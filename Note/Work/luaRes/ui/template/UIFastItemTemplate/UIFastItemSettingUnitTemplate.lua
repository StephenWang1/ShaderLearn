local UIFastItemSettingUnitTemplate = {};

UIFastItemSettingUnitTemplate.mIndex = 0;

UIFastItemSettingUnitTemplate.mPopupListValue = {};

UIFastItemSettingUnitTemplate.mEConfigOptionKey = nil;

--region Components

--region GameObject
function UIFastItemSettingUnitTemplate:GetUIItem_GameObject()
    if(self.mUIItem_GameObject == nil) then
        self.mUIItem_GameObject = self:Get("UIItem", "GameObject");
    end
    return self.mUIItem_GameObject;
end

function UIFastItemSettingUnitTemplate:GetBtnBg_GameObject()
    if(self.mBtnAdd_GameObject == nil) then
        self.mBtnAdd_GameObject = self:Get("UIItem/bg", "GameObject");
    end
    return self.mBtnAdd_GameObject;
end

function UIFastItemSettingUnitTemplate:GetItemName_GameObject()
    if(self.mItemName_GameObject == nil) then
        self.mItemName_GameObject = self:Get("UIItem/name", "GameObject");
    end
    return self.mItemName_GameObject;
end

function UIFastItemSettingUnitTemplate:GetAdd_GameObject()
    if(self.mAdd_GameObject == nil) then
        self.mAdd_GameObject = self:Get("UIItem/add", "GameObject");
    end
    return self.mAdd_GameObject;
end
--endregion

function UIFastItemSettingUnitTemplate:GetItemSettingList_UIPopupList()
    if(self.mFastSettingList == nil)  then
        self.mFastSettingList = self:Get("program/Btn_program", "UIPopupList");
    end
    return self.mFastSettingList;
end

function UIFastItemSettingUnitTemplate:GetUIItem()
    if(self.mUIItem == nil) then
        self.mUIItem = templatemanager.GetNewTemplate(self:GetUIItem_GameObject(), luaComponentTemplates.UIItem);
    end
    return self.mUIItem;
end

--endregion

--region Method
--region CallFunction

function UIFastItemSettingUnitTemplate:OnPopupListValueChanged()
    local itemId = self.mPopupListValue[self:GetItemSettingList_UIPopupList().value];
    local isGetValue, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
    if(isGetValue) then
        self:GetUIItem():RefreshUIWithItemInfo(itemTable, 1);
        self:IsShowAdd(false);
        if(self.mEConfigOptionKey ~= nil) then
          --  CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(self.mEConfigOptionKey, itemId);
        end
    end
end

function UIFastItemSettingUnitTemplate:OnClickBtnBg()
    self:GetItemSettingList_UIPopupList():Show();
end

function UIFastItemSettingUnitTemplate:OnClickBtnSelfGrid()

end
--endregion

function UIFastItemSettingUnitTemplate:ShowUnit(index)
    self.mIndex = index;
    if(self.mIndex == 0) then
        self.mEConfigOptionKey = CS.EConfigOption.ShortcutItem1;
    elseif(self.mIndex == 1) then
        self.mEConfigOptionKey = CS.EConfigOption.ShortcutItem2;
    elseif(self.mIndex == 2) then
        self.mEConfigOptionKey = CS.EConfigOption.ShortcutItem3;
    end

    local defaultItemId = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(self.mEConfigOptionKey);
    self.mPopupListValue = {};
    self:GetItemSettingList_UIPopupList().items:Clear();
    local isGetValue, value = CS.Cfg_GlobalTableManagerBase.Instance:TryGetValue(20182)
    if(isGetValue) then
        local params = string.Split(value.value, "#");
        for k,v in pairs(params) do
            local itemId = tonumber(v);
            local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
            if(isFind) then
                if(not self:GetItemSettingList_UIPopupList().items:Contains(itemTable.name))then
                    self:GetItemSettingList_UIPopupList().items:Add(itemTable.name);
                    self.mPopupListValue[itemTable.name] = itemId;
                end

                if(itemId == defaultItemId) then
                    self:GetItemSettingList_UIPopupList().value = itemTable.name;
                end
            end
        end

    end
end

function UIFastItemSettingUnitTemplate:IsShowAdd(isShow)
    self:GetAdd_GameObject():SetActive(isShow);
    self:GetItemName_GameObject():SetActive(isShow);
end

function UIFastItemSettingUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnBg_GameObject()).onClick = function()
        self:OnClickBtnBg();
    end

    CS.EventDelegate.Add(self:GetItemSettingList_UIPopupList().onChange, function()
        self:OnPopupListValueChanged();
    end);
end

function UIFastItemSettingUnitTemplate:RemoveEvents()

end
--endregion

function UIFastItemSettingUnitTemplate:Init()
    self:InitEvents();
end

function UIFastItemSettingUnitTemplate:Show()

end

return UIFastItemSettingUnitTemplate;