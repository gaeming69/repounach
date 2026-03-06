-- Roblox Lua Script
-- Teleports only unanchored BaseParts inside workspace.Items to the player's position

-- === CONFIGURATION ===
local playerName = "000_burrger" -- Change this to your Roblox username
local itemsFolder = workspace:FindFirstChild("Items")

if not itemsFolder then
    warn("workspace.Items folder not found!")
    return
end

-- Get the player object
local Players = game:GetService("Players")
local player = Players:FindFirstChild(playerName)

if not player then
    warn("Player '" .. playerName .. "' not found!")
    return
end

-- Function to teleport unanchored parts to the player
local function teleportUnanchoredPartsToPlayer()
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        warn("Player character or HumanoidRootPart not found!")
        return
    end

    local targetPosition = character.HumanoidRootPart.Position + Vector3.new(0, 3, 0) -- Slightly above player

    for _, obj in ipairs(itemsFolder:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored then
            -- Reset physics to avoid glitches
            obj.AssemblyLinearVelocity = Vector3.zero
            obj.AssemblyAngularVelocity = Vector3.zero

            -- Teleport part
            obj.CFrame = CFrame.new(targetPosition)
        end
    end
end

-- Run once
teleportUnanchoredPartsToPlayer()

print("Unanchored parts in workspace.Items have been teleported to " .. playerName)
