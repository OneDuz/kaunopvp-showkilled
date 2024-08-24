RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    local killer = data.killerServerId
    local victim = GetPlayerServerId(PlayerId())
    if data.killedByPlayer == false then killer = victim end
    if victim and killer then
        if data.killedByPlayer then
            lib.callback('one-codes:getplayernames:getdata', source, function(msg)
                lib.showTextUI(msg, {position = "top-center"})
            end, data)
        else
            lib.showTextUI("how?", {position = "top-center"})
        end
    end
end)

AddEventHandler('playerSpawned', function(spawn)
    local isOpen = lib.isTextUIOpen()
    if isOpen then
        lib.hideTextUI()
    end
end)