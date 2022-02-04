require('src/Controls')
require('src/Input')

Player = {
    x = 0;
    y = 0;
    dx = 0;
    dy = 0;
    vx = 0;
    vy = 0;
    width = 48;
    height = 48;
    accel = 1000;
    friction = 1000;
    topSpeed = 300;
    controls = Controls:new(),
    input = Input:new(Keyboard:new());
    character = nil;
}

function Player:new(x, y, character)
    local s = setmetatable( { Player }, { __index = self } )
    s.x = x or 0
    s.y = y or 0
    s.controls = Controls:new()
    if character ~= nil then
        s.character = character
    end
    return s;
end

function Player:update(dt, level)
    
    if self.controls.up then
        --if self.character ~= nil and self.vy > 0 then
        --    self.character:setDirection("Back")
        --end
        self.vy = self.vy + self.accel*dt
    elseif self.vy > 0 then
        if self.vy < self.friction*dt then
            self.vy = 0
        else 
            self.vy = self.vy - self.friction*dt
        end
    end

    if self.controls.down then
        --if self.character ~= nil and self.vy < 0 then
         --   self.character:setDirection("Front")
        --end
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
        --if self.character ~= nil and self.vx < 0 and math.abs(self.vy) < 0.01 then
        --    self.character:setDirection("Left")
        --end
    elseif self.vx < 0 then
        if self.vx > -self.friction*dt then
            self.vx = 0
        else 
            self.vx = self.vx + self.friction*dt
        end
    end

    if self.controls.right then
       -- if self.character ~= nil and self.vx > 0 and math.abs(self.vy) < 0.01 then
       --     self.character:setDirection("Right")
       -- end
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

    


    if self.character ~= nil then
        self.character:update(dt)
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

        -- Level collision
        if level.collision ~= nil then
            if self.dx < 0 then
                local tile1 = level:getCollisionTile(self.x, self.y + 2)
                local tile2 = level:getCollisionTile(self.x, self.y + self.height - 2)
                if tile1 ~= 0 or tile2 ~= 0 then
                    self.dx = 0
                    local w = level.tileWidth*level.zx
                    self.x = math.floor(self.x/w)*w + w
                end
            elseif self.dx > 0 then
                local tile1 = level:getCollisionTile(self.x+self.width, self.y + 2)
                local tile2 = level:getCollisionTile(self.x+self.width, self.y + self.height - 2)
                if tile1 ~= 0 or tile2 ~= 0 then
                    self.dx = 0
                    local w = level.tileWidth*level.zx
                    self.x = math.floor(self.x/w)*w + (w-self.width)
                end
            end
            if self.dy < 0 then
                local tile1 = level:getCollisionTile(self.x+self.width -2, self.y + self.height)
                local tile2 = level:getCollisionTile(self.x+2, self.y + self.height)
                if tile1 ~= 0 or tile2 ~= 0 then
                    self.dy = 0
                    local h = level.tileHeight*level.zy
                    self.y = math.floor(self.y/h)*h + (h-self.height)
                end
            elseif self.dy > 0 then
                local tile1 = level:getCollisionTile(self.x+self.width-2, self.y)
                local tile2 = level:getCollisionTile(self.x+2, self.y)
                if tile1 ~= 0 or tile2 ~= 0 then
                    self.dy = 0
                    local h = level.tileHeight*level.zy
                    self.y = math.floor(self.y/h)*h + h
                end
            end
        end

    end

    if self.character ~= nil then

        if self.dx > 0 and self.dx > math.abs(self.dy) then
            self.character:setDirection("Right")
        elseif self.dx < 0 and self.dx < math.abs(self.dy) then
            self.character:setDirection("Left")
        elseif self.dy < 0 and self.dy < math.abs(self.dx) then
            self.character:setDirection("Front")
        elseif self.dy > 0 and self.dy > math.abs(self.dx) then
            self.character:setDirection("Back")
        end

        if math.abs(self.dx) < 100 and math.abs(self.dy) < 100 then
            self.character:setState("Idle")
        else
            self.character:setState("Walk")
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

function Player:draw()
    if self.character ~= nil then
        self.character:draw(self.x, self.y)
    else
        love.graphics.rectangle("line", self.x - Camera.x, self.y - Camera.y, self.width, self.height)
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