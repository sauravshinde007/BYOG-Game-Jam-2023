Class=require("libraries/class")
anim=require("libraries/anim8")
camera=require("libraries/camera")
require("Player")
-- sti= require'libraries/sti'
-- gameMap=sti('maps/background1..lua')

player=Player()

-------------------WIndow Defination--------------
window_width=1280
window_height=720


----------------------Love Function-----------------------------------
function love.load()
    cam=camera()
    

    love.window.setMode(window_width,window_height)
    bg_img=love.graphics.newImage("sprites/pngegg.png")
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

    else if state=="Level 1"  then
        player:update(dt)
        cam:lookAt(player.playerx,player.playery)
        
    
    end

end

end

----------------------Love Draw-----------------------------------

function love.draw()


    if state=="MainMenu" then


    elseif state=="Level 1" then
        cam:attach()
        -- gameMap:drawLayer(gameMap.layers["ground"])
            love.graphics.draw(bg_img)
            player:draw()
        cam:detach()
       
        
    end
   
    
   
end
