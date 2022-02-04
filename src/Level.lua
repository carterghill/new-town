Level = {
    tileMap = {},
    objects = {},
    startx = 0,
    starty = 0
}

local function orderY(a,b)
    return a.y < b.y
end

function Level:new(file)

    local l = setmetatable( { Level }, { __index = self } )

    l.tileMap = Tilemap:new("assets/Maps/main.lua")
    l.objects = {}
    for i, v in ipairs(l.tileMap.objects) do
        if v.type =="Waterfall" then
            local img = love.graphics.newImage("assets/Tilesets/Waterfall@128x128.png")
            local anim = Animation:new(img, 6, 512, 384, l.tileMap.zx, l.tileMap.zy)
            anim.x = v.x*l.tileMap.zx
            anim.y = v.y*l.tileMap.zy
            l.objects[#l.objects+1] = anim
        end
        if v.type == "Spawn" then
            self.startx = v.x*l.tileMap.zx
            self.starty = v.y*l.tileMap.zy
        end
        for k, val in pairs(v) do
            local s = ""
            s = ": "..tostring(val)
        end
        if v.gid ~= nil then
            local newObj = TileObject:new(v, l.tileMap)
            l.objects[#l.objects+1] = newObj
        end
    end

    table.sort(l.objects, orderY)
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

function Level:drawObjects(player)
    local drawn = false
    for i, v in ipairs(self.objects) do
        if not drawn and player ~= nil and v.y+v.height*v.zy > player.y+player.height then
            player:draw()
            drawn = true
        end
        v:draw(v.x, v.y)
    end
    if not drawn then 
        player:draw()
    end
end