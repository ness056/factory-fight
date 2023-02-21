local Config = require "__factory-fight__.config"
local Utils = require "__factory-fight__.scripts.utils"

return function (event)
    local player = game.players[event.player_index]

    player.teleport(Utils.getValidPosition({0, 0}, Config.generation.specIslandSize), global.gameSurface)
    table.insert(global.specPlayers, player.name)
end