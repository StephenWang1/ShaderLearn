---@class UIGuildBenefitsPanel_SpoilsGridTemplate 帮会战利品格子模板
local UIGuildBenefitsPanel_SpoilsGridTemplate = {}
--region 初始化
function UIGuildBenefitsPanel_SpoilsGridTemplate:Init()
    self:InitComponent()
end

function UIGuildBenefitsPanel_SpoilsGridTemplate:InitComponent()
    self.icon = self:Get("icon", "UISprite")
    self.count = self:Get("count", "UILabel")
    self.go = self:Get("", "GameObject")
    self.good = self:Get("good", "GameObject")
    self.strengthen = self:Get("strengthen", "GameObject")
    self.bloodSignGO = self:Get("BloodLv", "GameObject")
    self.bloodLevelLabel = self:Get("BloodLvLabel", "UILabel")
end
--endregion

--region 刷新
---@param bagV2.BagItemInfo
function UIGuildBenefitsPanel_SpoilsGridTemplate:RefreshGrid(bagItemInfo)
    self:InitParams(bagItemInfo)
    if self.bagItemInfo == nil then
        self:RefreshNoItemGrid()
    else
        self:RefreshItemGrid()
    end
end

---初始化参数
---@param bagItemInfo bagV2.BagItemInfo
function UIGuildBenefitsPanel_SpoilsGridTemplate:InitParams(bagItemInfo)
    self.bagItemInfo = bagItemInfo
    if self.bagItemInfo ~= nil then
        local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.bagItemInfo.itemId)
        if itemInfoIsFind then
            self.itemInfo = itemInfo
        end
    end
end

---刷新没有物品格子
function UIGuildBenefitsPanel_SpoilsGridTemplate:RefreshNoItemGrid()
    self:RefreshActive(self.icon, false)
    self:RefreshActive(self.count, false)
    self:RefreshActive(self.good, false)
    self:RefreshActive(self.strengthen, false)
    self:RefreshCallBack(function()
    end)
    self:RefreshActive(self.bloodSignGO, false)
    self:RefreshActive(self.bloodLevelLabel, false)
end

---刷新有物品的格子
function UIGuildBenefitsPanel_SpoilsGridTemplate:RefreshItemGrid()
    self:RefreshActive(self.good, false)
    self:RefreshActive(self.strengthen, false)
    if self.bagItemInfo ~= nil and self.itemInfo ~= nil then
        self:RefreshSprite(self.icon, self.itemInfo.icon)
        if self.bagItemInfo.count > 0 then
            self:RefreshLabel(self.count, self.bagItemInfo.count)
        end
        ---@type UIItemInfoPanel_Union_RightUpOperate
        self:RefreshCallBack(function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.bagItemInfo, showRight = true, rightUpButtonsModule = luaComponentTemplates.UIItemInfoPanel_Union_RightUpOperate })
        end)
        local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(self.bagItemInfo.itemId)
        if bloodsuitTbl and self.bagItemInfo.bloodLevel > 0 then
            self:RefreshActive(self.bloodSignGO, true)
            self.bloodLevelLabel.text = tostring(self.bagItemInfo.bloodLevel)
        else
            self:RefreshActive(self.bloodSignGO, false)
            self:RefreshActive(self.bloodLevelLabel, false)
        end
    end
end
--endregion

--region 组件刷新
---控制显示
function UIGuildBenefitsPanel_SpoilsGridTemplate:RefreshActive(obj, state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        obj.gameObject:SetActive(state)
    end
end

---设置Sprite
function UIGuildBenefitsPanel_SpoilsGridTemplate:RefreshSprite(obj, spriteName)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.Top_UISprite)) then
            obj.spriteName = spriteName
        else
            local curSprite = self:GetCurComp(obj, "", "UISprite")
            if curSprite ~= nil then
                curSprite.spriteName = spriteName
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置Label
function UIGuildBenefitsPanel_SpoilsGridTemplate:RefreshLabel(obj, text)
    if text == 1 or text == "1" then
        text = ""
    end
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.Top_UILabel)) then
            obj.text = text
        else
            local curLabel = self:GetCurComp(obj, "", "UILabel")
            if curLabel ~= nil then
                curLabel.text = text
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置物品点击回调
function UIGuildBenefitsPanel_SpoilsGridTemplate:RefreshCallBack(action)
    if self.go ~= nil and not CS.StaticUtility.IsNull(self.go) then
        CS.UIEventListener.Get(self.go).onClick = action
    end
end
--endregion
return UIGuildBenefitsPanel_SpoilsGridTemplate