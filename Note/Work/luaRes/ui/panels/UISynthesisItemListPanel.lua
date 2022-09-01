---@class UISynthesisItemListPanel:UIBase
local UISynthesisItemListPanel = {};

---@type number 展开主页签类型
UISynthesisItemListPanel.TargetSynthesisMainType = nil;

---@type number 展开分类页签类型
UISynthesisItemListPanel.TargetSynthesisSubType = nil;

---@type number 展开分类页签下属的合成目标的时候,默认选择的合成目标
UISynthesisItemListPanel.TargetSynthesisItemID = nil;

UISynthesisItemListPanel.mFirstPageButtonUnitDic = nil;

UISynthesisItemListPanel.mSecondPageButtonUnitDic = nil;

---@type UISynthesisMainCategoryPage
UISynthesisItemListPanel.NowSelectMainCategoryPage = nil

---@type UISynthesisSubCategoryPage
UISynthesisItemListPanel.NowSelectSubCategoryPage = nil

---@type number 当前选择的展开分类页签类型
UISynthesisItemListPanel.NowChooseTargetSynthesisSubType = nil

---@type number 当前选择的展开分类页签下属的合成目标
UISynthesisItemListPanel.NowChooseTargetSynthesisItemID = nil

--region Components

function UISynthesisItemListPanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return self.mBtnClose_GameObject;
end

function UISynthesisItemListPanel:GetFirstGridContainer()
    if (self.mFirstGridContainer == nil) then
        self.mFirstGridContainer = self:GetCurComp("WidgetRoot/view/ScorllView_Toggle/ToggleArea", "UIGridContainer");
    end
    return self.mFirstGridContainer;
end

function UISynthesisItemListPanel:GetSecondGridContainer()
    if (self.mSecondGridContainer == nil) then
        self.mSecondGridContainer = self:GetCurComp("WidgetRoot/view/ItemListPanel/ToggleArea/ToggleView/ToggleBtn/AllToggleGridContainer", "UIGridContainer");
    end
    return self.mSecondGridContainer;
end

function UISynthesisItemListPanel:GetSecondPageScrollView()
    if (self.mSecondPageScrollView == nil) then
        self.mSecondPageScrollView = self:GetCurComp("WidgetRoot/view/ItemListPanel/ToggleArea/ToggleView", "UIScrollView");
    end
    return self.mSecondPageScrollView;
end

function UISynthesisItemListPanel:GetSecondUITable_UITable()
    if (self.mSecondUITable_UITable == nil) then
        self.mSecondUITable_UITable = self:GetCurComp("WidgetRoot/view/ItemListPanel/ToggleArea/ToggleView/ToggleBtn/AllToggleGridContainer", "UITable");
        self.mSecondUITable_UITable.IsDealy = true;
    end
    return self.mSecondUITable_UITable;
end

--endregion

--region Method


function UISynthesisItemListPanel:Init()
    self:InitEvents();
end

---@private
function UISynthesisItemListPanel:InitEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UISynthesisItemListPanel");
    end

    self.CallOnSynthesisMainCategoryOnClick = function(msgId, msgData)
        self:OnCallOnSynthesisMainCategoryOnClick(msgData);
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Synthesis_CallOnSynthesisMainCategoryOnClick, self.CallOnSynthesisMainCategoryOnClick);

    self.CallOnSynthesisSubCategoryOnClick = function(msgId, msgData)
        self:OnCallOnSynthesisSubCategoryOnClick(msgData);
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Synthesis_CallOnSynthesisSubCategoryOnClick, self.CallOnSynthesisSubCategoryOnClick);

    self.CallOnSynthesisItemOnClick = function(msgId, msgData)
        self:OnCallOnSynthesisItemOnClick(msgData);
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Synthesis_CallOnSynthesisItemOnClick, self.CallOnSynthesisItemOnClick);

    self.CallOnResSynthesisMessage = function(msgId, msgData)
        self:OnResSynthesisMessage();
    end

    self.CallOnUpdateSynthesisSubCategoryPageButtons = function(msgId, msgData)
        self:UpdateSynthesisSubCategoryPageButtons(LuaEnumSynthesisItemListType.DataChangeRefresh, self.NowChooseTargetSynthesisSubType, self.NowChooseTargetSynthesisItemID);
    end

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Synthesis_UpdateUI, self.CallOnUpdateSynthesisSubCategoryPageButtons);
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSynthesisMessage, self.CallOnResSynthesisMessage);
end

function UISynthesisItemListPanel:RemoveEvents()
    if (self.mCoroutineDelayUpdateUITable ~= nil) then
        StopCoroutine(self.mCoroutineDelayUpdateUITable);
        self.mCoroutineDelayUpdateUITable = nil;
    end
end

function UISynthesisItemListPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    if (customData.targetSynthesisTable ~= nil) then
        local luaSynthesisTable = customData.targetSynthesisTable.csTABLE ~= nil and customData.targetSynthesisTable
                or clientTableManager.cfg_synthesisManager:TryGetValue(customData.targetSynthesisTable.id)
        if (luaSynthesisTable ~= nil) then
            customData.firstType = luaSynthesisTable.tabType;
            customData.secondType = luaSynthesisTable.tabSubType
            customData.thirdItemId = customData.targetItemId;
        end
    else
        if (customData.firstType == nil) then
            local pageButtonList = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetSynthesisMainCategoryPageButtons();
            if (pageButtonList ~= nil) then
                for k, v in pairs(pageButtonList) do
                    ---@type LuaSynthesis_MainCategory
                    local mainCategory = v;
                    if (mainCategory.Type ~= nil) then
                        customData.firstType = mainCategory.Type;
                        break ;
                    end
                end
            end
        end
    end

    --有任意强制打开的话,就关闭默认打开3级页签
    if (customData.firstType ~= nil) then
        self.TargetSynthesisMainType = customData.firstType;
    end
    if (customData.secondType ~= nil) then
        self.TargetSynthesisSubType = customData.secondType;
    end
    if (customData.thirdItemId ~= nil) then
        self.TargetSynthesisItemID = customData.thirdItemId;
    end
    self:GetBtnClose_GameObject():SetActive(false);
    self:UpdateUI();

    --self.TargetSynthesisMainType = nil
    --self.TargetSynthesisSubType = nil
    --self.TargetSynthesisItemID = nil
end

--region CallFunction

---点击合成主页签按钮.由于需要去操作List面板上面所有分页签,所有在这里处理
function UISynthesisItemListPanel:OnCallOnSynthesisMainCategoryOnClick(data)
    if (data == nil) then
        return
    end

    if (self.NowSelectMainCategoryPage ~= nil) then
        if (data.unit ~= nil and self.NowSelectMainCategoryPage.go ~= data.unit.go) then
            self.NowSelectMainCategoryPage:SwitchTglState(false);
        end
    end
    self.NowSelectMainCategoryPage = data.unit;

    if (self.TargetSynthesisMainType ~= data.type) then
        self.TargetSynthesisMainType = data.type;
        self:UpdateSynthesisSubCategoryPageButtons();
        self:GetSecondUITable_UITable():Reposition();
    end


end

---分类页签按钮的点击,由于同时只能同时存在一个分类页签的下来,所以在这里进行一下其他分类页签的关闭处理
function UISynthesisItemListPanel:OnCallOnSynthesisSubCategoryOnClick(data)
    for k, v in pairs(self.mSecondPageButtonUnitDic) do
        if not (v.mBtnType == data.type and v.mBtnLayer == data.pageLayer) then
            v:CloseThirdPageButton();
        end
    end

    if (self.NowSelectSubCategoryPage ~= nil) then
        if (data.unit ~= nil and self.NowSelectSubCategoryPage.go ~= data.unit.go) then
            self.NowSelectSubCategoryPage:SwitchTglState(false);
        end
    end
    self.NowSelectSubCategoryPage = data.unit;
    local maxSecondaryTabsCount = self:GetTheNumberOfSecondaryTabs()
    if (maxSecondaryTabsCount <= 10 or (self.lastSecondaryTabsCount ~= nil and self.lastSecondaryTabsCount > 10)) then
        self:GetSecondPageScrollView():Reposition();
    end
    self:GetSecondUITable_UITable():Reposition()
    self.lastSecondaryTabsCount = data.maxSecondaryTabsCount
end

---获取当前打开主页签的二级页签数量
---@return number 二级页签数量
function UISynthesisItemListPanel:GetTheNumberOfSecondaryTabs()
    ---@type LuaSynthesisMgr
    local SynthesisMgr = gameMgr:GetPlayerDataMgr():GetSynthesisMgr()
    ---@type LuaSynthesis_MainCategory
    local MainCategory = SynthesisMgr:GetMainCategoryData(self.TargetSynthesisMainType)

    ---@type table<LuaSynthesis_SubCategory>
    local synthesisSubCategoryPageButtons = MainCategory:GetSynthesisSubCategoryPageButton()

    local maxCount = Utility.GetTableCount(synthesisSubCategoryPageButtons)

    return maxCount, synthesisSubCategoryPageButtons
end

---合成目标按钮的点击,由于最终的点击会影响到红整个界面的红点(点击过有红点的按钮,红点会消失)
function UISynthesisItemListPanel:OnCallOnSynthesisItemOnClick(data)
    if (self.NowSelectSubCategoryPage ~= nil and self.NowSelectSubCategoryPage.NowSelectSynthesisTarget ~= nil) then
        ---@type UISynthesisPageTargetItem
        local temp = self.NowSelectSubCategoryPage.NowSelectSynthesisTarget

        if (data.unit ~= nil and temp.go ~= data.unit.go) then
            temp:SwitchTglState(false);
        end
    end
    self.TargetSynthesisSubType = data.type;
    if self.NowSelectSubCategoryPage then
        self.NowSelectSubCategoryPage.NowSelectSynthesisTarget = data.unit;
    end
end


--endregion

--region Public

---@public
function UISynthesisItemListPanel:UpdateUI()
    self:UpdateSynthesisMainCategoryPageButtons();
    self:UpdateSynthesisSubCategoryPageButtons();
    self:GetSecondUITable_UITable():Reposition();
end

--region 大类页签面板相关
---更新合成的大类页签
function UISynthesisItemListPanel:UpdateSynthesisMainCategoryPageButtons()
    if (self.mFirstPageButtonUnitDic == nil) then
        self.mFirstPageButtonUnitDic = {};
    end

    ---@type LuaSynthesisMgr
    local SynthesisMgr = gameMgr:GetPlayerDataMgr():GetSynthesisMgr()
    ---@type table<LuaSynthesis_MainCategory>
    local synthesisMainCategoryPageButtons = SynthesisMgr:GetSynthesisMainCategoryPageButtons()

    local maxCount = Utility.GetTableCount(synthesisMainCategoryPageButtons)
    local gridContainer = self:GetFirstGridContainer();

    gridContainer.MaxCount = maxCount;
    if (maxCount > 0) then
        local index = 0;
        for i, v in pairs(synthesisMainCategoryPageButtons) do
            local gobj = gridContainer.controlList[index];
            if (self.mFirstPageButtonUnitDic[gobj] == nil) then
                self.mFirstPageButtonUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UISynthesisMainCategoryPage);
            end
            ---@type UISynthesisMainCategoryPage
            local temp = self.mFirstPageButtonUnitDic[gobj]
            ---@type LuaSynthesis_MainCategory
            local MainCategory = v

            temp:UpdateUnit(MainCategory, self.TargetSynthesisMainType == MainCategory.Type);

            if (self.TargetSynthesisMainType == MainCategory.Type) then
                self.NowSelectMainCategoryPage = temp;
            end
            index = index + 1;
        end
    end
end

---得到主页签按钮
---@return UISynthesisMainCategoryPage
function UISynthesisItemListPanel:GetFirstFirstPageButtonUnit(type)
    for k, v in pairs(self.mFirstPageButtonUnitDic) do
        if (v.mBtnType == type) then
            return v;
        end
    end
    return nil;
end

--endregion

--region 分类详细合成列表面板
---更新合成页签分类页签,(装备为一级页签   等级装备/等级衣服)
---@param refreshType LuaEnumSynthesisItemListType
function UISynthesisItemListPanel:UpdateSynthesisSubCategoryPageButtons(refreshType, targetSynthesisSubtype, targetSynthesisItemID)
    if (self.mSecondPageButtonUnitDic == nil) then
        self.mSecondPageButtonUnitDic = {};
    end

    --每次点击一级页签的时候,需要重置2级页签的列表坐标到开头
    self:GetSecondPageScrollView():ResetPosition();
    local gridContainer = self:GetSecondGridContainer();
    if (self.TargetSynthesisMainType == nil) then
        gridContainer.MaxCount = 0;
        return
    end

    if targetSynthesisSubtype ~= nil then
        self.TargetSynthesisSubType = targetSynthesisSubtype
    end

    if (targetSynthesisItemID ~= nil) then
        self.TargetSynthesisItemID = targetSynthesisItemID;
    end

    local maxCount, synthesisSubCategoryPageButtons = self:GetTheNumberOfSecondaryTabs()

    gridContainer.MaxCount = maxCount;

    ---@type UISynthesisSubCategoryPage
    local firstSynthesisSub = nil
    local IsOpenDefaultThreeList = true;
    if (maxCount > 0) then
        local index = 0;
        for i, v in pairs(synthesisSubCategoryPageButtons) do
            local gobj = gridContainer.controlList[index];
            if (self.mSecondPageButtonUnitDic[gobj] == nil) then
                self.mSecondPageButtonUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UISynthesisSubCategoryPage);
            end
            ---@type UISynthesisSubCategoryPage
            local temp = self.mSecondPageButtonUnitDic[gobj];

            ---@type LuaSynthesis_SubCategory
            local SubCategory = v

            ---刷新下级页签的数据,并返回下级页签数量
            --region 页签开启状态
            local openSubtype = temp.IsOpen
            if self.TargetSynthesisMainType ~= nil and self.TargetSynthesisSubType ~= nil then
                ---当前刷新的子页签为指定打开的子页签，则打开子页签
                openSubtype = self.TargetSynthesisMainType == SubCategory.Type and self.TargetSynthesisSubType == SubCategory.SubType
            elseif self.TargetSynthesisMainType ~= nil and (temp == nil or temp.LuaSynthesis_SubCategory == nil or self.TargetSynthesisMainType ~= temp.LuaSynthesis_SubCategory.Type) then
                ---当前刷新的主页前和当前模板页签内容不一致，则关闭
                openSubtype = false
            end
            if openSubtype == nil then
                openSubtype = false
            end

            if (openSubtype == true) then
                IsOpenDefaultThreeList = false
            end
            --endregion
            temp:UpdateUnit(SubCategory, openSubtype, self.TargetSynthesisItemID, refreshType);
            if (firstSynthesisSub == nil) then
                firstSynthesisSub = temp;
            end
            if (self.TargetSynthesisSubType == SubCategory.SubType) then
                self.NowSelectSubCategoryPage = temp
                self:GetSecondUITable_UITable():Reposition();
            end
            --if(temp.NowSelectSynthesisTarget ~= nil) then
            --    self.NowSelectSynthesisTarget =  temp.NowSelectSynthesisTarget;
            --end
            index = index + 1;
        end

        if (firstSynthesisSub ~= nil and IsOpenDefaultThreeList == true) then
            firstSynthesisSub:OnSelfClick();
        end
    end

end
--endregion

--endregion

---接收到合成结果的消息之后,需要刷新面板
function UISynthesisItemListPanel:OnResSynthesisMessage()
    self:UpdateUI();
end



--endregion



function ondestroy()
    UISynthesisItemListPanel:RemoveEvents();
end

return UISynthesisItemListPanel;