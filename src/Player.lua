require('src/Controls')
require('src/Input')

Player = {
    x = 0;
    y = 0;
    dx = 0;
    dy = 0;
    vx = 0;
    vy = 0;
    width = 64;
    height = 64;
    accel = 1000;
    friction = 1000;
    topSpeed = 300;
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

function Player:update(dt, level)
    
    if self.controls.up then
        self.vy = self.vy + self.accel*dt
    elseif self.vy > 0 then
        if self.vy < self.friction*dt then
            self.vy = 0
        else 
            self.vy = self.vy - self.friction*dt
        end
    end

    if self.controls.down then
        self.vy = self.vy - self.accel*dt
    elseif self.vy < 0 then
        if self.vy > -self.friction*dt then
            self.vy = 0
        else 
            self.vy = self.vy + self.friction*dt
        end
    end

    if self.controls.left then
        self.vx = self.vx - self.accel*dt
    elseif self.vx < 0 then
        if self.vx > -self.friction*dt then
            self.vx = 0
        else 
            self.vx = self.vx + self.friction*dt
        end
    end

    if self.controls.right then
        self.vx = self.vx + self.accel*dt
    elseif self.vx > 0 then
        if self.dx < self.friction*dt then
            self.vx = 0
        else 
            self.vx = self.vx - self.friction*dt
        end
    end

    if self.vx > self.topSpeed then
        self.vx = self.topSpeed
    elseif self.vx < -self.topSpeed then
        self.vx = -self.topSpeed
    end
    if self.vy > self.topSpeed then
        self.vy = self.topSpeed
    elseif self.vy < -self.topSpeed then
        self.vy = -self.topSpeed
    end

    self:normalize()
    self.x = self.x + self.dx*dt
    self.y = self.y - self.dy*dt

    if level ~= nil then
        if self.x < 0 then
            self.x = 0
        elseif self.x + self.width > level.width then
            self.x = level.width - self.width
        end
        if self.y < 0 then
            self.y = 0
        elseif self.y + self.height > level.height then
            self.y = level.height - self.height
        end
    end

end

function Player:normalize()
    local mag = math.sqrt(self.vx*self.vx + self.vy*self.vy)
    if mag ~= 0 then
        if self.vx < 0 then
            self.dx = -self.vx*(self.vx/mag)
        else
            self.dx = self.vx*(self.vx/mag)   
        end
        if self.vy < 0 then
            self.dy = -self.vy*(self.vy/mag)
        else
            self.dy = self.vy*(self.vy/mag)   
        end
    else
       self.dx = 0
       self.dy = 0 
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