-- TEST GUI SEDERHANA (PASTI MUNCUL)
print("🚀 TEST GUI DIMULAI...")

-- Buat GUI langsung di CoreGui
local gui = Instance.new("ScreenGui")
gui.Name = "TestGUI_" .. math.random(1000,9999)
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true  -- Penting untuk mobile
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Coba parent ke CoreGui dulu
local success, err = pcall(function()
    gui.Parent = game:GetService("CoreGui")
    print("✅ GUI diparent ke CoreGui")
end)

if not success then
    -- Kalau gagal, coba ke PlayerGui
    local player = game:GetService("Players").LocalPlayer
    if player then
        gui.Parent = player:WaitForChild("PlayerGui")
        print("✅ GUI diparent ke PlayerGui")
    else
        print("❌ Gagal menemukan player")
        return
    end
end

-- Buat frame besar berwarna MERAH (pasti kelihatan)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)  -- Tengah layar
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- MERAH TERANG
frame.BorderSizePixel = 5
frame.BorderColor3 = Color3.new(1,1,1)
frame.Parent = gui

-- Text besar
local text = Instance.new("TextLabel")
text.Size = UDim2.new(1, 0, 1, 0)
text.BackgroundTransparency = 1
text.Text = "✅ GUI MUNCUL!\n\nZHAK-GPT\nSCRIPT WORK!"
text.TextColor3 = Color3.new(1,1,1)
text.Font = Enum.Font.GothamBold
text.TextSize = 24
text.TextScaled = true
text.Parent = frame

-- Tombol close
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 50, 0, 50)
closeBtn.Position = UDim2.new(1, -55, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 30
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    print("✅ GUI ditutup")
end)

-- Tambah efek glow
local glow = Instance.new("UIStroke")
glow.Color = Color3.fromRGB(255, 255, 0)
glow.Thickness = 3
glow.Parent = frame

print("🎯 TEST GUI DIBUAT!")
print("📍 Posisi: Tengah layar")
print("🎨 Warna: Merah terang")
print("📏 Ukuran: 300x200")
print("❌ Tekan 'X' untuk tutup")
