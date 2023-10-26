local Utils = require("__factory-fight__.scripts.utils")

local Enemies = {}

---@param biter LuaEntity @the biter which has been spawned https://lua-api.factorio.com/latest/classes/LuaPlayer.html
---@param spawner LuaEntity @the spawner which has spawned the biter https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Enemies.setBiterCommand(biter, spawner)
    local redSilo = {_CONFIG.generation.spawnerZoneDistanceFromCenterX + _CONFIG.generation.spawnerZoneWidth / 2, 0}
    local team = Utils.splitString(biter.force.name, "~")[1]
    local factor = Utils.getSideFactor(team)
    biter.release_from_spawner()
    biter.ai_settings.allow_try_return_to_spawner = false
    local f = 1
    if spawner.position.y < 0 then
        f = -1
    end
    local r1 = math.random(_CONFIG.generation.bitterPathDistanceFromCenterY, _CONFIG.generation.bitterPathDistanceFromCenterY + _CONFIG.generation.bitterPathWidth) * f
    local r2 = math.random(_CONFIG.generation.bitterPathDistanceFromCenterY, _CONFIG.generation.bitterPathDistanceFromCenterY + _CONFIG.generation.bitterPathWidth) * f
    biter.set_command{type = defines.command.compound, structure_type = defines.compound_command.return_last, commands = {
        {type = defines.command.go_to_location, destination = {_CONFIG.generation.spawnerZoneDistanceFromCenterX * factor, r1}, distraction = defines.distraction.by_anything},
        {type = defines.command.go_to_location, destination = {_CONFIG.generation.spawnerZoneDistanceFromCenterX * -factor, r2}, distraction = defines.distraction.by_anything},
        {type = defines.command.go_to_location, destination = {redSilo[1] * -factor, 0}, distraction = defines.distraction.by_anything}
    }}
end

---freezes all the enemies and disable all spawners, called when the game is finished
function Enemies.freezeAllBiters()
    local biters = game.surfaces[global.gameSurface].find_entities_filtered{type = {"unit-spawner", "unit"}}

    for key, biter in pairs(biters) do
        biter.active = false
    end
end

---@param sourceEntity LuaEntity @the biter which has been spawned https://lua-api.factorio.com/latest/classes/LuaPlayer.html
---@param range number
function Enemies.rockSpitterSpell(sourceEntity, range)
    if not sourceEntity then
        return
    end
    local surface = sourceEntity.surface
    local entitiesInRange = surface.find_entities_filtered{position = sourceEntity.position, radius = range, force = sourceEntity.force, type = "unit"}
    local entityName = sourceEntity.name

    local selectedEntity = nil
    for k, entity in pairs(entitiesInRange) do
        if Enemies.isShielded(entity) == nil then
            selectedEntity = entity
        end
    end

    if selectedEntity == nil then
        return
    end

    local variation = 1
    local selectedEntitySize = Utils.splitString(selectedEntity.name, "-")[1]
    if selectedEntitySize == "medium" then
        variation = 2
    elseif selectedEntitySize == "big" then
        variation = 3
    elseif selectedEntitySize == "behemoth" then
        variation = 4
    end

    local shieldType = ""
    if entityName == "small-rock-spitter" then
        shieldType = "small_spitter_spell"
    elseif entityName == "medium-rock-spitter" then
        shieldType = "medium_spitter_spell"
    elseif entityName == "big-rock-spitter" then
        shieldType = "big_spitter_spell"
    elseif entityName == "behemoth-rock-spitter" then
        shieldType = "behemoth_spitter_spell"
    end

    Enemies.createShield(selectedEntity, shieldType, variation)
end

---returns nil if the given entity is not shielded, if the given entity is shielded, returns the shieldKey
---@param entity LuaEntity @the biter which has been spawned https://lua-api.factorio.com/latest/classes/LuaPlayer.html
---@return nil|number
function Enemies.isShielded(entity)
    return Utils.checkTableValuesCondition(global.shieldedEntities, function (v) return v.entity == entity end)
end

---@param entity LuaEntity @the biter which has been spawned https://lua-api.factorio.com/latest/classes/LuaPlayer.html
---@param shieldType string
---@param textureVariation number
function Enemies.createShield(entity, shieldTypeName, textureVariation)
    local shieldType = _CONFIG.shieldTypes[shieldTypeName]
    local renderId
    if shieldType.isSprite and shieldType.sprites[textureVariation] then
        renderId = rendering.draw_sprite{ sprite = shieldType.sprites[textureVariation], target = entity, surface = entity.surface, orientation_target = entity, use_target_orientation = true, target_offset = shieldType.offset }
    elseif shieldType.isAnimation and shieldType.animations[textureVariation] then
        renderId = rendering.draw_animation{ animation = shieldType.animation[textureVariation], target = entity, surface = entity.surface, orientation_target = entity, use_target_orientation = true, target_offset = shieldType.offset }
    end
    global.shieldedEntities[#global.shieldedEntities+1] = {entity = entity, renderId = renderId, tick = game.tick, shieldType = shieldTypeName}
end

---@param entity LuaEntity @the biter which has been spawned https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Enemies.destroyShield(entity, shieldKey)
    if shieldKey == nil then
        shieldKey = Enemies.isShielded(entity)
        if shieldKey == nil then
            return
        end
    end

    rendering.destroy(global.shieldedEntities[shieldKey].renderId)
    table.remove(global.shieldedEntities, shieldKey)
end

function Enemies.createTurrets()
    local surface = game.surfaces[global.gameSurface]
    local turrets = _CONFIG.turrets
    for k, turret in pairs(turrets) do
        local positionX = _CONFIG.generation.spawnerZoneDistanceFromCenterX * turret.position
        local positionY = _CONFIG.generation.bitterPathDistanceFromCenterY + _CONFIG.generation.bitterPathWidth / 2
        surface.create_entity{name = turret.prototype, position = {positionX, -positionY}, force = "redSilo"}
        surface.create_entity{name = turret.prototype, position = {positionX, positionY}, force = "redSilo"}
        surface.create_entity{name = turret.prototype, position = {-positionX, -positionY}, force = "blueSilo"}
        surface.create_entity{name = turret.prototype, position = {-positionX, positionY}, force = "blueSilo"}
    end
end

return Enemies