local file = io.open("input.txt", "rb")

if not file then return nil end

local lines = {}

for line in io.lines("input.txt") do
    local group = {}
    for token in string.gmatch(line, "[^%s]+") do
        table.insert(group, token)
    end
    table.insert(lines, group)
end

file:close()

local left_list = {}
local right_list = {}

for key, line in pairs(lines) do
    table.insert(left_list, line[1])
    table.insert(right_list, line[2])
end

table.sort(left_list)
table.sort(right_list)

local total_distance = 0
for i, value in pairs(left_list) do
    total_distance = total_distance + math.abs(value - right_list[i])
end

print(total_distance)
