-- ==============================================================
--  ZHAK-GPT FINAL v3.0 | MOBILE FLY SUPPORT GUARANTEED
--  Panel akan langsung muncul. Fly bisa pakai joystick HP.
-- ==============================================================

print("🔥 [ZHAK] Memuat script v3.0 dengan Mobile Fly Support...")

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
local MobileFlyUp = false -- Status tombol naik di HP
local MobileFlyDown = false -- Status tombol turun di HP
local CurrentChar, CurrentHumanoid = nil, nil

-- ==============================================
-- MEMBUAT GUI DENGAN CARA PALING AMAN
-- ==============================================
local function GetGuiParent()
    local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if success and coreGui then return coreGui end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local parent = GetGuiParent()
if parent:FindFirstChild("ZhakFinalGUI") then parent:FindFirstChild("ZhakFinalGUI"):Destroy() end

local screen = Instance.new("ScreenGui")
screen.Name = "ZhakFinalGUI"
screen.Parent = parent
screen.IgnoreGuiInset = true
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 480)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 20, 30)
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 127)
mainFrame.BorderSizePixel = 3
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Visible = true
mainFrame.Parent = screen
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(255, 0, 127)
header.Text = "✅ FINAL v3.0 | MOBILE SUPPORT"
header.TextColor3 = Color3.new(1, 1, 1)
header.Font = Enum.Font.GothamBold
header.TextSize = 16
header.Parent = mainFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 40)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
closeBtn.MouseButton1Click:Connect(function() screen:Destroy() end)

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -45)
scrollFrame.Position = UDim2.new(0, 0, 0, 45)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
scrollFrame.Parent = mainFrame
local listLayout = Instance.new("UIListLayout", scrollFrame)
listLayout.Padding = UDim.new(0, 8)
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ==============================================
-- TOMBOL VIRTUAL UNTUK MOBILE FLY (NAIK/TURUN)
-- ==============================================
local MobileFlyPad = Instance.new("Frame")
MobileFlyPad.Size = UDim2.new(0, 80, 0, 180)
MobileFlyPad.Position = UDim2.new(1, -90, 1, -190) -- Pojok kanan bawah
MobileFlyPad.BackgroundTransparency = 1
MobileFlyPad.Visible = false -- Muncul hanya saat fly aktif
MobileFlyPad.Parent = screen

local function CreateFlyPadButton(text, yPos, action)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 80)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.5
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 40
    btn.Parent = MobileFlyPad
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

    btn.MouseButton1Down:Connect(function() action(true) end)
    btn.MouseButton1Up:Connect(function() action(false) end)
    btn.TouchTapIn:Connect(function() action(true) end)
    btn.TouchTapOut:Connect(function() action(false) end)
end

CreateFlyPadButton("▲", 0, function(state) MobileFlyUp = state end) -- Tombol Naik
CreateFlyPadButton("▼", 90, function(state) MobileFlyDown = state end) -- Tombol Turun

-- ==============================================
-- FUNGSI MEMBUAT ELEMEN UI
-- ==============================================
local function CreateButton(text, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(60, 30, 45)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.Parent = scrollFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    if cb then btn.MouseButton1Click:Connect(function() cb(btn) end) end
    return btn
end

local function CreateTextBox(placeholder)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.9, 0, 0, 35)
    box.BackgroundColor3 = Color3.fromRGB(20, 10, 15)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.new(1, 1, 1)
    box.Font = Enum.Font.Gotham
    box.Parent = scrollFrame
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
    return box
end

-- ==============================================
-- MEMBUAT SEMUA TOMBOL FITUR
-- ==============================================
local flyBtn = CreateButton("✈️ Fly: OFF", function(btn)
    Settings.Fly = not Settings.Fly
    btn.Text = "✈️ Fly: " .. (Settings.Fly and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Fly and Color3.fromRGB(200, 0, 100) or Color3.fromRGB(60, 30, 45)
    
    MobileFlyPad.Visible = Settings.Fly -- Tampilkan/sembunyikan tombol virtual HP

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

local flySpeedBox = CreateTextBox("Fly Speed (Default: 75)")
local walkSpeedBox = CreateTextBox("Walk Speed (Default: 16)")
local jumpPowerBox = CreateTextBox("Jump Power (Default: 50)")

CreateButton("SET ALL SPEEDS", function()
    Settings.FlySpeed = tonumber(flySpeedBox.Text) or 75
    Settings.WalkSpeed = tonumber(walkSpeedBox.Text) or 16
    Settings.JumpPower = tonumber(jumpPowerBox.Text) or 50
    if CurrentHumanoid then
        CurrentHumanoid.WalkSpeed = Settings.WalkSpeed
        CurrentHumanoid.JumpPower = Settings.JumpPower
    end
    print("Kecepatan di-set!")
end)

CreateButton("👻 Noclip: OFF", function(btn) Settings.Noclip = not Settings.Noclip; btn.Text = "👻 Noclip: " .. (Settings.Noclip and "ON" or "OFF") end)
CreateButton("💀 God Mode: OFF", function(btn) Settings.GodMode = not Settings.GodMode; btn.Text = "💀 God Mode: " .. (Settings.GodMode and "ON" or "OFF") end)
CreateButton("♾️ Infinite Jump: OFF", function(btn) Settings.InfJump = not Settings.InfJump; btn.Text = "♾️ Infinite Jump: " .. (Settings.InfJump and "ON" or "OFF") end)

-- ==============================================
-- LOOP UTAMA (LOGIKA SEMUA FITUR)
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

    -- LOGIKA FLY (PC + MOBILE HYBRID)
    if Settings.Fly and FlyBodyVelocity then
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new()
        
        -- Input Horizontal (Joystick HP & WASD PC)
        local joystickMove = (cam.CFrame.LookVector * -CurrentHumanoid.MoveDirection.Z) + (cam.CFrame.RightVector * CurrentHumanoid.MoveDirection.X)
        if joystickMove.Magnitude > 0.1 then -- Jika joystick digerakkan
            moveDir += joystickMove
        else -- Jika tidak, cek keyboard PC
            if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
        end
        
        -- Input Vertikal (Tombol Virtual HP & Keyboard PC)
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

print("✅ ZHAK FINAL v3.0 LOADED! Mobile Fly Support aktif.")
