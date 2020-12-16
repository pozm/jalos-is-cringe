local variables = loadfile("uranium/variables.lua")()

return {
    drawLaser = function( origin, target, properties )
        variables.FireServer("FireAllClients","drawLaser", origin, target, properties)
    end,

    rotateSecCam = function(camera)
        if not camera then  return end
        val1 = math.random(-1000,1000) * 2
        val2 = math.random(-1000,1000) * 2
        variables.FireServer("updateSecurityCamRotation", camera, val1, val2)
    end,

    rotateSecCam2 = function(camera, val1, val2)
        if not camera then  return end
        val1 = val1 * (math.pi / 8);
	    val2 = val2 * (math.pi / 12);
        variables.FireServer("updateSecurityCamRotation", camera, val1, val2)
    end,

    tween = function( part, time, properties )
        local tweenService = game:GetService("TweenService")
        local info = TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut) 
        local Tween = tweenService:Create(part, info, properties)
        Tween:Play()
        return Tween
    end,

    MoveTo = function(cframe)
        variables.LocalPlayer.Character:SetPrimaryPartCFrame(cframe)
    end,
	
	Cosmetics = {
		wearShirt = function(id)
			variables.FireServer("wearShirt", id)
		end,
		
		wearPants = function(id)
			variables.FireServer("wearPants", id)
		end,
		
		wearHat = function(id)
			variables.FireServer("wearHat", id)
		end
	}
}
