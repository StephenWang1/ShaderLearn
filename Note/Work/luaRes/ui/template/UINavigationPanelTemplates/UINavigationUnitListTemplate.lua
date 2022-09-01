---@class UINavigationUnitListTemplate
local UINavigationUnitListTemplate = {};

UINavigationUnitListTemplate.mTableList = nil;

---@type table<UnityEngine.GameObject,UINavigationUnitTemplate>
UINavigationUnitListTemplate.mUnitDic = nil;

--region Component

---@type TweenPosition
function UINavigationUnitListTemplate:GetUnitTweenPosition()
    if (self.mUintTweenPosition == nil) then
        self.mUnitTweenPosition = self:Get("", "TweenPosition");
    end
    return self.mUnitTweenPosition;
end

---@type TweenAlpha
function UINavigationUnitListTemplate:GetUnitTweenAlpha()
    if (self.mUnitTweenAlpha == nil) then
        self.mUnitTweenAlpha = self:Get("", "TweenAlpha");
    end
    return self.mUnitTweenAlpha;
end

---@type UIGridContainer
function UINavigationUnitListTemplate:GetButtonsGridContainer()
    if (self.mButtonsGridContainer == nil) then
        self.mButtonsGridContainer = CS.Utility_Lua.GetComponent(self.go, "UIGridContainer");
    end
    return self.mButtonsGridContainer;
end

--endregion

--region Method

--region CallFunction
function UINavigationUnitListTemplate:OnTweenPositionFished()
    --self:SetClickState(true);
end
--endregion

--region Public

function UINavigationUnitListTemplate:SelectDefault()
    for k, v in pairs(self.mUnitDic) do
        v:OnClickIcon();
        break ;
    end
end

function UINavigationUnitListTemplate:TrySelect(targetId)
    if (self.mUnitDic == nil) then
        return ;
    end

    for k, v in pairs(self.mUnitDic) do
        if (v.mTableInfo ~= nil and (v.mTableInfo.ID == targetId or targetId == nil)) then
            v:OnClickIcon();
            return true;
        end
    end
    return false;
end

function UINavigationUnitListTemplate:SelectFirst()
    if (self.mUnitDic == nil) then
        return
    end
    for k, v in pairs(self.mUnitDic) do
        if (v.mTableInfo ~= nil) then
            v:OnClickIcon();
            return true;
        end
    end
    return false;
end

---@param tableList List<TABLE.CFG_NAVIGATION>
function UINavigationUnitListTemplate:ShowButtons(tableList)
    self.mTableList = tableList;
    self.go:SetActive(false);

    if (self.mUnitDic == nil) then
        self.mUnitDic = {};
    end
    local gridContainer = self:GetButtonsGridContainer()
    gridContainer.MaxCount = self.mTableList.Count;

    local exitNextNavigation = false
    local itemIndex = 0
    for i = 0, self.mTableList.Count - 1 do
        if (self:IsShowThirdButton(self.mTableList, i) == false) then
            gridContainer.MaxCount = gridContainer.MaxCount - 1
        else
            local gobj = gridContainer.controlList[itemIndex];
            if (self.mUnitDic[gobj] == nil) then
                self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UINavigationUnitTemplate);
            end
            ---@type UINavigationUnitTemplate
            local temp = self.mUnitDic[gobj]
            temp:ShowButton(self.mTableList[i]);
            itemIndex = itemIndex + 1

            exitNextNavigation = true
        end
        i = i + 1
    end
    return exitNextNavigation
end

---@param tableList table<TABLE.CFG_NAVIGATION>
function UINavigationUnitListTemplate:IsShowThirdButton(tableList, tableIndex)
    local table = tableList[tableIndex]

    if (table == nil) then
        return true
    end

    if (table.ID == 42) then
        local list = CS.Cfg_NavigationTableManager.Instance:GetOwnerList(42);
        if (list.Count == 1) then
            ---@type table<LuaPlayerEquipmentListData>
            local list = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetAllSLEquipmentList()
            if (#list == 0) then
                return false
            end
        end
    end

    if (table.ID == 45) then
        ---@type table<LuaPlayerEquipmentListData>
        local list = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetAllSLEquipmentList()
        if (#list == 0) then
            return false
        end
    end

    return true
end

function UINavigationUnitListTemplate:SetClickState(canClick)
    for k, v in pairs(self.mUnitDic) do
        v:GetButtonBoxCollider().enabled = canClick;
    end
end

function UINavigationUnitListTemplate:PlayUnitListFadeIn(callBack)
    if (self.go == nil) then
        return ;
    end

    self.go:SetActive(true);
    --self:SetClickState(false);

    self:GetUnitTweenAlpha():SetOnFinished(function()
        self:OnTweenPositionFished();
        if (callBack ~= nil) then
            callBack();
        end
    end);

    local pos = self.go.transform.localPosition;
    local originPosition = CS.UnityEngine.Vector3(190, pos.y, pos.z);
    local endPosition = CS.UnityEngine.Vector3(0, pos.y, pos.z);
    self:GetUnitTweenPosition().from = originPosition;
    self:GetUnitTweenPosition().to = endPosition;

    local originAlpha = 0;
    local endAlpha = 1;
    self:GetUnitTweenAlpha().from = originAlpha;
    self:GetUnitTweenAlpha().to = endAlpha;

    self:GetUnitTweenPosition():PlayTween();
    self:GetUnitTweenAlpha():PlayTween();
end

function UINavigationUnitListTemplate:OnFadeInFinished()
    if (self.go ~= nil) then
        self.go:SetActive(false);
    end
end

function UINavigationUnitListTemplate:OnFadeOutFinished()
    if (self.go ~= nil) then
        self.go:SetActive(false);
    end
    --for k,v in pairs(self.mUnitDic) do
    --    v:OnFadeOutFinished();
    --end
end

function UINavigationUnitListTemplate:Clear()
    self.mButtonsGridContainer = nil;
    self.mUnitTweenAlpha = nil;
    self.mUnitTweenPosition = nil;
    self.mUnitDic = nil;
end

--endregion

function UINavigationUnitListTemplate:OnDestroy()
    self:Clear();
end

--endregion

return UINavigationUnitListTemplate;