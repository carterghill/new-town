Level = {
    tileMap = {},
    objects = {},
    startx = 0,
    starty = 0
}

function Level:new(file)

    local l = setmetatable( { Level }, { __index = self } )

    l.tileMap = Tilemap:new("assets/Maps/main.lua")
    l.objects = {}
    for i, v in ipairs(l.tileMap.objects) do
        if v.type =="Waterfall" then
            local img = love.graphics.newImage("assets/Tilesets/Waterfall@128x128.png")
            local anim = Animation:new(img, 8, 512, 384, l.tileMap.zx, l.tileMap.zy)
            anim.x = v.x
            anim.y = v.y
            l.objects[#l.objects+1] = anim
        end
        if v.type == "Spawn" then
            self.startx = v.x*l.tileMap.zx
            self.starty = v.y*l.tileMap.zy
        end
        print(i)
        for k, val in pairs(v) do
            local s = ""
            s = ": "..tostring(val)
            print("\t"..k..s)
        end
        if v.type == "TallGrass" then
            local newObj = TileObject:new(v, l.tileMap)
            print(newObj.x)
            l.objects[#l.objects+1] = newObj
        end
    end

    l.tileMap:bakeLevel()

    return l

end

function Level:update(dt)
    for i, v in ipairs(self.objects) do
        v:update(dt)
    end
end

function Level:drawTopLayer()
    l.tileMap:drawHigher()
end

function Level:drawBottomLayer()
    l.tileMap:drawLower()
end

function Level:drawObjects()
    for i, v in ipairs(self.objects) do
        v:draw(v.x*v.zx, v.y*v.zy)
    end
end