local basinNames = {
    "create:basin_10",
    "create:basin_17",
    "create:basin_18",
    "create:basin_15",
    "create:basin_16",
    "create:basin_19",
    "create:basin_20",
    "create:basin_9",
    "create:basin_8"
}

local storage = peripheral.wrap("sophisticatedstorage:chest_5")
local packager = peripheral.wrap("Create_Packager_3") 
local currentBasinIndex = 1
local totalBasins = #basinNames


function CharcoalPress()
    while true do
        local items = storage.list()
        local totalMekanismChar = 0
        local slotsBlockChar = {}
        local half_BlockCharMove = 0
        for slot, data in pairs(items) do
            if data.name == "minecraft:charcoal" then
                local basinName = basinNames[currentBasinIndex]
                if basinName then
                        local moved = storage.pushItems(basinName, slot)
                        if moved > 0 then
                            currentBasinIndex = currentBasinIndex + 1
                        
                        if currentBasinIndex > totalBasins then
                            currentBasinIndex = 1
                        end
                    end
                end
            elseif data.name == "mekanism:block_charcoal" then
                slotsBlockChar[#slotsBlockChar+1] = slot
                totalMekanismChar = totalMekanismChar + data.count
            end


            if totalMekanismChar > 0 then
                local mekanism_block = math.floor(totalMekanismChar/2)
            end
        end



-- basins --
        for i, name in ipairs(basinNames) do
            local basin = peripheral.wrap(name)
            if basin then
                local basinItems = basin.list()
                for slot, data in pairs(basinItems) do
                    if data.name == "mekanism:block_charcoal" then
                        local pulled = basin.pushItems("sophisticatedstorage:chest_5", slot)
                    end
                end
            end
        end
        sleep(1)
    end
end

-- Executa a função
CharcoalPress()