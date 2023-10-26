local Gui = require("__factory-fight__.scripts.gui")
local Player = require("__factory-fight__.scripts.player")
local Game = require("__factory-fight__.scripts.game")
local Enemies = require("__factory-fight__.scripts.enemies")

return {
    {
        f = function (event)    -- ness - perma chart some chunk
            local y = math.max(_CONFIG.generation.spawnerZoneMaxHeight / 2, (_CONFIG.generation.playerBoxMaxSize + _CONFIG.generation.bordersWidth) * _CONFIG.generation.playerNBoxPerLine / 2) + 96
            local x1 = _CONFIG.generation.spawnerZoneMaxWidth + _CONFIG.generation.spawnerZoneDistanceFromCenterX + 96
            local x1Blue = -x1 - (_CONFIG.generation.playerBoxMaxSize + _CONFIG.generation.bordersWidth) * (math.floor(global["blueBoxN"] / _CONFIG.generation.playerNBoxPerLine) + 1)
            local x1Red = x1 + (_CONFIG.generation.playerBoxMaxSize + _CONFIG.generation.bordersWidth) * (math.floor(global["redBoxN"] / _CONFIG.generation.playerNBoxPerLine) + 1)
            local x2 = _CONFIG.generation.spawnerZoneDistanceFromCenterX * 0.85
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
    },

    {
        f = function (event)
            for shieldKey, shield in pairs(global.shieldedEntities) do
                local shieldType = _CONFIG.shieldTypes[shield.shieldType]
                if shieldType.duration ~= -1 and shieldType.duration < game.tick - shield.tick then
                    Enemies.destroyShield(nil, shieldKey)
                elseif shield.entity.valid == false then
                    Utils.error("Entity with shield not valid")
                    Enemies.destroyShield(nil, shieldKey)
                end
            end
        end,
        delay = 30
    }
}