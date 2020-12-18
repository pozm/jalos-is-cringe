local makedir = createdirectory or makefolder

pcall(makedir, "uranium")

rRepo = "pozm" -- Autist69420

local main = "https://raw.githubusercontent.com/".. rRepo .. "/jalos-is-cringe/main/main.lua"
local ui = "https://pastebin.com/raw/BbxzJKTw"
local functions = "https://raw.githubusercontent.com/".. rRepo .. "/jalos-is-cringe/main/functions.lua"
local variables = "https://raw.githubusercontent.com/".. rRepo .. "/jalos-is-cringe/main/variables.lua"

local HttpRequest = http_request or request or syn.request

local checkUpdated = function() 
	
    local exists = isfile('uranium/version')
    if (not exists) return false;
    local lastVersion = readfile('uranium/version')
    local id = game:GetService("HttpService"):JSONDecode(Get("https://api.github.com/repos/Autist69420/jalos-is-cringe/commits?per_page=1"))[1].sha
    writefile('uranium/version',id)
    if (id == lastVersion) return true;
    return false;


end
local Update = function()
    writefile("uranium/main.lua", Get(main))

    writefile("uranium/ui.lua", Get(ui))

    writefile("uranium/functions.lua", Get(functions))

    writefile("uranium/variables.lua", Get(variables))
end

local function Get(url)
	return HttpRequest({Url = url,Method = "GET"}).Body
end

if (not s) then
    Update()
else
    print(checkUpdated())

end
loadfile("uranium/main.lua")()