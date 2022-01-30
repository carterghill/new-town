Assassin = {
    direction = "Front",
    animations = {},
    state = "Walk"
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
                    --print(love.filesystem.getInfo("assets/Characters/Assassin/"..v.."/"..anim))
                    local t = a.animations[v]
                    local animation = Animation:new("assets/Characters/Assassin/"..v.."/"..anim, 6, 64, 64, 0.3, 0.3)
                    t[anim] = animation
                end
            end
        end
    end

    a.walk = Animation:new("assets/Characters/Assassin/Front/Walk")

    return a
end

function Assassin:draw(x, y)
    self.animations[self.direction][self.state]:draw(x-48, y-96)
    --self.walk:draw(x, y)
end

function Assassin:update(dt)
    self.animations[self.direction][self.state]:update(dt)
end

function Assassin:setDirection(direction)
    if direction ~= self.direction then
        self.animations[self.direction][self.state].frame = 1
        self.direction = direction
    end
end