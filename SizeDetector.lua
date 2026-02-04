local addonName, ns = ...
ns.SizeDetector = {}
local SizeDetector = ns.SizeDetector

local C_Timer = C_Timer
local UnitExists = UnitExists
local UnitIsPlayer = UnitIsPlayer
local UnitCanAttack = UnitCanAttack
local UnitGUID = UnitGUID
local UnitClassification = UnitClassification
local UnitLevel = UnitLevel
local UnitCreatureType = UnitCreatureType
local UnitAffectingCombat = UnitAffectingCombat
local CreateFrame = CreateFrame

local IS_RETAIL = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)

local SIZE_CATEGORY = {
    TINY     = 0.1,
    SMALL    = 0.3,
    MEDIUM   = 0.5,
    LARGE    = 0.7,
    HUGE     = 0.9,
    COLOSSAL = 1.0,
}

local activeThreatList = {}
local sizeCache = {}
local measureQueue = {}
local pendingMeasurement = nil
local recalculateCallback = nil

local measureScene = nil
local measureActor = nil

local function LogDebug(msg)
    if ns.Functions and ns.Functions.logMessage then
        ns.Functions:logMessage("debug", msg)
    end
end

-- ================= HEURISTIC SIZING =================

local function GetHeuristicSize(unit)
    if not UnitExists(unit) then return nil end
    if UnitIsPlayer(unit) then return nil end
    if not UnitCanAttack("player", unit) then return nil end

    local classification = UnitClassification(unit)
    local level = UnitLevel(unit)
    local creatureType = UnitCreatureType(unit)

    if level == -1 then
        return SIZE_CATEGORY.HUGE
    end

    if classification == "worldboss" then
        return SIZE_CATEGORY.HUGE
    end
    if classification == "rareelite" then
        return SIZE_CATEGORY.LARGE
    end
    if classification == "elite" then
        return SIZE_CATEGORY.MEDIUM
    end
    if classification == "minus" then
        return SIZE_CATEGORY.SMALL
    end
    if classification == "trivial" then
        return SIZE_CATEGORY.TINY
    end

    if creatureType == "Giant" then
        return SIZE_CATEGORY.LARGE
    end
    if creatureType == "Critter" or creatureType == "Non-combat Pet" then
        return SIZE_CATEGORY.TINY
    end

    return SIZE_CATEGORY.SMALL
end

-- ================= MODELSCENE BOUNDING BOX =================
-- ModelScene operations are NEVER called during combat to avoid taint.
-- Measurements are queued during combat and processed after PLAYER_REGEN_ENABLED.

local function InitMeasureScene()
    if measureScene then return end
    measureScene = CreateFrame("ModelScene", nil, nil)
    measureScene:SetSize(1, 1)
    measureScene:Hide()
    measureActor = measureScene:CreateActor()
end

InitMeasureScene()

local function HeightToCategory(height)
    if height <= 2.0 then
        return SIZE_CATEGORY.SMALL
    end
    if height <= 4.0 then
        return SIZE_CATEGORY.MEDIUM
    end
    if height <= 7.0 then
        return SIZE_CATEGORY.LARGE
    end
    if height <= 12.0 then
        return SIZE_CATEGORY.HUGE
    end
    return SIZE_CATEGORY.COLOSSAL
end

local function ProcessSingleMeasurement(guid, unit)
    if not IS_RETAIL then return end
    if not measureScene or not measureActor then return end
    if not UnitExists(unit) then return end

    measureActor:ClearModel()
    measureActor:SetModelByUnit(unit)

    pendingMeasurement = { guid = guid }

    local attempts = 0
    local ticker
    ticker = C_Timer.NewTicker(0.05, function()
        attempts = attempts + 1

        if not pendingMeasurement or pendingMeasurement.guid ~= guid then
            ticker:Cancel()
            return
        end

        if measureActor:IsLoaded() then
            ticker:Cancel()

            local bottom, top = measureActor:GetActiveBoundingBox()
            if bottom and top then
                local bz = bottom.z or bottom[3] or 0
                local tz = top.z or top[3] or 0
                local height = tz - bz

                local normalizedSize = HeightToCategory(height)

                local modelFileID = measureActor:GetModelFileID()
                if modelFileID then
                    sizeCache[modelFileID] = normalizedSize
                end

                if activeThreatList[guid] then
                    local oldSize = activeThreatList[guid].size
                    activeThreatList[guid].size = normalizedSize
                    activeThreatList[guid].modelFileID = modelFileID

                    if math.abs(normalizedSize - oldSize) > 0.05 and recalculateCallback then
                        recalculateCallback()
                    end
                end

                LogDebug(string.format(
                    "ModelScene measured: %s height=%.1f size=%.1f",
                    guid, height, normalizedSize
                ))
            end

            pendingMeasurement = nil
            return
        end

        if attempts >= 20 then
            ticker:Cancel()
            pendingMeasurement = nil
            LogDebug("ModelScene measurement timed out for: " .. guid)
        end
    end)
end

-- ================= THREAT LIST =================

local function GetLargestAliveSize()
    local maxSize = 0
    for _, entry in pairs(activeThreatList) do
        if entry.size > maxSize then
            maxSize = entry.size
        end
    end
    return maxSize
end

-- ================= PUBLIC API =================

function SizeDetector:SetRecalculateCallback(fn)
    recalculateCallback = fn
end

function SizeDetector:MeasureTarget(unit)
    local guid = UnitGUID(unit)
    if not guid then return end

    if activeThreatList[guid] then return end

    local heuristicSize = GetHeuristicSize(unit)
    if not heuristicSize then return end

    activeThreatList[guid] = {
        size = heuristicSize,
        modelFileID = nil,
    }

    LogDebug(string.format("Threat added: %s (heuristic: %.1f)", guid, heuristicSize))

    if UnitAffectingCombat("player") then
        measureQueue[guid] = unit
    else
        ProcessSingleMeasurement(guid, unit)
    end
end

function SizeDetector:ProcessMeasureQueue()
    if UnitAffectingCombat("player") then return end

    for guid, unit in pairs(measureQueue) do
        if activeThreatList[guid] and UnitExists(unit) then
            ProcessSingleMeasurement(guid, unit)
        end
    end
    wipe(measureQueue)
end

function SizeDetector:OnUnitDied(guid)
    if not guid then return false end
    if not activeThreatList[guid] then return false end

    LogDebug(string.format("Threat died: %s (size was: %.1f)", guid, activeThreatList[guid].size))
    activeThreatList[guid] = nil
    measureQueue[guid] = nil
    return true
end

function SizeDetector:ClearThreats()
    wipe(activeThreatList)
    wipe(measureQueue)
    pendingMeasurement = nil
    LogDebug("Threat list cleared")
end

function SizeDetector:HasThreats()
    return next(activeThreatList) ~= nil
end

function SizeDetector:GetLargestAliveYards(floor, ceiling)
    local largestSize = GetLargestAliveSize()
    if largestSize <= 0 then return nil end

    local yards = floor + (ceiling - floor) * largestSize

    local MAX_YARDS = ns.Database and ns.Database.DEFAULTS
        and ns.Database.DEFAULTS.MAX_POSSIBLE_DISTANCE or 39
    yards = math.max(floor, math.min(yards, MAX_YARDS))

    return yards
end
