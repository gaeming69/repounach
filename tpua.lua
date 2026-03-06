function TeleportUnanchoredPartsToPlayer(player)
    – Get all the parts in the workspace
    local parts = game.Workspace:GetDescendants()
-- Iterate through each part
for _, part in ipairs(parts) do
    -- Check if the part is unanchored
    if part:IsA("BasePart") and not part:IsAnchored() then
        -- Teleport the part to the player's position
        part.CFrame = player.Character.HumanoidRootPart.CFrame
    end
end

end
– Example usage of the TeleportUnanchoredPartsToPlayer function
– Usage Example: Teleport all unanchored parts to the player
local player = game.Players.LocalPlayer
TeleportUnanchoredPartsToPlayer(player)
