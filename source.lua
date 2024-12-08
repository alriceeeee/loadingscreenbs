local LoadingScreen = {}

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local TextAnimations = {
    TypeWriter = function(label, text)
        for i = 1, #text do
            label.Text = string.sub(text, 1, i)
            task.wait(0.05)
        end
        return true
    end,
    
    FadeInLetters = function(label, text)
        local letters = {}
        label.Text = ""
        
        for i = 1, #text do
            local letterLabel = Instance.new("TextLabel")
            letterLabel.BackgroundTransparency = 1
            letterLabel.Size = UDim2.new(1/#text, 0, 1, 0)
            letterLabel.Position = UDim2.new((i-1)/#text, 0, 0, 0)
            letterLabel.Text = string.sub(text, i, i)
            letterLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            letterLabel.TextScaled = true
            letterLabel.Font = label.Font
            letterLabel.TextTransparency = 1
            letterLabel.Parent = label
            
            table.insert(letters, letterLabel)
        end
        
        for _, letterLabel in ipairs(letters) do
            local fadeIn = TweenService:Create(letterLabel, TweenInfo.new(0.3), {TextTransparency = 0})
            fadeIn:Play()
            task.wait(0.1)
        end
        
        task.wait(0.2)
        label.Text = text
        for _, letterLabel in ipairs(letters) do
            letterLabel:Destroy()
        end
        return true
    end,
    
    Bounce = function(label, text)
        label.Text = text
        local originalPosition = label.Position
        
        for i = 1, 3 do
            local bounceUp = TweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                {Position = originalPosition - UDim2.new(0, 0, 0.02, 0)})
            local bounceDown = TweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), 
                {Position = originalPosition})
            
            bounceUp:Play()
            task.wait(0.2)
            bounceDown:Play()
            task.wait(0.2)
        end
        return true
    end,
    
    Wave = function(label, text)
        label.Text = text
        label.TextScaled = false
        local originalTextSize = 24
        label.TextSize = originalTextSize
        
        for i = 1, 4 do
            local waveUp = TweenService:Create(label, TweenInfo.new(0.5, Enum.EasingStyle.Sine), 
                {TextSize = originalTextSize + 16})
            local waveDown = TweenService:Create(label, TweenInfo.new(0.5, Enum.EasingStyle.Sine), 
                {TextSize = originalTextSize})
            
            waveUp:Play()
            waveUp.Completed:Wait()
            waveDown:Play()
            waveDown.Completed:Wait()
        end
        
        return true
    end
}

local ScreenGui = Instance.new("ScreenGui")
local BlurEffect = Instance.new("BlurEffect")
local Background = Instance.new("Frame")
local LoadingText = Instance.new("TextLabel")

BlurEffect.Size = 0
BlurEffect.Parent = game:GetService("Lighting")

ScreenGui.Name = "LoadingScreen"
ScreenGui.Parent = Player.PlayerGui
ScreenGui.ResetOnSpawn = false

Background.Name = "Background"
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Background.BackgroundTransparency = 0.7
Background.Parent = ScreenGui

LoadingText.Name = "LoadingText"
LoadingText.Size = UDim2.new(0.5, 0, 0.1, 0)
LoadingText.Position = UDim2.new(0.25, 0, 0.45, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.TextScaled = true
LoadingText.TextTransparency = 1
LoadingText.Font = Enum.Font.GothamBold
LoadingText.Parent = Background

function LoadingScreen.Init(config)
    local fullText = config.LoadingScreenText
    LoadingText.Text = ""
    
    local blurTween = TweenService:Create(BlurEffect, TweenInfo.new(0.5), {Size = 20})
    local textFadeIn = TweenService:Create(LoadingText, TweenInfo.new(0.5), {TextTransparency = 0})
    
    blurTween:Play()
    textFadeIn:Play()
    textFadeIn.Completed:Wait()
    
    local animationComplete = false
    
    task.spawn(function()
        local animationName = (config.TextAnimation or "TypeWriter"):lower()
        local selectedAnimation
        
        print("[LoadingScreen] Attempting to use animation:", animationName)
        
        for name, animation in pairs(TextAnimations) do
            if name:lower() == animationName then
                selectedAnimation = animation
                print("[LoadingScreen] Found matching animation:", name)
                break
            end
        end
        
        if not selectedAnimation then
            print("[LoadingScreen] Warning: Animation not found! Defaulting to TypeWriter")
            selectedAnimation = TextAnimations.TypeWriter
        end
        
        print("[LoadingScreen] Starting animation with text:", config.LoadingScreenText)
        animationComplete = selectedAnimation(LoadingText, fullText)
    end)
    
    task.spawn(function()
        repeat task.wait() until animationComplete
        task.wait(1) -- Extra delay after animation completes
        
        local fadeOut = TweenService:Create(Background, TweenInfo.new(0.5), {BackgroundTransparency = 1})
        local textFadeOut = TweenService:Create(LoadingText, TweenInfo.new(0.5), {TextTransparency = 1})
        local blurFadeOut = TweenService:Create(BlurEffect, TweenInfo.new(0.5), {Size = 0})
        
        fadeOut:Play()
        textFadeOut:Play()
        blurFadeOut:Play()
        
        textFadeOut.Completed:Wait()
        BlurEffect:Destroy()
        ScreenGui:Destroy()
    end)
    
    local TaskGui = Instance.new("ScreenGui")
    local TaskFrame = Instance.new("Frame")
    local TaskList = Instance.new("Frame")
    local DoneButton = Instance.new("TextButton")
    
    TaskGui.Name = "TaskGui"
    TaskGui.Parent = Player.PlayerGui
    
    TaskFrame.Name = "TaskFrame"
    TaskFrame.Size = UDim2.new(0.2, 0, 0.3, 0)
    TaskFrame.Position = UDim2.new(1.2, 0, 0.7, -10)
    TaskFrame.BackgroundTransparency = 0.5
    TaskFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TaskFrame.Parent = TaskGui
    
    local slideIn = TweenService:Create(TaskFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(0.8, -10, 0.7, -10)})
    slideIn:Play()
    
    TaskList.Name = "TaskList"
    TaskList.Size = UDim2.new(1, 0, 0.8, 0)
    TaskList.BackgroundTransparency = 0
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
        TaskLabel.TextTransparency = 1
        TaskLabel.Parent = TaskList
        
        local labelFade = TweenService:Create(TaskLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, i * 0.1), {TextTransparency = 0})
        labelFade:Play()
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
        local slideOut = TweenService:Create(TaskFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(1.2, 0, 0.7, -10)})
        slideOut:Play()
        slideOut.Completed:Wait()
        TaskGui:Destroy()
        if config.Callback then config.Callback() end
    end)
end

return LoadingScreen

