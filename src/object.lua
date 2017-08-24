local Object = {}

function Object:construct()
end

function Object:extend()
    local class = {}
    setmetatable(class, self)
    self.__index = self
    return class
end

function Object:new()
    local obj = self:extend()
    obj:construct()
    return obj
end

return Object
