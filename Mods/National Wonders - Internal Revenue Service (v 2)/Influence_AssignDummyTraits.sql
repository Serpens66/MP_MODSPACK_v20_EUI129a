-- only the ones that get the PrereqPolicy will have it enabled. 
-- Update all current leaders to have the new trait
INSERT INTO Leader_Traits(LeaderType, TraitType)
  SELECT Type, 'TRAIT_LESS_INFLUENCE_X' FROM Leaders;
-- Update any additional leaders to have the new trait  
CREATE TRIGGER LessInfluenceX
AFTER INSERT ON Leaders
BEGIN
  INSERT INTO Leader_Traits(LeaderType, TraitType)
    VALUES(NEW.Type, 'TRAIT_LESS_INFLUENCE_X');
END;
