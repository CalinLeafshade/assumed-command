
Action = Class("Action")

function Action:initialize(avatar, fn)
	self.avatar = avatar
	if fn then
		self.co = coroutine.create(fn)
	end
end

function Action:update(dt)
	local result, err = coroutine.resume(self.co, dt)
	if not result then error(err) end
	if coroutine.status(self.co) == "dead" then
		self.dead = true
	end
end

function Action:draw() end