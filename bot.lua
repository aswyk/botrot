Class = require("hump.class")
require("entity")
require("bullet")
Polygon = require("HC.polygon")
require("mixins.collidable")
require("mixins.health")

local lg = love.graphics
local lk = love.keyboard
local font_14 = love.graphics.newFont("assets/fonts/Hack-Regular.ttf", 14)
local font_16 = love.graphics.newFont("assets/fonts/Hack-Regular.ttf", 16)

local AngCor = -90

Bot = Class{
	name = "Bot";
	__includes = {Entity, Health, Collidable, shapes.ConvexPolygonShape};
	init = function (self, x, y, ang, r, g, b, a)
		Entity.init(self)
		Health.init(self, 100)
		self.m_x = x
		self.m_y = y
		self.m_ang_deg = ang
		self.m_ang_rad = self.m_ang_deg * math.pi / 180
		self.m_turnAngSlow = 3
		self.m_turnAngFast = 7

		self.m_dragCoef = 0.97

		self.m_r = r
		self.m_g = g
		self.m_b = b
		self.m_a = a

		self.m_xVel = 0
		self.m_yVel = 0

		self.m_maxVel = 5
		self.m_maxAccel = 5

		self.m_size = 32;
		self.m_scale = 0.25

		self.m_mainThrusterForce_US = 1
		self.m_strafeThrusterForce_US = 0.5
		self.m_reverseThrusterForce_US = 0.25

		self.m_mainThrusterForce = self.m_mainThrusterForce_US * self.m_scale
		self.m_strafeThrusterForce = self.m_strafeThrusterForce_US * self.m_scale
		self.m_reverseThrusterForce = self.m_strafeThrusterForce_US * self.m_scale

		shapes.ConvexPolygonShape.init(self, Polygon(self.m_size*self.m_scale,
									self.m_size*self.m_scale,0,-self.m_size*self.m_scale,
									-self.m_size*self.m_scale, self.m_size*self.m_scale))
		HC.register(self)
		self.ammo = { Bullet(self.m_x, self.m_y, self.m_ang_deg, 255, 50, 50, 255) }
		self.clipSize = 10;
	end;
	updatePosition = function (self, dt)
		self.m_xVel = self.m_xVel * self.m_dragCoef
		self.m_yVel = self.m_yVel * self.m_dragCoef

		self.m_x = self.m_x + self.m_xVel
		self.m_y = self.m_y + self.m_yVel

		if self.m_x > 1280 then
			self.m_x = 1
		elseif self.m_x < 0 then
			self.m_x = 1279
		end

		if self.m_y > 720 then
			self.m_y = 1
		elseif self.m_y < 0 then
			self.m_y = 719
		end
		self:moveTo(self.m_x, self.m_y)
		self:setRotation(self.m_ang_rad)
	end;

	applyMainThruster = function (self)
		self.m_xVel = self.m_xVel + self.m_mainThrusterForce * math.cos((AngCor+self.m_ang_deg) * math.pi / 180)
		self.m_yVel = self.m_yVel + self.m_mainThrusterForce * math.sin((AngCor+self.m_ang_deg) * math.pi / 180)
	end;
	applyReverseThruster = function (self)
		self.m_xVel = self.m_xVel + self.m_reverseThrusterForce * math.cos((AngCor+self.m_ang_deg+180) * math.pi / 180)
		self.m_yVel = self.m_yVel + self.m_reverseThrusterForce * math.sin((AngCor+self.m_ang_deg+180) * math.pi / 180)
	end;
	applyStrafeLeftThruster = function (self)
		self.m_xVel = self.m_xVel + self.m_strafeThrusterForce * math.cos((AngCor+self.m_ang_deg-90) * math.pi / 180)
		self.m_yVel = self.m_yVel + self.m_strafeThrusterForce * math.sin((AngCor+self.m_ang_deg-90) * math.pi / 180)
	end;
	applyStrafeRightThruster = function (self)
		self.m_xVel = self.m_xVel + self.m_strafeThrusterForce * math.cos((AngCor+self.m_ang_deg+90) * math.pi / 180)
		self.m_yVel = self.m_yVel + self.m_strafeThrusterForce * math.sin((AngCor+self.m_ang_deg+90) * math.pi / 180)
	end;
	turnLeftSlow = function (self)
		self.m_ang_deg = self.m_ang_deg - self.m_turnAngSlow
		self.m_ang_rad = self.m_ang_deg * math.pi / 180
	end;
	turnRightSlow = function (self)
		self.m_ang_deg = self.m_ang_deg + self.m_turnAngSlow
		self.m_ang_rad = self.m_ang_deg * math.pi / 180
	end;
	turnLeftFast = function (self)
		self.m_ang_deg = self.m_ang_deg - self.m_turnAngFast
		self.m_ang_rad = self.m_ang_deg * math.pi / 180
	end;
	turnRightFast = function (self)
		self.m_ang_deg = self.m_ang_deg + self.m_turnAngFast
		self.m_ang_rad = self.m_ang_deg * math.pi / 180
	end;
	update = function (self, dt)
		self:updatePosition(dt)
	end;
	fire = function (self)
		Bullet(self.m_x, self.m_y, self.m_ang_deg, 255, 50, 50, 255)
	end;

	draw = function (self, dt)
		lg.push()

		lg.setColor(self.m_r, self.m_g, self.m_b, self.m_a)
		love.graphics.polygon('line', self._polygon:unpack())

		lg.pop()
	end;
	keyPressed = function (self, key, scancode, isrepeat ) end;
}

Bot.collision_handler["Bullet"] = function(self, other, sep_v, dt)
	self.take_damage(other.damage)
end

Bot.collision_handler["*"] = function(self, other, sep_v, dt)
	print("collided with " .. tostring(other))
end

