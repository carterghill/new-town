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
    t.y = obj.y*tilemap.zy
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

end

function TileObject:draw()
    love.graphics.draw(self.batch, self.x-Camera.x, self.y-128-Camera.y, 0, self.zx, self.zy)
end