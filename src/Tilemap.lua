Tilemap = {
    images = {},
    quads = {},
}

function Tilemap:new(file)
    local t = setmetatable( { Tilemap }, { __index = self } )

    print(file)
    t.file = love.filesystem.load(file)()

    local tileset = love.filesystem.load(t.file.tilesets[1].filename)()

    t.images[#t.images+1] = love.graphics.newImage(tileset.image)

    local imageWidth = t.images[#t.images]:getWidth()
    local imageHeight = t.images[#t.images]:getHeight()
    local tileSize = 32
    print(imageWidth)
    local quads = {}
    for i = 1, (imageWidth*imageHeight)/32, 1 do
        quads[i] = love.graphics.newQuad((i-1)%imageWidth * tileSize, 
            math.floor((i-1)/(imageWidth))+1 * tileSize, tileSize, tileSize,
            t.images[#t.images]:getWidth(), t.images[#t.images]:getHeight())
    end

    local w = t.file.width
    local h = t.file.height
    t.mapWidth = w
    t.mapHeight = h

    t.batch = love.graphics.newSpriteBatch(t.images[1], t.mapWidth * t.mapHeight)

    t.quads = quads
    t.imageWidth = imageWidth
    t.imageHeight = imageHeight

    local map = {}
    for i, v in ipairs(t.file.layers[1].data) do
        if map[(i-1)%w + 1] == nil then
            map[(i-1)%w + 1] = {}
        end
        map[(i-1)%w + 1][math.floor((i-1)/(w))+1] = v
    end
    t.map = map

    return t
end

function Tilemap:update()
    local mapX = 1
    local mapY = 1
    self.batch:clear()
    for x=0, self.mapWidth-1 do
      for y=0, self.mapHeight-1 do
        self.batch:add(self.quads[self.map[x+mapX][y+mapY]], x*32, y*32)
      end
    end
    self.batch:flush()
end

function Tilemap:draw()
    love.graphics.draw(self.batch, math.floor(-Camera.x), math.floor(-Camera.y),
    0, 2, 2)
end