local makedir = createdirectory or makefolder

pcall(makedir, "uranium")

rRepo = "Autist69420" -- Autist69420 -- pozm

local main = "https://raw.githubusercontent.com/".. rRepo .. "/jalos-is-cringe/main/main.lua"
local ui = "https://pastebin.com/raw/BbxzJKTw"
local functions = "https://raw.githubusercontent.com/".. rRepo .. "/jalos-is-cringe/main/functions.lua"
local variables = "https://raw.githubusercontent.com/".. rRepo .. "/jalos-is-cringe/main/variables.lua"

local HttpRequest = http_request or request or syn.request

local function Get(url)
	return HttpRequest({Url = url,Method = "GET"}).Body
end

local checkUpdated = function() 
	
    local exists = isfile('uranium/.version')
    if (not exists) then return false; end
    local lastVersion = readfile('uranium/.version')
    local id = game:GetService("HttpService"):JSONDecode(Get("https://api.github.com/repos/" .. rRepo .. "/jalos-is-cringe/commits?per_page=1"))[1].sha
    writefile('uranium/.version',id)
    if (id == lastVersion) then return true; end
    return false;


end
local Update = function()
    print("updating...")
    writefile("uranium/main.lua", Get(main))

    writefile("uranium/ui.lua", Get(ui))

    writefile("uranium/functions.lua", Get(functions))

    writefile("uranium/variables.lua", Get(variables))
    
    local exists = isfile('uranium/.version')
    if (not exists) then writefile('uranium/.version',-32) end
end

local updated = checkUpdated()

if (not updated) then
    Update()
else
    print("Updated!")

end
loadfile("uranium/main.lua")()