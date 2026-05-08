-- Goku Ultra Instinct (UI) Script
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local UIS = game:GetService("UserInputService")

-- Configuration
local isActive = true
local dashPower = 120

-- Create Screen GUI
local gui = Instance.new("ScreenGui")
gui.Name = "GokuUIScript"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = gui
mainFrame.Size = UDim2.new(0, 250, 0, 130)
mainFrame.Position = UDim2.new(0.5, -125, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Active = true
mainFrame.Draggable = true -- Allows you to move the UI

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Title Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = mainFrame
titleLabel.Size = UDim2.new(1, 0, 0.4, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "GOKU ULTRA INSTINCT"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBlack

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Parent = mainFrame
toggleButton.Size = UDim2.new(0.8, 0, 0.4, 0)
toggleButton.Position = UDim2.new(0.1, 0, 0.5, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 180, 100) -- Initial Green
toggleButton.Text = "STATUS: ON"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextScaled = true

local btnCorner = Instance.new("UICorner")
btnCorner.Parent = toggleButton

-- Function to handle Aura creation
local function applyAura()
    local root = char:WaitForChild("HumanoidRootPart")
    local aura = Instance.new("ParticleEmitter")
    aura.Name = "UIAura"
    aura.Parent = root
    aura.Texture = "rbxassetid://296874871"
    aura.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
    aura.LightEmission = 1
    aura.Rate = 100
    aura.Speed = NumberRange.new(2, 4)
    aura.Lifetime = NumberRange.new(0.5, 1)
    return aura
end

local currentAura = applyAura()

-- Toggle Logic
toggleButton.MouseButton1Click:Connect(function()
    isActive = not isActive
    
    if isActive then
        toggleButton.Text = "STATUS: ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
        if char:FindFirstChild("HumanoidRootPart") then
            currentAura = applyAura()
        end
    else
        toggleButton.Text = "STATUS: OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        local root = char:FindFirstChild("HumanoidRootPart")
        if root and root:FindFirstChild("UIAura") then
            root.UIAura:Destroy()
        end
    end
end)

-- Dash Mechanism (Q Key)
UIS.InputBegan:Connect(function(input, processed)
    if processed or not isActive then return end
    
    if input.KeyCode == Enum.KeyCode.Q then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            local velocity = Instance.new("BodyVelocity")
            velocity.MaxForce = Vector3.new(100000, 0, 100000)
            velocity.Velocity = root.CFrame.LookVector * dashPower
            velocity.Parent = root
            
            task.wait(0.2)
            velocity:Destroy()
        end
    end
end)

-- Character Respawn Support
player.CharacterAdded:Connect(function(newCharacter)
    char = newCharacter
    if isActive then
        task.wait(1)
        currentAura = applyAura()
    end
end)
