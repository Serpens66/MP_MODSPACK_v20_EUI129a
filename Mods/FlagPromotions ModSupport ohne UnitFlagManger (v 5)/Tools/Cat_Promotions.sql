--

		
UPDATE UnitPromotions
SET Class = 'PROMOTION_CLASS_ATTRIBUTE_POSITIVE'
WHERE PediaType = 'PEDIA_ATTRIBUTES' AND LostWithUpgrade = 1;

UPDATE UnitPromotions
SET Class = 'PROMOTION_CLASS_ATTRIBUTE_NEGATIVE'
WHERE Type LIKE '%PENALTY%'
OR Type IN (
    'PROMOTION_RECON_EXPERIENCE',
	'PROMOTION_MUST_SET_UP',
	'PROMOTION_ROUGH_TERRAIN_ENDS_TURN',
	'PROMOTION_FOLIAGE_IMPASSABLE',
	'PROMOTION_NO_CAPTURE',
	'PROMOTION_ONLY_DEFENSIVE',
	'PROMOTION_NO_DEFENSIVE_BONUSES'
);


UPDATE UnitPromotions
SET LostWithUpgrade = 1
WHERE Class = 'PROMOTION_CLASS_ATTRIBUTE_NEGATIVE';

UPDATE UnitPromotions
SET PediaType = 'PEDIA_SHARED'
WHERE Type LIKE '%PROMOTION_BOMBARDMENT%';

UPDATE UnitPromotions
SET SimpleHelpText = 1
WHERE PediaType = 'PEDIA_ATTRIBUTES' AND NOT Type IN (
	'PROMOTION_AI_HANDICAP'				,
	'PROMOTION_AIR_SWEEP'				,
	'PROMOTION_AIR_RECON'				,
	'PROMOTION_ASTRONOMY'				,
	'PROMOTION_CAMARADERIE'				,
	'PROMOTION_DEFEND_NEAR_CAPITAL'		
);


INSERT INTO UnitPromotions_UnitCombats	(PromotionType, UnitCombatType)
SELECT DISTINCT							PromotionType, 'UNITCOMBAT_SUBMARINE'
FROM UnitPromotions_UnitCombats WHERE	UnitCombatType = 'UNITCOMBAT_NAVALRANGED';

DELETE FROM UnitPromotions_UnitCombats
WHERE UnitCombatType = 'UNITCOMBAT_SUBMARINE' AND PromotionType LIKE 'PROMOTION_BOMBARDMENT_%';

DELETE FROM UnitPromotions_UnitCombats
WHERE UnitCombatType = 'UNITCOMBAT_SUBMARINE' AND PromotionType IN (
	'PROMOTION_INDIRECT_FIRE',
	'PROMOTION_SUPPLY'
);

/*
-- REGEXP not available in this version of SQLite Spy?
UPDATE UnitPromotions
SET RankList = SUBSTR(Type, 1, LENGTH(Type)-2), RankNumber = SUBSTR(Type, -1)
WHERE Type REGEXP '.*\d';
*/

UPDATE UnitPromotions
SET RankList = SUBSTR(Type, 1, LENGTH(Type)-2), RankNumber = SUBSTR(Type, -1)
WHERE Type LIKE '%_1';

UPDATE UnitPromotions
SET RankList = SUBSTR(Type, 1, LENGTH(Type)-2), RankNumber = SUBSTR(Type, -1)
WHERE Type LIKE '%_2';

UPDATE UnitPromotions
SET RankList = SUBSTR(Type, 1, LENGTH(Type)-2), RankNumber = SUBSTR(Type, -1)
WHERE Type LIKE '%_3';



--RankList(stacking) of promos which are don´t numeric 

UPDATE UnitPromotions
SET RankList = 'MOBILITY', RankNumber = 70
WHERE Type = 'PROMOTION_MOBILITY';

UPDATE UnitPromotions
SET RankList = 'MOBILITY', RankNumber = 71
WHERE Type = 'PROMOTION_NAVAL_TRADITION';

UPDATE UnitPromotions
SET RankList = 'MOBILITY', RankNumber = 72
WHERE Type = 'PROMOTION_GREAT_LIGHTHOUSE';

UPDATE UnitPromotions
SET RankList = 'MOBILITY', RankNumber = 73
WHERE Type = 'PROMOTION_TREASURE_FLEET';



UPDATE UnitPromotions
SET RankList = 'HONOR', RankNumber = 1
WHERE Type = 'PROMOTION_HONOR_BONUS';

UPDATE UnitPromotions
SET RankList = 'HONOR', RankNumber = 2
WHERE Type = 'PROMOTION_KILL_HEAL';



UPDATE UnitPromotions
SET RankList = 'BUFFALO', RankNumber = 1
WHERE Type = 'PROMOTION_BUFFALO_HORNS';

UPDATE UnitPromotions
SET RankList = 'BUFFALO', RankNumber = 2
WHERE Type = 'PROMOTION_BUFFALO_CHEST';

UPDATE UnitPromotions
SET RankList = 'BUFFALO', RankNumber = 3
WHERE Type = 'PROMOTION_BUFFALO_LOINS';

UPDATE UnitPromotions
SET RankList = 'MEDIC', RankNumber = 1
WHERE Type = 'PROMOTION_MEDIC';

UPDATE UnitPromotions
SET RankList = 'MEDIC', RankNumber = 2
WHERE Type = 'PROMOTION_MEDIC_II';

-- Serp changes START
-- promotions from whowards AntiAir mod:
UPDATE UnitPromotions
SET RankList = 'ANTIAIR_INTERCEPT', RankNumber = 1
WHERE Type = 'PROMOTION_AA_INTERCEPT_I';

UPDATE UnitPromotions
SET RankList = 'ANTIAIR_INTERCEPT', RankNumber = 2
WHERE Type = 'PROMOTION_AA_INTERCEPT_II';

UPDATE UnitPromotions
SET RankList = 'ANTIAIR_INTERCEPT', RankNumber = 3
WHERE Type = 'PROMOTION_AA_INTERCEPT_III';

UPDATE UnitPromotions
SET RankList = 'ANTIAIR_FLACK', RankNumber = 1
WHERE Type = 'PROMOTION_AA_FLACK_I';

UPDATE UnitPromotions
SET RankList = 'ANTIAIR_FLACK', RankNumber = 2
WHERE Type = 'PROMOTION_AA_FLACK_II';

UPDATE UnitPromotions
SET RankList = 'ANTIAIR_FLACK', RankNumber = 3
WHERE Type = 'PROMOTION_AA_FLACK_III';

-- promotions from whowards extra cargo mod

UPDATE UnitPromotions
SET RankList = 'EXTRACARGO', RankNumber = 1
WHERE Type = 'PROMOTION_CARGO_EXTRA_I';

UPDATE UnitPromotions
SET RankList = 'EXTRACARGO', RankNumber = 2
WHERE Type = 'PROMOTION_CARGO_EXTRA_II';
-- SERP changes END

--ICONATLAS
--CBP Barb-only Promo Icon Changes

UPDATE UnitPromotions
SET PortraitIndex = 0, IconAtlas = 'NEW_PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_MARSH_WALKER';


UPDATE UnitPromotions
SET PortraitIndex = 2, IconAtlas = 'NEW_PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_WHITE_WALKER';


UPDATE UnitPromotions
SET PortraitIndex = 1, IconAtlas = 'NEW_PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_WOODS_WALKER';


UPDATE UnitPromotions
SET PortraitIndex = 3, IconAtlas = 'NEW_PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_DESERT_WALKER';


UPDATE UnitPromotions
SET PortraitIndex = 0, IconAtlas = 'VANGUARD_PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_COAST_WALKER';


UPDATE UnitPromotions
SET PortraitIndex = 0, IconAtlas = 'NEW_PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_HILL_WALKER';


--NavalPromos
UPDATE UnitPromotions
SET PortraitIndex = 0, IconAtlas = 'EXPANSIONI_ATLAS'
WHERE Type = 'PROMOTION_BOARDING_PARTY_1';


UPDATE UnitPromotions
SET PortraitIndex = 1, IconAtlas = 'EXPANSIONI_ATLAS'
WHERE Type = 'PROMOTION_BOARDING_PARTY_2';


UPDATE UnitPromotions
SET PortraitIndex = 2, IconAtlas = 'EXPANSIONI_ATLAS'
WHERE Type = 'PROMOTION_BOARDING_PARTY_3';


UPDATE UnitPromotions
SET PortraitIndex = 3, IconAtlas = 'EXPANSIONI_ATLAS'
WHERE Type = 'PROMOTION_COASTAL_RAIDER_1';


UPDATE UnitPromotions
SET PortraitIndex = 4, IconAtlas = 'EXPANSIONI_ATLAS'
WHERE Type = 'PROMOTION_COASTAL_RAIDER_2';


UPDATE UnitPromotions
SET PortraitIndex = 5, IconAtlas = 'EXPANSIONI_ATLAS'
WHERE Type = 'PROMOTION_COASTAL_RAIDER_3';

-- Serp changes START

-- new barbarian promotions from barbarian immersion

UPDATE UnitPromotions
SET PortraitIndex = 2, IconAtlas = 'EXPANSIONI_ATLAS'
WHERE Type = 'PROMOTION_BRIGAND';

UPDATE UnitPromotions
SET PortraitIndex = 3, IconAtlas = 'EXPANSIONI_ATLAS'
WHERE Type = 'PROMOTION_PIRATE';

UPDATE UnitPromotions
SET PortraitIndex = 4, IconAtlas = 'EXPANSIONI_ATLAS'
WHERE Type = 'PROMOTION_REBEL';

UPDATE UnitPromotions
SET PortraitIndex = 5, IconAtlas = 'EXPANSIONI_ATLAS'
WHERE Type = 'PROMOTION_TERRORIST';   

CREATE TRIGGER Trigger1
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_BRIGAND'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PortraitIndex = 2, IconAtlas = 'EXPANSIONI_ATLAS'
    WHERE Type = 'PROMOTION_BRIGAND';
END;

CREATE TRIGGER Trigger2
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_PIRATE'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PortraitIndex = 3, IconAtlas = 'EXPANSIONI_ATLAS'
    WHERE Type = 'PROMOTION_PIRATE';
END;

CREATE TRIGGER Trigger3
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_REBEL'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PortraitIndex = 4, IconAtlas = 'EXPANSIONI_ATLAS'
    WHERE Type = 'PROMOTION_REBEL';
END;

CREATE TRIGGER Trigger4
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_TERRORIST'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PortraitIndex = 5, IconAtlas = 'EXPANSIONI_ATLAS'
    WHERE Type = 'PROMOTION_TERRORIST';   
END;

-- promos from promotion level system , icon changes
UPDATE UnitPromotions
SET PortraitIndex = 19, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_PHEAL_M';   

UPDATE UnitPromotions
SET PortraitIndex = 11, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_CHARGE';   

UPDATE UnitPromotions
SET PortraitIndex = 9, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_ESC';   
 
UPDATE UnitPromotions
SET PortraitIndex = 16, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_MOUNTAIN';   

UPDATE UnitPromotions
SET PortraitIndex = 16, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_MOUNTAIN_SCOUT';   

CREATE TRIGGER Trigger5
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_PHEAL_M'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PortraitIndex = 19, IconAtlas = 'NEW_ICON_ATLAS'
    WHERE Type = 'PROMOTION_PHEAL_M';   
END;

CREATE TRIGGER Trigger6
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_CHARGE'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PortraitIndex = 11, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_CHARGE';   
END;

CREATE TRIGGER Trigger7
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_ESC'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PortraitIndex = 9, IconAtlas = 'NEW_ICON_ATLAS'
    WHERE Type = 'PROMOTION_ESC';   
END;

CREATE TRIGGER Trigger8
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_MOUNTAIN'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PortraitIndex = 16, IconAtlas = 'NEW_ICON_ATLAS'
    WHERE Type = 'PROMOTION_MOUNTAIN';    
END;

CREATE TRIGGER Trigger9
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_MOUNTAIN_SCOUT'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PortraitIndex = 16, IconAtlas = 'NEW_ICON_ATLAS'
    WHERE Type = 'PROMOTION_MOUNTAIN_SCOUT';    
END;

-- vanilla promo icon change

UPDATE UnitPromotions
SET PortraitIndex = 1, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_WOODSMAN';   

UPDATE UnitPromotions
SET PortraitIndex = 1, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_WOODSMAN_SCOUT';

UPDATE UnitPromotions
SET PortraitIndex = 17, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_ADJACENT_BONUS';

UPDATE UnitPromotions
SET PortraitIndex = 0, IconAtlas = 'NEW_PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_IGNORE_TERRAIN_COST';


-- promos from terraincrossing
-- every time the unitpromotions table gets a new entry, the icon from terraincrossing are replaced. To make sure to use the correct icons, even if the terrain mod loads after flagpromo

UPDATE UnitPromotions
SET PortraitIndex = 2, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_CAN_CROSS_MOUNTAINS';   

UPDATE UnitPromotions
SET PortraitIndex = 2, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_CAN_CROSS_MOUNTAINS_SCOUT';   

UPDATE UnitPromotions
SET PortraitIndex = 2, IconAtlas = 'NEW_PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_CAN_CROSS_ICE';  

UPDATE UnitPromotions
SET PortraitIndex = 2, IconAtlas = 'NEW_PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_ICEBREAKER';  

CREATE TRIGGER TerrainIconsFlagPromo1
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_CAN_CROSS_MOUNTAINS'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PortraitIndex = 2, IconAtlas = 'NEW_ICON_ATLAS'
    WHERE Type = 'PROMOTION_CAN_CROSS_MOUNTAINS';   
END;

CREATE TRIGGER TerrainIconsFlagPromo2
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_CAN_CROSS_MOUNTAINS_SCOUT'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PortraitIndex = 2, IconAtlas = 'NEW_ICON_ATLAS'
    WHERE Type = 'PROMOTION_CAN_CROSS_MOUNTAINS_SCOUT';    
END;

CREATE TRIGGER TerrainIconsFlagPromo3
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_CAN_CROSS_ICE'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PortraitIndex = 2, IconAtlas = 'NEW_PROMOTION_ATLAS'
    WHERE Type = 'PROMOTION_CAN_CROSS_ICE';  
END;

CREATE TRIGGER TerrainIconsFlagPromo4
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_ICEBREAKER'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PortraitIndex = 2, IconAtlas = 'NEW_PROMOTION_ATLAS'
    WHERE Type = 'PROMOTION_ICEBREAKER';    
END;

-- great people capture (hero promotion)

UPDATE UnitPromotions
SET PortraitIndex = 7, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_HEROES';  

CREATE TRIGGER CaptureGreatPeople
AFTER INSERT ON UnitPromotions  
WHEN 'PROMOTION_HEROES'=NEW.Type
BEGIN
  UPDATE UnitPromotions
    SET PortraitIndex = 7, IconAtlas = 'NEW_ICON_ATLAS' -- new icon
    WHERE Type = 'PROMOTION_HEROES';    
END;


-- Serp changes END

--Wonder promos

UPDATE UnitPromotions
SET PortraitIndex = 5, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_HIMEJI_CASTLE';

UPDATE UnitPromotions
SET PortraitIndex = 10, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_MORALE'	;		--morale---heroic epic

UPDATE UnitPromotions
SET PortraitIndex = 9, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_STATUE_ZEUS'	;		

-- Policie promos

UPDATE UnitPromotions
SET PortraitIndex = 11, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_HONOR_BONUS'; --logistics,conscription--might

UPDATE UnitPromotions
SET PortraitIndex = 11, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_KILL_HEAL'	;		--logistics,conscription---might	

UPDATE UnitPromotions
SET PortraitIndex = 6, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_LIGHTNING_WARFARE'	;		---lightning warfare --autocracy, musketeer french

UPDATE UnitPromotions
SET PortraitIndex = 4, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_NATIONALISM'	; --patriotic  war


-- Unique Unit Promos

UPDATE UnitPromotions
SET PortraitIndex = 14, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_ATLATL_ATTACK'	;		---mayan

UPDATE UnitPromotions
SET PortraitIndex = 4, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_HOMELAND_GUARDIAN'	;		---marok

UPDATE UnitPromotions
SET PortraitIndex = 16, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_DESERT_WARRIOR'	;		---marok

UPDATE UnitPromotions
SET PortraitIndex = 4, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_SAPPER'	;		---ashur

UPDATE UnitPromotions
SET PortraitIndex = 3, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_RAIDER'	;		---songhai

UPDATE UnitPromotions
SET PortraitIndex = 3, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_FLANK_ATTACK_BONUS'	;		---huns

UPDATE UnitPromotions
SET PortraitIndex = 17, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_FOREIGN_LANDS'	;		---celts

UPDATE UnitPromotions
SET PortraitIndex = 18, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_HEAVY_CHARGE'	;		---poland

UPDATE UnitPromotions
SET PortraitIndex = 19, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_STRONGER_VS_DAMAGED'	;		---russia

UPDATE UnitPromotions
SET PortraitIndex = 20, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_FASTER_HEAL'	;	--pers

UPDATE UnitPromotions
SET PortraitIndex = 21, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_ATTACK_BONUS_SWEDEN'	;	--sweden

UPDATE UnitPromotions
SET PortraitIndex = 3, IconAtlas = 'NEW_PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_DESERT_SHIPS';    --arab

-- deactivated by serp
-- UPDATE UnitPromotions
-- SET PortraitIndex = 1, IconAtlas = 'NEW_PROMOTION_ATLAS'
-- WHERE Type = 'PROMOTION_WOODSMAN';  -- iro, 

UPDATE UnitPromotions
SET PortraitIndex = 1, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_MOHAWK';  --iro

UPDATE UnitPromotions
SET PortraitIndex = 39, IconAtlas = 'PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_EXTRA_SIGHT_II';  --spain

UPDATE UnitPromotions
SET PortraitIndex = 37, IconAtlas = 'PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_EXTRA_SIGHT_I';  --austr

UPDATE UnitPromotions
SET PortraitIndex = 16, IconAtlas = 'PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_HAKA_WAR_DANCE';  --poly

UPDATE UnitPromotions
SET PortraitIndex = 1, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_JAGUAR'; --monti

UPDATE UnitPromotions
SET PortraitIndex = 26, IconAtlas = 'PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_PARTIAL_HEAL_IF_DESTROY_ENEMY'; --monti

UPDATE UnitPromotions
SET PortraitIndex = 30, IconAtlas = 'PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_SECOND_ATTACK';  --inca

UPDATE UnitPromotions
SET PortraitIndex = 16, IconAtlas = 'PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_FEARED_ELEPHANT';  --siam

UPDATE UnitPromotions
SET PortraitIndex = 9, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_ANTI_GUNPOWDER'; --shaka

UPDATE UnitPromotions
SET PortraitIndex = 26, IconAtlas = 'PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_HEAL_IF_DESTROY_ENEMY'; --otto

UPDATE UnitPromotions
SET PortraitIndex = 21, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_ATTACK_BONUS'	;	--otto

UPDATE UnitPromotions
SET PortraitIndex = 33, IconAtlas = 'PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_MOON_STRIKER'	;	--shosho

UPDATE UnitPromotions
SET PortraitIndex = 58, IconAtlas = 'PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_DEFEND_NEAR_CAPITAL'	;	--ethio

UPDATE UnitPromotions
SET PortraitIndex = 22, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_PRIZE_SHIPS'	;	--dutch

UPDATE UnitPromotions
SET PortraitIndex = 3, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_SNEAK_ATTACK'	;	--mercs

UPDATE UnitPromotions
SET PortraitIndex = 6, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_GUERILLA_FIGHTER'	;	--guerilla

UPDATE UnitPromotions
SET PortraitIndex = 42, IconAtlas = 'PROMOTION_ATLAS'
WHERE Type = 'PROMOTION_FIRE_SUPPORT'	;	--ironclad

UPDATE UnitPromotions
SET PortraitIndex = 23, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_CAN_MOVE_AFTER_ATTACKING'	;	

UPDATE UnitPromotions
SET PortraitIndex = 0, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_SIEGE';

UPDATE UnitPromotions
SET PortraitIndex = 0, IconAtlas = 'NEW_ICON_ATLAS'
WHERE Type = 'PROMOTION_SIEGE_100';	


/*

UPDATE UnitPromotions
SET IsOther = 1;

UPDATE UnitPromotions
SET IsFirst = 1, IsOther = 0
WHERE (RangeChange						<> 0
);

UPDATE UnitPromotions
SET IsAttack = 1, IsOther = 0
WHERE (AdjacentMod						<> 0
	OR AirSweepCombatModifier			<> 0
	OR AttackFortifiedMod				<> 0
	OR AttackMod						<> 0
	OR AttackWoundedMod					<> 0
	OR CityAttack						<> 0
	OR CityAttackOnly					<> 0
	OR CombatPercent					<> 0
	OR ExtraAttacks						<> 0
	OR FlankAttackModifier				<> 0
	OR FriendlyLandsAttackModifier		<> 0
	OR FriendlyLandsModifier			<> 0
	OR HillsAttack						<> 0
	OR OnlyDefensive					<> 0
	OR OpenAttack						<> 0
	OR OpenRangedAttackMod				<> 0
	OR OutsideFriendlyLandsModifier		<> 0
	OR RangeAttackIgnoreLOS				<> 0
	OR RangedAttackModifier				<> 0
	OR RangedSupportFire				<> 0
	OR River							<> 0
	OR RoughAttack						<> 0
	OR RoughRangedAttackMod				<> 0
);

UPDATE UnitPromotions
SET IsDefense = 1, IsOther = 0
WHERE (AdjacentMod						<> 0
	OR CityDefense						<> 0
	OR CombatPercent					<> 0
	OR DefenseMod						<> 0
	OR EmbarkDefenseModifier			<> 0
	OR HillsDefense						<> 0
	OR NoDefensiveBonus					<> 0
	OR OpenDefense						<> 0
	OR OutsideFriendlyLandsModifier		<> 0
	OR RangedDefenseMod					<> 0
	OR RoughDefense						<> 0
);

UPDATE UnitPromotions
SET IsRanged = 1, IsOther = 0
WHERE (AdjacentMod						<> 0
	OR AirSweepCombatModifier			<> 0
	OR AttackFortifiedMod				<> 0
	OR AttackMod						<> 0
	OR AttackWoundedMod					<> 0
	OR CityAttack						<> 0
	OR CityAttackOnly					<> 0
	OR CityDefense						<> 0
	OR CombatPercent					<> 0
	OR DefenseMod						<> 0
	OR ExtraAttacks						<> 0
	OR FlankAttackModifier				<> 0
	OR FriendlyLandsAttackModifier		<> 0
	OR FriendlyLandsModifier			<> 0
	OR HillsAttack						<> 0
	OR HillsDefense						<> 0
	OR NoDefensiveBonus					<> 0
	OR OpenAttack						<> 0
	OR OpenDefense						<> 0
	OR OpenRangedAttackMod				<> 0
	OR OutsideFriendlyLandsModifier		<> 0
	OR RangeAttackIgnoreLOS				<> 0
	OR RangedAttackModifier				<> 0
	OR RangedDefenseMod					<> 0
	OR RangedSupportFire				<> 0
	OR RoughAttack						<> 0
	OR RoughDefense						<> 0
	OR RoughRangedAttackMod				<> 0
);

UPDATE UnitPromotions
SET IsMelee = 1, IsOther = 0
WHERE (AttackFortifiedMod				<> 0
	OR AttackMod						<> 0
	OR AttackWoundedMod					<> 0
	OR CityAttack						<> 0
	OR CityAttackOnly					<> 0
	OR CombatPercent					<> 0
	OR DefenseMod						<> 0
	OR EmbarkDefenseModifier			<> 0
	OR ExtraAttacks						<> 0
	OR FlankAttackModifier				<> 0
	OR FriendlyLandsAttackModifier		<> 0
	OR FriendlyLandsModifier			<> 0
	OR HillsAttack						<> 0
	OR HillsDefense						<> 0
	OR NoDefensiveBonus					<> 0
	OR OpenAttack						<> 0
	OR OpenDefense						<> 0
	OR OutsideFriendlyLandsModifier		<> 0
	OR RangedDefenseMod					<> 0
	OR River							<> 0
	OR RoughAttack						<> 0
	OR RoughDefense						<> 0
);

UPDATE UnitPromotions
SET IsHeal = 1, IsOther = 0
WHERE (AlwaysHeal						<> 0
	OR EnemyHealChange					<> 0
	OR NeutralHealChange				<> 0
	OR FriendlyHealChange				<> 0
	OR AdjacentTileHealChange			<> 0
	OR InstaHeal						<> 0
	OR HealOutsideFriendly				<> 0
	OR HPHealedIfDestroyEnemy			<> 0
	OR HealIfDestroyExcludesBarbarians	<> 0
	OR HealOnPillage					<> 0
	OR SameTileHealChange				<> 0
);

UPDATE UnitPromotions
SET IsMove = 1, IsOther = 0
WHERE (Amphib							<> 0
	OR AllowsEmbarkation				<> 0
	OR DropRange						<> 0
	OR EmbarkedAllWater					<> 0
	OR EnemyRoute						<> 0
	OR ExtraNavalMovement				<> 0
	OR ExtraWithdrawal					<> 0
	OR FlatMovementCost					<> 0
	OR FreePillageMoves					<> 0
	OR GreatGeneralReceivesMovement		<> 0
	OR HillsDoubleMove					<> 0
	OR HoveringUnit						<> 0
	OR IgnoreTerrainCost				<> 0
	OR MoveDiscountChange				<> 0
	OR MovesChange						<> 0
	OR MustSetUpToRangedAttack			<> 0
	OR RivalTerritory					<> 0
	OR RoughTerrainEndsTurn				<> 0
);

UPDATE UnitPromotions SET IsAttack = 1, IsRanged = 1, IsMelee = 1, IsOther = 0
WHERE (Type IN (SELECT PromotionType FROM UnitPromotions_Terrains			WHERE Attack <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_Features			WHERE Attack <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_UnitClasses		WHERE Attack <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_UnitClasses		WHERE Modifier <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_Domains			WHERE Modifier <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_UnitCombatMods		WHERE Modifier <> 0)
);

UPDATE UnitPromotions SET IsDefense = 1, IsRanged = 1, IsMelee = 1, IsOther = 0
WHERE (Type IN (SELECT PromotionType FROM UnitPromotions_Terrains			WHERE Defense <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_Features			WHERE Defense <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_UnitClasses		WHERE Defense <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_UnitClasses		WHERE Modifier <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_Domains			WHERE Modifier <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_UnitCombatMods		WHERE Modifier <> 0)
);

UPDATE UnitPromotions SET IsMove = 1, IsOther = 0
WHERE (Type IN (SELECT PromotionType FROM UnitPromotions_Terrains			WHERE DoubleMove <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_Terrains			WHERE Impassable <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_Terrains			WHERE PassableTech <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_Features			WHERE DoubleMove <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_Features			WHERE Impassable <> 0)
	OR Type IN (SELECT PromotionType FROM UnitPromotions_Features			WHERE PassableTech <> 0)
);
*/
/*
UPDATE UnitPromotions
SET Help = Description || '_HELP'
WHERE Type IN (
	'PROMOTION_IGNORE_TERRAIN_COST'			,
	'PROMOTION_FLAT_MOVEMENT_COST'			,
	'PROMOTION_CAN_MOVE_AFTER_ATTACKING'	,
	'PROMOTION_CAN_MOVE_IMPASSABLE'			,
	'PROMOTION_NO_CAPTURE'					,
	'PROMOTION_ONLY_DEFENSIVE'				,
	'PROMOTION_NO_DEFENSIVE_BONUSES'		,
	'PROMOTION_PARADROP'					,
	'PROMOTION_MUST_SET_UP'					,
	'PROMOTION_INTERCEPTION_I'				,
	'PROMOTION_INTERCEPTION_II'				,
	'PROMOTION_INTERCEPTION_III'			,
	'PROMOTION_INTERCEPTION_IV'				,
	'PROMOTION_ANTI_AIR'					,
	'PROMOTION_ANTI_AIR_II'					,
	'PROMOTION_INDIRECT_FIRE'				,
	'PROMOTION_OCEAN_IMPASSABLE'			,
	'PROMOTION_RIVAL_TERRITORY'				,
	'PROMOTION_CARGO_I'						,
	'PROMOTION_CARGO_II'					,
	'PROMOTION_CARGO_III'					,
	'PROMOTION_CARGO_IV'					,
	'PROMOTION_ANTI_TANK'					,
	'PROMOTION_EVASION_I'					,
	'PROMOTION_EVASION_II'					
);

*/
--
-- Done
--
UPDATE LoadedFile SET Value=1 WHERE Type='Cat_Promotions.sql';