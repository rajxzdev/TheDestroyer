-- TEST SCRIPT (JALANKAN INI DULU)
local gui = Instance.new("ScreenGui")
gui.Parent = game:GetService("CoreGui")

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 200, 0, 100)
btn.Position = UDim2.new(0.5, -100, 0.5, -50)
btn.Text = "GUI MUNCUL!"
btn.TextSize = 30
btn.Parent = gui

print("TEST GUI DIBUAT!")
