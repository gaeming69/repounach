-- Roblox Server Script
-- Teleports workspace.000_burrger["Right Arm"] to a random player's torso
-- Changes target when the player dies

-- Validate that the object exists
local burrgerModel = workspace:FindFirstChild("000_burrger")
if not burrgerModel or not burrgerModel:FindFirstChild("Right Arm") then
    warn("Could not find workspace.000_burrger['Right Arm']")
    return
end

local rightArm = burrgerModel["Right Arm"]
local Players = game:GetService("Players")

-- Function to get a random player with a valid character and torso
local function getRandomPlayer()
    local playerList = Players:GetPlayers()
    if #playerList == 0 then
        return nil
    end

    -- Keep trying until we find a player with a torso
    for _ = 1, #playerList do
        local randomPlayer = playerList[math.random(1, #playerList)]
        if randomPlayer.Character then
            local torso = randomPlayer.Character:FindFirstChild("Torso") or randomPlayer.Character:FindFirstChild("UpperTorso")
            if torso then
                return randomPlayer, torso
            end
        end
    end
    return nil
end

-- Function to teleport the Right Arm to the torso
local function teleportToTorso(torso)
    if torso and torso:IsA("BasePart") then
        rightArm.CFrame = torso.CFrame
    end
end

-- Main loop: pick a player, teleport, wait for death, repeat
task.spawn(function()
    while true do
        local player, torso = getRandomPlayer()
        if player and torso then
            teleportToTorso(torso)

            -- Listen for death
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Died:Wait()
            end
        else
            -- No valid players, wait before retrying
            task.wait(1)
        end
    end
end)
