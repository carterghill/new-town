TileObject = {
    gid = 0,
    quads = {},
    x = 0, 
    y = 0,
    zx = 1,
    zy = 1
}

function TileObject:new(obj, tilemap)
    
    local t = setmetatable( { TileObject }, { __index = self } )

    t.batch = love.graphics.newSpriteBatch(tilemap.images[1], tilemap.tileWidth * tilemap.tileHeight*2)
    t.gid = obj.gid
    t.quads = tilemap.quads
    t:bakeObject()
    t.x = obj.x*tilemap.zx
    t.y = obj.y*tilemap.zy
    t.zx = tilemap.zx
    t.zy = tilemap.zy

    return t

end

function TileObject:bakeObject()
    self.batch:clear()
    --for index, layer in ipairs(self.layers) do
    --    for x=0, self.mapWidth-1 do
    --        for y=0, self.mapHeight-1 do
    --          if layer[x+mapX][y+mapY] ~= 0 then
                self.batch:add(self.quads[self.gid], 0, 0)
                --if index > 3 then
                --    self.batchHigher:add(self.quads[layer[x+mapX][y+mapY]], x*self.tileWidth, y*self.tileHeight)
                --else
                --    self.batchLower:add(self.quads[layer[x+mapX][y+mapY]], x*self.tileWidth, y*self.tileHeight)
                --end
    --          end
    --        end
    --    end
    --end
    self.batch:flush()
end

function TileObject:update(dt)

end

function TileObject:draw()
    print(self.x)
    love.graphics.draw(self.batch, math.floor(self.x-Camera.x), math.floor(self.y-Camera.y),
    0, self.zx, self.zy)
end