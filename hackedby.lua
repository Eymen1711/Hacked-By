-- palofsc: Hacked By (Ultimate MM2 Edition - English)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

-- Global Variables
_G.FlightSpeed = 60
_G.RoleESP = false
_G.AutoGrabGun = false
_G.AntiTradeScam = false
_G.AutoFarm = false
_G.AutoNoclip = false
_G.FullBright = false
_G.KillAllActive = false

-- ==========================================
-- 0. BOTTOM LEFT FPS COUNTER
-- ==========================================
local FpsGui = Instance.new("ScreenGui")
FpsGui.Name = "HackedBy_FpsCounter"
FpsGui.Parent = CoreGui
FpsGui.ResetOnSpawn = false

local FpsToggleButton = Instance.new("TextButton", FpsGui)
FpsToggleButton.Size = UDim2.new(0, 120, 0, 32)
FpsToggleButton.Position = UDim2.new(0, 15, 1, -45)
FpsToggleButton.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
FpsToggleButton.TextColor3 = Color3.fromRGB(0, 255, 127)
FpsToggleButton.TextSize = 13
FpsToggleButton.Font = Enum.Font.GothamBold
FpsToggleButton.Text = "FPS: 60 [ON]"
FpsToggleButton.Active = true
FpsToggleButton.Draggable = true
Instance.new("UICorner", FpsToggleButton).CornerRadius = UDim.new(0, 8)
local FpsStroke = Instance.new("UIStroke", FpsToggleButton)
FpsStroke.Color = Color3.fromRGB(138, 43, 226)
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
KeyFrame.Size = UDim2.new(0, 380, 0, 280)
KeyFrame.Position = UDim2.new(0.5, -190, 0.5, -140)
KeyFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)

local KeyStroke = Instance.new("UIStroke", KeyFrame)
KeyStroke.Color = Color3.fromRGB(138, 43, 226)
KeyStroke.Thickness = 2

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 50)
KeyTitle.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
KeyTitle.Text = "🔒 Hacked By | Key System"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 16
KeyTitle.Font = Enum.Font.GothamBold
Instance.new("UICorner", KeyTitle).CornerRadius = UDim.new(0, 12)

local KeyTextBox = Instance.new("TextBox", KeyFrame)
KeyTextBox.Size = UDim2.new(0.85, 0, 0, 40)
KeyTextBox.Position = UDim2.new(0.075, 0, 0.25, 0)
KeyTextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
KeyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTextBox.PlaceholderText = "Enter your key here..."
KeyTextBox.Text = ""
KeyTextBox.TextSize = 14
Instance.new("UICorner", KeyTextBox).CornerRadius = UDim.new(0, 8)

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(0.85, 0, 0, 35)
GetKeyBtn.Position = UDim2.new(0.075, 0, 0.43, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
GetKeyBtn.Text = "🔗 Get Key (LootLabs)"
GetKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
GetKeyBtn.TextSize = 13
GetKeyBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 8)

GetKeyBtn.MouseButton1Click:Connect(function()
    local lootlabsUrl = "https://lootdest.org/s/CRVogxNA"
    pcall(function() setclipboard(lootlabsUrl) end)
    pcall(function() GuiService:OpenBrowserWindow(lootlabsUrl) end)
    GetKeyBtn.Text = "✔️ Link Copied & Opened!"
    task.wait(2)
    GetKeyBtn.Text = "🔗 Get Key (LootLabs)"
end)

local LoginBtn = Instance.new("TextButton", KeyFrame)
LoginBtn.Size = UDim2.new(0.85, 0, 0, 40)
LoginBtn.Position = UDim2.new(0.075, 0, 0.64, 0)
LoginBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
LoginBtn.Text = "Login"
LoginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoginBtn.TextSize = 15
LoginBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", LoginBtn).CornerRadius = UDim.new(0, 8)

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
    ToggleMainGuiBtn.Size = UDim2.new(0, 150, 0, 40)
    ToggleMainGuiBtn.Position = UDim2.new(0, 20, 0, 250)
    ToggleMainGuiBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    ToggleMainGuiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleMainGuiBtn.Text = "⚡ Hacked By Hub"
    ToggleMainGuiBtn.TextSize = 12
    ToggleMainGuiBtn.Font = Enum.Font.GothamBold
    ToggleMainGuiBtn.Active = true
    ToggleMainGuiBtn.Draggable = true
    Instance.new("UICorner", ToggleMainGuiBtn).CornerRadius = UDim.new(0, 8)

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
    MainFrame.Size = UDim2.new(0, 450, 0, 450)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Visible = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

    ToggleMainGuiBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(138, 43, 226)
    MainStroke.Thickness = 2

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = MainFrame
    TitleLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    TitleLabel.Size = UDim2.new(1, 0, 0, 50)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = "⚡ Hacked By - Murder Mystery 2"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 15
    Instance.new("UICorner", TitleLabel).CornerRadius = UDim.new(0, 14)

    local TabContainer = Instance.new("Frame", MainFrame)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 10, 0, 58)
    TabContainer.Size = UDim2.new(1, -20, 0, 35)

    local TabListLayout = Instance.new("UIListLayout", TabContainer)
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.Padding = UDim.new(0, 10)

    local function CreateTabButton(name, index)
        local btn = Instance.new("TextButton", TabContainer)
        btn.Size = UDim2.new(0.48, 0, 1, 0)
        btn.BackgroundColor3 = index == 1 and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(25, 25, 35)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 13
        btn.Font = Enum.Font.GothamBold
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        return btn
    end

    local Tab1Btn = CreateTabButton("Main Features", 1)
    local Tab2Btn = CreateTabButton("Combat & Movement", 2)

    local PageContainer = Instance.new("Frame", MainFrame)
    PageContainer.BackgroundTransparency = 1
    PageContainer.Position = UDim2.new(0, 10, 0, 100)
    PageContainer.Size = UDim2.new(1, -20, 1, -110)

    local function CreateScrollingPage()
        local sf = Instance.new("ScrollingFrame", PageContainer)
        sf.BackgroundTransparency = 1
        sf.Size = UDim2.new(1, 0, 1, 0)
        sf.CanvasSize = UDim2.new(0, 0, 2.5, 0)
        sf.ScrollBarThickness = 4
        sf.Visible = false
        local layout = Instance.new("UIListLayout", sf)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 10)
        return sf
    end

    local Page1 = CreateScrollingPage()
    local Page2 = CreateScrollingPage()
    Page1.Visible = true

    Tab1Btn.MouseButton1Click:Connect(function()
        Page1.Visible, Page2.Visible = true, false
        Tab1Btn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        Tab2Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    end)

    Tab2Btn.MouseButton1Click:Connect(function()
        Page1.Visible, Page2.Visible = false, true
        Tab1Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Tab2Btn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    end)

    local function CreateToggle(parent, name, callback)
        local Button = Instance.new("TextButton")
        Button.Parent = parent
        Button.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Button.Size = UDim2.new(1, 0, 0, 42)
        Button.Font = Enum.Font.GothamSemibold
        Button.Text = name .. " : [OFF]"
        Button.TextColor3 = Color3.fromRGB(200, 200, 200)
        Button.TextSize = 13
        Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)
        
        local toggled = false
        Button.MouseButton1Click:Connect(function()
            toggled = not toggled
            if toggled then
                Button.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.Text = name .. " : [ON]"
            else
                Button.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                Button.TextColor3 = Color3.fromRGB(200, 200, 200)
                Button.Text = name .. " : [OFF]"
            end
            pcall(function() callback(toggled) end)
        end)
    end

    local function CreateSlider(parent, name, min, max, default, callback)
        local Frame = Instance.new("Frame", parent)
        Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Frame.Size = UDim2.new(1, 0, 0, 55)
        Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

        local Label = Instance.new("TextLabel", Frame)
        Label.BackgroundTransparency = 1
        Label.Position = UDim2.new(0, 10, 0, 5)
        Label.Size = UDim2.new(1, -20, 0, 20)
        Label.Font = Enum.Font.GothamBold
        Label.Text = name .. ": " .. default
        Label.TextColor3 = Color3.fromRGB(220, 220, 220)
        Label.TextSize = 13
        Label.TextXAlignment = Enum.TextXAlignment.Left

        local SliderBar = Instance.new("TextButton", Frame)
        SliderBar.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        SliderBar.Position = UDim2.new(0, 10, 0, 32)
        SliderBar.Size = UDim2.new(1, -20, 0, 12)
        SliderBar.Text = ""
        Instance.new("UICorner", SliderBar).CornerRadius = UDim.new(0, 6)

        local Fill = Instance.new("Frame", SliderBar)
        Fill.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        Instance.new("UICorner", Fill).CornerRadius = UDim.new(0, 6)

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
                    if hasK then hl.FillColor = Color3.fromRGB(255, 0, 0)
                    elseif hasG then hl.FillColor = Color3.fromRGB(0, 0, 255)
                    else hl.FillColor = Color3.fromRGB(0, 255, 0) end
                end
            end
        end)
    end)

    local NotificationLabel = Instance.new("TextLabel", ScreenGui)
    NotificationLabel.Name = "NotificationLabel"
    NotificationLabel.Size = UDim2.new(0, 350, 0, 40)
    NotificationLabel.Position = UDim2.new(0.5, -175, 0, 15)
    NotificationLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    NotificationLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
    NotificationLabel.TextSize = 13
    NotificationLabel.Font = Enum.Font.GothamBold
    NotificationLabel.Text = ""
    NotificationLabel.Visible = false
    Instance.new("UICorner", NotificationLabel).CornerRadius = UDim.new(0, 8)
    local notifStroke = Instance.new("UIStroke", NotificationLabel)
    notifStroke.Color = Color3.fromRGB(255, 60, 60)
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

    CreateToggle(Page1, "Anti Trade Scam", function(state)
        _G.AntiTradeScam = state
        ShowNotification(_G.AntiTradeScam and "🛡️ Anti Trade Scam Enabled!" or "❌ Anti Trade Scam Disabled")
        
        task.spawn(function()
            while _G.AntiTradeScam do
                task.wait(0.5)
                pcall(function()
                    local tradeGui = PlayerGui:FindFirstChild("TradeGui") or PlayerGui:FindFirstChild("Trade")
                    if tradeGui and tradeGui.Enabled then
                        ShowNotification("⚠️ Warning: Trade is active! Watch out for sudden item swaps!")
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
                    if not foundCoin then
                        for _, containerName in ipairs({"CoinContainer", "Coins", "MapCoins", "EventContainer"}) do
                            local container = Workspace:FindFirstChild(containerName)
                            if container then
                                for _, obj in ipairs(container:GetChildren()) do
                                    if not _G.AutoFarm then break end
                                    if obj:IsA("BasePart") then
                                        SmoothFlyTo(obj.CFrame + Vector3.new(0, 1.8, 0))
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
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

    CreateToggle(Page2, "Kill All (As Murderer)", function(state)
        _G.KillAllActive = state
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
    end)

    -- ==========================================
    -- 3. FLOATING ACTION BUTTONS
    -- ==========================================

    -- SHOOT MURDER BUTTON
    local FloatShootBtn = Instance.new("TextButton", ScreenGui)
    FloatShootBtn.Name = "FloatShootBtn"
    FloatShootBtn.Size = UDim2.new(0, 160, 0, 40)
    FloatShootBtn.Position = UDim2.new(0, 20, 0, 20)
    FloatShootBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    FloatShootBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FloatShootBtn.Text = "🎯 SHOOT MURDER"
    FloatShootBtn.TextSize = 12
    FloatShootBtn.Font = Enum.Font.GothamBold
    FloatShootBtn.Active = true
    FloatShootBtn.Draggable = true
    Instance.new("UICorner", FloatShootBtn).CornerRadius = UDim.new(0, 8)

    FloatShootBtn.MouseButton1Click:Connect(function()
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
                    
                    if hasKnife or (highlight and highlight.FillColor == Color3.fromRGB(255, 0, 0)) then
                        murdererTarget = pChar
                        break
                    end
                end
            end

            if murdererTarget and murdererTarget:FindFirstChild("HumanoidRootPart") then
                local mHrp = murdererTarget.HumanoidRootPart
                local _, inViewport = Camera:WorldToViewportPoint(mHrp.Position)
                local rayParams = RaycastParams.new()
                rayParams.FilterDescendantsInstances = {char, murdererTarget}
                rayParams.FilterType = Enum.RaycastFilterType.Exclude
                local rayResult = Workspace:Raycast(Camera.CFrame.Position, (mHrp.Position - Camera.CFrame.Position), rayParams)
                
                if inViewport and not rayResult then
                    if gun and gun:FindFirstChild("ShootGun") then
                        gun.ShootGun:FireServer(1, mHrp.Position, "AH")
                    end

                    for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
                        if remote:IsA("RemoteEvent") then
                            local rName = remote.Name:lower()
                            if string.find(rName, "shoot") or string.find(rName, "gun") or string.find(rName, "fire") then
                                remote:FireServer(mHrp.Position)
                            end
                        end
                    end

                    if gun and gun:FindFirstChild("Activate") then
                        pcall(function() gun:Activate() end)
                    end
                else
                    ShowNotification("Murderer is not in your field of view!")
                end
            else
                ShowNotification("Murderer not found!")
            end
        end)
    end)

    -- TELEPORT TO MAP BUTTON
    local FloatTpMapBtn = Instance.new("TextButton", ScreenGui)
    FloatTpMapBtn.Name = "FloatTpMapBtn"
    FloatTpMapBtn.Size = UDim2.new(0, 160, 0, 40)
    FloatTpMapBtn.Position = UDim2.new(0, 20, 0, 70)
    FloatTpMapBtn.BackgroundColor3 = Color3.fromRGB(41, 128, 185)
    FloatTpMapBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FloatTpMapBtn.Text = "🗺️ Teleport to Map"
    FloatTpMapBtn.TextSize = 12
    FloatTpMapBtn.Font = Enum.Font.GothamBold
    FloatTpMapBtn.Active = true
    FloatTpMapBtn.Draggable = true
    Instance.new("UICorner", FloatTpMapBtn).CornerRadius = UDim.new(0, 8)

    FloatTpMapBtn.MouseButton1Click:Connect(function()
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
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    p.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end
            end
        end)
    end)

    -- TELEPORT TO LOBBY BUTTON
    local FloatTpLobbyBtn = Instance.new("TextButton", ScreenGui)
    FloatTpLobbyBtn.Name = "FloatTpLobbyBtn"
    FloatTpLobbyBtn.Size = UDim2.new(0, 160, 0, 40)
    FloatTpLobbyBtn.Position = UDim2.new(0, 20, 0, 120)
    FloatTpLobbyBtn.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
    FloatTpLobbyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FloatTpLobbyBtn.Text = "🏠 Teleport to Lobby"
    FloatTpLobbyBtn.TextSize = 12
    FloatTpLobbyBtn.Font = Enum.Font.GothamBold
    FloatTpLobbyBtn.Active = true
    FloatTpLobbyBtn.Draggable = true
    Instance.new("UICorner", FloatTpLobbyBtn).CornerRadius = UDim.new(0, 8)

    FloatTpLobbyBtn.MouseButton1Click:Connect(function()
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
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    p.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end
            end
        end)
    end)
end

LoginBtn.MouseButton1Click:Connect(function()
    if KeyTextBox.Text == "5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3" or KeyTextBox.Text == "HackedByKey2026" then
        KeySystemGui:Destroy()
        StartMainHub()
    else
        KeyTextBox.Text = ""
        KeyTextBox.PlaceholderText = "WRONG KEY!"
        task.wait(1.5)
        KeyTextBox.PlaceholderText = "Enter your key here..."
    end
end)
