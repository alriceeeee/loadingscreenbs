local LoadingScreen = {}

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
local Background = Instance.new("Frame")
local LoadingText = Instance.new("TextLabel")

ScreenGui.Name = "LoadingScreen"
ScreenGui.Parent = Player.PlayerGui
ScreenGui.ResetOnSpawn = false

Background.Name = "Background"
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Background.Parent = ScreenGui

LoadingText.Name = "LoadingText"
LoadingText.Size = UDim2.new(0.5, 0, 0.1, 0)
LoadingText.Position = UDim2.new(0.25, 0, 0.45, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.TextScaled = true
LoadingText.Font = Enum.Font.GothamBold
LoadingText.Parent = Background

function LoadingScreen.Init(config)
    LoadingText.Text = config.LoadingScreenText or "Loading..."
    
    local TaskGui = Instance.new("ScreenGui")
    local TaskFrame = Instance.new("Frame")
    local TaskList = Instance.new("Frame")
    local DoneButton = Instance.new("TextButton")
    
    TaskGui.Name = "TaskGui"
    TaskGui.Parent = Player.PlayerGui
    
    TaskFrame.Name = "TaskFrame"
    TaskFrame.Size = UDim2.new(0.2, 0, 0.3, 0)
    TaskFrame.Position = UDim2.new(0.8, -10, 0.7, -10)
    TaskFrame.BackgroundTransparency = 1
    TaskFrame.Parent = TaskGui
    
    TaskList.Name = "TaskList"
    TaskList.Size = UDim2.new(1, 0, 0.8, 0)
    TaskList.BackgroundTransparency = 1
    TaskList.Parent = TaskFrame
    
    local taskHeight = 1 / #config.Tasks
    
    for i, taskText in ipairs(config.Tasks) do
        local TaskLabel = Instance.new("TextLabel")
        TaskLabel.Size = UDim2.new(1, 0, taskHeight, -2)
        TaskLabel.Position = UDim2.new(0, 0, taskHeight * (i-1), 0)
        TaskLabel.BackgroundTransparency = 1
        TaskLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TaskLabel.Text = taskText
        TaskLabel.TextWrapped = true
        TaskLabel.Font = Enum.Font.GothamBold
        TaskLabel.TextSize = 14
        TaskLabel.Parent = TaskList
    end
    
    DoneButton.Name = "DoneButton"
    DoneButton.Size = UDim2.new(1, 0, 0.15, 0)
    DoneButton.Position = UDim2.new(0, 0, 0.85, 0)
    DoneButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    DoneButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DoneButton.Text = config.ButtonText
    DoneButton.Font = Enum.Font.GothamBold
    DoneButton.TextSize = 14
    DoneButton.Parent = TaskFrame
    
    DoneButton.MouseButton1Click:Connect(function()
        local fadeOut = TweenService:Create(Background, TweenInfo.new(0.5), {BackgroundTransparency = 1})
        fadeOut:Play()
        fadeOut.Completed:Wait()
        ScreenGui.Enabled = false
        TaskGui:Destroy()
        if config.Callback then config.Callback() end
    end)
end

return LoadingScreen