local addonName, ns = ...
ns.SizeDetector = {}
local SizeDetector = ns.SizeDetector

local UnitExists = UnitExists
local UnitIsPlayer = UnitIsPlayer
local UnitCanAttack = UnitCanAttack
local UnitGUID = UnitGUID
local UnitClassification = UnitClassification
local UnitLevel = UnitLevel
local UnitCreatureType = UnitCreatureType

local SIZE_CATEGORY = {
    TINY     = 0.1,
    SMALL    = 0.3,
    MEDIUM   = 0.5,
    LARGE    = 0.7,
    HUGE     = 0.9,
    COLOSSAL = 1.0,
}

local activeThreatList = {}
local recalculateCallback = nil

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
    }

    LogDebug(string.format("Threat added: %s (size: %.1f)", guid, heuristicSize))
end

function SizeDetector:OnUnitDied(guid)
    if not guid then return false end
    if not activeThreatList[guid] then return false end

    LogDebug(string.format("Threat died: %s (size was: %.1f)", guid, activeThreatList[guid].size))
    activeThreatList[guid] = nil
    return true
end

function SizeDetector:ClearThreats()
    wipe(activeThreatList)
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
