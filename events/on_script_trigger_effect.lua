local Utils = require("__factory-fight__.scripts.utils")
local Enemies = require("__factory-fight__.scripts.enemies")

return function (event)
    local effect_id = event.effect_id
    local surface = game.surfaces[event.surface_index]
    local target_position = event.target_position
    local target_entity = event.target_entity
    local source_entity = event.source_entity

    if effect_id == "create-small-biter" then
        surface.create_entity{name = "small-biter", position = Utils.getValidPosition(target_position or target_entity.position, 10), force = source_entity.force}

    elseif effect_id == "create-small-plant-biter" then
        surface.create_entity{name = "small-plant-biter", position = Utils.getValidPosition(target_position or target_entity.position, 10), force = source_entity.force}

    elseif effect_id == "create-medium-plant-biter" then
        surface.create_entity{name = "medium-plant-biter", position = Utils.getValidPosition(target_position or target_entity.position, 10), force = source_entity.force}

    elseif effect_id == "create-big-plant-biter" then
        surface.create_entity{name = "big-plant-biter", position = Utils.getValidPosition(target_position or target_entity.position, 10), force = source_entity.force}

    elseif effect_id == "small-rock-spitter-spell" then
        Enemies.rockSpitterSpell(source_entity, _CONFIG.biters.rock.small_spitter_spell_range)

    elseif effect_id == "medium-rock-spitter-spell" then
        Enemies.rockSpitterSpell(source_entity, _CONFIG.biters.rock.medium_spitter_spell_range)

    elseif effect_id == "big-rock-spitter-spell" then
        Enemies.rockSpitterSpell(source_entity, _CONFIG.biters.rock.big_spitter_spell_range)

    elseif effect_id == "behemoth-rock-spitter-spell" then
        Enemies.rockSpitterSpell(source_entity, _CONFIG.biters.rock.behemoth_spitter_spell_range)
    end
end