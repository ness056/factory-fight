local Config = require "__factory-fight__.config"
local Gui = require("__factory-fight__.scripts.gui")
local Player = require("__factory-fight__.scripts.player")

return {
    {
        f = function (event)    -- ness - perma chart some chunk
            local y = math.max(Config.generation.spawnerZoneMaxHeight / 2, (Config.generation.playerBoxMaxHeight + Config.generation.bordersWidth) * Config.generation.playerNBoxPerLine / 2) + 96
            local x1 = Config.generation.spawnerZoneMaxWidth + Config.generation.spawnerZoneDistanceFromCenterX + 96
            local x1Blue = -x1 - (Config.generation.playerBoxMaxWidth + Config.generation.bordersWidth) * (math.floor(global["blueBoxN"] / Config.generation.playerNBoxPerLine) + 1)
            local x1Red = x1 + (Config.generation.playerBoxMaxWidth + Config.generation.bordersWidth) * (math.floor(global["redBoxN"] / Config.generation.playerNBoxPerLine) + 1)
            local x2 = Config.generation.spawnerZoneDistanceFromCenterX * 0.85
            local blueArea = {
                {x = x1Blue, y = -y},
                {x = x2, y = y}
            }
            local redArea = {
                {x = -x2, y = -y},
                {x = x1Red, y = y}
            }
            local specArea = {
                {x = blueArea[1].x, y = -y},
                {x = redArea[2].x, y = y}
            }
            if global.blueSpyingEnd < game.tick and global.isGameRunning then
                game.forces["blueSilo"].chart(game.surfaces[global.gameSurface], blueArea)
            else
                game.forces["blueSilo"].chart(game.surfaces[global.gameSurface], specArea)
            end
            if global.redSpyingEnd < game.tick and global.isGameRunning then
                game.forces["redSilo"].chart(game.surfaces[global.gameSurface], redArea)
            else
                game.forces["redSilo"].chart(game.surfaces[global.gameSurface], specArea)
            end
            game.forces["player"].chart(game.surfaces[global.gameSurface], specArea)
        end,
        delay = 100
    },

    {
        f = function (event)
            Gui.updateAllGui()

            Game.checkReset()

            if global.forceMapReset then
                Game.gameEnd("draw")
                Game.init()

                global.forceMapReset = false
            end

            if global.isGameRunning == false then return end

            for k, player in pairs(global.bluePlayers) do
                Player.income(game.players[player], 1)
            end

            for k, player in pairs(global.redPlayers) do
                Player.income(game.players[player], 1)
            end
        end,
        delay = 60
    }
}