
-- GEKYU HUB | Flee The Facility - SCRIPT COMPLETO + Anti-Cheat PC Cooldown (Janeiro 2026)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

if CoreGui:FindFirstChild("GekyuHubFTF") then
    CoreGui.GekyuHubFTF:Destroy()
end

local Library = {
    Connections = {},
    ESPObjects = {},
    HiddenState = {
        HitboxOriginalSize = Vector3.new(2, 2, 1),
        WalkSpeed = 16
    }
}

local CONFIG = {
    ESPPlayers = false,
    ESPExitDoors = false,
    ESPComputers = false,
    ESPCapsules = false,
    HitboxExpander = false,
    HitboxSize = 4,
    HitAura = false,
    HitAuraRange = 15,
    NoSlow = false,
    UnlockCamera = false,
    AntiErrorEnabled = false,
    SpeedValue = 16
}

local selectedPlayer = nil

-- Variáveis para cooldown e hack ativo
local pcCooldown = false
local hackingActive = false

-- Auto Interact (método que funcionava antes)
local function PressE()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvent")
    if remote then
        remote:FireServer("Input", "Action", true)
    end
end

local function UnpressE()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvent")
    if remote then
        remote:FireServer("Input", "Action", false)
    end
end

-- Notificação simples (pode ser melhorada depois com GUI custom)
local function Notify(title, message)
    print("[" .. title .. "] " .. message)
    -- Se quiser GUI de notificação, posso adicionar depois
end

-- ==============================================
-- LIMPEZA COMPLETA
-- ==============================================

local function FullCleanup()
    for _, conn in pairs(Library.Connections) do if conn then conn:Disconnect() end end
    Library.Connections = {}

    for obj, _ in pairs(Library.ESPObjects) do
        if obj and obj.Parent then obj:Destroy() end
    end
    Library.ESPObjects = {}

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            hrp.Size = Library.HiddenState.HitboxOriginalSize
            hrp.Transparency = 1
            hrp.CanCollide = true
        end
    end

    player.CameraMaxZoomDistance = 12.5
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
    end
end

local function FullDestruct()
    FullCleanup()
    if CoreGui:FindFirstChild("GekyuHubFTF") then CoreGui.GekyuHubFTF:Destroy() end
end

-- GUI (mantida igual, com abas exclusivas)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GekyuHubFTF"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 460)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Active = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 16)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "GEKYU HUB | FTF"
Title.TextColor3 = Color3.fromRGB(255, 215, 60)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 36, 0, 36)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -18)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 10)
CloseBtn.Activated:Connect(FullDestruct)

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 36, 0, 36)
MinimizeBtn.Position = UDim2.new(1, -80, 0.5, -18)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.new(0,0,0)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 22
MinimizeBtn.Parent = TopBar
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 10)

local minimized = false

MinimizeBtn.Activated:Connect(function()
    minimized = not minimized
    
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 340, 0, 50), "Out", "Quad", 0.25, true)
        for _, v in pairs(MainFrame:GetChildren()) do
            if v ~= TopBar and v:IsA("GuiObject") then v.Visible = false end
        end
        MinimizeBtn.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 340, 0, 460), "Out", "Quad", 0.25, true)
        for _, v in pairs(MainFrame:GetChildren()) do
            if v ~= TopBar and v:IsA("GuiObject") then v.Visible = true end
        end
        MinimizeBtn.Text = "-"
    end
end)

-- Arrastar pelo TopBar
local dragging, dragInput, dragStart, startPos = false, nil, nil, nil

local function updateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then updateInput(input) end
end)

-- Abas
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(0, 90, 1, -50)
TabFrame.Position = UDim2.new(0, 0, 0, 50)
TabFrame.BackgroundTransparency = 1
TabFrame.Parent = MainFrame

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -100, 1, -50)
ContentFrame.Position = UDim2.new(0, 100, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local currentContent = nil

local function createTabButton(name, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Text = name
    btn.TextColor3 = Color3.new(0.9,0.9,0.9)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = TabFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1,0,1,0)
    content.BackgroundTransparency = 1
    content.ScrollBarThickness = 4
    content.Visible = false
    content.Parent = ContentFrame
    
    btn.Activated:Connect(function()
        if currentContent then currentContent.Visible = false end
        for _, b in pairs(TabFrame:GetChildren()) do 
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
                b.TextColor3 = Color3.new(0.9,0.9,0.9)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(90, 180, 255)
        btn.TextColor3 = Color3.new(1,1,1)
        content.Visible = true
        currentContent = content
    end)
    
    return content
end

local VisualPage = createTabButton("VISUAL", 10)
local BeastPage = createTabButton("BEAST", 60)
local TPPage = createTabButton("TP", 110)
local ConfigPage = createTabButton("CONFIG", 160)
local TrollPage = createTabButton("TROLL", 210)

VisualPage.Visible = true
currentContent = VisualPage

-- ==============================================
-- ESP FUNCTIONS (mantido igual)
-- ==============================================

local function CreateHighlight(target, color, typeStr)
    if not target or not target.Parent then return end
    if target:FindFirstChild("GekyuESP") then target.GekyuESP:Destroy() end

    local hl = Instance.new("Highlight")
    hl.Name = "GekyuESP"
    hl.Adornee = target
    hl.FillColor = color
    hl.FillTransparency = 0.5
    hl.OutlineColor = color
    hl.OutlineTransparency = 0.1
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = target
    
    Library.ESPObjects[hl] = typeStr
end

local function ClearESP(typeStr)
    for obj, t in pairs(Library.ESPObjects) do
        if t == typeStr then
            if obj and obj.Parent then obj:Destroy() end
            Library.ESPObjects[obj] = nil
        end
    end
end

local function UpdatePlayerESP(state)
    ClearESP("Player")
    if not state then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local isBeast = p.Character:FindFirstChild("BeastPowers") or p.Character:FindFirstChild("Hammer") or p.Backpack:FindFirstChild("Hammer")
            local color = isBeast and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 255, 100)
            CreateHighlight(p.Character, color, "Player")
        end
    end
end

local function UpdateComputers(state)
    ClearESP("Computer")
    if not state then return end
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "ComputerTable" and obj:FindFirstChild("Screen") then
            local screen = obj.Screen
            local color = Color3.fromRGB(0, 170, 255)
            
            if screen:IsA("BasePart") and screen.BrickColor then
                local bc = screen.BrickColor.Name:lower()
                if bc:find("green") or bc:find("lime") then color = Color3.fromRGB(50, 255, 50) end
                if bc:find("red") then color = Color3.fromRGB(255, 50, 50) end
            end
            
            CreateHighlight(obj, color, "Computer")
        end
    end
end

local function UpdateCapsules(state)
    ClearESP("Capsule")
    if not state then return end
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "FreezePod" then
            CreateHighlight(obj, Color3.fromRGB(0, 255, 255), "Capsule")
        end
    end
end

local function UpdateDoors(state)
    ClearESP("Door")
    if not state then return end
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "ExitDoor" then
            CreateHighlight(obj, Color3.fromRGB(255, 215, 80), "Door")
        end
    end
end

task.spawn(function()
    while task.wait(1.8) do
        if not CoreGui:FindFirstChild("GekyuHubFTF") then break end
        if CONFIG.ESPPlayers then UpdatePlayerESP(true) end
        if CONFIG.ESPComputers then UpdateComputers(true) end
        if CONFIG.ESPCapsules then UpdateCapsules(true) end
        if CONFIG.ESPExitDoors then UpdateDoors(true) end
    end
end)

-- ==============================================
-- ANTI ERRO PC
-- ==============================================

getgenv().AntiErrorEnabled = false

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if method == "FireServer" and self.Name == "RemoteEvent" and args[1] == "SetPlayerMinigameResult" and getgenv().AntiErrorEnabled then
        args[2] = true
        return oldNamecall(self, unpack(args))
    end
    
    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

-- ==============================================
-- TOGGLES (BEAST só se for Beast)
-- ==============================================

local toggleRefs = {}

local function createToggle(parent, text, order, callback, configKey)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.95, 0, 0, 44)
    frame.LayoutOrder = order
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0, 50, 0, 28)
    status.Position = UDim2.new(1, -60, 0.5, -14)
    status.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    status.Text = "OFF"
    status.TextColor3 = Color3.new(0.8,0.8,0.8)
    status.Font = Enum.Font.GothamBold
    status.TextSize = 12
    status.Parent = frame
    Instance.new("UICorner", status).CornerRadius = UDim.new(0, 8)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,1,0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = frame

    toggleRefs[configKey] = {Status = status, Frame = frame}

    btn.Activated:Connect(function()
        -- Restrição BEAST
        if parent == BeastPage then
            local isBeast = player.Character and (player.Character:FindFirstChild("BeastPowers") or player.Character:FindFirstChild("Hammer") or player.Backpack:FindFirstChild("Hammer"))
            if not isBeast then
                Notify("BEAST", "Você não é a Beast! Função bloqueada.")
                return
            end
        end

        local newVal = not CONFIG[configKey]
        CONFIG[configKey] = newVal
        status.Text = newVal and "ON" or "OFF"
        status.BackgroundColor3 = newVal and Color3.fromRGB(80, 220, 120) or Color3.fromRGB(60, 60, 70)
        status.TextColor3 = newVal and Color3.new(0,0,0) or Color3.new(0.8,0.8,0.8)
        task.spawn(function() callback(newVal) end)
    end)

    if not parent:FindFirstChild("UIListLayout") then
        local layout = Instance.new("UIListLayout", parent)
        layout.Padding = UDim.new(0, 8)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
    end
end

-- VISUAL
createToggle(VisualPage, "Players ESP", 1, UpdatePlayerESP, "ESPPlayers")
createToggle(VisualPage, "Computers ESP", 2, UpdateComputers, "ESPComputers")
createToggle(VisualPage, "Exit Doors ESP", 3, UpdateDoors, "ESPExitDoors")
createToggle(VisualPage, "Capsules ESP", 4, UpdateCapsules, "ESPCapsules")
createToggle(VisualPage, "Anti Erro PC", 5, function(v) getgenv().AntiErrorEnabled = v end, "AntiErrorEnabled")

-- BEAST
createToggle(BeastPage, "Hitbox Expander", 1, function(v) end, "HitboxExpander")
createToggle(BeastPage, "Hit Aura", 2, function(v) end, "HitAura")
createToggle(BeastPage, "No Slow", 3, function(v) end, "NoSlow")
createToggle(BeastPage, "Unlock Camera", 4, function(v) end, "UnlockCamera")

-- ==============================================
-- TP PAGE
-- ==============================================

local DropdownContainer = Instance.new("Frame")
DropdownContainer.Size = UDim2.new(0.95, 0, 0, 35)
DropdownContainer.Position = UDim2.new(0.025, 0, 0, 0)
DropdownContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
DropdownContainer.ZIndex = 10
DropdownContainer.Parent = TPPage
Instance.new("UICorner", DropdownContainer).CornerRadius = UDim.new(0, 8)

local DropdownBtn = Instance.new("TextButton")
DropdownBtn.Size = UDim2.new(1,0,1,0)
DropdownBtn.BackgroundTransparency = 1
DropdownBtn.Text = "Selecione Jogador..."
DropdownBtn.TextColor3 = Color3.new(1,1,1)
DropdownBtn.Font = Enum.Font.GothamSemibold
DropdownBtn.TextSize = 14
DropdownBtn.ZIndex = 11
DropdownBtn.Parent = DropdownContainer

local DropdownList = Instance.new("Frame")
DropdownList.Size = UDim2.new(0.95, 0, 0, 0)
DropdownList.Position = UDim2.new(0.025, 0, 0, 40)
DropdownList.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
DropdownList.BorderSizePixel = 0
DropdownList.ZIndex = 12
DropdownList.Visible = false
DropdownList.Parent = TPPage
Instance.new("UICorner", DropdownList).CornerRadius = UDim.new(0, 8)

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 4)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = DropdownList

local function RefreshDropdown()
    for _, child in pairs(DropdownList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local list = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character then table.insert(list, p.Name) end
    end
    
    if #list == 0 then
        DropdownBtn.Text = "Nenhum jogador"
        return
    end
    
    for i, name in ipairs(list) do
        if i > 10 then break end
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 32)
        btn.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
        btn.Text = name
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 13
        btn.ZIndex = 13
        btn.Parent = DropdownList
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        btn.Activated:Connect(function()
            selectedPlayer = name
            DropdownBtn.Text = name
            DropdownList.Visible = false
        end)
    end
    
    local height = #list * 36
    if #list > 10 then height = 360 end
    DropdownList.Size = UDim2.new(0.95, 0, 0, height)
end

DropdownBtn.Activated:Connect(function()
    DropdownList.Visible = not DropdownList.Visible
    if DropdownList.Visible then RefreshDropdown() end
end)

-- Atualiza dropdown a cada 5s
task.spawn(function()
    while true do
        task.wait(5)
        if not minimized and TPPage.Visible then
            RefreshDropdown()
        end
    end
end)

-- Botões TP (separados manualmente, pretos opacos)
local function createButton(parent, text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 44)
    btn.Position = UDim2.new(0.025, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.BackgroundTransparency = 0.3
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    btn.Activated:Connect(callback)
end

createButton(TPPage, "Teleportar para Jogador Selecionado", 80, function()
    if selectedPlayer then
        local target = Players:FindFirstChild(selectedPlayer)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local oldPos = hrp.CFrame
                hrp.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                print("[TP Player] Teleportado para " .. selectedPlayer)
                task.delay(3, function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.CFrame = oldPos
                        print("[TP Player] Volta para posição original")
                    end
                end)
            end
        end
    end
end)

createButton(TPPage, "TP para Armário Aleatório", 130, function()
    local lockers = {}
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj.Name == "Locker" or (obj:FindFirstChild("Door") and obj:FindFirstChild("Door"):IsA("BasePart"))) then
            local part = obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart
            if part then table.insert(lockers, part) end
        end
    end
    
    if #lockers > 0 then
        local random = lockers[math.random(1, #lockers)]
        player.Character.HumanoidRootPart.CFrame = random.CFrame * CFrame.new(0, 2, 0)
        print("[TP Armário] Teleportado para armário aleatório")
    else
        print("[TP Armário] Nenhum armário encontrado")
    end
end)

createButton(TPPage, "TP para Exit Door Aleatória", 180, function()
    local exits = {}
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "ExitDoor" and obj:IsA("Model") then
            local part = obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart
            if part then table.insert(exits, part) end
        end
    end
    
    if #exits > 0 then
        local random = exits[math.random(1, #exits)]
        player.Character.HumanoidRootPart.CFrame = random.CFrame * CFrame.new(0, 0.5, 0) -- no chão
        print("[TP Exit] Teleportado para saída aleatória")
    else
        print("[TP Exit] Nenhuma saída encontrada")
    end
end)

-- TP para PC (com cooldown 15s + bloqueio durante hack)
local function TeleportToRandomPC()
    if pcCooldown then
        Notify("COOLDOWN", "Aguarde 15 segundos antes de tentar outro PC!")
        return
    end
    
    if hackingActive then
        Notify("HACKING", "Você já está hackeando um PC! Aguarde terminar.")
        return
    end
    
    local pcs = {}
    local mapCenter = Vector3.new(0, 0, 0) -- ajuste se souber o centro real do mapa
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name:match("ComputerTrigger%d") and obj:IsA("BasePart") then
            local parent = obj.Parent
            if parent and parent:FindFirstChild("Screen") then
                local screen = parent.Screen
                local bc = screen.BrickColor and screen.BrickColor.Name:lower() or ""
                if not bc:find("green") then -- não hackeado
                    -- Filtra PCs dentro do mapa (distância máxima 500 studs do centro)
                    if (obj.Position - mapCenter).Magnitude < 500 then
                        table.insert(pcs, obj)
                    end
                end
            end
        end
    end
    
    if #pcs == 0 then
        Notify("PC", "Nenhum PC disponível dentro do mapa")
        return
    end
    
    local randomPC = pcs[math.random(1, #pcs)]
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = randomPC.CFrame * CFrame.new(0, 3, 0)
        Notify("TP PC", "Teleportado para PC aleatório")
        
        hackingActive = true
        pcCooldown = true
        
        task.delay(1, function()
            PressE()
            task.wait(0.05)
            UnpressE()
            Notify("HACK", "Hack automático iniciado (E pressionado)")
            hackingActive = false
        end)
        
        -- Cooldown de 15s
        task.delay(15, function()
            pcCooldown = false
            Notify("COOLDOWN", "Cooldown do PC finalizado! Pode tentar novamente.")
        end)
    end
end

createButton(TPPage, "TP para PC + Hack Automático", 230, TeleportToRandomPC)

-- CONFIG (botões separados manualmente)
createButton(ConfigPage, "RECARREGAR TODOS ESPs", 80, function()
    FullCleanup()
    task.wait(0.3)
    if CONFIG.ESPPlayers then UpdatePlayerESP(true) end
    if CONFIG.ESPComputers then UpdateComputers(true) end
    if CONFIG.ESPCapsules then UpdateCapsules(true) end
    if CONFIG.ESPExitDoors then UpdateDoors(true) end
end)

createButton(ConfigPage, "DESATIVAR TUDO", 130, function()
    for k in pairs(CONFIG) do
        if k ~= "HitboxSize" and k ~= "HitAuraRange" then CONFIG[k] = false end
    end
    for _, ref in pairs(toggleRefs) do
        ref.Status.Text = "OFF"
        ref.Status.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        ref.Status.TextColor3 = Color3.new(0.8,0.8,0.8)
    end
    FullCleanup()
end)

print("[GEKYU HUB] Carregado com sucesso - PressE corrigido + Cooldown PC 15s + Hack 1s")
