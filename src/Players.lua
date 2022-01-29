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