---服务器列表界面
---@class 服务器列表界面:UIBase
local UIServerListPanel = {}

--region局部变量定义
---每100分区
UIServerListPanel.size = 50

---服务器状态图片
UIServerListPanel.StateSprite = {
    [LuaEnumServerState.NewServer] = "2",
    [LuaEnumServerState.Full] = "3",
}

---服务器状态点显示图片
UIServerListPanel.PointStateSprite = {
    [LuaEnumServerState.Full] = "14",
    [LuaEnumServerState.Maintain] = "12",
    [LuaEnumServerState.NewServer] = "11",
    [LuaEnumServerState.Smooth] = "11",
}

---渠道名字对应Toggle
---@type table<string,UIToggle>
UIServerListPanel.mRegionNameToGo = nil

--region白名单显示隐藏列表功能
---当前选择的服务器列表
UIServerListPanel.mCurrentShowServerList = nil

---当前点击隐藏按钮时间
UIServerListPanel.mLastClickTime = nil

---点击隐藏按钮次数
UIServerListPanel.mClickHideBtnCount = 0

---点击隐藏按钮有效时间
UIServerListPanel.mClickHidBtnEffectiveTime = 1

---需要点击隐藏按钮次数
UIServerListPanel.mNeedClickTimes = 10
--endregion

--endregion

--region 组件
---推荐区服
function UIServerListPanel.RecommendedServerToggle_UIToggle()
    if UIServerListPanel.mRecommendedServerToggle_GO == nil then
        UIServerListPanel.mRecommendedServerToggle_GO = UIServerListPanel:GetCurComp("WidgetRoot/tg_recommend", "UIToggle")
    end
    return UIServerListPanel.mRecommendedServerToggle_GO
end
---最近区服
function UIServerListPanel:RecentServerToggle_UIToggle()
    if self.mRecentServerToggle_GO == nil then
        self.mRecentServerToggle_GO = self:GetCurComp("WidgetRoot/tg_Login", "UIToggle")
    end
    return self.mRecentServerToggle_GO
end
---最近区服文字
function UIServerListPanel:RecentServer_UILabel()
    if self.mRecentServerLabel == nil then
        self.mRecentServerLabel = self:GetCurComp("WidgetRoot/tg_Login/name", "UILabel")
    end
    return self.mRecentServerLabel
end
---最近区服点
function UIServerListPanel:RecentServerPoint_UISprite()
    if self.mRecentServerPoint == nil then
        self.mRecentServerPoint = self:GetCurComp("WidgetRoot/tg_Login/point", "UISprite")
    end
    return self.mRecentServerPoint
end
---分组列表格子
function UIServerListPanel.TableList_UIGridContainer()
    if UIServerListPanel.mTableListGrids == nil then
        UIServerListPanel.mTableListGrids = UIServerListPanel:GetCurComp("WidgetRoot/TableList", "UIGridContainer")
    end
    return UIServerListPanel.mTableListGrids
end

---@return UIScrollView 分组列表ScrollView
function UIServerListPanel.TableList_UIScrollView()
    if UIServerListPanel.mTableListScrollView == nil then
        UIServerListPanel.mTableListScrollView = UIServerListPanel:GetCurComp("WidgetRoot/TableList", "UIScrollView")
    end
    return UIServerListPanel.mTableListScrollView
end

---@return UILoopScrollViewPlus 渠道分区列表组件
function UIServerListPanel:GetSubareaList_LoopScrollViewPlus()
    if self.mSubareaListLoopScroll == nil then
        self.mSubareaListLoopScroll = self:GetCurComp("WidgetRoot/TableList/Content", "UILoopScrollViewPlus")
    end
    return self.mSubareaListLoopScroll
end

---服务器列表格子
function UIServerListPanel.ServerListGrids()
    if UIServerListPanel.mServerListGrids == nil then
        UIServerListPanel.mServerListGrids = UIServerListPanel:GetCurComp("WidgetRoot/ServerList", "UIGridContainer")
    end
    return UIServerListPanel.mServerListGrids
end

---@return UILoopScrollViewPlus 服务器列表
function UIServerListPanel:GetServerList_LoopScrollViewPlus()
    if self.mServerListLoopScroll == nil then
        self.mServerListLoopScroll = self:GetCurComp("WidgetRoot/ServerList/Content", "UILoopScrollViewPlus")
    end
    return self.mServerListLoopScroll
end

---服务器列表ScrollView
function UIServerListPanel.ServerList_UIScrollView()
    if UIServerListPanel.mServerListScrollView == nil then
        UIServerListPanel.mServerListScrollView = UIServerListPanel:GetCurComp("WidgetRoot/ServerList", "UIScrollView")
    end
    return UIServerListPanel.mServerListScrollView
end
---@return UIGridContainer 渠道格子
function UIServerListPanel.RegionGrids_UIGridContainer()
    if UIServerListPanel.mRegionGrids == nil then
        UIServerListPanel.mRegionGrids = UIServerListPanel:GetCurComp("WidgetRoot/RegionTable", "UIGridContainer")
    end
    return UIServerListPanel.mRegionGrids
end
---渠道ScrollView
function UIServerListPanel.RegionList_UIScrollView()
    if UIServerListPanel.mRegionListScrollView == nil then
        UIServerListPanel.mRegionListScrollView = UIServerListPanel:GetCurComp("WidgetRoot/RegionTable", "UIScrollView")
    end
    return UIServerListPanel.mRegionListScrollView
end
---@return UIToggle 我的区服按钮
function UIServerListPanel.GetSelfServerToggle_UIToggle()
    if UIServerListPanel.mSelfServerToggle == nil then
        UIServerListPanel.mSelfServerToggle = UIServerListPanel:GetCurComp("WidgetRoot/SelfServerToggle", "UIToggle")
    end
    return UIServerListPanel.mSelfServerToggle
end
---关闭按钮
function UIServerListPanel.GetCloseBtn_GameObject()
    if UIServerListPanel.mCloseBtn_GameObject == nil then
        UIServerListPanel.mCloseBtn_GameObject = UIServerListPanel:GetCurComp("WidgetRoot/btn_close", "GameObject")
    end
    return UIServerListPanel.mCloseBtn_GameObject
end

---显示隐藏服务器列表按钮
function UIServerListPanel:GetShowHideServerListBtn_Go()
    if self.mShowHideBtn == nil then
        self.mShowHideBtn = self:GetCurComp("WidgetRoot/Sprite3", "GameObject")
    end
    return self.mShowHideBtn
end
--endregion

--region 属性
---推荐区服数据list
function UIServerListPanel.RecommendServer()
    if UIServerListPanel.mRecommendServer == nil then
        UIServerListPanel.mRecommendServer = UIServerListPanel.ServerFile.RecommendServerId
    end
    return UIServerListPanel.mRecommendServer
end

---@return HttpRequest
function UIServerListPanel:HttpRequestInstance()
    if self.mHttpRequest == nil then
        self.mHttpRequest = CS.HttpRequest.Instance
    end
    return self.mHttpRequest
end

---@return table<string,System.Object> 没有数据不知道怎么解析，之后再改
function UIServerListPanel:GetServerNameList()
    if self.mServerNameList == nil then
        self.mServerNameList = self:HttpRequestInstance().ServerNameDic
    end
    return self.mServerNameList
end

--endregion

--region 初始化
---@type CSServerFile 服务器列表文件
UIServerListPanel.ServerFile = nil

---所有服务器大区（其实是Dictionary类型）
---@type table<number,CSServerRegion>
UIServerListPanel.AllServerRegion = nil

---显示的服务器列表
UIServerListPanel.CurServerFileTable = {}
function UIServerListPanel:Init()
    UIServerListPanel:BindMessage()
    UIServerListPanel:ShowNowData()
end

function UIServerListPanel:BindMessage()
    CS.EventDelegate.Add(UIServerListPanel.GetSelfServerToggle_UIToggle().onChange, function()
        UIServerListPanel.OnClickSelfServerToggle(UIServerListPanel.GetSelfServerToggle_UIToggle().value)
    end)
    CS.UIEventListener.Get(self.GetCloseBtn_GameObject()).onClick = function()
        self:ClosePanel()
    end

    CS.UIEventListener.Get(self:GetShowHideServerListBtn_Go()).onClick = function(go)
        self:OnShowHideServerListBtnClicked()
    end

    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_RefushSelfIp, function(id, data)
        self:GetWhiteIpData(data)
    end)
end
--endregion

function UIServerListPanel:ShowNowData()
    UIServerListPanel.ServerFile = self:HttpRequestInstance().ServerFile
    if (UIServerListPanel.ServerFile == nil) then
        print("服务器文件数据加载有异常")
        return
    end
    UIServerListPanel.AllServerRegion = UIServerListPanel.ServerFile:GetAllServerRegion(false);

    self:InitRegionTable()
    self:InitServerListTable()
    self:InitDefaultTable()
    self:InitLastLoginSever()
    --UIServerListPanel.ShowNormalTable()
    --UIServerListPanel.RefreshLastLogin()
    --UIServerListPanel.RefreshRecommend()
end

---所有的分区
---@type table<number,CSServerSubarea> 分区列表
UIServerListPanel.SubareaList = nil
---当前选中分区服务器信息List
---@type table<string,table<number,CSServerItem>>
UIServerListPanel.ServerTableList = {}
UIServerListPanel.RegionStartIndex = {};--渠道的

---@type table<string,number> 渠道id tostring(subarea.SubareaID) 对应开始Index
UIServerListPanel.SubareaStartIndex = {};
--region 初始化渠道列表
---初始化渠道列表
function UIServerListPanel:InitRegionTable()
    if UIServerListPanel.RegionGrids_UIGridContainer() == nil then
        return
    end
    --分区列表
    UIServerListPanel.SubareaList = {};
    local count = 0;
    --遍历所有的大区
    CS.Utility_Lua.luaForeachCsharp:Foreach(UIServerListPanel.AllServerRegion, function(id, CSServerRegion)
        CS.Utility_Lua.luaForeachCsharp:Foreach(CSServerRegion.SubareaDic, function(id, CSServerSubarea)
            table.insert(UIServerListPanel.SubareaList, CSServerSubarea);
            count = count + 1;
        end)
    end)

    --UIServerListPanel.RegionGrids_UIGridContainer().gameObject:SetActive(count > 1);
    if (count <= 1) then
        UIServerListPanel.RegionGrids_UIGridContainer().MaxCount = 0
        return ;
    end
    self.mRegionNameToGo = {}
    UIServerListPanel.RegionGrids_UIGridContainer().MaxCount = count
    for i = 0, count - 1 do
        local gp = UIServerListPanel.RegionGrids_UIGridContainer().controlList[i].gameObject;
        local lb_name = CS.Utility_Lua.GetComponent(gp.transform:Find("name"), "UILabel")
        lb_name.text = UIServerListPanel.SubareaList[i + 1].name
        local regionName = tostring(UIServerListPanel.SubareaList[i + 1].SubareaID)
        gp.name = regionName
        UIServerListPanel.RegionStartIndex[regionName] = i;
        self.mRegionNameToGo[regionName] = gp
        CS.UIEventListener.Get(gp).onClick = UIServerListPanel.OnRegionClicked
    end
end
--endregion

--region 初始化服务器清单列表(1-100服,101-200服)
---初始化服务器清单列表
function UIServerListPanel:InitServerListTable()
    --[[
    UIServerListPanel.TableList_UIGridContainer().MaxCount = 0;

    for k, v in pairs(UIServerListPanel.SubareaList) do
        self:AddSubareaListTable(v)
    end
    --]]

    local subareaList = self:AnalyzeSubareaList()
    self:GetSubareaList_LoopScrollViewPlus():Init(function(go, line)
        if line < #subareaList then
            self:RefreshSubareaListSingleGrid(go, line, subareaList[line + 1])
            return true
        else
            return false
        end
    end, function()
    end)
end

---解析大区数据
function UIServerListPanel:AnalyzeSubareaList()
    local totalList = {}
    for k, v in pairs(self.SubareaList) do
        ---@type  CSServerSubarea
        local subarea = v
        local lineNum = math.ceil(subarea.list.Count / self.size)--占几行
        for i = 0, lineNum - 1 do
            local startIndex = i * self.size
            local gpname = subarea.SubareaID .. "_" .. startIndex

            local endIndex = self.size * (i + 1)
            if endIndex > subarea.list.Count then
                endIndex = subarea.list.Count - 1
            end
            local serverData = subarea:GetServerTable(startIndex, endIndex - startIndex + 1)

            UIServerListPanel.ServerTableList[gpname] = serverData
            local subareaListItem = {}
            subareaListItem.goName = gpname
            subareaListItem.data = serverData
            subareaListItem.subarea = subarea
            table.insert(totalList, subareaListItem)
        end
    end
    return totalList
end

---@param subarea CSServerSubarea  服务器分区(每个大区存在一个服务器列表)---这部分代码暂时没用了，改成新的组件刷新了，但不确定有没有问题，所以先不删
function UIServerListPanel:AddSubareaListTable(subarea)
    if (subarea.list.Count == 0) then
        return ;
    end
    local startCount = UIServerListPanel.TableList_UIGridContainer().MaxCount;
    local count = math.ceil(startCount + subarea.list.Count / UIServerListPanel.size)
    if (startCount == count) then
        return
    end
    UIServerListPanel.SubareaStartIndex[tostring(subarea.SubareaID)] = startCount + 1;
    UIServerListPanel.TableList_UIGridContainer().MaxCount = count
    local startIndex = 0;
    for i = startCount, count - 1 do
        local gp = UIServerListPanel.TableList_UIGridContainer().controlList[i].gameObject;
        local lb_name = CS.Utility_Lua.GetComponent(gp.transform:Find("name"), "UILabel")

        local index = UIServerListPanel.size * (startIndex + 1)
        if index > subarea.list.Count then
            index = subarea.list.Count
        end

        local gpname = subarea.SubareaID .. "_" .. startIndex
        gp.name = gpname
        local serverData = subarea:GetServerTable(startIndex * UIServerListPanel.size, index - startIndex * UIServerListPanel.size)
        UIServerListPanel.ServerTableList[gpname] = serverData

        --  CS.UIEventListener.Get(gp).onClick = UIServerListPanel.OnTableClicked

        local curMax = index
        local showList = self:GetShowServerList(serverData, uiStaticParameter.isOpenWhiteList)
        if (curMax > #showList) then
            curMax = #showList
        end

        local name = subarea.name .. tostring(startIndex * UIServerListPanel.size + 1) .. "-" .. tostring(curMax) .. "服";

        lb_name.text = name
        startIndex = startIndex + 1;
    end
end

---刷新大区单个格子
function UIServerListPanel:RefreshSubareaListSingleGrid(go, line, subareaData)
    local lb_name = CS.Utility_Lua.GetComponent(go.transform:Find("name"), "UILabel")
    local info = subareaData
    ---@type string
    local goName = subareaData.goName
    ---@type System.Collections.Generic.List1CSServerItem
    local data = subareaData.data
    ---@type string
    local subareaName
    if subareaData.subarea then
        subareaName = subareaData.subarea.name
    end
    local serverData = data
    CS.UIEventListener.Get(go).onClick = function()
        self:OnTableClicked(go, info)
    end

    local curMax = (line + 1) * self.size
    local showList = self:GetShowServerList(serverData, uiStaticParameter.isOpenWhiteList)
    if (curMax > #showList) then
        curMax = #showList + line * UIServerListPanel.size
    end

    local name = subareaName .. tostring(line * UIServerListPanel.size + 1) .. "-" .. tostring(curMax) .. "服";
    lb_name.text = name
    if line == 0 then
        ---@type UIToggle
        local toggle = CS.Utility_Lua.GetComponent(go, "UIToggle")
        toggle:Set(true, true)
        self:OnTableClicked(go, info)
    end
end

--endregion

--region 初始化默认选择的点击大区/服务器列表
---初始化默认选择的点击大区
function UIServerListPanel:InitDefaultTable()
    local selfList = UIServerListPanel.ServerFile.SelfServerList
    --如果有个人数据则先显示个人数据
    if selfList and selfList.Count > 0 then
        self.GetSelfServerToggle_UIToggle():Set(true, true)
        return
    end
    --显示渠道数据
    local defaultRegion = UIServerListPanel.ServerFile:GetDefaultRegion();
    defaultRegion = 4001
    --[[
     if (UIServerListPanel.RegionGrids_UIGridContainer().controlList.Count > 0) then
         local regionGp = UIServerListPanel.RegionGrids_UIGridContainer().controlList[0];
         local defaultRegionName = tostring(defaultRegion)
         if (defaultRegion ~= 0) then
             if self.mRegionNameToGo then
                 local go = self.mRegionNameToGo[defaultRegionName]
                 if not CS.StaticUtility.IsNull(go) then
                     ---@type UIToggle
                     local toggle = CS.Utility_Lua.GetComponent(go, "UIToggle")
                     toggle:Set(true, true)
                     regionGp = go;
                     UIServerListPanel:MarkRegionPos(defaultRegionName);
                 end
             end
         end
         UIServerListPanel.OnRegionClicked(regionGp)
     else

     end
     --]]
    --[[
    if (UIServerListPanel.TableList_UIGridContainer().controlList.Count > 0) then
        local gp = UIServerListPanel.TableList_UIGridContainer().controlList[0];
        UIServerListPanel.OnTableClicked(gp);
        ---@type UIToggle
        local toggle = CS.Utility_Lua.GetComponent(gp, "UIToggle")
        toggle:Set(true, true)
    end
    --]]
end

--endregion

--region初始化上次登录大区信息
---region初始化上次登录大区信息
function UIServerListPanel:InitLastLoginSever()
    local serverId = 0
    local hasServerInfo = false
    --上次登入服务器
    if CS.UnityEngine.PlayerPrefs.HasKey(CS.HttpRequest.Instance.ServerFile.ServerIdKey) then
        serverId = CS.UnityEngine.PlayerPrefs.GetInt(CS.HttpRequest.Instance.ServerFile.ServerIdKey)
        local serverInfo = self.ServerFile:GetServerItem(serverId)
        if serverInfo then
            local state = serverInfo.State
            self:RecentServerPoint_UISprite().spriteName = self.PointStateSprite[state]
            self:RecentServer_UILabel().text = serverInfo.ServerName
            hasServerInfo = true
        end
    end
    self:RecentServerToggle_UIToggle().gameObject:SetActive(serverId ~= 0 and hasServerInfo)
end

function UIServerListPanel:RefreshLastLoginInfo(info)

end

--endregion

function UIServerListPanel:InitLastTable()
    --local lastServerIndex = CS.UnityEngine.PlayerPrefs.HasKey(CS.HttpRequest.Instance.ServerFile.ServerIdKey)
    --if(lastServerIndex > 0) then
    --    UIServerListPanel.ServerFile:GetServerItem(tonumber(lastServerIndex));
    --end
end

---点击渠道
function UIServerListPanel.OnRegionClicked(go)
    ---定位到当前页签位置
    local endID = UIServerListPanel.SubareaStartIndex[go.name]  --选中id table位置
    if endID == nil then
        return
    end
    UIServerListPanel.TableList_UIScrollView():Begin(CS.UnityEngine.Vector3(-350, 230 + (endID - 1) * 80, 0), 3);

    local info = UIServerListPanel.ServerTableList[go.name .. "_0"]
    if info ~= nil then
        UIServerListPanel.SelectedServerTable = go.name .. "_0"
        UIServerListPanel.ShowServerItem(info, true)
    end

    local obj = UIServerListPanel.TableList_UIGridContainer().controlList[endID - 1];
    if (obj == nil) then
        return
    end
    local Toggle = CS.Utility_Lua.GetComponent(obj, "UIToggle")
    if (Toggle == nil) then
        return
    end
    Toggle.value = true
end

UIServerListPanel.SelectedServerTable = nil
---点击区服
function UIServerListPanel:OnTableClicked(go, subareaData)
    local goName = subareaData.goName
    if goName then
        ---将服务器列表重置到初始位置
        UIServerListPanel.ServerList_UIScrollView():ResetPosition()
        ---@type table<number,CSServerItem>
        local info = UIServerListPanel.ServerTableList[goName]
        if info == nil then
            return
        end
        UIServerListPanel.SelectedServerTable = goName
        UIServerListPanel.ShowServerItem(info, true)
        local data = string.Split(goName, '_')
        UIServerListPanel:MarkRegionPos(data[1])
    end
end

---显示当前分服的所有服务器
---是List CS.System.Collections.Generic["List`1[CSServerItem]"]
---@param serverList table<number,CSServerItem> 注释table方便查数据
---@param needReverse boolean 是否需要倒序
function UIServerListPanel.ShowServerItem(serverList, needReverse)
    --[[
    UIServerListPanel.CurServerFileTable = {}
        if CS.StaticUtility.IsNull(UIServerListPanel.ServerListGrids()) then
            return
        end
        if serverList == nil then
            UIServerListPanel.ServerListGrids().MaxCount = 0
            return
        end
        --]]
    UIServerListPanel.mCurrentShowServerList = serverList
    --获取需要显示服务器列表
    local showList = UIServerListPanel:GetShowServerList(serverList, uiStaticParameter.isOpenWhiteList)
    UIServerListPanel:ShowServerList(showList, needReverse)
end

---显示服务器列表
---@param needReverse boolean 是否需要倒序
---@param showList table<number,CSServerItem>
function UIServerListPanel:ShowServerList(showList, needReverse)
    if showList == nil then
        return
    end
    if needReverse then
        showList = self:GetReverseTblData(showList)
    end
    -- UIServerListPanel.ServerListGrids().MaxCount = #showList
    local currentChooseServerIndex = -1
    ---@type UILoginPanel
    local loginPanel = uimanager:GetPanel("UILoginPanel")
    if loginPanel then
        currentChooseServerIndex = loginPanel.mServerIndex
    end
    self:GetServerList_LoopScrollViewPlus():Init(function(go, line)
        local maxLine = math.ceil(#showList / 2)
        if line < maxLine then
            ---@type UIGridContainer
            local container = CS.Utility_Lua.Get(go.transform, "child", "UIGridContainer")
            local index = 2 * line + 2
            local maxItem = 2
            if index > #showList then
                maxItem = 1
            end
            container.MaxCount = maxItem
            for i = 0, maxItem - 1 do
                local gp = container.controlList[i].gameObject
                local lineIndex = 2 * line + 1 + i
                if lineIndex <= #showList and lineIndex > 0 then
                    local ServerInfo = showList[lineIndex]
                    self:RefreshServerListItem(gp, lineIndex, ServerInfo, currentChooseServerIndex)
                end
            end
            return true
        else
            return false
        end
    end, function()
    end)
end

---反向排序
function UIServerListPanel:GetReverseTblData(showList)
    local newTbl = {}
    for i = #showList, 1, -1 do
        table.insert(newTbl, showList[i])
    end
    return newTbl
end

---@param ServerInfo CSServerItem
function UIServerListPanel:RefreshServerListItem(go, line, ServerInfo, currentChooseServerIndex)
    if not CS.StaticUtility.IsNull(go) and line and ServerInfo then
        local gp = go
        local i = line
        ---@type UIToggle
        local toggle = CS.Utility_Lua.GetComponent(gp.transform, "UIToggle")
        toggle:Set(currentChooseServerIndex == ServerInfo.ServerID)
        --服务器名字
        local lb_name = CS.Utility_Lua.GetComponent(gp.transform:Find("name"), "UILabel")
        lb_name.text = ServerInfo.ServerName
        --服务器推荐状态
        local isShowRecommend = ServerInfo.ServerID == UIServerListPanel.RecommendServer()
        ---@type UnityEngine.GameObject
        local recommend = gp.transform:Find("Table/recommend").gameObject
        recommend:SetActive(isShowRecommend)
        --服务器状态(现在没有即是新服又火爆的状态)
        local state = ServerInfo.State
        ---@type UIGridContainer
        local Grid = CS.Utility_Lua.GetComponent(gp.transform:Find("Table/Grid"), "UIGridContainer")
        local spriteList = {}
        --是否有账号
        local hasAccountNumber = UIServerListPanel:GetHasRole(ServerInfo.ServerID)
        ---角色数量
        local roleNum = ServerInfo.RoleNum
        --是否新服或者火爆
        local isNewOrFull = state == LuaEnumServerState.NewServer
        -- or state == LuaEnumServerState.Full 火爆不显示图片
        local gridNum = 0
        if isNewOrFull and not isShowRecommend then
            gridNum = gridNum + 1
            table.insert(spriteList, UIServerListPanel.StateSprite[state])
        end
        if roleNum > 0 then
            gridNum = gridNum + 1
            local roleSpriteName = ternary(roleNum > 1, "roles", "role")
            table.insert(spriteList, roleSpriteName)
        end
        Grid.MaxCount = gridNum
        for i = 0, gridNum - 1 do
            local sprite = CS.Utility_Lua.GetComponent(Grid.controlList[i], "UISprite")
            sprite.spriteName = spriteList[i + 1]
        end
        local staticPos = Grid.transform.localPosition
        local width = Grid.CellWidth
        local posX = staticPos.x - gridNum * width - width / 2
        staticPos.x = posX
        recommend.transform.localPosition = staticPos

        --火爆/畅通 点
        local point = CS.Utility_Lua.GetComponent(gp.transform:Find("point"), "UISprite")
        point.spriteName = UIServerListPanel.PointStateSprite[state]
        gp.name = tostring(i)
        --UIServerListPanel.CurServerFileTable[gp] = ServerInfo
        CS.UIEventListener.Get(gp).onClick = function(go)
            self:OnServerClicked(go, ServerInfo)
        end
    end
    ---将服务器列表重置到初始位置
    --UIServerListPanel.ServerList_UIScrollView():ResetPosition()
end

---点击服务器
function UIServerListPanel:OnServerClicked(go, serverItem)
    ---@type table<number,CSServerItem>
    --local serverTableList = UIServerListPanel.ServerTableList[UIServerListPanel.SelectedServerTable]
    --if (serverTableList == nil) then
    --    return
    --end
    --local serverIndex = tonumber((go.name))
    --local serverItem = serverTableList[serverIndex]
    --if (serverItem == nil) then
    --    return
    --end
    local serverItem = serverItem
    if serverItem == nil then
        return
    end
    uimanager:ClosePanel('UIServerListPanel')
    UIServerListPanel:GetClientEventHandler():SendEvent(CS.CEvent.V2_UpdateSelectedServer, serverItem)
end

---@param serverList table<number,CSServerItem> 服务器列表
---@param isAvoidIsShow boolean 是否显示隐藏分区（true是要显示）
function UIServerListPanel:GetShowServerList(serverList, isAvoidIsShow)
    local list = {}
    if serverList then
        for i = 0, serverList.Count - 1 do
            ---@type CSServerItem
            local serverInfo = serverList[i]
            if serverInfo ~= nil and serverInfo.IsShow or isAvoidIsShow then
                table.insert(list, serverInfo)
            end
        end
    end
    return list
end

---适配Table页签
function UIServerListPanel.MarkTablePos(go)
end

---适配region页签
function UIServerListPanel:MarkRegionPos(regionID)
    local endID = UIServerListPanel.RegionStartIndex[regionID]  --选中id table位置
    if endID == nil then
        return
    end
    UIServerListPanel.RegionList_UIScrollView():Begin(CS.UnityEngine.Vector3(-182 - 128 * endID, 320, 0), 3);
    local obj = UIServerListPanel.RegionGrids_UIGridContainer().controlList[endID];
    if (obj == nil) then
        return
    end
    local Toggle = CS.Utility_Lua.GetComponent(obj, "UIToggle")
    if (Toggle == nil) then
        return
    end
    Toggle.value = true
end
--endregion

---点击我的区服
function UIServerListPanel.OnClickSelfServerToggle(isClicked)
    if isClicked then
        UIServerListPanel.ShowServerItem(UIServerListPanel.ServerFile.SelfServerList, false)
    end
end

---点击隐藏按钮
function UIServerListPanel:OnShowHideServerListBtnClicked()
    if self.mLastClickTime ~= nil then
        if CS.UnityEngine.Time.time - self.mLastClickTime < self.mClickHidBtnEffectiveTime then
            self.mClickHideBtnCount = self.mClickHideBtnCount + 1
            if self.mClickHideBtnCount >= self.mNeedClickTimes then
                self.ServerFile:GetInternalIP()
                self:CloseHideBtnData()
            end
        else
            self:CloseHideBtnData()
        end
    else
        self.mClickHideBtnCount = UIServerListPanel.mClickHideBtnCount + 1
    end
    self.mLastClickTime = CS.UnityEngine.Time.time
end

---清空当前隐藏按钮数据
function UIServerListPanel:CloseHideBtnData()
    self.mLastClickTime = nil
    self.mClickHideBtnCount = 0
end

---后台返回白名单数据
function UIServerListPanel:GetWhiteIpData(selfIp)
    if self.ServerFile:IsAdminUser(selfIp) then
        uiStaticParameter.isOpenWhiteList = true
        if self.mCurrentShowServerList then
            local showList = self:GetShowServerList(self.mCurrentShowServerList, true)
            self:ShowServerList(showList, true)
        end
        self:GetClientEventHandler():SendEvent(CS.CEvent.V2_UnionScoreChange, "白名单Open")
        CS.Constant.IsWhiteIp = true
    end
end

--region 当前版本

--region 刷新区服
---区服图标显示（火爆/新服/爆满/维护）
function UIServerListPanel.GetPoint(num)
    if num == 1 then
        return "11"--新服
    elseif num == 2 then
        return "11"--畅通
    elseif num == 3 then
        return "14"--爆满
    else
        return "12"--维护
    end
end

---是是否有角色
function UIServerListPanel:GetHasRole(serverId)
    if self:GetServerNameList() ~= nil and self:GetServerNameList().Count > 0 then
        local res, roleInfo = self:GetServerNameList():TryGetValue(serverId)
        if res then
            return true
        end
    end
    return false
end
--endregion

---刷新推荐区服
function UIServerListPanel.RefreshRecommend()
    if UIServerListPanel.RecommendedServerToggle_UIToggle() == nil then
        return
    end
    if UIServerListPanel.RecommendServer() == nil then
        UIServerListPanel.RecommendedServerToggle_UIToggle().gameObject:SetActive(false)
        return
    end
    UIServerListPanel.RecommendedServerToggle_UIToggle().gameObject:SetActive(true)
    local recommondServer = UIServerListPanel.RecommendServer()
    CS.Utility_Lua.GetComponent(UIServerListPanel.RecommendedServerToggle_UIToggle().transform:Find("name"), "UILabel").text = recommondServer[0]
    local state = tonumber(recommondServer[2]);
    CS.Utility_Lua.GetComponent(UIServerListPanel.RecommendedServerToggle_UIToggle().transform:Find("point"), "UISprite").spriteName = UIServerListPanel.GetPoint(state)
    local sp_tex = CS.Utility_Lua.GetComponent(UIServerListPanel.RecommendedServerToggle_UIToggle().transform:Find("tex"), "UISprite")
    if state == 1 or state == 3 then
        sp_tex.gameObject:SetActive(true)
        sp_tex.spriteName = ternary(state == 3, "3", "2")
    else
        sp_tex.gameObject:SetActive(false)
    end
    CS.UIEventListener.Get(UIServerListPanel.RecommendedServerToggle_UIToggle().gameObject, recommondServer).onClick = UIServerListPanel.OnAddressClick
end
--endregion

--region onDestroy
function ondestroy()
    local uiLoginPanel = uimanager:GetPanel("UILoginPanel")
    if uiLoginPanel ~= nil then
        uiLoginPanel.ControlServerListRelevancePanel(true)
    end
    StopCoroutine(UIServerListPanel. mIEnumRequestData)
end
--endregion

return UIServerListPanel