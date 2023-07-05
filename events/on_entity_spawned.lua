local Enemies = require("__factory-fight__.scripts.enemies")

return function (event)
    if not event.entity then return end
    if event.entity.surface.name ~= global.gameSurface then return end
    if global.gameStarted == false then return end

    Enemies.setBiterCommand(event.entity, event.spawner)
end