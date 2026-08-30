--[================================================================================]--
-- MM2 Ultra Premium Hub v10.0 - Sürüklenebilir, Akıcı Animasyonlu & Tema Destekli
-- Key Link: https://lootdest.org/s?CRVogxNA
-- Admin Key: 5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3
--[================================================================================]--

if IY_LOADED and not _G.IY_DEBUG == true then
	return
end

pcall(function() getgenv().IY_LOADED = true end)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- 1. MODERN KEY SYSTEM GUI (Animasyonlu Geçişler)
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "MM2KeySystem"
KeyGui.Parent = CoreGui
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Parent = KeyGui
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
MainFrame.Size = UDim2.new(0, 320, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true

local UICornerKey = Instance.new("UICorner")
UICornerKey.CornerRadius = UDim.new(0, 12)
UICornerKey.Parent = MainFrame

local UIStrokeKey = Instance.new("UIStroke")
UIStrokeKey.Color = Color3.fromRGB(110, 60, 255)
UIStrokeKey.Thickness = 2
UIStrokeKey.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 0, 0, 15)
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 20
TitleLabel.Text = "✨ MM2 Ultra Hub - Key"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

local KeyBox = Instance.new("TextBox")
KeyBox.Parent = MainFrame
KeyBox.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
KeyBox.BorderSizePixel = 0
KeyBox.Position = UDim2.new(0.1, 0, 0.32, 0)
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Font = Enum.Font.Gotham
KeyBox.PlaceholderText = "Keyinizi buraya yapıştırın..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 140)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 14

local UICornerBox = Instance.new("UICorner")
UICornerBox.CornerRadius = UDim.new(0, 8)
UICornerBox.Parent = KeyBox

local CheckKeyBtn = Instance.new("TextButton")
CheckKeyBtn.Parent = MainFrame
CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(90, 40, 210)
CheckKeyBtn.BorderSizePixel = 0
CheckKeyBtn.Position = UDim2.new(0.1, 0, 0.58, 0)
CheckKeyBtn.Size = UDim2.new(0.8, 0, 0, 36)
CheckKeyBtn.Font = Enum.Font.GothamBold
CheckKeyBtn.TextSize = 14
CheckKeyBtn.Text = "Keyi Doğrula"
CheckKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local UICornerBtn1 = Instance.new("UICorner")
UICornerBtn1.CornerRadius = UDim.new(0, 8)
UICornerBtn1.Parent = CheckKeyBtn

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Parent = MainFrame
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Position = UDim2.new(0.1, 0, 0.79, 0)
GetKeyBtn.Size = UDim2.new(0.8, 0, 0, 32)
GetKeyBtn.Font = Enum.Font.GothamMedium
GetKeyBtn.TextSize = 13
GetKeyBtn.Text = "🔗 Key Al (Linki Kopyala)"
GetKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 210)

local UICornerBtn2 = Instance.new("UICorner")
UICornerBtn2.CornerRadius = UDim.new(0, 8)
UICornerBtn2.Parent = GetKeyBtn

-- Buton Hover Efektleri
local function addHover(btn, originalColor, hoverColor)
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
	end)
end

addHover(CheckKeyBtn, Color3.fromRGB(90, 40, 210), Color3.fromRGB(110, 60, 240))
addHover(GetKeyBtn, Color3.fromRGB(45, 45, 55), Color3.fromRGB(60, 60, 75))

GetKeyBtn.MouseButton1Click:Connect(function()
	local targetLink = "https://lootdest.org/s?CRVogxNA"
	if setclipboard then
		setclipboard(targetLink)
		GetKeyBtn.Text = "✨ Link Kopyalandı!"
		task.wait(1.5)
		GetKeyBtn.Text = "🔗 Key Al (Linki Kopyala)"
	else
		KeyBox.Text = targetLink
		GetKeyBtn.Text = "📁 Link Kutuya Yazıldı!"
	end
end)

local ADMIN_KEY = "5e50439b382a2eb7a7c79e3966b1003821f2ab99f9b9b7d0947588af36aef6d3"
local VERIFY_SITE = "https://glittering-stroopwafel-c336e3.netlify.app"

CheckKeyBtn.MouseButton1Click:Connect(function()
	local enteredKey = KeyBox.Text
	if enteredKey == "" then
		CheckKeyBtn.Text = "⚠️ Lütfen key girin!"
		task.wait(1)
		CheckKeyBtn.Text = "Keyi Doğrula"
		return
	end
	
	if enteredKey == ADMIN_KEY then
		KeyGui:Destroy()
		loadMainScript()
		return
	end
	
	CheckKeyBtn.Text = "🔄 Doğrulanıyor..."
	task.spawn(function()
		local success, response = pcall(function()
			return game:HttpGet(VERIFY_SITE)
		end)
		
		if success and response then
			if string.find(response, enteredKey) or #enteredKey >= 32 then
				KeyGui:Destroy()
				loadMainScript()
			else
				CheckKeyBtn.Text = "❌ Geçersiz Key!"
				task.wait(1.5)
				CheckKeyBtn.Text = "Keyi Doğrula"
			end
		else
			if #enteredKey >= 30 then
				KeyGui:Destroy()
				loadMainScript()
			else
				CheckKeyBtn.Text = "❌ Bağlantı / Key Hatası"
				task.wait(1.5)
				CheckKeyBtn.Text = "Keyi Doğrula"
			end
		end
	end)
end)

-- 2. ULTRA PREMIUM ANIMATED MAIN SCRIPT
function loadMainScript()
	local MainScreenGui = Instance.new("ScreenGui")
	MainScreenGui.Name = "MM2UltraMainGui"
	MainScreenGui.Parent = CoreGui
	MainScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local Holder = Instance.new("Frame")
	Holder.Name = "MainPanel"
	Holder.Parent = MainScreenGui
	Holder.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	Holder.BorderSizePixel = 0
	Holder.Position = UDim2.new(0.5, -140, 0.5, -140)
	Holder.Size = UDim2.new(0, 280, 0, 330)
	Holder.Active = true
	Holder.Draggable = true
	Holder.ClipsDescendants = true

	local UICornerMain = Instance.new("UICorner")
	UICornerMain.CornerRadius = UDim.new(0, 10)
	UICornerMain.Parent = Holder

	local UIStrokeMain = Instance.new("UIStroke")
	UIStrokeMain.Color = Color3.fromRGB(90, 40, 210)
	UIStrokeMain.Thickness = 2
	UIStrokeMain.Parent = Holder

	-- Üst Başlık Barı
	local TopBar = Instance.new("Frame")
	TopBar.Parent = Holder
	TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
	TopBar.BorderSizePixel = 0
	TopBar.Size = UDim2.new(1, 0, 0, 35)

	local Title = Instance.new("TextLabel")
	Title.Parent = TopBar
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0, 12, 0, 0)
	Title.Size = UDim2.new(1, -12, 1, 0)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 14
	Title.Text = "⚡ MM2 Ultra Hub v10"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextXAlignment = Enum.TextXAlignment.Left

	-- Küçült / Aç Kapat Butonu (Animasyonlu)
	local MinimizeBtn = Instance.new("TextButton")
	MinimizeBtn.Parent = TopBar
	MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
	MinimizeBtn.Position = UDim2.new(1, -30, 0, 6)
	MinimizeBtn.Size = UDim2.new(0, 22, 0, 22)
	MinimizeBtn.Font = Enum.Font.GothamBold
	MinimizeBtn.TextSize = 12
	MinimizeBtn.Text = "-"
	MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

	local UICornerMin = Instance.new("UICorner")
	UICornerMin.CornerRadius = UDim.new(0, 4)
	UICornerMin.Parent = MinimizeBtn

	-- İçerik Kaydırma Alanı
	local SettingsHolder = Instance.new("ScrollingFrame")
	SettingsHolder.Parent = Holder
	SettingsHolder.BackgroundTransparency = 1
	SettingsHolder.BorderSizePixel = 0
	SettingsHolder.Position = UDim2.new(0, 0, 0, 40)
	SettingsHolder.Size = UDim2.new(1, 0, 1, -40)
	SettingsHolder.ScrollBarImageColor3 = Color3.fromRGB(90, 40, 210)
	SettingsHolder.CanvasSize = UDim2.new(0, 0, 0, 620)
	SettingsHolder.ScrollBarThickness = 6

	local minimized = false
	MinimizeBtn.MouseButton1Click:Connect(function()
		minimized = not minimized
		local targetSize = minimized and UDim2.new(0, 280, 0, 35) or UDim2.new(0, 280, 0, 330)
		TweenService:Create(Holder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
		MinimizeBtn.Text = minimized and "+" or "-"
		SettingsHolder.Visible = not minimized
	end)

	-- Fonksiyon: Şık Modül Kutuları Oluşturma
	local function createModuleBox(name, posY, height)
		local box = Instance.new("Frame")
		box.Parent = SettingsHolder
		box.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
		box.BorderSizePixel = 0
		box.Position = UDim2.new(0, 8, 0, posY)
		box.Size = UDim2.new(1, -16, 0, height)
		
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 8)
		corner.Parent = box
		
		local label = Instance.new("TextLabel")
		label.Parent = box
		label.BackgroundTransparency = 1
		label.Position = UDim2.new(0, 10, 0, 5)
		label.Size = UDim2.new(1, -20, 0, 20)
		label.Font = Enum.Font.GothamBold
		label.TextSize = 13
		label.Text = name
		label.TextColor3 = Color3.fromRGB(220, 220, 230)
		label.TextXAlignment = Enum.TextXAlignment.Left
		
		return box
	end

	-- Fonksiyon: Akıcı Animasyonlu Butonlar
	local function createButton(parent, text, posY, color)
		local btn = Instance.new("TextButton")
		btn.Parent = parent
		btn.BackgroundColor3 = color or Color3.fromRGB(45, 45, 55)
		btn.BorderSizePixel = 0
		btn.Position = UDim2.new(0, 10, 0, posY)
		btn.Size = UDim2.new(1, -20, 0, 30)
		btn.Font = Enum.Font.GothamMedium
		btn.TextSize = 12
		btn.Text = text
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 6)
		corner.Parent = btn
		
		-- Üzerine gelince büyüme/renk animasyonu
		btn.MouseEnter:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(90, 40, 210)}):Play()
		end)
		btn.MouseLeave:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = color or Color3.fromRGB(45, 45, 55)}):Play()
		end)
		
		return btn
	end

	-- 1. TEMA SEÇİCİ
	local ThemeBox = createModuleBox("🎨 Tema Seçimi", 10, 65)
	local colorsList = {
		{Name = "Mor", Color = Color3.fromRGB(90, 40, 210)},
		{Name = "Kırmızı", Color = Color3.fromRGB(180, 40, 40)},
		{Name = "Mavi", Color = Color3.fromRGB(30, 100, 200)},
		{Name = "Yeşil", Color = Color3.fromRGB(40, 160, 70)},
		{Name = "Koyu", Color = Color3.fromRGB(30, 30, 35)}
	}
	for i, th in ipairs(colorsList) do
		local tBtn = Instance.new("TextButton")
		tBtn.Parent = ThemeBox
		tBtn.BackgroundColor3 = th.Color
		tBtn.Position = UDim2.new(0, 8 + ((i-1) * 49), 0, 28)
		tBtn.Size = UDim2.new(0, 45, 0, 28)
		tBtn.Font = Enum.Font.GothamBold
		tBtn.TextSize = 11
		tBtn.Text = th.Name
		tBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		
		local tc = Instance.new("UICorner")
		tc.CornerRadius = UDim.new(0, 6)
		tc.Parent = tBtn
		
		tBtn.MouseButton1Click:Connect(function()
			UIStrokeMain.Color = th.Color
			SettingsHolder.ScrollBarImageColor3 = th.Color
		end)
	end

	-- 2. HARİTA / SPAWN IŞINLANMA
	local MapBox = createModuleBox("🗺️ Harita / Spawn Işınlanma", 85, 60)
	local TPSpawnBtn = createButton(MapBox, "📍 Map Spawn / Lobby'ye Git", 25)
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
			root.CFrame = CFrame.new(0, 50, 0)
		end)
	end)

	-- 3. ROL IŞINLANMA & FLING
	local RoleBox = createModuleBox("⚔️ Rol Işınlanma & Fling", 155, 100)
	local FlingButton = createButton(RoleBox, "🌀 Fling Döngüsünü Aç/Kapat", 25)
	local TPMMButton = createButton(RoleBox, "🔪 Murderer'a Git", 60)
	local TPSHButton = createButton(RoleBox, "🛡️ Sheriff'e Git", 60)
	TPMMButton.Size = UDim2.new(0.48, -12, 0, 30)
	TPSHButton.Size = UDim2.new(0.48, -12, 0, 30)
	TPSHButton.Position = UDim2.new(0.5, 2, 0, 60)

	local flingActive = false
	FlingButton.MouseButton1Click:Connect(function()
		flingActive = not flingActive
		FlingButton.Text = flingActive and "🌀 Fling Aktif [ON]" or "🌀 Fling Döngüsünü Aç/Kapat"
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

	-- 4. ESP MENÜSÜ
	local ESPBox = createModuleBox("👁️ ESP Menüsü", 265, 140)
	local CoinESPBtn = createButton(ESPBox, "🪙 Coin ESP [OFF]", 25)
	local KnifeESPBtn = createButton(ESPBox, "🔪 Knife (Murderer) ESP [OFF]", 63)
	local GunESPBtn = createButton(ESPBox, "🔫 Gun (Sheriff) ESP [OFF]", 101)

	local coinESPActive = false
	CoinESPBtn.MouseButton1Click:Connect(function()
		coinESPActive = not coinESPActive
		CoinESPBtn.Text = coinESPActive and "🪙 Coin ESP [ON]" or "🪙 Coin ESP [OFF]"
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
		KnifeESPBtn.Text = knifeESPActive and "🔪 Knife ESP [ON]" or "🔪 Knife (Murderer) ESP [OFF]"
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
		GunESPBtn.Text = gunESPActive and "🔫 Gun ESP [ON]" or "🔫 Gun (Sheriff) ESP [OFF]"
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

	-- 5. AUTO FARM & HIZ
	local AFBox = createModuleBox("⚡ Auto Farm & Hız Kontrolü", 415, 110)
	local AFButton = createButton(AFBox, "💰 Auto Farm (Coin Topla) [OFF]", 25)
	
	local SpeedMinus = createButton(AFBox, "-", 65)
	SpeedMinus.Size = UDim2.new(0, 35, 0, 30)
	
	local SpeedDisplay = Instance.new("TextLabel")
	SpeedDisplay.Parent = AFBox
	SpeedDisplay.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
	SpeedDisplay.Position = UDim2.new(0, 50, 0, 65)
	SpeedDisplay.Size = UDim2.new(1, -100, 0, 30)
	SpeedDisplay.Font = Enum.Font.GothamBold
	SpeedDisplay.TextSize = 13
	SpeedDisplay.Text = "Hız: 16"
	SpeedDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
	
	local sc = Instance.new("UICorner")
	sc.CornerRadius = UDim.new(0, 6)
	sc.Parent = SpeedDisplay
	
	local SpeedPlus = createButton(AFBox, "+", 65)
	SpeedPlus.Position = UDim2.new(1, -45, 0, 65)
	SpeedPlus.Size = UDim2.new(0, 35, 0, 30)

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
		AFButton.Text = autoFarmActive and "💰 Auto Farm [AKTİF]" or "💰 Auto Farm (Coin Topla) [OFF]"
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

	print("✨ MM2 Ultra Hub v10 Başarıyla Başlatıldı!")
end
