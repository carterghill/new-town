Camera = {
    x = 0, 
    y = 0,
    dx = 0,
    dy = 0,
    followObj = nil,
    followTime = 1
}

function Camera:new()
    local c = setmetatable( { Camera }, { __index = self } )
    return c
end

function Camera:update(dt)

    if self.followObj ~= nil then
        local obj = self.followObj
        local time = self.followTime
        local w = love.graphics.getWidth()
        local h = love.graphics.getHeight()
        if (obj.dx ~= nil) then
            w = w - obj.dx*0.75
        end
        if (obj.dy ~= nil) then
            h = h + obj.dy*0.75
        end
        Camera.dx = (((obj.x + obj.width/2) - w/2) - Camera.x)/time
        Camera.dy = (((obj.y + obj.height) - h/2) - Camera.y)/time
    end

    Camera.x = Camera.x + Camera.dx*dt
    Camera.y = Camera.y + Camera.dy*dt

end

function Camera:follow(obj, time)
    self.followObj = obj
    self.followTime = time
end