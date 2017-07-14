function love.load()
   windowX, windowY, _ = love.window.getMode()
   local windowCenter = { x = windowX / 2, y = windowY / 2 }
   
   ang = 0
   collided = false
   image = love.graphics.newImage("assets/nyan-cat-uhaul-trailer.png")
   bang = love.graphics.newImage("assets/bang.png")

   imageWidth, imageHeight = image:getWidth(), image:getHeight()
   coordinate = {
      x = windowCenter.x - imageWidth/2,
      y = windowCenter.y - imageHeight/2
   }

   bg = love.graphics.newCanvas()
   bg:renderTo(function()
	 bgImage = love.graphics.newImage("assets/nebula.jpg")
	 love.graphics.draw(bgImage, 0, 0)
   end)
end

function love.update(dt)
   
   local rightBound = love.graphics.getWidth() - 15
   
   ang = ang + math.pi/25.0
   coordinate.y = coordinate.y + math.sin(ang) * 5
   
   if love.keyboard.isDown("right") then
      if collided then
	 coordinate.x = rightBound - imageWidth
      else 
	 coordinate.x = coordinate.x + 500 * dt
      end
   elseif love.keyboard.isDown("left") then
      coordinate.x = coordinate.x - 500 * dt
   end
   
   if coordinate.x + imageWidth >= rightBound then
      collided = true
   else
      collided = false
   end
end

function love.draw()
   love.graphics.draw(bg, 0, 0)
   if collided then
      love.graphics.draw(bang, windowX / 2 - 100, coordinate.y - imageHeight + 10, 0, 0.8)
   else
      love.graphics.clear()
      love.graphics.draw(bg, 0, 0)
   end
   
   love.graphics.print("X: " .. coordinate.x + imageWidth, 20, 20, 0, 2)
   love.graphics.print("window: " .. love.graphics.getWidth(), 20, 40, 0, 2)
   love.graphics.print("collided?: " .. tostring(collided), 20, 60, 0, 2)
   love.graphics.draw(image, coordinate.x, coordinate.y)
end
