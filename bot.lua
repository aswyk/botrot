bot = {}--{ prompt = "$USER$ on $MACHINE$ in $PATH$"}
bot.__index = bot


require("bullet")

local lg = love.graphics
local lk = love.keyboard
local font_14 = love.graphics.newFont("assets/fonts/Hack-Regular.ttf", 14)
local font_16 = love.graphics.newFont("assets/fonts/Hack-Regular.ttf", 16)

local AngCor = -90

local bullets = {}

function bot.create(x, y, ang, r, g, b, a)
    local self = setmetatable({}, bot)

    self.m_x = x
    self.m_y = y
    self.m_ang_deg = ang
    self.m_ang_rad = self.m_ang_deg * math.pi / 180
    self.m_turnAngSlow = 3
    self.m_turnAngFast = 7

    self.m_dragCoef = 0.95

    self.m_r = r
    self.m_g = g
    self.m_b = b
    self.m_a = a

    self.m_mainThrusterForce = 0.3
    self.m_reverseThrusterForce = 0.1

    self.m_xVel = 0
    self.m_yVel = 0

    self.m_maxVel = 2
    self.m_maxAccel = 2

    self.m_size = 32;
    self.m_scale = 0.25

    --self.m_geom = {32,0,    64,64,   0,64,   32,0}
    -- Making bot smaller, 64 is a bit to big
    --self.m_geom = {32/2,0,    64/2,64/2,   0,64/2,   32/2,0}

    --self.m_geom = {0,-16,    16,16,   -16,16,   0,-16}
    self.m_geom = {0,-self.m_size*self.m_scale,
                    self.m_size*self.m_scale,self.m_size*self.m_scale,
                    -self.m_size*self.m_scale,self.m_size*self.m_scale,
                    0,-self.m_size*self.m_scale}

    self.ammo = { bullet.create(self.m_x, self.m_y, self.m_ang_deg, 255, 50, 50, 255) }
    self.clipSize = 10;

    return self
end

function bot:updateVelocity()
    --self.m_xVel = self.m_xVel + math.cos(self.m_ang_deg)
    --self.m_yVel = self.m_yVel + math.sin(self.m_ang_rad)

    --self.m_xVel = self.m_xVel + math.cos(45.0)
    --self.m_yVel = self.m_yVel + math.sin(45.0)
end

function bot:updatePostion()

    self.m_xVel = self.m_xVel * self.m_dragCoef
    self.m_yVel = self.m_yVel * self.m_dragCoef

    self.m_x = self.m_x + self.m_xVel
    self.m_y = self.m_y + self.m_yVel
end

function bot:applyMainThruster()
    --self.m_XVel = 1 * math.cos(self.m_ang_rad)
    --self.m_yVel = 1* math.sin(self.m_ang_rad)

    --if self.m_xVel < self.m_maxVel then
    --    if self.m_yVel < self.m_maxVel then
            self.m_xVel = self.m_xVel + self.m_mainThrusterForce * math.cos((AngCor+self.m_ang_deg) * math.pi / 180)
            self.m_yVel = self.m_yVel + self.m_mainThrusterForce * math.sin((AngCor+self.m_ang_deg) * math.pi / 180)
    --    end
    --end
end

function bot:applyReverseThruster()
    --self.m_XVel = 1 * math.cos(self.m_ang_rad)
    --self.m_yVel = 1* math.sin(self.m_ang_rad)

    self.m_xVel = self.m_xVel + self.m_reverseThrusterForce * math.cos((AngCor+self.m_ang_deg+180) * math.pi / 180)
    self.m_yVel = self.m_yVel + self.m_reverseThrusterForce * math.sin((AngCor+self.m_ang_deg+180) * math.pi / 180)
end

function bot:applyStrafeLeftThruster()
    self.m_xVel = self.m_xVel + self.m_mainThrusterForce * math.cos((AngCor+self.m_ang_deg-90) * math.pi / 180)
    self.m_yVel = self.m_yVel + self.m_mainThrusterForce * math.sin((AngCor+self.m_ang_deg-90) * math.pi / 180)
end

function bot:applyStrafeRightThruster()
    self.m_xVel = self.m_xVel + self.m_mainThrusterForce * math.cos((AngCor+self.m_ang_deg+90) * math.pi / 180)
    self.m_yVel = self.m_yVel + self.m_mainThrusterForce * math.sin((AngCor+self.m_ang_deg+90) * math.pi / 180)
end


function bot:turnLeftSlow()
    self.m_ang_deg = self.m_ang_deg - self.m_turnAngSlow
    self.m_ang_rad = self.m_ang_deg * math.pi / 180
end

function bot:turnRightSlow()
    self.m_ang_deg = self.m_ang_deg + self.m_turnAngSlow
    self.m_ang_rad = self.m_ang_deg * math.pi / 180
end

function bot:turnLeftFast()
    self.m_ang_deg = self.m_ang_deg - self.m_turnAngFast
    self.m_ang_rad = self.m_ang_deg * math.pi / 180
end

function bot:turnRightFast()
    self.m_ang_deg = self.m_ang_deg + self.m_turnAngFast
    self.m_ang_rad = self.m_ang_deg * math.pi / 180
end

function bot:update()
    --self.updateVelocity()
    --self.updatePosition()
    self.draw()
end

function bot:fire()
    b = bullet.create(self.m_x, self.m_y, self.m_ang_deg, 255, 50, 50, 255)
    --table.insert(self.m_ammo, b)

    table.insert(bullets, b)

end

--table.remove(t, 2)

function bot:removeBullets()
    local count = 0
    for k, v in ipairs(bullets) do
        count = count + 1


        --t.window.width = 1280
        --t.window.height = 720

        if v:getX() < 0 then
            table.remove(bullets, count)
        elseif v:getX() > 1280 then
            table.remove(bullets, count)
        elseif v:getY() < 0 then
            table.remove(bullets, count)
        elseif v:getY() > 720 then
            table.remove(bullets, count)
        end

    end
end

function bot:drawBullets()
    --for k, v in ipairs(self.m_ammo) do
    local count = 0
    for k, v in ipairs(bullets) do
        count = count + 1
        v:updatePostion()
        v:draw()
        local str = "bullet : "..count
        print(str)
        v:printInfo()
    end
end

function bot:draw()

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
end


function bot:keyPressed( key, scancode, isrepeat )


end
