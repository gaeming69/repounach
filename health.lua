-- LocalScript inside StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Wait for the player's character to load
local function getCharacter()
    local char = player.Character or player.CharacterAdded:Wait()
    char:WaitForChild("HumanoidRootPart") -- Ensure teleport anchor exists
    return char
end

-- Function to find the "Health" item in workspace.PowerUps children
local function findHealthItem()
    local powerUpsFolder = workspace:FindFirstChild("PowerUps")
    if not powerUpsFolder then
        warn("PowerUps folder not found in Workspace.")
        return nil
    end

    -- Search through each child of PowerUps
    for _, child in ipairs(powerUpsFolder:GetChildren()) do
        local healthItem = child:FindFirstChild("Health")
        if healthItem and healthItem:IsA("BasePart") then
            return healthItem
        end
    end

    warn("No 'Health' item found in PowerUps children.")
    return nil
end

-- Teleport function
local function teleportToHealth()
    local char = getCharacter()
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    local healthItem = findHealthItem()

    if rootPart and healthItem then
        -- Move player to the Health item's position
        rootPart.CFrame = healthItem.CFrame + Vector3.new(0, 3, 0) -- Offset to avoid clipping
        print("Teleported to Health item.")
    end
end

-- Example: teleport when the player presses the "H" key
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.H then
        teleportToHealth()
    end
end)
