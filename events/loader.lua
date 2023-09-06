local on_init = require "on_init"
local on_nth_tick = require "on_nth_tick"
local on_player_joined_game = require "on_player_joined_game"
local on_player_changed_position = require "on_player_changed_position"
local on_entity_spawned = require "on_entity_spawned"
local on_gui_click = require "on_gui_click"
local on_gui_value_changed = require "on_gui_value_changed"
local on_built_entity = require "on_built_entity"
local on_entity_died = require "on_entity_died"
local on_research_finished = require "on_research_finished"
local on_gui_selection_state_changed = require "on_gui_selection_state_changed"

script.on_event(defines.events.on_player_joined_game, on_player_joined_game)
script.on_event(defines.events.on_player_changed_position, on_player_changed_position)
script.on_event(defines.events.on_entity_spawned, on_entity_spawned)
script.on_event(defines.events.on_gui_click, on_gui_click)
script.on_event(defines.events.on_gui_value_changed, on_gui_value_changed)
script.on_event(defines.events.on_built_entity, on_built_entity)
script.on_event(defines.events.on_entity_died, on_entity_died)
script.on_event(defines.events.on_research_finished, on_research_finished)
script.on_event(defines.events.on_gui_selection_state_changed, on_gui_selection_state_changed)
for k, v in pairs(on_nth_tick) do
    script.on_nth_tick(v.delay, v.f)
end
script.on_init(on_init)