-- TheDestroyer 2026 - CLEAN PRO EDITION
-- by rajxzdev – King without ban
-- Fly/Speed adjustable + Mobile perfect

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- GUI CANTIK 2026
local gui = Instance.new("ScreenGui")
gui.Name = "rajxzdevClean"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 360, 0, 480)
main.Position = UDim2.new(0.5, -180, 0.5, -240)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 20)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 60)
title.BackgroundColor3 = Color3.fromRGB(80, 0, 255)
title.Text = "rajxzdev 2026"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 28
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 20)

-- Slider Function
local function Slider(name, pos, min, max, default, callback)
    local slider = Instance.new("Frame", main)
    slider.Size = UDim2.new(0.9, 0, 0, 50)
    slider.Position = UDim2.new(0.05, 0, 0, pos)
    slider.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    
    local label = Instance.new("TextLabel", slider)
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name .. ": " .. default
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Position = UDim2.new(0, 10, 0, 0)

    local bar = Instance.new("TextButton", slider)
    bar.Size = UDim2.new(0.7, 0, 0.4, 0)
    bar.Position = UDim2.new(0.25, 0, 0.3, 0)
    bar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    bar.Text = ""
    
    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new(default / max, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(120, 0, 255)
    
    bar.MouseButton1Down:Connect(function()
        local mouse = LocalPlayer:GetMouse()
        local connection
        connection = RunService.RenderStepped:Connect(function()
            local pos = mouse.X - bar.AbsolutePosition.X
            local percent = math.clamp(pos / bar.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            local value = math.floor(min + (max - min) * percent)
            label.Text = name .. ": " .. value
            callback(value)
        end)
        mouse.Button1Up:Connect(function()
            connection:Disconnect()
        end)
    end)
    
    Instance.new("UICorner", slider).CornerRadius = UDim.new(0, 12)
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 8)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 8)
end

-- Fitur Variables
local FlySpeed = 100
local WalkSpeed = 100
local FlyActive = false
local Wallhack = false

-- Fly (Mobile + PC perfect)
local function ToggleFly()
    FlyActive = not FlyActive
    if FlyActive then
        local bv = Instance.new("BodyVelocity", HRP)
        bv.MaxForce = Vector3.new(9e9,9e9,9e9)
        local bg = Instance.new("BodyGyro", HRP)
        bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
        bg.P = 9e9
        spawn(function()
            while FlyActive do
                local dir = Vector3.new(0,0,0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
                bv.Velocity = dir * FlySpeed
                bg.CFrame = Camera.CFrame
                task.wait()
            end
            bv:Destroy(); bg:Destroy()
        end)
    end
end

-- Sliders
Slider("Fly Speed", 100, 16, 1000, FlySpeed, function(v) FlySpeed = v end)
Slider("Walk Speed", 170, 16, 1000, WalkSpeed, function(v) Humanoid.WalkSpeed = v end)

-- Buttons
local btn = function(name, pos, color, callback)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.9, 0, 0, 60)
    b.Position = UDim2.new(0.05, 0, 0, pos)
    b.BackgroundColor3 = color
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 22
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 14)
    b.MouseButton1Click:Connect(callback)
end

btn("Toggle Fly", 250, Color3.fromRGB(0, 180, 255), ToggleFly)
btn("Infinite Jump", 320, Color3.fromRGB(0, 255, 150), function()
    UserInputService.JumpRequest:Connect(function()
        Humanoid:ChangeState("Jumping")
    end)
end)
btn("Wallhack (X-Ray)", 390, Color3.fromRGB(255, 0, 150), function()
    Wallhack = not Wallhack
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            for _, part in pairs(plr.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = Wallhack and 0.7 or 0
                    part.Material = Wallhack and Enum.Material.ForceField or Enum.Material.Plastic
                end
            end
        end
    end
end)

print("rajxzdev 2026 CLEAN PRO EDITION – welcome to the new era")                            local exp = Instance.new("Explosion", bomb)
                            exp.BlastRadius = 9999
                            exp.BlastPressure = 9e9
                            exp.DestroyJointRadiusPercent = 0
                            game.Debris:AddItem(bomb, 0.01)
                        end)
                    end
                end
            end
        end
    end)
end)

print("rajxzdev 2026 – The King has returned")
