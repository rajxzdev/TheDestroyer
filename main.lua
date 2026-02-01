-- ZHAK-GPT UNIVERSAL DELTA MOBILE FIX
-- Semua fitur (Fly, Speed, Troll, Spec) dalam satu kode simpel

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- 1. NYARI TEMPAT MUNCUL (PARENT FIX)
local function GetGuiParent()
    local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if success and coreGui then return coreGui end
    
    local success2, getHui = pcall(function() return gethui() end)
    if success2 and getHui then return getHui end
    
    return LocalPlayer:WaitForChild("PlayerGui")
end

local TargetParent = GetGuiParent()

-- 2. SETTINGS
local Settings = {
    Fly = false, FlySpeed = 50, WalkSpeed = 16, JumpPower = 50,
    Noclip = false, InfJump = false, God = false, TrollSize = 10
}
local MobileInput = {W = false, S = false, A = false, D = false, Up = false, Down = false}

-- 3. HAPUS GUI LAMA KALAU ADA
if TargetParent:FindFirstChild("ZhakFinal") then TargetParent.ZhakFinal:Destroy() end

-- 4. BUAT GUI UTAMA
local Screen = Instance.new("ScreenGui")
Screen.Name = "ZhakFinal"
Screen.Parent = TargetParent
Screen.IgnoreGuiInset = true

-- TOMBOL BUKA/TUTUP (FLOATING BUTTON)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0.5, -25, 0.1, 0) -- Tengah atas
OpenBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
OpenBtn.Text = "ZHAK"
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Parent = Screen
local corner = Instance.new("UICorner", OpenBtn)
corner.CornerRadius = UDim.new(1, 0)

-- MAIN PANEL
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 300, 0, 400)
Main.Position = UDim2.new(0.5, -150, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Visible = false
Main.Active = true
Main.Draggable = true
Main.Parent = Screen
Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "ZHAK UNIVERSAL MOBILE"
Title.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.Parent = Main
Instance.new("UICorner", Title)

-- SCROLLING FRAME
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -10, 1, -50)
Scroll.Position = UDim2.new(0, 5, 0, 45)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 800)
Scroll.Parent = Main
local list = Instance.new("UIListLayout", Scroll)
list.Padding = UDim.new(0, 5)

-- TOGGLE BUKA PANEL
OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- 5. FUNGSI FITUR
local function NewButton(txt, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.Text = txt
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.Parent = Scroll
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() callback(b) end)
    return b
end

local function NewInput(placeholder)
    local i = Instance.new("TextBox")
    i.Size = UDim2.new(1, -10, 0, 35)
    i.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    i.PlaceholderText = placeholder
    i.Text = ""
    i.TextColor3 = Color3.new(1,1,1)
    i.Parent = Scroll
    Instance.new("UICorner", i)
    return i
end

-- --- TAMBAHKAN FITUR ---

-- WALK SPEED & JUMP
local wsInput = NewInput("Speed (Default 16)")
NewButton("Set Speed", function()
    Settings.WalkSpeed = tonumber(wsInput.Text) or 16
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Settings.WalkSpeed
    end
end)

local jpInput = NewInput("Jump (Default 50)")
NewButton("Set Jump", function()
    Settings.JumpPower = tonumber(jpInput.Text) or 50
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = Settings.JumpPower
    end
end)

-- FLY & NOCLIP
NewButton("Fly: Toggle", function(b)
    Settings.Fly = not Settings.Fly
    b.BackgroundColor3 = Settings.Fly and Color3.new(0, 1, 0) or Color3.fromRGB(40, 40, 40)
end)

NewButton("Noclip: Toggle", function(b)
    Settings.Noclip = not Settings.Noclip
    b.BackgroundColor3 = Settings.Noclip and Color3.new(0, 1, 0) or Color3.fromRGB(40, 40, 40)
end)

-- TROLL PART
local trollTarget = NewInput("Nama Target Troll")
NewButton("Spawn Troll Part (Mental)", function()
    local t = Players:FindFirstChild(trollTarget.Text)
    if t and t.Character then
        local p = Instance.new("Part", workspace)
        p.Size = Vector3.new(Settings.TrollSize, Settings.TrollSize, Settings.TrollSize)
        p.Position = t.Character.HumanoidRootPart.Position + Vector3.new(0, 15, 0)
        p.Velocity = Vector3.new(0, -100, 0) -- Biar ngebanting
        p.BrickColor = BrickColor.new("Bright red")
        task.delay(5, function() p:Destroy() end)
    end
end)

-- SPECTATE
local specTarget = NewInput("Nama Target Spec")
local specOn = false
NewButton("Spectate: Toggle", function(b)
    specOn = not specOn
    if specOn then
        local t = Players:FindFirstChild(specTarget.Text)
        if t and t.Character then
            workspace.CurrentCamera.CameraSubject = t.Character:FindFirstChild("Humanoid")
            b.BackgroundColor3 = Color3.new(0, 1, 0)
        end
    else
        workspace.CurrentCamera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
        b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

-- 6. MOBILE PAD (VIRTUAL)
local Pad = Instance.new("Frame", Screen)
Pad.Size = UDim2.new(0, 120, 0, 120)
Pad.Position = UDim2.new(1, -130, 1, -130)
Pad.BackgroundTransparency = 1

local function PadBtn(txt, pos, k)
    local b = Instance.new("TextButton", Pad)
    b.Size = UDim2.new(0, 40, 0, 40)
    b.Position = pos
    b.Text = txt
    b.BackgroundColor3 = Color3.new(0,0,0)
    b.BackgroundTransparency = 0.5
    b.TextColor3 = Color3.new(1,1,1)
    b.MouseButton1Down:Connect(function() MobileInput[k] = true end)
    b.MouseButton1Up:Connect(function() MobileInput[k] = false end)
end

PadBtn("↑", UDim2.new(0.5, -20, 0, 0), "W")
PadBtn("↓", UDim2.new(0.5, -20, 1, -40), "S")
PadBtn("←", UDim2.new(0, 0, 0.5, -20), "A")
PadBtn("→", UDim2.new(1, -40, 0.5, -20), "D")
PadBtn("▲", UDim2.new(1, -40, 0, 0), "Up")
PadBtn("▼", UDim2.new(0, 0, 1, -40), "Down")

-- 7. LOOPING UTAMA
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if hum and root then
        if Settings.Fly then
            hum.PlatformStand = true
            local cam = workspace.CurrentCamera
            local dir = Vector3.new(0,0,0)
            if MobileInput.W then dir += cam.CFrame.LookVector end
            if MobileInput.S then dir -= cam.CFrame.LookVector end
            if MobileInput.A then dir -= cam.CFrame.RightVector end
            if MobileInput.D then dir += cam.CFrame.RightVector end
            if MobileInput.Up then dir += Vector3.new(0,1,0) end
            if MobileInput.Down then dir -= Vector3.new(0,1,0) end
            
            root.Velocity = Vector3.new(0,0,0) -- Anti gravitasi
            root.CFrame = root.CFrame + (dir * (Settings.FlySpeed / 50))
        else
            hum.PlatformStand = false
        end

        if Settings.Noclip then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end
end)

print("✅ ZHAK FINAL LOADED!")
