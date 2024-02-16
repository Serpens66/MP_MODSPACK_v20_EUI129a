CREATE TRIGGER Convstart
AFTER INSERT ON Civilization_FreeUnits
BEGIN
  UPDATE Civilization_FreeUnits SET UnitClassType = 'UNITCLASS_SUPERSETTLER'
    WHERE UnitClassType = 'UNITCLASS_SETTLER';
END;
