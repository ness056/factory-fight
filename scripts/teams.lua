local Utils = require("__factory-fight__.scripts.utils")
local Generation = require("__factory-fight__.scripts.generation")
local Player = require("__factory-fight__.scripts.player")

local Teams = {}

---called on event on_init
function Teams.init()
    local blueSilo = game.create_force("blueSilo")
    blueSilo.share_chart = true
    blueSilo.set_friend("player", true)
    game.forces["player"].set_friend("blueSilo", true)

    local redSilo = game.create_force("redSilo")
    redSilo.share_chart = true
    redSilo.set_friend("player", true)
    game.forces["player"].set_friend("redSilo", true)

    game.forces["player"].disable_research()

    local specPermGroup = game.permissions.create_group("spec")

    specPermGroup.set_allows_action(defines.input_action.activate_paste, false)
    specPermGroup.set_allows_action(defines.input_action.begin_mining, false)
    specPermGroup.set_allows_action(defines.input_action.begin_mining_terrain, false)
    specPermGroup.set_allows_action(defines.input_action.build, false)
    specPermGroup.set_allows_action(defines.input_action.build_rail, false)
    specPermGroup.set_allows_action(defines.input_action.build_terrain, false)
    specPermGroup.set_allows_action(defines.input_action.craft, false)
    specPermGroup.set_allows_action(defines.input_action.deconstruct, false)
    specPermGroup.set_allows_action(defines.input_action.drop_item, false)
    specPermGroup.set_allows_action(defines.input_action.import_blueprint, false)
    specPermGroup.set_allows_action(defines.input_action.import_blueprint_string, false)
    specPermGroup.set_allows_action(defines.input_action.import_blueprints_filtered, false)
    specPermGroup.set_allows_action(defines.input_action.open_blueprint_library_gui, false)
    specPermGroup.set_allows_action(defines.input_action.open_blueprint_record, false)
    specPermGroup.set_allows_action(defines.input_action.use_item, false)
    specPermGroup.set_allows_action(defines.input_action.wire_dragging, false)

    local playerPermGroup = game.permissions.create_group("player")

    playerPermGroup.set_allows_action(defines.input_action.import_blueprint, false)
    playerPermGroup.set_allows_action(defines.input_action.import_blueprint_string, false)
    playerPermGroup.set_allows_action(defines.input_action.import_blueprints_filtered, false)
    playerPermGroup.set_allows_action(defines.input_action.open_blueprint_library_gui, false)
    playerPermGroup.set_allows_action(defines.input_action.open_blueprint_record, false)
end

---change the given player's team
---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
---@param newTeam "blue"|"red"|"spec"
---@param forced boolean
function Teams.changeTeam(player, newTeam, forced)
    local formerTeam = Player.getTeamOfPlayer(player)
    if formerTeam == newTeam and forced == false then return end

    -- save inventories
    if formerTeam == "blue" then
        Player.savePlayerInventories(player, "blue")
    elseif formerTeam == "red" then
        Player.savePlayerInventories(player, "red")
    end

    Player.clearPlayerInventories(player)

    -- load inventories and change team players' table
    Utils.removeByValue(global.specPlayers, player.name)
    Utils.removeByValue(global.bluePlayers, player.name)
    Utils.removeByValue(global.redPlayers, player.name)

    if newTeam == "spec" then
        table.insert(global.specPlayers, player.name)

    elseif newTeam == "blue" then
        table.insert(global.bluePlayers, player.name)

    elseif newTeam == "red" then
        table.insert(global.redPlayers, player.name)

    else
        Utils.error("!!!! Team " .. newTeam .. " doesn't exist !!!!")
        return
    end

    -- if the game hasn't started now, players names will be write in a list and then, when the game will start, their forces and boxs will be created
    if global.isGameRunning and not global.boxs[newTeam .. "~" .. player.name] and newTeam ~= "spec" then
        Generation.createPlayerBox(player, newTeam)
        Teams.createPlayerForce(player)
    end

    if global.isGameRunning and newTeam ~= "spec" then
        player.force = newTeam .. "~" .. player.name
        game.permissions.get_group("player").add_player(player)
        local factor = Utils.getSideFactor(newTeam)
        local boxCenter = global.boxs[newTeam .. "~" .. player.name].center
        player.teleport(Utils.getValidPosition({boxCenter[1] - 33 * factor, boxCenter[2] * math.abs(factor)}))
    elseif global.isGameRunning then
        player.teleport({0, 0})
    end

    if newTeam == "spec" then
        player.force = "player"
        game.permissions.get_group("spec").add_player(player)

    elseif newTeam == "blue" then
        Player.loadPlayerInventories(player, "blue")

    elseif newTeam == "red" then
        Player.loadPlayerInventories(player, "red")
    end
end

---loop over all the players to create thier force, called when the game is starting
function Teams.onGameStarting()
    for k, playerName in pairs(global.bluePlayers) do
        local player = game.players[playerName]
        local force = Teams.createPlayerForce(player)
        Teams.changeTeam(player, Utils.getTeamFromForce(force.name), true)
    end

    for k, playerName in pairs(global.redPlayers) do
        local player = game.players[playerName]
        local force = Teams.createPlayerForce(player)
        Teams.changeTeam(player, Utils.getTeamFromForce(force.name), true)
    end
end

---creates the given player's force and set it friend with spectators' team and all their allies' forces
---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
---@return LuaForce @https://lua-api.factorio.com/latest/classes/LuaForce.html
function Teams.createPlayerForce(player)
    local team = Player.getTeamOfPlayer(player)

    local force = game.create_force(team .. "~" .. player.name)

    force.set_friend("player", true)
    game.forces["player"].set_friend(force, true)
    force.set_friend(team .. "Silo", true)
    game.forces[team .. "Silo"].set_friend(force, true)
    for k, playerName in pairs(global[team .. "Players"]) do
        if player.name == playerName then break end

        force.set_friend(team .. "~" .. playerName, true)
        game.forces[team .. "~" .. playerName].set_friend(force, true)
    end

    force.set_spawn_position(global.boxs[team .. "~" .. player.name].center, global.gameSurface)

    force.share_chart = true
    force.research_queue_enabled = true

    Generation.addLinkedChest(team .. "~" .. player.name, 0)

    return force
end

return Teams