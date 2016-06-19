Class = require('hump.class')

Collidable = Class{
	name = "Collidable",
	collision = function(self, other, sep_v)
		if self.collision_handler[other.name] then
			return self.collision_handler[other.name](self, other, sep_v)
		end

		return self.collision_handler["*"](self, other, sep_v)
	end,
	collision_handler = {["*"] = function(self, other, sep_v) end},
}
