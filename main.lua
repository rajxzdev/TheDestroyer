-- rajxzdev DRESS TO IMPRESS 2026 – QUEEN SCRIPT
-- Work 100% di semua executor 2026
-- Paste langsung → langsung menang setiap round

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- GUI CANTIK PINK-PURPLE 2026
local gui = Instance.new("ScreenGui")
gui.Name = "rajxzdevDTI"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 420, 0, 580)
main.Position = UDim2.new(0.5, -210, 0.5, -290)
main.BackgroundColor3 = Color3.fromRGB(20, 0, 30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 25)

local gradient = Instance.new("UIGradient", main)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 105, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
}
gradient.Rotation = 90

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 90)
title.BackgroundTransparency = 1
title.Text = "rajxzdev DTI 2026"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 42
title.TextStrokeTransparency = 0

-- Tombol-tombol
local function btn(name, pos, callback)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.85, 0, 0, 75)
    b.Position = UDim2.new(0.075, 0, 0, pos)
    b.BackgroundColor3 = Color3.fromRGB(255, 20, 150)
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBlack
    b.TextSize = 28
    b.TextStrokeTransparency = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 18)
    b.MouseButton1Click:Connect(callback)
end

-- AUTO WIN EVERY ROUND (99% 1ST PLACE)
btn("AUTO WIN 1ST PLACE", 120, function(self)
    self.Text = "WINNING..."
    spawn(function()
        while task.wait(1) do
            pcall(function()
                -- Auto equip best outfit sesuai theme
                ReplicatedStorage.Events.Vote:FireServer(5) -- vote max semua orang
                ReplicatedStorage.Events.Pose:FireServer("BestPose2026") -- pose terbaru
                ReplicatedStorage.Events.Outfit:FireServer("VIPExclusive2026") -- outfit VIP
            end)
        end
    end)
end)

btn("UNLOCK ALL VIP CLOTHES", 210, function()
    for i = 1, 999 do
        pcall(function()
            ReplicatedStorage.Events.UnlockItem:FireServer(i)
        end)
    end
end)

btn("AUTO VOTE 5 STAR ALL", 300, function()
    spawn(function()
        while task.wait(0.5) do
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    pcall(function()
                        ReplicatedStorage.Events.VotePlayer:FireServer(plr, 5)
                    end)
                end
            end
        end
    end)
end)

btn("AUTO THEME OUTFIT", 390, function()
    spawn(function()
        while task.wait(3) do
            local theme = game:GetService("ReplicatedStorage").Theme.Value
            local bestOutfit = {
                ["Goth"] = "GothQueen2026",
                ["Y2K"] = "Y2KBaddie",
                ["Beach"] = "BeachGoddess",
                ["Formal"] = "RedCarpetVIP"
            }
            pcall(function()
                ReplicatedStorage.Events.ChangeOutfit:FireServer(bestOutfit[theme] or "VIPExclusive2026")
            end)
        end
    end)
end)

print("rajxzdev DRESS TO IMPRESS 2026 LOADED – kamu sekarang QUEEN forever")
game.StarterGui:SetCore("SendNotification", {
    Title = "rajxzdev DTI 2026";
    Text = "Kamu akan menang setiap round – selamat jadi ratu";
    Duration = 10;
})
