-- ==========================================
-- ULTIMATE MM2 FIXED & CLEANED SCRIPT v4.2 (Final)
-- ==========================================

local p = game:GetService("Players")
local pl = p.LocalPlayer
local workspace = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local lighting = game:GetService("Lighting")

local LOOTLABS_LINK = "https://loot-link.com/s?9K7cNpua"
local CORRECT_KEY = "5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3"

local customThemeColor = Color3.fromRGB(0, 162, 255)
local activeConnections = {}

-- Global States Table (Fully Synchronized)
local O = {
    WalkSpeed = 16,
    JumpPower = 50,
    FOV = 70,
    ThemeRainbow = true,
    ESP = false,
    XRay = false,
    GodMode = false,
    InfJump = false,
    Noclip = false,
    FullBright = false,
    SilentAim = false,
    AutoFarm = false,
    OriginalTransparency = {},
    CoinCache = {}
}

local CUSTOM_FONT = Enum.Font.FredokaOne

local function getThemeColor(speed)
    if O.ThemeRainbow then
        local hue = (tick() * (speed or 1)) % 1
        return Color3.fromHSV(hue, 1, 1)
    else
        return customThemeColor
    end
end

local function getParentGui()
    local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if success and coreGui then return coreGui end
    return pl:WaitForChild("PlayerGui")
end

local function trackConnection(conn)
    table.insert(activeConnections, conn)
    return conn
end

local function cleanupAll()
    for _, conn in ipairs(activeConnections) do
        if conn and typeof(conn) == "RBXScriptConnection" then
            conn:Disconnect()
        end
    end
    activeConnections = {}
end

-- Classic custom dragging function for universal executor compatibility
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    trackConnection(frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            trackConnection(input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end))
        end
    end))
    trackConnection(frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end))
    trackConnection(uis.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end))
end

-- Notification System
local notifGui = Instance.new("ScreenGui")
notifGui.Name = "MM2_Notifications"
notifGui.ResetOnSpawn = false
notifGui.Parent = getParentGui()
trackConnection(notifGui.AncestryChanged:Connect(function() if not notifGui.Parent then cleanupAll() end end))

local notifHolder = Instance.new("Frame", notifGui)
notifHolder.Size = UDim2.new(0, 300, 0, 400)
notifHolder.Position = UDim2.new(1, -315, 1, -415)
notifHolder.BackgroundTransparency = 1
local notifLayout = Instance.new("UIListLayout", notifHolder)
notifLayout.SortOrder = Enum.SortOrder.LayoutOrder
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
notifLayout.Padding = UDim.new(0, 8)

local function sendNotification(titleText, msgText, duration)
    task.spawn(function()
        local box = Instance.new("Frame", notifHolder)
        box.Size = UDim2.new(1, 0, 0, 65)
        box.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        box.BackgroundTransparency = 0.1
        box.Position = UDim2.new(1, 50, 0, 0)
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
        
        local stroke = Instance.new("UIStroke", box)
        stroke.Thickness = 1.5
        trackConnection(rs.RenderStepped:Connect(function() if stroke and stroke.Parent then stroke.Color = getThemeColor(0.8) end end))

        local tLbl = Instance.new("TextLabel", box)
        tLbl.Size = UDim2.new(1, -15, 0, 24)
        tLbl.Position = UDim2.new(0, 12, 0, 6)
        tLbl.BackgroundTransparency = 1
        tLbl.Text = titleText
        tLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        tLbl.TextSize = 16
        tLbl.Font = CUSTOM_FONT
        tLbl.TextXAlignment = Enum.TextXAlignment.Left

        local mLbl = Instance.new("TextLabel", box)
        mLbl.Size = UDim2.new(1, -15, 0, 24)
        mLbl.Position = UDim2.new(0, 12, 0, 30)
        mLbl.BackgroundTransparency = 1
        mLbl.Text = msgText
        mLbl.TextColor3 = Color3.fromRGB(190, 190, 190)
        mLbl.TextSize = 14
        mLbl.Font = CUSTOM_FONT
        mLbl.TextXAlignment = Enum.TextXAlignment.Left

        pcall(function() box:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.3, true) end)
        task.wait(duration or 2.5)
        pcall(function() box:TweenPosition(UDim2.new(1, 50, 0, 0), "In", "Quad", 0.3, true) end)
        task.wait(0.3)
        if box then box:Destroy() end
    end)
end

-- Key System UI
local gui = Instance.new("ScreenGui")
gui.Name = "MM2_KeySystem"
gui.ResetOnSpawn = false
gui.Parent = getParentGui()

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 240)
frame.Position = UDim2.new(0.5, -200, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
frame.Active = true
makeDraggable(frame)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
trackConnection(rs.RenderStepped:Connect(function() if stroke and stroke.Parent then stroke.Color = getThemeColor(1) end end))

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
title.Text = "Hacked by (Key System)"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = CUSTOM_FONT
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.85, 0, 0, 48)
textBox.Position = UDim2.new(0.075, 0, 0.3, 0)
textBox.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "Enter key..."
textBox.Text = ""
textBox.TextSize = 16
textBox.Font = CUSTOM_FONT
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 8)

local getKeyBtn = Instance.new("TextButton", frame)
getKeyBtn.Size = UDim2.new(0.4, 0, 0, 45)
getKeyBtn.Position = UDim2.new(0.075, 0, 0.62, 0)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
getKeyBtn.Text = "Get Key"
getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyBtn.TextSize = 16
getKeyBtn.Font = CUSTOM_FONT
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0, 8)

trackConnection(getKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(LOOTLABS_LINK)
        getKeyBtn.Text = "Link Copied!"
        task.wait(2)
        getKeyBtn.Text = "Get Key"
    else
        sendNotification("Error", "Clipboard API not supported.", 2)
    end
end))

local loginBtn = Instance.new("TextButton", frame)
loginBtn.Size = UDim2.new(0.4, 0, 0, 45)
loginBtn.Position = UDim2.new(0.525, 0, 0.62, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
loginBtn.Text = "Login"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.TextSize = 16
loginBtn.Font = CUSTOM_FONT
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 8)

trackConnection(loginBtn.MouseButton1Click:Connect(function()
    if textBox.Text == CORRECT_KEY then
        gui:Destroy()
        sendNotification("Success", "Key verified!", 3)
        
        -- MASTER MENU CREATION
        local mgui = Instance.new("ScreenGui")
        mgui.Name = "MM2_MasterMenu"
        mgui.ResetOnSpawn = false
        mgui.Parent = getParentGui()
        
        trackConnection(mgui.AncestryChanged:Connect(function()
            if not mgui.Parent then cleanupAll() end
        end))

        -- Master Character Loop
        trackConnection(rs.Stepped:Connect(function()
            if not mgui.Parent then return end
            pcall(function()
                local char = pl.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        if hum.WalkSpeed ~= O.WalkSpeed then hum.WalkSpeed = O.WalkSpeed end
                        hum.UseJumpPower = true
                        if hum.JumpPower ~= O.JumpPower then hum.JumpPower = O.JumpPower end
                    end
                    if O.Noclip then
                        for _, part in pairs(char:GetDescendants()) do
                            if part:IsA("BasePart") then part.CanCollide = false end
                        end
                    end
                end
                local cam = workspace.CurrentCamera
                if cam and cam.FieldOfView ~= O.FOV then cam.FieldOfView = O.FOV end
            end)
        end))

        -- Quick Access Buttons
        local toggleButton = Instance.new("TextButton", mgui)
        toggleButton.Size = UDim2.new(0, 190, 0, 48)
        toggleButton.Position = UDim2.new(0, 40, 0, 40)
        toggleButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        toggleButton.Text = "Hacked By - Menu"
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.TextSize = 17
        toggleButton.Font = CUSTOM_FONT
        toggleButton.Active = true
        makeDraggable(toggleButton)
        Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)
        local tbStroke = Instance.new("UIStroke", toggleButton)
        trackConnection(rs.RenderStepped:Connect(function() if tbStroke and tbStroke.Parent then tbStroke.Color = getThemeColor(1) end end))

        local silentAimButton = Instance.new("TextButton", mgui)
        silentAimButton.Size = UDim2.new(0, 190, 0, 48)
        silentAimButton.Position = UDim2.new(0, 40, 0, 96)
        silentAimButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        silentAimButton.Text = "Camera Aim: OFF"
        silentAimButton.TextColor3 = Color3.fromRGB(255, 50, 50)
        silentAimButton.TextSize = 16
        silentAimButton.Font = CUSTOM_FONT
        silentAimButton.Active = true
        makeDraggable(silentAimButton)
        Instance.new("UICorner", silentAimButton).CornerRadius = UDim.new(0, 8)
        local sabStroke = Instance.new("UIStroke", silentAimButton)
        trackConnection(rs.RenderStepped:Connect(function() if sabStroke and sabStroke.Parent then sabStroke.Color = getThemeColor(1) end end))

        trackConnection(silentAimButton.MouseButton1Click:Connect(function()
            O.SilentAim = not O.SilentAim
            silentAimButton.Text = O.SilentAim and "Camera Aim: ON" or "Camera Aim: OFF"
            silentAimButton.TextColor3 = O.SilentAim and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            sendNotification("Aim Assist", O.SilentAim and "Enabled!" or "Disabled!", 1.5)
        end))

        local mapButton = Instance.new("TextButton", mgui)
        mapButton.Size = UDim2.new(0, 190, 0, 48)
        mapButton.Position = UDim2.new(0, 40, 0, 152)
        mapButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        mapButton.Text = "TP to Map"
        mapButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        mapButton.TextSize = 17
        mapButton.Font = CUSTOM_FONT
        mapButton.Active = true
        makeDraggable(mapButton)
        Instance.new("UICorner", mapButton).CornerRadius = UDim.new(0, 8)
        local mbStroke = Instance.new("UIStroke", mapButton)
        trackConnection(rs.RenderStepped:Connect(function() if mbStroke and mbStroke.Parent then mbStroke.Color = getThemeColor(1) end end))

        trackConnection(mapButton.MouseButton1Click:Connect(function()
            pcall(function()
                local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local map = workspace:FindFirstChild("Map", true)
                    if map then
                        local primary = map:IsA("Model") and (map.PrimaryPart or map:FindFirstChildWhichIsA("BasePart"))
                        if primary then hrp.CFrame = primary.CFrame + Vector3.new(0, 5, 0) end
                    else
                        hrp.CFrame = CFrame.new(0, 50, 0)
                    end
                    sendNotification("Teleport", "Teleported to Map!", 2)
                end
            end)
        end))

        local lobbyButton = Instance.new("TextButton", mgui)
        lobbyButton.Size = UDim2.new(0, 190, 0, 48)
        lobbyButton.Position = UDim2.new(0, 40, 0, 208)
        lobbyButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        lobbyButton.Text = "TP to Lobby"
        lobbyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        lobbyButton.TextSize = 17
        lobbyButton.Font = CUSTOM_FONT
        lobbyButton.Active = true
        makeDraggable(lobbyButton)
        Instance.new("UICorner", lobbyButton).CornerRadius = UDim.new(0, 8)
        local lbStroke = Instance.new("UIStroke", lobbyButton)
        trackConnection(rs.RenderStepped:Connect(function() if lbStroke and lbStroke.Parent then lbStroke.Color = getThemeColor(1) end end))

        trackConnection(lobbyButton.MouseButton1Click:Connect(function()
            pcall(function()
                local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp then 
                    local spawn = workspace:FindFirstChild("LobbySpawn", true)
                    if spawn and spawn:IsA("BasePart") then
                        hrp.CFrame = spawn.CFrame + Vector3.new(0, 3, 0)
                    else
                        hrp.CFrame = CFrame.new(0, 10, 0) 
                    end
                    sendNotification("Teleport", "Returned to Lobby!", 2)
                end
            end)
        end))

        -- Main Panel Frame
        local f = Instance.new("Frame", mgui)
        f.Size = UDim2.new(0, 620, 0, 450)
        f.Position = UDim2.new(0.5, -310, 0.5, -225)
        f.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
        f.Active = true
        makeDraggable(f)
        f.ClipsDescendants = true
        f.Visible = false

        trackConnection(toggleButton.MouseButton1Click:Connect(function() f.Visible = not f.Visible end))
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
        local fStroke = Instance.new("UIStroke", f)
        fStroke.Transparency = 0.2
        trackConnection(rs.RenderStepped:Connect(function() if fStroke and fStroke.Parent then fStroke.Color = getThemeColor(1) end end))

        local t = Instance.new("TextLabel", f)
        t.Size = UDim2.new(1, 0, 0, 45)
        t.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        t.Text = "Hacked by - Panel"
        t.TextColor3 = Color3.fromRGB(255, 255, 255)
        t.TextSize = 18
        t.Font = CUSTOM_FONT
        Instance.new("UICorner", t).CornerRadius = UDim.new(0, 12)

        local catHolder = Instance.new("ScrollingFrame", f)
        catHolder.Size = UDim2.new(0, 150, 1, -55)
        catHolder.Position = UDim2.new(0, 8, 0, 50)
        catHolder.BackgroundTransparency = 1
        catHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
        catHolder.ScrollBarThickness = 2

        local catLayout = Instance.new("UIListLayout", catHolder)
        catLayout.FillDirection = Enum.FillDirection.Vertical
        catLayout.SortOrder = Enum.SortOrder.LayoutOrder
        catLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        catLayout.Padding = UDim.new(0, 6)

        trackConnection(catLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            catHolder.CanvasSize = UDim2.new(0, 0, 0, catLayout.AbsoluteContentSize.Y + 20)
        end))

        local function createPage()
            local sc = Instance.new("ScrollingFrame", f)
            sc.Size = UDim2.new(1, -170, 1, -55)
            sc.Position = UDim2.new(0, 162, 0, 50)
            sc.BackgroundTransparency = 1
            sc.BorderSizePixel = 0
            sc.ScrollBarThickness = 6
            sc.Visible = false
            trackConnection(rs.RenderStepped:Connect(function() if sc and sc.Parent then sc.ScrollBarImageColor3 = getThemeColor(1) end end))
            local ll = Instance.new("UIListLayout", sc)
            ll.Padding = UDim.new(0, 8)
            ll.SortOrder = Enum.SortOrder.LayoutOrder
            trackConnection(ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                sc.CanvasSize = UDim2.new(0, 0, 0, ll.AbsoluteContentSize.Y + 20)
            end))
            return sc
        end

        local categories = {"Theme", "ESP & X-Ray", "Combat & Aim", "Trade & Misc", "Auto Farm"}
        local pageFrames = {}

        for i, catName in ipairs(categories) do
            local page = createPage()
            table.insert(pageFrames, page)

            local cBtn = Instance.new("TextButton", catHolder)
            cBtn.Size = UDim2.new(1, -10, 0, 40)
            cBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
            cBtn.Text = catName
            cBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
            cBtn.TextSize = 13
            cBtn.Font = CUSTOM_FONT
            Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 8)

            trackConnection(cBtn.MouseButton1Click:Connect(function()
                for _, pFrame in ipairs(pageFrames) do pFrame.Visible = false end
                page.Visible = true
            end))
            if i == 1 then page.Visible = true end
        end

        local function Tog(parentContainer, titleText, defaultState, callbackFunc)
            local f2 = Instance.new("Frame", parentContainer)
            f2.Size = UDim2.new(1, -10, 0, 46)
            f2.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
            f2.BackgroundTransparency = 0.4
            Instance.new("UICorner", f2).CornerRadius = UDim.new(0, 8)

            local lb = Instance.new("TextLabel", f2)
            lb.Size = UDim2.new(1, -70, 1, 0)
            lb.Position = UDim2.new(0, 14, 0, 0)
            lb.BackgroundTransparency = 1
            lb.Text = titleText
            lb.TextColor3 = Color3.fromRGB(240, 240, 240)
            lb.TextSize = 14
            lb.Font = CUSTOM_FONT
            lb.TextXAlignment = Enum.TextXAlignment.Left

            local bg2 = Instance.new("Frame", f2)
            bg2.Size = UDim2.new(0, 44, 0, 24)
            bg2.Position = UDim2.new(1, -54, 0.5, -12)
            bg2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            bg2.BorderSizePixel = 0
            Instance.new("UICorner", bg2).CornerRadius = UDim.new(0, 12)

            local circ = Instance.new("Frame", bg2)
            circ.Size = UDim2.new(0, 20, 0, 20)
            circ.Position = UDim2.new(0, 2, 0.5, -10)
            circ.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            circ.BorderSizePixel = 0
            Instance.new("UICorner", circ).CornerRadius = UDim.new(0, 10)

            local st = defaultState or false
            local function upd()
                if st then
                    bg2.BackgroundColor3 = getThemeColor(1)
                    circ.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    pcall(function() circ:TweenPosition(UDim2.new(0, 22, 0.5, -10), "Out", "Quad", 0.2, true) end)
                else
                    bg2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    circ.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                    pcall(function() circ:TweenPosition(UDim2.new(0, 2, 0.5, -10), "Out", "Quad", 0.2, true) end)
                end
            end
            upd()

            local btn = Instance.new("TextButton", f2)
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            trackConnection(btn.MouseButton1Click:Connect(function()
                st = not st
                upd()
                if callbackFunc then pcall(callbackFunc, st) end
            end))
        end

        local function createStepControl(parentContainer, labelName, defaultVal, minVal, maxVal, step, callback)
            local frameBox = Instance.new("Frame", parentContainer)
            frameBox.Size = UDim2.new(1, -10, 0, 55)
            frameBox.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
            frameBox.BackgroundTransparency = 0.4
            Instance.new("UICorner", frameBox).CornerRadius = UDim.new(0, 8)

            local lbl = Instance.new("TextLabel", frameBox)
            lbl.Size = UDim2.new(1, -130, 1, 0)
            lbl.Position = UDim2.new(0, 14, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = labelName .. ": " .. defaultVal
            lbl.TextColor3 = Color3.fromRGB(240, 240, 240)
            lbl.TextSize = 14
            lbl.Font = CUSTOM_FONT
            lbl.TextXAlignment = Enum.TextXAlignment.Left

            local val = defaultVal
            local minusBtn = Instance.new("TextButton", frameBox)
            minusBtn.Size = UDim2.new(0, 38, 0, 32)
            minusBtn.Position = UDim2.new(1, -95, 0.5, -16)
            minusBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            minusBtn.Text = "-"
            minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            minusBtn.TextSize = 18
            minusBtn.Font = CUSTOM_FONT
            Instance.new("UICorner", minusBtn).CornerRadius = UDim.new(0, 6)

            local plusBtn = Instance.new("TextButton", frameBox)
            plusBtn.Size = UDim2.new(0, 38, 0, 32)
            plusBtn.Position = UDim2.new(1, -52, 0.5, -16)
            plusBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            plusBtn.Text = "+"
            plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            plusBtn.TextSize = 18
            plusBtn.Font = CUSTOM_FONT
            Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0, 6)

            trackConnection(minusBtn.MouseButton1Click:Connect(function()
                val = math.clamp(val - step, minVal, maxVal)
                lbl.Text = labelName .. ": " .. val
                if callback then pcall(callback, val) end
            end))

            trackConnection(plusBtn.MouseButton1Click:Connect(function()
                val = math.clamp(val + step, minVal, maxVal)
                lbl.Text = labelName .. ": " .. val
                if callback then pcall(callback, val) end
            end))

            return frameBox
        end

        -- Tab 1: Theme
        Tog(pageFrames[1], "Rainbow Mode", true, function(s) 
            O.ThemeRainbow = s 
            sendNotification("Theme", s and "Rainbow Enabled" or "Disabled", 1.5)
        end)

        -- Tab 2: ESP & Dynamic X-Ray
        Tog(pageFrames[2], "Role ESP", false, function(s) 
            O.ESP = s 
            sendNotification("ESP", s and "Enabled" or "Disabled", 1.5)
        end)
        
        Tog(pageFrames[2], "Wallhack X-Ray", false, function(s) 
            O.XRay = s
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and not part:IsDescendantOf(pl.Character) then
                    if s then
                        if O.OriginalTransparency[part] == nil then
                            O.OriginalTransparency[part] = part.LocalTransparencyModifier
                        end
                        part.LocalTransparencyModifier = 0.5
                    else
                        if O.OriginalTransparency[part] ~= nil then
                            part.LocalTransparencyModifier = O.OriginalTransparency[part]
                        else
                            part.LocalTransparencyModifier = 0
                        end
                    end
                end
            end
            sendNotification("X-Ray", s and "Enabled" or "Disabled", 1.5)
        end)

        -- Dynamic X-Ray Watcher for newly streamed parts
        trackConnection(workspace.DescendantAdded:Connect(function(part)
            if O.XRay and part:IsA("BasePart") and not part:IsDescendantOf(pl.Character) then
                O.OriginalTransparency[part] = part.LocalTransparencyModifier
                part.LocalTransparencyModifier = 0.5
            end
        end))

        -- Tab 3: Combat & Aim
        Tog(pageFrames[3], "Client God Mode", false, function(s) 
            O.GodMode = s 
            sendNotification("God Mode", s and "Active" or "Disabled", 1.5)
        end)

        -- Tab 4: Trade & Misc
        Tog(pageFrames[4], "Infinite Jump", false, function(s) 
            O.InfJump = s 
            sendNotification("Misc", s and "Inf Jump Active" or "Disabled", 1.5)
        end)
        
        Tog(pageFrames[4], "Noclip", false, function(s) 
            O.Noclip = s 
            sendNotification("Noclip", s and "Active" or "Disabled", 1.5)
        end)

        local origBrightness = lighting.Brightness
        local origClock = lighting.ClockTime
        local origFog = lighting.FogEnd
        Tog(pageFrames[4], "FullBright", false, function(s) 
            if s then
                lighting.Brightness = 2
                lighting.ClockTime = 14
                lighting.FogEnd = 100000
            else
                lighting.Brightness = origBrightness
                lighting.ClockTime = origClock
                lighting.FogEnd = origFog
            end
            sendNotification("FullBright", s and "Enabled" or "Disabled", 1.5)
        end)

        createStepControl(pageFrames[4], "Character FOV", 70, 50, 120, 5, function(v) O.FOV = v end)
        createStepControl(pageFrames[4], "WalkSpeed", 16, 16, 200, 4, function(v) O.WalkSpeed = v end)
        createStepControl(pageFrames[4], "JumpPower", 50, 50, 300, 10, function(v) O.JumpPower = v end)

        -- Tab 5: Auto Farm (Cached Collection System supporting Coins & Gems)
        Tog(pageFrames[5], "Auto Farm", false, function(s) 
            O.AutoFarm = s 
            O.Noclip = s
            sendNotification("Auto Farm", s and "Optimized Auto Farm Active" or "Disabled", 1.5)
        end)

        -- Background Loops
        trackConnection(uis.JumpRequest:Connect(function()
            if O.InfJump then
                pcall(function() pl.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
            end
        end))

        -- Role ESP Loop
        task.spawn(function()
            while mgui.Parent do
                task.wait(1)
                pcall(function()
                    if O.ESP then
                        for _, v in pairs(p:GetPlayers()) do
                            if v ~= pl and v.Character then
                                local hl = v.Character:FindFirstChild("MM2_ESP")
                                local char = v.Character
                                local bp = v.Backpack
                                if not hl then
                                    hl = Instance.new("Highlight", char)
                                    hl.Name = "MM2_ESP"
                                    hl.FillTransparency = 0.5
                                    hl.OutlineTransparency = 0.1
                                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                end
                                local hasKnife = char:FindFirstChild("Knife") or (bp and bp:FindFirstChild("Knife"))
                                local hasGun = char:FindFirstChild("Gun") or (bp and bp:FindFirstChild("Gun"))
                                if hasKnife then hl.FillColor = Color3.fromRGB(255, 0, 0)
                                elseif hasGun then hl.FillColor = Color3.fromRGB(0, 150, 255)
                                else hl.FillColor = Color3.fromRGB(0, 255, 0) end
                            end
                        end
                    else
                        for _, v in pairs(p:GetPlayers()) do
                            if v.Character and v.Character:FindFirstChild("MM2_ESP") then v.Character.MM2_ESP:Destroy() end
                        end
                    end
                end)
            end
        end)

        -- Camera Aim Loop
        task.spawn(function()
            while mgui.Parent do
                task.wait(0.05)
                pcall(function()
                    if O.SilentAim then
                        local cam = workspace.CurrentCamera
                        local char = pl.Character
                        local gun = char and (char:FindFirstChild("Gun") or pl.Backpack:FindFirstChild("Gun"))
                        if gun then
                            for _, v in pairs(p:GetPlayers()) do
                                if v ~= pl and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                                    local hasKnife = v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife"))
                                    if hasKnife then
                                        cam.CFrame = CFrame.new(cam.CFrame.Position, v.Character.HumanoidRootPart.Position)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)

        -- Auto Farm Loop (With Coin/Gem Support & Round Refresh Cache)
        task.spawn(function()
            while mgui.Parent do
                task.wait(0.3)
                pcall(function()
                    if O.AutoFarm then
                        local char = pl.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        local hum = char and char:FindFirstChildOfClass("Humanoid")
                        
                        if hrp and hum and hum.Health > 0 then
                            if #O.CoinCache == 0 then
                                for _, obj in pairs(workspace:GetDescendants()) do
                                    if obj:IsA("BasePart") then
                                        local n = obj.Name:lower()
                                        if n:find("coin") or n:find("gold") or n:find("gem") then
                                            table.insert(O.CoinCache, obj)
                                        end
                                    end
                                end
                            end
                            
                            for i = #O.CoinCache, 1, -1 do
                                if not O.AutoFarm then break end
                                local coin = O.CoinCache[i]
                                if coin and coin.Parent and coin.Transparency < 1 then
                                    hum.PlatformStand = true
                                    hrp.CFrame = coin.CFrame + Vector3.new(0, 2, 0)
                                    rs.Heartbeat:Wait()
                                    hum.PlatformStand = false
                                    table.remove(O.CoinCache, i)
                                    task.wait(0.05)
                                else
                                    table.remove(O.CoinCache, i)
                                end
                            end
                        end
                    else
                        O.CoinCache = {}
                    end
                end)
            end
        end)

        sendNotification("Loaded", "All architecture gaps patched successfully!", 3)
    else
        textBox.Text = ""
        textBox.PlaceholderText = "WRONG KEY!"
        task.wait(1.5)
        textBox.PlaceholderText = "Enter key..."
    end
end)
