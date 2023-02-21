local Config = require "__factory-fight__.config"

return {
    {
        f = function (event)    -- ness - perma chart some chunk to forces
            local y = math.max(Config.generation.spawnerZoneMaxHeight / 2, (Config.generation.playerBoxMaxHeight + 15) * Config.generation.playerNBoxPerLine / 2) + 64
            local x1 = Config.generation.spawnerZoneMaxWidth + Config.generation.spawnerZoneDistanceFromCenterX + 64
            local x1Blue = -x1 - (Config.generation.playerBoxMaxWidth + 15) * (math.floor(global["blue" .. "BoxN"] / Config.generation.playerNBoxPerLine) + 1)
            local x1Red = x1 + (Config.generation.playerBoxMaxWidth + 15) * (math.floor(global["red" .. "BoxN"] / Config.generation.playerNBoxPerLine) + 1)
            local x2 = Config.generation.spawnerZoneDistanceFromCenterX * 0.85
            local blueArea = {
                {x = x1Blue, y = -y},
                {x = x2, y = y}
            }
            local redArea = {
                {x = x2 * -1, y = -y},
                {x = x1Red, y = y}
            }
            local specArea = {
                {x = blueArea[1].x, y = -y},
                {x = redArea[2].x, y = y}
            }
            game.forces["blueSilo"].chart(game.surfaces[global.gameSurface], blueArea)
            game.forces["redSilo"].chart(game.surfaces[global.gameSurface], redArea)
            game.forces["player"].chart(game.surfaces[global.gameSurface], specArea)
        end,
        delay = 100
    }
}