Class=require("libraries/class")
anim=require("libraries/anim8")
camera=require("libraries/camera")

wf=require("libraries/windfield")
sti = require("libraries/sti")
require("Player")

player=Player()

-------------------WIndow Defination--------------
window_width=1260
window_height=400


----------------------Love Function-----------------------------------
function love.load()
    gamemap=sti("maps/background1.lua")
    cam=camera()
    -- world=wf.newWorld(0,0)

    love.window.setMode(window_width,window_height)
    -- bg_img=love.graphics.newImage("sprites/pngegg.png")
    player:init(100,500)

    --state of the game
    state="MainMenu"

end

----------------------Love Update-----------------------------------

function love.update(dt)


    if state=="MainMenu" then
        
        if love.keyboard.isDown("return") then
            state="Level 1"
            
        end

    elseif state=="Level 1"  then
        player:update(dt)
        cam:lookAt(player.playerx,player.playery)
    
    end
   
end
print("hello")

----------------------Love Draw-----------------------------------

function love.draw()
   
  
    if state=="MainMenu" then


    elseif state=="Level 1" then
        cam:attach()
            gamemap:drawLayer(gamemap.layers["Border"])
            gamemap:drawLayer(gamemap.layers["Ground"])
            gamemap:drawLayer(gamemap.layers["Objects"])
            player:draw()
        cam:detach()
        
    end
   
    
   
end
