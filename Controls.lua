Controls = {
    up = false,
    down = false,
    left = false,
    right = false
}

function Controls:new()
    local i = setmetatable( {Controls}, { __index = self } )
    return i
end