Class = require("hump.class")

EntityManager = Class {
	name = "EntityManager";
	init = function (self)
		self.entities = {}
		self.free = {}
	end;

	update = function (self, dt)
		for i=1, #self.entities do
			local e = self.entities[i]
			if e ~= nil then
				e:update(dt)
			end
		end
	end;

	render = function (self, dt)
		for i=1, #self.entities do
			local e = self.entities[i]
			if e ~= nil then
				e:draw(dt)
			end
		end
	end;

	add = function (self, entity)
		if #self.free > 0 then
			local pos = table.remove(self.free, #self.free)
			table.insert(self.entities, pos, entity)
			return pos
		end
		table.insert(self.entities, entity)
		return #self.entities
	end;

	remove = function (self, id)
		if type(id) ~= "number" then
			return false
		end
		self.entities[id] = nil
		table.insert(self.free, id)
		return true
	end;
}
