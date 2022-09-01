---@class UIBossScorePanelTemplate:TemplateBase
local UIBossScorePanelTemplate = {}

--region 组件
---@return UnityEngine.GameObject 帮助按钮
function UIBossScorePanelTemplate:GetHelpBtn_GO()
    if self.mHelpBtn_Go == nil then
        self.mHelpBtn_Go = self:Get("btn_help", "GameObject")
    end
    return self.mHelpBtn_Go
end

---@return  UIGridContainer
function UIBossScorePanelTemplate:GetLevel1Container()
    if self.mLevel1Container == nil then
        self.mLevel1Container = self:Get("reward_show/1", "UIGridContainer")
    end
    return self.mLevel1Container
end

---@return  UIGridContainer
function UIBossScorePanelTemplate:GetLevel2Container()
    if self.mLevel2Container == nil then
        self.mLevel2Container = self:Get("reward_show/2", "UIGridContainer")
    end
    return self.mLevel2Container
end

---@return  UIGridContainer
function UIBossScorePanelTemplate:GetLevel3Container()
    if self.mLevel3Container == nil then
        self.mLevel3Container = self:Get("reward_show/3", "UIGridContainer")
    end
    return self.mLevel3Container
end
--endregion

---@param panel UIBossPanel
function UIBossScorePanelTemplate:Init(panel)
    self.mRootPanel = panel
    self:BindEvents()
end

function UIBossScorePanelTemplate:BindEvents()
    CS.UIEventListener.Get(self:GetHelpBtn_GO()).onClick = function(go)
        self:OnHelpBtnClicked(go)
    end
end

---点击帮助按钮
function UIBossScorePanelTemplate:OnHelpBtnClicked(go)
    local isFind, descriptionInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(157)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, descriptionInfo)
    end
end

---有机会把bosspanel 的代码挪过来就不通过这个方法获取数据了
function UIBossScorePanelTemplate:GetTableData(id)
    return self.mRootPanel:GetIntegralData(id)
end

---@return TABLE.CFG_ITEMS 道具信息
function UIBossScorePanelTemplate:GetItemInfo(id)
    if id == nil then
        return
    end
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[id]
    if info == nil then
        ___, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
        self.mItemIdToInfo[id] = info
    end
    return info
end

--region 赛季奖励
---@param firstLineData activityV2.BossScoreRewards
function UIBossScorePanelTemplate:RefreshScoreReward(firstLineData)
    local info = self:GetTableData(firstLineData.id)
    if info then
        local level1 = info.rewardShow1
        local level2 = info.rewardShow2
        local level3 = info.rewardShow3
        self:RefreshGridContainer(self:GetLevel1Container(), level1)
        self:RefreshGridContainer(self:GetLevel2Container(), level2)
        self:RefreshGridContainer(self:GetLevel3Container(), level3)
    end
end

---@param container UIGridContainer
---@param rewardList TABLE.IntListList
function UIBossScorePanelTemplate:RefreshGridContainer(container, rewardList)
    if not CS.StaticUtility.IsNull(container) and rewardList then
        container.MaxCount = rewardList.list.Count
        for i = 0, container.controlList.Count - 1 do
            local go = container.controlList[i]
            local info = rewardList.list[i]
            if info.list.Count >= 2 then
                local id = info.list[0]
                local num = info.list[1]
                self:RefreshSingleGrid(go, id, num)
            end
        end
    end
end

---刷新单个格子
function UIBossScorePanelTemplate:RefreshSingleGrid(go, id, num)
    ---@type UISprite
    local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
    ---@type UILabel
    local count = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
    if not CS.StaticUtility.IsNull(icon) then
        local itemInfo = self:GetItemInfo(id)
        if itemInfo then
            icon.spriteName = itemInfo.icon
        end
        CS.UIEventListener.Get(icon.gameObject).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
        end
    end
    if not CS.StaticUtility.IsNull(count) then
        local showNum = num == 1 and "" or num
        count.text = showNum
    end
end

--endregion

return UIBossScorePanelTemplate