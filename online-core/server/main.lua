-- online-core entry point
-- Starts each module on resource start.

CreateThread(function()
    if SpawnModule and SpawnModule.Init then
        SpawnModule.Init()
    else
        print('^1[online-core] Failed to start SpawnModule^0')
    end
end)