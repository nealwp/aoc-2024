local utils = require('utils')

local file = io.open("./d3/input.txt", "rb")

if not file then return nil end

local garbage = {}

for line in file:lines() do
    table.insert(garbage, line)
end

file:close()

local valids = {}

for _, line in pairs(garbage) do
    for token in string.gmatch(line, "mul%(%d+,%d+%)") do
        table.insert(valids, token)
    end
end

utils.print_table(valids)

local sum = 0
for _, value in pairs(valids) do
    local values = {}
    for token in string.gmatch(value, "%d+") do
        table.insert(values, token)
    end
    local product = values[1] * values[2]
    sum = sum + product
end

print(sum)
