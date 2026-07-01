local isWaitingToTurnOff = false

CreateThread(function()
    while true do
        Wait(0)

        if IsControlJustPressed(0, 20) then
            if isWaitingToTurnOff then
                isWaitingToTurnOff = false
                SetBigmapActive(false, false)
                RemoveMultiplayerBankCash()
                RemoveMultiplayerWalletCash()
            else
                isWaitingToTurnOff = true
                SetBigmapActive(true, false)
                SetMultiplayerBankCash()
                SetMultiplayerWalletCash()

                CreateThread(function()
                    Wait(4350)

                    if isWaitingToTurnOff then
                        isWaitingToTurnOff = false
                        SetBigmapActive(false, false)
                        RemoveMultiplayerBankCash()
                        RemoveMultiplayerWalletCash()
                    end
                end)
            end
        end
    end
end)