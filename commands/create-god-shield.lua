local Enemies = require("__factory-fight__.scripts.enemies")

return {
    name = "create-god-shield",
    description = "Gives a god shield to a given player. arg: player name.",
    f = function(command)
        local player
        if command.player_index then
            player = game.players[command.player_index]
            if not player.admin then
                player.print({"must-be-admin"})
                return
            end
        end

        if not game.players[command.parameter] then
            if player then
                player.print({"player-not-found"})
            end
            return
        end

        Enemies.createShield(game.players[command.parameter].character, "god_shield", 1)
    end
}