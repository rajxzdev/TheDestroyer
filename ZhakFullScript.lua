-- ZHAK-GPT FINAL v5.0 | TOMBOL PASTI MUNCUL + MOBILE FLY
-- Layout 2 kolom vertikal, ukuran kecil, semua tombol terlihat jelas

print("🔥 [ZHAK] Loading v5.0 - Tombol pasti muncul!")

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- DETEKSI MOBILE
local isMobile = UIS.TouchEnabled
local scaleFactor = isMobile and 0.75 or 1.0

-- SETTINGS
local Settings = {
    Fly = false, FlySpeed = 75, WalkSpeed = 16, JumpPower = 50,
    Noclip = false, GodMode = false, InfJump = false
}
local FlyBodyVelocity = nil
local MobileFlyUp = false
local MobileFlyDown = false
local CurrentChar, CurrentHumanoid = nil, nil

-- GUI SETUP
local function GetGuiParent()
    local ok, core = pcall(function() return game:GetService("CoreGui") end)
    if ok and core then return core end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local parent = GetGuiParent()
if parent:FindFirstChild("ZhakFinal_v5") then parent.ZhakFinal_v5:Destroy() end

local screen = Instance.new("ScreenGui")
screen.Name = "ZhakFinal_v5"
screen.Parent = parent
screen.IgnoreGuiInset = true
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MAIN FRAME (UKURAN KECIL UNTUK MOBILE)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280 * scaleFactor, 0, 420 * scaleFactor)
mainFrame.Position = UDim2.new(0.5, -140 * scaleFactor, 0.5, -210 * scaleFactor)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 20, 30)
mainFrame.BorderColor3 = Color3.fromRGB(255, 50, 150)
mainFrame.BorderSizePixel = 2
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Visible = true
mainFrame.Parent = screen
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

-- HEADER
local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 35 * scaleFactor)
header.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
header.Text = "✅ ZHAK v5.0"
header.TextColor3 = Color3.new(1, 1, 1)
header.Font = Enum.Font.GothamBold
header.TextSize = 14 * scaleFactor
header.Parent = mainFrame
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)

-- CLOSE BUTTON
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25 * scaleFactor, 0, 25 * scaleFactor)
closeBtn.Position = UDim2.new(1, -30 * scaleFactor, 0, 5 * scaleFactor)
closeBtn.BackgroundColor3 = Color3.fromRGB(100, 20, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16 * scaleFactor
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
closeBtn.MouseButton1Click:Connect(function() screen:Destroy() end)

-- MOBILE FLY PAD (HANYA MUNCUL SAAT FLY AKTIF)
local MobileFlyPad = Instance.new("Frame")
MobileFlyPad.Size = UDim2.new(0, 60 * scaleFactor, 0, 130 * scaleFactor)
MobileFlyPad.Position = UDim2.new(1, -70 * scaleFactor, 1, -140 * scaleFactor)
MobileFlyPad.BackgroundTransparency = 1
MobileFlyPad.Visible = false
MobileFlyPad.Parent = screen

local function CreateFlyBtn(text, yPos, action)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 60 * scaleFactor)
    btn.Position = UDim2.new(0, 0, 0, yPos * scaleFactor)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.6
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 24 * scaleFactor
    btn.Parent = MobileFlyPad
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.3, 0)
    
    btn.MouseButton1Down:Connect(function() action(true) end)
    btn.MouseButton1Up:Connect(function() action(false) end)
    btn.TouchTapIn:Connect(function() action(true) end)
    btn.TouchTapOut:Connect(function() action(false) end)
end

CreateFlyBtn("▲", 0, function(s) MobileFlyUp = s end)
CreateFlyBtn("▼", 65, function(s) MobileFlyDown = s end)

-- FUNGSI BUAT TOMBOL (2 KOLOM)
local col1X = 0.05
local col2X = 0.52
local startY = 0.12
local spacing = 0.085
local btnHeight = 0.07

local function CreateButton(text, x, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.43, 0, btnHeight, 0)
    btn.Position = UDim2.new(x, 0, y, 0)
    btn.BackgroundColor3 = Color3.fromRGB(65, 35, 50)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13 * scaleFactor
    btn.Parent = mainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    
    if callback then
        btn.MouseButton1Click:Connect(function() callback(btn) end)
    end
    return btn
end

local function CreateInput(placeholder, x, y)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.43, 0, btnHeight, 0)
    box.Position = UDim2.new(x, 0, y, 0)
    box.BackgroundColor3 = Color3.fromRGB(45, 25, 35)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.new(1, 1, 1)
    box.Font = Enum.Font.Gotham
    box.TextSize = 12 * scaleFactor
    box.Parent = mainFrame
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    return box
end

-- KOLOM 1: FLY & SPEED
local flyBtn = CreateButton("✈️ FLY: OFF", col1X, startY, function(btn)
    Settings.Fly = not Settings.Fly
    btn.Text = "✈️ FLY: " .. (Settings.Fly and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Fly and Color3.fromRGB(220, 50, 120) or Color3.fromRGB(65, 35, 50)
    MobileFlyPad.Visible = Settings.Fly
    
    if Settings.Fly then
        if CurrentChar and not FlyBodyVelocity then
            FlyBodyVelocity = Instance.new("BodyVelocity")
            FlyBodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            FlyBodyVelocity.P = 5000
            FlyBodyVelocity.Parent = CurrentChar:FindFirstChild("HumanoidRootPart")
        end
    else
        if FlyBodyVelocity then FlyBodyVelocity:Destroy(); FlyBodyVelocity = nil end
        if CurrentHumanoid then CurrentHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end
end)

local flySpd = CreateInput("Fly Speed (75)", col1X, startY + spacing)
local walkSpd = CreateInput("Walk Speed (16)", col1X, startY + spacing*2)
local jumpPwr = CreateInput("Jump Power (50)", col1X, startY + spacing*3)

CreateButton("SET SPEED", col1X, startY + spacing*4, function()
    Settings.FlySpeed = tonumber(flySpd.Text) or 75
    Settings.WalkSpeed = tonumber(walkSpd.Text) or 16
    Settings.JumpPower = tonumber(jumpPwr.Text) or 50
    if CurrentHumanoid then
        CurrentHumanoid.WalkSpeed = Settings.WalkSpeed
        CurrentHumanoid.JumpPower = Settings.JumpPower
    end
end)

-- KOLOM 2: CHEATS
CreateButton("👻 NOCLIP: OFF", col2X, startY, function(btn)
    Settings.Noclip = not Settings.Noclip
    btn.Text = "👻 NOCLIP: " .. (Settings.Noclip and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Noclip and Color3.fromRGB(220, 50, 120) or Color3.fromRGB(65, 35, 50)
end)

CreateButton("💀 GOD: OFF", col2X, startY + spacing, function(btn)
    Settings.GodMode = not Settings.GodMode
    btn.Text = "💀 GOD: " .. (Settings.GodMode and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.GodMode and Color3.fromRGB(220, 50, 120) or Color3.fromRGB(65, 35, 50)
end)

CreateButton("♾️ INF JUMP: OFF", col2X, startY + spacing*2, function(btn)
    Settings.InfJump = not Settings.InfJump
    btn.Text = "♾️ INF JUMP: " .. (Settings.InfJump and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.InfJump and Color3.fromRGB(220, 50, 120) or Color3.fromRGB(65, 35, 50)
end)

-- KOSONG KOLOM 2 BARIS 4-5 (BIAR RAPI)
local info = Instance.new("TextLabel")
info.Size = UDim2.new(0.43, 0, btnHeight*2, 0)
info.Position = UDim2.new(col2X, 0, startY + spacing*3, 0)
info.BackgroundTransparency = 1
info.Text = "📱 Gunakan Joystick\nuntuk terbang!\n▲▼ = Naik/Turun"
info.TextColor3 = Color3.fromRGB(255, 200, 220)
info.Font = Enum.Font.Gotham
info.TextSize = 11 * scaleFactor
info.TextWrapped = true
info.Parent = mainFrame

-- MAIN LOOP (FLY + CHEATS)
RunService.Heartbeat:Connect(function()
    CurrentChar = LocalPlayer.Character
    CurrentHumanoid = CurrentChar and CurrentChar:FindFirstChildOfClass("Humanoid")
    if not CurrentChar or not CurrentHumanoid then return end

    -- GOD MODE
    if Settings.GodMode then CurrentHumanoid.Health = CurrentHumanoid.MaxHealth end

    -- NOCLIP
    if Settings.Noclip then
        for _, v in pairs(CurrentChar:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end

    -- FLY LOGIC (PC + MOBILE)
    if Settings.Fly and FlyBodyVelocity then
        local root = CurrentChar:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new()
        
        -- INPUT HORIZONTAL (JOYSTICK HP / KEYBOARD PC)
        local moveVec = CurrentHumanoid.MoveDirection
        if moveVec.Magnitude > 0.1 then
            moveDir = (cam.CFrame.LookVector * -moveVec.Z) + (cam.CFrame.RightVector * moveVec.X)
        else
            if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
        end
        
        -- INPUT VERTIKAL
        if MobileFlyUp or UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
        if MobileFlyDown or UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0, 1, 0) end
        
        if moveDir.Magnitude > 0.1 then
            FlyBodyVelocity.Velocity = moveDir.Unit * Settings.FlySpeed
        else
            FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

-- INFINITE JUMP
UIS.JumpRequest:Connect(function()
    if Settings.InfJump and CurrentHumanoid then
        CurrentHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

print("✅ ZHAK v5.0 LOADED!")
print("✅ Panel pink kecil muncul di tengah")
print("✅ 2 kolom tombol jelas terlihat")
print("✅ Fly pakai joystick HP + tombol ▲▼")
