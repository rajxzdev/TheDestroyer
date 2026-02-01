-- [[ ZHAK-GPT UNIVERSAL HUB 2025 ]] --
-- Fitur: Fly, Speed, Jump, Noclip, ESP, Inf Jump
-- Kompatibilitas: All Executors (Mobile/PC)

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")
local Hum = Character:WaitForChild("Humanoid")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- // UI SETUP // --
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Container = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "ZhakHub"
ScreenGui.Parent = game.CoreGui or Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -125)
MainFrame.Size = UDim2.new(0, 200, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true -- Agar bisa digeser

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Text = "ZHAK-GPT HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

Container.Parent = MainFrame
Container.Position = UDim2.new(0, 5, 0, 40)
Container.Size = UDim2.new(1, -10, 1, -45)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 2

UIListLayout.Parent = Container
UIListLayout.Padding = UDim.new(0, 5)

-- // FUNCTIONS // --
local function CreateButton(name, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = Container
    Button.Size = UDim2.new(1, 0, 0, 30)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    Button.Text = name
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 12
    Button.MouseButton1Click:Connect(callback)
end

-- // HACK VARIABLES // --
local FlyEnabled = false
local FlySpeed = 50
local NoclipEnabled = false
local InfJumpEnabled = false

-- 1. Fly System (CFrame based - Visible to others)
CreateButton("Toggle Fly (F)", function()
    FlyEnabled = not FlyEnabled
    if FlyEnabled then
        local bv = Instance.new("BodyVelocity", Root)
        bv.Velocity = Vector3.new(0,0,0)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Name = "ZhakFly"
        
        task.spawn(function()
            while FlyEnabled do
                local cam = workspace.CurrentCamera
                local move = Vector3.new(0,0,0)
                if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                
                Root.Velocity = move * FlySpeed
                task.wait()
            end
            if Root:FindFirstChild("ZhakFly") then Root.ZhakFly:Destroy() end
        end)
    end
end)

-- 2. WalkSpeed
CreateButton("Set Speed 100", function()
    Player.Character.Humanoid.WalkSpeed = 100
end)

-- 3. JumpPower
CreateButton("High Jump", function()
    Player.Character.Humanoid.JumpPower = 150
end)

-- 4. Noclip (Tembus Tembok)
CreateButton("Noclip", function()
    NoclipEnabled = not NoclipEnabled
    RunService.Stepped:Connect(function()
        if NoclipEnabled then
            for _, v in pairs(Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- 5. ESP (Melihat Orang di Balik Tembok)
CreateButton("ESP (Player)", function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= Player and p.Character then
            local Highlight = Instance.new("Highlight")
            Highlight.Parent = p.Character
            Highlight.FillColor = Color3.new(1, 0, 0)
        end
    end
end)

-- 6. Infinite Jump
UIS.JumpRequest:Connect(function()
    if InfJumpEnabled then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)
CreateButton("Inf Jump: OFF", function(self)
    InfJumpEnabled = not InfJumpEnabled
    -- Note: Text update logic usually needs a reference to the button
end)

-- 7. Reset Character
CreateButton("Reset Character", function()
    Character:BreakJoints()
end)

-- // TOGGLE GUI // --
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

print("Zhak-Gpt Hub Loaded! Press RightControl to Toggle GUI")
