return {
    generation = {
        specIslandSize = 16,                    -- ness - radius in tiles
        spawnerZoneHeight = 250,                -- ness - height in tiles
        spawnerZoneWidth = 250,                 -- ness - width in tiles
        spawnerZoneMaxHeight = 500,
        spawnerZoneMaxWidth = 500,
        spawnerZoneDistanceFromCenterX = 200,   -- ness - distance from the 0,0 to the start of the spawner zone
        playerBoxHeight = 100,
        playerBoxWidth = 100,
        playerBoxMaxHeight = 150,
        playerBoxMaxWidth = 150,
        playerNBoxPerLine = 3,
        bitterPathWidth = 20,
        bitterPathDistanceFromCenterY = 80,     -- ness - distance from the 0,0 to the start of the bitter paths
        bordersWidth = 15                       -- ness - width of the void borders which separate differents zones (like the spawner zones or the boxs)
    },
    income = {
        oilIncomeMult = 100,
        smallValue = 10,
        mediumValue = 40,
        bigValue = 150,
        behemothValue = 2000,
        base = 50
    }
}