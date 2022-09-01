---灵兽装备面板（炼化状态下）
---@class UIServantPanel_Base_Refine:UIServantPanel_Base
local UIServantPanel_Base_Refine = {};

setmetatable(UIServantPanel_Base_Refine, luaComponentTemplates.UIServantPanel_Base)

---@return bagV2.BagItemInfo
function UIServantPanel_Base_Refine:GetFirstChooseBagItemInfo()
    local refinePanel = uimanager:GetPanel("UIRefinePanel");
    if (refinePanel ~= nil) then
        return refinePanel:GetFirstChooseBagItemInfo();
    end
    return nil;
end

---@return bagV2.BagItemInfo
function UIServantPanel_Base_Refine:GetSecondChooseBagItemInfo()
    local refinePanel = uimanager:GetPanel("UIRefinePanel");
    if (refinePanel ~= nil) then
        return refinePanel:GetSecondChooseBagItemInfo();
    end
    return nil;
end

---@return bagV2.BagItemInfo
function UIServantPanel_Base_Refine:GetMainChooseBagItemInfo()
    local refinePanel = uimanager:GetPanel("UIRefinePanel");
    if (refinePanel ~= nil) then
        return refinePanel:GetMainChooseBagItemInfo();
    end
    return nil;
end
function UIServantPanel_Base_Refine:Init(panel)
    self:RunBaseFunction("Init", panel)
    self.ServantPanel:ShowOtherButton(false)
    self:GetAllBtn_GameObject():SetActive(false)
    self:GetEquipHelp_GameObject():SetActive(false)
end

function UIServantPanel_Base_Refine:OnClickEquip(go)
    local template = self.mGridToTemplate[go]
    if template then
        local bagItemInfo = template.BagItemInfo
        if bagItemInfo and bagItemInfo.ItemTABLE then
            local canSynthesis = CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(bagItemInfo.itemId);
            if canSynthesis then
                local tipsInfo = {};
                local hasError = false;
                if bagItemInfo ~= nil then
                    if (not CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(bagItemInfo.itemId)) then
                        tipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
                        tipsInfo[LuaEnumTipConfigType.ConfigID] = 329
                        hasError = true;
                    end
                end
                if (not hasError) then
                    luaEventManager.DoCallback(LuaCEvent.Servant_OnEquipRefineClick, bagItemInfo);
                else
                    uimanager:CreatePanel("UIBubbleTipsPanel", nil, tipsInfo);
                end
                self:UpdateGrid();
            else
                Utility.ShowPopoTips(go, nil, 329, "UIServantPanel")
            end
        end
    end
end

---灵兽切换刷新选中
function UIServantPanel_Base_Refine:RefreshServant(servantInfo, panelOpenType, bagItemInfo, isMainPlayerServant)
    self:RunBaseFunction("RefreshServant", servantInfo, panelOpenType, bagItemInfo, isMainPlayerServant)
    self.ServantPanel:GetBtnShowAttribute():SetActive(false);
    self.ServantPanel:ShowOtherButton(false);
end

function UIServantPanel_Base_Refine:RefreshGridTemp(temp, index, equipInfo, grid, servantType)
    if (equipInfo == nil) or grid:IsNull() then
        return
    end
    --红点
    local redPoint = grid.transform:Find("RedPoint").gameObject
    redPoint:SetActive(false)
    --加号
    local add = grid.transform:Find("add").gameObject
    add:SetActive(false)
    --刷新装备信息
    CS.UIEventListener.Get(grid).LuaEventTable = self
    self.mGridToTemplate[grid] = temp
    local res, dicInfo = equipInfo:TryGetValue(index)
    if res then
        --该位置有装备
        --self.lidToTemplate[dicInfo.lid] = temp
        local canRefine = CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(dicInfo.itemId);
        if (self:GetMainChooseBagItemInfo() ~= nil) then
            if (CS.CSScene.MainPlayerInfo ~= nil) then
                local equipInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantEquip(self:GetMainChooseBagItemInfo().lid);
                if (equipInfo ~= nil) then
                    if (dicInfo.lid ~= self:GetMainChooseBagItemInfo().lid) then
                        canRefine = false;
                    else
                        local replaceItemId, count = CS.Cfg_ItemsFloatTableManager.Instance:GetRefineReplaceItem(self:GetMainChooseBagItemInfo().itemId);
                        if (dicInfo.itemId == self:GetMainChooseBagItemInfo().itemId) then
                            canRefine = true;
                        elseif (dicInfo.itemId == replaceItemId) then
                            canRefine = true;
                        else
                            canRefine = false;
                        end
                    end
                else
                    canRefine = dicInfo.itemId == self:GetMainChooseBagItemInfo().itemId;
                end
            else
                canRefine = CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(dicInfo.itemId)
            end
        end
        temp:RefreshEquip(dicInfo, canRefine and LuaEnumServantEquipShowColorType.Normal or LuaEnumServantEquipShowColorType.Gray);
        CS.UIEventListener.Get(grid).OnClickLuaDelegate = self.OnClickEquip
        local isChoose = (self:GetFirstChooseBagItemInfo() ~= nil and self:GetFirstChooseBagItemInfo().lid == dicInfo.lid) or (self:GetSecondChooseBagItemInfo() ~= nil and self:GetSecondChooseBagItemInfo().lid == dicInfo.lid);
        temp:SetItemChoose(isChoose)
    else
        --该位置没有装备
        temp:ResetEquip()
        temp:SetItemChoose(false)
    end
end

function UIServantPanel_Base_Refine:UpdateGrid()
    if (self.mCoroutineUpdateGrid ~= nil) then
        StopCoroutine(self.mCoroutineUpdateGrid);
        self.mCoroutineUpdateGrid = nil;
    end
    self.mCoroutineUpdateGrid = StartCoroutine(self.CDelayUpdateGrid, self);
end

function UIServantPanel_Base_Refine:CDelayUpdateGrid()
    coroutine.yield(0);
    for k, v in pairs(self.mGridToTemplate) do
        if (v.BagItemInfo ~= nil) then
            local canRefine = CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(v.BagItemInfo.itemId);
            if (self:GetMainChooseBagItemInfo() ~= nil) then
                if (CS.CSScene.MainPlayerInfo ~= nil) then
                    local equipInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantEquip(self:GetMainChooseBagItemInfo().lid);
                    if (equipInfo ~= nil) then
                        if (v.BagItemInfo.lid ~= self:GetMainChooseBagItemInfo().lid) then
                            canRefine = false;
                        else
                            local replaceItemId, count = CS.Cfg_ItemsFloatTableManager.Instance:GetRefineReplaceItem(self:GetMainChooseBagItemInfo().itemId);
                            if (v.BagItemInfo.itemId == self:GetMainChooseBagItemInfo().itemId) then
                                canRefine = true;
                            elseif (v.BagItemInfo.itemId == replaceItemId) then
                                canRefine = true;
                            else
                                canRefine = false;
                            end
                        end
                    else
                        canRefine = v.BagItemInfo.itemId == self:GetMainChooseBagItemInfo().itemId;
                    end
                else
                    canRefine = CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(v.BagItemInfo.itemId)
                end
            end

            v:RefreshEquip(v.BagItemInfo, canRefine and LuaEnumServantEquipShowColorType.Normal or LuaEnumServantEquipShowColorType.Gray);

            local firstBagItemInfo = self:GetFirstChooseBagItemInfo();
            local secondBagItemInfo = self:GetSecondChooseBagItemInfo();
            local isChoose = false;
            if (firstBagItemInfo ~= nil and firstBagItemInfo.lid == v.BagItemInfo.lid) then
                isChoose = true;
            elseif (secondBagItemInfo ~= nil and secondBagItemInfo.lid == v.BagItemInfo.lid) then
                isChoose = true;
            end
            v:SetItemChoose(isChoose)
        else
            v:SetItemChoose(false)
        end
    end
end

function UIServantPanel_Base_Refine:OnEnable()
    self:RunBaseFunction("OnEnable");
    self.CallOnClearFirstBagItem = function(msgId, msgData)
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

    if self.ServantPanel then
        self.ServantPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Refine_OnClearFirstBagItem, self.CallOnClearFirstBagItem)
        self.ServantPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Refine_OnClearSecondBagItem, self.CallOnClearSecondBagItem)
        self.ServantPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Refine_OnFirstBagItemChange, self.CallOnFirstBagItemChange)
        self.ServantPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Refine_OnSecondBagItemChange, self.CallOnSecondBagItemChange)
    end
end

function UIServantPanel_Base_Refine:OnDisable()
    self:RunBaseFunction("OnDisable")
    if self.ServantPanel then
        self.ServantPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Refine_OnClearFirstBagItem, self.CallOnClearFirstBagItem)
        self.ServantPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Refine_OnClearSecondBagItem, self.CallOnClearSecondBagItem)
        self.ServantPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Refine_OnFirstBagItemChange, self.CallOnFirstBagItemChange)
        self.ServantPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Refine_OnSecondBagItemChange, self.CallOnSecondBagItemChange)
    end

    if (self.mCoroutineUpdateGrid ~= nil) then
        StopCoroutine(self.mCoroutineUpdateGrid);
        self.mCoroutineUpdateGrid = nil;
    end
end

return UIServantPanel_Base_Refine;