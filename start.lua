local storyboard = require "storyboard"
local scene = storyboard.newScene()

function scene:createScene(event)

local screenGroup = self.view

local background = display.newImage("inizio.png")   
background:setReferencePoint(display.BottomLeftReferencePoint)  
screenGroup:insert(background)   

local bottonstart = display.newImage("botton.png") 
bottonstart.x=800
bottonstart.y=530
screenGroup:insert(bottonstart)


function start(event)

           if event.phase == "began" then 
                storyboard.gotoScene("game")
            end
end

bottonstart:addEventListener("touch",start)

end

function scene:enterScene(event)
   
end


function scene:exitScene(event)
end

function scene:destroyScene(event)
bottonstart:removeEventListener("touch", start)
end


scene:addEventListener("createScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("exitScene",scene)
scene:addEventListener("destroyScene",scene)

return scene