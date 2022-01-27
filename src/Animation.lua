Animation = {
    image = {},
    quads = {},
    objects = {},
    batch = {},
    zx = 1,
    zy = 1,
    width = 0,
    height = 0,
    tileWidth = 64,
    tileHeight = 64
}

function Animation:new(img, width, height, zx, zy)
    local a = setmetatable( { Animation }, { __index = self } )

    a.image = love.graphics.newImage(img)
    a.image:setFilter("nearest") 
    a.zx = sx or 1
    a.zy = sy or 1

    local imageWidth = a.image:getWidth()
    local imageHeight = a.image:getHeight()
    local tileWidth = width or 128
    local tileHeight = height or 128
    local quads = {}
    local tilesx = imageWidth/tileWidth
    local tilesy = imageHeight/tileHeight
    for y = 1, tilesy, 1 do
        for x = 1, tilesx, 1 do
            quads[x + (y-1)*tilesy] = love.graphics.newQuad(x-1, y-1, tileWidth, tileHeight, imageWidth, imageHeight)
        end
    end

    a.batch = love.graphics.newSpriteBatch(a.image, tilesx * tilesy)

    --[[for i = 1, (imageWidth*imageHeight)/128, 128 do
        quads[math.floor(i/128)+1] = love.graphics.newQuad(math.floor((i-1)%imageWidth), 
            math.floor((i-1)/imageWidth)*tileSize, tileSize, tileSize,
            a.image:getWidth(), a.image:getHeight())
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
    t.map = map--]]

    return a
end

function Animation:update()
    local mapX = 1
    local mapY = 1
    self.batch:clear()

    self.batch:add(self.quads[1], x*self.tileWidth, y*self.tileHeight)

    self.batch:flush()
end

function Animation:draw(x, y)
    love.graphics.draw(self.batch, math.floor(x - Camera.x), math.floor(y - Camera.y ),
    0, self.zx, self.zy)
end