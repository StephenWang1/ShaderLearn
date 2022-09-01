---@class UISynthesisSubCategoryPage:UISynthesisPageButtonUnit 合成清单的具体个体
local UISynthesisSubCategoryPage = {};

UISynthesisSubCategoryPage.mItemTables = nil;

UISynthesisSubCategoryPage.mPageTargetItemUnitDic = nil;

UISynthesisSubCategoryPage.IsOpen = nil;

UISynthesisSubCategoryPage.mSelectItemId = nil;

UISynthesisSubCategoryPage.LuaSynthesis_SubCategory = nil
---@type UISynthesisPageTargetItem
UISynthesisSubCategoryPage.NowSelectSynthesisTarget = nil;

--region Components

function UISynthesisSubCategoryPage:GetTgl_UIToggle()
    if (self.mTgl_UIToggle == nil) then
        self.mTgl_UIToggle = self:Get("backgroud", "UIToggle");
    end
    return self.mTgl_UIToggle;
end

function UISynthesisSubCategoryPage:GetBtnLabel1_Text()
    if (self.mBtnLabel1_Text == nil) then
        self.mBtnLabel1_Text = self:Get("backgroud/backgroud/Label", "UILabel");
    end
    return self.mBtnLabel1_Text;
end

function UISynthesisSubCategoryPage:GetBtnLabel2_Text()
    if (self.mBtnLabel2_Text == nil) then
        self.mBtnLabel2_Text = self:Get("backgroud/checkMark/Label", "UILabel");
    end
    return self.mBtnLabel2_Text;
end

function UISynthesisSubCategoryPage:GetDropGridContainer()
    if (self.mDropGridContainer == nil) then
        self.mDropGridContainer = self:Get("ScrollView/SecondLayer", "UIGridContainer");
    end
    return self.mDropGridContainer;
end

function UISynthesisSubCategoryPage:GetRedPointComponent()
    if (self.mRedPointComponent == nil) then
        self.mRedPointComponent = self:Get("redPoint", "UIRedPoint");
    end
    return self.mRedPointComponent;
end

---获取合成物品列表面板
---@return UISynthesisItemListPanel
function UISynthesisSubCategoryPage:GetSynthesisItemListPanel()
    if self.synthesisItemListPanel == nil then
        self.synthesisItemListPanel = uimanager:GetPanel("UISynthesisItemListPanel")
    end
    return self.synthesisItemListPanel
end
--endregion

--region Method

function UISynthesisSubCategoryPage:Init()
    if self.IsOpen == nil then
        self.IsOpen = false
    end
    CS.UIEventListener.Get(self:GetTgl_UIToggle().gameObject).onClick = function()
        self:OnSelfClick();
    end
end

--region CallFunction

---@public
function UISynthesisSubCategoryPage:OnSelfClick()
    self.IsOpen = not self.IsOpen;
    self:UpdatePageItemButtonUnit();
    self:SwitchTglState(self.IsOpen);
    self:GetSynthesisItemListPanel().NowChooseTargetSynthesisSubType = self.mBtnType
    luaEventManager.DoCallback(LuaCEvent.Synthesis_CallOnSynthesisSubCategoryOnClick, { unit = self, type = self.mBtnType, maxSecondaryTabsCount = self:GetDropGridContainer().MaxCount })
end

--endregion

function UISynthesisSubCategoryPage:SwitchTglState(value)
    self:GetTgl_UIToggle().activeSprite.alpha = value and 1 or 0;
    if (self.IsOpen == value) then
        return
    end
    if (value == true) then
        self:OpenThirdPageButton();
    else
        self:CloseThirdPageButton()
    end
end

---@param customData LuaSynthesis_SubCategory  第二級按钮数据
---@param refreshType LuaEnumSynthesisItemListType
function UISynthesisSubCategoryPage:UpdateUnit(customData, open, selectItemId, refreshType)
    if (customData ~= nil) then
        self.mBtnName = customData.Name;
        self.mOwnerType = customData.Type;
        self.mBtnType = customData.SubType;
    end
    self.refreshType = refreshType
    self.LuaSynthesis_SubCategory = customData
    self:UpdateUI();
    self:UpdateRedPoint();
    self.IsOpen = open;
    self:SwitchTglState(open)
    self.mSelectItemId = selectItemId;
    self.NowSelectSynthesisTarget = nil;
    self:UpdatePageItemButtonUnit();
end

function UISynthesisSubCategoryPage:UpdateUI()
    if (self.LuaSynthesis_SubCategory ~= nil) then
        self:GetBtnLabel1_Text().text = self.LuaSynthesis_SubCategory.Name;
        self:GetBtnLabel2_Text().text = self.LuaSynthesis_SubCategory.Name;
    end
end

function UISynthesisSubCategoryPage:UpdateRedPoint()
    if (self:GetRedPointComponent() ~= nil) then
        self:GetRedPointComponent():RemoveRedPointKey();
    end
    local key = self.LuaSynthesis_SubCategory.RedKey

    if (key ~= nil) then
        if (self:GetRedPointComponent() ~= nil) then
            self:GetRedPointComponent():AddRedPointKey(key);
        end
    end
end

function UISynthesisSubCategoryPage:UpdatePageItemButtonUnit()
    local gridContainer = self:GetDropGridContainer();
    if (self.IsOpen == false or self.LuaSynthesis_SubCategory == nil) then
        gridContainer.MaxCount = 0;
    else
        if (self.mPageTargetItemUnitDic == nil) then
            self.mPageTargetItemUnitDic = {};
        end

        ---@type table<LuaSynthesis_ListItem>
        self.mItemTables = self.LuaSynthesis_SubCategory:GetSynthesisPageButtonItemList()

        local maxCount = Utility.GetTableCount(self.mItemTables)
        gridContainer.MaxCount = maxCount;
        local index = 0;
        for k, v in pairs(self.mItemTables) do
            local gobj = gridContainer.controlList[index];
            if (self.mPageTargetItemUnitDic[gobj] == nil) then
                self.mPageTargetItemUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UISynthesisPageTargetItem, self);
            end

            -----@type UISynthesisPageTargetItem
            local temp = self.mPageTargetItemUnitDic[gobj]
            ---@type LuaSynthesis_ListItem
            local listItem = v;
            temp:UpdateUnit(listItem);
            if (self.mSelectItemId ~= nil) then
                local itemTable = listItem:GetItemTable();
                if (itemTable ~= nil) then
                    temp:SwitchTglState(itemTable.id == self.mSelectItemId);
                    if (itemTable.id == self.mSelectItemId) then
                        self.NowSelectSynthesisTarget = temp
                        temp:OnSelfClick();
                    end
                end
            else
                temp:SwitchTglState(false);
            end
            index = index + 1;
        end
    end
end

function UISynthesisSubCategoryPage:OpenThirdPageButton()
    self.IsOpen = true;
    self:UpdatePageItemButtonUnit();
end

function UISynthesisSubCategoryPage:CloseThirdPageButton()
    self.IsOpen = false;
    self:UpdatePageItemButtonUnit();
end

--endregion


return UISynthesisSubCategoryPage;