-- Goku MI

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "GokuMI"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,300,0,120)
frame.Position = UDim2.new(0.5,-150,0.1,0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BackgroundTransparency = 0.2

local corner = Instance.new("UICorner")
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "WELCOME TO BE STRONG"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack

-- Snow Aura
local aura = Instance.new("ParticleEmitter")
aura.Parent = char:WaitForChild("HumanoidRootPart")
aura.Texture = "rbxassetid://296874871"
aura.Color = ColorSequence.new(Color3.fromRGB(255,255,255))
aura.LightEmission = 1
aura.Rate = 100
aura.Speed = NumberRange.new(2,4)
aura.Lifetime = NumberRange.new(0.5,1)

-- Dash
local UIS = game:GetService("UserInputService")
local root = char:WaitForChild("HumanoidRootPart")

UIS.InputBegan:Connect(function(input,gp)
	if gp then return end
	
	if input.KeyCode == Enum.KeyCode.Q then
		local bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(99999,0,99999)
		bv.Velocity = root.CFrame.LookVector * 120
		bv.Parent = root
		
		task.wait(0.2)
		bv:Destroy()
	end
end)
