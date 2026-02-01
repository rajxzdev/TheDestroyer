-- ==============================================================
--  ZHAK-GPT FINAL v4.0 | HORIZONTAL GUI FOR MOBILE
--  GUI berbentuk horizontal (landscape), semua tombol terlihat
-- ==============================================================

print("🔥 [ZHAK] Memuat script v4.0 dengan GUI Horizontal...")

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==============================================
-- PENGATURAN & STATUS
-- ==============================================
local Settings = {
    Fly = false, FlySpeed = 75,
    WalkSpeed = 16, JumpPower = 50,
    Noclip = false, GodMode = false, InfJump = false,
}
local FlyBodyVelocity = nil
local MobileFlyUp = false
local MobileFlyDown = false
local CurrentChar, CurrentHumanoid = nil, nil

-- ==============================================
-- MEMBUAT GUI HORIZONTAL (LANDSCAPE)
-- ==============================================
local function GetGuiParent()
    local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if success and coreGui then return coreGui end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local parent = GetGuiParent()
if parent:FindFirstChild("ZhakHorizontalGUI") then parent:FindFirstChild("ZhakHorizontalGUI"):Destroy() end

local screen = Instance.new("ScreenGui")
screen.Name = "ZhakHorizontalGUI"
screen.Parent = parent
screen.IgnoreGuiInset = true
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MAIN FRAME HORIZONTAL (Landscape)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 280) -- Lebar 500, tinggi 280 (landscape)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -140) -- Tengah layar
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 15, 25)
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 127)
mainFrame.BorderSizePixel = 3
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Visible = true
mainFrame.Parent = screen
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

-- HEADER
local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(255, 0, 127)
header.Text = "✅ ZHAK HORIZONTAL v4.0"
header.TextColor3 = Color3.new(1, 1, 1)
header.Font = Enum.Font.GothamBold
header.TextSize = 16
header.Parent = mainFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 40)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
closeBtn.MouseButton1Click:Connect(function() screen:Destroy() end)

-- SCROLLING FRAME HORIZONTAL
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -40) -- Sesuaikan dengan header
scrollFrame.Position = UDim2.new(0, 5, 0, 40)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 5
scrollFrame.ScrollingDirection = Enum.ScrollingDirection.X -- Scroll horizontal
scrollFrame.CanvasSize = UDim2.new(0, 800, 0, 0) -- Lebar canvas 800
scrollFrame.Parent = mainFrame

local gridLayout = Instance.new("UIGridLayout")
gridLayout.CellSize = UDim2.new(0, 150, 0, 40) -- Ukuran setiap tombol
gridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
gridLayout.FillDirection = Enum.FillDirection.Horizontal
gridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
gridLayout.Parent = scrollFrame

-- ==============================================
-- TOMBOL VIRTUAL UNTUK MOBILE FLY
-- ==============================================
local MobileFlyPad = Instance.new("Frame")
MobileFlyPad.Size = UDim2.new(0, 70, 0, 150)
MobileFlyPad.Position = UDim2.new(1, -80, 1, -160) -- Pojok kanan bawah
MobileFlyPad.BackgroundTransparency = 1
MobileFlyPad.Visible = false
MobileFlyPad.Parent = screen

local function CreateFlyPadButton(text, yPos, action)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 70)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.5
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 30
    btn.Parent = MobileFlyPad
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

    btn.MouseButton1Down:Connect(function() action(true) end)
    btn.MouseButton1Up:Connect(function() action(false) end)
    btn.TouchTapIn:Connect(function() action(true) end)
    btn.TouchTapOut:Connect(function() action(false) end)
end

CreateFlyPadButton("▲", 0, function(state) MobileFlyUp = state end)
CreateFlyPadButton("▼", 75, function(state) MobileFlyDown = state end)

-- ==============================================
-- FUNGSI MEMBUAT TOMBOL
-- ==============================================
local function CreateButton(text, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0) -- Ukuran mengikuti grid
    btn.BackgroundColor3 = Color3.fromRGB(60, 30, 45)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.Parent = scrollFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    if cb then btn.MouseButton1Click:Connect(function() cb(btn) end) end
    return btn
end

local function CreateTextBox(placeholder)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, 0, 1, 0)
    box.BackgroundColor3 = Color3.fromRGB(20, 10, 15)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.new(1, 1, 1)
    box.Font = Enum.Font.Gotham
    box.TextSize = 12
    box.Parent = scrollFrame
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
    return box
end

-- ==============================================
-- SEMUA TOMBOL FITUR (HORIZONTAL)
-- ==============================================
-- Baris 1: Fly & Speed
local flyBtn = CreateButton("✈️ Fly: OFF", function(btn)
    Settings.Fly = not Settings.Fly
    btn.Text = "✈️ Fly: " .. (Settings.Fly and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Fly and Color3.fromRGB(200, 0, 100) or Color3.fromRGB(60, 30, 45)
    
    MobileFlyPad.Visible = Settings.Fly

    if Settings.Fly then
        if CurrentChar and not FlyBodyVelocity then
            FlyBodyVelocity = Instance.new("BodyVelocity")
            FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            FlyBodyVelocity.P = 5000
            FlyBodyVelocity.Parent = CurrentChar.HumanoidRootPart
        end
    else
        if FlyBodyVelocity then FlyBodyVelocity:Destroy(); FlyBodyVelocity = nil end
        if CurrentHumanoid then CurrentHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end
end)

local flySpeedBox = CreateTextBox("Fly Speed: 75")
local walkSpeedBox = CreateTextBox("Walk Speed: 16")
local jumpPowerBox = CreateTextBox("Jump Power: 50")

-- Baris 2: Cheats
CreateButton("👻 Noclip: OFF", function(btn) 
    Settings.Noclip = not Settings.Noclip
    btn.Text = "👻 Noclip: " .. (Settings.Noclip and "ON" or "OFF")
end)

CreateButton("💀 God Mode: OFF", function(btn) 
    Settings.GodMode = not Settings.GodMode
    btn.Text = "💀 God Mode: " .. (Settings.GodMode and "ON" or "OFF")
end)

CreateButton("♾️ Inf Jump: OFF", function(btn) 
    Settings.InfJump = not Settings.InfJump
    btn.Text = "♾️ Inf Jump: " .. (Settings.InfJump and "ON" or "OFF")
end)

-- Baris 3: Speed Controls
CreateButton("SET FLY SPEED", function()
    Settings.FlySpeed = tonumber(flySpeedBox.Text) or 75
    print("Fly Speed di-set ke: " .. Settings.FlySpeed)
end)

CreateButton("SET WALK SPEED", function()
    Settings.WalkSpeed = tonumber(walkSpeedBox.Text) or 16
    if CurrentHumanoid then CurrentHumanoid.WalkSpeed = Settings.WalkSpeed end
    print("Walk Speed di-set ke: " .. Settings.WalkSpeed)
end)

CreateButton("SET JUMP POWER", function()
    Settings.JumpPower = tonumber(jumpPowerBox.Text) or 50
    if CurrentHumanoid then CurrentHumanoid.JumpPower = Settings.JumpPower end
    print("Jump Power di-set ke: " .. Settings.JumpPower)
end)

-- ==============================================
-- LOOP UTAMA
-- ==============================================
RunService.Heartbeat:Connect(function()
    CurrentChar = LocalPlayer.Character
    CurrentHumanoid = CurrentChar and CurrentChar:FindFirstChildOfClass("Humanoid")
    if not CurrentChar or not CurrentHumanoid then return end

    if Settings.GodMode then CurrentHumanoid.Health = CurrentHumanoid.MaxHealth end

    if Settings.Noclip then
        for _, part in pairs(CurrentChar:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    -- FLY LOGIC (PC + MOBILE)
    if Settings.Fly and FlyBodyVelocity then
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new()
        
        -- Input Horizontal
        local joystickMove = (cam.CFrame.LookVector * -CurrentHumanoid.MoveDirection.Z) + (cam.CFrame.RightVector * CurrentHumanoid.MoveDirection.X)
        if joystickMove.Magnitude > 0.1 then
            moveDir += joystickMove
        else
            if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
        end
        
        -- Input Vertikal
        if MobileFlyUp or UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
        if MobileFlyDown or UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0, 1, 0) end
        
        FlyBodyVelocity.Velocity = moveDir.Unit * Settings.FlySpeed
    end
end)

UIS.JumpRequest:Connect(function()
    if Settings.InfJump and CurrentHumanoid then
        CurrentHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

print("✅ ZHAK HORIZONTAL v4.0 LOADED!")
print("📱 GUI berbentuk landscape, semua tombol terlihat!")
