require("Player")

function love.load()
    player = Player:new()
    player2 = Player:new(50, 50)
end

function love.draw()
    --love.graphics.print("Hello World!!", player.x, player.y)
    love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
    love.graphics.rectangle("line", player2.x, player2.y, player2.width, player2.height)
end

function love.update(dt)
    player:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
    player:keypressed(key)
    if key == "up" then
        player2.input.up = true
    end
    if key == "down" then
        player2.input.down = true
    end
    if key == "left" then
        player2.input.left = true
    end
    if key == "right" then
        player2.input.right = true
    end
end

function love.keyreleased(key)
    if key == "w" then
        player.input.up = false
    end
    if key == "s" then
        player.input.down = false
    end
    if key == "a" then
        player.input.left = false
    end
    if key == "d" then
        player.input.right = false
    end

    if key == "up" then
        player2.input.up = false
    end
    if key == "down" then
        player2.input.down = false
    end
    if key == "left" then
        player2.input.left = false
    end
    if key == "right" then
        player2.input.right = false
    end
end