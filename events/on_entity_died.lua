local Game = require("__factory-fight__.scripts.game")
local Enemies = require("__factory-fight__.scripts.enemies")

return function (event)
    local entity = event.entity

    if entity.force.name == "blueSilo" and entity.name == "rocket-silo" then
        Game.gameEnd("red", entity)
    end
    if entity.force.name == "redSilo" and entity.name == "rocket-silo" then
        Game.gameEnd("blue", entity)
    end

    Enemies.destroyShield(entity)
end