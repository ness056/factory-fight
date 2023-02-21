local on_init = require "on_init"
local on_nth_tick = require "on_nth_tick"
local on_player_joined_game = require "on_player_joined_game"

script.on_event(defines.events.on_player_joined_game, on_player_joined_game)
for k, v in pairs(on_nth_tick) do
    script.on_nth_tick(v.delay, v.f)
end
script.on_init(on_init)