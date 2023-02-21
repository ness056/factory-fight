local Global = {}

function Global.init()
    global.gameSurface = "game0"    -- ness - game surface name, alternates between "game0" and "game1"
    global.bluePlayers = {}         -- ness - blue team player list (blue team is on the left)
    global.blueBoxN = 0             -- ness - number of player box which were created in the blue side
    global.redPlayers = {}          -- ness - red team player list (red team is on the right)
    global.redBoxN = 0              -- ness - number of player box which were created in the red side
    global.boxs = {}                -- ness - a table with k = player name and v = box center
    global.specPlayers = {}         -- ness - list of spectators
    global.gameStarted = false      -- ness - set to true when game starts
end

return Global