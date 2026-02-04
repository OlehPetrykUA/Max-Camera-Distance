local addonName = "Max_Camera_Distance"
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "frFR")

if not L then return end

-- *** General Settings ***
L["GENERAL_SETTINGS"] = "Paramètres généraux"

L["MAX_ZOOM_FACTOR"] = "Distance max de la caméra"
L["MAX_ZOOM_FACTOR_DESC"] = "Définit la distance maximale autorisée pour la caméra (en mètres/yards)."

L["MOVE_VIEW_DISTANCE"] = "Vitesse du zoom"
L["MOVE_VIEW_DISTANCE_DESC"] = "Règle la vitesse à laquelle la caméra effectue un zoom avant ou arrière."

L["YAW_MOVE_SPEED"] = "Vitesse de rotation horizontale"
L["YAW_MOVE_SPEED_DESC"] = "Règle la vitesse du mouvement horizontal de la caméra (lacet)."

L["PITCH_MOVE_SPEED"] = "Vitesse de rotation verticale"
L["PITCH_MOVE_SPEED_DESC"] = "Règle la vitesse du mouvement vertical de la caméra (tangage)."

-- *** Combat Settings ***
L["COMBAT_SETTINGS"] = "Zoom de combat intelligent"
L["COMBAT_SETTINGS_WARNING"] = "|cff0070deCette section permet à la caméra de changer automatiquement de distance selon que vous êtes en combat ou non.|r"

L["AUTO_ZOOM_COMBAT"] = "Activer le zoom de combat intelligent"
L["AUTO_ZOOM_COMBAT_DESC"] = "Si activé, la caméra s'éloignera automatiquement en entrant en combat et se rapprochera en sortant du combat."

L["FORCE_COMBAT_INSTANCE"] = "Traiter les instances comme du combat"
L["FORCE_COMBAT_INSTANCE_DESC"] = "Dans un donjon, raid, arène ou champ de bataille, utiliser toujours la distance de combat même hors combat réel."

L["SCALE_ZOOM_BY_SIZE"] = "Adapter le zoom à la taille de l'ennemi"
L["SCALE_ZOOM_BY_SIZE_DESC"] = "Éloigne dynamiquement la caméra pour les ennemis plus grands (boss, géants). La caméra ne zoomera jamais plus près que votre Distance de combat. Quand un grand ennemi meurt, la caméra s'adapte au prochain ennemi le plus grand."

L["SIZE_ZOOM_MAX_YARDS"] = "Distance max. par taille"
L["SIZE_ZOOM_MAX_YARDS_DESC"] = "Distance maximale de la caméra pour les plus grands ennemis. La Distance de combat sert de plancher minimum."

L["MAX_COMBAT_ZOOM_FACTOR"] = "Distance en combat"
L["MAX_COMBAT_ZOOM_FACTOR_DESC"] = "La distance cible de la caméra lorsque vous êtes EN combat."

L["MIN_COMBAT_ZOOM_FACTOR"] = "Distance hors combat"
L["MIN_COMBAT_ZOOM_FACTOR_DESC"] = "La distance cible de la caméra lorsque vous êtes HORS combat (mode repos)."

L["ZOOM_TRANSITION"] = "Fluidité de transition"
L["ZOOM_TRANSITION_DESC"] = "Temps en secondes pour la transition fluide entre les distances de caméra (Combat/Monture/Normal). Des valeurs plus élevées signifient un mouvement plus lent et plus fluide."

-- Mount
L["MOUNT_SETTINGS_HEADER"] = "Monture & Voyage"
L["AUTO_MOUNT_ZOOM"] = "Activer le zoom automatique sur monture"
L["AUTO_MOUNT_ZOOM_DESC"] = "Zoom automatique lorsque vous êtes monté ou en forme de voyage (Druide/Chaman/Évocateur). Actif uniquement hors combat."

L["MOUNT_ZOOM_FACTOR"] = "Distance sur monture"
L["MOUNT_ZOOM_FACTOR_DESC"] = "La distance cible de la caméra lorsque vous êtes monté/en voyage."

-- Delay
L["DISMOUNT_DELAY"] = "Délai de transition"
L["DISMOUNT_DELAY_DESC"] = "Temps d'attente (en secondes) après la fin du combat ou le démontage avant de revenir à la distance normale."

-- *** Advanced Settings ***
L["ADVANCED_SETTINGS"] = "Paramètres avancés"

L["REDUCE_UNEXPECTED_MOVEMENT"] = "Réduire les mouvements inattendus"
L["REDUCE_UNEXPECTED_MOVEMENT_DESC"] = "Réduit les sauts de caméra lorsque celle-ci entre en collision avec le terrain ou des objets."

L["RESAMPLE_ALWAYS_SHARPEN"] = "Toujours affiner (Sharpen)"
L["RESAMPLE_ALWAYS_SHARPEN_DESC"] = "Force l'application d'un filtre de netteté, même si AMD FSR Upscale est désactivé."

L["INDIRECT_VISIBILITY"] = "Collision avec le terrain"
L["INDIRECT_VISIBILITY_DESC"] = "Contrôle la façon dont la caméra interagit avec l'environnement (réduit le clipping à travers les objets)."

L["SOFT_TARGET_INTERACT"] = "Icônes d'interaction (Soft Target)"
L["SOFT_TARGET_INTERACT_DESC"] = "Affiche des icônes d'interaction au-dessus des objets de jeu (boîtes aux lettres, herbes, portails, PNJ) pour un ciblage plus facile."

-- *** Messages & UI ***
L["SETTINGS_CHANGED"] = "Les paramètres de la caméra ont été modifiés."
L["SETTINGS_SET_TO_MAX"] = "Paramètres de la caméra réglés sur les valeurs maximales."
L["SETTINGS_SET_TO_AVERAGE"] = "Paramètres de la caméra réglés sur les valeurs moyennes."
L["SETTINGS_SET_TO_MIN"] = "Paramètres de la caméra réglés sur les valeurs minimales."
L["SETTINGS_SET_TO_DEFAULT"] = "Paramètres de la caméra réinitialisés aux valeurs par défaut."
L["SETTINGS_RESET"] = "Le profil a été réinitialisé aux valeurs par défaut."

L["WARNING_TEXT"] = "Cet addon étend la limite de distance de la caméra pour améliorer la visibilité lors des raids, donjons et PvP."

L["RELOAD_BUTTON"] = "Recharger l'IU"
L["RELOAD_BUTTON_DESC"] = "Recharge l'interface utilisateur pour appliquer les changements critiques."

L["RESET_BUTTON"] = "Réinitialiser"
L["RESET_BUTTON_DESC"] = "Réinitialise tous les paramètres de ce profil à leurs valeurs par défaut."

-- *** Debug Settings ***
L["DEBUG_SETTINGS"] = "Paramètres de débogage"
L["ENABLE_DEBUG_LOGGING"] = "Activer la journalisation"
L["ENABLE_DEBUG_LOGGING_DESC"] = "Affiche les informations de débogage dans la fenêtre de discussion."

L["DEBUG_LEVEL"] = "Niveau de débogage"
L["DEBUG_LEVEL_DESC"] = "Sélectionnez la verbosité des journaux."
L["DEBUG_LEVEL_ERROR"] = "Erreur"
L["DEBUG_LEVEL_WARNING"] = "Avertissement"
L["DEBUG_LEVEL_INFO"] = "Info"
L["DEBUG_LEVEL_DEBUG"] = "Verbeux"

-- *** Tools Section ***
L["TOOLS_HEADER"] = "Outils & Utilitaires"

L["UNTRACK_QUESTS_BUTTON"] = "Arrêter le suivi de toutes les quêtes"
L["UNTRACK_QUESTS_DESC"] = "Supprime instantanément toutes les quêtes du suivi d'objectifs (côté droit de l'écran) pour réduire l'encombrement et améliorer les FPS."
L["QUEST_TRACKER_EMPTY"] = "Le suivi de quêtes est déjà vide."
L["QUEST_TRACKER_CLEARED"] = "Arrêt du suivi de %d quêtes."

-- *** Messages ***
L["DB_NOT_READY"] = "Base de données pas encore initialisée."
L["CMD_USAGE"] = "Utilisation : /mcd config | autozoom | automount | restore"
L["SETTINGS_RESTORED"] = "Restauré : %s (%.0f yards)"
L["ZOOM_SET_MESSAGE"] = "Zoom réglé sur %s (%.1f yards)"

-- *** Toggle States ***
L["ENABLED"] = "|cff00ff00Activé|r"
L["DISABLED"] = "|cffff0000Désactivé|r"