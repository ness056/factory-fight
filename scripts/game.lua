local Generation = require "__factory-fight__.scripts.generation"
local Teams = require "__factory-fight__.scripts.teams"

Game = {}

function Game.start()
    Teams.onGameStarting()
    Generation.onGameStarting()
end

return Game