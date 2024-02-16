-- Aircraft rebase animations.
UPDATE MovementRates SET TotalTime = 0.04 WHERE Type = "AIR_REBASE";
UPDATE AnimationPaths SET MissionPath = 0 WHERE Type = "ANIMATIONPATH_AIRFADEIN";
UPDATE AnimationPaths SET MissionPath = 0 WHERE Type = "ANIMATIONPATH_AIRFADEOUT";

-- Aircraft animation speed.
UPDATE ArtDefine_UnitMemberCombats SET MoveRate = 2 * MoveRate;
UPDATE ArtDefine_UnitMemberCombats SET TurnRateMin = 2 * TurnRateMin WHERE MoveRate > 0;
UPDATE ArtDefine_UnitMemberCombats SET TurnRateMax = 2 * TurnRateMax WHERE MoveRate > 0;
UPDATE ArtDefine_UnitMemberCombats SET AttackRadius = 4 * AttackRadius WHERE MoveRate > 0;


-- faster movement for all other units
-- this unfortunaltey may cause units to not stop the movement animation, although they already reached their tile.
UPDATE MovementRates SET IndividualOffset = 0; -- delay between part-units from a unit
UPDATE MovementRates SET RowOffset = 0; -- delay between rows of part-units from a unit
UPDATE MovementRates SET TotalTime = TotalTime/4; -- the total time a part-unit needs to reach the plot

-- dont know what these do
-- UPDATE ArtDefine_UnitMemberCombats SET ShortMoveRate = 0.5*ShortMoveRate;
-- UPDATE MovementRates SET PathSubdivision = 0.5;
-- UPDATE AnimationPaths SET MissionPath = 0;
-- UPDATE Missions SET Time = 0;
-- UPDATE Missions SET Visible = 0;

-- no clue how to speed up the combat animations.. but such an animation would center the screen to it alawys and this would suck, even if it would be 10 times faster..
-- so we will stick to quick combat setting instead.