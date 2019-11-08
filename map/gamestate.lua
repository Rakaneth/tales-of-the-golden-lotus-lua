local ROT = require('lib.rotLove.src.rot')
local Scheduler = ROT.Scheduler.Speed
local Engine = ROT.Engine

local GAME = {
    player = {x = 0, y = 0},
    entities = {},
    maps = {},
    scheduler = {},
    engine = {}
}

return GAME