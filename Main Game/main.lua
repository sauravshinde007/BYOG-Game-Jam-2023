Class=require("libraries/class")
anim=require("libraries/anim8")
camera=require("libraries/camera")
require("Player")

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

    elseif state=="Level 1"  then    
    elseif state=="game-over" then
          if love.keyboard.isDown("r") then
            state="MainMenu"
          end  
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
    love.graphics.setFont(font)

    if state=="MainMenu" then
        love.graphics.draw("menu",0,0) 
        
      
        love.graphics.print("Press enter to play",(window_width-200)/2,500)    
    elseif state=="Level 1" then
        
        cam:attach()
        love.graphics.draw(bg_img)
        player:draw()
        cam:detach()
    elseif state=="game-over" then
        love.graphics.print("Game over",(window_width-200)/2,500)
        love.graphics.print("Press R to retry",(window_width-200)/2,550)
    end
    
end