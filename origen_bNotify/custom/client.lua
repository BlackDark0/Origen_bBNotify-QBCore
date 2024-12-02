local abiertos = {}

RegisterNetEvent("origen_bNotify:infonegocios")
AddEventHandler("origen_bNotify:infonegocios", function(action, info, table)
    if GetInvokingResource() then return print("A DONDE VAS CAMPEÓN?, ESTO ESTA PROTEGIDISIMO ILLO") end
    local message = nil
    if action == "open" then 
        message = info.label .. Config.Locales['just_opened']
    elseif action == "close" then
        message = info.label .. Config.Locales['just_closed']
    elseif action == "reopen" then
        message = info.label .. Config.Locales['just_reopened']
    end
    abiertos = table
    exports["origen_notify"]:ShowNotification(message, "business")
end)

CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do
        Wait(100)
    end
    lib.callback("origen_bNotify:getnegocios", function(tabla)
        abiertos = tabla
    end)
end)
