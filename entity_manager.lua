Class = require("hump.class")

EntityManager = Class {
	name = "EntityManager";
	init = function (self, _)
		print("in awdawdawd")
		self.entities = {}
	end;

	update = function (self, dt)
		local i = 1
		local remove = {}
		for k, v in pairs(self.entities) do
			if v == false then
				table.insert(remove, i)
			end
			if v == true and k:update(dt) == true then
				table.remove(remove, i)
			end
			i = i + 1
		end

		for i, v in ipairs(remove) do
			table.remove(self.entities, v)
		end
	end;

	render = function (self, dt)
		for k, v in pairs(self.entities) do
			if v == true then
				k:draw(dt)
			end
		end
	end;

	add = function (self, entity)
		self.entities[entity] = true
	end;

	remove = function (self, entity)
		self.entities[entity] = false
	end;
}
