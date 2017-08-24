local Object = require "object"
local Work = Object:extend{}

function Work:workBegin()
end

function Work:work(callback)
    error("work function not defined")
end

function Work:workEnd()
end

return Work
