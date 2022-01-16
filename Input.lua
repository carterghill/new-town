Input = {
    up = false,
    down = false,
    left = false,
    right = false
}

function Input:new()
    local i = setmetatable( {Input}, { __index = self } )
    print(i)
    return i
end