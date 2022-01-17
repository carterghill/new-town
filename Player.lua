require('Controls')
require('Input')

Player = {
    x = 0;
    y = 0;
    dx = 0;
    dy = 0;
    width = 64;
    height = 64;
    controls = Controls:new(),
    input = Input:new(Keyboard:new())
}

function Player:new(x, y)
    local s = setmetatable( {Player}, { __index = self } )
    s.x = x or 0
    s.y = y or 0
    s.controls = Controls:new()
    return s;
end

function Player:update(dt)
    
    if self.controls.up then
        self.dy = self.dy + 1
    elseif self.dy > 0 then
        if self.dy < 1 then
            self.dy = 0
        else 
            self.dy = self.dy - 1
        end
    end

    if self.controls.down then
        self.dy = self.dy - 1
    elseif self.dy < 0 then
        if self.dy > -1 then
            self.dy = 0
        else 
            self.dy = self.dy + 1
        end
    end

    if self.controls.left then
        self.dx = self.dx - 1
    elseif self.dx < 0 then
        if self.dx > -1 then
            self.dx = 0
        else 
            self.dx = self.dx + 1
        end
    end

    if self.controls.right then
        self.dx = self.dx + 1
    elseif self.dx > 0 then
        if self.dx < 1 then
            self.dx = 0
        else 
            self.dx = self.dx - 1
        end
    end

    self.x = self.x + self.dx*dt
    self.y = self.y - self.dy*dt

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