
Ship = Class("Ship")

function Ship:initialize(name)
	--load map
	self.map = {
			{ 0,0,0,0,0,0,0,0,0,0},
			{ 0,1,1,1,1,1,1,1,1,0},
			{ 0,1,2,2,2,2,2,2,1,0},
			{ 0,1,2,2,2,2,2,2,1,0},
			{ 0,1,2,2,2,2,2,2,1,0},
			{ 0,1,2,2,2,2,2,2,1,0},
			{ 0,1,2,2,2,2,2,2,1,0},
			{ 0,1,2,2,2,2,2,2,1,0},
			{ 0,1,1,1,2,2,1,1,1,0},
			{ 0,0,0,1,2,2,1,0,0,0},
			{ 0,0,0,1,2,2,1,0,0,0},
			{ 0,0,0,1,2,2,1,0,0,0},
			{ 0,0,0,1,2,2,1,0,0,0},
			{ 0,1,1,1,2,2,1,1,1,0},
			{ 0,1,2,2,2,2,2,2,1,0},
			{ 0,1,2,2,2,2,2,2,1,0},
			{ 0,1,2,2,2,2,2,2,1,0},
			{ 0,1,2,2,2,2,2,2,1,0},
			{ 0,1,2,2,2,2,2,2,1,0},
			{ 0,1,1,1,1,1,1,1,1,0},
			{ 0,0,0,0,0,0,0,0,0,0}
		}
	self.objects = {}
	self:genPathNodes()
end

function Ship:genPathNodes()
	local nodes = {}
	self.nodeLookUp = {}
	for x = 1, self:getWidth() do
		self.nodeLookUp[x] = {}
		for y = 1, self:getHeight() do
			local t = self.map[x][y]
			print(x,y,t)
			if t > 1 then
				local n = {x =  x, y = y, t = t}
				table.insert(nodes, n)
				self.nodeLookUp[x][y] = #nodes
			end
		end
	end
	self.pathNodes = nodes
end

function Ship:getNearestPathNode(x,y)
	return self.pathNodes[math.floor(x/16)] and self.pathNodes[math.floor(x/16)][math.floor(y/16)]
end

function Ship:getPathNodeIndex(x,y)
	return self.nodeLookUp[x] and self.nodeLookUp[x][y]
end

function Ship:getPathNode(x,y)
	local index = self.nodeLookUp[x] and self.nodeLookUp[x][y]
	return self.pathNodes[index]
end

function Ship:objectAt(x,y)
	for i,v in pairs(self.objects) do
		if v:contains(x,y) then
			return v
		end
	end
end

function Ship:getRoute(pather,x,y)
	TLpath.findPath(pather, self.nodeLookUp[x][y])
end

function Ship:tileToWorld(x,y)
	return x * 16 + 8, y * 16 + 8
end

function Ship:worldToTile(x,y)
	return math.floor(x/16), math.floor(y/16)
end

function Ship:add(obj)
	self.objects[obj] = obj
end

function Ship:getWidth()
	return #self.map
end

function Ship:getHeight()
	return #self.map[1]
end

function Ship:sane(x,y)
	return x >= 0 and x < self:getWidth() and y >= 0 and y < self:getHeight()
end

function Ship:isWalkable(x,y)
	if not self:sane(x,y) then return false end
	return self.map[x][y] == 2
end

function Ship:update(dt)
	for i,v in pairs(self.objects) do
		v:update(dt)
	end
end

function Ship:draw()
	for x = 1, self:getWidth() do
		for y = 1, self:getHeight() do
			local t = self.map[x][y]
			love.graphics.setColor(t == 1 and {255,255,255} or {128,128,128})
			if t > 0 then
				love.graphics.rectangle("fill", x * 16, y * 16, 16,16)
			end
		end
	end
	for i,v in pairs(self.objects) do
		v:draw()
	end
end