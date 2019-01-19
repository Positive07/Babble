local SubPath = (...):gsub('%.[^%.]+%.[^%.]+$', '')

local Class = require(SubPath..".class")

local Print = Class()
function Print:init(node, str)
   self.node = node
   self.str  = str
end

function Print:update()
   print(self.str)

   return true
end

return Print
