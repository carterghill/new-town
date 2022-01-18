Camera = {
    x = 0, 
    y = 0,
    dx = 0,
    dy = 0
}

function Camera:new()
    local c = setmetatable( { Camera }, { __index = self } )
    return c
end

function Camera:update(dt)

    Camera.x = Camera.x + Camera.dx*dt
    Camera.y = Camera.y + Camera.dy*dt

end

function Camera:follow(obj, time)
    w = love.graphics.getWidth()
    h = love.graphics.getHeight()
    Camera.dx = (((obj.x + obj.width/2) - w/2) - Camera.x)/time
    Camera.dy = (((obj.y + obj.height) - h/2) - Camera.y)/time
end