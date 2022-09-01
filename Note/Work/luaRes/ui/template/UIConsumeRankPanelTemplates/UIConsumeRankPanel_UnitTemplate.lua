---@class UIConsumeRankPanel_UnitTemplate :TemplateBase 消费排行单元
local UIConsumeRankPanel_UnitTemplate = {}

--region 初始化

function UIConsumeRankPanel_UnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIConsumeRankPanel_UnitTemplate:InitParameters()
    ---@type activitiesV2.ConsumRankInfo
    self.curRankData = nil
    self.rewardTbl = {}
    self.allTemplateByRewardGoTbl = {}
    self.IsInitialized = false
end

function UIConsumeRankPanel_UnitTemplate:InitComponents()
    ---@type Top_UISprite 排行图片
    self.rankingSprite = self:Get('Total/rankingSprite', 'Top_UISprite')
    ---@type Top_UILabel 名称
    self.name = self:Get('name', 'Top_UILabel')
    ---@type Top_UISprite 商会icon
    self.shIcon = self:Get('name/icon', 'Top_UISprite')
    ---@type Top_UIGridContainer 奖励列表
    self.rewardGrid = self:Get('rewardList', 'Top_UIGridContainer')
end

function UIConsumeRankPanel_UnitTemplate:BindUIMessage()
    -- CS.UIEventListener.Get(self.go).LuaEventTable = self
    -- CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClickGoCallBack
end

--endregion

--region Show

---@param data table
---@field data.rank number 当前排名
---@field data.rankData activitiesV2.ConsumRankInfo 排名信息
function UIConsumeRankPanel_UnitTemplate:SetTemplate(data)
    if data == nil or data.rankData == nil then
        return
    end
    self.curRankData = data.rankData
    self:RefreshView()
end

--endregion

--region UI函数监听

function UIConsumeRankPanel_UnitTemplate:OnClickGoCallBack()

end

--endregion

--region View

function UIConsumeRankPanel_UnitTemplate:RefreshView()
    self.name.text = self:RoleInfoIsNil() and '虚位以待' or self.curRankData.roleName
    self.rankingSprite.spriteName = tostring(self.curRankData.rank)
    local shIconStr = self:GetMothName(self.curRankData.shId)
    self.shIcon.spriteName = shIconStr
    self.shIcon:DelayUpdateAnchors()
    self.shIcon.gameObject:SetActive(shIconStr ~= "")
    if not self.IsInitialized then
        self:RefreshRewardView()
        self.IsInitialized = true
    end
end

---刷新奖励视图
function UIConsumeRankPanel_UnitTemplate:RefreshRewardView()
    self:RefreshRewardData()
    self.rewardGrid.MaxCount = #self.rewardTbl
    for i = 1, #self.rewardTbl do
        local go = self.rewardGrid.controlList[i - 1]
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


--region otherFunction
---获取商会前缀图片名称
function UIConsumeRankPanel_UnitTemplate:GetMothName(monthCardId)
    return self.curRankData.rid == 0 and '' or
            monthCardId == 1 and 'Commerce_bq' or monthCardId == 2 and 'Commerce_mc' or ''
end

function UIConsumeRankPanel_UnitTemplate:RefreshRewardData()
    self.rewardTbl = {}
    ---@type TABLE.cfg_special_activity
    local specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(self.curRankData.configId)
    if specialActivityTbl == nil then
        return
    end

    local itemID = (specialActivityTbl:GetAward() ~= nil and #specialActivityTbl:GetAward().list > 0) and specialActivityTbl:GetAward().list[1] or 0
    local mCount = (specialActivityTbl:GetAward() ~= nil and #specialActivityTbl:GetAward().list > 0) and specialActivityTbl:GetAward().list[2] or 0

    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemID)
    if itemTbl == null then
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

---人物信息是否为空
---@return boolean
function UIConsumeRankPanel_UnitTemplate:RoleInfoIsNil()
    return self.curRankData == nil or self.curRankData.rid == nil or self.curRankData.rid == 0
end

--endregion

--region ondestroy

function UIConsumeRankPanel_UnitTemplate:onDestroy()

end

--endregion

return UIConsumeRankPanel_UnitTemplate
