Class=require("libraries/class")
anim=require("libraries/anim8")
camera=require("libraries/camera")
require("Player")
player=Player()
window_width=1280
window_height=720

function love.load()
    cam=camera()
    love.window.setMode(window_width,window_height)
    bg_img=love.graphics.newImage("sprites/pngegg.png")
    player:init(100,500)

end
function love.update(dt)
    player:update(dt)
    cam:lookAt(player.playerx,player.playery)
end
function love.draw()
    cam:attach()
        love.graphics.draw(bg_img)
        player:draw()
    cam:detach()
end
