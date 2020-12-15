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
        
        Render = {
        
        }
    },
    
    gunTable = {"S&W 638","M1014","Dragunov","ACR","Makarov","SPAS-12","L86A2","M60","Beretta M9","Revolver","M14","AK47-U","M16","AK47","UMP-45","M98B"}
}