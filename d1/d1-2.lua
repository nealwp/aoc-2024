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

-- sort the right_list
table.sort(right_list)

-- new list, count of right list grouped by number
local grouped = {}
for key, value in pairs(right_list) do
    if not grouped[value] then
        grouped[value] = 1
    else
        grouped[value] = grouped[value] + 1
    end
end


local similarty_score = 0
for key, value in pairs(left_list) do
    local multiplier = 0
    if grouped[value] then
        multiplier = grouped[value]
    end
    similarty_score = similarty_score + (value * multiplier)
end

print(similarty_score)
