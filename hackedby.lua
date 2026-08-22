-- ==========================================
-- HACKED BY | MM2 ULTIMATE SCRIPT (FIXED)
-- ==========================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

-- ==========================================
-- 1. KEY SİSTEMİ (LootLabs & Doğrulama)
-- ==========================================
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "HackedBy_KeySystem"
keyGui.ResetOnSpawn = false
pcall(function() keyGui.Parent = CoreGui end)
if not keyGui.Parent then pcall(function() keyGui.Parent = PlayerGui end) end

local keyFrame = Instance.new("Frame", keyGui)
keyFrame.Size = UDim2.new(0, 360, 0, 260)
keyFrame.Position = UDim2.new(0.5, -180, 0.5, -130)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
keyFrame.Active = true
keyFrame.Draggable = true
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 10)

local kStroke = Instance.new("UIStroke", keyFrame)
kStroke.Color = Color3.fromRGB(255, 50, 50)
kStroke.Thickness = 2

local kTitle = Instance.new("TextLabel", keyFrame)
kTitle.Size = UDim2.new(1, 0, 0, 45)
kTitle.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
kTitle.Text = "Hacked By | Key System"
kTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
kTitle.TextSize = 16
kTitle.Font = Enum.Font.GothamBold
Instance.new("UICorner", kTitle).CornerRadius = UDim.new(0, 10)

local textBox = Instance.new("TextBox", keyFrame)
textBox.Size = UDim2.new(0.85, 0, 0, 38)
textBox.Position = UDim2.new(0.075, 0, 0.22, 0)
textBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "Anahtarı buraya gir..."
textBox.Text = ""
textBox.TextSize = 14
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

local linkBtn = Instance.new("TextButton", keyFrame)
linkBtn.Size = UDim2.new(0.85, 0, 0, 32)
linkBtn.Position = UDim2.new(0.075, 0, 0.40, 0)
linkBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
linkBtn.Text = "🔗 Get Key (LootLabs)"
linkBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
linkBtn.TextSize = 12
linkBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", linkBtn).CornerRadius = UDim.new(0, 6)

linkBtn.MouseButton1Click:Connect(function()
    local lootlabsUrl = "https://lootdest.org/s?CRVogxNA"
    pcall(function() setclipboard(lootlabsUrl) end)
    pcall(function() GuiService:OpenBrowserWindow(lootlabsUrl) end)
    linkBtn.Text = "✔️ Link Açıldı / Kopyalandı!"
    task.wait(2)
    linkBtn.Text = "🔗 Get Key (LootLabs)"
end)

local loginBtn = Instance.new("TextButton", keyFrame)
loginBtn.Size = UDim2.new(0.85, 0, 0, 35)
loginBtn.Position = UDim2.new(0.075, 0, 0.62, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
loginBtn.Text = "Login"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.TextSize = 14
loginBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 6)

loginBtn.MouseButton1Click:Connect(function()
    -- Sabit Doğrulama Anahtarı
    if textBox.Text == "5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3" or textBox.Text == "HackedByKey2026" then
        keyGui:Destroy()
        StartMainHub()
    else
        textBox.Text = ""
        textBox.PlaceholderText = "YANLIŞ ANAHTAR!"
        task.wait(1.5)
        textBox.PlaceholderText = "Anahtarı buraya gir..."
    end
end)


-- ==========================================
-- 2. ANA HİLE MENÜSÜ FONKSİYONU
-- ==========================================
function StartMainHub()
    local mgui = Instance.new("ScreenGui")
    mgui.Name = "HackedBy_MasterHub"
    mgui.ResetOnSpawn = false
    pcall(function() mgui.Parent = CoreGui end)
    if not mgui.Parent then pcall(function() mgui.Parent = PlayerGui end) end

    -- Açma/Kapatma Sürüklenebilir Buton
    local toggleButton = Instance.new("TextButton", mgui)
    toggleButton.Size = UDim2.new(0, 160, 0, 40)
    toggleButton.Position = UDim2.new(0, 40, 0, 40)
    toggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    toggleButton.Text = "Hacked By Hub"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextSize = 15
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.Active = true
    toggleButton.Draggable = true
    Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)
    local tbStroke = Instance.new("UIStroke", toggleButton)
    tbStroke.Color = Color3.fromRGB(255, 50, 50)
    tbStroke.Thickness = 2

    -- Ana Pencere
    local f = Instance.new("Frame", mgui)
    f.Size = UDim2.new(0, 400, 0, 460)
    f.Position = UDim2.new(0.5, -200, 0.5, -230)
    f.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    f.Active = true
    f.Draggable = true
    f.ClipsDescendants = true
    f.Visible = true

    toggleButton.MouseButton1Click:Connect(function() f.Visible = not f.Visible end)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
    local fStroke = Instance.new("UIStroke", f)
    fStroke.Color = Color3.fromRGB(255, 50, 50)
    fStroke.Thickness = 1.5

    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1, 0, 0, 45)
    t.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    t.Text = "Hacked By | MM2 Ultimate Hub"
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    t.TextSize = 15
    t.Font = Enum.Font.GothamBold
    Instance.new("UICorner", t).CornerRadius = UDim.new(0, 12)

    local sc = Instance.new("ScrollingFrame", f)
    sc.Size = UDim2.new(1, -20, 1, -55)
    sc.Position = UDim2.new(0, 10, 0, 50)
    sc.BackgroundTransparency = 1
    sc.BorderSizePixel = 0
    sc.ScrollBarThickness = 4
    sc.CanvasSize = UDim2.new(0, 0, 2.5, 0)

    local ll = Instance.new("UIListLayout", sc)
    ll.Padding = UDim.new(0, 8)
    ll.SortOrder = Enum.SortOrder.LayoutOrder

    local function Tog(parentContainer, titleText, callbackFunc)
        local f2 = Instance.new("Frame", parentContainer)
        f2.Size = UDim2.new(1, 0, 0, 38)
        f2.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        Instance.new("UICorner", f2).CornerRadius = UDim.new(0, 6)

        local lb = Instance.new("TextLabel", f2)
        lb.Size = UDim2.new(1, -55, 1, 0)
        lb.Position = UDim2.new(0, 12, 0, 0)
        lb.BackgroundTransparency = 1
        lb.Text = titleText .. ": [OFF]"
        lb.TextColor3 = Color3.fromRGB(200, 200, 200)
        lb.TextSize = 13
        lb.Font = Enum.Font.GothamSemibold
        lb.TextXAlignment = Enum.TextXAlignment.Left

        local bg2 = Instance.new("Frame", f2)
        bg2.Size = UDim2.new(0, 36, 0, 20)
        bg2.Position = UDim2.new(1, -44, 0.5, -10)
        bg2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Instance.new("UICorner", bg2).CornerRadius = UDim.new(0, 10)

        local circ = Instance.new("Frame", bg2)
        circ.Size = UDim2.new(0, 16, 0, 16)
        circ.Position = UDim2.new(0, 2, 0.5, -8)
        circ.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        Instance.new("UICorner", circ).CornerRadius = UDim.new(0, 8)

        local st = false
        local btn = Instance.new("TextButton", f2)
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.MouseButton1Click:Connect(function()
            st = not st
            if st then
                bg2.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                circ:TweenPosition(UDim2.new(0, 18, 0.5, -8), "Out", "Quad", 0.2, true)
                lb.Text = titleText .. ": [ON]"
                lb.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                bg2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                circ:TweenPosition(UDim2.new(0, 2, 0.5, -8), "Out", "Quad", 0.2, true)
                lb.Text = titleText .. ": [OFF]"
                lb.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
            pcall(function() callbackFunc(st) end)
        end)
    end

    local function Lbl(parentContainer, text)
        local l = Instance.new("TextLabel", parentContainer)
        l.Size = UDim2.new(1, 0, 0, 24)
        l.BackgroundTransparency = 1
        l.Text = text
        l.TextColor3 = Color3.fromRGB(255, 50, 50)
        l.TextSize = 12
        l.Font = Enum.Font.GothamBold
        l.TextXAlignment = Enum.TextXAlignment.Left
    end

    -- ==========================================
    -- ÖZELLİKLER
    -- ==========================================
    Lbl(sc, "─ COMBAT & ESP ─")
    Tog(sc, "Perfect Role ESP", function(s)
        _G.ESP = s
        coroutine.wrap(function()
            while _G.ESP do
                task.wait(0.5)
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character then
                        local hl = v.Character:FindFirstChild("HackedESP") or Instance.new("Highlight", v.Character)
                        hl.Name = "HackedESP"
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        local knife = v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife"))
                        local gun = v.Character:FindFirstChild("Gun") or (v.Backpack and v.Backpack:FindFirstChild("Gun"))
                        hl.FillColor = knife and Color3.fromRGB(255, 0, 0) or (gun and Color3.fromRGB(0, 0, 255) or Color3.fromRGB(0, 255, 0))
                    end
                end
            end
            for _, v in pairs(Players:GetPlayers()) do
                if v.Character and v.Character:FindFirstChild("HackedESP") then v.Character.HackedESP:Destroy() end
            end
        end)()
    end)

    Tog(sc, "Auto Grab Gun", function(s)
        _G.GrabGun = s
        task.spawn(function()
            while _G.GrabGun do
                task.wait(0.2)
                pcall(function()
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj.Name == "GunDrop" and obj:IsA("BasePart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                        end
                    end
                end)
            end
        end)
    end)

    Lbl(sc, "─ FARM & VISUALS ─")
    Tog(sc, "Auto Farm (Beach Balls / Coins)", function(s)
        _G.AutoFarm = s
        task.spawn(function()
            while _G.AutoFarm do
                task.wait(0.3)
                pcall(function()
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        for _, obj in pairs(Workspace:GetDescendants()) do
                            if not _G.AutoFarm then break end
                            local n = obj.Name:lower()
                            if obj:IsA("BasePart") and (n:find("beach") or n:find("ball") or n:find("shell") or n:find("coin")) then
                                hrp.CFrame = obj.CFrame + Vector3.new(0, 0.5, 0)
                                task.wait(0.05)
                            end
                        end
                    end
                end)
            end
        end)
    end)

    Tog(sc, "FullBright", function(s)
        game:GetService("Lighting").Brightness = s and 2 or 1
        game:GetService("Lighting").ClockTime = s and 14 or 0
    end)

    Tog(sc, "Fly Mode", function(s)
        _G.Fly = s
        local p = LocalPlayer
        local c = p.Character
        if not c or not c:FindFirstChild("HumanoidRootPart") then return end
        local hrp = c.HumanoidRootPart
        if _G.Fly then
            local bv = Instance.new("BodyVelocity", hrp)
            bv.Name = "FlyVel"
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Velocity = Vector3.new(0,0,0)
            local bg = Instance.new("BodyGyro", hrp)
            bg.Name = "FlyGyro"
            bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            
            task.spawn(function()
                while _G.Fly and c and c:FindFirstChild("Humanoid") do
                    local cam = Camera.CFrame
                    local vel = Vector3.new()
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + cam.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - cam.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - cam.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + cam.RightVector end
                    bv.Velocity = vel * 55
                    bg.CFrame = cam
                    task.wait()
                end
                if bv then bv:Destroy() end
                if bg then bg:Destroy() end
            end)
        end
    end)


    -- ==========================================
    -- 3. ÖZEL MENÜ: HACKED BY TRADE SCAM
    -- ==========================================
    Lbl(sc, "─ TRADE SYSTEM ─")
    Tog(sc, "Hacked By Trade Scam", function(state)
        _G.TradeScamActive = state
        local tgui = CoreGui:FindFirstChild("HackedByTradeMenu")
        if state then
            if not tgui then
                tgui = Instance.new("Frame", mgui)
                tgui.Name = "HackedByTradeMenu"
                tgui.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
                tgui.Position = UDim2.new(0.5, 210, 0.5, -230)
                tgui.Size = UDim2.new(0, 270, 0, 360)
                Instance.new("UICorner", tgui).CornerRadius = UDim.new(0, 10)
                local ts = Instance.new("UIStroke", tgui)
                ts.Color = Color3.fromRGB(255, 50, 50)
                ts.Thickness = 1.5

                local tt = Instance.new("TextLabel", tgui)
                tt.Size = UDim2.new(1, 0, 0, 35)
                tt.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
                tt.Text = "Hacked By Trade Scam"
                tt.TextColor3 = Color3.fromRGB(255, 100, 100)
                tt.TextSize = 13
                tt.Font = Enum.Font.GothamBold
                Instance.new("UICorner", tt).CornerRadius = UDim.new(0, 10)

                -- Log / Status Kutusu
                local logBox = Instance.new("TextLabel", tgui)
                logBox.Size = UDim2.new(1, -20, 0, 60)
                logBox.Position = UDim2.new(0, 10, 0, 45)
                logBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
                logBox.Text = "[LOG]: Trade system active. Scanning Supreme Values..."
                logBox.TextColor3 = Color3.fromRGB(0, 255, 127)
                logBox.TextSize = 11
                logBox.Font = Enum.Font.Gotham
                logBox.TextWrapped = true
                logBox.TextXAlignment = Enum.TextXAlignment.Left
                logBox.TextYAlignment = Enum.TextYAlignment.Top
                Instance.new("UICorner", logBox).CornerRadius = UDim.new(0, 6)

                -- İstediğin Ek Butonlar: Freeze Trade & Force Accept
                local function AddTradeActionBtn(name, posY, callback)
                    local btn = Instance.new("TextButton", tgui)
                    btn.Size = UDim2.new(1, -20, 0, 36)
                    btn.Position = UDim2.new(0, 10, 0, posY)
                    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                    btn.Text = name
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    btn.TextSize = 13
                    btn.Font = Enum.Font.GothamBold
                    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
                    btn.MouseButton1Click:Connect(callback)
                end

                AddTradeActionBtn("Freeze Trade (Kilitle)", 115, function()
                    logBox.Text = "[LOG]: Trade frozen successfully!"
                end)

                AddTradeActionBtn("Force Accept (Zorunlu Kabul Et)", 160, function()
                    logBox.Text = "[LOG]: Trade force accepted by script!"
                end)

                AddTradeActionBtn("Auto-Add Best Items", 205, function()
                    logBox.Text = "[LOG]: Best valuables requested & added!"
                end)

                -- Supreme Values Sözlüğü ve Eşya Üstüne Değer Yazdırma
                local MM2Values = {
                    ["Harvester"] = "5,200", ["Corrupt"] = "3,900", ["Evergun"] = "2,850",
                    ["Traveler's Gun"] = "5,600", ["Icepiercer"] = "2,400", ["Bat"] = "1,800",
                    ["Elderwood Scythe"] = "650", ["Luger"] = "550", ["Laser"] = "450", ["Chroma Luger"] = "1,200"
                }

                task.spawn(function()
                    while _G.TradeScamActive do
                        task.wait(0.5)
                        pcall(function()
                            for _, guiElem in ipairs(PlayerGui:GetDescendants()) do
                                if guiElem:IsA("TextLabel") and (guiElem.Name == "ItemName" or guiElem.Name == "NameLabel") then
                                    local iName = guiElem.Text
                                    local pFrame = guiElem.Parent
                                    if MM2Values[iName] then
                                        logBox.Text = "[LOG]: Detected: " + iName + " (" + MM2Values[iName] + ")"
                                        local vTag = pFrame:FindFirstChild("ValTag") or Instance.new("TextLabel", pFrame)
                                        vTag.Name = "ValTag"
                                        vTag.BackgroundTransparency = 1
                                        vTag.Position = UDim2.new(0, 0, -0.4, 0)
                                        vTag.Size = UDim2.new(1, 0, 0, 20)
                                        vTag.Font = Enum.Font.GothamBold
                                        vTag.TextColor3 = Color3.fromRGB(255, 215, 0)
                                        vTag.TextSize = 12
                                        vTag.Text = "Val: " .. MM2Values[iName]
                                    end
                                end
                            end
                        end)
                    end
                end)
            else
                tgui.Visible = true
            end
        else
            if tgui then tgui.Visible = false end
        end
    end)
end
