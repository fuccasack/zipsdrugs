local ox_target = exports.ox_target
local ox_inventory = exports.ox_inventory
local Labs = ConfigLabs

----- Draw 3D Text Function
function createCoords(x, y, z)
    return vector3(x, y, z)
end

function createMarker(coords, rgba)
    local newCoords = coords - vector3(0.0, 0.0, 1.0)
    if not rgba then rgba = {r = 255, g = 240, b = 0, a = 200} end
    local checkPoint = CreateCheckpoint(45, newCoords, newCoords, 0.3, rgba.r, rgba.g, rgba.b, rgba.a, 0)
    SetCheckpointCylinderHeight(checkPoint, 0.3, 0.3, 0.3)
    
    return checkPoint
end


function DisplayText(location, text, duration)
    Citizen.CreateThread(function()
        local displayTime = 0
        while displayTime < duration do
            local onScreen, x, y = World3dToScreen2d(location.x, location.y, location.z + 1.0)
            if onScreen then
                SetTextScale(scale, scale)
                SetTextFont(font)
                SetTextColour(255, 255, 255, 255)
                SetTextOutline()
                SetTextCentre(true)

                BeginTextCommandDisplayText("STRING")
                AddTextComponentSubstringPlayerName(text)
                EndTextCommandDisplayText(x, y)

                displayTime = displayTime + 100
            end
            Citizen.Wait(0)
        end
    end)
end

function createAndShowCustomMarker(markerLocation, markerType)
    local marker = nil

    function CreateAndShowCustomMarker(markerType, location)
        local marker = nil
        if IsResourceStarted("zips-markers") then
            marker = CreateMarker(markerType, location.x, location.y, location.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 0, 155, 255, 200, false, false, 2, false, nil, nil, false)
            SetMarkerDisplay(drugsharvestmarker, 1)
        else
            print("Error: zips-markers resource is not loaded.")
        end
        return marker
    end
    
    function DisplayText(location, text, duration)
        Citizen.CreateThread(function()
            local displayTime = 0
            while displayTime < duration do
                local onScreen, x, y = World3dToScreen2d(location, 0.0, 0.0, 0.0)
                if onScreen then
                    SetTextScale(scale, scale)
                    SetTextFont(font)
                    SetTextColour(255, 255, 255, 255)
                    SetTextCentre(true)
                    SetTextDropshadow(2, 2, 0, 0, 0)
                    SetTextOutline()
                    BeginTextCommandDisplayText("STRING")
                    AddTextComponentSubstringPlayerName(text)
                    EndTextCommandDisplayText(x, y)
                end
                displayTime = displayTime + 50
                Citizen.Wait(0)
            end
        end)
    end
end
-- define the ox target function
local function ox_target(netIds, options)
    local items = {
        {name = 'oxygen_tank', label = 'Oxygen Tank'},
        {name = 'oxygen_mask', label = 'Oxygen Mask'},
        {name = 'codeine', label = 'Codeine'},
        {name = 'ice', label = 'Ice'},
        {name = 'sprite', label = 'Sprite'},
        {name = 'cocaleaves', label = 'Cocaleaves'},
        {name = 'gasoline', label = 'Gasoline'},
        {name = 'solvent', label = 'Solvent'},
        {name = 'carbon', label = 'Carbon'},
        {name = 'hydrogen', label = 'Hydrogen'},
        {name = 'nitrogen', label = 'Nitrogen'},
        {name = 'oxygen', label = 'Oxygen'},
        {name = 'jollyranchers', label = 'Jolly Ranchers'},
        {name = 'red sulfur', label = 'Red Sulfur'},
        {name = 'liquid sulfur', label = 'Liquid Sulfur'},
        {name = 'muriatic acid', label = 'Muriatic Acid'},
        {name = 'ammonium nitrate', label = 'Ammonium Nitrate'},
        {name = 'sodium hydroxide', label = 'Sodium Hydroxide'},
        {name = 'pseudoefedrine', label = 'Pseudoefedrine'}
    }
    for _, item in ipairs(items) do
        local count = exports.ox_inventory:getQuantity(item.name)
        if count == 0 then
            TriggerEvent('chat:addMessage', {args = {'^1You need a ' .. item.label .. ' to make drugs!'}})
            return false
        end
    end
    exports.ox_target:addEntity(netIds, options)
    return true
end

function CanSellToPed(ped)
    if not DoesEntityExist(ped) then
        return false
    end
    
    if IsPedDeadOrDying(ped, true) or IsPedInAnyVehicle(ped, true) then
        return false
    end
    
    if IsPedAPlayer(ped) then
        return false
    end
    
    -- Add more conditions here if necessary
    
    return true
end
    