local SubPath = (...):gsub('%.[^%.]+%.[^%.]+$', '')

local Class = require(SubPath..".class")

local Clear = Class()
function Clear:init(node)
   self.node = node
end

function Clear:update()
   self.node.parent:clear()

   return true
end

return Clear
