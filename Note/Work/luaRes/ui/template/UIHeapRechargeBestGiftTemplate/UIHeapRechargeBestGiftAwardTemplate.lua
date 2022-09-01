--- DateTime: 2021/05/18 09:53
--- Description 累充豪礼奖励模板

---@class UIHeapRechargeBestGiftAwardTemplate:TemplateBase
local UIHeapRechargeBestGiftAwardTemplate = {}

--region parameters
UIHeapRechargeBestGiftAwardTemplate.allTemplateByRewardGoTbl = nil
--endregion

--region Init
---@private
function UIHeapRechargeBestGiftAwardTemplate:Init()
    self:InitParameters()
    self:InitComponents()
end

---@private
function UIHeapRechargeBestGiftAwardTemplate:InitParameters()
    self.allTemplateByRewardGoTbl = {}
end

---@private
function UIHeapRechargeBestGiftAwardTemplate:InitComponents()
    ---@type Top_UIGridContainer
    self.grid_reward = self:Get('', 'Top_UIGridContainer')
end
--endregion

--region public methods
function UIHeapRechargeBestGiftAwardTemplate:SetTemplate(specialID)
    if specialID == nil then
        return
    end
    self.specialID = specialID
    self:RefreshRewardData()
    self:RefreshRewardGrid()
end
--endregion

--region private methods
---@private
---刷新奖励数据
function UIHeapRechargeBestGiftAwardTemplate:RefreshRewardData()
    self.rewardTbl = {}
    ---@type TABLE.cfg_special_activity
    local specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(self.specialID)
    if specialActivityTbl == nil then
        return
    end

    local itemID = (specialActivityTbl:GetAward() ~= nil and #specialActivityTbl:GetAward().list > 0) and specialActivityTbl:GetAward().list[1] or 0
    local mCount = (specialActivityTbl:GetAward() ~= nil and #specialActivityTbl:GetAward().list > 0) and specialActivityTbl:GetAward().list[2] or 0

    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemID)
    if itemTbl == nil then
        return
    end
    ---判断是否为宝箱
    if itemTbl:GetType() ~= nil and itemTbl:GetType() == 5 then
        local list = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(itemID)
        for i = 0, list.Count - 1 do
            table.insert(self.rewardTbl, {
                itemId = list[i].itemId,
                count = list[i].count
            })

        end
    else
        table.insert(self.rewardTbl, {
            itemId = itemID,
            count = mCount
        })
    end
end

---@private
---刷新奖励格子
function UIHeapRechargeBestGiftAwardTemplate:RefreshRewardGrid()
    if (self.grid_reward == nil) then
        return
    end
    self.grid_reward.MaxCount = #self.rewardTbl
    for i = 1, #self.rewardTbl do
        local go = self.grid_reward.controlList[i - 1]
        if go then
            local rewardInfo = self.rewardTbl[i]
            ---@type UIItem
            local template = self.allTemplateByRewardGoTbl[go]
            if template == nil then
                template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                self.allTemplateByRewardGoTbl[go] = template
            end
            local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(rewardInfo.itemId)
            if isFind then
                template:RefreshUIWithItemInfo(itemInfo, rewardInfo.count)
                template:RefreshOtherUI({ showItemInfo = itemInfo })
            end
        end
    end
end
--endregion

--region bind event
--endregion

--region destroy
--endregion

return UIHeapRechargeBestGiftAwardTemplate