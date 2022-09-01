---@class HintPopTips:UIBase
local HintPopTips = {}

HintPopTips.PanelLayerType = CS.UILayerType.BasicPlane

HintPopTips.IsInitialLoad=true

function HintPopTips:Init()
    self:InitComponents()
    self:BindEvents()
end

function HintPopTips:InitComponents()
    self.HintClickTipsTemplate = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.HintClickTipsTemplate)
end

function HintPopTips:BindEvents()
    self:GetClientEventHandler():AddEvent(CS.CEvent.OpenPanel, function(id,panelName)
        self.HintClickTipsTemplate:RefreshAllPopState(panelName)
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.ClosePanel, function(id,panelName)
        self.HintClickTipsTemplate:RefreshAllPopState(panelName)
    end)
end


--region 提示气泡
---@param commonData.id number Cfg_Guide_BubbleTableManager表的id
---@param commonData.point UnityEngine.GameObject 挂载节点
---@param commonData.clickCallBack function 点击回调
function HintPopTips:TryHintTips(commonData)
    if commonData.id ~= nil and commonData.point ~= nil then
        local tableIsFind,table = CS.Cfg_Guide_BubbleTableManager.Instance:TryGetValue(commonData.id)
        if tableIsFind == true then
            commonData.guidBubbleInfo = table
            local tipTemplate = self.HintClickTipsTemplate:RefreshTips(commonData)
            return tipTemplate
        end
    end
end

---移除提示气泡
function HintPopTips:RemoveTips(tipsTemplate)
    if self.HintClickTipsTemplate ~= nil then
        self.HintClickTipsTemplate:RemoveTips(tipsTemplate)
    end
end
--endregion
return HintPopTips