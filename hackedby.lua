-- ==========================================
-- ULTIMATE MM2 AIMBOT RENAMED FOR DELTA
-- ==========================================

local p = game:GetService("Players")
local pl = p.LocalPlayer
local workspace = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local lighting = game:GetService("Lighting")

local pg = pl:WaitForChild("PlayerGui")

local customThemeColor = Color3.fromRGB(0, 162, 255)
local activeConnections = {}

local O = {
    WalkSpeed = 16,
    JumpPower = 50,
    FOV = 70,
    ThemeRainbow = true,
    ESP = false,
    XRay = false,
    GodMode = false,
    InfJump = false,
    Noclip = false,
    FullBright = false,
    Aimbot = false,
    AutoFarm = false
}

local CUSTOM_FONT = Enum.Font.SourceSansBold

local function getThemeColor(speed)
    if O.ThemeRainbow then
        local hue = (tick() * (speed or 1)) % 1
        return Color3.fromHSV(hue, 1, 1)
    else
        return customThemeColor
    end
end

local function trackConnection(conn)
    table.insert(activeConnections, conn)
    return conn
end

local function cleanupAll()
    for _, conn in ipairs(activeConnections) do
        if conn and typeof(conn) == "RBXScriptConnection" then
            conn:Disconnect()
        end
    end
    activeConnections = {}
end

local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    trackConnection(frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            trackConnection(input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end))
        end
    end))
    trackConnection(frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end))
    trackConnection(uis.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end))
end

local mgui = Instance.new("ScreenGui")
mgui.Name = "MM2_MasterMenu"
mgui.ResetOnSpawn = false
mgui.Parent = pg

trackConnection(mgui.AncestryChanged:Connect(function()
    if not mgui.Parent then cleanupAll() end
end))

-- Master Character Loop
trackConnection(rs.Stepped:Connect(function()
    if not mgui.Parent then return end
    pcall(function()
        local char = pl.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                if hum.WalkSpeed ~= O.WalkSpeed then hum.WalkSpeed = O.WalkSpeed end
                hum.UseJumpPower = true
                if hum.JumpPower ~= O.JumpPower then hum.JumpPower = O.JumpPower end
            end
            if O.Noclip then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end
        local cam = workspace.CurrentCamera
        if cam and cam.FieldOfView ~= O.FOV then cam.FieldOfView = O.FOV end
    end)
end))

-- 1. Ana Menü Açma/Kapama Tuşu
local toggleButton = Instance.new("TextButton", mgui)
toggleButton.Size = UDim2.new(0, 190, 0, 48)
toggleButton.Position = UDim2.new(0, 40, 0, 40)
toggleButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
toggleButton.Text = "Hacked By - Menu"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 17
toggleButton.Font = CUSTOM_FONT
toggleButton.Active = true
makeDraggable(toggleButton)
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)

-- 2. Aimbot Tuşu (Menü tuşunun altında)
local aimbotButton = Instance.new("TextButton", mgui)
aimbotButton.Size = UDim2.new(0, 190, 0, 48)
aimbotButton.Position = UDim2.new(0, 40, 0, 96)
aimbotButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
aimbotButton.Text = "Aimbot: OFF"
aimbotButton.TextColor3 = Color3.fromRGB(255, 50, 50)
aimbotButton.TextSize = 16
aimbotButton.Font = CUSTOM_FONT
aimbotButton.Active = true
makeDraggable(aimbotButton)
Instance.new("UICorner", aimbotButton).CornerRadius = UDim.new(0, 8)

trackConnection(aimbotButton.MouseButton1Click:Connect(function()
    O.Aimbot = not O.Aimbot
    aimbotButton.Text = O.Aimbot and "Aimbot: ON" or "Aimbot: OFF"
    aimbotButton.TextColor3 = O.Aimbot and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
end))

-- 3. TP to Map Tuşu
local mapButton = Instance.new("TextButton", mgui)
mapButton.Size = UDim2.new(0, 190, 0, 48)
mapButton.Position = UDim2.new(0, 40, 0, 152)
mapButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
mapButton.Text = "TP to Map"
mapButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mapButton.TextSize = 17
mapButton.Font = CUSTOM_FONT
mapButton.Active = true
makeDraggable(mapButton)
Instance.new("UICorner", mapButton).CornerRadius = UDim.new(0, 8)

trackConnection(mapButton.MouseButton1Click:Connect(function()
    pcall(function()
        local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local map = workspace:FindFirstChild("Map", true)
            if map then
                local primary = map:IsA("Model") and (map.PrimaryPart or map:FindFirstChildWhichIsA("BasePart"))
                if primary then hrp.CFrame = primary.CFrame + Vector3.new(0, 5, 0) end
            else
                hrp.CFrame = CFrame.new(0, 50, 0)
            end
        end
    end)
end))

-- 4. TP to Lobby Tuşu
local lobbyButton = Instance.new("TextButton", mgui)
lobbyButton.Size = UDim2.new(0, 190, 0, 48)
lobbyButton.Position = UDim2.new(0, 40, 0, 208)
lobbyButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
lobbyButton.Text = "TP to Lobby"
lobbyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
lobbyButton.TextSize = 17
lobbyButton.Font = CUSTOM_FONT
lobbyButton.Active = true
makeDraggable(lobbyButton)
Instance.new("UICorner", lobbyButton).CornerRadius = UDim.new(0, 8)

trackConnection(lobbyButton.MouseButton1Click:Connect(function()
    pcall(function()
        local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
        if hrp then 
            local spawn = workspace:FindFirstChild("LobbySpawn", true)
            if spawn and spawn:IsA("BasePart") then
                hrp.CFrame = spawn.CFrame + Vector3.new(0, 3, 0)
            else
                hrp.CFrame = CFrame.new(0, 10, 0) 
            end
        end
    end)
end))

-- Ana Menü Paneli (Kalan özelliklerin bulunduğu yer)
local f = Instance.new("Frame", mgui)
f.Size = UDim2.new(0, 620, 0, 450)
f.Position = UDim2.new(0.5, -310, 0.5, -225)
f.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
f.Active = true
makeDraggable(f)
f.ClipsDescendants = true
f.Visible = false

trackConnection(toggleButton.MouseButton1Click:Connect(function() f.Visible = not f.Visible end))
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 0, 45)
t.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
t.Text = "Hacked by - Panel"
t.TextColor3 = Color3.fromRGB(255, 255, 255)
t.TextSize = 18
t.Font = CUSTOM_FONT
Instance.new("UICorner", t).CornerRadius = UDim.new(0, 12)

local catHolder = Instance.new("ScrollingFrame", f)
catHolder.Size = UDim2.new(0, 150, 1, -55)
catHolder.Position = UDim2.new(0, 8, 0, 50)
catHolder.BackgroundTransparency = 1
catHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
catHolder.ScrollBarThickness = 2

local catLayout = Instance.new("UIListLayout", catHolder)
catLayout.FillDirection = Enum.FillDirection.Vertical
catLayout.SortOrder = Enum.SortOrder.LayoutOrder
catLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
catLayout.Padding = UDim.new(0, 6)

trackConnection(catLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    catHolder.CanvasSize = UDim2.new(0, 0, 0, catLayout.AbsoluteContentSize.Y + 20)
end))

local function createPage()
    local sc = Instance.new("ScrollingFrame", f)
    sc.Size = UDim2.new(1, -170, 1, -55)
    sc.Position = UDim2.new(0, 162, 0, 50)
    sc.BackgroundTransparency = 1
    sc.BorderSizePixel = 0
    sc.ScrollBarThickness = 6
    sc.Visible = false
    local ll = Instance.new("UIListLayout", sc)
    ll.Padding = UDim.new(0, 8)
    ll.SortOrder = Enum.SortOrder.LayoutOrder
    trackConnection(ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sc.CanvasSize = UDim2.new(0, 0, 0, ll.AbsoluteContentSize.Y + 20)
    end))
    return sc
end

local categories = {"Theme", "ESP & X-Ray", "Combat & Misc", "Trade & Misc", "Auto Farm"}
local pageFrames = {}

for i, catName in ipairs(categories) do
    local page = createPage()
    table.insert(pageFrames, page)

    local cBtn = Instance.new("TextButton", catHolder)
    cBtn.Size = UDim2.new(1, -10, 0, 40)
    cBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    cBtn.Text = catName
    cBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
    cBtn.TextSize = 13
    cBtn.Font = CUSTOM_FONT
    Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 8)

    trackConnection(cBtn.MouseButton1Click:Connect(function()
        for _, pFrame in ipairs(pageFrames) do pFrame.Visible = false end
        page.Visible = true
    end))
    if i == 1 then page.Visible = true end
end

local function Tog(parentContainer, titleText, defaultState, callbackFunc)
    local f2 = Instance.new("Frame", parentContainer)
    f2.Size = UDim2.new(1, -10, 0, 46)
    f2.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    f2.BackgroundTransparency = 0.4
    Instance.new("UICorner", f2).CornerRadius = UDim.new(0, 8)

    local lb = Instance.new("TextLabel", f2)
    lb.Size = UDim2.new(1, -70, 1, 0)
    lb.Position = UDim2.new(0, 14, 0, 0)
    lb.BackgroundTransparency = 1
    lb.Text = titleText
    lb.TextColor3 = Color3.fromRGB(240, 240, 240)
    lb.TextSize = 14
    lb.Font = CUSTOM_FONT
    lb.TextXAlignment = Enum.TextXAlignment.Left

    local bg2 = Instance.new("Frame", f2)
    bg2.Size = UDim2.new(0, 44, 0, 24)
    bg2.Position = UDim2.new(1, -54, 0.5, -12)
    bg2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    bg2.BorderSizePixel = 0
    Instance.new("UICorner", bg2).CornerRadius = UDim.new(0, 12)

    local circ = Instance.new("Frame", bg2)
    circ.Size = UDim2.new(0, 20, 0, 20)
    circ.Position = UDim2.new(0, 2, 0.5, -10)
    circ.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    circ.BorderSizePixel = 0
    Instance.new("UICorner", circ).CornerRadius = UDim.new(0, 10)

    local st = defaultState or false
    local function upd()
        if st then
            bg2.BackgroundColor3 = getThemeColor(1)
            circ.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            pcall(function() circ:TweenPosition(UDim2.new(0, 22, 0.5, -10), "Out", "Quad", 0.2, true) end)
        else
            bg2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            circ.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            pcall(function() circ:TweenPosition(UDim2.new(0, 2, 0.5, -10), "Out", "Quad", 0.2, true) end)
        end
    end
    upd()

    local btn = Instance.new("TextButton", f2)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    trackConnection(btn.MouseButton1Click:Connect(function()
        st = not st
        upd()
        if callbackFunc then pcall(callbackFunc, st) end
    end))
end

local function createStepControl(parentContainer, labelName, defaultVal, minVal, maxVal, step, callback)
    local frameBox = Instance.new("Frame", parentContainer)
    frameBox.Size = UDim2.new(1, -10, 0, 55)
    frameBox.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    frameBox.BackgroundTransparency = 0.4
    Instance.new("UICorner", frameBox).CornerRadius = UDim.new(0, 8)

    local lbl = Instance.new("TextLabel", frameBox)
    lbl.Size = UDim2.new(1, -130, 1, 0)
    lbl.Position = UDim2.new(0, 14, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelName .. ": " .. defaultVal
    lbl.TextColor3 = Color3.fromRGB(240, 240, 240)
    lbl.TextSize = 14
    lbl.Font = CUSTOM_FONT
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local val = defaultVal
    local minusBtn = Instance.new("TextButton", frameBox)
    minusBtn.Size = UDim2.new(0, 38, 0, 32)
    minusBtn.Position = UDim2.new(1, -95, 0.5, -16)
    minusBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    minusBtn.Text = "-"
    minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minusBtn.TextSize = 18
    minusBtn.Font = CUSTOM_FONT
    Instance.new("UICorner", minusBtn).CornerRadius = UDim.new(0, 6)

    local plusBtn = Instance.new("TextButton", frameBox)
    plusBtn.Size = UDim2.new(0, 38, 0, 32)
    plusBtn.Position = UDim2.new(1, -52, 0.5, -16)
    plusBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    plusBtn.Text = "+"
    plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    plusBtn.TextSize = 18
    plusBtn.Font = CUSTOM_FONT
    Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0, 6)

    trackConnection(minusBtn.MouseButton1Click:Connect(function()
        val = math.clamp(val - step, minVal, maxVal)
        lbl.Text = labelName .. ": " .. val
        if callback then pcall(callback, val) end
    end))

    trackConnection(plusBtn.MouseButton1Click:Connect(function()
        val = math.clamp(val + step, minVal, maxVal)
        lbl.Text = labelName .. ": " .. val
        if callback then pcall(callback, val) end
    end))

    return frameBox
end

-- Menü İçerisindeki Diğer Özellikler
Tog(pageFrames[1], "Rainbow Mode", true, function(s) O.ThemeRainbow = s end)

Tog(pageFrames[2], "Role ESP", false, function(s) O.ESP = s end)
Tog(pageFrames[2], "Wallhack X-Ray", false, function(s) 
    O.XRay = s
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsDescendantOf(pl.Character) then
            part.LocalTransparencyModifier = s and 0.5 or 0
        end
    end
end)

Tog(pageFrames[3], "Client God Mode", false, function(s) O.GodMode = s end)

Tog(pageFrames[4], "Infinite Jump", false, function(s) O.InfJump = s end)
Tog(pageFrames[4], "Noclip", false, function(s) O.Noclip = s end)
Tog(pageFrames[4], "FullBright", false, function(s) 
    lighting.Brightness = s and 2 or 1
    lighting.ClockTime = s and 14 or 12
end)

createStepControl(pageFrames[4], "Character FOV", 70, 50, 120, 5, function(v) O.FOV = v end)
createStepControl(pageFrames[4], "WalkSpeed", 16, 16, 200, 4, function(v) O.WalkSpeed = v end)
createStepControl(pageFrames[4], "JumpPower", 50, 50, 300, 10, function(v) O.JumpPower = v end)

Tog(pageFrames[5], "Auto Farm", false, function(s) 
    O.AutoFarm = s 
    O.Noclip = s
end)

print("MM2 Aimbot Script başarıyla yüklendi!")
