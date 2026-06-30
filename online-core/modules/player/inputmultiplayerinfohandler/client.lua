local isWaitingToTurnOff = false

CreateThread(function()
    while true do
        Wait(0)

        if IsControlJustPressed(0, 20) then
            if isWaitingToTurnOff then
                isWaitingToTurnOff = false
                SetBigmapActive(false, false)
            else
                isWaitingToTurnOff = true
                SetBigmapActive(true, false)

                CreateThread(function()
                    Wait(4350)

                    if isWaitingToTurnOff then
                        isWaitingToTurnOff = false
                        SetBigmapActive(false, false)
                    end
                end)
            end
        end
    end
end)