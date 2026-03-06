-- LocalScript: Teleports the player to the "Speed" item inside workspace.PowerUps
-- Place this in StarterPlayer -> StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Wait until the character is loaded
local function getCharacter()
    local char = player.Character or player.CharacterAdded:Wait()
    -- Ensure HumanoidRootPart exists
    char:WaitForChild("HumanoidRootPart")
    return char
end

-- Function to find the "Speed" item in workspace.PowerUps
local function findSpeedItem()
    local powerUpsFolder = workspace:FindFirstChild("PowerUps")
    if not powerUpsFolder then
        warn("PowerUps folder not found in Workspace.")
        return nil
    end

    for _, item in ipairs(powerUpsFolder:GetChildren()) do
        if item.Name == "Speed" and item:IsA("BasePart") then
            return item
        end
    end

    warn('"Speed" item not found or is not a BasePart.')
    return nil
end

-- Teleport function
local function teleportToSpeed()
    local char = getCharacter()
    local speedItem = findSpeedItem()

    if speedItem then
        -- Teleport the HumanoidRootPart to the Speed item's position
        char:MoveTo(speedItem.Position)
        print("Teleported to Speed item.")
    end
end

-- Example: teleport when the game starts
teleportToSpeed()

-- Optional: Bind to a key press (e.g., "T")
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.T then
        teleportToSpeed()
    end
end)
