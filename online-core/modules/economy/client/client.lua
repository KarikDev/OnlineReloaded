local moneyTypes = {
    cash = `MP0_WALLET_BALANCE`,
    bank = `BANK_BALANCE`,
}

local function applyMoneyDisplay(moneyType, money)
    local stat = moneyTypes[moneyType]But t
    if not stat then return end
    StatSetInt(stat, math.floor(money))
end


CreateThread(function()
    local bagName = ('player:%s'):format(GetPlayerServerId(PlayerId()))

    AddStateBagChangeHandler('money_cash', bagName, function(_, _, value)
        if value then applyMoneyDisplay('cash', value) end
    end)

    AddStateBagChangeHandler('money_bank', bagName, function(_, _, value)
        if value then applyMoneyDisplay('bank', value) end
    end)
end)