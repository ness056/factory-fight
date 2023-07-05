local Utils = require("__factory-fight__.scripts.utils")
local Generation = require("__factory-fight__.scripts.generation")
local Player = require("__factory-fight__.scripts.player")

local Teams = {}

function Teams.init()
    local blueSilo = game.create_force("blueSilo")
    blueSilo.share_chart = true
    game.forces["player"].set_friend("blueSilo", true)
    local redSilo = game.create_force("redSilo")
    redSilo.share_chart = true
    game.forces["player"].set_friend("redSilo", true)
end

function Teams.changeTeam(player, newTeam)  -- ness - changes the team of a player, player must be a LuaPlayer and newTeam must be "spec", "blue" or "red"
    if Player.getTeamOfPlayer(player) == newTeam then return end

    if newTeam == "spec" then
        table.insert(global.specPlayers, player.name)
        Utils.removeByValue(global.bluePlayers, player.name)
        Utils.removeByValue(global.redPlayers, player.name)

    elseif newTeam == "blue" then
        table.insert(global.bluePlayers, player.name)
        Utils.removeByValue(global.specPlayers, player.name)
        Utils.removeByValue(global.redPlayers, player.name)

    elseif newTeam == "red" then
        table.insert(global.redPlayers, player.name)
        Utils.removeByValue(global.specPlayers, player.name)
        Utils.removeByValue(global.bluePlayers, player.name)

    else
        Utils.error("!!!! Team " .. newTeam .. " doesn't exist !!!!")
        return
    end

    if global.gameStarted and not global.boxs[newTeam .. "~" .. player.name] and newTeam ~= "spec" then      -- if the game hasn't started now, players names will be write in a list and then, when the game will start, their forces and boxs will be created
        Generation.createPlayerBox(player, newTeam)
        Teams.createPlayerForce(player)
    end

    if global.gameStarted and newTeam ~= "spec" then
        player.force = newTeam .. "~" .. player.name
        local factor = Utils.getSideFactor(newTeam)
        local boxCenter = global.boxs[newTeam .. "~" .. player.name]
        player.teleport({boxCenter[1] - 33 * factor, boxCenter[2] * math.abs(factor)})
    else
        player.force = "player"
        player.teleport({0, 0})
    end
end

function Teams.onGameStarting()     -- ness - create pending forces
    for k, playerName in pairs(global.bluePlayers) do
        local player = game.players[playerName]
        local force = Teams.createPlayerForce(player)
        player.force = force
    end

    for k, playerName in pairs(global.redPlayers) do
        local player = game.players[playerName]
        local force = Teams.createPlayerForce(player)
        player.force = force
    end
end

function Teams.createPlayerForce(player)    --ness - player must be a LuaPlayer. returns the new force name
    local team = Player.getTeamOfPlayer(player)

    local force = game.create_force(team .. "~" .. player.name)

    force.set_friend(team .. "Silo", true)
    game.forces["player"].set_friend(force, true)
    game.forces[team .. "Silo"].set_friend(force, true)
    for k, playerName in pairs(global[team .. "Players"]) do
        if player.name == playerName then break end

        force.set_friend(team .. "~" .. playerName, true)
        game.forces[team .. "~" .. playerName].set_friend(force, true)
    end

    force.set_spawn_position(global.boxs[team .. "~" .. player.name], global.gameSurface)

    force.share_chart = true

    return force
end

return Teams