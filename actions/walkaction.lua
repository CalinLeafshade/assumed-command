
require('vector')
require('action')
require('path')

WalkAction = Class("WalkAction", Action)

function WalkAction:initialize(avatar,x,y)
	local tx,ty = avatar:getTile()
	local path = Path(avatar.ship,tx,ty,x,y)
	self.path = path
	Action.initialize(self,avatar,function()
				while path:waiting() do
					coroutine.yield()
				end
				local speed = 0
				if not path:unreachable() then
					path:optimize()
					while path:peek() do
						local nextNode = path:next()
						local vec = Vector(avatar.ship:tileToWorld(nextNode.x, nextNode.y))
						while vec:dist(avatar.position) > 2 do
							local dt = coroutine.yield()
							avatar.position = avatar.position + (vec - avatar.position):normalized() * dt * speed
							speed = math.min(speed + dt * 50, avatar:getSpeed())
						end
					end
				else
					print(x,y,"unreachable")
				end
			
			end)
end

function WalkAction:draw()
	if self.path then
		self.path:draw()
	end
end