local makedir = createdirectory or makefolder

local ScreenGui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local bar = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local progress = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local name = Instance.new("TextLabel")
local status = Instance.new("TextLabel")

--Properties:

ScreenGui.Parent = game.CoreGui

mainFrame.Name = "mainFrame"
mainFrame.Parent = ScreenGui
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Size = UDim2.new(0, 500, 0, 200)

UICorner.Parent = mainFrame

bar.Name = "bar"
bar.Parent = mainFrame
bar.AnchorPoint = Vector2.new(0.5, 1)
bar.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
bar.Position = UDim2.new(0.5, 0, 1, -50)
bar.Size = UDim2.new(0, 300, 0, 20)

UICorner_2.Parent = bar

progress.Name = "progress"
progress.Parent = bar
progress.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
progress.BorderSizePixel = 0
progress.Size = UDim2.new(0, 0, 0, 20)

UICorner_3.Parent = progress

name.Name = "name"
name.Parent = mainFrame
name.AnchorPoint = Vector2.new(0.5, 0.5)
name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
name.BackgroundTransparency = 1.000
name.Position = UDim2.new(0.5, 0, 0.5, -40)
name.Size = UDim2.new(0, 200, 0, 50)
name.Font = Enum.Font.Roboto
name.Text = "cock loader"
name.TextColor3 = Color3.fromRGB(255, 255, 255)
name.TextSize = 29.000

status.Name = "status"
status.Parent = name
status.AnchorPoint = Vector2.new(0.5, 0.5)
status.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
status.BackgroundTransparency = 1.000
status.Position = UDim2.new(0.5, 0, 0.400000006, 30)
status.Size = UDim2.new(0, 200, 0, 40)
status.Font = Enum.Font.Roboto
status.Text = "Downloading :"
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.TextSize = 15.000

local files = {
    {

        name = "main.lua",
        link = "https://raw.githubusercontent.com/Autist69420/jalos-is-cringe/main/main.lua"
    },

	{
		name = "ui.lua",
		link = "https://pastebin.com/raw/BbxzJKTw"
    },
    
    {
        name = "functions.lua",
        link = "https://raw.githubusercontent.com/Autist69420/jalos-is-cringe/main/functions.lua"
    },

    {
        name = "variables.lua",
        link = "https://raw.githubusercontent.com/Autist69420/jalos-is-cringe/main/variables.lua"
    }
} -- put links of the files in here

local done = {}

function download()
	makedir("uranium")
	
	table.foreach(files, function(i, v)
		local start = tick()
		
		local res = request({
			Url = v.link,
			Method = "GET"
		}).Body
		
		
		writefile("uranium/" .. v.name, res)
		status.Text = ("Downloaded: %s\nTook: %s"):format(v.name, tostring(math.floor(start - tick())))
        table.insert(done, v.name )
    end)
    
    repeat wait() until #done == #files

    status.Text = "Done, executing..."
    pcall(function( ... )
        loadfile("uranium/main.lua")()
    end) -- cuz yes
    progress.Size = bar.Size
    wait(2)
    ScreenGui:Destroy()
end
	
download()
