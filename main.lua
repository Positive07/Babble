local Babble = require("babble")

local font  = love.graphics.newFont("LCD_Solid.ttf", 24)

local d = Babble.dialogue()
   :addNode("start", function (node)
      return node
         :wait(2)
         :text("We can do a sine wave.\n", {explicit = true, font = font})
         :text(" \n")
         :text("Or just shake in fear.\n", {explicit = true, font = font})
         :text(" \n")
         :text("Underline the lines.\n", {font = font, underline = true})
         :text("Strikethrough through the strike.\n", {font = font, strikethrough = true})
         :text("Or some kind of rainbow effect.", {explicit = true, font = font})
         :text(" \n"):wait(0.5)
         :text("Or all at the same time!!!", {font = font, explicit = true, strikethrough = true, underline = true})
   end)

   :switch("start")

local r1, r2 =  0          ,  1.0
local g1, g2 = -math.sqrt( 3 )/2, -0.5
local b1, b2 =  math.sqrt( 3 )/2, -0.5

local function HSVToRGB( h, s, v, a )
   h=h+math.pi/2
   local h1, h2 = math.cos( h ), math.sin( h )

   local r = h1*r1 + h2*r2
   local g = h1*g1 + h2*g2
   local b = h1*b1 + h2*b2

   g = g + (1-g)*s
   b = b + (1-b)*s

   r,g,b = r*v, g*v, b*v

   return r*255, g*255, b*255, (a or 1) * 255
end

local t = 0

function love.update(dt)
   d:update(dt)

   if d.contents[1] then
      for i = 1, #d.contents[1].text do
         d.contents[1]:setModifier(i, "offset", {
            0,
            math.sin((love.timer.getTime() * 8) + (i)) * 3,
         })
      end
   end

   if d.contents[3] then
      for i = 1, #d.contents[3].text do
         d.contents[3]:setModifier(i, "offset", {
            love.math.random(-1, 1),
            love.math.random(-1, 1),
         })
      end
   end

   t = t + dt

   if d.contents[7] then
      for i = 1, #d.contents[7].text do
         local r, g, b = HSVToRGB(((i * 0.25) + (t * 2.5)) % (math.pi*2), 0, 1)
         local c = {r, g, b}

         d.contents[7]:setModifier(i, "color", c)
      end
   end

   if d.contents[9] then
      for i = 1, #d.contents[9].text do
         local r, g, b = HSVToRGB(((i * 0.1) + (t * 7)) % (math.pi*2), 0, 1)
         local c = {r, g, b}

         d.contents[9]:setModifier(i, "color", c)
         d.contents[9]:setModifier(i, "offset", {
            love.math.random(-2, 2),
            math.sin((love.timer.getTime() * 8) + (i)) * 5 + love.math.random(-2, 2),
         })
      end
   end
end

function love.draw()
   love.graphics.rectangle("line", 10, 460, 620, 170)
   love.graphics.setFont(font)
   d:draw(20, 470, 600, 150, false)

   local info = love.graphics.getStats()
   love.graphics.print(info.drawcalls)
end

function love.keypressed(key)
   if key == "s" then
      d:skip()
   end

   if key == "c" then
      d:clear()
      d:switch("start")
   end
end
