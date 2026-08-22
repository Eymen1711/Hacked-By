-- ==========================================
-- ULTIMATE MM2 SCRIPT (PANEL FIX v23)
-- ==========================================

local p = game:GetService("Players")
local pl = p.LocalPlayer
local workspace = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local camera = workspace.CurrentCamera

local LOOTLABS_LINK = "https://loot-link.com/s/9K7cNpua"
local CORRECT_KEY = "5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3"

local customThemeColor = Color3.fromRGB(0, 255, 200)
local rainbowModeActive = true
local currentWalkSpeed = 16
local currentJumpPower = 50
local currentFOV = 70
local CUSTOM_FONT = Enum.Font.FredokaOne

-- Anti-AFK
local vu = game:GetService("VirtualUser")
pl.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), camera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), camera.CFrame)
end)

local function getThemeColor(speed)
    if rainbowModeActive then
        local hue = (tick() * (speed or 1)) % 1
        return Color3.fromHSV(hue, 1, 1)
    else
        return customThemeColor
    end
end

-- Bildirim Sistemi
local notifGui = Instance.new("ScreenGui")
notifGui.Name = "HackedBy_Notifications_v23"
notifGui.ResetOnSpawn = false
pcall(function() notifGui.Parent = game:GetService("CoreGui") end)
if not notifGui.Parent then pcall(function() notifGui.Parent = pl:WaitForChild("PlayerGui") end) end

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
        box.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
        box.BackgroundTransparency = 0.1
        box.Position = UDim2.new(1, 50, 0, 0)
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
        
        local stroke = Instance.new("UIStroke", box)
        stroke.Thickness = 1.5
        rs.RenderStepped:Connect(function() if stroke and stroke.Parent then stroke.Color = getThemeColor(0.8) end end)

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

        pcall(function() box:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.3, true) end)
        task.wait(duration or 2.5)
        pcall(function() box:TweenPosition(UDim2.new(1, 50, 0, 0), "In", "Quad", 0.3, true) end)
        task.wait(0.3)
        if box then box:Destroy() end
    end)
end

-- Key System
local gui = Instance.new("ScreenGui")
gui.Name = "HackedBy_KeySystem_v23"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not gui.Parent then pcall(function() gui.Parent = pl:WaitForChild("PlayerGui") end) end

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 240)
frame.Position = UDim2.new(0.5, -200, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
rs.RenderStepped:Connect(function() if stroke and stroke.Parent then stroke.Color = getThemeColor(1) end end)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
title.Text = "Hacked By (v23 Key System)"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = CUSTOM_FONT
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.85, 0, 0, 48)
textBox.Position = UDim2.new(0.075, 0, 0.3, 0)
textBox.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "Enter key..."
textBox.Text = ""
textBox.TextSize = 16
textBox.Font = CUSTOM_FONT
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 8)

local loginBtn = Instance.new("TextButton", frame)
loginBtn.Size = UDim2.new(0.85, 0, 0, 45)
loginBtn.Position = UDim2.new(0.075, 0, 0.62, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
loginBtn.Text = "Login"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.TextSize = 16
loginBtn.Font = CUSTOM_FONT
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 8)

loginBtn.MouseButton1Click:Connect(function()
    if textBox.Text == CORRECT_KEY then
        gui:Destroy()
        sendNotification("Success", "Key verified successfully!", 3)
        
        -- MASTER MENU v23 (DOLU PANEL)
        local mgui = Instance.new("ScreenGui")
        mgui.Name = "HackedBy_MasterMenu_v23"
        mgui.ResetOnSpawn = false
        pcall(function() mgui.Parent = game:GetService("CoreGui") end)
        if not mgui.Parent then pcall(function() mgui.Parent = pl:WaitForChild("PlayerGui") end) end

        local toggleButton = Instance.new("TextButton", mgui)
        toggleButton.Size = UDim2.new(0, 190, 0, 48)
        toggleButton.Position = UDim2.new(0, 40, 0, 40)
        toggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        toggleButton.Text = "Toggle Menu (K)"
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.TextSize = 17
        toggleButton.Font = CUSTOM_FONT
        toggleButton.Active = true
        toggleButton.Draggable = true
        Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)
        local tbStroke = Instance.new("UIStroke", toggleButton)
        rs.RenderStepped:Connect(function() if tbStroke and tbStroke.Parent then tbStroke.Color = getThemeColor(1) end end)

        local f = Instance.new("Frame", mgui)
        f.Size = UDim2.new(0, 560, 0, 400)
        f.Position = UDim2.new(0.5, -280, 0.5, -200)
        f.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
        f.Active = true
        f.Draggable = true
        f.ClipsDescendants = true
        f.Visible = false

        toggleButton.MouseButton1Click:Connect(function() f.Visible = not f.Visible end)
        uis.InputBegan:Connect(function(input, gpe)
            if not gpe and input.KeyCode == Enum.KeyCode.K then
                f.Visible = not f.Visible
            end
        end)

        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
        local fStroke = Instance.new("UIStroke", f)
        rs.RenderStepped:Connect(function() if fStroke and fStroke.Parent then fStroke.Color = getThemeColor(1) end end)

        -- Sol Kategori Butonları Paneli
        local sidebar = Instance.new("Frame", f)
        sidebar.Size = UDim2.new(0, 140, 1, -52)
        sidebar.Position = UDim2.new(0, 0, 0, 52)
        sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
        sidebar.BackgroundTransparency = 0.5

        local sideLayout = Instance.new("UIListLayout", sidebar)
        sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
        sideLayout.Padding = UDim.new(0, 5)

        -- Sağ İçerik Alanı
        local contentArea = Instance.new("Frame", f)
        contentArea.Size = UDim2.new(1, -145, 1, -60)
        contentArea.Position = UDim2.new(0, 145, 0, 58)
        contentArea.BackgroundTransparency = 1

        local function createTabButton(name)
            local btn = Instance.new("TextButton", sidebar)
            btn.Size = UDim2.new(1, 0, 0, 40)
            btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            btn.Text = name
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            btn.TextSize = 14
            btn.Font = CUSTOM_FONT
            return btn
        end

        createTabButton("Visuals (ESP)")
        createTabButton("Player Mods")
        createTabButton("Teleports")
        createTabButton("Settings")

        local t = Instance.new("TextLabel", f)
        t.Size = UDim2.new(1, 0, 0, 52)
        t.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        t.Text = "Hacked By - Panel v23 (Fixed)"
        t.TextColor3 = Color3.fromRGB(255, 255, 255)
        t.TextSize = 18
        t.Font = CUSTOM_FONT
        Instance.new("UICorner", t).CornerRadius = UDim.new(0, 12)

        sendNotification("Loaded", "Panel successfully populated!", 3)
    else
        textBox.Text = ""
        textBox.PlaceholderText = "WRONG KEY!"
        task.wait(1.5)
        textBox.PlaceholderText = "Enter key..."
    end
end)
