Animation = {
    image = {},
    quads = {},
    objects = {},
    batch = {},
    zx = 1,
    zy = 1,
    width = 0,
    height = 0,
    fps = 12,
    frameAge = 0,
    frame = 1
}

function Animation:new(img, fps, width, height, zx, zy)

    local a = setmetatable( { Animation }, { __index = self } )

    a.image = img
    a.image:setFilter("nearest") 
    a.zx = zx or 1
    a.zy = zy or 1
    a.fps = fps or 12

    local imageWidth = a.image:getWidth()
    local imageHeight = a.image:getHeight()
    local tileWidth = width or 128
    local tileHeight = height or 128
    local quads = {}
    local tilesx = imageWidth/tileWidth
    local tilesy = imageHeight/tileHeight

    for y = 1, tilesy, 1 do
        for x = 1, tilesx, 1 do
            quads[x + (y-1)*tilesx] = love.graphics.newQuad((x-1)*tileWidth, 
            (y-1)*tileHeight, tileWidth, tileHeight, imageWidth, imageHeight)
        end
    end

    a.quads = quads
    a.batch = love.graphics.newSpriteBatch(a.image, tilesx * tilesy)

    return a
end

function Animation:update(dt)   
    local frameTime = 1/self.fps
    self.frameAge = self.frameAge + dt
    if self.frameAge > frameTime then
        if self.frame == #self.quads then
            self.frame = 1
        else 
            self.frame = self.frame + 1
        end
        self.frameAge = 0
        self.batch:clear()
        self.batch:add(self.quads[self.frame])
        self.batch:flush()
    end
end

function Animation:draw(x, y)
    love.graphics.draw(self.batch, math.floor(x - Camera.x), math.floor(y - Camera.y ),
    0, self.zx, self.zy)
end