Camera = {
    x = 0, 
    y = 0,
    dx = 0,
    dy = 0,
    followObj = nil,
    followTime = 1,
    lockObj = nil
}

function Camera:new()
    local c = setmetatable( { Camera }, { __index = self } )
    return c
end

function Camera:update(dt)

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    if self.followObj ~= nil then
        local obj = self.followObj
        local time = self.followTime
        if (obj.dx ~= nil) then
            w = w - obj.dx*0.6
        end
        if (obj.dy ~= nil) then
            h = h + obj.dy*0.6
        end
        self.dx = (((obj.x + obj.width/2) - w/2) - self.x)/time
        self.dy = (((obj.y + obj.height) - h/2) - self.y)/time
    end

    if self.lockObj ~= nil then
        self.dx = 0
        self.dy = 0
        self.x = self.lockObj.x + self.lockObj.width/2 - w/2
        self.y = self.lockObj.y + self.lockObj.height - h/2
    end

    self.x = self.x + self.dx*dt
    self.y = self.y + self.dy*dt

end

function Camera:follow(obj, time)
    self.followObj = obj
    self.followTime = time
    self.lockObj = nil
end

function Camera:lockOn(obj)
    self.followObj = nil
    self.followTime = 1
    self.lockObj = obj
end