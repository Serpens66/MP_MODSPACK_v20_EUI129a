-- Remove the conflict between FEATURE_LAKE == FEATURE_ICE and FEATURE_RIVER == FEATURE_JUNGLE
UPDATE FakeFeatures SET ID=ID+200;

ALTER TABLE Buildings
  ADD AddsFreshWater INTEGER DEFAULT 0;
ALTER TABLE Buildings
  ADD PurchaseOnly INTEGER DEFAULT 0;
ALTER TABLE Building_ThemingBonuses
  ADD ConsecutiveEras INTEGER DEFAULT 0;

ALTER TABLE Improvements
  ADD AddsFreshWater INTEGER DEFAULT 0;
  
-- added by serp:
ALTER TABLE Improvements
  ADD RequiresHills INTEGER DEFAULT 0;
  ALTER TABLE Improvements
  ADD RequiresAdjacentCity INTEGER DEFAULT 0;

INSERT INTO CustomModDbUpdates(Name, Value) VALUES('API_EXTENSIONS', 1);
