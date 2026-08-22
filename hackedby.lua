-- ==========================================
-- HACKED BY + ULTIMATE MM2 SCRIPT (WITH ITEM SPAWNER)
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

local function getThemeColor(speed)
    if rainbowModeActive then
        local hue = (tick() * (speed or 1)) % 1
        return Color3.fromHSV(hue, 1, 1)
    else
        return customThemeColor
    end
end

-- Bildirim Sistemi (Sağ Altta Sabit)
local notifGui = Instance.new("ScreenGui")
notifGui.Name = "MM2_Notifications"
notifGui.ResetOnSpawn = false
pcall(function() notifGui.Parent = game:GetService("CoreGui") end)
if not notifGui.Parent then pcall(function() notifGui.Parent = pl:WaitForChild("PlayerGui") end) end

local notifHolder = Instance.new("Frame", notifGui)
notifHolder.Size = UDim2.new(0, 260, 0, 400)
notifHolder.Position = UDim2.new(1, -275, 1, -415)
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
        
        local conn
        conn = rs.RenderStepped:Connect(function()
            stroke.Color = getThemeColor(0.8)
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
rs.RenderStepped:Connect(function() stroke.Color = getThemeColor(1) end)

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
        
        -- ASIL HİLE MENÜSÜ
        local mgui = Instance.new("ScreenGui")
        mgui.Name = "MM2_MasterMenu"
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
        rs.RenderStepped:Connect(function() fpsStroke.Color = getThemeColor(1) end)

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
        rs.RenderStepped:Connect(function() tbStroke.Color = getThemeColor(1) end)

        -- Shoot Murderer Butonu
        local shootButton = Instance.new("TextButton", mgui)
        shootButton.Size = UDim2.new(0, 160, 0, 40)
        shootButton.Position = UDim2.new(0, 40, 0, 95)
        shootButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        shootButton.Text = "Shoot Murderer"
        shootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        shootButton.TextSize = 14
        shootButton.Font = Enum.Font.SourceSansBold
        shootButton.Active = true
        shootButton.Draggable = true
        Instance.new("UICorner", shootButton).CornerRadius = UDim.new(0, 8)
        local sbStroke = Instance.new("UIStroke", shootButton)
        rs.RenderStepped:Connect(function() sbStroke.Color = getThemeColor(1) end)

        shootButton.MouseButton1Click:Connect(function()
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
                                local ev = gun:FindFirstChildWhichIsA("RemoteEvent")
                                if ev then 
                                    ev:FireServer(hrp.Position) 
                                else
                                    pcall(function()
                                        for _, remote in pairs(gun:GetDescendants()) do
                                            if remote:IsA("RemoteEvent") then
                                                remote:FireServer(hrp.Position)
                                            end
                                        end
                                    end)
                                end
                                sendNotification("Success", "Shot Murderer accurately!", 2)
                                break
                            end
                        end
                    end
                    if not targetFound then sendNotification("Info", "No Murderer found with knife!", 1.5) end
                else
                    sendNotification("Error", "You don't have a gun!", 1.5)
                end
            end)
        end)

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
        rs.RenderStepped:Connect(function() mbStroke.Color = getThemeColor(1) end)

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
        rs.RenderStepped:Connect(function() lbStroke.Color = getThemeColor(1) end)

        lobbyButton.MouseButton1Click:Connect(function()
            pcall(function()
                local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp then 
                    hrp.CFrame = CFrame.new(0, 100, 0) 
                    sendNotification("Teleport", "Returned to Lobby!", 2)
                end
            end)
        end)

        -- Ana Pencere ve Kategori Sekme Sistemi
        local f = Instance.new("Frame", mgui)
        f.Size = UDim2.new(0, 400, 0, 480)
        f.Position = UDim2.new(0.5, -200, 0.5, -240)
        f.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
        f.Active = true
        f.Draggable = true
        f.ClipsDescendants = true
        f.Visible = false

        toggleButton.MouseButton1Click:Connect(function() f.Visible = not f.Visible end)
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
        local fStroke = Instance.new("UIStroke", f)
        fStroke.Transparency = 0.2
        rs.RenderStepped:Connect(function() fStroke.Color = getThemeColor(1) end)

        local t = Instance.new("TextLabel", f)
        t.Size = UDim2.new(1, 0, 0, 40)
        t.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        t.Text = "Hacked by - Panel"
        t.TextColor3 = Color3.fromRGB(255, 255, 255)
        t.TextSize = 14
        t.Font = Enum.Font.SourceSansBold
        Instance.new("UICorner", t).CornerRadius = UDim.new(0, 12)

        -- Kategori Butonları Alanı
        local catHolder = Instance.new("ScrollingFrame", f)
        catHolder.Size = UDim2.new(1, -20, 0, 32)
        catHolder.Position = UDim2.new(0, 10, 0, 46)
        catHolder.BackgroundTransparency = 1
        catHolder.CanvasSize = UDim2.new(0, 520, 0, 0)
        catHolder.ScrollBarThickness = 0

        local catLayout = Instance.new("UIListLayout", catHolder)
        catLayout.FillDirection = Enum.FillDirection.Horizontal
        catLayout.SortOrder = Enum.SortOrder.LayoutOrder
        catLayout.Padding = UDim.new(0, 6)

        -- İçerik Konteynerleri
        local pagesHolder = Instance.new("Folder", f)

        local function createPage()
            local sc = Instance.new("ScrollingFrame", f)
            sc.Size = UDim2.new(1, -20, 1, -90)
            sc.Position = UDim2.new(0, 10, 0, 86)
            sc.BackgroundTransparency = 1
            sc.BorderSizePixel = 0
            sc.ScrollBarThickness = 4
            sc.Visible = false
            rs.RenderStepped:Connect(function() sc.ScrollBarImageColor3 = getThemeColor(1) end)
            local ll = Instance.new("UIListLayout", sc)
            ll.Padding = UDim.new(0, 8)
            ll.SortOrder = Enum.SortOrder.LayoutOrder
            ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                sc.CanvasSize = UDim2.new(0, 0, 0, ll.AbsoluteContentSize.Y + 20)
            end)
            return sc
        end

        local categories = {"Theme", "ESP & Roles", "Combat", "Trade & Misc", "Auto Farm", "Item Spawner"}
        local pageFrames = {}

        for i, catName in ipairs(categories) do
            local page = createPage()
            table.insert(pageFrames, page)

            local cBtn = Instance.new("TextButton", catHolder)
            cBtn.Size = UDim2.new(0, 80, 0, 30)
            cBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
            cBtn.Text = catName
            cBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            cBtn.TextSize = 11
            cBtn.Font = Enum.Font.SourceSansBold
            Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 6)

            cBtn.MouseButton1Click:Connect(function()
                for _, pFrame in ipairs(pageFrames) do pFrame.Visible = false end
                page.Visible = true
            end)
            if i == 1 then page.Visible = true end
        end

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
                    bg2.BackgroundColor3 = getThemeColor(1)
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
                if callbackFunc then pcall(callbackFunc, st) end
            end)
        end

        local O = {}
        
        -- Sayfa 1: Theme
        Tog(pageFrames[1], "Rainbow Mode", true, function(s) rainbowModeActive = s end)
        local colorContainer = Instance.new("Frame", pageFrames[1])
        colorContainer.Size = UDim2.new(1, 0, 0, 36)
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

        -- Sayfa 2: ESP & Roles
        Tog(pageFrames[2], "Perfect Role ESP", false, function(s) O.ESP = s end)
        Tog(pageFrames[2], "Sheriff Gun & Coin ESP", false, function(s) O.ExtraESP = s end)

        -- Sayfa 3: Combat
        Tog(pageFrames[3], "Auto Grab Gun", false, function(s) O.AutoGrabGun = s end)
        Tog(pageFrames[3], "Auto Sheriff Target", false, function(s) O.AutoSheriff = s end)
        Tog(pageFrames[3], "Kill All (Murderer)", false, function(s) O.KA = s end)
        Tog(pageFrames[3], "Auto Avoid Knife", false, function(s) O.Avoid = s end)
        Tog(pageFrames[3], "God Mode Shield", false, function(s) O.GodMode = s end)

        -- Sayfa 4: Trade & Misc
        Tog(pageFrames[4], "Freeze Trade", false, function(s) O.FreezeTrade = s end)
        Tog(pageFrames[4], "Force Accept Trade", false, function(s) O.ForceAccept = s end)
        Tog(pageFrames[4], "Infinite Jump", false, function(s) O.InfJump = s end)
        Tog(pageFrames[4], "FullBright", false, function(s) 
            lighting.Brightness = s and 2 or 1
            lighting.ClockTime = s and 14 or 0
            lighting.FogEnd = s and 100000 or 10000
        end)
        Tog(pageFrames[4], "FPS Display", false, function(s) O.FPS = s; fpsLabel.Visible = s end)

        -- Sayfa 5: Auto Farm
        Tog(pageFrames[5], "Auto Farm (Flying Coin Teleport)", false, function(s) O.AF = s end)
        
        -- Auto Farm Hız Slider Yapısı
        local speedFrame = Instance.new("Frame", pageFrames[5])
        speedFrame.Size = UDim2.new(1, 0, 0, 50)
        speedFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        speedFrame.BackgroundTransparency = 0.4
        Instance.new("UICorner", speedFrame).CornerRadius = UDim.new(0, 6)

        local speedLbl = Instance.new("TextLabel", speedFrame)
        speedLbl.Size = UDim2.new(1, -20, 0, 20)
        speedLbl.Position = UDim2.new(0, 12, 0, 4)
        speedLbl.BackgroundTransparency = 1
        speedLbl.Text = "Autofarm speed (0-30 safe): 30"
        speedLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
        speedLbl.TextSize = 12
        speedLbl.Font = Enum.Font.SourceSans
        speedLbl.TextXAlignment = Enum.TextXAlignment.Left

        local sliderBg = Instance.new("Frame", speedFrame)
        sliderBg.Size = UDim2.new(1, -24, 0, 8)
        sliderBg.Position = UDim2.new(0, 12, 0, 32)
        sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(0, 4)

        local sliderFill = Instance.new("Frame", sliderBg)
        sliderFill.Size = UDim2.new(30/200, 0, 1, 0)
        sliderFill.BackgroundColor3 = customThemeColor
        Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(0, 4)
        rs.RenderStepped:Connect(function() sliderFill.BackgroundColor3 = getThemeColor(1) end)

        local autoFarmSpeed = 30
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
                autoFarmSpeed = math.floor(pos * 200)
                if autoFarmSpeed < 1 then autoFarmSpeed = 1 end
                speedLbl.Text = "Autofarm speed (0-30 safe): " .. autoFarmSpeed
            end
        end)

        -- Sayfa 6: Item Spawner (Kasa Açılım Animasyonlu)
        local spawnerContainer = pageFrames[6]
        
        local searchBox = Instance.new("TextBox", spawnerContainer)
        searchBox.Size = UDim2.new(1, 0, 0, 38)
        searchBox.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        searchBox.PlaceholderText = "İtem Ara (örn: Harvester, Gingerscope)..."
        searchBox.Text = ""
        searchBox.TextSize = 13
        Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 6)

        local selectedItemDisplay = Instance.new("TextButton", spawnerContainer)
        selectedItemDisplay.Size = UDim2.new(1, 0, 0, 38)
        selectedItemDisplay.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
        selectedItemDisplay.TextColor3 = Color3.fromRGB(150, 200, 255)
        selectedItemDisplay.Text = "Seçilen: Hiçbiri"
        selectedItemDisplay.TextSize = 13
        selectedItemDisplay.Font = Enum.Font.SourceSansBold
        Instance.new("UICorner", selectedItemDisplay).CornerRadius = UDim.new(0, 6)

        local itemDropdown = Instance.new("ScrollingFrame", spawnerContainer)
        itemDropdown.Size = UDim2.new(1, 0, 0, 120)
        itemDropdown.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
        itemDropdown.Visible = false
        itemDropdown.ScrollBarThickness = 4
        Instance.new("UICorner", itemDropdown).CornerRadius = UDim.new(0, 6)
        local dropLayout = Instance.new("UIListLayout", itemDropdown)
        dropLayout.SortOrder = Enum.SortOrder.LayoutOrder

        local itemsList = {"Harvester", "Gingerscope", "TravelerGunChroma", "BaubleChroma", "Corrupt", "Icebreaker", "Candy", "Sugar", "Blossom", "Sakura", "Bat", "Elderwood Scythe"}
        local chosenItemName = "Harvester"

        local function updateDropdown(filter)
            for _, child in pairs(itemDropdown:GetChildren()) do
                if child:IsA("TextButton") then child:Destroy() end
            end
            local count = 0
            for _, itemName in ipairs(itemsList) do
                if filter == "" or itemName:lower():find(filter:lower()) then
                    count = count + 1
                    local btn = Instance.new("TextButton", itemDropdown)
                    btn.Size = UDim2.new(1, 0, 0, 30)
                    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    btn.Text = itemName
                    btn.TextSize = 12
                    btn.Font = Enum.Font.SourceSans
                    btn.MouseButton1Click:Connect(function()
                        chosenItemName = itemName
                        selectedItemDisplay.Text = "Seçilen: " .. itemName
                        itemDropdown.Visible = false
                    end)
                end
            end
            itemDropdown.CanvasSize = UDim2.new(0, 0, 0, count * 30)
        end

        searchBox.Focused:Connect(function()
            itemDropdown.Visible = true
            updateDropdown(searchBox.Text)
        end)

        searchBox:GetPropertyChangedSignal("Text"):Connect(function()
            itemDropdown.Visible = true
            updateDropdown(searchBox.Text)
        end)

        -- Spawn Butonu
        local spawnBtn = Instance.new("TextButton", spawnerContainer)
        spawnBtn.Size = UDim2.new(1, 0, 0, 40)
        spawnBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        spawnBtn.Text = "Spawn Item (Kasa Açılımı)"
        spawnBtn.TextSize = 14
        spawnBtn.Font = Enum.Font.SourceSansBold
        Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0, 6)

        -- Kasa Açılım Animasyon Arayüzü (Videodaki Gibi)
        local unboxGui = Instance.new("ScreenGui", mgui)
        unboxGui.Name = "UnboxAnimationGui"
        unboxGui.Enabled = false
        unboxGui.ResetOnSpawn = false

        local unboxBg = Instance.new("Frame", unboxGui)
        unboxBg.Size = UDim2.new(1, 0, 1, 0)
        unboxBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        unboxBg.BackgroundTransparency = 0.4

        local unboxMain = Instance.new("Frame", unboxBg)
        unboxMain.Size = UDim2.new(0, 460, 0, 240)
        unboxMain.Position = UDim2.new(0.5, -230, 0.5, -120)
        unboxMain.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        Instance.new("UICorner", unboxMain).CornerRadius = UDim.new(0, 12)
        local unboxStroke = Instance.new("UIStroke", unboxMain)
        rs.RenderStepped:Connect(function() unboxStroke.Color = getThemeColor(1) end)

        local unboxTitle = Instance.new("TextLabel", unboxMain)
        unboxTitle.Size = UDim2.new(1, 0, 0, 40)
        unboxTitle.BackgroundTransparency = 1
        unboxTitle.Text = "Unboxing..."
        unboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        unboxTitle.TextSize = 16
        unboxTitle.Font = Enum.Font.SourceSansBold

        -- Kaydırma kutuları (Kasa açılış şeridi)
        local rollStrip = Instance.new("Frame", unboxMain)
        rollStrip.Size = UDim2.new(0.9, 0, 0, 100)
        rollStrip.Position = UDim2.new(0.05, 0, 0.25, 0)
        rollStrip.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
        rollStrip.ClipsDescendants = true
        Instance.new("UICorner", rollStrip).CornerRadius = UDim.new(0, 8)

        local rollHolder = Instance.new("Frame", rollStrip)
        rollHolder.Size = UDim2.new(0, 1000, 1, 0)
        rollHolder.Position = UDim2.new(0, 0, 0, 0)
        rollHolder.BackgroundTransparency = 1

        local resultLabel = Instance.new("TextLabel", unboxMain)
        resultLabel.Size = UDim2.new(1, 0, 0, 40)
        resultLabel.Position = UDim2.new(0, 0, 0.78, 0)
        resultLabel.BackgroundTransparency = 1
        resultLabel.Text = ""
        resultLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
        resultLabel.TextSize = 15
        resultLabel.Font = Enum.Font.SourceSansBold

        spawnBtn.MouseButton1Click:Connect(function()
            unboxGui.Enabled = true
            resultLabel.Text = ""
            unboxTitle.Text = "Spawning " .. chosenItemName .. "..."
            
            for _, child in pairs(rollHolder:GetChildren()) do child:Destroy() end
            
            -- Rastgele simüle edilmiş öğe kutucukları oluştur
            local fakeItems = {"Default Knife", "Blade", "Clown", "Melon", chosenItemName, "Fade", "Oily", "Default Gun"}
            for i = 1, 15 do
                local itemBox = Instance.new("Frame", rollHolder)
                itemBox.Size = UDim2.new(0, 90, 0, 90)
                itemBox.Position = UDim2.new(0, (i-1)*100 + 5, 0, 5)
                itemBox.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
                Instance.new("UICorner", itemBox).CornerRadius = UDim.new(0, 6)
                
                local lbl = Instance.new("TextLabel", itemBox)
                lbl.Size = UDim2.new(1, 0, 1, 0)
                lbl.BackgroundTransparency = 1
                lbl.Text = fakeItems[math.random(1, #fakeItems)]
                if i == 11 then lbl.Text = chosenItemName end -- 11. kutu kazanılan item olsun
                lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                lbl.TextSize = 11
                lbl.Font = Enum.Font.SourceSansBold
                lbl.TextWrapped = true
            end

            rollHolder.Position = UDim2.new(0, 0, 0, 0)
            -- Kayma animasyonu
            rollHolder:TweenPosition(UDim2.new(0, -1000 + 350, 0, 0), "Out", "Quart", 2.5, true, function()
                resultLabel.Text = "IT WORKED! 1x Godly Obtained: " .. chosenItemName
                unboxTitle.Text = "Successfully Claimed!"
                sendNotification("Success", chosenItemName .. " spawned and added to inventory!", 3)
                task.wait(1.5)
                unboxGui.Enabled = false
            end)
        end)

        -- Kararlı ESP Mantığı
        coroutine.wrap(function()
            while task.wait(1) do
                if O.ESP then
                    for _, v in pairs(p:GetPlayers()) do
                        if v ~= pl and v.Character then
                            local hl = v.Character:FindFirstChild("PerfectESP")
                            if not hl then
                                hl = Instance.new("Highlight", v.Character)
                                hl.Name = "PerfectESP"
                                hl.FillTransparency = 0.5
                                hl.OutlineTransparency = 0.2
                                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            end
                            local hasKnife = v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife"))
                            local hasGun = v.Character:FindFirstChild("Gun") or (v.Backpack and v.Backpack:FindFirstChild("Gun"))
                            hl.FillColor = hasKnife and Color3.fromRGB(255, 0, 0) or (hasGun and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(0, 255, 0))
                        end
                    end
                else
                    for _, v in pairs(p:GetPlayers()) do
                        if v.Character and v.Character:FindFirstChild("PerfectESP") then v.Character.PerfectESP:Destroy() end
                    end
                end
            end
        end)()

        -- Ekstra ESP (Gun & Coin)
        coroutine.wrap(function()
            while task.wait(1.5) do
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

        -- Kill All
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

        -- God Mode
        coroutine.wrap(function()
            while task.wait(0.05) do
                if O.GodMode then
                    local hum = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
                end
            end
        end)()

        -- Infinite Jump
        uis.JumpRequest:Connect(function()
            if O.InfJump then
                pcall(function() pl.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
            end
        end)()

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
                                task.wait(1 / autoFarmSpeed)
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
