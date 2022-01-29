Players = {
    level = {},
}

function Players:load(level)
    player2 = Player:new(3500, 400)
    player = Player:new(level.startx, level.starty)
    self.level = level
end

function Players:draw()
    love.graphics.rectangle("line", player.x - Camera.x, player.y - Camera.y, player.width, player.height)
    love.graphics.rectangle("line", player2.x - Camera.x, player2.y - Camera.y, player2.width, player2.height)
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