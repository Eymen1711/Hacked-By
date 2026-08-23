-- ==========================================
-- HACKED BY + ULTIMATE MM2 SCRIPT (TASTE BREAD FONT - FULLY FIXED)
-- ==========================================

local p = game:GetService("Players")
local pl = p.LocalPlayer
local workspace = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local camera = workspace.CurrentCamera

local LOOTLABS_LINK = "https://loot-link.com/s?9K7cNpua"
local CORRECT_KEY = "5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3"

local customThemeColor = Color3.fromRGB(0, 162, 255)
local rainbowModeActive = true

-- Global Settings
local currentWalkSpeed = 16
local currentJumpPower = 50
local autoFarmSpeed = 25
local currentFOV = 70

-- Taste Bread Tarzı Tatlı/Oyun Fontu
local CUSTOM_FONT = Enum.Font.FredokaOne

local function getThemeColor(speed)
    if rainbowModeActive then
        local hue = (tick() * (speed or 1)) % 1
        return Color3.fromHSV(hue, 1, 1)
    else
        return customThemeColor
    end
end

-- Anti-Ban Security Layer (Güvenli pcall ile sarıldı)
pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldNameCall = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if tostring(method):lower() == "kick" or tostring(self):lower() == "anticheat" then
            return nil
        end
        return oldNameCall(self, ...)
    end)
    setreadonly(mt, true)
end)

-- Notification System
local notifGui = Instance.new("ScreenGui")
notifGui.Name = "MM2_Notifications"
notifGui.ResetOnSpawn = false
pcall(function() notifGui.Parent = game:GetService("CoreGui") end)
if not notifGui.Parent then pcall(function() notifGui.Parent = pl:WaitForChild("PlayerGui") end) end

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
        
        local conn
        conn = rs.RenderStepped:Connect(function()
            if stroke and stroke.Parent then
                stroke.Color = getThemeColor(0.8)
            else
                if conn then conn:Disconnect() end
            end
        end)

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
        if conn then conn:Disconnect() end
        if box then box:Destroy() end
    end)
end

-- Key System UI
local gui = Instance.new("ScreenGui")
gui.Name = "MM2_KeySystem"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not gui.Parent then pcall(function() gui.Parent = pl:WaitForChild("PlayerGui") end) end

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 240)
frame.Position = UDim2.new(0.5, -200, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
rs.RenderStepped:Connect(function() if stroke and stroke.Parent then stroke.Color = getThemeColor(1) end end)

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

getKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(LOOTLABS_LINK)
        getKeyBtn.Text = "Link Copied!"
        task.wait(2)
        getKeyBtn.Text = "Get Key"
    end
end)

local loginBtn = Instance.new("TextButton", frame)
loginBtn.Size = UDim2.new(0.4, 0, 0, 45)
loginBtn.Position = UDim2.new(0.525, 0, 0.62, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
loginBtn.Text = "Login"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.TextSize = 16
loginBtn.Font = CUSTOM_FONT
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 8)

loginBtn.MouseButton1Click:Connect(function()
    if textBox.Text == CORRECT_KEY then
        gui:Destroy()
        sendNotification("Success", "Key verified successfully!", 3)
        
        -- MASTER MENU
        local mgui = Instance.new("ScreenGui")
        mgui.Name = "MM2_MasterMenu"
        mgui.ResetOnSpawn = false
        pcall(function() mgui.Parent = game:GetService("CoreGui") end)
        if not mgui.Parent then pcall(function() mgui.Parent = pl:WaitForChild("PlayerGui") end) end

        -- Constant Character Loop to enforce WalkSpeed, JumpPower & FOV
        task.spawn(function()
            while true do
                task.wait(0.2)
                pcall(function()
                    local char = pl.Character
                    if char then
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum then
                            if hum.WalkSpeed ~= currentWalkSpeed then hum.WalkSpeed = currentWalkSpeed end
                            hum.UseJumpPower = true
                            if hum.JumpPower ~= currentJumpPower then hum.JumpPower = currentJumpPower end
                        end
                    end
                    if camera and camera.FieldOfView ~= currentFOV then
                        camera.FieldOfView = currentFOV
                    end
                end)
            end
        end)

        local fpsLabel = Instance.new("TextLabel", mgui)
        fpsLabel.Size = UDim2.new(0, 140, 0, 40)
        fpsLabel.Position = UDim2.new(0, 15, 1, -55)
        fpsLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        fpsLabel.BackgroundTransparency = 0.3
        fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        fpsLabel.TextSize = 16
        fpsLabel.Font = CUSTOM_FONT
        fpsLabel.Text = "FPS: 0"
        fpsLabel.Visible = false
        Instance.new("UICorner", fpsLabel).CornerRadius = UDim.new(0, 8)
        local fpsStroke = Instance.new("UIStroke", fpsLabel)
        rs.RenderStepped:Connect(function() if fpsStroke and fpsStroke.Parent then fpsStroke.Color = getThemeColor(1) end end)

        task.spawn(function()
            local frames = 0
            local lastUpdate = tick()
            rs.RenderStepped:Connect(function()
                frames = frames + 1
                local now = tick()
                if now - lastUpdate >= 0.5 then
                    local fps = math.floor((frames / (now - lastUpdate)) + 0.5)
                    if fpsLabel and fpsLabel.Visible then
                        fpsLabel.Text = "FPS: " .. tostring(fps)
                    end
                    frames = 0
                    lastUpdate = now
                end
            end)
        end)

        local toggleButton = Instance.new("TextButton", mgui)
        toggleButton.Size = UDim2.new(0, 190, 0, 48)
        toggleButton.Position = UDim2.new(0, 40, 0, 40)
        toggleButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        toggleButton.Text = "Toggle Menu"
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.TextSize = 17
        toggleButton.Font = CUSTOM_FONT
        toggleButton.Active = true
        toggleButton.Draggable = true
        Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)
        local tbStroke = Instance.new("UIStroke", toggleButton)
        rs.RenderStepped:Connect(function() if tbStroke and tbStroke.Parent then tbStroke.Color = getThemeColor(1) end end)

        -- Silent Aim Toggle Button (On/Off)
        local silentAimActive = false
        local silentAimButton = Instance.new("TextButton", mgui)
        silentAimButton.Size = UDim2.new(0, 190, 0, 48)
        silentAimButton.Position = UDim2.new(0, 40, 0, 105)
        silentAimButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        silentAimButton.Text = "Silent Aim: OFF"
        silentAimButton.TextColor3 = Color3.fromRGB(255, 50, 50)
        silentAimButton.TextSize = 16
        silentAimButton.Font = CUSTOM_FONT
        silentAimButton.Active = true
        silentAimButton.Draggable = true
        Instance.new("UICorner", silentAimButton).CornerRadius = UDim.new(0, 8)
        local sabStroke = Instance.new("UIStroke", silentAimButton)
        rs.RenderStepped:Connect(function() if sabStroke and sabStroke.Parent then sabStroke.Color = getThemeColor(1) end end)

        silentAimButton.MouseButton1Click:Connect(function()
            silentAimActive = not silentAimActive
            if silentAimActive then
                silentAimButton.Text = "Silent Aim: ON"
                silentAimButton.TextColor3 = Color3.fromRGB(50, 255, 50)
                sendNotification("Silent Aim", "Enabled successfully!", 1.5)
            else
                silentAimButton.Text = "Silent Aim: OFF"
                silentAimButton.TextColor3 = Color3.fromRGB(255, 50, 50)
                sendNotification("Silent Aim", "Disabled!", 1.5)
            end
        end)

        local mapButton = Instance.new("TextButton", mgui)
        mapButton.Size = UDim2.new(0, 190, 0, 48)
        mapButton.Position = UDim2.new(0, 40, 0, 170)
        mapButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        mapButton.Text = "TP to Map"
        mapButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        mapButton.TextSize = 17
        mapButton.Font = CUSTOM_FONT
        Instance.new("UICorner", mapButton).CornerRadius = UDim.new(0, 8)
        local mbStroke = Instance.new("UIStroke", mapButton)
        rs.RenderStepped:Connect(function() if mbStroke and mbStroke.Parent then mbStroke.Color = getThemeColor(1) end end)

        mapButton.MouseButton1Click:Connect(function()
            pcall(function()
                local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local targetPos = nil
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if (obj.Name == "Map" or obj.Name == "CoinContainer") and obj:IsA("Model") then
                            for _, part in pairs(obj:GetDescendants()) do
                                if part:IsA("BasePart") then targetPos = part.Position + Vector3.new(0, 5, 0); break end
                            end
                            if targetPos then break end
                        end
                    end
                    hrp.CFrame = CFrame.new(targetPos or Vector3.new(0, 50, 0))
                    sendNotification("Teleport", "Teleported to map!", 2)
                end
            end)
        end)

        local lobbyButton = Instance.new("TextButton", mgui)
        lobbyButton.Size = UDim2.new(0, 190, 0, 48)
        lobbyButton.Position = UDim2.new(0, 40, 0, 235)
        lobbyButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        lobbyButton.Text = "TP to Lobby"
        lobbyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        lobbyButton.TextSize = 17
        lobbyButton.Font = CUSTOM_FONT
        Instance.new("UICorner", lobbyButton).CornerRadius = UDim.new(0, 8)
        local lbStroke = Instance.new("UIStroke", lobbyButton)
        rs.RenderStepped:Connect(function() if lbStroke and lbStroke.Parent then lbStroke.Color = getThemeColor(1) end end)

        lobbyButton.MouseButton1Click:Connect(function()
            pcall(function()
                local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp then 
                    hrp.CFrame = CFrame.new(0, 10, 0) 
                    sendNotification("Teleport", "Returned to Lobby!", 2)
                end
            end)
        end)

        -- Main Panel Frame
        local f = Instance.new("Frame", mgui)
        f.Size = UDim2.new(0, 560, 0, 600)
        f.Position = UDim2.new(0.5, -280, 0.5, -300)
        f.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
        f.Active = true
        f.Draggable = true
        f.ClipsDescendants = true
        f.Visible = false

        toggleButton.MouseButton1Click:Connect(function() f.Visible = not f.Visible end)
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
        local fStroke = Instance.new("UIStroke", f)
        fStroke.Transparency = 0.2
        rs.RenderStepped:Connect(function() if fStroke and fStroke.Parent then fStroke.Color = getThemeColor(1) end end)

        local t = Instance.new("TextLabel", f)
        t.Size = UDim2.new(1, 0, 0, 52)
        t.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        t.Text = "Hacked by - Panel"
        t.TextColor3 = Color3.fromRGB(255, 255, 255)
        t.TextSize = 18
        t.Font = CUSTOM_FONT
        Instance.new("UICorner", t).CornerRadius = UDim.new(0, 12)

        local catHolder = Instance.new("ScrollingFrame", f)
        catHolder.Size = UDim2.new(1, -24, 0, 42)
        catHolder.Position = UDim2.new(0, 12, 0, 60)
        catHolder.BackgroundTransparency = 1
        catHolder.CanvasSize = UDim2.new(0, 550, 0, 0)
        catHolder.ScrollBarThickness = 0

        local catLayout = Instance.new("UIListLayout", catHolder)
        catLayout.FillDirection = Enum.FillDirection.Horizontal
        catLayout.SortOrder = Enum.SortOrder.LayoutOrder
        catLayout.Padding = UDim.new(0, 8)

        local function createPage()
            local sc = Instance.new("ScrollingFrame", f)
            sc.Size = UDim2.new(1, -24, 1, -120)
            sc.Position = UDim2.new(0, 12, 0, 110)
            sc.BackgroundTransparency = 1
            sc.BorderSizePixel = 0
            sc.ScrollBarThickness = 6
            sc.Visible = false
            rs.RenderStepped:Connect(function() if sc and sc.Parent then sc.ScrollBarImageColor3 = getThemeColor(1) end end)
            local ll = Instance.new("UIListLayout", sc)
            ll.Padding = UDim.new(0, 10)
            ll.SortOrder = Enum.SortOrder.LayoutOrder
            ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                sc.CanvasSize = UDim2.new(0, 0, 0, ll.AbsoluteContentSize.Y + 30)
            end)
            return sc
        end

        local categories = {"Theme", "ESP & X-Ray", "Combat & Aim", "Trade & Misc", "Auto Farm"}
        local pageFrames = {}

        for i, catName in ipairs(categories) do
            local page = createPage()
            table.insert(pageFrames, page)

            local cBtn = Instance.new("TextButton", catHolder)
            cBtn.Size = UDim2.new(0, 100, 0, 40)
            cBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
            cBtn.Text = catName
            cBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
            cBtn.TextSize = 13
            cBtn.Font = CUSTOM_FONT
            Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 8)

            cBtn.MouseButton1Click:Connect(function()
                for _, pFrame in ipairs(pageFrames) do pFrame.Visible = false end
                page.Visible = true
            end)
            if i == 1 then page.Visible = true end
        end

        local function Tog(parentContainer, titleText, defaultState, callbackFunc)
            local f2 = Instance.new("Frame", parentContainer)
            f2.Size = UDim2.new(1, 0, 0, 50)
            f2.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
            f2.BackgroundTransparency = 0.4
            Instance.new("UICorner", f2).CornerRadius = UDim.new(0, 8)

            local lb = Instance.new("TextLabel", f2)
            lb.Size = UDim2.new(1, -70, 1, 0)
            lb.Position = UDim2.new(0, 16, 0, 0)
            lb.BackgroundTransparency = 1
            lb.Text = titleText
            lb.TextColor3 = Color3.fromRGB(240, 240, 240)
            lb.TextSize = 15
            lb.Font = CUSTOM_FONT
            lb.TextXAlignment = Enum.TextXAlignment.Left

            local bg2 = Instance.new("Frame", f2)
            bg2.Size = UDim2.new(0, 48, 0, 26)
            bg2.Position = UDim2.new(1, -58, 0.5, -13)
            bg2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            bg2.BorderSizePixel = 0
            Instance.new("UICorner", bg2).CornerRadius = UDim.new(0, 13)

            local circ = Instance.new("Frame", bg2)
            circ.Size = UDim2.new(0, 22, 0, 22)
            circ.Position = UDim2.new(0, 2, 0.5, -11)
            circ.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            circ.BorderSizePixel = 0
            Instance.new("UICorner", circ).CornerRadius = UDim.new(0, 11)

            local st = defaultState or false
            local function upd()
                if st then
                    bg2.BackgroundColor3 = getThemeColor(1)
                    circ.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    pcall(function() circ:TweenPosition(UDim2.new(0, 24, 0.5, -11), "Out", "Quad", 0.2, true) end)
                else
                    bg2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    circ.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                    pcall(function() circ:TweenPosition(UDim2.new(0, 2, 0.5, -11), "Out", "Quad", 0.2, true) end)
                end
            end
            upd()

            local btn = Instance.new("TextButton", f2)
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.MouseButton1Click:Connect(function()
                st = not st
                upd()
                if callbackFunc then pcall(callbackFunc, st) end
            end)
        end

        local function createStepControl(parentContainer, labelName, defaultVal, minVal, maxVal, step, callback)
            local frameBox = Instance.new("Frame", parentContainer)
            frameBox.Size = UDim2.new(1, 0, 0, 60)
            frameBox.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
            frameBox.BackgroundTransparency = 0.4
            Instance.new("UICorner", frameBox).CornerRadius = UDim.new(0, 8)

            local lbl = Instance.new("TextLabel", frameBox)
            lbl.Size = UDim2.new(1, -140, 1, 0)
            lbl.Position = UDim2.new(0, 16, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = labelName .. ": " .. defaultVal
            lbl.TextColor3 = Color3.fromRGB(240, 240, 240)
            lbl.TextSize = 15
            lbl.Font = CUSTOM_FONT
            lbl.TextXAlignment = Enum.TextXAlignment.Left

            local val = defaultVal

            local minusBtn = Instance.new("TextButton", frameBox)
            minusBtn.Size = UDim2.new(0, 42, 0, 36)
            minusBtn.Position = UDim2.new(1, -110, 0.5, -18)
            minusBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            minusBtn.Text = "-"
            minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            minusBtn.TextSize = 20
            minusBtn.Font = CUSTOM_FONT
            Instance.new("UICorner", minusBtn).CornerRadius = UDim.new(0, 6)

            local plusBtn = Instance.new("TextButton", frameBox)
            plusBtn.Size = UDim2.new(0, 42, 0, 36)
            plusBtn.Position = UDim2.new(1, -58, 0.5, -18)
            plusBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            plusBtn.Text = "+"
            plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            plusBtn.TextSize = 20
            plusBtn.Font = CUSTOM_FONT
            Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0, 6)

            minusBtn.MouseButton1Click:Connect(function()
                val = math.clamp(val - step, minVal, maxVal)
                lbl.Text = labelName .. ": " .. val
                if callback then pcall(callback, val) end
            end)

            plusBtn.MouseButton1Click:Connect(function()
                val = math.clamp(val + step, minVal, maxVal)
                lbl.Text = labelName .. ": " .. val
                if callback then pcall(callback, val) end
            end)

            return frameBox
        end

        local O = {}
        
        -- Tab 1: Theme
        Tog(pageFrames[1], "Rainbow Mode", true, function(s) rainbowModeActive = s end)
        local colorContainer = Instance.new("Frame", pageFrames[1])
        colorContainer.Size = UDim2.new(1, 0, 0, 48)
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
            cBtn.MouseButton1Click:Connect(function()
                rainbowModeActive = false
                customThemeColor = colData.Color
                sendNotification("Theme", colData.Name .." theme selected!", 1.5)
            end)
        end

        -- Tab 2: ESP & X-Ray
        Tog(pageFrames[2], "Perfect Role ESP", false, function(s) O.ESP = s end)
        Tog(pageFrames[2], "Wallhack X-Ray (See Through Walls)", false, function(s) 
            O.XRay = s
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and not part:IsDescendantOf(pl.Character) then
                    if s then
                        if part.Transparency < 0.5 then part.LocalTransparencyModifier = 0.5 end
                    else
                        part.LocalTransparencyModifier = 0
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
        Tog(pageFrames[4], "Freeze Trade", false, function(s) O.FreezeTrade = s end)
        Tog(pageFrames[4], "Force Accept Trade", false, function(s) O.ForceAccept = s end)
        Tog(pageFrames[4], "Infinite Jump", false, function(s) O.InfJump = s end)
        Tog(pageFrames[4], "Noclip (Walk Through Walls)", false, function(s) O.Noclip = s end)
        Tog(pageFrames[4], "FullBright", false, function(s) 
            lighting.Brightness = s and 2 or 1
            lighting.ClockTime = s and 14 or 0
            lighting.FogEnd = s and 100000 or 10000
        end)
        Tog(pageFrames[4], "FPS Display", false, function(s) O.FPS = s; fpsLabel.Visible = s end)

        createStepControl(pageFrames[4], "Character FOV", 70, 50, 120, 5, function(v) currentFOV = v end)
        createStepControl(pageFrames[4], "WalkSpeed", 16, 16, 200, 4, function(v)
            currentWalkSpeed = v
            pcall(function() pl.Character.Humanoid.WalkSpeed = v end)
        end)
        createStepControl(pageFrames[4], "JumpPower", 50, 50, 300, 10, function(v)
            currentJumpPower = v
            pcall(function()
                local hum = pl.Character.Humanoid
                hum.UseJumpPower = true
                hum.JumpPower = v
            end)
        end)

        -- Tab 5: Auto Farm & Role Fling / Anti-Autofarm
        Tog(pageFrames[5], "Auto Farm (Flying Smooth)", false, function(s) O.AF = s end)
        Tog(pageFrames[5], "Anti-Autofarm (Fling Other Farmers)", false, function(s) O.AntiAF = s end)
        Tog(pageFrames[5], "Fling Sheriff", false, function(s) O.FlingSheriff = s end)
        Tog(pageFrames[5], "Fling Murderer", false, function(s) O.FlingRoleMurderer = s end)
        createStepControl(pageFrames[5], "Autofarm Speed", 25, 5, 50, 5, function(v) autoFarmSpeed = v end)

        -- Background Loops & Core Functionality
        task.spawn(function()
            while true do
                task.wait(0.3)
                pcall(function()
                    if O.ESP then
                        for _, v in pairs(p:GetPlayers()) do
                            if v ~= pl and v.Character then
                                local hl = v.Character:FindFirstChild("PerfectESP")
                                if not hl then
                                    hl = Instance.new("Highlight", v.Character)
                                    hl.Name = "PerfectESP"
                                    hl.FillTransparency = 0.4
                                    hl.OutlineTransparency = 0.1
                                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                end
                                local hasKnife = v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife")) or v.Character:FindFirstChild("KnifeServer")
                                local hasGun = v.Character:FindFirstChild("Gun") or (v.Backpack and v.Backpack:FindFirstChild("Gun"))
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
                end)
            end
        end)

        -- NOCLIP LOOP
        rs.Stepped:Connect(function()
            if O.Noclip then
                pcall(function()
                    local char = pl.Character
                    if char then
                        for _, part in pairs(char:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            end
        end)

        -- ANTI-AUTOFARM LOOP
        task.spawn(function()
            while true do
                task.wait(0.5)
                pcall(function()
                    if O.AntiAF then
                        for _, player in pairs(p:GetPlayers()) do
                            if player ~= pl and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local otherHRP = player.Character.HumanoidRootPart
                                local otherHumanoid = player.Character:FindFirstChildOfClass("Humanoid")
                                if otherHRP.Position.Y < 300 and otherHumanoid then
                                    otherHRP.Velocity = Vector3.new(0, 400, 0)
                                end
                            end
                        end
                    end
                end)
            end
        end)

        -- FLING SHERIFF LOOP
        task.spawn(function()
            while true do
                task.wait(0.5)
                pcall(function()
                    if O.FlingSheriff then
                        for _, player in pairs(p:GetPlayers()) do
                            if player ~= pl and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local hasGun = player.Character:FindFirstChild("Gun") or (player.Backpack and player.Backpack:FindFirstChild("Gun"))
                                if hasGun then
                                    local otherHRP = player.Character.HumanoidRootPart
                                    if otherHRP.Position.Y < 300 then
                                        otherHRP.Velocity = Vector3.new(0, 500, 0)
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)

        -- FLING MURDERER LOOP
        task.spawn(function()
            while true do
                task.wait(0.5)
                pcall(function()
                    if O.FlingRoleMurderer then
                        for _, player in pairs(p:GetPlayers()) do
                            if player ~= pl and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local hasKnife = player.Character:FindFirstChild("Knife") or (player.Backpack and player.Backpack:FindFirstChild("Knife")) or player.Character:FindFirstChild("KnifeServer")
                                if hasKnife then
                                    local otherHRP = player.Character.HumanoidRootPart
                                    if otherHRP.Position.Y < 300 then
                                        otherHRP.Velocity = Vector3.new(0, 500, 0)
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)

        -- SILENT AIM LOOP
        task.spawn(function()
            while true do
                task.wait(0.05)
                pcall(function()
                    if silentAimActive then
                        local c2 = pl.Character
                        local gun = c2 and (c2:FindFirstChild("Gun") or pl.Backpack:FindFirstChild("Gun") or c2:FindFirstChild("GunServer"))
                        if gun then
                            for _, v in pairs(p:GetPlayers()) do
                                if v ~= pl and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                                    local hasKnife = v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife")) or v.Character:FindFirstChild("KnifeServer")
                                    if hasKnife then
                                        local targetHrp = v.Character.HumanoidRootPart
                                        camera.CFrame = CFrame.new(camera.CFrame.Position, targetHrp.Position)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)

        task.spawn(function()
            while true do
                task.wait(1)
                pcall(function()
                    if O.ExtraESP then
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj.Name == "GunDrop" and obj:IsA("BasePart") and not obj:FindFirstChild("GunESP") then
                                local hl = Instance.new("Highlight", obj)
                                hl.Name = "GunESP"
                                hl.FillColor = Color3.fromRGB(255, 255, 0)
                            elseif obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name:lower():find("gold")) and not obj:FindFirstChild("CoinESP") then
                                local hl = Instance.new("Highlight", obj)
                                hl.Name = "CoinESP"
                                hl.FillColor = Color3.fromRGB(255, 215, 0)
                            end
                        end
                    else
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("Highlight") and (obj.Name == "GunESP" or obj.Name == "CoinESP") then obj:Destroy() end
                        end
                    end
                end)
            end
        end)

        -- AUTO GRAB GUN
        task.spawn(function()
            while true do
                task.wait(0.2)
                pcall(function()
                    if O.AutoGrabGun then
                        local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            for _, obj in pairs(workspace:GetDescendants()) do
                                if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                                    local savedCFrame = hrp.CFrame
                                    hrp.CFrame = obj.CFrame
                                    task.wait(0.15)
                                    hrp.CFrame = savedCFrame
                                    sendNotification("Auto Grab", "Gun grabbed & returned!", 2)
                                    break 
                                end
                            end
                        end
                    end
                end)
            end
        end)

        task.spawn(function()
            while true do
                task.wait(0.3)
                pcall(function()
                    if O.AutoSheriff then
                        local c2 = pl.Character
                        local gun = c2 and (c2:FindFirstChild("Gun") or pl.Backpack:FindFirstChild("Gun"))
                        if not gun and c2 and c2:FindFirstChild("Humanoid") then
                            local bpGun = pl.Backpack:FindFirstChild("Gun")
                            if bpGun then bpGun.Parent = c2; gun = bpGun end
                        end
                        if gun then
                            for _, v in pairs(p:GetPlayers()) do
                                if v ~= pl and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                                    if v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife")) then
                                        local ev = gun:FindFirstChildWhichIsA("RemoteEvent")
                                        if ev then ev:FireServer(v.Character.HumanoidRootPart.Position) end
                                        break
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)

        task.spawn(function()
            while true do
                task.wait(0.3)
                pcall(function()
                    if O.KA then
                        local c2 = pl.Character
                        local knife = c2 and (c2:FindFirstChild("Knife") or pl.Backpack:FindFirstChild("Knife"))
                        if knife then
                            if knife.Parent == pl.Backpack then knife.Parent = c2 end
                            for _, v in pairs(p:GetPlayers()) do
                                if v ~= pl and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                                    local rp = c2:FindFirstChild("HumanoidRootPart")
                                    if rp then
                                        rp.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                                        task.wait(0.05)
                                        local ev = knife:FindFirstChildWhichIsA("RemoteEvent")
                                        if ev then ev:FireServer(v.Character.HumanoidRootPart) end
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)

        task.spawn(function()
            while true do
                task.wait(0.05)
                pcall(function()
                    if O.GodMode then
                        local hum = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
                    end
                end)
            end
        end)

        task.spawn(function()
            while true do
                task.wait(0.1)
                pcall(function()
                    if O.FlingMurderer then
                        local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                        local hum = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.Health > 0 then
                            local origPos = hrp.CFrame
                            local targeted = false
                            
                            for _, v in pairs(p:GetPlayers()) do
                                if not O.FlingMurderer then break end
                                if v ~= pl and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
                                    local hasKnife = v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife")) or v.Character:FindFirstChild("KnifeServer")
                                    if hasKnife then
                                        targeted = true
                                        local targetHrp = v.Character.HumanoidRootPart
                                        local targetHum = v.Character.Humanoid
                                        
                                        while targetHrp and targetHrp.Parent and targetHum.Health > 0 and O.FlingMurderer do
                                            hum.Health = hum.MaxHealth
                                            hrp.CFrame = targetHrp.CFrame
                                            hrp.Velocity = Vector3.new(40000, 40000, 40000)
                                            hrp.RotVelocity = Vector3.new(40000, 40000, 40000)
                                            task.wait(0.02)
                                        end
                                    end
                                end
                            end
                            
                            if targeted then
                                hrp.Velocity = Vector3.new(0, 0, 0)
                                hrp.RotVelocity = Vector3.new(0, 0, 0)
                                hrp.CFrame = origPos
                                sendNotification("Success", "Murderer neutralized & Returned!", 2)
                                task.wait(0.5)
                            end
                        end
                    end
                end)
            end
        end)

        -- DÜZELTİLDİ: JavaScript ok fonksiyonu yerine standart Lua fonksiyonu kullanıldı
        uis.JumpRequest:Connect(function()
            if O.InfJump then
                pcall(function() pl.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
            end
        end)

        -- AUTO FARM
        task.spawn(function()
            while true do
                task.wait(0.05)
                pcall(function()
                    if O.AF then
                        local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                        local hum = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.Health > 0 then
                            hum.PlatformStand = true
                            for _, v in pairs((workspace:FindFirstChild("CoinContainer") or workspace):GetDescendants()) do
                                if not O.AF then break end
                                if v:IsA("BasePart") and (v.Name:lower():find("coin") or v.Name:lower():find("gold") or v.Name:lower():find("gem")) and v.Transparency < 1 then
                                    local targetCF = v.CFrame + Vector3.new(0, 0.5, 0)
                                    local distance = (hrp.Position - targetCF.Position).Magnitude
                                    
                                    local speedVal = math.clamp(autoFarmSpeed, 5, 50)
                                    local travelTime = distance / (speedVal * 10)
                                    travelTime = math.clamp(travelTime, 0.05, 1.5)
                                    
                                    local startTime = tick()
                                    local startCF = hrp.CFrame
                                    while tick() - startTime < travelTime do
                                        if not O.AF then break end
                                        local alpha = (tick() - startTime) / travelTime
                                        hrp.CFrame = startCF:Lerp(targetCF, alpha)
                                        rs.RenderStepped:Wait()
                                    end
                                    hrp.CFrame = targetCF
                                    task.wait(0.05)
                                end
                            end
                            hum.PlatformStand = false
                        end
                    end
                end)
            end
        end)

        sendNotification("Loaded", "Script fixed & ready to use!", 3)
    else
        textBox.Text = ""
        textBox.PlaceholderText = "WRONG KEY!"
        task.wait(1.5)
        textBox.PlaceholderText = "Enter key..."
    end
end)
