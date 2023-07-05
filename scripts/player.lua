local Config = require "__factory-fight__.config"
local Utils = require("__factory-fight__.scripts.utils")

local Player = {}

function Player.getTeamOfPlayer(player)      -- ness - returns the team of the player, player must be a LuaPlayer
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

function Player.checkTeleporter(player)     -- ness - check if the player is on a teleporter, and if so, it teleports him, player must be a LuaPlayer
    local team = Player.getTeamOfPlayer(player)
    if not (team == "blue" or team == "red") or not global.gameStarted then return end

    local pos = player.position

    local factor = 1
    if team == "blue" then
        factor = -1
    end

    local siloX = (Config.generation.spawnerZoneDistanceFromCenterX + Config.generation.spawnerZoneWidth / 2) * factor
    local playerBox = global.boxs[team .. "~" .. player.name]

    if math.abs(pos.x) > math.abs(siloX) + 8 and math.abs(pos.x) < math.abs(siloX) + 14 and math.abs(pos.y) < 3 then
        player.teleport({playerBox[1] - 33 * factor, playerBox[2]})
    elseif math.abs(playerBox[1] - pos.x - 40 * factor) < 3 and math.abs(playerBox[2] - pos.y) < 3 then
        player.teleport({siloX + 17 * factor, 0})
    end
end

function Player.checkBitterPathBarrier(player)
    local team = Player.getTeamOfPlayer(player)
    if not (team == "blue" or team == "red") or not global.gameStarted then return end

    local factor = 1
    if team == "blue" then
        factor = -1
    end

    local pos = player.position

    if math.abs(pos.x) < Config.generation.spawnerZoneDistanceFromCenterX then
        player.teleport({(Config.generation.spawnerZoneDistanceFromCenterX + 1) * factor, pos.y})
    end
end

function Player.income(team, player, time)
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
    local spawners = game.surfaces[global.gameSurface].find_entities_filtered{area = area, type = "unit-spawner", force = team .. "~" .. player}

    local value = 25
    for k, spawner in pairs(spawners) do
        value = value + Config.income[Utils.splitString(spawner.name, "-")[1] .. "Value"]
    end
    local income = math.sqrt(value / time)
    print(player, income, value)
end

return Player