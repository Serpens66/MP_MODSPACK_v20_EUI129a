-----------------------------------------------------------------------------
-- R.E.D. - Just Ethnic Diversity
-- Base Units
-----------------------------------------------------------------------------

-- ANTI-AIRCRAFT GUN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_ANTIAIRCRAFTGUN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_ANTIAIRCRAFTGUN%';
UPDATE ArtDefine_UnitInfos SET Formation = 'ThreeBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_ANTI_AIRCRAFT_GUN%';

-- ANTI-TANK GUN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_ANTITANKGUN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_ANTITANKGUN%';
UPDATE ArtDefine_UnitInfos SET Formation = 'ThreeBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_ANTI_TANK_GUN%';

-- ARCHER				
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_ARCHER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_ARCHER%';
DELETE FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_ARCHER';
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_ARCHER','ART_DEF_UNIT_MEMBER_ARCHER_V2',"3");
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_ARCHER','ART_DEF_UNIT_MEMBER_ARCHER',"6");
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_ARCHER','ART_DEF_UNIT_MEMBER_ARCHER_V3',"3");
UPDATE ArtDefine_UnitInfos SET Formation = 'Archer' WHERE Type LIKE 'ART_DEF_UNIT_ARCHER%';

-- ARTILLERY
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_ARTILLERY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_ARTILLERY%';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_ARTILLERY%';

-- ATOMIC BOMB
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.07 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_ATOMICBOMB%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_ATOMICBOMB%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_ATOMIC_BOMB%';

-- BARBARIAN ARCHER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_BARBARIAN_ARCHER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_BARBARIAN_ARCHER_01';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 6 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_BARBARIAN_ARCHER_V2';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_BARBARIAN_ARCHER_V3';
UPDATE ArtDefine_UnitInfos SET Formation = 'Barbarian' WHERE Type LIKE 'ART_DEF_UNIT_BARBARIAN_ARCHER%';

-- BARBARIAN GALLEY
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.09 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_BARBARIAN_GALLEY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_BARBARIAN_GALLEY';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_BARBARIAN_GALLEY%';

-- BARBARIAN SPEARMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_BARBARIAN_SPEARMAN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 4 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_BARBARIAN_SPEARMAN';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_BARBARIAN_SPEARMAN_V2';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_BARBARIAN_SPEARMAN_V3';
UPDATE ArtDefine_UnitInfos SET Formation = 'Barbarian' WHERE Type LIKE 'ART_DEF_UNIT_BARBARIAN_SPEARMAN%';

-- BARBARIAN SWORDSMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_BARBARIAN_SWORDSMAN%';			
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_BARBARIAN_SWORDSMAN';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 6 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_BARBARIAN_SWORDSMAN_V2';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_BARBARIAN_SWORDSMAN_V3';
UPDATE ArtDefine_UnitInfos SET Formation = 'Barbarian' WHERE Type LIKE 'ART_DEF_UNIT_BARBARIAN_SWORDSMAN%';

-- BARBARIAN WARRIOR
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_BARBARIAN_EURO%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_BARBARIAN_EURO_ALPHA';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 4 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_BARBARIAN_EURO_BRAVO';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 4 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_BARBARIAN_EURO_CHARLIE';
UPDATE ArtDefine_UnitInfos SET Formation = 'Barbarian' WHERE Type LIKE 'ART_DEF_UNIT_BARBARIAN_EURO%';

-- BATTLESHIP				
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.09 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_BATTLESHIP%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_BATTLESHIP%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_BATTLESHIP%';

-- BOMBER				
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.08 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_BOMBER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_BOMBER%';
UPDATE ArtDefine_UnitInfos SET Formation = 'BomberWing' WHERE Type LIKE 'ART_DEF_UNIT_BOMBER%';

-- CANNON
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CANNON%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_CANNON%';
UPDATE ArtDefine_UnitInfos SET Formation = 'ThreeBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_CANNON%';

-- CARAVEL
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CARAVEL%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_CARAVEL%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_CARAVEL%';

-- CARRIER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.09 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CARRIER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_CARRIER%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_CARRIER%';

-- CATAPULT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CATAPULT%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_CATAPULT%';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_CATAPULT%';

-- CAVALRY
--note R.E.D. French and German cavalry use UNIT_MEMBER_LANCER_%
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CAVALRY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_CAVALRY%';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type LIKE 'ART_DEF_UNIT_CAVALRY%';

-- CHARIOT ARCHER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.13 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CHARIOTARCHER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_CHARIOTARCHER%';
UPDATE ArtDefine_UnitInfos SET Formation = 'ChariotElephant' WHERE Type LIKE 'ART_DEF_UNIT_CHARIOT_ARCHER%';

-- CROSSBOWMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CROSSBOWMAN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_CROSSBOWMAN%';
UPDATE ArtDefine_UnitInfos SET Formation = 'Archer' WHERE Type LIKE 'ART_DEF_UNIT_CROSSBOWMAN%';

-- DESTROYER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_DESTROYER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_DESTROYER%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_DESTROYER%';

-- FIGHTER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.08 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_FIGHTER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_FIGHTER%';
UPDATE ArtDefine_UnitInfos SET Formation = 'FighterWing' WHERE Type LIKE 'ART_DEF_UNIT_FIGHTER%';

-- FRIGATE
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_FRIGATE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_FRIGATE%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_FRIGATE%';

-- GALLEON
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GALLEON%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GALLEON%';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_GALLEON%';

-- GALLEY
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GALLEY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GALLEY%';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_GALLEY%';

-- GUIDED MISSILE
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GUIDEDMISSILE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GUIDEDMISSILE%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_GUIDED_MISSILE%';

-- HELICOPTER GUNSHIP
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.1 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_HELICOPTERGUNSHIP%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_HELICOPTERGUNSHIP%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_HELICOPTER_GUNSHIP%';

-- GREAT ARTIST
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREATARTIST_EARLY%';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.1 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREATARTIST_LATE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREATARTIST_EARLY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREATARTIST_LATE%';
UPDATE ArtDefine_UnitInfos SET Formation = 'EarlyGreatArtist' WHERE Type LIKE 'ART_DEF_UNIT_ARTIST%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_ARTIST_LATE%';

-- GREAT ENGINEER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREATENGINEER_EARLY%';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.09 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREATENGINEER_LATE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREATENGINEER_EARLY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREATENGINEER_LATE%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_ENGINEER%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_ENGINEER_LATE%';

-- GREAT GENERAL
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREATGENERAL_EARLY%';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREATGENERAL_LATE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREATGENERAL_EARLY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREATGENERAL_LATE%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_GENERAL%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_GENERAL_LATE%';

-- GREAT MERCHANT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREATMERCHANT_EARLY%';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.11 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREATMERCHANT_LATE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREATMERCHANT_EARLY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREATMERCHANT_LATE%';
UPDATE ArtDefine_UnitInfos SET Formation = 'EarlyGreatMerchant' WHERE Type LIKE 'ART_DEF_UNIT_MERCHANT%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_MERCHANT_LATE%';

-- GREAT SCIENTIST
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREATSCIENTIST_EARLY%';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREATSCIENTIST_LATE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREATSCIENTIST_EARLY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREATSCIENTIST_LATE%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_SCIENTIST%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_SCIENTIST_LATE%';

-- HORSEMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_HORSEMAN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_HORSEMAN%';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type LIKE 'ART_DEF_UNIT_HORSEMAN%';

-- INFANTRY (infantry for vanilla, late infantry for G&K)
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_INFANTRY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_INFANTRY%';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type LIKE 'ART_DEF_UNIT_INFANTRY%';

-- IRONCLAD
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_IRONCLAD%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_IRONCLAD%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_IRONCLAD%';

-- JETFIGHTER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.09 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_JETFIGHTER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_JETFIGHTER%';
UPDATE ArtDefine_UnitInfos SET Formation = 'FighterWing' WHERE Type LIKE 'ART_DEF_UNIT_JET_FIGHTER%';

-- KNIGHT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_KNIGHT%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_KNIGHT%';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type LIKE 'ART_DEF_UNIT_KNIGHT%';

-- LANCER
--note R.E.D. French and German cavalry use UNIT_MEMBER_LANCER_%
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_LANCER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_LANCER%';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type LIKE 'ART_DEF_UNIT_LANCER%';

-- LONGSWORDSMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_LONGSWORDSMAN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_LONGSWORDSMAN%';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultMelee' WHERE Type LIKE 'ART_DEF_UNIT_LONGSWORDSMAN%';

-- GIANT DEATH ROBOT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_MECH%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_MECH%';
UPDATE ArtDefine_UnitInfos SET Formation = 'Vehicle' WHERE Type LIKE 'ART_DEF_UNIT_MECH%';

-- MECHANIZED INFANTRY
--not updated by R.E.D., but counters change from MECH% wildcard above
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.1 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_MECHANIZEDINFANTRY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_MECHANIZEDINFANTRY%';
UPDATE ArtDefine_UnitInfos SET Formation = 'Vehicle' WHERE Type LIKE 'ART_DEF_UNIT_MECHANIZED_INFANTRY%';

-- MISSILE CRUISER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.11 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_MISSILECRUISER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_MISSILECRUISER%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_MISSILE_CRUISER%';

-- MOBILE SAM
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.11 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_MOBILESAM%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_MOBILESAM%';
UPDATE ArtDefine_UnitInfos SET Formation = 'Vehicle' WHERE Type LIKE 'ART_DEF_UNIT_MOBILE_SAM%';

-- MODERN ARMOR
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.1 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_MODERNARMOR%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_MODERNARMOR%';
UPDATE ArtDefine_UnitInfos SET Formation = 'Vehicle' WHERE Type LIKE 'ART_DEF_UNIT_MODERN_ARMOR%';

-- MUSKETMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_MUSKETMAN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 14 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_MUSKETMAN%';
UPDATE ArtDefine_UnitInfos SET Formation = 'HonorableGunpowder' WHERE Type LIKE 'ART_DEF_UNIT_MUSKETMAN%';

-- NUCLEAR MISSILE
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_NUCLEARMISSILE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_NUCLEARMISSILE%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_NUCLEAR_MISSILE%';

-- NUCLEAR SUBMARINE
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.1 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_NUCLEARSUBMARINE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_NUCLEARSUBMARINE%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_NUCLEAR_SUBMARINE%';

-- PARATROOPER (changed to Danrell WWII generic models for consistency with civilization specific models)
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_PARATROOPER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 10 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_PARATROOPER%';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type LIKE 'ART_DEF_UNIT_PARATROOPER%';

-- PIKEMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_PIKEMAN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_PIKEMAN%';
UPDATE ArtDefine_UnitInfos SET Formation = 'Pikeman' WHERE Type LIKE 'ART_DEF_UNIT_PIKEMAN%';

-- RIFLEMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_RIFLEMAN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 14 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_RIFLEMAN%';
UPDATE ArtDefine_UnitInfos SET Formation = 'HonorableGunpowder' WHERE Type LIKE 'ART_DEF_UNIT_RIFLEMAN%';

-- ROCKET ARTILLERY
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.09 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_ROCKETARTILLERY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_ROCKETARTILLERY%';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_ROCKET_ARTILLERY%';

-- SCOUT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_SCOUT%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 6 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_SCOUT%';
UPDATE ArtDefine_UnitInfos SET Formation = 'Scout' WHERE Type LIKE 'ART_DEF_UNIT_SCOUT%';

-- SETTLER AFRICAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_AFRI%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_AFRI%';
-- SETTLER AMERINDIAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_AMER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_AMER%';
-- SETTLER SOUTH AMERINDIAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_SOUTHAM%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_SOUTHAM%';
-- SETTLER ASIAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.08 WHERE Type = 'ART_DEF_UNIT_MEMBER_SETTLERS_ASIAN_OX';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_SETTLERS_ASIAN_F_%';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_SETTLERS_ASIAN_M_%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_SETTLERS_ASIAN%';
-- SETTLER EURO
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_EURO%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_EURO%';
-- SETTLER
UPDATE ArtDefine_UnitInfos SET Formation = 'LooseCivilian' WHERE Type LIKE 'ART_DEF_UNIT__SETTLER%';

-- SPACE SHIP PARTS
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.1 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_SS_%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_SS_%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_SS_%';

-- SPEARMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_SPEARMAN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_SPEARMAN%';
DELETE FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_SPEARMAN';
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_SPEARMAN','ART_DEF_UNIT_MEMBER_SPEARMAN_V2',"4");
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_SPEARMAN','ART_DEF_UNIT_MEMBER_SPEARMAN',"5");
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_SPEARMAN','ART_DEF_UNIT_MEMBER_SPEARMAN_V3',"3");
UPDATE ArtDefine_UnitInfos SET Formation = 'Phalanx' WHERE Type LIKE 'ART_DEF_UNIT_SPEARMAN%';

-- STEALTH BOMBER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.08 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_STEALTHBOMBER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_STEALTHBOMBER%';
UPDATE ArtDefine_UnitInfos SET Formation = 'BomberWing' WHERE Type LIKE 'ART_DEF_UNIT_STEALTH_BOMBER%';

-- SUBMARINE
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.16 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_SUBMARINE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_SUBMARINE%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_SUBMARINE%';

-- SWORDSMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_SWORDSMAN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_SWORDSMAN%';
DELETE FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_SWORDSMAN';
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_SWORDSMAN','ART_DEF_UNIT_MEMBER_SWORDSMAN_V2',"4");
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_SWORDSMAN','ART_DEF_UNIT_MEMBER_SWORDSMAN',"5");
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_SWORDSMAN','ART_DEF_UNIT_MEMBER_SWORDSMAN_V3',"3");
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultMelee' WHERE Type LIKE 'ART_DEF_UNIT_SWORDSMAN%';

-- TANK
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_TANK%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_TANK%';
UPDATE ArtDefine_UnitInfos SET Formation = 'Vehicle' WHERE Type LIKE 'ART_DEF_UNIT_TANK%';

-- TRANSPORT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.11 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_TRANSPORT%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_TRANSPORT%';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_TRANSPORT%';

-- TREBUCHET
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_TREBUCHET%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_TREBUCHET%';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_TREBUCHET%';

-- TRIREME
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.07 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_TRIREME%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_TRIREME%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_TRIREME%';

-- WARRIOR
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_WARRIOR%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_WARRIOR%';
DELETE FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT__WARRIOR';
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT__WARRIOR','ART_DEF_UNIT_MEMBER_WARRIOR_V2',"3");
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT__WARRIOR','ART_DEF_UNIT_MEMBER_WARRIOR',"6");
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT__WARRIOR','ART_DEF_UNIT_MEMBER_WARRIOR_V4',"3");
UPDATE ArtDefine_UnitInfos SET Formation = 'Warrior' WHERE Type LIKE 'ART_DEF_UNIT__WARRIOR%';

-- WORKBOAT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.07 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_WORKBOAT%';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.07 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_WORKBOAT_INDUSTRIAL%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_WORKBOAT%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_WORKBOAT_INDUSTRIAL%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_WORKBOAT%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_WORKBOAT_LATE%';

-- WORKER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_WORKER_%';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_WORKER_EURO_LATE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 8 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_WORKER_%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 8 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_WORKER_EURO_LATE%';
UPDATE ArtDefine_UnitInfos SET Formation = 'LooseCivilian' WHERE Type LIKE 'ART_DEF_UNIT__WORKER%';
UPDATE ArtDefine_UnitInfos SET Formation = 'LooseCivilian' WHERE Type LIKE 'ART_DEF_UNIT__WORKER_LATE%';

-----------------------------------------------------------------------------
-- Unique Units (Vanilla)
-----------------------------------------------------------------------------

-- AMERICAN B-17
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.08 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_AMERICAN_B17';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_AMERICAN_B17';
UPDATE ArtDefine_UnitInfos SET Formation = 'BomberWing' WHERE Type = 'ART_DEF_UNIT_U_AMERICAN_B17';

-- AMERICAN MINUTEMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_AMERICAN_MINUTEMAN';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 14 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_AMERICAN_MINUTEMAN';
UPDATE ArtDefine_UnitInfos SET Formation = 'HonorableGunpowder' WHERE Type = 'ART_DEF_UNIT_U_AMERICAN_MINUTEMAN';

-- ARABIAN CAMEL ARCHER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_ARABIAN_CAMELARCHER';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_ARABIAN_CAMELARCHER';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type = 'ART_DEF_UNIT_U_ARABIAN_CAMELARCHER';

-- AZTEC JAGUAR
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_AZTEC_JAGUAR';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_AZTEC_JAGUAR';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type = 'ART_DEF_UNIT_U_AZTEC_JAGUAR';

-- CHINESE CHU-KO-NU				
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_CHINESE_CHUKONU';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_CHINESE_CHUKONU';
UPDATE ArtDefine_UnitInfos SET Formation = 'Archer' WHERE Type = 'ART_DEF_UNIT_U_CHINESE_CHUKONU';

-- EGYPTIAN WAR CHARIOT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.13 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_EGYPTIAN_WARCHARIOT';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_EGYPTIAN_WARCHARIOT';
UPDATE ArtDefine_UnitInfos SET Formation = 'ChariotElephant' WHERE Type = 'ART_DEF_UNIT_U_EGYPTIAN_WARCHARIOT';

-- ENGLISH LONGBOWMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_ENGLISH_LONGBOWMAN';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_ENGLISH_LONGBOWMAN';
UPDATE ArtDefine_UnitInfos SET Formation = 'Archer' WHERE Type = 'ART_DEF_UNIT_U_ENGLISH_LONGBOWMAN';

-- ENGLISH SHIP OF THE LINE
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_ENGLISH_SHIPOFTHELINE';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_ENGLISH_SHIPOFTHELINE';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type = 'ART_DEF_UNIT_U_ENGLISH_SHIPOFTHELINE';

-- FRENCH FOREIGN LEGION
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_FRENCH_FOREIGNLEGION';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_FRENCH_FOREIGNLEGION';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type = 'ART_DEF_UNIT_U_FRENCH_FOREIGNLEGION';

-- FRENCH MUSKETEER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_FRENCH_MUSKETEER';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 14 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_FRENCH_MUSKETEER';
UPDATE ArtDefine_UnitInfos SET Formation = 'HonorableGunpowder' WHERE Type = 'ART_DEF_UNIT_U_FRENCH_MUSKETEER';

-- GERMAN LANDSKNECHT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_GERMAN_LANDSKNECHT_A';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_GERMAN_LANDSKNECHT_B';
DELETE FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_U_GERMAN_LANDSKNECHT';
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_U_GERMAN_LANDSKNECHT','ART_DEF_UNIT_MEMBER_U_GERMAN_LANDSKNECHT_A',"6");
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_U_GERMAN_LANDSKNECHT','ART_DEF_UNIT_MEMBER_U_GERMAN_LANDSKNECHT_B',"6");
UPDATE ArtDefine_UnitInfos SET Formation = 'Pikeman' WHERE Type = 'ART_DEF_UNIT_U_GERMAN_LANDSKNECHT';

-- GERMAN PANZER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.11 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_GERMAN_PANZER';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_GERMAN_PANZER';
UPDATE ArtDefine_UnitInfos SET Formation = 'Vehicle' WHERE Type = 'ART_DEF_UNIT_U_GERMAN_PANZER';

-- GREEK COMPANION CAVALRY
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_GREEK_COMPANIONCAVALRY';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_GREEK_COMPANIONCAVALRY';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type = 'ART_DEF_UNIT_U_GREEK_COMPANIONCAVALRY';

-- GREEK HOPLITE
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_GREEK_HOPLITE';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_GREEK_HOPLITE';
UPDATE ArtDefine_UnitInfos SET Formation = 'Phalanx' WHERE Type = 'ART_DEF_UNIT_U_GREEK_HOPLITE';

-- INDIAN WARELEPHANT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_INDIAN_WARELEPHANT';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_INDIAN_WARELEPHANT';
UPDATE ArtDefine_UnitInfos SET Formation = 'ChariotElephant' WHERE Type = 'ART_DEF_UNIT_U_INDIAN_WARELEPHANT';

-- IROQUOIAN MOHAWK WARRIOR
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_IROQUOIAN_MOHAWKWARRIOR';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_IROQUOIAN_MOHAWKWARRIOR';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type = 'ART_DEF_UNIT_U_IROQUOIAN_MOHAWKWARRIOR';

-- JAPANESE SAMURAI
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_JAPANESE_SAMURAI';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_JAPANESE_SAMURAI';
UPDATE ArtDefine_UnitInfos SET Formation = 'Samurai' WHERE Type = 'ART_DEF_UNIT_U_JAPANESE_SAMURAI';

-- JAPANESE ZERO
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.07 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_JAPANESE_ZERO';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_JAPANESE_ZERO';
UPDATE ArtDefine_UnitInfos SET Formation = 'FighterWing' WHERE Type = 'ART_DEF_UNIT_U_JAPANESE_ZERO';

-- OTTOMAN JANISSARY
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_OTTOMAN_JANISSARY';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 14 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_OTTOMAN_JANISSARY';
UPDATE ArtDefine_UnitInfos SET Formation = 'HonorableGunpowder' WHERE Type = 'ART_DEF_UNIT_U_OTTOMAN_JANISSARY';

--OTTOMAN SIPAHI
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_OTTOMAN_SIPAHI';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_OTTOMAN_SIPAHI';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type = 'ART_DEF_UNIT_U_OTTOMAN_SIPAHI';

-- PERSIAN IMMORTAL
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_PERSIAN_IMMORTAL';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_PERSIAN_IMMORTAL';
UPDATE ArtDefine_UnitInfos SET Formation = 'Phalanx' WHERE Type = 'ART_DEF_UNIT_U_PERSIAN_IMMORTAL';

-- ROMAN BALLISTA
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_ROMAN_BALLISTA';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_ROMAN_BALLISTA';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type = 'ART_DEF_UNIT_U_ROMAN_BALLISTA';

-- ROMAN LEGION
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_ROMAN_LEGION';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_ROMAN_LEGION';
UPDATE ArtDefine_UnitInfos SET Formation = 'Phalanx' WHERE Type = 'ART_DEF_UNIT_U_ROMAN_LEGION';

-- RUSSIAN COSSACK
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_RUSSIAN_COSSACK';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_RUSSIAN_COSSACK_V2';			
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_RUSSIAN_COSSACK_V3';
DELETE FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_U_RUSSIAN_COSSACK';
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_U_RUSSIAN_COSSACK','ART_DEF_UNIT_MEMBER_U_RUSSIAN_COSSACK',"1");
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_U_RUSSIAN_COSSACK','ART_DEF_UNIT_MEMBER_U_RUSSIAN_COSSACK_V2',"2");
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_U_RUSSIAN_COSSACK','ART_DEF_UNIT_MEMBER_U_RUSSIAN_COSSACK_V3',"2");
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type = 'ART_DEF_UNIT_U_RUSSIAN_COSSACK';

-- SIAMESE WAR ELEPHANT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SIAMESE_WARELEPHANT';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_SIAMESE_WARELEPHANT';
UPDATE ArtDefine_UnitInfos SET Formation = 'ChariotElephant' WHERE Type = 'ART_DEF_UNIT_U_SIAMESE_WARELEPHANT';

-- SONGHAI MUSLIM CAVALRY			
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SONGHAI_MUSLIMCAVALRY';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_SONGHAI_MUSLIMCAVALRY';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type = 'ART_DEF_UNIT_U_SONGHAI_MUSLIMCAVALRY';

-----------------------------------------------------------------------------
-- Unique Units (DLC)
-----------------------------------------------------------------------------

-- MOGOLIAN GREAT GENERAL
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_GREATGENERAL_KHAN';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_GREATGENERAL_KHAN';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type = 'ART_DEF_UNIT_GENERAL_KHAN';

-- MONGOLIAN KESHIK
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_MONGOLIAN_KESHIK';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_MONGOLIAN_KESHIK';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type = 'ART_DEF_UNIT_U_MONGOLIAN_KESHIK';

-- SPANISH CONQUISTADOR			
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.13 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SPANISH_CONQUISTADOR';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_SPANISH_CONQUISTADOR';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type = 'ART_DEF_UNIT_U_SPANISH_CONQUISTADOR';

-- INCAN SLINGER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_INCAN_SLINGER';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_INCAN_SLINGER';
UPDATE ArtDefine_UnitInfos SET Formation = 'Archer' WHERE Type = 'ART_DEF_UNIT_U_INCAN_SLINGER';

-- SPANISH TERCIO
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SPANISH_TERCIO_ARCABUCERO';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SPANISH_TERCIO_PIQUERO';
DELETE FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_U_SPANISH_TERCIO';
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_U_SPANISH_TERCIO','ART_DEF_UNIT_MEMBER_U_SPANISH_TERCIO_PIQUERO',"6");
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES ('ART_DEF_UNIT_U_SPANISH_TERCIO','ART_DEF_UNIT_MEMBER_U_SPANISH_TERCIO_ARCABUCERO',"6");
UPDATE ArtDefine_UnitInfos SET Formation = 'OffsetPikeman' WHERE Type = 'ART_DEF_UNIT_U_SPANISH_TERCIO';

-- POLYNESIAN WAR CANOE
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.07 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_POLYNESIAN_WAR_CANOE';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_POLYNESIAN_WAR_CANOE';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type = 'ART_DEF_UNIT_U_POLYNESIAN_WAR_CANOE';

-- POLYNESIAN MAORI WARRIOR
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.13 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_POLYNESIAN_MAORI_WARRIOR';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 10 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_POLYNESIAN_MAORI_WARRIOR';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type = 'ART_DEF_UNIT_U_POLYNESIAN_MAORI_WARRIOR';

-- DANISH BERSERKER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.16 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_DANISH_BERSERKER';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_DANISH_BERSERKER';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type = 'ART_DEF_UNIT_U_DANISH_BERSERKER';

-- DANISH SKI INFANTRY
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.13 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_DANISH_SKY_INFANTRY';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 14 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_DANISH_SKY_INFANTRY';
UPDATE ArtDefine_UnitInfos SET Formation = 'HonorableGunpowder' WHERE Type = 'ART_DEF_UNIT_U_DANISH_SKI_INFANTRY';

-- DANISH LONGBOAT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.10 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_DANISH_LONGBOAT';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_DANISH_LONGBOAT';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type = 'ART_DEF_UNIT_U_DANISH_LONGBOAT';

-- KOREAN HWACHA
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.13 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_KOREAN_HWACHA';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_KOREAN_HWACHA';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type = 'ART_DEF_UNIT_U_KOREAN_HWACHA';

-- KOREAN TURTLESHIP
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_KOREAN_TURTLESHIP';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_KOREAN_TURTLESHIP';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type = 'ART_DEF_UNIT_U_KOREAN_TURTLESHIP';

-- BABYLONIAN BOWMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_BABYLONIAN_BOWMAN';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_BABYLONIAN_BOWMAN';
UPDATE ArtDefine_UnitInfos SET Formation = 'Archer' WHERE Type = 'ART_DEF_UNIT_U_BABYLONIAN_BOWMAN';

-----------------------------------------------------------------------------
-- Gods & Kings units
-----------------------------------------------------------------------------


-- AUSTRIAN HUSSAR
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_AUSTRIAN_HUSSAR';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_AUSTRIAN_HUSSAR';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type = 'ART_DEF_UNIT_U_AUSTRIAN_HUSSAR';

-- BYZANTIUM CATAPHRACT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_BYZANTIUM_CATAPHRACT';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_BYZANTIUM_CATAPHRACT';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type = 'ART_DEF_UNIT_U_BYZANTIUM_CATAPHRACT';

-- BYZANTIUM DROMON
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.16 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_BYZANTIUM_DROMON';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_BYZANTIUM_DROMON';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type = 'ART_DEF_UNIT_U_BYZANTIUM_DROMON';

-- CARTHAGE AFRICANFOREST ELEPHANT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.13 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_CARTHAGE_AFRICANFOREST_ELEPHANT';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_CARTHAGE_AFRICANFOREST_ELEPHANT';
UPDATE ArtDefine_UnitInfos SET Formation = 'ChariotElephant' WHERE Type = 'ART_DEF_UNIT_U_CARTHAGE_AFRICANFOREST_ELEPHANT';

-- CARTHAGE QUINQUEREME
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.075 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_CARTHAGE_QUINQUEREME';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_CARTHAGE_QUINQUEREME';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type = 'ART_DEF_UNIT_U_CARTHAGE_QUINQUEREME';

-- CELT PICTISH WARRIOR
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_CELT_PICTISH_WARRIOR';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 10 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_CELT_PICTISH_WARRIOR';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type = 'ART_DEF_UNIT_U_CELT_PICTISH_WARRIOR';

-- DUTCH SEA BEGGARS
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_DUTCH_SEA_BEGGARS';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_DUTCH_SEA_BEGGARS';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type = 'ART_DEF_UNIT_U_DUTCH_SEA_BEGGARS';

-- ETHIOPIA MEHAL SEFARI
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.13 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_ETHIOPIA_MEHAL_SEFARI';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 14 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_ETHIOPIA_MEHAL_SEFARI';
UPDATE ArtDefine_UnitInfos SET Formation = 'HonorableGunpowder' WHERE Type = 'ART_DEF_UNIT_U_ETHIOPIA_MEHAL_SEFARI';

-- GALLEASS
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GALLEASS%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GALLEASS%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_GALLEASS%';

-- GREAT PROPHET
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREAT_PROPHET%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREAT_PROPHET%';
UPDATE ArtDefine_UnitInfos SET Formation = 'EarlyGreatArtist' WHERE Type LIKE 'ART_DEF_UNIT_GREAT_PROPHET%';

-- INQUISITOR
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_INQUISITOR%';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.125 WHERE Type = 'ART_DEF_UNIT_MEMBER_INQUISITOR_01';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.13 WHERE Type = 'ART_DEF_UNIT_MEMBER_INQUISITOR_02';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_INQUISITOR%';
UPDATE ArtDefine_UnitInfos SET Formation = 'EarlyGreatArtist' WHERE Type LIKE 'ART_DEF_UNIT_INQUISITOR%';

-- MISSIONARY
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_MISSIONARY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_MISSIONARY%';
UPDATE ArtDefine_UnitInfos SET Formation = 'EarlyGreatArtist' WHERE Type LIKE 'ART_DEF_UNIT_MISSIONARY%';

-- GREAT ADMIRAL
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREAT_ADMIRAL%';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREAT_ADMIRAL_LATE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREAT_ADMIRAL%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREAT_ADMIRAL_LATE%';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type LIKE 'ART_DEF_UNIT_GREAT_ADMIRAL%';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type LIKE 'ART_DEF_UNIT_GREAT_ADMIRAL_LATE%';

-- PRIVATEER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_XP_PRIVATEER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_XP_PRIVATEER%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_XP_PRIVATEER%';

-- HUNS BATTERING RAM
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.115 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_HUNS_BATTERING_RAM';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_HUNS_BATTERING_RAM';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type = 'ART_DEF_UNIT_U_HUNS_BATTERING_RAM';

-- HUNS HORSE ARCHER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_HUNS_HORSE_ARCHER';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_HUNS_HORSE_ARCHER';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type = 'ART_DEF_UNIT_U_HUNS_HORSE_ARCHER';

-- MARINE
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_MARINE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 14 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_MARINE%';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type LIKE 'ART_DEF_UNIT_MARINE%';

-- MAYAN ATLALIST
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_MAYAN_ATLALIST';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 10 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_MAYAN_ATLALIST';
UPDATE ArtDefine_UnitInfos SET Formation = 'Archer' WHERE Type = 'ART_DEF_UNIT_U_MAYAN_ATLALIST';

-- COMPOSITE BOWMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_COMPOSITE_BOWMAN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_COMPOSITE_BOWMAN%';
UPDATE ArtDefine_UnitInfos SET Formation = 'Archer' WHERE Type LIKE 'ART_DEF_UNIT_COMPOSITE_BOWMAN%';

-- MACHINE GUN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_MACHINEGUN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_MACHINEGUN%';
UPDATE ArtDefine_UnitInfos SET Formation = 'ThreeBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_MACHINEGUN%';

-- SWEDISH CAROLEAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SWEDISH_CAROLEAN';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 14 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_SWEDISH_CAROLEAN';
UPDATE ArtDefine_UnitInfos SET Formation = 'HonorableGunpowder' WHERE Type = 'ART_DEF_UNIT_U_SWEDISH_CAROLEAN';

-- SWEDISH HAKKAPELITTA
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SWEDISH_HAKKAPELITTA';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_SWEDISH_HAKKAPELITTA';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type = 'ART_DEF_UNIT_U_SWEDISH_HAKKAPELITTA';

-- WW1 BOMBER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.08 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_WW1_BOMBER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_WW1_BOMBER%';
UPDATE ArtDefine_UnitInfos SET Formation = 'BomberWing' WHERE Type LIKE 'ART_DEF_UNIT_WW1_BOMBER%';

-- WW1 FIGHTER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.09 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_WW1_FIGHTER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_WW1_FIGHTER%';
UPDATE ArtDefine_UnitInfos SET Formation = 'FighterWing' WHERE Type LIKE 'ART_DEF_UNIT_WW1_FIGHTER%';

-- WW1 INFANTRY
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_WW1_INFANTRY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 14 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_WW1_INFANTRY%';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type LIKE 'ART_DEF_UNIT_WW1_INFANTRY%';

-- WW1 TANK
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.11 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_WW1_TANK%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_WW1_TANK%';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_WW1_TANK%';

-- WW2 INFANTRY
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_WW2_INFANTRY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 14 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_WW2_INFANTRY%';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type LIKE 'ART_DEF_UNIT_WW2_INFANTRY%';

-- GATLING GUN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GATLINGGUN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GATLINGGUN%';
UPDATE ArtDefine_UnitInfos SET Formation = 'ThreeBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_GATLINGGUN%';

-----------------------------------------------------------------------------
-- Additional units (Scenarios)
-----------------------------------------------------------------------------

-- PRIVATEER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_PRIVATEER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_PRIVATEER%';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type LIKE 'ART_DEF_UNIT_PRIVATEER%';

-- SAXON HUSCARL
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SAXON_HUSCARL';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 9 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_SAXON_HUSCARL';
UPDATE ArtDefine_UnitInfos SET Formation = 'FighterWing' WHERE Type = 'ART_DEF_UNIT_U_SAXON_HUSCARL';

-- HITTITE WAR CHARIOT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.145 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_HITTITE_WARCHARIOT';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_HITTITE_WARCHARIOT';
UPDATE ArtDefine_UnitInfos SET Formation = 'ChariotElephant' WHERE Type = 'ART_DEF_UNIT_U_HITTITE_WARCHARIOT';

-- SUMERIAN PHALANX
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.13 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SUMERIAN_PHALANX';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_SUMERIAN_PHALANX';
UPDATE ArtDefine_UnitInfos SET Formation = 'Phalanx' WHERE Type = 'ART_DEF_UNIT_U_SUMERIAN_PHALANX';

-- SPANISH GALLEON
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.15 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SPANISH_GALLEON';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_SPANISH_GALLEON';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type = 'ART_DEF_UNIT_U_SPANISH_GALLEON';

-- SPANISH TREASURE CART
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.063 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SPANISH_TREASURE_CART';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_SPANISH_TREASURE_CART';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type = 'ART_DEF_UNIT_U_SPANISH_TREASURE_CART';

-- GADRAUHTS SWORDSMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_GADRAUHTS_SWORDSMAN';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 10 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_GADRAUHTS_SWORDSMAN';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type = 'ART_DEF_UNIT_GADRAUHTS_SWORDSMAN';


-----------------------------------------------------------------------------
-- Brave New World units
-----------------------------------------------------------------------------

-- CARGO SHIP
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.16 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CARGO_SHIP%';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CARGO_SHIP_MID%';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.08 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CARGO_SHIP_LATE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_CARGO_SHIP%';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type LIKE 'ART_DEF_UNIT_CARGO_SHIP%';

-- CARAVAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CARAVAN%';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.04 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CARAVAN_LATE%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_CARAVAN%';
UPDATE ArtDefine_UnitInfos SET Formation = 'ThreeInLine' WHERE Type LIKE 'ART_DEF_UNIT_CARAVAN%';
UPDATE ArtDefine_UnitInfos SET Formation = 'TheeInLineStag' WHERE Type LIKE 'ART_DEF_UNIT_CARAVAN_POSTMODERN%';

-- PORTUGUESE CARRACK
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_PORTUGUESE_CARRACK';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_PORTUGUESE_CARRACK';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type = 'ART_DEF_UNIT_U_PORTUGUESE_CARRACK';

-- VENETIAN GALLEASS
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_VENETIAN_GALLEASS';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_VENETIAN_GALLEASS';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type = 'ART_DEF_UNIT_U_VENETIAN_GALLEASS';

-- ARCHAEOLOGIST
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_ARCHAEOLOGIST%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_ARCHAEOLOGIST%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_ARCHAEOLOGIST_F1';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_ARCHAEOLOGIST_F2';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type LIKE 'ART_DEF_UNIT_ARCHAEOLOGIST%';

-- POLISH WINGED HUSSAR
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.13 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_POLISH_WINGED_HUSSAR';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_POLISH_WINGED_HUSSAR';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type = 'ART_DEF_UNIT_U_POLISH_WINGED_HUSSAR';

-- BAZOOKA INFANTRY
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_BAZOOKA_INFANTRY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_BAZOOKA_INFANTRY%';
UPDATE ArtDefine_UnitInfos SET Formation = 'ThreeBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_BAZOOKA_INFANTRY%';

-- GREAT ARTIST
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREAT_ARTIST%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREAT_ARTIST%';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type LIKE 'ART_DEF_UNIT_GREAT_ARTIST%';

-- GREAT WRITER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREAT_WRITER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREAT_WRITER%';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type LIKE 'ART_DEF_UNIT_GREAT_WRITER%';

-- GREAT MUSICIAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREAT_MUSICIAN%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREAT_MUSICIAN%';
UPDATE ArtDefine_UnitInfos SET Formation = 'EarlyGreatArtist' WHERE Type LIKE 'ART_DEF_UNIT_GREAT_MUSICIAN%';

-- VENETIAN MERCHANT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_VENETIAN_MERCHANT';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_VENETIAN_MERCHANT';
UPDATE ArtDefine_UnitInfos SET Formation = 'EarlyGreatMerchant' WHERE Type = 'ART_DEF_UNIT_U_VENETIAN_MERCHANT';

-- HAND AXE BARBARIAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_HAND_AXE_BARBARIAN';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 10 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_HAND_AXE_BARBARIAN';
UPDATE ArtDefine_UnitInfos SET Formation = 'Archer' WHERE Type = 'ART_DEF_UNIT_HAND_AXE_BARBARIAN';

-- BRAZILIAN PRACINHAS
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_BRAZILIAN_PRACINHAS';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_BRAZILIAN_PRACINHAS';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type = 'ART_DEF_UNIT_U_BRAZILIAN_PRACINHAS';

-- INDONESIAN KRIS SWORDSMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_INDONESIAN_KRIS_SWORDSMAN';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_INDONESIAN_KRIS_SWORDSMAN';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultMelee' WHERE Type = 'ART_DEF_UNIT_U_INDONESIAN_KRIS_SWORDSMAN';

-- MORROCAN BERBER CAVALRY
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_MORROCAN_BERBER_CAVALRY';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_MORROCAN_BERBER_CAVALRY';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type = 'ART_DEF_UNIT_U_MORROCAN_BERBER_CAVALRY';

-- SHOSHONE PATHFINDER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SHOSHONE_PATHFINDER';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 6 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_SHOSHONE_PATHFINDER';
UPDATE ArtDefine_UnitInfos SET Formation = 'Scout' WHERE Type = 'ART_DEF_UNIT_U_SHOSHONE_PATHFINDER';

-- ZULU IMPI WARRIOR
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_U_ZULU_IMPI_WARRIOR%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 4 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_ZULU_IMPI_WARRIOR';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_ZULU_IMPI_WARRIOR_V2';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_ZULU_IMPI_WARRIOR_V3';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type = 'ART_DEF_UNIT_U_ZULU_IMPI_WARRIOR';

-- ASSYRIAN SIEGE TOWER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.1 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_ASSYRIAN_SIEGE_TOWER';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_ASSYRIAN_SIEGE_TOWER';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type = 'ART_DEF_UNIT_U_ASSYRIAN_SIEGE_TOWER';

-- SHOSHONE COMANCHE RIDERS
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SHOSHONE_COMANCHE_RIDERS';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_U_SHOSHONE_COMANCHE_RIDERS';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type = 'ART_DEF_UNIT_U_SHOSHONE_COMANCHE_RIDERS';

-- CONFEDERATE ARTILLERY NAPOLEON/PARROTT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CONFEDERATE_ARTILLERY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_CONFEDERATE_ARTILLERY%';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_CONFEDERATE_ARTILLERY%';

-- UNION ARTILLERY NAPOLEON/PARROTT
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_UNION_ARTILLERY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_UNION_ARTILLERY%';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type LIKE 'ART_DEF_UNIT_UNION_ARTILLERY%';

-- MILITARY ENGINEER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_MILITARY_ENGINEER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 8 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_MILITARY_ENGINEER%';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type LIKE 'ART_DEF_UNIT_MILITARY_ENGINEER%';

-- CONFEDERATE GREAT GENERAL
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_CONFEDERATE_GREAT_GENERAL';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_CONFEDERATE_GREAT_GENERAL';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type = 'ART_DEF_UNIT_CONFEDERATE_GENERAL';

-- UNION GREAT GENERAL
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_UNION_GREAT_GENERAL';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_UNION_GREAT_GENERAL';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type = 'ART_DEF_UNIT_UNION_GENERAL';

-- GREAT EXPLORER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_GREAT_EXPLORER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_GREAT_EXPLORER%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 6 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_GREAT_EXPLORER_F1';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_GREAT_EXPLORER_F2';
UPDATE ArtDefine_UnitInfos SET Formation = 'EarlyGreatArtist' WHERE Type LIKE 'ART_DEF_UNIT_EXPLORER%';

-- XCOM SQUAD
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_XCOM_SQUAD%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 6 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_XCOM_SQUAD%';
UPDATE ArtDefine_UnitInfos SET Formation = 'EarlyGreatArtist' WHERE Type LIKE 'ART_DEF_UNIT_XCOM_SQUAD%';


-----------------------------------------------------------------------------
-- Additional units (Scenarios, not yet included in R.E.D.)
-----------------------------------------------------------------------------

-- SMOKEY AIRSHIP LEVEL 1
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.21 WHERE Type = 'ART_DEF_UNIT_MEMBER_SMOKEY_AIRSHIP_LEVEL_1';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_SMOKEY_AIRSHIP_LEVEL_1';
UPDATE ArtDefine_UnitInfos SET Formation = 'FighterWing' WHERE Type = 'ART_DEF_UNIT_SMOKEY_STEAM_AIRSHIP_LEVEL_1';

-- SMOKEY BLIMP
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.21 WHERE Type = 'ART_DEF_UNIT_MEMBER_SMOKEY_BLIMP';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_SMOKEY_BLIMP';
UPDATE ArtDefine_UnitInfos SET Formation = 'FighterWing' WHERE Type = 'ART_DEF_UNIT_SMOKEY_STEAM_AIRSHIP';

-- SMOKEY LANDSHIP LEVEL 1
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.16 WHERE Type = 'ART_DEF_UNIT_MEMBER_SMOKEY_LANDSHIP_LEVEL_1';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_SMOKEY_LANDSHIP_LEVEL_1';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type = 'ART_DEF_UNIT_SMOKEY_LANDSHIP_LEVEL_1';

-- SMOKEY LANDSHIP LEVEL 2
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.15 WHERE Type = 'ART_DEF_UNIT_MEMBER_SMOKEY_LANDSHIP_LEVEL_2';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_SMOKEY_LANDSHIP_LEVEL_2';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type = 'ART_DEF_UNIT_SMOKEY_LANDSHIP_LEVEL_2';

-- SMOKEY LANDSHIP LEVEL 3
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.20 WHERE Type = 'ART_DEF_UNIT_MEMBER_SMOKEY_LANDSHIP_LEVEL_3';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_SMOKEY_LANDSHIP_LEVEL_3';
UPDATE ArtDefine_UnitInfos SET Formation = 'TwoBigGuns' WHERE Type = 'ART_DEF_UNIT_SMOKEY_LANDSHIP_LEVEL_3';

-- SMOKEY STEAM FIGHTER
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.09 WHERE Type = 'ART_DEF_UNIT_MEMBER_SMOKEY_STEAM_FIGHTER';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 3 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_SMOKEY_STEAM_FIGHTER';
UPDATE ArtDefine_UnitInfos SET Formation = 'FighterWing' WHERE Type = 'ART_DEF_UNIT_SMOKEY_STEAM_FIGHTER';

-- CONFEDERATE CAVALRY CARBINE/PISTOL
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CONFEDERATE_CAVALRY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_CONFEDERATE_CAVALRY%';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type LIKE 'ART_DEF_UNIT_CONFEDERATE_CAVALRY%';

-- CONFEDERATE IRONCLAD
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_CONFEDERATE_IRONCLAD';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_CONFEDERATE_IRONCLAD';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type = 'ART_DEF_UNIT_CONFEDERATE_IRONCLAD';

-- CONFEDERATE DIVISION/CORPS RIFLEMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_CONFEDERATE_RIFLEMAN%';
--UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_CONFEDERATE_RIFLEMAN';
--UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_CONFEDERATE_RIFLEMAN_V1';
--UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 2 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_CONFEDERATE_RIFLEMAN_V2';
UPDATE ArtDefine_UnitInfos SET Formation = 'HonorableGunpowder' WHERE Type = 'ART_DEF_UNIT_CONFEDERATE_RIFLEMAN';

-- UNION CAVALRY CARBINE/PISTOL
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type LIKE 'ART_DEF_UNIT_MEMBER_UNION_CAVALRY%';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 5 WHERE UnitMemberInfoType LIKE 'ART_DEF_UNIT_MEMBER_UNION_CAVALRY%';
UPDATE ArtDefine_UnitInfos SET Formation = 'DefaultCavalry' WHERE Type LIKE 'ART_DEF_UNIT_UNION_CAVALRY%';

-- UNION IRONCLAD
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.12 WHERE Type = 'ART_DEF_UNIT_MEMBER_UNION_IRONCLAD';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_UNION_IRONCLAD';
UPDATE ArtDefine_UnitInfos SET Formation = '' WHERE Type = 'ART_DEF_UNIT_UNION_IRONCLAD';

-- UNION DIVISION/CORPS RIFLEMAN
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_UNION_RIFLEMAN';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 7 WHERE UnitInfoType = 'ART_DEF_UNIT_UNION_DIVISION';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 14 WHERE UnitInfoType = 'ART_DEF_UNIT_UNION_CORPS';
UPDATE ArtDefine_UnitInfos SET Formation = 'HonorableGunpowder' WHERE Type = 'ART_DEF_UNIT_UNION_RIFLEMAN';

-- SCRAMBLE FORCE PUBLIQUE
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_SCRAMBLE_FORCE_PUBLIQUE';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 12 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_SCRAMBLE_FORCE_PUBLIQUE';
UPDATE ArtDefine_UnitInfos SET Formation = 'UnFormed' WHERE Type = 'ART_DEF_UNIT_SCRAMBLE_FORCE_PUBLIQUE';

-- SCRAMBLE FOREIGN VOLUNTEERS
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.14 WHERE Type = 'ART_DEF_UNIT_MEMBER_SCRAMBLE_FOREIGN_VOLUNTEERS';
UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 14 WHERE UnitMemberInfoType = 'ART_DEF_UNIT_MEMBER_SCRAMBLE_FOREIGN_VOLUNTEERS';
UPDATE ArtDefine_UnitInfos SET Formation = 'HonorableGunpowder' WHERE Type = 'ART_DEF_UNIT_SCRAMBLE_FOREIGN_VOLUNTEERS';