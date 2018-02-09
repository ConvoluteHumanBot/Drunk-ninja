local storyboard = require "storyboard"
local scene = storyboard.newScene()


function scene:createScene(event)

local screenGroup = self.view


local background = display.newImage("riprova.png") 
screenGroup:insert(background) 

local botrestart=display.newImage("restart.png")
botrestart.x=500
botrestart.y=100
screenGroup:insert(botrestart)        

function start(event)

           if event.phase == "began" then 
                storyboard.gotoScene("game")
            end
end

botrestart:addEventListener("touch",start)

end

function scene:enterScene(event)
 storyboard.removeScene("game")
end


function scene:exitScene(event)
 
end

function scene:destroyScene(event)
botrestart:removeEventListener("touch", start)
end


scene:addEventListener("createScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("exitScene",scene)
scene:addEventListener("destroyScene",scene)

return scene