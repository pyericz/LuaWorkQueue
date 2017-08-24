local Object = require "object"
local Deque = require "deque"

local WorkQueue = Object:extend()
WorkQueue.FIFO = 1  -- first in first out
WorkQueue.LIFO = 2  -- last in first out

function WorkQueue:construct()
    self.workList = Deque:new()
    self.queueType = WorkQueue.FIFO
end

function WorkQueue:setCallback(callback)
    self.callback = callback
end

function WorkQueue:addWork(work)
    self.workList:pushRight(work)
end

function WorkQueue:setQueueType(queueType)
    if queueType == WorkQueue.FIFO or queueType == WorkQueue.LIFO then
        self.queueType = queueType
    end
end

function WorkQueue:getQueueType()
    return self.queueType
end

function WorkQueue:_startWork(workObj, finishCallback)
    local function callback()
        workObj:workEnd()
        if type(finishCallback) == "function" then
            finishCallback()
        end
    end
    workObj:workBegin()
    workObj:work(callback)
end

function WorkQueue:start()
    if self.workList:isEmpty() then
        if type(self.callback) == "function" then
            self.callback()
        end
        return
    end

    local work = nil
    if self:getQueueType() == WorkQueue.FIFO then
        work = self.workList:popLeft()
    else
        work = self.workList:popRight()
    end

    local function callback()
        self:start()
    end

    if work then
        self:_startWork(work, callback)
    else
        callback()
    end

end

return WorkQueue
