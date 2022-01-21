require('src/Camera')

Tile = {}

function Tile:new(img)
    local t = setmetatable( { Tile }, { __index = self } )
    t.img = love.graphics.newImage(img)
    t.scale = 64/t.img:getWidth()
    return t
end

function Tile:draw(x, y)
    love.graphics.draw(self.img, x - Camera.x, y - Camera.y, 0, self.scale)
end