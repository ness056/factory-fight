local Utils = require("__factory-fight__.scripts.utils")
local Config = require("__factory-fight__.config")

local Enemies = {}

function Enemies.setBiterCommand(biter, spawner)
    local redSilo = {Config.generation.spawnerZoneDistanceFromCenterX + Config.generation.spawnerZoneWidth / 2, 0}
    local team = Utils.splitString(biter.force.name, "~")[1]
    local factor = Utils.getSideFactor(team)
    biter.release_from_spawner()
    biter.ai_settings.allow_try_return_to_spawner = false
    local f = (spawner.position.y < 0 and -1) or 1
    local r1 = math.random(Config.generation.bitterPathDistanceFromCenterY, Config.generation.bitterPathDistanceFromCenterY + Config.generation.bitterPathWidth) * f
    local r2 = math.random(Config.generation.bitterPathDistanceFromCenterY, Config.generation.bitterPathDistanceFromCenterY + Config.generation.bitterPathWidth) * f
    biter.set_command{type = defines.command.compound, structure_type = defines.compound_command.return_last, commands = {
        {type = defines.command.go_to_location, destination = {Config.generation.spawnerZoneDistanceFromCenterX * factor, r1}, distraction = defines.distraction.by_anything},
        {type = defines.command.go_to_location, destination = {Config.generation.spawnerZoneDistanceFromCenterX * -factor, r2}, distraction = defines.distraction.by_anything},
        {type = defines.command.go_to_location, destination = {redSilo[1] * -factor, 0}, distraction = defines.distraction.by_anything}
    }}
end

return Enemies