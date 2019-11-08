local PointSet = require('lib.rotLove.src.rot').Type.PointSet

local block_move = {
    name = 'block-move'
}

local block_sight = {
    name = 'block-sight'
}

local inventory = {
    name = 'inventory',
    inventory = {}
}

local player_actor = {
    name = 'player-actor',
    group = 'actor'
}

local chi_user = {
    name = 'chi-user',
    group = 'skill-user',
    points = function(self)
        local n = self.chi_width // 2
        return self.fulcrum - n, self.fulcrum + n
    end,
    shiftExternal = function(self, amt)
        local _, high = self.points()
        if high + amt <= 10 then
            self.fulcrum = self.fulcrum + amt
            return true
        end
        return false
    end,
    shiftInteral = function(self, amt)
        local low = self.points()
        if low - amt >= -10 then
            self.fulcrum = self.fulcrum - amt
            return true
        end
        return false
    end,
    externalMode = function(self)
        local low = self.points()
        return low >= 0
    end,
    internalMode = function(self)
        local _, high = self.points()
        return high < 0
    end,
    init = function(self, opts)
        self.chi_width = opts.chi_width or 6
        self.fulcrum = 0
        self.chi_techs = {}
    end,
}

local stats = {
    name = 'stats',
    getStat = function(self, stat)
        return self[stat] or 0
    end,
    init = function(self, opts)
        self.power = opts.power or 1
        self.discipline = opts.discipline or 1
        self.spirit = opts.spirit or 1
    end,
}

local vision = {
    name = 'vision',
    group = 'vision',
    visible = PointSet(),
    can_see = function(self, x, y)
        return self.visible:find(x, y)
    end,
    addVisible = function(self, x, y)
        self.visible:push(x, y)
    end,
    init = function(self, opts)
        self.vision = opts.vision or 6
    end,
}

return {
    vision = vision,
    stats = stats,
    chi_user = chi_user,
    player_actor = player_actor,
    inventory = inventory,
    block_move = block_move,
    block_sight = block_sight
}

