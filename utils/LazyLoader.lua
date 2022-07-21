-- Simple object that takes a require path and lazily loads modules from it
-- If a module returns a function, it runs it with 


local LazyLoader = {}
LazyLoader.__index = function(self, k)
    local static = LazyLoader[k]
    if static then
        return static
    end

    local value = require(self._path .. "." .. k)
    if type(value) == "function" then
        value = value(unpack(self._args))
    end

    self[k] = value
    return value
end


function LazyLoader.new(path, ...)
    local self = setmetatable({
        _path = path,
        _args = { ... }
    }, LazyLoader)

    return self
end


return LazyLoader