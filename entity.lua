Class = require("hump.class")
require("entity_manager")

em = EntityManager()

Entity = Class{
	name = "Entity";
	init = function(self)
		self.__entity_id = em:add(self)
	end;

	die = function(self)
		if self.__can_die then
			print("removing id ", self.__entity_id)
			em:remove(self.__entity_id)
		end
	end;
	__entity_id = 0;
	__can_die = true;
}

