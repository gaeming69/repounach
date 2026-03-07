local sourceFolder = workspace:FindFirstChild("PowerUps")
local target = workspace:FindFirstChild("Doviast")

if sourceFolder and target then
    for _, obj in ipairs(sourceFolder:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored then
            obj.CFrame = target:GetPivot()
        end
    end
end
