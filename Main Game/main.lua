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
    cam=camera(0,0,3)
   
    gameMap=sti("maps/mainlevel.lua")

    --fonts for the game
    arabic=love.graphics.newFont("fonts/RamadhanAmazing-jEnDv.ttf")


    -- Disable texture filtering for fonts and textures
    love.graphics.setDefaultFilter("nearest", "nearest")

    --images for game
    mainmenu_bg=love.graphics.newImage("assets/mainmenu.png")
    title=love.graphics.newImage("assets/title mainmenu.png")


    --sound for games
    mainmenu_sfx=love.audio.newSource("sounds/mainmenu.mp3","stream")
    game_sfx=love.audio.newSource("sounds/main game.mp3","stream")


    world=wf.newWorld(0,0)
    player.collider=world:newBSGRectangleCollider(10,10,10,14,10)
    player.collider:setFixedRotation(true)
  
    love.window.setMode(window_width,window_height)
    
    player:init(10,10)

    --state of the game
    state="MainMenu"
    
    items={}
    if gameMap.layers["Items"] then
        for i,obj in pairs(gameMap.layers["Items"].objects) do
            local item=world:newRectangleCollider(obj.x,obj.y,obj.width,obj.height)
            item:setType("static")
            table.insert( items,item)
        end
    end
   
    

end

----------------------Love Update-----------------------------------

function love.update(dt)


    if state=="MainMenu" then

        mainmenu_sfx:play()
        
        if love.keyboard.isDown("return") then
            state="Level 1"
            
        end

    elseif state=="Level 1"  then

        game_sfx:play()
        mainmenu_sfx:stop()
        
        player:update(dt)
        cam:lookAt(player.playerx,player.playery)

        --stoping camera 

        --upper right
        -- if cam.x<window_width/2 then
        --     cam.x=window_width/2
            
        -- end

        -- --upper left
        -- if cam.y<window_height/2 then
        --     cam.y=window_height/2
            
        -- end
        player.collider:setLinearVelocity(player.vx,player.vy)
      
        player.playerx=player.collider:getX()
        player.playery=player.collider:getY()
        world:update(dt)
    else if state=="Puzzle1"  then

        love.graphics.print("Decode the secret language :",100,100)
        love.graphics.print("")

        
    
    end

end

end


----------------------Love Draw-----------------------------------

function love.draw()
    

    if state=="MainMenu" then

        -- love.graphics.draw(mainmenu_bg,-40,0,nil,2.3,2.4)

        --title for the game
        love.graphics.draw(title,window_width/2-190,window_height/2-200,nil,0.2,0.2)


        -- love.graphics.print("Pyramid Pursuit",window_width/2-130,window_height/2-30,nil,6,6)
        -- love.graphics.print(text,x,y,r,sx,sy,ox,oy)


    elseif state=="Level 1" then
        cam:attach()
            
            -- love.graphics.push()

            -- --will scale the map
            -- love.graphics.scale(4)

            -- -- love.graphics.rectangle(mode,x,y,width,height)
            -- love.graphics.setColor(1,1,1)
            -- love.graphics.rectangle("fill",0,0,window_width,window_height)
            -- -- love.graphics.draw(bg_img)
           
            --cam:zoomTo(2)
            gameMap:drawLayer(gameMap.layers["Ground"])
            gameMap:drawLayer(gameMap.layers["Path"])
            -- love.graphics.pop()
            -- world:draw()
            player:draw()

            
        cam:detach()

        
    end
   
    
   
end
