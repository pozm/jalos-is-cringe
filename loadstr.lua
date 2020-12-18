local repo = "Autist69420" -- Autist69420 -- pozm
local url = "https://raw.githubusercontent.com/".. repo .."/jalos-is-cringe/main/loader.lua"
local req = http_request or request or syn.request

loadstring(req({Url = url,Method = "GET"}).Body)()