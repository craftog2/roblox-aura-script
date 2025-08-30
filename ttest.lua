local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local auraNames = {
    "12532288301","12532302225","12532440639","13948000252",
    "12672411889","13948001865","13948007143","14077536383"
}

-- Entferne alle Extras am Anfang
for _, child in ipairs(character:GetChildren()) do
    if child:IsA("Accessory") or child:IsA("ParticleEmitter") or child:IsA("Trail") then
        child:Destroy()
    end
end

-- GUI erstellen
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 150)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
mainFrame.Parent = screenGui

-- Toggle Button
local toggleButton = Instance.new("TextButton", mainFrame)
toggleButton.Size = UDim2.new(0,200,0,40)
toggleButton.Position = UDim2.new(0,10,0,10)
toggleButton.Text = "OFF"
toggleButton.BackgroundColor3 = Color3.fromRGB(200,0,0)

local effectsOn = false

toggleButton.MouseButton1Click:Connect(function()
    effectsOn = not effectsOn
    if effectsOn then
        toggleButton.Text = "ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0,200,0)
    else
        toggleButton.Text = "OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(200,0,0)
    end
end)

-- Speed Button
local speeds = {"Slow","Normal","Fast","Turbo"}
local speedLevel = 2
local speedButton = Instance.new("TextButton", mainFrame)
speedButton.Size = UDim2.new(0,200,0,40)
speedButton.Position = UDim2.new(0,10,0,60)
speedButton.Text = "Speed: Normal"
speedButton.BackgroundColor3 = Color3.fromRGB(150,150,150)

speedButton.MouseButton1Click:Connect(function()
    speedLevel = speedLevel % #speeds + 1
    speedButton.Text = "Speed: "..speeds[speedLevel]
end)

local speedHeights = {1,2,3,4} -- Slow, Normal, Fast, Turbo

-- RenderLoop
game:GetService("RunService").RenderStepped:Connect(function()
    if effectsOn then
        for _, auraName in ipairs(auraNames) do
            local auraPart = character:FindFirstChild(auraName)
            if auraPart then
                auraPart.Position = character.HumanoidRootPart.Position + Vector3.new(0, speedHeights[speedLevel], 0)
            end
        end
    end
end)
