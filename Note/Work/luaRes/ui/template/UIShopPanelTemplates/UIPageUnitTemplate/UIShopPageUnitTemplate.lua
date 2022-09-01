---@class UIShopPageUnitTemplate
local UIShopPageUnitTemplate = {};

setmetatable(UIShopPageUnitTemplate, luaComponentTemplates.UIPageUnitTemplate)

UIShopPageUnitTemplate.mShopUnitDic = nil;

UIShopPageUnitTemplate.mChooseStore = nil;

--region Component

function UIShopPageUnitTemplate:GetUnitGridContainer()
    if (self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = CS.Utility_Lua.GetComponent(self.go, "UIGridContainer");
    end
    return self.mUnitGridContainer;
end

--endregion

--region Method

--region CallFunction
function UIShopPageUnitTemplate:OnResSendStoreInfoChangeMessage(id, tableData)
    local storeId = tableData.storeInfo.storeId;
    if (self.mShopUnitDic ~= nil) then
        for k, v in pairs(self.mShopUnitDic) do
            if (v:GetStoreId() == storeId) then
                local storeUnitVo = CS.CSScene.MainPlayerInfo.StoreInfoV2:GetStoreInfo(storeId);
                v:SetViewUnit(storeUnitVo);
                break ;
            end
        end
    end
end
--endregion

--region Public

function UIShopPageUnitTemplate:SetChooseStore(chooseStore)
    local firstChooseGameObject;
    if (chooseStore ~= nil) then
        self.mChooseStore = chooseStore;
        for k, v in pairs(self.mShopUnitDic) do
            local isChoose = false
            for k_1, v_1 in pairs(self.mChooseStore) do
                if (v.mShopData.storeId == v_1) then
                    isChoose = true;
                    chooseStore[k] = nil;
                    break ;
                end
            end
            v:SetChoose(isChoose);
            if (isChoose and firstChooseGameObject == nil) then
                firstChooseGameObject = v.go;
            end
        end
    end
    return firstChooseGameObject;
end

function UIShopPageUnitTemplate:UnChooseStore(unChooseStores)
    if (unChooseStores ~= nil) then
        for k, v in pairs(self.mShopUnitDic) do
            local isChoose = false;
            for k_1, v_1 in pairs(unChooseStores) do
                if (v.mShopData.storeId == v_1) then
                    isChoose = true;
                    unChooseStores[k] = nil;
                    v:SetChoose(not isChoose);
                    break ;
                end
            end
        end
    end
end

--endregion

--region Private

function UIShopPageUnitTemplate:GetShopUnitTemplate()
    return luaComponentTemplates.UIShopUnitTemplate;
end

function UIShopPageUnitTemplate:InitEvents()

    self.CallFuncResSendStoreInfoChangeMessage = function(id, tableData)
        self:OnResSendStoreInfoChangeMessage(id, tableData);
    end

    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSendStoreInfoChangeMessage, self.CallFuncResSendStoreInfoChangeMessage)

    self.CallOnTaskUnShopSelect = function(msgId, msgData)
        self:UnChooseStore(msgData);
    end

    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Task_UnShopSelect, self.CallOnTaskUnShopSelect)
end

function UIShopPageUnitTemplate:RemoveEvents()
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResSendStoreInfoChangeMessage, self.CallFuncResSendStoreInfoChangeMessage);
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Task_UnShopSelect, self.CallOnTaskUnShopSelect);
end

--endregion

--region Override

function UIShopPageUnitTemplate:UpdateUnit(shopDataList)
    if (shopDataList == nil) then
        local gridContainer = self:GetUnitGridContainer();
        if (gridContainer ~= nil) then
            gridContainer.MaxCount = 0
        end
        return ;
    end

    if (self.mShopUnitDic == nil) then
        self.mShopUnitDic = {};
    end

    local sortFunc = function(a, b)
        local isFind1, itemTable1 = CS.Cfg_StoreTableManager.Instance:TryGetValue(a.storeId)
        local isFind2, itemTable2 = CS.Cfg_StoreTableManager.Instance:TryGetValue(b.storeId)
        if (isFind1 and isFind2) then
            return itemTable1.index < itemTable2.index;
        end
        return false;
    end
    table.sort(shopDataList, sortFunc);

    local gridContainer = self:GetUnitGridContainer();
    gridContainer.MaxCount = #shopDataList;
    local index = 0;
    for k, v in pairs(shopDataList) do
        local gobj = gridContainer.controlList[index];
        if (self.mShopUnitDic[gobj] == nil) then
            self.mShopUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, self:GetShopUnitTemplate(), self.mOwnerPanel);
        end

        self.mShopUnitDic[gobj]:SetViewUnit(v);
        index = index + 1;
    end
end

--endregion

--endregion

function UIShopPageUnitTemplate:Start()
    self:InitEvents();
end

function UIShopPageUnitTemplate:OnEnable()
    --self:InitEvents();
end

function UIShopPageUnitTemplate:OnDisable()
    --self:RemoveEvents();
end

function UIShopPageUnitTemplate:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel
    --self:InitEvents()
end

function UIShopPageUnitTemplate:OnDestroy()
    self:RemoveEvents();
end

return UIShopPageUnitTemplate;