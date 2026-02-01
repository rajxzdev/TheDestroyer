-- [REAI-CODEX ULTIMATE] Roblox Mobile Exploit v4.0 (ULTIMATE FIX)
-- 🔧 FULL REWRITE + TOUCH EVENTS + DIRECT GUI MANIPULATION

-- 🎮 GUI Initialization
local function init_gui()
    local gui = Instance.new("ScreenGui")
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 99999
    gui.Parent = game:GetService("CoreGui")
    
    -- 🎯 Main Frame (Grava Hub Style)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.4, 0, 0.7, 0)
    frame.Position = UDim2.new(0.3, 0, 0.15, 0)
    frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    frame.BackgroundTransparency = 0.2
    frame.BorderColor3 = Color3.fromRGB(0,150,255)
    frame.BorderSizePixel = 2
    frame.Parent = gui
    
    -- 🖼️ Title Bar
    local title = Instance.new("TextLabel")
    title.Text = "Grava Hub v4.0"
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.BackgroundColor3 = Color3.fromRGB(30,30,30)
    title.TextColor3 = Color3.fromRGB(0,150,255)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 14
    title.Parent = frame
    
    -- 🚫 Close Button (TOUCH EVENT)
    local closeBtn = Instance.new("TextButton")
    closeBtn.Text = "X"
    closeBtn.Size = UDim2.new(0.1, 0, 1, 0)
    closeBtn.Position = UDim2.new(0.9, 0, 0, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
    closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
    closeBtn.Font = Enum.Font.SourceSansBold
    closeBtn.Parent = title
    
    -- 📐 Minimize Button (TOUCH EVENT)
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Text = "-"
    minimizeBtn.Size = UDim2.new(0.1, 0, 1, 0)
    minimizeBtn.Position = UDim2.new(0.8, 0, 0, 0)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
    minimizeBtn.TextColor3 = Color3.fromRGB(255,255,255)
    minimizeBtn.Font = Enum.Font.SourceSansBold
    minimizeBtn.Parent = title
    
    -- 🛠️ Control Buttons (TOUCH EVENTS)
    local speedBtn = createButton(frame, "Speed: 16", 0, 0.1)
    local flyBtn = createButton(frame, "Fly: 100", 0, 0.2)
    local jumpBtn = createButton(frame, "Jump: 50", 0, 0.3)
    local wallHackBtn = createButton(frame, "Wall Hack: OFF", 0, 0.4)
    
    -- 🎮 Button Creation Helper
    local function createButton(parent, text, x, y)
        local btn = Instance.new("TextButton")
        btn.Text = text
        btn.Size = UDim2.new(1, 0, 0.15, 0)
        btn.Position = UDim2.new(x, 0, y, 0)
        btn.BackgroundColor3 = Color3.fromRGB(255,255,255)
        btn.TextColor3 = Color3.fromRGB(0,150,255)
        btn.Font = Enum.Font.SourceSansBold
        btn.BorderSizePixel = 1
        btn.BorderColor3 = Color3.fromRGB(0,150,255)
        btn.Parent = parent
        
        -- DEBUG OUTPUT
        warn("Created button: " .. text .. " at Y=" .. y)
        
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
    
    -- 📲 TOUCH EVENT HANDLERS (FOR MOBILE)
    local function onTouchInput(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            local position = input.Position
            local hit = frame:FindFirstChildOfClass("TextButton") and frame:FindFirstChildOfClass("TextButton"):HitTest(position)
            
            if hit then
                local btn = hit.Parent
                if btn:IsA("TextButton") then
                    warn("Touched: " .. btn.Text)
                    
                    if btn.Text:match("Speed") then
                        local newVal = 16 + (math.random() * 20)
                        applySpeed(newVal)
                        btn.Text = "Speed: " .. newVal
                    elseif btn.Text:match("Fly") then
                        local newVal = 100 + (math.random() * 100)
                        applyFly(newVal)
                        btn.Text = "Fly: " .. newVal
                    elseif btn.Text:match("Jump") then
                        local newVal = 50 + (math.random() * 50)
                        applyJump(newVal)
                        btn.Text = "Jump: " .. newVal
                    elseif btn.Text:match("Wall Hack") then
                        toggleWallHack()
                    elseif btn.Text == "X" then
                        frame:Destroy()
                    elseif btn.Text == "-" then
                        local minimized = frame.Size.Y.Scale < 0.2
                        frame.Size = UDim2.new(0.4, 0, minimized and 0.7 or 0.1, 0)
                        btn.Text = minimized and "+" or "-"
                    end
                end
            end
        end
    end
    
    game:GetService("UserInputService").InputBegan:Connect(onTouchInput)
    
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
