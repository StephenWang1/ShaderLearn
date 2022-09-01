---@class UIRolePanel_EquipTemplateRefine:UIRolePanel_EquipTemplate
local UIRolePanel_EquipTemplateRefine = {}

setmetatable(UIRolePanel_EquipTemplateRefine, luaComponentTemplates.UIRolePanel_EquipTemplate)

UIRolePanel_EquipTemplateRefine.mCurrentChooseItem = nil

function UIRolePanel_EquipTemplateRefine:GetFirstChooseBagItemInfo()
    local refinePanel = uimanager:GetPanel("UIRefinePanel");
    if (refinePanel ~= nil) then
        return refinePanel:GetFirstChooseBagItemInfo();
    end
    return nil;
end

function UIRolePanel_EquipTemplateRefine:GetSecondChooseBagItemInfo()
    local refinePanel = uimanager:GetPanel("UIRefinePanel");
    if (refinePanel ~= nil) then
        return refinePanel:GetSecondChooseBagItemInfo();
    end
    return nil;
end

function UIRolePanel_EquipTemplateRefine:GetMainChooseBagItemInfo()
    local refinePanel = uimanager:GetPanel("UIRefinePanel");
    if (refinePanel ~= nil) then
        return refinePanel:GetMainChooseBagItemInfo();
    end
    return nil;
end

---帧更新事件
function UIRolePanel_EquipTemplateRefine:Update()
    if (self.mIsLongPress) then
        self.mTimer = self.mTimer + CS.UnityEngine.Time.deltaTime;
        if (self.mTimer >= 0.2) then
            self.mIsLongPress = false;
            if (self.mPressTarget ~= nil) then
                local template = self.mGridToTemplate[self.mPressTarget]
                self:ShowItemInfo(template, false);
                self.mPressTarget = nil;
            end
            return ;
        end
    end
end

---重写角装备格子按下事件
function UIRolePanel_EquipTemplateRefine:OnRolePanelGirdOnPress(go, state, bagItemInfo, itemInfo, equipIndex)
    self.mTimer = 0;
    if (state) then
        self.mIsLongPress = true;
        self.mPressTarget = go;
    else
        self.mIsLongPress = false;
    end
end

---重写角色格子点击事件
function UIRolePanel_EquipTemplateRefine:OnItemClicked(go)
    local template = self.mGridToTemplate[go];
    if (template.mIsChoose) then
        self:ShowItemInfo(template, false);
    else
        local tipsInfo = {};
        local hasError = false;
        local bagItemInfo = template.bagItemInfo;
        if bagItemInfo ~= nil then
            if (not CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(bagItemInfo.itemId)) then
                tipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
                tipsInfo[LuaEnumTipConfigType.ConfigID] = 329
                hasError = true;
                --elseif(self:GetMainChooseBagItemInfo() ~= nil and self:GetMainChooseBagItemInfo().itemId == bagItemInfo.itemId and bagItemInfo.lid ~= self:GetMainChooseBagItemInfo().lid) then
                --    local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfo(self:GetMainChooseBagItemInfo().lid);
                --    if(equipInfo ~= nil) then
                --        tipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
                --        tipsInfo[LuaEnumTipConfigType.ConfigID] = 329
                --        hasError = true;
                --    end
                --else
                --if(self:GetFirstChooseBagItemInfo() ~= nil) then
                --    if(self:GetFirstChooseBagItemInfo().itemId ~= bagItemInfo.itemId) then
                --        tipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
                --        tipsInfo[LuaEnumTipConfigType.ConfigID] = 331;
                --        hasError = true;
                --    end
                --elseif(self:GetSecondChooseBagItemInfo() ~= nil) then
                --    if(self:GetSecondChooseBagItemInfo().itemId ~= bagItemInfo.itemId) then
                --        tipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
                --        tipsInfo[LuaEnumTipConfigType.ConfigID] = 331;
                --        hasError = true;
                --    end
                --end
            end
        end

        if (not hasError) then
            self:RunBaseFunction("OnItemClicked", go);
        else
            uimanager:CreatePanel("UIBubbleTipsPanel", nil, tipsInfo);
        end
    end
end

---重写选中角色格子事件
function UIRolePanel_EquipTemplateRefine:SetItemChoose(equipIndex)
    --if self.mEquipIndexToTemplate and equipIndex and self.mEquipIndexToTemplate[equipIndex] then
    --    local go = self.mEquipIndexToGrid[equipIndex]
    --    if UIRolePanel_EquipTemplateRefine.mCurrentChooseItem == go then
    --        return
    --    end
    --    self:HideCurrentChooseItem()
    --    self:SetItemShowChoose(true, go)
    --    UIRolePanel_EquipTemplateRefine.mCurrentChooseItem = go
    --end
    self:UpdateGrid();
end

---隐藏当前选中物品
function UIRolePanel_EquipTemplateRefine:HideCurrentChooseItem()
    --if UIRolePanel_EquipTemplateRefine.mCurrentChooseItem ~= nil then
    --    self:SetItemShowChoose(false, UIRolePanel_EquipTemplateRefine.mCurrentChooseItem)
    --    UIRolePanel_EquipTemplateRefine.mCurrentChooseItem = nil
    --end
    self:UpdateGrid();
end

---设置某格子选中显示
function UIRolePanel_EquipTemplateRefine:SetItemShowChoose(isShow, go)
    local template = self.mGridToTemplate[go]
    if template and template.ChooseItem then
        template:ChooseItem(isShow)
    end
end

function UIRolePanel_EquipTemplateRefine:UpdateGrid()
    if (self.mCoroutineUpdateGrid ~= nil) then
        StopCoroutine(self.mCoroutineUpdateGrid);
        self.mCoroutineUpdateGrid = nil;
    end
    self.mCoroutineUpdateGrid = StartCoroutine(self.CDelayUpdateGrid, self);
    --self:CDelayUpdateGrid();
end

function UIRolePanel_EquipTemplateRefine:CDelayUpdateGrid()
    coroutine.yield(0);
    self:RefreshGrid();
    for k, v in pairs(self.mGridToTemplate) do
        self:SetItemShowChoose(false, v.go);
        if (v.bagItemInfo ~= nil) then
            if (self:GetFirstChooseBagItemInfo() ~= nil) then
                if (v.bagItemInfo.lid == self:GetFirstChooseBagItemInfo().lid) then
                    self:SetItemShowChoose(true, v.go);
                end
            end
            if (self:GetSecondChooseBagItemInfo() ~= nil) then
                if (v.bagItemInfo.lid == self:GetSecondChooseBagItemInfo().lid) then
                    self:SetItemShowChoose(true, v.go);
                end
            end
        end
    end
    --if(UIRolePanel_EquipTemplateRefine.mCurrentChooseItem ~= nil) then
    --    local template = self.mGridToTemplate[UIRolePanel_EquipTemplateRefine.mCurrentChooseItem];
    --    if(template ~= nil and template.bagItemInfo == nil) then
    --        self:HideCurrentChooseItem();
    --    elseif(template.bagItemInfo ~= nil) then
    --        if(self:GetFirstChooseBagItemInfo() ~= nil and template.bagItemInfo.lid ~= self:GetFirstChooseBagItemInfo().lid) and (self:GetSecondChooseBagItemInfo() ~= nil and template.bagItemInfo.lid ~= self:GetSecondChooseBagItemInfo().lid) then
    --            self:HideCurrentChooseItem();
    --        elseif(self:GetSecondChooseBagItemInfo() == nil and self:GetFirstChooseBagItemInfo() == nil) then
    --            self:HideCurrentChooseItem();
    --        end
    --    end
    --end
end

function UIRolePanel_EquipTemplateRefine:OnEnable()
    self:RunBaseFunction("OnEnable");
    self.CallOnClearFirstBagItem = function(msgId, msgData)
        --if(UIRolePanel_EquipTemplateRefine.mCurrentChooseItem ~= nil) then
        --    local template = self.mGridToTemplate[UIRolePanel_EquipTemplateRefine.mCurrentChooseItem];
        --    if(template ~= nil and template.bagItemInfo ~= nil and msgData ~= nil) then
        --        if(template.bagItemInfo.lid == msgData.lid) then
        --            self:HideCurrentChooseItem();
        --        end
        --    end
        --end

        self:UpdateGrid();
    end

    self.CallOnClearSecondBagItem = function(msgId, msgData)
        self:UpdateGrid();
    end

    self.CallOnFirstBagItemChange = function()
        self:UpdateGrid();
    end

    self.CallOnSecondBagItemChange = function()
        self:UpdateGrid();
    end
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Refine_OnClearFirstBagItem, self.CallOnClearFirstBagItem)
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Refine_OnClearSecondBagItem, self.CallOnClearSecondBagItem)
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Refine_OnFirstBagItemChange, self.CallOnFirstBagItemChange)
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Refine_OnSecondBagItemChange, self.CallOnSecondBagItemChange)
    end

end

function UIRolePanel_EquipTemplateRefine:OnDisable()
    self:RunBaseFunction("OnDisable");
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Refine_OnClearFirstBagItem, self.CallOnClearFirstBagItem)
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Refine_OnClearSecondBagItem, self.CallOnClearSecondBagItem)
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Refine_OnFirstBagItemChange, self.CallOnFirstBagItemChange)
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Refine_OnSecondBagItemChange, self.CallOnSecondBagItemChange)
    end

    if (self.mCoroutineUpdateGrid ~= nil) then
        StopCoroutine(self.mCoroutineUpdateGrid);
        self.mCoroutineUpdateGrid = nil;
    end
end

function UIRolePanel_EquipTemplateRefine:OnDestroy()
    self:RunBaseFunction("OnDestroy");
    UIRolePanel_EquipTemplateRefine.mCurrentChooseItem = nil

    if (self.mCoroutineUpdateGrid ~= nil) then
        StopCoroutine(self.mCoroutineUpdateGrid);
        self.mCoroutineUpdateGrid = nil;
    end
end

return UIRolePanel_EquipTemplateRefine