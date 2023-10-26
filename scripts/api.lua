local json = require "json"

API = {}

API.requests = {}
API.token_ = 0

---used to send HTTP request to the api (https://github.com/ness056/factory-fight-API)
---@param method "GET"|"POST"|"PATCH"|"DELETE"
---@param uri string
---@param body table
---@param fn function
function API.request(method, uri, body, fn)
    API.token_ = API.token_ + 1
    table.insert(API.requests, {token = API.token_, method = method, uri = uri, body = body, callback = fn})

    game.write_file("API/request.txt", API.token_ .. "~" .. method .. "~" .. uri .. "~" .. json.encode(body) .. "\n", true, 0)
end

return API