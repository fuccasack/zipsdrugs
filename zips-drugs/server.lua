ESX = nil
ESX = exports['es_extended']:getSharedObject()
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Server side table, to store convert timer for players:
RegisterServerEvent("zips-drugs:addConvertingTimer")
AddEventHandler("zip-drugs:addConvertingTimer",function(source,timer)
	table.insert(ConvertTimer,{convertWait = GetPlayerIdentifier(source), timeB = timer})
end)

-- Usable item to convert drugs:
ESX = exports['es_extended']:getSharedObject()
Citizen.CreateThread(function()
	for k,v in pairs(Config.DrugConversion) do 
		ESX.RegisterUsableItem(v.UsableItem, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			local itemLabel = ESX.GetItemLabel(v.UsableItem)
			local drugOutput
			local requiredItems
			
			local scale = xPlayer.getInventoryItem(v.hqscale).count >= 1
			if v.HighQualityScale then
				if scale then
					drugOutput = v.RewardAmount.b
					requiredItems = v.RequiredItemAmount.d
				else
					drugOutput = v.RewardAmount.a
					requiredItems = v.RequiredItemAmount.c
				end
			else
				drugOutput = v.RewardAmount
				requiredItems = v.RequiredItemAmount
			end
				
			local reqItems = xPlayer.getInventoryItem(v.RequiredItem).count >= requiredItems
			if not reqItems then
				local reqItemLabel = ESX.GetItemLabel(v.RequiredItem)
				TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~"..reqItemLabel.."~s~")
				return
			end
			
			if xPlayer.getInventoryItem(v.RewardItem).count <= v.MaxRewardItemInv.f or (not scale and xPlayer.getInventoryItem(v.RewardItem).count <= v.MaxRewardItemInv.e) then
				if not Converting(GetPlayerIdentifier(source)) then
					TriggerEvent("zips-drugs:addConvertingTimer",source,v.ConversionTime)
					xPlayer.removeInventoryItem(v.UsableItem,1)
					xPlayer.removeInventoryItem(v.RequiredItem,requiredItems)
					TriggerClientEvent("zips-drugs:ConvertProcess",source,k,v)
					Citizen.Wait(v.ConversionTime)
					xPlayer.addInventoryItem(v.RewardItem,drugOutput)
				else
					TriggerClientEvent("esx:showNotification",source,string.format("You are ~b~already~s~ converting",GetConvertTime(GetPlayerIdentifier(source))))	
				end	
			else
				TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~b~empty space~s~ for more ~y~"..itemLabel.."~s~")
			end
		end)
	end
end)