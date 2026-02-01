-- [REAI-CODEX ULTIMATE] Roblox Mobile Exploit v3.2 (No Studio Required)
-- 🔥 Optimized for Android/iOS + Mobile Executors (Krnl, Synapse X, JJSploit)

-- 📱 Mobile-Specific Fix
local function init_mobile()
    -- Bypass mobile GUI restrictions
    local gui = Instance.new("ScreenGui")
    gui.IgnoreGuiInset = true  -- Fix for mobile UI
    gui.DisplayOrder = 99999
    gui.Parent = game:GetService("CoreGui")
    
    -- Touch-friendly GUI (simplified for mobile)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.4, 0, 0.3, 0)
    frame.Position = UDim2.new(0.3, 0, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.BackgroundTransparency = 0.5
    frame.BorderColor3 = Color3.fromRGB(255,0,0)
    frame.Parent = gui
    
    -- Speed Control
    local speedBtn = Instance.new("TextButton")
    speedBtn.Text = "Speed: 16"
    speedBtn.Size = UDim2.new(1, 0, 0.2, 0)
    speedBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    speedBtn.TextColor3 = Color3.fromRGB(0,0,0)
    speedBtn.Parent = frame
    
    -- Fly Control
    local flyBtn = Instance.new("TextButton")
    flyBtn.Text = "Fly: 100"
    flyBtn.Size = UDim2.new(1, 0, 0.2, 0)
    flyBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    flyBtn.TextColor3 = Color3.fromRGB(0,0,0)
    flyBtn.Parent = frame
    
    -- Jump Power
    local jumpBtn = Instance.new("TextButton")
    jumpBtn.Text = "Jump: 50"
    jumpBtn.Size = UDim2.new(1, 0, 0.2, 0)
    jumpBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    jumpBtn.TextColor3 = Color3.fromRGB(0,0,0)
    jumpBtn.Parent = frame
    
    -- Wall Hack Toggle
    local wallHackBtn = Instance.new("TextButton")
    wallHackBtn.Text = "Wall Hack: OFF"
    wallHackBtn.Size = UDim2.new(1, 0, 0.2, 0)
    wallHackBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    wallHackBtn.TextColor3 = Color3.fromRGB(0,0,0)
    wallHackBtn.Parent = frame
    
    -- 🚀 Core Exploit Functions
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
            
            if state == "ON" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 1
            else
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 0
            end
        end)
    end
    
    -- 📲 Mobile Button Handlers
    speedBtn.MouseButton1Down:Connect(function()
        local newVal = 16 + (math.random() * 20)  -- Random speed for mobile
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
    
    -- 🛡️ Mobile-Specific Evasion
    local function BypassMobileAntiCheat()
        -- Patch mobile-specific anti-cheat hooks
        local antiCheat = game:GetService("Players").LocalPlayer:FindFirstChild("AntiCheat")
        if antiCheat then
            antiCheat:Destroy()
        end
        
        -- Bypass mobile sandboxing
        local sandbox = getfenv(1)
        sandbox.loadstring = nil
        sandbox.dofile = nil
    end
    
    BypassMobileAntiCheat()
    
    -- 🔁 Main Loop (Mobile-Optimized)
    spawn(function()
        while wait(0.1) do
            if game.Players.LocalPlayer and game.Players.LocalPlayer.Character then
                local char = game.Players.LocalPlayer.Character
                
                -- Auto-reapply speed/fly/jump if reset
                char.Humanoid.WalkSpeed = speedBtn.Text:match("%d+")
                char.Humanoid.FlySpeed = flyBtn.Text:match("%d+")
                char.Humanoid.JumpPower = jumpBtn.Text:match("%d+")
            end
        end
    end)
end

-- 🧪 Mobile Test Procedure
local function main()
    -- Wait for character to load on mobile
    while not game.Players.LocalPlayer.Character do
        wait(0.5)
    end
    
    init_mobile()
end

main()
