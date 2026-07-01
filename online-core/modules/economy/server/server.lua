local resourceName = GetCurrentResourceName()

local function getPlayerDataExport(name, ...)
    local exportTable = exports[resourceName]

    if not exportTable or type(exportTable[name]) ~= 'function' then
        return nil
    end

    return exportTable[name](...)
end

local function getPlayerDbId(playerIdx)
    if not playerIdx or playerIdx <= 0 then
        return nil
    end

    local player = Player(playerIdx)
    if not player then
        return nil
    end

    local dbId = player.state['cfx.re/playerData@id']
    if dbId == nil then
        dbId = getPlayerDataExport('getPlayerId', playerIdx)
    end

    if dbId == nil then
        return nil
    end

    return tonumber(dbId) or dbId
end

local validMoneyTypes = {
    bank = true,
    cash = true,
}

local function getMoneyForId(playerId, moneyType)
    return GetResourceKvpInt(('money:%s:%s'):format(playerId, moneyType)) / 100.0
end

local function setMoneyForId(playerIdx, moneyType, money)
    local playerId = getPlayerDbId(playerIdx)
    if not playerId then
        return false
    end

    if Player(playerIdx) then
        Player(playerIdx).state['money_' .. moneyType] = money
    end

    return SetResourceKvpInt(('money:%s:%s'):format(playerId, moneyType), math.tointeger(money * 100.0))
end

local function addMoneyForId(playerIdx, moneyType, amount)
    local playerId = getPlayerDbId(playerIdx)
    if not playerId then
        return false, 0
    end

    local curMoney = getMoneyForId(playerId, moneyType)
    curMoney += amount

    if curMoney >= 0 then
        setMoneyForId(playerIdx, moneyType, curMoney)
        return true, curMoney
    end

    return false, 0
end

exports('addMoney', function(playerIdx, moneyType, amount)
    amount = tonumber(amount)

    if not amount or amount <= 0 or amount > (1 << 30) then
        return false
    end

    if not validMoneyTypes[moneyType] then
        return false
    end

    local success, money = addMoneyForId(playerIdx, moneyType, amount)

    if success then
        Player(playerIdx).state['money_' .. moneyType] = money
    end

    return success
end)

exports('removeMoney', function(playerIdx, moneyType, amount)
    amount = tonumber(amount)

    if not amount or amount <= 0 or amount > (1 << 30) then
        return false
    end

    if not validMoneyTypes[moneyType] then
        return false
    end

    local success, money = addMoneyForId(playerIdx, moneyType, -amount)

    if success then
        Player(playerIdx).state['money_' .. moneyType] = money
    end

    return success
end)

exports('getMoney', function(playerIdx, moneyType)
    local playerId = getPlayerDbId(playerIdx)
    return getMoneyForId(playerId, moneyType)
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    local playerId = getPlayerDbId(source)

    for moneyType, _ in pairs(validMoneyTypes) do
        local amount = getMoneyForId(playerId, moneyType)
        Player(source).state['money_' .. moneyType] = amount
    end
end)

local function notify(source, message)
    TriggerClientEvent('chat:addMessage', source, { args = { message } })
end

RegisterCommand('earn', function(source, args)
    local moneyType = args[1]
    local amount = tonumber(args[2])

    if not validMoneyTypes[moneyType] or not amount then
        notify(source, 'Usage: /earn (type) (amount)')
        return
    end

    if not exports[resourceName]:addMoney(source, moneyType, amount) then
        notify(source, 'Usage: /earn (type) (amount)')
    end
end, true)

RegisterCommand('spend', function(source, args)
    local moneyType = args[1]
    local amount = tonumber(args[2])

    if not validMoneyTypes[moneyType] or not amount then
        notify(source, 'Usage: /spend (type) (amount)')
        return
    end

    if not exports[resourceName]:removeMoney(source, moneyType, amount) then
        print('you are broke??')
    end
end, true)