local Player = require("__factory-fight__.scripts.player")

return function (event)
    Player.on_built_entity(event)
end