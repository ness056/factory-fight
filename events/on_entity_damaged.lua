local Enemies = require("__factory-fight__.scripts.enemies")

return function (event)
    local entity = event.entity
    if entity.health == 0 then
        return
    end
    local shieldKey = Enemies.isShielded(entity)

    if shieldKey == nil then
        return
    end
    local shield = global.shieldedEntities[shieldKey]

    local shieldType = _CONFIG.shieldTypes[shield.shieldType]
    if shieldType.duration ~= -1 and shieldType.duration < game.tick - shield.tick then
        Enemies.destroyShield(entity)
        return
    end

    local reduction = shieldType.power
    entity.health = entity.health + event.final_damage_amount * reduction
end