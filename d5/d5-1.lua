local utils = require "utils"
local lines = utils.get_file_lines("./d5/input-a.txt")

local parsed = {}

for _, value in pairs(lines) do
    local group = {}
    for page_number in string.gmatch(value, "([^|]+)") do
        table.insert(group, page_number)
    end
    table.insert(parsed, group)
end

local rules = {}
local dependent_counts = {}

for _, value in pairs(parsed) do
    if not rules[value[2]] then
        rules[value[2]] = {}
        dependent_counts[value[2]] = 0
    end
    table.insert(rules[value[2]], value[1])
end

utils.print_table_2d(rules)

for page in pairs(dependent_counts) do
    for _, dependents in pairs(rules) do
        if utils.table_includes(dependents, page) then
            dependent_counts[page] = dependent_counts[page] + 1
        end
    end
end

utils.print_table(dependent_counts)

local lines2 = utils.get_file_lines("./d5/input-b.txt")

--utils.print_table(lines2)

local pages = {}

for _, value in pairs(lines2) do
    local group = {}
    for page_number in string.gmatch(value, "([^,]+)") do
        table.insert(group, page_number)
    end
    table.insert(pages, group)
end

--utils.print_table_2d(pages)

local function get_middle_element(table)
    local length = utils.len(table)
    local middle_index = math.ceil(length / 2)
    return table[middle_index]
end

local sum_middle = 0

for key, value in pairs(pages) do
    local middle = get_middle_element(value)
    sum_middle = sum_middle + middle
end

print(sum_middle)
