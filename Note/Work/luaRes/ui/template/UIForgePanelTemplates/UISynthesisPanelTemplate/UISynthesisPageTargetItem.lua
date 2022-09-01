---@class UISynthesisPageTargetItem:UISynthesisPageTargetItem
local UISynthesisPageTargetItem = {};

---@type LuaSynthesis_ListItem
UISynthesisPageTargetItem.Synthesis_ListItem = nil

UISynthesisPageTargetItem.mItemTable = nil;

UISynthesisPageTargetItem.mRedPointKey = nil;

UISynthesisPageTargetItem.ChooseState = nil;

--region Components

function UISynthesisPageTargetItem:GetTgl_UIToggle()
    if (self.mTgl_UIToggle == nil) then
        self.mTgl_UIToggle = self:Get("", "UIToggle");
    end
    return self.mTgl_UIToggle;
end

function UISynthesisPageTargetItem:GetBtnLabel1_Text()
    if (self.mBtnLabel1_Text == nil) then
        self.mBtnLabel1_Text = self:Get("Label", "UILabel");
    end
    return self.mBtnLabel1_Text;
end

function UISynthesisPageTargetItem:GetBtnLabel2_Text()
    if (self.mBtnLabel2_Text == nil) then
        self.mBtnLabel2_Text = self:Get("checkMark/Label", "UILabel");
    end
    return self.mBtnLabel2_Text;
end

function UISynthesisPageTargetItem:GetRedPointComponent()
    if (self.mRedPointComponent == nil) then
        self.mRedPointComponent = self:Get("redPoint", "UIRedPoint");
    end
    return self.mRedPointComponent;
end

---获取合成物品列表面板
---@return UISynthesisItemListPanel
function UISynthesisPageTargetItem:GetSynthesisItemListPanel()
    if self.synthesisItemListPanel == nil then
        self.synthesisItemListPanel = uimanager:GetPanel("UISynthesisItemListPanel")
    end
    return self.synthesisItemListPanel
end
--endregion

--region Method

function UISynthesisPageTargetItem:Init()
    CS.UIEventListener.Get(self:GetTgl_UIToggle().gameObject).onClick = function()
        self:OnSelfClick();
    end
end

--region Private

function UISynthesisPageTargetItem:OnSelfClick()
    --if (not gameMgr:GetPlayerDataMgr():GetSynthesisMgr():IsExitInShieldSynthesisRedList(self.mItemTable.id)) then
    --    gameMgr:GetPlayerDataMgr():GetSynthesisMgr():AddToShieldSynthesisRedList(self.mItemTable.id)
    --end
    if (self.synthesisTables ~= nil) then
        luaEventManager.DoCallback(LuaCEvent.Synthesis_OnSynthesisListTargetClick, self.synthesisTables);
    end

    self:SwitchTglState(true);
    luaEventManager.DoCallback(LuaCEvent.Synthesis_CallOnSynthesisItemOnClick, { unit = self, type = self.Synthesis_ListItem.SubType })
end

--endregion

--region Public

---@param pageLayer number, 1:第一级按钮, 2:第二级按钮, 3:第三级按钮
---@param customData LuaSynthesis_ListItem
function UISynthesisPageTargetItem:UpdateUnit(customData)
    self.Synthesis_ListItem = customData
    ---@type TABLE.cfg_items
    self.mItemTable = customData:GetItemTable();
    ---@type table<TABLE.cfg_synthesis>
    self.synthesisTables = customData:GetSynthesisTables();

    if (#self.synthesisTables > 0) then
        ---@type TABLE.cfg_synthesis
        self.synthesisTable = self.synthesisTables[1];
    end

    self.mRedPointKey = customData.RedKey
    self:UpdateUI();
    self:UpdateRedPoint();
end

function UISynthesisPageTargetItem:UpdateUI()
    if (self.mItemTable ~= nil) then
        local isShowLevel = false;
        if (self.mItemTable.type == luaEnumItemType.Equip and self.mItemTable.subType < 81) then
            isShowLevel = true;
        end
        local itemName = ''
        local levelString = "";
        if self.synthesisTable ~= nil and self.synthesisTable:GetReplaceName() ~= '' then
            itemName = self.synthesisTable:GetReplaceName();
        else
            itemName = CS.Cfg_ItemsTableManager.Instance:GetItemName(self.mItemTable.id);
        end
        self:GetBtnLabel1_Text().text = itemName .. levelString;
        self:GetBtnLabel2_Text().text = itemName .. levelString;
    end
end

function UISynthesisPageTargetItem:SwitchTglState(value)
    self.ChooseState = value
    if self.ChooseState == true and self:GetSynthesisItemListPanel() ~= nil and self.mItemTable ~= nil then
        self:GetSynthesisItemListPanel().NowChooseTargetSynthesisItemID = self.mItemTable.id
    end
    luaclass.UIRefresh:RefreshActive(self:GetBtnLabel1_Text(), not value)
    self:GetTgl_UIToggle().activeSprite.alpha = value and 1 or 0;
end
--endregion

--region Private

function UISynthesisPageTargetItem:UpdateRedPoint()
    if (self:GetRedPointComponent() ~= nil) then
        self:GetRedPointComponent():RemoveRedPointKey();
    end

    if (self.mRedPointKey ~= nil and self:GetRedPointComponent() ~= nil) then
        self:GetRedPointComponent():AddRedPointKey(self.mRedPointKey);
    end
end

--endregion

--endregion

return UISynthesisPageTargetItem;