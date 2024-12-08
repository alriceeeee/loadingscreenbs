local source = loadstring(game:HttpGet("https://raw.githubusercontent.com/alriceeeee/loadingscreenbs/refs/heads/main/source.lua"))()

local config = {
    TextAnimation = "TypeWriter", -- TypeWriter, FadeInLetters, Bounce, Wave (the types of animations)
    LoadingScreenText = "Loading this dumb loading screen...",
    Tasks = {
        "Task 1",
        "Task 2",
    },
    ButtonText = "I have completed these tasks",
    Callback = function()
        print("Tasks completed, loading main UI...")
        --[[ Load your other UI crap here, for example:
        local NEVERLOSE = loadstring(game:HttpGet("https://raw.githubusercontent.com/alriceeeee/NEVERLOSE-UI-Nightly/main/source.lua"))()

NEVERLOSE:Theme("dark") -- [ dark , nightly , original ]

if NEVERLOSE._ActiveWindow then
    NEVERLOSE._ActiveWindow:Destroy()
end

local Window = NEVERLOSE:AddWindow("NEVERLOSE","TEXT HERE")
local Notification = NEVERLOSE:Notification()

Notification.MaxNotifications = 6

Window:AddTabLabel('Home')

local ExampleTab = Window:AddTab('Example Tab','earth') -- [ads , list , folder , earth , locked , home , mouse , user]
local MainTab = Window:AddTab('Test','ads')

local Example = ExampleTab:AddSection('Example',"left")

Example:AddLabel("Label")

Example:AddButton("Test Notification",function()
	print('button')
	Notification:Notify("info","Notification","Test Notification")
	Notification:Notify("warning","Notification","Don't Spam",4)
end)

Example:AddToggle('Toggle',false,function(val)
	print("Toggle",val)
end)

Example:AddKeybind('Keybind',Enum.KeyCode.X,function(val)
	print('keybind',val)
end)

Example:AddSlider('Slider',1,100,50,function(val)
	print('slider',val)
end)

Example:AddDropdown('Dropdown',{1,2,3},2,function(val)
	print("dropdown",val)
end)

-- Section Function --

local Test = ExampleTab:AddSection('Test',"right")

Test:AddToggle('Example',true,function(val)
	if val then
		Example:Show()
	else
		Example:Hide()
	end
end)

--------------------

local SectionTest = MainTab:AddSection('Test',"left")

SectionTest:AddButton("Kick",function()
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local function rejoinGame()
    local player = Players.LocalPlayer
    local placeId = game.PlaceId
    local jobId = game.JobId

    TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
end

-- Call the function to rejoin immediately
rejoinGame()

print("Attempting to rejoin the current game...")
end)
        --]]
    end
}

source.Init(config)
