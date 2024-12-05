local source = loadstring(game:HttpGet("https://raw.githubusercontent.com/alriceeeee/loadingscreenbs/refs/heads/main/source.lua"))()

local config = {
    LoadingScreenText = "Loading...",
    Tasks = {
        "Unequip your fishing rod",
        "Go to spawn area",
    },
    ButtonText = "I have completed these tasks",
    Callback = function()
        print("Tasks completed, loading main UI...")
        -- Load your other UI lib here
    end
}

source.Init(config)
