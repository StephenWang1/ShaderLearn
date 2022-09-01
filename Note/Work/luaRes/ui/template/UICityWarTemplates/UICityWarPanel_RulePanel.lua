---沙城争霸规则面板
---@class UICityWarPanel_RulePanel
local UICityWarPanel_RulePanel = {}

function UICityWarPanel_RulePanel:Init()
    self.IsShowReward = false
    self:InitComponent()
    self:ShowReward()
end

function UICityWarPanel_RulePanel:InitComponent()
    self.killRewardContainer = self:Get("awardsScrollView/KillRewards", "UIGridContainer")
    self.defenceRewardContainer = self:Get("awardsScrollView/DefenceRewards", "UIGridContainer")
    self.scoreRewardContainer = self:Get("awardsScrollView/SelfScoreRewards", "UIGridContainer")
end

---只有第一次打开界面时刷新界面显示
function UICityWarPanel_RulePanel:RefreshPanel()
    if not self.IsShowReward then
        self:ShowReward()
        self.IsShowReward = true
    end
end

---刷新界面显示
function UICityWarPanel_RulePanel:ShowReward()
    local killReward = CS.Cfg_GlobalTableManager.Instance:GetKillReward()
    local killRewardTable = self:DicToTable(killReward)
    local defenceReward = CS.Cfg_GlobalTableManager.Instance:GetKillReward()
    local defenceRewardTable = self:DicToTable(defenceReward)
    local scoreReward = CS.Cfg_GlobalTableManager.Instance:GetScoreReward()
    local scoreRewardTable = self:IntArrayToTable(scoreReward)
    self:RefreshContainer(self.killRewardContainer, killRewardTable, false)
    self:RefreshContainer(self.defenceRewardContainer, defenceRewardTable, false)
    self:RefreshContainer(self.scoreRewardContainer, scoreRewardTable, true)
end

---字典转为table
function UICityWarPanel_RulePanel:DicToTable(dic)
    local list = {}
    if dic then
        for k, v in pairs(dic) do
            local itemInfo = {}
            itemInfo.itemId = k
            itemInfo.itemNum = v
            table.insert(list, itemInfo)
        end
    end
    return list
end

---list 转为table
function UICityWarPanel_RulePanel:IntArrayToTable(list)
    local info = {}
    if list then
        for i = 0, list.Length - 1 do
            table.insert(info, list[i])
        end
    end
    return info
end

---刷新列表显示(此方法只在第一次打开界面时执行一次)
---@param container UIGridContainer
---@param list table
function UICityWarPanel_RulePanel:RefreshContainer(container, list, isSpecial)
    if not CS.StaticUtility.IsNull(container) and list then
        container.MaxCount = #list
        for i = 0, container.controlList.Count - 1 do
            local gp = container.controlList[i]
            local icon = CS.Utility_Lua.GetComponent(gp.transform:Find("icon"),"UISprite")
            local itemId = list[i + 1]
            if not isSpecial then
                itemId = list[i + 1].itemId
                local itemNum = list[i + 1].itemNum
                local num = CS.Utility_Lua.GetComponent(gp.transform:Find("count"),"UILabel")
                if not CS.StaticUtility.IsNull(num) and itemNum then
                    num.text = itemNum
                end
            end
            local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
            if res then
                if not CS.StaticUtility.IsNull(icon) then
                    icon.spriteName = itemInfo.icon
                end
                CS.UIEventListener.Get(gp).onClick = function()
                    self:OnItemClicked(itemInfo)
                end
            end
        end
    end
end

---创建道具面板
function UICityWarPanel_RulePanel:OnItemClicked(itemInfo)
    uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = itemInfo})
end

return UICityWarPanel_RulePanel