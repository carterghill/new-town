require('Controls')
require('Input')

Player = {
    x = 0;
    y = 0;
    dx = 0;
    dy = 0;
    width = 64;
    height = 64;
    accel = 750;
    friction = 750;
    topSpeed = 250;
    controls = Controls:new(),
    input = Input:new(Keyboard:new())
}

function Player:new(x, y)
    local s = setmetatable( { Player }, { __index = self } )
    s.x = x or 0
    s.y = y or 0
    s.controls = Controls:new()
    return s;
end

function Player:update(dt)
    
    if self.controls.up then
        self.dy = self.dy + self.accel*dt
    elseif self.dy > 0 then
        if self.dy < self.friction*dt then
            self.dy = 0
        else 
            self.dy = self.dy - self.friction*dt
        end
    end

    if self.controls.down then
        self.dy = self.dy - self.accel*dt
    elseif self.dy < 0 then
        if self.dy > -self.friction*dt then
            self.dy = 0
        else 
            self.dy = self.dy + self.friction*dt
        end
    end

    if self.controls.left then
        self.dx = self.dx - self.accel*dt
    elseif self.dx < 0 then
        if self.dx > -self.friction*dt then
            self.dx = 0
        else 
            self.dx = self.dx + self.friction*dt
        end
    end

    if self.controls.right then
        self.dx = self.dx + self.accel*dt
    elseif self.dx > 0 then
        if self.dx < self.friction*dt then
            self.dx = 0
        else 
            self.dx = self.dx - self.friction*dt
        end
    end

    if self.dx > self.topSpeed then
        self.dx = self.topSpeed
    elseif self.dx < -self.topSpeed then
        self.dx = -self.topSpeed
    end
    if self.dy > self.topSpeed then
        self.dy = self.topSpeed
    elseif self.dy < -self.topSpeed then
        self.dy = -self.topSpeed
    end

    self:normalize()
    self.x = self.x + self.dx*self.topSpeed*dt
    self.y = self.y - self.dy*self.topSpeed*dt

end

function Player:normalize()
    local mag = math.sqrt(self.dx*self.dx + self.dy*self.dy)
    if mag ~= 0 then
        self.dx = (self.dx/mag)
        self.dy = (self.dy/mag)
    end
end

function Player:keypressed(key)
    local keyboard = self.input.keyboard
    if key == keyboard.up then
        self.controls.up = true
    end
    if key == keyboard.down then
        self.controls.down = true
    end
    if key == keyboard.left then
        self.controls.left = true
    end
    if key == keyboard.right then
        self.controls.right = true
    end
end

function Player:keyreleased(key)
    local keyboard = self.input.keyboard
    if key == keyboard.up then
        self.controls.up = false
    end
    if key == keyboard.down then
        self.controls.down = false
    end
    if key == keyboard.left then
        self.controls.left = false
    end
    if key == keyboard.right then
        self.controls.right = false
    end
end