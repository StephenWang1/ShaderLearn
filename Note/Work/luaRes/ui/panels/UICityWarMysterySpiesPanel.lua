---@class UICityWarMysterySpiesPanel:UIBase
local UICityWarMysterySpiesPanel = {}

local this = nil;

UICityWarMysterySpiesPanel.mOccupyUnionData = nil;

--region Components

function UICityWarMysterySpiesPanel:GetBtnClose_GameObject()
    if(this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/events/CloseBtn","GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UICityWarMysterySpiesPanel:GetNoGuild_GameObject()
    if(this.mNoGuild_GameObject == nil) then
        this.mNoGuild_GameObject = this:GetCurComp("WidgetRoot/NoGuild","GameObject");
    end
    return this.mNoGuild_GameObject;
end

function UICityWarMysterySpiesPanel:GetNoTarget_GameObject()
    if(this.mNoTarget_GameObject == nil) then
        this.mNoTarget_GameObject = this:GetCurComp("WidgetRoot/notarget","GameObject");
    end
    return this.mNoTarget_GameObject;
end

function UICityWarMysterySpiesPanel:GetUnitGridContainer()
    if(this.mUnitGridContainer == nil) then
        this.mUnitGridContainer = this:GetCurComp("WidgetRoot/ScrollView/ObjectArea","UIGridContainer");
    end
    return this.mUnitGridContainer;
end

--endregion


--region Method

--region CallFunction

function UICityWarMysterySpiesPanel:OnResBrokerPanelMessage(msgData)
    this.mOccupyUnionData = msgData;
    this:UpdateUI();
    this:UpdateUnit();
end

--endregion

--region Public

function UICityWarMysterySpiesPanel:UpdateUI()
    local hasOccupyUnion = false;
    local hasOccupyUnionPlayers = false;
    if(this.mOccupyUnionData ~= nil)then
        if(this.mOccupyUnionData.unionId ~= 0) then
            hasOccupyUnion = true;
            if(this.mOccupyUnionData.players ~= nil and #this.mOccupyUnionData.players > 0) then
                hasOccupyUnionPlayers = true;
            end
        end
    end
    this:GetNoGuild_GameObject():SetActive(not hasOccupyUnion);
    this:GetNoTarget_GameObject(not hasOccupyUnionPlayers);
end

function UICityWarMysterySpiesPanel:UpdateUnit()
    if(this.mUnitDic == nil) then
        this.mUnitDic = {};
    end
    local gridContainer = this:GetUnitGridContainer();
    if(this.mOccupyUnionData ~= nil and this.mOccupyUnionData.players ~= nil) then
        local unionPlayers = this.mOccupyUnionData.players;
        gridContainer.MaxCount = #unionPlayers;
        for i = 0, gridContainer.MaxCount - 1 do
            local gobj = gridContainer.controlList[i];
            if(this.mUnitDic[gobj] == nil) then
                this.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UICityWarMysterySpiesUnitTemplate);
            end
            this.mUnitDic[gobj]:UpdateUnit(unionPlayers[i + 1]);
        end
    else
        gridContainer.MaxCount = 0
    end
end

--endregion

--region Private

function UICityWarMysterySpiesPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UICityWarMysterySpiesPanel");
    end

    this.CallOnResBrokerPanelMessage = function(msgId, msgData)
        this:OnResBrokerPanelMessage(msgData);
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBrokerPanelMessage, this.CallOnResBrokerPanelMessage)
end

--endregion

--endregion

function UICityWarMysterySpiesPanel:Init()
    this = self;

    this:InitEvents();
end

function UICityWarMysterySpiesPanel:Show(customData)
    this:GetNoGuild_GameObject():SetActive(this.mOccupyUnionData == nil or this.mOccupyUnionData.unionId == 0);
    networkRequest.ReqOpenBrokerPanel();
end

return UICityWarMysterySpiesPanel;