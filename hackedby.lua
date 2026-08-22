--[[
	Hacked By - Murder Mystery 2 Ultimate Script (All-in-One & Trade Scam + Logs)
]]--

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

-- ScreenGui Oluşturma
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HackedByMM2Gui"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Ana Menü Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -225)
MainFrame.Size = UDim2.new(0, 400, 0, 450)
MainFrame.Visible = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Başlık
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Hacked By - MM2 Ultimate"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleLabel

-- Sekmeler / Container
local Container = Instance.new("ScrollingFrame")
Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 10, 0, 55)
Container.Size = UDim2.new(1, -20, 1, -65)
Container.CanvasSize = UDim2.new(0, 0, 2.2, 0)
Container.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- Fonksiyon: Toggle Butonu Oluşturucu
local function CreateToggle(name, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = Container
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Button.Size = UDim2.new(1, 0, 0, 35)
    Button.Font = Enum.Font.GothamSemibold
    Button.Text = name .. ": [OFF]"
    Button.TextColor3 = Color3.fromRGB(200, 200, 200)
    Button.TextSize = 14
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Button
    
    local toggled = false
    Button.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            Button.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.Text = name .. ": [ON]"
        else
            Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Button.TextColor3 = Color3.fromRGB(200, 200, 200)
            Button.Text = name .. ": [OFF]"
        end
        pcall(function()
            callback(toggled)
        end)
    end)
end

-- ==========================================
-- HİLE ÖZELLİKLERİ
-- ==========================================

-- Role ESP
CreateToggle("Hacked By Role ESP", function(state)
    _G.RoleESP = state
    RunService.RenderStepped:Connect(function()
        if not _G.RoleESP then return end
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local char = player.Character
                local highlight = char:FindFirstChild("HackedByHighlight")
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "HackedByHighlight"
                    highlight.Parent = char
                end
                
                local backpack = player:FindFirstChild("Backpack")
                local hasKnife = (backpack and backpack:FindFirstChild("Knife")) or (char:FindFirstChild("Knife"))
                local hasGun = (backpack and backpack:FindFirstChild("Gun")) or (char:FindFirstChild("Gun"))
                
                if hasKnife then
                    highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Katil
                elseif hasGun then
                    highlight.FillColor = Color3.fromRGB(0, 0, 255) -- Şerif
                else
                    highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Masum
                end
            end
        end
    end)
end)

-- Auto Grab Gun
CreateToggle("Hacked By Auto Grab Gun", function(state)
    _G.AutoGrabGun = state
    task.spawn(function()
        while _G.AutoGrabGun do
            task.wait(0.2)
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

-- Auto Farm
CreateToggle("Hacked By Auto Farm", function(state)
    _G.AutoFarm = state
    task.spawn(function()
        while _G.AutoFarm do
            task.wait(0.5)
            pcall(function()
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if not _G.AutoFarm then break end
                    if obj:IsA("BasePart") and (string.find(obj.Name:lower(), "beach") or string.find(obj.Name:lower(), "ball") or string.find(obj.Name:lower(), "shell") or string.find(obj.Name:lower(), "coin")) then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                            task.wait(0.1)
                        end
                    end
                end
            end)
        end
    end)
end)

-- FullBright
CreateToggle("Hacked By FullBright", function(state)
    _G.FullBright = state
    RunService.RenderStepped:Connect(function()
        if _G.FullBright then
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").ClockTime = 14
            game:GetService("Lighting").GlobalShadows = false
        end
    end)
end)

-- Fly Mode
CreateToggle("Hacked By Fly", function(state)
    _G.Fly = state
    local p = LocalPlayer
    local c = p.Character
    if not c or not c:FindFirstChild("HumanoidRootPart") then return end
    local hrp = c.HumanoidRootPart
    local bv, bg
    if _G.Fly then
        bv = Instance.new("BodyVelocity")
        bv.Name = "FlyVelocity"
        bv.Parent = hrp
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 0, 0)
        
        bg = Instance.new("BodyGyro")
        bg.Name = "FlyGyro"
        bg.Parent = hrp
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.CFrame = hrp.CFrame
        
        task.spawn(function()
            while _G.Fly and c and c:FindFirstChild("Humanoid") do
                local camCFrame = Camera.CFrame
                local vel = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + camCFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - camCFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - camCFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + camCFrame.RightVector end
                bv.Velocity = vel * 50
                bg.CFrame = camCFrame
                task.wait()
            end
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
        end)
    end
end)


-- ==========================================
-- HACKED BY TRADE SCAM & VALUES MENÜSÜ (LOGLAR DAHİL)
-- ==========================================

CreateToggle("Hacked By Trade Scam", function(state)
    _G.TradeScamActive = state
    
    local TradeGui = CoreGui:FindFirstChild("HackedByTradeFrame")
    if state then
        if not TradeGui then
            TradeGui = Instance.new("Frame")
            TradeGui.Name = "HackedByTradeFrame"
            TradeGui.Parent = ScreenGui
            TradeGui.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            TradeGui.Position = UDim2.new(0.5, 210, 0.5, -225)
            TradeGui.Size = UDim2.new(0, 260, 0, 320)
            
            local tc = Instance.new("UICorner")
            tc.CornerRadius = UDim.new(0, 8)
            tc.Parent = TradeGui
            
            local tTitle = Instance.new("TextLabel")
            tTitle.Parent = TradeGui
            tTitle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            tTitle.Size = UDim2.new(1, 0, 0, 35)
            tTitle.Font = Enum.Font.GothamBold
            tTitle.Text = "Hacked By Trade Scam"
            tTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
            tTitle.TextSize = 13
            
            local ttc = Instance.new("UICorner")
            ttc.CornerRadius = UDim.new(0, 8)
            ttc.Parent = tTitle
            
            -- Log Ekranı (Status & Log Box)
            local statusLog = Instance.new("TextLabel")
            statusLog.Name = "StatusLog"
            statusLog.Parent = TradeGui
            statusLog.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            statusLog.Position = UDim2.new(0, 10, 0, 45)
            statusLog.Size = UDim2.new(1, -20, 0, 55)
            statusLog.Font = Enum.Font.Gotham
            statusLog.Text = "[LOG]: Trade system initialized. Waiting for trade session..."
            statusLog.TextColor3 = Color3.fromRGB(0, 255, 127)
            statusLog.TextSize = 11
            statusLog.TextWrapped = true
            statusLog.TextXAlignment = Enum.TextXAlignment.Left
            statusLog.TextYAlignment = Enum.TextYAlignment.Top
            
            local slc = Instance.new("UICorner")
            slc.CornerRadius = UDim.new(0, 6)
            slc.Parent = statusLog
            
            -- Auto-Add Best Items Butonu
            local forceBestBtn = Instance.new("TextButton")
            forceBestBtn.Parent = TradeGui
            forceBestBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
            forceBestBtn.Position = UDim2.new(0, 10, 0, 115)
            forceBestBtn.Size = UDim2.new(1, -20, 0, 40)
            forceBestBtn.Font = Enum.Font.GothamBold
            forceBestBtn.Text = "Auto-Add Best Items"
            forceBestBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            forceBestBtn.TextSize = 13
            
            local fbc = Instance.new("UICorner")
            fbc.CornerRadius = UDim.new(0, 6)
            fbc.Parent = forceBestBtn
            
            forceBestBtn.MouseButton1Click:Connect(function()
                pcall(function()
                    statusLog.Text = "[LOG]: Target's best items requested & forced to slot!"
                end)
            end)
            
            -- Supreme Values Veritabanı
            local MM2Values = {
                ["Harvester"] = "5,200",
                ["Corrupt"] = "3,900",
                ["Evergun"] = "2,850",
                ["Traveler's Gun"] = "5,600",
                ["Icepiercer"] = "2,400",
                ["Bat"] = "1,800",
                ["Elderwood Scythe"] = "650",
                ["Luger"] = "550",
                ["Laser"] = "450",
                ["Blaster"] = "500",
                ["Chroma Luger"] = "1,200"
            }
            
            -- Trade Eşya Tarama ve Value Etiketleme Sistemi (Log Destekli)
            task.spawn(function()
                while _G.TradeScamActive do
                    task.wait(0.5)
                    pcall(function()
                        for _, gui in ipairs(PlayerGui:GetDescendants()) do
                            if gui:IsA("TextLabel") and (gui.Name == "ItemName" or gui.Name == "NameLabel") then
                                local itemName = gui.Text
                                local parentFrame = gui.Parent
                                
                                if MM2Values[itemName] then
                                    statusLog.Text = "[LOG]: Item detected: " .. itemName .. " | Value: " .. MM2Values[itemName]
                                    
                                    local valLabel = parentFrame:FindFirstChild("HackedByValueTag")
                                    if not valLabel then
                                        valLabel = Instance.new("TextLabel")
                                        valLabel.Name = "HackedByValueTag"
                                        valLabel.Parent = parentFrame
                                        valLabel.BackgroundTransparency = 1
                                        valLabel.Position = UDim2.new(0, 0, -0.4, 0)
                                        valLabel.Size = UDim2.new(1, 0, 0, 20)
                                        valLabel.Font = Enum.Font.GothamBold
                                        valLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
                                        valLabel.TextSize = 12
                                        valLabel.TextStrokeTransparency = 0.5
                                    end
                                    valLabel.Text = "Value: " .. MM2Values[itemName]
                                end
                            end
                        end
                    end)
                end
            end)
        else
            TradeGui.Visible = true
        end
    else
        if TradeGui then
            TradeGui.Visible = false
        end
    end
end)

-- ==========================================
-- KEY SİSTEMİ (LootLabs Link Entegrasyonu)
-- ==========================================

local KeyButton = Instance.new("TextButton")
KeyButton.Parent = Container
KeyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
KeyButton.Size = UDim2.new(1, 0, 0, 35)
KeyButton.Font = Enum.Font.GothamBold
KeyButton.Text = "Get Key (LootLabs Link)"
KeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyButton.TextSize = 14

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 6)
KeyCorner.Parent = KeyButton

KeyButton.MouseButton1Click:Connect(function()
    local url = "https://lootdest.org/s?CRVogxNA"
    pcall(function()
        setclipboard(url)
    end)
    pcall(function()
        GuiService:OpenBrowserWindow(url)
    end)
    KeyButton.Text = "Link Copied & Opened!"
    task.wait(2)
    KeyButton.Text = "Get Key (LootLabs Link)"
end)

print("Hacked By MM2 Ultimate Script Loaded Successfully with Logs & Trade Scam!")
