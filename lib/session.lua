local redis = require "resty.redis"
local shared = require "ngx.shared"

local M = {}

function M.create(shared_dict, user)
    local red = redis.new()
    local ok, err = red:connect("127.0.0.1", 6379)
    if not ok then
        return nil, "failed to connect to Redis: " .. err
    end

    local session_id, err = red:incr("session_counter")
    if not session_id then
        red:set_keepalive()
        return nil, "failed to generate session ID: " .. err
    end

    local data = {username = user}
    local ok, err = red:set(session_id, cjson.encode(data))
    red:set_keepalive()

    if not ok then
        return nil, "failed to set session data: " .. err
    end

    return session_id
end

function M.get(shared_dict, session_id)
    local red = redis.new()
    local ok, err = red:connect("127.0.0.1", 6379)
    if not ok then
        return nil, "failed to connect to Redis: " .. err
    end

    local data, err = red:get(session_id)
    red:set_keepalive()

    if not data then
        return nil, "session not found"
    end

    return cjson.decode(data)
end

return M