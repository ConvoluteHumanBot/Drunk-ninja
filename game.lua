--Storyboard and Score data
local storyboard = require "storyboard"  
local scene = storyboard.newScene()
local path = system.pathForFile( "score.txt", system.DocumentsDirectory )
local fh = io.open( path, "r" )

if fh==nil then
fh=io.open(path, "w")
end
local contfh = fh:read( "*a" )
if contfh==nil then
contfh="1"
end
local savedata = tonumber (contfh)
io.close(fh);
if savedata==nil then
savedata=1
end

function scene:createScene(event)


      
      local screenGroup = self.view
      
      display.setStatusBar(display.HiddenStatusBar)
      
      
      
      

--  -- -- -- -- -- -- BG SETTINGS -- -- -- -- -- -- -- 
local mytext = display.newText ("Current: ", 50, 555, native.systemFont, 30)
local mytext22 = display.newText ("Highscore: ", 400, 555, native.systemFont, 30)
local viewscore22 = display.newText (savedata, 650, 555, native.systemFont, 30)
local viewscore = display.newText (savedata, 250, 555, native.systemFont, 30)
local speedh=8
local speedh2=5

local physics = require "physics"
physics.start(noSleep)
physics.setGravity(0,150)
physics.setDrawMode( "normal" )


          
local bg = display.newImage("bg.png")
bg:setReferencePoint(display.BottomLeftReferencePoint)
bg.x=0
bg.y=640
screenGroup:insert(bg)  

local city3 = display.newImage("city1copia.png")
city3:setReferencePoint(display.BottomLeftReferencePoint)
city3.x=0		
city3.y=615
screenGroup:insert(city3)  

local city4 = display.newImage("city1copia.png")
city4:setReferencePoint(display.BottomLeftReferencePoint)
city4.x=960		
city4.y=615
screenGroup:insert(city4)  

local city = display.newImage("2dcit.png")
city:setReferencePoint(display.BottomLeftReferencePoint)
city.x=0		
city.y=615
screenGroup:insert(city)  

local nero = display.newImage("nero.png")
nero:setReferencePoint(display.BottomLeftReferencePoint)
nero.x=0		
nero.y=761
screenGroup:insert(nero)  

local city2 = display.newImage("2dcit.png")
city2:setReferencePoint(display.BottomLeftReferencePoint)
city2.x=960		
city2.y=615
screenGroup:insert(city2)   

local manSprite= display.newImage("uomo.png")
manSprite:setReferencePoint(display.BottomLeftReferencePoint)
manSprite.x=150
manSprite.y=470  
screenGroup:insert(manSprite)

--[[local manuto= { width=80, height=80, numFrames=4 }
local manSheet = graphics.newImageSheet( "spritecorsa2.png", manuto )
local manutosprite= { name="running", start=1, count=4, time=330 }  
manSprite= display.newSprite( manSheet, manutosprite)                      
manSprite.x=150
manSprite.y=470  
manSprite:play()
screenGroup:insert(manSprite)]]
   
local lama =display.newImage("lama.png")  
lama:setReferencePoint(display.BottomLeftReferencePoint)
lama.x= 990
lama.y=math.random(250,470)
lama.rotation=1
lama.initY=lama.y
lama.amp= math.random(60,80)
lama.angle= math.random(1,360)
screenGroup:insert(lama)

local obstacle = display.newImage("obstacle.png")
obstacle:setReferencePoint(display.BottomLeftReferencePoint)
obstacle.x=1000
obstacle.y=518
obstacle.hscore=1
screenGroup:insert(obstacle) 

local bricks = display.newImage("gray.png")
bricks:setReferencePoint(display.BottomLeftReferencePoint)
bricks.x=0	
bricks.y=640
physics.addBody(bricks, "static", {})
screenGroup:insert(bricks) 

local bordonero1 = display.newImage("nero22.png")
bordonero1:setReferencePoint(display.BottomLeftReferencePoint)
bordonero1.x=-400
bordonero1.y=720
screenGroup:insert(bordonero1)

local bordonero2 = display.newImage("nero22.png")
bordonero2:setReferencePoint(display.BottomLeftReferencePoint)
bordonero2.x=960
bordonero2.y=720
screenGroup:insert(bordonero2)





-- -- -- -- -- -- -- -- -- -- GAME SET -- -- -- -- -- -- -- -- -- --

physics.addBody(manSprite, "dynamic", {density=0.8, radius=40, bounce=0})
 
physics.addBody(obstacle, "static", {density=0, radius=17, friction=0})

physics.addBody(lama, "static", {density=0, radius=12, friction=0})


-- -- -- -- -- -- -- MOVEMENT SETTINGS -- -- -- -- -- -- -- -- -- -- 

function scroll(self,event)
  if self.x < -957 then 
       self.x=0
  else
     self.x=self.x - 0.7
  end
end

function scroll2(self,event)
  if self.x < 3 then 
       self.x=960
  else
     self.x=self.x - 0.7
  end
end

function scroll3(self,event)
  if self.x < -957 then 
       self.x=0
  else
     self.x=self.x - 2.5
  end
end

function scroll4(self,event)
  if self.x < 3 then 
       self.x=960
  else
     self.x=self.x - 2.5
  end
end

function scrollobstacle(self,event)
  if self.x < -2 then 
       self.x=1000
       speedh=speedh+0.25
  else
     self.x=self.x - speedh
     self.hscore=self.hscore+math.round(speedh/5.5)+math.round(speedh2/10)
     viewscore.text = self.hscore
  end
end

function rotationlama(self,event)
  if self.x < -31 then 
       self.x=990
       self.initY=math.random(300,450)
       speedh2=math.random(7,10)
  else
     self.x= self.x -speedh2
     self.angle=self.angle+0.2
     self.y= self.amp * math.sin(self.angle) + self.initY
     self.rotation= self.rotation+23
  end
end

function Jump(self,event)
       if self.y>380 then
         self:applyForce(0, -2000, self.x, self.y)
        end
        
end

function touchScreen(event)
           if event.phase == "began" then 
                manSprite.enterFrame = Jump
                Runtime:addEventListener("enterFrame", manSprite)
            end
            
            if event.phase == "ended" then 
                Runtime:removeEventListener("enterFrame", manSprite)
            end
end

function onCollision( event )
        if  event.phase == "began"  then
        if obstacle.hscore > savedata then
                   fh = io.open( path, "w" )
                   fh:write(obstacle.hscore, "")
                   fh:close()
                end
                manSprite.y=480
                mytext.text = ""
                viewscore.text = ""
                mytext22.text=""
                viewscore22.text=""
            storyboard.gotoScene("restart", "fade", 400)
         end
end





-- -- -- -- -- -- -- RUNTIME SETTINGS -- -- -- -- -- -- -- --

city3.enterFrame = scroll
Runtime:addEventListener("enterFrame", city3)

city4.enterFrame = scroll2
Runtime:addEventListener("enterFrame", city4)

city.enterFrame = scroll3
Runtime:addEventListener("enterFrame", city)

city2.enterFrame = scroll4
Runtime:addEventListener("enterFrame", city2)

obstacle.enterFrame = scrollobstacle
Runtime:addEventListener("enterFrame", obstacle)

lama.enterFrame = rotationlama
Runtime:addEventListener("enterFrame", lama)

obstacle.collision=onCollision 
obstacle:addEventListener("collision", onCollision)

lama.collision=onCollision 
lama:addEventListener("collision", onCollision)

Runtime:addEventListener("touch", touchScreen)

end





function scene:enterScene(event)

end

function scene:exitScene(event)

Runtime:removeEventListener("enterFrame", city3)


Runtime:removeEventListener("enterFrame", city4)


Runtime:removeEventListener("enterFrame", city)


Runtime:removeEventListener("enterFrame", city2)


Runtime:removeEventListener("enterFrame", obstacle)

Runtime:removeEventListener("enterFrame", lama)

Runtime:removeEventListener("touch", touchScreen)


end

function scene:destroyScene(event)

end


scene:addEventListener("createScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("exitScene",scene)
scene:addEventListener("destroyScene",scene)

return scene

-- OLDIES

--[[local manSheet = sprite.newSpriteSheet( "spritecorsa2.png", 80, 80 )
manSprite= sprite.newSpriteSet( manSheet, 1, 4)
sprite.add(manSprite, "men",1,4,330,0)   
man=sprite.newSprite(manSprite)      
man.x=150
man.y=580  
man:prepare("men")
man:play()
screenGroup:insert(man) ]]
