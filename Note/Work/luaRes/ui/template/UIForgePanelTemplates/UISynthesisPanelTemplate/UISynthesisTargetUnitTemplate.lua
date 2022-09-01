---@class UISynthesisTargetUnitTemplate
local UISynthesisTargetUnitTemplate = {};

UISynthesisTargetUnitTemplate.mItemId = 0;

---@type TABLE.cfg_synthesis
UISynthesisTargetUnitTemplate.mSynthesisTable = nil;
---合成次数
UISynthesisTargetUnitTemplate.mCount = 1;
--region Components

function UISynthesisTargetUnitTemplate:GetUIItem()
    if (self.mUIItem == nil) then
        local gobj = self:Get("UIItem", "GameObject");
        self.mUIItem = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
    end
    return self.mUIItem;
end

function UISynthesisTargetUnitTemplate:GetGood_UISprite()
    if CS.StaticUtility.IsNull(self.mGetGood_UISprite) then
        self.mGetGood_UISprite = self:Get("UIItem/good", "UISprite")
    end
    return self.mGetGood_UISprite
end

function UISynthesisTargetUnitTemplate:GetSynthesisTable()
    return self.mSynthesisTable;
end

function UISynthesisTargetUnitTemplate:GetMinSynthesisCount()
    return 1;
end

function UISynthesisTargetUnitTemplate:GetSynthesisCount()
    if (self.mCount == nil) then
        self.mCount = 1;
    end
    return self.mCount;
end

--endregion

--region Method

--region Public

function UISynthesisTargetUnitTemplate:UpdateUnit(synthesisTable)
    self.mSynthesisTable = synthesisTable;
    self:UpdateSynthesisCount(1);
end

function UISynthesisTargetUnitTemplate:UpdateSynthesisCount(count)
    self.mCount = count;
    self:UpdateUI();
end

function UISynthesisTargetUnitTemplate:UpdateUI()
    if (self.mSynthesisTable ~= nil) then
        if (self.mSynthesisTable:GetOutputgoods() ~= nil and self.mSynthesisTable:GetOutputgoods().list ~= nil and #self.mSynthesisTable:GetOutputgoods().list > 0) then
            self.mItemId = self.mSynthesisTable:GetOutputgoods().list[1];
            local num = 1;

            if (self.mSynthesisTable.synthesisType == LuaEnumSynthesisType.Random) then
                self:GetUIItem():ResetUI();
                self:GetUIItem():GetItemCount_UILabel().text = tostring(num * self:GetSynthesisCount());
            else
                local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mItemId);
                if (isFind) then
                    self:GetUIItem():RefreshUIWithItemInfo(itemTable, 1);
                end
            end
            if (num <= 1) then
                self:GetUIItem():GetItemCount_UILabel().text = "";
            else
                self:GetUIItem():GetItemCount_UILabel().text = tostring(num * self:GetSynthesisCount());
            end
            self:RefreshGoodIcon()
        end
    end
end

function UISynthesisTargetUnitTemplate:RefreshGoodIcon()
    if CS.StaticUtility.IsNull(self:GetGood_UISprite()) == false then
        local arrowSpriteName = ""
        local fakeBagItemInfo = nil

        local itemTable = clientTableManager.cfg_itemsManager:TryGetValue(self.mItemId);
        if (itemTable ~= nil) then
            if (itemTable:GetType() == luaEnumItemType.Equip or (itemTable:GetType() == luaEnumItemType.Assist and itemTable:GetSubType() == 8)) then
                local bagItemInfo = CS.Cfg_ItemsFakeTipsTableManager.Instance:GetFakeBagItemInfoByItemId(self.mItemId);
                if (bagItemInfo ~= nil) then
                    local arrowType = Utility.GetArrowType(bagItemInfo, false);

                    if arrowType == LuaEnumArrowType.GreenArrow then
                        arrowSpriteName = "arrow2"
                    elseif arrowType == LuaEnumArrowType.YellowArrow then
                        arrowSpriteName = "arrow3"
                    end
                end
            end
        end

        self:GetGood_UISprite().spriteName = arrowSpriteName
    end
end

function UISynthesisTargetUnitTemplate:ShowItemInfo(isShowRight)
    if (self.mSynthesisTable ~= nil) then
        if (self.mSynthesisTable.synthesisType == LuaEnumSynthesisType.Random) then
            return ;
        end
    end

    if (self.mItemId ~= nil) then
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mItemId);
        if (isFind) then
            local backgroundPos = nil
            if (itemTable.type == luaEnumItemType.SkillBook and itemTable.subType == 3) then
                backgroundPos = CS.UnityEngine.Vector3(-128, 0, 0)
            end
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable, showRight = isShowRight, backgroundPos = backgroundPos });
            uiStaticParameter.UIItemInfoManager:TryCreateSkillVideoPanel();
        end
    end
end

function UISynthesisTargetUnitTemplate:GetTargetName()
    if (self.mItemId ~= nil) then
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mItemId);
        if (isFind) then
            return itemTable.name;
        end
    end
end

function UISynthesisTargetUnitTemplate:OnSelect()
    if (self.mSynthesisTable ~= nil) then
        luaEventManager.DoCallback(LuaCEvent.Synthesis_OnSelectSynthesisTarget, self);
    end
end

--endregion

--region Private

function UISynthesisTargetUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetUIItem().go).onClick = function()
        self:OnSelect();
    end
end

--endregion

--endregion

function UISynthesisTargetUnitTemplate:Init()
    self:InitEvents();
end

return UISynthesisTargetUnitTemplate;