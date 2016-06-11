bot = {}--{ prompt = "$USER$ on $MACHINE$ in $PATH$"}
bot.__index = bot

local lg = love.graphics
local lk = love.keyboard
local font_14 = love.graphics.newFont("assets/fonts/Hack-Regular.ttf", 14)
local font_16 = love.graphics.newFont("assets/fonts/Hack-Regular.ttf", 16)

function bot.create(x, y, ang, r, g, b, a)
    local self = setmetatable({}, bot)

    self.m_x = x
    self.m_y = y
    self.m_ang = ang

    self.m_r = r
    self.m_g = g
    self.m_b = b
    self.m_a = a

    self.m_geom = {32,0,    64,64,   0,64,   32,0}

    --love.graphics.line( points )

    return self
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
    love.graphics.line( self.m_geom )

    lg.pop()
end


function bot:keyPressed( key, scancode, isrepeat )


end
