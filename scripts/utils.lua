local Utils = {}

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
    return game.surfaces[global.gameSurface].find_non_colliding_position("character", pos, radius, 0.01)
end

return Utils