local Config = require "__factory-fight__.config"
local Utils = require("__factory-fight__.scripts.utils")

local Player = {}

---returns the given player's team, returns nil if they are not in any team
---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
---@return string|nil
function Player.getTeamOfPlayer(player)
    if Utils.indexOf(global.specPlayers, player.name) then
        return "spec"
    elseif Utils.indexOf(global.bluePlayers, player.name) then
        return "blue"
    elseif Utils.indexOf(global.redPlayers, player.name) then
        return "red"
    else
        return nil
    end
end

---checks if the given player touches a teleporter, teleports them to the teleporter's destination if yes
---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Player.checkTeleporter(player)
    local team = Player.getTeamOfPlayer(player)
    if not (team == "blue" or team == "red") or not global.isGameRunning then return end

    local pos = player.position

    local factor = 1
    if team == "blue" then
        factor = -1
    end

    local siloX = (Config.generation.spawnerZoneDistanceFromCenterX + Config.generation.spawnerZoneWidth / 2) * factor
    local playerBox = global.boxs[team .. "~" .. player.name].center

    if math.abs(pos.x) > math.abs(siloX) + 8 and math.abs(pos.x) < math.abs(siloX) + 14 and math.abs(pos.y) < 3 then
        player.teleport(Utils.getValidPosition({playerBox[1] - 33 * factor, playerBox[2]}))
    elseif math.abs(playerBox[1] - pos.x - 40 * factor) < 3 and math.abs(playerBox[2] - pos.y) < 3 then
        player.teleport(Utils.getValidPosition({siloX + 17 * factor, 0}))
    end
end

---checks if the given player touches the bitter path invisible wall, teleports them back if yes
---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Player.checkBitterPathBarrier(player)
    local team = Player.getTeamOfPlayer(player)
    if not (team == "blue" or team == "red") or not global.isGameRunning then return end

    local factor = 1
    if team == "blue" then
        factor = -1
    end

    local pos = player.position

    if math.abs(pos.x) < Config.generation.spawnerZoneDistanceFromCenterX then
        player.teleport(Utils.getValidPosition({(Config.generation.spawnerZoneDistanceFromCenterX + 1) * factor, pos.y}))
    end
end

---inserts resources in the given player's linked chests based on their income, called every seconds
---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
---@param time number @time in second since the last income cycle
function Player.income(player, time)
    local surface = game.surfaces[global.gameSurface]
    local team = Player.getTeamOfPlayer(player)
    local factor = Utils.getSideFactor(team)
    local box = global.boxs[team .. "~" .. player.name]
    local pendingIncome = global.boxs[team .. "~" .. player.name].pendingIncome
    local incomePercentage = global.boxs[team .. "~" .. player.name].incomePercentage
    local income = Player.getIncome(player, time)

    local ironIncome = math.floor(pendingIncome["iron"]) + math.floor(income * incomePercentage["iron"])
    pendingIncome["iron"] = pendingIncome["iron"] % 1 + (income * incomePercentage["iron"]) % 1

    local copperIncome = math.floor(pendingIncome["copper"]) + math.floor(income * incomePercentage["copper"])
    pendingIncome["copper"] = pendingIncome["copper"] % 1 + (income * incomePercentage["copper"]) % 1

    local stoneIncome = math.floor(pendingIncome["stone"]) + math.floor(income * incomePercentage["stone"])
    pendingIncome["stone"] = pendingIncome["stone"] % 1 + (income * incomePercentage["stone"]) % 1

    local coalIncome = math.floor(pendingIncome["coal"]) + math.floor(income * incomePercentage["coal"])
    pendingIncome["coal"] = pendingIncome["coal"] % 1 + (income * incomePercentage["coal"]) % 1

    local oilIncome = math.floor(pendingIncome["oil"]) + math.floor(income * incomePercentage["oil"])
    pendingIncome["oil"] = pendingIncome["oil"] % 1 + (income * incomePercentage["oil"]) % 1

    local x = box.center[1] + (Config.generation.playerBoxWidth / 2 - 0.5) * factor + (factor - 1) / -2
    local y = box.center[2] + 0.5
    local x_ = x + (Config.generation.playerBoxMaxWidth - Config.generation.playerBoxWidth + 8) / 4 * factor

    local chest = surface.find_entity("linked-chest", {x, y})
    local tank = surface.find_entity("giant-storage-tank", {x_, y})
    if ironIncome > 0 then chest.insert({name="iron-plate", count = ironIncome}) end
    if copperIncome > 0 then chest.insert({name="copper-plate", count = copperIncome}) end
    if stoneIncome > 0 then chest.insert({name="stone", count = stoneIncome}) end
    if coalIncome > 0 then chest.insert({name="coal", count = coalIncome}) end
    if oilIncome > 0 then tank.insert_fluid({name="crude-oil", amount = oilIncome * Config.income.oilIncomeMult}) end
end

---calcutates the income the given player
---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
---@param time number @time in second since the last income cycle
---@return number @income
function Player.getIncome(player, time)
    local surface = game.surfaces[global.gameSurface]
    local team = Player.getTeamOfPlayer(player)
    local factor = Utils.getSideFactor(team)
    local area = {
        {factor * (Config.generation.spawnerZoneDistanceFromCenterX + Config.generation.spawnerZoneMaxWidth), -Config.generation.spawnerZoneMaxHeight / 2},
        {factor * Config.generation.spawnerZoneDistanceFromCenterX, Config.generation.spawnerZoneMaxHeight / 2}
    }
    if team == "red" then
        local temp = area[1][1]
        area[1][1] = area[2][1]
        area[2][1] = temp
    end
    local spawners = surface.find_entities_filtered{area = area, type = "unit-spawner", force = team .. "~" .. player.name}

    local value = Config.income.base
    for k, spawner in pairs(spawners) do
        value = value + Config.income[Utils.splitString(spawner.name, "-")[1] .. "Value"]
    end
    local income = math.sqrt(value) / time

    return income
end

---called by Player.on_built_entity to destroy an entity and give the item backer_name
---@param entity LuaEntity @https://lua-api.factorio.com/latest/classes/LuaEntity.html
---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
---@param msg string|LocalisedString @https://lua-api.factorio.com/latest/concepts.html#LocalisedString
function Player.deleteEntity(entity, player, msg)
    local stack = player.cursor_stack
    if stack.count == 0 then
        player.get_main_inventory().insert({name = entity.name, count = 1})
    else
        stack.count = stack.count + 1
    end

    player.create_local_flying_text{text = msg, position = entity.position}

    entity.destroy()
end

---called on event on_built_entity, check if the placed entity can be placed there, destroys it if not
---@param event table @https://lua-api.factorio.com/latest/events.html#on_built_entity
function Player.on_built_entity(event)
    local entity = event.created_entity
    local player = game.players[event.player_index]
    local surface = game.surfaces[global.gameSurface]

    local factor = Utils.getSideFactor(Player.getTeamOfPlayer(player))

    if entity.type == "unit-spawner" and not global.isGameRunning then
        Player.deleteEntity(entity, player, {"game-finished-cannot-be-played"})
        return
    end

    if entity.position.x * factor < Config.generation.spawnerZoneDistanceFromCenterX
    or (entity.position.x * factor > Config.generation.spawnerZoneDistanceFromCenterX + Config.generation.spawnerZoneMaxWidth and entity.type == "unit-spawner")
    or (math.abs(entity.position.y) > Config.generation.spawnerZoneMaxHeight / 2 and entity.position.x * factor < Config.generation.spawnerZoneDistanceFromCenterX + Config.generation.spawnerZoneMaxWidth) then
        Player.deleteEntity(entity, player, {"cannot-be-placed"})
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
            Player.deleteEntity(entity, player, {"l-cannot-be-placed"})
            return
        end

        entity.rotatable = false
    end
end

---TODO
function Player.createPlayerCharacters(player)

end

return Player