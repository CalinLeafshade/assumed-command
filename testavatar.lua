
require('avatar')

TestAvatar = Class("TestAvatar", Avatar)

function TestAvatar:update(dt)
	Avatar.update(self,dt)
	if self:getStatus() == "Idle" then
		self:walk(math.random(self.ship:getWidth()), math.random(self.ship:getHeight()))
	end
end