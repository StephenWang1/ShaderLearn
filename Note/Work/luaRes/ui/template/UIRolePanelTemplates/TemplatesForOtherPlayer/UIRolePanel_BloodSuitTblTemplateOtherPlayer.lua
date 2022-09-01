---@type UIRolePanel_BloodSuitTblTemplateOtherPlayer
local UIRolePanel_BloodSuitTblTemplateOtherPlayer = {}


function UIRolePanel_BloodSuitTblTemplateOtherPlayer:InitComponents()
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

end

function UIRolePanel_BloodSuitTblTemplateOtherPlayer:InitOther()
    CS.UIEventListener.Get(self.go.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.go.gameObject).OnClickLuaDelegate = self.OnClickBackground
end
---初始化数据
function UIRolePanel_BloodSuitTblTemplateOtherPlayer:Init(superiorPanel)
    self:InitComponents()
    self:InitOther()
    ---@type UIOtherRoleBloodSuitPanel
    self.superiorPanel = superiorPanel
end

---@param data TABLE.cfg_bloodsuit_combination 遍历方法
function UIRolePanel_BloodSuitTblTemplateOtherPlayer:RefreshUI(data, isSelect)
    if data == nil then
        return
    end
    self.cfg_bloodsuit_combination = data
    self.IsOpenEquipType=false
    self:RefreShDes(data:GetName())
    self:RefreshActive(isSelect)
end

---刷新描述
function UIRolePanel_BloodSuitTblTemplateOtherPlayer:RefreShDes(des)
    self.BackgroundLabel.text = des
    self.ForegroundLabel.text = des
    self.lockLabel.text = des
end

---刷新开启状态
function UIRolePanel_BloodSuitTblTemplateOtherPlayer:RefreshActive(isSelect)
    if self.cfg_bloodsuit_combination == nil then
        return
    end
    self.isSelect = isSelect
    self.IsOpenEquipType = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():IsOpenEquipType(self.cfg_bloodsuit_combination:GetType())
    self.Background.gameObject:SetActive(self.IsOpenEquipType)
    self.Foreground.gameObject:SetActive(isSelect and self.IsOpenEquipType)
    self.lock.gameObject:SetActive(not self.IsOpenEquipType)
end

---点击背景切换选项
function UIRolePanel_BloodSuitTblTemplateOtherPlayer:OnClickBackground(go)
    if self.IsOpenEquipType then
        if self.superiorPanel==nil or self.cfg_bloodsuit_combination==nil then
            return
        end
        self.superiorPanel:RefreshUI(self.cfg_bloodsuit_combination:GetType())
    else
        local str = self.cfg_bloodsuit_combination:GetTips()
        Utility.ShowPopoTips(go, str, 428)
    end
end


return UIRolePanel_BloodSuitTblTemplateOtherPlayer