require('src/Tile')

Tiles = {
    dirt = {},
    tilled = {}
}

function Tiles:load()
    local dirtimg = love.graphics.newImage('assets/Tilesets/Dirt/Dirt_01.png')
    Dirt = Tile:new(dirtimg)
    for i = -25, 25, 1 do
        for j = -25, 25, 1 do
            print(#self.dirt)
            self.dirt[#self.dirt+1] = Tile:new(dirtimg, i*256, j*256, 256)
        end
    end
end

function Tiles:draw()
    for key, value in pairs(self.dirt) do
        value:draw()
    end
end