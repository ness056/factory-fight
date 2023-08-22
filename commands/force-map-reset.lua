local Game = require("__factory-fight__.scripts.game")

return {
    name = "force-map-reset",
    description = "Reset the map and start a new match.",
    f = function(command)
        local playerName
        if command.player_index then
            local player = game.players[command.player_index]

            if not player.admin then
                player.print({"must-be-admin"})
                return
            end
            playerName = player.name
        else
            playerName = {"server-console-name"}
        end

        game.print({"force-map-reset", playerName}, {r = 1, g = 0, b = 0, a = 1})

        global.forceMapReset = true
    end
}