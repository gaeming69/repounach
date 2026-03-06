local sourceFolder = workspace:FindFirstChild("Items")
local target = workspace:FindFirstChild("000_burrger")

if sourceFolder and target then
    for _, obj in ipairs(sourceFolder:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored then
            obj.CFrame = target:GetPivot()
        end
    end
end
