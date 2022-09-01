---联盟献祭信息
local UISealTowerPanel_LeagueInfo_MySacrifice = {}

setmetatable(UISealTowerPanel_LeagueInfo_MySacrifice,luaComponentTemplates.UISealTowerPanel_LeagueInfo_Base)

--region 初始化
function UISealTowerPanel_LeagueInfo_MySacrifice:InitOther()
    self:BindClickCallBack(self.SacrificeBtn_GameObject,function(go)
        --if luaclass.SealTowerDataInfo.SealTowerIsOpen == false then
        --    Utility.ShowPopoTips(go,"活动未开启",209)
        --    return
        --end
        if self.sacrificialMaterialInfo ~= nil then
            local maxLimit = ternary(self.sacrificialMaterialInfo.haveMaxLimit,self.sacrificialNum,999)
            local beginCount = 1
            local color = ternary(beginCount > self.sacrificialNum,luaEnumColorType.Red,luaEnumColorType.White )
            local titleName = color .. string.format(self.sacrificialMaterialInfo.titleName,beginCount * self.sacrificialMaterialInfo.needNum,beginCount * self.sacrificialMaterialInfo.sacrificialValue)
            uimanager:CreatePanel("UIItemCountPanel", nil, { Title = "确定", ItemInfo = self.sacrificialMaterialInfo.itemInfo, CallBack = function(count,go) self:ItemUsePanelConfirmClick(count,go) end, BeginningCount = 1, MaxCount = maxLimit,titleName = titleName,ClickConfirmAutoClosePanel = false,NumChangeCallBack = function(count) self:ItemUsePanelNumChange(count) end })
        end
    end)
end
--endregion

--region 刷新
function UISealTowerPanel_LeagueInfo_MySacrifice:RefreshCurPanel()
    self:RunBaseFunction("RefreshCurPanel")
    self:RefreshNeedMaterial()
    local leagueColor = luaEnumColorType.Blue2
    local leagueName = leagueColor .. self.leagueTableInfo:GetName() .. "[-]"
    self:RefreshLabel(self.name_UILabel, leagueName .. luaEnumColorType.Gray .. "("  .. tostring(luaclass.SealTowerDataInfo.MainPlayerTowerScore) .. ")")
end
--endregion

--region 刷新捐献需要的材料
function UISealTowerPanel_LeagueInfo_MySacrifice:RefreshNeedMaterial()
    ---献祭材料信息/可献祭次数
    local sacrificialMaterialInfo,sacrificialNum = LuaGlobalTableDeal:GetSacrificialMaterial()
    self.sacrificialMaterialInfo = sacrificialMaterialInfo
    self.sacrificialNum = sacrificialNum
    if self.sacrificialMaterialInfo ~= nil then
        self:RefreshLabel(self.SacrificeBtn_UILabel,self.sacrificialMaterialInfo.btnText)
    end
end
--endregion

--region 点击事件
---物品使用面板确认按钮点击事件
---@param count number 选择的数量
---@param go UnityEngine.GameObject 按钮
function UISealTowerPanel_LeagueInfo_MySacrifice:ItemUsePanelConfirmClick(count,go)
    if count > self.sacrificialNum then
        Utility.ShowPopoTips(go.transform,nil,self.sacrificialMaterialInfo.exceedMaxLimitPopoId)
        return
    end
    networkRequest.ReqSealTowerDonation(self.sacrificialMaterialInfo.type, count)
    uimanager:ClosePanel("UIItemCountPanel")
end

---物品使用面板数量变化事件
---@param count number 选择的数量
function UISealTowerPanel_LeagueInfo_MySacrifice:ItemUsePanelNumChange(count)
    local titleName = ""
    if self.sacrificialMaterialInfo == nil then
        return
    end
    local color = ternary(count > self.sacrificialNum,luaEnumColorType.Red,luaEnumColorType.White)
    titleName = color .. string.format(self.sacrificialMaterialInfo.titleName,count * self.sacrificialMaterialInfo.needNum,count * self.sacrificialMaterialInfo.sacrificialValue)
    local itemCountPanel = uimanager:GetPanel("UIItemCountPanel")
    if type(titleName) == 'string' and itemCountPanel ~= nil then
        itemCountPanel:SetTitleName(titleName)
    end
end
--endregion
return UISealTowerPanel_LeagueInfo_MySacrifice