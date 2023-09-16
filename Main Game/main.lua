Class=require("libraries/class")
anim=require("libraries/anim8")
camera=require("libraries/camera")

wf=require("libraries/windfield")

require("Player")
sti = require("libraries/sti")
player=Player()

-------------------WIndow Defination--------------
window_width=1280
window_height=720

--variable to store player's input
playerInput=""

--correct answer
correctInput="hello"

----------------------Love Function-----------------------------------
function love.load()
    cam=camera()
    gameMap=sti("maps/mainlevel.lua")


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

        --stoping camera 

        --upper right
        if cam.x<window_width/2 then
            cam.x=window_width/2
            
        end

        --upper left
        if cam.y<window_height/2 then
            cam.y=window_height/2
            
        end

    else if state=="Puzzle1"  then

        love.graphics.print("Decode the secret language :",100,100)
        love.graphics.print("")

        
    
    end

end

end


----------------------Love Draw-----------------------------------

function love.draw()


    if state=="MainMenu" then


    elseif state=="Level 1" then
        cam:attach()

            love.graphics.push()

            --will scale the map
            love.graphics.scale(4)

            -- -- love.graphics.rectangle(mode,x,y,width,height)
            -- love.graphics.setColor(1,1,1)
            -- love.graphics.rectangle("fill",0,0,window_width,window_height)
            -- -- love.graphics.draw(bg_img)
            gameMap:drawLayer(gameMap.layers["Ground"])
            gameMap:drawLayer(gameMap.layers["Path"])

            love.graphics.pop()
            player:draw()

            
        cam:detach()

        
    end
   
    
   
end
