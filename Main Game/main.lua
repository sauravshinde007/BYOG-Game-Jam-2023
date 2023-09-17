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
isInputActive=false
    --correct answer
correctAns1="pvepyr"
correctAns2="sver"
correctAns3="oneore"
correctAns4="vagrearg"
correctAns5="ryrira"
function Collision(v,k)
    return v.x<k.x+k.width and
           v.x+v.width>k.x and
           v.y<k.y+k.height and
           v.y+v.height>k.y
end
----------------------Love Function-----------------------------------
function love.load()
    
   
    timer=20
    local roundedTime = math.floor(timer)
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
    world:addCollisionClass('Player')
    world:addCollisionClass('door')
    player.collider=world:newBSGRectangleCollider(100,80,7,14,1)
    player.collider:setFixedRotation(true)
    
  
    love.window.setMode(window_width,window_height)
    
    player:init()

    --state of the game
    state="MainMenu"
    
    items={}
    if gameMap.layers["Items"] then
        for i,obj in pairs(gameMap.layers["Items"].objects) do
            item=world:newRectangleCollider(obj.x,obj.y,obj.width,obj.height)
            item:setType("static")
            table.insert( items,item)
        end
    end
    c=0
    doors={}
    function door(x,y,width,height,no)
        local door={}
        door.width=50
        door.height=50
        door.x=x
       door.y=y
       door.no=no
       
        
        return door   -----creates enemy
    end
    
    
        if gameMap.layers["doors"] then
            for i, obj in pairs(gameMap.layers["doors"].objects) do
                c=c+1
                table.insert(doors,door(obj.x, obj.y, obj.width, obj.height,c))
                
            end
           
        end
        
    

end

----------------------Love Update-----------------------------------

function love.update(dt)


    if state=="MainMenu" then

        mainmenu_sfx:play()
        
        if love.keyboard.isDown("return") then
            state="Instruct"  
        end

    elseif state=="Level 1"  then

        game_sfx:play()
        mainmenu_sfx:stop()
        
        player:update(dt)
        cam:lookAt(player.x,player.y)

        if cam.x<window_width/6 then
            cam.x=window_width/6
        end
        if cam.y<window_height/5 then
            cam.y=window_height/5
        end
        if cam.x>(gameMap.width*gameMap.tilewidth)-window_width/6 then
            cam.x=(gameMap.width*gameMap.tilewidth)-window_width/6
        end
        if cam.y>(gameMap.height*gameMap.tileheight)-window_height/5 then
            cam.y=(gameMap.height*gameMap.tileheight)-window_height/5
        end
        
        player.collider:setLinearVelocity(player.vx,player.vy)
        
        player.x=player.collider:getX()
        player.y=player.collider:getY()
        world:update(dt)
    elseif state=="puzzle1" or state=="puzzle2" or state=="puzzle3" or state=="puzzle4" or state=="puzzle5" then
        timer=timer-dt
        local roundedTime = math.floor(timer)       --for timed task
    

    end
    
    
    function love.mousepressed(x, y, button, istouch, presses)
        -- Activate input when clicking inside the text input field
        if button==1 then
            isInputActive = true
        elseif button==2 then
            isInputActive = false       
        end
    end



    function love.keypressed(key)
        if key=="return" and state=="Instruct" then
            state="Level 1"
            isInputActive = false
        end 
        for i,k in pairs(doors) do
            if  Collision(player,k) and k.no==1 then  --will add location's conditions instead of tapping x or y
                state="puzzle1"
                   
            end
            if Collision(player,k) and k.no==2 then  --will add location's conditions instead of tapping x or y
                state="puzzle2"
                
            end
            if Collision(player,k) and k.no==3 then  --will add location's conditions instead of tapping x or y
                state="puzzle3"
                
            end
            if Collision(player,k) and k.no==4 then  --will add location's conditions instead of tapping x or y
                state="puzzle4"
                
            end
            if Collision(player,k) and k.no==5 then  --will add location's conditions instead of tapping x or y
                state="puzzle5"
                
            end
            
        end
        if key=="x" and state=="Level 1" then  --will add location's conditions instead of tapping x or y
            state="puzzle1"
            isInputActive = false
        end
        if key=="escape" then
            love.event.quit()
        end  
        --puzzle input  
        function check(x,y)
            
                if isInputActive==true then
                    if key=="backspace" then
                        playerInput=playerInput:sub(1,-2)
                    elseif key=="return" then
                        if playerInput==x then
                            state=y
                            playerInput=""
                            timer=20
                        else
                            playerInput=""   
                        end
                    else
                        playerInput=playerInput..key        
                    end
                end         
        end    
        if state=="puzzle1" then
            if timer>0 then
                check(correctAns1,"puzzle2")
            elseif timer==0 then
                status="game-over"
            end        
        end
        if state=="puzzle2" then
            if timer>0 then
                check(correctAns2,"Level 1")
            elseif timer==0 then
                status="game-over"
            end    
        end  
        if state=="puzzle3" then
            if timer>0 then
                check(correctAns3,"puzzle4")
            elseif timer==0 then
                status="game-over"
            end    
        end
        if state=="puzzle4" then
            if timer>0 then
                check(correctAns4,"puzzle5")
            elseif timer==0 then
                status="game-over"
            end
        end 
        if state=="puzzle5" then
            if timer>0 then
                check(correctAns5,"Level 1")
            elseif timer==0 then
                status="game-over"
            end    
        end 
        if timer<=0 and key=="r" then
            playerInput=""   
            timer=20
            state="MainMenu"
        end    
    end
end
   


----------------------Love Draw-----------------------------------

function love.draw()
    

    if state=="MainMenu" then

        -- love.graphics.draw(mainmenu_bg,-40,0,nil,2.3,2.4)

        --title for the game
        love.graphics.draw(title,window_width/2-190,window_height/2-200,nil,0.2,0.2)
        font=love.graphics.newFont(20)
        love.graphics.setFont(font)

        -- love.graphics.print("Pyramid Pursuit",window_width/2-130,window_height/2-30,nil,6,6)
        -- love.graphics.print(text,x,y,r,sx,sy,ox,oy)


    elseif state=="Level 1" then
        cam:attach()
            gameMap:drawLayer(gameMap.layers["Ground"])
            gameMap:drawLayer(gameMap.layers["Path"])
            
            -- world:draw()
            player:draw()

            
        cam:detach()

    elseif state=="Instruct" then
        love.graphics.print("INSTRUCTION:",200,100)
        love.graphics.print("hello -> uryyb",250,160)  
    
       --puzzle description    
    elseif state=="puzzle1" then 
        if timer>0 then
            local roundedTime = math.floor(timer)
            love.graphics.print(roundedTime,1210,45)
            love.graphics.print("What has an end but no beginning, and a start but no finish?",100,100)
            love.graphics.print("Your Answer: "..playerInput,100,150)
            love.graphics.rectangle("line",230, 150, 150, 30)
        elseif timer<=0 then
            love.graphics.print("Game-over",(window_width-200)/2,500)  
            love.graphics.print("Press R to retry",(window_width-200)/2,550)   
        end    
    elseif state=="puzzle2" then
        if timer>0 then
            local roundedTime = math.floor(timer)
            love.graphics.print(roundedTime,1210,45)
            love.graphics.print("I am not alive, but I can grow; I don't have lungs, but I need air. What am I?",100,100)
            love.graphics.print("Your Answer: "..playerInput,100,150)
            love.graphics.rectangle("line", 230, 150, 150, 30)
        elseif timer<=0 then
            love.graphics.print("Game-over",(window_width-200)/2,500)  
            love.graphics.print("Press R to retry",(window_width-200)/2,550)    
        end    
    elseif state=="puzzle3" then
        if timer>0 then
            local roundedTime = math.floor(timer)
            love.graphics.print(roundedTime,1210,45)
            love.graphics.print("A man shaves several times a day but still has a beard. Who is he?",100,100)
            love.graphics.print("Your Answer: "..playerInput,100,150)
            love.graphics.rectangle("line", 230, 150, 150, 30)
        elseif timer<=0 then
            love.graphics.print("Game-over",(window_width-200)/2,500)  
            love.graphics.print("Press R to retry",(window_width-200)/2,550)    
        end        
    elseif state=="puzzle4" then
        if timer>0 then
            local roundedTime = math.floor(timer)
            love.graphics.print(roundedTime,1210,45)
            love.graphics.print("What has keys but can't open locks and can connect you to world?",100,100)
            love.graphics.print("Your Answer: "..playerInput,100,150)
            love.graphics.rectangle("line", 230, 150, 150, 30)
        elseif timer<=0 then
            love.graphics.print("Game-over",(window_width-200)/2,500)  
            love.graphics.print("Press R to retry",(window_width-200)/2,550)    
        end    
    elseif state=="puzzle5" then
        if timer>0 then
            local roundedTime = math.floor(timer)
            love.graphics.print(roundedTime,1210,45)
            love.graphics.print("How many letters are there in the alphabet? Answer in words only.",100,100)
            love.graphics.print("Your Answer: "..playerInput,100,150)
            love.graphics.rectangle("line", 230, 150, 150, 30)
        elseif timer<=0 then
            love.graphics.print("Game-over",(window_width-200)/2,500)  
            love.graphics.print("Press R to retry",(window_width-200)/2,550)   
        end    
    
               
    end
    
   
end
