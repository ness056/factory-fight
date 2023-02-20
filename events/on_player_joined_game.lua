local Config = require "__factory-fight__.config"

return function (event)
    local player = game.players[event.player_index]

    local validPos = game.surfaces[global.gameSurface].find_non_colliding_position("character", {0, 0}, Config.generation.specIslandSize, 0.01)
    player.teleport(validPos, global.gameSurface)
    table.insert(global.specPlayers, player.name)
end