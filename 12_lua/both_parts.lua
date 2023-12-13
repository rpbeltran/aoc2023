function slice(tbl, first, last)
    local sliced = {}
    for i = first, last or #tbl do
      sliced[#sliced+1] = tbl[i]
    end
    return sliced
end


function replace_char(pos, str, r)
    return str:sub(1, pos-1) .. r .. str:sub(pos+1)
end


function table.shallow_copy(t)
    local t2 = {}
    for k,v in pairs(t) do
      t2[k] = v
    end
    return t2
end


function add_tables(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end


function group_errors(line)
    groups = {}
    for errors in string.gmatch(line, "#+") do
        groups[#groups+1] = string.len(errors)
    end
    return groups
end


function f_prime2(s, g)
    egs = group_errors(s)
    if table.concat(egs,",") == table.concat(g,",") then
        return 1
    end
    return 0
end


function get_qs(s)
    local holes = {}
    local start = 1
    while true do
        local _,i = string.find(s,"?",start,true)
        if i==nil then break end
        holes[#holes+1] = i
        start=i+1
    end
    return holes
end


function f(s, g, dp, quiet)
    local key = s .. " " .. table.concat(g,",")
    if dp[key] == nil then
        local qs = get_qs(s)
        local middle_q = qs[(1+#qs)//2]
        -- Base case
        if (#qs == 0) then
            dp[key] = f_prime2(s, g)
        else
            -- Otherwise -- 
            local s_len = string.len(s)
            
            local sa = s:sub(1,middle_q-1)
            local sb = "." .. s:sub(middle_q+1, s_len)
            local s2 = replace_char(middle_q, s, "#")
            local f2 = f(s2, g, dp, 1)

            local total = f2
            for g_div = 1,#g+1 do
                local ga = slice(g, 1, g_div-1)
                local gb = slice(g, g_div, #g)
                local fa = f(sa, ga, dp, 1)
                local fb = f(sb, gb, dp, 1)
                
                total = total + (fa * fb)
            end
            dp[key] = total
        end
    end
    return dp[key]
end


function f_extended(s,g,e)
    local se = s
    local ge = table.shallow_copy(g)
    for i=1,e-1 do
        se = se .. "?" .. s
        add_tables(ge, g)
    end
    return f(se, ge, {})
end

sum = 0
sum5 = 0
for line in io.lines("input.txt") do
    g = {}
    first_line = true
    for p in string.gmatch(line, "[^ ,]+") do
        if first_line then
            g[#g+1] = p
        else
            g[#g+1] = tonumber(p)
        end
        first_line = false
    end
    s = table.remove(g, 1)

    f = f_extended(s, g, 1)
    f5 = f_extended(s, g, 5)
    sum = sum + f
    sum5 = sum + f5
end

print("\n\nFinal answer:\n")
print(sum)