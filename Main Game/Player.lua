Player=Class{}
function Player:init(playerx,playery)
    self.playerx=playerx
    self.playery=playery
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
   
    if love.keyboard.isDown('w') then
        self.playery=self.playery-100*dt
        self.animation=self.animations.uprun
        counter=1
    else
        if counter==1 then
            self.animation=self.animations.upidle
    
        end
    end
    if love.keyboard.isDown('s') then
        self.playery=self.playery+100*dt
        self.animation=self.animations.downrun
        counter=2
    else
        if counter==2 then
            self.animation=self.animations.downidle
        end
    end
    if love.keyboard.isDown('a') then
        self.playerx=self.playerx-100*dt
        self.animation=self.animations.leftrun
        counter=3
    else
        if counter==3 then
            self.animation=self.animations.leftidle
        end
    end

    if love.keyboard.isDown('d') then
        self.playerx=self.playerx+100*dt
        self.animation=self.animations.rightrun
        counter=4
    else
        if counter==4 then 
            self.animation=self.animations.rightidle
        end
    end

end

function Player:draw()
    self.animation:draw(self.player_img,self.playerx,self.playery,0,2,2,32,32)
end