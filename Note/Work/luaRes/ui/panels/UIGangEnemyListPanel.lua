---@class UIGangEnemyListPanel:UIBase
local UIGangEnemyListPanel = {}

UIGangEnemyListPanel.RevengePointGo = nil
UIGangEnemyListPanel.RevengePointID = 0
--region 组件
function UIGangEnemyListPanel:GetCloseBtn()
    if (self.mCloseBtn == nil) then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

function UIGangEnemyListPanel:GetPlayer_ScrollViewPlus()
    if (self.mPlayerScrollViewPlus == nil) then
        self.mPlayerScrollViewPlus = self:GetCurComp("WidgetRoot/view/Scroll View/player", "UILoopScrollViewPlus")
    end
    return self.mPlayerScrollViewPlus
end
--endregion

--region 初始化

function UIGangEnemyListPanel:Init()
    self:BindMessage()
    self:BindUIEvent()
end

function UIGangEnemyListPanel:Show()
    self:RefreshUIPanel()
end

function UIGangEnemyListPanel:BindUIEvent()
    CS.UIEventListener.Get(self:GetCloseBtn()).onClick = self.CloseBtnOnClickEvent
end

function UIGangEnemyListPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, UIGangEnemyListPanel.OnResHasPlayerSomeInfoMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRewardUnionRevengeMessage, UIGangEnemyListPanel.OnResRewardUnionRevengeMessage)
end
--endregion

--region 界面逻辑
function UIGangEnemyListPanel.CloseBtnOnClickEvent()
    uimanager:ClosePanel("UIGangEnemyListPanel")
end

function UIGangEnemyListPanel:RefreshUIPanel()
    self:GetPlayer_ScrollViewPlus():Init(function(go, line)
        local data = gameMgr:GetPlayerDataMgr():GetUnionInfo():GetUnionEnemyTable()[line + 1]
        if (data == nil) then
            return false
        end
        local template = self:GetUnionEnemyTemplate(go)
        if template then
            template:Refresh(data)
        end
        return true
    end, nil)
end

---@param go UnityEngine.GameObject
---@return UIRechargeRewardTemplate
function UIGangEnemyListPanel:GetUnionEnemyTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGuildEnemytemplate, self)
    end
    return template
end

---@param trans GameObject 按钮
---@param str string    内容
---@param id  number    提示框id
function UIGangEnemyListPanel:ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion

--region 服务器消息
function UIGangEnemyListPanel.OnResHasPlayerSomeInfoMessage(id, tbldata)
    if (tbldata ~= nil and tbldata.type == luaEnumRspServerCommonType.PlayIsOnLine and tbldata.data == 1) then
        --在线
        uimanager:CreatePanel("UIGangTrackPromptPanel", nil, UIGangEnemyListPanel.RevengePointID)
    else
        --离线
        if (UIGangEnemyListPanel.RevengePointGo ~= nil) then
            UIGangEnemyListPanel:ShowTips(UIGangEnemyListPanel.RevengePointGo, 356)
        end
    end
end

function UIGangEnemyListPanel.OnResRewardUnionRevengeMessage(id, data)
    UIGangEnemyListPanel:RefreshUIPanel()
end
--endregion

return UIGangEnemyListPanel