local weaponNames = {}
local totalGunsAdded = 0
local totalGunsFailed = 0

function LoadWeaponNames()
    local startTime = os.clock()
    lib.print.debug("Loading ox_inventory/data/weapons.lua...")
    print("Loading ox_inventory/data/weapons.lua...")
    local weaponsFilePath = "data/weapons.lua"
    local weaponsFile = LoadResourceFile("ox_inventory", weaponsFilePath)
    if weaponsFile then
        local chunk = load(weaponsFile)
        if chunk then
            local success, weaponsData = pcall(chunk)
            if success and weaponsData and weaponsData.Weapons then
                for spawnCode, weaponData in pairs(weaponsData.Weapons) do
                    local displayName = weaponData.label
                    weaponNames[GetHashKey(spawnCode)] = displayName
                    totalGunsAdded = totalGunsAdded + 1
                end
                lib.print.debug("Loaded " .. totalGunsAdded .. " guns from weapons.lua.")
                print("Loaded " .. totalGunsAdded .. " guns from weapons.lua.")
            else
                lib.print.error("Error: Invalid weapons.lua format or missing 'Weapons' table.")
                print("Error: Invalid weapons.lua format or missing 'Weapons' table.")
                totalGunsFailed = totalGunsFailed + 1
            end
        else
            lib.print.error("Error: Failed to load weapons.lua.")
            print("Error: Failed to load weapons.lua.")
            totalGunsFailed = totalGunsFailed + 1
        end
    else
        lib.print.error("Error: Failed to read weapons.lua.")
        print("Error: Failed to read weapons.lua.")
        totalGunsFailed = totalGunsFailed + 1
    end
    lib.print.debug("Total guns added: " .. totalGunsAdded)
    lib.print.debug("Total guns failed to load: " .. totalGunsFailed)
    print("Total guns added: " .. totalGunsAdded)
    print("Total guns failed to load: " .. totalGunsFailed)
    local endTime = os.clock()
    local runtime = endTime - startTime
    lib.print.verbose("LoadWeaponNames function runtime: " .. runtime .. " seconds")
    print("LoadWeaponNames function runtime: " .. runtime .. " seconds")
end

AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        LoadWeaponNames()
    end
end)

function GetWeaponName(hash)
    return weaponNames[hash] or "Unknown Weapon"
end

lib.callback.register('one-codes:getplayernames:getdata', function(source, data)
    return "Tave nupiso ID:"..data.killerServerId.." STEAM:"..GetPlayerName(data.killerServerId).." | nuo "..data.distance.."m su "..GetWeaponName(data.deathCause)..""
end)
