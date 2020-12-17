-- > init
local lib = loadfile("uranium/ui.lua")()
local functions = loadfile("uranium/functions.lua")()
local variables = loadfile("uranium/variables.lua")()

-- > tabs & sections

local ui = lib.new(true);
ui.ChangeToggleKey(Enum.KeyCode.P)

local WeaponsTab = ui:Category("Weapons")
local WeaponsMainSection = WeaponsTab:Sector("Weapon")
local WeaponsConfigSection = WeaponsTab:Sector("Config")

local PlayerTab = ui:Category("Player")
local PlayerMainSection = PlayerTab:Sector("Player")
local PlayerConfigSection = PlayerTab:Sector("Config")

local WorldTab = ui:Category("World")
local WorldMainSection = WorldTab:Sector("World")
local WorldConfigSection = WorldTab:Sector("Config")

local CamerasTab = ui:Category("Cameras")
local CamerasMainSection = CamerasTab:Sector("Cameras")
local CamerasConfigSection = CamerasTab:Sector("Config")

local RenderTab = ui:Category("Render")
local RenderMainSection = RenderTab:Sector("Render")
local RenderConfigSection = RenderTab:Sector("Config")

local CreditsTab = ui:Category("Credits")
local CreditsMainSection = CreditsTab:Sector("Credits")

local Camera = game.Workspace.CurrentCamera;
local BottomVector = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y);
local Lines = {};

local function AddLine(arg1, arg2)
	local Line = Drawing.new("Line");
	local PartVector = Camera:WorldToViewportPoint(arg1.Position);
	Line.Visible = true;
	Line.From = BottomVector;
	Line.To = Vector2.new(PartVector.X, PartVector.Y);
	Line.Color = Color3.fromRGB(255, 255, 255);
	Line.Thickness = variables.Settings.Render.Thickness;
	Line.Transparency = 1;
	local Distance = Drawing.new("Text");
	Distance.Text = "0";
	Distance.Size = 16;
	Distance.Visible = true;
	Distance.Position = Vector2.new(PartVector.X, PartVector.Y - 20);
	Lines[#Lines + 1] = {
		Part = arg1,
		Line = Line,
		Player = arg2 or nil,
		Distance = Distance
	}
end;

local function UpdateLines()
	for i, v in pairs(Lines) do
		local Line = v.Line;
		if v.Part and v.Part.Parent ~= nil and v.Player and v.Player.Character and v.Player.Character:FindFirstChild("Head") then
			local PartVector, onScreen = Camera:WorldToViewportPoint(v.Part.Position);
			if onScreen then
				if not Line.Visible then
					Line.Visible = true;
				end;
				Line.To = Vector2.new(PartVector.X, PartVector.Y);
			else
				v.Distance.Visible = false;
				Line.Visible = false;
			end;
			if v.Player.TeamColor ~= nil and variables.Settings.Render.Showteam then
				Line.Color = v.Player.TeamColor.Color;
			else
				Line.Color = Color3.fromRGB(255, 255, 255);
			end;
			Line.Thickness = variables.Settings.Render.Thickness;
			if game.Players.LocalPlayer.Character:FindFirstChild("Head") and variables.Settings.Render.Distance then
				local Distance = math.ceil((v.Part.Position - game.Players.LocalPlayer.Character.Head.Position).magnitude);
				v.Distance.Text = ("Distance: %s"):format(Distance);
				v.Distance.Position = Vector2.new(PartVector.X, PartVector.Y - 20);
				v.Distance.Visible = true;
			else
				v.Distance.Visible = false;
			end;
		else
			Line.Visible = false;
			Line:Remove();
			table.remove(Lines, i)
		end;
	end;
end;


-- > buttons and shit

--// weapons

WeaponsMainSection:Cheat("Button", "All guns", function()
	for i, v in pairs(variables.gunTable) do
		variables.InvokeServer("giveItem", v)
	end
end)

WeaponsMainSection:Cheat("Button", "Modify Weapons", function( ... )
	for i, v in next, getgc(true) do
		if type(v) == "table" and rawget(v, "maxAmmo") then
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

WeaponsConfigSection:Cheat("Checkbox", "Infinite Ammo", function( arg1 )
	variables.Settings.Weapons.InfAmmo = arg1
end)

WeaponsConfigSection:Cheat("Checkbox", "No Cooldown", function( arg1 )
	variables.Settings.Weapons.NoCooldown = arg1
end)

WeaponsConfigSection:Cheat("Checkbox", "Auto Fire", function( arg1 )
	variables.Settings.Weapons.AutoFire = arg1
end)

WeaponsConfigSection:Cheat("Checkbox", "Long Range", function( arg1 )
	variables.Settings.Weapons.LongRange = arg1
end)

WeaponsConfigSection:Cheat("Checkbox", "One Shot", function( arg1 )
	variables.Settings.Weapons.OneShot = arg1
end)

WeaponsConfigSection:Cheat("Checkbox", "Insta Reload", function( arg1 )
	variables.Settings.Weapons.InstaReload = arg1
end)

WeaponsConfigSection:Cheat("Checkbox", "No Spread", function( arg1 )
	variables.Settings.Weapons.NoSpread = arg1
end)

--// player

PlayerMainSection:Cheat("Dropdown", "Teleport to", function( arg1 )
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
end, {
	options = variables.tpNames,
	default = variables.tpNames[1]
})


PlayerConfigSection:Cheat("Checkbox", "Tween Teleport", function( arg1 )
	variables.Settings.Player.TweenTP = arg1
end)

--// world

WorldMainSection:Cheat("Checkbox", "Spam CCTV", function( arg1 )
	variables.Settings.World.SpamCCTV = arg1
end)

WorldMainSection:Cheat("Checkbox", "Spam time", function( arg1 )
	variables.Settings.World.TimeSpam = arg1
end)

WorldMainSection:Cheat("Checkbox", "Spam doors", function( arg1 )
	variables.Settings.World.DoorSpam = arg1
end)

WorldMainSection:Cheat("Button", "No minimum level", function( ... )
	workspace.minimumLevel.Position = Vector3.new(workspace.minimumLevel.Position.X, -9e9, workspace.minimumLevel.Position.Z)
end)

--// Cameras

CamerasMainSection:Cheat("Button", "Move Cameras Up", function()
	for i, v in pairs(workspace.AllMovables.SecurityCams:GetChildren()) do
		functions.rotateSecCam2(v, 0, 1)
	end
end)

CamerasMainSection:Cheat("Button", "Move Cameras Down", function()
	for i, v in pairs(workspace.AllMovables.SecurityCams:GetChildren()) do
		functions.rotateSecCam2(v, 0, -1)
	end
end)

CamerasMainSection:Cheat("Button", "Move Cameras Left", function()
	for i, v in pairs(workspace.AllMovables.SecurityCams:GetChildren()) do
		functions.rotateSecCam2(v, 1, 0)
	end
end)

CamerasMainSection:Cheat("Button", "Move Cameras Right", function()
	for i, v in pairs(workspace.AllMovables.SecurityCams:GetChildren()) do
		functions.rotateSecCam2(v, -1, 0)
	end
end)

-- // Render

RenderMainSection:Cheat("Checkbox", "Tracers", function ( arg1 )
	variables.Settings.Render.Tracers = arg1;
	for i, v in pairs(game.Players:GetChildren()) do
		if v ~= game.Players.LocalPlayer then
			if variables.Settings.Render.Tracers then
				AddLine(v.Character.Head, v);
				v.CharacterAdded:Connect(function(character)
					if variables.Settings.Render.Tracers then
						local Head = character:WaitForChild("Head");
						AddLine(Head, v);
					end;
				end);
			else
				for i, v in pairs(Lines) do
					if v.Line then
						v.Line:Remove();
						table.remove(Lines, i);
					end;
				end;
			end;
		end;
	end;
end);

RenderMainSection:Cheat("Checkbox", "Show Team", function ( arg1 )
	variables.Settings.Render.Showteam = arg1;
end);

RenderMainSection:Cheat("Checkbox", "Show Distance", function ( arg1 )
	variables.Settings.Render.Distance = arg1;
end);


RenderConfigSection:Cheat("Slider", "Thickness", function( arg1 )
	variables.Settings.Render.Thickness = arg1;
end, {min = 0, max = 20})

--// Credits
CreditsMainSection:Cheat("Label", "autist69420 @ v3rmillion.net")
CreditsMainSection:Cheat("Label", "d s f @ v3rmillion.net")

CreditsMainSection:Cheat("Label", "autist69420 - UI and most functions")
CreditsMainSection:Cheat("Label", "dsf - providing functions needed")

-- > render loop

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		if variables.Settings.Render.Tracers then
			local Head = character:WaitForChild("Head")
			AddLine(Head, player);
		end;
	end);
end);

variables.RunService:BindToRenderStep("renderLoop", 0, function( ... )
	if variables.Settings.Render.Tracers then
		UpdateLines();
	end;
end)

-- > function loop

variables.RunService:BindToRenderStep("functionLoop", 0, function( ... )
	if variables.Settings.World.SpamCCTV then
		for i, v in pairs(workspace.AllMovables.SecurityCams:GetChildren()) do
			functions.rotateSecCam(v)
		end
	end

	if variables.Settings.World.TimeSpam then
		for i, v in pairs(workspace.AllMovables.SecurityCams:GetChildren()) do
			x = math.random(-1000, 1000)
			variables.FireServer("FireAllClients", "updateClock", x)
		end
	end

	if variables.Settings.World.DoorSpam then
		for i, v in pairs(workspace.AllDoors:GetChildren()) do
			variables.FireServer("updateDoorSystem", v)
		end
	end
end)
