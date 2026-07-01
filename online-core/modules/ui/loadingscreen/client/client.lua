local loadingDone = false

-- fires once the map/world has actually finished loading
AddEventHandler('onClientMapStart', function()
    loadingDone = true
end)

-- keep HUD component 18 hidden every frame while the loadscreen is up
Citizen.CreateThread(function()
    while not loadingDone do
        HideHudComponentThisFrame(18)
        Citizen.Wait(0)
    end
end)