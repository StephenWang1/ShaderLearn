---@class UIGemSuitAttributePanel:UIBossSkillPanel
local UIGemSuitAttributePanel = {}

setmetatable(UIGemSuitAttributePanel, luaPanelModules.UIBossSkillPanel)

--region 初始化
function UIGemSuitAttributePanel:InitComponents()
    --region 背景图
    ---@type UISprite
    self.infoPanelBG = self:GetCurComp("WidgetRoot/infoPanel/bg", "Top_UISprite")
    --endregion

    --region 描述
    ---@type UILabel
    self.mCurTitle_UILabel = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/Cur/CurTitle", "Top_UILabel")
    ---@type UILabel
    self.mCurContent_UILabel = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/Cur/CurContent", "Top_UILabel")
    ---@type UILabel
    self.mNextTitle_UILabel = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/Next/NextTitle", "Top_UILabel")
    ---@type UILabel
    self.mNextContent_UILabel = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/Next/NextContent", "Top_UILabel")
    ---@type UITable
    self.mCurDes_UITable = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/Cur", "Top_UITable")
    ---@type UITable
    self.mNextDes_UITable = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/Next", "Top_UITable")
    --endregion

    ---@type UITable
    self.Center_UITable = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot", "Top_UITable")
    ---@type UIScrollView
    self.Center_UIScrollView = self:GetCurComp("WidgetRoot/infoPanel/skillInfo", "Top_UIScrollView")
    ---@type UIPanel
    self.Center_UIPanel = self:GetCurComp("WidgetRoot/infoPanel/skillInfo", "UIPanel")
end

function UIGemSuitAttributePanel:InitOther()
    ---延时刷新参数
    self.DelayRefresh = nil
    ---默认高度尺寸
    self.defaultTopSize = 50
end
--endregion

---@class OpenGemSuitAttributePanelParams
---@field furnaceId number
---@field state boolean
---@field type LuaEnumFurnaceOpenType
---@param customData OpenGemSuitAttributePanelParams
function UIGemSuitAttributePanel:Show(customData)
    if(customData == nil) then
        customData = {};
    end

    if(customData.furnaceId == nil) then
        customData.furnaceId = 0;
    end

    if(customData.state == nil) then
        customData.state = false;
    end

    if self:AnalysisParams(customData) == false then
        uimanager:ClosePanel(self)
        return
    end
    self:RefreshUI()
end


--region 刷新
---@param customData OpenGemSuitAttributePanelParams
function UIGemSuitAttributePanel:AnalysisParams(customData)
    if(customData.furnaceId == 0) then
        return false;
    end
    self.mFurnaceType = customData.type
    self.state = customData.state;
    self.curTitleDes, self.curContentDes = Utility:GetGemAdditionBufferDes(customData.furnaceId)
    if CS.StaticUtility.IsNullOrEmpty(self.curTitleDes) or CS.StaticUtility.IsNullOrEmpty(self.curContentDes) then
        return false
    end
    local nextItemId, isActive = Utility:GetNextSpecialFurnaceState(customData.furnaceId, self.mFurnaceType);
    if type(nextItemId) == 'number' then
        self.nextTitleDes, self.nextContentDes = Utility:GetGemAdditionBufferDes(nextItemId)
    end
    return true
end

---刷新顶部数据
function UIGemSuitAttributePanel:RefreshTopInfo()

end

---刷新中间数据
function UIGemSuitAttributePanel:RefreshCenterInfo()
    local color1 = self.state and luaEnumColorType.Green or luaEnumColorType.Gray
    luaclass.UIRefresh:RefreshLabel(self.mCurTitle_UILabel, color1 .. self.curTitleDes)
    luaclass.UIRefresh:RefreshLabel(self.mCurContent_UILabel, color1 .. self.curContentDes)
    --luaclass.UIRefresh:RefreshLabel(self.mNextTitle_UILabel, luaEnumColorType.Gray .. (self.nextTitleDes == nil and "" or self.nextTitleDes) .. "[-]")
    --luaclass.UIRefresh:RefreshLabel(self.mNextContent_UILabel, luaEnumColorType.Gray ..(self.nextContentDes == nil and "" or self.nextContentDes).. "[-]")
    --luaclass.UIRefresh:RefreshActive(self.mNextTitle_UILabel, CS.StaticUtility.IsNullOrEmpty(self.nextTitleDes) == false)
    --luaclass.UIRefresh:RefreshActive(self.mNextContent_UILabel, CS.StaticUtility.IsNullOrEmpty(self.nextContentDes) == false)
    luaclass.UIRefresh:RefreshActive(self.mNextTitle_UILabel, false)
    luaclass.UIRefresh:RefreshActive(self.mNextContent_UILabel, false)
end
--endregion

--region 自适应
function UIGemSuitAttributePanel:AdaptiveSize()
    self.mCurDes_UITable:Reposition()
    self.mNextDes_UITable:Reposition()
    self.Center_UITable:Reposition()
    self.Center_UIScrollView:ResetPosition()
    ---@type UnityEngine.Bounds
    local Bounds = CS.NGUIMath.CalculateRelativeWidgetBounds(self.Center_UITable.gameObject.transform);
    local Bounds2 = CS.NGUIMath.CalculateRelativeWidgetBounds(self.infoPanelBG.gameObject.transform);
    if Bounds then
        local totalHigh = Bounds.size.y + self.defaultTopSize
        if totalHigh > self.maxHigh then
            totalHigh = self.maxHigh
        end
        local curBoundsSize = totalHigh - self.defaultTopSize
        local scrollViewClipAddSize = 10
        local pos_y = 160
        self.Center_UIPanel:SetRect(0, Bounds.center.y + pos_y, Bounds.size.x + scrollViewClipAddSize, curBoundsSize + scrollViewClipAddSize)

        self.infoPanelBG.height = math.ceil(totalHigh - 21)
    end
end

function update()
    UIGemSuitAttributePanel:OnUpdate()
end
--endregion

return UIGemSuitAttributePanel