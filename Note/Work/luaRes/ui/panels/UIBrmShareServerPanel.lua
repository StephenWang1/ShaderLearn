local UIBrmShareServerPanel = {}

UIBrmShareServerPanel.mTemplateDic = {}
--region 组件
function UIBrmShareServerPanel:GetShareGrid_LoopScrollView()
    if (self.mShareGrid == nil) then
        self.mShareGrid = self:GetCurComp("WidgetRoot/view/MainView/ShareServer/scroll/Grid", "UILoopScrollViewPlus")
    end
    return self.mShareGrid
end
--endregion

---@type BaiRiMenActController_Hunt 获取白日门联服活动数据管理
function UIBrmShareServerPanel:GetActController_CrossServerActivity()
    return gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_CrossServerActivity()
end

function UIBrmShareServerPanel:GetSingleActivityTemplate(go, data)
    if (self.mTemplateDic[go] == nil) then
        self.mTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBrmCrossServerActivityTemplate, data)
    end
    return self.mTemplateDic[go]
end

function UIBrmShareServerPanel:Init()

end

function UIBrmShareServerPanel:Show()
    self:RefreshPanel()
end

function UIBrmShareServerPanel:RefreshPanel()
    local infos = self:GetActController_CrossServerActivity():GetActivityTables()
    self:GetShareGrid_LoopScrollView():Init(function(go, line)
        if line < #infos then
            ---@type UIBrmCrossServerActivityTemplate
            local template = self:GetSingleActivityTemplate(go, infos[line + 1])
            template:Refresh()
            return true
        else
            return false
        end
    end)
end

function ondestroy()

end

return UIBrmShareServerPanel