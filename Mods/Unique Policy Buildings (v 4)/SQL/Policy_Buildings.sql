
-- add needing of new strategic ressource, if the mod adding this is active
-- RESOURCE_IRON

INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
  VALUES("BUILDING_TCS_PUBLIC_BATHS", 'RESOURCE_IRON', 1);
  
INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
  VALUES("BUILDING_TCS_TOWN_COUNCIL", 'RESOURCE_IRON', 1);

INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
  VALUES("BUILDING_TCS_STRONGHOLD", 'RESOURCE_IRON', 1);

INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
  VALUES("BUILDING_TCS_PAROCHIAL_SCHOOL", 'RESOURCE_IRON', 1);

INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
  VALUES("BUILDING_TCS_CHANCERY", 'RESOURCE_IRON', 1);

INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
  VALUES("BUILDING_TCS_MEMORIAL", 'RESOURCE_IRON', 1);

INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
  VALUES("BUILDING_TCS_DEPOT", 'RESOURCE_IRON', 1);

INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
  VALUES("BUILDING_TCS_BOTANICAL_GARDENS", 'RESOURCE_IRON', 1);

INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
  VALUES("BUILDING_TCS_PATENT_OFFICE", 'RESOURCE_IRON', 1);



-- now some triggers, to make it not depend on loading order

CREATE TRIGGER AddOpiumNeed1
AFTER INSERT ON Resources
WHEN 'RESOURCE_IRON'=NEW.Type
BEGIN
  INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
    VALUES("BUILDING_TCS_PUBLIC_BATHS", NEW.Type, 1);
END;

CREATE TRIGGER AddOpiumNeed2
AFTER INSERT ON Resources
WHEN 'RESOURCE_IRON'=NEW.Type
BEGIN
  INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
    VALUES("BUILDING_TCS_TOWN_COUNCIL", NEW.Type, 1);
END;

CREATE TRIGGER AddOpiumNeed3
AFTER INSERT ON Resources
WHEN 'RESOURCE_IRON'=NEW.Type
BEGIN
  INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
    VALUES("BUILDING_TCS_STRONGHOLD", NEW.Type, 1);
END;

CREATE TRIGGER AddOpiumNeed4
AFTER INSERT ON Resources
WHEN 'RESOURCE_IRON'=NEW.Type
BEGIN
  INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
    VALUES("BUILDING_TCS_PAROCHIAL_SCHOOL", NEW.Type, 1);
END;

CREATE TRIGGER AddOpiumNeed5
AFTER INSERT ON Resources
WHEN 'RESOURCE_IRON'=NEW.Type
BEGIN
  INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
    VALUES("BUILDING_TCS_CHANCERY", NEW.Type, 1);
END;

CREATE TRIGGER AddOpiumNeed6
AFTER INSERT ON Resources
WHEN 'RESOURCE_IRON'=NEW.Type
BEGIN
  INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
    VALUES("BUILDING_TCS_MEMORIAL", NEW.Type, 1);
END;

CREATE TRIGGER AddOpiumNeed7
AFTER INSERT ON Resources
WHEN 'RESOURCE_IRON'=NEW.Type
BEGIN
  INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
    VALUES("BUILDING_TCS_DEPOT", NEW.Type, 1);
END;

CREATE TRIGGER AddOpiumNeed8
AFTER INSERT ON Resources
WHEN 'RESOURCE_IRON'=NEW.Type
BEGIN
  INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
    VALUES("BUILDING_TCS_BOTANICAL_GARDENS", NEW.Type, 1);
END;

CREATE TRIGGER AddOpiumNeed9
AFTER INSERT ON Resources
WHEN 'RESOURCE_IRON'=NEW.Type
BEGIN
  INSERT INTO Building_ResourceQuantityRequirements(BuildingType, ResourceType, Cost)
    VALUES("BUILDING_TCS_PATENT_OFFICE", NEW.Type, 1);
END;