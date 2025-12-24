-- GEKYU HUB V3.23 COMPLETO - "EXECUTANDO..." REDUZIDO PARA 1 SEGUNDO
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Configurações
local KeyTemporariaAtivada = true
local KeyCorreta = "GEKYU2025"

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GekyuHub"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999

-- IntroScreen
local IntroScreen = Instance.new("Frame")
IntroScreen.Name = "IntroScreen"
IntroScreen.Parent = ScreenGui
IntroScreen.Size = UDim2.new(1, 0, 1, 0)
IntroScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IntroScreen.BackgroundTransparency = 0
IntroScreen.BorderSizePixel = 0
IntroScreen.ZIndex = 9999999

local IntroLabel = Instance.new("TextLabel")
IntroLabel.Parent = IntroScreen
IntroLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
IntroLabel.Position = UDim2.new(0.1, 0, 0.2, 0)
IntroLabel.BackgroundTransparency = 1
IntroLabel.Text = "GEKYU HUB"
IntroLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroLabel.TextScaled = true
IntroLabel.Font = Enum.Font.GothamBlack
IntroLabel.TextTransparency = 1

local IntroGradient = Instance.new("UIGradient")
IntroGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(200, 200, 200)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(50, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
IntroGradient.Offset = Vector2.new(0, 0)
IntroGradient.Parent = IntroLabel

local function AnimarGradient(obj)
    while obj.Parent do
        TweenService:Create(obj, TweenInfo.new(4, Enum.EasingStyle.Linear), {Offset = Vector2.new(-0.5, 0)}):Play()
        wait(4)
        TweenService:Create(obj, TweenInfo.new(4, Enum.EasingStyle.Linear), {Offset = Vector2.new(0.5, 0)}):Play()
        wait(4)
    end
end
spawn(function() AnimarGradient(IntroGradient) end)

-- Key Input Frame
local KeyInputFrame = Instance.new("Frame")
KeyInputFrame.Parent = IntroScreen
KeyInputFrame.Size = UDim2.new(0.4, 0, 0.12, 0)
KeyInputFrame.Position = UDim2.new(0.3, 0, 0.45, 0)
KeyInputFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
KeyInputFrame.BackgroundTransparency = 0.4
KeyInputFrame.BorderSizePixel = 0

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 20)
KeyCorner.Parent = KeyInputFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(255, 255, 255)
KeyStroke.Thickness = 2
KeyStroke.Transparency = 0.5
KeyStroke.Parent = KeyInputFrame

local KeyGradient = Instance.new("UIGradient")
KeyGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(200, 200, 200)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(50, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
KeyGradient.Offset = Vector2.new(0, 0)
KeyGradient.Parent = KeyStroke
spawn(function() AnimarGradient(KeyGradient) end)

local KeyBox = Instance.new("TextBox")
KeyBox.Parent = KeyInputFrame
KeyBox.Size = UDim2.new(0.9, 0, 0.8, 0)
KeyBox.Position = UDim2.new(0.05, 0, 0.1, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeyBox.PlaceholderText = "Digite a KEY..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextScaled = true
KeyBox.ClearTextOnFocus = false

local CornerKey = Instance.new("UICorner")
CornerKey.CornerRadius = UDim.new(0, 12)
CornerKey.Parent = KeyBox

-- Erro Label
local ErroLabel = Instance.new("TextLabel")
ErroLabel.Parent = IntroScreen
ErroLabel.Size = UDim2.new(0.4, 0, 0, 30)
ErroLabel.Position = UDim2.new(0.3, 0, 0.6, 0)
ErroLabel.BackgroundTransparency = 1
ErroLabel.Text = ""
ErroLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
ErroLabel.TextScaled = true
ErroLabel.Font = Enum.Font.GothamBold
ErroLabel.Visible = false

-- Botões Verificar e Cancelar
local BtnVerificar = Instance.new("TextButton")
BtnVerificar.Parent = IntroScreen
BtnVerificar.Size = UDim2.new(0.18, 0, 0, 50)
BtnVerificar.Position = UDim2.new(0.31, 0, 0.65, 0)
BtnVerificar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BtnVerificar.Text = "Verificar Key"
BtnVerificar.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnVerificar.TextScaled = true
BtnVerificar.Font = Enum.Font.GothamBold
BtnVerificar.BorderSizePixel = 1
BtnVerificar.BorderColor3 = Color3.fromRGB(100, 100, 100)

local CornerVerificar = Instance.new("UICorner")
CornerVerificar.CornerRadius = UDim.new(0, 12)
CornerVerificar.Parent = BtnVerificar

local BtnCancelar = Instance.new("TextButton")
BtnCancelar.Parent = IntroScreen
BtnCancelar.Size = UDim2.new(0.18, 0, 0, 50)
BtnCancelar.Position = UDim2.new(0.51, 0, 0.65, 0)
BtnCancelar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BtnCancelar.Text = "Cancelar"
BtnCancelar.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnCancelar.TextScaled = true
BtnCancelar.Font = Enum.Font.GothamBold
BtnCancelar.BorderSizePixel = 1
BtnCancelar.BorderColor3 = Color3.fromRGB(100, 100, 100)

local CornerCancelar = Instance.new("UICorner")
CornerCancelar.CornerRadius = UDim.new(0, 12)
CornerCancelar.Parent = BtnCancelar

-- Fundo e MainFrame
local Fundo = Instance.new("Frame")
Fundo.Name = "Fundo"
Fundo.Parent = ScreenGui
Fundo.Size = UDim2.new(1, 0, 1, 0)
Fundo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Fundo.BackgroundTransparency = 1
Fundo.BorderSizePixel = 0
Fundo.Active = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Visible = false

local CornerMain = Instance.new("UICorner")
CornerMain.CornerRadius = UDim.new(0, 12)
CornerMain.Parent = MainFrame

local StrokeMain = Instance.new("UIStroke")
StrokeMain.Color = Color3.fromRGB(100, 100, 100)
StrokeMain.Thickness = 1.5
StrokeMain.Transparency = 0.5
StrokeMain.Parent = MainFrame

-- Topbar
local Topbar = Instance.new("Frame")
Topbar.Parent = MainFrame
Topbar.Size = UDim2.new(1, 0, 0, 50)
Topbar.Position = UDim2.new(0, 0, 0, 0)
Topbar.BackgroundTransparency = 1

local Titulo = Instance.new("TextLabel")
Titulo.Parent = Topbar
Titulo.Size = UDim2.new(1, -100, 1, 0)
Titulo.Position = UDim2.new(0, 15, 0, 0)
Titulo.BackgroundTransparency = 1
Titulo.Text = "GEKYU HUB"
Titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
Titulo.TextScaled = true
Titulo.Font = Enum.Font.GothamBlack

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(200, 200, 200)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(50, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
Gradient.Offset = Vector2.new(0, 0)
Gradient.Parent = Titulo
spawn(function() AnimarGradient(Gradient) end)

local BtnMinimizar = Instance.new("TextButton")
BtnMinimizar.Parent = Topbar
BtnMinimizar.Size = UDim2.new(0, 36, 0, 36)
BtnMinimizar.Position = UDim2.new(1, -80, 0, 7)
BtnMinimizar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BtnMinimizar.Text = "-"
BtnMinimizar.TextColor3 = Color3.fromRGB(0, 0, 0)
BtnMinimizar.TextScaled = true
BtnMinimizar.Font = Enum.Font.GothamBold

local CornerMin = Instance.new("UICorner")
CornerMin.CornerRadius = UDim.new(0, 10)
CornerMin.Parent = BtnMinimizar

local BtnDestruir = Instance.new("TextButton")
BtnDestruir.Parent = Topbar
BtnDestruir.Size = UDim2.new(0, 36, 0, 36)
BtnDestruir.Position = UDim2.new(1, -40, 0, 7)
BtnDestruir.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BtnDestruir.Text = "X"
BtnDestruir.TextColor3 = Color3.fromRGB(0, 0, 0)
BtnDestruir.TextScaled = true
BtnDestruir.Font = Enum.Font.GothamBold

local CornerDestruir = Instance.new("UICorner")
CornerDestruir.CornerRadius = UDim.new(0, 10)
CornerDestruir.Parent = BtnDestruir

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 140, 1, -50)
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.BackgroundTransparency = 1

local SearchBar = Instance.new("TextBox")
SearchBar.Parent = Sidebar
SearchBar.Size = UDim2.new(1, -10, 0, 30)
SearchBar.Position = UDim2.new(0, 5, 0, 5)
SearchBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
SearchBar.PlaceholderText = "Pesquisar jogo..."
SearchBar.Text = ""
SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBar.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
SearchBar.Font = Enum.Font.Gotham
SearchBar.TextScaled = true
SearchBar.ClearTextOnFocus = false

local CornerSearch = Instance.new("UICorner")
CornerSearch.CornerRadius = UDim.new(0, 8)
CornerSearch.Parent = SearchBar

local JogosList = Instance.new("ScrollingFrame")
JogosList.Parent = Sidebar
JogosList.Size = UDim2.new(1, -10, 1, -45)
JogosList.Position = UDim2.new(0, 5, 0, 40)
JogosList.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
JogosList.BackgroundTransparency = 0.5
JogosList.BorderSizePixel = 0
JogosList.ScrollBarThickness = 2
JogosList.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 80)
JogosList.CanvasSize = UDim2.new(0, 0, 0, 0)

local CornerJogos = Instance.new("UICorner")
CornerJogos.CornerRadius = UDim.new(0, 10)
CornerJogos.Parent = JogosList

-- Scripts Area
local ScriptsArea = Instance.new("Frame")
ScriptsArea.Parent = MainFrame
ScriptsArea.Size = UDim2.new(1, -150, 1, -50)
ScriptsArea.Position = UDim2.new(0, 140, 0, 50)
ScriptsArea.BackgroundTransparency = 1

local ScriptsList = Instance.new("ScrollingFrame")
ScriptsList.Parent = ScriptsArea
ScriptsList.Size = UDim2.new(1, -10, 1, -10)
ScriptsList.Position = UDim2.new(0, 5, 0, 5)
ScriptsList.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ScriptsList.BackgroundTransparency = 0
ScriptsList.BorderSizePixel = 0
ScriptsList.ScrollBarThickness = 2
ScriptsList.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 80)
ScriptsList.CanvasSize = UDim2.new(0, 0, 0, 0)

local CornerScripts = Instance.new("UICorner")
CornerScripts.CornerRadius = UDim.new(0, 10)
CornerScripts.Parent = ScriptsList

local ScriptsGradient = Instance.new("UIGradient")
ScriptsGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
ScriptsGradient.Offset = Vector2.new(0, 0)
ScriptsGradient.Parent = ScriptsList

local function AnimarScriptsGradient()
    while ScriptsList.Parent do
        TweenService:Create(ScriptsGradient, TweenInfo.new(1, Enum.EasingStyle.Linear), {Offset = Vector2.new(-1, 0)}):Play()
        wait(1)
        ScriptsGradient.Offset = Vector2.new(0, 0)
    end
end
spawn(AnimarScriptsGradient)

-- Dados dos Jogos
local Jogos = {
    {Nome = "Murderers vs Sheriffs Duels", Scripts = {
        {Nome = "ESP + Hitbox + Aimbot", Loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/NickNick00/Assassinos-sheriff/refs/heads/main/.lua"))()'},
        {Nome = "Teste Simples", Loadstring = "print('Teste OK!')"}
    }},
    {Nome = "Outros Jogos", Scripts = {
        {Nome = "Auto Farm", Loadstring = "print('Auto Farm')"}
    }},
}

-- PopUp de Confirmação (contador 3s + delay 1s para "Executando...")
local PopUp = nil
local ContadorAtivo = false
local ContadorConnection = nil
local Executando = false

local function CriarPopUp(titulo, mensagem, acaoConfirmar, textoBotaoSim)
    if PopUp then PopUp:Destroy() end
    ContadorAtivo = false
    Executando = false
    if ContadorConnection then ContadorConnection:Disconnect() end

    PopUp = Instance.new("Frame")
    PopUp.Name = "PopUp"
    PopUp.Parent = ScreenGui
    PopUp.Size = UDim2.new(0, 320, 0, 180)
    PopUp.Position = UDim2.new(0.5, -160, 0.5, -90)
    PopUp.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    PopUp.BorderSizePixel = 0
    PopUp.Active = true

    local CornerPop = Instance.new("UICorner")
    CornerPop.CornerRadius = UDim.new(0, 12)
    CornerPop.Parent = PopUp

    local StrokePop = Instance.new("UIStroke")
    StrokePop.Color = Color3.fromRGB(60, 60, 80)
    StrokePop.Thickness = 1.5
    StrokePop.Parent = PopUp

    local TituloPop = Instance.new("TextLabel")
    TituloPop.Parent = PopUp
    TituloPop.Size = UDim2.new(1, 0, 0, 40)
    TituloPop.Position = UDim2.new(0, 0, 0, 10)
    TituloPop.BackgroundTransparency = 1
    TituloPop.Text = titulo
    TituloPop.TextColor3 = Color3.fromRGB(255, 255, 255)
    TituloPop.TextScaled = true
    TituloPop.Font = Enum.Font.GothamBold

    local Msg = Instance.new("TextLabel")
    Msg.Parent = PopUp
    Msg.Size = UDim2.new(1, -40, 0, 40)
    Msg.Position = UDim2.new(0, 20, 0, 50)
    Msg.BackgroundTransparency = 1
    Msg.Text = mensagem
    Msg.TextColor3 = Color3.fromRGB(200, 200, 220)
    Msg.TextScaled = true
    Msg.Font = Enum.Font.Gotham
    Msg.TextWrapped = true

    local BtnSim = Instance.new("TextButton")
    BtnSim.Parent = PopUp
    BtnSim.Size = UDim2.new(0, 120, 0, 40)
    BtnSim.Position = UDim2.new(0, 30, 1, -50)
    BtnSim.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    BtnSim.Text = textoBotaoSim or "SIM"
    BtnSim.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnSim.TextScaled = true
    BtnSim.Font = Enum.Font.GothamBold

    local CornerSim = Instance.new("UICorner")
    CornerSim.CornerRadius = UDim.new(0, 8)
    CornerSim.Parent = BtnSim

    local BtnNao = Instance.new("TextButton")
    BtnNao.Parent = PopUp
    BtnNao.Size = UDim2.new(0, 120, 0, 40)
    BtnNao.Position = UDim2.new(1, -150, 1, -50)
    BtnNao.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    BtnNao.Text = "NÃO"
    BtnNao.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnNao.TextScaled = true
    BtnNao.Font = Enum.Font.GothamBold

    local CornerNao = Instance.new("UICorner")
    CornerNao.CornerRadius = UDim.new(0, 8)
    CornerNao.Parent = BtnNao

    BtnSim.MouseButton1Click:Connect(function()
        if Executando then
            return  -- Bloqueia clique durante execução
        end

        if ContadorAtivo then
            ContadorAtivo = false
            if ContadorConnection then ContadorConnection:Disconnect() end
            BtnSim.Text = textoBotaoSim or "SIM"
            BtnNao.Visible = true
            return
        end

        ContadorAtivo = true
        local TempoRestante = 3.59
        BtnSim.Text = "3.59"
        BtnNao.Visible = false

        ContadorConnection = RunService.Heartbeat:Connect(function(delta)
            if not ContadorAtivo then return end
            TempoRestante = TempoRestante - delta
            if TempoRestante <= 0 then
                ContadorAtivo = false
                if ContadorConnection then ContadorConnection:Disconnect() end
                Executando = true
                BtnSim.Text = "Executando..."
                wait(1)  -- Delay reduzido para 1 segundo
                acaoConfirmar()
                PopUp:Destroy()
                Executando = false
                return
            end
            BtnSim.Text = string.format("%.2f", TempoRestante)
        end)
    end)

    BtnNao.MouseButton1Click:Connect(function()
        ContadorAtivo = false
        if ContadorConnection then ContadorConnection:Disconnect() end
        PopUp:Destroy()
    end)
end

-- Criar Botões de Jogos
local BotaoJogos = {}

local function CriarBotaoJogo(nome, index, scripts)
    local Btn = Instance.new("TextButton")
    Btn.Parent = JogosList
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.Position = UDim2.new(0, 0, 0, (index-1)*45)
    Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Btn.Text = nome
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextScaled = true
    Btn.Font = Enum.Font.GothamSemibold
    Btn.Visible = true

    local CornerBtn = Instance.new("UICorner")
    CornerBtn.CornerRadius = UDim.new(0, 8)
    CornerBtn.Parent = Btn

    table.insert(BotaoJogos, {Btn = Btn, Nome = nome, Scripts = scripts})

    Btn.MouseButton1Click:Connect(function()
        for _, child in pairs(ScriptsList:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        local yPos = 0
        for _, scriptData in ipairs(scripts) do
            local ScriptBtn = Instance.new("TextButton")
            ScriptBtn.Parent = ScriptsList
            ScriptBtn.Size = UDim2.new(1, 0, 0, 40)
            ScriptBtn.Position = UDim2.new(0, 0, 0, yPos)
            ScriptBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
            ScriptBtn.Text = scriptData.Nome
            ScriptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            ScriptBtn.TextScaled = true
            ScriptBtn.Font = Enum.Font.Gotham
            ScriptBtn.TextXAlignment = Enum.TextXAlignment.Left

            local Padding = Instance.new("UIPadding")
            Padding.PaddingLeft = UDim.new(0, 10)
            Padding.Parent = ScriptBtn

            local CornerScript = Instance.new("UICorner")
            CornerScript.CornerRadius = UDim.new(0, 8)
            CornerScript.Parent = ScriptBtn

            ScriptBtn.MouseButton1Click:Connect(function()
                CriarPopUp("Executar?", "Executar:\n" .. scriptData.Nome .. "?", function()
                    pcall(function() loadstring(scriptData.Loadstring)() end)
                end, "SIM")
            end)

            yPos = yPos + 45
        end
        ScriptsList.CanvasSize = UDim2.new(0, 0, 0, yPos)
    end)
end

local function AtualizarListaJogos()
    local query = SearchBar.Text:lower()
    local visibleCount = 0
    for _, data in ipairs(BotaoJogos) do
        if query == "" or data.Nome:lower():find(query, 1, true) then
            data.Btn.Visible = true
            data.Btn.Position = UDim2.new(0, 0, 0, visibleCount * 45)
            visibleCount = visibleCount + 1
        else
            data.Btn.Visible = false
        end
    end
    JogosList.CanvasSize = UDim2.new(0, 0, 0, visibleCount * 45)
end

for i, jogo in ipairs(Jogos) do
    CriarBotaoJogo(jogo.Nome, i, jogo.Scripts)
end
JogosList.CanvasSize = UDim2.new(0, 0, 0, #Jogos * 45)

SearchBar:GetPropertyChangedSignal("Text"):Connect(AtualizarListaJogos)

-- Drag
local dragging, dragInput, dragStart, startPos

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
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

-- Minimizar
local estaMinimizado = false
BtnMinimizar.MouseButton1Click:Connect(function()
    estaMinimizado = not estaMinimizado
    if estaMinimizado then
        BtnMinimizar.Text = "+"
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 450, 0, 50)}):Play()
        TweenService:Create(Fundo, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        Sidebar.Visible = false
        ScriptsArea.Visible = false
    else
        BtnMinimizar.Text = "-"
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 450, 0, 300)}):Play()
        TweenService:Create(Fundo, TweenInfo.new(0.3), {BackgroundTransparency = 0.4}):Play()
        Sidebar.Visible = true
        ScriptsArea.Visible = true
    end
end)

-- Destruir Hub
BtnDestruir.MouseButton1Click:Connect(function()
    CriarPopUp("Destruir Hub", "Tem certeza que deseja destruir o GEKYU HUB?", function()
        ScreenGui:Destroy()
    end, "SIM")
end)

-- Animação Intro
local function AnimarIntroLabel()
    TweenService:Create(IntroLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

    for i = 1, 4 do
        wait(1)
        TweenService:Create(IntroLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        wait(1)
        TweenService:Create(IntroLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    end

    TweenService:Create(IntroLabel, TweenInfo.new(1), {TextTransparency = 1}):Play()
    TweenService:Create(IntroScreen, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    wait(1)

    IntroScreen:Destroy()

    MainFrame.Visible = true
    TweenService:Create(Fundo, TweenInfo.new(0.5), {BackgroundTransparency = 0.4}):Play()
    TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 450, 0, 300)}):Play()
end

-- Key Temporária
local function VerificarKeyTemporaria()
    if not KeyTemporariaAtivada then return true end
    local savedTime = player:GetAttribute("KeyTempTime") or 0
    return os.time() - savedTime < 12 * 3600
end

local function SalvarKeyTemporaria()
    player:SetAttribute("KeyTempTime", os.time())
end

-- Verificar Key
BtnVerificar.MouseButton1Click:Connect(function()
    local key = KeyBox.Text
    if key == "" then
        ErroLabel.Text = "Coloque a senha!"
        ErroLabel.Visible = true
        wait(3)
        ErroLabel.Visible = false
        return
    end

    if key == KeyCorreta then
        if KeyTemporariaAtivada then
            SalvarKeyTemporaria()
        end
        KeyInputFrame.Visible = false
        BtnVerificar.Visible = false
        BtnCancelar.Visible = false
        ErroLabel.Visible = false
        AnimarIntroLabel()
    else
        ErroLabel.Text = "Senha errada!"
        ErroLabel.Visible = true
        wait(3)
        ErroLabel.Visible = false
    end
end)

BtnCancelar.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Inicia se key temporária válida
if VerificarKeyTemporaria() then
    KeyInputFrame.Visible = false
    BtnVerificar.Visible = false
    BtnCancelar.Visible = false
    AnimarIntroLabel()
end

-- Inicia gradiente
spawn(function()
    wait(0.5)
    TweenService:Create(IntroLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
end)

print("GEKYU HUB V3.23 COMPLETO - 'EXECUTANDO...' AGORA 1 SEGUNDO!")
