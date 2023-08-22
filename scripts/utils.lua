Utils = {}

function Utils.error(err)
    game.print(err, {r = 1, b = 0, g = 0, a = 1})
end

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

function Utils.indexOf(array, value)    -- ness - returns the index of the first element which is egal to value. returns nil if no element is egal to value
    for k, v in pairs(array) do
        if v == value then
            return k
        end
    end
    return nil
end

function Utils.removeByValue(array, value)  -- ness - removes the first element which is egal to value and returns its index. does nothing if no element is egal to value and returns nil
    local index = Utils.indexOf(array, value)
    if index == nil then
        return nil
    end
    table.remove(array, index)
    return index
end

function Utils.getValidPosition(pos, radius)    -- ness - returns the closest non colliding position for a character
    if not radius then
        radius = 0
    end
    return game.surfaces[global.gameSurface].find_non_colliding_position("character", pos, radius, 0.01)
end

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

function Utils.getSideFactor(team)
    if team == "blue" then return -1
    elseif team == "red" then return 1
    elseif team == "spec" then return 0 end
end

function Utils.getTeamFromForce(force)
    return Utils.splitString(force, "~")[1]
end

function Utils.getGameTimer()
    if global.isGameRunning then
        return game.tick - global.gameStratingTick
    else
        return global.gameEndingTick - global.gameStratingTick
    end
end

function Utils.getGameTimerInSMinH()
    local gameTimer = Utils.getGameTimer()
    local s = math.floor(gameTimer / 60 % 60)
    local min = math.floor(gameTimer / 3600 % 60)
    local h = math.floor(gameTimer / 216000)
    return {s = s, min = min, h = h}
end

function Utils.ceilNthDecimal(x, n)
    local n_ = 10 ^ n
    return math.ceil(x * n_) / n_
end

function Utils.getResetTimer()
    if global.gameEndingTick == -1 then
        return math.huge
    else
        return global.gameEndingTick - game.tick + 3600
    end
end

function Utils.resetGlobalTable(name)
    for k, v in pairs(global[name]) do
        global[name][k] = nil
    end
end

return Utils