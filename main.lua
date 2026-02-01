-- Zhak-GPT Mobile FIX (Auto GUI)
-- Jalankan di: Fluxus Mobile, Delta, Wave, Krnl

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Debug
print("🔥 SYSTEM: Loading Zhak-GPT Mobile Fix...")

-- ==============================================
// TAMPILKAN TOAST MESSAGE (PENGKONFIRMASI)
// ==============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZhakLoader"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 100)
frame.Position = UDim2.new(0.5, -150, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Parent = screenGui

local text = Instance.new("TextLabel")
text.Size = UDim2.new(1, 0, 1, 0)
text.BackgroundTransparency = 1
text.Text = "ZHAK GUI LOADED!\n\nTekan Tombol Hijau di GUI untuk Buka/Tutup."
text.TextColor3 = Color3.fromRGB(255, 50, 50)
text.Font = Enum.Font.GothamBold
text.TextSize = 16
text.TextScaled = true
text.Parent = frame

-- Hapus toast setelah 2 detik
task.delay(2, function()
    if screenGui then screenGui:Destroy() end
end)

-- ==============================================
// USER NAMA KAMU (AGAR MUDAH DIOPIK)
// ==============================================
local MyName = LocalPlayer.Name
print("👋 Selamat datang, User: " .. MyName)

-- ==============================================
// FITUR LAINNYA
// ==============================================
local Settings = {
    Fly = false,
    FlySpeed = 75,
    WalkSpeed = 50,
    JumpPower = 75,
    Noclip = false,
    InfiniteJump = false,
    GodMode = false,
    TrollPartSize = 10,
    Spectating = false
}

local MobileInput = {
    Forward = false, Backward = false, Left = false, Right = false,
    Up = false, Down = false
}

local CurrentChar, CurrentHumanoid, spectateConnection, isMinimized = nil, nil, nil, false

-- ==============================================
// GUI UTAMA
// ==============================================
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "ZhakUniversalGUI"
MainGui.Parent = LocalPlayer.PlayerGui
MainGui.ResetOnSpawn = false
MainGui.Enabled = true -- FIX: MEMBUAT MUNCUL LANGSUNG

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = MainGui

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
Header.Parent = MainFrame

local HeaderText = Instance.new("TextLabel")
HeaderText.Size = UDim2.new(0.8, 0, 1, 0)
HeaderText.BackgroundTransparency = 1
HeaderText.Text = "📱 ZHAK MOBILE FIXED"
HeaderText.TextColor3 = Color3.new(1,1,1)
HeaderText.Font = Enum.Font.GothamBold
HeaderText.Parent = Header

-- TOMBOL BESAR TOGGLE DI HEADER (SOLUSI MOBILE)
local BigToggle = Instance.new("TextButton")
BigToggle.Size = UDim2.new(0, 40, 0, 40)
BigToggle.Position = UDim2.new(1, -45, 0.5, -20)
BigToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BigToggle.Text = "TGL"
BigToggle.Font = Enum.Font.GothamBold
BigToggle.TextSize = 14
BigToggle.Parent = Header

BigToggle.MouseButton1Click:Connect(function()
    if MainFrame.Visible then
        MainFrame.Visible = false
        print("GUI Tutup")
    else
        MainFrame.Visible = true
        print("GUI Buka")
    end
end)

-- ==============================================
// SEMUA FITUR (FULL LIST)
// ==============================================

local function CreateToggle(text, yPos, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.92, 0, 0, 35)
    Btn.Position = UDim2.new(0.04, 0, yPos, 0)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Btn.Text = text
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 14
    Btn.Parent = MainFrame

    Btn.MouseButton1Click:Connect(function()
        callback(Btn)
    end)
    return Btn
end

-- --- BUTTON FLY ---
local FlyBtn = CreateToggle("✈️ Fly: OFF", 0.12, function(btn)
    Settings.Fly = not Settings.Fly
    btn.Text = "✈️ Fly: " .. (Settings.Fly and "ON" or "OFF")
    if CurrentHumanoid then CurrentHumanoid.PlatformStand = Settings.Fly end
end)

-- --- SLIDERS ---
-- Skrip membuat slider (disederhanakan untuk cepat)
local function CreateSlider(labelText, yPos, min, max, default, onChange)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.Position = UDim2.new(0, 0, yPos, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText .. ": " .. default
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.Parent = MainFrame

    local Slider = Instance.new("Frame")
    Slider.Size = UDim2.new(0.92, 0, 0, 6)
    Slider.Position = UDim2.new(0.04, 0, yPos + 0.035, 0)
    Slider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    Slider.Parent = MainFrame

    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new(default/max, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    SliderFill.Parent = Slider

    local SliderBtn = Instance.new("TextButton")
    SliderBtn.Size = UDim2.new(0, 12, 0, 12)
    SliderBtn.Position = UDim2.new(default/max, -6, 0.5, -6)
    SliderBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    SliderBtn.Parent = Slider

    local dragging = false
    SliderBtn.MouseButton1Down:Connect(function() dragging = true end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    RunService.Heartbeat:Connect(function()
        if dragging then
            local pos = UIS:GetMouseLocation()
            local rel = math.clamp((pos.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X, 0, 1)
            local val = math.floor(rel * max)
            SliderFill.Size = UDim2.new(rel, 0, 1, 0)
            SliderBtn.Position = UDim2.new(rel, -6, 0.5, -6)
            Label.Text = labelText .. ": " .. val
            onChange(val)
        end
    end)
end

CreateSlider("🚀 Fly Speed", 0.22, 10, 200, Settings.FlySpeed, function(v) Settings.FlySpeed = v end)
CreateSlider("🏃 Walk Speed", 0.35, 16, 200, Settings.WalkSpeed, function(v) 
    Settings.WalkSpeed = v 
    if CurrentHumanoid then CurrentHumanoid.WalkSpeed = v end 
end)
CreateSlider("🦘 Jump Power", 0.48, 50, 200, Settings.JumpPower, function(v) 
    Settings.JumpPower = v 
    if CurrentHumanoid then CurrentHumanoid.JumpPower = v end 
end)

-- --- TOGGLES LAINNYA ---
CreateToggle("👻 Noclip: OFF", 0.61, function(btn)
    Settings.Noclip = not Settings.Noclip
    btn.Text = "👻 Noclip: " .. (Settings.Noclip and "ON" or "OFF")
end)
CreateToggle("💀 God Mode: OFF", 0.68, function(btn)
    Settings.GodMode = not Settings.GodMode
    btn.Text = "💀 God Mode: " .. (Settings.GodMode and "ON" or "OFF")
end)
CreateToggle("♾️ Infinite Jump: OFF", 0.75, function(btn)
    Settings.InfiniteJump = not Settings.InfiniteJump
    btn.Text = "♾️ Infinite Jump: " .. (Settings.InfiniteJump and "ON" or "OFF")
end)

-- --- MENTAL TROLL ---
local TrollLabel = Instance.new("TextLabel")
TrollLabel.Size = UDim2.new(1, 0, 0, 20)
TrollLabel.Position = UDim2.new(0, 0, 0.82, 0)
TrollLabel.BackgroundTransparency = 1
TrollLabel.Text = "🧟‍♂️ MENTAL TROLL"
TrollLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
TrollLabel.Font = Enum.Font.GothamBold
TrollLabel.Parent = MainFrame

local TrollTargetBox = Instance.new("TextBox")
TrollTargetBox.Size = UDim2.new(0.88, 0, 0, 30)
TrollTargetBox.Position = UDim2.new(0.06, 0, 0.87, 0)
TrollTargetBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TrollTargetBox.Text = "Ketik nama player target"
TrollTargetBox.TextColor3 = Color3.new(1,1,1)
TrollTargetBox.Parent = MainFrame

CreateSlider("📏 Ukuran Part", 0.92, 1, 30, Settings.TrollPartSize, function(v) Settings.TrollPartSize = v end)

local TrollBtn = Instance.new("TextButton")
TrollBtn.Size = UDim2.new(0.92, 0, 0, 35)
TrollBtn.Position = UDim2.new(0.04, 0, 0.99, 0)
TrollBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
TrollBtn.Text = "💥 TROLL TARGET!"
TrollBtn.TextColor3 = Color3.new(1,1,1)
TrollBtn.Font = Enum.Font.GothamBold
TrollBtn.Parent = MainFrame

TrollBtn.MouseButton1Click:Connect(function()
    local tgt = Players:FindFirstChild(TrollTargetBox.Text)
    if not tgt or not tgt.Character then return warn("❌ Player tidak ditemukan!") end
    local root = tgt.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local part = Instance.new("Part")
    part.Size = Vector3.new(Settings.TrollPartSize, Settings.TrollPartSize, Settings.TrollPartSize)
    part.Position = root.Position + Vector3.new(0, Settings.TrollPartSize + 8, 0)
    part.Anchored, part.CanCollide, part.Material = false, true, Enum.Material.Neon
    part.Color, part.Density, part.Name = Color3.new(1,0,0), 100, "TROLL_PART"
    part.Parent = workspace
    task.delay(8, function() if part.Parent then part:Destroy() end end)
end)

-- --- PLAYER SPEC ---
local SpecBox = Instance.new("TextBox")
SpecBox.Size = UDim2.new(0.88, 0, 0, 30)
SpecBox.Position = UDim2.new(0.06, 0, 1.11, 0)
SpecBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SpecBox.Text = "Ketik nama player"
SpecBox.TextColor3 = Color3.new(1,1,1)
SpecBox.Parent = MainFrame

local SpecInfo = Instance.new("TextLabel")
SpecInfo.Size = UDim2.new(0.92, 0, 0, 60)
SpecInfo.Position = UDim2.new(0.04, 0, 1.17, 0)
SpecInfo.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SpecInfo.TextColor3 = Color3.new(1,1,1)
SpecInfo.Font = Enum.Font.Gotham
SpecInfo.TextSize = 12
SpecInfo.TextWrapped = true
SpecInfo.Text = "📊 Info player akan muncul disini"
SpecInfo.Parent = MainFrame

local function UpdateSpecInfo()
    local tgt = Players:FindFirstChild(SpecBox.Text)
    if not tgt then return SpecInfo.Text = "❌ Player tidak ditemukan!" end
    local char = tgt.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    SpecInfo.Text = string.format(
        "📊 Info: %s\nUserID: %d\nUmur Akun: %d hari\nHealth: %s/%s\nSpeed: %s",
        tgt.DisplayName, tgt.UserId, tgt.AccountAge,
        hum and math.floor(hum.Health) or "?", hum and hum.MaxHealth or "?",
        hum and hum.WalkSpeed or "?"
    )
end

CreateToggle("🔍 Lihat Info", 1.30, function() UpdateSpecInfo() end)
local SpectateBtn = CreateToggle("🎥 Spectate: OFF", 1.37, function(btn)
    Settings.Spectating = not Settings.Spectating
    btn.Text = "🎥 Spectate: " .. (Settings.Spectating and "ON" or "OFF")
    if not Settings.Spectating and spectateConnection then
        spectateConnection:Disconnect()
        spectateConnection = nil
        if CurrentHumanoid then workspace.CurrentCamera.CameraSubject = CurrentHumanoid end
        return
    end
    local tgt = Players:FindFirstChild(SpecBox.Text)
    if not tgt or not tgt.Character then
        Settings.Spectating = false
        btn.Text = "🎥 Spectate: OFF"
        return warn("❌ Player tidak ditemukan!")
    end
    local root = tgt.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    spectateConnection = RunService.Heartbeat:Connect(function()
        if Settings.Spectating and root.Parent then
            local cam = workspace.CurrentCamera
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(root.Position + Vector3.new(0,3,8), root.Position), 0.1)
        end
    end)
end)

-- ==============================================
// LOOP UTAMA
// ==============================================
RunService.Heartbeat:Connect(function()
    if MainFrame.Visible == false then return end

    -- Update character
    if LocalPlayer.Character ~= CurrentChar then
        CurrentChar = LocalPlayer.Character
        CurrentHumanoid = CurrentChar and CurrentChar:FindFirstChildOfClass("Humanoid")
        if CurrentHumanoid then
            CurrentHumanoid.WalkSpeed = Settings.WalkSpeed
            CurrentHumanoid.JumpPower = Settings.JumpPower
        end
    end

    -- God Mode
    if Settings.GodMode and CurrentHumanoid then
        CurrentHumanoid.Health = CurrentHumanoid.MaxHealth
    end

    -- Noclip
    if Settings.Noclip and CurrentChar then
        for _,v in pairs(CurrentChar:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end

    -- FLY LOGIC
    if Settings.Fly and CurrentChar and CurrentHumanoid then
        CurrentHumanoid.PlatformStand = true
        local cam = workspace.CurrentCamera
        local dir = Vector3.new(0,0,0)
        
        if UIS:IsKeyDown(Enum.KeyCode.W) or MobileInput.Forward then dir += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) or MobileInput.Backward then dir -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) or MobileInput.Left then dir -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) or MobileInput.Right then dir += cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) or MobileInput.Up then dir += Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or MobileInput.Down then dir -= Vector3.new(0,1,0) end
        
        if dir.Magnitude > 0 and CurrentChar:FindFirstChild("HumanoidRootPart") then
            local root = CurrentChar.HumanoidRootPart
            root.CFrame = root.CFrame + (dir.Unit * Settings.FlySpeed * 0.08)
        end
    elseif CurrentHumanoid then
        CurrentHumanoid.PlatformStand = false
    end
end)

-- Infinite Jump
UIS.JumpRequest:Connect(function()
    if Settings.InfiniteJump and CurrentHumanoid then
        CurrentHumanoid:ChangeState("Jumping")
    end
end)

print("✅ SYSTEM READY! TAMPILKAN TOMBOL HANP DI HEADER MENU GUI")
