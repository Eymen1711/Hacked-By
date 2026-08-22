-- ==========================================
-- HACKED BY | MM2 ULTIMATE HUB + SUMMER AUTO FARM
-- ==========================================

local p = game:GetService("Players")
local pl = p.LocalPlayer

-- Anahtar Giriş Arayüzü
local gui = Instance.new("ScreenGui")
gui.Name = "HackedBy_KeySystem"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not gui.Parent then pcall(function() gui.Parent = pl:WaitForChild("PlayerGui") end) end

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 360, 0, 220)
frame.Position = UDim2.new(0.5, -180, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(255, 50, 50)
stroke.Thickness = 2

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
title.Text = "Hacked By"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.85, 0, 0, 40)
textBox.Position = UDim2.new(0.075, 0, 0.3, 0)
textBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "Anahtarı buraya gir..."
textBox.Text = ""
textBox.TextSize = 14
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

local loginBtn = Instance.new("TextButton", frame)
loginBtn.Size = UDim2.new(0.85, 0, 0, 35)
loginBtn.Position = UDim2.new(0.075, 0, 0.62, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
loginBtn.Text = "Login"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.TextSize = 14
loginBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 6)

loginBtn.MouseButton1Click:Connect(function()
    if textBox.Text == "5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3" then
        gui:Destroy()
        
        -- ASIL MM2 HİLE MENÜSÜ
        local workspace = game:GetService("Workspace")
        local uis = game:GetService("UserInputService")
        local rs = game:GetService("RunService")
        local lighting = game:GetService("Lighting")

        local mgui = Instance.new("ScreenGui")
        mgui.Name = "HackedBy_Master"
        mgui.ResetOnSpawn = false
        pcall(function() mgui.Parent = game:GetService("CoreGui") end)
        if not mgui.Parent then pcall(function() mgui.Parent = pl:WaitForChild("PlayerGui") end) end

        -- FPS Sayacı
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
        fpsStroke.Color = Color3.fromRGB(255, 50, 50)
        fpsStroke.Thickness = 1

        -- Açma/Kapatma Butonu
        local toggleButton = Instance.new("TextButton", mgui)
        toggleButton.Size = UDim2.new(0, 160, 0, 40)
        toggleButton.Position = UDim2.new(0, 40, 0, 40)
        toggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        toggleButton.Text = "Hacked By"
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.TextSize = 15
        toggleButton.Font = Enum.Font.SourceSansBold
        toggleButton.Active = true
        toggleButton.Draggable = true
        Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)
        local tbStroke = Instance.new("UIStroke", toggleButton)
        tbStroke.Color = Color3.fromRGB(255, 50, 50)
        tbStroke.Thickness = 2

        -- Shoot Murderer
        local shootButton = Instance.new("TextButton", mgui)
        shootButton.Size = UDim2.new(0, 160, 0, 40)
        shootButton.Position = UDim2.new(0, 40, 0, 95)
        shootButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        shootButton.Text = "Shoot Murderer (Hold)"
        shootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        shootButton.TextSize = 14
        shootButton.Font = Enum.Font.SourceSansBold
        shootButton.Active = true
        shootButton.Draggable = true
        Instance.new("UICorner", shootButton).CornerRadius = UDim.new(0, 8)
        local sbStroke = Instance.new("UIStroke", shootButton)
        sbStroke.Color = Color3.fromRGB(255, 50, 50)
        sbStroke.Thickness = 2

        local shootingActive = false
        shootButton.MouseButton1Down:Connect(function() shootingActive = true end)
        shootButton.MouseButton1Up:Connect(function() shootingActive = false end)
        shootButton.MouseLeave:Connect(function() shootingActive = false end)

        coroutine.wrap(function()
            while task.wait(0.08) do
                if shootingActive then
                    pcall(function()
                        local c2 = pl.Character
                        local gun = c2 and (c2:FindFirstChild("Gun") or pl.Backpack:FindFirstChild("Gun"))
                        if not gun and c2 and c2:FindFirstChild("Humanoid") then
                            local bpGun = pl.Backpack:FindFirstChild("Gun")
                            if bpGun then bpGun.Parent = c2; gun = bpGun end
                        end
                        if gun then
                            for _, v in pairs(p:GetPlayers()) do
                                if v ~= pl and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                                    local hasKnife = v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife"))
                                    if hasKnife then
                                        local ev = gun:FindFirstChildWhichIsA("RemoteEvent")
                                        if ev then
                                            ev:FireServer(unpack({v.Character.HumanoidRootPart.Position}))
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)()

        -- TP to Map
        local mapButton = Instance.new("TextButton", mgui)
        mapButton.Size = UDim2.new(0, 160, 0, 40)
        mapButton.Position = UDim2.new(0, 40, 0, 150)
        mapButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        mapButton.Text = "TP to Map"
        mapButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        mapButton.TextSize = 15
        mapButton.Font = Enum.Font.SourceSansBold
        mapButton.Active = true
        mapButton.Draggable = true
        Instance.new("UICorner", mapButton).CornerRadius = UDim.new(0, 8)
        local mbStroke = Instance.new("UIStroke", mapButton)
        mbStroke.Color = Color3.fromRGB(255, 50, 50)
        mbStroke.Thickness = 2

        mapButton.MouseButton1Down:Connect(function()
            pcall(function()
                local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local targetPos = nil
                    for _, obj in pairs(workspace:GetChildren()) do
                        if obj.Name ~= "Lobby" and obj:IsA("Model") then
                            for _, part in pairs(obj:GetDescendants()) do
                                if part:IsA("BasePart") and (part.Name:lower():find("spawn") or part.Name:lower():find("floor")) then
                                    targetPos = part.Position + Vector3.new(0, 3, 0)
                                    break
                                end
                            end
                            if targetPos then break end
                        end
                    end
                    if targetPos then hrp.CFrame = CFrame.new(targetPos) end
                end
            end)
        end)

        -- TP to Lobby
        local lobbyButton = Instance.new("TextButton", mgui)
        lobbyButton.Size = UDim2.new(0, 160, 0, 40)
        lobbyButton.Position = UDim2.new(0, 40, 0, 205)
        lobbyButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        lobbyButton.Text = "TP to Lobby"
        lobbyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        lobbyButton.TextSize = 15
        lobbyButton.Font = Enum.Font.SourceSansBold
        lobbyButton.Active = true
        lobbyButton.Draggable = true
        Instance.new("UICorner", lobbyButton).CornerRadius = UDim.new(0, 8)
        local lbStroke = Instance.new("UIStroke", lobbyButton)
        lbStroke.Color = Color3.fromRGB(255, 50, 50)
        lbStroke.Thickness = 2

        lobbyButton.MouseButton1Down:Connect(function()
            pcall(function()
                local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local lobbyObj = workspace:FindFirstChild("Lobby")
                    local targetPos = nil
                    if lobbyObj and lobbyObj:IsA("Model") then
                        for _, part in pairs(lobbyObj:GetDescendants()) do
                            if part:IsA("BasePart") and (part.Name:lower():find("spawn") or part.Name:lower():find("floor")) then
                                targetPos = part.Position + Vector3.new(0, 4, 0)
                                break
                            end
                        end
                    end
                    if targetPos then hrp.CFrame = CFrame.new(targetPos) else hrp.CFrame = CFrame.new(-120, 135, 0) end
                end
            end)
        end)

        -- Ana Menü Penceresi
        local f = Instance.new("Frame", mgui)
        f.Size = UDim2.new(0, 380, 0, 480)
        f.Position = UDim2.new(0.5, -190, 0.5, -240)
        f.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
        f.Active = true
        f.Draggable = true
        f.ClipsDescendants = true
        f.Visible = false

        toggleButton.MouseButton1Click:Connect(function() f.Visible = not f.Visible end)
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
        local fStroke = Instance.new("UIStroke", f)
        fStroke.Color = Color3.fromRGB(255, 50, 50)
        fStroke.Thickness = 1.5

        local t = Instance.new("TextLabel", f)
        t.Size = UDim2.new(1, 0, 0, 40)
        t.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        t.Text = "Hacked By | Ultimate Hub"
        t.TextColor3 = Color3.fromRGB(255, 255, 255)
        t.TextSize = 14
        t.Font = Enum.Font.SourceSansBold
        Instance.new("UICorner", t).CornerRadius = UDim.new(0, 12)

        local sc = Instance.new("ScrollingFrame", f)
        sc.Size = UDim2.new(1, -20, 1, -50)
        sc.Position = UDim2.new(0, 10, 0, 46)
        sc.BackgroundTransparency = 1
        sc.BorderSizePixel = 0
        sc.ScrollBarThickness = 4
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
            f2.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
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
                    bg2.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
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

        local function Sld(parentContainer, titleText, minVal, maxVal, defaultVal, callbackFunc)
            local f2 = Instance.new("Frame", parentContainer)
            f2.Size = UDim2.new(1, 0, 0, 55)
            f2.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
            f2.BackgroundTransparency = 0.4
            Instance.new("UICorner", f2).CornerRadius = UDim.new(0, 6)

            local lb = Instance.new("TextLabel", f2)
            lb.Size = UDim2.new(1, -15, 0, 25)
            lb.Position = UDim2.new(0, 12, 0, 4)
            lb.BackgroundTransparency = 1
            lb.Text = titleText .. ": " .. tostring(defaultVal)
            lb.TextColor3 = Color3.fromRGB(220, 220, 220)
            lb.TextSize = 13
            lb.Font = Enum.Font.SourceSans
            lb.TextXAlignment = Enum.TextXAlignment.Left

            local bar = Instance.new("Frame", f2)
            bar.Size = UDim2.new(1, -24, 0, 8)
            bar.Position = UDim2.new(0, 12, 0, 36)
            bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            bar.BorderSizePixel = 0
            Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 4)

            local fill = Instance.new("Frame", bar)
            fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
            fill.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            fill.BorderSizePixel = 0
            Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 4)

            local btn = Instance.new("TextButton", bar)
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""

            local dragging = false
            local function updateValue(input)
                local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                local val = math.floor(minVal + ((maxVal - minVal) * pos))
                fill.Size = UDim2.new(pos, 0, 1, 0)
                lb.Text = titleText .. ": " .. tostring(val)
                if callbackFunc then pcall(callbackFunc, val) end
            end

            btn.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    updateValue(input)
                end
            end)

            uis.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            uis.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateValue(input)
                end
            end)
        end

        local function Lbl(parentContainer, text)
            local l = Instance.new("TextLabel", parentContainer)
            l.Size = UDim2.new(1, 0, 0, 26)
            l.BackgroundTransparency = 1
            l.Text = text
            l.TextColor3 = Color3.fromRGB(255, 50, 50)
            l.TextSize = 12
            l.Font = Enum.Font.SourceSansBold
            l.TextXAlignment = Enum.TextXAlignment.Left
        end

        local O = { SpeedVal = 16, JumpVal = 50, AF = false }
        Lbl(sc, "─ ESP & ROLES ─")
        Tog(sc, "Perfect Role ESP", false, function(s) O.ESP = s end)

        Lbl(sc, "─ GUN MECHANICS ─")
        Tog(sc, "Auto Grab Gun", false, function(s) O.AutoGrabGun = s end)
        Tog(sc, "Auto Sheriff Target", false, function(s) O.AutoSheriff = s end)

        Lbl(sc, "─ COMBAT & SURVIVAL ─")
        Tog(sc, "Kill All (Murderer)", false, function(s) O.KA = s end)
        Tog(sc, "Auto Avoid Knife", false, function(s) O.Avoid = s end)
        Tog(sc, "God Mode Shield", false, function(s) O.GodMode = s end)

        Lbl(sc, "─ SPEED & JUMP ─")
        Sld(sc, "WalkSpeed", 16, 100, 16, function(v) O.SpeedVal = v end)
        Sld(sc, "JumpPower", 50, 100, 50, function(v) O.JumpVal = v end)

        Lbl(sc, "─ VISUALS ─")
        Tog(sc, "Fly Mode", false, function(s) O.Fly = s end)
        Tog(sc, "FullBright", false, function(s) 
            lighting.Brightness = s and 2 or 1
            lighting.ClockTime = s and 14 or 0
        end)
        Tog(sc, "FPS Display", false, function(s) O.FPS = s; fpsLabel.Visible = s end)

        -- VİDEODAKİ GİBİ DÜZELTİLMİŞ AUTO FARM (Karakteri öldürmez, eşyaları güvenle toplar)
        Lbl(sc, "─ AUTO FARM (SUMMER UPDATE) ─")
        Tog(sc, "Auto Farm (Grab Beach Ball)", false, function(s) O.AF = s end)

        local lastTick, frameCount = tick(), 0
        rs.RenderStepped:Connect(function()
            frameCount = frameCount + 1
            if tick() - lastTick >= 1 then
                if O.FPS then fpsLabel.Text = "FPS: " .. tostring(frameCount) end
                frameCount, lastTick = 0, tick()
            end

            pcall(function()
                local hum = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.WalkSpeed = O.SpeedVal
                    if hum.UseJumpPower then hum.JumpPower = O.JumpVal else hum.JumpHeight = O.JumpVal / 4 end
                end
            end)
        end)

        -- ESP Sistemi
        coroutine.wrap(function()
            while task.wait(0.2) do
                if O.ESP then
                    for _, v in pairs(p:GetPlayers()) do
                        if v ~= pl and v.Character then
                            local hl = v.Character:FindFirstChild("PerfectESP") or Instance.new("Highlight", v.Character)
                            hl.Name = "PerfectESP"
                            hl.FillTransparency = 0.5
                            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
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
            while task.wait(0.2) do
                if O.AutoSheriff then
                    local c2 = pl.Character
                    local gun = c2 and (c2:FindFirstChild("Gun") or pl.Backpack:FindFirstChild("Gun"))
                    if gun then
                        for _, v in pairs(p:GetPlayers()) do
                            if v ~= pl and v.Character and v.Character:FindFirstChild("Knife") then
                                local ev = gun:FindFirstChildWhichIsA("RemoteEvent")
                                if ev then ev:FireServer(unpack({v.Character.HumanoidRootPart.Position})) end
                                break
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
                            if v ~= pl and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                                local rp = c2:FindFirstChild("HumanoidRootPart")
                                if rp then
                                    rp.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                                    task.wait(0.05)
                                    local ev = knife:FindFirstChildWhichIsA("RemoteEvent")
                                    if ev then ev:FireServer(unpack({v.Character.HumanoidRootPart})) end
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
                            if v ~= pl and v.Character and v.Character:FindFirstChild("Knife") then
                                if (hrp.Position - v.Character.HumanoidRootPart.Position).Magnitude < 14 then
                                    hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * -10) + Vector3.new(0, 5, 0)
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

        -- VİDEODAKİ GİBİ DÜZELTİLMİŞ AUTO FARM DÖNGÜSÜ (ÖLMEDEN TOPLAMA)
        coroutine.wrap(function()
            while task.wait(0.05) do
                if O.AF then
                    pcall(function()
                        local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                        local hum = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.Health > 0 then
                            for _, obj in pairs(workspace:GetDescendants()) do
                                if not O.AF then break end
                                local nameLower = obj.Name:lower()
                                if obj:IsA("BasePart") and (nameLower:find("beach") or nameLower:find("ball") or nameLower:find("shell") or nameLower:find("coin")) and obj.Transparency < 1 then
                                    hrp.CFrame = obj.CFrame + Vector3.new(0, 0.5, 0)
                                    task.wait(0.04)
                                end
                            end
                        end
                    end)
                end
            end
        end)()

        print("[LOADED] Hacked By MM2 Ultimate Hub Ready!")
    else
        textBox.Text = ""
        textBox.PlaceholderText = "YANLIŞ ANAHTAR!"
        task.wait(1.5)
        textBox.PlaceholderText = "Anahtarı buraya gir..."
    end
end)
