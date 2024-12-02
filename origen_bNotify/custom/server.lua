local QBCore = exports['qb-core']:GetCoreObject()
local negociosabiertos = {}

local function CheckAuth(job)
    for k, v in pairs(Config.Jobs) do
        if v.job == job then
            return true, v
        end
    end
    return false
end

local function CheckAbierto(job)
    for k, v in pairs(negociosabiertos) do
        if v.job == job then
            return true
        end
    end
    return false
end

local function GetPlayer(src)
    return QBCore.Functions.GetPlayer(src)
end

RegisterCommand(Config.Commands.Open, function(source)
    local xPlayer = GetPlayer(source)
    local job = xPlayer.PlayerData.job.name
    local puede, info = CheckAuth(job)
    if not puede then
        return TriggerClientEvent("origen_notify:ShowNotification", source, Config.Locales['no_access'], "error")
    end

    for k, v in pairs(negociosabiertos) do
        if v == info then
            return TriggerClientEvent("origen_bNotify:infonegocios", -1, "reopen", info, negociosabiertos)
        end
    end
    table.insert(negociosabiertos, info)
    TriggerClientEvent("origen_bNotify:infonegocios", -1, "open", info, negociosabiertos)
end)

RegisterCommand(Config.Commands.Close, function(source)
    local xPlayer = GetPlayer(source)
    local job = xPlayer.PlayerData.job.name
    local puede, info = CheckAuth(job)
    local abierto = CheckAbierto(job)
    if not puede then
        return TriggerClientEvent("origen_notify:ShowNotification", source, Config.Locales['no_access'], "error")
    end
    if not abierto then
        return TriggerClientEvent("origen_notify:ShowNotification", source, Config.Locales['not_open'], "error")
    end
    for k, v in pairs(negociosabiertos) do
        if v == info then table.remove(negociosabiertos, k) end
    end
    TriggerClientEvent("origen_bNotify:infonegocios", -1, "close", info, negociosabiertos)
end)

lib.callback.register("origen_bNotify:getnegocios", function()
    local value = nil
    if #negociosabiertos == 0 then 
        value = "No hay negocios abiertos" 
    else 
        value = negociosabiertos 
    end
    return value
end)
