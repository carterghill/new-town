require("src/Player")
require("src/Camera")
require("src/Tilemap")
require("src/Animation")
require("src/Level")

function love.load()
    l = Level:new("assets/Maps/main.lua")
    t = Tilemap:new("assets/Maps/main.lua")
    player = Player:new(3500, 400)
    player2 = Player:new(50, 50)
    Camera:lockOn(player)
end

function love.draw()

    -- Level and Character
    l:drawBottomLayer()
    love.graphics.rectangle("line", player.x - Camera.x, player.y - Camera.y, player.width, player.height)
    love.graphics.rectangle("line", player2.x - Camera.x, player2.y - Camera.y, player2.width, player2.height)
    l:drawObjects()
    l:drawTopLayer()

    -- UI
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, 150, 75)
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.print(love.timer.getFPS())
    local s = "("..math.floor(player.x)..", "..math.floor(player.y).."): "..l.tileMap:getCollisionTile(player.x, player.y)
    love.graphics.print(s, 0, 16)

end

function love.update(dt)
    player:update(dt, l.tileMap)
    player2:update(dt, l.tileMap)
    Camera:update(dt, l.tileMap)
    l:update(dt)
end

function love.keypressed(key)
    if key == "f" then
        love.window.setFullscreen(not love.window.getFullscreen())
    end
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
    if key =="escape" then
        love.event.quit()
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