-- Prüfen, ob wir in Roblox sind
if not game then return end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Aura-IDs
local auraIDs = {
    12532288301,
    12532302225,
    12532440639,
    13948000252,
    12672411889,
    13948001865,
    13948007143,
    14077536383
}

-- Geschwindigkeit
local speedLevel = 2 -- 1=Langsam, 2=Normal, 3=Schnell, 4=Turbo
local speedHeights = {1,2,3,4}

-- Erstelle Auren
local function toggleAuras()
    for _, auraID in ipairs(auraIDs) do
        local aura = character:FindFirstChild(tostring(auraID))
        if aura then
            aura:Destroy()
        else
            local newAura = Instance.new("Part")
            newAura.Name = tostring(auraID)
            newAura.Size = Vector3.new(1,1,1)
            newAura.Position = character:WaitForChild("HumanoidRootPart").Position
            newAura.Anchored = true
            newAura.CanCollide = false
            newAura.Transparency = 1
            newAura.Parent = character
        end
    end
end

-- GUI erstellen
local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0,200,0,150)
    mainFrame.Position = UDim2.new(0,10,0,10)
    mainFrame.BackgroundColor3 = Color3.new(0,0,0)
    mainFrame.BorderSizePixel = 1
    mainFrame.Parent = screenGui

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0,180,0,40)
    toggleButton.Position = UDim2.new(0,10,0,10)
    toggleButton.Text = "Auren Umschalten"
    toggleButton.BackgroundColor3 = Color3.new(1,1,1)
    toggleButton.Parent = mainFrame
    toggleButton.MouseButton1Click:Connect(toggleAuras)

    local speeds = {"Langsam","Normal","Schnell","Turbo"}
    for i, v in ipairs(speeds) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0,80,0,30)
        btn.Position = UDim2.new(0,10 + ((i-1)*45),0,60)
        btn.Text = v
        btn.BackgroundColor3 = Color3.new(0.7,0.7,0.7)
        btn.Parent = mainFrame
        btn.MouseButton1Click:Connect(function()
            speedLevel = i
        end)
    end
end

-- RenderLoop für Auren
game:GetService("RunService").RenderStepped:Connect(function()
    for _, auraID in ipairs(auraIDs) do
        local aura = character:FindFirstChild(tostring(auraID))
        if aura then
            aura.Position = character.HumanoidRootPart.Position + Vector3.new(0,speedHeights[speedLevel],0)
        end
    end
end)

-- Effekte entfernen
for _, child in ipairs(character:GetChildren()) do
    if child:IsA("Accessory") or child:IsA("ParticleEmitter") then
        child:Destroy()
    end
end

-- GUI starten
createGUI()
