Tileset = {
    batch = nil,
}

function Tileset:new(image)
    local t = setmetatable( { Tileset }, { __index = self } )

    mapWidth = 60
    mapHeight = 40
  
    map = {}
    for x=1,mapWidth do
        map[x] = {}
        for y=1,mapHeight do
        map[x][y] = love.math.random(0,3)
        end
    end

    mapX = 1
    mapY = 1
    tilesDisplayWidth = 26
    tilesDisplayHeight = 20
    
    zoomX = 2
    zoomY = 2

    tilesetImage = love.graphics.newImage( image ) 
    -- this "linear filter" removes some artifacts if we were to scale the tiles
    --tilesetImage:setFilter("nearest", "linear") 
    tileSize = 32
    
    -- grass
    tileQuads = {}
    tileQuads[0] = love.graphics.newQuad(0 * tileSize, 20 * tileSize, tileSize, tileSize,
        tilesetImage:getWidth(), tilesetImage:getHeight())
    -- kitchen floor tile
    tileQuads[1] = love.graphics.newQuad(2 * tileSize, 0 * tileSize, tileSize, tileSize,
        tilesetImage:getWidth(), tilesetImage:getHeight())
    -- parquet flooring
    tileQuads[2] = love.graphics.newQuad(4 * tileSize, 0 * tileSize, tileSize, tileSize,
        tilesetImage:getWidth(), tilesetImage:getHeight())
    -- middle of red carpet
    tileQuads[3] = love.graphics.newQuad(3 * tileSize, 9 * tileSize, tileSize, tileSize,
        tilesetImage:getWidth(), tilesetImage:getHeight())

    t.batch = love.graphics.newSpriteBatch(tilesetImage, tilesDisplayWidth * tilesDisplayHeight)

    return t
end 

function Tileset:draw()
    love.graphics.draw(self.batch, math.floor(-zoomX*(mapX%1)*tileSize - Camera.x), math.floor(-zoomY*(mapY%1)*tileSize - Camera.y),
    0, zoomX, zoomY)
end

function Tileset:update()
    self.batch:clear()
    for x=0, tilesDisplayWidth-1 do
      for y=0, tilesDisplayHeight-1 do
        self.batch:add(tileQuads[map[x+mapX][y+mapY]], x*tileSize, y*tileSize)
      end
    end
    self.batch:flush()
end