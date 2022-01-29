require("src/Player")
require("src/Players")
require("src/Camera")
require("src/Tilemap")
require("src/Animation")
require("src/Level")
require("src/UI")

function love.load()
    l = Level:new("assets/Maps/main.lua")
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

    Players:keypressed(key)

    if key == "f" then
        love.window.setFullscreen(not love.window.getFullscreen())
    end
    if key == "r" then
        l.tileMap:bakeLevel()
    end
    if key =="escape" then
        love.event.quit()
    end

end

function love.keyreleased(key)
    Players:keyreleased(key)
end