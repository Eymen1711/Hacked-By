-- palofsc: Murder Mystery 2 - Fixed & Safe Universal Edition
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = Workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Key Tanımlamaları
local LOOTLABS_URL = "https://lootdest.org/s?CRVogxNA"
local VALID_KEY = "5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3"

-- Global Variables
_G.FlightSpeed = 60
_G.RoleESP = false
_G.GunESP = false
_G.CoinESP = false
_G.AutoGrabGun = false
_G.TradeScamActive = false
_G.ForceAcceptActive = false
_G.AutoBestItemActive = false
_G.FullBright = false
_G.KillAllActive = false
_G.InfiniteJump = false

-- Güvenli GUI Alanı (CoreGui hata verirse PlayerGui'ye düşer)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HackedBy_MM2_Elite"
pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = PlayerGui
end
ScreenGui.ResetOnSpawn = false

-- Bildirim Sistemi
local NotificationLabel = Instance.new("TextLabel", ScreenGui)
NotificationLabel.Name = "NotificationLabel"
NotificationLabel.Size = UDim2.new(0, 360, 0, 42)
NotificationLabel.Position = UDim2.new(0.5, -180, 0, 15)
NotificationLabel.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
NotificationLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
NotificationLabel.TextSize = 13
NotificationLabel.Font = Enum.Font.GothamBold
NotificationLabel.Text = "⚡ Key System Initialized..."
NotificationLabel.Visible = false
Instance.new("UICorner", NotificationLabel).CornerRadius = UDim.new(0, 10)
local notifStroke = Instance.new("UIStroke", NotificationLabel)
notifStroke.Color = Color3.fromRGB(168, 85, 247)
notifStroke.Thickness = 1.5

local function ShowNotification(msg)
    NotificationLabel.Text = msg
    NotificationLabel.Visible = true
    task.delay(3, function()
        if NotificationLabel.Text == msg then
            NotificationLabel.Visible = false
        end
    end)
end

-- ==========================================
-- 0. LOOTLABS KEY SİSTEMİ PENCERESİ
-- ==========================================
local KeySystemFrame = Instance.new("Frame", ScreenGui)
KeySystemFrame.Name = "KeySystemFrame"
KeySystemFrame.Size = UDim2.new(0, 400, 0, 240)
KeySystemFrame.Position = UDim2.new(0.5, -200, 0.5, -120)
KeySystemFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 18)
KeySystemFrame.Active = true
KeySystemFrame.Draggable = true
Instance.new("UICorner", KeySystemFrame).CornerRadius = UDim.new(0, 16)
local keyStroke = Instance.new("UIStroke", KeySystemFrame)
keyStroke.Color = Color3.fromRGB(168, 85, 247)
keyStroke.Thickness = 2

local KeyTitle = Instance.new("TextLabel", KeySystemFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 50)
KeyTitle.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
KeyTitle.Text = "⚡ Hacked By Hub - Key System"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 14
KeyTitle.Font = Enum.Font.GothamBold
Instance.new("UICorner", KeyTitle).CornerRadius = UDim.new(0, 16)

local GetKeyBtn = Instance.new("TextButton", KeySystemFrame)
GetKeyBtn.Size = UDim2.new(0.85, 0, 0, 40)
GetKeyBtn.Position = UDim2.new(0.075, 0, 0, 68)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 55)
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.Text = "🔗 Get Key (LootLabs Link)"
GetKeyBtn.TextSize = 13
GetKeyBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 10)

local KeyInputBox = Instance.new("TextBox", KeySystemFrame)
KeyInputBox.Size = UDim2.new(0.85, 0, 0, 42)
KeyInputBox.Position = UDim2.new(0.075, 0, 0, 118)
KeyInputBox.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
KeyInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInputBox.PlaceholderText = "Paste your key here..."
KeyInputBox.Text = ""
KeyInputBox.TextSize = 13
KeyInputBox.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", KeyInputBox).CornerRadius = UDim.new(0, 10)

local SubmitKeyBtn = Instance.new("TextButton", KeySystemFrame)
SubmitKeyBtn.Size = UDim2.new(0.85, 0, 0, 42)
SubmitKeyBtn.Position = UDim2.new(0.075, 0, 0, 172)
SubmitKeyBtn.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
SubmitKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitKeyBtn.Text = "Verify Key"
SubmitKeyBtn.TextSize = 13
SubmitKeyBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SubmitKeyBtn).CornerRadius = UDim.new(0, 10)

-- Güvenli Panoya Kopyalama
GetKeyBtn.MouseButton1Click:Connect(function()
    local success = pcall(function()
        setclipboard(LOOTLABS_URL)
    end)
    if success then
        ShowNotification("📋 LootLabs linki panoya kopyalandı!")
    else
        ShowNotification("🔗 Link: " .. LOOTLABS_URL)
    end
end)

-- Ana Menüyü Başlatan Fonksiyon
local function LoadMainHub()
    KeySystemFrame:Destroy()
    ShowNotification("⚡ Key Verified! Hub Loaded Successfully.")

    local ToggleMainGuiBtn = Instance.new("TextButton", ScreenGui)
    ToggleMainGuiBtn.Name = "ToggleMainGuiBtn"
    ToggleMainGuiBtn.Size = UDim2.new(0, 160, 0, 44)
    ToggleMainGuiBtn.Position = UDim2.new(0, 20, 0, 15)
    ToggleMainGuiBtn.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
    ToggleMainGuiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleMainGuiBtn.Text = "⚡ Hacked By Hub"
    ToggleMainGuiBtn.TextSize = 13
    ToggleMainGuiBtn.Font = Enum.Font.GothamBold
    ToggleMainGuiBtn.Active = true
    ToggleMainGuiBtn.Draggable = true
    Instance.new("UICorner", ToggleMainGuiBtn).CornerRadius = UDim.new(0, 12)
    local MainToggleStroke = Instance.new("UIStroke", ToggleMainGuiBtn)
    MainToggleStroke.Color = Color3.fromRGB(216, 180, 254)
    MainToggleStroke.Thickness = 1.5

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 18)
    MainFrame.Position = UDim2.new(0.5, -240, 0.5, -265)
    MainFrame.Size = UDim2.new(0, 480, 0, 490)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Visible = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 20)

    ToggleMainGuiBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(168, 85, 247)
    MainStroke.Thickness = 2

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = MainFrame
    TitleLabel.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    TitleLabel.Size = UDim2.new(1, 0, 0, 60)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = "⚡ Hacked By - Murder Mystery 2 Elite"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 15
    Instance.new("UICorner", TitleLabel).CornerRadius = UDim.new(0, 20)

    local TabContainer = Instance.new("Frame", MainFrame)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 15, 0, 72)
    TabContainer.Size = UDim2.new(1, -30, 0, 40)

    local TabListLayout = Instance.new("UIListLayout", TabContainer)
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.Padding = UDim.new(0, 12)

    local function CreateTabButton(name, index)
        local btn = Instance.new("TextButton", TabContainer)
        btn.Size = UDim2.new(0.485, 0, 1, 0)
        btn.BackgroundColor3 = index == 1 and Color3.fromRGB(168, 85, 247) or Color3.fromRGB(22, 22, 32)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 13
        btn.Font = Enum.Font.GothamBold
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
        return btn
    end

    local Tab1Btn = CreateTabButton("Main & Sheriff", 1)
    local Tab2Btn = CreateTabButton("Combat & Movement", 2)

    local PageContainer = Instance.new("Frame", MainFrame)
    PageContainer.BackgroundTransparency = 1
    PageContainer.Position = UDim2.new(0, 15, 0, 124)
    PageContainer.Size = UDim2.new(1, -30, 1, -136)

    local function CreateScrollingPage()
        local sf = Instance.new("ScrollingFrame", PageContainer)
        sf.BackgroundTransparency = 1
        sf.Size = UDim2.new(1, 0, 1, 0)
        sf.CanvasSize = UDim2.new(0, 0, 2.8, 0)
        sf.ScrollBarThickness = 4
        sf.Visible = false
        local layout = Instance.new("UIListLayout", sf)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 12)
        return sf
    end

    local Page1 = CreateScrollingPage()
    local Page2 = CreateScrollingPage()
    Page1.Visible = true

    Tab1Btn.MouseButton1Click:Connect(function()
        Page1.Visible, Page2.Visible = true, false
        Tab1Btn.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
        Tab2Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
    end)

    Tab2Btn.MouseButton1Click:Connect(function()
        Page1.Visible, Page2.Visible = false, true
        Tab1Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
        Tab2Btn.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
    end)

    local function CreateToggle(parent, name, callback)
        local Button = Instance.new("TextButton")
        Button.Parent = parent
        Button.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
        Button.Size = UDim2.new(1, 0, 0, 48)
        Button.Font = Enum.Font.GothamSemibold
        Button.Text = name .. " : [OFF]"
        Button.TextColor3 = Color3.fromRGB(180, 180, 200)
        Button.TextSize = 13
        Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 10)
        
        local toggled = false
        Button.MouseButton1Click:Connect(function()
            toggled = not toggled
            if toggled then
                Button.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.Text = name .. " : [ON]"
            else
                Button.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
                Button.TextColor3 = Color3.fromRGB(180, 180, 200)
                Button.Text = name .. " : [OFF]"
            end
            pcall(function() callback(toggled) end)
        end)
    end

    local function CreateButton(parent, name, callback)
        local Button = Instance.new("TextButton")
        Button.Parent = parent
        Button.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
        Button.Size = UDim2.new(1, 0, 0, 48)
        Button.Font = Enum.Font.GothamBold
        Button.Text = name
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 13
        Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 10)
        
        Button.MouseButton1Click:Connect(function()
            pcall(function() callback() end)
        end)
    end

    local function CreateSlider(parent, name, min, max, default, callback)
        local Frame = Instance.new("Frame", parent)
        Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
        Frame.Size = UDim2.new(1, 0, 0, 60)
        Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

        local Label = Instance.new("TextLabel", Frame)
        Label.BackgroundTransparency = 1
        Label.Position = UDim2.new(0, 14, 0, 8)
        Label.Size = UDim2.new(1, -28, 0, 20)
        Label.Font = Enum.Font.GothamBold
        Label.Text = name .. ": " .. default
        Label.TextColor3 = Color3.fromRGB(220, 220, 235)
        Label.TextSize = 13
        Label.TextXAlignment = Enum.TextXAlignment.Left

        local SliderBar = Instance.new("TextButton", Frame)
        SliderBar.BackgroundColor3 = Color3.fromRGB(38, 38, 55)
        SliderBar.Position = UDim2.new(0, 14, 0, 36)
        SliderBar.Size = UDim2.new(1, -28, 0, 14)
        SliderBar.Text = ""
        Instance.new("UICorner", SliderBar).CornerRadius = UDim.new(0, 7)

        local Fill = Instance.new("Frame", SliderBar)
        Fill.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
        Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        Instance.new("UICorner", Fill).CornerRadius = UDim.new(0, 7)

        local dragging = false
        SliderBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                Fill.Size = UDim2.new(pos, 0, 1, 0)
                local val = math.floor(min + (max - min) * pos)
                Label.Text = name .. ": " .. val
                pcall(function() callback(val) end)
            end
        end)
    end

    -- ================= PAGE 1 =================
    CreateToggle(Page1, "Role ESP", function(state)
        _G.RoleESP = state
        RunService.RenderStepped:Connect(function()
            if not _G.RoleESP then return end
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local char = player.Character
                    local hl = char:FindFirstChild("HBHighlight") or Instance.new("Highlight", char)
                    hl.Name = "HBHighlight"
                    local bp = player:FindFirstChild("Backpack")
                    local hasK = (bp and bp:FindFirstChild("Knife")) or char:FindFirstChild("Knife")
                    local hasG = (bp and bp:FindFirstChild("Gun")) or char:FindFirstChild("Gun")
                    if hasK then hl.FillColor = Color3.fromRGB(255, 50, 50)
                    elseif hasG then hl.FillColor = Color3.fromRGB(50, 150, 255)
                    else hl.FillColor = Color3.fromRGB(50, 255, 100) end
                end
            end
        end)
    end)

    CreateToggle(Page1, "Sheriff Gun ESP", function(state)
        _G.GunESP = state
        RunService.RenderStepped:Connect(function()
            if not _G.GunESP then return end
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                    local hl = obj:FindFirstChild("GunHighlight") or Instance.new("Highlight", obj)
                    hl.Name = "GunHighlight"
                    hl.FillColor = Color3.fromRGB(255, 255, 0)
                end
            end
        end)
    end)

    CreateToggle(Page1, "Coin ESP", function(state)
        _G.CoinESP = state
        RunService.RenderStepped:Connect(function()
            if not _G.CoinESP then return end
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and string.find(obj.Name:lower(), "coin") then
                    local hl = obj:FindFirstChild("CoinHighlight") or Instance.new("Highlight", obj)
                    hl.Name = "CoinHighlight"
                    hl.FillColor = Color3.fromRGB(255, 215, 0)
                end
            end
        end)
    end)

    CreateButton(Page1, "🎯 Shoot Murderer", function()
        local murdererFound = false
        local localChar = LocalPlayer.Character
        local localHrp = localChar and localChar:FindFirstChild("HumanoidRootPart")
        
        if not localHrp then
            ShowNotification("❌ Karakter bulunamadı!")
            return
        end

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local bp = p:FindFirstChild("Backpack")
                local char = p.Character
                local hasKnife = (bp and bp:FindFirstChild("Knife")) or char:FindFirstChild("Knife")
                
                if hasKnife then
                    murdererFound = true
                    local targetHrp = char.HumanoidRootPart
                    local _, onScreen = Camera:WorldToViewportPoint(targetHrp.Position)
                    local distance = (localHrp.Position - targetHrp.Position).Magnitude
                    
                    if onScreen and distance <= 250 then
                        local gun = localChar:FindFirstChild("Gun") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Gun"))
                        if gun then
                            gun.Parent = localChar
                            pcall(function()
                                local shootRemote = ReplicatedStorage:FindFirstChild("ShootGun", true) or ReplicatedStorage:FindFirstChild("GunShoot", true)
                                if shootRemote then
                                    if shootRemote:IsA("RemoteEvent") then shootRemote:FireServer(targetHrp.Position)
                                    elseif shootRemote:IsA("RemoteFunction") then shootRemote:InvokeServer(targetHrp.Position) end
                                else
                                    gun:Activate()
                                end
                            end)
                            ShowNotification("🎯 Murderer Shot Successfully!")
                        else
                            ShowNotification("❌ Elinizde tabanca yok!")
                        end
                    else
                        ShowNotification("⚠️ Katil görüş mesafenizde değil!")
                    end
                    break
                end
            end
        end
        if not murdererFound then
            ShowNotification("🔍 Odada yaşayan katil tespit edilemedi.")
        end
    end)

    CreateToggle(Page1, "Auto Grab Gun", function(state)
        _G.AutoGrabGun = state
        task.spawn(function()
            while _G.AutoGrabGun do
                task.wait(0.3)
                pcall(function()
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if obj.Name == "GunDrop" and obj:IsA("BasePart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                        end
                    end
                end)
            end
        end)
    end)

    -- ================= PAGE 2 =================
    CreateSlider(Page2, "Flight Speed", 15, 90, 60, function(val)
        _G.FlightSpeed = val
    end)

    CreateSlider(Page2, "WalkSpeed", 16, 100, 16, function(val)
        pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = val end)
    end)

    CreateSlider(Page2, "JumpPower", 50, 100, 50, function(val)
        pcall(function() LocalPlayer.Character.Humanoid.JumpPower = val end)
    end)

    CreateToggle(Page2, "Infinite Jump", function(state)
        _G.InfiniteJump = state
    end)

    UserInputService.JumpRequest:Connect(function()
        if _G.InfiniteJump then
            pcall(function() LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
        end
    end)

    CreateToggle(Page2, "Kill All (As Murderer)", function(state)
        _G.KillAllActive = state
        if _G.KillAllActive then
            task.spawn(function()
                while _G.KillAllActive do
                    task.wait(0.4)
                    pcall(function()
                        if not _G.KillAllActive then break end
                        local char = LocalPlayer.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        if not hrp then return end
                        local knife = char:FindFirstChild("Knife") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Knife"))
                        if knife then knife.Parent = char end

                        for _, p in ipairs(Players:GetPlayers()) do
                            if not _G.KillAllActive then break end
                            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHrp = p.Character.HumanoidRootPart
                                hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 2)
                                task.wait(0.1)
                                if knife and knife:FindFirstChild("Stab") then knife.Stab:FireServer() end
                                if knife then pcall(function() knife:Activate() end) end
                            end
                        end
                    end)
                end
            end)
        end
    end)

    -- ==========================================
    -- 2. TRADE SCAM YAN MENÜSÜ
    -- ==========================================
    local TradeSidePanel = Instance.new("Frame", ScreenGui)
    TradeSidePanel.Name = "TradeSidePanel"
    TradeSidePanel.Size = UDim2.new(0, 210, 0, 230)
    TradeSidePanel.Position = UDim2.new(1, -230, 0.5, -115)
    TradeSidePanel.BackgroundColor3 = Color3.fromRGB(13, 13, 18)
    TradeSidePanel.Visible = false
    TradeSidePanel.Active = true
    TradeSidePanel.Draggable = true
    Instance.new("UICorner", TradeSidePanel).CornerRadius = UDim.new(0, 14)
    local tradePanelStroke = Instance.new("UIStroke", TradeSidePanel)
    tradePanelStroke.Color = Color3.fromRGB(168, 85, 247)
    tradePanelStroke.Thickness = 2

    local TradeTitle = Instance.new("TextLabel", TradeSidePanel)
    TradeTitle.Size = UDim2.new(1, 0, 0, 38)
    TradeTitle.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    TradeTitle.Text = "⚡ TRADE SCAM PANEL"
    TradeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    TradeTitle.TextSize = 12
    TradeTitle.Font = Enum.Font.GothamBold
    Instance.new("UICorner", TradeTitle).CornerRadius = UDim.new(0, 14)

    local TradePanelLayout = Instance.new("UIListLayout", TradeSidePanel)
    TradePanelLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TradePanelLayout.Padding = UDim.new(0, 8)
    TradePanelLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local pad = Instance.new("Frame", TradeSidePanel)
    pad.Size = UDim2.new(1, 0, 0, 40)
    pad.BackgroundTransparency = 1
    pad.LayoutOrder = 0

    local function CreateTradePanelToggle(name, layoutOrder, callback)
        local btn = Instance.new("TextButton", TradeSidePanel)
        btn.LayoutOrder = layoutOrder
        btn.Size = UDim2.new(0.9, 0, 0, 36)
        btn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
        btn.TextColor3 = Color3.fromRGB(180, 180, 200)
        btn.Text = name .. " : [OFF]"
        btn.TextSize = 11
        btn.Font = Enum.Font.GothamBold
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        local active = false
        btn.MouseButton1Click:Connect(function()
            active = not active
            if active then
                btn.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Text = name .. " : [ON]"
            else
                btn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
                btn.TextColor3 = Color3.fromRGB(180, 180, 200)
                btn.Text = name .. " : [OFF]"
            end
            pcall(function() callback(active) end)
        end)
        return btn
    end

    CreateTradePanelToggle("Freeze Trade", 1, function(state)
        _G.TradeScamActive = state
        ShowNotification(state and "⚡ Freeze Trade Activated!" or "❌ Freeze Trade Disabled")
        task.spawn(function()
            while _G.TradeScamActive do
                task.wait(0.2)
                pcall(function()
                    for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
                        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                            local rName = remote.Name:lower()
                            if string.find(rName, "trade") and (string.find(rName, "freeze") or string.find(rName, "lock")) then
                                if remote:IsA("RemoteEvent") then remote:FireServer(true)
                                elseif remote:IsA("RemoteFunction") then remote:InvokeServer(true) end
                            end
                        end
                    end
                end)
            end
        end)
    end)

    CreateTradePanelToggle("Force Accept", 2, function(state)
        _G.ForceAcceptActive = state
        ShowNotification(state and "⚡ Force Accept Activated!" or "❌ Force Accept Disabled")
        task.spawn(function()
            while _G.ForceAcceptActive do
                task.wait(0.2)
                pcall(function()
                    for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
                        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                            local rName = remote.Name:lower()
                            if string.find(rName, "trade") and (string.find(rName, "accept") or string.find(rName, "confirm")) then
                                if remote:IsA("RemoteEvent") then remote:FireServer(true)
                                elseif remote:IsA("RemoteFunction") then remote:InvokeServer(true) end
                            end
                        end
                    end
                end)
            end
        end)
    end)

    CreateTradePanelToggle("Protect Best Item", 3, function(state)
        _G.AutoBestItemActive = state
        ShowNotification(state and "🛡️ Best Item Protection Active!" or "❌ Protection Disabled")
    end)

    task.spawn(function()
        while true do
            task.wait(0.4)
            pcall(function()
                local tradeGui = PlayerGui:FindFirstChild("TradeGui") or PlayerGui:FindFirstChild("Trade")
                if tradeGui and tradeGui.Enabled then
                    TradeSidePanel.Visible = true
                else
                    TradeSidePanel.Visible = false
                end
            end)
        end
    end)
end

-- Key Doğrulama Kontrolü
SubmitKeyBtn.MouseButton1Click:Connect(function()
    local enteredKey = KeyInputBox.Text
    if enteredKey == VALID_KEY then
        LoadMainHub()
    else
        ShowNotification("❌ Hatalı Key! Lütfen geçerli bir key girin.")
    end
end)
