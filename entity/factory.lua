local creatures = require('entity.creatures')
local utils = require('utils')
local Entity = require('entity.entity')

local factory = {}

function factory.buildCreature(buildID, opts)
    opts = opts or {}
    local template = creatures[buildID]
    if not template then
        error(string.format('No template for build ID %s', buildID))
    end
    local finalOpts = utils.merge(template, opts)
    return Entity.
end

return factory