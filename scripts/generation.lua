local Config = require "__factory-fight__.config"
local Utils = require("__factory-fight__.scripts.utils")

local Generation = {}

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
    game.map_settings.pollution.enabled = false
    game.map_settings.enemy_evolution.enabled = false
    game.map_settings.enemy_expansion.enabled = false

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

    local blueSZCenter = {-Config.generation.spawnerZoneDistanceFromCenterX - Config.generation.spawnerZoneWidth / 2, 0}
    local redSZCenter = {-blueSZCenter[1], 0}

    surface.request_to_generate_chunks({0, 0}, 4)

    local genWidth = math.ceil(Config.generation.spawnerZoneMaxWidth / 64) + 1
    local genHeight = math.ceil(Config.generation.spawnerZoneMaxHeight / 64) + 1
    surface.request_to_generate_chunks(blueSZCenter, math.max(genWidth, genHeight))
    surface.request_to_generate_chunks(redSZCenter, math.max(genWidth, genHeight))
    surface.force_generate_chunk_requests()

    Generation.createBorder({blueSZCenter[1] - Config.generation.spawnerZoneWidth / 2, 0}, Config.generation.spawnerZoneMaxWidth, Config.generation.spawnerZoneMaxHeight)
    Generation.createBorder({redSZCenter[1] + Config.generation.spawnerZoneWidth / 2, 0}, Config.generation.spawnerZoneMaxWidth, Config.generation.spawnerZoneMaxHeight)

    local blueSilo = surface.create_entity{name = "rocket-silo", position = blueSZCenter, force = "blueSilo"}
    blueSilo.minable = false
    local redSilo = surface.create_entity{name = "rocket-silo", position = redSZCenter, force = "redSilo"}
    redSilo.minable = false

    local blueTPos = {blueSZCenter[1] - 10, blueSZCenter[2]}
    local redTPos = {redSZCenter[1] + 11, redSZCenter[2]}

    local blueTp = surface.create_entity{name = "teleporter", position = blueTPos, force = "blueSilo"}
    blueTp.destructible = false
    local redTp = surface.create_entity{name = "teleporter", position = redTPos, force = "redSilo"}
    redTp.destructible = false
end

function Generation.onGameStarting()
    for k, playerName in pairs(global.bluePlayers) do
        Generation.createPlayerBox(game.players[playerName], "blue")
    end

    for k, playerName in pairs(global.redPlayers) do
        Generation.createPlayerBox(game.players[playerName], "red")
    end
end

function Generation.createPlayerBox(player, team)     -- ness - player must be a LuaPlayer
    local factor = Utils.getSideFactor(team)
    if factor == 0 then return end

    local n = math.ceil((global[team .. "BoxN"] % Config.generation.playerNBoxPerLine) / 2)
    local d = math.floor(global[team .. "BoxN"] / Config.generation.playerNBoxPerLine)
    local xCenter = (Config.generation.spawnerZoneDistanceFromCenterX + Config.generation.spawnerZoneMaxWidth + Config.generation.playerBoxMaxWidth / 2 + Config.generation.bordersWidth + 1 + (Config.generation.bordersWidth + Config.generation.playerBoxMaxWidth) * d) * factor
    local yCenter = (-1) ^ global[team .. "BoxN"] * (Config.generation.playerBoxMaxHeight + Config.generation.bordersWidth) * n + ((Config.generation.playerNBoxPerLine + 1) % 2 * Config.generation.playerBoxMaxHeight / 2)

    game.surfaces[global.gameSurface].request_to_generate_chunks({xCenter, yCenter}, math.ceil(math.max(Config.generation.playerBoxMaxWidth, Config.generation.playerBoxMaxHeight) / 64))
    game.surfaces[global.gameSurface].force_generate_chunk_requests()

    global[team .. "BoxN"] = global[team .. "BoxN"] + 1

    local area = {
        {xCenter - Config.generation.playerBoxWidth / 2, yCenter - Config.generation.playerBoxHeight / 2},
        {xCenter + Config.generation.playerBoxWidth / 2, yCenter + Config.generation.playerBoxHeight / 2}
    }

    Generation.setTilesArea(area, "landfill")
    Generation.createBorder({xCenter, yCenter}, Config.generation.playerBoxMaxWidth, Config.generation.playerBoxMaxHeight)

    local teleporter = game.surfaces[global.gameSurface].create_entity{name = "teleporter", position = {xCenter - 40 * factor, yCenter}, force = "player"}
    teleporter.destructible = false

    global.boxs[team .. "~" .. player.name] = {xCenter, yCenter}
    player.teleport({xCenter - 33 * factor, yCenter})
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

function Generation.createBorder(center, width, height)  -- ness - creates a border of void around zones (like boxs and spawner zones), center must be a map position, width and height is the size of the side of the inner square of the border
    local tiles = {}

    for x = 0, width + Config.generation.bordersWidth * 2, 1 do
        for y = 0, height + Config.generation.bordersWidth * 2, 1 do
            if x < Config.generation.bordersWidth or x - Config.generation.bordersWidth - width > 0 or
            y < Config.generation.bordersWidth or y - Config.generation.bordersWidth - height > 0 then
                local pos = {center[1] + x - width / 2 - Config.generation.bordersWidth, center[2] + y - height / 2 - Config.generation.bordersWidth}
                local tile = game.surfaces[global.gameSurface].get_tile(pos[1], pos[2])
                if tile.name == "water" or tile.name == "deepwater" then
                    table.insert(tiles, {position = pos, name = "out-of-map"})
                end
            end
        end
    end

    game.surfaces[global.gameSurface].set_tiles(tiles)
end

function Generation.addLinkedChest(force, number)
    local surface = game.surfaces[global.gameSurface]
    surface.create_entity{name = "teleporter", position = {xCenter - 40 * factor, yCenter}, force = "player"}
    global.boxs[force]
end

return Generation