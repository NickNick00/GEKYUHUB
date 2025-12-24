-- Script: GEKYU | DUELS (CORREÇÕES FINAIS - CORES TEAM 100% + INPUT MOBILE + AIMBOT SEM CONFLITO)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- Configurações
local CONFIG = {
    ESPEnabled = false,
    HitboxEnabled = false,
    HitboxVisualEnabled = false,
    HitboxSize = Vector3.new(10, 10, 10),
    AimbotEnabled = false,
    MaxESPDistance = 500
}

-- Tabelas cleanup
local ESPs = {}
local originalSizes = {}

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GekyuUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 420)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.45
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 10
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 18)
UICorner.Parent = MainFrame

-- Botões topo
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.new(1, 1, 1)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.new(0, 0, 0)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.ZIndex = 12
MinimizeButton.Parent = MainFrame

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 15)
MinCorner.Parent = MinimizeButton

local DestroyButton = Instance.new("TextButton")
DestroyButton.Size = UDim2.new(0, 30, 0, 30)
DestroyButton.Position = UDim2.new(1, -35, 0, 5)
DestroyButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
DestroyButton.Text = "X"
DestroyButton.TextColor3 = Color3.new(1, 1, 1)
DestroyButton.Font = Enum.Font.GothamBold
DestroyButton.TextSize = 18
DestroyButton.ZIndex = 12
DestroyButton.Parent = MainFrame

local DestroyCorner = Instance.new("UICorner")
DestroyCorner.CornerRadius = UDim.new(0, 15)
DestroyCorner.Parent = DestroyButton

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "GEKYU | DUELS"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.ZIndex = 11
Title.Parent = MainFrame

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -40, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 35)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Assassinos-sheriffs"
SubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SubTitle.TextTransparency = 0.85
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 12
SubTitle.ZIndex = 11
SubTitle.Parent = MainFrame

-- Toggle padrão
local function createToggleButton(name, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 55)
    btn.Position = UDim2.new(0.05, 0, posY, 0)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.ZIndex = 15
    btn.Parent = MainFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = btn
    
    local state = false
    btn.Activated:Connect(function()
        state = not state
        btn.Text = name .. ": " .. (state and "ON" or "OFF")
        if state then
            btn.BackgroundColor3 = Color3.new(1, 1, 1)
            btn.TextColor3 = Color3.new(0, 0, 0)
        else
            btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            btn.TextColor3 = Color3.new(1, 1, 1)
        end
        callback(state)
    end)
    
    return btn
end

-- Hitbox combinado
local HitboxMainButton = Instance.new("TextButton")
HitboxMainButton.Size = UDim2.new(0.65, 0, 0, 55)
HitboxMainButton.Position = UDim2.new(0.05, 0, 0.28, 0)
HitboxMainButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
HitboxMainButton.Text = "Hitbox: OFF"
HitboxMainButton.TextColor3 = Color3.new(1, 1, 1)
HitboxMainButton.Font = Enum.Font.GothamBold
HitboxMainButton.TextSize = 18
HitboxMainButton.ZIndex = 15
HitboxMainButton.Parent = MainFrame

local HitboxCorner = Instance.new("UICorner")
HitboxCorner.CornerRadius = UDim.new(0, 12)
HitboxCorner.Parent = HitboxMainButton

local VisualToggle = Instance.new("TextButton")
VisualToggle.Size = UDim2.new(0.2, 0, 0, 55)
VisualToggle.Position = UDim2.new(0.75, 0, 0.28, 0)
VisualToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
VisualToggle.Text = "VISUAL"
VisualToggle.TextColor3 = Color3.new(1, 1, 1)
VisualToggle.Font = Enum.Font.GothamBold
VisualToggle.TextSize = 14
VisualToggle.ZIndex = 15
VisualToggle.Parent = MainFrame

local VisualCorner = Instance.new("UICorner")
VisualCorner.CornerRadius = UDim.new(0, 12)
VisualCorner.Parent = VisualToggle

local hitboxState = false
local visualState = false

HitboxMainButton.Activated:Connect(function()
    hitboxState = not hitboxState
    HitboxMainButton.Text = "Hitbox: " .. (hitboxState and "ON" or "OFF")
    if hitboxState then
        HitboxMainButton.BackgroundColor3 = Color3.new(1, 1, 1)
        HitboxMainButton.TextColor3 = Color3.new(0, 0, 0)
    else
        HitboxMainButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        HitboxMainButton.TextColor3 = Color3.new(1, 1, 1)
        visualState = false
        VisualToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        VisualToggle.TextColor3 = Color3.new(1, 1, 1)
    end
    CONFIG.HitboxEnabled = hitboxState
    CONFIG.HitboxVisualEnabled = visualState
    updateHitboxes()
end)

VisualToggle.Activated:Connect(function()
    if not hitboxState then return end
    visualState = not visualState
    if visualState then
        VisualToggle.BackgroundColor3 = Color3.new(1, 1, 1)
        VisualToggle.TextColor3 = Color3.new(0, 0, 0)
    else
        VisualToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        VisualToggle.TextColor3 = Color3.new(1, 1, 1)
    end
    CONFIG.HitboxVisualEnabled = visualState
    updateHitboxes()
end)

-- Input Hitbox Size (corrigido para mobile)
local SizeLabel = Instance.new("TextLabel")
SizeLabel.Size = UDim2.new(0.9, 0, 0, 30)
SizeLabel.Position = UDim2.new(0.05, 0, 0.41, 0)
SizeLabel.BackgroundTransparency = 1
SizeLabel.Text = "Hitbox Size: 10"
SizeLabel.TextColor3 = Color3.new(1,1,1)
SizeLabel.Font = Enum.Font.GothamBold
SizeLabel.TextSize = 16
SizeLabel.Parent = MainFrame

local SizeBox = Instance.new("TextBox")
SizeBox.Size = UDim2.new(0.9, 0, 0, 40)
SizeBox.Position = UDim2.new(0.05, 0, 0.48, 0)
SizeBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SizeBox.PlaceholderText = "Digite o tamanho (1-200)"
SizeBox.ClearTextOnFocus = false  -- importante para mobile aparecer teclado
SizeBox.Text = "10"
SizeBox.TextColor3 = Color3.new(1,1,1)
SizeBox.Font = Enum.Font.Gotham
SizeBox.TextSize = 16
SizeBox.Parent = MainFrame

local SizeCorner = Instance.new("UICorner")
SizeCorner.CornerRadius = UDim.new(0, 10)
SizeCorner.Parent = SizeBox

SizeBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local num = tonumber(SizeBox.Text)
        if num and num >= 1 and num <= 200 then
            CONFIG.HitboxSize = Vector3.new(num, num, num)
            SizeLabel.Text = "Hitbox Size: " .. num
            if CONFIG.HitboxEnabled then updateHitboxes() end
        else
            SizeBox.Text = tostring(CONFIG.HitboxSize.X)
        end
    end
end)

-- Botões restantes
local ESPButton = createToggleButton("ESP", 0.15, function(state) CONFIG.ESPEnabled = state end)

local AimbotButton = createToggleButton("Aimbot", 0.60, function(state) 
    CONFIG.AimbotEnabled = state 
    -- Não desativa hitbox ao ativar aimbot
end)

-- Minimizar
MinimizeButton.Activated:Connect(function()
    if MainFrame.Size.Y.Offset == 60 then
        MainFrame:TweenSize(UDim2.new(0, 260, 0, 420), "Out", "Quad", 0.3)
        MinimizeButton.Text = "-"
        for _, child in pairs(MainFrame:GetChildren()) do
            if child:IsA("GuiObject") and child ~= MinimizeButton and child ~= DestroyButton and child ~= Title and child ~= SubTitle then
                child.Visible = true
            end
        end
    else
        MainFrame:TweenSize(UDim2.new(0, 260, 0, 60), "Out", "Quad", 0.3)
        MinimizeButton.Text = "+"
        for _, child in pairs(MainFrame:GetChildren()) do
            if child:IsA("GuiObject") and child ~= MinimizeButton and child ~= DestroyButton and child ~= Title and child ~= SubTitle then
                child.Visible = false
            end
        end
    end
end)

-- ESP CORRIGIDO 100% (cores azul/vermelho imediatas e permanentes)
local function createOrUpdateESP(plr)
    if plr == player or not plr.Character then return end

    local highlight = ESPs[plr]
    if not highlight or not highlight.Parent then
        highlight = Instance.new("Highlight")
        highlight.Name = "DuelESP"
        highlight.Adornee = plr.Character
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.Parent = plr.Character
        ESPs[plr] = highlight
    end
    highlight.Adornee = plr.Character
end

local function updateESPColors()
    if not CONFIG.ESPEnabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        for _, hl in pairs(ESPs) do
            hl.Enabled = false
        end
        return
    end

    for plr, hl in pairs(ESPs) do
        if plr.Parent and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            hl.Enabled = dist <= CONFIG.MaxESPDistance

            if hl.Enabled then
                local myTeam = player.Team
                local theirTeam = plr.Team
                if myTeam and theirTeam then
                    if myTeam == theirTeam then
                        hl.FillColor = Color3.fromRGB(80, 160, 255)  -- Azul aliados
                    else
                        hl.FillColor = Color3.fromRGB(255, 70, 70)   -- Vermelho inimigos
                    end
                else
                    hl.FillColor = Color3.fromRGB(200, 200, 200)  -- Cinza lobby
                end
            end
        else
            hl.Enabled = false
        end
    end
end

-- Hitbox
local function applyHitbox(plr)
    if plr == player or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = plr.Character.HumanoidRootPart
    local key = plr.UserId

    if CONFIG.HitboxEnabled then
        if not originalSizes[key] then originalSizes[key] = hrp.Size end
        hrp.Size = CONFIG.HitboxSize
        hrp.CanCollide = false
        hrp.Material = Enum.Material.ForceField
        hrp.Color = Color3.fromRGB(255, 50, 50)
        hrp.Transparency = CONFIG.HitboxVisualEnabled and 0.5 or 1
    else
        if originalSizes[key] then
            hrp.Size = originalSizes[key]
            originalSizes[key] = nil
        end
        hrp.Transparency = 1
        hrp.Material = Enum.Material.Plastic
        hrp.CanCollide = false
    end
end

function updateHitboxes()
    for _, plr in pairs(Players:GetPlayers()) do
        applyHitbox(plr)
    end
end

-- Aimbot (sem conflito com hitbox)
local function getBestTarget()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") or not player.Team then return nil end
    local myPos = player.Character.HumanoidRootPart.Position
    local closest = nil
    local closestDist = math.huge

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") and plr.Team and plr.Team ~= player.Team then
            local head = plr.Character.Head
            local dist = (head.Position - myPos).Magnitude
            if dist < 300 and dist < closestDist then
                closest = head
                closestDist = dist
            end
        end
    end
    return closest
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed or not CONFIG.AimbotEnabled then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        local target = getBestTarget()
        if target then
            local velocity = target.AssemblyLinearVelocity or Vector3.zero
            local predicted = target.Position + velocity * 0.14
            camera.CFrame = CFrame.lookAt(camera.CFrame.Position, predicted)
        end
    end
end)

-- Conexões
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(1)
        createOrUpdateESP(plr)
        applyHitbox(plr)
    end)
    plr:GetPropertyChangedSignal("Team"):Connect(updateESPColors)
end)

player:GetPropertyChangedSignal("Team"):Connect(updateESPColors)

Players.PlayerRemoving:Connect(function(plr)
    if ESPs[plr] then ESPs[plr]:Destroy() ESPs[plr] = nil end
    originalSizes[plr.UserId] = nil
end)

for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= player then
        createOrUpdateESP(plr)
        if plr.Character then applyHitbox(plr) end
        plr.CharacterAdded:Connect(function()
            task.wait(1)
            createOrUpdateESP(plr)
            applyHitbox(plr)
        end)
    end
end

-- Loop atualização
RunService.Heartbeat:Connect(function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            createOrUpdateESP(plr)
        end
    end
    updateESPColors()
end)

-- Destroy limpa tudo
DestroyButton.Activated:Connect(function()
    CONFIG.HitboxEnabled = false
    updateHitboxes()
    for _, hl in pairs(ESPs) do if hl and hl.Parent then hl:Destroy() end end
    ESPs = {}
    originalSizes = {}
    ScreenGui:Destroy()
end)

print("[GEKYU | DUELS] Versão corrigida carregada! ESP com cores azul/vermelho corretas instantaneamente, input funciona no mobile, aimbot não desativa hitbox.")
