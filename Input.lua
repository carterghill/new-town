Keyboard = {
    up = "w",
    down = "s",
    left = "a",
    right = "d"
}

function Keyboard:new(up, down, left, right)
    local k = setmetatable( { Keyboard }, { __index = self } )
    k.up = up or "w"
    k.left = left or "a"
    k.down = down or "s"
    k.right = right or "d"
    return k
end

Input = {
    controller = {},
    keyboard = Keyboard
}

function Input:new(keyboard, controller)
    local i = setmetatable( { Input }, { __index = self } )
    i.controller = controller
    i.keyboard = keyboard
    return i
end