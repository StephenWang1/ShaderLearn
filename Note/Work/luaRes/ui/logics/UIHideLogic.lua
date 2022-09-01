---@class UIHideLogic
local UIHideLogic = {}

---@type cfg_uilogicManager
UIHideLogic.uilogicTblMgr = clientTableManager.cfg_uilogicManager
---@type cfg_uilogic_hideManager
UIHideLogic.logicHideTblMgr = clientTableManager.cfg_uilogic_hideManager
---@type cfg_uisetsManager
UIHideLogic.uiSetsTblMgr = clientTableManager.cfg_uisetsManager
UIHideLogic.panelsToBeHiden = nil
---代码层面的规避列表
---@type table
UIHideLogic.avoidListInScript = {
    "UILoginPanel", "UILoginRolePanel", "UIServerListPanel", "UIAllTextTipsContainerPanel", "UIDeadPanel", "UIAntiAddictionPanel"
}

---隐藏逻辑的隐藏缓冲区
---@class table
UIHideLogic.hidenPanelBuffer = {}

---界面打开前检查
---@param panel UIBase
function UIHideLogic:CheckAfterPanelOpened(panel)
    if panel == nil or panel._PanelName == nil then
        return
    end
    local uilogicTbl = self.uilogicTblMgr:GetUILogic(panel._PanelName)
    if uilogicTbl and uilogicTbl:GetHideLogics() and uilogicTbl:GetHideLogics().list then
        self.panelsToBeHiden = {}
        for i = 1, #uilogicTbl:GetHideLogics().list do
            local hideTblIndex = uilogicTbl:GetHideLogics().list[i]
            self:TryHideOtherPanel(panel, hideTblIndex)
        end
        if self.panelsToBeHiden then
            self.hidenPanelBuffer[panel._PanelName] = {}
            ---隐藏需要隐藏的界面
            for i, v in pairs(self.panelsToBeHiden) do
                if v and v._PanelName then
                    local isHiden, isActiveInHierarchy
                    isHiden, isActiveInHierarchy = self:HideTargetPanel(v)
                    if isHiden then
                        for k, l in pairs(self.hidenPanelBuffer) do
                            for s, t in pairs(l) do
                                if t.panelName == v._PanelName then
                                    isActiveInHierarchy = t.isActiveInHierarchy
                                end
                            end
                        end
                        table.insert(self.hidenPanelBuffer[panel._PanelName], {
                            panelName = v._PanelName,
                            isActiveInHierarchy = isActiveInHierarchy
                        })
                    end
                end
            end
        end
        self.panelsToBeHiden = nil
    end
end

---界面关闭后检查是否有界面需要重新显示
---@param panel UIBase
function UIHideLogic:CheckAfterPanelClosed(panel)
    if self.hidenPanelBuffer and panel and panel._PanelName then
        for i, v in pairs(self.hidenPanelBuffer) do
            if i == panel._PanelName and v then
                self.hidenPanelBuffer[i] = nil
                for x, s in pairs(v) do
                    self:ReshowTargetPanel(s)
                end
            end
        end
    end
end

---隐藏目标界面
---@param panel UIBase 检查的界面
---@param hideTblIndex number hide表的索引
function UIHideLogic:TryHideOtherPanel(panel, hideTblIndex)
    if panel and hideTblIndex then
        for i, v in pairs(uimanager.UIGameObjects) do
            if i and i ~= panel._PanelName and v and v.go and CS.StaticUtility.IsNull(v.go) == false and Utility.IsContainsValue(self.avoidListInScript, i) == false then
                if v.PanelLayerTypeInt == nil then
                    v.PanelLayerTypeInt = Utility.EnumToInt(v.PanelLayerType)
                end
                if self.logicHideTblMgr:IsPanelConformToHide(hideTblIndex, i, v.PanelLayerTypeInt) then
                    if Utility.IsContainsValue(self.panelsToBeHiden, v) == false then
                        table.insert(self.panelsToBeHiden, v)
                    end
                end
            end
        end
    end
end

---隐藏目标界面
---@param uipanel UIBase
---@return boolean 是否隐藏成功
---@return boolean 隐藏之前的activeInHierarchy值
function UIHideLogic:HideTargetPanel(uipanel)
    if uipanel then
        if uipanel._PanelState ~= LuaEnumUIState.IsGoingToBeDestroyed and uipanel.go and CS.StaticUtility.IsNull(uipanel.go) == false then
            local isActiveInHierarchy = uipanel.go.activeInHierarchy
            uimanager:HidePanel(uipanel)
            return true, isActiveInHierarchy
        end
    end
    return false
end

---再显示目标界面
---@param uipanelData { panelName:string,isActiveInHierarchy:boolean } 需要重新显示的界面数据
function UIHideLogic:ReshowTargetPanel(uipanelData)
    if uipanelData and uipanelData.panelName then
        for i, v in pairs(uimanager.UIGameObjects) do
            if i == uipanelData.panelName then
                if uipanelData.isActiveInHierarchy then
                    if v._PanelState ~= LuaEnumUIState.IsGoingToBeDestroyed and self:CheckIsPanelAbleToBeReshown(i) then
                        uimanager:ReShowPanel(v)
                    end
                end
            end
        end
    end
end

---@return boolean 是否可以重新显示某界面
function UIHideLogic:CheckIsPanelAbleToBeReshown(targetPanelName)
    if self.hidenPanelBuffer then
        for i, v in pairs(self.hidenPanelBuffer) do
            if v then
                for x, y in pairs(v) do
                    if y.panelName == targetPanelName then
                        return false
                    end
                end
            end
        end
    end
    return true
end

return UIHideLogic