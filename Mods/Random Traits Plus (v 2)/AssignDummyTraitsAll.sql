-- only the ones that get the PrereqPolicy will have it enabled. 
-- Update all current leaders to have the new trait
INSERT INTO Leader_Traits(LeaderType, TraitType)
  SELECT Type, 'TRAIT_MOD_CHOOSE_ANY_BELIEF_X' FROM Leaders;
-- Update any additional leaders to have the new trait  
CREATE TRIGGER ModChooseAnyBeliefTraitX
AFTER INSERT ON Leaders
BEGIN
  INSERT INTO Leader_Traits(LeaderType, TraitType)
    VALUES(NEW.Type, 'TRAIT_MOD_CHOOSE_ANY_BELIEF_X');
END;

INSERT INTO Leader_Traits(LeaderType, TraitType)
  SELECT Type, 'TRAIT_MOD_UNIQUE_LUXURY_X' FROM Leaders;
-- Update any additional leaders to have the new trait  
CREATE TRIGGER ModTallTraitX
AFTER INSERT ON Leaders
BEGIN
  INSERT INTO Leader_Traits(LeaderType, TraitType)
    VALUES(NEW.Type, 'TRAIT_MOD_UNIQUE_LUXURY_X');
END;

INSERT INTO Leader_Traits(LeaderType, TraitType)
  SELECT Type, 'TRAIT_MOD_WIDE_X' FROM Leaders;
-- Update any additional leaders to have the new trait  
CREATE TRIGGER ModWideTraitX
AFTER INSERT ON Leaders
BEGIN
  INSERT INTO Leader_Traits(LeaderType, TraitType)
    VALUES(NEW.Type, 'TRAIT_MOD_WIDE_X');
END;