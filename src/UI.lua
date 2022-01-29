UI = {
    stats = {
        show = true
    },
}

function UI:load()
    
end

function UI:draw(player)
    if self.stats.show then
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle("fill", 0, 0, 150, 75)
        love.graphics.setColor(255, 255, 255, 1)
        love.graphics.print(love.timer.getFPS())
        if player ~= nil then
            local s = "("..math.floor(player.x)..", "..math.floor(player.y).."): "..l.tileMap:getCollisionTile(player.x, player.y)
            love.graphics.print(s, 0, 16)
        end
    end
end