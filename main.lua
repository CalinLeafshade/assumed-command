
-- main.lua
io.stdout:setvbuf("no")

Class = require('lib.middleclass')
require('goo')
require('goo.testgui')

function love.load()
	TestGUI(0,0)
	TestGUI(300,300)
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

function love.keypressed(key)
	Goo.keyDown(key)
end

function love.keyreleased(key)
	Goo.keyUp(key)
end

function love.textinput(text)
	Goo.textEntry(text)
end
