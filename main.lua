local terminal = require("BearLibTerminal")
local UIStack = require("ui.uistack")
local UI = require("ui.ui")
local Title = require("ui.title")
local ROT = require("lib.rotLove.src.rot")
local utils = require("utils")
local Entity = require("entity.entity")
--local mixins = require("entity.mixin")
--local block_move, block_sight, inventory, player_actor, vitals = table.unpack(mixins)
local beholder = require("lib.beholder")
require("ui.input")

local function main()
    --init and config terminal
    terminal.open()
    terminal.set("log: file=blt.log, level=trace")
    terminal.set("font: assets/UbuntuMono-r.ttf, size=14x14")
    terminal.set("window: title='Tales of the Golden Lotus', size=100x40")

    --init uis
    local input
    UIStack:push(Title())

    --game loop
    repeat
        terminal.clear()

        for _, ui in UIStack:allUIs() do
            ui:render(terminal)
        end
        --TODO: Key handling

        terminal.refresh()
        input = terminal.read()

        beholder.trigger(UIStack:peek().name, input)

        if input == terminal.TK_CLOSE then
            beholder.trigger("quit")
        end
    until #UIStack.uis == 0

    --clean up
    terminal.close()
end

local function err_handler(err)
    print("ERROR: ", err)
end

if not xpcall(main, err_handler) then
    terminal.close()
end