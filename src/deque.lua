local Object = require "object"
local Deque = Object:extend{}

function Deque:construct()
    self.first = 0
    self.last = -1
    self.list = {}
end

function Deque:length()
    return self.last - self.first + 1
end

function Deque:pushLeft(value)
    local first = self.first - 1
    self.first = first
    self.list[first] = value
end

function Deque:pushRight(value)
    local last = self.last + 1
    self.last = last
    self.list[last] = value
end

function Deque:isEmpty()
    return self.first > self.last
end

function Deque:popLeft()
    assert(not self:isEmpty(), "Deque is empty")
    local list = self.list
    local first = self.first
    local value = list[first]
    list[first] = nil
    self.first = first + 1
    return value
end

function Deque:popRight()
    assert(not self:isEmpty(), "Deque is empty")
    local list = self.list
    local last = self.last
    local value = list[last]
    list[last] = nil
    self.last = last - 1
    return value
end

function Deque:getLeft()
    assert(not self:isEmpty(), "Deque is empty")
    return self.list[self.first]
end

function Deque:getRight()
    assert(not self:isEmpty(), "Deque is empty")
    return self.list[self.last]
end

return Deque
