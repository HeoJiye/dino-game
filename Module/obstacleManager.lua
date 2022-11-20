local obstacleModule = require( "Module.obstacleModule" )

local obstacleImages = {}
obstacleImages[1] = "Content/bone1.png"
obstacleImages[2] = "Content/bone2.png"
obstacleImages[3] = "Content/bone3.png"
obstacleImages[4] = "Content/Ptero.png"

local initX = display.contentWidth+200
local initY = {}
initY[1] = display.contentHeight-280
initY[2] = display.contentHeight-280
initY[3] = display.contentHeight-280
initY[4] = 200


local obstacleManager = {}

function obstacleManager.New()
    local obstacleGroup = display.newGroup()

    function obstacleGroup:spwan()
        local idx = math.random(1, 4)
        local obstacle = obstacleModule:New(obstacleImages[idx], initX, initY[idx])
        obstacleGroup:insert(obstacle)

        timer.performWithDelay(math.random(1500, 4000), 
            function() 
                obstacleGroup:spwan()
            end
        )
    end

    return obstacleGroup
end

return obstacleManager