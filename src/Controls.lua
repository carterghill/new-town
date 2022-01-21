Controls = {
    up = false,
    down = false,
    left = false,
    right = false
}

function Controls:new()
    local c = setmetatable( {Controls}, { __index = self } )
    return c
end