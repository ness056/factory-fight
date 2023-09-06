local Utils = require("__factory-fight__.scripts.utils")
local Config = require("__factory-fight__.config")

local Enemies = {}

---@param biter LuaEntity @the biter which has been spawned https://lua-api.factorio.com/latest/classes/LuaPlayer.html
---@param spawner LuaEntity @the spawner which has spawned the biter https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Enemies.setBiterCommand(biter, spawner)
    local redSilo = {Config.generation.spawnerZoneDistanceFromCenterX + Config.generation.spawnerZoneWidth / 2, 0}
    local team = Utils.splitString(biter.force.name, "~")[1]
    local factor = Utils.getSideFactor(team)
    biter.release_from_spawner()
    biter.ai_settings.allow_try_return_to_spawner = false
    local f = 1
    if spawner.position.y < 0 then
        f = -1
    end
    local r1 = math.random(Config.generation.bitterPathDistanceFromCenterY, Config.generation.bitterPathDistanceFromCenterY + Config.generation.bitterPathWidth) * f
    local r2 = math.random(Config.generation.bitterPathDistanceFromCenterY, Config.generation.bitterPathDistanceFromCenterY + Config.generation.bitterPathWidth) * f
    biter.set_command{type = defines.command.compound, structure_type = defines.compound_command.return_last, commands = {
        {type = defines.command.go_to_location, destination = {Config.generation.spawnerZoneDistanceFromCenterX * factor, r1}, distraction = defines.distraction.by_anything},
        {type = defines.command.go_to_location, destination = {Config.generation.spawnerZoneDistanceFromCenterX * -factor, r2}, distraction = defines.distraction.by_anything},
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

return Enemies