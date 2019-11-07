local terminal = require 'BearLibTerminal'
local key

terminal.open()

while not (key == terminal.TK_CLOSE or key == terminal.TK_ESCAPE) do
    terminal.refresh()
    terminal.clear()
    key = terminal.read()
    terminal.print(0, 0, string.format("Key is %d", key))
end

terminal.close()