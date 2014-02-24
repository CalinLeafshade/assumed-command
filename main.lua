-- main.lua
io.stdout:setvbuf("no")

Class = require('lib.middleclass')
require('goo')
require('goo.testgui')

function love.load()
	TestGUI()
end

function love.update()
	Goo.update(dt)
end

function love.draw()
	Goo.draw()
end

function love.mousepressed(x,y,b)
	Goo.mouseDown(x,y,b)
end

function love.mousereleased(x,y,b)
	Goo.mouseUp(x,y,b)
end
