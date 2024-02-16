UPDATE Features SET InBorderHappiness=1 WHERE Type='FEATURE_CRATER';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_CRATER';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_CRATER', 'YIELD_FOOD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_CRATER', 'YIELD_PRODUCTION', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_CRATER', 'YIELD_GOLD', 2);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_CRATER', 'YIELD_SCIENCE', 3);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_CRATER', 'YIELD_CULTURE', 3);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_CRATER', 'YIELD_FAITH', 0);

UPDATE Features SET InBorderHappiness=1 WHERE Type='FEATURE_FUJI';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_FUJI';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_FUJI', 'YIELD_FOOD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_FUJI', 'YIELD_PRODUCTION', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_FUJI', 'YIELD_GOLD', 2);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_FUJI', 'YIELD_SCIENCE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_FUJI', 'YIELD_CULTURE', 3);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_FUJI', 'YIELD_FAITH', 3);

UPDATE Features SET InBorderHappiness=1 WHERE Type='FEATURE_MESA';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_MESA';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MESA', 'YIELD_FOOD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MESA', 'YIELD_PRODUCTION', 2);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MESA', 'YIELD_GOLD', 3);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MESA', 'YIELD_SCIENCE', 3);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MESA', 'YIELD_CULTURE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MESA', 'YIELD_FAITH', 0);

UPDATE Features SET InBorderHappiness=1 WHERE Type='FEATURE_REEF';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_REEF';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_REEF', 'YIELD_FOOD', 2);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_REEF', 'YIELD_PRODUCTION', 1);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_REEF', 'YIELD_GOLD', 1);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_REEF', 'YIELD_SCIENCE', 2);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_REEF', 'YIELD_CULTURE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_REEF', 'YIELD_FAITH', 0);

UPDATE Features SET InBorderHappiness=1 WHERE Type='FEATURE_VOLCANO';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_VOLCANO';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_VOLCANO', 'YIELD_FOOD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_VOLCANO', 'YIELD_PRODUCTION', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_VOLCANO', 'YIELD_GOLD', 3);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_VOLCANO', 'YIELD_SCIENCE', 5);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_VOLCANO', 'YIELD_CULTURE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_VOLCANO', 'YIELD_FAITH', 0);

UPDATE Features SET InBorderHappiness=1 WHERE Type='FEATURE_GIBRALTAR';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_GIBRALTAR';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_GIBRALTAR', 'YIELD_FOOD', 2);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_GIBRALTAR', 'YIELD_PRODUCTION', 1);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_GIBRALTAR', 'YIELD_GOLD', 5);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_GIBRALTAR', 'YIELD_SCIENCE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_GIBRALTAR', 'YIELD_CULTURE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_GIBRALTAR', 'YIELD_FAITH', 0);

UPDATE Features SET InBorderHappiness=4 WHERE Type='FEATURE_GEYSER';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_GEYSER';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_GEYSER', 'YIELD_FOOD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_GEYSER', 'YIELD_PRODUCTION', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_GEYSER', 'YIELD_GOLD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_GEYSER', 'YIELD_SCIENCE', 5);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_GEYSER', 'YIELD_CULTURE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_GEYSER', 'YIELD_FAITH', 0);

UPDATE Features SET InBorderHappiness=9 WHERE Type='FEATURE_FOUNTAIN_YOUTH';
UPDATE Features SET OccurrenceFrequency=2 WHERE Type='FEATURE_FOUNTAIN_YOUTH';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_FOUNTAIN_YOUTH';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_FOUNTAIN_YOUTH', 'YIELD_FOOD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_FOUNTAIN_YOUTH', 'YIELD_PRODUCTION', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_FOUNTAIN_YOUTH', 'YIELD_GOLD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_FOUNTAIN_YOUTH', 'YIELD_SCIENCE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_FOUNTAIN_YOUTH', 'YIELD_CULTURE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_FOUNTAIN_YOUTH', 'YIELD_FAITH', 0);

UPDATE Features SET InBorderHappiness=1 WHERE Type='FEATURE_POTOSI';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_POTOSI';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_POTOSI', 'YIELD_FOOD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_POTOSI', 'YIELD_PRODUCTION', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_POTOSI', 'YIELD_GOLD', 8);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_POTOSI', 'YIELD_SCIENCE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_POTOSI', 'YIELD_CULTURE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_POTOSI', 'YIELD_FAITH', 0);

UPDATE Features SET InBorderHappiness=1 WHERE Type='FEATURE_EL_DORADO';
UPDATE Features SET OccurrenceFrequency=4 WHERE Type='FEATURE_EL_DORADO';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_EL_DORADO';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_EL_DORADO', 'YIELD_FOOD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_EL_DORADO', 'YIELD_PRODUCTION', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_EL_DORADO', 'YIELD_GOLD', 3);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_EL_DORADO', 'YIELD_SCIENCE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_EL_DORADO', 'YIELD_CULTURE', 5);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_EL_DORADO', 'YIELD_FAITH', 0);

UPDATE Features SET InBorderHappiness=3 WHERE Type='FEATURE_SRI_PADA';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_SRI_PADA';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_SRI_PADA', 'YIELD_FOOD', 2);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_SRI_PADA', 'YIELD_PRODUCTION', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_SRI_PADA', 'YIELD_GOLD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_SRI_PADA', 'YIELD_SCIENCE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_SRI_PADA', 'YIELD_CULTURE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_SRI_PADA', 'YIELD_FAITH', 4);

UPDATE Features SET InBorderHappiness=1 WHERE Type='FEATURE_MT_SINAI';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_MT_SINAI';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MT_SINAI', 'YIELD_FOOD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MT_SINAI', 'YIELD_PRODUCTION', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MT_SINAI', 'YIELD_GOLD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MT_SINAI', 'YIELD_SCIENCE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MT_SINAI', 'YIELD_CULTURE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MT_SINAI', 'YIELD_FAITH', 8);

UPDATE Features SET InBorderHappiness=3 WHERE Type='FEATURE_MT_KAILASH';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_MT_KAILASH';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MT_KAILASH', 'YIELD_FOOD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MT_KAILASH', 'YIELD_PRODUCTION', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MT_KAILASH', 'YIELD_GOLD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MT_KAILASH', 'YIELD_SCIENCE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MT_KAILASH', 'YIELD_CULTURE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_MT_KAILASH', 'YIELD_FAITH', 6);

UPDATE Features SET InBorderHappiness=1 WHERE Type='FEATURE_ULURU';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_ULURU';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_ULURU', 'YIELD_FOOD', 2);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_ULURU', 'YIELD_PRODUCTION', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_ULURU', 'YIELD_GOLD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_ULURU', 'YIELD_SCIENCE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_ULURU', 'YIELD_CULTURE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_ULURU', 'YIELD_FAITH', 6);

UPDATE Features SET InBorderHappiness=1 WHERE Type='FEATURE_LAKE_VICTORIA';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_LAKE_VICTORIA';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_LAKE_VICTORIA', 'YIELD_FOOD', 6);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_LAKE_VICTORIA', 'YIELD_PRODUCTION', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_LAKE_VICTORIA', 'YIELD_GOLD', 2);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_LAKE_VICTORIA', 'YIELD_SCIENCE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_LAKE_VICTORIA', 'YIELD_CULTURE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_LAKE_VICTORIA', 'YIELD_FAITH', 0);

UPDATE Features SET InBorderHappiness=1 WHERE Type='FEATURE_KILIMANJARO';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_KILIMANJARO';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_KILIMANJARO', 'YIELD_FOOD', 4);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_KILIMANJARO', 'YIELD_PRODUCTION', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_KILIMANJARO', 'YIELD_GOLD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_KILIMANJARO', 'YIELD_SCIENCE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_KILIMANJARO', 'YIELD_CULTURE', 2);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_KILIMANJARO', 'YIELD_FAITH', 2);

UPDATE Features SET InBorderHappiness=1 WHERE Type='FEATURE_SOLOMONS_MINES';
UPDATE Features SET FirstFinderGold=150 WHERE Type='FEATURE_SOLOMONS_MINES';
UPDATE Features SET OccurrenceFrequency=5 WHERE Type='FEATURE_SOLOMONS_MINES';
DELETE FROM Feature_YieldChanges WHERE FeatureType='FEATURE_SOLOMONS_MINES';
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_SOLOMONS_MINES', 'YIELD_FOOD', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_SOLOMONS_MINES', 'YIELD_PRODUCTION', 6);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_SOLOMONS_MINES', 'YIELD_GOLD', 2);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_SOLOMONS_MINES', 'YIELD_SCIENCE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_SOLOMONS_MINES', 'YIELD_CULTURE', 0);
INSERT INTO Feature_YieldChanges(FeatureType, YieldType, Yield) VALUES('FEATURE_SOLOMONS_MINES', 'YIELD_FAITH', 0);

DELETE FROM Feature_YieldChanges WHERE Yield=0;
DELETE FROM Feature_YieldChanges WHERE FeatureType NOT IN (SELECT Type FROM Features);
