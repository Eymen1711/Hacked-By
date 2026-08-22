-- palofsc: Hacked By (Ultimate MM2 Edition - Full Features & Fixed Shoot)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

-- Global Variables
_G.FlightSpeed = 60
_G.RoleESP = false
_G.GunESP = false
_G.CoinESP = false
_G.NameDistESP = false
_G.AutoGrabGun = false
_G.TradeScamActive = false
_G.AutoFarm = false
_G.AutoNoclip = false
_G.FullBright = false
_G.KillAllActive = false
_G.InfiniteJump = false

-- ==========================================
-- 0. BOTTOM LEFT FPS COUNTER
-- ==========================================
local FpsGui = Instance.new("ScreenGui")
FpsGui.Name = "HackedBy_FpsCounter"
FpsGui.Parent = CoreGui
FpsGui.ResetOnSpawn = false

local FpsToggleButton = Instance.new("TextButton", FpsGui)
FpsToggleButton.Size = UDim2.new(0, 110, 0, 32)
FpsToggleButton.Position = UDim2.new(0, 15, 1, -50)
FpsToggleButton.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
FpsToggleButton.TextColor3 = Color3.fromRGB(0, 255, 127)
FpsToggleButton.TextSize = 12
FpsToggleButton.Font = Enum.Font.GothamBold
FpsToggleButton.Text = "FPS: 60 [ON]"
FpsToggleButton.Active = true
FpsToggleButton.Draggable = true
Instance.new("UICorner", FpsToggleButton).CornerRadius = UDim.new(0, 10)
local FpsStroke = Instance.new("UIStroke", FpsToggleButton)
FpsStroke.Color = Color3.fromRGB(168, 85, 247)
FpsStroke.Thickness = 1.5

local fpsActive = true
FpsToggleButton.MouseButton1Click:Connect(function()
    fpsActive = not fpsActive
    if not fpsActive then
        FpsToggleButton.Text = "FPS: Hidden [OFF]"
        FpsToggleButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

local frameCount, lastUpdate = 0, tick()
RunService.RenderStepped:Connect(function()
    if not fpsActive then return end
    frameCount = frameCount + 1
    local now = tick()
    if now - lastUpdate >= 1 then
        local fps = math.floor(frameCount / (now - lastUpdate))
        FpsToggleButton.Text = "FPS: " .. fps .. " [ON]"
        FpsToggleButton.TextColor3 = Color3.fromRGB(0, 255, 127)
        frameCount, lastUpdate = 0, now
    end
end)

-- ==========================================
-- 1. KEY SYSTEM GUI
-- ==========================================
local KeySystemGui = Instance.new("ScreenGui")
KeySystemGui.Name = "HackedBy_KeySystem"
KeySystemGui.Parent = CoreGui
KeySystemGui.ResetOnSpawn = false

local KeyFrame = Instance.new("Frame", KeySystemGui)
KeyFrame.Size = UDim2.new(0, 420, 0, 300)
KeyFrame.Position = UDim2.new(0.5, -210, 0.5, -150)
KeyFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 18)
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 18)

local KeyStroke = Instance.new("UIStroke", KeyFrame)
KeyStroke.Color = Color3.fromRGB(168, 85, 247)
KeyStroke.Thickness = 2

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 60)
KeyTitle.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
KeyTitle.Text = "🔐  HACKED BY | SECURE ACCESS"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 15
KeyTitle.Font = Enum.Font.GothamBold
Instance.new("UICorner", KeyTitle).CornerRadius = UDim.new(0, 18)

local KeyTextBox = Instance.new("TextBox", KeyFrame)
KeyTextBox.Size = UDim2.new(0.86, 0, 0, 46)
KeyTextBox.Position = UDim2.new(0.07, 0, 0.28, 0)
KeyTextBox.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
KeyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTextBox.PlaceholderText = "Enter your license key..."
KeyTextBox.Text = ""
KeyTextBox.TextSize = 13
KeyTextBox.Font = Enum.Font.GothamMedium
Instance.new("UICorner", KeyTextBox).CornerRadius = UDim.new(0, 12)
local KeyBoxStroke = Instance.new("UIStroke", KeyTextBox)
KeyBoxStroke.Color = Color3.fromRGB(50, 50, 75)
KeyBoxStroke.Thickness = 1.2

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(0.86, 0, 0, 40)
GetKeyBtn.Position = UDim2.new(0.07, 0, 0.48, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
GetKeyBtn.Text = "🔗 Get Key (LootLabs)"
GetKeyBtn.TextColor3 = Color3.fromRGB(216, 180, 254)
GetKeyBtn.TextSize = 13
GetKeyBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 12)

GetKeyBtn.MouseButton1Click:Connect(function()
    local lootlabsUrl = "https://lootdest.org/s/CRVogxNA"
    pcall(function() setclipboard(lootlabsUrl) end)
    pcall(function() GuiService:OpenBrowserWindow(lootlabsUrl) end)
    GetKeyBtn.Text = "✔️ Link Copied & Opened!"
    task.wait(2)
    GetKeyBtn.Text = "🔗 Get Key (LootLabs)"
end)

local LoginBtn = Instance.new("TextButton", KeyFrame)
LoginBtn.Size = UDim2.new(0.86, 0, 0, 46)
LoginBtn.Position = UDim2.new(0.07, 0, 0.68, 0)
LoginBtn.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
LoginBtn.Text = "Authenticate & Launch"
LoginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoginBtn.TextSize = 14
LoginBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", LoginBtn).CornerRadius = UDim.new(0, 12)

-- ==========================================
-- 2. MAIN HUB & TABS
-- ==========================================
local function StartMainHub()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "HackedByGui"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

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

    local Tab1Btn = CreateTabButton("Main Features", 1)
    local Tab2Btn = CreateTabButton("Combat & Movement", 2)

    local PageContainer = Instance.new("Frame", MainFrame)
    PageContainer.BackgroundTransparency = 1
    PageContainer.Position = UDim2.new(0, 15, 0, 124)
    PageContainer.Size = UDim2.new(1, -30, 1, -136)

    local function CreateScrollingPage()
        local sf = Instance.new("ScrollingFrame", PageContainer)
        sf.BackgroundTransparency = 1
        sf.Size = UDim2.new(1, 0, 1, 0)
        sf.CanvasSize = UDim2.new(0, 0, 2.5, 0)
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

    local function SmoothFlyTo(targetCFrame)
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local distance = (hrp.Position - targetCFrame.Position).Magnitude
                local currentSpeed = math.clamp(_G.FlightSpeed or 60, 15, 90)
                local flightTime = distance / currentSpeed 
                
                local tweenInfo = TweenInfo.new(flightTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
                tween:Play()
                task.wait(flightTime)
            end
        end)
    end

    -- ================= PAGE 1: MAIN FEATURES =================
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
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            end
        end)
    end)

    CreateToggle(Page1, "Coin ESP & Tracker", function(state)
        _G.CoinESP = state
        RunService.RenderStepped:Connect(function()
            if not _G.CoinESP then return end
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local n = obj.Name:lower()
                    if string.find(n, "coin") or string.find(n, "token") or string.find(n, "drop") then
                        local hl = obj:FindFirstChild("CoinHighlight") or Instance.new("Highlight", obj)
                        hl.Name = "CoinHighlight"
                        hl.FillColor = Color3.fromRGB(255, 215, 0)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end)
    end)

    CreateToggle(Page1, "Name & Distance ESP", function(state)
        _G.NameDistESP = state
        RunService.RenderStepped:Connect(function()
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                    local head = player.Character.Head
                    local bg = head:FindFirstChild("NameDistTag")
                    if _G.NameDistESP then
                        if not bg then
                            bg = Instance.new("BillboardGui", head)
                            bg.Name = "NameDistTag"
                            bg.Size = UDim2.new(0, 100, 0, 40)
                            bg.StudsOffset = Vector3.new(0, 2.5, 0)
                            bg.AlwaysOnTop = true
                            local txt = Instance.new("TextLabel", bg)
                            txt.Name = "TagText"
                            txt.Size = UDim2.new(1, 0, 1, 0)
                            txt.BackgroundTransparency = 1
                            txt.TextColor3 = Color3.fromRGB(255, 255, 255)
                            txt.TextStrokeTransparency = 0
                            txt.TextSize = 12
                            txt.Font = Enum.Font.GothamBold
                        end
                        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local dist = math.floor((hrp.Position - head.Position).Magnitude)
                            local txt = bg:FindFirstChild("TagText")
                            if txt then
                                txt.Text = player.Name .. "\n[" .. dist .. " studs]"
                            end
                        end
                    else
                        if bg then bg:Destroy() end
                    end
                end
            end
        end)
    end)

    local NotificationLabel = Instance.new("TextLabel", ScreenGui)
    NotificationLabel.Name = "NotificationLabel"
    NotificationLabel.Size = UDim2.new(0, 360, 0, 42)
    NotificationLabel.Position = UDim2.new(0.5, -180, 0, 15)
    NotificationLabel.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
    NotificationLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    NotificationLabel.TextSize = 13
    NotificationLabel.Font = Enum.Font.GothamBold
    NotificationLabel.Text = ""
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

    CreateToggle(Page1, "Auto Grab Gun", function(state)
        _G.AutoGrabGun = state
    end)

    CreateToggle(Page1, "Trade Scam (Freeze & Force Best)", function(state)
        _G.TradeScamActive = state
        ShowNotification(_G.TradeScamActive and "⚡ Advanced Trade Scam Activated!" or "❌ Trade Scam Disabled")
        
        task.spawn(function()
            while _G.TradeScamActive do
                task.wait(0.2)
                pcall(function()
                    local tradeGui = PlayerGui:FindFirstChild("TradeGui") or PlayerGui:FindFirstChild("Trade")
                    if tradeGui and tradeGui.Enabled then
                        for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
                            if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                                local rName = remote.Name:lower()
                                if string.find(rName, "trade") and (string.find(rName, "freeze") or string.find(rName, "lock") or string.find(rName, "accept") or string.find(rName, "offer") or string.find(rName, "item")) then
                                    pcall(function()
                                        if remote:IsA("RemoteEvent") then
                                            remote:FireServer(true)
                                            remote:FireServer("Freeze")
                                            remote:FireServer("Accept")
                                        elseif remote:IsA("RemoteFunction") then
                                            remote:InvokeServer(true)
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end)

    task.spawn(function()
        local lastGunFound = false
        while true do
            task.wait(0.3)
            pcall(function()
                local gunDrop = nil
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                        gunDrop = obj
                        break
                    end
                end

                if gunDrop then
                    if not lastGunFound then
                        lastGunFound = true
                        ShowNotification("⚠️ Sheriff is Dead! Gun Dropped!")

                        if _G.AutoGrabGun then
                            local char = LocalPlayer.Character
                            local hrp = char and char:FindFirstChild("HumanoidRootPart")
                            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
                            if hrp then
                                local originalPos = hrp.CFrame
                                hrp.CFrame = gunDrop.CFrame + Vector3.new(0, 1, 0)
                                task.wait(0.15)
                                hrp.CFrame = originalPos
                                
                                if humanoid then
                                    humanoid.PlatformStand = false
                                    humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                                end
                            end
                        end
                    end
                else
                    lastGunFound = false
                end
            end)
        end
    end)

    CreateToggle(Page1, "Auto Farm Coins", function(state)
        _G.AutoFarm = state
        _G.AutoNoclip = state

        if _G.AutoFarm then
            task.spawn(function()
                while _G.AutoFarm do
                    task.wait(0.15)
                    pcall(function()
                        local foundCoin = false
                        for _, obj in ipairs(Workspace:GetDescendants()) do
                            if not _G.AutoFarm then break end
                            if obj:IsA("BasePart") then
                                local n = obj.Name:lower()
                                if n == "coin" or n == "coinvisual" or n == "coin_visual" or string.find(n, "coin") or string.find(n, "event") or string.find(n, "drop") or string.find(n, "collect") or string.find(n, "token") then
                                    SmoothFlyTo(obj.CFrame + Vector3.new(0, 1.8, 0))
                                    foundCoin = true
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end)

    RunService.Stepped:Connect(function()
        if _G.AutoNoclip then
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
    end)

    CreateToggle(Page1, "FullBright", function(state)
        _G.FullBright = state
        RunService.RenderStepped:Connect(function()
            if _G.FullBright then
                game:GetService("Lighting").Brightness = 2
                game:GetService("Lighting").ClockTime = 14
                game:GetService("Lighting").GlobalShadows = false
            end
        end)
    end)

    -- ================= PAGE 2: COMBAT & MOVEMENT =================
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
            pcall(function()
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end)
        end
    end)

    CreateToggle(Page2, "Kill All (As Murderer)", function(state)
        _G.KillAllActive = state
        if _G.KillAllActive then
            task.spawn(function()
                while _G.KillAllActive do
                    task.wait(0.4)
                    pcall(function()
                        local char = LocalPlayer.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        if not hrp then return end

                        local knife = char:FindFirstChild("Knife") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Knife"))
                        if knife then knife.Parent = char end

                        for _, p in ipairs(Players:GetPlayers()) do
                            if not _G.KillAllActive then break end
                            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHrp = p.Character.HumanoidRootPart
                                local targetHumanoid = p.Character:FindFirstChildOfClass("Humanoid")
                                if targetHumanoid and targetHumanoid.Health > 0 then
                                    hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 2)
                                    task.wait(0.1)
                                    if knife and knife:FindFirstChild("Stab") then
                                        knife.Stab:FireServer()
                                    end
                                    if knife and knife:FindFirstChild("Activate") then
                                        pcall(function() knife:Activate() end)
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end)

    -- ==========================================
    -- 3. FLOATING ACTION BUTTONS (VERTICAL CONTAINER)
    -- ==========================================
    local FloatContainer = Instance.new("Frame", ScreenGui)
    FloatContainer.Name = "FloatContainer"
    FloatContainer.Size = UDim2.new(0, 185, 0, 310)
    FloatContainer.Position = UDim2.new(0, 15, 0, 75)
    FloatContainer.BackgroundTransparency = 1
    FloatContainer.Active = true
    FloatContainer.Draggable = true

    local FloatLayout = Instance.new("UIListLayout", FloatContainer)
    FloatLayout.SortOrder = Enum.SortOrder.LayoutOrder
    FloatLayout.Padding = UDim.new(0, 6)

    local function CreateFloatingButton(name, text, color, layoutOrder, callback)
        local FloatBtn = Instance.new("TextButton", FloatContainer)
        FloatBtn.Name = name
        FloatBtn.LayoutOrder = layoutOrder
        FloatBtn.Size = UDim2.new(1, 0, 0, 40)
        FloatBtn.BackgroundColor3 = color
        FloatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        FloatBtn.Text = text
        FloatBtn.TextSize = 13
        FloatBtn.Font = Enum.Font.GothamBold
        Instance.new("UICorner", FloatBtn).CornerRadius = UDim.new(0, 10)
        local btnStroke = Instance.new("UIStroke", FloatBtn)
        btnStroke.Color = Color3.fromRGB(255, 255, 255)
        btnStroke.Transparency = 0.4
        btnStroke.Thickness = 1.2
        
        FloatBtn.MouseButton1Click:Connect(callback)
        return FloatBtn
    end

    -- 1. TRADE SCAM FLOATING BUTTON (Order 1)
    CreateFloatingButton("FloatTradeScamBtn", "⚡ TRADE SCAM", Color3.fromRGB(147, 51, 234), 1, function()
        _G.TradeScamActive = not _G.TradeScamActive
        ShowNotification(_G.TradeScamActive and "⚡ Advanced Trade Scam Activated!" or "❌ Trade Scam Disabled")
        
        if _G.TradeScamActive then
            task.spawn(function()
                while _G.TradeScamActive do
                    task.wait(0.2)
                    pcall(function()
                        local tradeGui = PlayerGui:FindFirstChild("TradeGui") or PlayerGui:FindFirstChild("Trade")
                        if tradeGui and tradeGui.Enabled then
                            for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
                                if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                                    local rName = remote.Name:lower()
                                    if string.find(rName, "trade") and (string.find(rName, "freeze") or string.find(rName, "lock") or string.find(rName, "accept") or string.find(rName, "offer")) then
                                        pcall(function()
                                            if remote:IsA("RemoteEvent") then remote:FireServer(true)
                                            elseif remote:IsA("RemoteFunction") then remote:InvokeServer(true) end
                                        end)
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end)

    -- 2. SHOOT MURDER BUTTON (Fixed & Optimized) (Order 2)
    CreateFloatingButton("FloatShootBtn", "🎯 SHOOT MURDER", Color3.fromRGB(225, 29, 72), 2, function()
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            local gun = char:FindFirstChild("Gun") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Gun"))
            if gun then gun.Parent = char end

            local murdererTarget = nil
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local pChar = p.Character
                    local bp = p:FindFirstChild("Backpack")
                    local hasKnife = (bp and bp:FindFirstChild("Knife")) or pChar:FindFirstChild("Knife")
                    local highlight = pChar:FindFirstChild("HBHighlight")
                    
                    if hasKnife or (highlight and highlight.FillColor == Color3.fromRGB(255, 50, 50)) then
                        murdererTarget = pChar
                        break
                    end
                end
            end

            if murdererTarget and murdererTarget:FindFirstChild("HumanoidRootPart") then
                local mHrp = murdererTarget.HumanoidRootPart
                
                -- Force Equipping and Firing
                if gun then
                    pcall(function() gun:Activate() end)
                    if gun:FindFirstChild("ShootGun") then
                        gun.ShootGun:FireServer(1, mHrp.Position, "AH")
                    end
                end

                for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
                    if remote:IsA("RemoteEvent") then
                        local rName = remote.Name:lower()
                        if string.find(rName, "shoot") or string.find(rName, "gun") or string.find(rName, "fire") then
                            pcall(function() remote:FireServer(mHrp.Position) end)
                        end
                    end
                end

                ShowNotification("🎯 Shot fired at Murderer!")
            else
                ShowNotification("⚠️ Murderer not found!")
            end
        end)
    end)

    -- 3. KILL ALL BUTTON (Order 3)
    CreateFloatingButton("FloatKillAllBtn", "⚔️ KILL ALL", Color3.fromRGB(185, 28, 28), 3, function()
        _G.KillAllActive = not _G.KillAllActive
        if _G.KillAllActive then
            ShowNotification("⚔️ Kill All Activated!")
            task.spawn(function()
                while _G.KillAllActive do
                    task.wait(0.4)
                    pcall(function()
                        local char = LocalPlayer.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        if not hrp then return end

                        local knife = char:FindFirstChild("Knife") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Knife"))
                        if knife then knife.Parent = char end

                        for _, p in ipairs(Players:GetPlayers()) do
                            if not _G.KillAllActive then break end
                            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHrp = p.Character.HumanoidRootPart
                                local targetHumanoid = p.Character:FindFirstChildOfClass("Humanoid")
                                if targetHumanoid and targetHumanoid.Health > 0 then
                                    hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 2)
                                    task.wait(0.1)
                                    if knife and knife:FindFirstChild("Stab") then
                                        knife.Stab:FireServer()
                                    end
                                    if knife and knife:FindFirstChild("Activate") then
                                        pcall(function() knife:Activate() end)
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        else
            ShowNotification("❌ Kill All Deactivated!")
        end
    end)

    -- 4. TELEPORT TO MAP BUTTON (Order 4)
    CreateFloatingButton("FloatTpMapBtn", "🗺️ Teleport to Map", Color3.fromRGB(37, 99, 235), 4, function()
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            if not hrp then return end
            
            local targetCFrame = nil
            for _, obj in ipairs(Workspace:GetChildren()) do
                local nameLower = obj.Name:lower()
                if obj:IsA("Model") and nameLower ~= "lounge" and nameLower ~= "lobby" and nameLower ~= "camera" and nameLower ~= "terrain" and nameLower ~= "currentcamera" then
                    local spawns = obj:FindFirstChild("SpawnLocations") or obj:FindFirstChild("Spawns") or obj:FindFirstChild("MapSpawns")
                    if spawns and #spawns:GetChildren() > 0 then
                        for _, sp in ipairs(spawns:GetChildren()) do
                            if sp:IsA("BasePart") then
                                targetCFrame = sp.CFrame + Vector3.new(0, 5, 0)
                                break
                            end
                        end
                    end
                    
                    if not targetCFrame then
                        for _, part in ipairs(obj:GetDescendants()) do
                            if part:IsA("BasePart") and part.Size.Magnitude > 12 and part.Position.Y > -5 and part.Position.Y < 500 then
                                targetCFrame = part.CFrame + Vector3.new(0, 6, 0)
                                break
                            end
                        end
                    end
                end
                if targetCFrame then break end
            end

            if targetCFrame then
                hrp.CFrame = targetCFrame
                ShowNotification("🗺️ Teleported to Map!")
            else
                hrp.CFrame = CFrame.new(0, 30, 0)
                ShowNotification("⚠️ Map not found, teleported to safe spot.")
            end

            task.wait(0.05)
            if humanoid then
                humanoid.PlatformStand = false
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end)
    end)

    -- 5. TELEPORT TO LOBBY BUTTON (Order 5)
    CreateFloatingButton("FloatTpLobbyBtn", "🏠 Teleport to Lobby", Color3.fromRGB(5, 150, 105), 5, function()
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            if not hrp then return end

            local lobbySpawn = Workspace:FindFirstChild("Lobby") or Workspace:FindFirstChild("SpawnLocation") or Workspace:FindFirstChild("Spawns")
            if lobbySpawn and lobbySpawn:IsA("BasePart") then
                hrp.CFrame = lobbySpawn.CFrame + Vector3.new(0, 5, 0)
            else
                hrp.CFrame = CFrame.new(0, 10, 0)
            end

            ShowNotification("🏠 Teleported to Lobby!")

            task.wait(0.05)
            if humanoid then
                humanoid.PlatformStand = false
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end)
    end)

    -- 6. SERVER HOP BUTTON (Order 6)
    CreateFloatingButton("FloatServerHopBtn", "🌐 Server Hop", Color3.fromRGB(217, 119, 6), 6, function()
        pcall(function()
            ShowNotification("🌐 Finding new server...")
            task.spawn(function()
                local servers = {}
                local req = pcall(function()
                    servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data
                end)
                if req and servers then
                    for _, s in ipairs(servers) do
                        if type(s) == "table" and s.maxPlayers and s.playing and s.playing < s.maxPlayers and s.id ~= game.JobId then
                            TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
                            return
                        end
                    end
                end
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            end)
        end)
    end)
end

LoginBtn.MouseButton1Click:Connect(function()
    if KeyTextBox.Text == "5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3" or KeyTextBox.Text == "HackedByKey2026" then
        KeySystemGui:Destroy()
        StartMainHub()
    else
        KeyTextBox.Text = ""
        KeyTextBox.PlaceholderText = "INVALID KEY!"
        task.wait(1.5)
        KeyTextBox.PlaceholderText = "Enter your license key..."
    end
end)
