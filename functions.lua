local variables = loadfile("variables.lua")()

return {
    drawLaser = function( origin, target, properties )
        variables.FireServer("FireAllClients","drawLaser", origin, target, properties)
    end,

    rotateSecCam = function(camera, val1, val2)
        if not camera then  return end
        val1 = val1 * 2
        val2 = val2 * 2
        variables.FireServer("updateSecurityCamRotation", camera, val1, val2)
    end
}
