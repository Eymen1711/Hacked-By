--[================================================================]--
-- Infinite Yield FE - MM2 Complete Script (Key System + Full ESP + Features)
-- Key Link: https://lootdest.org/s?CRVogxNA
-- Admin Key: 5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3
--[================================================================]--

if IY_LOADED and not _G.IY_DEBUG == true then
	return
end

pcall(function() getgenv().IY_LOADED = true end)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- 1. KEY SYSTEM GUI
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "MM2KeySystem"
KeyGui.Parent = CoreGui
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Parent = KeyGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 0, 0, 10)
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 18
TitleLabel.Text = "MM2 Script - Key System"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

local KeyBox = Instance.new("TextBox")
KeyBox.Parent = MainFrame
KeyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeyBox.BorderSizePixel = 0
KeyBox.Position = UDim2.new(0.1, 0, 0.3, 0)
KeyBox.Size = UDim2.new(0.8, 0, 0, 35)
KeyBox.Font = Enum.Font.SourceSans
KeyBox.PlaceholderText = "Keyinizi buraya girin..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 14

local CheckKeyBtn = Instance.new("TextButton")
CheckKeyBtn.Parent = MainFrame
CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
CheckKeyBtn.BorderSizePixel = 0
CheckKeyBtn.Position = UDim2.new(0.1, 0, 0.58, 0)
CheckKeyBtn.Size = UDim2.new(0.8, 0, 0, 30)
CheckKeyBtn.Font = Enum.Font.SourceSansBold
CheckKeyBtn.TextSize = 14
CheckKeyBtn.Text = "Keyi Doğrula"
CheckKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Parent = MainFrame
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Position = UDim2.new(0.1, 0, 0.8, 0)
GetKeyBtn.Size = UDim2.new(0.8, 0, 0, 30)
GetKeyBtn.Font = Enum.Font.SourceSansBold
GetKeyBtn.TextSize = 14
GetKeyBtn.Text = "Key Al (Linki Kopyala)"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

GetKeyBtn.MouseButton1Click:Connect(function()
	local targetLink = "https://lootdest.org/s?CRVogxNA"
	if setclipboard then
		setclipboard(targetLink)
		GetKeyBtn.Text = "Link Kopyalandı!"
		task.wait(1.5)
		GetKeyBtn.Text = "Key Al (Linki Kopyala)"
	else
		KeyBox.Text = targetLink
		GetKeyBtn.Text = "Link Kutuya Yazıldı!"
	end
end)

local ADMIN_KEY = "5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3"
local VERIFY_SITE = "https://glittering-stroopwafel-c336e3.netlify.app"

CheckKeyBtn.MouseButton1Click:Connect(function()
	local enteredKey = KeyBox.Text
	if enteredKey == "" then
		CheckKeyBtn.Text = "Lütfen key girin!"
		task.wait(1)
		CheckKeyBtn.Text = "Keyi Doğrula"
		return
	end
	
	if enteredKey == ADMIN_KEY then
		KeyGui:Destroy()
		loadMainScript()
		return
	end
	
	CheckKeyBtn.Text = "Doğrulanıyor..."
	task.spawn(function()
		local success, response = pcall(function()
			return game:HttpGet(VERIFY_SITE)
		end)
		
		if success and response then
			if string.find(response, enteredKey) or #enteredKey >= 32 then
				KeyGui:Destroy()
				loadMainScript()
			else
				CheckKeyBtn.Text = "Geçersiz Key!"
				task.wait(1.5)
				CheckKeyBtn.Text = "Keyi Doğrula"
			end
		else
			if #enteredKey >= 30 then
				KeyGui:Destroy()
				loadMainScript()
			else
				CheckKeyBtn.Text = "Bağlantı Hatası / Geçersiz Key"
				task.wait(1.5)
				CheckKeyBtn.Text = "Keyi Doğrula"
			end
		end
	end)
end)

-- 2. MAIN SCRIPT FUNCTION (LOADS AFTER KEY VERIFICATION)
function loadMainScript()
	if not game:IsLoaded() then
		local notLoaded = Instance.new("Message")
		notLoaded.Parent = CoreGui
		notLoaded.Text = 'Infinite Yield is waiting for the game to load'
		game.Loaded:Wait()
		notLoaded:Destroy()
	end

	local currentVersion = '5.9.5-MM2-Full'
	local PARENT = CoreGui

	local Holder = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local Dark = Instance.new("Frame")
	local Cmdbar = Instance.new("TextBox")
	local CMDsF = Instance.new("ScrollingFrame")
	local cmdListLayout = Instance.new("UIListLayout")
	local Settings = Instance.new("Frame")

	local shade1 = {}
	local shade2 = {}
	local text1 = {}
	local scroll = {}

	Holder.Name = "MM2MainPanel"
	Holder.Parent = PARENT
	Holder.Active = true
	Holder.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Holder.BorderSizePixel = 0
	Holder.Position = UDim2.new(1, -250, 1, -220)
	Holder.Size = UDim2.new(0, 250, 0, 220)
	Holder.ZIndex = 10
	table.insert(shade2, Holder)

	Title.Name = "Title"
	Title.Parent = Holder
	Title.Active = true
	Title.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	Title.BorderSizePixel = 0
	Title.Size = UDim2.new(0, 250, 0, 20)
	Title.Font = Enum.Font.SourceSans
	Title.TextSize = 18
	Title.Text = "MM2 Hub v" .. currentVersion
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.ZIndex = 10
	table.insert(shade1, Title)
	table.insert(text1, Title)

	Dark.Name = "Dark"
	Dark.Parent = Holder
	Dark.Active = true
	Dark.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	Dark.BorderSizePixel = 0
	Dark.Position = UDim2.new(0, 0, 0, 45)
	Dark.Size = UDim2.new(0, 250, 0, 175)
	Dark.ZIndex = 10
	table.insert(shade1, Dark)

	Cmdbar.Name = "Cmdbar"
	Cmdbar.Parent = Holder
	Cmdbar.BackgroundTransparency = 1
	Cmdbar.BorderSizePixel = 0
	Cmdbar.Position = UDim2.new(0, 5, 0, 20)
	Cmdbar.Size = UDim2.new(0, 240, 0, 25)
	Cmdbar.Font = Enum.Font.SourceSans
	Cmdbar.TextSize = 18
	Cmdbar.TextXAlignment = Enum.TextXAlignment.Left
	Cmdbar.TextColor3 = Color3.new(1, 1, 1)
	Cmdbar.Text = ""
	Cmdbar.ZIndex = 10
	Cmdbar.PlaceholderText = "Command Bar"

	CMDsF.Name = "CMDs"
	CMDsF.Parent = Holder
	CMDsF.BackgroundTransparency = 1
	CMDsF.BorderSizePixel = 0
	CMDsF.Position = UDim2.new(0, 5, 0, 45)
	CMDsF.Size = UDim2.new(0, 245, 0, 175)
	CMDsF.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)
	CMDsF.ScrollBarThickness = 8
	CMDsF.ZIndex = 10
	table.insert(scroll, CMDsF)

	cmdListLayout.Parent = CMDsF

	Settings = Instance.new("Frame")
	Settings.Name = "Settings"
	Settings.Parent = Holder
	Settings.Active = true
	Settings.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	Settings.BorderSizePixel = 0
	Settings.Position = UDim2.new(0, 0, 0, 220)
	Settings.Size = UDim2.new(0, 250, 0, 175)
	Settings.ZIndex = 10
	table.insert(shade1, Settings)

	local SettingsHolder = Instance.new("ScrollingFrame")
	SettingsHolder.Name = "Holder"
	SettingsHolder.Parent = Settings
	SettingsHolder.BackgroundTransparency = 1
	SettingsHolder.BorderSizePixel = 0
	SettingsHolder.Size = UDim2.new(1, 0, 1, 0)
	SettingsHolder.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)
	SettingsHolder.CanvasSize = UDim2.new(0, 0, 0, 560)
	SettingsHolder.ScrollBarThickness = 8
	SettingsHolder.ZIndex = 10

	-- Theme Selector
	local ThemeFrame = Instance.new("Frame")
	ThemeFrame.Parent = SettingsHolder
	ThemeFrame.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	ThemeFrame.BorderSizePixel = 0
	ThemeFrame.Position = UDim2.new(0, 5, 0, 5)
	ThemeFrame.Size = UDim2.new(1, -10, 0, 60)
	ThemeFrame.ZIndex = 10

	local ThemeLabel = Instance.new("TextLabel")
	ThemeLabel.Parent = ThemeFrame
	ThemeLabel.BackgroundTransparency = 1
	ThemeLabel.Position = UDim2.new(0, 5, 0, 2)
	ThemeLabel.Size = UDim2.new(1, -10, 0, 20)
	ThemeLabel.Font = Enum.Font.SourceSansBold
	ThemeLabel.TextSize = 14
	ThemeLabel.Text = "Tema Seç (Red, Blue, Yellow, Green, Black)"
	ThemeLabel.TextColor3 = Color3.new(1, 1, 1)
	ThemeLabel.TextXAlignment = Enum.TextXAlignment.Left
	ThemeLabel.ZIndex = 10

	local colorsList = {
		{Name = "Red", Color = Color3.fromRGB(150, 30, 30)},
		{Name = "Blue", Color = Color3.fromRGB(30, 80, 150)},
		{Name = "Yellow", Color = Color3.fromRGB(150, 130, 30)},
		{Name = "Green", Color = Color3.fromRGB(30, 130, 30)},
		{Name = "Black", Color = Color3.fromRGB(20, 20, 20)}
	}

	for i, th in ipairs(colorsList) do
		local btn = Instance.new("TextButton")
		btn.Parent = ThemeFrame
		btn.BackgroundColor3 = th.Color
		btn.Position = UDim2.new(0, 5 + ((i-1) * 45), 0, 25)
		btn.Size = UDim2.new(0, 40, 0, 25)
		btn.Font = Enum.Font.SourceSansBold
		btn.TextSize = 12
		btn.Text = th.Name
		btn.TextColor3 = Color3.new(1, 1, 1)
		btn.ZIndex = 10
		
		btn.MouseButton1Click:Connect(function()
			for _, guiObj in ipairs(shade1) do guiObj.BackgroundColor3 = th.Color end
			for _, guiObj in ipairs(shade2) do guiObj.BackgroundColor3 = th.Color end
		end)
	end

	-- Map Teleport Frame
	local MapTPFrame = Instance.new("Frame")
	MapTPFrame.Parent = SettingsHolder
	MapTPFrame.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	MapTPFrame.BorderSizePixel = 0
	MapTPFrame.Position = UDim2.new(0, 5, 0, 70)
	MapTPFrame.Size = UDim2.new(1, -10, 0, 65)
	MapTPFrame.ZIndex = 10

	local MapTPTitle = Instance.new("TextLabel")
	MapTPTitle.Parent = MapTPFrame
	MapTPTitle.BackgroundTransparency = 1
	MapTPTitle.Position = UDim2.new(0, 5, 0, 2)
	MapTPTitle.Size = UDim2.new(1, -10, 0, 20)
	MapTPTitle.Font = Enum.Font.SourceSansBold
	MapTPTitle.TextSize = 14
	MapTPTitle.Text = "Harita / Spawn Işınlanma"
	MapTPTitle.TextColor3 = Color3.new(1, 1, 1)
	MapTPTitle.TextXAlignment = Enum.TextXAlignment.Left
	MapTPTitle.ZIndex = 10

	local TPSpawnBtn = Instance.new("TextButton")
	TPSpawnBtn.Parent = MapTPFrame
	TPSpawnBtn.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	TPSpawnBtn.Position = UDim2.new(0, 5, 0, 26)
	TPSpawnBtn.Size = UDim2.new(1, -10, 0, 30)
	TPSpawnBtn.Font = Enum.Font.SourceSansBold
	TPSpawnBtn.TextSize = 13
	TPSpawnBtn.Text = "Map Spawn / Lobby'ye Git"
	TPSpawnBtn.TextColor3 = Color3.new(1, 1, 1)
	TPSpawnBtn.ZIndex = 10

	TPSpawnBtn.MouseButton1Click:Connect(function()
		pcall(function()
			local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if not root then return end
			local spawnPart = workspace:FindFirstChild("Spawn") or workspace:FindFirstChild("Spawns")
			if spawnPart then
				if spawnPart:IsA("BasePart") then
					root.CFrame = spawnPart.CFrame + Vector3.new(0, 3, 0)
					return
				elseif spawnPart:IsA("Model") then
					local part = spawnPart:FindFirstChildWhichIsA("BasePart")
					if part then
						root.CFrame = part.CFrame + Vector3.new(0, 3, 0)
						return
					end
				end
			end
			for _, child in ipairs(workspace:GetChildren()) do
				if child:IsA("Model") and child:FindFirstChild("Spawn") then
					local s = child.Spawn
					if s:IsA("BasePart") then
						root.CFrame = s.CFrame + Vector3.new(0, 3, 0)
						return
					end
				end
			end
			root.CFrame = CFrame.new(0, 50, 0)
		end)
	end)

	-- Role & Fling Frame
	local MM2FlingFrame = Instance.new("Frame")
	MM2FlingFrame.Parent = SettingsHolder
	MM2FlingFrame.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	MM2FlingFrame.BorderSizePixel = 0
	MM2FlingFrame.Position = UDim2.new(0, 5, 0, 140)
	MM2FlingFrame.Size = UDim2.new(1, -10, 0, 95)
	MM2FlingFrame.ZIndex = 10

	local MM2Title = Instance.new("TextLabel")
	MM2Title.Parent = MM2FlingFrame
	MM2Title.BackgroundTransparency = 1
	MM2Title.Position = UDim2.new(0, 5, 0, 2)
	MM2Title.Size = UDim2.new(1, -10, 0, 20)
	MM2Title.Font = Enum.Font.SourceSansBold
	MM2Title.TextSize = 14
	MM2Title.Text = "Rol Işınlanma & Fling"
	MM2Title.TextColor3 = Color3.new(1, 1, 1)
	MM2Title.TextXAlignment = Enum.TextXAlignment.Left
	MM2Title.ZIndex = 10

	local FlingButton = Instance.new("TextButton")
	FlingButton.Parent = MM2FlingFrame
	FlingButton.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	FlingButton.Position = UDim2.new(0, 5, 0, 25)
	FlingButton.Size = UDim2.new(1, -10, 0, 25)
	FlingButton.Font = Enum.Font.SourceSansBold
	FlingButton.TextSize = 14
	FlingButton.Text = "Fling Döngüsünü Aç/Kapat"
	FlingButton.TextColor3 = Color3.new(1, 1, 1)
	FlingButton.ZIndex = 10

	local TPMMButton = Instance.new("TextButton")
	TPMMButton.Parent = MM2FlingFrame
	TPMMButton.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	TPMMButton.Position = UDim2.new(0, 5, 0, 55)
	TPMMButton.Size = UDim2.new(0.48, -5, 0, 32)
	TPMMButton.Font = Enum.Font.SourceSansBold
	TPMMButton.TextSize = 13
	TPMMButton.Text = "Murderer'a Git"
	TPMMButton.TextColor3 = Color3.new(1, 1, 1)
	TPMMButton.ZIndex = 10

	local TPSHButton = Instance.new("TextButton")
	TPSHButton.Parent = MM2FlingFrame
	TPSHButton.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	TPSHButton.Position = UDim2.new(0.52, 0, 0, 55)
	TPSHButton.Size = UDim2.new(0.48, -5, 0, 32)
	TPSHButton.Font = Enum.Font.SourceSansBold
	TPSHButton.TextSize = 13
	TPSHButton.Text = "Sheriff'e Git"
	TPSHButton.TextColor3 = Color3.new(1, 1, 1)
	TPSHButton.ZIndex = 10

	local flingActive = false
	FlingButton.MouseButton1Click:Connect(function()
		flingActive = not flingActive
		FlingButton.Text = flingActive and "Fling Aktif [ON]" or "Fling Döngüsünü Aç/Kapat"
		task.spawn(function()
			while flingActive do
				RunService.RenderStepped:Wait()
				local Character = LocalPlayer.Character
				local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
				if Character and RootPart then
					RootPart.Velocity = Vector3.new(30000, 30000, 30000)
					RootPart.RotVelocity = Vector3.new(30000, 30000, 30000)
				end
			end
		end)
	end)

	local function getRolePlayer(roleName)
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character then
				local bp = p:FindFirstChildOfClass("Backpack")
				local char = p.Character
				if roleName == "Murderer" then
					if (bp and bp:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife")) then return p end
				elseif roleName == "Sheriff" then
					if (bp and bp:FindFirstChild("Gun")) or (char and char:FindFirstChild("Gun")) then return p end
				end
			end
		end
		return nil
	end

	TPMMButton.MouseButton1Click:Connect(function()
		local m = getRolePlayer("Murderer")
		if m and m.Character and m.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			LocalPlayer.Character.HumanoidRootPart.CFrame = m.Character.HumanoidRootPart.CFrame
		end
	end)

	TPSHButton.MouseButton1Click:Connect(function()
		local s = getRolePlayer("Sheriff")
		if s and s.Character and s.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			LocalPlayer.Character.HumanoidRootPart.CFrame = s.Character.HumanoidRootPart.CFrame
		end
	end)

	-- ESP Frame (Coin, Knife, Gun)
	local ESPFrame = Instance.new("Frame")
	ESPFrame.Parent = SettingsHolder
	ESPFrame.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	ESPFrame.BorderSizePixel = 0
	ESPFrame.Position = UDim2.new(0, 5, 0, 245)
	ESPFrame.Size = UDim2.new(1, -10, 0, 165)
	ESPFrame.ZIndex = 10

	local ESPTitle = Instance.new("TextLabel")
	ESPTitle.Parent = ESPFrame
	ESPTitle.BackgroundTransparency = 1
	ESPTitle.Position = UDim2.new(0, 5, 0, 2)
	ESPTitle.Size = UDim2.new(1, -10, 0, 20)
	ESPTitle.Font = Enum.Font.SourceSansBold
	ESPTitle.TextSize = 14
	ESPTitle.Text = "ESP Menüsü (Coin, Knife, Gun)"
	ESPTitle.TextColor3 = Color3.new(1, 1, 1)
	ESPTitle.TextXAlignment = Enum.TextXAlignment.Left
	ESPTitle.ZIndex = 10

	local CoinESPBtn = Instance.new("TextButton")
	CoinESPBtn.Parent = ESPFrame
	CoinESPBtn.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	CoinESPBtn.Position = UDim2.new(0, 5, 0, 26)
	CoinESPBtn.Size = UDim2.new(1, -10, 0, 35)
	CoinESPBtn.Font = Enum.Font.SourceSansBold
	CoinESPBtn.TextSize = 13
	CoinESPBtn.Text = "Coin ESP [OFF]"
	CoinESPBtn.TextColor3 = Color3.new(1, 1, 1)
	CoinESPBtn.ZIndex = 10

	local KnifeESPBtn = Instance.new("TextButton")
	KnifeESPBtn.Parent = ESPFrame
	KnifeESPBtn.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	KnifeESPBtn.Position = UDim2.new(0, 5, 0, 67)
	KnifeESPBtn.Size = UDim2.new(1, -10, 0, 35)
	KnifeESPBtn.Font = Enum.Font.SourceSansBold
	KnifeESPBtn.TextSize = 13
	KnifeESPBtn.Text = "Knife (Murderer) ESP [OFF]"
	KnifeESPBtn.TextColor3 = Color3.new(1, 1, 1)
	KnifeESPBtn.ZIndex = 10

	local GunESPBtn = Instance.new("TextButton")
	GunESPBtn.Parent = ESPFrame
	GunESPBtn.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	GunESPBtn.Position = UDim2.new(0, 5, 0, 108)
	GunESPBtn.Size = UDim2.new(1, -10, 0, 35)
	GunESPBtn.Font = Enum.Font.SourceSansBold
	GunESPBtn.TextSize = 13
	GunESPBtn.Text = "Gun (Sheriff) ESP [OFF]"
	GunESPBtn.TextColor3 = Color3.new(1, 1, 1)
	GunESPBtn.ZIndex = 10

	local coinESPActive = false
	CoinESPBtn.MouseButton1Click:Connect(function()
		coinESPActive = not coinESPActive
		CoinESPBtn.Text = coinESPActive and "Coin ESP [ON]" or "Coin ESP [OFF]"
		task.spawn(function()
			while coinESPActive do
				task.wait(1)
				pcall(function()
					local coinsFolder = workspace:FindFirstChild("CoinContainer") or workspace:FindFirstChild("Coins")
					if coinsFolder then
						for _, coin in ipairs(coinsFolder:GetChildren()) do
							if not coin:FindFirstChild("CoinHighlight") then
								local hl = Instance.new("Highlight")
								hl.Name = "CoinHighlight"
								hl.Adornee = coin
								hl.FillColor = Color3.fromRGB(255, 215, 0)
								hl.Parent = coin
							end
						end
					end
				end)
			end
		end)
	end)

	local knifeESPActive = false
	KnifeESPBtn.MouseButton1Click:Connect(function()
		knifeESPActive = not knifeESPActive
		KnifeESPBtn.Text = knifeESPActive and "Knife ESP [ON]" or "Knife (Murderer) ESP [OFF]"
		task.spawn(function()
			while knifeESPActive do
				RunService.RenderStepped:Wait()
				pcall(function()
					for _, p in ipairs(Players:GetPlayers()) do
						if p ~= LocalPlayer and p.Character then
							local hasKnife = (p.Character:FindFirstChild("Knife") or (p:FindFirstChildOfClass("Backpack") and p.Backpack:FindFirstChild("Knife")))
							if hasKnife then
								if not p.Character:FindFirstChild("KnifeHighlight") then
									local hl = Instance.new("Highlight")
									hl.Name = "KnifeHighlight"
									hl.Adornee = p.Character
									hl.FillColor = Color3.fromRGB(255, 0, 0)
									hl.Parent = p.Character
								end
							end
						end
					end
				end)
			end
		end)
	end)

	local gunESPActive = false
	GunESPBtn.MouseButton1Click:Connect(function()
		gunESPActive = not gunESPActive
		GunESPBtn.Text = gunESPActive and "Gun ESP [ON]" or "Gun (Sheriff) ESP [OFF]"
		task.spawn(function()
			while gunESPActive do
				RunService.RenderStepped:Wait()
				pcall(function()
					for _, p in ipairs(Players:GetPlayers()) do
						if p ~= LocalPlayer and p.Character then
							local hasGun = (p.Character:FindFirstChild("Gun") or (p:FindFirstChildOfClass("Backpack") and p.Backpack:FindFirstChild("Gun")))
							if hasGun then
								if not p.Character:FindFirstChild("GunHighlight") then
									local hl = Instance.new("Highlight")
									hl.Name = "GunHighlight"
									hl.Adornee = p.Character
									hl.FillColor = Color3.fromRGB(0, 100, 255)
									hl.Parent = p.Character
								end
							end
						end
					end
				end)
			end
		end)
	end)

	-- Auto Farm & Speed Frame
	local AutoFarmFrame = Instance.new("Frame")
	AutoFarmFrame.Parent = SettingsHolder
	AutoFarmFrame.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	AutoFarmFrame.BorderSizePixel = 0
	AutoFarmFrame.Position = UDim2.new(0, 5, 0, 415)
	AutoFarmFrame.Size = UDim2.new(1, -10, 0, 135)
	AutoFarmFrame.ZIndex = 10

	local AFLabel = Instance.new("TextLabel")
	AFLabel.Parent = AutoFarmFrame
	AFLabel.BackgroundTransparency = 1
	AFLabel.Position = UDim2.new(0, 5, 0, 2)
	AFLabel.Size = UDim2.new(1, -10, 0, 20)
	AFLabel.Font = Enum.Font.SourceSansBold
	AFLabel.TextSize = 14
	AFLabel.Text = "Auto Farm & Hız Kontrolü"
	AFLabel.TextColor3 = Color3.new(1, 1, 1)
	AFLabel.TextXAlignment = Enum.TextXAlignment.Left
	AFLabel.ZIndex = 10

	local AFButton = Instance.new("TextButton")
	AFButton.Parent = AutoFarmFrame
	AFButton.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	AFButton.Position = UDim2.new(0, 5, 0, 25)
	AFButton.Size = UDim2.new(1, -10, 0, 30)
	AFButton.Font = Enum.Font.SourceSansBold
	AFButton.TextSize = 14
	AFButton.Text = "Auto Farm (Coin Topla) [OFF]"
	AFButton.TextColor3 = Color3.new(1, 1, 1)
	AFButton.ZIndex = 10

	local SpeedMinus = Instance.new("TextButton")
	SpeedMinus.Parent = AutoFarmFrame
	SpeedMinus.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	SpeedMinus.Position = UDim2.new(0, 5, 0, 65)
	SpeedMinus.Size = UDim2.new(0, 35, 0, 30)
	SpeedMinus.Font = Enum.Font.SourceSansBold
	SpeedMinus.TextSize = 16
	SpeedMinus.Text = "-"
	SpeedMinus.TextColor3 = Color3.new(1, 1, 1)
	SpeedMinus.ZIndex = 10

	local SpeedDisplay = Instance.new("TextLabel")
	SpeedDisplay.Parent = AutoFarmFrame
	SpeedDisplay.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	SpeedDisplay.Position = UDim2.new(0, 45, 0, 65)
	SpeedDisplay.Size = UDim2.new(1, -95, 0, 30)
	SpeedDisplay.Font = Enum.Font.SourceSansBold
	SpeedDisplay.TextSize = 14
	SpeedDisplay.Text = "Hız: 16"
	SpeedDisplay.TextColor3 = Color3.new(1, 1, 1)
	SpeedDisplay.ZIndex = 10

	local SpeedPlus = Instance.new("TextButton")
	SpeedPlus.Parent = AutoFarmFrame
	SpeedPlus.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	SpeedPlus.Position = UDim2.new(1, -40, 0, 65)
	SpeedPlus.Size = UDim2.new(0, 35, 0, 30)
	SpeedPlus.Font = Enum.Font.SourceSansBold
	SpeedPlus.TextSize = 16
	SpeedPlus.Text = "+"
	SpeedPlus.TextColor3 = Color3.new(1, 1, 1)
	SpeedPlus.ZIndex = 10

	local currentWalkSpeed = 16
	SpeedPlus.MouseButton1Click:Connect(function()
		currentWalkSpeed = currentWalkSpeed + 4
		SpeedDisplay.Text = "Hız: " .. currentWalkSpeed
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
			LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = currentWalkSpeed
		end
	end)

	SpeedMinus.MouseButton1Click:Connect(function()
		currentWalkSpeed = math.max(0, currentWalkSpeed - 4)
		SpeedDisplay.Text = "Hız: " .. currentWalkSpeed
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
			LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = currentWalkSpeed
		end
	end)

	local autoFarmActive = false
	AFButton.MouseButton1Click:Connect(function()
		autoFarmActive = not autoFarmActive
		AFButton.Text = autoFarmActive and "Auto Farm [AKTİF]" or "Auto Farm (Coin Topla) [OFF]"
		task.spawn(function()
			while autoFarmActive do
				task.wait(0.5)
				pcall(function()
					local coinsFolder = workspace:FindFirstChild("CoinContainer") or workspace:FindFirstChild("Coins")
					if coinsFolder and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						for _, coin in ipairs(coinsFolder:GetChildren()) do
							if not autoFarmActive then break end
							local handle = coin:FindFirstChild("BasePart") or coin
							if handle and handle:IsA("BasePart") then
								LocalPlayer.Character.HumanoidRootPart.CFrame = handle.CFrame
								task.wait(0.2)
							end
						end
					end
				end)
			end
		end)
	end)

	-- Infinite Jump
	UserInputService.JumpRequest:Connect(function()
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
			LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)

	print("MM2 Tam Donanımlı Hub Başarıyla Yüklendi!")
end
