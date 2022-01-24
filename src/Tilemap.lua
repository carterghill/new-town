Tilemap = {
    images ={}
}

function Tilemap:new(file)
    local t = setmetatable( { Tilemap }, { __index = self } )

    print(file)
    t.file = love.filesystem.load(file)()

    local tileset = love.filesystem.load(t.file.tilesets[1].filename)()

    t.images[#t.images+1] = love.graphics.newImage(tileset.image)

    local imageWidth = t.images[#t.images]:getWidth()
    print(imageWidth)

    local w = t.file.width
    local h = t.file.height

    local map = {}
    for i, v in ipairs(t.file.layers[1].data) do
        print(i..": "..v)
        print(((i-1)%w + 1)..", "..math.floor((i-1)/w)+1)
        if map[(i-1)%w + 1] == nil then
            map[(i-1)%w + 1] = {}
        end
        map[(i-1)%w + 1][math.floor((i-1)/(w))+1] = v
    end

    return t
end