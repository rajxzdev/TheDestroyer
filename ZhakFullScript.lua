-- ZHAK-GPT FINAL SCRIPT (2025)
-- Fitur: Fly, Speed, Noclip, God Mode, Troll Part, Device Detector, Open/Close/Minimize

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==============================================
-- SETTINGS
-- ==============================================
local Settings = {
    Fly = false,
    FlySpeed = 75,
    WalkSpeed = 50,
    JumpPower = 75,
    Noclip = false,
    GodMode = false,
    InfiniteJump = false,
    TrollSize = 10,
    Minimized = false
}

local CurrentChar, CurrentHumanoid = nil, nil

-- ==============================================
-- DETEKSI DEVICE (MOBILE/PC)
-- ==============================================
local isMobile = UIS.TouchEnabled
local screenSize = workspace.CurrentCamera.ViewportSize
local scaleFactor = isMobile and 0.8 or 1.0  -- Skala GUI lebih kecil di mobile

-- ==============================================
-- GUI PARENT (CoreGui/PlayerGui)
-- ==============================================
local function GetGuiParent()
    local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if success and coreGui then return coreGui end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local parent = GetGuiParent()

-- Hapus GUI lama jika ada
if parent:FindFirstChild("ZhakFinalGUI") then
    parent.ZhakFinalGUI:Destroy()
end

-- ==============================================
-- BUILD GUI
-- ==============================================
local gui = Instance.new("ScreenGui")
gui.Name = "ZhakFinalGUI"
gui.Parent = parent
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MAIN FRAME (Ukuran otomatis menyesuaikan device)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320 * scaleFactor, 0, 480 * scaleFactor)
mainFrame.Position = UDim2.new(0.5, -160 * scaleFactor, 0.5, -240 * scaleFactor)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- HEADER (Tombol Open/Close/Minimize)
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 1, 0)
title.Position = UDim2.new(0.05, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ZHAK FINAL SCRIPT"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = header

-- TOMBOL MINIMIZE
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
minimizeBtn.Text = "–"
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.Parent = header

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeBtn

-- TOMBOL CLOSE
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- SCROLLING FRAME (Agar bisa discroll di HP)
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -50)
scrollFrame.Position = UDim2.new(0, 5, 0, 45)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 5
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Akan otomatis bertambah
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.Parent = scrollFrame

-- ==============================================
-- FUNGSI BANTU (Membuat Tombol, Label, dll)
-- ==============================================
local function CreateLabel(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.9, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(0, 200, 120)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.Parent = scrollFrame
    return label
end

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = scrollFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

local function CreateTextBox(placeholder)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.9, 0, 0, 30)
    box.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.new(1,1,1)
    box.PlaceholderColor3 = Color3.fromRGB(150,150,150)
    box.Font = Enum.Font.Gotham
    box.TextSize = 12
    box.Parent = scrollFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = box
    return box
end

-- ==============================================
-- TOMBOL MINIMIZE (Fungsi)
-- ==============================================
minimizeBtn.MouseButton1Click:Connect(function()
    Settings.Minimized = not Settings.Minimized
    if Settings.Minimized then
        mainFrame.Size = UDim2.new(0, 320 * scaleFactor, 0, 40)
        minimizeBtn.Text = "+"
    else
        mainFrame.Size = UDim2.new(0, 320 * scaleFactor, 0, 480 * scaleFactor)
        minimizeBtn.Text = "–"
    end
end)

-- TOMBOL CLOSE (Fungsi)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    print("[ZHAK] GUI ditutup")
end)

-- ==============================================
-- SEMUA FITUR
-- ==============================================
CreateLabel("⚡ MOVEMENT")

-- Fly Toggle
local flyBtn = CreateButton("✈️ Fly: OFF", function(btn)
    Settings.Fly = not Settings.Fly
    btn.Text = "✈️ Fly: " .. (Settings.Fly and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Fly and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(40, 40, 45)
end)

-- Fly Speed
CreateButton("🚀 ↑ Fly Speed", function()
    Settings.FlySpeed = Settings.FlySpeed + 25
    if Settings.FlySpeed > 200 then Settings.FlySpeed = 25 end
    print("[ZHAK] Fly Speed →", Settings.FlySpeed)
end)

-- Walk Speed
CreateButton("🏃 ↑ Walk Speed", function()
    Settings.WalkSpeed = Settings.WalkSpeed + 25
    if Settings.WalkSpeed > 200 then Settings.WalkSpeed = 16 end
    if CurrentHumanoid then CurrentHumanoid.WalkSpeed = Settings.WalkSpeed end
    print("[ZHAK] Walk Speed →", Settings.WalkSpeed)
end)

-- Jump Power
CreateButton("🦘 ↑ Jump Power", function()
    Settings.JumpPower = Settings.JumpPower + 25
    if Settings.JumpPower > 200 then Settings.JumpPower = 50 end
    if CurrentHumanoid then CurrentHumanoid.JumpPower = Settings.JumpPower end
    print("[ZHAK] Jump Power →", Settings.JumpPower)
end)

CreateLabel("🛡️ CHEATS")

-- Noclip
local noclipBtn = CreateButton("👻 Noclip: OFF", function(btn)
    Settings.Noclip = not Settings.Noclip
    btn.Text = "👻 Noclip: " .. (Settings.Noclip and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Noclip and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(40, 40, 45)
end)

-- God Mode
local godBtn = CreateButton("💀 God Mode: OFF", function(btn)
    Settings.GodMode = not Settings.GodMode
    btn.Text = "💀 God Mode: " .. (Settings.GodMode and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.GodMode and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(40, 40, 45)
end)

-- Infinite Jump
local infJumpBtn = CreateButton("♾️ Infinite Jump: OFF", function(btn)
    Settings.InfiniteJump = not Settings.InfiniteJump
    btn.Text = "♾️ Infinite Jump: " .. (Settings.InfiniteJump and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.InfiniteJump and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(40, 40, 45)
end)

CreateLabel("🧟 TROLL")

local trollTarget = CreateTextBox("Ketik nama player target")

-- Ukuran Part
CreateButton("📏 Ukuran Part: 10", function()
    Settings.TrollSize = Settings.TrollSize + 5
    if Settings.TrollSize > 30 then Settings.TrollSize = 5 end
    print("[ZHAK] Troll Part Size →", Settings.TrollSize)
end)

-- Spawn Part
CreateButton("💥 Spawn Part di Atas Target", function()
    local name = trollTarget.Text
    if name == "" then
        print("[ZHAK] Masukkan nama dulu")
        return
    end
    local target = Players:FindFirstChild(name)
    if not target or not target.Character then
        print("[ZHAK] Target tidak valid")
        return
    end
    local root = target.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local part = Instance.new("Part")
    part.Size = Vector3.new(Settings.TrollSize, Settings.TrollSize, Settings.TrollSize)
    part.Position = root.Position + Vector3.new(0, Settings.TrollSize + 10, 0)
    part.Anchored = false
    part.CanCollide = true
    part.Material = Enum.Material.Neon
    part.Color = Color3.fromRGB(255, 0, 0)
    part.Density = 100
    part.Parent = workspace

    task.delay(8, function()
        if part.Parent then part:Destroy() end
    end)
end)

-- ==============================================
-- MAIN LOOP (Fly, Noclip, God, dll)
-- ==============================================
RunService.Heartbeat:Connect(function()
    -- Update karakter
    if LocalPlayer.Character ~= CurrentChar then
        CurrentChar = LocalPlayer.Character
        CurrentHumanoid = CurrentChar and CurrentChar:FindFirstChildOfClass("Humanoid")
        if CurrentHumanoid then
            CurrentHumanoid.WalkSpeed = Settings.WalkSpeed
            CurrentHumanoid.JumpPower = Settings.JumpPower
        end
    end
    if not CurrentChar or not CurrentHumanoid then return end

    -- God Mode
    if Settings.GodMode then
        CurrentHumanoid.Health = CurrentHumanoid.MaxHealth
    end

    -- Noclip
    if Settings.Noclip then
        for _,v in pairs(CurrentChar:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end

    -- Fly Logic
    if Settings.Fly then
        CurrentHumanoid.PlatformStand = true
        local cam = workspace.CurrentCamera
        local move = Vector3.new(0,0,0)

        if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0,1,0) end

        if move.Magnitude > 0 then
            local root = CurrentChar:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = root.CFrame + (move.Unit * Settings.FlySpeed * 0.08)
            end
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

print("[ZHAK] SCRIPT LOADED – GUI should be visible now!")
