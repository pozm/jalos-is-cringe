-- > init
local lib = loadfile("ui.lua")()
local functions = loadfile("functions.lua")()
local variables = loadfile("variables.lua")()

-- > tabs & sections

local WeaponsTab = lib:CreateTab("Weapons")
local WeaponsMainSection = WeaponsTab:CreateSection("Weapon")
local WeaponsConfigSection = WeaponsTab:CreateSection("Config")

local PlayerTab = lib:CreateTab("Player")
local PlayerMainSection = PlayerTab:CreateSection("Player")
local PlayerConfigSection = PlayerTab:CreateSection("Config")

local RenderTab = lib:CreateTab("Render")
local RenderMainSection = RenderTab:CreateSection("Render")
local RenderConfigSection = RenderTab:CreateSection("Config")

-- > client variables

-- > buttons and shit

WeaponsMainSection:CreateButton("All guns", function()
	table.foreach(variables.gunTable, function( i, v )
		variables.InvokeServer("giveItem", v)
	end)
end)

WeaponsMainSection:CreateToggle("Aimbot", function(boolean)
	print("Aimbot:", boolean)
end)

-- > render loop

variables.RunService:BindToRenderStep("renderLoop", 0, function( ... )
    
end)

-- > function loop

variables.RunService:BindToRenderStep("functionLoop", 0, function( ... )
    
end)
