local storage = peripheral.wrap("create:item_vault_0")
local storageOak = peripheral.wrap("create:item_vault_2")
local storageAny = peripheral.wrap("create:item_vault_4")

local makeCharcoal = "sophisticatedstorage:chest_1"
local charcoalStorage = peripheral.wrap("sophisticatedstorage:chest_2")

local packagerMadeira = peripheral.wrap("Create_Packager_8")
local packagerCharcoal = peripheral.wrap("Create_Packager_9")
local packagerAny = peripheral.wrap("Create_Packager_10")


function Storages()
    while true do

        local items = storage.list()

        for slot, data in pairs(items) do
            if data.name == "regions_unexplored:redwood_log" then
                storage.pushItems("create:item_vault_2", slot)
            else
                storage.pushItems("create:item_vault_4", slot)
            end
        end

        local anyItems = storageAny.list()

        for slot, data in pairs(anyItems) do
            packagerAny.setAddress("Storage")
            packagerAny.makePackage()
        end

        local logItems = storageOak.list()
        local total_Log = 0
        local slotsLog = {}
        
        
        for slot, data in pairs(logItems) do 
            if data.name == "regions_unexplored:redwood_log" then
                slotsLog[#slotsLog+1] = slot
                total_Log = total_Log + data.count
            end
        end

    local half_LogMove = 0
    if total_Log > 0 then
        local half_Log = math.floor(total_Log / 2)

        for i, slot in ipairs(slotsLog) do
            local item = storageOak.getItemDetail(slot)
            if item then
                local slotCount = item.count
                local movingLog = 0

                if half_LogMove < half_Log then
                    movingLog = math.min(slotCount, half_Log - half_LogMove)
                    if movingLog > 0 then
                        storageOak.pushItems(makeCharcoal, slot, movingLog)
                        half_LogMove = half_LogMove + movingLog
                    end
                end

                local remaningLog = slotCount - movingLog
                if remaningLog > 0 then
                    packagerMadeira.setAddress("Storage")
                    packagerMadeira.makePackage()
                end
            end
        end
    end

        for slot, item in pairs(charcoalStorage.list()) do
            charcoalStorage.pushItems("create:item_vault_3", slot)
            packagerCharcoal.setAddress("CharcoalPress")
            packagerCharcoal.makePackage()
        end
        sleep(1)
    end
end
Storages()