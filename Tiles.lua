Tiles = {
    dirt = {},
    tilled = {}
}

function Tiles:load()
    local files = love.filesystem.getDirectoryItems('assets/Tilesets/Dirt')
    for i, file in ipairs(files) do
        self.dirt[#self.dirt] = love.graphics.newImage('assets/Tilesets/Dirt/'..file)
    end
    files = love.filesystem.getDirectoryItems('assets/Tilesets/Tilled')
    for i, file in ipairs(files) do
        self.tilled[#self.tilled] = love.graphics.newImage('assets/Tilesets/Tilled/'..file)
    end
end

function Tiles:draw()
    love.graphics.draw(self.dirt[0], 0, 0, 0, 0.25)
    love.graphics.draw(self.dirt[0], 128, 0, 0, 0.25)
    love.graphics.draw(self.dirt[0], 256, 0, 0, 0.25)
    love.graphics.draw(self.dirt[0], 256+128, 0, 0, 0.25)

    love.graphics.draw(self.tilled[0], 128, 128, 0, 0.25)
    love.graphics.draw(self.tilled[0], 256, 128, 0, 0.25)
    love.graphics.draw(self.tilled[0], 128, 256, 0, 0.25)
    love.graphics.draw(self.tilled[0], 256, 256, 0, 0.25)
end