Player=Class{}
function Player:init()
    
    self.x=0
    self.y=0
    self.width=7
    self.height=14
    self.speed=50
    
    
    self.player_img=love.graphics.newImage("sprites/Player.png")
    local grid=anim.newGrid(64,64,self.player_img:getWidth(),self.player_img:getHeight())
    self.animations={}

    self.animations.upidle=anim.newAnimation(grid('1-5',8),0.1)
    self.animations.downidle=anim.newAnimation(grid('1-5',2),0.1)
    self.animations.leftidle=anim.newAnimation(grid('1-5',5),0.1)
    self.animations.rightidle=anim.newAnimation(grid('2-6',11),0.1)

    self.animations.uprun=anim.newAnimation(grid('1-6',9),0.08)
    self.animations.downrun=anim.newAnimation(grid('1-6',3),0.08)
    self.animations.leftrun=anim.newAnimation(grid('1-6',6),0.08)
    self.animations.rightrun=anim.newAnimation(grid('1-6',12),0.08)
   
    self.animation = self.animations.upidle
    self.counter=0
    
end

function Player:update(dt)
   self.animation:update(dt)
   self.vx=0
   self.vy=0
    if love.keyboard.isDown('w') then
        self.vy=self.speed*-1
        self.animation=self.animations.uprun
        counter=1
    else
        if counter==1 then
            self.animation=self.animations.upidle
    
        end
    end
    if love.keyboard.isDown('s')  then
        self.vy=self.speed
        
        self.animation=self.animations.downrun
        counter=2
    else
        if counter==2 then
            self.animation=self.animations.downidle
        end
    end
    if love.keyboard.isDown('a')  then
        self.vx=self.speed*-1
        self.animation=self.animations.leftrun
        counter=3
    else
        if counter==3 then
            self.animation=self.animations.leftidle
        end
    end

    if love.keyboard.isDown('d') then
        self.vx=self.speed
        self.animation=self.animations.rightrun
        counter=4
    else
        if counter==4 then 
            self.animation=self.animations.rightidle
        end
    end
   

end

function Player:draw()

    self.animation:draw(self.player_img,self.x,self.y,0,0.5,0.5,32,32)
    
end