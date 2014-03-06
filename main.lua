
require('util')

-- main.lua
io.stdout:setvbuf("no")

Class = require('lib.middleclass')
require('goo')
require('goo.testgui')
require('ship')
require('avatar')
require('statemanager')
require('gamemain')

function love.load()
	manager = StateManager()
	TestGUI(0,0)
	TestGUI(300,300)
	manager:push(GameMain)
end

function love.update(dt)
	manager:update(dt)
	Goo.update(dt)
end

function love.draw()
	manager:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.print(love.timer.getFPS(),5,5)
	Goo.draw()
end

function love.mousepressed(x,y,b)
	if not Goo.mouseDown(x,y,b) then
		manager:mouseDown(x,y,b)
	end
end

function love.mousereleased(x,y,b)
	if not Goo.mouseUp(x,y,b) then
		manager:mouseUp(x,y,b)
	end
end

function love.keypressed(key)
	if key == "q" then
		love.event.push("quit")
	end
	Goo.keyDown(key)
end

function love.keyreleased(key)
	Goo.keyUp(key)
end

function love.textinput(text)
	Goo.textEntry(text)
end
