require("src/Player")
require("src/Players")
require("src/Camera")
require("src/Tilemap")
require("src/Animation")
require("src/Level")
require("src/UI")

function love.load()
    l = Level:new("assets/Maps/main.lua")
    t = Tilemap:new("assets/Maps/main.lua")
    Players:load(l)
    Camera:lockOn(player)
end

function love.draw()

    -- Level and Character
    l:drawBottomLayer()
    Players:draw()
    l:drawObjects()
    l:drawTopLayer()

    -- UI
    UI:draw(player)

end

function love.update(dt)
    Players:update(dt)
    Camera:update(dt, l.tileMap)
    l:update(dt)
end

function love.keypressed(key)
    if key == "f" then
        love.window.setFullscreen(not love.window.getFullscreen())
    end
    if key == "r" then
        l.tileMap:bakeLevel()
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