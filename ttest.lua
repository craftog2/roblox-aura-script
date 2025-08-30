-- Überprüfe, ob das Skript in Roblox ausgeführt wird
if game then
    -- Definiere die Aura-IDs
    local auraIDs = {
        12532288301, -- 1.0 Blue Fire Aura
        12532302225, -- 1.0 Purple Fire Aura
        12532440639, -- Green Fire Aura 1.0
        13948000252, -- 1.0 Blue Meteor Aura
        12672411889, -- 1.0 Yellow Fire Aura
        13948001865, -- 1.0 Purple Meteor Aura
        13948007143, -- 1.0 Inverted Meteor Aura
        14077536383  -- 1.0 Fire and Ice Aura
    }

    -- Funktion zum Umschalten der Auren
    local function toggleAuras()
        for _, auraID in ipairs(auraIDs) do
            local aura = game.Players.LocalPlayer.Character:FindFirstChild(tostring(auraID))
            if aura then
                aura:Destroy()
            else
                local newAura = Instance.new("Part")
                newAura.Name = tostring(auraID)
                newAura.Parent = game.Players.LocalPlayer.Character
                newAura.Anchored = true
                newAura.CanCollide = false
                newAura.Size = Vector3.new(1, 1, 1)
                newAura.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                newAura.Transparency = 1
                newAura.CustomPhysicalProperties = PhysicalProperties.new(0.0, 0.0, 0.0)
            end
        end
    end

    -- Funktion zur Anpassung der Geschwindigkeit
    local function adjustSpeed(speed)
        game:GetService("RunService").RenderStepped:Connect(function()
            for _, auraID in ipairs(auraIDs) do
                local aura = game.Players.LocalPlayer.Character:FindFirstChild(tostring(auraID))
                if aura then
                    if speed == "Langsam" then
                        aura.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1, 0)
                    elseif speed == "Normal" then
                        aura.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
                    elseif speed == "Schnell" then
                        aura.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0)
                    elseif speed == "Turbo" then
                        aura.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 4, 0)
                    end
                end
            end
        end)
    end

    -- Entferne alle Partikeleffekte und Accessoires
    local function removeEffectsAndAccessories()
        for _, child in ipairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if child:IsA("Accessory") or child:IsA("ParticleEmitter") then
                child:Destroy()
            end
        end
    end

    -- Erstelle die GUI
    local function createGUI()
        local screenGui = Instance.new("ScreenGui")
        local mainFrame = Instance.new("Frame")
        local toggleButton = Instance.new("TextButton")
        local speedDropdown = Instance.new("TextButton")

        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        mainFrame.Size = UDim2.new(0, 200, 0, 100)
        mainFrame.Position = UDim2.new(0, 10, 0, 10)
        mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
        mainFrame.BorderSizePixel = 1
        mainFrame.Parent = screenGui

        toggleButton.Size = UDim2.new(0, 180, 0, 40)
        toggleButton.Position = UDim2.new(0, 10, 0, 10)
        toggleButton.Text = "Auren Umschalten"
        toggleButton.BackgroundColor3 = Color3.new(1, 1, 1)
        toggleButton.BorderSizePixel = 1
        toggleButton.Parent = mainFrame

        speedDropdown.Size = UDim2.new(0, 180, 0, 40)
        speedDropdown.Position = UDim2.new(0, 10, 0, 60)
        speedDropdown.Text = "Speed: Normal"
        speedDropdown.BackgroundColor3 = Color3.new(1, 1, 1)
        speedDropdown.BorderSizePixel = 1
        speedDropdown.Parent = mainFrame

        -- Ereignis-Listener
        toggleButton.MouseButton1Click:Connect(toggleAuras)
        speedDropdown.MouseButton1Click:Connect(function()
            local currentSpeed = speedDropdown.Text:match("Speed: (.+)")
            local nextSpeed
            if currentSpeed == "Langsam" then
                nextSpeed = "Normal"
            elseif currentSpeed == "Normal" then
                nextSpeed = "Schnell"
            elseif currentSpeed == "Schnell" then
                nextSpeed = "Turbo"
            else
                nextSpeed = "Langsam"
            end
            speedDropdown.Text = "Speed: " .. nextSpeed
            adjustSpeed(nextSpeed)
        end)
    end

    -- Hauptfunktion
    local function main()
        removeEffectsAndAccessories()
        createGUI()
        adjustSpeed("Normal") -- Standardgeschwindigkeit setzen
    end

    -- Führe das Skript aus
    main()
else
    print("Dieses Skript muss in Roblox ausgeführt werden.")
end
