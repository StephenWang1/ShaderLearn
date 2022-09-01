---帮会推送界面
---@class UIChooseGuildPanel:UIBase
local UIChooseGuildPanel = {}

--region 属性
---@return CSPlayerInfo 玩家信息
function UIChooseGuildPanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSUnionInfoV2 帮会信息
function UIChooseGuildPanel:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil and self:GetPlayerInfo() then
        self.mUnionInfoV2 = self:GetPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfoV2
end
--endregion

--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UIChooseGuildPanel:GetCloseBtn()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
    end
    return self.mCloseBtn
end

---@return UIGridContainer 特权container
function UIChooseGuildPanel:GetContainer_UIGridContainer()
    if self.mGridContainer == nil then
        self.mGridContainer = self:GetCurComp("WidgetRoot/view/ScrollView/Grid", "UIGridContainer")
    end
    return self.mGridContainer
end

---@return UnityEngine.GameObject 加入帮会按钮
function UIChooseGuildPanel:GetJoinUnion_GameObject()
    if self.mJoinUnionBtn == nil then
        self.mJoinUnionBtn = self:GetCurComp("WidgetRoot/event/btn_Join", "GameObject")
    end
    return self.mJoinUnionBtn
end

--endregion

--region 初始化
function UIChooseGuildPanel:Init()
    self:BindEvents()
    self:BindMessage()
end

function UIChooseGuildPanel:Show()
    self:RefreshPushList()
end

function UIChooseGuildPanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseBtn()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetJoinUnion_GameObject()).onClick = function()
        self:OnJoinClicked()
    end
end

function UIChooseGuildPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_AllUnionInfoChange, function()

    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.UnionIDChange, function()
        local unionId = self:GetUnionInfoV2().UnionID
        if unionId and unionId ~= 0 then
            uimanager:CreatePanel("UIGuildPanel")
            self:ClosePanel()
        end
    end)
end
--endregion

--region UI事件
---刷新帮会推送显示
function UIChooseGuildPanel:RefreshPushList()
    local array = CS.Cfg_GlobalTableManager.Instance:UnionPushIcon()
    if array then
        --sp个数据为一组
        local sp = 1
        local group = array.Length / sp
        self:GetContainer_UIGridContainer().MaxCount = group
        for i = 0, group - 1 do
            ---@type UnityEngine.GameObject
            local go = self:GetContainer_UIGridContainer().controlList[i]
            if not CS.StaticUtility.IsNull(go) then
                if array.Length >= i * sp then
                    local icon = array[i * sp]
                    local sprite = CS.Utility_Lua.GetComponent(go.transform:Find("icon"),"UISprite")
                    sprite.spriteName = icon
                end
            end
        end
    end
end

---点击进入按钮
function UIChooseGuildPanel:OnJoinClicked()
    if self:GetUnionInfoV2() and self:GetUnionInfoV2().PushList and self:GetUnionInfoV2().PushList.Count > 0 then
        local unionInfo = self:GetUnionInfoV2().PushList[0]
        networkRequest.ReqJoinOrWithdrawUnion(unionInfo.unionId, unionInfo.applyState)
    end
end
--endregion

return UIChooseGuildPanel