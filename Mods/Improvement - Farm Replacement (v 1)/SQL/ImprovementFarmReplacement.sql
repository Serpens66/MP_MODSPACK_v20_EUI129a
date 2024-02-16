-- Create an Arable improvement type
INSERT INTO ArtDefine_LandmarkTypes(Type, LandmarkType, FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_ARABLE', 'Improvement', 'Arable';

-- The following block makes all Farms look the same (using the building graphics from the Wheat farm), but changes them between the Renaissance and Industrial eras
--INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
--SELECT 'Ancient',    'UnderConstruction', 1.5, 'ART_DEF_IMPROVEMENT_ARABLE', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'HB_Medieval_Farm.fxsxml', 1 UNION ALL
--SELECT 'Ancient',    'Constructed',       1.5, 'ART_DEF_IMPROVEMENT_ARABLE', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'Medieval_Farm.fxsxml',    1 UNION ALL
--SELECT 'Ancient',    'Pillaged',          1.5, 'ART_DEF_IMPROVEMENT_ARABLE', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'PL_Medieval_Farm.fxsxml', 1 UNION ALL
--SELECT 'Industrial', 'UnderConstruction', 1.5, 'ART_DEF_IMPROVEMENT_ARABLE', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'HB_Modern_Farm.fxsxml',   1 UNION ALL
--SELECT 'Industrial', 'Constructed',       1.5, 'ART_DEF_IMPROVEMENT_ARABLE', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'Modern_Farm.fxsxml',      1 UNION ALL
--SELECT 'Industrial', 'Pillaged',          1.5, 'ART_DEF_IMPROVEMENT_ARABLE', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'PL_Modern_Farm.fxsxml',   1;

-- The following two blocks use CCTP resources to create four Farms, one (barley) for Wheat resources and three that display randomly
INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction', 0.96, 'ART_DEF_IMPROVEMENT_ARABLE', 'SNAPSHOT', 'ART_DEF_RESOURCE_WHEAT', 'ART/Barley/HB_Plantation_MID_Barley.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed',       0.96, 'ART_DEF_IMPROVEMENT_ARABLE', 'SNAPSHOT', 'ART_DEF_RESOURCE_WHEAT', 'ART/Barley/Plantation_MID_Barley.fxsxml', 1 UNION ALL
SELECT 'Any', 'Pillaged',          0.96, 'ART_DEF_IMPROVEMENT_ARABLE', 'SNAPSHOT', 'ART_DEF_RESOURCE_WHEAT', 'ART/Barley/PL_Plantation_MID_Barley.fxsxml', 1;

-- Use the same (generic) Under Construction and Pillaged graphics, otherwise the Constructed farm is different from what was being built!
INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction', 0.96, 'ART_DEF_IMPROVEMENT_ARABLE', 'RANDOM', 'ART_DEF_RESOURCE_ALL', 'ART/Tobacco/HB_Plantation_MID_Tobacco.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed',       0.96, 'ART_DEF_IMPROVEMENT_ARABLE', 'RANDOM', 'ART_DEF_RESOURCE_ALL', 'ART/Corn/Plantation_MID_Corn.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed',       0.96, 'ART_DEF_IMPROVEMENT_ARABLE', 'RANDOM', 'ART_DEF_RESOURCE_ALL', 'ART/Mango/Plantation_MID_Mango.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed',       0.96, 'ART_DEF_IMPROVEMENT_ARABLE', 'RANDOM', 'ART_DEF_RESOURCE_ALL', 'ART/Tobacco/Plantation_MID_Tobacco.fxsxml', 1 UNION ALL
SELECT 'Any', 'Pillaged',          0.96, 'ART_DEF_IMPROVEMENT_ARABLE', 'RANDOM', 'ART_DEF_RESOURCE_ALL', 'ART/Mango/PL_Plantation_MID_Mango.fxsxml', 1;

INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
SELECT 'ART_DEF_IMPROVEMENT_ARABLE', 'Improvement', 'SV_Farm.dds';

-- Now set the Farm to use the new Arable improvement graphics
UPDATE Improvements SET ArtDefineTag='ART_DEF_IMPROVEMENT_ARABLE' WHERE ArtDefineTag='ART_DEF_IMPROVEMENT_FARM';

-- Finally (paranoia) delete the Farm improvement graphics
DELETE FROM ArtDefine_LandmarkTypes WHERE Type='ART_DEF_IMPROVEMENT_FARM';
DELETE FROM ArtDefine_Landmarks WHERE ImprovementType='ART_DEF_IMPROVEMENT_FARM';
DELETE FROM ArtDefine_StrategicView WHERE StrategicViewType='ART_DEF_IMPROVEMENT_FARM';
