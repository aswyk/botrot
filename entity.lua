Class = require("hump.class")
require("entity_manager")
em = EntityManager()


Entity = Class{
	name = "Entity";
	init = function(self)
		self.__entity_id = em:add(self)
	end;

	die = function(self)
		print("removing id ", self.__entity_id)
		em:remove(self.__entity_id)
	end;
	__entity_id = 0
}

