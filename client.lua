local location = nil

-- Locations
Locations = {
	[1] = {
    name = "LSPD", 
    coords = vector3(441.29165, -981.9122, 30.689584), 
    picture="https://cdn.discordapp.com/attachments/892793331854213233/1152959365448466574/LSPD.webp",
    title="Join the LSPD", 
    subtitle="Join LSPD today to make LS safe again!",
    drawtexttitle="Join LSPD",
    drawtextsubtitle="Press [E] to open"
  },
  [2] = {
    name = "BurgerShot", 
    coords = vector3(-1181.188, -882.7281, 13.821201), 
    picture="https://cdn.discordapp.com/attachments/892793331854213233/1152964296452620420/pngaaa.com-503726.png",
    title="Join the Burgershot", 
    subtitle="Join the Burgershot today and make LS citizens happy!",
    drawtexttitle="Join Burgershot",
    drawtextsubtitle="Press [E] to open"
  },
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
  TriggerServerEvent('5e-forms:sendlog', data, location)
  SendNUIMessage({
    type = "ui",
    display = false
  })
  SetNuiFocus(false, false) 
  -- Add your notify here when submit
end)

function openNUI(picture, title, subtitle, drawtexttitle, drawtextsubtitle) 
     SendNUIMessage({
      type = "ui",
      display = true,
      notificationdisplay = true,
      img = picture,
      title = title,
      subtitle = subtitle,
      dttitle = drawtexttitle,
      dtsubtitle = drawtextsubtitle
    })
    SetNuiFocus(true, true) 
end

function showNotification(drawtexttitle, drawtextsubtitle) 
  SendNUIMessage({
    notificationdisplay = true,
    dttitle = drawtexttitle,
    dtsubtitle = drawtextsubtitle
 })
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
                showNotification(v.drawtexttitle, v.drawtextsubtitle)
                if IsControlJustReleased(0, 38) then
                    openNUI(v.picture, v.title, v.subtitle, v.drawtexttitle, v.drawtextsubtitle)
                    location = v.name
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