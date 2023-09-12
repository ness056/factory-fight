local Teams = require("__factory-fight__.scripts.teams")
local Generation = require("__factory-fight__.scripts.generation")
local Global = require("__factory-fight__.scripts.global")
local Enemies = require("__factory-fight__.scripts.enemies")
local Utils = require("__factory-fight__.scripts.utils")
local Player = require("__factory-fight__.scripts.player")
local Config = require "__factory-fight__.config"

Game = {}

function Game.init()
    if global.gameEndingTick ~= -1 and global.gameEndingTick then
        -- reset last game

        for k, force in pairs(game.forces) do
            local name = force.name
            if name ~= "player" and name ~= "enemy" and name ~= "neutral" and name ~= "blueSilo" and name ~= "redSilo" then
                game.merge_forces(name, "player")
            end
        end

        Generation.newGameSurface()

        for k, player in pairs(game.players) do
            player.teleport(Utils.getValidPosition({0, 0}, Config.generation.specIslandSize), global.gameSurface)
            Teams.changeTeam(player, "spec")

            Player.clearPlayerSavedInventories(player)
            Player.clearPlayerInventories(player)
        end

        if global.gameSurface == "game0" then
            game.delete_surface("game1")
        else
            game.delete_surface("game0")
        end

        Utils.resetGlobalTable("boxs")
        global.blueBoxN = 0
        global.redBoxN = 0
        global.gameStratingTick = -1
        global.gameEndingTick = -1
        global.winner = ""
    else
        --init first game
        Global.init()

        Teams.init()

        Generation.deleteNauvis()
        Generation.newGameSurface()
    end
end

---called when the game is starting
function Game.start()
    global.isGameRunning = true
    global.gameStratingTick = game.tick

    Generation.onGameStarting()
    Teams.onGameStarting()
end

---called when one silo dies or on a draw
---@param winner "blue"|"red"|"draw"
---@param silo LuaEntity? @the silo which has died or nil if draw https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Game.gameEnd(winner, silo)
    Enemies.freezeAllBiters()

    global.gameEndingTick = game.tick
    global.winner = winner
    global.isGameRunning = false

    -- create a fancy explosion where the silo was
    if silo then
        local pos = silo.position
        game.surfaces[global.gameSurface].create_entity({
            name = "atomic-rocket",
            position = pos,
            source = pos,
            target = pos,
            max_range = 1,
            speed = 0.1
        })
    end


    game.play_sound{path = "gg-sound"}
end

---resets the map when the game is finished to start a new one, called every second
function Game.checkReset()
    if Utils.getResetTimer() < 0 and global.gameEndingTick ~= -1 and global.gameEndingTick then
        Game.init()
    end
end

return Game