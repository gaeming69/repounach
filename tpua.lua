-- Script (place in ServerScriptService)
-- Teleports all unanchored parts in workspace.Items to workspace["000_burrger"].Torso

local itemsFolder = workspace:FindFirstChild("Items")
local targetModel = workspace:FindFirstChild("000_burrger")

-- Validate target model and torso
if not itemsFolder or not targetModel then
    warn("Items folder or target model not found in workspace.")
    return
end

local torso = targetModel:FindFirstChild("Torso")
if not torso or not torso:IsA("BasePart") then
    warn("Torso not found or is not a BasePart in target model.")
    return
end

-- Function to teleport unanchored parts
local function teleportUnanchoredItems()
    for _, obj in ipairs(itemsFolder:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored then
            -- Move part to torso position
            obj.CFrame = torso.CFrame + Vector3.new(0, 3, 0) -- offset to avoid overlap
            obj.AssemblyLinearVelocity = Vector3.zero -- stop movement
        end
    end
end

-- Run once on script start
teleportUnanchoredItems()

-- Optional: run every few seconds to keep teleporting new items
while task.wait(222222) do
    teleportUnanchoredItems()
end
