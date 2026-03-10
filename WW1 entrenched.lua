--!strict
-- SCRIPT ENTRENCHED (WW1) PRO V10 - MANUS AI
-- Silent Aim Ultra, ESP 3D Adaptativo, Health Bar Dinâmica, Kill Tracker Laranja
-- Otimizado para Delta Executor (Mobile)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- ScreenGui Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Entrenched_V10_Pro"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999

-- ScreenGui para o ESP (Camada Superior)
local ESPGui = Instance.new("ScreenGui", CoreGui)
ESPGui.Name = "Entrenched_ESP_V10"
ESPGui.DisplayOrder = 999998
local ESPFolder = Instance.new("Folder", ESPGui)

-- Variáveis da UI
local UI_SIZE = UDim2.new(0, 360, 0, 520)
local UI_POSITION = UDim2.new(0.5, -180, 0.5, -260)
local COLOR_BG = Color3.fromRGB(15, 15, 15)
local COLOR_ACCENT = Color3.fromRGB(255, 0, 0)
local COLOR_BTN = Color3.fromRGB(45, 45, 45)
local COLOR_TEXT = Color3.fromRGB(255, 255, 255)
local COLOR_ENEMY = Color3.fromRGB(255, 0, 0)
local COLOR_REVENGE = Color3.fromRGB(0, 255, 0)
local COLOR_KILL = Color3.fromRGB(255, 165, 0) -- Laranja para quem você matou

-- Frame Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UI_SIZE
MainFrame.Position = UI_POSITION
MainFrame.BackgroundColor3 = COLOR_BG
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 12)
UICornerMain.Parent = MainFrame

-- Topbar
local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Size = UDim2.new(1, 0, 0, 50)
Topbar.BackgroundColor3 = COLOR_ACCENT
Topbar.BorderSizePixel = 0
Topbar.Parent = MainFrame

local UICornerTopbar = Instance.new("UICorner")
UICornerTopbar.CornerRadius = UDim.new(0, 12)
UICornerTopbar.Parent = Topbar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -110, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "ENTRENCHED PRO V10"
TitleLabel.TextColor3 = COLOR_TEXT
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.Parent = Topbar

-- Botões Topbar
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
MinimizeBtn.Position = UDim2.new(1, -95, 0.5, -20)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = COLOR_TEXT
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 30
MinimizeBtn.Parent = Topbar
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 8)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0.5, -20)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = COLOR_TEXT
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 22
CloseBtn.Parent = Topbar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

-- Conteúdo (Abas)
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, 0, 1, -50)
Content.Position = UDim2.new(0, 0, 0, 50)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

local TabFrame = Instance.new("Frame", Content)
TabFrame.Size = UDim2.new(1, 0, 0, 40)
TabFrame.BackgroundTransparency = 1
local TabList = Instance.new("UIListLayout", TabFrame)
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabList.Padding = UDim.new(0, 5)

local PageFrame = Instance.new("Frame", Content)
PageFrame.Size = UDim2.new(1, 0, 1, -40)
PageFrame.Position = UDim2.new(0, 0, 0, 40)
PageFrame.BackgroundTransparency = 1

local function createTab(name, isDefault)
    local btn = Instance.new("TextButton", TabFrame)
    btn.Size = UDim2.new(0.33, -5, 1, 0)
    btn.BackgroundColor3 = isDefault and COLOR_ACCENT or COLOR_BTN
    btn.Text = name
    btn.TextColor3 = COLOR_TEXT
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    local page = Instance.new("ScrollingFrame", PageFrame)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = isDefault
    page.CanvasSize = UDim2.new(0, 0, 0, 650)
    page.ScrollBarThickness = 0
    
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    Instance.new("UIPadding", page).PaddingTop = UDim.new(0, 15)
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(PageFrame:GetChildren()) do p.Visible = false end
        for _, b in pairs(TabFrame:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = COLOR_BTN end end
        page.Visible = true
        btn.BackgroundColor3 = COLOR_ACCENT
    end)
    return page
end

local mainPage = createTab("Main", true)
local visualPage = createTab("Visual", false)
local miscPage = createTab("Misc", false)

-- Estados
local aimbotLegitOn = false
local aimbotRageOn = false
local silentAimOn = false
local wallCheckOn = false
local predictionOn = false
local aimSmooth = 0.15
local aimFOV = 180

local espLinesOn = false
local espBoxOn = false
local espNameOn = false
local healthBarOn = false

local fullBrightOn = false
local customFOV = 70

local killerName = nil
local killerTime = 0
local killedPlayers = {} -- Lista de players que você matou {Name = Time}

-- Criar Toggle
local function createToggle(parent, text, defaultState, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 320, 0, 45)
    btn.BackgroundColor3 = defaultState and Color3.fromRGB(0, 160, 0) or COLOR_BTN
    btn.Text = text .. (defaultState and ": ON" or ": OFF")
    btn.TextColor3 = COLOR_TEXT
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    
    local state = defaultState
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and ": ON" or ": OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 160, 0) or COLOR_BTN
        callback(state)
    end)
end

-- Criar Slider FOV
local function createSlider(parent, text, min, max, default, callback)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(0, 320, 0, 60)
    container.BackgroundColor3 = COLOR_BTN
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 10)
    
    local label = Instance.new("TextLabel", container)
    label.Size = UDim2.new(1, 0, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default
    label.TextColor3 = COLOR_TEXT
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    
    local sliderBtn = Instance.new("TextButton", container)
    sliderBtn.Size = UDim2.new(0.9, 0, 0, 10)
    sliderBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
    sliderBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    sliderBtn.Text = ""
    Instance.new("UICorner", sliderBtn).CornerRadius = UDim.new(0, 5)
    
    local fill = Instance.new("Frame", sliderBtn)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = COLOR_ACCENT
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 5)
    
    local isMoving = false
    
    local function updateSlider(input)
        local relativePos = math.clamp((input.Position.X - sliderBtn.AbsolutePosition.X) / sliderBtn.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * relativePos)
        fill.Size = UDim2.new(relativePos, 0, 1, 0)
        label.Text = text .. ": " .. value
        callback(value)
    end

    sliderBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isMoving = true
            updateSlider(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isMoving and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isMoving = false
        end
    end)
end

-- MAIN TAB
createToggle(mainPage, "AIMBOT (LEGIT)", aimbotLegitOn, function(s) aimbotLegitOn = s end)
createToggle(mainPage, "AIMBOT (RAGE)", aimbotRageOn, function(s) aimbotRageOn = s end)
createToggle(mainPage, "SILENT AIM ULTRA", silentAimOn, function(s) silentAimOn = s end)
createToggle(mainPage, "WALL CHECK", wallCheckOn, function(s) wallCheckOn = s end)
createToggle(mainPage, "PREDICTION", predictionOn, function(s) predictionOn = s end)

-- VISUAL TAB
createToggle(visualPage, "ESP LINES (TOP)", espLinesOn, function(s) espLinesOn = s end)
createToggle(visualPage, "ESP BOX (3D STYLE)", espBoxOn, function(s) espBoxOn = s end)
createToggle(visualPage, "ESP NAME (RED)", espNameOn, function(s) espNameOn = s end)
createToggle(visualPage, "HEALTH BAR (ADAPTIVE)", healthBarOn, function(s) healthBarOn = s end)

-- MISC TAB
createToggle(miscPage, "FULL BRIGHT", fullBrightOn, function(s) fullBrightOn = s end)
createSlider(miscPage, "FIELD OF VIEW", 70, 120, customFOV, function(v) customFOV = v end)

-- Funções Auxiliares
local function isEnemy(p)
    if not p.Team or not LocalPlayer.Team then return true end
    return p.Team ~= LocalPlayer.Team
end

local function getTargetPart(char)
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head") or char:FindFirstChild("Torso")
end

-- Monitoramento de Mortes e Kills
LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.Died:Connect(function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local enemyHum = p.Character:FindFirstChild("Humanoid")
                if enemyHum and enemyHum.Health > 0 then
                    local dist = (getTargetPart(char).Position - getTargetPart(p.Character).Position).Magnitude
                    if dist < 150 then
                        killerName = p.Name
                        killerTime = tick()
                        break
                    end
                end
            end
        end
    end)
end)

-- Detectar se você matou alguém (Baseado na vida do inimigo zerando)
for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        p.CharacterAdded:Connect(function(char)
            local hum = char:WaitForChild("Humanoid")
            hum.Died:Connect(function()
                local dist = (getTargetPart(LocalPlayer.Character).Position - getTargetPart(char).Position).Magnitude
                if dist < 200 and UserInputService:IsMouseButtonPressed(Enum.MouseButton1) then
                    killedPlayers[p.Name] = tick()
                end
            end)
        end)
    end
end

-- Loop Principal
RunService.RenderStepped:Connect(function()
    ESPFolder:ClearAllChildren()
    
    if fullBrightOn then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    end
    Camera.FieldOfView = customFOV

    local myChar = LocalPlayer.Character
    if not myChar then return end
    local myRoot = getTargetPart(myChar)
    if not myRoot then return end

    local closestTarget = nil
    local minMouseDist = aimFOV
    local targetVelocity = Vector3.new(0,0,0)
    local targetIsMoving = false

    -- Limpar Status
    if killerName and tick() - killerTime > 35 then killerName = nil end
    for name, t in pairs(killedPlayers) do
        if tick() - t > 50 then killedPlayers[name] = nil end
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and isEnemy(p) then
            local char = p.Character
            local head = char:FindFirstChild("Head")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            
            if head and hrp and hum and hum.Health > 0 then
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                local screenPos = Vector2.new(pos.X, pos.Y)
                local mouseDist = (screenPos - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                local worldDist = (myRoot.Position - head.Position).Magnitude
                
                local isKiller = (killerName == p.Name)
                local isKilledByMe = (killedPlayers[p.Name] ~= nil)
                
                local drawColor = COLOR_ENEMY
                if isKiller then drawColor = COLOR_REVENGE
                elseif isKilledByMe then drawColor = COLOR_KILL end

                -- Aimbot Target Selection
                if (aimbotLegitOn or aimbotRageOn or (silentAimOn and UserInputService:IsMouseButtonPressed(Enum.MouseButton1))) and onScreen and mouseDist < minMouseDist then
                    local canAim = true
                    if wallCheckOn then
                        local rayParams = RaycastParams.new()
                        rayParams.FilterDescendantsInstances = {myChar, char}
                        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                        local rayResult = Workspace:Raycast(Camera.CFrame.Position, (head.Position - Camera.CFrame.Position).Unit * worldDist, rayParams)
                        if rayResult then canAim = false end
                    end
                    
                    if canAim then
                        minMouseDist = mouseDist
                        closestTarget = p
                        targetVelocity = hrp.AssemblyLinearVelocity or Vector3.new(0,0,0)
                        targetIsMoving = targetVelocity.Magnitude > 2
                    end
                end

                -- ESP Rendering (Independente do Aimbot)
                if onScreen then
                    local size = (1000 / pos.Z) * 2.5
                    
                    -- ESP LINES (TOP)
                    if espLinesOn then
                        local line = Instance.new("Frame", ESPFolder)
                        line.BackgroundColor3 = drawColor
                        line.BorderSizePixel = 0
                        local start = Vector2.new(Camera.ViewportSize.X / 2, 0)
                        local diff = screenPos - start
                        line.Size = UDim2.new(0, diff.Magnitude, 0, 1)
                        line.Position = UDim2.new(0, (start.X + screenPos.X) / 2, 0, (start.Y + screenPos.Y) / 2)
                        line.Rotation = math.deg(math.atan2(diff.Y, diff.X))
                        line.AnchorPoint = Vector2.new(0.5, 0.5)
                    end

                    -- ESP BOX (3D ADAPTIVE - CORRIGIDO PARA DISTÂNCIA)
                    if espBoxOn then
                        local box = Instance.new("Frame", ESPFolder)
                        box.Size = UDim2.new(0, size, 0, size * 1.5)
                        box.Position = UDim2.new(0, screenPos.X - size/2, 0, screenPos.Y - size/2)
                        box.BackgroundTransparency = 1
                        
                        local function createCorner(x, y, sx, sy)
                            local c = Instance.new("Frame", box)
                            c.BackgroundColor3 = drawColor
                            c.BorderSizePixel = 0
                            c.Position = UDim2.new(x, 0, y, 0)
                            c.Size = UDim2.new(sx, 0, sy, 0)
                        end
                        createCorner(0,0,0.25,0.02) createCorner(0,0,0.02,0.25)
                        createCorner(0.75,0,0.25,0.02) createCorner(0.98,0,0.02,0.25)
                        createCorner(0,0.98,0.25,0.02) createCorner(0,0.75,0.02,0.25)
                        createCorner(0.75,0.98,0.25,0.02) createCorner(0.98,0.75,0.02,0.25)
                    end

                    -- HEALTH BAR (ADAPTIVE: FINA E LONGA DE LONGE)
                    if healthBarOn then
                        local barWidth = math.clamp(4 - (worldDist / 100), 1, 3) -- Fica mais fina de longe
                        local barHeight = size * 1.5
                        
                        local barBg = Instance.new("Frame", ESPFolder)
                        barBg.Size = UDim2.new(0, barWidth, 0, barHeight)
                        barBg.Position = UDim2.new(0, screenPos.X - (size/2) - (barWidth + 4), 0, screenPos.Y - size/2)
                        barBg.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
                        barBg.BorderSizePixel = 0
                        
                        local healthPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                        local bar = Instance.new("Frame", barBg)
                        bar.Size = UDim2.new(1, 0, healthPercent, 0)
                        bar.Position = UDim2.new(0, 0, 1 - healthPercent, 0)
                        bar.BorderSizePixel = 0
                        bar.BackgroundColor3 = Color3.fromHSV(healthPercent * 0.3, 1, 1)
                    end

                    -- ESP NAME (DEBAIXO DA TERRA)
                    if espNameOn then
                        local label = Instance.new("TextLabel", ESPFolder)
                        label.Size = UDim2.new(0, 100, 0, 20)
                        label.Position = UDim2.new(0, screenPos.X - 50, 0, screenPos.Y + (size/2) + 5)
                        label.BackgroundTransparency = 1
                        label.Text = p.Name .. " [" .. math.floor(worldDist) .. "]"
                        label.TextColor3 = drawColor
                        label.Font = Enum.Font.GothamBold
                        label.TextSize = 12
                        label.TextStrokeTransparency = 0
                    end
                end
            end
        end
    end

    -- SMART AIM EXECUTION
    if closestTarget and closestTarget.Character then
        local char = closestTarget.Character
        local head = char:FindFirstChild("Head")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        if head and hrp then
            local worldDist = (myRoot.Position - head.Position).Magnitude
            local targetPos = head.Position
            
            -- Lógica Inteligente
            if worldDist > 200 then
                if targetIsMoving then targetPos = hrp.Position else targetPos = head.Position end
            else targetPos = head.Position end

            -- PREDICTION ULTRA
            if predictionOn then
                local projectileSpeed = 1300 -- Ajustado
                local timeToReach = (Camera.CFrame.Position - targetPos).Magnitude / projectileSpeed
                targetPos = targetPos + (targetVelocity * timeToReach)
            end
            
            local targetCFrame = CFrame.new(Camera.CFrame.Position, targetPos)
            
            if aimbotRageOn then Camera.CFrame = targetCFrame
            elseif aimbotLegitOn or silentAimOn then
                local smooth = silentAimOn and 0.45 or aimSmooth
                Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, smooth)
            end
        end
    end
end)

-- Arraste Mobile
local dragging, dragStart, startPos
Topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    Content.Visible = not Content.Visible
    MainFrame.Size = Content.Visible and UI_SIZE or UDim2.new(0, 360, 0, 50)
end)

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() ESPGui:Destroy() end)

print("Entrenched WW1 PRO V10 GOD MODE Loaded!")

