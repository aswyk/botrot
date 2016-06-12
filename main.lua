require("bot")
require("bullet")

local screen_w = 0
local screen_h = 0

local lg = love.graphics
local font14 = nil

local bot = bot.create(300, 600, 45, 50, 255, 50, 255)

local b = bullet.create(350, 550, 45, 255, 50, 50, 255)



function love.load()
    -- Setting up a nice font
    local font14 = love.graphics.newFont("assets/fonts/Hack-Regular.ttf", 14)
    love.graphics.setFont(font14)

    screen_w = love.graphics.getWidth( )
    screen_h = love.graphics.getHeight( )


end

function love.keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)

end

function love.mousemoved( x, y, dx, dy )
end

function love.update(dt)
    if love.keyboard.isDown( "a" ) then
        bot:turnLeftFast()
    end

    if love.keyboard.isDown( "d" ) then
        bot:turnRightFast()
    end

    if love.keyboard.isDown( "w" ) then
        bot:applyMainThruster()
    end

    if love.keyboard.isDown( "s" ) then
        bot:applyReverseThruster()
    end

    if love.keyboard.isDown( "q" ) then
        bot:applyStrafeLeftThruster()
    end

    if love.keyboard.isDown( "e" ) then
        bot:applyStrafeRightThruster()
    end


    --bot:update()
    bot:updateVelocity()
    bot:updatePostion()
end

function love.draw()


    lg.push()

        lg.setColor(255,100,100,150)
        lg.line(5,5,  screen_w-5,5,  screen_w-5,screen_h-5,  5,screen_h-5,  5,5)

        lg.push()
            lg.setColor(150,255,150,255)
            --love.graphics.setFont(font_14)
            lg.print( "botrot", 10, 10)
        lg.pop()

        bot:draw()
        b:draw()

    lg.pop()


end
