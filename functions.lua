local variables = loadfile("variables.lua")()

return {
    drawLaser = function( origin, target, properties )
        variables.FireServer("FireAllClients","drawLaser", origin, target, properties)
    end,

    rotateSecCam = function(camera, val1, val2)
        if not camera then  return end
        val1 = val1 * (math.pi / 8)
        val2 = val2 * (math.pi / 12)
        variables.FireServer("updateSecurityCamRotation", camera, val1, val2)
    end
}
