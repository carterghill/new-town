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

function love.keyreleased(key)
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