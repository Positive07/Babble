local path = (...):gsub('%.init$', '')

local Components = {
   link   = require(path..".link"),
   script = require(path..".script"),
   setter = require(path..".setter"),
   text   = require(path..".text"),
   wait   = require(path..".wait"),
   clear  = require(path..".clear")
}

return Components
