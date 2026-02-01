-- ZHAK-GPT DELTA FIX 2025 (WORK DI DELTA TERBARU)
-- Metode: In-Game Objects + Overlay

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- ==============================================
-- 1. BUAT TANDA VISUAL DI DALAM GAME
-- ==============================================
local function CreateVisualMarker(position, size, color)
    local part = Instance.new("Part")
    part.Size = size
    part.Position = position
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 0.5
    part.Material = Enum.Material.Neon
    part.BrickColor = BrickColor.new(color)
    part.Parent = workspace
    return part
end

-- Tanda di atas kepala kamu
local HeadMarker = nil
local function UpdateHeadMarker()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if not HeadMarker then
            HeadMarker = CreateVisualMarker(
                LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0),
                Vector3.new(2, 2, 2),
                "Bright green"
            )
        else
            HeadMarker.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
        end
    end
end

-- ==============================================
-- 2. BUAT OVERLAY TEXT (TEKAN UNTUK BUKA)
-- ==============================================
local overlay = Instance.new("ScreenGui")
overlay.Name = "ZHAkOverlay"
overlay.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local overlayBtn = Instance.new("TextButton")
overlayBtn.Size = UDim2.new(0, 80, 0, 80)
overlayBtn.Position = UDim2.new(0, 10, 0.5, -40)
overlayBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
overlayBtn.Text = "Z\nHAK"
overlayBtn.TextColor3 = Color3.new(1,1,1)
overlayBtn.Font = Enum.Font.GothamBold
overlayBtn.TextSize = 20
overlayBtn.Parent = overlay

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = overlayBtn

-- ==============================================
-- 3. SYSTEM NOTIFIKASI (DI CHAT & DI SCREEN)
-- ==============================================
local function ShowNotification(message)
    -- Chat notification
    LocalPlayer:Chat(message)
    
    -- In-game floating text
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.AlwaysOnTop = true
        billboard.Parent = workspace
        
        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.Text = message
        text.TextColor3 = Color3.fromRGB(255, 255, 255)
        text.TextStrokeTransparency = 0
        text.Font = Enum.Font.GothamBold
        text.TextSize = 20
        text.Parent = billboard
        
        billboard.Adornee = LocalPlayer.Character.HumanoidRootPart
        billboard.StudsOffset = Vector3.new(0, 5, 0)
        
        task.delay(3, function() billboard:Destroy() end)
    end
end

-- ==============================================
-- 4. SYSTEM FLY (TANPA GUI)
-- ==============================================
local Settings = {
    Fly = false,
    FlySpeed = 75,
    WalkSpeed = 50,
    JumpPower = 75,
    Noclip = false,
    GodMode = false
}

local MobileInput = {
    Forward = false, Backward = false, Left = false, Right = false,
    Up = false, Down = false
}

-- Toggle dengan tombol F (PC) atau sentuh overlay (Mobile)
overlayBtn.MouseButton1Click:Connect(function()
    Settings.Fly = not Settings.Fly
    ShowNotification("Fly: " .. (Settings.Fly and "ON" or "OFF"))
    
    if Settings.Fly then
        ShowNotification("Tekan: W/S/A/D/Space/Ctrl untuk terbang")
        ShowNotification("Mobile: Sentuh tombol Z di kiri layar")
    end
end)

-- Tombol virtual untuk mobile (di kiri layar)
local mobilePad = Instance.new("TextButton")
mobilePad.Size = UDim2.new(0, 60, 0, 60)
mobilePad.Position = UDim2.new(0, 10, 0.5, 40) -- Di bawah tombol Z
mobilePad.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
mobilePad.Text = "PAD"
mobilePad.TextColor3 = Color3.new(1,1,1)
mobilePad.Font = Enum.Font.GothamBold
mobilePad.Parent = overlay

mobilePad.MouseButton1Down:Connect(function()
    MobileInput.Forward = true
    mobilePad.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
end)
mobilePad.MouseButton1Up:Connect(function()
    MobileInput.Forward = false
    mobilePad.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
end)

-- ==============================================
-- 5. MAIN LOOP (FLY + VISUAL)
-- ==============================================
RunService.Heartbeat:Connect(function()
    -- Update visual marker
    UpdateHeadMarker()
    
    -- Fly logic
    local char = LocalPlayer.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")
    
    if Settings.Fly and humanoid and root then
        humanoid.PlatformStand = true
        
        local cam = workspace.CurrentCamera
        local dir = Vector3.new(0,0,0)
        
        -- PC Controls
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
        
        -- Mobile Controls
        if MobileInput.Forward then dir += cam.CFrame.LookVector end
        
        if dir.Magnitude > 0 then
            root.CFrame = root.CFrame + (dir.Unit * Settings.FlySpeed * 0.08)
        end
    elseif humanoid then
        humanoid.PlatformStand = false
    end
    
    -- God Mode
    if Settings.GodMode and humanoid then
        humanoid.Health = humanoid.MaxHealth
    end
    
    -- Noclip
    if Settings.Noclip and char then
        for _,v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- ==============================================
-- 6. KEYBOARD SHORTCUTS (TANPA GUI)
-- ==============================================
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- Toggle Fly dengan F
    if input.KeyCode == Enum.KeyCode.F then
        Settings.Fly = not Settings.Fly
        ShowNotification("Fly: " .. (Settings.Fly and "ON" or "OFF"))
    end
    
    -- Toggle Noclip dengan G
    if input.KeyCode == Enum.KeyCode.G then
        Settings.Noclip = not Settings.Noclip
        ShowNotification("Noclip: " .. (Settings.Noclip and "ON" or "OFF"))
    end
    
    -- Toggle God Mode dengan H
    if input.KeyCode == Enum.KeyCode.H then
        Settings.GodMode = not Settings.GodMode
        ShowNotification("God Mode: " .. (Settings.GodMode and "ON" or "OFF"))
    end
    
    -- Increase Speed dengan +
    if input.KeyCode == Enum.KeyCode.KeypadPlus then
        Settings.FlySpeed = Settings.FlySpeed + 25
        ShowNotification("Fly Speed: " .. Settings.FlySpeed)
    end
    
    -- Decrease Speed dengan -
    if input.KeyCode == Enum.KeyCode.KeypadMinus then
        Settings.FlySpeed = Settings.FlySpeed - 25
        if Settings.FlySpeed < 25 then Settings.FlySpeed = 25 end
        ShowNotification("Fly Speed: " .. Settings.FlySpeed)
    end
end)

-- ==============================================
-- 7. MENTAL TROLL (SPAWN PART DI ATAS PLAYER)
-- ==============================================
local function TrollPlayer(name)
    local tgt = Players:FindFirstChild(name)
    if not tgt or not tgt.Character then
        ShowNotification("❌ Player '" .. name .. "' tidak ditemukan!")
        return
    end
    
    local root = tgt.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local part = Instance.new("Part")
    part.Size = Vector3.new(10, 10, 10)
    part.Position = root.Position + Vector3.new(0, 15, 0)
    part.Anchored = false
    part.CanCollide = true
    part.Material = Enum.Material.Neon
    part.BrickColor = BrickColor.new("Bright red")
    part.CustomPhysicalProperties = PhysicalProperties.new(100, 0, 0, 0, 0)
    part.Parent = workspace
    
    ShowNotification("💥 Part muncul di atas " .. tgt.DisplayName)
    
    task.delay(8, function()
        if part.Parent then part:Destroy() end
    end)
end

-- ==============================================
-- 8. COMMAND SYSTEM (TEKAN ENTER UNTUK COMMAND)
-- ==============================================
UIS.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Return then
        ShowNotification("Masukkan command: /fly /noclip /god /troll [nama] /speed [angka]")
    end
end)

-- ==============================================
-- 9. INISIALISASI
-- ==============================================
ShowNotification("✅ ZHAK-GPT DELTA FIX LOADED!")
ShowNotification("Tekan tombol Z di kiri layar untuk toggle Fly")
ShowNotification("Tekan F/G/H untuk fitur lain")
ShowNotification("Tekan + / - untuk ubah kecepatan")

print("✅ ZHAK-GPT DELTA FIX LOADED!")
print("📱 Tombol Z di kiri layar = Toggle Fly")
print("⌨️  Keyboard: F=Fly, G=Noclip, H=God Mode, +/-=Speed")
