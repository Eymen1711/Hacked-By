 p = game:GetService("Players")
local pl = p.LocalPlayer
local workspace = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local lighting = game:GetService("Lighting")

-- GUI Oluşturma
local gui = Instance.new("ScreenGui")
gui.Name = "MM2_Master"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not gui.Parent then pcall(function() gui.Parent = pl:WaitForChild("PlayerGui") end) end

-- FPS Göstergesi
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 120, 0, 30)
fpsLabel.Position = UDim2.new(0, 15, 1, -45)
fpsLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
fpsLabel.BackgroundTransparency = 0.3
fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLabel.TextSize = 14
fpsLabel.Font = Enum.Font.SourceSansBold
fpsLabel.Text = "FPS: 0"
fpsLabel.Visible = false
fpsLabel.Parent = gui

Instance.new("UICorner", fpsLabel).CornerRadius = UDim.new(0, 6)
local fpsStroke = Instance.new("UIStroke", fpsLabel)
fpsStroke.Color = Color3.fromRGB(255, 50, 50)
fpsStroke.Thickness = 1

-- Menü Aç/Kapa Butonu (Yazı Beyaz ve Daha Büyük)
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 160, 0, 40)
toggleButton.Position = UDim2.new(0, 40, 0, 40)
toggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
toggleButton.Text = "Hacked By"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 15
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.Active = true
toggleButton.Draggable = true
toggleButton.Parent = gui
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)
local tbStroke = Instance.new("UIStroke", toggleButton)
tbStroke.Color = Color3.fromRGB(255, 50, 50)
tbStroke.Thickness = 2

-- Shoot Murderer Butonu (Basılı Tut)
local shootButton = Instance.new("TextButton")
shootButton.Size = UDim2.new(0, 160, 0, 40)
shootButton.Position = UDim2.new(0, 40, 0, 95)
shootButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
shootButton.Text = "Shoot Murderer (Hold)"
shootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
shootButton.TextSize = 14
shootButton.Font = Enum.Font.SourceSansBold
shootButton.Active = true
shootButton.Draggable = true
shootButton.Parent = gui
Instance.new("UICorner", shootButton).CornerRadius = UDim.new(0, 8)
local sbStroke = Instance.new("UIStroke", shootButton)
sbStroke.Color = Color3.fromRGB(255, 50, 50)
sbStroke.Thickness = 2

local shootingActive = false
shootButton.MouseButton1Down:Connect(function() shootingActive = true end)
shootButton.MouseButton1Up:Connect(function() shootingActive = false end)
shootButton.MouseLeave:Connect(function() shootingActive = false end)

coroutine.wrap(function()
    while task.wait(0.1) do
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
                                if ev then ev:FireServer(v.Character.HumanoidRootPart.Position) end
                                break
                            end
                        end
                    end
                end
            end)
        end
    end
end)()

-- TP to Map Butonu
local mapButton = Instance.new("TextButton")
mapButton.Size = UDim2.new(0, 160, 0, 40)
mapButton.Position = UDim2.new(0, 40, 0, 150)
mapButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mapButton.Text = "TP to Map"
mapButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mapButton.TextSize = 15
mapButton.Font = Enum.Font.SourceSansBold
mapButton.Active = true
mapButton.Draggable = true
mapButton.Parent = gui
Instance.new("UICorner", mapButton).CornerRadius = UDim.new(0, 8)
local mbStroke = Instance.new("UIStroke", mapButton)
mbStroke.Color = Color3.fromRGB(255, 50, 50)
mbStroke.Thickness = 2

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
        end
    end)
end)

-- TP to Lobby Butonu
local lobbyButton = Instance.new("TextButton")
lobbyButton.Size = UDim2.new(0, 160, 0, 40)
lobbyButton.Position = UDim2.new(0, 40, 0, 205)
lobbyButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
lobbyButton.Text = "TP to Lobby"
lobbyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
lobbyButton.TextSize = 15
lobbyButton.Font = Enum.Font.SourceSansBold
lobbyButton.Active = true
lobbyButton.Draggable = true
lobbyButton.Parent = gui
Instance.new("UICorner", lobbyButton).CornerRadius = UDim.new(0, 8)
local lbStroke = Instance.new("UIStroke", lobbyButton)
lbStroke.Color = Color3.fromRGB(255, 50, 50)
lbStroke.Thickness = 2

lobbyButton.MouseButton1Down:Connect(function()
    pcall(function()
        local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(0, 150, 0) end
    end)
end)

-- Ana Menü Penceresi
local f = Instance.new("Frame")
f.Size = UDim2.new(0, 380, 0, 480)
f.Position = UDim2.new(0.5, -190, 0.5, -240)
f.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
f.Active = true
f.Draggable = true
f.ClipsDescendants = true
f.Visible = false
f.Parent = gui

toggleButton.MouseButton1Click:Connect(function() f.Visible = not f.Visible end)
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
local fStroke = Instance.new("UIStroke", f)
fStroke.Color = Color3.fromRGB(255, 50, 50)
fStroke.Thickness = 1.5
fStroke.Transparency = 0.4

local t = Instance.new("TextLabel")
t.Size = UDim2.new(1, 0, 0, 40)
t.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
t.Text = "Hacked By | MM2 Clean Hub"
t.TextColor3 = Color3.fromRGB(255, 255, 255)
t.TextSize = 14
t.Font = Enum.Font.SourceSansBold
t.Parent = f
Instance.new("UICorner", t).CornerRadius = UDim.new(0, 12)

local al2 = Instance.new("Frame")
al2.Size = UDim2.new(1, 0, 0, 2)
al2.Position = UDim2.new(0, 0, 0, 40)
al2.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
al2.Parent = f

local sc = Instance.new("ScrollingFrame")
sc.Size = UDim2.new(1, -20, 1, -50)
sc.Position = UDim2.new(0, 10, 0, 46)
sc.BackgroundTransparency = 1
sc.BorderSizePixel = 0
sc.ScrollBarThickness = 4
sc.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
sc.CanvasSize = UDim2.new(0, 0, 0, 0)
sc.Parent = f

local ll = Instance.new("UIListLayout")
ll.Padding = UDim.new(0, 8)
ll.SortOrder = Enum.SortOrder.LayoutOrder
ll.Parent = sc
ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    sc.CanvasSize = UDim2.new(0, 0, 0, ll.AbsoluteContentSize.Y + 20)
end)

local function Tog(parentContainer, titleText, defaultState, callbackFunc)
    local f2 = Instance.new("Frame")
    f2.Size = UDim2.new(1, 0, 0, 36)
    f2.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    f2.BackgroundTransparency = 0.4
    f2.Parent = parentContainer
    Instance.new("UICorner", f2).CornerRadius = UDim.new(0, 6)

    local lb = Instance.new("TextLabel")
    lb.Size = UDim2.new(1, -50, 1, 0)
    lb.Position = UDim2.new(0, 12, 0, 0)
    lb.BackgroundTransparency = 1
    lb.Text = titleText
    lb.TextColor3 = Color3.fromRGB(220, 220, 220)
    lb.TextSize = 13
    lb.Font = Enum.Font.SourceSans
    lb.TextXAlignment = Enum.TextXAlignment.Left
    lb.Parent = f2

    local bg2 = Instance.new("Frame")
    bg2.Size = UDim2.new(0, 36, 0, 20)
    bg2.Position = UDim2.new(1, -44, 0.5, -10)
    bg2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    bg2.BorderSizePixel = 0
    bg2.Parent = f2
    Instance.new("UICorner", bg2).CornerRadius = UDim.new(0, 10)

    local circ = Instance.new("Frame")
    circ.Size = UDim2.new(0, 16, 0, 16)
    circ.Position = UDim2.new(0, 2, 0.5, -8)
    circ.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    circ.BorderSizePixel = 0
    circ.Parent = bg2
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

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = f2
    btn.MouseButton1Click:Connect(function()
        st = not st
        upd()
        if callbackFunc then pcall(callbackFunc, st) end
    end)
end

local function Lbl(parentContainer, text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, 26)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(255, 50, 50)
    l.TextSize = 12
    l.Font = Enum.Font.SourceSansBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parentContainer
end

local O = {}
Lbl(sc, "─ ESP & ROLES ─")
Tog(sc, "Perfect Role ESP", false, function(s) O.ESP = s end)

Lbl(sc, "─ GUN MECHANICS ─")
Tog(sc, "Auto Grab Gun", false, function(s) O.AutoGrabGun = s end)
Tog(sc, "Auto Sheriff Target", false, function(s) O.AutoSheriff = s end)

Lbl(sc, "─ COMBAT & SURVIVAL ─")
Tog(sc, "Kill All (Murderer)", false, function(s) O.KA = s end)
Tog(sc, "Auto Avoid Knife", false, function(s) O.Avoid = s end)
Tog(sc, "God Mode Shield", false, function(s) O.GodMode = s end)

Lbl(sc, "─ MOVEMENT & VISUALS ─")
Tog(sc, "Fly Mode", false, function(s) O.Fly = s end)
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

-- ESP Motoru
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

-- Fly Motoru
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
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new()
        if uis:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
        bv.velocity = moveDir * 50
        bg.CFrame = cam.CFrame
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
                        if cc >= 40 then cc = 0; hum.Health = 0; task.wait(3); break end
                    end
                end
            end
        else
            cc = 0
        end
    end
end)()

print("[LOADED] MM2 Clean Hub Ready!")
