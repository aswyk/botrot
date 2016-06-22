AI = {}--{ prompt = "$USER$ on $MACHINE$ in $PATH$"}
AI.__index = AI


-- Some comment about AI

local lg = love.graphics
local lk = love.keyboard

-- AI Constructor
function AI.create(name)
    local self = setmetatable({}, AI)

    self.m_name = name
    return self
end

-- AI onThink function. Each AI will override this function.
function AI:onThink()

end
