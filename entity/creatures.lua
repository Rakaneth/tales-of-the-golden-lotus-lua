local mixins = require('entity.mixins')
local utils = require('utils')
local function std_mixins(...)
    local extra = {...}
    local base = {
        mixins.block_move,
        mixins.block_sight,
        mixins.stats,
        mixins.vision
    }
    return utils.merge(base, extra or {})
end

local function chi_user_mixins(...)
    local extra = {...}
    return std_mixins(mixins.chi_user, table.unpack(extra))
end

return {
    strength = {
        desc = "Disciple of Strength",
        power = 5,
        discipline = 3,
        spirit = 2,
        mixins = chi_user_mixins(mixins.inventory)
    },
    discipline = {
        desc = "Disciple of Discipline",
        power = 3,
        discipline = 5,
        spirit = 2,
        mixins = chi_user_mixins(mixins.inventory)
    },
    spirit = {
        desc = "Disciple of Spirit",
        power = 2,
        discipline = 3,
        spirit = 5,
        mixins = chi_user_mixins(mixins.inventory)
    },
}