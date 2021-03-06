Assassin = {
    direction = "Front",
    animations = {},
    state = "Walk"
}

function Assassin:new()
    local a = setmetatable( { Assassin }, { __index = self } )

    local folder = love.filesystem.getDirectoryItems("assets/Characters/Assassin")
    for i, v in ipairs(folder) do
        if love.filesystem.getInfo("assets/Characters/Assassin/"..v).type == "directory" then
            local dir = love.filesystem.getDirectoryItems("assets/Characters/Assassin/"..v)
            a.animations[v] = {}
            for i, anim in ipairs(dir) do
                if love.filesystem.getInfo("assets/Characters/Assassin/"..v.."/"..anim).type == "directory" then
                    local t = a.animations[v]
                    local fps = 6
                    if anim == "Idle" then
                        fps = 4
                    end
                    local animation = Animation:new("assets/Characters/Assassin/"..v.."/"..anim, fps, 64, 64, 0.3, 0.3)
                    t[anim] = animation
                end
            end
        end
    end

    a.walk = Animation:new("assets/Characters/Assassin/Front/Walk")

    return a
end

function Assassin:draw(x, y)
    self.animations[self.direction][self.state]:draw(x-45, y-96)
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

function Assassin:setState(state)
    if state ~= self.state then
        self.animations[self.direction][self.state].frame = 1
        self.state = state
    end
end