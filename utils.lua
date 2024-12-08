local U = {}

U.print_table = function(table)
    for _, value in pairs(table) do
        print(value)
    end
end

return U
