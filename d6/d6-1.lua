local utils = require "utils"

local lines = utils.get_file_lines("./d6/input.txt")

local N = '^'
local S = 'v'
local E = '>'
local W = '<'

local map = {}
for _, line in pairs(lines) do
    local r = {}
    for c in string.gmatch(line, '.') do
        table.insert(r, c)
    end
    table.insert(map, r)
end

local function turn_guard(guard, r, c)
    if guard.facing == N then
        guard.facing = E
        map[r][c + 1] = guard.facing
        return
    end
    if guard.facing == E then
        guard.facing = S
        map[r + 1][c] = guard.facing
        return
    end
    if guard.facing == S then
        guard.facing = W
        map[r][c - 1] = guard.facing
        return
    end
    if guard.facing == W then
        guard.facing = N
        map[r - 1][c] = guard.facing
        return
    end
end

local function move_guard(guard, row, col)
    local dest = {}

    if guard.facing == N then
        dest = { row = row - 1, col = col }
    elseif guard.facing == E then
        dest = { row = row, col = col + 1 }
    elseif guard.facing == S then
        dest = { row = row + 1, col = col }
    elseif guard.facing == W then
        dest = { row = row, col = col - 1 }
    end

    if not map[dest.row] or not map[dest.row][dest.col] then
        return true
    end

    if map[dest.row][dest.col] == '#' then
        turn_guard(guard, row, col)
        return false
    else
        map[dest.row][dest.col] = guard.facing
        return false
    end
end

local function is_guard(x)
    if x == N or x == E or x == S or x == W then return true else return false end
end

local function mark_traveled(row, col)
    map[row][col] = 'X'
end


local function game_loop(guard)
    for r, row in pairs(map) do
        for c, col in pairs(row) do
            if is_guard(col) then
                mark_traveled(r, c)
                local exit_condition = move_guard(guard, r, c)
                return exit_condition
            end
        end
    end
    return false
end

local guard = { facing = N }
local exit = false
while not exit do
    exit = game_loop(guard)
end

local traveled_count = 0
for _, row in pairs(map) do
    for _, col in pairs(row) do
        if col == 'X' then traveled_count = traveled_count + 1 end
    end
end

print(traveled_count)
