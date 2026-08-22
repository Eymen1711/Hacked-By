-- ==========================================
-- HACKED BY + NOTIFICATION SYSTEM
-- ==========================================

local p = game:GetService("Players")
local pl = p.LocalPlayer
local workspace = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local ts = game:GetService("TweenService")
local camera = workspace.CurrentCamera

local LOOTLABS_LINK = "https://loot-link.com/s?9K7cNpua"
local CORRECT_KEY = "5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3"

-- Dinamik Rainbow Renk Fonksiyonu
local function getRainbowColor(speed)
    local hue = (tick() * (speed or 1)) % 1
    return Color3.fromHSV(hue, 1, 1)
end

-- Bildirim Sistemi (Toast Notification)
local notifGui = Instance.new("ScreenGui")
notifGui.Name = "MM2_Notifications"
notifGui.ResetOnSpawn = false
pcall(function() notifGui.Parent = game:GetService("CoreGui") end)
if not notifGui.Parent then pcall(function() notifGui.Parent = pl:WaitForChild("PlayerGui") end) end

local notifHolder = Instance.new("Frame", notifGui)
notifHolder.Size = UDim2.new(0, 260, 1, 0)
notifHolder.Position = UDim2.new(1, -280, 0, 20)
notifHolder.BackgroundTransparency = 1
local notifLayout = Instance.new("UIListLayout", notifHolder)
notifLayout.SortOrder = Enum.SortOrder.LayoutOrder
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
notifLayout.Padding = UDim.new(0, 8)

local function sendNotification(titleText, msgText, duration)
    task.spawn(function()
        local box = Instance.new("Frame", notifHolder)
        box.Size = UDim2.new(1, 0, 0, 55)
        box.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        box.BackgroundTransparency = 0.1
        box.Position = UDim2.new(1, 50, 0, 0)
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
        
        local stroke = Instance.new("UIStroke", box)
        stroke.Thickness = 1.5
        
        -- Rainbow Stroke Sync for Notification
        local conn
        conn = rs.RenderStepped:Connect(function()
            stroke.Color = getRainbowColor(0.8)
        end)

        local tLbl = Instance.new("TextLabel", box)
        tLbl.Size = UDim2.new(1, -15, 0, 20)
        tLbl.Position = UDim2.new(0, 12, 0, 6)
        tLbl.BackgroundTransparency = 1
        tLbl.Text = titleText
        tLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        tLbl.TextSize = 13
        tLbl.Font = Enum.Font.SourceSansBold
        tLbl.TextXAlignment = Enum.TextXAlignment.Left

        local mLbl = Instance.new("TextLabel", box)
        mLbl.Size = UDim2.new(1, -15, 0, 20)
        mLbl.Position = UDim2.new(0, 12, 0, 26)
        mLbl.BackgroundTransparency = 1
        mLbl.Text = msgText
        mLbl.TextColor3 = Color3.fromRGB(180, 180, 180)
        mLbl.TextSize = 12
        mLbl.Font = Enum.Font.SourceSans
        mLbl.TextXAlignment = Enum.TextXAlignment.Left

        box:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.3, true)
        task.wait(duration or 2.5)
        box:TweenPosition(UDim2.new(1, 50, 0, 0), "In", "Quad", 0.3, true)
        task.wait(0.3)
        if conn then conn:Disconnect() end
        box:Destroy()
    end)
end

-- Key System Arayüzü
local gui = Instance.new("ScreenGui")
gui.Name = "MM2_KeySystem"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not gui.Parent then pcall(function() gui.Parent = pl:WaitForChild("PlayerGui") end) end

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 360, 0, 220)
frame.Position = UDim2.new(0.5, -180, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
rs.RenderStepped:Connect(function() stroke.Color = getRainbowColor(1) end)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
title.Text = "Hacked by"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 15
title.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.85, 0, 0, 40)
textBox.Position = UDim2.new(0.075, 0, 0.3, 0)
textBox.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "Key giriniz..."
textBox.Text = ""
textBox.TextSize = 14
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

local getKeyBtn = Instance.new("TextButton", frame)
getKeyBtn.Size = UDim2.new(0.4, 0, 0, 35)
getKeyBtn.Position = UDim2.new(0.075, 0, 0.62, 0)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
getKeyBtn.Text = "Get Key"
getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyBtn.TextSize = 14
getKeyBtn.Font = Enum.Font.SourceSansBold
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
loginBtn.Size = UDim2.new(0.4, 0, 0, 35)
loginBtn.Position = UDim2.new(0.525, 0, 0.62, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
loginBtn.Text = "Login"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.TextSize = 14
loginBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 6)

loginBtn.MouseButton1Click:Connect(function()
    if textBox.Text == CORRECT_KEY then
        gui:Destroy()
        sendNotification("Success", "Key verified successfully!", 3)
        
        -- ASIL HİLE MENÜSÜ BAŞLANGICI
        local mgui = Instance.new("ScreenGui")
        mgui.Name = "MM2_RainbowMaster"
        mgui.ResetOnSpawn = false
        pcall(function() mgui.Parent = game:GetService("CoreGui") end)
        if not mgui.Parent then pcall(function() mgui.Parent = pl:WaitForChild("PlayerGui") end) end

        local fpsLabel = Instance.new("TextLabel", mgui)
        fpsLabel.Size = UDim2.new(0, 120, 0, 30)
        fpsLabel.Position = UDim2.new(0, 15, 1, -45)
        fpsLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        fpsLabel.BackgroundTransparency = 0.3
        fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        fpsLabel.TextSize = 14
        fpsLabel.Font = Enum.Font.SourceSansBold
        fpsLabel.Text = "FPS: 0"
        fpsLabel.Visible = false
        Instance.new("UICorner", fpsLabel).CornerRadius = UDim.new(0, 6)
        local fpsStroke = Instance.new("UIStroke", fpsLabel)
        rs.RenderStepped:Connect(function() fpsStroke.Color = getRainbowColor(1) end)

        -- Toggle Menu Butonu
        local toggleButton = Instance.new("TextButton", mgui)
        toggleButton.Size = UDim2.new(0, 160, 0, 40)
        toggleButton.Position = UDim2.new(0, 40, 0, 40)
        toggleButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        toggleButton.Text = "Toggle Menu"
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.TextSize = 15
        toggleButton.Font = Enum.Font.SourceSansBold
        toggleButton.Active = true
        toggleButton.Draggable = true
        Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)
        local tbStroke = Instance.new("UIStroke", toggleButton)
        rs.RenderStepped:Connect(function() tbStroke.Color = getRainbowColor(1) end)

        -- Shoot Murderer Butonu (Hold & FOV Check)
        local shootButton = Instance.new("TextButton", mgui)
        shootButton.Size = UDim2.new(0, 160, 0, 40)
        shootButton.Position = UDim2.new(0, 40, 0, 95)
        shootButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        shootButton.Text = "Shoot Murderer (Hold)"
        shootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        shootButton.TextSize = 14
        shootButton.Font = Enum.Font.SourceSansBold
        shootButton.Active = true
        shootButton.Draggable = true
        Instance.new("UICorner", shootButton).CornerRadius = UDim.new(0, 8)
        local sbStroke = Instance.new("UIStroke", shootButton)
        rs.RenderStepped:Connect(function() sbStroke.Color = getRainbowColor(1) end)

        local shootingActive = false
        shootButton.MouseButton1Down:Connect(function() shootingActive = true end)
        shootButton.MouseButton1Up:Connect(function() shootingActive = false end)
        shootButton.MouseLeave:Connect(function() shootingActive = false end)

        coroutine.wrap(function()
            while task.wait(0.15) do
                if shootingActive then
                    pcall(function()
                        local c2 = pl.Character
                        local gun = c2 and (c2:FindFirstChild("Gun") or pl.Backpack:FindFirstChild("Gun"))
                        if not gun and c2 and c2:FindFirstChild("Humanoid") then
                            local bpGun = pl.Backpack:FindFirstChild("Gun")
                            if bpGun then bpGun.Parent = c2; gun = bpGun end
                        end
                        if gun then
                            local targetFound = false
                            for _, v in pairs(p:GetPlayers()) do
                                if v ~= pl and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                                    local hasKnife = v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife"))
                                    if hasKnife then
                                        targetFound = true
                                        local hrp = v.Character.HumanoidRootPart
                                        local _, onScreen = camera:WorldToViewportPoint(hrp.Position)
                                        if onScreen then
                                            local ev = gun:FindFirstChildWhichIsA("RemoteEvent")
                                            if ev then ev:FireServer(hrp.Position) end
                                        else
                                            sendNotification("Warning", "Murderer not in FOV!", 1.5)
                                        end
                                        break
                                    end
                                end
                            end
                            if not targetFound then
                                sendNotification("Info", "No Murderer found with knife!", 1.5)
                            end
                        end
                    end)
                end
            end
        end)()

        -- TP to Map Butonu
        local mapButton = Instance.new("TextButton", mgui)
        mapButton.Size = UDim2.new(0, 160, 0, 40)
        mapButton.Position = UDim2.new(0, 40, 0, 150)
        mapButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        mapButton.Text = "TP to Map"
        mapButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        mapButton.TextSize = 15
        mapButton.Font = Enum.Font.SourceSansBold
        mapButton.Active = true
        mapButton.Draggable = true
        Instance.new("UICorner", mapButton).CornerRadius = UDim.new(0, 8)
        local mbStroke = Instance.new("UIStroke", mapButton)
        rs.RenderStepped:Connect(function() mbStroke.Color = getRainbowColor(1) end)

        mapButton.MouseButton1Down:Connect(function()
            pcall(function()
                local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local targetPos = nil
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name == "CoinContainer" and obj:IsA("Model") and obj.PrimaryPart then
                            targetPos = obj.PrimaryPart.Position
                            break
                        elseif obj.Name == "Map" and obj:IsA("Model") then
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

        -- TP to Lobby Butonu
        local lobbyButton = Instance.new("TextButton", mgui)
        lobbyButton.Size = UDim2.new(0, 160, 0, 40)
        lobbyButton.Position = UDim2.new(0, 40, 0, 205)
        lobbyButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        lobbyButton.Text = "TP to Lobby"
        lobbyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        lobbyButton.TextSize = 15
        lobbyButton.Font = Enum.Font.SourceSansBold
        lobbyButton.Active = true
        lobbyButton.Draggable = true
        Instance.new("UICorner", lobbyButton).CornerRadius = UDim.new(0, 8)
        local lbStroke = Instance.new("UIStroke", lobbyButton)
        rs.RenderStepped:Connect(function() lbStroke.Color = getRainbowColor(1) end)

        lobbyButton.MouseButton1Down:Connect(function()
            pcall(function()
                local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp then 
                    hrp.CFrame = CFrame.new(0, 150, 0) 
                    sendNotification("Teleport", "Returned to Lobby!", 2)
                end
            end)
        end)

        -- Ana Pencere (Main Window Frame)
        local f = Instance.new("Frame", mgui)
        f.Size = UDim2.new(0, 380, 0, 480)
        f.Position = UDim2.new(0.5, -190, 0.5, -240)
        f.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
        f.Active = true
        f.Draggable = true
        f.ClipsDescendants = true
        f.Visible = false

        toggleButton.MouseButton1Click:Connect(function() 
            f.Visible = not f.Visible 
        end)

        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
        local fStroke = Instance.new("UIStroke", f)
        fStroke.Transparency = 0.2
        rs.RenderStepped:Connect(function() fStroke.Color = getRainbowColor(1) end)

        local t = Instance.new("TextLabel", f)
        t.Size = UDim2.new(1, 0, 0, 40)
        t.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        t.Text = "Hacked by"
        t.TextColor3 = Color3.fromRGB(255, 255, 255)
        t.TextSize = 14
        t.Font = Enum.Font.SourceSansBold
        Instance.new("UICorner", t).CornerRadius = UDim.new(0, 12)

        local al2 = Instance.new("Frame", f)
        al2.Size = UDim2.new(1, 0, 0, 2)
        al2.Position = UDim2.new(0, 0, 0, 40)
        rs.RenderStepped:Connect(function() al2.BackgroundColor3 = getRainbowColor(1) end)

        local sc = Instance.new("ScrollingFrame", f)
        sc.Size = UDim2.new(1, -20, 1, -50)
        sc.Position = UDim2.new(0, 10, 0, 46)
        sc.BackgroundTransparency = 1
        sc.BorderSizePixel = 0
        sc.ScrollBarThickness = 4
        rs.RenderStepped:Connect(function() sc.ScrollBarImageColor3 = getRainbowColor(1) end)
        sc.CanvasSize = UDim2.new(0, 0, 0, 0)

        local ll = Instance.new("UIListLayout", sc)
        ll.Padding = UDim.new(0, 8)
        ll.SortOrder = Enum.SortOrder.LayoutOrder
        ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            sc.CanvasSize = UDim2.new(0, 0, 0, ll.AbsoluteContentSize.Y + 20)
        end)

        local function Tog(parentContainer, titleText, defaultState, callbackFunc)
            local f2 = Instance.new("Frame", parentContainer)
            f2.Size = UDim2.new(1, 0, 0, 36)
            f2.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
            f2.BackgroundTransparency = 0.4
            Instance.new("UICorner", f2).CornerRadius = UDim.new(0, 6)

            local lb = Instance.new("TextLabel", f2)
            lb.Size = UDim2.new(1, -50, 1, 0)
            lb.Position = UDim2.new(0, 12, 0, 0)
            lb.BackgroundTransparency = 1
            lb.Text = titleText
            lb.TextColor3 = Color3.fromRGB(220, 220, 220)
            lb.TextSize = 13
            lb.Font = Enum.Font.SourceSans
            lb.TextXAlignment = Enum.TextXAlignment.Left

            local bg2 = Instance.new("Frame", f2)
            bg2.Size = UDim2.new(0, 36, 0, 20)
            bg2.Position = UDim2.new(1, -44, 0.5, -10)
            bg2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            bg2.BorderSizePixel = 0
            Instance.new("UICorner", bg2).CornerRadius = UDim.new(0, 10)

            local circ = Instance.new("Frame", bg2)
            circ.Size = UDim2.new(0, 16, 0, 16)
            circ.Position = UDim2.new(0, 2, 0.5, -8)
            circ.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            circ.BorderSizePixel = 0
            Instance.new("UICorner", circ).CornerRadius = UDim.new(0, 8)

            local st = defaultState or false
            local function upd()
                if st then
                    bg2.BackgroundColor3 = getRainbowColor(1)
                    circ.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    circ:TweenPosition(UDim2.new(0, 18, 0.5, -8), "Out", "Quad", 0.2, true)
                else
                    bg2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    circ.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                    circ:TweenPosition(UDim2.new(0, 2, 0.5, -8), "Out", "Quad", 0.2, true)
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
                if st then
                    sendNotification("Enabled", titleText .. " activated!", 2)
                else
                    sendNotification("Disabled", titleText .. " deactivated!", 2)
                end
                if callbackFunc then pcall(callbackFunc, st) end
            end)
        end

        local function Lbl(parentContainer, text)
            local l = Instance.new("TextLabel", parentContainer)
            l.Size = UDim2.new(1, 0, 0, 26)
            l.BackgroundTransparency = 1
            l.Text = text
            rs.RenderStepped:Connect(function() l.TextColor3 = getRainbowColor(1) end)
            l.TextSize = 12
            l.Font = Enum.Font.SourceSansBold
            l.TextXAlignment = Enum.TextXAlignment.Left
        end

        local O = {}
        Lbl(sc, "─ ESP & ROLES ─")
        Tog(sc, "Perfect Role ESP", false, function(s) O.ESP = s end)
        Tog(sc, "Sheriff Gun & Coin ESP", false, function(s) O.ExtraESP = s end)

        Lbl(sc, "─ GUN MECHANICS ─")
        Tog(sc, "Auto Grab Gun", false, function(s) O.AutoGrabGun = s end)
        Tog(sc, "Auto Sheriff Target", false, function(s) O.AutoSheriff = s end)

        Lbl(sc, "─ COMBAT & SURVIVAL ─")
        Tog(sc, "Kill All (Murderer)", false, function(s) O.KA = s end)
        Tog(sc, "Auto Avoid Knife", false, function(s) O.Avoid = s end)
        Tog(sc, "God Mode Shield", false, function(s) O.GodMode = s end)

        Lbl(sc, "─ TRADE SCAM PANEL ─")
        Tog(sc, "Freeze Trade", false, function(s) O.FreezeTrade = s end)
        Tog(sc, "Force Accept Trade", false, function(s) O.ForceAccept = s end)

        Lbl(sc, "─ MOVEMENT & VISUALS ─")
        Tog(sc, "Fly Mode", false, function(s) O.Fly = s end)
        Tog(sc, "Infinite Jump", false, function(s) O.InfJump = s end)
        Tog(sc, "FullBright", false, function(s) 
            lighting.Brightness = s and 2 or 1
            lighting.ClockTime = s and 14 or 0
            lighting.FogEnd = s and 100000 or 10000
        end)
        Tog(sc, "FPS Display", false, function(s) O.FPS = s; fpsLabel.Visible = s end)

        Lbl(sc, "─ AUTO FARM ─")
        Tog(sc, "Auto Farm (40 Coin Limit)", false, function(s) O.AF = s end)

        -- FPS Sayacı
        local lastTick, frameCount = tick(), 0
        rs.RenderStepped:Connect(function()
            frameCount = frameCount + 1
            if tick() - lastTick >= 1 then
                if O.FPS then fpsLabel.Text = "FPS: " .. tostring(frameCount) end
                frameCount, lastTick = 0, tick()
            end
        end)

        -- Infinite Jump Bağlantısı
        uis.JumpRequest:Connect(function()
            if O.InfJump then
                pcall(function()
                    pl.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end)
            end
        end)

        -- Role ESP Mantığı
        coroutine.wrap(function()
            while task.wait(0.5) do
                if O.ESP then
                    for _, v in pairs(p:GetPlayers()) do
                        if v ~= pl and v.Character then
                            local hl = v.Character:FindFirstChild("PerfectESP") or Instance.new("Highlight", v.Character)
                            hl.Name = "PerfectESP"
                            hl.FillTransparency = 0.5
                            hl.OutlineTransparency = 0.2
                            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            
                            local hasKnife = v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife"))
                            local hasGun = v.Character:FindFirstChild("Gun") or (v.Backpack and v.Backpack:FindFirstChild("Gun"))
                            
                            hl.FillColor = hasKnife and Color3.fromRGB(255, 0, 0) or (hasGun and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(0, 255, 0))
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        end
                    end
                else
                    for _, v in pairs(p:GetPlayers()) do
                        if v.Character and v.Character:FindFirstChild("PerfectESP") then v.Character.PerfectESP:Destroy() end
                    end
                end
            end
        end)()

        -- Sheriff Gun & Coin ESP Mantığı
        coroutine.wrap(function()
            while task.wait(1) do
                if O.ExtraESP then
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                            local hl = obj:FindFirstChild("GunESP") or Instance.new("Highlight", obj)
                            hl.Name = "GunESP"
                            hl.FillColor = Color3.fromRGB(255, 255, 0)
                            hl.FillTransparency = 0.3
                        elseif obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name:lower():find("gold")) then
                            local hl = obj:FindFirstChild("CoinESP") or Instance.new("Highlight", obj)
                            hl.Name = "CoinESP"
                            hl.FillColor = Color3.fromRGB(255, 215, 0)
                            hl.FillTransparency = 0.4
                        end
                    end
                else
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("Highlight") and (obj.Name == "GunESP" or obj.Name == "CoinESP") then
                            obj:Destroy()
                        end
                    end
                end
            end
        end)()

        -- Auto Grab Gun
        coroutine.wrap(function()
            while task.wait(0.2) do
                if O.AutoGrabGun then
                    local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj.Name == "GunDrop" and obj:IsA("BasePart") then hrp.CFrame = obj.CFrame; task.wait(0.1); break end
                        end
                    end
                end
            end
        end)()

        -- Auto Sheriff Target
        coroutine.wrap(function()
            while task.wait(0.3) do
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
            end
        end)()

        -- Kill All (Murderer)
        coroutine.wrap(function()
            while task.wait(0.3) do
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
            end
        end)()

        -- Auto Avoid Knife
        coroutine.wrap(function()
            while task.wait(0.1) do
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
            end
        end)()

        -- God Mode Shield
        coroutine.wrap(function()
            while task.wait(0.05) do
                if O.GodMode then
                    local hum = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
                end
            end
        end)()

        -- Trade Scam Simulation (Freeze & Force Accept)
        coroutine.wrap(function()
            while task.wait(0.5) do
                pcall(function()
                    local tradeGui = pl.PlayerGui:FindFirstChild("TradeGui") or pl.PlayerGui:FindFirstChild("Trade")
                    if tradeGui then
                        if O.FreezeTrade then
                            -- Trade verilerini dondurma simülasyonu
                        end
                        if O.ForceAccept then
                            local acceptBtn = tradeGui:FindFirstChild("AcceptButton", true) or tradeGui:FindFirstChild("ConfirmButton", true)
                            if acceptBtn and acceptBtn:IsA("TextButton") then
                                for _, conn in pairs(getconnections(acceptBtn.MouseButton1Click)) do
                                    conn:Fire()
                                end
                            end
                        end
                    end
                end)
            end
        end)()

        -- Fly Mode
        local flying, bg, bv = false, nil, nil
        rs.RenderStepped:Connect(function()
            local c2 = pl.Character
            local hrp = c2 and c2:FindFirstChild("HumanoidRootPart")
            local hum = c2 and c2:FindFirstChildOfClass("Humanoid")
            if O.Fly and hrp and hum then
                if not flying then
                    flying = true
                    bg = Instance.new("BodyGyro", hrp)
                    bg.P, bg.maxTorque = 9e4, Vector3.new(9e4, 9e4, 9e4)
                    bg.CFrame = hrp.CFrame
                    bv = Instance.new("BodyVelocity", hrp)
                    bv.velocity, bv.maxForce = Vector3.new(0, 0.1, 0), Vector3.new(9e4, 9e4, 9e4)
                    hum.PlatformStand = true
                end
                local moveDir = Vector3.new()
                if uis:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camera.CFrame.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camera.CFrame.RightVector end
                bv.velocity = moveDir * 50
                bg.CFrame = camera.CFrame
            else
                if flying then
                    flying = false
                    if bg then bg:Destroy() end
                    if bv then bv:Destroy() end
                    if hum then hum.PlatformStand = false end
                end
            end
        end)

        -- Auto Farm
        coroutine.wrap(function()
            local cc = 0
            while task.wait(0.05) do
                if O.AF then
                    local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                    local hum = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
                    if hrp and hum and hum.Health > 0 then
                        for _, v in pairs((workspace:FindFirstChild("CoinContainer") or workspace):GetDescendants()) do
                            if not O.AF then break end
                            if v:IsA("BasePart") and (v.Name:lower():find("coin") or v.Name:lower():find("gold") or v.Name:lower():find("gem")) and v.Transparency < 1 then
                                hrp.CFrame = v.CFrame + Vector3.new(0, 0.5, 0)
                                cc = cc + 1
                                task.wait(0.03)
                                if cc >= 40 then 
                                    cc = 0
                                    sendNotification("AutoFarm", "Hit 40 coin limit, resetting safely!", 2)
                                    hum.Health = 0
                                    task.wait(3)
                                    break 
                                end
                            end
                        end
                    end
                else
                    cc = 0
                end
            end
        end)()

        sendNotification("Loaded", "Hacked by is ready!", 3)
    else
        textBox.Text = ""
        textBox.PlaceholderText = "YANLIŞ ANAHTAR!"
        task.wait(1.5)
        textBox.PlaceholderText = "Key giriniz..."
    end
end)
