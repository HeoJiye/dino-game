-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()

local audioManager = require( "Module.audioManager" )
local dinoModule = require( "Module.dinoModule" )

-- local obstacleModule = require("Module.obstacleModule")
local obstacleManager = require("Module.obstacleManager")

function scene:create( event )
	local sceneGroup = self.view

	physics.start()
	physics.setGravity(0, 0)
	-- physics.setDrawMode("hybrid")

	-- BACKGROUND
	local bgGroup = display.newGroup();
	local background = display.newRect(bgGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	
	local sky = display.newImageRect(bgGroup, "Content/Sky.png", display.contentWidth, display.contentHeight)
	sky.x, sky.y = display.contentCenterX, display.contentCenterY
	
	local ground = display.newImageRect(bgGroup, "Content/Ground.png", display.contentWidth, 300)
	ground.x, ground.y = display.contentCenterX, display.contentHeight-150

	sceneGroup:insert(bgGroup)


	-- DINOSAUR
	local dino = dinoModule:New()
	dino.x, dino.y = display.contentWidth*0.2, display.contentCenterY

	sceneGroup:insert(dino)

	dino:animation('run')

	local jumpButton = widget.newButton(
		{
			defaultFile = "Content/jump.png", 
			overFile = "Content/jump_over.png",
			x = 1100, y = 600,
			
			onRelease = function()
				print("jump!!")
				audioManager:soundOn(4)
				dino:jump()
			end
		}
	)	
	local sildeButton = widget.newButton(
		{
			defaultFile = "Content/slide.png", 
			overFile = "Content/slide_over.png",
			x = 200, y = 600,
			
			onPress = function()
				print("silde start!!")
				audioManager:soundOn(3)
				dino:sildeStart()
			end,
			onRelease = function()
				print("slide end!!")
				dino:sildeEnd()
			end
		}
	)
	sceneGroup:insert(jumpButton)
	sceneGroup:insert(sildeButton)

	-- OBSTACLE
	local obstacleGroup = obstacleManager:New()
	sceneGroup:insert(obstacleGroup)

	obstacleGroup:spwan()


	-- SCORE
	local scoreBoard = display.newRoundedRect(display.contentWidth*0.13, display.contentHeight*0.1, 300, 75, 50)
	scoreBoard:setFillColor(0)
	scoreBoard.alpha = 0.5

	local score = 0
	local scoreView = display.newText(score, display.contentWidth*0.15, display.contentHeight*0.1, 250, 50)
	scoreView.align = "right"
	scoreView.size = 50

	sceneGroup:insert(scoreBoard)
	sceneGroup:insert(scoreView)

	local function scoreUp( event )
		score = score + 1
		scoreView.text = score
	end
	local scoreUpTimer = timer.performWithDelay( 500, scoreUp, 0 )


	-- UI GROUP
	local UIGroup = display.newGroup();


	local pauseBG = display.newRect(UIGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	pauseBG:setFillColor(0)
	pauseBG.alpha = 0

	local pauseUI = {}
	pauseUI[0] = display.newImageRect(UIGroup, "Content/pause.png", 55, 55)
	pauseUI[0].x, pauseUI[0].y = 1180, 40
	pauseUI[0].alpha = 1
	pauseUI[1] = display.newImageRect(UIGroup, "Content/play.png", 55, 55)
	pauseUI[1].x, pauseUI[1].y = 1180, 40
	pauseUI[1].alpha = 0

	local bgmUI = {}
	bgmUI[0] = display.newImageRect(UIGroup, "Content/bgm_on.png", 55, 55)
	bgmUI[0].x, bgmUI[0].y = 1240, 40
	bgmUI[0].alpha = 1
	bgmUI[1] = display.newImageRect(UIGroup, "Content/bgm_off.png", 55, 55)
	bgmUI[1].x, bgmUI[1].y = 1240, 40
	bgmUI[1].alpha = 0

	sceneGroup:insert(UIGroup)

	local function gamePause( event )
		pauseUI[0].alpha = 0
		pauseUI[1].alpha = 1
		pauseBG.alpha = 0.5

		print("game pause")

		physics.pause()
		timer.pauseAll()
		transition.pause()
		dino:pause()

		jumpButton.alpha = 0
		sildeButton.alpha = 0
	end
	local function gameResume( )
		pauseUI[0].alpha = 1
		pauseUI[1].alpha = 0
		pauseBG.alpha = 0
		
		print("game resume")

		physics.start()
		timer.resumeAll()
		transition.resume()
		dino:play()

		jumpButton.alpha = 1
		sildeButton.alpha = 1
	end
	pauseUI[0]:addEventListener("tap", gamePause)
	pauseUI[1]:addEventListener("tap", gameResume)

	local function bgmPause( event )
		bgmUI[0].alpha = 0
		bgmUI[1].alpha = 1

		print("bgm pause")

		audioManager:pause()
	end
	local function bgmResume( event )
		bgmUI[0].alpha = 1
		bgmUI[1].alpha = 0

		print("bgm resume")
		
		audioManager:resume()
	end
	bgmUI[0]:addEventListener("tap", bgmPause)
	bgmUI[1]:addEventListener("tap", bgmResume)



	-- COLLISION EVENT
local function onCollision( event ) 
	if ( event.phase == "began" ) then
		print("충돌!!!")
		audioManager:soundOn(2)
		
		dino:animation('collide')
		Runtime:removeEventListener( "collision", onCollision )

		physics.stop()
		timer.cancelAll()
		transition.cancelAll()

		composer.setVariable("score", score)
		composer.gotoScene( "Scene.end", { time=800, effect="crossFade" } )
	end
end
Runtime:addEventListener( "collision", onCollision )
	
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
		composer.removeScene('Scene.game')
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
