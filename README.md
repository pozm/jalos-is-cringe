# Uranium
A redwood prison gui supposed to fuck up the game
> jalos is like really retarded and cringe so im fucking him in the ass with this!

# Credits
- ![Autist69420](https://github.com/Autist69420) - Main gui / functions
- ![dsf](https://github.com/notdsf) - Helping alot <3


# script
The script has a fancy loader or you can use:

```lua
local makedir = createdirectory or makefolder

pcall(makedir, "uranium")

local main = "https://raw.githubusercontent.com/Autist69420/jalos-is-cringe/main/main.lua"
local ui = "https://pastebin.com/raw/BbxzJKTw"
local functions = "https://raw.githubusercontent.com/Autist69420/jalos-is-cringe/main/functions.lua"
local variables = "https://raw.githubusercontent.com/Autist69420/jalos-is-cringe/main/variables.lua"

local HttpRequest = http_request or request or syn.request

local function Get(url)
	return HttpRequest({Url = url,Method = "GET"}).Body
end

writefile("uranium/main.lua", Get(main))

writefile("uranium/ui.lua", Get(ui))

writefile("uranium/functions.lua", Get(functions))

writefile("uranium/variables.lua", Get(variables))

loadfile("uranium/main.lua")()
```
# showcase

![Weapons tab](https://i.imgur.com/552wC6P.gif)
