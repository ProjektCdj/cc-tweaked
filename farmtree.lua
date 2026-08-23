local relay_clutch = peripheral.wrap("redstone_relay_1")

function Farm()
    while true do
        relay_clutch.setOutput("top", true) print("Going...")
        sleep(30)  print("Waiting.")
        relay_clutch.setOutput("top", false) print("Backing...")
        sleep(30) print("Waiting.")
    end
    sleep(1)
end

Farm()