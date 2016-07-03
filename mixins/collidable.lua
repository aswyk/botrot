Class = require('hump.class')

Collidable = Class{
	name = "Collidable";
	collision = function(self, other, sep_v, dt)
		if self.collision_handler[other.name] then
			return self.collision_handler[other.name](self, other, sep_v, dt)
		end

		return self.collision_handler["*"](self, other, sep_v, dt)
	end;
	collision_handler = {["*"] = function(self, other, sep_v, dt) end},
}
