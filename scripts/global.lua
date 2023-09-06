local Global = {}

function Global.init()              -- ness - define all global variables
    global.gameSurface = "game0"    -- ness - game surface name, alternates between "game0" and "game1"
    global.bluePlayers = {}         -- ness - blue team player list (blue team is on the left)
    global.blueBoxN = 0             -- ness - number of player box which were created in the blue side
    global.redPlayers = {}          -- ness - red team player list (red team is on the right)
    global.redBoxN = 0              -- ness - number of player box which were created in the red side
    global.boxs = {}                --[[ ness - a table with k = force name and v = {center = box center, 
                                    pendingIncome = pending income {iron, copper, coal, stone, oil},
                                    incomePercentage = how many percentage of the income goes where {iron, copper, coal, stone, oil}}]]
    global.specPlayers = {}         -- ness - list of spectators
    global.isGameRunning = false
    global.gameStratingTick = -1    -- ness - egals to -1 if the game is not started
    global.gameEndingTick = -1      -- ness - egals to -1 if the game is not finished
    global.winner = ""              -- ness - winner of the last game ("blue" or "red"). "" if it's the first match of the save
    global.forceMapReset = false    -- ness - used in force-map-reset command
    global.blueSpyingEnd = 0        -- ness - blue can spy red if this < game.tick
    global.redSpyingEnd = 0         -- ness - red can spy blue if this < game.tick
end

return Global