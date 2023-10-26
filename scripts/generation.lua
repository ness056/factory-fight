local Utils = require("__factory-fight__.scripts.utils")
local Enemies = require("__factory-fight__.scripts.enemies")

local Generation = {}

---deletes and disables all chunks in nauvis (the default surface)
function Generation.deleteNauvis()
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
    --create a new game surface [[
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

    surface.always_day = true
    --]]

    local blueSZCenter = {-_CONFIG.generation.spawnerZoneDistanceFromCenterX - _CONFIG.generation.spawnerZoneWidth / 2, 0}
    local redSZCenter = {-blueSZCenter[1], 0}

    surface.request_to_generate_chunks({0, 0}, 4)

    local genWidth = math.ceil(_CONFIG.generation.spawnerZoneMaxWidth / 64) + 1
    local genHeight = math.ceil(_CONFIG.generation.spawnerZoneMaxHeight / 64) + 1
    surface.request_to_generate_chunks(blueSZCenter, math.max(genWidth, genHeight))
    surface.request_to_generate_chunks(redSZCenter, math.max(genWidth, genHeight))
    surface.force_generate_chunk_requests()

    local BZx1 = _CONFIG.generation.spawnerZoneDistanceFromCenterX
    local BZx2 = BZx1 + _CONFIG.generation.spawnerZoneWidth
    local BZy = _CONFIG.generation.spawnerZoneHeight / 2
    Generation.setTilesArea({{BZx1, -BZy}, {BZx2, BZy}}, "grass-1")
    Generation.setTilesArea({{-BZx2, -BZy}, {-BZx1, BZy}}, "grass-1")

    local BPy1 = _CONFIG.generation.bitterPathDistanceFromCenterY
    local BPy2 = BPy1 + _CONFIG.generation.bitterPathWidth
    Generation.setTilesArea({{-BZx1, BPy1}, {BZx1, BPy2}}, "grass-1")
    Generation.setTilesArea({{-BZx1, -BPy2}, {BZx1, -BPy1}}, "grass-1")

    surface.regenerate_decorative()

    Generation.createBorder({blueSZCenter[1] - _CONFIG.generation.spawnerZoneWidth / 2, 0}, _CONFIG.generation.spawnerZoneMaxWidth, _CONFIG.generation.spawnerZoneMaxHeight)
    Generation.createBorder({redSZCenter[1] + _CONFIG.generation.spawnerZoneWidth / 2, 0}, _CONFIG.generation.spawnerZoneMaxWidth, _CONFIG.generation.spawnerZoneMaxHeight)

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

    Enemies.createTurrets()
end

---loop over all the players to create thier island, called when the game is starting
function Generation.onGameStarting()
    for k, playerName in pairs(global.bluePlayers) do
        Generation.createPlayerBox(game.players[playerName], "blue")
    end

    for k, playerName in pairs(global.redPlayers) do
        Generation.createPlayerBox(game.players[playerName], "red")
    end
end

---creates player's island and its teleport, its oil tank and its first linked chest
---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
---@param team "blue"|"red"
function Generation.createPlayerBox(player, team)
    local factor = Utils.getSideFactor(team)
    if factor == 0 then return end
    local surface = game.surfaces[global.gameSurface]
    local playerBoxMaxSize = _CONFIG.generation.playerBoxMaxSize
    local playerNBoxPerLine = _CONFIG.generation.playerNBoxPerLine
    local spawnerZoneDistanceFromCenterX = _CONFIG.generation.spawnerZoneDistanceFromCenterX
    local bordersWidth = _CONFIG.generation.bordersWidth
    local spawnerZoneMaxWidth = _CONFIG.generation.spawnerZoneMaxWidth

    local n = math.ceil((global[team .. "BoxN"] % playerNBoxPerLine) / 2)
    local d = math.floor(global[team .. "BoxN"] / playerNBoxPerLine)
    local xCenter = (spawnerZoneDistanceFromCenterX + spawnerZoneMaxWidth + playerBoxMaxSize / 2 + bordersWidth + 1 + (bordersWidth + playerBoxMaxSize) * d) * factor
    local yCenter = (-1) ^ global[team .. "BoxN"] * (playerBoxMaxSize + bordersWidth) * n + ((playerNBoxPerLine + 1) % 2 * playerBoxMaxSize / 2)

    surface.request_to_generate_chunks({xCenter, yCenter}, math.ceil(playerBoxMaxSize / 64))
    surface.force_generate_chunk_requests()

    global[team .. "BoxN"] = global[team .. "BoxN"] + 1

    local area = {
        {xCenter - _CONFIG.generation.playerBoxWidth / 2, yCenter - _CONFIG.generation.playerBoxHeight / 2},
        {xCenter + _CONFIG.generation.playerBoxWidth / 2, yCenter + _CONFIG.generation.playerBoxHeight / 2}
    }

    Generation.setTilesArea(area, "landfill")
    Generation.createBorder({xCenter, yCenter}, playerBoxMaxSize, playerBoxMaxSize)

    local teleporter = surface.create_entity{name = "teleporter", position = {xCenter - 40 * factor, yCenter}, force = "player"}
    teleporter.destructible = false

    local x = xCenter + (_CONFIG.generation.playerBoxWidth / 2 - 1) * factor
    for i = 0, 4, 1 do
        local y = yCenter + (-1) ^ i * math.ceil(i / 2) * 10
        surface.create_entity{name = "linked-chest-blocker", position = {x, y}, force = "player"}
    end

    local x_ = x + (playerBoxMaxSize - _CONFIG.generation.playerBoxWidth + 8) / 4 * factor
    Generation.setTilesArea({{x_ - 1, yCenter - 1}, {x_ + 1, yCenter + 1}}, "landfill")
    local tank = surface.create_entity{name = "giant-storage-tank", position = {x_, yCenter}, force = "player"}
    tank.destructible = false
    tank.minable = false
    tank.rotatable = false

    global.boxs[team .. "~" .. player.name] = {
        center = {xCenter, yCenter},
        pendingIncome = {iron = 0, copper = 0, coal = 0, stone = 0, oil = 0},
        incomePercentage = {iron = .2, copper = .2, coal = .2, stone = .2, oil = .2},
    }
    player.teleport(Utils.getValidPosition({xCenter - 33 * factor, yCenter}))

    local nSubstation = math.ceil(playerBoxMaxSize / 64)
    local offset = (math.ceil(playerBoxMaxSize / 64) * 64 - playerBoxMaxSize) / 2
    for i = 1, nSubstation do
        local xPos = xCenter + (-1)^i * math.floor(i / 2) * 64
        if xPos - 64 < xCenter - playerBoxMaxSize / 2 then
            xPos = xPos + offset
        elseif xPos + 64 > xCenter + playerBoxMaxSize / 2 then
            xPos = xPos - offset + 1
        end
        for j = 1, nSubstation do
            local yPos = yCenter + (-1)^j * math.floor(j / 2) * 64
            if yPos - 64 < yCenter - playerBoxMaxSize / 2 then
                yPos = yPos + offset
            elseif yPos + 64 > yCenter + playerBoxMaxSize / 2 then
                yPos = yPos - offset + 1
            end
            local name = "invisible-giant-substation"
            if i == 1 and j == 1 then
                name = "giant-substation"
            end
            surface.create_entity{name = name, force = "player", position = {xPos, yPos}}
        end
    end
end

---@param area BoundingBox @https://lua-api.factorio.com/latest/Concepts.html#BoundingBox
---@param tileName string @tile's prototype name
function Generation.setTilesArea(area, tileName)
    local tiles = {}

    for x = 0, area[2][1] - area[1][1], 1 do
        for y = 0, area[2][2] - area[1][2], 1 do
            table.insert(tiles, {position = {area[1][1] + x, area[1][2] + y}, name = tileName})
        end
    end

    game.surfaces[global.gameSurface].set_tiles(tiles)
end


---creates a border of void around zones (like boxs and spawner zones), center must be a map position, width and height is the size of the side of the inner square of the border
---@param center MapPosition @https://lua-api.factorio.com/latest/concepts.html#MapPosition
---@param width number
---@param height number
function Generation.createBorder(center, width, height)
    local tiles = {}

    for x = 0, width + _CONFIG.generation.bordersWidth * 2, 1 do
        for y = 0, height + _CONFIG.generation.bordersWidth * 2, 1 do
            if x < _CONFIG.generation.bordersWidth or x - _CONFIG.generation.bordersWidth - width > 0 or
            y < _CONFIG.generation.bordersWidth or y - _CONFIG.generation.bordersWidth - height > 0 then
                local pos = {center[1] + x - width / 2 - _CONFIG.generation.bordersWidth, center[2] + y - height / 2 - _CONFIG.generation.bordersWidth}
                local tile = game.surfaces[global.gameSurface].get_tile(pos[1], pos[2])
                if tile.name == "water" or tile.name == "deepwater" then
                    table.insert(tiles, {position = pos, name = "out-of-map"})
                end
            end
        end
    end

    game.surfaces[global.gameSurface].set_tiles(tiles)
end

---generates a new linked chest
---@param force string @force name
---@param number number @how manyth chest is it
function Generation.addLinkedChest(force, number)
    local surface = game.surfaces[global.gameSurface]
    local team = Utils.getTeamFromForce(force)
    local factor = Utils.getSideFactor(team)
    local box = global.boxs[force].center

    local x = box[1] + (_CONFIG.generation.playerBoxWidth / 2 - 0.5) * factor + (factor - 1) / -2
    local y = box[2] + (-1) ^ number * math.ceil(number / 2) * 10 + 0.5
    local chest = surface.create_entity{name = "linked-chest", position = {x, y}, force = force}

    chest.destructible = false
    chest.minable = false
    chest.rotatable = false

    chest.link_id = game.forces[force].index

    local blocker = surface.find_entity("linked-chest-blocker", {x, y})
    blocker.destroy()
end

return Generation