local isOpen = false
local closeAt = 0
local AUTO_CLOSE_MS = 4350

local function openMenu()
    isOpen = true
    closeAt = GetGameTimer() + AUTO_CLOSE_MS
    SetBigmapActive(true, false)
    SetMultiplayerBankCash()
    SetMultiplayerWalletCash()
end

local function closeMenu()
    isOpen = false
    SetBigmapActive(false, false)
    RemoveMultiplayerBankCash()
    RemoveMultiplayerWalletCash()
end

CreateThread(function()
    while true do
        Wait(0)

        if IsControlJustPressed(0, 20) then
            if isOpen then
                closeMenu()
            else
                openMenu()
            end
        elseif isOpen and GetGameTimer() >= closeAt then
            closeMenu()
        end
    end
end)