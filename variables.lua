local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local LocalPlayerBackpack = LocalPlayer.Backpack

return {
    Players = Players,
    RunService = RunService,
    
    LocalPlayer = LocalPlayer,
    LocalPlayerBackpack = LocalPlayerBackpack,
    
    FireServer = require(workspace.upsilonLibrary).FireServer,
    InvokeServer = require(workspace.upsilonLibrary).InvokeServer,
    
    Settings = {
        Player = {
        
        },
        
        Weapons = {
            
        },

        World = {
            SpamCCTV = false,
            TimeSpam = false,
            DoorSpam = false
        },
        
        Render = {
        
        }
    },
    
    gunTable = {"S&W 638","M1014","Dragunov","ACR","Makarov","SPAS-12","L86A2","M60","Beretta M9","Revolver","M14","AK47-U","M16","AK47","UMP-45","M98B"},

    tpNames = {"Cake","Courtyard","Vents","Cells","Helipad","Tower","Police HQ","Criminal Base","Cave","ATV Building","Entrance Tower","Keycard Building"},
    tpLocations = {
        ["Cake"] = Vector3.new(108.500664, 4, -27.2045383),
        ["Courtyard"] = Vector3.new(243.07106, 2.3200254, -80.9014206),
        ["Vents"] = Vector3.new(118, 31.5, 59),
        ["Cells"] = Vector3.new(-4, 1.5, -7),
        ["Helipad"] = Vector3.new(236.001, 1.8, 53.997),
        ["Tower"] = Vector3.new(189, 42.501, -195),
        ["Police HQ"] = Vector3.new(93, 1.5, 15),
        ["Criminal Base"] = Vector3.new(-600.986, -27.542, -333),
        ["Cave"] = Vector3.new(616.33606, 7.11495972, -225.397186),
        ["ATV Building"] = Vector3.new(44.9203072, 5, -233.453262),
        ["Entrance Tower"] = Vector3.new(110.673782, 26, -327.952759),
        ["Keycard Building"] = Vector3.new(-428.097046, -23.9986668, -519.590576)
    }
}
