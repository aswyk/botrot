Class = require("hump.class")

Health = Class {
	name = "Health";
	init = function(self, hp)
		self.health = hp
	end;
	take_damage = function(self, damage)
		self.health = self.health - damage
		if self.health < 0 then
			self:die()
		end
	end;
	health = 100;
}

Damage = Class{
	name = "Damage";
	init = function(self, damage)
		self.damage = damage
	end;
	damage = 10;
}
