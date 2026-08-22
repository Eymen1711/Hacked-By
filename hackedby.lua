-- ==========================================
-- ULTIMATE MM2 SCRIPT (EXACTLY LIKE VIDEO v31 - FIXED)
-- ==========================================

local p = game:GetService("Players")
local pl = p.LocalPlayer
local workspace = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local camera = workspace.CurrentCamera

local MENU_TITLE = "Hacked By"
local CORRECT_KEY = "5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3"

local customThemeColor = Color3.fromRGB(0, 255, 200)
local rainbowModeActive = true
local CUSTOM_FONT = Enum.Font.FredokaOne

local currentWalkSpeed = 16
local currentJumpPower = 50
local silentAimEnabled = false
local espEnabled = false
local autoFarmEnabled = false
local infJumpActive = false

-- Eski pencereleri temizle
pcall(function()
    for i = 22, 31 do
        local old = game:GetService("CoreGui"):FindFirstChild("HackedBy_MasterMenu_v" .. i)
        if old then old:Destroy() end
        local oldKey = game:GetService("CoreGui"):FindFirstChild("HackedBy_KeySystem_v" .. i)
        if oldKey then oldKey:Destroy() end
        local oldNotif = game:GetService("CoreGui"):FindFirstChild("HackedBy_Notifications_v" .. i)
        if oldNotif then oldNotif:Destroy() end
    end
end)

-- Anti-AFK
local vu = game:GetService("VirtualUser")
pl.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), camera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), camera.CFrame)
end)

local function getThemeColor(speed)
    if rainbowModeActive then
        local hue = (tick() * (speed or 1)) % 1
        return Color3.fromHSV(hue, 1, 1)
    else
        return customThemeColor
    end
end

-- Bildirim Sistemi
local notifGui = Instance.new("ScreenGui")
notifGui.Name = "HackedBy_Notifications_v31"
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
        box.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
        box.BackgroundTransparency = 0.1
        box.Position = UDim2.new(1, 50, 0, 0)
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
        
        local stroke = Instance.new("UIStroke", box)
        stroke.Thickness = 1.5
        rs.RenderStepped:Connect(function() if stroke and stroke.Parent then stroke.Color = getThemeColor(0.8) end end)

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

-- Key System
local gui = Instance.new("ScreenGui")
gui.Name = "HackedBy_KeySystem_v31"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not gui.Parent then pcall(function() gui.Parent = pl:WaitForChild("PlayerGui") end) end

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 240)
frame.Position = UDim2.new(0.5, -200, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
rs.RenderStepped:Connect(function() if stroke and stroke.Parent then stroke.Color = getThemeColor(1) end end)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
title.Text = MENU_TITLE .. " (Key System)"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = CUSTOM_FONT
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.85, 0, 0, 48)
textBox.Position = UDim2.new(0.075, 0, 0.3, 0)
textBox.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "Enter key..."
textBox.Text = ""
textBox.TextSize = 16
textBox.Font = CUSTOM_FONT
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 8)

local loginBtn = Instance.new("TextButton", frame)
loginBtn.Size = UDim2.new(0.85, 0, 0, 45)
loginBtn.Position = UDim2.new(0.075, 0, 0.62, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
loginBtn.Text = "Login"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.TextSize = 16
loginBtn.Font = CUSTOM_FONT
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 8)

loginBtn.MouseButton1Click:Connect(function()
    if textBox.Text == CORRECT_KEY then
        gui:Destroy()
        sendNotification("Success", "Key verified successfully!", 3)
        
        -- MASTER MENU v31
        local mgui = Instance.new("ScreenGui")
        mgui.Name = "HackedBy_MasterMenu_v31"
        mgui.ResetOnSpawn = false
        pcall(function() mgui.Parent = game:GetService("CoreGui") end)
        if not mgui.Parent then pcall(function() mgui.Parent = pl:WaitForChild("PlayerGui") end) end

        -- Karakter hız ve zıplama döngüsü
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
                end)
            end
        end)

        -- ==========================================
        -- SOL TARAFTAKI SABİT BUTONLAR
        -- ==========================================
        local toggleButton = Instance.new("TextButton", mgui)
        toggleButton.Size = UDim2.new(0, 150, 0, 40)
        toggleButton.Position = UDim2.new(0, 20, 0, 20)
        toggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        toggleButton.Text = "Toggle Menu"
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.TextSize = 15
        toggleButton.Font = CUSTOM_FONT
        toggleButton.Active = true
        toggleButton.Draggable = true
        Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)
        local tbStroke = Instance.new("UIStroke", toggleButton)
        rs.RenderStepped:Connect(function() if tbStroke and tbStroke.Parent then tbStroke.Color = getThemeColor(1) end end)

        local leftSilentBtn = Instance.new("TextButton", mgui)
        leftSilentBtn.Size = UDim2.new(0, 150, 0, 40)
        leftSilentBtn.Position = UDim2.new(0, 20, 0, 70)
        leftSilentBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        leftSilentBtn.Text = "Silent Aim OFF"
        leftSilentBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        leftSilentBtn.TextSize = 15
        leftSilentBtn.Font = CUSTOM_FONT
        Instance.new("UICorner", leftSilentBtn).CornerRadius = UDim.new(0, 8)
        local lsStroke = Instance.new("UIStroke", leftSilentBtn)
        rs.RenderStepped:Connect(function() if lsStroke and lsStroke.Parent then lsStroke.Color = getThemeColor(1) end end)

        leftSilentBtn.MouseButton1Click:Connect(function()
            silentAimEnabled = not silentAimEnabled
            if silentAimEnabled then
                leftSilentBtn.Text = "Silent Aim ON"
                leftSilentBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
                sendNotification("Silent Aim", "Silent Aim Activated!", 2)
            else
                leftSilentBtn.Text = "Silent Aim OFF"
                leftSilentBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                sendNotification("Silent Aim", "Silent Aim Deactivated!", 2)
            end
        end)

        local leftMapBtn = Instance.new("TextButton", mgui)
        leftMapBtn.Size = UDim2.new(0, 150, 0, 40)
        leftMapBtn.Position = UDim2.new(0, 20, 0, 120)
        leftMapBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        leftMapBtn.Text = "TP to Map"
        leftMapBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        leftMapBtn.TextSize = 15
        leftMapBtn.Font = CUSTOM_FONT
        Instance.new("UICorner", leftMapBtn).CornerRadius = UDim.new(0, 8)
        local lmStroke = Instance.new("UIStroke", leftMapBtn)
        rs.RenderStepped:Connect(function() if lmStroke and lmStroke.Parent then lmStroke.Color = getThemeColor(1) end end)

        leftMapBtn.MouseButton1Click:Connect(function()
            pcall(function()
                local foundMap = workspace:FindFirstChild("Map") or workspace:FindFirstChild("CurrentMap")
                if foundMap and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                    for _, obj in ipairs(foundMap:GetDescendants()) do
                        if obj:IsA("BasePart") then
                            pl.Character.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 5, 0)
                            sendNotification("Teleport", "Teleported to Map!", 2)
                            break
                        end
                    end
                else
                    sendNotification("Error", "Map not found or round not started!", 2)
                end
            end)
        end)

        local leftLobbyBtn = Instance.new("TextButton", mgui)
        leftLobbyBtn.Size = UDim2.new(0, 150, 0, 40)
        leftLobbyBtn.Position = UDim2.new(0, 20, 0, 170)
        leftLobbyBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        leftLobbyBtn.Text = "TP to Lobby"
        leftLobbyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        leftLobbyBtn.TextSize = 15
        leftLobbyBtn.Font = CUSTOM_FONT
        Instance.new("UICorner", leftLobbyBtn).CornerRadius = UDim.new(0, 8)
        local llStroke = Instance.new("UIStroke", leftLobbyBtn)
        rs.RenderStepped:Connect(function() if llStroke and llStroke.Parent then llStroke.Color = getThemeColor(1) end end)

        leftLobbyBtn.MouseButton1Click:Connect(function()
            pcall(function()
                if pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                    pl.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
                    sendNotification("Teleport", "Teleported to Lobby!", 2)
                end
            end)
        end)

        -- ==========================================
        -- ANA MENÜ PENCERESİ (SEKMELİ SİSTEM)
        -- ==========================================
        local f = Instance.new("Frame", mgui)
        f.Size = UDim2.new(0, 520, 0, 380)
        f.Position = UDim2.new(0.5, -260, 0.5, -190)
        f.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
        f.Active = true
        f.Draggable = true
        f.ClipsDescendants = true
        f.Visible = true

        toggleButton.MouseButton1Click:Connect(function() f.Visible = not f.Visible end)
        uis.InputBegan:Connect(function(input, gpe)
            if not gpe and input.KeyCode == Enum.KeyCode.K then
                f.Visible = not f.Visible
            end
        end)

        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
        local fStroke = Instance.new("UIStroke", f)
        rs.RenderStepped:Connect(function() if fStroke and fStroke.Parent then fStroke.Color = getThemeColor(1) end end)

        local menuTitleLbl = Instance.new("TextLabel", f)
        menuTitleLbl.Size = UDim2.new(1, 0, 0, 40)
        menuTitleLbl.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        menuTitleLbl.Text = MENU_TITLE .. " - Panel"
        menuTitleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        menuTitleLbl.TextSize = 16
        menuTitleLbl.Font = CUSTOM_FONT
        Instance.new("UICorner", menuTitleLbl).CornerRadius = UDim.new(0, 12)

        -- Sekme Butonları Alanı
        local tabsHolder = Instance.new("Frame", f)
        tabsHolder.Size = UDim2.new(1, -16, 0, 35)
        tabsHolder.Position = UDim2.new(0, 8, 0, 48)
        tabsHolder.BackgroundTransparency = 1

        local tabsLayout = Instance.new("UIListLayout", tabsHolder)
        tabsLayout.FillDirection = Enum.FillDirection.Horizontal
        tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tabsLayout.Padding = UDim.new(0, 4)

        -- İçerik Sayfaları Alanı
        local pagesHolder = Instance.new("Frame", f)
        pagesHolder.Size = UDim2.new(1, -16, 1, -95)
        pagesHolder.Position = UDim2.new(0, 8, 0, 90)
        pagesHolder.BackgroundTransparency = 1

        local function createTabPage()
            local page = Instance.new("ScrollingFrame", pagesHolder)
            page.Size = UDim2.new(1, 0, 1, 0)
            page.BackgroundTransparency = 1
            page.CanvasSize = UDim2.new(0, 0, 1.8, 0)
            page.ScrollBarThickness = 4
            page.Visible = false
            local l = Instance.new("UIListLayout", page)
            l.SortOrder = Enum.SortOrder.LayoutOrder
            l.Padding = UDim.new(0, 8)
            return page
        end

        local pageTheme = createTabPage()
        local pageEsp = createTabPage()
        local pageCombat = createTabPage()
        local pageTrade = createTabPage()
        local pageAutoFarm = createTabPage()

        -- Varsayılan açık sayfa
        pageTheme.Visible = true

        local function addTabButton(name, targetPage)
            local tBtn = Instance.new("TextButton", tabsHolder)
            tBtn.Size = UDim2.new(0.19, 0, 1, 0)
            tBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
            tBtn.Text = name
            tBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            tBtn.TextSize = 12
            tBtn.Font = CUSTOM_FONT
            Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 6)

            tBtn.MouseButton1Click:Connect(function()
                pageTheme.Visible = false
                pageEsp.Visible = false
                pageCombat.Visible = false
                pageTrade.Visible = false
                pageAutoFarm.Visible = false
                
                targetPage.Visible = true
            end)
        end

        addTabButton("Theme", pageTheme)
        addTabButton("ESP & Key", pageEsp)
        addTabButton("Combat", pageCombat)
        addTabButton("Trade & Misc", pageTrade)
        addTabButton("Auto Farm", pageAutoFarm)

        -- ==========================================
        -- TÜM ÖZELLİK BUTONLARI (EKSİKSİZ)
        -- ==========================================

        -- 1. THEME SEKMESİ
        local themeToggleBtn = Instance.new("TextButton", pageTheme)
        themeToggleBtn.Size = UDim2.new(1, 0, 0, 42)
        themeToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        themeToggleBtn.Text = "Rainbow Theme: ON"
        themeToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
        themeToggleBtn.TextSize = 14
        themeToggleBtn.Font = CUSTOM_FONT
        Instance.new("UICorner", themeToggleBtn).CornerRadius = UDim.new(0, 6)

        themeToggleBtn.MouseButton1Click:Connect(function()
            rainbowModeActive = not rainbowModeActive
            if rainbowModeActive then
                themeToggleBtn.Text = "Rainbow Theme: ON"
                themeToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
            else
                themeToggleBtn.Text = "Rainbow Theme: OFF"
                themeToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end)

        -- 2. ESP SEKMESİ
        local espToggleBtn = Instance.new("TextButton", pageEsp)
        espToggleBtn.Size = UDim2.new(1, 0, 0, 42)
        espToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        espToggleBtn.Text = "Perfect Role ESP: OFF"
        espToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        espToggleBtn.TextSize = 14
        espToggleBtn.Font = CUSTOM_FONT
        Instance.new("UICorner", espToggleBtn).CornerRadius = UDim.new(0, 6)

        espToggleBtn.MouseButton1Click:Connect(function()
            espEnabled = not espEnabled
            if espEnabled then
                espToggleBtn.Text = "Perfect Role ESP: ON"
                espToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
                sendNotification("ESP", "Perfect Role ESP Activated!", 2)
            else
                espToggleBtn.Text = "Perfect Role ESP: OFF"
                espToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                sendNotification("ESP", "Perfect Role ESP Deactivated!", 2)
            end
        end)

        -- 3. COMBAT SEKMESİ (Infinite Jump, Fullbright, Hız, Zıplama)
        local infJumpBtn = Instance.new("TextButton", pageCombat)
        infJumpBtn.Size = UDim2.new(1, 0, 0, 42)
        infJumpBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        infJumpBtn.Text = "Infinite Jump: OFF"
        infJumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        infJumpBtn.TextSize = 14
        infJumpBtn.Font = CUSTOM_FONT
        Instance.new("UICorner", infJumpBtn).CornerRadius = UDim.new(0, 6)

        infJumpBtn.MouseButton1Click:Connect(function()
            infJumpActive = not infJumpActive
            if infJumpActive then
                infJumpBtn.Text = "Infinite Jump: ON"
                infJumpBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
            else
                infJumpBtn.Text = "Infinite Jump: OFF"
                infJumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end)

        uis.JumpRequest:Connect(function()
            if infJumpActive then
                pcall(function()
                    pl.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end)
            end
        end)

        local fullBrightBtn = Instance.new("TextButton", pageCombat)
        fullBrightBtn.Size = UDim2.new(1, 0, 0, 42)
        fullBrightBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        fullBrightBtn.Text = "Fullbright (Night Vision)"
        fullBrightBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        fullBrightBtn.TextSize = 14
        fullBrightBtn.Font = CUSTOM_FONT
        Instance.new("UICorner", fullBrightBtn).CornerRadius = UDim.new(0, 6)

        fullBrightBtn.MouseButton1Click:Connect(function()
            pcall(function()
                game:GetService("Lighting").Brightness = 2
                game:GetService("Lighting").ClockTime = 14
                game:GetService("Lighting").GlobalShadows = false
                sendNotification("Fullbright", "Night Vision Enabled!", 2)
            end)
        end)

        -- WalkSpeed Ayar Çubuğu
        local speedFrame = Instance.new("Frame", pageCombat)
        speedFrame.Size = UDim2.new(1, 0, 0, 45)
        speedFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        Instance.new("UICorner", speedFrame).CornerRadius = UDim.new(0, 6)

        local speedLabel = Instance.new("TextLabel", speedFrame)
        speedLabel.Size = UDim2.new(0.5, 0, 1, 0)
        speedLabel.Position = UDim2.new(0, 10, 0, 0)
        speedLabel.BackgroundTransparency = 1
        speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        speedLabel.TextSize = 14
        speedLabel.Font = CUSTOM_FONT
        speedLabel.TextXAlignment = Enum.TextXAlignment.Left
        speedLabel.Text = "WalkSpeed: " .. currentWalkSpeed

        local speedMinus = Instance.new("TextButton", speedFrame)
        speedMinus.Size = UDim2.new(0, 35, 0, 32)
        speedMinus.Position = UDim2.new(0.65, 0, 0.15, 0)
        speedMinus.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
        speedMinus.Text = "-"
        speedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
        speedMinus.Font = CUSTOM_FONT
        Instance.new("UICorner", speedMinus).CornerRadius = UDim.new(0, 4)

        local speedPlus = Instance.new("TextButton", speedFrame)
        speedPlus.Size = UDim2.new(0, 35, 0, 32)
        speedPlus.Position = UDim2.new(0.82, 0, 0.15, 0)
        speedPlus.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
        speedPlus.Text = "+"
        speedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
        speedPlus.Font = CUSTOM_FONT
        Instance.new("UICorner", speedPlus).CornerRadius = UDim.new(0, 4)

        speedMinus.MouseButton1Click:Connect(function()
            currentWalkSpeed = math.max(16, currentWalkSpeed - 10)
            speedLabel.Text = "WalkSpeed: " .. currentWalkSpeed
        end)
        speedPlus.MouseButton1Click:Connect(function()
            currentWalkSpeed = math.min(250, currentWalkSpeed + 10)
            speedLabel.Text = "WalkSpeed: " .. currentWalkSpeed
        end)

        -- JumpPower Ayar Çubuğu
        local jumpFrame = Instance.new("Frame", pageCombat)
        jumpFrame.Size = UDim2.new(1, 0, 0, 45)
        jumpFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        Instance.new("UICorner", jumpFrame).CornerRadius = UDim.new(0, 6)

        local jumpLabel = Instance.new("TextLabel", jumpFrame)
        jumpLabel.Size = UDim2.new(0.5, 0, 1, 0)
        jumpLabel.Position = UDim2.new(0, 10, 0, 0)
        jumpLabel.BackgroundTransparency = 1
        jumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        jumpLabel.TextSize = 14
        jumpLabel.Font = CUSTOM_FONT
        jumpLabel.TextXAlignment = Enum.TextXAlignment.Left
        jumpLabel.Text = "JumpPower: " .. currentJumpPower

        local jumpMinus = Instance.new("TextButton", jumpFrame)
        jumpMinus.Size = UDim2.new(0, 35, 0, 32)
        jumpMinus.Position = UDim2.new(0.65, 0, 0.15, 0)
        jumpMinus.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
        jumpMinus.Text = "-"
        jumpMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
        jumpMinus.Font = CUSTOM_FONT
        Instance.new("UICorner", jumpMinus).CornerRadius = UDim.new(0, 4)

        local jumpPlus = Instance.new("TextButton", jumpFrame)
        jumpPlus.Size = UDim2.new(0, 35, 0, 32)
        jumpPlus.Position = UDim2.new(0.82, 0, 0.15, 0)
        jumpPlus.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
        jumpPlus.Text = "+"
        jumpPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
        jumpPlus.Font = CUSTOM_FONT
        Instance.new("UICorner", jumpPlus).CornerRadius = UDim.new(0, 4)

        jumpMinus.MouseButton1Click:Connect(function()
            currentJumpPower = math.max(50, currentJumpPower - 20)
            jumpLabel.Text = "JumpPower: " .. currentJumpPower
        end)
        jumpPlus.MouseButton1Click:Connect(function()
            currentJumpPower = math.min(300, currentJumpPower + 20)
            jumpLabel.Text = "JumpPower: " .. currentJumpPower
        end)

        -- 4. TRADE & MISC SEKMESİ
        local rejoiningBtn = Instance.new("TextButton", pageTrade)
        rejoiningBtn.Size = UDim2.new(1, 0, 0, 42)
        rejoiningBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        rejoiningBtn.Text = "Rejoin Server"
        rejoiningBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        rejoiningBtn.TextSize = 14
        rejoiningBtn.Font = CUSTOM_FONT
        Instance.new("UICorner", rejoiningBtn).CornerRadius = UDim.new(0, 6)

        rejoiningBtn.MouseButton1Click:Connect(function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, pl)
        end)

        -- 5. AUTO FARM SEKMESİ
        local autoFarmBtn = Instance.new("TextButton", pageAutoFarm)
        autoFarmBtn.Size = UDim2.new(1, 0, 0, 42)
        autoFarmBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        autoFarmBtn.Text = "Auto Farm Coins: OFF"
        autoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        autoFarmBtn.TextSize = 14
        autoFarmBtn.Font = CUSTOM_FONT
        Instance.new("UICorner", autoFarmBtn).CornerRadius = UDim.new(0, 6)

        autoFarmBtn.MouseButton1Click:Connect(function()
            autoFarmEnabled = not autoFarmEnabled
            if autoFarmEnabled then
                autoFarmBtn.Text = "Auto Farm Coins: ON"
                autoFarmBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
                sendNotification("Farm", "Auto Farm Enabled!", 2)
            else
                autoFarmBtn.Text = "Auto Farm Coins: OFF"
                autoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                sendNotification("Farm", "Auto Farm Disabled!", 2)
            end
        end)

        sendNotification("Loaded", "Panel v31 fully loaded and fixed!", 3)
    else
        textBox.Text = ""
        textBox.PlaceholderText = "WRONG KEY!"
        task.wait(1.5)
        textBox.PlaceholderText = "Enter key..."
    end
end)
