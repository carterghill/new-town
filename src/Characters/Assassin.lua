Assassin = {
    direction = "down",
    animations = {},
}

function Assassin:new()
    local a = setmetatable( { Assassin }, { __index = self } )

    local folder = love.filesystem.getDirectoryItems("assets/Characters/Assassin")
    for i, v in ipairs(folder) do
        if love.filesystem.isDirectory("assets/Characters/Assassin/"..v) then
            local dir = love.filesystem.getDirectoryItems("assets/Characters/Assassin/"..v)
            a.animations[v] = {}
            for i, anim in ipairs(dir) do
                if love.filesystem.isDirectory("assets/Characters/Assassin/"..v.."/"..anim) then
                    --print(anim)
                    local t = a.animations[v]
                    local animation = Animation:new("assets/Characters/Assassin/"..v.."/"..anim)
                    t[anim] = animation
                end
            end
        end
    end

    a.walk = Animation:new("assets/Characters/Assassin/Front/Walk")

    return a
end

function Assassin:draw(x, y)
    for i, v in ipairs(self.animations) do
        love.graphics.print(i..") "..v, 0, 32)
    end
    print(self.walk.draw)
    self.walk:draw(x, y)
end