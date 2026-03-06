-- LocalScript (place in StarterPlayerScripts)
-- Teleports your right arm to a random player's torso every 5 seconds
-- Press "J" to toggle ON/OFF

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local teleportEnabled = false -- starts disabled

-- Function to get a random other player
local function getRandomOtherPlayer()
    local allPlayers = Players:GetPlayers()
    local others = {}
    for _, p in ipairs(allPlayers) do
        if p ~= LocalPlayer and p.Character then
            table.insert(others, p)
        end
    end
    if #others > 0 then
        return others[math.random(1, #others)]
    end
    return nil
end

-- Function to teleport the arm
local function teleportArm()
    local char = LocalPlayer.Character
    if not char then return end

    local rightArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand")
    if not rightArm then
        warn("Right arm not found!")
        return
    end

    local targetPlayer = getRandomOtherPlayer()
    if not targetPlayer then
        warn("No other players to teleport to.")
        return
    end

    local targetTorso = targetPlayer.Character:FindFirstChild("Torso") or targetPlayer.Character:FindFirstChild("UpperTorso")
    if not targetTorso then
        warn("Target torso not found!")
        return
    end

    -- Move the arm's CFrame to the target torso's position
    rightArm.CFrame = targetTorso.CFrame
end

-- Toggle function for keybind
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.J then
        teleportEnabled = not teleportEnabled
        print("Arm teleport is now " .. (teleportEnabled and "ENABLED" or "DISABLED"))
    end
end)

-- Loop to run teleport when enabled
task.spawn(function()
    while true do
        if teleportEnabled then
            teleportArm()
        end
        task.wait(5) -- delay between teleports
    end
end)
