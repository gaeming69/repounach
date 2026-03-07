
-- List of item names inside workspace.Items
local itemNames = {
    "Nuke Pistol",
    "Explosive Pistol",
    "Flight Pistol",
    "Super Pistol",
    "Streamliner",
    "Health Pistol"
}

-- Get target torso
local targetTorso = workspace:FindFirstChild("Doviast")
    and workspace["Doviast"]:FindFirstChild("Torso")

if not targetTorso then
    warn("Target torso not found. Script stopped.")
    return
end

-- Function to teleport an item to the target torso
local function teleportItem(item)
    if item:IsA("BasePart") then
        if not item.Anchored then
            item.CFrame = targetTorso.CFrame
        end
    elseif item:IsA("Model") then
        local primary = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
        if primary and not primary.Anchored then
            item:SetPrimaryPartCFrame(targetTorso.CFrame)
        end
    end
end

-- Loop through each item name and teleport if found
for _, name in ipairs(itemNames) do
    local item = workspace.Items:FindFirstChild(name)
    if item then
        teleportItem(item)
    else
        warn("Item not found: " .. name)
    end
end
