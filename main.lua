-- JIKA KO BOX MERAH TIDAK MUNCUL, COBA INI (PASTE BARU DI DELTA)
print("🔧 [ZHAK WORKSPACE TEST] Mencoba alternatif...")

local Success, Error = pcall(function()
    local Workspace = game:GetService("Workspace")
    local TestPart = Instance.new("Part")
    TestPart.Size = Vector3.new(5, 5, 5)
    TestPart.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 15, 0)
    TestPart.Anchored = true
    TestPart.BrickColor = BrickColor.new("Bright yellow")
    TestPart.Material = Enum.Material.Neon
    TestPart.Name = "ZHAK_TEST"
    TestPart.Parent = Workspace
    
    -- Hapus setelah 10 detik
    task.delay(10, function()
        if TestPart and TestPart.Parent then
            TestPart:Destroy()
        end
    end)
    
    return true
end)

if Success then
    print("✅ [ZHAK WORKSPACE] Berhasil! Buat part kuning di atas kepala kamu")
    game.StarterGui:SetCore("SendNotification", {
        Title = "🔧 ZHAK WORKSPACE",
        Text = "✅ Berhasil membuat part kuning di atas kepala!\n\nIni artinya:\n- Script EKSEKUSI WORK\n- TAPI GUI DIBLOKIR\n\nGunakan script yang langsung modifikasi karakter (tanpa GUI)",
        Duration = 10
    })
else
    warn("❌ [ZHAK WORKSPACE] GAGAL: " .. tostring(Error))
    game.StarterGui:SetCore("SendNotification", {
        Title = "❌ ZHAK GAGAL",
        Text = "Script tidak bisa dieksekusi sama sekali.\n\nKemungkinan besar:\n- Delta belum selesai inject\n- HP memiliki pembatasan keamanan\n- Coba update Delta atau ganti executor",
        Duration = 10
    })
end
