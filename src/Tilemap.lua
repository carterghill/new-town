Tilemap = {
    images = {},
    quads = {},
    objects = {},
    width = 0,
    height = 0,
    tileWidth = 64,
    tileHeight = 64
}

function Tilemap:new(file)
    local t = setmetatable( { Tilemap }, { __index = self } )

    t.file = love.filesystem.load(file)()
    local tilesetfile = t.file.tilesets[1].filename
    tilesetfile = tilesetfile:gsub(".tsx", ".lua")
    local tileset = love.filesystem.load("assets/Maps/"..tilesetfile)()

    t.images[#t.images+1] = love.graphics.newImage(tileset.image)
    t.images[#t.images]:setFilter("nearest") 

    local imageWidth = t.images[#t.images]:getWidth()
    local imageHeight = t.images[#t.images]:getHeight()
    local tileSize = 128
    local quads = {}
    for i = 1, (imageWidth*imageHeight)/128, 128 do
        quads[math.floor(i/128)+1] = love.graphics.newQuad(math.floor((i-1)%imageWidth), 
            math.floor((i-1)/imageWidth)*tileSize, tileSize, tileSize,
            t.images[#t.images]:getWidth(), t.images[#t.images]:getHeight())
    end

    local w = t.file.width
    local h = t.file.height
    t.mapWidth = w
    t.mapHeight = h
    t.tileWidth = t.file.tilewidth
    t.tileHeight = t.file.tileheight
    t.zx = 64/tileSize
    t.zy = 64/tileSize
    t.width = w * t.tileWidth * t.zx
    t.height = h * t.tileHeight * t.zy

    t.batch = love.graphics.newSpriteBatch(t.images[1], t.mapWidth * t.mapHeight)
    t.batchLower = love.graphics.newSpriteBatch(t.images[1], t.mapWidth * t.mapHeight)
    t.batchHigher = love.graphics.newSpriteBatch(t.images[1], t.mapWidth * t.mapHeight)

    t.quads = quads
    t.imageWidth = imageWidth
    t.imageHeight = imageHeight
    t.layers = {}

    for index, layer in ipairs(t.file.layers) do
        local map = {}
        if layer.data ~= nil then
            for i, v in ipairs(layer.data) do
                if map[(i-1)%w + 1] == nil then
                    map[(i-1)%w + 1] = {}
                end
                map[(i-1)%w + 1][math.floor((i-1)/(w))+1] = v
            end
        end
        if layer.name == "Collision" then
            t.collision = map
        elseif layer.type == "objectgroup" then
            t.objects = layer.objects
        else
            t.layers[#t.layers+1] = map
        end
    end

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

function Tilemap:getCollisionTile(x, y)
    if self.collision ~= nil then
        local tilex = math.floor((x/self.tileWidth)/self.zx) + 1
        local tiley = math.floor((y/self.tileHeight)/self.zy) + 1
        if tilex > 0 and tiley > 0 and tilex <= self.mapWidth and tiley <= self.mapHeight then
            local num = self.collision[tilex][tiley]
            return num
        end
    end
    return 0
end

function Tilemap:bakeLevel()
    local mapX = 1
    local mapY = 1
    self.batch:clear()
    for index, layer in ipairs(self.layers) do
        for x=0, self.mapWidth-1 do
            for y=0, self.mapHeight-1 do
              if layer[x+mapX][y+mapY] ~= 0 then
                self.batch:add(self.quads[layer[x+mapX][y+mapY]], x*self.tileWidth, y*self.tileHeight)
                if index > 3 then
                    self.batchHigher:add(self.quads[layer[x+mapX][y+mapY]], x*self.tileWidth, y*self.tileHeight)
                else
                    self.batchLower:add(self.quads[layer[x+mapX][y+mapY]], x*self.tileWidth, y*self.tileHeight)
                end
              end
            end
        end
    end
    self.batch:flush()
end

function Tilemap:drawHigher()
    love.graphics.draw(self.batchHigher, math.floor(-Camera.x), math.floor(-Camera.y),
    0, self.zx, self.zy)
end

function Tilemap:drawLower()
    love.graphics.draw(self.batchLower, math.floor(-Camera.x), math.floor(-Camera.y),
    0, self.zx, self.zy)
end

function Tilemap:draw()
    love.graphics.draw(self.batch, math.floor(-Camera.x), math.floor(-Camera.y),
    0, self.zx, self.zy)
end