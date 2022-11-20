-- STEP 03. dino module

local imgSheet = graphics.newImageSheet( "Content/Player.png", 
    { width = 214, height = 217, numFrames = 6 })
local sequencesData = {
    { name = "idle",	frames = { 1 } },
    { name = "run",  	frames = { 1, 2, 3 }, time = 400 },
    { name = "jump", 	frames = { 4 } },
    { name = "silde", 	frames = { 5 } },
    { name = "collide", frames = { 6 } }
}
local dinoOutline = {
    idle = graphics.newOutline(2, imgSheet, 1),
    silde = graphics.newOutline(2, imgSheet, 5)
}

local dinoModlue = {}

function dinoModlue:New() 
    local dino = display.newSprite(imgSheet, sequencesData)

    dino.isJump = false
    physics.addBody(dino, "kinematic", { outline = dinoOutline.idle })

    function dino:animation( state )
        dino:setSequence( state )
        dino:play()
    end

    function dino:jump()
        if (dino.isJump == false) then
            dino.isJump = true

            dino:animation('jump')
            transition.to( dino, { time = 1500,  y = (dino.y-200), 
                transition = easing.continuousLoop, 
                onComplete = function() 
                    dino:animation('run')
                    dino.isJump = false
                end 
            })
        end
    end

    function dino:sildeStart()
        if (dino.isJump == false) then
            dino:animation('silde')

            physics.removeBody( dino )
            physics.addBody(dino, "kinematic", { outline = dinoOutline.silde })
        end
    end

    function dino:sildeEnd()
        if (dino.isJump == false) then
            dino:animation('run')

            physics.removeBody( dino )
            physics.addBody(dino, "kinematic", { outline = dinoOutline.idle}) 
        end
    end

    return dino
end

return dinoModlue
