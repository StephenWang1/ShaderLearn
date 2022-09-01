---@class UIGodPowerTotemPanel:UIBase 神级boss入口面板
local UIGodPowerTotemPanel = {}

--region 初始化
function UIGodPowerTotemPanel:Init()
    self:InitComponent()
    self:BindEvents()
end

function UIGodPowerTotemPanel:InitComponent()
    ---@type UnityEngine.GameObject
    self.CloseBtn_GameObject = self:GetCurComp("WidgetRoot/CloseBtn","GameObject")
    ---@type UnityEngine.GameObject
    self.EnterBtn_GameObject = self:GetCurComp("WidgetRoot/EnterBtn","GameObject")
end

function UIGodPowerTotemPanel:BindEvents()
    luaclass.UIRefresh:BindClickCallBack(self.CloseBtn_GameObject,function() uimanager:ClosePanel(self) end)
    luaclass.UIRefresh:BindClickCallBack(self.EnterBtn_GameObject,function()
        networkRequest.ReqDeliverByConfig(130006)
        uimanager:ClosePanel(self)
    end)
end
--endregion

--region 刷新
function UIGodPowerTotemPanel:Show(data,curdata)
    
end
--endregion
return UIGodPowerTotemPanel