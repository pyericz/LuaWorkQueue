local Object = require "object"
local Work = require "work"
local WorkQueue = require "work_queue"
local Deque = require "deque"

local test = Work:extend()

function test:setId(id)
    self.id = id
end

function test:getId()
    return self.id
end

function test:workBegin()
    print("work begin: ", self.id)
end

function test:workEnd()
    print("work end: ", self.id)
    print("=============================")
end

function test:work(callback)
    -- do the dirty work. As an example, the work is to print the test id
    print("working ... ", self.id)
    callback()
end

function main()
    local function finishCallback()
        print("all done")
    end
    local workQueue = WorkQueue:new()
    workQueue:setQueueType(WorkQueue.FIFO)
    workQueue:setCallback(finishCallback)
    for i=1, 10 do
        local work = test:new()
        work:setId(i)
        print("add work", work:getId())
        workQueue:addWork(work)
    end
    print("================ work queue start ================")
    workQueue:start()
end

main()
