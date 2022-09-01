---@class UICloseLogic
local UICloseLogic = {}

local Utility = Utility

---@type cfg_uilogicManager
UICloseLogic.uilogicTblMgr = clientTableManager.cfg_uilogicManager
---@type cfg_uilogic_closeManager
UICloseLogic.logicCloseTblMgr = clientTableManager.cfg_uilogic_closeManager
---@type cfg_uisetsManager
UICloseLogic.uiSetsTblMgr = clientTableManager.cfg_uisetsManager
---代码层面的规避列表
---@type table
UICloseLogic.avoidListInScript = {
    "UILoginPanel", "UILoginRolePanel", "UIServerListPanel", "UIAllTextTipsContainerPanel", "UIDeadPanel", "UIAntiAddictionPanel"
}

---界面打开前检查
---@param panel UIBase
function UICloseLogic:CheckAfterPanelOpened(panel)
    if panel == nil or panel._PanelName == nil then
        return
    end
    local uilogicTbl = self.uilogicTblMgr:GetUILogic(panel._PanelName)
    if uilogicTbl and uilogicTbl:GetCloseLogics() and uilogicTbl:GetCloseLogics().list then
        for i = 1, #uilogicTbl:GetCloseLogics().list do
            local closeTblIndex = uilogicTbl:GetCloseLogics().list[i]
            local closeTbl = self.logicCloseTblMgr:TryGetValue(closeTblIndex)
            if closeTbl and closeTbl:GetCloseType() == 2 then
                local targetPanelList = closeTbl:GetTargetPanelList()
                local targetSelectType = closeTbl:GetTargetSelectType()
                local uisetID = closeTbl:GetUisetID()
                --遍历所有已经打开的界面集合,按照关闭逻辑关闭符合条件的面板
                for panelNameTemp, panelTemp in pairs(uimanager.UIGameObjects) do
                    --规避自身的界面
                    if panelNameTemp ~= panel._PanelName and panelTemp and Utility.IsContainsValue(self.avoidListInScript, panelNameTemp) == false then
                        if panelTemp.PanelLayerTypeInt == nil then
                            panelTemp.PanelLayerTypeInt = Utility.EnumToInt(panelTemp.PanelLayerType)
                        end
                        --判断当前判断的界面是否属于集合内
                        local isInUISets = uisetID == 0 or self.uiSetsTblMgr:IsContainedInUISets(uisetID, panelNameTemp, Utility.EnumToInt(panelTemp.PanelLayerType))

                        local containTarget = targetPanelList ~= nil and Utility.IsContainsValue(targetPanelList.list, panelNameTemp)
                        if isInUISets then
                            if targetSelectType == 1 then
                                --关闭集合中除指定界面外的其他界面
                                if containTarget == false then
                                    uimanager:ClosePanel(panelNameTemp)
                                end
                            elseif targetSelectType == 2 then
                                --关闭集合中指定界面
                                if containTarget then
                                    uimanager:ClosePanel(panelNameTemp)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

---界面关闭前检查是否有界面需要关闭
---@param panel UIBase
function UICloseLogic:CheckAfterPanelClosed(panel)
    if panel == nil or panel._PanelName == nil then
        return
    end
    local uilogicTbl = self.uilogicTblMgr:GetUILogic(panel._PanelName)
    if uilogicTbl and uilogicTbl:GetCloseLogics() and uilogicTbl:GetCloseLogics().list then
        for i = 1, #uilogicTbl:GetCloseLogics().list do
            local closeTblIndex = uilogicTbl:GetCloseLogics().list[i]
            local closeTbl = self.logicCloseTblMgr:TryGetValue(closeTblIndex)
            if closeTbl and closeTbl:GetCloseType() == 1 then
                local targetPanelList = closeTbl:GetTargetPanelList()
                if closeTbl:GetTargetSelectType() == 2 then
                    --关闭集合中指定界面
                    --遍历所有已经打开的界面集合,按照关闭逻辑关闭符合条件的面板
                    for panelNameTemp, panelTemp in pairs(uimanager.UIGameObjects) do
                        --规避自身的界面
                        if panelNameTemp ~= panel._PanelName and panelTemp and Utility.IsContainsValue(self.avoidListInScript, panelNameTemp) == false then
                            if panelTemp.PanelLayerTypeInt == nil then
                                panelTemp.PanelLayerTypeInt = Utility.EnumToInt(panelTemp.PanelLayerType)
                            end
                            --判断当前判断的界面是否属于集合内
                            local isInUISets = closeTbl:GetUisetID() == 0
                                    or self.uiSetsTblMgr:IsContainedInUISets(closeTbl:GetUisetID(), panelNameTemp, panelTemp.PanelLayerTypeInt)
                            local containTarget = targetPanelList ~= nil and Utility.IsContainsValue(targetPanelList.list, panelNameTemp)
                            if isInUISets then
                                if containTarget then
                                    uimanager:ClosePanel(panelNameTemp, true)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

return UICloseLogic