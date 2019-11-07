local beholder = require('lib.beholder')
local UIStack = require('ui.uistack')
local MainScreen = require('ui.mainscreen')

beholder.observe("title", function()
    UIStack:pop()
    UIStack:push(MainScreen())
end)

beholder.observe("quit", function()
    --TODO: Autosave code
    UIStack:popall()
end)