---内存分析
---@class memoryAnalyze
local memoryAnalyze = {}

---正在测试的panel地址
memoryAnalyze.panelAddr = nil
---正在测试的panelname
memoryAnalyze.panelName = nil

---界面是否存在
---@param panelName string
---@return boolean
function memoryAnalyze.IsPanelExist(panelName)
    return uimanager:GetPanel(panelName) ~= nil
end

---开始测试
function memoryAnalyze.StartTest(panelname)
    memoryAnalyze.panelName = panelname
    uimanager:CreatePanel(panelname, function(panel)
        if panel then
            memoryAnalyze.panelAddr = tostring(panel)
        end
    end)
end

---结束测试
function memoryAnalyze.FinishTest()
    uimanager:ClosePanel(memoryAnalyze.panelName)
end

---打印测试结果
---@return string
function memoryAnalyze.PrintTestResult()
    local str = memoryAnalyze.PrintTableReferPathInLua(memoryAnalyze.panelAddr)
    memoryAnalyze.panelAddr = nil
    memoryAnalyze.panelName = nil
    return str
end

---查找lua中table引用路径
---@param tableAddr string table的地址,一般为table: 00000000aa44ff88的格式
---@return string
function memoryAnalyze.PrintTableReferPathInLua(tableAddr)
    local cacheTbl = {}
    local isFind, path = memoryAnalyze.FindTablePathInEnv(_G, tableAddr, cacheTbl)
    if isFind then
        return "lua _G中查询到一条引用路径指向" .. memoryAnalyze.panelName .. ":" .. "    " .. path
    else
        return ""
    end
end

---根据table地址模糊查询获取引用链
---@param tableAddr string table的地址,一般为32位数字的16进制
---@return string
function memoryAnalyze.GetReferByTableAddrFuzzy(tableAddr)
    local cacheTbl = {}
    local isFind, path = memoryAnalyze.FindTablePathInEnvFuzzy(_G, tableAddr, cacheTbl)
    if isFind then
        return Utility.CombineStringQuickly("lua _G中查询到引用路径指向  ", tableAddr, "  :  ", path)
    else
        return Utility.CombineStringQuickly("")
    end
end

---获取环境中的table引用路径
---@private
---@param envTbl table 需要查询的table所处的env
---@param targetTableAddr string 需要查询的table的地址
---@param checkedTblAddr table<number,string> 已查询过的table,避免死循环
function memoryAnalyze.FindTablePathInEnvFuzzy(envTbl, targetTableAddr, checkedTblAddr)
    local envAddr = tostring(envTbl)
    if checkedTblAddr[envAddr] == nil then
        checkedTblAddr[envAddr] = true
    else
        return false
    end
    for i, v in pairs(envTbl) do
        if v ~= memoryAnalyze then
            local vAddrStr = tostring(v)
            local vType = type(v)
            if vType == "table" then
                ---只模糊匹配后面几位存在在table的地址中的table
                if string.match(vAddrStr, targetTableAddr) ~= nil then
                    return true, tostring(i)
                end
                local isFind, path = memoryAnalyze.FindTablePathInEnvFuzzy(v, targetTableAddr, checkedTblAddr)
                if isFind then
                    return true, Utility.CombineStringQuickly(tostring(i), " -> ", path)
                end
            end
        end
    end
    return false
end

---获取环境中的table引用路径
---@private
---@param envTbl table 需要查询的table所处的env
---@param targetTableAddr string 需要查询的table的地址
---@param checkedTblAddr table<number,string> 已查询过的table,避免死循环
function memoryAnalyze.FindTablePathInEnv(envTbl, targetTableAddr, checkedTblAddr)
    local envAddr = tostring(envTbl)
    if checkedTblAddr[envAddr] == nil then
        checkedTblAddr[envAddr] = true
    else
        return false
    end
    for i, v in pairs(envTbl) do
        local vAddr = tostring(v)
        local vType = type(v)
        if vType == "table" then
            if vAddr == targetTableAddr then
                return true, tostring(i)
            end
            local isFind, path = memoryAnalyze.FindTablePathInEnv(v, targetTableAddr, checkedTblAddr)
            if isFind then
                return true, tostring(i) .. " -> " .. path
            end
        end
    end
    return false
end

return memoryAnalyze