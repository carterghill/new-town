Tile = {}

function Tile:new(img)
    local t = setmetatable( { Tile }, { __index = self } )
    t.img = love.graphics.newImage(img)
    t.scale = 64/t.img:getWidth()
    return t
end

function Tile:draw()
    --love.graphics.draw
end