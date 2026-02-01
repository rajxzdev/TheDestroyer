-- [REAI-CODEX ULTIMATE] Roblox Mobile Exploit v3.6 (Delta + Grava Hub Branding)
-- 🎨 Full UI Refresh + Wall Hack Fix

-- 🎮 GUI Layout with Grava Hub Branding
local function init_gui()
    local gui = Instance.new("ScreenGui")
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 99999
    gui.Parent = game:GetService("CoreGui")
    
    -- 🎯 Main Frame (Grava Hub Style)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.4, 0, 0.4, 0)
    frame.Position = UDim2.new(0.3, 0, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    frame.BackgroundTransparency = 0.2
    frame.BorderColor3 = Color3.fromRGB(0,150,255)  -- Grava Blue
    frame.BorderSizePixel = 2
    frame.Parent = gui
    
    -- 🖼️ Title Bar with Grava Logo
    local title = Instance.new("TextLabel")
    title.Text = "Grava Hub v3.6"
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.BackgroundColor3 = Color3.fromRGB(30,30,30)
    title.TextColor3 = Color3.fromRGB(0,150,255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.Parent = frame
    
    -- 🛠️ Control Buttons
    local speedBtn = createButton(frame, "Speed: 16", 0, 0.1)
    local flyBtn = createButton(frame, "Fly: 100", 0, 0.25)
    local jumpBtn = createButton(frame, "Jump: 50", 0, 0.4)
    local wallHackBtn = createButton(frame, "Wall Hack: OFF", 0, 0.55)
    
    -- 🎮 Button Creation Helper
    local function createButton(parent, text, x, y)
        local btn = Instance.new("TextButton")
        btn.Text = text
        btn.Size = UDim2.new(1, 0, 0.2, 0)
        btn.Position = UDim2.new(x, 0, y, 0)
        btn.BackgroundColor3 = Color3.fromRGB(255,255,255)
        btn.TextColor3 = Color3.fromRGB(0,150,255)
        btn.Font = Enum.Font.Gotham
        btn.BorderSizePixel = 1
        btn.BorderColor3 = Color3.fromRGB(0,150,255)
        btn.Parent = parent
        return btn
    end
    
    -- 🛡️ Delta-Specific Evasion
    local function BypassDeltaAC()
        local deltaAC = game:GetService("Players").LocalPlayer:FindFirstChild("DeltaAC")
        if deltaAC then
            deltaAC:Destroy()
        end
    end
    
    BypassDeltaAC()
    
    -- 🧪 Core Exploit Functions
    local function applySpeed(value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        end)
    end
    
    local function applyFly(value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.FlySpeed = value
            game.Players.LocalPlayer.Character.Humanoid.CanFly = true
        end)
    end
    
    local function applyJump(value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
        end)
    end
    
    local function toggleWallHack()
        pcall(function()
            local state = wallHackBtn.Text:match("ON") and "OFF" or "ON"
            wallHackBtn.Text = "Wall Hack: " .. state
            
            local char = game.Players.LocalPlayer.Character
            local rootPart = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
            
            if rootPart then
                rootPart.Anchored = (state == "ON")
                rootPart.Transparency = (state == "ON") and 1 or 0
                rootPart.CanCollide = (state == "OFF")
                
                if state == "ON" then
                    warn("✅ Wall Hack ON - Can walk through walls")
                else
                    warn("❌ Wall Hack OFF - Normal collision")
                end
            else
                warn("❗ RootPart not found! Try rejoining the game.")
            end
        end)
    end
    
    -- 📲 Button Handlers
    speedBtn.MouseButton1Down:Connect(function()
        local newVal = 16 + (math.random() * 20)
        applySpeed(newVal)
        speedBtn.Text = "Speed: " .. newVal
    end)
    
    flyBtn.MouseButton1Down:Connect(function()
        local newVal = 100 + (math.random() * 100)
        applyFly(newVal)
        flyBtn.Text = "Fly: " .. newVal
    end)
    
    jumpBtn.MouseButton1Down:Connect(function()
        local newVal = 50 + (math.random() * 50)
        applyJump(newVal)
        jumpBtn.Text = "Jump: " .. newVal
    end)
    
    wallHackBtn.MouseButton1Down:Connect(toggleWallHack)
    
    -- 🔁 Main Loop
    spawn(function()
        while wait(0.1) do
            if game.Players.LocalPlayer and game.Players.LocalPlayer.Character then
                local char = game.Players.LocalPlayer.Character
                
                char.Humanoid.WalkSpeed = speedBtn.Text:match("%d+")
                char.Humanoid.FlySpeed = flyBtn.Text:match("%d+")
                char.Humanoid.JumpPower = jumpBtn.Text:match("%d+")
            end
        end
    end)
end

-- 🧪 Delta Test Procedure
local function main()
    -- Wait for character to load
    while not game.Players.LocalPlayer.Character do
        wait(0.5)
    end
    
    init_gui()
end

main()
