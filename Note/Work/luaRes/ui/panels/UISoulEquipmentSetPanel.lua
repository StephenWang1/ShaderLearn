---@class UISoulEquipmentSetPanel:UIBase 魂装
local UISoulEquipmentSetPanel = {};

UISoulEquipmentSetPanel.mSuitBelong = LuaEnumSoulEquipType.HunZhuang

---@type table<UnityEngine.GameObject, UIItem>
UISoulEquipmentSetPanel.mUIItemDic = nil;

---@type bagV2.BagItemInfo
UISoulEquipmentSetPanel.mSelectEquip = nil;

---@type bagV2.BagItemInfo
UISoulEquipmentSetPanel.mSelectSoulEquip = nil;

function UISoulEquipmentSetPanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

function UISoulEquipmentSetPanel:GetBtnRemove_GameObject()
    if (self.mBtnRemove_GameObject == nil) then
        self.mBtnRemove_GameObject = self:GetCurComp("WidgetRoot/view/itemTemplate/soulEquipIcon/remove", "GameObject");
    end
    return self.mBtnRemove_GameObject;
end

function UISoulEquipmentSetPanel:GetBtnSet_GameObject()
    if (self.mBtnSet_GameObject == nil) then
        self.mBtnSet_GameObject = self:GetCurComp("WidgetRoot/view/btn_use", "GameObject")
    end
    return self.mBtnSet_GameObject;
end

function UISoulEquipmentSetPanel:GetBtnSuit_GameObject()
    if (self.mBtnSuit_GameObject == nil) then
        self.mBtnSuit_GameObject = self:GetCurComp("WidgetRoot/events/btn_suit", "GameObject");
    end
    return self.mBtnSuit_GameObject;
end

function UISoulEquipmentSetPanel:GetBtnHelp_GameObject()
    if (self.mBtnHelp_GameObject == nil) then
        self.mBtnHelp_GameObject = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject");
    end
    return self.mBtnHelp_GameObject;
end

function UISoulEquipmentSetPanel:GetNoEquipment_GameObject()
    if (self.mNoEquipment_GameObject == nil) then
        self.mNoEquipment_GameObject = self:GetCurComp("WidgetRoot/view/NoEquipment", "GameObject");
    end
    return self.mNoEquipment_GameObject;
end

function UISoulEquipmentSetPanel:GetSoulEquipName_Text()
    if (self.mSoulEquipName_Text == nil) then
        self.mSoulEquipName_Text = self:GetCurComp("WidgetRoot/view/itemTemplate/name", "UILabel")
    end
    return self.mSoulEquipName_Text;
end

function UISoulEquipmentSetPanel:GetNoSoulEquip_GameObject()
    if (self.mNoSoulEquip_GameObject == nil) then
        self.mNoEquipment_GameObject = self:GetCurComp("WidgetRoot/view/stoneList/NoElementtips", "GameObject")
    end
    return self.mNoEquipment_GameObject;
end

--function UISoulEquipmentSetPanel:GetSoulEquipAdd_GameObject()
--    if(self.mSelectSoulEquip_GameObject == nil) then
--        self.mSelectSoulEquip_GameObject = self:GetCurComp("WidgetRoot/view/AddBtnTemplate/add","GameObject");
--    end
--    return self.mSelectSoulEquip_GameObject;
--end

function UISoulEquipmentSetPanel:GetSoulEquipQuality_UISprite()
    if (self.mSoulEquipQuality_UISprite == nil) then
        self.mSoulEquipQuality_UISprite = self:GetCurComp("WidgetRoot/view/itemTemplate/soulEquipQuality", "UISprite");
    end
    return self.mSoulEquipQuality_UISprite;
end

function UISoulEquipmentSetPanel:GetItemIcon_UISprite()
    if (self.mItemIcon_UISprite == nil) then
        self.mItemIcon_UISprite = self:GetCurComp("WidgetRoot/view/itemTemplate/icon", "UISprite");
    end
    return self.mItemIcon_UISprite;
end

function UISoulEquipmentSetPanel:GetSoulEquipIcon_UISprite()
    if (self.mSoulEquipIcon_UISprite == nil) then
        self.mSoulEquipIcon_UISprite = self:GetCurComp("WidgetRoot/view/itemTemplate/soulEquipIcon", "UISprite");
    end
    return self.mSoulEquipIcon_UISprite;
end

--function UISoulEquipmentSetPanel:GetSelectSoulEquip_UISprite()
--    if(self.mSelectSoulEquip_UISprite == nil) then
--        self.mSelectSoulEquip_UISprite = self:GetCurComp("WidgetRoot/view/AddBtnTemplate/icon","UISprite");
--    end
--    return self.mSelectSoulEquip_UISprite;
--end

function UISoulEquipmentSetPanel:GetSoulEquipDes_Text()
    if (self.mSoulEquipDes_Text == nil) then
        self.mSoulEquipDes_Text = self:GetCurComp("WidgetRoot/view/soulEquipDes", "UILabel");
    end
    return self.mSoulEquipDes_Text;
end

function UISoulEquipmentSetPanel:GetGridContainer()
    if (self.mGridContainer == nil) then
        self.mGridContainer = self:GetCurComp("WidgetRoot/view/stoneList/stoneList/activityBtns", "UIGridContainer");
    end
    return self.mGridContainer;
end

---@return bagV2.BagItemInfo
function UISoulEquipmentSetPanel:GetSelectEquip()
    return self.mSelectEquip;
end

function UISoulEquipmentSetPanel:SetSelectEquip(equipInfo)
    self.mSelectEquip = equipInfo;
    luaEventManager.DoCallback(LuaCEvent.SoulEquip_OnSelectSoulEquip);
end

function UISoulEquipmentSetPanel:SetSelectSoulEquip(equipInfo, gobj)
    self.mSelectSoulEquip = equipInfo

    self:UpdateSelectSoulEquip();
    if (gobj ~= nil and not CS.StaticUtility.IsNull(gobj)) then
        if (self.mLastSelectUIItem ~= nil) then
            self.mLastSelectUIItem:SetAsUnselectedState();
        end
        self.mUIItemDic[gobj]:SetAsSelectedState();
        self.mLastSelectUIItem = self.mUIItemDic[gobj];
    end
end

---@public 更新UI显示
function UISoulEquipmentSetPanel:UpdateUI()
    self:GetNoEquipment_GameObject():SetActive(self.mSelectEquip == nil);
    self:GetBtnSet_GameObject():SetActive(self.mSelectEquip ~= nil);
    self:GetSoulEquipIcon_UISprite().spriteName = "";
    self:GetBtnRemove_GameObject():SetActive(false);
    self:GetItemIcon_UISprite().gameObject:SetActive(false);
    self:GetSoulEquipQuality_UISprite().gameObject:SetActive(false);
    if (self.mSelectEquip ~= nil) then
        ---@type TABLE.cfg_items
        local itemTable = clientTableManager.cfg_itemsManager:TryGetValue(self.mSelectEquip.itemId);
        if (itemTable ~= nil) then
            self:GetItemIcon_UISprite().gameObject:SetActive(true);
            self:GetItemIcon_UISprite().spriteName = itemTable:GetIcon();
        end
        local targetSoulEquip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSoulEquipToEquipIndex(self.mSelectEquip.index);
        if (targetSoulEquip ~= nil) then
            self:GetBtnRemove_GameObject():SetActive(true);
            ---@type TABLE.cfg_items
            local targetTbl = clientTableManager.cfg_itemsManager:TryGetValue(targetSoulEquip.itemId);
            self:GetSoulEquipIcon_UISprite().spriteName = targetTbl:GetIcon();
            self:GetBtnRemove_GameObject():SetActive(true);
            self:GetSoulEquipQuality_UISprite().gameObject:SetActive(true);
            self:GetSoulEquipQuality_UISprite().spriteName = "SoulEquip_" .. targetTbl:GetGroup();
        end
    end
    self:UpdateMaterialSoulEquip();
end

function UISoulEquipmentSetPanel:UpdateSelectSoulEquip()
    --self:GetSelectSoulEquip_UISprite().gameObject:SetActive(false);
    --self:GetSoulEquipAdd_GameObject():SetActive(true);
    self:GetSoulEquipDes_Text().text = "";
    self:GetSoulEquipName_Text().text = "";
    self:GetSoulEquipName_Text().gameObject:SetActive(true);
    if (self.mSelectSoulEquip ~= nil) then
        ---@type TABLE.cfg_items
        local tbl = clientTableManager.cfg_itemsManager:TryGetValue(self.mSelectSoulEquip.itemId);
        if (tbl ~= nil) then
            --self:GetSelectSoulEquip_UISprite().spriteName = tbl:GetIcon();
            --self:GetSelectSoulEquip_UISprite().gameObject:SetActive(true);
            --self:GetSoulEquipAdd_GameObject():SetActive(false);
            self:GetSoulEquipName_Text().text = tbl:GetName();
            ---@type TABLE.cfg_signet
            local height, lower = CS.Utility_Lua.DecodeHD(self.mSelectSoulEquip.soulEffect, 32, 0xffffffff);
            if (lower ~= 0) then
                local signetTable = clientTableManager.cfg_signetManager:TryGetValue(lower)
                if (signetTable ~= nil) then
                    if (signetTable:GetParameter() ~= nil and signetTable:GetParameter().list.Count > 0) then
                        local value = signetTable:GetParameter().list[0];
                        self:GetSoulEquipDes_Text().text = tbl:GetName() .. "\n" .. luaEnumColorType.Purple .. string.CSFormat(signetTable:GetDescription(), value) .. "[-]";
                    end
                end
            end
        end
    else
        if (self.mSelectEquip ~= nil) then
            local setSoulEquip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSoulEquipToEquipIndex(self.mSelectEquip.index);
            if (setSoulEquip ~= nil) then
                ---@type TABLE.cfg_items
                local tbl = clientTableManager.cfg_itemsManager:TryGetValue(setSoulEquip.itemId);
                if (tbl ~= nil) then
                    local signetTable = clientTableManager.cfg_signetManager:TryGetValue(setSoulEquip.soulEffect)
                    if (signetTable ~= nil) then
                        if (signetTable:GetParameter() ~= nil and signetTable:GetParameter().list.Count > 0) then
                            local value = signetTable:GetParameter().list[0];
                            self:GetSoulEquipDes_Text().text = tbl:GetName() .. "\n" .. luaEnumColorType.Purple .. string.CSFormat(signetTable:GetDescription(), value) .. "[-]";
                        end
                    end
                end
            end
        end
    end
end

---@public 更新当做材料显示的魂装列表
function UISoulEquipmentSetPanel:UpdateMaterialSoulEquip()
    if (self.mUIItemDic == nil) then
        self.mUIItemDic = {};
    end

    local defaultSoulEquip = self.mSelectSoulEquip;
    local defaultGobj = nil;

    local gridContainer = self:GetGridContainer();
    if (self.mSelectEquip ~= nil) then
        local soulEquipList = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetEquipCanSetSoulEquipList(self.mSelectEquip.itemId);
        if (soulEquipList ~= nil) then
            gridContainer.MaxCount = #soulEquipList;
            local index = 0;
            ---@param v bagV2.BagItemInfo
            for k, v in pairs(soulEquipList) do
                local gobj = gridContainer.controlList[index];
                if (self.mUIItemDic[gobj] == nil) then
                    self.mUIItemDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                end
                ---@type TABLE.cfg_items
                local itemTable = clientTableManager.cfg_itemsManager:TryGetValue(v.itemId);
                if (itemTable ~= nil) then
                    self.mUIItemDic[gobj]:RefreshUIWithItemInfo(itemTable:CsTABLE());
                    self.mUIItemDic[gobj]:SetAsUnselectedState();
                end
                CS.UIEventListener.Get(gobj).onClick = function()
                    self:SetSelectSoulEquip(v, gobj);
                end

                if (defaultSoulEquip == nil) then
                    defaultSoulEquip = v;
                    defaultGobj = gobj;
                elseif(v.lid == defaultSoulEquip.lid) then
                    defaultGobj = gobj;
                end

                index = index + 1;
            end
        end
    else
        gridContainer.MaxCount = 0;
    end
    self:SetSelectSoulEquip(defaultSoulEquip, defaultGobj);
    local setSoulEquip = nil;
    if (self.mSelectEquip ~= nil) then
        setSoulEquip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSoulEquipToEquipIndex(self.mSelectEquip.index);
    end
    self:GetNoSoulEquip_GameObject():SetActive(not (gridContainer.MaxCount > 0 or setSoulEquip ~= nil));
end

---@public 更新左侧面板
function UISoulEquipmentSetPanel:UpdateLeftPanel()
    uimanager:CreatePanel("UIRolePanel", function(panel)
        if (not CS.StaticUtility.IsNull(self.go)) then
            panel:ShowCloseButton(false);
            panel:SetSLToggle(false)
            if (self:GetSelectEquip() ~= nil) then
                panel:SetItemChoose(self:GetSelectEquip());
            end
        end
    end, { equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateSoulEquipSet, equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateSoulEquipSet });
end

---@private 初始化事件
function UISoulEquipmentSetPanel:InitEvents()

    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UISoulEquipmentSetPanel");
        uimanager:ClosePanel("UIRolePanel");
    end

    CS.UIEventListener.Get(self:GetBtnRemove_GameObject()).onClick = function()
        if (self.mSelectEquip ~= nil) then
            networkRequest.ReqPutOffSoulEquip(self.mSelectEquip.index, self.mSuitBelong);
        end
    end

    CS.UIEventListener.Get(self:GetBtnSet_GameObject()).onClick = function()
        if (self.mSelectEquip ~= nil and self.mSelectSoulEquip ~= nil) then
            networkRequest.ReqPutOnSoulEquip(self.mSelectEquip.index, self.mSelectSoulEquip.lid, self.mSuitBelong);
            luaEventManager.DoCallback(LuaCEvent.Effect_PlayEffect, { effectId = "700008", scale = 100, wordPosition = self:GetItemIcon_UISprite().gameObject.transform.position });
        end
        self:SetSelectSoulEquip(nil, nil);
    end

    CS.UIEventListener.Get(self:GetItemIcon_UISprite().gameObject).onClick = function()
        self:SetSelectSoulEquip(nil, nil);
        self:SetSelectEquip(nil)
        self:UpdateUI();

    end

    CS.UIEventListener.Get(self:GetBtnSuit_GameObject()).onClick = function()
        uimanager:CreatePanel("UISuitAttributeSoulEquipPanel");
    end;

    CS.UIEventListener.Get(self:GetBtnHelp_GameObject()).onClick = function()
        local helpId = 187;
        local isFind, desTable = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(helpId)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, desTable)
        end
    end;

    ---@param template UIRolePanel_GridTemplateBase
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_EquipGridClicked, function(msgId, template)
        self:SetSelectEquip(template.bagItemInfo)
        self:SetSelectSoulEquip(nil);
        self:UpdateUI();
    end)

    self.CallResAllSoulEquipInfoMessage = function(msgId, msgData)
        self:UpdateUI();
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAllSoulEquipInfoMessage, self.CallResAllSoulEquipInfoMessage);
end

function UISoulEquipmentSetPanel:Init()
    self:InitEvents();
end

function UISoulEquipmentSetPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    if (customData.equipInfo ~= nil) then
        local tbl = clientTableManager.cfg_itemsManager:TryGetValue(customData.equipInfo.itemId);
        if(tbl ~= nil) then
            local equipIndexes = Utility.GetEquipIndexesByLuaItemTbl(tbl);
            for k,v in pairs(equipIndexes) do
                local bodyEquip = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipInfoByEquipIndex(v);
                if(bodyEquip ~= nil) then
                    self.mSelectEquip = bodyEquip;
                    break;
                end
            end
            self.mSelectSoulEquip = customData.equipInfo;
        end
    else
        self.mSelectEquip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetDefaultCanSetSoulEquip();
    end

    self:UpdateUI();
    self:UpdateLeftPanel();
end

function ondestroy()
    uimanager:ClosePanel("UIRolePanel");
end

return UISoulEquipmentSetPanel;