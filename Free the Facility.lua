-- GEKYU HUB | Free The Facility (DRAG CORRIGIDO E TOTALMENTE FUNCIONAL)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- Configurações
local CONFIG = {
    SpeedValue = 16,
    ESPPlayersBeast = false,
    ESPInnocents = false,
    ESPExitDoors = false,
    ESPComputers = false,
    ESPCapsules = false
}

-- Tabelas para ESP
local ESPs = {}
local NameTags = {}
local lastUpdate = 0
local updateInterval = 0.5 -- Atualiza a cada 0.5 segundos para reduzir lag

-- GUI Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GekyuHubFTF"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.45
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 10
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 18)
MainCorner.Parent = MainFrame

-- Barra Lateral Esquerda (Abas)
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0, 70, 1, 0)
TabBar.Position = UDim2.new(0, 0, 0, 0)
TabBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TabBar.BackgroundTransparency = 0.45
TabBar.BorderSizePixel = 0
TabBar.ZIndex = 11
TabBar.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 18)
TabCorner.Parent = TabBar

-- Área de Conteúdo
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -70, 1, -60)
ContentFrame.Position = UDim2.new(0, 70, 0, 60)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ZIndex = 11
ContentFrame.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -120, 0, 50)
Title.Position = UDim2.new(0, 75, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "GEKYU | FTF"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 12
Title.Parent = MainFrame

-- Botões topo direito
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 15)
MinimizeButton.BackgroundColor3 = Color3.new(1, 1, 1)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.new(0, 0, 0)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.ZIndex = 15
MinimizeButton.Parent = MainFrame

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 15)
MinCorner.Parent = MinimizeButton

local DestroyButton = Instance.new("TextButton")
DestroyButton.Size = UDim2.new(0, 30, 0, 30)
DestroyButton.Position = UDim2.new(1, -35, 0, 15)
DestroyButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
DestroyButton.Text = "X"
DestroyButton.TextColor3 = Color3.new(1, 1, 1)
DestroyButton.Font = Enum.Font.GothamBold
DestroyButton.TextSize = 18
DestroyButton.ZIndex = 15
DestroyButton.Parent = MainFrame

local DestroyCorner = Instance.new("UICorner")
DestroyCorner.CornerRadius = UDim.new(0, 15)
DestroyCorner.Parent = DestroyButton

-- Modal Fix (para não perder foco)
local ModalFix = Instance.new("TextButton")
ModalFix.Size = UDim2.new(1, 0, 1, 0)
ModalFix.BackgroundTransparency = 1
ModalFix.Text = ""
ModalFix.Modal = true
ModalFix.ZIndex = 9
ModalFix.Parent = MainFrame

-- === DRAG FUNCIONAL (MESMO DO SEU HUB PRINCIPAL) ===
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input == dragInput) then
        update(input)
    end
end)
-- === FIM DO DRAG FUNCIONAL ===

-- Lista de abas
local currentTab = nil

-- Função para criar aba
local function createTab(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 55)
    btn.Position = UDim2.new(0, 0, posY, 0)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.BackgroundTransparency = 0.3
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.ZIndex = 12
    btn.Parent = TabBar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = btn

    btn.MouseEnter:Connect(function()
        if currentTab ~= btn then
            btn.BackgroundTransparency = 0.1
        end
    end)
    btn.MouseLeave:Connect(function()
        if currentTab ~= btn then
            btn.BackgroundTransparency = 0.3
        end
    end)

    return btn
end

-- Abas
local PlayersTab = createTab("PLAYERS", 0.05)
local BeastTab = createTab("BEAST", 0.20)
local ConfigTab = createTab("CONFIG", 0.35)
local InfoTab = createTab("INFO", 0.50)

-- Conteúdos
local PlayersContent = Instance.new("ScrollingFrame")
PlayersContent.Size = UDim2.new(1, 0, 1, 0)
PlayersContent.BackgroundTransparency = 1
PlayersContent.Visible = true
PlayersContent.ScrollBarThickness = 6
PlayersContent.ZIndex = 12
PlayersContent.Parent = ContentFrame

local BeastContent = Instance.new("ScrollingFrame")
BeastContent.Size = UDim2.new(1, 0, 1, 0)
BeastContent.BackgroundTransparency = 1
BeastContent.Visible = false
BeastContent.ScrollBarThickness = 6
BeastContent.ZIndex = 12
BeastContent.Parent = ContentFrame

local ConfigContent = Instance.new("ScrollingFrame")
ConfigContent.Size = UDim2.new(1, 0, 1, 0)
ConfigContent.BackgroundTransparency = 1
ConfigContent.Visible = false
ConfigContent.ScrollBarThickness = 6
ConfigContent.ZIndex = 12
ConfigContent.Parent = ContentFrame

local InfoContent = Instance.new("ScrollingFrame")
InfoContent.Size = UDim2.new(1, 0, 1, 0)
InfoContent.BackgroundTransparency = 1
InfoContent.Visible = false
InfoContent.ScrollBarThickness = 6
InfoContent.ZIndex = 12
InfoContent.Parent = ContentFrame

-- Função para destacar aba
local function selectTab(selectedBtn, content)
    if currentTab then
        currentTab.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        currentTab.BackgroundTransparency = 0.3
        currentTab.TextColor3 = Color3.new(1,1,1)
    end

    selectedBtn.BackgroundColor3 = Color3.new(1,1,1)
    selectedBtn.BackgroundTransparency = 0
    selectedBtn.TextColor3 = Color3.new(0,0,0)

    currentTab = selectedBtn

    PlayersContent.Visible = false
    BeastContent.Visible = false
    ConfigContent.Visible = false
    InfoContent.Visible = false
    content.Visible = true
end

PlayersTab.Activated:Connect(function() selectTab(PlayersTab, PlayersContent) end)
BeastTab.Activated:Connect(function() selectTab(BeastTab, BeastContent) end)
ConfigTab.Activated:Connect(function() selectTab(ConfigTab, ConfigContent) end)
InfoTab.Activated:Connect(function() selectTab(InfoTab, InfoContent) end)

-- Toggle
local function createToggle(content, name, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, posY, 0)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.ZIndex = 13
    btn.Parent = content

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
end

-- Aba PLAYERS
createToggle(PlayersContent, "Beast ESP (Vermelho)", 0.02, function(state) CONFIG.ESPPlayersBeast = state end)
createToggle(PlayersContent, "Exit Doors ESP", 0.14, function(state) CONFIG.ESPExitDoors = state end)
createToggle(PlayersContent, "Computers ESP", 0.26, function(state) CONFIG.ESPComputers = state end)

-- Velocidade
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.9, 0, 0, 30)
SpeedLabel.Position = UDim2.new(0.05, 0, 0.40, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Velocidade: 16"
SpeedLabel.TextColor3 = Color3.new(1,1,1)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextSize = 16
SpeedLabel.ZIndex = 13
SpeedLabel.Parent = PlayersContent

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0.9, 0, 0, 40)
SpeedBox.Position = UDim2.new(0.05, 0, 0.48, 0)
SpeedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedBox.PlaceholderText = "0 - 50"
SpeedBox.ClearTextOnFocus = false
SpeedBox.Text = "16"
SpeedBox.TextColor3 = Color3.new(1,1,1)
SpeedBox.Font = Enum.Font.Gotham
SpeedBox.TextSize = 16
SpeedBox.ZIndex = 13
SpeedBox.Parent = PlayersContent

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 10)
SpeedCorner.Parent = SpeedBox

SpeedBox.FocusLost:Connect(function(enter)
    if enter then
        local num = tonumber(SpeedBox.Text)
        if num and num >= 0 and num <= 50 then
            CONFIG.SpeedValue = num
            SpeedLabel.Text = "Velocidade: " .. num
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = num
            end
        else
            SpeedBox.Text = tostring(CONFIG.SpeedValue)
        end
    end
end)

-- Aba BEAST
createToggle(BeastContent, "Inocentes ESP (Verde)", 0.08, function(state) CONFIG.ESPInnocents = state end)
createToggle(BeastContent, "Cápsulas ESP", 0.20, function(state) CONFIG.ESPCapsules = state end)

-- Minimizar
local isMinimized = false
MinimizeButton.Activated:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 320, 0, 60), "Out", "Quad", 0.3)
        TabBar.Visible = false
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 320, 0, 420), "Out", "Quad", 0.3)
        TabBar.Visible = true
        ContentFrame.Visible = true
        MinimizeButton.Text = "-"
    end
end)

-- Destroy
DestroyButton.Activated:Connect(function()
    for obj, hl in pairs(ESPs) do
        if hl and hl.Parent then hl:Destroy() end
    end
    for char, tag in pairs(NameTags) do
        if tag and tag.Parent then tag:Destroy() end
    end
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
    end
    ScreenGui:Destroy()
end)

-- Funções de ESP otimizadas
local function addHighlight(obj, color, name)
    if not obj or ESPs[obj] then return end
    local hl = Instance.new("Highlight")
    hl.Name = name or "GekyuESP"
    hl.Adornee = obj
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.FillColor = color
    hl.FillTransparency = 0.4
    hl.OutlineColor = color
    hl.OutlineTransparency = 0
    hl.Parent = obj
    ESPs[obj] = hl
end

local function removeHighlight(obj)
    if ESPs[obj] then
        ESPs[obj]:Destroy()
        ESPs[obj] = nil
    end
end

local function addNameTag(char, name)
    if not char or NameTags[char] then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "NameTag"
    billboard.Size = UDim2.new(0, 100, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Adornee = char:FindFirstChild("Head")
    billboard.AlwaysOnTop = true
    billboard.Parent = char

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = name
    text.TextColor3 = Color3.new(1, 1, 1)
    text.Font = Enum.Font.GothamBold
    text.TextSize = 16
    text.Parent = billboard

    NameTags[char] = billboard
end

-- Loop otimizado de ESP
RunService.Heartbeat:Connect(function()
    local currentTime = tick()
    if currentTime - lastUpdate < updateInterval then return end
    lastUpdate = currentTime

    -- Limpeza
    for obj, hl in pairs(ESPs) do
        if not obj or not obj.Parent then
            removeHighlight(obj)
        end
    end
    for char, tag in pairs(NameTags) do
        if not char or not char.Parent then
            if tag then tag:Destroy() end
            NameTags[char] = nil
        end
    end

    -- ESP Beast (vermelho) - Aba Players
    if CONFIG.ESPPlayersBeast then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local hasBeastPowers = plr.Character:FindFirstChild("BeastPowers") or (plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool").Name:lower():find("claw"))
                if hasBeastPowers and not ESPs[plr.Character] then
                    addHighlight(plr.Character, Color3.fromRGB(255, 85, 0), "BeastESP")
                elseif not hasBeastPowers and ESPs[plr.Character] then
                    removeHighlight(plr.Character)
                end
            end
        end
    else
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character then removeHighlight(plr.Character) end
        end
    end

    -- ESP Inocentes (verde com nome) - Aba Beast
    if CONFIG.ESPInnocents then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local hasBeastPowers = plr.Character:FindFirstChild("BeastPowers") or (plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool").Name:lower():find("claw"))
                if not hasBeastPowers then
                    if not ESPs[plr.Character] then
                        addHighlight(plr.Character, Color3.fromRGB(0, 170, 255), "InnocentESP")
                        if not NameTags[plr.Character] then
                            addNameTag(plr.Character, plr.Name)
                        end
                    end
                else
                    removeHighlight(plr.Character)
                    if NameTags[plr.Character] then
                        NameTags[plr.Character]:Destroy()
                        NameTags[plr.Character] = nil
                    end
                end
            end
        end
    else
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and not plr.Character:FindFirstChild("BeastPowers") then
                removeHighlight(plr.Character)
                if NameTags[plr.Character] then
                    NameTags[plr.Character]:Destroy()
                    NameTags[plr.Character] = nil
                end
            end
        end
    end

    -- ESP Exit Doors
    if CONFIG.ESPExitDoors then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == "ExitDoor" and (obj:IsA("BasePart") or obj:IsA("Model")) and not ESPs[obj] then
                addHighlight(obj, Color3.fromRGB(255, 165, 0), "ExitESP")
            end
        end
    else
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == "ExitDoor" and ESPs[obj] then
                removeHighlight(obj)
            end
        end
    end

    -- ESP Computers
    if CONFIG.ESPComputers then
        for _, c in pairs(Workspace:GetDescendants()) do
            if c.Name == "ComputerTable" and c:IsA("Model") and not ESPs[c] then
                local s = c:FindFirstChild("Screen")
                if s then
                    addHighlight(c, Color3.fromRGB(0, 170, 255), "ComputerESP")
                    local hl = ESPs[c]
                    if hl then
                        local color = tostring(s.BrickColor):lower()
                        if color:find("green") then
                            hl.FillColor = Color3.fromRGB(0, 255, 0)
                        elseif color:find("red") then
                            hl.FillColor = Color3.fromRGB(255, 0, 0)
                        else
                            hl.FillColor = Color3.fromRGB(0, 170, 255)
                        end
                        hl.OutlineColor = hl.FillColor
                    end
                end
            end
        end
    else
        for _, c in pairs(Workspace:GetDescendants()) do
            if c.Name == "ComputerTable" and ESPs[c] then
                removeHighlight(c)
            end
        end
    end

    -- ESP Cápsulas
    if CONFIG.ESPCapsules then
        for _, pod in pairs(Workspace:GetDescendants()) do
            if (pod.Name == "FreezePod" or pod.Name:find("Pod")) and (pod:IsA("Model") or pod:IsA("BasePart")) and not ESPs[pod] then
                addHighlight(pod, Color3.fromRGB(0, 255, 255), "CapsuleESP")
            end
        end
    else
        for _, pod in pairs(Workspace:GetDescendants()) do
            if (pod.Name == "FreezePod" or pod.Name:find("Pod")) and ESPs[pod] then
                removeHighlight(pod)
            end
        end
    end
end)

-- Velocidade ao spawnar
player.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = CONFIG.SpeedValue
end)

-- Aba Players aberta por padrão
selectTab(PlayersTab, PlayersContent)

print("[GEKYU HUB] Free The Facility - DRAG CORRIGIDO E FUNCIONANDO PERFEITAMENTE!")
