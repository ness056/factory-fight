local Teams = require("__factory-fight__.scripts.teams")
local Generation = require("__factory-fight__.scripts.generation")

local Game = {}

function Game.start()
    Generation.onGameStarting()
    Teams.onGameStarting()

    global.gameStarted = true
    global.gameStratingTick = game.tick
end

return Game