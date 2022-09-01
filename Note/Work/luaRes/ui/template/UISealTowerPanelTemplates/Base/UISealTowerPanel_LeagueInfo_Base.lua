local UISealTowerPanel_LeagueInfo_Base = {}

setmetatable(UISealTowerPanel_LeagueInfo_Base,luaComponentTemplates.UIRefreshTemplate)

--region 初始化
function UISealTowerPanel_LeagueInfo_Base:Init()
    self:InitComponent()
    self:InitOther()
end

function UISealTowerPanel_LeagueInfo_Base:InitComponent()
    self.bg_Gameobject = self:Get("bg","GameObject")
    self.icon_UISprite = self:Get("icon","UISprite")
    self.name_UILabel = self:Get("name","UILabel")
    self.attackValue_UILabel = self:Get("attackValue","UILabel")

    self.SacrificeBtn_GameObject = self:Get("btn","GameObject")
    self.SacrificeBtn_UILabel = self:Get("btn/Label","UILabel")
end

function UISealTowerPanel_LeagueInfo_Base:InitOther()

end
--endregion

--region 刷新
---刷新面板
---@param commonData table 通用数据(commonData.leagueInfo联盟信息  commonData.line行数)
function UISealTowerPanel_LeagueInfo_Base:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        return
    end
    self:RefreshCurPanel()
end

---解析参数
function UISealTowerPanel_LeagueInfo_Base:AnalysisParams(commonData)
    if commonData == nil or commonData.leagueInfo == nil then
        return false
    end
    self.leagueInfo = commonData.leagueInfo
    self.leagueType = self.leagueInfo.type
    if self.leagueType ~= nil then
        self.leagueTableInfo = clientTableManager.cfg_leagueManager:TryGetValue(self.leagueType)
    end
    if self.leagueTableInfo == nil then
        return false
    end
    return true
end

---刷新具体的面板
function UISealTowerPanel_LeagueInfo_Base:RefreshCurPanel()
    self:DefaultRefresh()
end

---默认刷新
function UISealTowerPanel_LeagueInfo_Base:DefaultRefresh()
    self:RefreshSprite(self.icon_UISprite,self.leagueTableInfo:GetTowerIcon())
end
--endregion

return UISealTowerPanel_LeagueInfo_Base