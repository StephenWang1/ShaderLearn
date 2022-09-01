---@class UIMapDirectionPanel:UIBase
local UIMapDirectionPanel = {}

UIMapDirectionPanel.mActivityButtonsState = false;

---@return UIEnemyWarning
function UIMapDirectionPanel:GetEnemyWarning()
    if self.mEnemyWarning == nil then
        self.mEnemyWarning = self:GetCurComp("WidgetRoot/view", "UIEnemyWarning")
    end
    return self.mEnemyWarning
end

function UIMapDirectionPanel:GetDangers()
    if self.mGetDangers == nil then
        self.mGetDangers = self:GetCurComp("WidgetRoot/view/dangers", "GameObject")
    end
    return self.mGetDangers
end

function UIMapDirectionPanel:Init()
    self:BindMessages()
    if CS.StaticUtility.IsNull(self:GetEnemyWarning()) == false then
        self:GetEnemyWarning():RefreshWarningTarget(0)
    end
end

function UIMapDirectionPanel:BindMessages()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_EnemyWarning_FocusOnEnemy, function(id, targetID)
        if CS.StaticUtility.IsNull(self:GetEnemyWarning()) == false then
            self:GetEnemyWarning():RefreshWarningTarget(targetID)
            self:GetEnemyWarning().gameObject:SetActive(not UIMapDirectionPanel.mActivityButtonsState);
            luaEventManager.DoCallback(LuaCEvent.FastUseItem_UpdateRandomStoneEffect);
        end
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_EnemyWarning_Clear, function(id, data)
        if CS.StaticUtility.IsNull(self:GetEnemyWarning()) == false then
            self:GetEnemyWarning():RefreshWarningTarget(0)
        end
    end)

    UIMapDirectionPanel.CallOnActivityButtonsOpened = function()
        UIMapDirectionPanel.mActivityButtonsState = true;
        if CS.StaticUtility.IsNull(self:GetEnemyWarning()) == false then
            self:GetEnemyWarning().gameObject:SetActive(false);
        end
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ActivityButtons_OnButtonsOpened, UIMapDirectionPanel.CallOnActivityButtonsOpened)

    UIMapDirectionPanel.CallOnActivityButtonsClosed = function()
        UIMapDirectionPanel.mActivityButtonsState = false;
        if CS.StaticUtility.IsNull(self:GetEnemyWarning()) == false then
            self:GetEnemyWarning():RefreshWarningTarget();
        end
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ActivityButtons_OnButtonsClosed, UIMapDirectionPanel.CallOnActivityButtonsClosed)
end

function ondestroy()
    luaEventManager.DoCallback(LuaCEvent.FastUseItem_UpdateRandomStoneEffect);
    --luaEventManager.RemoveCallback(LuaCEvent.ActivityButtons_OnButtonsOpened, UIMapDirectionPanel.CallOnActivityButtonsOpened);
    --luaEventManager.RemoveCallback(LuaCEvent.ActivityButtons_OnButtonsClosed, UIMapDirectionPanel.CallOnActivityButtonsClosed);
end

return UIMapDirectionPanel