local Config = require "__factory-fight__.config"
local Utils = require("__factory-fight__.scripts.utils")
local Player = require("__factory-fight__.scripts.player")
local Gui = require("__factory-fight__.scripts.gui")

return function (event)
    local player = game.players[event.player_index]

    if Player.getTeamOfPlayer(player) == nil then
        player.teleport(Utils.getValidPosition({0, 0}, Config.generation.specIslandSize), global.gameSurface)
        table.insert(global.specPlayers, player.name)
    end

    Gui.destroyGui(player)
    Gui.createGui(player)
end