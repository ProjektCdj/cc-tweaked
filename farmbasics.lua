local allRelays = {peripheral.find("redstone_relay")}
local relays = {}

for _, r in ipairs(allRelays) do
    local name = peripheral.getName(r)
    if name:match("^redstone_relay_%d+$") then
        table.insert(relays, r)
    end
end


local function setRelays(state)
    for _, r in ipairs(relays) do
        r.setOutput("left", state)
    end
end

while true do
    setRelays(true)
    sleep(5)   --
    setRelays(false)
    sleep(1)   --
end

