local Config = require "__factory-fight__.config"
local Utils = require("__factory-fight__.scripts.utils")
local Player = require("__factory-fight__.scripts.player")

local function deleteEntity (entity, player, msg)
    local stack = player.cursor_stack
    if stack.count == 0 then
        player.get_main_inventory().insert({name = entity.name, count = 1})
    else
        stack.count = stack.count + 1
    end

    player.create_local_flying_text{text = msg, position = entity.position}

    entity.destroy()
end

return function (event)
    local entity = event.created_entity
    local player = game.players[event.player_index]
    local surface = game.surfaces[global.gameSurface]

    local factor = Utils.getSideFactor(Player.getTeamOfPlayer(player))

    if entity.position.x * factor < Config.generation.spawnerZoneDistanceFromCenterX
    or (entity.position.x * factor > Config.generation.spawnerZoneDistanceFromCenterX + Config.generation.spawnerZoneMaxWidth and entity.type == "unit-spawner")
    or (math.abs(entity.position.y) > Config.generation.spawnerZoneMaxHeight / 2 and entity.position.x * factor < Config.generation.spawnerZoneDistanceFromCenterX + Config.generation.spawnerZoneMaxWidth) then
        deleteEntity(entity, player, {"cannot-be-placed"})
        return
    end

    if entity.name == "loader_" or entity.name == "fast-loader_" or entity.name == "express-loader_" then
        local shift = {x = 0, y = 0}
        if entity.direction == 0 then shift.y = 1
        elseif entity.direction == 2 then shift.x = -1
        elseif entity.direction == 4 then shift.y = -1
        elseif entity.direction == 6 then shift.x = 1 end

        local backEntity = surface.find_entity("linked-chest", {entity.position.x + shift.x, entity.position.y + shift.y})
        if not backEntity then
            deleteEntity(entity, player, {"l-cannot-be-placed"})
            return
        end

        entity.rotatable = false
    end
end