Utils = {}

---print a message in red
---@param err string
function Utils.error(err)
    game.print(err, {r = 1, b = 0, g = 0, a = 1})
end

---splits the given string in an array of strings
---@param inputstr string
---@param sep string
---@return table
function Utils.splitString(inputstr, sep)
    if sep == nil then
       sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
       table.insert(t, str)
    end
    return t
end

---returns the index of the first element which is egal to value. returns nil if no element is egal to values
---@param array array
---@param value any
---@return number|nil
function Utils.indexOf(array, value)
    for k, v in pairs(array) do
        if v == value then
            return k
        end
    end
    return nil
end

---removes the first element which is egal to value and returns its index. does nothing if no element is egal to value and returns nil
---@param array array
---@param value any
---@return number|nil
function Utils.removeByValue(array, value)
    local index = Utils.indexOf(array, value)
    if index == nil then
        return nil
    end
    table.remove(array, index)
    return index
end

---returns the closest non colliding position for a character, returns nil if no such position has been found
---@param pos MapPosition @https://lua-api.factorio.com/latest/concepts.html#MapPosition
---@param radius? number
---@return MapPosition|nil @https://lua-api.factorio.com/latest/concepts.html#MapPosition
function Utils.getValidPosition(pos, radius)
    if not radius then
        radius = 0
    end
    return game.surfaces[global.gameSurface].find_non_colliding_position("character", pos, radius, 0.01)
end

---converts an array to a string, only used for debuging, since lua does not allow to print array
---@param o array
---@return string
function Utils.dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. Utils.dump(v) .. ','
        end
        return s .. '} '
    else
       return tostring(o)
    end
end

---used to transform a MapPosition to avoid useless calculation
---@param team "blue"|"red"|"spec"
---@return integer
function Utils.getSideFactor(team)
    if team == "blue" then return -1
    elseif team == "red" then return 1
    else return 0 end
end

---force name format: "<force's player name>~<team name>", returns only the team name
---@param force string @force name
---@return string
function Utils.getTeamFromForce(force)
    return Utils.splitString(force, "~")[1]
end

---returns the game timer in ticks if is game is running, returns how long the last game has lasted in tick if the game is finished (1 tick = 1s/60)
---@return number
function Utils.getGameTimer()
    if global.isGameRunning then
        return game.tick - global.gameStratingTick
    else
        return global.gameEndingTick - global.gameStratingTick
    end
end

---returns the game timer in s/min/h if is game is running, returns how long the last game has lasted in s/min/h if the game is finished (1 tick = 1s/60)
---@return table
function Utils.getGameTimerInSMinH()
    local gameTimer = Utils.getGameTimer()
    local s = math.floor(gameTimer / 60 % 60)
    local min = math.floor(gameTimer / 3600 % 60)
    local h = math.floor(gameTimer / 216000)
    return {s = s, min = min, h = h}
end

---ceil x to the nth decimal
---@param x number
---@param n number
---@return number
function Utils.ceilNthDecimal(x, n)
    local n_ = 10 ^ n
    return math.ceil(x * n_) / n_
end

---@return number
function Utils.getResetTimer()
    if global.gameEndingTick == -1 then
        return math.huge
    else
        return global.gameEndingTick - game.tick + 3600
    end
end

---clears all global tables content
---@param name string|number
function Utils.resetGlobalTable(name)
    for k, v in pairs(global[name]) do
        global[name][k] = nil
    end
end

---@param table table
---@param key string
---@return boolean
function Utils.isKeyDefined(table, key)
    if table[key] then
        return true
    else
        return false
    end
end

---copy given table
---@param table table
function Utils.shallowcopy(table)
    local copy = {}
    for k, v in pairs(table) do
        copy[k] = v
    end
    return copy
end

---checks if any value of an array passes the function
---@param table table
---@param f function
---@return nil|number
function Utils.checkTableValuesCondition(table, f)
    for k, v in pairs(table) do
        if f(v) then
            return k
        end
    end
    return nil
end

return Utils
