Class = require("hump.class")
require("entity")
require("bullet")
require("HC")
require("mixins.collidable")

local lg = love.graphics
local lk = love.keyboard
local font_14 = love.graphics.newFont("assets/fonts/Hack-Regular.ttf", 14)
local font_16 = love.graphics.newFont("assets/fonts/Hack-Regular.ttf", 16)

local AngCor = -90

local Bullets = {}

Bot = Class{
	name = "Bot";
	__includes = {"Entity", "Health", "Collidable"};
	init = function (self, x, y, ang, r, g, b, a)
		Entity.init(self)
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
		--self.m_scale = 0.25
		self.m_scale = 0.25

		self.m_mainThrusterForce_US = 1
		self.m_strafeThrusterForce_US = 0.5
		self.m_reverseThrusterForce_US = 0.25

		self.m_mainThrusterForce = self.m_mainThrusterForce_US * self.m_scale
		self.m_strafeThrusterForce = self.m_strafeThrusterForce_US * self.m_scale
		self.m_reverseThrusterForce = self.m_strafeThrusterForce_US * self.m_scale



		--self.m_geom = {32,0,    64,64,   0,64,   32,0}
		-- Making bot smaller, 64 is a bit to big
		--self.m_geom = {32/2,0,    64/2,64/2,   0,64/2,   32/2,0}

		--self.m_geom = {0,-16,    16,16,   -16,16,   0,-16}
		self.m_geom = {0,-self.m_size*self.m_scale,
						self.m_size*self.m_scale,self.m_size*self.m_scale,
						-self.m_size*self.m_scale,self.m_size*self.m_scale,
						0,-self.m_size*self.m_scale}

		self.ammo = { Bullet(self.m_x, self.m_y, self.m_ang_deg, 255, 50, 50, 255) }
		self.clipSize = 10;
	end;
	updateVelocity = function (self)
		--self.m_xVel = self.m_xVel + math.cos(self.m_ang_deg)
		--self.m_yVel = self.m_yVel + math.sin(self.m_ang_rad)

		--self.m_xVel = self.m_xVel + math.cos(45.0)
		--self.m_yVel = self.m_yVel + math.sin(45.0)
	end;
	updatePosition = function (self)
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
	end;

	applyMainThruster = function (self)
		--self.m_XVel = 1 * math.cos(self.m_ang_rad)
		--self.m_yVel = 1* math.sin(self.m_ang_rad)

		--if self.m_xVel < self.m_maxVel then
		--    if self.m_yVel < self.m_maxVel then
				self.m_xVel = self.m_xVel + self.m_mainThrusterForce * math.cos((AngCor+self.m_ang_deg) * math.pi / 180)
				self.m_yVel = self.m_yVel + self.m_mainThrusterForce * math.sin((AngCor+self.m_ang_deg) * math.pi / 180)
		--    end
		--end
	end;
	applyReverseThruster = function (self)
		--self.m_XVel = 1 * math.cos(self.m_ang_rad)
		--self.m_yVel = 1* math.sin(self.m_ang_rad)

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
	update = function (self)
		--self.updateVelocity()
		--self.updatePosition()
		self.draw()
	end;
	fire = function (self)
		b = Bullet(self.m_x, self.m_y, self.m_ang_deg, 255, 50, 50, 255)
		--table.insert(self.m_ammo, b)

		table.insert(Bullets, b)

	end;
	removeBullets = function (self)
		local count = 0
		for k, v in ipairs(Bullets) do
			count = count + 1


			--t.window.width = 1280
			--t.window.height = 720
			if v:getX() < 0 then
				v:die()
				table.remove(Bullets, count)
			elseif v:getX() > 1280 then
				v:die()
				table.remove(Bullets, count)
			elseif v:getY() < 0 then
				v:die()
				table.remove(Bullets, count)
			elseif v:getY() > 720 then
				v:die()
				table.remove(Bullets, count)
			end

		end
	end;
	drawBullets = function (self)
		--for k, v in ipairs(self.m_ammo) do
		local count = 0
		for k, v in ipairs(Bullets) do
			count = count + 1
			v:updatePosition()
			v:draw()
		end
	end;
	draw = function (self)

		-- Attemppting to draw to framebuffer for shell. Its not called framebuffer
		-- anymore, but rather "canvas"

		-- Changing framebuffers. This means any drawing commands will be drawing on the fb, duh. ;git add -
		--lg.setCanvas(self.m_fb)

		--lg.clear( )

		lg.push()

		lg.setColor(self.m_r, self.m_g, self.m_b, self.m_a)

		lg.translate( self.m_x, self.m_y )
		lg.rotate( self.m_ang_rad )
		love.graphics.line( self.m_geom )

		lg.pop()
	end;
	keyPressed = function (self, key, scancode, isrepeat ) end;
}

Bot.collision_handler["Bullet"] = function(self, other, sep_v)
	self.take_damage(other.damage)
end

