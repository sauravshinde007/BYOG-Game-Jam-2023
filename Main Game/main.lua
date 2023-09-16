Class=require("libraries/class")
anim=require("libraries/anim8")
camera=require("libraries/camera")

wf=require("libraries/windfield")

require("Player")

player=Player()

-------------------WIndow Defination--------------
window_width=1280
window_height=720


----------------------Love Function-----------------------------------
function love.load()
    cam=camera()
    -- world=wf.newWorld(0,0)

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
        
    
    end
    player:update(dt)
    cam:lookAt(player.playerx,player.playery)
end

end

----------------------Love Draw-----------------------------------

function love.draw()
    cam:attach()
        love.graphics.draw(bg_img)
        player:draw()
    cam:detach()

    if state=="MainMenu" then


    elseif state=="Level 1" then
        player:draw()
        
    end
   
    
   
end
