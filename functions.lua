local variables = loadfile("variables.lua")()

return {
    drawLaser = function( origin, target, properties )
        variables.FireServer("FireAllClients","drawLaser", origin, target, properties)
    end,

    rotateSecCam = function(camera)
        if not camera then  return end
        val1 = math.random(-1000,1000) * 2
        val2 = math.random(-1000,1000) * 2
        variables.FireServer("updateSecurityCamRotation", camera, val1, val2)
    end
}
