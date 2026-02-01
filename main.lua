-- rajxzdev 2026 CLEAN PRO – GUI 100% MUNcul
-- Paste langsung → GUI langsung keluar di semua executor

local gui = Instance.new("ScreenGui")
gui.Name = "rajxzdev2026"
gui.ResetOnSpawn = false

-- FIX PALING AMPUH 2026
if syn then
    syn.protect_gui(gui)
    gui.Parent = game.CoreGui
elseif gethui then
    gui.Parent = gethui()
else
    gui.Parent = game:GetService("CoreGui")
end

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 380, 0, 520)
main.Position = UDim2.new(0.5, -190, 0.5, -260)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 20)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 70)
title.BackgroundColor3 = Color3.fromRGB(120, 0, 255)
title.Text = "rajxzdev 2026"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 36
title.TextStrokeTransparency = 0
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 20)

-- Slider Fly Speed
local flyspeed = 200
local flyslider = Instance.new("TextBox", main)
flyslider.Size = UDim2.new(0.8, 0, 0, 50)
flyslider.Position = UDim2.new(0.1, 0, 0, 100)
flyslider.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
flyslider.Text = "Fly Speed: " .. flyspeed
flyslider.TextColor3 = Color3.new(1,1,1)
flyslider.Font = Enum.Font.GothamBold
flyslider.TextSize = 20
Instance.new("UICorner", flyslider).CornerRadius = UDim.new(0, 12)

-- Slider Walk Speed
local walkspeed = 200
local walkspeedslider = Instance.new("TextBox", main)
walkspeedslider.Size = UDim2.new(0.8, 0, 0, 50)
walkspeedslider.Position = UDim2.new(0.1, 0, 0, 170)
walkspeedslider.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
walkspeedslider.Text = "Walk Speed: " .. walkspeed
walkspeedslider.TextColor3 = Color3.new(1,1,1)
walkspeedslider.Font = Enum.Font.GothamBold
walkspeedslider.TextSize = 20
Instance.new("UICorner", walkspeedslider).CornerRadius = UDim.new(0, 12)

-- Buttons
local function btn(name, pos, color, func)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.8, 0, 0, 60)
    b.Position = UDim2.new(0.1, 0, 0, pos)
    b.BackgroundColor3 = color
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 24
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 14)
    b.MouseButton1Click:Connect(func)
end

local flying = false
btn("Toggle Fly", 240, Color3.fromRGB(0, 180, 255), function()
    flying = not flying
    local char = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    if flying then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(9e9,9e9,9e9)
        local bg = Instance.new("BodyGyro", hrp)
        bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
        bg.P = 9e9
        spawn(function()
            while flying do
                local dir = Vector3.new(0,0,0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
                bv.Velocity = dir * flyspeed
                bg.CFrame = Camera.CFrame
                task.wait()
            end
            bv:Destroy()
            bg:Destroy()
        end)
    end
end)

btn("Infinite Jump", 320, Color3.fromRGB(0, 255, 150), function()
    UserInputService.JumpRequest:Connect(function()
        Humanoid:ChangeState("Jumping")
    end)
end)

btn("Wallhack", 400, Color3.fromRGB(255, 0, 150), function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            for _, part in pairs(plr.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = part.Transparency == 0.7 and 0 or 0.7
                end
            end
        end
    end
end)

-- Update speed real-time
flyslider.FocusLost:Connect(function()
    flyspeed = tonumber(flyslider.Text:match("%d+")) or 200
    flyslider.Text = "Fly Speed: " .. flyspeed
end)

walkspeedslider.FocusLost:Connect(function()
    walkspeed = tonumber(walkspeedslider.Text:match("%d+")) or 200
    walkspeedslider.Text = "Walk Speed: " .. walkspeed
    Humanoid.WalkSpeed = walkspeed
end)

print("rajxzdev 2026 CLEAN PRO – GUI 100% MUNcul – Mobile/PC Perfect")            callback(value)
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
