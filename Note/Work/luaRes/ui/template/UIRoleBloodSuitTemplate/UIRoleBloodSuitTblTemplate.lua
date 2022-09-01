---血继肉身装备格子面板
---@class UIRoleBloodSuitTblTemplate
local UIRoleBloodSuitTblTemplate = {}

function UIRoleBloodSuitTblTemplate:InitComponents()
    ---背景
    self.Background = self:Get("Background", "GameObject")
    ---背景描述
    self.BackgroundLabel = self:Get("Background/Label", "UILabel")
    ---选中
    self.Foreground = self:Get("Foreground", "GameObject")
    ---选中描述
    self.ForegroundLabel = self:Get("Foreground/Label", "UILabel")
    ---锁定
    self.lock = self:Get("lock", "GameObject")
    ---锁定描述
    self.lockLabel = self:Get("lock/Label", "UILabel")
    ---锁定描述
    self.redpoint = self:Get("redpoint", "Top_UIRedPoint")

end

function UIRoleBloodSuitTblTemplate:InitOther()
    CS.UIEventListener.Get(self.go.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.go.gameObject).OnClickLuaDelegate = self.OnClickBackground
end

---初始化数据
function UIRoleBloodSuitTblTemplate:Init(superiorPanel, type)
    self:InitComponents()
    self:InitOther()
    ---@type UIRoleBloodSuitPanel
    self.superiorPanel = superiorPanel
    if self.superiorPanel ~= nil and self.superiorPanel.SuitRedPointDic ~= nil then
        self.redpoint:RemoveRedPointKey();
        local RedEnum = self.superiorPanel.SuitRedPointDic[type]
        local Key = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(RedEnum);
        self.redpoint:AddRedPointKey(Key)
    end
end

---@param data TABLE.cfg_bloodsuit_combination 遍历方法
function UIRoleBloodSuitTblTemplate:RefreshUI(data, isSelect, isMainPlayer, PlayerBloodSuitEquipMgr)
    if data == nil then
        return
    end
    if isMainPlayer == nil then
        self.isMainPlayer = true
    else
        self.isMainPlayer = isMainPlayer
    end
    if PlayerBloodSuitEquipMgr == nil then
        ---@type LuaPlayerBloodSuitEquipMgr
        self.PlayerBloodSuitEquipMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr()
    else
        ---@type LuaPlayerBloodSuitEquipMgr
        self.PlayerBloodSuitEquipMgr = PlayerBloodSuitEquipMgr
    end
    self.cfg_bloodsuit_combination = data
    self.IsOpenEquipType = false
    self.FailedConditionIndex = -1
    self:RefreShDes(data:GetName())
    self:RefreshActive(isSelect)
end

---刷新描述
function UIRoleBloodSuitTblTemplate:RefreShDes(des)
    self.BackgroundLabel.text = des
    self.ForegroundLabel.text = des
    self.lockLabel.text = des
end

---刷新开启状态
function UIRoleBloodSuitTblTemplate:RefreshActive(isSelect)
    if self.cfg_bloodsuit_combination == nil then
        return
    end
    self.isSelect = isSelect
    if self.isMainPlayer == false then
        self.IsOpenEquipType, self.FailedConditionIndex = self.PlayerBloodSuitEquipMgr:IsOpenOtherEquipType(self.cfg_bloodsuit_combination:GetType())
    else
        self.IsOpenEquipType, self.FailedConditionIndex = self.PlayerBloodSuitEquipMgr:IsOpenEquipType(self.cfg_bloodsuit_combination:GetType())
    end
    self.Background.gameObject:SetActive(self.IsOpenEquipType)
    self.Foreground.gameObject:SetActive(isSelect and self.IsOpenEquipType)
    self.lock.gameObject:SetActive(not self.IsOpenEquipType)
end

---点击背景切换选项
function UIRoleBloodSuitTblTemplate:OnClickBackground(go)
    if self.IsOpenEquipType then
        if self.superiorPanel == nil or self.cfg_bloodsuit_combination == nil then
            return
        end
        self.superiorPanel:RefreshUI(self.cfg_bloodsuit_combination:GetType())
        --  self.superiorPanel:OnOpenBag()
    else
        if self.FailedConditionIndex == nil or self.FailedConditionIndex <= -1 then
            return
        end
        local str = self.cfg_bloodsuit_combination:GetTips()
        local tips = string.Split(str, '#')
        if not (tips == nil or #tips == 0 or #tips < self.FailedConditionIndex) then
            str = tips[self.FailedConditionIndex]
        end
        Utility.ShowPopoTips(go, str, 428)
    end
end

return UIRoleBloodSuitTblTemplate