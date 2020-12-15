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

local WorldTab = lib:CreateTab("World")
local WorldMainSection = PlayerTab:CreateSection("Player")
local WorldConfigSection = PlayerTab:CreateSection("Config")

local RenderTab = lib:CreateTab("Render")
local RenderMainSection = RenderTab:CreateSection("Render")
local RenderConfigSection = RenderTab:CreateSection("Config")

-- > buttons and shit

--// weapons

WeaponsMainSection:CreateButton("All guns", function()
    for i,v in pairs(variables.gunTable) do
        variables.InvokeServer("giveItem", v)
    end
end)

WeaponsMainSection:CreateButton("Modify Weapons", function( ... )
	for i,v in next, getgc(true) do
        if type(v) == "table" and rawget(v,"maxAmmo") then
			if variables.Settings.Weapons.InfAmmo then
				v.maxAmmo = math.huge
				v.exAmmo = math.huge
				v.maxExAmmo = math.huge
			end

			if variables.Settings.Weapons.NoCooldown then
				v.coolDown = 0
			end

			if variables.Settings.Weapons.AutoFire then
				v.fireType = "automatic"
			end

			if variables.Settings.Weapons.LongRange then
				v.range = 9e9
			end

			if variables.Settings.Weapons.OneShot then
				v.damage = 100
			end

			if variables.Settings.Weapons.InstaReload then
				v.reloadTime = 0
			end

			if variables.Settings.Weapons.NoSpread then
				v.sprayRange = 0
			end
        end
    end
end)

WeaponsConfigSection:CreateToggle("Infinite Ammo", function( arg1 )
    variables.Settings.Weapons.InfAmmo = arg1
end)

WeaponsConfigSection:CreateToggle("No Cooldown", function( arg1 )
    variables.Settings.Weapons.NoCooldown = arg1
end)

WeaponsConfigSection:CreateToggle("Auto Fire", function( arg1 )
    variables.Settings.Weapons.AutoFire = arg1
end)

WeaponsConfigSection:CreateToggle("Long Range", function( arg1 )
    variables.Settings.Weapons.LongRange = arg1
end)

WeaponsConfigSection:CreateToggle("One Shot", function( arg1 )
    variables.Settings.Weapons.OneShot = arg1
end)

WeaponsConfigSection:CreateToggle("Insta Reload", function( arg1 )
    variables.Settings.Weapons.InstaReload = arg1
end)

WeaponsConfigSection:CreateToggle("No Spread", function( arg1 )
    variables.Settings.Weapons.NoSpread = arg1
end)

--// world

WorldMainSection:CreateToggle("Spam CCTV", function( arg1 )
	variables.Settings.World.SpamCCTV = arg1
end)

-- > render loop

variables.RunService:BindToRenderStep("renderLoop", 0, function( ... )
	if variables.Settings.World.SpamCCTV then
		for i,v in pairs(workspace.AllMovables.SecurityCams:GetChildren()) do
			functions.rotateSecCam(v, math.random(100), math.random(100))
		end
	end
end)

-- > function loop

variables.RunService:BindToRenderStep("functionLoop", 0, function( ... )
    
end)
