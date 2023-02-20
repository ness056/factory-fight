local Utils = require "utils"

Teams = {}

function Teams.init()
    game.create_force("blueSilo")
    game.create_force("redSilo")
end

function Teams.changeTeam(player, newTeam)  -- ness - changes the team of a player, player must be a LuaPlayer and newTeam must be "spec", "blue" or "red"
    if global.gameStarted then      -- if the game hasn't started now, players will names will be write in a list and then, when the game will start, their forces and boxs will be created

    else
        if Teams.getTeamOfPlayer(player) == newTeam then return end

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
    local team = Teams.getTeamOfPlayer(player)

    local force = game.create_force(team .. "~" .. player.name)

    force.set_friend(team .. "Silo", true)
    for k, v in pairs(global[team .. "Players"]) do
        force.set_friend(team .. "~" .. v)
    end
end

function Teams.getTeamOfPlayer(player)      -- ness - returns the team of the player, player must be a LuaPlayer
    if Utils.indexOf(global.specPlayers, player.name) then
        return "spec"
    elseif Utils.indexOf(global.bluePlayers, player.name) then
        return "blue"
    elseif Utils.indexOf(global.redPlayers, player.name) then
        return "red"
    else
        Utils.error("!!!! " .. player.name .. " isn't in any team !!!!")
    end
end

return Teams