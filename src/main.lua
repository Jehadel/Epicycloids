--[[

Draw and display epicycloides curves 
to play with polar coordinates

]]

local SCREEN_W = 800
local SCREEN_H = 600

local theta = 0
local radius1 = 20
local radius2 = 40
local radius_sum = radius1 + radius2
local pace = 5

-- polar coordinate conversion
local centerX = (radius1 + radius2) * math.cos(theta) 
local centerY = (radius1 + radius2) * math.sin(theta) 

-- epicycloid table
local epi = {
  radius_sum * math.cos(theta) - radius2 * math.cos(radius_sum/radius2 * theta) + SCREEN_W/2,
  radius_sum * math.sin(theta) - radius2 * math.sin(radius_sum/radius2 * theta) + SCREEN_H/2
}

-- control states
local hide_instructions = false
local reset = false
local draw_epicycloid = true


function love.load()

    love.window.setMode(SCREEN_W, SCREEN_H)
    love.window.setTitle('Epicycloid demo')

end


function love.update(dt)

  if reset == true then
    reset = false
    epi = {
      radius_sum * math.cos(theta) - radius2 * math.cos(radius_sum/radius2 * theta) + SCREEN_W/2,
      radius_sum * math.sin(theta) - radius2 * math.sin(radius_sum/radius2 * theta) + SCREEN_H/2
    }
  end

  theta = theta + dt * 2 
  radius_sum = radius1 + radius2
  centerX = (radius_sum) * math.cos(theta) + SCREEN_W/2
  centerY = (radius_sum) * math.sin(theta) + SCREEN_H/2
  endX = radius_sum * math.cos(theta) - radius2 * math.cos(radius_sum/radius2 * theta) + SCREEN_W/2
  table.insert(epi, endX)
  endY = radius_sum * math.sin(theta) - radius2 * math.sin(radius_sum/radius2 * theta) + SCREEN_H/2
  table.insert(epi, endY)

end


function love.draw()

  -- display instructions or not : instructions are hidden if hide_instructions == true
  if hide_instructions == false then
    love.graphics.print('Controls:', 10, 10)
    love.graphics.print('up/down - Modify first circle radius', 10, 30)
    love.graphics.print('left/right - Modify second circle radius', 10, 50)
    love.graphics.print('h - Hide/display those instructions', 10, 70)
    love.graphics.print('r - Reset the epicycloid drawing (useful when you modify any radius)', 10, 90)
    love.graphics.print('e - Interrupt/enable the epicycloid drawing', 10, 110)
    love.graphics.print('ESC - Quit', 10, 130)
  end

  -- draw curves
  love.graphics.circle('line', SCREEN_W/2, SCREEN_H/2, radius1)    
  love.graphics.circle('line', centerX, centerY, radius2)
  love.graphics.line(centerX, centerY, endX, endY)
  love.graphics.setColor(1, 0, 0)
  love.graphics.circle('fill', endX, endY, 5)
  if draw_epicycloid == true then
    love.graphics.line(epi)
  end
  love.graphics.setColor(1, 1, 1)

  -- display radiuses
  love.graphics.print('Radius 1: ' .. tostring(radius1), 10, SCREEN_H - 30)
  love.graphics.print('Radius 2: ' .. tostring(radius2), 100, SCREEN_H - 30)

end


function love.keypressed(key)

  if key == 'escape' then
    love.event.quit()
  end

  if key == 'h' then
    hide_instructions = not hide_instructions
  end

  if key == 'e' then
    draw_epicycloid = not draw_epicycloid 
  end

  if key == 'r' then
    reset = true
  end

  if key == 'up' then
    radius1 = radius1 + pace
  end

  if key == 'down' then
    if radius1 > pace then
      radius1 = radius1 - pace 
    end
  end

  if key == 'left' then
    if radius2 > pace then
      radius2 = radius2 - pace
    end
  end

  if key == 'right' then
    radius2 = radius2 + pace
  end

end
