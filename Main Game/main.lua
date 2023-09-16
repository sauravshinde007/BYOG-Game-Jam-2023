Class=require("libraries/class")
anim=require("libraries/anim8")
require("Player")

player=Player()

-------------------WIndow Defination--------------
window_width=1280
window_height=720


----------------------Love Function-----------------------------------
function love.load()
    

    love.window.setMode(window_width,window_height)
    
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
end

end

----------------------Love Draw-----------------------------------

function love.draw()

    if state=="MainMenu" then


    elseif state=="Level 1" then
        player:draw()
        
    end
   
    
   
end
