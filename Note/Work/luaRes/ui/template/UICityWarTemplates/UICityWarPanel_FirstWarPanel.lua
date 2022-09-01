---第一次沙城争霸界面
---@class UICityWarPanel_FirstWarPanel
local UICityWarPanel_FirstWarPanel = {}

function UICityWarPanel_FirstWarPanel:Init()
    self:InitComponent()
    self:RefreshItem()
end

function UICityWarPanel_FirstWarPanel:InitComponent()
    self.mOpenDays_UILabel = self:Get("LeftDays", "UILabel")
    ---@type UICountdownLabel
    self.mOpenDays_UICountDownLabel = self:Get("LeftDays", "UICountdownLabel")
    ---@type UIGridContainer
    self.mRewards_UIGridContainer = self:Get("Rewards", "UIGridContainer")
    ---背景图片
    self.mBG_GameObject = self:Get("Sprite", "GameObject")
end

---刷新界面显示
function UICityWarPanel_FirstWarPanel:RefreshPanel(OpenDays)
    self:RefreshTime(OpenDays)
end

---刷新倒计时显示
function UICityWarPanel_FirstWarPanel:RefreshTime(OpenDays)
    if OpenDays == 0 then
        local desTime = CS.CSScene.MainPlayerInfo.DuplicateV2:GetOpenTime()
        self:StartCountDown(desTime)
    else
        self.mOpenDays_UILabel.text = math.abs(OpenDays)
    end
    if not CS.StaticUtility.IsNull(self.mBG_GameObject) then
        self.mBG_GameObject:SetActive(OpenDays ~= 0)
    end
end

---开服第一次活动倒计时
function UICityWarPanel_FirstWarPanel:StartCountDown(desTime)
    if not CS.StaticUtility.IsNull(self.mOpenDays_UICountDownLabel) then
        self.mOpenDays_UICountDownLabel:StartCountBySecond(nil, 5, desTime, nil, nil, nil, function()
            self.mOpenDays_UILabel.text = "激烈争夺中"
        end)
    end
end

---刷新奖励显示
function UICityWarPanel_FirstWarPanel:RefreshItem()
    local reward = self:GetSabacRewardGlobalData(20477)
    self.mRewards_UIGridContainer.MaxCount = #reward
    for i = 0, self.mRewards_UIGridContainer.controlList.Count - 1 do
        local gp = self.mRewards_UIGridContainer.controlList[i]
        local icon = CS.Utility_Lua.GetComponent(gp.transform:Find("icon"),"UISprite")
        local num = CS.Utility_Lua.GetComponent(gp.transform:Find("count"),"UILabel")
        local info = reward[i + 1]
        if not CS.StaticUtility.IsNull(icon) and info.itemId then
            local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(info.itemId)
            if res then
                icon.spriteName = itemInfo.icon
                CS.UIEventListener.Get(gp).onClick = function()
                    self:OnItemClicked(itemInfo)
                end
            end
        end
        if not CS.StaticUtility.IsNull(num) and info.itemNum then
            num.text = info.itemNum
        end
    end
end

---获取首战沙巴克奖励
function UICityWarPanel_FirstWarPanel:GetSabacRewardGlobalData(id)
    local list = {}
    local res, globalData = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(id)
    if res then
        local strList = string.Split(globalData.value, '&')
        for i = 1, #strList do
            local info = string.Split(strList[i], '#')
            local itemInfo = {}
            if #info >= 2 then
                itemInfo.itemId = tonumber(info[1])
                itemInfo.itemNum = tonumber(info[2])
                table.insert(list, itemInfo)
            end
        end
    end
    return list
end

---创建道具面板
function UICityWarPanel_FirstWarPanel:OnItemClicked(itemInfo)
    uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = itemInfo})
end

return UICityWarPanel_FirstWarPanel