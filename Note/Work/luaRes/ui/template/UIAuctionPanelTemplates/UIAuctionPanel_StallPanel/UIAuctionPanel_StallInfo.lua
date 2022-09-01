---@class UIAuctionPanel_StallInfo:TemplateBase 摊位信息模板
local UIAuctionPanel_StallInfo = {}
--region 属性
---获取面板的客户端消息Handler
---@return EventHandlerManager
function UIAuctionPanel_StallInfo:GetClientEventHandler()
    if self == nil then
        return
    end
    if self.mClient == nil then
        self.mClient = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)--客户端事件
    end
    return self.mClient
end
--endregion

function UIAuctionPanel_StallInfo:Init(stallPanelTemplate)
    self.stallPanelTemplate = stallPanelTemplate
    self.chooseNameList = nil
    self:InitCompoment()
    self:InitTemplate()
    self:BindEvent()
end

function UIAuctionPanel_StallInfo:InitCompoment()
    self.Name_GameObject = self:Get("Name", "GameObject")
    self.Time_GameObject = self:Get("Time", "GameObject")
    self.Position_GameObject = self:Get("Position", "GameObject")
    self.btn_stall_GameObject = self:Get("StallBtn", "GameObject")
    self.btn_stall_label = self:Get("StallBtn/label", "UILabel")
    self.itemgold_UILabel = self:Get("itemgold", "UILabel")
    self.itemgold_UISprite = self:Get("itemgold/Sprite", "UISprite")
    self.RefreshPositionBtn = self:Get("Position/RefreshBtn", "GameObject")
    self.helpBtn = self:Get("btn_help", "GameObject")
    self.chooseTable = {
        name = {},
        stallCost = 0,
        map = 0
    }
end

function UIAuctionPanel_StallInfo:OnEnable()
    ---摊位初始坐标请求盟重土城
    if CS.CSScene.MainPlayerInfo.AuctionInfo.BoothInfo == nil then
        networkRequest.ReqGetUpdateBoothPoint(CS.CSScene.MainPlayerInfo.AuctionInfo.MapId)
    end
end

function UIAuctionPanel_StallInfo:Start()
    ---刷新摊位地图标题名字
    self.RefreshBoothPosition = function(msgId, boothTitleName)
        if boothTitleName ~= nil and self.Map_MultitermChooseTemplate ~= nil then
            local curBoothTitleName = boothTitleName
            ---没有空余摊位的时候变更标题内容
            if CS.CSScene.MainPlayerInfo.AuctionInfo.BoothInfo == nil and (CS.CSScene.MainPlayerInfo.AuctionInfo.NoBoothPositionInfo == nil or CS.CSScene.MainPlayerInfo.AuctionInfo.NoBoothPositionInfo.boothCoordinateId == 0) then
                curBoothTitleName = "没有空余摊位"
            end
            self.Map_MultitermChooseTemplate:SetTitleName(curBoothTitleName)
        end
    end
    ---摊位发生变更
    self.BoothPositionChange = function()
        self:OnBoothPositionChangeCallBack()
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BoothPositionChange, self.BoothPositionChange)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_RefreshBoothPosition, self.RefreshBoothPosition)
end

function UIAuctionPanel_StallInfo:InitTemplate()
    ---摊位名字
    ---@type MultitermChooseTemplate
    self.Name_MultitermChooseTemplate = templatemanager.GetNewTemplate(self.Name_GameObject, luaComponentTemplates.MultitermChooseTemplate)
    ---摊位花费
    ---@type MultitermChooseTemplate
    self.Time_MultitermChooseTemplate = templatemanager.GetNewTemplate(self.Time_GameObject, luaComponentTemplates.MultitermChooseTemplate)
    ---地图
    ---@type MultitermChooseTemplate
    self.Map_MultitermChooseTemplate = templatemanager.GetNewTemplate(self.Position_GameObject, luaComponentTemplates.MultitermChooseTemplate)
end

function UIAuctionPanel_StallInfo:BindEvent()
    CS.UIEventListener.Get(self.btn_stall_GameObject).onClick = function(go)
        self:OnClickStallBtnCallBack(go)
    end

    CS.UIEventListener.Get(self.RefreshPositionBtn).onClick = function()
        local boothInfo = CS.CSScene.MainPlayerInfo.AuctionInfo.BoothInfo
        if boothInfo == nil then
            local mapId = self:GetMapId()
            if mapId ~= 0 then
                networkRequest.ReqGetUpdateBoothPoint(mapId)
            end
        else
            networkRequest.ReqGetUpdateBoothPoint(boothInfo.boothMapId)
        end
    end

    CS.UIEventListener.Get(self.helpBtn).onClick = function()
        local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(178)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
        end
    end
end

function UIAuctionPanel_StallInfo:OnClickStallBtnCallBack(go)
    local boothInfo = CS.CSScene.MainPlayerInfo.AuctionInfo.BoothInfo
    if boothInfo == nil then
        self:GetChooseListTable()
        if self:IsCanCreateBooth(self.chooseTable.stallCost) then
            if CS.CSScene.MainPlayerInfo.AuctionInfo.NoBoothPositionInfo == nil or CS.CSScene.MainPlayerInfo.AuctionInfo.NoBoothPositionInfo.boothCoordinateId == 0 then
                Utility.ShowPopoTips(go.transform, nil, 264)
                return
            end
            networkRequest.ReqCreateBooth(self.chooseTable.name, self.chooseTable.stallCost, CS.CSScene.MainPlayerInfo.AuctionInfo.NoBoothPositionInfo.boothCoordinateId)
        end
    else
        networkRequest.ReqCancelBooth()
    end
end

function UIAuctionPanel_StallInfo:OnBoothPositionChangeCallBack()
    local position = CS.CSScene.MainPlayerInfo.AuctionInfo.newBoothPosition
    if CS.CSScene.MainPlayerInfo.AuctionInfo.HaveBoothPositionInfo == nil or CS.CSScene.MainPlayerInfo.AuctionInfo.HaveBoothPositionInfo.boothCoordinateId == 0 then
        Utility.ShowPopoTips(self.RefreshPositionBtn.transform, nil, 264)
        return
    end
    Utility.ShowSecondConfirmPanel({ PromptWordId = 66, des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(66, Utility.GetIntPart(position.x), Utility.GetIntPart(position.y)), ComfireAucion = function()
        networkRequest.ReqUpdateBoothPoint(CS.CSScene.MainPlayerInfo.AuctionInfo.HaveBoothPositionInfo.boothCoordinateId)
    end })
end

function UIAuctionPanel_StallInfo:RefreshBtnLabel(text)
    if self.btn_stall_label ~= nil then
        self.btn_stall_label.text = text
    end
end

function UIAuctionPanel_StallInfo:IsCanCreateBooth(stallCostId)
    local isCanCreate = false
    local stallCostInfoIsFind, stallCostInfo = CS.Cfg_StallCostTableManager.Instance:TryGetValue(stallCostId)
    if stallCostInfoIsFind then
        local cost = stallCostInfo.cost
        if cost ~= nil and cost.list.Count >= 2 then
            local playerCoinNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinNum(cost.list[0])
            if playerCoinNum >= cost.list[1] then
                isCanCreate = true
            else
                local promptInfoIsFind, prompInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(107)
                local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(cost.list[0])
                if promptInfoIsFind == true and itemInfoIsFind == true then
                    local tipsString = string.format(prompInfo.content, itemInfo.name)
                    Utility.ShowPopoTips(self.btn_stall_GameObject, tipsString, 107)
                end
            end
        end
    end
    return isCanCreate
end



--region 摊位名字
function UIAuctionPanel_StallInfo:RefreshNameTemplate(openTween, chooseTable)
    local customData = {
        showTable = self:GetNameTable(),
        callBack = function(multitermChooseTemplate, chooseList)
            self:NameBtnCallBack(multitermChooseTemplate, chooseList)
        end,
        openTween = openTween
    }
    self.Name_MultitermChooseTemplate:RefreshContent(customData)
    if chooseTable and type(chooseTable) == "table" then
        self.Name_MultitermChooseTemplate:SetChooseListAndChangeTitleName(chooseTable)
    end
    if CS.CSScene.MainPlayerInfo.AuctionInfo.NoBoothPositionInfo == nil or CS.CSScene.MainPlayerInfo.AuctionInfo.NoBoothPositionInfo.boothCoordinateId == 0 then

    end
end

---刷新摊位名字的标题并控制tween
function UIAuctionPanel_StallInfo:RefreshStallNameTitleAndTween(openTween, titleName)
    if self.Name_MultitermChooseTemplate ~= nil and self.Name_MultitermChooseTemplate.RefreshTieleNameAndChangeTween ~= nil then
        self.Name_MultitermChooseTemplate:RefreshTieleNameAndChangeTween(openTween, titleName)
    end
end

---获取名字显示列表
function UIAuctionPanel_StallInfo:GetNameTable()
    local nameArray = CS.Cfg_GlobalTableManager.Instance:GetStallNameArray()
    local nameTable = {}
    local length = nameArray.Length - 1
    for k = 0, length do
        local v = nameArray[k]
        table.insert(nameTable, v)
    end
    return nameTable
end

---名字按钮点击回调
function UIAuctionPanel_StallInfo:NameBtnCallBack(multitermChooseTemplate, chooseList)
    ---数据存储
    if chooseList ~= nil and chooseList.Count > 0 then
        if self.stallPanelTemplate ~= nil and CS.CSScene.MainPlayerInfo.AuctionInfo:IsHaveBooth() == true then
            --networkRequest.ReqChangeBoothName(chooseList)
            self.chooseNameList = chooseList
        end
    end
end
--endregion

--region 摊位花费
---刷新摊位花费信息
---@param hasStall boolean 是否有摊位
function UIAuctionPanel_StallInfo:RefreshStallInfoTemplate(hasStall, chooseTable)
    local stallType = LuaEnumStallType.MainServer
    local mapList = CS.CSScene.MainPlayerInfo.AuctionInfo.MapList
    if mapList ~= nil and mapList.Count > 0 then
        local mapId = mapList[0]
        if mapId ~= nil then
            stallType = ternary(clientTableManager.cfg_mapManager:IsKuaFuMap(mapId), LuaEnumStallType.CrossServer, LuaEnumStallType.MainServer)
        end
    end
    local customData = {
        showTable = self:GetStallInfoTable(stallType),
        stallInfoList = self.stallInfoList,
        callBack = function(multitermChooseTemplate, chooseList, stallInfo)
            self:StallInfoCallBack(multitermChooseTemplate, chooseList, stallInfo)
        end,
    }
    self.Time_MultitermChooseTemplate:RefreshContent(customData)
    if chooseTable and type(chooseTable) == "table" then
        self.Time_MultitermChooseTemplate:SetChooseListAndChangeTitleName(chooseTable)
    end

    ---刷新标题和按钮显示
    self.Time_MultitermChooseTemplate:SetBtnsState(not hasStall)
    self.Time_MultitermChooseTemplate:SetTitleState(hasStall)
    self.itemgold_UILabel.gameObject:SetActive(not hasStall)

    ---刷新摊位花费
    if hasStall == false then
        local stallCostInfo = self:GetStallCostInfo()
        self.itemgold_UILabel.text = tostring(CS.Cfg_StallCostTableManager.Instance:GetPrice(stallCostInfo))
        self.itemgold_UISprite.spriteName = CS.Cfg_StallCostTableManager.Instance:GetPriceIconName(stallCostInfo)
    end
end

---刷新摊位信息的标题并控制tween
function UIAuctionPanel_StallInfo:RefreshStallInfoTitleAndTween(openTween, titleName)
    if self.Time_MultitermChooseTemplate ~= nil and self.Time_MultitermChooseTemplate.RefreshTieleNameAndChangeTween ~= nil then
        self.Time_MultitermChooseTemplate:RefreshTieleNameAndChangeTween(openTween, titleName)
    end
end

---获取摊位信息显示列表
function UIAuctionPanel_StallInfo:GetStallInfoTable(stallType)
    self.stallInfoList = CS.Cfg_StallCostTableManager.Instance:GetAllStallCostInfo(stallType)
    local stallShowContentList = CS.CSScene.MainPlayerInfo.AuctionInfo:GetStallShowContentListByAnalysisList(self.stallInfoList)
    local stallShowContentTable = {}
    local length = stallShowContentList.Count - 1
    for k = 0, length do
        local v = stallShowContentList[k]
        table.insert(stallShowContentTable, v)
    end
    self:InitStallIdAndIndex()
    return stallShowContentTable
end

---初始化摊位id和index
function UIAuctionPanel_StallInfo:InitStallIdAndIndex()
    self.stallIdAndIndexTable = {}
    if self.stallInfoList ~= nil then
        local length = self.stallInfoList.Count - 1
        for k = 0, length do
            local stallId = self.stallInfoList[k]
            self.stallIdAndIndexTable[stallId.id] = k + 1
        end
    end
end

---摊位按钮点击回调
function UIAuctionPanel_StallInfo:StallInfoCallBack(multitermChooseTemplate, chooseList, stallInfo)
    ---数据存储
    if chooseList ~= nil and chooseList.Count > 0 and self.stallInfoList.Count > 0 then
        if stallInfo ~= nil then
            self.itemgold_UILabel.text = tostring(CS.Cfg_StallCostTableManager.Instance:GetPrice(stallInfo))
            self.itemgold_UISprite.spriteName = CS.Cfg_StallCostTableManager.Instance:GetPriceIconName(stallInfo)
        end
    end
end

---刷新时间
function UIAuctionPanel_StallInfo:RreshTitleInfoTime()
    local refreshTitleName = function()
        local boothInfo = CS.CSScene.MainPlayerInfo.AuctionInfo.BoothInfo
        local remainTime = boothInfo.overdueTime - CS.CSServerTime.Instance.TotalMillisecond
        while remainTime > 0 do
            local hour, minute, second = Utility.MillisecondToFormatTime(remainTime)
            local str = Utility.GetIntPart(hour) .. "小时" .. Utility.GetIntPart(minute) .. "分" .. Utility.GetIntPart(second) .. "秒"
            self.Time_MultitermChooseTemplate:SetTitleName(str)
            coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
            remainTime = boothInfo.overdueTime - CS.CSServerTime.Instance.TotalMillisecond
        end
    end
    self:StopRefreshTitleInfoTime()
    UIAuctionPanel_StallInfo.RefreshTime = StartCoroutine(refreshTitleName)
end

function UIAuctionPanel_StallInfo:StopRefreshTitleInfoTime()
    if UIAuctionPanel_StallInfo.RefreshTime ~= nil then
        StopCoroutine(UIAuctionPanel_StallInfo.RefreshTime)
        UIAuctionPanel_StallInfo.RefreshTime = nil
    end
end
--endregion

--region 摊位地图
---刷新地图信息列表
function UIAuctionPanel_StallInfo:RefreshMapInfoTable(openTween, chooseTable)
    local customData = {
        showTable = self:GetStallMapTable(),
        callBack = function(multitermChooseTemplate, chooseList)
            self:mapBtnOnClick(multitermChooseTemplate, chooseList)
        end,
        openTween = openTween
    }
    self.Map_MultitermChooseTemplate:RefreshContent(customData)
    if chooseTable and type(chooseTable) == "table" then
        self.Map_MultitermChooseTemplate:SetChooseListAndChangeTitleName(chooseTable)
    end
    ---没有空余摊位的时候变更标题内容
    if CS.CSScene.MainPlayerInfo.AuctionInfo.BoothInfo == nil and (CS.CSScene.MainPlayerInfo.AuctionInfo.NoBoothPositionInfo == nil or CS.CSScene.MainPlayerInfo.AuctionInfo.NoBoothPositionInfo.boothCoordinateId == 0) then
        self.Map_MultitermChooseTemplate:SetTitleName("没有空余摊位")
    end
end

---刷新地图的标题并控制tween
function UIAuctionPanel_StallInfo:RefreshMapTitleAndTween(openTween, titleName)
    if self.Map_MultitermChooseTemplate ~= nil and self.Map_MultitermChooseTemplate.RefreshTieleNameAndChangeTween ~= nil then
        self.Map_MultitermChooseTemplate:RefreshTieleNameAndChangeTween(openTween, titleName)
    end
end

---获取摊位地图显示列表
function UIAuctionPanel_StallInfo:GetStallMapTable()
    local mapNameList = CS.CSScene.MainPlayerInfo.AuctionInfo:GetStallMapInfoList()
    local mapNameTable = {}
    local length = mapNameList.Count - 1
    for k = 0, length do
        local v = mapNameList[k]
        table.insert(mapNameTable, v)
    end
    self:InitMapIdAndIndex()
    return mapNameTable
end

---初始化mapid和index
function UIAuctionPanel_StallInfo:InitMapIdAndIndex()
    local mapInfoList = CS.CSScene.MainPlayerInfo.AuctionInfo:GetMapInfoList()
    self.mapIdAndIndexTable = {}
    local length = mapInfoList.Count - 1
    for k = 0, length do
        local mapInfo = mapInfoList[k]
        self.mapIdAndIndexTable[mapInfo.id] = k + 1
    end
end

---地图按钮点击回调
function UIAuctionPanel_StallInfo:mapBtnOnClick(multitermChooseTemplate, chooseList)
    ---数据存储
    if chooseList ~= nil and chooseList.Count > 0 then
    end
end
--endregion

--region 获取
---获取服务器需要的选项参数
function UIAuctionPanel_StallInfo:GetChooseListTable()
    if self.Name_MultitermChooseTemplate ~= nil and self.Time_MultitermChooseTemplate ~= nil and self.Map_MultitermChooseTemplate ~= nil then
        self.chooseTable.name = self:GetNameList()

        local stallInfo = self:GetStallCostInfo()
        if stallInfo == nil then
            return
        end
        self.chooseTable.stallCost = stallInfo.id

        self.chooseTable.map = self:GetMapId()
    end
    return self.chooseTable
end

---获取当前选择的摊位花费表
function UIAuctionPanel_StallInfo:GetStallCostInfo()
    local chooseIndex = self.Time_MultitermChooseTemplate:GetChooseList()[0]
    local stallInfo = nil
    if chooseIndex - 1 >= 0 and chooseIndex - 1 < self.stallInfoList.Count then
        stallInfo = self.stallInfoList[chooseIndex - 1]
    end
    return stallInfo
end

---获取当前选择的名字列表
function UIAuctionPanel_StallInfo:GetNameList()
    return self.Name_MultitermChooseTemplate:GetChooseList()
end

---获取地图id
function UIAuctionPanel_StallInfo:GetMapId()
    local stallType = self.Map_MultitermChooseTemplate:GetChooseList()[0]
    local mapList = CS.CSScene.MainPlayerInfo.AuctionInfo.MapList
    if mapList ~= nil and mapList.Count > 0 then
        local mapId = mapList[stallType - 1]
        return mapId
    end
    return 0
end
--endregion

---控制多项选择锁状态
function UIAuctionPanel_StallInfo:ChangeMultitermChooseState(chooseState)
    if self.Time_MultitermChooseTemplate ~= nil then
        self.Time_MultitermChooseTemplate.StallInfo_MultitermChoose.ChooseLock = chooseState
    end
    if self.Map_MultitermChooseTemplate ~= nil then
        self.Map_MultitermChooseTemplate.StallInfo_MultitermChoose.ChooseLock = chooseState
    end
end

function UIAuctionPanel_StallInfo:RefreshContent()
    self:RefreshStallPosition()
end

function UIAuctionPanel_StallInfo:OnDestroy()
    self:StopRefreshTitleInfoTime()
    networkRequest.ReqChangeBoothName(self:GetNameList())
    self:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_RefreshBoothPosition, self.RefreshBoothPosition)
    self:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_BoothPositionChange, self.BoothPositionChange)
end
return UIAuctionPanel_StallInfo