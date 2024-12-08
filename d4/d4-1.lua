local utils = require "utils"
local file = io.open("./d4/input.txt", "rb")

if not file then return nil end

local lines = {}

local line_count = 0

for line in file:lines() do
    local chars = {}
    for token in string.gmatch(line, "%a") do
        table.insert(chars, token)
    end
    table.insert(lines, chars)
    line_count = line_count + 1
end

local XMAS = 'XMAS'
local SAMX = 'SAMX'

local function vertical_scan()
    local match_count = 0

    for anchor_line, _ in pairs(lines) do
        local line_1 = lines[anchor_line]
        local line_2 = lines[anchor_line + 1]
        local line_3 = lines[anchor_line + 2]
        local line_4 = lines[anchor_line + 3]

        if not line_4 then
            return match_count
        end

        for i, _ in pairs(line_1) do
            local text = line_1[i] .. line_2[i] .. line_3[i] .. line_4[i]
            if text == XMAS or text == SAMX then
                match_count = match_count + 1
            end
        end
    end
end

local function horizontal_scan()
    local match_count = 0

    for ii, line in pairs(lines) do
        for i, _ in pairs(line) do
            local c1 = line[i]
            local c2 = line[i + 1]
            local c3 = line[i + 2]
            local c4 = line[i + 3]

            if c4 then
                local text = c1 .. c2 .. c3 .. c4
                if text == XMAS or text == SAMX then
                    match_count = match_count + 1
                end
            end
        end
    end
    return match_count
end

local function left_diagonal_scan()
    local match_count = 0

    for anchor_line, _ in pairs(lines) do
        local line_1 = lines[anchor_line]
        local line_2 = lines[anchor_line + 1]
        local line_3 = lines[anchor_line + 2]
        local line_4 = lines[anchor_line + 3]

        if not line_4 then
            return match_count
        end

        for i, _ in pairs(line_1) do
            local c1 = line_1[i]
            local c2 = line_2[i + 1]
            local c3 = line_3[i + 2]
            local c4 = line_4[i + 3]
            if c4 then
                local text = c1 .. c2 .. c3 .. c4
                if text == XMAS or text == SAMX then
                    match_count = match_count + 1
                end
            end
        end
    end
end

local function right_diagonal_scan()
    local match_count = 0

    for anchor_line, _ in pairs(lines) do
        local line_1 = lines[anchor_line]
        local line_2 = lines[anchor_line + 1]
        local line_3 = lines[anchor_line + 2]
        local line_4 = lines[anchor_line + 3]

        if not line_4 then
            return match_count
        end

        for i, _ in pairs(line_1) do
            local c1 = line_1[i + 3]
            local c2 = line_2[i + 2]
            local c3 = line_3[i + 1]
            local c4 = line_4[i]
            if c1 then
                local text = c1 .. c2 .. c3 .. c4
                if text == XMAS or text == SAMX then
                    match_count = match_count + 1
                end
            end
        end
    end
end

local vertical_matches = vertical_scan()
local horizontal_matches = horizontal_scan()
local left_diagonal_matches = left_diagonal_scan()
local right_diagonal_matches = right_diagonal_scan()

print('Vertical matches: ' .. vertical_matches)
print('Horizontal matches: ' .. horizontal_matches)
print('Left diagonal matches: ' .. left_diagonal_matches)
print('right diagonal matches: ' .. right_diagonal_matches)
print('combined matches: ' .. vertical_matches + horizontal_matches + left_diagonal_matches + right_diagonal_matches)
