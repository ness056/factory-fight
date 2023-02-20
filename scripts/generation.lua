local Config = require "__factory-fight__.config"
local Teams = require "teams"

Generation = {}

function Generation.deleteNauvis() -- ness - just a function to delete and disable all chunks in nauvis
    local nauvis = game.surfaces[1]
    local map_gen_settings = nauvis.map_gen_settings
    map_gen_settings.height = 3
    map_gen_settings.width = 3
    nauvis.map_gen_settings = map_gen_settings
    for chunk in nauvis.get_chunks() do
        nauvis.delete_chunk({chunk.x, chunk.y})
    end
end

function Generation.newGameSurface()
    if global.gameSurface == "game0" then
        global.gameSurface = "game1"
    else
        global.gameSurface = "game0"
    end

    local mapGenSettings = {
        autoplace_controls = {
            ["coal"] = {frequency = 0, size = 0, richness = 0},
            ["stone"] = {frequency = 0, size = 0, richness = 0},
            ["copper-ore"] = {frequency = 0, size = 0, richness = 0},
            ["iron-ore"] = {frequency = 0, size = 0, richness = 0},
            ["uranium-ore"] = {frequency = 0, size = 0, richness = 0},
            ["crude-oil"] = {frequency = 0, size = 0, richness = 0},
            ["trees"] = {frequency = 0, size = 0, richness = 0},
            ["enemy-base"] = {frequency = 0, size = 0, richness = 0}
        },
        cliff_settings = {
            richness = 0
        },
        property_expression_names = {
            elevation = "map"
        }
    }

    local surface = game.create_surface(global.gameSurface, mapGenSettings)

    surface.request_to_generate_chunks({0, 0}, 32)
    surface.force_generate_chunk_requests()
end

function Generation.onGameStarting()
    for k, playerName in pairs(global.bluePlayers) do
        Generation.createPlayerBox(game.players[playerName])
    end

    for k, playerName in pairs(global.redPlayers) do
        Generation.createPlayerBox(game.players[playerName])
    end
end

function Generation.createPlayerBox(player)     -- ness - player must be a LuaPlayer
    local team = Teams.getTeamOfPlayer(player)

    local factor = 1
    if team == "blue" then factor = -1
    elseif team == "spec" then return end

    local n = math.floor(global[team .. "BoxN"] / 2)
    local xCenter = (Config.generation.spawnerZoneDistanceFromCenterX + Config.generation.spawnerZoneMaxWidth + Config.generation.playerBoxMaxWidth / 2 + 15) * factor
    local yCenter = (-1) ^ global[team .. "BoxN"] * (Config.generation.playerBoxMaxHeight * n + 15 * n)

    game.surfaces[global.gameSurface].request_to_generate_chunks({xCenter, yCenter}, Config.generation.playerBoxWidth / 2)
    game.surfaces[global.gameSurface].force_generate_chunk_requests()

    global[team .. "BoxN"] = global[team .. "BoxN"] + 1

    local area = {
        {xCenter - Config.generation.playerBoxWidth / 2 , yCenter - Config.generation.playerBoxHeight / 2},
        {xCenter + Config.generation.playerBoxWidth / 2, yCenter + Config.generation.playerBoxHeight / 2}
    }

    Generation.setTilesArea(area, "landfill")

    player.teleport({xCenter, yCenter})
end

function Generation.setTilesArea(area, tileName)    -- ness - area must be a boundingBox (https://lua-api.factorio.com/latest/Concepts.html#BoundingBox), tileName must be a tile name prototype
    local tiles = {}

    for x = 0, area[2][1] - area[1][1], 1 do
        for y = 0, area[2][2] - area[1][2], 1 do
            table.insert(tiles, {position = {area[1][1] + x, area[1][2] + y}, name = tileName})
        end
    end

    game.surfaces[global.gameSurface].set_tiles(tiles)
end

return Generation