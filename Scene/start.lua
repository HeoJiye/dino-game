-----------------------------------------------------------------------------------------
--
-- start.lua
--
-----------------------------------------------------------------------------------------

local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()



function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImage("Content/start/bg.png")
	background.x, background.y = display.contentCenterX, display.contentCenterY

	local dino = display.newImage("Content/start/dino.png")
	dino.x, dino.y = display.contentWidth*0.18, display.contentHeight*0.49

	local title = display.newImage("Content/start/title.png")
	title.x, title.y = display.contentWidth*0.65, display.contentHeight*0.42
	
	local startUI = widget.newButton(
		{ 
			defaultFile = "Content/start/start.png", 
			overFile = "Content/start/start_over.png",
			x = display.contentWidth*0.65, 
			y = display.contentHeight*0.72, 

			onRelease = function() 

				composer.gotoScene("Scene.game")
			end 
		})

	sceneGroup:insert(background)
	sceneGroup:insert(dino)
	sceneGroup:insert(title)
	sceneGroup:insert(startUI)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	elseif phase == "did" then

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then

	elseif phase == "did" then


	end
end

function scene:destroy( event )
	local sceneGroup = self.view

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene