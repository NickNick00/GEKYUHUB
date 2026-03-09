--!strict
-- SCRIPT ENTRENCHED (WW1) PRO V6 - MANUS AI
-- Silent Aim, Aimbot Rage/Legit, Health Bar Corrigido, Aba Misc (Full Bright, FOV)
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
ScreenGui.Name = "Entrenched_V6_Pro"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999

-- ScreenGui para o ESP (Camada Superior)
local ESPGui = Instance.new("ScreenGui", CoreGui)
ESPGui.Name = "Entrenched_ESP_V6"
ESPGui.DisplayOrder = 999998
local ESPFolder = Instance.new("Folder", ESPGui)

-- Variáveis da UI
local UI_SIZE = UDim2.new(0, 360, 0, 520)
local UI_POSITION = UDim2.new(0.5, -180, 0.5, -260)
local COLOR_BG = Color3.fromRGB(12, 12, 12)
local COLOR_ACCENT = Color3.fromRGB(255, 0, 0)
local COLOR_BTN = Color3.fromRGB(40, 40, 40)
local COLOR_TEXT = Color3.fromRGB(255, 255, 255)
local COLOR_ENEMY = Color3.fromRGB(255, 0, 0)

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
TitleLabel.Text = "ENTRENCHED PRO V6"
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
local aimSmooth = 0.12
local aimFOV = 180

local espLinesOn = false
local espBoxOn = false
local espNameOn = false
local healthBarOn = false
local bulletTracerOn = false

local fullBrightOn = false
local customFOV = 70

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

-- Criar Slider Simples para FOV
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
    
    sliderBtn.MouseButton1Down:Connect(function()
        local connection
        connection = RunService.RenderStepped:Connect(function()
            local mousePos = UserInputService:GetMouseLocation().X
            local relativePos = math.clamp((mousePos - sliderBtn.AbsolutePosition.X) / sliderBtn.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * relativePos)
            fill.Size = UDim2.new(relativePos, 0, 1, 0)
            label.Text = text .. ": " .. value
            callback(value)
            if not UserInputService:IsMouseButtonPressed(Enum.MouseButton1) then
                connection:Disconnect()
            end
        end)
    end)
end

-- MAIN TAB
createToggle(mainPage, "AIMBOT (LEGIT)", aimbotLegitOn, function(s) aimbotLegitOn = s end)
createToggle(mainPage, "AIMBOT (RAGE)", aimbotRageOn, function(s) aimbotRageOn = s end)
createToggle(mainPage, "SILENT AIM", silentAimOn, function(s) silentAimOn = s end)
createToggle(mainPage, "WALL CHECK", wallCheckOn, function(s) wallCheckOn = s end)
createToggle(mainPage, "PREDICTION", predictionOn, function(s) predictionOn = s end)

-- VISUAL TAB
createToggle(visualPage, "ESP LINES (TOP)", espLinesOn, function(s) espLinesOn = s end)
createToggle(visualPage, "ESP BOX (CEGO STYLE)", espBoxOn, function(s) espBoxOn = s end)
createToggle(visualPage, "ESP NAME (RED)", espNameOn, function(s) espNameOn = s end)
createToggle(visualPage, "HEALTH BAR", healthBarOn, function(s) healthBarOn = s end)
createToggle(visualPage, "BULLET TRACERS", bulletTracerOn, function(s) bulletTracerOn = s end)

-- MISC TAB
createToggle(miscPage, "FULL BRIGHT", fullBrightOn, function(s) fullBrightOn = s end)
createSlider(miscPage, "FIELD OF VIEW", 70, 120, customFOV, function(v) customFOV = v end)

-- Funções Auxiliares
local function isEnemy(p)
    if not p.Team or not LocalPlayer.Team then return true end
    return p.Team ~= LocalPlayer.Team
end

local function getTargetPart(char)
    return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

-- Loop Principal
RunService.RenderStepped:Connect(function()
    ESPFolder:ClearAllChildren()
    
    -- Full Bright & FOV Logic
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

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and isEnemy(p) then
            local char = p.Character
            local head = getTargetPart(char)
            local hum = char:FindFirstChildOfClass("Humanoid")
            
            if head and hum and hum.Health > 0 then
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                local screenPos = Vector2.new(pos.X, pos.Y)
                local mouseDist = (screenPos - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                local worldDist = (myRoot.Position - head.Position).Magnitude

                -- Aimbot Target Selection
                if (aimbotLegitOn or aimbotRageOn or silentAimOn) and onScreen and mouseDist < minMouseDist then
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
                        closestTarget = head
                        targetVelocity = head.AssemblyLinearVelocity or Vector3.new(0,0,0)
                    end
                end

                -- ESP Rendering (CORRIGIDO: CENTRALIZADO NO CORPO)
                if onScreen then
                    local size = (1000 / pos.Z) * 2.5
                    
                    -- ESP LINES (TOP)
                    if espLinesOn then
                        local line = Instance.new("Frame", ESPFolder)
                        line.BackgroundColor3 = COLOR_ENEMY
                        line.BorderSizePixel = 0
                        local start = Vector2.new(Camera.ViewportSize.X / 2, 0)
                        local diff = screenPos - start
                        line.Size = UDim2.new(0, diff.Magnitude, 0, 1)
                        line.Position = UDim2.new(0, (start.X + screenPos.X) / 2, 0, (start.Y + screenPos.Y) / 2)
                        line.Rotation = math.deg(math.atan2(diff.Y, diff.X))
                        line.AnchorPoint = Vector2.new(0.5, 0.5)
                    end

                    -- ESP BOX (CEGO STYLE - CORRIGIDO)
                    if espBoxOn then
                        local box = Instance.new("Frame", ESPFolder)
                        box.Size = UDim2.new(0, size, 0, size * 1.5)
                        box.Position = UDim2.new(0, screenPos.X - size/2, 0, screenPos.Y - size/4) -- Ajuste de altura
                        box.BackgroundTransparency = 1
                        
                        local function createCorner(x, y, sx, sy)
                            local c = Instance.new("Frame", box)
                            c.BackgroundColor3 = COLOR_ENEMY
                            c.BorderSizePixel = 0
                            c.Position = UDim2.new(x, 0, y, 0)
                            c.Size = UDim2.new(sx, 0, sy, 0)
                        end
                        createCorner(0,0,0.25,0.02) createCorner(0,0,0.02,0.25) -- Top Left
                        createCorner(0.75,0,0.25,0.02) createCorner(0.98,0,0.02,0.25) -- Top Right
                        createCorner(0,0.98,0.25,0.02) createCorner(0,0.75,0.02,0.25) -- Bottom Left
                        createCorner(0.75,0.98,0.25,0.02) createCorner(0.98,0.75,0.02,0.25) -- Bottom Right
                    end

                    -- HEALTH BAR (CORRIGIDO)
                    if healthBarOn then
                        local barBg = Instance.new("Frame", ESPFolder)
                        barBg.Size = UDim2.new(0, 4, 0, size * 1.5)
                        barBg.Position = UDim2.new(0, screenPos.X - (size/2) - 8, 0, screenPos.Y - size/4)
                        barBg.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
                        barBg.BorderSizePixel = 0
                        
                        local healthPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                        local bar = Instance.new("Frame", barBg)
                        bar.Size = UDim2.new(1, 0, healthPercent, 0)
                        bar.Position = UDim2.new(0, 0, 1 - healthPercent, 0)
                        bar.BorderSizePixel = 0
                        bar.BackgroundColor3 = Color3.fromHSV(healthPercent * 0.3, 1, 1)
                    end

                    -- ESP NAME (RED)
                    if espNameOn then
                        local label = Instance.new("TextLabel", ESPFolder)
                        label.Size = UDim2.new(0, 100, 0, 20)
                        label.Position = UDim2.new(0, screenPos.X - 50, 0, screenPos.Y - (1000/pos.Z) - 25)
                        label.BackgroundTransparency = 1
                        label.Text = p.Name .. " [" .. math.floor(worldDist) .. "]"
                        label.TextColor3 = COLOR_ENEMY
                        label.Font = Enum.Font.GothamBold
                        label.TextSize = 12
                        label.TextStrokeTransparency = 0
                    end
                end
            end
        end
    end

    -- Aimbot & Silent Aim Execution
    if closestTarget then
        local targetPos = closestTarget.Position
        
        -- PREDICTION (REFEITO)
        if predictionOn then
            local timeToReach = (Camera.CFrame.Position - targetPos).Magnitude / 1200 -- Ajustado para Entrenched
            targetPos = targetPos + (targetVelocity * timeToReach)
        end
        
        local targetCFrame = CFrame.new(Camera.CFrame.Position, targetPos)
        
        if silentAimOn then
            -- SILENT AIM: Redireciona disparos sem mover a câmera drasticamente
            -- (Simulado através de CFrame manipulação no Delta)
            if UserInputService:IsMouseButtonPressed(Enum.MouseButton1) then
                Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, 0.4)
            end
        elseif aimbotRageOn then
            Camera.CFrame = targetCFrame
        elseif aimbotLegitOn then
            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, aimSmooth)
        end

        -- BULLET TRACERS
        if bulletTracerOn and UserInputService:IsMouseButtonPressed(Enum.MouseButton1) then
            local tracer = Instance.new("Part", Workspace)
            tracer.Anchored = true
            tracer.CanCollide = false
            tracer.Size = Vector3.new(0.1, 0.1, (myRoot.Position - targetPos).Magnitude)
            tracer.CFrame = CFrame.new(myRoot.Position:Lerp(targetPos, 0.5), targetPos)
            tracer.Color = COLOR_ACCENT
            tracer.Material = Enum.Material.Neon
            task.delay(0.1, function() tracer:Destroy() end)
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

print("Entrenched WW1 PRO V6 FINAL Loaded!")

