require('Input')

Player = {
    x = 0;
    y = 0;
    dx = 0;
    dy = 0;
    width = 64;
    height = 64;
    input = Input:new()
}

function Player:new(x, y)
    local s = setmetatable( {Player}, { __index = self } )
    s.x = x or 0
    s.y = y or 0
    s.input = Input:new()
    return s;
end

function Player:update(dt)
    
    if self.input.up then
        self.dy = self.dy + 1
    elseif self.dy > 0 then
        if self.dy < 1 then
            self.dy = 0
        else 
            self.dy = self.dy - 1
        end
    end

    if self.input.down then
        self.dy = self.dy - 1
    elseif self.dy < 0 then
        if self.dy > -1 then
            self.dy = 0
        else 
            self.dy = self.dy + 1
        end
    end

    if self.input.left then
        self.dx = self.dx - 1
    elseif self.dx < 0 then
        if self.dx > -1 then
            self.dx = 0
        else 
            self.dx = self.dx + 1
        end
    end

    if self.input.right then
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
    if key == "w" then
        self.input.up = true
    end
    if key == "s" then
        self.input.down = true
    end
    if key == "a" then
        self.input.left = true
    end
    if key == "d" then
        self.input.right = true
    end
end

