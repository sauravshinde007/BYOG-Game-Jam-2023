Player=Class{}
function Player:init(playerx,playery)
    self.world=wf.newWorld(0,0)
    self.playerx=playerx
    self.playery=playery
    self.speed=100
    self.collider=self.world:newBSGRectangleCollider(100,500,30,65,10)
    self.collider:setFixedRotation(true)
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
    if love.keyboard.isDown('w') and self.playery>0 then
        self.vy=self.speed*-1
        self.animation=self.animations.uprun
        counter=1
    else
        if counter==1 then
            self.animation=self.animations.upidle
    
        end
    end
    if love.keyboard.isDown('s') and self.playery<window_height-65 then
        self.vy=self.speed
        self.playery=self.playery+100*dt
        self.animation=self.animations.downrun
        counter=2
    else
        if counter==2 then
            self.animation=self.animations.downidle
        end
    end
    if love.keyboard.isDown('a') and self.playerx>0 then
        self.vx=self.speed*-1
        self.animation=self.animations.leftrun
        counter=3
    else
        if counter==3 then
            self.animation=self.animations.leftidle
        end
    end

    if love.keyboard.isDown('d') and self.playerx<window_width-30 then
        self.vx=self.speed
        self.animation=self.animations.rightrun
        counter=4
    else
        if counter==4 then 
            self.animation=self.animations.rightidle
        end
    end
    self.collider:setLinearVelocity(self.vx,self.vy)
    self.world:update(dt)
    self.playerx=self.collider:getX()
    self.playery=self.collider:getY()

end

function Player:draw()

    self.animation:draw(self.player_img,self.playerx,self.playery,0,2,2,32,32)
    self.world:draw()
end