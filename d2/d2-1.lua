local file = io.open("input.txt", "rb")

if not file then return nil end

local reports = {}

for line in file:lines() do
    local report = {}
    for token in string.gmatch(line, "%S+") do
        table.insert(report, tonumber(token))
    end
    table.insert(reports, report)
end

file:close()

local count_safe = 0

local all_decreasing_or_increasing = function(report)
    -- equivalent means not increasing or decreasing
    if report[1] == report[2] then
        return false
    end
    if report[1] < report[2] then
        -- increasing
        for i, entry in pairs(report) do
            local next = report[i + 1]
            if next and next <= entry then
                return false
            end
        end
    else
        -- decreasing
        for i, entry in pairs(report) do
            local next = report[i + 1]
            if next and (next >= entry) then
                return false
            end
        end
    end
    return true
end

for _, report in pairs(reports) do
    local is_safe = true
    if not all_decreasing_or_increasing(report) then
        local report_str = ''
        for _, entry in pairs(report) do
            report_str = report_str .. entry .. ', '
        end
        is_safe = false
    else
        for i, entry in pairs(report) do
            local next = report[i + 1]
            if next then
                local diff = entry - next
                if math.abs(diff) > 3 then
                    is_safe = false
                end
            end
        end
    end
    if is_safe then
        count_safe = count_safe + 1
    end
end

print(count_safe)
