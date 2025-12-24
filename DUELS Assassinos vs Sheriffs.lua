-- Script: Murderers vs Sheriffs Duels - ESP + Hitbox + Aimbot (ESP 100% CORRIGIDO COM TeamBlue/TeamRed)
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
    HitboxVisible = false,
    HitboxSize = Vector3.new(5, 6, 5),
    AimbotEnabled = false,
    MaxESPDistance = 300
}

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DuelUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 330)
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -165)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 10
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 18)
UICorner.Parent = MainFrame

local ModalFix = Instance.new("TextButton")
ModalFix.Size = UDim2.new(1, 0, 1, 0)
ModalFix.BackgroundTransparency = 1
ModalFix.Text = ""
ModalFix.Modal = true
ModalFix.Parent = MainFrame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.new(1,1,1)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.ZIndex = 12
MinimizeButton.Parent = MainFrame

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 15)
MinCorner.Parent = MinimizeButton

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MvS Duels Cheat"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.ZIndex = 11
Title.Parent = MainFrame

local function createToggleButton(name, posY, onColor, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 50)
    btn.Position = UDim2.new(0.05, 0, posY, 0)
    btn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.new(1,1,1)
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
        btn.BackgroundColor3 = state and onColor or Color3.fromRGB(255, 80, 80)
        callback(state)
    end)
    
    return btn
end

local ESPButton = createToggleButton("ESP", 0.15, Color3.fromRGB(255, 215, 0), function(state) CONFIG.ESPEnabled = state end)
local HitboxButton = createToggleButton("Hitbox", 0.30, Color3.fromRGB(255, 100, 100), function(state) 
    CONFIG.HitboxEnabled = state 
    updateHitboxes() 
end)
local VisualButton = createToggleButton("Hitbox Visual", 0.45, Color3.fromRGB(200, 0, 0), function(state) 
    CONFIG.HitboxVisible = state 
    updateHitboxes() 
end)
local AimbotButton = createToggleButton("Aimbot", 0.60, Color3.fromRGB(100, 255, 100), function(state) CONFIG.AimbotEnabled = state end)

MinimizeButton.Activated:Connect(function()
    if MainFrame.Size.Y.Offset == 50 then
        MainFrame:TweenSize(UDim2.new(0, 240, 0, 330), "Out", "Quad", 0.3)
        MinimizeButton.Text = "-"
        ESPButton.Visible = true
        HitboxButton.Visible = true
        VisualButton.Visible = true
        AimbotButton.Visible = true
    else
        MainFrame:TweenSize(UDim2.new(0, 240, 0, 50), "Out", "Quad", 0.3)
        MinimizeButton.Text = "+"
        ESPButton.Visible = false
        HitboxButton.Visible = false
        VisualButton.Visible = false
        AimbotButton.Visible = false
    end
end)

-- ESP CORRETO: Detecta TeamBlue / TeamRed pelo nome do time
local ESPs = {}

local function createESP(plr)
    if plr == player or not plr.Character then return end
    local highlight = plr.Character:FindFirstChild("DuelESP")
    if highlight then highlight:Destroy() end

    highlight = Instance.new("Highlight")
    highlight.Name = "DuelESP"
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillTransparency = 0.7
    highlight.OutlineTransparency = 0.3
    highlight.Parent = plr.Character
    ESPs[plr] = highlight
end

local function updateESP(plr)
    if not ESPs[plr] or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local highlight = ESPs[plr]
    local distance = (plr.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
    
    if distance > CONFIG.MaxESPDistance or not CONFIG.ESPEnabled then
        highlight.Enabled = false
        return
    end

    highlight.Enabled = true

    local playerTeamName = player.Team and player.Team.Name or nil
    local plrTeamName = plr.Team and plr.Team.Name or nil

    if playerTeamName == nil or plrTeamName == nil then  -- Lobby
        highlight.FillColor = Color3.fromRGB(255, 255, 255)
        highlight.OutlineColor = Color3.fromRGB(200, 200, 200)
    else
        -- Compara nomes exatos: TeamBlue vs TeamRed
        local isSameTeam = (playerTeamName == "TeamBlue" and plrTeamName == "TeamBlue") or 
                           (playerTeamName == "TeamRed" and plrTeamName == "TeamRed")
        
        if isSameTeam then
            -- Aliado: azul claro
            highlight.FillColor = Color3.fromRGB(100, 200, 255)
            highlight.OutlineColor = Color3.fromRGB(0, 150, 255)
        else
            -- Inimigo: vermelho
            highlight.FillColor = Color3.fromRGB(255, 100, 100)
            highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
            highlight.FillTransparency = 0.6
        end
    end
end

-- Hitbox (mantido)
local originalSizes = {}

local function applyHitbox(plr)
    if plr == player or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = plr.Character.HumanoidRootPart
    local key = plr.UserId

    if CONFIG.HitboxEnabled then
        if not originalSizes[key] then
            originalSizes[key] = hrp.Size
        end
        hrp.Size = CONFIG.HitboxSize
        hrp.Transparency = CONFIG.HitboxVisible and 0.4 or 1
        hrp.Color = Color3.fromRGB(255, 50, 50)
        hrp.Material = Enum.Material.ForceField
        hrp.CanCollide = false
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

local function updateHitboxes()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            applyHitbox(plr)
        end
    end
end

-- Aimbot (mantido)
local function getBestTarget()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = player.Character.HumanoidRootPart.Position
    local closest, closestDist = nil, math.huge

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Team and plr.Team ~= player.Team then
            local torso = plr.Character.HumanoidRootPart
            local dist = (torso.Position - myPos).Magnitude
            if dist < 200 and dist < closestDist then
                closest = torso
                closestDist = dist
            end
        end
    end
    return closest
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 and CONFIG.AimbotEnabled then
        local target = getBestTarget()
        if target then
            local predicted = target.Position + target.AssemblyLinearVelocity * 0.12
            camera.CFrame = CFrame.new(camera.CFrame.Position, predicted)
        end
    end
end)

-- Conexões
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(1)
        createESP(plr)
        applyHitbox(plr)
    end)
end)

for _, plr in pairs(Players:GetPlayers()) do
    if plr.Character then
        task.wait(0.5)
        createESP(plr)
        applyHitbox(plr)
    end
    plr.CharacterAdded:Connect(function()
        task.wait(1)
        createESP(plr)
        applyHitbox(plr)
    end)
end

player.CharacterAdded:Connect(function()
    task.wait(1)
    updateHitboxes()
end)

RunService.Heartbeat:Connect(function()
    for plr, _ in pairs(ESPs) do
        if plr.Parent then
            updateESP(plr)
        else
            ESPs[plr] = nil
        end
    end
    if CONFIG.HitboxEnabled then
        updateHitboxes()
    end
end)

print("[MvS Duels] ESP 100% CORRIGIDO: Detecta TeamBlue/TeamRed pelo nome exato - Aliados azul, Inimigos vermelho!")
