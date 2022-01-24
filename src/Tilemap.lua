Tilemap = {}

function Tilemap:new(file)
    local t = setmetatable( { Tilemap }, { __index = self } )

    print(file)
    t.file = love.filesystem.load(file)()

    print(t.file.width)

    

    return t
end