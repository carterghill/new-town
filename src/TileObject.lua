TileObject = {
    gid = 0,
    quads = {},
    x = 0, 
    y = 0,
    zx = 1,
    zy = 1,
    type = "",
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
    
    if self.type == "TallGrass" then
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
        else
            --print("No collision!")
        end
    end
end

function TileObject:draw()
    love.graphics.draw(self.batch, self.x-Camera.x, self.y-self.height*self.zy-Camera.y, 0, self.zx, self.zy)
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