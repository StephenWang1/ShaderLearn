local UITreasurePanel_Record = {}

function UITreasurePanel_Record:InitComponents()
    ---幸运大奖预览列表
    self.Grid = self:Get("LuckyReward/ScrollView/Grid", "Top_UIGridContainer")

    --- 全服翻牌记录按钮
    self.Btn_mode1 = self:Get("LogPanel/LogBtn/Btn_mode1", "GameObject")
    --- 全服翻牌记录面板
    self.AllRecord = self:Get("LogPanel/AllRecord", "GameObject")
    --- 全服翻牌记录面板
    self.AllRecordPanel = self:Get("LogPanel/AllRecord", "UIPanel")
    --- 全服翻牌记录面板Top_UIScrollView
    self.AllRecord_UIScrollView = self:Get("LogPanel/AllRecord", "Top_UIScrollView")
    --- 全服翻牌记录面板Top_UIPanel
    self.AllRecord_UIPanel = self:Get("LogPanel/AllRecord", "Top_UIPanel")
    --- 全服翻牌记录面板UIProgressBar
    self.AllRecord_progress = self:Get("LogPanel/AllRecord/progress", "Top_UIProgressBar")
    --- 全服翻牌记录列表
    self.AllRecordchlidlist = self:Get("LogPanel/AllRecord/AllRecordchlidlist", "Top_UIGridContainer")
    --- 全服翻牌记录面板SpringPanel
    self.AllRecord_SpringPanel = self:Get("LogPanel/AllRecord", "SpringPanel")

    --- 个人翻牌记录
    self.Btn_mode2 = self:Get("LogPanel/LogBtn/Btn_mode2", "GameObject")
    --- 个人翻牌面板
    self.SelfRecord = self:Get("LogPanel/SelfRecord", "GameObject")
    --- 个人翻牌面板
    self.SelfRecordPanel = self:Get("LogPanel/SelfRecord", "UIPanel")
    --- 个人翻牌面板Top_UIScrollView
    self.SelfRecord_UIScrollView = self:Get("LogPanel/SelfRecord", "Top_UIScrollView")
    --- 个人翻牌面板Top_UIPanel
    self.SelfRecord_UIPanel = self:Get("LogPanel/SelfRecord", "Top_UIPanel")
    ---个人翻牌面板progress
    self.SelfRecord_progress = self:Get("LogPanel/SelfRecord/progress", "Top_UIProgressBar")
    ---个人翻牌列表
    self.SelfRecordchlidlist = self:Get("LogPanel/SelfRecord/SelfRecordchlidlist", "Top_UIGridContainer")
    --- 个人翻牌记录面板SpringPanel
    self.SelfRecord_SpringPanel = self:Get("LogPanel/SelfRecord", "SpringPanel")

end

function UITreasurePanel_Record:InitOther()
    UITreasurePanel_Record.Self = self
    self.TreasureTemplatesList = {}

    CS.UIEventListener.Get(self.Btn_mode1).LuaEventTable = self
    CS.UIEventListener.Get(self.Btn_mode1).OnClickLuaDelegate = self.OnClickAllRecord
    CS.UIEventListener.Get(self.Btn_mode2).LuaEventTable = self
    CS.UIEventListener.Get(self.Btn_mode2).OnClickLuaDelegate = self.OnClickSelfRecord
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServerHistoryMessage, UITreasurePanel_Record.OnResServerHistoryMessage)
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, UITreasurePanel_Record.OnResCommonMessage)
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResReinNumMessage, UITreasurePanel_Record.OnResReinNumMessage)
end

function UITreasurePanel_Record:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel
    self:InitComponents()
    self:InitOther()
    self:RefreshUI()
    networkRequest.ReqServerHistory()
    self.mSelfScrollPosition = self.SelfRecord_UIScrollView.gameObject.transform.localPosition
    self.mAllScrollPosition = self.AllRecord_UIScrollView.gameObject.transform.localPosition
    self:RefreshRecordList(true)
end

function UITreasurePanel_Record:RefreshUI()
    -- self:SetAwardsShowList()
    networkRequest.ReqReinNum(CS.Cfg_GlobalTableManager.Instance.TreasureReinLevelList)
end

---@param csData treasureHuntV2.ReinNumResponse C# class类型消息数据
function UITreasurePanel_Record:SetAwardsShowList(csData)
    local itemidList = CS.CSScene.MainPlayerInfo.TreasureInfo:GteAwardsShowList(csData);
    if itemidList == nil then
        print("CS.CSScene.MainPlayerInfo.TreasureInfo:GteAwardsShowList()为空 请策划检查表格")
        return
    end

    local activityItemList = self:GetActivityItemList()
    if activityItemList then
        self.Grid.MaxCount = itemidList.Count + 8
        for i = 0, self.Grid.MaxCount - 1 do
            local item = self.Grid.controlList[i].gameObject
            local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UITreasurePanel_Item)
            if i < 8 then
                -- 前8个为额外活动item
                if activityItemList[i] ~= nil then
                    template:RefreshUI(activityItemList[i].itemId, nil, self:GetActivityItemEffectID(i))
                end
            else
                local index = i - 8
                if itemidList[index] ~= nil then
                    template:RefreshUI(itemidList[index].itemID, nil, itemidList[index].effectID)
                end
            end
        end
    else
        self.Grid.MaxCount = itemidList.Count
        for i = 0, itemidList.Count - 1 do
            local item = self.Grid.controlList[i].gameObject
            local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UITreasurePanel_Item)
            if itemidList[i] ~= nil then
                template:RefreshUI(itemidList[i].itemID, nil, itemidList[i].effectID)
            end
        end
    end
end

---@return bagV2.CoinInfo
function UITreasurePanel_Record:GetActivityItemList()
    local activityOpenId = self:GetActivityOpenId()
    if activityOpenId == -1 then
        return nil
    end
    local activityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(activityOpenId)
    if activityTbl == nil then
        return nil
    end
    local activityItemList = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(activityTbl.goal.list[1])
    return activityItemList
end

function UITreasurePanel_Record:GetActivityOpenId()
    local activityId1 = 1001001 -- 开服活动-神装首发
    local activityId2 = 2001001 -- 联服活动-神装首发
    local activityId3 = 3001001 -- 合服-神装首发
    local activityId4 = 4001001 -- 节日-神装首发
    local allOpenActivityOpenState = gameMgr:GetPlayerDataMgr():GetSpecialActivityData().mAllOpenActivityOpenState
    if allOpenActivityOpenState[activityId1] then
        return activityId1
    end
    if allOpenActivityOpenState[activityId2] then
        return activityId2
    end

    if allOpenActivityOpenState[activityId3] then
        return activityId3
    end

    if allOpenActivityOpenState[activityId4] then
        return activityId4
    end
    return -1
end

function UITreasurePanel_Record:GetActivityItemEffectID(i)
    if i == 0 or i == 1 then
        return 700142 -- 红
    elseif i == 2 or i == 3 then
        return 700139 -- 黄
    elseif i == 4 or i == 5 then
        return 700141 -- 紫
    elseif i == 6 or i == 7 then
        return 700140 -- 绿
    end
end

--region 点击事件
---全服领奖记录点击事件
function UITreasurePanel_Record:OnClickAllRecord()
    if self.AllRecord_UIScrollView.gameObject.activeInHierarchy == false or true then
        self:RefreshTreasureRecordList(self.AllRecordchlidlist, self.AllRecord_UIScrollView, self.AllRecord_UIPanel, self.mAllTreasureRecordList, self.AllRecord_SpringPanel, self.mAllScrollPosition)
    end
    self.AllRecordPanel.alpha = 1
    self.SelfRecordPanel.alpha = 0
end
---个人领奖记录点击事件
function UITreasurePanel_Record:OnClickSelfRecord()
    if self.SelfRecord_UIScrollView.gameObject.activeInHierarchy == false or true then
        self:RefreshTreasureRecordList(self.SelfRecordchlidlist, self.SelfRecord_UIScrollView, self.SelfRecord_UIPanel, self.mMyTreasureRecordList, self.SelfRecord_SpringPanel, self.mSelfScrollPosition)
    end
    self.AllRecordPanel.alpha = 0
    self.SelfRecordPanel.alpha = 1
end
--endregion

--region 服务器消息
---通用信息整体刷新 历史消息
function UITreasurePanel_Record.OnResCommonMessage(msgId, tblData, csData)
    if tblData.type ~= 5 then
        return
    end
    UITreasurePanel_Record.Self:RefreshRecordList(false)
end
---历史消息
function UITreasurePanel_Record.OnResServerHistoryMessage(msgId, tblData, csData)
    if tblData.type ~= 1 then
        return
    end
    UITreasurePanel_Record.Self:RefreshRecordList(true)
end

function UITreasurePanel_Record:RefreshRecordList(isRefreshAll)
    local ServerHistory = CS.CSScene.MainPlayerInfo.TreasureInfo.ServerHistory
    local Rolehistory = CS.CSScene.MainPlayerInfo.TreasureInfo.Rolehistory
    local self = UITreasurePanel_Record.Self
    self.mMyTreasureRecordList = Rolehistory
    self.mAllTreasureRecordList = ServerHistory
    ---个人
    if self.SelfRecordPanel.alpha == 1 or isRefreshAll then
        self:RefreshTreasureRecordList(self.SelfRecordchlidlist, self.SelfRecord_UIScrollView, self.SelfRecord_UIPanel, self.mMyTreasureRecordList, self.SelfRecord_SpringPanel, self.mSelfScrollPosition)
    end
    --全服
    if self.AllRecordPanel.alpha == 1 or isRefreshAll then
        self:RefreshTreasureRecordList(self.AllRecordchlidlist, self.AllRecord_UIScrollView, self.AllRecord_UIPanel, self.mAllTreasureRecordList, self.AllRecord_SpringPanel, self.mAllScrollPosition)
    end

end

---全服转生数据
function UITreasurePanel_Record.OnResReinNumMessage(id, data, csData)
    UITreasurePanel_Record.Self:SetAwardsShowList(csData)
end

--endregion

--region 数据处理
---刷新宝藏列表
function UITreasurePanel_Record:RefreshTreasureRecordList(treasureList, scrollView, panel, data, SpringPanel, mOriginScrollPosition)
    treasureList.MaxCount = data.Count
    local height = treasureList.MaxCount * treasureList.CellHeight
    local panelHeight = panel:GetViewSize().y
    local index = 0
    for i = 0, data.Count - 1 do
        local item = treasureList.controlList[i]
        if self.TreasureTemplatesList[item] == nil then
            local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UITreasurePanel_RecordItem)
            self.TreasureTemplatesList[item] = template
        end
        self.TreasureTemplatesList[item]:RefreshUI(data[i])
    end
    local maxNumber = data.Count - 12
    if maxNumber < 0 then
        maxNumber = 0;
    end
    SpringPanel.target = CS.UnityEngine.Vector3(mOriginScrollPosition.x, mOriginScrollPosition.y + 25 * maxNumber - 10, mOriginScrollPosition.z);
    SpringPanel.enabled = true;
end

--endregion

function UITreasurePanel_Record:OnDestroy()
    UITreasurePanel_Record.Self = nil
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResCommonMessage, UITreasurePanel_Record.OnResCommonMessage)
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResServerHistoryMessage, UITreasurePanel_Record.OnResServerHistoryMessage)
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResReinNumMessage, UITreasurePanel_Record.OnResReinNumMessage)
end

return UITreasurePanel_Record