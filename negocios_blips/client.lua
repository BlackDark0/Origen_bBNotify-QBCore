local negociosBlips = {}

local function ActualizarBlips(negocios)
    for _, blip in pairs(negociosBlips) do
        RemoveBlip(blip)
    end
    negociosBlips = {}

    for _, negocio in pairs(Config.Jobs) do
        local abierto = false
        for _, abiertoInfo in pairs(negocios) do
            if negocio.job == abiertoInfo.job then
                abierto = true
                break
            end
        end

        local blip = AddBlipForCoord(negocio.coords.x, negocio.coords.y, negocio.coords.z)
        SetBlipSprite(blip, negocio.blip.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, abierto and negocio.blip.color or 40)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(string.format("%s (%s)", negocio.blip.label, abierto and "Abierto" or "Cerrado"))
        EndTextCommandSetBlipName(blip)

        table.insert(negociosBlips, blip)
    end
end

CreateThread(function()
    TriggerServerEvent("origen_bNotify:syncNegocios")
end)

RegisterNetEvent("origen_bNotify:infonegocios", function(action, _, negocios)
    if action == "sync" or type(negocios) == "table" then
        ActualizarBlips(negocios)
    end
end)
