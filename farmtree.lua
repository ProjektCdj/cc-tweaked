local relay_clutch = peripheral.wrap("redstone_relay_1")
local storagePackager = peripheral.wrap("create:item_vault_0")
local makeCharcoal = "sophisticatedstorage:chest_1"
local charcoalStorage = peripheral.wrap("sophisticatedstorage:chest_2")
local packagerMadeira = peripheral.wrap("Create_Packager_5")
local packager_any = peripheral.wrap("Create_Packager_6")
local packagercharcoal = peripheral.wrap("Create_Packager_7")



function Farm()
    while true do
        relay_clutch.setOutput("top", true) print("Going...")
        sleep(30)  print("Waiting.")
        relay_clutch.setOutput("top", false) print("Backing...")
        sleep(30) print("Waiting.")
    end
end

function Storages()
    while true do
        local items = storagePackager.list()
        local total_Log = 0
        local slotsLog = {}
        local half_LogMove = 0

        for slot, data in pairs(items) do
            if data.name == "regions_unexplored:redwood_log" then
                slotsLog[#slotsLog+1] = slot
                total_Log = total_Log + data.count
            elseif data.name == "minecraft:charcoal" then
                packagercharcoal.setAddress("CharcoalPress")
                packagercharcoal.makePackage()
            elseif data.name ~= "minecraft:charcoal" or "regions_unexplored:redwood_log" then
                packager_any.setAddress("Storage")
                packager_any.makePackage()
            end
        end

        if total_Log > 0 then
            local half_Log = math.floor(total_Log / 2)

            if half_Log > 0 then
                for i, slot in ipairs(slotsLog) do
                    if half_LogMove >= half_Log then
                        break -- aqui é seguro, só sai deste for
                    end

                    local item = storagePackager.getItemDetail(slot)
                    if not item then
                        break
                    end

                    local slotCount = item.count
                    local movingLog = math.min(slotCount, half_Log - half_LogMove)
                    local remaningLog = slotCount - movingLog

                    if movingLog > 0 then
                        storagePackager.pushItems(makeCharcoal, slot, movingLog)
                        half_LogMove = half_LogMove + movingLog
                    end

                    if remaningLog > 0 then
                        packagerMadeira.setAddress("Storage")
                        packagerMadeira.makePackage()
                    end
                end
            end
        end

        for slot, item in pairs(charcoalStorage.list()) do
            if item.name == "minecraft:charcoal" then
                charcoalStorage.pushItems("create:item_vault_0", slot)
            end
        end

        sleep(1)
    end
end

parallel.waitForAll(Farm, Storages)