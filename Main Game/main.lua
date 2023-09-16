Class=require("libraries/class")
anim=require("libraries/anim8")
require("Player")
player=Player()
window_width=1280
window_height=720

function love.load()
   
    love.window.setMode(window_width,window_height)
    
    player:init(100,500)

end
function love.update(dt)
    player:update(dt)
end
function love.draw()
   
    player:draw()
   
end
