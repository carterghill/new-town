Players = {
    level = {},
}

function Players:load(level)
    player2 = Player:new(3500, 400)
    player = Player:new(level.startx, level.starty, Assassin:new())
    self.level = level
end

function Players:draw()
    player:draw()
    player2:draw()
end

function Players:update(dt)
    player:update(dt, self.level.tileMap)
    player2:update(dt, self.level.tileMap)
end

function Players:keypressed(key)
    player:keypressed(key)
    if key == "up" then
        player2.controls.up = true
    end
    if key == "down" then
        player2.controls.down = true
    end
    if key == "left" then
        player2.controls.left = true
    end
    if key == "right" then
        player2.controls.right = true
    end
end

function Players:keyreleased(key)
    player:keyreleased(key)

    if key == "up" then
        player2.controls.up = false
    end
    if key == "down" then
        player2.controls.down = false
    end
    if key == "left" then
        player2.controls.left = false
    end
    if key == "right" then
        player2.controls.right = false
    end
end