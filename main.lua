-- > init
local lib = loadfile("uranium/ui.lua")()
local functions = loadfile("uranium/functions.lua")()
local variables = loadfile("uranium/variables.lua")()

-- > tabs & sections

local WeaponsTab = lib:CreateTab("Weapons")
local WeaponsMainSection = WeaponsTab:CreateSection("Weapon")
local WeaponsConfigSection = WeaponsTab:CreateSection("Config")

local PlayerTab = lib:CreateTab("Player")
local PlayerMainSection = PlayerTab:CreateSection("Player")
local PlayerConfigSection = PlayerTab:CreateSection("Config")

local WorldTab = lib:CreateTab("World")
local WorldMainSection = WorldTab:CreateSection("World")
local WorldConfigSection = WorldTab:CreateSection("Config")

local CamerasTab = lib:CreateTab("Cameras")
local CamerasMainSection = CamerasTab:CreateSection("Cameras")
local CamerasConfigSection = CamerasTab:CreateSection("Config")

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

--// player

PlayerMainSection:CreateDropdown("Teleport to", variables.tpNames, 1, function( arg1 )
	local Cframe = CFrame.new(variables.tpLocations[arg1].X, variables.tpLocations[arg1].Y + 5, variables.tpLocations[arg1].Z) -- i know bad code im fixing it later
	if variables.Settings.Player.TweenTP then
		functions.tween(variables.LocalPlayer.Character.HumanoidRootPart, .3,
			{
				CFrame = Cframe
			}
		)
	else
		functions.MoveTo(Cframe)
	end
end)


PlayerConfigSection:CreateToggle("Tween Teleport", function( arg1 )
	variables.Settings.Player.TweenTP = arg1
end)

--// world

WorldMainSection:CreateToggle("Spam CCTV", function( arg1 )
	variables.Settings.World.SpamCCTV = arg1
end)

WorldMainSection:CreateToggle("Spam time", function( arg1 )
	variables.Settings.World.TimeSpam = arg1
end)

WorldMainSection:CreateToggle("Spam doors", function( arg1 )
	variables.Settings.World.DoorSpam = arg1
end)

WorldMainSection:CreateButton("No minimum level", function( ... )
	workspace.minimumLevel.Position = Vector3.new(workspace.minimumLevel.Position.X, -9e9, workspace.minimumLevel.Position.Z)
end)

--// Cameras

CamerasMainSection:CreateButton("Move Cameras Up", function()
	for i,v in pairs(workspace.AllMovables.SecurityCams:GetChildren()) do
		functions.rotateSecCam2(v, 0, 1)
	end
end)

CamerasMainSection:CreateButton("Move Cameras Down", function()
	for i,v in pairs(workspace.AllMovables.SecurityCams:GetChildren()) do
		functions.rotateSecCam2(v, 0, -1)
	end
end)

CamerasMainSection:CreateButton("Move Cameras Left", function()
	for i,v in pairs(workspace.AllMovables.SecurityCams:GetChildren()) do
		functions.rotateSecCam2(v, 1, 0)
	end
end)

CamerasMainSection:CreateButton("Move Cameras Right", function()
	for i,v in pairs(workspace.AllMovables.SecurityCams:GetChildren()) do
		functions.rotateSecCam2(v, -1, 0)
	end
end)

-- > render loop

variables.RunService:BindToRenderStep("renderLoop", 0, function( ... )
	
end)

-- > function loop

variables.RunService:BindToRenderStep("functionLoop", 0, function( ... )
    if variables.Settings.World.SpamCCTV then
		for i,v in pairs(workspace.AllMovables.SecurityCams:GetChildren()) do
			functions.rotateSecCam(v)
		end
	end

	if variables.Settings.World.TimeSpam then
		for i,v in pairs(workspace.AllMovables.SecurityCams:GetChildren()) do
			x = math.random(-1000, 1000)
            variables.FireServer("FireAllClients","updateClock",x)
		end
	end

	if variables.Settings.World.DoorSpam then
		for i,v in pairs(workspace.AllDoors:GetChildren()) do
			variables.FireServer("updateDoorSystem", v)
		end
	end
end)
