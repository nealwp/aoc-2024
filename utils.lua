local U = {}

U.print_table = function(table)
    for key, value in pairs(table) do
        print(key .. ': ' .. value)
    end
end

U.print_table_2d = function(table)
    for key, row in pairs(table) do
        local str = key .. ': '
        for _, col in pairs(row) do
            str = str .. col .. ' '
        end
        print(str)
    end
end

U.len = function(table)
    local length = 0
    for _ in pairs(table) do
        length = length + 1
    end
    return length
end

U.table_includes = function(table, search_term)
    for _, value in pairs(table) do
        if value == search_term then return true end
    end
    return false
end


U.get_file_lines = function(fp)
    local file = io.open(fp, "rb")
    local lines = {}
    if not file then return lines end
    for line in file:lines() do
        table.insert(lines, line)
    end
    file:close()
    return lines
end

return U
