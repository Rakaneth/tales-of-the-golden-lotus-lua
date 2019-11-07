local utils = {}

function utils.any(tbl, fn)
    for _, item in ipairs(tbl) do
        if fn(item) then return true end
    end
    return false
end

function utils.all(tbl, fn)
    for _, item in ipairs(tbl) do
        if not fn(item) then return false end
    end
    return true
end

function utils.filter(tbl, fn)
    local result = {}
    for _, item in ipairs(tbl) do
        if fn(item) then table.insert(result, item) end
    end
    return result
end

function utils.clone(tbl)
    local t = type(tbl)
    local copy
    if t == 'table' then
        copy = {}
        for ok, ov in next, tbl, nil do
            copy[utils.clone(ok)] = utils.clone(ov)
        end
        setmetatable(copy, utils.clone(getmetatable(tbl)))
    else
        copy = tbl
    end
    return copy
end

--non-destructive, leaves original tables intact
function utils.merge(orig, modi)
    local result = utils.clone(orig)
    local m = utils.clone(modi)
    for mk, mv in next, m, nil do
        if type(mv) == 'table' then
            if type(result[mk] or false) == 'table' then
                result[mk] = utils.merge(result[mk] or {}, m[mk] or {})
            else
                if not result[mk] then result[mk] = mv end
            end
        else
            if not result[mk] then result[mk] = mv end
        end
    end
    return result
end

function utils.table_debug(tbl, lvl)
    lvl = lvl or 0
    local indent = function(lv)
        if lv > 0 then
            for i = 1, lv * 2 do io.write(" ") end
        end
    end
    io.write("{\n")
    for k, v in pairs(tbl) do
        indent(lvl + 1)
        io.write(string.format("%s = ", k))
        if type(v) == 'table' then
            utils.table_debug(v, lvl + 1)
        else
            io.write(v, "\n")
        end
    end
    indent(lvl)
    io.write("}\n")
end

function utils.clamp(val, low, high)
    if val < low then
        return low
    elseif val > high then
        return high
    else
        return val
    end 
end

function utils.between(val, low, high)
    return utils.clamp(val, low, high) == val
end

return utils