TileObject = {
    gid = 0,
    quads = {},
    x = 0, 
    y = 0,
    zx = 1,
    zy = 1,
    type = "",
    rotation = 0,
    rotateTo = 0.3
}

function TileObject:new(obj, tilemap)
    
    local t = setmetatable( { TileObject }, { __index = self } )

    t.batch = love.graphics.newSpriteBatch(tilemap.images[1], tilemap.tileWidth * tilemap.tileHeight*2)
    t.gid = obj.gid
    t.quads = tilemap.quads
    t.x = obj.x*tilemap.zx
    t.y = obj.y*tilemap.zy - tilemap.tileHeight*tilemap.zy
    t.zx = tilemap.zx
    t.zy = tilemap.zy
    t.height = tilemap.tileHeight
    t.width = tilemap.tileWidth
    t.type = obj.type

    t:bakeObject()

    return t

end



function TileObject:bakeObject()
    self.batch:clear()
    
    if self.type == "TallGrass" or self.gid == 241 then
        self.batch:add(self.quads[self.gid-16], 0, 0)
        self.batch:add(self.quads[self.gid], 0, 128)
    else 
        self.batch:add(self.quads[self.gid], 0, 128)
    end

    self.batch:flush()
end

function TileObject:update(dt)
    local players = Players:get()
    for i, player in ipairs(players) do
        if self:checkCollision(player) then
            --print("Collision!")
            if self.rotateTo == 0 and self.rotation == 0 and (player.dx ~= 0 or player.dy ~= 0) then
                self.rotateTo = 0.3
            end
        else
            --print("No collision!")
        end
    end
    self:animate(dt)
end

function TileObject:animate(dt)
    local tau = math.pi*2
    if (self.rotation > tau) then
        self.rotation = self.rotation - tau
    end
    if self.rotateTo == 0.3 then
        if self.rotation < 0.3 then
            self.rotation = self.rotation + dt
        else
            self.rotation = self.rotation - dt
            self.rotateTo = -0.2
        end
    end
    if self.rotateTo == -0.2 then
        if self.rotation > -0.2 then
            self.rotation = self.rotation - dt
        else
            self.rotation = self.rotation + dt
            self.rotateTo = 0.1
        end
    end
    if self.rotateTo == 0.1 then
        if self.rotation < 0.1 then
            self.rotation = self.rotation + dt
        else
            self.rotation = self.rotation - dt
            self.rotateTo = 0
        end
    end
    if self.rotateTo == 0 then
        if self.rotation > 0 then
            self.rotation = self.rotation - dt
        else
            self.rotation = 0
        end
    end
    print(self.rotation)
end

function TileObject:draw()
    love.graphics.draw(self.batch, self.x-Camera.x+32, (self.y-self.height*self.zy-Camera.y)+128, self.rotation, self.zx, self.zy, 64, 128*2)
    love.graphics.rectangle("line", self.x-Camera.x, self.y-Camera.y, self.width*self.zx, self.height*self.zy)
end

function TileObject:checkCollision(object)
    if self.x < object.x+object.width
    and self.x+self.width*self.zx > object.x
    and self.y < object.y+object.height
    and self.y+self.height*self.zy > object.y then
        return true
    end
    return false
end