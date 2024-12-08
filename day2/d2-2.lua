local file = io.open("input.txt", "rb")

if not file then return nil end

local reports = {}
local issues = {}

for line in file:lines() do
    local report = {}
    for token in string.gmatch(line, "%S+") do
        table.insert(report, tonumber(token))
    end
    table.insert(reports, report)
    table.insert(issues, 0)
end

file:close()

local count_safe = 0

local all_decreasing_or_increasing = function(report, report_issues)
    -- equivalent means not increasing or decreasing
    if report[1] == report[2] then
        report_issues = report_issues + 1
    end
    if report[1] < report[2] then
        -- increasing
        for i, entry in pairs(report) do
            local next = report[i + 1]
            if next and next <= entry then
                report_issues = report_issues + 1
            end
        end
    else
        -- decreasing
        for i, entry in pairs(report) do
            local next = report[i + 1]
            if next and (next >= entry) then
                report_issues = report_issues + 1
            end
        end
    end
    return report_issues
end


for i, report in pairs(reports) do
    issues[i] = all_decreasing_or_increasing(report, issues[i])
    for ii, entry in pairs(report) do
        local next = report[ii + 1]
        if next then
            local diff = entry - next
            if math.abs(diff) > 3 then
                issues[i] = issues[i] + 1
            end
        end
    end

    if issues[i] < 2 then
        count_safe = count_safe + 1
    end
end

print(count_safe)
