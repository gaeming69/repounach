-- Roblox Server Script
-- Teleports all unanchored parts in the Workspace to the player's position
-- without moving the player's own character parts.

-- Replace "PlayerNameHere" with your Roblox username
local targetPlayerName = "000_burrger"

-- Function to get the player's position safely
local function getPlayerPosition(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        return player.Character.HumanoidRootPart.Position
    end
    return nil
end

-- Main execution
local Players = game:GetService("Players")
local targetPlayer = Players:FindFirstChild(targetPlayerName)

if not targetPlayer then
    warn("Player '" .. targetPlayerName .. "' not found in the server.")
    return
end

local playerPos = getPlayerPosition(targetPlayer)
if not playerPos then
    warn("Could not get position for player '" .. targetPlayerName .. "'.")
    return
end

-- Loop through all descendants in the workspace
for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") and not obj.Anchored then
        -- Skip parts that belong to the player's own character
        if not obj:IsDescendantOf(targetPlayer.Character) then
            -- Move the part to the player's position
            obj.CFrame = CFrame.new(playerPos)
        end
    end
end

print("All unanchored parts have been teleported to " .. targetPlayerName .. "'s position.")
