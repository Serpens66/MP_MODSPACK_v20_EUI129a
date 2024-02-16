-- Update all current leaders to have the new trait
INSERT INTO Leader_Traits(LeaderType, TraitType)
  SELECT Type, 'TRAIT_ANNEX_CITY_STATE_VIA_POLICY' FROM Leaders;

-- Update any additional leaders to have the new trait  
CREATE TRIGGER CsAnnexByPolicy
AFTER INSERT ON Leaders
BEGIN
  INSERT INTO Leader_Traits(LeaderType, TraitType)
    VALUES(NEW.Type, 'TRAIT_ANNEX_CITY_STATE_VIA_POLICY');
END;
