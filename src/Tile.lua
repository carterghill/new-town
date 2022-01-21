require('src/Camera')

Tile = {
    img = nil,
    sx = 1,
    sy = 1,
    x = 0,
    y = 0
}

function Tile:new(img, x, y, size)
    local t = setmetatable( { Tile }, { __index = self } )
    local s = size or 64
    t.img = img
    t.sx = s/t.img:getWidth()
    t.sy = s/t.img:getHeight()
    t.x = x
    t.y = y
    return t
end

function Tile:draw()
    love.graphics.draw(self.img, self.x - Camera.x, self.y - Camera.y, 0, self.sx, self.sy)
end