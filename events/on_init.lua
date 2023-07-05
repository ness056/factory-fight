local Generation = require("__factory-fight__.scripts.generation")
local Teams = require("__factory-fight__.scripts.teams")
local Global = require("__factory-fight__.scripts.global")

return function()
    Global.init()

    Teams.init()

    Generation.deleteNauvis()
    Generation.newGameSurface()
end