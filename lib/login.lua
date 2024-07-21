local pgmoon = require "pgmoon"

local M = {
    -- PostgreSQL connection details
    conn = nil,
}

function M.init(db_info)
    local db, err = pgmoon.new(db_info)
    if not db or err then
        ngx.say("Failed to connect to PostgreSQL: ", err)
        return
    end

    M.conn = db
end

function M.authenticate(auth_header)
    -- Parse the Authorization header
    local user, password = auth_header:match("Basic %((.-):(.-)%)")
    if not user or not password then
        return false, nil, "Invalid Authorization header"
    end

    -- Fetch user from database
    local query = "SELECT * FROM users WHERE username = $1 AND password = crypt($2, password)"
    local res, err = M.conn:query(query, {user, password})
    if err or not res[1] then
        return false, nil, err
    end

    return true, res[1].username
end

return M