--

--
-- Create Tables
--

CREATE TABLE IF NOT EXISTS Cep(Type text NOT NULL UNIQUE, Value);
INSERT INTO Cep (Type, Value) VALUES ('SkipFile', 1);




	
/*

	





	


	
CREATE TABLE IF NOT EXISTS
	PromotionClasses (
	ID				integer PRIMARY KEY,
	Type			text NOT NULL UNIQUE ,
	Description		text
);

CREATE TABLE IF NOT EXISTS
	PromotionStats (
	ID				integer PRIMARY KEY AUTOINCREMENT,
	Type			text NOT NULL UNIQUE,
	Section			integer default 1,
	Priority		integer default 1,
	Dynamic			integer default 0,
	Attack			integer default 0,
	Defense			integer default 0,
	Opposite		text,
	Value			text
);



CREATE TABLE IF NOT EXISTS
	Trait_FreePromotionUnitTypes (
	TraitType		text REFERENCES Traits(Type),
	UnitType		text REFERENCES Units(Type),
	PromotionType	text REFERENCES UnitPromotions(Type)
);
	
CREATE TABLE IF NOT EXISTS
	Trait_FreeExperience_Domains (
	TraitType		text REFERENCES Traits(Type),
	DomainType		text REFERENCES Domains(Type),
	Experience		integer default 0
);
	
CREATE TABLE IF NOT EXISTS
	Trait_FreeUnitAtTech (
	TraitType		text REFERENCES Traits(Type),
	TechType		text REFERENCES Technologies(Type),
	UnitClassType	text REFERENCES UnitClasses(Type),
	PromotionType	text REFERENCES UnitPromotions(Type)
);
	

	

	

	

	

	
CREATE TABLE IF NOT EXISTS
	Policy_FreePromotionUnitClasses (
	PolicyType		text REFERENCES Policies(Type),
	UnitClass		text REFERENCES UnitClasses(Type),
	PromotionType	text REFERENCES UnitPromotions(Type)
);
	

	

	


	

	

	
CREATE TABLE IF NOT EXISTS
	UnitPromotions_Equivilancy (
	Melee			text,
	Ranged			text,
	Vanguard		text
);
	
CREATE TABLE IF NOT EXISTS
	UnitPromotions_Grid (
	PromotionType	text REFERENCES UnitPromotions(Type),
	UnitCombatType	text REFERENCES UnitCombatInfos(Type),
	Base			boolean default true,
	GridX			integer,
	GridY			integer
);
	

CREATE TABLE IF NOT EXISTS
	Technology_DomainPromotion (
	TechType		text REFERENCES Technologies(Type),
	DomainType		text REFERENCES Domains(Type),
	PromotionType	text REFERENCES UnitPromotions(Type)
);
	

	


*/


--
-- Add Table Columns
--



--ALTER TABLE GameOptions		ADD Reverse								boolean;



--ALTER TABLE Units			ADD BarbUpgradeType						text;
ALTER TABLE UnitCombatInfos	ADD PromotionCategory					text;
--ALTER TABLE UnitCombatInfos	ADD FlavorType							text REFERENCES Flavors(Type) default 'FLAVOR_OFFENSE';

--ALTER TABLE UnitPromotions	ADD IsFirst								boolean;
--ALTER TABLE UnitPromotions	ADD IsAttack							boolean;
--ALTER TABLE UnitPromotions	ADD IsDefense							boolean;
--ALTER TABLE UnitPromotions	ADD IsRanged							boolean;
--ALTER TABLE UnitPromotions	ADD IsMelee								boolean;
--ALTER TABLE UnitPromotions	ADD IsHeal								boolean;
--ALTER TABLE UnitPromotions	ADD IsMove								boolean;
--ALTER TABLE UnitPromotions	ADD IsOther								boolean;
ALTER TABLE UnitPromotions	ADD SimpleHelpText						boolean;
--ALTER TABLE UnitPromotions	ADD FullMovesAfterAttack				boolean;
ALTER TABLE UnitPromotions	ADD IsVisibleAboveFlag					boolean;
--ALTER TABLE UnitPromotions	ADD GoldenPoints						integer default 0;
ALTER TABLE UnitPromotions	ADD RankList							text;
ALTER TABLE UnitPromotions	ADD RankNumber							integer default 0;
ALTER TABLE UnitPromotions	ADD Class								text default 'PROMOTION_CLASS_PERSISTANT';








ALTER TABLE Units			ADD ListPriority integer default -1;





--
-- Done
--
UPDATE LoadedFile SET Value=1 WHERE Type='MT_AlterTables.sql';