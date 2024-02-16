-----------------------------------------------------------------------------
-- R.E.D. - Just Ethnic Diversity
-- Compatibility File
-----------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------------
-- Mechanized Infantry with soldiers
-------------------------------------------------------------------------------------------------------------------------

-- MODERN SOLDIER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_MODERNSOLDIER';

-- MECHANIZED INFANTRY 2
--already updated by JustEthnicDiversity.sql
--UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.1 WHERE Type = 'ART_DEF_UNIT_MEMBER_MECHANIZEDINFANTRY2';


/*
-------------------------------------------------------------------------------------------------------------------------
-- City State Diplomacy Mod
-------------------------------------------------------------------------------------------------------------------------

-- MESSENGER
INSERT INTO "ArtDefine_UnitInfos" ('Type','DamageStates','Formation')
	VALUES	("ART_DEF_UNIT_MESSENGER", "1", "UnFormed");	
INSERT INTO "ArtDefine_UnitInfoMemberInfos" ('UnitInfoType','UnitMemberInfoType','NumMembers')
	VALUES	("ART_DEF_UNIT_MESSENGER", "ART_DEF_UNIT_MEMBER_AFRIFEMALE1", 1);
	
-- ENVOY
INSERT INTO "ArtDefine_UnitInfos" ('Type','DamageStates','Formation')
	VALUES	("ART_DEF_UNIT_ENVOY", "1", "UnFormed");	
INSERT INTO "ArtDefine_UnitInfoMemberInfos" ('UnitInfoType','UnitMemberInfoType','NumMembers')
	VALUES	("ART_DEF_UNIT_ENVOY", "ART_DEF_UNIT_MEMBER_AFRIMALE2", 1);

-- EMISSARY
INSERT INTO "ArtDefine_UnitInfos" ('Type','DamageStates','Formation')
	VALUES	("ART_DEF_UNIT_EMISSARY", "1", "UnFormed");	
INSERT INTO "ArtDefine_UnitInfoMemberInfos" ('UnitInfoType','UnitMemberInfoType','NumMembers')
	VALUES	("ART_DEF_UNIT_EMISSARY", "ART_DEF_UNIT_MEMBER_SETTLERS_ASIAN_F4", 1);

-- DIPLOMAT
INSERT INTO "ArtDefine_UnitInfos" ('Type','DamageStates','Formation')
	VALUES	("ART_DEF_UNIT_DIPLOMAT", "1", "UnFormed");	
INSERT INTO "ArtDefine_UnitInfoMemberInfos" ('UnitInfoType','UnitMemberInfoType','NumMembers')
	VALUES	("ART_DEF_UNIT_DIPLOMAT", "ART_DEF_UNIT_MEMBER_EUROMALE45", 1);
	
-- AMBASSADOR
INSERT INTO "ArtDefine_UnitInfos" ('Type','DamageStates','Formation')
	VALUES	("ART_DEF_UNIT_AMBASSADOR", "1", "UnFormed");	
INSERT INTO "ArtDefine_UnitInfoMemberInfos" ('UnitInfoType','UnitMemberInfoType','NumMembers')
	VALUES	("ART_DEF_UNIT_AMBASSADOR", "ART_DEF_UNIT_MEMBER_SETTLERS_ASIAN_M1", 1);
*/
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------