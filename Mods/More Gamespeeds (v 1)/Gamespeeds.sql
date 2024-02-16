-- some triggers for stockpile mod, so the mod load order does not matter

CREATE TRIGGER ADJUSTSTOCKPILE1
AFTER INSERT ON CustomModOptions  
WHEN 'PROCESS_STOCKPILE_PER_ERA'=NEW.Name
BEGIN
  UPDATE CustomModOptions
    SET Value = 60
    WHERE Name = 'PROCESS_STOCKPILE_PER_ERA';  
END;

CREATE TRIGGER ADJUSTSTOCKPILE2
AFTER INSERT ON Process_ProductionYields  
WHEN 'PROCESS_STOCKPILE'=NEW.ProcessType
BEGIN
  UPDATE Process_ProductionYields
    SET Yield = 95
    WHERE ProcessType = 'PROCESS_STOCKPILE';  
END;