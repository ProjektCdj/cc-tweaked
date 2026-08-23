local basinNames = {
    "create:basin_42", "create:basin_43", "create:basin_44",
    "create:basin_45", "create:basin_46", "create:basin_47",
    "create:basin_48", "create:basin_49",  "create:basin_50"
}
local storageCopper = peripheral.wrap("functionalstorage:oak_1_0")
local storageZinc = peripheral.wrap("functionalstorage:oak_1_1")
local packager = peripheral.wrap("Create_Packager_11")
local currentBasinIndex = 1
local totalBasins = #basinNames


function Brass()
    while true do
        local copperDust = storageCopper.list()
        local zincDust = storageZinc.list()

            for slot, data in pairs(copperDust) do
                if data.name == "alltheores:copper_dust" then
                    local basinName = basinNames[currentBasinIndex]
                    local moved = storageCopper.pushItems(basinName, slot)
                    if moved and moved > 0 then
                        currentBasinIndex = currentBasinIndex + 1
                        if currentBasinIndex > totalBasins then
                            currentBasinIndex = 1
                        end
                    end
                end
            end

            for slot, data in pairs(zincDust) do
                if data.name == "alltheores:zinc_dust" then
                    local basinName = basinNames[currentBasinIndex]
                    local moved = storageZinc.pushItems(basinName, slot)
                    if moved and moved > 0 then
                        currentBasinIndex = currentBasinIndex + 1
                        if currentBasinIndex > totalBasins then
                            currentBasinIndex = 1
                        end
                    end
                end
            end

            for _, name in ipairs(basinNames) do
            local basin = peripheral.wrap(name)
            if basin then
                for slot, data in pairs(basin.list()) do
                    if data.name == "alltheores:brass_dust" then     
                        basin.pushItems("sophisticatedstorage:chest_6", slot )
                        packager.setAddress("Storage")
                        packager.makePackage()
                    end
                end
            end
            end
        end
        sleep(1)
end
Brass()