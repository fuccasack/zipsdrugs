Config = {}
ESX = nil
Config.Locale = 'en'
Config.Framework = 'ESX' -- ESX or QBCore
Config.MySQL = 'oxmysql' -- oxmysql or mysql-async

-- ox_target is the name of the target in the database, you can change it to whatever you want
Config.ox_target = true


-- Police Settings:
Config.PoliceDatabaseName = "police"	-- set the exact name from your jobs database for police
Config.PoliceNotfiyEnabled = true		-- police notification upon truck robbery enabled (true) or disabled (false)
Config.PoliceBlipShow = true			-- enable or disable blip on map on police notify
Config.PoliceBlipTime = 30				-- miliseconds that blip is active on map (this value is multiplied with 4 in the script)
Config.PoliceBlipRadius = 50.0			-- set radius of the police notify blip
Config.PoliceBlipAlpha = 250			-- set alpha of the blip
Config.PoliceBlipColor = 5				-- set blip color

-- Crafting Settings:
Config.CraftingEnabled = true			-- enable or disable crafting
Config.CraftingTime = 30000				-- miliseconds for crafting
Config.CraftingLocation = Config.Labs	-- set location for crafting 
-- Harvest Settings:
Config = {}

Config.Blips = {
    drugHarvestSprite = 1,  -- The sprite ID for the drug harvest blip
    drugHarvestScale = 0.8, -- The scale of the drug harvest blip
    drugHarvestColor = 47,  -- The color of the drug harvest blip
    drugHarvestRadius = 100 -- The radius around the drug harvest location where the blip is displayed and the player can interact with it
}

Config.InteractionButton = 38 -- The control button ID for the interaction button (in this example, "E")


-- The rest of your code

-- Lab Settings:
Config.LabEnabled = true				-- enable or disable lab

Config.Labs = {
    {x = -1960.61, y = -244.45, z = 34.99, h = 234.19, r = 1.0},
    {x = 1392.5, y = 3604.5, z = 38.9, h = 0.0, r = 1.0},
    {x = 1392.5, y = 3604.5, z = 38.9, h = 0.0, r = 1.0},
    {x = 1392.5, y = 3604.5, z = 38.9, h = 0.0, r = 1.0},
    {x = 1392.5, y = 3604.5, z = 38.9, h = 0.0, r = 1.0},
    {x = 1392.5, y = 3604.5, z = 38.9, h = 0.0, r = 1.0},
    {x = 1392.5, y = 3604.5, z = 38.9, h = 0.0, r = 1.0},
    {x = 1392.5, y = 3604.5, z = 38.9, h = 0.0, r = 1.0},
    {x = 1392.5, y = 3604.5, z = 38.9, h = 0.0, r = 1.0},
    {x = 1392.5, y = 3604.5, z = 38.9, h = 0.0, r= 1.0}
}
-- Drug Settings:
local drugscraftrecipes = {
    {itemfinal = 'drug_lean', itemfinallabel = 'Lean', qtyfinal = 6, item1 = 'codeine', item2 = 'ice', item3 = 'drink_sprunk', qty1 = 6, qty2 = 6, qty3 = 6, target = ox_target},
    {itemfinal = 'coke1g', itemfinallabel = 'Cocaine', qtyfinal = 6, item1 = 'cocaleaves', item2 = 'gasoline', item3 = 'solvent', qty1 = 6, qty2 = 6, qty3 = 6, target = ox_target},
    {itemfinal = 'drug_lsd', itemfinallabel = 'LSD', qtyfinal = 6, item1 = 'carbon', item2 = 'hydrogen', item3 = 'oxygen', qty1 = 6, qty2 = 6, qty3 = 6, qty4 = 6, target = ox_target},
    {itemfinal = 'drug_ecstasy', itemfinallabel = 'Ecstasy', qtyfinal = 6, item1 = 'carbon', item2 = 'hydrogen', item3 = 'oxygen', item4 = 'nitrogen', item5 = 'jolly_ranchers', item6 = 'red_sulfur', qty1 = 6, qty2 = 6, qty3 = 6, qty4 = 6, qty5 = 6, qty6 = 6, target = ox_target},
    {itemfinal = 'drug_meth', itemfinallabel = 'Methamphetamine', qtyfinal = 6, item1 = 'pseudoefedrine', item2 = 'red_sulfur', item3 = 'liquid_sulfur', qty1 = 6, qty2 = 6, qty3 = 6, target = ox_target},
    {itemfinal = 'drug_amphetamine', itemfinallabel = 'Amphetamine', qtyfinal = 6, item1 = 'carbon', item2 = 'hydrogen', item3 = 'nitrogen', item4 = 'ammonium_nitrate', item5 = 'sodium_hydroxide', qty1 = 6, qty2 = 6, qty3 = 6, qty4 = 6, qty5 = 6, target = ox_target}
}

Config.ListOfRecipes = drugscraftrecipes


Config.ListOfDrugs = {
    {item = 'weed1g', itemlabel = 'Weed', harvestqty = 6, timeharvest = 60000, coordharvest = {x = 325.19, y = 6626.65, z = 28.71, h = 0.00}, target = ox_target},
    {item = 'drug_opium', itemlabel = 'Opium', harvestqty = 6, timeharvest = 60000, coordharvest = {x = -94.01, y = 2893.87, z = 51.58, h = 167.244}, target = ox_target}, 
    {item = 'codeine', itemlabel = 'Codeine', harvestqty = 9, timeharvest = 60000, coordharvest = {x = 157.16, y = 6657.42, z = 31.56, h = 65.196}, target = ox_target}, 
    {item = 'cocaleaves', itemlabel = 'Coca Leaves', harvestqty = 8, timeharvest = 60000, coordharvest = {x = 3680.08, y = 4528.90, z = 24.81, h = 201.259}, target = ox_target}, 
    {item = 'gasoline', itemlabel = 'Gasoline', harvestqty = 8, timeharvest = 60000, coordharvest = {x = 2758.04, y = 1478.64, z = 30.79, h = 0.00}, target = ox_target}, 
    {item = 'solvent', itemlabel = 'Solvent', harvestqty = 8, timeharvest = 60000, coordharvest = {x = 1050.85, y = -2483.52, z = 29.43, h = 351.496}, target = ox_target},
    {item = 'carbon', itemlabel = 'Carbon', harvestqty = 8, timeharvest = 60000, coordharvest = {x = 2632.26, y = 2935.41, z = 40.42, h = 62.362}, target = ox_target},
    {item = 'hydrogen', itemlabel = 'Hydrogen', harvestqty = 8, timeharvest = 60000, coordharvest = {x = 561.26, y = -485.30, z = 24.98, h = 0.00}, target = ox_target},
    {item = 'oxygen', itemlabel = 'Oxygen', harvestqty = 8, timeharvest = 60000, coordharvest = {x = 319.33, y = -560.18, z = 28.74, h = 0.00}, target = ox_target},
    {item = 'nitrogen', itemlabel = 'Nitrogen', harvestqty = 8, timeharvest = 60000, coordharvest = {x = -190.13, y = 6067.82, z = 31.38, h = 104.881}, target = ox_target},
    {item = 'red_sulfur', itemlabel = 'Red Sulfur', harvestqty = 8, timeharvest = 60000, coordharvest = {x = -540.923, y = 202148, z = 47.3, h = 329.67}, target = ox_target}
}

-- Conversion Settings:
Config.DrugConversion = {
	{ 
		UsableItem 				= "cokebrick",					-- item name in database for usable item
		RewardItem 				= "coke10g",					-- item name in database for required item
		RewardAmount 			= {a = 6, b = 10},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
		MaxRewardItemInv		= {e = 44, f = 40},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
		RequiredItem 			= "drugbags",					-- item name in database for required item
		RequiredItemAmount 		= {c = 6, d = 10},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
		HighQualityScale		= true,							-- enable/disable scale feature for the drugType
		hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
		ProgressBarText			= "COKE BRICK > COKE 10G",		-- progress bar text
		ConversionTime			= 5000,							-- set conversion time in MS.
	},
	{ 
		UsableItem 				= "methbrick",					-- item name in database for usable item
		RewardItem 				= "meth10g",					-- item name in database for required item
		RewardAmount 			= {a = 6, b = 10},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
		MaxRewardItemInv		= {e = 44, f = 40},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
		RequiredItem 			= "drugbags",					-- item name in database for required item
		RequiredItemAmount 		= {c = 6, d = 10},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
		HighQualityScale		= true,							-- enable/disable scale feature for the drugType
		hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
		ProgressBarText			= "METH BRICK > METH 10G",		-- progress bar text
		ConversionTime			= 5000,							-- set conversion time in MS.
	},
	{ 
		UsableItem 				= "weedbrick",					-- item name in database for usable item
		RewardItem 				= "weed20g",					-- item name in database for required item
		RewardAmount 			= {a = 8, b = 10},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
		MaxRewardItemInv		= {e = 44, f = 40},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
		RequiredItem 			= "drugbags",					-- item name in database for required item
		RequiredItemAmount 		= {c = 8, d = 10},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
		HighQualityScale		= true,							-- enable/disable scale feature for the drugType
		hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
		ProgressBarText			= "WEED BRICK > WEED 20G",		-- progress bar text
		ConversionTime			= 5000,							-- set conversion time in MS.
	},
	{ 
		UsableItem 				= "coke10g",					-- item name in database for usable item
		RewardItem 				= "coke1g",						-- item name in database for required item
		RewardAmount 			= {a = 6, b = 10},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
		MaxRewardItemInv		= {e = 44, f = 40},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
		RequiredItem 			= "drugbags",					-- item name in database for required item
		RequiredItemAmount 		= {c = 6, d = 10},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
		HighQualityScale		= true,							-- enable/disable scale feature for the drugType
		hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
		ProgressBarText			= "COKE 10G > COKE 1G",			-- progress bar text
		ConversionTime			= 5000,							-- set conversion time in MS.
	},
	{ 
		UsableItem 				= "meth10g",					-- item name in database for usable item
		RewardItem 				= "meth1g",						-- item name in database for required item
		RewardAmount 			= {a = 6, b = 10},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
		MaxRewardItemInv		= {e = 44, f = 40},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
		RequiredItem 			= "drugbags",					-- item name in database for required item
		RequiredItemAmount 		= {c = 6, d = 10},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
		HighQualityScale		= true,							-- enable/disable scale feature for the drugType
		hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
		ProgressBarText			= "METH 10G > METH 1G",			-- progress bar text
		ConversionTime			= 5000,							-- set conversion time in MS.
	},
	{ 
		UsableItem 				= "weed20g",					-- item name in database for usable item
		RewardItem 				= "weed4g",						-- item name in database for required item
		RewardAmount 			= {a = 4, b = 5},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
		MaxRewardItemInv		= {e = 46, f = 45},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
		RequiredItem 			= "drugbags",					-- item name in database for required item
		RequiredItemAmount 		= {c = 4, d = 5},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
		HighQualityScale		= true,							-- enable/disable scale feature for the drugType
		hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
		ProgressBarText			= "WEED 20G > WEED 4G",			-- progress bar text
		ConversionTime			= 5000,							-- set conversion time in MS.
	},
    {
        UsableItem 				= "4gweed",
        RewardItem 				= "weed20g",
        RewardAmount 			= {a = 10, b = 1},
        MaxRewardItemInv		= {e = 44, f = 40},
        RequiredItem 			= "drugbags",
        RequiredItemAmount 		= {c = 10, d = 1},
        HighQualityScale		= true,
        hqscale					= "hqscale",
        ProgressBarText			= "WEED 4G > WEED 20G",
        ConversionTime			= 2000,
    },
    { 
        UsableItem 				= "weed20g",					-- item name in database for usable item
        RewardItem 				= "weedbrick",					-- item name in database for required item
        RewardAmount 			= {a = 1, b = 10},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
        MaxRewardItemInv		= {e = 4, f = 40},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
        RequiredItem 			= "drugbags",					-- item name in database for required item
        RequiredItemAmount 		= {c = 6, d = 10},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
        HighQualityScale		= true,							-- enable/disable scale feature for the drugType
        hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
        ProgressBarText			= "WEED 20G > WEED BRICK",		-- progress bar text
        ConversionTime			= 5000,							-- set conversion time in MS.
    },
    { 
        UsableItem 				= "meth10g",
        RewardItem 				= "meth1g",
        RewardAmount 			= {a = 10, b = 1},
        MaxRewardItemInv		= {e = 440, f = 100},
        RequiredItem 			= "drugbags",
        RequiredItemAmount 		= {c = 1, d = 10},
        HighQualityScale		= true,
        hqscale					= "hqscale",
        ProgressBarText			= "METH 10G > METH 1G",
        ConversionTime			= 2000,
    },
    {
        UsableItem 				= "1gmeth",
        RewardItem 				= "10gmeth",
        RewardAmount 			= {a = 10, b = 1},
        MaxRewardItemInv		= {e = 44, f = 40},
        RequiredItem 			= "drugbags",
        RequiredItemAmount 		= {c = 10, d = 1},
        HighQualityScale		= true,
        hqscale					= "hqscale",
        ProgressBarText			= "METH 1G > METH 10G",
        ConversionTime			= 2000,
    },
    { 
        UsableItem 				= "meth10g",					-- item name in database for usable item
        RewardItem 				= "methbrick",					-- item name in database for required item
        RewardAmount 			= {a = 1, b = 10},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
        MaxRewardItemInv		= {e = 4, f = 40},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
        RequiredItem 			= "drugbags",					-- item name in database for required item
        RequiredItemAmount 		= {c = 6, d = 10},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
        HighQualityScale		= true,							-- enable/disable scale feature for the drugType
        hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
        ProgressBarText			= "METH 10G > METH BRICK",		-- progress bar text
        ConversionTime			= 5000,							-- set conversion time in MS.
    },
    { 
        UsableItem 				= "coke10g",
        RewardItem 				= "coke1g",
        RewardAmount 			= {a = 10, b = 1},
        MaxRewardItemInv		= {e = 440, f = 100},
        RequiredItem 			= "drugbags",
        RequiredItemAmount 		= {c = 1, d = 10},
        HighQualityScale		= true,
        hqscale					= "hqscale",
        ProgressBarText			= "COKE 10G > COKE 1G",
        ConversionTime			= 2000,
    },
    {
        UsableItem 				= "1gcoke",
        RewardItem 				= "10gcoke",
        RewardAmount 			= {a = 10, b = 1},
        MaxRewardItemInv		= {e = 44, f = 40},
        RequiredItem 			= "drugbags",
        RequiredItemAmount 		= {c = 10, d = 1},
        HighQualityScale		= true,
        hqscale					= "hqscale",
        ProgressBarText			= "COKE 1G > COKE 10G",
        ConversionTime			= 2000,
    },
    { 
        UsableItem 				= "coke10g",					-- item name in database for usable item
        RewardItem 				= "cokebrick",					-- item name in database for required item
        RewardAmount 			= {a = 1, b = 10},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
        MaxRewardItemInv		= {e = 4, f = 40},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
        RequiredItem 			= "drugbags",					-- item name in database for required item
        RequiredItemAmount 		= {c = 6, d = 10},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
        HighQualityScale		= true,							-- enable/disable scale feature for the drugType
        hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
        ProgressBarText			= "COKE 10G > COKE BRICK",		-- progress bar text
        ConversionTime			= 5000,							-- set conversion time in MS.
    },
	{ 
		UsableItem 				= "weed4g",						-- item name in database for usable item
		RewardItem 				= "joint2g",					-- item name in database for required item
		RewardAmount 			= 2,							-- Amount of RewardItem player receives
		MaxRewardItemInv		= {e = 44, f = 40},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
		RequiredItem 			= "rolpaper",					-- item name in database for required item
		RequiredItemAmount 		= 2,							-- Amount of RequiredItem for conversion
		HighQualityScale		= false,						-- enable/disable scale feature for the drugType
		hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
		ProgressBarText			= "WEED 4G > JOINT 2G",			-- progress bar text
		ConversionTime			= 5000,							-- set conversion time in MS.
	}
}