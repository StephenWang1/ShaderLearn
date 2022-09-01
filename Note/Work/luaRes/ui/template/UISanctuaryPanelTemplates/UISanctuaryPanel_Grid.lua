local UISanctuaryPanel_Grid = {}
--region 初始化
function UISanctuaryPanel_Grid:Init()
    self:InitComponent()
    self:InitEvents()
end

function UISanctuaryPanel_Grid:InitComponent()
    self.lb_location_UILabel = self:Get("lb_location","UILabel")
end

function UISanctuaryPanel_Grid:InitEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        self:onClick(self)
    end
end
--endregion

--region 刷新
function UISanctuaryPanel_Grid:RefreshGrid(commonData)
    self:InitParams(commonData)
    self:Refresh()
end

function UISanctuaryPanel_Grid:InitParams(commonData)
    self.duplicateInfo = ternary(commonData == nil,nil,commonData.duplicateInfo)
    self.duplicateName = ternary(self.duplicateInfo == nil,"",self.duplicateInfo.name)
    self.prefixName = ""
    if self.duplicateInfo.specialCondition ~= nil and self.duplicateInfo.specialCondition.list ~= nil and self.duplicateInfo.specialCondition.list.Count > 0 then
        self.prefixName = CS.Cfg_PrefixTableManager.Instance:GetPrefixName(self.duplicateInfo.specialCondition.list[0])
    end
    self.onClick = ternary(commonData.onClick == nil,function() end,commonData.onClick)
    self.duplicateNameColor = "[878787]"
    if self.duplicateInfo ~= nil then
        self.duplicateNameColor = ternary(CS.CSScene.MainPlayerInfo.SanctuaryInfo:CheckSanctuaryIsCanEnter(self.duplicateInfo.id),"[00ff00]","[878787]")
    end
    self.text = self.duplicateNameColor .. self.duplicateName .. "[-][878787](" .. self.prefixName .. ")[-]"
end

function UISanctuaryPanel_Grid:Refresh()
    if self.lb_location_UILabel ~= nil then
        self.lb_location_UILabel.text = self.text
    end
end
--endregion
return UISanctuaryPanel_Grid