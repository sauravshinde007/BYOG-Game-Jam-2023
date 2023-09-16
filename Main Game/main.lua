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
    -- bg_img=love.graphics.newImage("sprites/pngegg.png")
    player:init(100,500)
    font=love.graphics.newFont(35)
    menu=love.graphics.newImage("C:/BYOG/mainmenu.png")
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

-----------------------------key pressed----------------------------------------
function love.keypressed(key)
    if key=="escape" then
        love.event.quit()
    end    
end    
----------------------Love Draw-----------------------------------

function love.draw()
    cam:attach()
        love.graphics.draw(bg_img)
        player:draw()
    cam:detach()

    if state=="MainMenu" then
        love.graphics.draw("menu",0,0) 
        
      
        love.graphics.print("Press enter to play",(window_width-200)/2,500)    
    elseif state=="Level 1" then
        player:draw()
        
    end
    
end