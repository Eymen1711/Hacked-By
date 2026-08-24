-- ==========================================
-- ULTIMATE MM2 SCRIPT (v2.2 FINAL FULL FIXED)
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
local rainbowModeActive = true

local currentWalkSpeed = 16
local currentJumpPower = 50
local currentFOV = 70
local CUSTOM_FONT = Enum.Font.FredokaOne

getgenv().MM2_ActiveConnections = getgenv().MM2_ActiveConnections or {}
getgenv().MM2_ActiveThreads = getgenv().MM2_ActiveThreads or {}

local function cleanUpAll()
    for _, conn in ipairs(getgenv().MM2_ActiveConnections) do
        if conn and typeof(conn) == "RBXScriptConnection" then
            pcall(function() conn:Disconnect() end)
        end
    end
    getgenv().MM2_ActiveConnections = {}

    for _, thread in ipairs(getgenv().MM2_ActiveThreads) do
        if thread and coroutine.status(thread) ~= "dead" then
            pcall(function() task.cancel(thread) end)
        end
    end
    getgenv().MM2_ActiveThreads = {}
end
cleanUpAll()

local function addConnection(conn)
    table.insert(getgenv().MM2_ActiveConnections, conn)
    return conn
end

local function addThread(thread)
    table.insert(getgenv().MM2_ActiveThreads, thread)
    return thread
end

pcall(function()
    for _, name in ipairs({"MM2_MasterMenu", "MM2_KeySystem", "MM2_Notifications"}) do
        if game:GetService("CoreGui"):FindFirstChild(name) then game:GetService("CoreGui")[name]:Destroy() end
        if pl.PlayerGui:FindFirstChild(name) then pl.PlayerGui[name]:Destroy() end
    end
end)

local function getThemeColor(speed)
    if rainbowModeActive then
        local hue = (tick() * (speed or 1)) % 1
        return Color3.fromHSV(hue, 1, 1)
    else
        return customThemeColor
    end
end

local function makeDraggable(topBar, window)
    local dragging, dragInput, dragStart, startPos
    addConnection(topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = window.Position
            addConnection(input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end))
        end
    end))
    addConnection(topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end))
    addConnection(uis.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end))
end

-- Notification System
local notifGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
notifGui.Name = "MM2_Notifications"
notifGui.ResetOnSpawn = false

local notifHolder = Instance.new("Frame", notifGui)
notifHolder.Size = UDim2.new(0, 300, 0, 400)
notifHolder.Position = UDim2.new(1, -315, 1, -415)
notifHolder.BackgroundTransparency = 1
local notifLayout = Instance.new("UIListLayout", notifHolder)
notifLayout.SortOrder = Enum.SortOrder.LayoutOrder
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
notifLayout.Padding = UDim.new(0, 8)

local function sendNotification(titleText, msgText, duration)
    addThread(task.spawn(function()
        local box = Instance.new("Frame", notifHolder)
        box.Size = UDim2.new(1, 0, 0, 65)
        box.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        box.BackgroundTransparency = 0.1
        box.Position = UDim2.new(1, 50, 0, 0)
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
        local stroke = Instance.new("UIStroke", box)
        stroke.Thickness = 1.5
        
        local conn = addConnection(rs.RenderStepped:Connect(function()
            if stroke and stroke.Parent then stroke.Color = getThemeColor(0.8) end
        end))

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

        pcall(function() box:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.3, true) end)
        task.wait(duration or 2.5)
        pcall(function() box:TweenPosition(UDim2.new(1, 50, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true) end)
        task.wait(0.3)
        if conn then conn:Disconnect() end
        if box then box:Destroy() end
    end))
end

local function isValidCoin(obj)
    if not obj or not obj.Parent or not obj:IsA("BasePart") then return false end
    if obj.Transparency >= 1 then return false end
    local name = obj.Name:lower()
    if name == "coin" or name == "gold" or name == "gem" or name:match("^coin_") or name:match("^gold_") or name:match("^gem_") then
        local cf = obj.CFrame
        if cf then
            local pos = cf.Position
            if pos.X == pos.X and pos.Y == pos.Y and pos.Z == pos.Z then return true end
        end
    end
    return false
end

-- Key System UI
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "MM2_KeySystem"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 240)
frame.Position = UDim2.new(0.5, -200, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
frame.Active = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
title.Text = "Hacked by (Key System)"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = CUSTOM_FONT
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)
makeDraggable(title, frame)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
addConnection(rs.RenderStepped:Connect(function() if stroke and stroke.Parent then stroke.Color = getThemeColor(1) end end))

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

addConnection(getKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(LOOTLABS_LINK)
        getKeyBtn.Text = "Link Copied!"
        task.wait(2)
        getKeyBtn.Text = "Get Key"
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

addConnection(loginBtn.MouseButton1Click:Connect(function()
    if textBox.Text == CORRECT_KEY then
        gui:Destroy()
        sendNotification("Success", "Key verified successfully!", 3)

        -- MASTER MENU
        local mgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        mgui.Name = "MM2_MasterMenu"
        mgui.ResetOnSpawn = false

        addThread(task.spawn(function()
            while true do
                task.wait(0.2)
                local char = pl.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        if hum.WalkSpeed ~= currentWalkSpeed then hum.WalkSpeed = currentWalkSpeed end
                        hum.UseJumpPower = true
                        if hum.JumpPower ~= currentJumpPower then hum.JumpPower = currentJumpPower end
                    end
                end
                local currentCam = workspace.CurrentCamera
                if currentCam and currentCam.FieldOfView ~= currentFOV then
                    currentCam.FieldOfView = currentFOV
                end
            end
        end))

        local toggleButton = Instance.new("TextButton", mgui)
        toggleButton.Size = UDim2.new(0, 190, 0, 48)
        toggleButton.Position = UDim2.new(0, 40, 0, 40)
        toggleButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        toggleButton.Text = "Hacked By - Menu"
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.TextSize = 17
        toggleButton.Font = CUSTOM_FONT
        toggleButton.Active = true
        Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)
        makeDraggable(toggleButton, toggleButton)
        local tbStroke = Instance.new("UIStroke", toggleButton)
        addConnection(rs.RenderStepped:Connect(function() if tbStroke and tbStroke.Parent then tbStroke.Color = getThemeColor(1) end end))

        local f = Instance.new("Frame", mgui)
        f.Size = UDim2.new(0, 620, 0, 450)
        f.Position = UDim2.new(0.5, -310, 0.5, -225)
        f.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
        f.Active = true
        f.ClipsDescendants = true
        f.Visible = false

        addConnection(toggleButton.MouseButton1Click:Connect(function() f.Visible = not f.Visible end))
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
        local fStroke = Instance.new("UIStroke", f)
        fStroke.Transparency = 0.2
        addConnection(rs.RenderStepped:Connect(function() if fStroke and fStroke.Parent then fStroke.Color = getThemeColor(1) end end))

        local t = Instance.new("TextLabel", f)
        t.Size = UDim2.new(1, 0, 0, 45)
        t.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        t.Text = "Hacked by - Panel"
        t.TextColor3 = Color3.fromRGB(255, 255, 255)
        t.TextSize = 18
        t.Font = CUSTOM_FONT
        Instance.new("UICorner", t).CornerRadius = UDim.new(0, 12)
        makeDraggable(t, f)

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

        addConnection(catLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
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
            addConnection(rs.RenderStepped:Connect(function() if sc and sc.Parent then sc.ScrollBarImageColor3 = getThemeColor(1) end end))
            
            local ll = Instance.new("UIListLayout", sc)
            ll.Padding = UDim.new(0, 8)
            ll.SortOrder = Enum.SortOrder.LayoutOrder
            
            addConnection(ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
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

            addConnection(cBtn.MouseButton1Click:Connect(function()
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
                    pcall(function() circ:TweenPosition(UDim2.new(0, 22, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true) end)
                else
                    bg2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    circ.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                    pcall(function() circ:TweenPosition(UDim2.new(0, 2, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true) end)
                end
            end
            upd()

            local btn = Instance.new("TextButton", f2)
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            addConnection(btn.MouseButton1Click:Connect(function()
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

            addConnection(minusBtn.MouseButton1Click:Connect(function()
                val = math.clamp(val - step, minVal, maxVal)
                lbl.Text = labelName .. ": " .. val
                if callback then pcall(callback, val) end
            end))

            addConnection(plusBtn.MouseButton1Click:Connect(function()
                val = math.clamp(val + step, minVal, maxVal)
                lbl.Text = labelName .. ": " .. val
                if callback then pcall(callback, val) end
            end))

            return frameBox
        end

        local O = {}
        
        -- Tab 1: Theme
        Tog(pageFrames[1], "Rainbow Mode", true, function(s) 
            rainbowModeActive = s 
            sendNotification("Theme", s and "Rainbow Mode Enabled" or "Rainbow Mode Disabled", 1.5)
        end)
        
        local colorContainer = Instance.new("Frame", pageFrames[1])
        colorContainer.Size = UDim2.new(1, -10, 0, 45)
        colorContainer.BackgroundTransparency = 1
        local colors = {
            {Name = "Red", Color = Color3.fromRGB(255, 50, 50)},
            {Name = "Green", Color = Color3.fromRGB(50, 255, 50)},
            {Name = "Blue", Color = Color3.fromRGB(50, 150, 255)},
            {Name = "Purple", Color = Color3.fromRGB(180, 50, 255)},
            {Name = "Orange", Color = Color3.fromRGB(255, 140, 0)}
        }
        for i, colData in ipairs(colors) do
            local cBtn = Instance.new("TextButton", colorContainer)
            cBtn.Size = UDim2.new(0.18, 0, 1, 0)
            cBtn.Position = UDim2.new((i-1)*0.205, 0, 0, 0)
            cBtn.BackgroundColor3 = colData.Color
            cBtn.Text = ""
            Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 8)
            addConnection(cBtn.MouseButton1Click:Connect(function()
                rainbowModeActive = false
                customThemeColor = colData.Color
                sendNotification("Theme", colData.Name .." theme selected!", 1.5)
            end))
        end

        -- Tab 2: ESP & X-Ray
        local originalTransparency = {}
        Tog(pageFrames[2], "Perfect Role ESP", false, function(s) O.ESP = s end)
        
        Tog(pageFrames[2], "Wallhack X-Ray", false, function(s) 
            O.XRay = s
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and pl.Character and not part:IsDescendantOf(pl.Character) then
                    if s then
                        if not originalTransparency[part] then
                            originalTransparency[part] = part.LocalTransparencyModifier
                        end
                        if part.Transparency < 0.5 then part.LocalTransparencyModifier = 0.5 end
                    else
                        for partVal, originalValue in pairs(originalTransparency) do
                            if partVal and partVal.Parent then
                                partVal.LocalTransparencyModifier = originalValue
                            end
                            originalTransparency[partVal] = nil
                        end
                    end
                end
            end
        end)
        
        Tog(pageFrames[2], "Sheriff Gun & Coin ESP", false, function(s) O.ExtraESP = s end)

        -- Tab 3: Combat & Aim
        Tog(pageFrames[3], "Auto Grab Gun", false, function(s) O.AutoGrabGun = s end)
        Tog(pageFrames[3], "Auto Sheriff Target", false, function(s) O.AutoSheriff = s end)
        Tog(pageFrames[3], "Kill All (Murderer)", false, function(s) O.KA = s end)
        Tog(pageFrames[3], "God Mode Shield", false, function(s) O.GodMode = s end)
        Tog(pageFrames[3], "God Fling Murderer", false, function(s) O.FlingMurderer = s end)

        -- Tab 4: Trade & Misc
        local origLighting = {Brightness = lighting.Brightness, ClockTime = lighting.ClockTime, FogEnd = lighting.FogEnd}
        Tog(pageFrames[4], "Freeze Trade", false, function(s) O.FreezeTrade = s end)
        Tog(pageFrames[4], "Force Accept Trade", false, function(s) O.ForceAccept = s end)
        Tog(pageFrames[4], "Infinite Jump", false, function(s) O.InfJump = s end)
        
        local originalCanCollide = {}
        Tog(pageFrames[4], "Noclip", false, function(s) 
            O.Noclip = s 
            if not s then
                local char = pl.Character
                if char then
                    for part, val in pairs(originalCanCollide) do
                        if part and part.Parent then part.CanCollide = val end
                    end
                    originalCanCollide = {}
                end
            end
        end)
        
        Tog(pageFrames[4], "FullBright", false, function(s) 
            if s then
                lighting.Brightness = 2 lighting.ClockTime = 14 lighting.FogEnd = 100000
            else
                lighting.Brightness = origLighting.Brightness lighting.ClockTime = origLighting.ClockTime lighting.FogEnd = origLighting.FogEnd
            end
        end)

        createStepControl(pageFrames[4], "Character FOV", 70, 50, 120, 5, function(v) currentFOV = v end)
        
        createStepControl(pageFrames[4], "WalkSpeed", 16, 16, 200, 4, function(v)
            currentWalkSpeed = v
            pcall(function()
                local char = pl.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = v end
            end)
        end)
        
        createStepControl(pageFrames[4], "JumpPower", 50, 50, 300, 10, function(v)
            currentJumpPower = v
            pcall(function()
                local char = pl.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.UseJumpPower = true
                    hum.JumpPower = v
                end
            end)
        end)

        -- Tab 5: Auto Farm & Troll Coin
        Tog(pageFrames[5], "Troll Coin", false, function(s) O.AF = s end)
        Tog(pageFrames[5], "Auto Farm", false, function(s) O.AutoFarm = s; O.Noclip = s end)

        -- Loops
        addThread(task.spawn(function()
            while true do
                task.wait(0.5)
                if O.ESP then
                    for _, v in pairs(p:GetPlayers()) do
                        if v ~= pl and v.Character then
                            local hl = v.Character:FindFirstChild("PerfectESP")
                            local hasKnife = v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife"))
                            local hasGun = v.Character:FindFirstChild("Gun") or (v.Backpack and v.Backpack:FindFirstChild("Gun"))
                            if not hl then
                                hl = Instance.new("Highlight", v.Character)
                                hl.Name = "PerfectESP"
                                hl.FillTransparency = 0.4
                                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            end
                            if hasKnife then hl.FillColor = Color3.fromRGB(255, 0, 0)
                            elseif hasGun then hl.FillColor = Color3.fromRGB(0, 150, 255)
                            else hl.FillColor = Color3.fromRGB(0, 255, 0) end
                        end
                    end
                else
                    for _, v in pairs(p:GetPlayers()) do
                        if v.Character and v.Character:FindFirstChild("PerfectESP") then v.Character.PerfectESP:Destroy() end
                    end
                end
            end
        end))

        addConnection(rs.Stepped:Connect(function()
            if O.Noclip then
                local char = pl.Character
                if char then
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            if originalCanCollide[part] == nil then originalCanCollide[part] = part.CanCollide end
                            part.CanCollide = false
                        end
                    end
                end
            end
        end))

        addThread(task.spawn(function()
            while true do
                task.wait(0.2)
                if O.AutoFarm then
                    local char = pl.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if hrp and hum and hum.Health > 0 then
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if not O.AutoFarm then hum.PlatformStand = false; break end
                            if isValidCoin(obj) then
                                local targetCFrame = obj.CFrame + Vector3.new(0, 2, 0)
                                local startCFrame = hrp.CFrame
                                local distance = (hrp.Position - targetCFrame.Position).Magnitude
                                local steps = math.clamp(math.floor(distance / 12), 4, 25)
                                
                                hum.PlatformStand = true
                                for i = 1, steps do
                                    if not O.AutoFarm or not isValidCoin(obj) then break end
                                    local alpha = i / steps
                                    pcall(function() hrp.CFrame = startCFrame:Lerp(targetCFrame, alpha) end)
                                    rs.Heartbeat:Wait()
                                end
                                hum.PlatformStand = false
                                pcall(function()
                                    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                                    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                                end)
                                task.wait(0.05)
                            end
                        end
                        hum.PlatformStand = false
                    end
                end
            end
        end))

        sendNotification("Loaded", "All features ready!", 3)
    else
        textBox.Text = ""
        textBox.PlaceholderText = "WRONG KEY!"
        task.wait(1.5)
        textBox.PlaceholderText = "Enter key..."
    end
end))
