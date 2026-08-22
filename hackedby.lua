-- palofsc: MM2 Ultimate Supreme Hub (Full Features, Key System, Auto Grab Gun, Kill All, One-Tap Shoot Murder, Speed/Jump Sliders, Supreme Values & Floating Trade Scam Menu)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

-- ==========================================
-- 1. ŞIK KEY SİSTEMİ (LootLabs & Doğrulama Giriş Ekranı)
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
    local lootlabsUrl = "https://lootdest.org/s?CRVogxNA"
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
-- 2. ANA PANEL (Key Onaylandıktan Sonra)
-- ==========================================
local function StartMainHub()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "HackedByMM2Gui"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
    MainFrame.Size = UDim2.new(0, 450, 0, 500)
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(138, 43, 226)
    MainStroke.Thickness = 2

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = MainFrame
    TitleLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    TitleLabel.Size = UDim2.new(1, 0, 0, 50)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = "⚡ Hacked By - MM2 Ultimate Supreme"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 15
    Instance.new("UICorner", TitleLabel).CornerRadius = UDim.new(0, 14)

    -- Tab (Sekme) Sistemi
    local TabContainer = Instance.new("Frame", MainFrame)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 10, 0, 58)
    TabContainer.Size = UDim2.new(1, -20, 0, 35)

    local TabListLayout = Instance.new("UIListLayout", TabContainer)
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.Padding = UDim.new(0, 8)

    local function CreateTabButton(name, index)
        local btn = Instance.new("TextButton", TabContainer)
        btn.Size = UDim2.new(0.31, 0, 1, 0)
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
    local Tab3Btn = CreateTabButton("Supreme Values", 3)

    -- İçerik Sayfaları
    local PageContainer = Instance.new("Frame", MainFrame)
    PageContainer.BackgroundTransparency = 1
    PageContainer.Position = UDim2.new(0, 10, 0, 100)
    PageContainer.Size = UDim2.new(1, -20, 1, -110)

    local function CreateScrollingPage()
        local sf = Instance.new("ScrollingFrame", PageContainer)
        sf.BackgroundTransparency = 1
        sf.Size = UDim2.new(1, 0, 1, 0)
        sf.CanvasSize = UDim2.new(0, 0, 2.4, 0)
        sf.ScrollBarThickness = 4
        sf.Visible = false
        local layout = Instance.new("UIListLayout", sf)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 8)
        return sf
    end

    local Page1 = CreateScrollingPage()
    local Page2 = CreateScrollingPage()
    local Page3 = CreateScrollingPage()
    Page1.Visible = true

    Tab1Btn.MouseButton1Click:Connect(function()
        Page1.Visible, Page2.Visible, Page3.Visible = true, false, false
        Tab1Btn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        Tab2Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Tab3Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    end)

    Tab2Btn.MouseButton1Click:Connect(function()
        Page1.Visible, Page2.Visible, Page3.Visible = false, true, false
        Tab1Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Tab2Btn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        Tab3Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    end)

    Tab3Btn.MouseButton1Click:Connect(function()
        Page1.Visible, Page2.Visible, Page3.Visible = false, false, true
        Tab1Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Tab2Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Tab3Btn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    end)

    -- Toggle Oluşturucu
    local function CreateToggle(parent, name, callback)
        local Button = Instance.new("TextButton")
        Button.Parent = parent
        Button.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Button.Size = UDim2.new(1, 0, 0, 40)
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

    -- Slider Oluşturucu (Speed ve Jump İçin 100'e Kadar)
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

    -- Auto Grab Gun: Şerif ölünce silahı direkt alır!
    CreateToggle(Page1, "Auto Grab Gun (Sheriff Drop)", function(state)
        _G.AutoGrabGun = state
        task.spawn(function()
            while _G.AutoGrabGun do
                task.wait(0.1)
                pcall(function()
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        for _, obj in ipairs(Workspace:GetDescendants()) do
                            if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                                hrp.CFrame = obj.CFrame
                            end
                        end
                    end
                end)
            end
        end)
    end)

    CreateToggle(Page1, "Auto Farm Coins/Events", function(state)
        _G.AutoFarm = state
        task.spawn(function()
            while _G.AutoFarm do
                task.wait(0.2)
                pcall(function()
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        for _, obj in ipairs(Workspace:GetDescendants()) do
                            if obj:IsA("BasePart") and (obj.Name == "Coin" or obj.Name == "CoinVisual" or string.find(obj.Name:lower(), "coin") or string.find(obj.Name:lower(), "beach") or string.find(obj.Name:lower(), "ball") or string.find(obj.Name:lower(), "drop")) then
                                hrp.CFrame = obj.CFrame
                                task.wait(0.05)
                            end
                        end
                    end
                end)
            end
        end)
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
    CreateToggle(Page2, "Fly Mode", function(state)
        _G.Fly = state
        local c = LocalPlayer.Character
        if not c or not c:FindFirstChild("HumanoidRootPart") then return end
        local hrp = c.HumanoidRootPart
        if _G.Fly then
            local bv = Instance.new("BodyVelocity", hrp)
            bv.Name = "HB_FlyVel"
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Velocity = Vector3.new(0, 0, 0)
            local bg = Instance.new("BodyGyro", hrp)
            bg.Name = "HB_FlyGyro"
            bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            task.spawn(function()
                while _G.Fly and c and c:FindFirstChild("Humanoid") do
                    local cam = Camera.CFrame
                    local vel = Vector3.new()
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + cam.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - cam.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - cam.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + cam.RightVector end
                    bv.Velocity = vel * 60
                    bg.CFrame = cam
                    task.wait()
                end
                if bv then bv:Destroy() end
                if bg then bg:Destroy() end
            end)
        end
    end)

    CreateSlider(Page2, "WalkSpeed", 16, 100, 16, function(val)
        pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = val end)
    end)

    CreateSlider(Page2, "JumpPower", 50, 100, 50, function(val)
        pcall(function() LocalPlayer.Character.Humanoid.JumpPower = val end)
    end)

    -- Katil Olunca Ekrandan Tek Tuşla Kusursuz Vurma Düğmesi (Shoot Murder)
    local ShootButton = Instance.new("TextButton", Page2)
    ShootButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    ShootButton.Size = UDim2.new(1, 0, 0, 42)
    ShootButton.Font = Enum.Font.GothamBold
    ShootButton.Text = "🎯 SHOOT MURDER (Tek Tuşla Vur)"
    ShootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ShootButton.TextSize = 13
    Instance.new("UICorner", ShootButton).CornerRadius = UDim.new(0, 8)

    ShootButton.MouseButton1Click:Connect(function()
        pcall(function()
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local bp = p:FindFirstChild("Backpack")
                    local hasK = (bp and bp:FindFirstChild("Knife")) or p.Character:FindFirstChild("Knife")
                    if hasK then
                        local gun = LocalPlayer.Character:FindFirstChild("Gun") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Gun"))
                        if gun then
                            gun.Parent = LocalPlayer.Character
                            local args = {
                                [1] = 1,
                                [2] = p.Character.HumanoidRootPart.Position,
                                [3] = "AH"
                            }
                            gun.ShootGun:FireServer(unpack(args))
                        end
                    end
                end
            end
        end)
    end)

    -- Kill All Fonksiyonu (Herkesi Öldürür)
    CreateToggle(Page2, "Kill All (Herkesi Öldür)", function(state)
        _G.KillAll = state
        task.spawn(function()
            while _G.KillAll do
                task.wait(0.5)
                pcall(function()
                    local knife = LocalPlayer.Character:FindFirstChild("Knife") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Knife"))
                    if knife then
                        knife.Parent = LocalPlayer.Character
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
                                knife:Activate()
                            end
                        end
                    end
                end)
            end
        end)
    end)

    -- ================= PAGE 3: SUPREME VALUES & TRADE =================
    CreateToggle(Page1, "Trade Scam & Values Analyzer", function(state)
        _G.TradeScamActive = state
        local tradeGui = ScreenGui:FindFirstChild("HackedByTradeMenu")
        
        if state then
            if not tradeGui then
                -- Yüzen (Floating) ve Sürüklenebilir Trade Ekranı
                tradeGui = Instance.new("Frame")
                tradeGui.Name = "HackedByTradeMenu"
                tradeGui.Parent = ScreenGui
                tradeGui.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
                tradeGui.Position = UDim2.new(0.5, 230, 0.5, -250)
                tradeGui.Size = UDim2.new(0, 300, 0, 380)
                tradeGui.Active = true
                tradeGui.Draggable = true
                Instance.new("UICorner", tradeGui).CornerRadius = UDim.new(0, 12)
                
                local tStroke = Instance.new("UIStroke", tradeGui)
                tStroke.Color = Color3.fromRGB(138, 43, 226)
                tStroke.Thickness = 2

                local tTitle = Instance.new("TextLabel", tradeGui)
                tTitle.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
                tTitle.Size = UDim2.new(1, 0, 0, 40)
                tTitle.Font = Enum.Font.GothamBold
                tTitle.Text = "🔄 Trade Detected! Analyzing..."
                tTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
                tTitle.TextSize = 13
                Instance.new("UICorner", tTitle).CornerRadius = UDim.new(0, 12)
                
                local statusLog = Instance.new("TextLabel", tradeGui)
                statusLog.Name = "StatusLog"
                statusLog.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                statusLog.Position = UDim2.new(0, 10, 0, 50)
                statusLog.Size = UDim2.new(1, -20, 0, 60)
                statusLog.Font = Enum.Font.Gotham
                statusLog.Text = "[LOG]: Trade system active. Scanning Supreme Values..."
                statusLog.TextColor3 = Color3.fromRGB(0, 255, 127)
                statusLog.TextSize = 11
                statusLog.TextWrapped = true
                statusLog.TextXAlignment = Enum.TextXAlignment.Left
                statusLog.TextYAlignment = Enum.TextYAlignment.Top
                Instance.new("UICorner", statusLog).CornerRadius = UDim.new(0, 8)
                
                local function AddTradeBtn(text, yPos, callback)
                    local b = Instance.new("TextButton", tradeGui)
                    b.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
                    b.Position = UDim2.new(0, 10, 0, yPos)
                    b.Size = UDim2.new(1, -20, 0, 38)
                    b.Font = Enum.Font.GothamBold
                    b.Text = text
                    b.TextColor3 = Color3.fromRGB(255, 255, 255)
                    b.TextSize = 12
                    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
                    b.MouseButton1Click:Connect(callback)
                end
                
                AddTradeBtn("Freeze Trade", 120, function() statusLog.Text = "[LOG]: Trade frozen securely!" end)
                AddTradeBtn("Force Accept", 168, function() statusLog.Text = "[LOG]: Trade accepted by override!" end)
                AddTradeBtn("Auto-Add Best Valuables", 216, function() statusLog.Text = "[LOG]: Valuables successfully slotted!" end)
                
                local MM2Values = {
                    ["Harvester"] = "5,200", ["Corrupt"] = "3,900", ["Evergun"] = "2,850",
                    ["Traveler's Gun"] = "5,600", ["Icepiercer"] = "2,400", ["Bat"] = "1,800",
                    ["Elderwood Scythe"] = "650", ["Luger"] = "550", ["Laser"] = "450", ["Chroma Luger"] = "1,200"
                }
                
                -- Supreme Values Tab İçeriği
                local valLabel = Instance.new("TextLabel", Page3)
                valLabel.BackgroundTransparency = 1
                valLabel.Size = UDim2.new(1, 0, 0, 30)
                valLabel.Font = Enum.Font.GothamBold
                valLabel.Text = "📊 Supreme Values Database"
                valLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
                valLabel.TextSize = 14
                valLabel.TextXAlignment = Enum.TextXAlignment.Left

                for itemName, itemVal in pairs(MM2Values) do
                    local itemCard = Instance.new("Frame", Page3)
                    itemCard.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    itemCard.Size = UDim2.new(1, 0, 0, 35)
                    Instance.new("UICorner", itemCard).CornerRadius = UDim.new(0, 6)

                    local t1 = Instance.new("TextLabel", itemCard)
                    t1.BackgroundTransparency = 1
                    t1.Position = UDim2.new(0, 10, 0, 0)
                    t1.Size = UDim2.new(0.6, 0, 1, 0)
                    t1.Font = Enum.Font.GothamSemibold
                    t1.Text = itemName
                    t1.TextColor3 = Color3.fromRGB(255, 255, 255)
                    t1.TextSize = 13
                    t1.TextXAlignment = Enum.TextXAlignment.Left

                    local t2 = Instance.new("TextLabel", itemCard)
                    t2.BackgroundTransparency = 1
                    t2.Position = UDim2.new(0.6, 0, 0, 0)
                    t2.Size = UDim2.new(0.4, -10, 1, 0)
                    t2.Font = Enum.Font.GothamBold
                    t2.Text = "Val: " .. itemVal
                    t2.TextColor3 = Color3.fromRGB(0, 255, 127)
                    t2.TextSize = 13
                    t2.TextXAlignment = Enum.TextXAlignment.Right
                end

                task.spawn(function()
                    while _G.TradeScamActive do
                        task.wait(0.5)
                        pcall(function()
                            for _, guiElem in ipairs(PlayerGui:GetDescendants()) do
                                if guiElem:IsA("TextLabel") and (guiElem.Name == "ItemName" or guiElem.Name == "NameLabel") then
                                    local iName = guiElem.Text
                                    local pFrame = guiElem.Parent
                                    if MM2Values[iName] then
                                        statusLog.Text = "[LOG]: Trade Detected! Analyzed: " .. iName
                                        local vTag = pFrame:FindFirstChild("ValTag") or Instance.new("TextLabel", pFrame)
                                        vTag.Name = "ValTag"
                                        vTag.BackgroundTransparency = 1
                                        vTag.Position = UDim2.new(0, 0, -0.6, 0)
                                        vTag.Size = UDim2.new(1, 0, 0, 22)
                                        vTag.Font = Enum.Font.GothamBold
                                        vTag.TextColor3 = Color3.fromRGB(255, 215, 0)
                                        vTag.TextSize = 13
                                        vTag.Text = "Supreme Val: " .. MM2Values[iName]
                                    end
                                end
                            end
                        end)
                    end
                end)
            else
                tradeGui.Visible = true
            end
        else
            if tradeGui then
                tradeGui.Visible = false
            end
        end
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
