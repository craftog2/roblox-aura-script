-- Roblox Aura Effekte Script (Executor-kompatibel)

-- Prüfen, ob wir in Roblox sind
if not game then return end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Liste der Aura-Namen (Parts die durch BTR Addon angezogen wurden)
local auraNames = {
    "12532288301",
    "12532302225",
    "12532440639",
    "13948000252",
    "12672411889",
    "13948001865",
    "13948007143",
    "14077536383"
}

-- Geschwindigkeitseinstellungen
local speedLevel = 2 -- Standard Normal
local speedHeights = {1,2,3,4} -- Slow, Normal, Fast, Turbo

-- Effekte Toggle
local effectsOn = true

-- Entferne alle ParticleEmitter, Accessories, Effekte
for _, child in ipairs(character:GetChildren()) do
    if child:IsA("Accessory") or child:IsA("ParticleEmitter") or child:IsA("Trail") then
        child:Destroy()
    end
end

-- GUI erstellen
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0,220,0,150)
mainFrame.Position = UDim2.new(0,10,0,10)
mainFrame.BackgroundColor3 = Color3.new(0,0,0)
mainFrame.BorderSizePixel = 1
mainFrame.Parent = screenGui

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0,200,0,40)
toggleButton.Position = UDim2.new(0,10,0,10)
toggleButton.Text = "Effekte An/Aus"
toggleButton.BackgroundColor3 = Color3.new(1,1,1)
toggleButton.Parent = mainFrame

toggleButton.MouseButton1Click:Connect(function()
    effectsOn = not effectsOn
    toggleButton.Text = effectsOn and "Effekte An" or "Effekte Aus"
end)

-- Speed Buttons
local speeds = {"Slow","Normal","Fast","Turbo"}
for i,v in ipairs(speeds) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,80,0,30)
    btn.Position = UDim2.new(0,10 + ((i-1)*50),0,60)
    btn.Text = v
    btn.BackgroundColor3 = Color3.new(0.7,0.7,0.7)
    btn.Parent = mainFrame
    btn.MouseButton1Click:Connect(function()
        speedLevel = i
    end)
end

-- RenderLoop für Auren
game:GetService("RunService").RenderStepped:Connect(function()
    if effectsOn then
        for _, auraName in ipairs(auraNames) do
            local auraPart = character:FindFirstChild(auraName)
            if auraPart then
                auraPart.Position = character.HumanoidRootPart.Position + Vector3.new(0,speedHeights[speedLevel],0)
            end
        end
    end
end)
