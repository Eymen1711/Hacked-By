-- ==========================================
-- ULTIMATE MM2 FIXED & CLEANED SCRIPT v4.3 (Debug)
-- ==========================================

local p = game:GetService("Players")
local pl = p.LocalPlayer
local workspace = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local lighting = game:GetService("Lighting")

local LOOTLABS_LINK = "https://loot-link.com/s?9K7cNpua"
local CORRECT_KEY = "5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3"

local customThemeColor = Color3.fromRGB(0, 162, 255)
local activeConnections = {}

-- Global States Table (Fully Synchronized)
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
    SilentAim = false,
    AutoFarm = false,
    OriginalTransparency = {},
    CoinCache = {}
}

local CUSTOM_FONT = Enum.Font.SourceSansBold -- Tüm executor'larda kesin çalışan güvenli font

local function getThemeColor(speed)
    if O.ThemeRainbow then
        local hue = (tick() * (speed or 1)) % 1
        return Color3.fromHSV(hue, 1, 1)
    else
        return customThemeColor
    end
end

-- CoreGui yerine kesin çalışan PlayerGui kullanıyoruz
local function getParentGui()
    local pg = pl:FindFirstChild("PlayerGui")
    if not pg then
        pg = pl:WaitForChild("PlayerGui", 5)
    end
    return pg or pl
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

-- Classic custom dragging function for universal executor compatibility
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

-- Notification System
local parentGui = getParentGui()
if not parentGui then
    warn("PlayerGui bulunamadı!")
    return
end

local notifGui = Instance.new("ScreenGui")
notifGui.Name = "MM2_Notifications"
notifGui.ResetOnSpawn = false
notifGui.Parent = parentGui

local notifHolder = Instance.new("Frame", notifGui)
notifHolder.Size = UDim2.new(0, 300, 0, 400)
notifHolder.Position = UDim2.new(1, -315, 1, -415)
notifHolder.BackgroundTransparency = 1
local notifLayout = Instance.new("UIListLayout", notifHolder)
notifLayout.SortOrder = Enum.SortOrder.LayoutOrder
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
notifLayout.Padding = UDim.new(0, 8)

local function sendNotification(titleText, msgText, duration)
    task.spawn(function()
        local box = Instance.new("Frame", notifHolder)
        box.Size = UDim2.new(1, 0, 0, 65)
        box.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        box.BackgroundTransparency = 0.1
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)

        local tLbl = Instance.new("TextLabel", box)
        tLbl.Size = UDim2.new(1, -15, 0, 24)
        tLbl.Position = UDim2.new(0, 12, 0, 6)
        tLbl.BackgroundTransparency = 1
        tLbl.Text = titleText
        tLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        tLbl.TextSize = 16
        tLbl.Font = CUSTOM_FONT
        tLbl.TextXAlignment = Enum.TextXAlignment.Left

        local mLbl = Instance.new("TextLabel", box)
        mLbl.Size = UDim2.new(1, -15, 0, 24)
        mLbl.Position = UDim2.new(0, 12, 0, 30)
        mLbl.BackgroundTransparency = 1
        mLbl.Text = msgText
        mLbl.TextColor3 = Color3.fromRGB(190, 190, 190)
        mLbl.TextSize = 14
        mLbl.Font = CUSTOM_FONT
        mLbl.TextXAlignment = Enum.TextXAlignment.Left

        task.wait(duration or 2.5)
        if box then box:Destroy() end
    end)
end

-- Key System UI
local gui = Instance.new("ScreenGui")
gui.Name = "MM2_KeySystem"
gui.ResetOnSpawn = false
gui.Parent = parentGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 240)
frame.Position = UDim2.new(0.5, -200, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
frame.Active = true
makeDraggable(frame)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
title.Text = "Hacked by (Key System)"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = CUSTOM_FONT
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.85, 0, 0, 48)
textBox.Position = UDim2.new(0.075, 0, 0.3, 0)
textBox.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "Enter key..."
textBox.Text = ""
textBox.TextSize = 16
textBox.Font = CUSTOM_FONT
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 8)

local getKeyBtn = Instance.new("TextButton", frame)
getKeyBtn.Size = UDim2.new(0.4, 0, 0, 45)
getKeyBtn.Position = UDim2.new(0.075, 0, 0.62, 0)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
getKeyBtn.Text = "Get Key"
getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyBtn.TextSize = 16
getKeyBtn.Font = CUSTOM_FONT
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0, 8)

trackConnection(getKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(LOOTLABS_LINK)
        getKeyBtn.Text = "Link Copied!"
        task.wait(2)
        getKeyBtn.Text = "Get Key"
    else
        sendNotification("Error", "Clipboard API not supported.", 2)
    end
end))

local loginBtn = Instance.new("TextButton", frame)
loginBtn.Size = UDim2.new(0.4, 0, 0, 45)
loginBtn.Position = UDim2.new(0.525, 0, 0.62, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
loginBtn.Text = "Login"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.TextSize = 16
loginBtn.Font = CUSTOM_FONT
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 8)

trackConnection(loginBtn.MouseButton1Click:Connect(function()
    if textBox.Text == CORRECT_KEY then
        gui:Destroy()
        sendNotification("Success", "Key verified!", 3)
        
        -- MASTER MENU CREATION
        local mgui = Instance.new("ScreenGui")
        mgui.Name = "MM2_MasterMenu"
        mgui.ResetOnSpawn = false
        mgui.Parent = parentGui
        
        -- Quick Access Buttons
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

        sendNotification("Loaded", "Script başarıyla yüklendi!", 3)
    else
        textBox.Text = ""
        textBox.PlaceholderText = "WRONG KEY!"
        task.wait(1.5)
        textBox.PlaceholderText = "Enter key..."
    end
end))
