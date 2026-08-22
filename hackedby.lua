-- ==========================================
-- HACKED BY + ULTIMATE MM2 SCRIPT (BIGGER MENU & TEXT)
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

-- Global Speed & Jump Settings
local currentWalkSpeed = 16
local currentJumpPower = 16
local autoFarmSpeed = 16

local function getThemeColor(speed)
    if rainbowModeActive then
        local hue = (tick() * (speed or 1)) % 1
        return Color3.fromHSV(hue, 1, 1)
    else
        return customThemeColor
    end
end

-- Anti-Ban Security Layer
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
notifHolder.Size = UDim2.new(0, 280, 0, 400)
notifHolder.Position = UDim2.new(1, -295, 1, -415)
notifHolder.BackgroundTransparency = 1
local notifLayout = Instance.new("UIListLayout", notifHolder)
notifLayout.SortOrder = Enum.SortOrder.LayoutOrder
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
notifLayout.Padding = UDim.new(0, 8)

local function sendNotification(titleText, msgText, duration)
    task.spawn(function()
        local box = Instance.new("Frame", notifHolder)
        box.Size = UDim2.new(1, 0, 0, 60)
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
        tLbl.Size = UDim2.new(1, -15, 0, 22)
        tLbl.Position = UDim2.new(0, 12, 0, 6)
        tLbl.BackgroundTransparency = 1
        tLbl.Text = titleText
        tLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        tLbl.TextSize = 15
        tLbl.Font = Enum.Font.Antique
        tLbl.TextXAlignment = Enum.TextXAlignment.Left

        local mLbl = Instance.new("TextLabel", box)
        mLbl.Size = UDim2.new(1, -15, 0, 22)
        mLbl.Position = UDim2.new(0, 12, 0, 28)
        mLbl.BackgroundTransparency = 1
        mLbl.Text = msgText
        mLbl.TextColor3 = Color3.fromRGB(180, 180, 180)
        mLbl.TextSize = 13
        mLbl.Font = Enum.Font.Antique
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
frame.Size = UDim2.new(0, 380, 0, 230)
frame.Position = UDim2.new(0.5, -190, 0.5, -115)
frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
rs.RenderStepped:Connect(function() if stroke and stroke.Parent then stroke.Color = getThemeColor(1) end end)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
title.Text = "Hacked by (Key System)"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.Antique
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.85, 0, 0, 45)
textBox.Position = UDim2.new(0.075, 0, 0.3, 0)
textBox.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "Enter key..."
textBox.Text = ""
textBox.TextSize = 15
textBox.Font = Enum.Font.Antique
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

local getKeyBtn = Instance.new("TextButton", frame)
getKeyBtn.Size = UDim2.new(0.4, 0, 0, 40)
getKeyBtn.Position = UDim2.new(0.075, 0, 0.62, 0)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
getKeyBtn.Text = "Get Key"
getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyBtn.TextSize = 15
getKeyBtn.Font = Enum.Font.Antique
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0, 6)

getKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(LOOTLABS_LINK)
        getKeyBtn.Text = "Link Copied!"
        task.wait(2)
        getKeyBtn.Text = "Get Key"
    end
end)

local loginBtn = Instance.new("TextButton", frame)
loginBtn.Size = UDim2.new(0.4, 0, 0, 40)
loginBtn.Position = UDim2.new(0.525, 0, 0.62, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
loginBtn.Text = "Login"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.TextSize = 15
loginBtn.Font = Enum.Font.Antique
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 6)

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

        -- Constant Character Loop to enforce WalkSpeed & JumpPower on Respawn
        task.spawn(function()
            while true do
                task.wait(0.2)
                pcall(function()
                    local char = pl.Character
                    if char then
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum then
                            if hum.WalkSpeed ~= currentWalkSpeed then
                                hum.WalkSpeed = currentWalkSpeed
                            end
                            hum.UseJumpPower = true
                            if hum.JumpPower ~= currentJumpPower then
                                hum.JumpPower = currentJumpPower
                            end
                        end
                    end
                end)
            end
        end)

        local fpsLabel = Instance.new("TextLabel", mgui)
        fpsLabel.Size = UDim2.new(0, 130, 0, 35)
        fpsLabel.Position = UDim2.new(0, 15, 1, -50)
        fpsLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        fpsLabel.BackgroundTransparency = 0.3
        fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        fpsLabel.TextSize = 15
        fpsLabel.Font = Enum.Font.Antique
        fpsLabel.Text = "FPS: 0"
        fpsLabel.Visible = false
        Instance.new("UICorner", fpsLabel).CornerRadius = UDim.new(0, 6)
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
        toggleButton.Size = UDim2.new(0, 175, 0, 45)
        toggleButton.Position = UDim2.new(0, 40, 0, 40)
        toggleButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        toggleButton.Text = "Toggle Menu"
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.TextSize = 16
        toggleButton.Font = Enum.Font.Antique
        toggleButton.Active = true
        toggleButton.Draggable = true
        Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)
        local tbStroke = Instance.new("UIStroke", toggleButton)
        rs.RenderStepped:Connect(function() if tbStroke and tbStroke.Parent then tbStroke.Color = getThemeColor(1) end end)

        local shootButton = Instance.new("TextButton", mgui)
        shootButton.Size = UDim2.new(0, 175, 0, 45)
        shootButton.Position = UDim2.new(0, 40, 0, 100)
        shootButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        shootButton.Text = "Shoot Murderer"
        shootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        shootButton.TextSize = 15
        shootButton.Font = Enum.Font.Antique
        shootButton.Active = true
        shootButton.Draggable = true
        Instance.new("UICorner", shootButton).CornerRadius = UDim.new(0, 8)
        local sbStroke = Instance.new("UIStroke", shootButton)
        rs.RenderStepped:Connect(function() if sbStroke and sbStroke.Parent then sbStroke.Color = getThemeColor(1) end end)

        shootButton.MouseButton1Click:Connect(function()
            pcall(function()
                local c2 = pl.Character
                local gun = c2 and (c2:FindFirstChild("Gun") or pl.Backpack:FindFirstChild("Gun"))
                if not gun and c2 and c2:FindFirstChild("Humanoid") then
                    local bpGun = pl.Backpack:FindFirstChild("Gun")
                    if bpGun then bpGun.Parent = c2; gun = bpGun end
                end

                if not gun then
                    sendNotification("Error", "You don't have a gun!", 1.5)
                    return
                end

                local murderer = nil
                for _, v in pairs(p:GetPlayers()) do
                    if v ~= pl and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local hasKnife = v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife")) or v.Character:FindFirstChild("KnifeServer")
                        if hasKnife then
                            murderer = v
                            break
                        end
                    end
                end

                if not murderer then
                    sendNotification("Info", "No Murderer found with knife!", 1.5)
                    return
                end

                local murdererHRP = murderer.Character:FindFirstChild("HumanoidRootPart")
                if not murdererHRP then return end

                local origin = c2.HumanoidRootPart.Position
                local direction = (Vector3.new(murdererHRP.Position.X, origin.Y, murdererHRP.Position.Z) - origin).unit * 1000
                
                local params = RaycastParams.new()
                params.FilterType = Enum.RaycastFilterType.Exclude
                params.FilterDescendantsInstances = {c2}

                local raycastResult = workspace:Raycast(origin, direction, params)
                local isVisible = false

                if raycastResult and raycastResult.Instance and raycastResult.Instance:IsDescendantOf(murderer.Character) then
                    isVisible = true
                end

                if isVisible then
                    local ev = gun:FindFirstChildWhichIsA("RemoteEvent")
                    if ev then ev:FireServer(murdererHRP.Position) end
                    sendNotification("Success", "Shot Murderer accurately!", 2)
                else
                    sendNotification("Info", "Waiting for murderer to be in view...", 2)
                    local connection
                    connection = rs.Stepped:Connect(function()
                        if not c2 or not murderer.Character or not murdererHRP.Parent then
                            if connection then connection:Disconnect() end
                            return
                        end

                        local curOrigin = c2.HumanoidRootPart.Position
                        local curDir = (Vector3.new(murdererHRP.Position.X, curOrigin.Y, murdererHRP.Position.Z) - curOrigin).unit * 1000
                        local curRay = workspace:Raycast(curOrigin, curDir, params)

                        if curRay and curRay.Instance and curRay.Instance:IsDescendantOf(murderer.Character) then
                            local ev = gun:FindFirstChildWhichIsA("RemoteEvent")
                            if ev then ev:FireServer(murdererHRP.Position) end
                            if connection then connection:Disconnect() end
                            sendNotification("Success", "Shot fired as murderer came into view!", 2)
                        end
                    end)
                end
            end)
        end)

        local mapButton = Instance.new("TextButton", mgui)
        mapButton.Size = UDim2.new(0, 175, 0, 45)
        mapButton.Position = UDim2.new(0, 40, 0, 160)
        mapButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        mapButton.Text = "TP to Map"
        mapButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        mapButton.TextSize = 16
        mapButton.Font = Enum.Font.Antique
        mapButton.Active = true
        mapButton.Draggable = true
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
        lobbyButton.Size = UDim2.new(0, 175, 0, 45)
        lobbyButton.Position = UDim2.new(0, 40, 0, 220)
        lobbyButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        lobbyButton.Text = "TP to Lobby"
        lobbyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        lobbyButton.TextSize = 16
        lobbyButton.Font = Enum.Font.Antique
        lobbyButton.Active = true
        lobbyButton.Draggable = true
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

        -- Expanded Main Panel Frame (Bigger width & height)
        local f = Instance.new("Frame", mgui)
        f.Size = UDim2.new(0, 520, 0, 560)
        f.Position = UDim2.new(0.5, -260, 0.5, -280)
        f.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
        f.Active = true
        f.Draggable = true
        f.ClipsDescendants = true
        f.Visible = false

        toggleButton.MouseButton1Click:Connect(function() f.Visible = not f.Visible end)
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
        local fStroke = Instance.new("UIStroke", f)
        f.Transparency = 0
        fStroke.Transparency = 0.2
        rs.RenderStepped:Connect(function() if fStroke and fStroke.Parent then fStroke.Color = getThemeColor(1) end end)

        local t = Instance.new("TextLabel", f)
        t.Size = UDim2.new(1, 0, 0, 48)
        t.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        t.Text = "Hacked by - Panel"
        t.TextColor3 = Color3.fromRGB(255, 255, 255)
        t.TextSize = 17
        t.Font = Enum.Font.Antique
        Instance.new("UICorner", t).CornerRadius = UDim.new(0, 12)

        local catHolder = Instance.new("ScrollingFrame", f)
        catHolder.Size = UDim2.new(1, -24, 0, 38)
        catHolder.Position = UDim2.new(0, 12, 0, 54)
        catHolder.BackgroundTransparency = 1
        catHolder.CanvasSize = UDim2.new(0, 520, 0, 0)
        catHolder.ScrollBarThickness = 0

        local catLayout = Instance.new("UIListLayout", catHolder)
        catLayout.FillDirection = Enum.FillDirection.Horizontal
        catLayout.SortOrder = Enum.SortOrder.LayoutOrder
        catLayout.Padding = UDim.new(0, 8)

        local function createPage()
            local sc = Instance.new("ScrollingFrame", f)
            sc.Size = UDim2.new(1, -24, 1, -110)
            sc.Position = UDim2.new(0, 12, 0, 100)
            sc.BackgroundTransparency = 1
            sc.BorderSizePixel = 0
            sc.ScrollBarThickness = 6
            sc.Visible = false
            rs.RenderStepped:Connect(function() if sc and sc.Parent then sc.ScrollBarImageColor3 = getThemeColor(1) end end)
            local ll = Instance.new("UIListLayout", sc)
            ll.Padding = UDim.new(0, 10)
            ll.SortOrder = Enum.SortOrder.LayoutOrder
            ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                sc.CanvasSize = UDim2.new(0, 0, 0, ll.AbsoluteContentSize.Y + 25)
            end)
            return sc
        end

        local categories = {"Theme", "ESP & Roles", "Combat", "Trade & Misc", "Auto Farm"}
        local pageFrames = {}

        for i, catName in ipairs(categories) do
            local page = createPage()
            table.insert(pageFrames, page)

            local cBtn = Instance.new("TextButton", catHolder)
            cBtn.Size = UDim2.new(0, 94, 0, 36)
            cBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
            cBtn.Text = catName
            cBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
            cBtn.TextSize = 13
            cBtn.Font = Enum.Font.Antique
            Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 6)

            cBtn.MouseButton1Click:Connect(function()
                for _, pFrame in ipairs(pageFrames) do pFrame.Visible = false end
                page.Visible = true
            end)
            if i == 1 then page.Visible = true end
        end

        local function Tog(parentContainer, titleText, defaultState, callbackFunc)
            local f2 = Instance.new("Frame", parentContainer)
            f2.Size = UDim2.new(1, 0, 0, 44)
            f2.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
            f2.BackgroundTransparency = 0.4
            Instance.new("UICorner", f2).CornerRadius = UDim.new(0, 6)

            local lb = Instance.new("TextLabel", f2)
            lb.Size = UDim2.new(1, -60, 1, 0)
            lb.Position = UDim2.new(0, 14, 0, 0)
            lb.BackgroundTransparency = 1
            lb.Text = titleText
            lb.TextColor3 = Color3.fromRGB(235, 235, 235)
            lb.TextSize = 14
            lb.Font = Enum.Font.Antique
            lb.TextXAlignment = Enum.TextXAlignment.Left

            local bg2 = Instance.new("Frame", f2)
            bg2.Size = UDim2.new(0, 42, 0, 24)
            bg2.Position = UDim2.new(1, -52, 0.5, -12)
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
                    pcall(function() circ:TweenPosition(UDim2.new(0, 20, 0.5, -10), "Out", "Quad", 0.2, true) end)
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
            btn.MouseButton1Click:Connect(function()
                st = not st
                upd()
                if callbackFunc then pcall(callbackFunc, st) end
            end)
        end

        local O = {}
        
        Tog(pageFrames[1], "Rainbow Mode", true, function(s) rainbowModeActive = s end)
        local colorContainer = Instance.new("Frame", pageFrames[1])
        colorContainer.Size = UDim2.new(1, 0, 0, 42)
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
            Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 6)
            cBtn.MouseButton1Click:Connect(function()
                rainbowModeActive = false
                customThemeColor = colData.Color
                sendNotification("Theme", colData.Name .." theme selected!", 1.5)
            end)
        end

        Tog(pageFrames[2], "Perfect Role ESP", false, function(s) O.ESP = s end)
        Tog(pageFrames[2], "Sheriff Gun & Coin ESP", false, function(s) O.ExtraESP = s end)

        Tog(pageFrames[3], "Auto Grab Gun", false, function(s) O.AutoGrabGun = s end)
        Tog(pageFrames[3], "Auto Sheriff Target", false, function(s) O.AutoSheriff = s end)
        Tog(pageFrames[3], "Kill All (Murderer)", false, function(s) O.KA = s end)
        Tog(pageFrames[3], "Auto Avoid Knife", false, function(s) O.Avoid = s end)
        Tog(pageFrames[3], "God Mode Shield", false, function(s) O.GodMode = s end)
        Tog(pageFrames[3], "God Fling Murderer (You Live, Target Dies)", false, function(s) O.FlingMurderer = s end)
        Tog(pageFrames[3], "God Fling Sheriff (You Live, Target Dies)", false, function(s) O.FlingSheriff = s end)

        Tog(pageFrames[4], "Freeze Trade", false, function(s) O.FreezeTrade = s end)
        Tog(pageFrames[4], "Force Accept Trade", false, function(s) O.ForceAccept = s end)
        Tog(pageFrames[4], "Infinite Jump", false, function(s) O.InfJump = s end)
        Tog(pageFrames[4], "FullBright", false, function(s) 
            lighting.Brightness = s and 2 or 1
            lighting.ClockTime = s and 14 or 0
            lighting.FogEnd = s and 100000 or 10000
        end)
        Tog(pageFrames[4], "FPS Display", false, function(s) O.FPS = s; fpsLabel.Visible = s end)

        Tog(pageFrames[5], "Auto Farm (Flying Smooth)", false, function(s) O.AF = s end)
        
        -- Helper function to create custom sliders with bigger sizes
        local function createSlider(parentContainer, labelName, defaultVal, callback)
            local frameBox = Instance.new("Frame", parentContainer)
            frameBox.Size = UDim2.new(1, 0, 0, 58)
            frameBox.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
            frameBox.BackgroundTransparency = 0.4
            Instance.new("UICorner", frameBox).CornerRadius = UDim.new(0, 6)

            local lbl = Instance.new("TextLabel", frameBox)
            lbl.Size = UDim2.new(1, -20, 0, 24)
            lbl.Position = UDim2.new(0, 14, 0, 5)
            lbl.BackgroundTransparency = 1
            lbl.Text = labelName .. ": " .. defaultVal
            lbl.TextColor3 = Color3.fromRGB(235, 235, 235)
            lbl.TextSize = 14
            lbl.Font = Enum.Font.Antique
            lbl.TextXAlignment = Enum.TextXAlignment.Left

            local sliderBg = Instance.new("Frame", frameBox)
            sliderBg.Size = UDim2.new(1, -28, 0, 10)
            sliderBg.Position = UDim2.new(0, 14, 0, 36)
            sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(0, 5)

            local sliderFill = Instance.new("Frame", sliderBg)
            sliderFill.Size = UDim2.new(defaultVal/100, 0, 1, 0)
            sliderFill.BackgroundColor3 = customThemeColor
            Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(0, 5)
            rs.RenderStepped:Connect(function() if sliderFill and sliderFill.Parent then sliderFill.BackgroundColor3 = getThemeColor(1) end end)

            local val = defaultVal
            local dragging = false
            local sliderBtn = Instance.new("TextButton", sliderBg)
            sliderBtn.Size = UDim2.new(1, 0, 1, 0)
            sliderBtn.BackgroundTransparency = 1
            sliderBtn.Text = ""

            sliderBtn.MouseButton1Down:Connect(function() dragging = true end)
            uis.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
            uis.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                    sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                    val = math.floor(pos * 100)
                    if val < 1 then val = 1 end
                    lbl.Text = labelName .. ": " .. val
                    if callback then pcall(callback, val) end
                end
            end)
            return frameBox
        end

        createSlider(pageFrames[5], "Autofarm Fly Speed", 16, function(v) autoFarmSpeed = v end)
        createSlider(pageFrames[4], "WalkSpeed", 16, function(v)
            currentWalkSpeed = v
            pcall(function() pl.Character.Humanoid.WalkSpeed = v end)
        end)
        createSlider(pageFrames[4], "JumpPower", 16, function(v)
            currentJumpPower = v
            pcall(function()
                local hum = pl.Character.Humanoid
                hum.UseJumpPower = true
                hum.JumpPower = v
            end)
        end)

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

        task.spawn(function()
            while true do
                task.wait(0.2)
                pcall(function()
                    if O.AutoGrabGun then
                        local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            for _, obj in pairs(workspace:GetDescendants()) do
                                if obj.Name == "GunDrop" and obj:IsA("BasePart") then hrp.CFrame = obj.CFrame; task.wait(0.1); break end
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
                task.wait(0.1)
                pcall(function()
                    if O.Avoid then
                        local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            for _, v in pairs(p:GetPlayers()) do
                                if v ~= pl and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                                    if v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife")) then
                                        if (hrp.Position - v.Character.HumanoidRootPart.Position).Magnitude < 14 then
                                            hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * -10) + Vector3.new(0, 5, 0)
                                        end
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

        -- God Fling Murderer
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
                                sendNotification("Success", "Murderer neutralized & Returned to position!", 2)
                                task.wait(0.5)
                            end
                        end
                    end
                end)
            end
        end)

        -- God Fling Sheriff
        task.spawn(function()
            while true do
                task.wait(0.1)
                pcall(function()
                    if O.FlingSheriff then
                        local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                        local hum = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.Health > 0 then
                            local origPos = hrp.CFrame
                            local targeted = false

                            for _, v in pairs(p:GetPlayers()) do
                                if not O.FlingSheriff then break end
                                if v ~= pl and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
                                    local hasGun = v.Character:FindFirstChild("Gun") or (v.Backpack and v.Backpack:FindFirstChild("Gun"))
                                    if hasGun then
                                        targeted = true
                                        local targetHrp = v.Character.HumanoidRootPart
                                        local targetHum = v.Character.Humanoid
                                        
                                        while targetHrp and targetHrp.Parent and targetHum.Health > 0 and O.FlingSheriff do
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
                                sendNotification("Success", "Sheriff neutralized & Returned to position!", 2)
                                task.wait(0.5)
                            end
                        end
                    end
                end)
            end
        end)

        uis.JumpRequest:Connect(function()
            if O.InfJump then
                pcall(function() pl.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
            end
        end)

        -- Smooth Flying Autofarm (Controlled by Autofarm Speed Slider)
        task.spawn(function()
            while true do
                task.wait(0.05)
                pcall(function()
                    if O.AF then
                        local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                        local hum = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.Health > 0 then
                            for _, v in pairs((workspace:FindFirstChild("CoinContainer") or workspace):GetDescendants()) do
                                if not O.AF then break end
                                if v:IsA("BasePart") and (v.Name:lower():find("coin") or v.Name:lower():find("gold") or v.Name:lower():find("gem")) and v.Transparency < 1 then
                                    local targetCF = v.CFrame + Vector3.new(0, 0.5, 0)
                                    local distance = (hrp.Position - targetCF.Position).Magnitude
                                    local travelTime = math.clamp(distance / (autoFarmSpeed * 15), 0.01, 0.3)
                                    
                                    local startTime = tick()
                                    local startCF = hrp.CFrame
                                    while tick() - startTime < travelTime do
                                        if not O.AF then break end
                                        local alpha = (tick() - startTime) / travelTime
                                        hrp.CFrame = startCF:Lerp(targetCF, alpha)
                                        rs.RenderStepped:Wait()
                                    end
                                    hrp.CFrame = targetCF
                                    task.wait(0.02 + math.random(1, 3)/100)
                                end
                            end
                        end
                    end
                end)
            end
        end)

        sendNotification("Loaded", "Script fully ready with bigger UI and text!", 3)
    else
        textBox.Text = ""
        textBox.PlaceholderText = "WRONG KEY!"
        task.wait(1.5)
        textBox.PlaceholderText = "Enter key..."
    end
end)
