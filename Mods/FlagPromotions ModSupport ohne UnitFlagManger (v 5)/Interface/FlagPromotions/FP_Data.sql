-- Insert SQL Rules Here 

UPDATE UnitPromotions SET IsVisibleAboveFlag = 0;




UPDATE UnitPromotions SET IsVisibleAboveFlag = 1
WHERE Type IN (
	'PROMOTION_ANTI_GUNPOWDER'                  , --shaka
	'PROMOTION_FEARED_ELEPHANT'					, --siam
	'PROMOTION_EXTRA_SIGHT_I'                 ,  --autria
	'PROMOTION_EXTRA_SIGHT_II'                 ,
    'PROMOTION_ATLATL_ATTACK'					,
	'PROMOTION_SKIRMISH' 						, --earned
	'PROMOTION_MORALE' 							, --not on all units
	'PROMOTION_STATUE_ZEUS' 					, --not on all units
	'PROMOTION_MERCENARY' 						, --Germans
	'PROMOTION_DESERT_POWER'					, --barbarians
	'PROMOTION_ARCTIC_POWER'					, --barbarians
	'PROMOTION_HILL_FIGHTER'					, --barbarians
	'PROMOTION_WOODSMAN' 						, --barbarians
	'PROMOTION_BOMBARDMENT_1'					, --
	'PROMOTION_BOMBARDMENT_2'					, --
	'PROMOTION_BOMBARDMENT_3'					, --
	'PROMOTION_BLITZ'							, --
	'PROMOTION_LOGISTICS'						, --
	'PROMOTION_EXTRA_SIGHT_NOUPGRADE_II'		, --China
	'PROMOTION_EXTRA_MOVES_I'					,--
	  'PROMOTION_INTERCEPTION_1'					,-- Added by SERP
    'PROMOTION_INTERCEPTION_2'					,--Added by SERP
    'PROMOTION_INTERCEPTION_3'					,--Added by SERP
    'PROMOTION_INTERCEPTION_4'					,--Added by SERP
    'PROMOTION_CARGO_EXTRA_I'					,--Added by SERP
    'PROMOTION_CARGO_EXTRA_II'					,--Added by SERP
    'PROMOTION_EVASION'				           	 --Added by SERP 
) OR (Class = 'PROMOTION_CLASS_PERSISTANT' AND NOT (
	   Type LIKE '%PENALTY%'
	OR Type LIKE '%NOUPGRADE%'
	OR Type LIKE '%CARGO%'
	OR Type LIKE '%EMBARKATION%' --
	OR Type LIKE '%INTERCEPTION%' --
	OR Type LIKE '%EVASION%' --	
	OR Type IN (	                         -- add those promotions wich should not appear over flag
		
		--CSD
		'PROMOTION_EMISSARY'			,
		'PROMOTION_ENVOY'			,
		'PROMOTION_DIPLOMAT'			,
		'PROMOTION_AMBASSADOR'			,
		'PROMOTION_GREAT_MERCHANT'			,		
		'PROMOTION_GREAT_DIPLOMAT'			,		
--		'PROMOTION_NOBEL_LAUREATE'			,--sweden
		'PROMOTION_SIGNET'			,
		'PROMOTION_EXPRESS'			,
		'PROMOTION_LITERACY'			,
		'PROMOTION_IMMUNITY'			,
		'PROMOTION_PAX'			,
		'PROMOTION_NOBILITY'			,

		
/*
		'PROMOTION_CAN_MOVE_AFTER_ATTACKING'			, 
		
*/	


		'PROMOTION_SELL_EXOTIC_GOODS'	,	--Portugal	
		'PROMOTION_WAR_CANOES'			,--songhai
		'PROMOTION_DOUBLE_PLUNDER'     ,--denmark
		'PROMOTION_MOVEMENT_TO_GENERAL'			, 
		'PROMOTION_GENERAL_STACKING'    ,
		'PROMOTION_SILENT_HUNTER'    ,
		'PROMOTION_ANTI_AIR_II'			, 
		'PROMOTION_ANTI_FIGHTER'    ,
		'PROMOTION_FLAT_MOVEMENT_COST'			, 
		'PROMOTION_ANTI_AIR'			, 
		'PROMOTION_PARADROP'			, 
		'PROMOTION_ENSLAVEMENT'			, --Ramses
		'PROMOTION_GODDY_HUT_PICKER'			, --Shosho
		'PROMOTION_GOLDEN_AGE_POINTS'			, --Braz
		'PROMOTION_GAIN_EXPERIENCE'			, --oda,jap
		'PROMOTION_SPAWN_GENERALS_II'			,
		'PROMOTION_SPAWN_GENERALS_I'			,
		'PROMOTION_AIR_SWEEP'			,
		'PROMOTION_AIR_RECON'			,
		'PROMOTION_CAN_MOVE_IMPASSABLE'			,
		'PROMOTION_INVISIBLE_SUBMARINE'			,
		'PROMOTION_HOVERING_UNIT'			,
		'PROMOTION_WITHDRAW_BEFORE_MELEE'			,
		'PROMOTION_SEE_INVISIBLE_SUBMARINE'			,
		'PROMOTION_ANTI_SUBMARINE_II'			,	
		'PROMOTION_EXTENDED_PARADROP'			,
		'PROMOTION_GREAT_ADMIRAL'			,	
		'PROMOTION_RIVAL_TERRITORY'			,		
		'PROMOTION_UNWELCOME_EVANGELIST'			,		
        'PROMOTION_NAVAL_MISFIRE'               ,--check
		'PROMOTION_FALLOUT_REDUCTION'			,		
		'PROMOTION_FALLOUT_IMMUNITY'			,		
		'PROMOTION_EMBARKED_SIGHT'			,		
		'PROMOTION_ANTI_TANK'			,--	check						
		'PROMOTION_ROUGH_TERRAIN_ENDS_TURN'		, --penalty
		'PROMOTION_ONLY_DEFENSIVE'				, --penalty
		'PROMOTION_NO_DEFENSIVE_BONUSES'		, --penalty
		'PROMOTION_MUST_SET_UP'					, --penalty
		'PROMOTION_CITY_SIEGE'					, --demolish
		'PROMOTION_CITY_ASSAULT'				, --demolish
		'PROMOTION_NEW_UNIT'					, --
		'PROMOTION_DEFENSE_1'					, --
		'PROMOTION_DEFENSE_2'					, --
		'PROMOTION_GREAT_GENERAL'				, --
		'PROMOTION_FREE_UPGRADES'				, --citystates
		--'PROMOTION_ANTI_CAVALRY'				, --Ottomans
		'PROMOTION_MEDIC_GENERAL'				, --Mongolia
--		'PROMOTION_SENTRY'						, --America
--		'PROMOTION_DEFENSIVE_EMBARKATION'		, --Songhai
		'PROMOTION_FREE_PILLAGE_MOVES'			, --Denmark
		'PROMOTION_OCEAN_MOVEMENT'				, --England
		'PROMOTION_OCEAN_IMPASSABLE'			, --Korea
		'PROMOTION_MUSTERED'					,
		'PROMOTION_FAST_ADMIRAL'				,
	    'PROMOTION_FAST_GENERAL'	            ,
        
            -- Serp changes START
        -- hide unlocker promotions from level system
        'PROM_UNLOCK_LVL_2',
        'PROM_UNLOCK_LVL_3',
        'PROM_UNLOCK_LVL_4',
        -- hide promotions from barbarian general
        'PROMOTION_MOVE_THIS',
        'PROMOTION_HORDE_GENERAL',
        -- hide new explorer promotion
        'PROMOTION_XP_FOR_SCOUTING'
        -- Serp changes END
	))
);




