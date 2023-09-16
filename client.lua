-- Locations
Locations = {
	[1] = {coords = vector3(441.29165, -981.9122, 30.689584)},
}

-- NUI Callback
RegisterNUICallback("exit", function()
  SendNUIMessage({
    type = "ui",
    display = false
  })
  SetNuiFocus(false, false) 
end)

RegisterNUICallback("join", function(data)
  TriggerServerEvent('5e-lspdform:sendlog', data)
  SendNUIMessage({
    type = "ui",
    display = false
  })
  SetNuiFocus(false, false) 
  -- Add your notify here when submit
end)

function openNUI() 
     SendNUIMessage({
      type = "ui",
      display = true,
      notificationdisplay = true
    })
    SetNuiFocus(true, true) 
end

-- Thread
CreateThread(function()
  local alreadyEnteredZone = false
    while true do
        wait = 5
        local ped = PlayerPedId()
        local inZone = false
        for k, v in pairs(Locations) do
            local dist = #(GetEntityCoords(ped)-vector3(v.coords.x,v.coords.y,v.coords.z))
            if dist <= 5.0 then
                wait = 5
                inZone  = true
                if IsControlJustReleased(0, 38) then
                    openNUI()
                end
                break
            else
                wait = 2000
            end
        end
        
        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            SendNUIMessage({
              notificationdisplay = true
            })
        end

        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            SendNUIMessage({
              notificationdisplay = false
            })
        end
        Citizen.Wait(wait)
    end
end)