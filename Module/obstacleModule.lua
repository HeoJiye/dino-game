
local obstacleModule = {}

function obstacleModule:New(image, initX, initY)
    local obstacle = display.newImage(image)
    obstacle.x, obstacle.y = initX, initY

    physics.addBody( obstacle, "dynamic", { outline = graphics.newOutline(2, image) })
    obstacle:setLinearVelocity( -500, 0)

    timer.performWithDelay(4000, 
        function() 
            print("장애물이 삭제됩니다.")
            physics.removeBody(obstacle)
            display.remove(obstacle)
        end
    )

    return obstacle
end

return obstacleModule