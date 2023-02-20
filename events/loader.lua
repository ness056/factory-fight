local on_init = require "on_init"
local on_player_joined_game = require "on_player_joined_game"

script.on_event(defines.events.on_player_joined_game, on_player_joined_game)
script.on_init(on_init)