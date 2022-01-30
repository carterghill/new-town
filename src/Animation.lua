Animation = {
    image = {},
    quads = {},
    batch = {},
    zx = 1,
    zy = 1,
    width = 0,
    height = 0,
    fps = 12,
    frameAge = 0,
    frame = 1,
    type = "tileset"
}

function Animation:new(img, fps, width, height, zx, zy)

    local a = {}
    a = setmetatable( { Animation }, { __index = self } )
    a.zx = zx or 1
    a.zy = zy or 1
    a.fps = fps or 12


    if type(img) == "string" then
        a.type = "folder"
        a.quads = {}
        local dir = love.filesystem.getDirectoryItems(img)
        for i, v in ipairs(dir) do
            a.quads[#a.quads+1] = love.graphics.newImage(img.."/"..v)
        end
    else

        a.image = img
        a.image:setFilter("nearest") 
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
    
    end

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
        if self.type == "tileset" then
            self.batch:clear()
            self.batch:add(self.quads[self.frame])
            self.batch:flush()
        end
        
    end
end

function Animation:draw(x, y)
    if self.type == "folder" then
        love.graphics.draw(self.quads[self.frame], x - Camera.x, y - Camera.y, 0, self.zx, self.zy)
    else
        love.graphics.draw(self.batch, math.floor(x - Camera.x), math.floor(y - Camera.y ),
        0, self.zx, self.zy)
    end
    
end