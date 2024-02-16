-- be compatible to whowards TerrainCrossing Mod (the version slighlty changed by serp)
-- PROM_UNLOCK_LVL_5 does not exist, but is still sometimes as Or2 added, to make EUI 1.29 categorize it differntly, so the level promotion is properly shown in the flags

-- first: just try to add the unlocker promotion as dependence, which will only work, if the new promotions are already added
UPDATE UnitPromotions
SET PromotionPrereqOr1 = "PROM_UNLOCK_LVL_2", PromotionPrereqOr2 = "PROM_UNLOCK_LVL_3", PromotionPrereqOr3 = "PROM_UNLOCK_LVL_4", PromotionPrereqOr4 = NULL, PromotionPrereqOr5 = NULL, PromotionPrereqOr6 = NULL, PromotionPrereqOr7 = NULL, PromotionPrereqOr8 = NULL, PromotionPrereqOr9 = NULL
WHERE Type = 'PROMOTION_ICEBREAKER';  

UPDATE UnitPromotions
SET PromotionPrereqOr1 = "PROM_UNLOCK_LVL_2", PromotionPrereqOr2 = "PROM_UNLOCK_LVL_3", PromotionPrereqOr3 = "PROM_UNLOCK_LVL_4", PromotionPrereqOr4 = NULL, PromotionPrereqOr5 = NULL, PromotionPrereqOr6 = NULL, PromotionPrereqOr7 = NULL, PromotionPrereqOr8 = NULL, PromotionPrereqOr9 = NULL
WHERE Type = 'PROMOTION_CAN_CROSS_MOUNTAINS_SCOUT';  

UPDATE UnitPromotions
SET PromotionPrereqOr1 = "PROM_UNLOCK_LVL_4", PromotionPrereqOr2 = "PROM_UNLOCK_LVL_5", PromotionPrereqOr3 = NULL, PromotionPrereqOr4 = NULL, PromotionPrereqOr5 = NULL, PromotionPrereqOr6 = NULL, PromotionPrereqOr7 = NULL, PromotionPrereqOr8 = NULL, PromotionPrereqOr9 = NULL
WHERE Type = 'PROMOTION_CAN_CROSS_MOUNTAINS';  

-- second: create triggers. If this mod is loaded before the terraincrossing mod, the triggers will add the unlocker promotions right after the new promotions were added
CREATE TRIGGER TerrainUnlocker1
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_ICEBREAKER'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PromotionPrereqOr1 = "PROM_UNLOCK_LVL_2", PromotionPrereqOr2 = "PROM_UNLOCK_LVL_3", PromotionPrereqOr3 = "PROM_UNLOCK_LVL_4", PromotionPrereqOr4 = NULL, PromotionPrereqOr5 = NULL, PromotionPrereqOr6 = NULL, PromotionPrereqOr7 = NULL, PromotionPrereqOr8 = NULL, PromotionPrereqOr9 = NULL
    WHERE Type = 'PROMOTION_ICEBREAKER';  
END;

CREATE TRIGGER TerrainUnlocker2
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_CAN_CROSS_MOUNTAINS_SCOUT'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PromotionPrereqOr1 = "PROM_UNLOCK_LVL_2", PromotionPrereqOr2 = "PROM_UNLOCK_LVL_3", PromotionPrereqOr3 = "PROM_UNLOCK_LVL_4", PromotionPrereqOr4 = NULL, PromotionPrereqOr5 = NULL, PromotionPrereqOr6 = NULL, PromotionPrereqOr7 = NULL, PromotionPrereqOr8 = NULL, PromotionPrereqOr9 = NULL
    WHERE Type = 'PROMOTION_CAN_CROSS_MOUNTAINS_SCOUT';  
END;

CREATE TRIGGER TerrainUnlocker3
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_CAN_CROSS_MOUNTAINS'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PromotionPrereqOr1 = "PROM_UNLOCK_LVL_4", PromotionPrereqOr2 = "PROM_UNLOCK_LVL_5", PromotionPrereqOr3 = NULL, PromotionPrereqOr4 = NULL, PromotionPrereqOr5 = NULL, PromotionPrereqOr6 = NULL, PromotionPrereqOr7 = NULL, PromotionPrereqOr8 = NULL, PromotionPrereqOr9 = NULL
    WHERE Type = 'PROMOTION_CAN_CROSS_MOUNTAINS';  
END;