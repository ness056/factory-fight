local Player = require("__factory-fight__.scripts.player")

return function (event)
    local player = game.players[event.player_index]

    Player.checkTeleporter(player)
    Player.checkBitterPathBarrier(player)
end