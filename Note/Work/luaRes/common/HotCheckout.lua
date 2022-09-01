---@class  HotCheckout
local HotCheckout = {}

HotCheckout.LocalResDic = {}
HotCheckout.MaxSchedule=0
HotCheckout.NowSchedule=0

---资源校验
function HotCheckout:CheckoutRes(isCheckAll)
    --CS.VersionsCompare.Instance:SetLocalResDic();
    if self.co ~= nil then
        StopCoroutine(self.co)
    end
    self.co = StartCoroutine(function()
        self:StartCoroutineCheckoutRes(isCheckAll)
        self.co = nil
    end)
end

function HotCheckout:StartCoroutineCheckoutRes(isCheckAll)
    local time = CS.System.Diagnostics.Stopwatch()
    time:Start();
    self.pathList= self:GetPathList(isCheckAll)
    coroutine.yield(0);
    self.NowSchedule=0
    self.MaxSchedule=self:GetMaxCount(self.pathList)
    print( self.MaxSchedule)
    coroutine.yield(0);
    self:SetLocalResDic()
    self:DetectionResDifference()
    print("资源校验耗时②", time.ElapsedMilliseconds);

end

---得到路径列表
---@return table<number,string>
function HotCheckout:GetPathList(isCheckAll)
    local pathTable={}
    local path = CS.CSEditorPath.Get(CS.EEditorPath.LocalResourcesLoadPath);
    local path1 = path .. "Table"
    local path2 = path .. "Android"
    local path3 = path .. "luaRes"
    if isCheckAll then
        table.insert(pathTable,path)
    else
        table.insert(pathTable,path1)
        table.insert(pathTable,path2)
        table.insert(pathTable,path3)
    end
    return pathTable
end

---检测本地文件与服务器配置差异
function HotCheckout:DetectionResDifference()
    local ServerResListText = CS.VersionsCompare.Instance.ServerResListText;
    if ServerResListText == nil or ServerResListText == "" then
        return
    end
    local data = _fSplit(ServerResListText, "\r\n")
    local index = 0
    local stopInterval=0
    for i, v in pairs(data) do
        local temp = string.Split(v, "#")
        if temp ~= nil and Utility.GetTableCount(temp) == 6 then
            if HotCheckout.LocalResDic ~= nil and HotCheckout.LocalResDic[temp[1]] == temp[6] then
                local res = CS.Resource(tostring(temp[1]), tostring(temp[2]), tostring(temp[3]), tostring(temp[4]), tostring(temp[5]), tostring(temp[6]), tostring(v))
                CS.VersionsCompare.Instance:WriteCacheData(res);
                print("问题文件：",temp[1])
                stopInterval=stopInterval+1
                if stopInterval>=100 then
                    coroutine.yield(0);
                    stopInterval=0
                end
            end
        end
        self.NowSchedule=self.NowSchedule+1
    end
end

---设置本地资源列表
function HotCheckout:SetLocalResDic()
    HotCheckout.LocalResDic = {}
    local time = CS.System.Diagnostics.Stopwatch()
    time:Start();
    for i, path in pairs(self.pathList) do
        self:CheckoutLocalResource(path)
        coroutine.yield(0);
    end
    print("md5耗时", time.ElapsedMilliseconds);
end

---得到本地文件的Md5值
function HotCheckout:CheckoutLocalResource(path, type)
    local rootPath = CS.CSEditorPath.Get(CS.EEditorPath.LocalResourcesLoadPath)
    local IO = CS.System.IO
    local indxe = 0
    local stopInterval=0
    if IO.Directory.Exists(path) then
        local directoryInfo = IO.DirectoryInfo(path)
        local temp = CS.VersionsCompare.GetMD5HashFromFile
        local files = directoryInfo:GetFiles("*", IO.SearchOption.AllDirectories)
        for i = 0, files.Length - 1 do
            if not (type ~= nil and string.find(files[i].Name, type) == nil) then
                local md5 = temp(files[i].FullName)
                local FullName = string.gsub(files[i].FullName, "\\", "/")
                local path = string.gsub(FullName, rootPath, "")
                HotCheckout.LocalResDic[path] = md5
                indxe = indxe + 1
                stopInterval=stopInterval+1
                if stopInterval>=100 then
                    coroutine.yield(0);
                    stopInterval=0
                end
            end
            self.NowSchedule=self.NowSchedule+1
        end
    end
    print("检测文件个数：", path, indxe)
end
function HotCheckout:GetMaxCount(pathList)
    local IO = CS.System.IO
    local count=0
    for i = 1, #pathList do
        local path=pathList[i]
        if IO.Directory.Exists(path) then
            local directoryInfo = IO.DirectoryInfo(path)
            local files = directoryInfo:GetFiles("*", IO.SearchOption.AllDirectories)
            count=count+files.Length
        end
    end
    local ServerResListText = CS.VersionsCompare.Instance.ServerResListText;
    if ServerResListText == nil or ServerResListText == "" then
        return count
    end
    local data = _fSplit(ServerResListText, "\r\n")
    count=count+#data
    return count
end
return HotCheckout