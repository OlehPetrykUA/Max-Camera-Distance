local Locals = LibStub("AceLocale-3.0"):NewLocale("Max_Camera_Distance", "ukUA")
if not Locals then return end

Locals["SETTINGS_SET_TO_MAX"] = "Параметри камери встановлені на максимальні значення."
Locals["SETTINGS_SET_TO_AVERAGE"] = "Параметри камери встановлені на середні значення."
Locals["SETTINGS_SET_TO_MIN"] = "Параметри камери встановлені на мінімальні значення."
Locals["SETTINGS_SET_TO_DEFAULT"] = "Параметри камери встановлені на значення за замовчуванням."
Locals["SETTINGS_CHANGED"] = "Параметри камери були змінені."

-- *** General Settings ***
Locals["GENERAL_SETTINGS"] = "Загальні налаштування"

Locals["MAX_ZOOM_FACTOR"] = "Максимальна відстань камери"
Locals["MAX_ZOOM_FACTOR_DESC"] = "Встановлює максимально дозволену відстань камери (у ярдах)."

Locals["MOVE_VIEW_DISTANCE"] = "Швидкість зуму"
Locals["MOVE_VIEW_DISTANCE_DESC"] = "Налаштовує швидкість наближення та віддалення камери."

Locals["ZOOM_TRANSITION"] = "Плавність переходу"
Locals["ZOOM_TRANSITION_DESC"] = "Час у секундах для плавного переходу між відстанями камери (Бій/Маунт/Нормальна). Більші значення — повільніший, плавніший рух."

Locals["YAW_MOVE_SPEED"] = "Горизонтальна швидкість обертання"
Locals["YAW_MOVE_SPEED_DESC"] = "Налаштовує швидкість горизонтального руху камери."

Locals["PITCH_MOVE_SPEED"] = "Вертикальна швидкість обертання"
Locals["PITCH_MOVE_SPEED_DESC"] = "Налаштовує швидкість вертикального руху камери."

-- *** Smart Zoom Settings ***
Locals["COMBAT_SETTINGS"] = "Система розумного зуму"
Locals["COMBAT_SETTINGS_WARNING"] = "|cff0070deЦя система автоматично змінює відстань камери залежно від вашого поточного стану.\nПріоритет: Бій > Маунт > Нормальний.|r"

Locals["AUTO_ZOOM_COMBAT"] = "Увімкнути розумний бойовий зум"
Locals["AUTO_ZOOM_COMBAT_DESC"] = "Камера автоматично віддаляється при вході в бій. (Найвищий пріоритет)"

Locals["FORCE_COMBAT_INSTANCE"] = "Вважати інстанси за бій"
Locals["FORCE_COMBAT_INSTANCE_DESC"] = "Перебуваючи в данжі, рейді, арені або полі бою, завжди використовувати бойову відстань — навіть поза боєм."

Locals["MAX_COMBAT_ZOOM_FACTOR"] = "Відстань у бою"
Locals["MAX_COMBAT_ZOOM_FACTOR_DESC"] = "Цільова відстань камери, коли ви В бою."

Locals["MIN_COMBAT_ZOOM_FACTOR"] = "Нормальна відстань"
Locals["MIN_COMBAT_ZOOM_FACTOR_DESC"] = "Цільова відстань камери поза боєм та без маунта (мирний режим)."

-- Mount
Locals["MOUNT_SETTINGS_HEADER"] = "Налаштування маунта та подорожі"
Locals["AUTO_MOUNT_ZOOM"] = "Автозум при верховій їзді"
Locals["AUTO_MOUNT_ZOOM_DESC"] = "Автоматично віддаляє камеру при їзді верхи або у формі подорожі (Друїд/Шаман/Пробуджений). Активно тільки поза боєм."

Locals["MOUNT_ZOOM_FACTOR"] = "Відстань на маунті"
Locals["MOUNT_ZOOM_FACTOR_DESC"] = "Цільова відстань камери під час верхової їзди/подорожі."

-- Delay
Locals["DISMOUNT_DELAY"] = "Затримка переходу"
Locals["DISMOUNT_DELAY_DESC"] = "Час очікування (у секундах) після виходу з бою або зіскакування перед поверненням камери."

-- *** Advanced Settings ***
Locals["ADVANCED_SETTINGS"] = "Розширені налаштування"

Locals["REDUCE_UNEXPECTED_MOVEMENT"] = "Зменшити несподівані рухи"
Locals["REDUCE_UNEXPECTED_MOVEMENT_DESC"] = "Зменшує стрибки камери при зіткненні з місцевістю або об'єктами."

Locals["RESAMPLE_ALWAYS_SHARPEN"] = "Завжди підвищувати різкість (FSR)"
Locals["RESAMPLE_ALWAYS_SHARPEN_DESC"] = "Примусово застосовує фільтр різкості, навіть без масштабування."

Locals["INDIRECT_VISIBILITY"] = "Зіткнення з місцевістю"
Locals["INDIRECT_VISIBILITY_DESC"] = "Контролює взаємодію камери з оточенням (зменшує проникнення крізь об'єкти)."

Locals["SOFT_TARGET_INTERACT"] = "Іконки взаємодії (Soft Target)"
Locals["SOFT_TARGET_INTERACT_DESC"] = "Відображає іконки взаємодії над ігровими об'єктами (поштові скриньки, трави, портали, NPC)."

-- *** Tools Section ***
Locals["TOOLS_HEADER"] = "Інструменти"

Locals["UNTRACK_QUESTS_BUTTON"] = "Зняти відстеження всіх завдань"
Locals["UNTRACK_QUESTS_DESC"] = "Миттєво видаляє всі завдання з трекера для зменшення безладу та покращення FPS."
Locals["QUEST_TRACKER_EMPTY"] = "Трекер завдань вже порожній."
Locals["QUEST_TRACKER_CLEARED"] = "Зупинено відстеження %d завдань."

-- *** Messages & UI ***
Locals["SETTINGS_RESET"] = "Профіль скинуто до значень за замовчуванням."
Locals["DB_NOT_READY"] = "База даних ще не ініціалізована."
Locals["CMD_USAGE"] = "Використання: /mcd config | autozoom | automount | restore"
Locals["SETTINGS_RESTORED"] = "Відновлено: %s (%.0f ярдів)"
Locals["ZOOM_SET_MESSAGE"] = "Зум встановлено на %s (%.1f ярдів)"

Locals["WARNING_TEXT"] = "Цей аддон розширює ліміт відстані камери для кращої видимості у рейдах, підземеллях та PvP."

Locals["RELOAD_BUTTON"] = "Перезавантажити UI"
Locals["RELOAD_BUTTON_DESC"] = "Перезавантажує інтерфейс для застосування критичних змін."

Locals["RESET_BUTTON"] = "Скинути налаштування"
Locals["RESET_BUTTON_DESC"] = "Скидає всі налаштування цього профілю до значень за замовчуванням."

-- *** Debug Settings ***
Locals["DEBUG_SETTINGS"] = "Налаштування відлагодження"
Locals["ENABLE_DEBUG_LOGGING"] = "Увімкнути журналювання"
Locals["ENABLE_DEBUG_LOGGING_DESC"] = "Виводить інформацію відлагодження у вікно чату."

Locals["DEBUG_LEVEL"] = "Рівень відлагодження"
Locals["DEBUG_LEVEL_DESC"] = "Оберіть деталізацію журналу."
Locals["DEBUG_LEVEL_ERROR"] = "Помилка"
Locals["DEBUG_LEVEL_WARNING"] = "Попередження"
Locals["DEBUG_LEVEL_INFO"] = "Інфо"
Locals["DEBUG_LEVEL_DEBUG"] = "Детально"

-- *** Toggle States ***
Locals["ENABLED"] = "|cff00ff00Увімкнено|r"
Locals["DISABLED"] = "|cffff0000Вимкнено|r"
