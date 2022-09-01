---@class UIActivityInformationPanel:UIBase
local UIActivityInformationPanel = {}

--region 局部变量

--endregion

--region 初始化

function UIActivityInformationPanel:Init()
    self:AddCollider()
    self:InitCommonComponent()
    self:InitUIEvent()
end

function UIActivityInformationPanel:InitCommonComponent()
    UIActivityInformationPanel.CloseBtn = self:GetCurComp("WidgetRoot/Root/events/btn_close", "GameObject")
end

function UIActivityInformationPanel:InitUIEvent()
    --点击关闭事件
    CS.UIEventListener.Get(UIActivityInformationPanel.CloseBtn.gameObject).onClick = function()
    self:OnClickCloseCallBack()
    end
end

function UIActivityInformationPanel:OnClickCloseCallBack()
    uimanager:ClosePanel("UIActivityInformationPanel")
end

---@param data customData
---@alias customData{settleInfo:CS.ActivitySettleBaseVO,rankId:number}
function UIActivityInformationPanel:Show(customData)
    if customData then
        if self.id ~= customData.rankId then
            self.id = customData.rankId
            if self.activityInfoClass ~= nil then
                self.activityInfoClass:Clear()
            end
            local class = luaclass[uiStaticParameter.ActivityRankInfomationClass[customData.rankId]]
            if class == nil then
                class = luaclass.UIActivityRankInfoViewBase
            end
            self.activityInfoClass = class:NewWithGO(self.go)
        end
        self.activityInfoClass:SetUI(customData)
        if self.activityInfoClass.headicon ~= nil then
            CS.UIEventListener.Get(self.activityInfoClass.headicon.gameObject).LuaEventTable = self
            CS.UIEventListener.Get(self.activityInfoClass.headicon.gameObject).OnClickLuaDelegate = self.OnIconClick
        end
    end
end

--endregion

--region 函数监听

function UIActivityInformationPanel:OnIconClick(go)
    if self.activityInfoClass.rid ~= nil then
        --CS.CSScene.MainPlayerInfo.OtherPlayerInfo:ReqOtherPlayerMsg(self.activityInfoClass.rid, LuaEnumOtherPlayerBtnType.ROLE,LuaEnumOtherPlayerBtnSubtype.OTHERROLE)
        -- uimanager:ClosePanel("UIActivityInformationPanel")
        if (self.activityInfoClass.rid == CS.CSScene.MainPlayerInfo.ID) then
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Equip);
        else
            uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                panelType = LuaEnumPanelIDType.RankPanel_RoleInfo,
                roleId = self.activityInfoClass.rid,
                roleName = self.activityInfoClass.name
            })
        end
        uimanager:ClosePanel("UIActivityInformationPanel");
    end
end

--endregion


--region 网络消息处理

--endregion

--region UI

--endregion

--region otherFunction

--endregion

--region ondestroy

function UIActivityInformationPanel:Clear()
    if self.activityInfoClass ~= nil then
        self.activityInfoClass:Clear()
    end
end

function ondestroy()
    UIActivityInformationPanel:Clear()
end

--endregion

return UIActivityInformationPanel