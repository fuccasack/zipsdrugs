ox_target = exports.es_extended:getSharedObject("ox_target")

local options = {
    {
        name = 'ox:option1',
        event = 'ox_target:debug',
        icon = 'fa-solid fa-road',
        label = 'Option 1',
    },
    {
        name = 'ox:option2',
        event = 'ox_target:debug',
        icon = 'fa-solid fa-road',
        label = 'Option 2',
        canInteract = function(entity, distance, coords, name, bone)
            return not IsEntityDead(entity)
        end
    }
}


local models = { `prop_atm_01`, `prop_atm_02` }
local optionsNames = { 'ox:option1', 'ox:option2' }
local ox_target = exports.ox_target
local ox_inventory = exports.ox_inventory
local Labs = Config.Labs
local itemNames = {}
local targetCoords = nil



for item, data in pairs(exports.ox_inventory:Items()) do
    itemNames[item] = data.label
end
-- assign value to v
local v = {
    coordharvest = { x = 1, y = 2, z = 3 },
    timeharvest = 10,
    harvestqty = 5,
    item = "drugitem",
    itemlabel = "drugitemlabel",
    target = "drugharvesttarget"
}

function coords(x, y, z)
    return vector3(x, y, z)
end

-- Define the marker and drug harvest locations
local drugsharvestlocation = vector3(v.coordharvest.x, v.coordharvest.y, v.coordharvest.z)
local drugsharvesttime = v.timeharvest
local drugharvestqty = v.harvestqty
local drugitem = v.item
local drugitemlabel = v.itemlabel
local drugharvesttarget = v.target
local isHarvesting = false

function CreateMarker(coords, rgba)
    coords = coords.xyz - vector3(0.0, 0.0, 1.0)
    if not rgba then rgba = {r = 255, g = 240, b = 0, a = 200} end
    local checkPoint = CreateCheckpoint(45, coords, coords, 0.3, rgba.r, rgba.g, rgba.b, rgba.a, 0)
    SetCheckpointCylinderHeight(checkPoint, 0.3, 0.3, 0.3)
    
    return checkPoint
end


-- Create the custom markers and display them
local marker = CreateMarker(coords(0,0,0), {r = 255, g = 0, b = 0, a = 200})
local drugsharvestlocation = vector3(v.coordharvest.x, v.coordharvest.y, v.coordharvest.z)
local drugsharvestmarker = CreateMarker(drugsharvestlocation, {r = 255, g = 240, b = 0, a = 200})

-- Check if the markers were created successfully
if marker and drugsharvestmarker then
    print("Markers created successfully")
else
    print("Error creating markers")
end

-- Define the 3D text properties
local text = "Sample Text"
local scale = 1.0
local font = 0
local duration = 5000
local textLocation = vector3(0.0, 0.0, 0.0)
local Draw3DText = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local scale = (1/dist)*2
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov
	if onScreen then
		SetTextScale(0.0*scale, 0.55*scale)
		SetTextFont(font)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0125, 0.01+ factor, 0.03, 0, 0, 0, 80)
	end
end
function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = #(vector3(px, py, pz) - vector3(x, y, z))

    if onScreen then
        local scale = (1 / dist) * 2
        local fov = (1 / GetGameplayCamFov()) * 100
        local scale = scale * fov

        SetTextScale(0.0, 0.35 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)

        -- Set the draw origin to the specified position
        SetDrawOrigin(x, y, z, 0)

        DrawText(0.0, 0.0)
        ClearDrawOrigin()
    end
end


function DisplayText(pos, text, duration)
    Citizen.CreateThread(function()
        local displaytime = GetGameTimer() + duration
        while GetGameTimer() <= displaytime do
            Draw3DText(pos.x, pos.y, pos.z, text)
            Citizen.Wait(0)
        end
    end)
end


-- Display the 3D text on the drug harvest location
DisplayText(drugsharvestlocation, drugitemlabel, 5000)

-- Define the drug harvesting function
function HarvestDrug()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local dist = #(playerCoords - drugsharvestlocation)
	-- Check if player is within the harvesting location
	if dist <= 1.5 then
		if not isHarvesting then
			isHarvesting = true
	
			-- Start the drug harvesting animation
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
	
			-- Play the harvesting sound
			PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	
			-- Wait for the specified time
			Citizen.Wait(drugsharvesttime * 1000)
	
			-- Stop the drug harvesting animation
			ClearPedTasks(playerPed)
	
			-- Add the harvested drug to the player's inventory
			ox_inventory:addItem(drugitem, drugharvestqty)
	
			-- Show a notification that the drug was harvested
			ox_target:Notification("You harvested " .. drugharvestqty .. " " .. drugitemlabel)
	
			-- Set isHarvesting back to false
			isHarvesting = false
		else
			ox_target:Notification("You are already harvesting")
		end
	else
		ox_target:Notification("You are not in the harvesting location")
	end
end

	
	-- Define the function that is called when the player enters the drug harvest location
	function EnterHarvestLocation()
	DisplayText(drugsharvestlocation, drugitemlabel, 5000)
	end
	
	-- Define the function that is called when the player exits the drug harvest location
	function ExitHarvestLocation()
	ClearPrints()
	end
	
	-- Create the blips for the drug harvest location
	Citizen.CreateThread(function()
	local drugHarvestBlip = AddBlipForCoord(drugsharvestlocation)
	SetBlipSprite(drugHarvestBlip, Config.Blips.drugHarvestSprite)
	SetBlipDisplay(drugHarvestBlip, 4)
	SetBlipScale(drugHarvestBlip, Config.Blips.drugHarvestScale)
	SetBlipColour(drugHarvestBlip, Config.Blips.drugHarvestColor)
	SetBlipAsShortRange(drugHarvestBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Drug Harvest")
	EndTextCommandSetBlipName(drugHarvestBlip)
	while true do
		Citizen.Wait(0)
	
		-- Get the player's current position
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
	
		-- Check if the player is inside the drug harvest location
		if #(playerCoords - drugsharvestlocation) <= Config.Blips.drugHarvestRadius then
			-- Display the text when the player enters the location
			EnterHarvestLocation()
	
			-- Check if the player has pressed the interaction button
			if IsControlJustPressed(0, Config.InteractionButton) then
				-- Harvest the drug
				HarvestDrug()
			end
		else
			-- Remove the text when the player leaves the location
	RemoveHarvestText()
		end
	end
end)
	
	function EnterHarvestLocation()
	if not isHarvesting then
	isHarvesting = true
	-- Display the text to enter the harvest location
	DisplayText(drugsharvestlocation, "Press INPUT_CONTEXT to harvest the drugs", duration)
	end
end

	function RemoveHarvestText()
	if isHarvesting then
	isHarvesting = false
	-- Remove the text
	RemoveBlip(drugsharvestmarker)
	end
end

	
function HarvestDrug()
	-- Check if the player has the required item in their inventory
	if ox_inventory:Items(drugitem, drugharvestqty) then
		-- Remove the required item from the player's inventory
		ox_inventory:Items(drugitem, drugharvestqty)
		
		-- Add the harvested item to the player's inventory
		ox_inventory:Items(drugitem, drugharvestqty)
	
		-- Notify the player that they have successfully harvested the drug
		TriggerEvent("chat:addMessage", {
			color = {255, 0, 0},
			multiline = true,
			args = {"Drug Harvesting", "You have successfully harvested the drug!"}
		})
	
		-- Create the drug item at the player's current target location
		local targetCoords = ox_target:GetTargetCoords("player")
		CreateObject(drugitem, targetCoords.x, targetCoords.y, targetCoords.z, true, false, false)
	
		-- Remove the drug harvest marker
		RemoveBlip(drugsharvestmarker)
	else

		-- Notify the player that they do not have the required item in their inventory
		TriggerEvent("chat:addMessage", {
			color = {255, 0, 0},
			multiline = true,
			args = {"Drug Harvesting", "You do not have the required item in your inventory!"}
		})
	end
end
	
function CreateObject(modelHash, x, y, z, isNetwork, thisScriptCheck, dynamic)
	local model = GetHashKey(modelHash)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end
	
	local object = CreateObject(model, x, y, z, isNetwork, thisScriptCheck, dynamic)
	SetModelAsNoLongerNeeded(model)
	
	return object
end

	

ESX = exports['es_extended']:getSharedObject()
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('zips-drugs:outlawNotify')
AddEventHandler('zips-drugs:outlawNotify', function(alert)
	if isPlayerWhitelisted then
		TriggerEvent('chat:addMessage', { args = { "^5 Dispatch: " .. alert }})
	end
end)

function refreshPlayerWhitelisted()	
	if not ESX.PlayerData then
		return false
	end

	if not ESX.PlayerData.job then
		return false
	end

	if Config.PoliceDatabaseName == ESX.PlayerData.job.name then
		return true
	end

	return false
end

-- Convert Item Event:
RegisterNetEvent("zips-drugs:ConvertProcess")
AddEventHandler("zips-drugs:ConvertProcess", function(k,v)
	
	local animDict = "misscarsteal1car_1_ext_leadin"
	local animName = "base_driver2"
	
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
	
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		TaskPlayAnim(GetPlayerPed(-1),"misscarsteal1car_1_ext_leadin","base_driver2",8.0, -8, -1, 49, 0, 0, 0, 0)
		FreezeEntityPosition(GetPlayerPed(-1), true)
		exports['progressBars']:startUI(v.ConversionTime, v.ProgressBarText)
		Citizen.Wait(v.ConversionTime)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		ClearPedTasks(GetPlayerPed(-1))
	else
		exports['progressBars']:startUI(v.ConversionTime, v.ProgressBarText)
		Citizen.Wait(v.ConversionTime)
	end
end)

RequestAnimDict("mp_common")
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
		local playerPos = GetEntityCoords(player, 0)
		local handle, ped = FindFirstPed()
		local success
		repeat
			success, ped = FindNextPed(handle)
			local pos = GetEntityCoords(ped)
			local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerPos.x, playerPos.y, playerPos.z, true)

			if distance < 2 and CanSellToPed(ped) and canSellDrugs and not IsPedInAnyVehicle(player, true) then
				if Config.Enable3DTextToSell then
					DrawText3Ds(pos.x, pos.y, pos.z, "Press ~g~[H]~s~ to offer ~y~drugs~s~")
				else
					ESX.ShowHelpNotification("Press ~g~ ~INPUT_VEH_HEADLIGHT~ ~s~ to offer ~r~drugs~s~")
				end
				if IsControlJustPressed(1,74) then
					oldped = ped
					TaskStandStill(ped,5000.0)
					SetEntityAsMissionEntity(ped)
					FreezeEntityPosition(ped,true)
					FreezeEntityPosition(player,true)
					SetEntityHeading(ped,GetHeadingFromVector_2d(pos.x-playerPos.x,pos.y-playerPos.y)+180)
					SetEntityHeading(player,GetHeadingFromVector_2d(pos.x-playerPos.x,pos.y-playerPos.y))

					local chance = math.random(1,3)
					exports['progressBars']:startUI((Config.SellDrugsTime * 1000), Config.SellDrugsBarText)
					Citizen.Wait((Config.SellDrugsTime * 1000))
					if chance == 1 or chance == 2 then
						TaskPlayAnim(player, "mp_common", "givetake2_a", 8.0, 8.0, 2000, 0, 1, 0,0,0)
						TaskPlayAnim(ped, "mp_common", "givetake2_a", 8.0, 8.0, 2000, 0, 1, 0,0,0)
						TriggerServerEvent("zips-drugs:sellDrugs")
					else
						chance = math.random(1,Config.CallPoliceChance)
						if chance == 1 then
							if Config.PoliceNotfiyEnabled == true then
								TriggerServerEvent('zips-drugs:DrugSaleInProgress',GetEntityCoords(PlayerPedId()),streetName)
							end
							ESX.ShowNotification("Your offer was ~r~rejected~s~ and ~b~Police~s~ is notified")
						else
							ESX.ShowNotification("Your offer was ~r~rejected~s~")	
						end
					end
				end
			end
		until not success
		EndFindPed(handle)
	end
end)
				
-- function startDrugHarvest()
function startDrugHarvest()
    isHarvesting = true
    TriggerEvent('zips-items:client:busy', drugharvesttarget, true)
    RequestAnimDict('anim@amb@business@weed@weed_inspecting_low_intensity')
    while not HasAnimDictLoaded('anim@amb@business@weed@weed_inspecting_low_intensity') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'anim@amb@business@weed@weed_inspecting_low_intensity', 'weed_inspecting_low_intensity_idle_b', 8.0, -8.0, drugsharvesttime, 1, 0, false, false, false)
    Citizen.CreateThread(function()
        Citizen.Wait(drugsharvesttime)
        isHarvesting = false
        TriggerEvent('zips-items:client:busy', drugharvesttarget, false)
        ox_inventory.addItem(drugitem, drugharvestqty)
        exports['mythic_notify']:DoHudText('success', 'You have harvested ' .. drugharvestqty .. ' ' .. drugitemlabel)
        exports["zips-markers"]:deleteCustomMarker(drugsharvestmarker)
    end)
end


-- define the crafting recipes
local drugscraftrecipes = {
    {itemfinal = 'drug_lean', itemfinallabel = 'Lean', qtyfinal = 6, item1 = 'codeine', item2 = 'ice', item3 = 'drink_sprunk', qty1 = 6, qty2 = 6, qty3 = 6, target = ox_target},
    {itemfinal = 'coke1g', itemfinallabel = 'Cocaine', qtyfinal = 6, item1 = 'cocaleaves', item2 = 'gasoline', item3 = 'solvent', qty1 = 6, qty2 = 6, qty3 = 6, target = ox_target},
    {itemfinal = 'drug_lsd', itemfinallabel = 'LSD', qtyfinal = 6, item1 = 'carbon', item2 = 'hydrogen', item3 = 'oxygen', qty1 = 6, qty2 = 6, qty3 = 6, qty4 = 6, target = ox_target},
    {itemfinal = 'drug_ecstasy', itemfinallabel = 'Ecstasy', qtyfinal = 6, item1 = 'carbon', item2 = 'hydrogen', item3 = 'oxygen', item4 = 'nitrogen', item5 = 'jolly_ranchers', item6 = 'red_sulfur', qty1 = 6, qty2 = 6, qty3 = 6, qty4 = 6, qty5 = 6, qty6 = 6, target = ox_target},
    {itemfinal = 'drug_meth', itemfinallabel = 'Methamphetamine', qtyfinal = 6, item1 = 'pseudoefedrine', item2 = 'red_sulfur', item3 = 'liquid_sulfur', qty1 = 6, qty2 = 6, qty3 = 6, target = ox_target},
    {itemfinal = 'drug_amphetamine', itemfinallabel = 'Amphetamine', qtyfinal = 6, item1 = 'carbon', item2 = 'hydrogen', item3 = 'nitrogen', item4 = 'ammonium_nitrate', item5 = 'sodium_hydroxide', qty1 = 6, qty2 = 6, qty3 = 6, qty4 = 6, qty5 = 6, target = ox_target}
}

-- loop through the drugscraftrecipes table and register the crafting event for each recipe
for _, recipe in ipairs(drugscraftrecipes) do
    RegisterNetEvent('craft:' .. recipe.itemfinal)
    AddEventHandler('craft:' .. recipe.itemfinal, function()
        if recipe.target() then
            ox_inventory.removeItem(recipe.item1, recipe.qty1)
            ox_inventory.removeItem(recipe.item2, recipe.qty2)
            ox_inventory.removeItem(recipe.item3, recipe.qty3)
            if recipe.item4 and recipe.qty4 then
                ox_inventory.removeItem(recipe.item4, recipe.qty4)
            end
            if recipe.item5 and recipe.qty5 then
                ox_inventory.removeItem(recipe.item5, recipe.qty5)
            end
            if recipe.item6 and recipe.qty6 then
                ox_inventory.removeItem(recipe.item6, recipe.qty6)
            end
            TriggerServerEvent('ox_drugs:craftDrug', recipe.itemfinal, recipe.qtyfinal)
            TriggerEvent('ox_inventory:refreshInventory')
            TriggerEvent('ox_notify:displayNotification', 'You crafted ' .. recipe.qtyfinal.. ' ' .. recipe.itemfinallabel, 'centerRight', 3000, 'success')
		else
		TriggerEvent('ox_notify:displayNotification', 'You need to be near a stove to craft this item', 'centerRight', 3000, 'error')
		end 
	end)
end
-- create a function to check if the player is near the stove
function ox_target()
	local playerPed = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(playerPed, false)
	local stoveObject = GetClosestObjectOfType(playerCoords, 3.0, GetHashKey('prop_stove_01'), false, false, false)
	if DoesEntityExist(stoveObject) then
	local stoveCoords = GetEntityCoords(stoveObject, false)
	local distance = Vdist(playerCoords, stoveCoords)
	if distance < 3.0 then
	return true
	end
	end
	return false
end

-- create a function to open the crafting menu
function OpenCraftingMenu()
	local elements = {}
	for _, recipe in ipairs(drugscraftrecipes) do
	table.insert(elements, {label = 'Craft ' .. recipe.itemfinallabel, value = recipe.itemfinal})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'crafting_menu', {
	title = 'Crafting Menu',
	align = 'center',
	elements = elements
	}, function(data, menu)
	menu.close()
	TriggerEvent('craft:' .. data.current.value)
	end, function(data, menu)
	menu.close()
	end)
end
-- Listen for player proximity to the harvest location and start the harvest process when close enough
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local dist = #(vector3(playerCoords.x, playerCoords.y, playerCoords.z) - vector3(drugsharvestlocation.x, drugsharvestlocation.y, drugsharvestlocation.z))
        if not isHarvesting and dist < 2.0 then
            DrawMarker(2, drugsharvestlocation.x, drugsharvestlocation.y, drugsharvestlocation.z + 0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 0.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
            if dist < 0.5 then
                TriggerEvent('chat:addMessage', {args = {'^2Press E to harvest ' .. drugitemlabel}})
                if IsControlJustPressed(0, 38) then
                startDrugHarvest()
				end
			end
		end
	end
end)

    -- Thread for Police Notify
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		streetName,_ = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
		streetName = GetStreetNameFromHashKey(streetName)
	end
end)

RegisterNetEvent('zips-drugs:OutlawBlipEvent')
AddEventHandler('zips-drugs:OutlawBlipEvent', function(targetCoords)
	if isPlayerWhitelisted and Config.PoliceBlipShow then
		local alpha = Config.PoliceBlipAlpha
		local policeNotifyBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.PoliceBlipRadius)

		SetBlipHighDetail(policeNotifyBlip, true)
		SetBlipColour(policeNotifyBlip, Config.PoliceBlipColor)
		SetBlipAlpha(policeNotifyBlip, alpha)
		SetBlipAsShortRange(policeNotifyBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.PoliceBlipTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(policeNotifyBlip, alpha)

			if alpha == 0 then
				RemoveBlip(policeNotifyBlip)
				return
			end
		end
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	StopTheJob = true
	TriggerServerEvent("zips-drugs:syncJobsData",Config.Jobs)
	Citizen.Wait(5000)
	StopTheJob = false
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

RegisterNetEvent("zips-drugs:syncJobsData")
AddEventHandler("zips-drugs:syncJobsData",function(data)
	Config.Jobs = data
end)

    