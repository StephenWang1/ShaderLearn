---@class UISynthesisViewTemplate:TemplateBase 合成
local UISynthesisViewTemplate = {};

UISynthesisViewTemplate.mNeedMaterialUnitDic = nil;

UISynthesisViewTemplate.mSelectBagItem = nil;

UISynthesisViewTemplate.mLastSelectBagItem = nil;

UISynthesisViewTemplate.mBagPanel = nil;

UISynthesisViewTemplate.mEffectDic = nil;

UISynthesisViewTemplate.mCustomData = nil;

---@type TABLE.cfg_synthesis
UISynthesisViewTemplate.mTargetSynthesisTable = nil;

UISynthesisViewTemplate.mLeftPanelType = nil;

---@type TABLE.CFG_ITEMS
UISynthesisViewTemplate.nowSynthesisItem = nil;

UISynthesisViewTemplate.mIsSynthesisSuccess = false;

---合成物单行数量
UISynthesisViewTemplate.OutPutItemSingleRowCount = 2

---合成结果表集合
UISynthesisViewTemplate.mSynthesisTables = nil;

UISynthesisViewTemplate.mSynthesisUseMaterialType = nil;

--region Components

---切换主材料取用逻辑父节点
function UISynthesisViewTemplate:GetChangeMaterialLogic_GameObject()
    if (self.mChangeMaterialLogic_GameObject == nil) then
        self.mChangeMaterialLogic_GameObject = self:Get("events/changeMaterialLogic", "GameObject");
    end
    return self.mChangeMaterialLogic_GameObject;
end

---使用角色装备作为材料逻辑按钮
function UISynthesisViewTemplate:GetBtnUseRole_GameObject()
    if (self.mBtnUseRole_GameObject == nil) then
        self.mBtnUseRole_GameObject = self:Get("events/changeMaterialLogic/btn_useRole", "GameObject");
    end
    return self.mBtnUseRole_GameObject;
end

function UISynthesisViewTemplate:GetTglUseRole_UIToggle()
    if (self.mTglUseRole_UIToggle == nil) then
        self.mTglUseRole_UIToggle = CS.Utility_Lua.GetComponent(self:GetBtnUseRole_GameObject(), "UIToggle")
    end
    return self.mTglUseRole_UIToggle;
end

---使用寒芒装备作为材料逻辑按钮
function UISynthesisViewTemplate:GetBtnUseHM_GameObject()
    if (self.mBtnUseHM_GameObject == nil) then
        self.mBtnUseHM_GameObject = self:Get("events/changeMaterialLogic/btn_useServant1", "GameObject");
    end
    return self.mBtnUseHM_GameObject;
end

function UISynthesisViewTemplate:GetTglUseHM_UIToggle()
    if (self.mTglUseHM_UIToggle == nil) then
        self.mTglUseHM_UIToggle = CS.Utility_Lua.GetComponent(self:GetBtnUseHM_GameObject(), "UIToggle")
    end
    return self.mTglUseHM_UIToggle;
end

---使用落星装备作为材料逻辑按钮
function UISynthesisViewTemplate:GetBtnUseLX_GameObject()
    if (self.mBtnUseLX_GameObject == nil) then
        self.mBtnUseLX_GameObject = self:Get("events/changeMaterialLogic/btn_useServant2", "GameObject");
    end
    return self.mBtnUseLX_GameObject;
end

function UISynthesisViewTemplate:GetTglUseLX_UIToggle()
    if (self.mTglUseLX_UIToggle == nil) then
        self.mTglUseLX_UIToggle = CS.Utility_Lua.GetComponent(self:GetBtnUseLX_GameObject(), "UIToggle")
    end
    return self.mTglUseLX_UIToggle;
end

---使用天成装备作为材料逻辑按钮
function UISynthesisViewTemplate:GetBtnUseTC_GameObject()
    if (self.mBtnUseTC_GameObject == nil) then
        self.mBtnUseTC_GameObject = self:Get("events/changeMaterialLogic/btn_useServant3", "GameObject");
    end
    return self.mBtnUseTC_GameObject;
end

function UISynthesisViewTemplate:GetTglUseTC_UIToggle()
    if (self.mTglUseTC_UIToggle == nil) then
        self.mTglUseTC_UIToggle = CS.Utility_Lua.GetComponent(self:GetBtnUseTC_GameObject(), "UIToggle")
    end
    return self.mTglUseTC_UIToggle;
end

function UISynthesisViewTemplate:GetTglSynthesisList_UIToggle()
    if (self.mTglSynthesisList_UIToggle == nil) then
        self.mTglSynthesisList_UIToggle = self:Get("events/btn_synthesisList", "UIToggle");
    end
    return self.mTglSynthesisList_UIToggle;
end

function UISynthesisViewTemplate:GetTglRole_UIToggle()
    if (self.mTglRole__UIToggle == nil) then
        self.mTglRole__UIToggle = self:Get("events/btn_role", "UIToggle");
    end
    return self.mTglRole__UIToggle;
end

function UISynthesisViewTemplate:GetTglBag_UIToggle()
    if (self.mTglBag_UIToggle == nil) then
        self.mTglBag_UIToggle = self:Get("events/btn_bag", "UIToggle");
    end
    return self.mTglBag_UIToggle;
end

function UISynthesisViewTemplate:GetTglServant_UIToggle()
    if (self.mTglServant_UIToggle == nil) then
        self.mTglServant_UIToggle = self:Get("events/btn_yuanling", "UIToggle");
    end
    return self.mTglServant_UIToggle;
end

function UISynthesisViewTemplate:GetNotHasSynthesis_GameObject()
    if (self.mNotHasSynthesis_GameObject == nil) then
        self.mNotHasSynthesis_GameObject = self:Get("window/NoSynthesis", "GameObject");
    end
    return self.mNotHasSynthesis_GameObject;
end

function UISynthesisViewTemplate:GetChoose_GameObject()
    if (self.mChoose_GameObject == nil) then
        self.mChoose_GameObject = self:Get("view/Choose", "GameObject")
    end
    return self.mChoose_GameObject;
end

function UISynthesisViewTemplate:GetBtnSynthesis_GameObject()
    if (self.mBtnSynthesis_GameObject == nil) then
        self.mBtnSynthesis_GameObject = self:Get("events/btn_use", "GameObject");
    end
    return self.mBtnSynthesis_GameObject;
end

function UISynthesisViewTemplate:GetBtnSynthesis_UILabel()
    if (self.mBtnSynthesis_UILabel == nil) then
        self.mBtnSynthesis_UILabel = self:Get("events/btn_use/Label", "Top_UILabel");
    end
    return self.mBtnSynthesis_UILabel;
end

function UISynthesisViewTemplate:GetView_GameObject()
    if (self.mView_GameObject == nil) then
        self.mView_GameObject = self:Get("view", "GameObject");
    end
    return self.mView_GameObject;
end

function UISynthesisViewTemplate:GetBtnAdd_GameObject()
    if (self.mBtnAdd_GameObject == nil) then
        self.mBtnAdd_GameObject = self:Get("view/Input/add", "GameObject");
    end
    return self.mBtnAdd_GameObject;
end

function UISynthesisViewTemplate:GetBtnLess_GameObject()
    if (self.mBtnLess_GameObject == nil) then
        self.mBtnLess_GameObject = self:Get("view/Input/reduce", "GameObject");
    end
    return self.mBtnLess_GameObject;
end

function UISynthesisViewTemplate:GetTglYuanSu_UIToggle()
    if (self.mTglYuanSu_UIToggle == nil) then
        self.mTglYuanSu_UIToggle = self:Get("events/btn_yuansu", "UIToggle");
    end
    return self.mTglYuanSu_UIToggle
end

function UISynthesisViewTemplate:GetBtnChangeMaterial_GameObject()
    if (self.mBtnChangeMaterial_GameObject == nil) then
        self.mBtnChangeMaterial_GameObject = self:Get("events/btn_changeMaterial", "GameObject");
    end
    return self.mBtnChangeMaterial_GameObject;
end

function UISynthesisViewTemplate:GetArrow_Tween()
    if (self.mArrow_Tween == nil) then
        self.mArrow_Tween = self:Get("events/btn_changeMaterial/arrow", "Top_TweenRotation");
    end
    return self.mArrow_Tween;
end

function UISynthesisViewTemplate:GetTglYinJi_UIToggle()
    if (self.mTglYinJi_UIToggle == nil) then
        self.mTglYinJi_UIToggle = self:Get("events/btn_yinji", "UIToggle");
    end
    return self.mTglYinJi_UIToggle;
end

function UISynthesisViewTemplate:GetTglEquip_UIToggle()
    if (self.mTglEquip_UIToggle == nil) then
        self.mTglEquip_UIToggle = self:Get("events/btn_equip", "UIToggle");
    end
    return self.mTglEquip_UIToggle;
end

function UISynthesisViewTemplate:GetInputCountParent_GameObject()
    if (self.mInputCountParent_GameObject == nil) then
        self.mInputCountParent_GameObject = self:Get("view/Input", "GameObject");
    end
    return self.mInputCountParent_GameObject;
end

function UISynthesisViewTemplate:GetEffectNode_Transform()
    if (self.mEffectNode_Transform == nil) then
        self.mEffectNode_Transform = self:Get("view/effectNode", "Transform");
    end
    return self.mEffectNode_Transform;
end

function UISynthesisViewTemplate:GetCostValue_Text()
    if (self.mCostValue_Text == nil) then
        self.mCostValue_Text = self:Get("view/cost2", "UILabel");
    end
    return self.mCostValue_Text;
end

function UISynthesisViewTemplate:GetCurrentSynthesisName_Text()
    if (self.mCurrentSynthesisName_Text == nil) then
        self.mCurrentSynthesisName_Text = self:Get("view/currentName", "UILabel");
    end
    return self.mCurrentSynthesisName_Text;
end

function UISynthesisViewTemplate:GetCurrentSynthesisCount_Text()
    if (self.mCurrentSynthesisCount_Text == nil) then
        self.mCurrentSynthesisCount_Text = self:Get("view/count", "UILabel");
    end
    return self.mCurrentSynthesisCount_Text;
end

function UISynthesisViewTemplate:GetCostType_UISprite()
    if (self.mCostType_UISprite == nil) then
        self.mCostType_UISprite = self:Get("view/img", "UISprite");
    end
    return self.mCostType_UISprite;
end

---宝箱物品格子列表
---@return UIGridContainer
function UISynthesisViewTemplate:GetBoxItemGrids()
    if self.mBoxItemGrids == nil then
        self.mBoxItemGrids = self:Get("view/Scroll_single/Grid", "UIGridContainer")
    end
    return self.mBoxItemGrids
end

---@return UIScrollView
function UISynthesisViewTemplate:GetBoxItemGridsScrollView()
    if self.mBoxItemGridsScrollView == nil then
        self.mBoxItemGridsScrollView = self:Get("view/Scroll_single", "UIScrollView")
    end
    return self.mBoxItemGridsScrollView
end

---@return UnityEngine.GameObject
function UISynthesisViewTemplate:GetBoxItemSign()
    if self.mBoxItemSign == nil then
        self.mBoxItemSign = self:Get("view/text", "GameObject")
    end
    return self.mBoxItemSign
end

---@return UIWidget
function UISynthesisViewTemplate:GetCostType_UIWidget()
    if (self.mCostType_UIWidget == nil) then
        self.mCostType_UIWidget = self:Get("view/img", "UIWidget");
    end
    return self.mCostType_UIWidget;
end

function UISynthesisViewTemplate:GetCountInput_UIInput()
    if (self.mCountInput_UIInput == nil) then
        self.mCountInput_UIInput = self:Get("view/Input/inputcount", "UIInput");
    end
    return self.mCountInput_UIInput;
end

---@return UISynthesisTargetUnitTemplate
function UISynthesisViewTemplate:GetSingleSynthesisTargetUnit()
    if (self.mSingleSynthesisTargetUnit == nil) then
        local gobj = self:Get("view/singleTargetUnitTemplate", "GameObject");
        self.mSingleSynthesisTargetUnit = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UISynthesisTargetUnitTemplate);
    end
    return self.mSingleSynthesisTargetUnit;
end

function UISynthesisViewTemplate:GetSynthesisTargetParents_GameObject()
    if (self.mSynthesisTargetParents_GameObject == nil) then
        self.mSynthesisTargetParents_GameObject = self:Get("view/DoubleItem", "GameObject");
    end
    return self.mSynthesisTargetParents_GameObject;
end

function UISynthesisViewTemplate:GetNeedMaterials_UIPanel()
    if (self.mGetNeedMaterials_UIPanel == nil) then
        self.mGetNeedMaterials_UIPanel = self:Get("view/ScrollView", "Top_UIPanel")
    end
    return self.mGetNeedMaterials_UIPanel;
end
function UISynthesisViewTemplate:GetNeedMaterials_UIScrollView()
    if (self.mGetNeedMaterials_UIScrollView == nil) then
        self.mGetNeedMaterials_UIScrollView = self:Get("view/ScrollView", "Top_UIScrollView")
    end
    return self.mGetNeedMaterials_UIScrollView;
end

function UISynthesisViewTemplate:GetNeedMaterials_UIGridContainer()
    if (self.mNeedMaterials_UIGridContainer == nil) then
        self.mNeedMaterials_UIGridContainer = self:Get("view/ScrollView/materials", "UIGridContainer")
    end
    return self.mNeedMaterials_UIGridContainer;
end

function UISynthesisViewTemplate:GetTglRole_RedPoint()
    if (self.mTglRole_RedPoint == nil) then
        self.mTglRole_RedPoint = self:Get("events/btn_role/Red", "UIRedPoint");
    end
    return self.mTglRole_RedPoint;
end

function UISynthesisViewTemplate:GetSynthesisListRedPointComponent()
    if (self.mSynthesisListRedPointComponent == nil) then
        self.mSynthesisListRedPointComponent = self:Get("events/btn_synthesisList/Red", "UIRedPoint");
    end
    return self.mSynthesisListRedPointComponent;
end

function UISynthesisViewTemplate:GetTglServant_RedPoint()
    if (self.mTglServant_RedPoint == nil) then
        self.mTglServant_RedPoint = self:Get("events/btn_yuanling/Red", "UIRedPoint");
    end
    return self.mTglServant_RedPoint;
end

function UISynthesisViewTemplate:GetBtnYinJiRedPointComponent()
    if (self.mBtnYinJiRedPointComponent == nil) then
        self.mBtnYinJiRedPointComponent = self:Get("events/btn_yinji/Red", "UIRedPoint");
    end
    return self.mBtnYinJiRedPointComponent;
end

function UISynthesisViewTemplate:GetBtnYuanSuRedPointComponent()
    if (self.mBtnYuanSuRedPointComponent == nil) then
        self.mBtnYuanSuRedPointComponent = self:Get("events/btn_yuansu/Red", "UIRedPoint");
    end
    return self.mBtnYuanSuRedPointComponent;
end

---@return Top_UIGridContainer
function UISynthesisViewTemplate:GetOutPutItemRow_Top_UIGridContainer()
    if (self.mOutPutItemRow == nil) then
        self.mOutPutItemRow = self:Get("view/Scroll/OutPutItemRow", "Top_UIGridContainer");
    end
    return self.mOutPutItemRow;
end

function UISynthesisViewTemplate:GetOutPutItemRow_Top_UIScrollView()
    if (self.mGetOutPutItemRow_Top_UIScrollView == nil) then
        self.mGetOutPutItemRow_Top_UIScrollView = self:Get("view/OutPutItemRow", "Top_UIScrollView");
    end
    return self.mGetOutPutItemRow_Top_UIScrollView;
end

---条件的描述
function UISynthesisViewTemplate:GetConditionDescLabel()
    if (self.mGetConditionDescLabel == nil) then
        self.mGetConditionDescLabel = self:Get("view/conditionDesc", "Top_UILabel");
    end
    return self.mGetConditionDescLabel;
end

---获得当前使用材料的类型
function UISynthesisViewTemplate:GetCurSynthesisUseMaterialType()
    if (self.mSynthesisUseMaterialType == nil) then
        return LuaEnumSynthesisUseMaterialLogicType.RoleAndBag;
    end
    return self.mSynthesisUseMaterialType;
end

--endregion

function UISynthesisViewTemplate:GetSynthesisTargetUnits(SynthesisCount)
    if SynthesisCount == nil then
        return self.mSynthesisTargetUnits
    end
    self:RefreshOutPutItemGrid(SynthesisCount)
    return self.mSynthesisTargetUnits;
end

---刷新合成物格子
function UISynthesisViewTemplate:RefreshOutPutItemGrid(SynthesisCount)
    local isUseSlippingGrid = SynthesisCount >= 3
    self:GetOutPutItemRow_Top_UIGridContainer().gameObject:SetActive(not isUseSlippingGrid)
    self:GetBoxItemGrids().gameObject:SetActive(isUseSlippingGrid)
    if isUseSlippingGrid then
        self:RefreshOutPutItemGrid2(SynthesisCount)
        return
    end
    self.mSynthesisTargetUnits = {};
    if CS.StaticUtility.IsNull(self:GetOutPutItemRow_Top_UIGridContainer()) == false then
        local childCount = SynthesisCount
        local totalRow = Utility.GetMaxIntPart(childCount / self.OutPutItemSingleRowCount)
        self:GetOutPutItemRow_Top_UIGridContainer().MaxCount = totalRow
        --local gridIndex = 0
        for k = 0, totalRow - 1 do
            local singleRow_GameObject = self:GetOutPutItemRow_Top_UIGridContainer().controlList[k]
            local singleRow_Top_UIGridContainer = self:GetCurComp(singleRow_GameObject, "", "Top_UIGridContainer")
            local singleRowItemCount = ternary(k == totalRow - 1, childCount - (self.OutPutItemSingleRowCount * k), self.OutPutItemSingleRowCount)
            if CS.StaticUtility.IsNull(singleRow_Top_UIGridContainer) == false then
                singleRow_Top_UIGridContainer.MaxCount = singleRowItemCount
                for j = 0, singleRowItemCount - 1 do
                    --gridIndex = k + (j + 1)
                    local itemGrid = singleRow_Top_UIGridContainer.controlList[j]
                    local template = templatemanager.GetNewTemplate(itemGrid, luaComponentTemplates.UISynthesisTargetUnitTemplate);
                    table.insert(self.mSynthesisTargetUnits, template);
                end
            end
        end
    end
    if (self:GetOutPutItemRow_Top_UIScrollView()) then
        self:GetOutPutItemRow_Top_UIScrollView():ResetPosition();
    end
end

---刷新合成物格子2
function UISynthesisViewTemplate:RefreshOutPutItemGrid2(SynthesisCount)
    self.mSynthesisTargetUnits = {};
    if CS.StaticUtility.IsNull(self:GetBoxItemGrids()) == false then
        self:GetBoxItemGrids().MaxCount = SynthesisCount
        for k = 0, SynthesisCount - 1 do
            local itemGrid = self:GetBoxItemGrids().controlList[k]
            local template = templatemanager.GetNewTemplate(itemGrid, luaComponentTemplates.UISynthesisTargetUnitTemplate);
            table.insert(self.mSynthesisTargetUnits, template);
        end
    end
    if (self:GetBoxItemGridsScrollView()) then
        self:GetBoxItemGridsScrollView():ResetPosition();
    end
end

--region CallFunction

---使用角色装备作为材料逻辑按钮点击响应
function UISynthesisViewTemplate:OnBtnUseRoleClick()
    self:UpdateMaterialLogic(LuaEnumSynthesisUseMaterialLogicType.RoleAndBag);
end

---使用寒芒装备作为材料逻辑按钮点击响应
function UISynthesisViewTemplate:OnBtnUseHMClick()
    self:UpdateMaterialLogic(LuaEnumSynthesisUseMaterialLogicType.HMAndBag);
end

---使用落星装备作为材料逻辑按钮点击响应
function UISynthesisViewTemplate:OnBtnUseLXClick()
    self:UpdateMaterialLogic(LuaEnumSynthesisUseMaterialLogicType.LXAndBag);
end

---使用天成装备作为材料逻辑按钮点击响应
function UISynthesisViewTemplate:OnBtnUseTCClick()
    self:UpdateMaterialLogic(LuaEnumSynthesisUseMaterialLogicType.TCAndBag);
end

function UISynthesisViewTemplate:OnBtnSynthesisClick()
    if (self.NotMeetSynthesisConditionResult ~= nil) then
        Utility.ShowPopoTips(self:GetBtnSynthesis_GameObject().transform, self.NotMeetSynthesisConditionResult.txt, 329, "UISynthesisPanel");
        return ;
    end

    if (self.mTargetSynthesisTable ~= nil and CS.CSScene.MainPlayerInfo ~= nil) then
        local count = tonumber(self:GetCountInput_UIInput().value);
        local stateCode = 2;
        local luaSynthesis = clientTableManager.cfg_synthesisManager:TryGetValue(self.mTargetSynthesisTable.id)
        stateCode = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetSynthesisStateCode(luaSynthesis, self:GetSynthesisMainBagItemInfo(), count)
        ---如果是选中目标进行合成(如果是通过合成列表,这里面好像是没有的)
        local mustItemLids = {};
        local otherItemLids = nil
        local coinItemIds = nil;
        if (self:GetSynthesisMainBagItemInfo() ~= nil) then
            table.insert(mustItemLids, self:GetSynthesisMainBagItemInfo().lid);
            otherItemLids, coinItemIds = self:GetCostItems(self:GetSynthesisMainBagItemInfo().lid)
        else
            otherItemLids, coinItemIds = self:GetCostItems()
        end

        if (stateCode == 0 or stateCode == 2) then
            --正常消耗
            self:ReqSynthesis(count, mustItemLids, otherItemLids, coinItemIds);
        elseif (stateCode == 2) then
            --材料不足
            Utility.ShowPopoTips(self:GetBtnSynthesis_GameObject().transform, "材料不足", 329, "UISynthesisPanel");
        elseif (stateCode == 3) then
            --region  如果主材料(装备)在身上装备的数量大于等于2 则给个提示(确认方法)
            local sureFunction = function()
                local sureSynthesis = function()
                    self:ReqSynthesis(count, mustItemLids, otherItemLids);
                end

                local list = self:GetOutItemIdList();
                if (list ~= nil) then
                    if (self.mSelectBagItem ~= nil and CS.CSScene.MainPlayerInfo.EquipInfo:IsEquip(self.mSelectBagItem.lid)) then
                        for i = 1, #list do
                            if (not CS.CSScene.MainPlayerInfo.EquipInfo:IsBetterBaseAndRateAttributeThanBodyEquip(list[i], self:GetSynthesisMainBagItemInfo())) then
                                Utility.ShowPromptTipsPanel({ id = 115, Callback = sureSynthesis });
                            else
                                sureSynthesis();
                            end
                        end
                    else
                        sureSynthesis();
                    end
                end
            end
            --endregion

            Utility.ShowPromptTipsPanel({ id = 138, Callback = sureFunction });

        end
    else
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Describe] = "没有可合成的物品";
        TipsInfo[LuaEnumTipConfigType.Parent] = self:GetBtnSynthesis_GameObject().transform;
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 171
        TipsInfo[LuaEnumTipConfigType.DependPanel] = "UISynthesisPanel"
        uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    end
end

---判断是不是神力装备并且不满足穿戴条件
---@return boolean 是神力装备并且不满足穿戴条件
function UISynthesisViewTemplate:IsInsufficientLevelOfDivineSuitEquip()
    local list = self:GetOutItemIdList();
    if (list ~= nil) then
        for i = 1, #list do
            local itemID = tonumber(list[i])
            if clientTableManager.cfg_itemsManager:IsDivineSuitEquip(itemID) then
                local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemID)
                if luaItemInfo and luaItemInfo:GetSubType() ~= LuaEquipmentItemType.POS_SL_FABAO then
                    local divineInfo = clientTableManager.cfg_divinesuitManager:TryGetValue(luaItemInfo:GetDivineId())
                    if divineInfo then
                        local canUse = false
                        local playerHasEquip = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentItem(divineInfo:GetType(), LuaEquipmentItemType.POS_SL_FABAO)
                        if playerHasEquip and playerHasEquip.DivineSuitTbl_lua then
                            canUse = playerHasEquip.DivineSuitTbl_lua:GetLevel() >= divineInfo:GetLevel()
                        end
                        if (not canUse and divineInfo:GetLevel() > 1) then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

---得到消耗的道具Items数据
---@param excludeId number 排除掉选中的道具
function UISynthesisViewTemplate:GetCostItems(excludeId)
    self.mCostItemLids = {}
    self.mCostCoinItemIds = {};

    ---循环底下的所有材料
    local gridContainer = self:GetNeedMaterials_UIGridContainer();
    for i = 0, gridContainer.MaxCount - 1 do
        local gobj = gridContainer.controlList[i];
        ---@type UISynthesisMaterialUnitTemplate
        local temp = self.mNeedMaterialUnitDic[gobj]
        if (temp ~= nil) then
            local costItemLids, costCoinItemIds = temp:GetCostItems(excludeId);
            if (costItemLids ~= nil) then
                for k, v in pairs(costItemLids) do
                    table.insert(self.mCostItemLids, v);
                end
            end

            if (costCoinItemIds ~= nil) then
                for k, v in pairs(costCoinItemIds) do
                    table.insert(self.mCostCoinItemIds, v);
                end
            end
        end
    end

    return self.mCostItemLids, self.mCostCoinItemIds;
end

function UISynthesisViewTemplate:ReqSynthesis(count, mustItemLids, otherItemLids, coinIds)
    --local maxCount = self:GetMaxSynthesisCount();
    ---@type function
    local func = function()
        networkRequest.ReqSynthesis(self.mTargetSynthesisTable:GetId(), 0, count, mustItemLids, otherItemLids, coinIds);
    end

    ---如果合成的是神力装备，并且合成后等级不足不能装备，则气泡提示等级不足是否强制合成
    if (self:IsInsufficientLevelOfDivineSuitEquip()) then
        Utility.ShowPromptTipsPanel({ id = 121, Callback = func });
        return
    end

    local isShowTip = self:TryCreateLevelDeficiencyTip(func)

    if isShowTip == true then
        return
    end

    func()

    --[[根据堆叠数进行合成判断,堆叠数=1，一次只能合成1个
    if (maxCount <= 1) then
        networkRequest.ReqSynthesis(self.mTargetSynthesisTable:GetId(), 0, count, mustItemLids, otherItemLids, coinIds);
    else
        --region 合成主材料
        local isFindOrignItem, originItem;
        if (self.mSelectBagItem ~= nil) then
            isFindOrignItem, originItem = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mSelectBagItem.itemId);
        else
            if (self.mTargetSynthesisTable ~= nil) then
                local itemId = nil;
                if (self.mTargetSynthesisTable:GetItemid() ~= nil and #self.mTargetSynthesisTable:GetItemid().list > 0) then
                    itemId = self.mTargetSynthesisTable:GetItemid().list[1];
                end

                if (itemId ~= nil) then
                    isFindOrignItem, originItem = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
                end
            end
        end
        --endregion

        local list = self:GetOutItemIdList();
        for i, itemId in pairs(list) do
            local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
            if (isFind) then
                if (isFindOrignItem and originItem.overlying == 1) then
                    --虽然拥有多个相同的可合成道具,但是这个道具是不可重叠的,所以需要一个个合成
                    networkRequest.ReqSynthesis(self.mTargetSynthesisTable:GetId(), 0, 1, mustItemLids, otherItemLids, coinIds);
                else
                    local num = tonumber(self:GetCountInput_UIInput().value);
                    networkRequest.ReqSynthesis(self.mTargetSynthesisTable:GetId(), 0, num, mustItemLids, otherItemLids, coinIds);
                end
            end
        end
    end
    --]]
end

---合成成功
function UISynthesisViewTemplate:OnResSynthesisMessage(msgId, msgData)
    if (self.mCoroutinePlayEffect ~= nil) then
        StopCoroutine(self.mCoroutinePlayEffect);
        self.mCoroutinePlayEffect = nil;
    end
    self.mCoroutinePlayEffect = StartCoroutine(self.IEnumPlaySuccessEffect, self, msgData.item)

    self.mIsSynthesisSuccess = true;
    --self:UpdateSynthesis();
end

function UISynthesisViewTemplate:OnRoleEquipGridClick(bagItemInfo)
    if (bagItemInfo ~= nil) then
        self.mSynthesisUseMaterialType = LuaEnumSynthesisUseMaterialLogicType.RoleAndBag;
        self:SwitchTglState(self:GetTglEquip_UIToggle(), false)
        self:SwitchTglState(self:GetTglYuanSu_UIToggle(), false)
        self:SwitchTglState(self:GetTglYinJi_UIToggle(), false)
        self.mSelectBagItem = bagItemInfo;
        self.mLastSelectBagItem = bagItemInfo;
        --if (self:TrySetSelectBagItem(bagItemInfo) ~= 1) then
        --
        --end
        self:UpdateSynthesis();
    end
end

---背包格子单击
function UISynthesisViewTemplate:OnBagSingleClick(bagItemInfo)
    local stateCode = self:TrySetSelectBagItem(bagItemInfo);
    if (stateCode == 1) then
        ---物品不能合成;
        self:OpenItemTip(bagItemInfo);
    end

    self:UpdateSynthesis();
end

---灵兽头像单击
function UISynthesisViewTemplate:OnServantHeadClick(bagItemInfo)
    local stateCode = self:TrySetSelectBagItem(bagItemInfo);
    self:UpdateSynthesis();
end

---印记按钮点击
function UISynthesisViewTemplate:OnBtnSignetClick()
    local isEquip = false;
    if (self.mSelectBagItem ~= nil) then
        local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfo(self.mSelectBagItem.lid);
        if (equipInfo ~= nil) then
            isEquip = true;
            local signetInfo = CS.CSScene.MainPlayerInfo.SignetV2:FindIndexSignetInfo(equipInfo.index);
            if (signetInfo ~= nil and signetInfo.itemInfo ~= nil) then
                self.mLastSelectBagItem = self.mSelectBagItem;
                self:TrySetSelectBagItem(signetInfo.itemInfo);
                --gameMgr:GetPlayerDataMgr():GetSynthesisMgr():AddToShieldSynthesisRedList(signetInfo.itemInfo.itemId)
                --gameMgr:GetLuaRedPointManager():AddRemoveRedItem(signetInfo.itemInfo.itemId);
                --gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipSignet));
                self:UpdateSynthesis();
            end
        end
    end

    if (not isEquip) then
        if (self.mLastSelectBagItem ~= nil) then
            local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfo(self.mLastSelectBagItem.lid);
            if (equipInfo ~= nil) then
                local signetInfo = CS.CSScene.MainPlayerInfo.SignetV2:FindIndexSignetInfo(equipInfo.index);
                if (signetInfo ~= nil and signetInfo.itemInfo ~= nil) then
                    self:TrySetSelectBagItem(signetInfo.itemInfo);
                    --gameMgr:GetPlayerDataMgr():GetSynthesisMgr():AddToShieldSynthesisRedList(signetInfo.itemInfo.itemId)
                    --gameMgr:GetLuaRedPointManager():AddRemoveRedItem(signetInfo.itemInfo.itemId);
                    --gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipSignet));
                    self:UpdateSynthesis();
                end
            end
        end
    end
    self:SwitchTglState(self:GetTglYinJi_UIToggle(), true);
    self:SwitchTglState(self:GetTglYuanSu_UIToggle(), false);
    self:SwitchTglState(self:GetTglEquip_UIToggle(), false);
end

---元素按钮点击
function UISynthesisViewTemplate:OnBtnElementClick()
    local isEquip = false;
    if (self.mSelectBagItem ~= nil) then
        local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfo(self.mSelectBagItem.lid);
        if (equipInfo ~= nil) then
            isEquip = true;
            local isFind, elementInfo = CS.CSScene.MainPlayerInfo.ElementInfo.Elements:TryGetValue(equipInfo.index);
            if (isFind and elementInfo ~= nil and elementInfo.bagItemInfo ~= nil) then
                self.mLastSelectBagItem = self.mSelectBagItem;
                self:TrySetSelectBagItem(elementInfo.bagItemInfo);

                --gameMgr:GetPlayerDataMgr():GetSynthesisMgr():AddToShieldSynthesisRedList(elementInfo.bagItemInfo.itemId)
                --gameMgr:GetLuaRedPointManager():AddRemoveRedItem(elementInfo.bagItemInfo.itemId);
                --gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipElement));
                self:UpdateSynthesis();
            end
        end
    end

    if (not isEquip) then
        if (self.mLastSelectBagItem ~= nil) then
            local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfo(self.mLastSelectBagItem.lid);
            if (equipInfo ~= nil) then
                if (equipInfo ~= nil) then
                    local isFind, elementInfo = CS.CSScene.MainPlayerInfo.ElementInfo.Elements:TryGetValue(equipInfo.index);
                    if (isFind and elementInfo ~= nil and elementInfo.bagItemInfo ~= nil) then
                        self:TrySetSelectBagItem(elementInfo.bagItemInfo);

                        --gameMgr:GetPlayerDataMgr():GetSynthesisMgr():AddToShieldSynthesisRedList(elementInfo.bagItemInfo.itemId)
                        --gameMgr:GetLuaRedPointManager():AddRemoveRedItem(elementInfo.bagItemInfo.itemId);
                        --gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipElement));
                        self:UpdateSynthesis();
                    end
                end
            end
        end
    end
    self:SwitchTglState(self:GetTglYinJi_UIToggle(), false);
    self:SwitchTglState(self:GetTglYuanSu_UIToggle(), true);
    self:SwitchTglState(self:GetTglEquip_UIToggle(), false);
end

---装备按钮点击
function UISynthesisViewTemplate:OnBtnEquipClick()
    local isEquip = false;
    if (self.mSelectBagItem ~= nil) then
        local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfo(self.mSelectBagItem.lid);
        if (equipInfo ~= nil) then
            isEquip = true;
            self.mLastSelectBagItem = self.mSelectBagItem;
            if (clientTableManager.cfg_synthesisManager:IsCanSynthesis(equipInfo.itemId) == false) then
                return ;
            end
            self:TrySetSelectBagItem(self.mSelectBagItem);
            self:UpdateSynthesis();
        end
    end

    if (not isEquip) then
        if (self.mLastSelectBagItem ~= nil) then
            local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfo(self.mLastSelectBagItem.lid);
            if (equipInfo ~= nil) then
                if (clientTableManager.cfg_synthesisManager:IsCanSynthesis(equipInfo.itemId) == false) then
                    return ;
                end
                self:TrySetSelectBagItem(self.mLastSelectBagItem);
                self:UpdateSynthesis();
            end
        end
    end
    self:SwitchTglState(self:GetTglYinJi_UIToggle(), false);
    self:SwitchTglState(self:GetTglYuanSu_UIToggle(), false);
    self:SwitchTglState(self:GetTglEquip_UIToggle(), true);
end

--endregion

--region Public

function UISynthesisViewTemplate:UpdateView(customData)
    uimanager:ClosePanel("UIBagPanel");

    self.mCustomData = customData;
    if (self.mCustomData == nil) then
        self.mCustomData = {};
    end
    --region 自动放入一件顺位装备
    ---暂时取消
    local isBodyEquip = false;
    local isServantEquip = false;
    local isServantEgg = false;
    local isHMEquip = false;
    local isLXEquip = false;
    local isTCEquip = false;
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        if (self.mCustomData.bagItemInfo ~= nil) then
            isBodyEquip = CS.CSScene.MainPlayerInfo.EquipInfo:IsEquip(self.mCustomData.bagItemInfo.lid);
            isHMEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsServantEquip(luaEnumServantType.HM, self.mCustomData.bagItemInfo.lid);
            isLXEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsServantEquip(luaEnumServantType.LX, self.mCustomData.bagItemInfo.lid);
            isTCEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsServantEquip(luaEnumServantType.TC, self.mCustomData.bagItemInfo.lid);
            isServantEquip = isHMEquip or isLXEquip or isTCEquip;
            isServantEgg = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():IsServantEgg(self.mCustomData.bagItemInfo.lid)
            self:TrySetSelectBagItem(self.mCustomData.bagItemInfo);
        end
    end
    --endregion

    if (self.mCustomData.bagItemInfo == nil) then
        if (self.mCustomData.type == nil) then
            if (gameMgr:GetLuaRedPointManager():GetRedPointState(gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetAllPageButtonRedPointKey())) then
                self.mCustomData.type = LuaEnumSynthesisLeftPanelType.SynthesisList;
            elseif (self:GetTglRole_RedPoint().gameObject.activeSelf) then
                self.mCustomData.type = LuaEnumSynthesisLeftPanelType.Role;
            elseif (self:GetTglServant_RedPoint().gameObject.activeSelf) then
                self.mCustomData.type = LuaEnumSynthesisLeftPanelType.Servant;
            else
                self.mCustomData.type = LuaEnumSynthesisLeftPanelType.SynthesisList;
            end
        end
    else
        local isArtifact = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():IsMagicWeapon(self.mCustomData.bagItemInfo.itemId);
        if (isArtifact) then
            --合成背包删除了，跳转到合成列表
            self.mCustomData.type = LuaEnumSynthesisLeftPanelType.SynthesisList;
            self.mSynthesisUseMaterialType = LuaEnumSynthesisUseMaterialLogicType.OnlyBag
        elseif (isBodyEquip) then
            self.mCustomData.type = LuaEnumSynthesisLeftPanelType.Role;
            self.mSynthesisUseMaterialType = LuaEnumSynthesisUseMaterialLogicType.RoleAndBag
        elseif self:IsEnoughBagItemInBagToSynthesis() then
            --合成背包删除了，跳转到合成列表
            self.mCustomData.type = LuaEnumSynthesisLeftPanelType.SynthesisList;
            self.mSynthesisUseMaterialType = LuaEnumSynthesisUseMaterialLogicType.All
        elseif (isServantEquip or isServantEgg) then
            self.mCustomData.type = LuaEnumSynthesisLeftPanelType.Servant;
            if (isHMEquip) then
                self.mSynthesisUseMaterialType = LuaEnumSynthesisUseMaterialLogicType.HMAndBag
            elseif (isLXEquip) then
                self.mSynthesisUseMaterialType = LuaEnumSynthesisUseMaterialLogicType.LXAndBag
            elseif (isTCEquip) then
                self.mSynthesisUseMaterialType = LuaEnumSynthesisUseMaterialLogicType.TCAndBag
            else
                self.mSynthesisUseMaterialType = LuaEnumSynthesisUseMaterialLogicType.All;
            end
        else
            self.mCustomData.type = LuaEnumSynthesisLeftPanelType.SynthesisList;
            self.mSynthesisUseMaterialType = LuaEnumSynthesisUseMaterialLogicType.All;
        end
    end

    self:TryUpdateLeftPanel(self.mCustomData.type);
    self:UpdateSynthesis();
end

---背包中是否有足够的物品来合成
---@return boolean
function UISynthesisViewTemplate:IsEnoughBagItemInBagToSynthesis()
    if self.mSelectBagItem == nil or CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.BagInfo == nil then
        return false
    end
    local isExistInBag = CS.CSScene.MainPlayerInfo.BagInfo.BagItems:TryGetValue(self.mSelectBagItem.lid)
    if isExistInBag then
        return true
    else
        return false
    end
end

function UISynthesisViewTemplate:TryUpdateLeftPanel(leftPanelType)
    if (self.mLeftPanelType ~= leftPanelType) then
        self.mDelayFrameCount = 5;
        self.mLeftPanelType = leftPanelType;
    end
end

function UISynthesisViewTemplate:UpdateLeftPanel()
    if (self.mLeftPanelName ~= nil) then
        uimanager:ClosePanel(self.mLeftPanelName);
    end
    if (self.mLeftPanelType == LuaEnumSynthesisLeftPanelType.Role) then
        self:UpdateRolePanel();
        self:GetTglRole_UIToggle().value = true;
    elseif (self.mLeftPanelType == LuaEnumSynthesisLeftPanelType.Bag) then
        self:UpdateBagPanel();
        self:GetTglBag_UIToggle().value = true;
    elseif (self.mLeftPanelType == LuaEnumSynthesisLeftPanelType.Servant) then
        self:GetTglServant_UIToggle().value = true;
        self:UpdateServantPanel();
    elseif (self.mLeftPanelType == LuaEnumSynthesisLeftPanelType.SynthesisList) then
        self:GetTglSynthesisList_UIToggle().value = true;
        self:UpdateSynthesisListPanel();
    end
end

function UISynthesisViewTemplate:OnUpdate()
    if (self.mDelayFrameCount ~= nil and self.mDelayFrameCount > 0) then
        self.mDelayFrameCount = self.mDelayFrameCount - 1;
        if (self.mDelayFrameCount <= 0) then
            self:UpdateLeftPanel();
        end
    end

    --if (self.mDelayUpdateSynthesisFrameCount ~= nil and self.mDelayUpdateSynthesisFrameCount > 0) then
    --    self.mDelayUpdateSynthesisFrameCount = self.mDelayUpdateSynthesisFrameCount - 1;
    --    if (self.mDelayUpdateSynthesisFrameCount <= 0) then
    --        self:UpdateSynthesis();
    --    end
    --end
end

function UISynthesisViewTemplate:UpdateBagPanel()
    self.mLeftPanelName = "UIBagPanel";
    uimanager:CreatePanel("UIBagPanel", function(panel)
        self.mBagPanel = panel;
    end, { type = LuaEnumBagType.Synthesis });
end

function UISynthesisViewTemplate:UpdateRolePanel()
    self.mLeftPanelName = "UIRolePanel";

    local cache = nil;

    --region 角色界面第一顺位红点
    if (self.mSelectBagItem == nil) then
        if (self:GetTglRole_RedPoint().gameObject.activeSelf) then
            cache = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetSynthesisRolePanelFirstCache();
            if (cache ~= nil) then
                self:OnRoleEquipGridClick(cache);
            end
        end
    end
    --endregion

    ---@param panel UIRolePanel
    uimanager:CreatePanel("UIRolePanel", function(panel)
        if (not CS.StaticUtility.IsNull(self.go)) then
            panel:ShowCloseButton(false);
            if (cache ~= nil) then
                panel:SetItemChoose(cache);
            elseif (self.mSelectBagItem ~= nil) then
                panel:SetItemChoose(self.mSelectBagItem);
            end
        end
    end, { equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateSynthesis, equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateSynthesis });
end

function UISynthesisViewTemplate:UpdateServantPanel()
    self.mLeftPanelName = "UIServantPanel";
    local customData = {}
    local servantType = 1;

    if (self.mSelectBagItem ~= nil) then
        local isServantEgg = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():IsServantEgg(self.mSelectBagItem.lid);
        if (not isServantEgg) then
            servantType = math.floor(self.mSelectBagItem.index / 1000);
            servantType = servantType > 3 and 3 or servantType;
            servantType = servantType < 1 and 1 or servantType;
        end
    end

    customData.pos = servantType - 1;
    customData.BaseTemplate = luaComponentTemplates.UIServantPanel_Base_Synthesis;
    customData.openServantPanelType = LuaEnumPanelOpenSourceType.BySynthesis;
    customData.topOpenType = LuaEnumServantPanelType.BasePanel;
    customData.ServantHead = luaComponentTemplates.UIServantHeadTemplate_Synthesis;
    uimanager:CreatePanel("UIServantPanel", nil, customData);
end

function UISynthesisViewTemplate:UpdateSynthesisListPanel()
    self.mLeftPanelName = "UISynthesisItemListPanel";
    local isShowRedPoint = self:GetSynthesisListRedPointComponent().gameObject.activeSelf;

    if (self.mCustomData ~= nil and self.mCustomData.subCustomData ~= nil) then
        uimanager:CreatePanel("UISynthesisItemListPanel", nil, self.mCustomData.subCustomData);
        return
    end
    if (isShowRedPoint) then
        if (self.mCustomData.subCustomData ~= nil) then
            uimanager:CreatePanel("UISynthesisItemListPanel", nil, self.mCustomData.subCustomData);
        else
            local customData = {};
            local cache = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetSynthesisListFirstCache();
            if cache then
                customData.firstType = cache.firstType;
                customData.secondType = cache.secondType;
                customData.thirdItemId = cache.thirdItemId;
            end
            uimanager:CreatePanel("UISynthesisItemListPanel", nil, customData);
        end

    else
        uimanager:CreatePanel("UISynthesisItemListPanel");
    end
end

-----尝试刷新合成
--function UISynthesisViewTemplate:TryUpdateSynthesis(frameCount)
--    ---延迟多少帧更新
--    self.mDelayUpdateSynthesisFrameCount = frameCount;
--end

---刷新合成
function UISynthesisViewTemplate:UpdateSynthesis()
    --if(self.mTargetSynthesisTable ~= nil and self.mSelectBagItem ~= nil) then
    --    self:UpdateSynthesisNeedMaterial();
    --    return;
    --end

    if (self.mSelectBagItem ~= nil) then
        local synthesisList = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetSynthesisListByItemId(self.mSelectBagItem.itemId);

        if (synthesisList ~= nil) then
            if (#synthesisList > 0) then
                local list = self:ListChangeTable(synthesisList, self.mSelectBagItem.itemId);
                self:UpdateSynthesisTable(list);
            end
        else
            self:SetChooseTargetUnit(nil);
        end
    else
        self:SetChooseTargetUnit(nil);
    end
end

function UISynthesisViewTemplate:ListChangeTable(list, itemId)
    local cufTable = {}
    ---如果是书页/上古秘籍,那么下一级的合成书籍需要去判定职业
    if (itemId == 6240001 or itemId == 6270001) then
        if list ~= nil then
            ---@param synthesisTbl TABLE.cfg_synthesis
            for i, synthesisTbl in pairs(list) do
                if (synthesisTbl:GetOutputgoods() ~= nil and synthesisTbl:GetOutputgoods() ~= nil and #synthesisTbl:GetOutputgoods().list > 0) then
                    local itemIdTemp = synthesisTbl:GetOutputgoods().list[1];
                    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemIdTemp);
                    if (isFind) then
                        if (itemTable.propertyTendency == Utility.EnumToInt(CS.ECareer.Common) or itemTable.propertyTendency == Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)) then
                            table.insert(cufTable, synthesisTbl)
                        end
                    end
                end
            end
        end
    else
        if list ~= nil then
            for i, v in pairs(list) do
                table.insert(cufTable, v)
            end
        end
    end
    return cufTable
end

---@type table<TABLE.cfg_synthesis> lua合成表集合
function UISynthesisViewTemplate:UpdateSynthesisTable(synthesisTables)
    if (synthesisTables ~= nil and #synthesisTables > 0) then
        local targetUnit;
        for k, v in pairs(self:GetSynthesisTargetUnits(#synthesisTables)) do
            ---@type TABLE.cfg_synthesis
            local synthesisTbl = synthesisTables[k]
            v:UpdateUnit(synthesisTbl);
            if (synthesisTbl:GetOutputgoods() ~= nil and synthesisTbl:GetOutputgoods().list ~= nil and #synthesisTbl:GetOutputgoods().list > 0) then
                local itemId = synthesisTbl:GetOutputgoods().list[1];
                local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
                if (isFind) then
                    if (itemTable.propertyTendency == Utility.EnumToInt(CS.ECareer.Common) or itemTable.propertyTendency == Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)) then
                        if (targetUnit == nil) then
                            targetUnit = v;
                        end
                    end
                end
            end
        end

        if (targetUnit ~= nil) then
            self:SetChooseTargetUnit(targetUnit);
        else
            if (self.mSynthesisTargetUnits ~= nil and #self.mSynthesisTargetUnits > 0) then
                self:SetChooseTargetUnit(self.mSynthesisTargetUnits[1]);
            end
        end
        self:RefreshBoxSingleItems(targetUnit)
    end
end

---如果选中的是宝箱类型,应读取宝箱中的物品展示出来,并隐藏之前的物品
---@private
---@param targetUnit UISynthesisTargetUnitTemplate
function UISynthesisViewTemplate:RefreshBoxSingleItems(targetUnit)
    local selectedBoxItemTbl = nil
    if targetUnit ~= nil and targetUnit:GetSynthesisTable() ~= nil and targetUnit:GetSynthesisTable():GetOutputgoods() ~= nil
            and targetUnit:GetSynthesisTable():GetOutputgoods().list ~= nil
            and #targetUnit:GetSynthesisTable():GetOutputgoods().list == 1 then
        local outputItemID = targetUnit:GetSynthesisTable():GetOutputgoods().list[1]
        if outputItemID ~= nil then
            local outputItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(outputItemID)
            if outputItemTbl ~= nil and outputItemTbl:GetType() == luaEnumItemType.TreasureBox and outputItemTbl:GetAutouse() == 1 then
                selectedBoxItemTbl = outputItemTbl
            end
        end
    end
    if self.mSelectedBoxItemTbl == selectedBoxItemTbl then
        if self.mSelectedBoxItemTbl == nil then
            self:GetBoxItemSign():SetActive(false)
        else
            self:GetOutPutItemRow_Top_UIGridContainer().gameObject:SetActive(false)
            self:GetBoxItemGrids().gameObject:SetActive(true)
        end
        return
    end

    ---@type TABLE.cfg_items
    self.mSelectedBoxItemTbl = selectedBoxItemTbl
    if self.mSelectedBoxItemTbl == nil then
        ---非宝箱,正常显示
        self:GetOutPutItemRow_Top_UIGridContainer().gameObject:SetActive(true)
        self:GetBoxItemGrids().gameObject:SetActive(false)
        self:GetBoxItemSign():SetActive(false)
    else
        ---宝箱,只显示宝箱中的物品
        self:GetOutPutItemRow_Top_UIGridContainer().gameObject:SetActive(false)
        self:GetBoxItemGrids().gameObject:SetActive(true)
        local rewards = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(self.mSelectedBoxItemTbl:GetId())
        local amount = rewards.Count
        self:GetBoxItemGrids().MaxCount = amount
        for i = 1, amount do
            local itemID = rewards[i - 1].itemId
            local go = self:GetBoxItemGrids().controlList[i - 1]
            local template = self:GetBoxItemTemplateForGo(go)
            template:RefreshItemID(itemID)
        end
        self:GetBoxItemGridsScrollView():ResetPosition()
        self:GetBoxItemSign():SetActive(true)
    end
end

---@private
---@param go UnityEngine.GameObject
---@return UISynthesisView_BoxItemTemplate
function UISynthesisViewTemplate:GetBoxItemTemplateForGo(go)
    if self.mBoxItemTemplateDic == nil then
        self.mBoxItemTemplateDic = {}
    end
    local template = self.mBoxItemTemplateDic[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UISynthesisView_BoxItemTemplate, self.mOwnerPanel)
        self.mBoxItemTemplateDic[go] = template
    end
    return template
end

---toggle功能不太好用所以另外使用(toggle本身处于enabled = false 状态)
function UISynthesisViewTemplate:SwitchTglState(toggle, value)
    if (toggle ~= nil) then
        toggle.activeSprite.alpha = value and 1 or 0.1;
    end
end

function UISynthesisViewTemplate:UpdateRightButton()
    --region 角色界面印记元素
    self:GetTglYinJi_UIToggle().gameObject:SetActive(false);
    self:GetTglYuanSu_UIToggle().gameObject:SetActive(false);
    self:GetTglEquip_UIToggle().gameObject:SetActive(false);

    self:SwitchTglState(self:GetTglYinJi_UIToggle(), false);
    self:SwitchTglState(self:GetTglYuanSu_UIToggle(), false);
    self:SwitchTglState(self:GetTglEquip_UIToggle(), false);
    --endregion

    --region 合成列表切换材料取用逻辑
    self:GetChangeMaterialLogic_GameObject():SetActive(false);
    --endregion

    if (self.mLeftPanelType == LuaEnumSynthesisLeftPanelType.Role) then
        --region 角色界面印记元素
        local isEquip = false;
        local equipIndex = nil;
        if (self.mSelectBagItem ~= nil) then
            local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfo(self.mSelectBagItem.lid);
            if (equipInfo ~= nil) then
                isEquip = true;
                equipIndex = equipInfo.index;
                local signetInfo = CS.CSScene.MainPlayerInfo.SignetV2:FindIndexSignetInfo(equipInfo.index);
                if (signetInfo ~= nil) then
                    if (signetInfo.itemInfo ~= nil and clientTableManager.cfg_synthesisManager:IsCanSynthesis(signetInfo.itemInfo.itemId)) then
                        self:GetTglYinJi_UIToggle().gameObject:SetActive(true);
                    end
                end
                local isFind, elementInfo = CS.CSScene.MainPlayerInfo.ElementInfo.Elements:TryGetValue(equipInfo.index);
                if (isFind) then
                    if (elementInfo.bagItemInfo ~= nil and clientTableManager.cfg_synthesisManager:IsCanSynthesis(elementInfo.bagItemInfo.itemId)) then
                        self:GetTglYuanSu_UIToggle().gameObject:SetActive(true);
                    end
                end
                self:GetTglEquip_UIToggle().gameObject:SetActive(self:GetTglYinJi_UIToggle().gameObject.activeSelf or self:GetTglYuanSu_UIToggle().gameObject.activeSelf);
            end
        end
        if (not isEquip) then
            if (self.mLastSelectBagItem ~= nil) then
                local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfo(self.mLastSelectBagItem.lid);
                if (equipInfo ~= nil) then
                    equipIndex = equipInfo.index;
                    local signetInfo = CS.CSScene.MainPlayerInfo.SignetV2:FindIndexSignetInfo(equipInfo.index);
                    if (signetInfo ~= nil) then
                        if (signetInfo.itemInfo ~= nil and clientTableManager.cfg_synthesisManager:IsCanSynthesis(signetInfo.itemInfo.itemId)) then
                            self:GetTglYinJi_UIToggle().gameObject:SetActive(true);
                        end
                    end
                    local isFind, elementInfo = CS.CSScene.MainPlayerInfo.ElementInfo.Elements:TryGetValue(equipInfo.index);
                    if (isFind) then
                        if (elementInfo.bagItemInfo ~= nil and clientTableManager.cfg_synthesisManager:IsCanSynthesis(elementInfo.bagItemInfo.itemId)) then
                            self:GetTglYuanSu_UIToggle().gameObject:SetActive(true);
                        end
                    end
                    self:GetTglEquip_UIToggle().gameObject:SetActive(self:GetTglYinJi_UIToggle().gameObject.activeSelf or self:GetTglYuanSu_UIToggle().gameObject.activeSelf);
                end
            end
        end
        self:UpdateSignetAndElementRedPoint(equipIndex);
        --endregion
    elseif (self.mLeftPanelType == LuaEnumSynthesisLeftPanelType.SynthesisList) then

    end
end

---刷新印記元素按鈕紅點
function UISynthesisViewTemplate:UpdateSignetAndElementRedPoint(equipIndex)
    if (self.mLeftPanelType == LuaEnumSynthesisLeftPanelType.Role) then
        self:GetBtnYuanSuRedPointComponent():RemoveRedPointKey();
        local elementKey = gameMgr:GetLuaRedPointManager():GetSynthesisEquipElementRedPointKey(equipIndex);
        if (elementKey ~= nil) then
            self:GetBtnYuanSuRedPointComponent():AddRedPointKey(elementKey);
        end

        self:GetBtnYinJiRedPointComponent():RemoveRedPointKey()
        local signetKey = gameMgr:GetLuaRedPointManager():GetSynthesisEquipSignetRedPointKey(equipIndex);
        if (signetKey ~= nil) then
            self:GetBtnYinJiRedPointComponent():AddRedPointKey(signetKey);
        end

        if (self:GetTglYinJi_UIToggle().gameObject.activeSelf and self:GetBtnYinJiRedPointComponent().gameObject.activeSelf) then
            self:OnBtnSignetClick();
        elseif (self:GetTglYuanSu_UIToggle().gameObject.activeSelf and self:GetBtnYuanSuRedPointComponent().gameObject.activeSelf) then
            self:OnBtnElementClick();
        else
            if (self.mSelectBagItem ~= nil) then
                if (clientTableManager.cfg_synthesisManager:IsCanSynthesis(self.mSelectBagItem.itemId) == false) then
                    if (self:GetTglYuanSu_UIToggle().gameObject.activeSelf) then
                        self:OnBtnElementClick();
                    elseif (self:GetTglYinJi_UIToggle().gameObject.activeSelf) then
                        self:OnBtnSignetClick();
                    end
                else
                    self:SwitchTglState(self:GetTglEquip_UIToggle(), true);
                end
            else
                self:SwitchTglState(self:GetTglEquip_UIToggle(), true);
            end
        end
    end
end

function UISynthesisViewTemplate:UpdateSynthesisNeedMaterial()
    self:UpdateSynthesisCondition()
    if (self.mNeedMaterialUnitDic == nil) then
        self.mNeedMaterialUnitDic = {};
    end
    --是否在合成列表选中道具
    local IsInSynthesisList = self.mLeftPanelType == LuaEnumSynthesisLeftPanelType.SynthesisList
    --是否存在多种合成的主材料()
    local IsExitMoreSynthesisMainMaterial = self.mSynthesisTables ~= nil and #self.mSynthesisTables > 1

    self:GetBtnChangeMaterial_GameObject():SetActive(IsInSynthesisList and IsExitMoreSynthesisMainMaterial);

    if (self.mTargetSynthesisTable == nil or CS.CSScene.MainPlayerInfo == nil) then
        self:GetCostValue_Text().gameObject:SetActive(false);
        self:GetCostType_UISprite().gameObject:SetActive(false);
        return ;
    end

    local needCostMaterial = self.mTargetSynthesisTable:GetItemid()
    local needCostMaterialCount = self.mTargetSynthesisTable:GetNumber()

    local gridContainer = self:GetNeedMaterials_UIGridContainer();
    self.mCostItemLids = {};
    self.mCostCoinItemIds = {};

    if (needCostMaterial ~= nil and needCostMaterial.list and #needCostMaterial.list > 0) then
        gridContainer.MaxCount = #needCostMaterial.list;

        for i = 0, #needCostMaterial.list - 1 do
            local gobj = gridContainer.controlList[i];
            if (self.mNeedMaterialUnitDic[gobj] == nil) then
                self.mNeedMaterialUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UISynthesisMaterialUnitTemplate, self);
            end
            ---@type UISynthesisMaterialUnitTemplate
            local temp = self.mNeedMaterialUnitDic[gobj]
            temp:UpdateUnit(self.mTargetSynthesisTable, needCostMaterial.list[i + 1], needCostMaterialCount.list[i + 1], i == 0);

            ---i == 0 视为主材料
            if (i == 0) then
                local position = self:GetBtnChangeMaterial_GameObject().transform.position;
                self:GetBtnChangeMaterial_GameObject().transform.position = CS.UnityEngine.Vector3(gobj.transform.position.x, position.y, position.z);
            end
        end
        self:UpdateCostMaterialPosition(needCostMaterial.list)
    else
        gridContainer.MaxCount = 0;
    end
    self:UpdateSynthesisCost();
end

---不满足的合成条件结果
UISynthesisViewTemplate.NotMeetSynthesisConditionResult = nil;

function UISynthesisViewTemplate:UpdateSynthesisCondition()
    self.NotMeetSynthesisConditionResult = nil;
    if (self.mTargetSynthesisTable == nil or self.mTargetSynthesisTable:GetConditionId() == nil) then
        self:GetConditionDescLabel().text = ""
        return
    end
    local conditionList = self.mTargetSynthesisTable:GetConditionId().list;
    --local conditionList = {}
    --table.insert(conditionList, 550145)

    local conditionStr = ""
    for i = 1, #conditionList do
        local id = conditionList[i]
        ---@type LuaMatchConditionResult
        local result = Utility.IsMainPlayerMatchCondition(id)
        if (conditionStr ~= "") then
            conditionStr = conditionStr .. "\r\n"
        end
        if (result.success == true) then
            conditionStr = conditionStr .. "[00ff00]"
        else
            if (self.NotMeetSynthesisConditionResult == nil) then
                self.NotMeetSynthesisConditionResult = result;
            end
            conditionStr = conditionStr .. "[e85038]"
        end
        conditionStr = conditionStr .. result.txt .. "[-]"
    end

    self:GetConditionDescLabel().text = conditionStr;
end

---更新合成材料面板的坐标,在4个以内的时候,合成材料居中,不然向左对齐
function UISynthesisViewTemplate:UpdateCostMaterialPosition(list)
    --合成
    if (self:GetNeedMaterials_UIScrollView() ~= nil and #list > 4) then
        self:GetNeedMaterials_UIScrollView().IsDealy = true
        self:GetNeedMaterials_UIScrollView():Reposition()
    else
        self:GetNeedMaterials_UIScrollView().transform.localPosition = CS.UnityEngine.Vector3(-200, -125, 0)
        self:GetNeedMaterials_UIPanel().clipOffset = CS.UnityEngine.Vector2(0, 0)
    end
end

---添加道具到其他消耗列表中
function UISynthesisViewTemplate:AddBagItemToOtherCostMaterial()

end

function UISynthesisViewTemplate:UpdateSynthesisCost()
    self:GetCostValue_Text().gameObject:SetActive(false);
    self:GetCostType_UISprite().gameObject:SetActive(false);
    if (self.mTargetSynthesisTable ~= nil and self.mTargetSynthesisTable:GetCurrency() ~= nil and #self.mTargetSynthesisTable:GetCurrency().list >= 2) then
        local itemId = self.mTargetSynthesisTable:GetCurrency().list[1];
        local count = self.mTargetSynthesisTable:GetCurrency().list[2];
        local num = tonumber(self:GetCountInput_UIInput().value);
        num = ternary(num == nil, 0, num)
        self:GetCostValue_Text().gameObject:SetActive(true);
        self:GetCostValue_Text().text = count * num;
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
        if (isFind) then
            self:GetCostType_UISprite().gameObject:SetActive(true);
            self:GetCostType_UISprite().spriteName = itemTable.icon;
        end

        ---@type CSMainPlayerInfo
        local mMainPlayerInfo = CS.CSScene.MainPlayerInfo
        if mMainPlayerInfo then
            local playerHas = mMainPlayerInfo.BagInfo:GetCoinAmount(itemId)
            local cost = count * num
            local color = playerHas >= cost and "" or luaEnumColorType.Red
            self:GetCostValue_Text().text = color .. cost
        end

        self:GetCostType_UIWidget():UpdateAnchors()
    end
end

function UISynthesisViewTemplate:UpdateSynthesisCount(count)
    for k, v in pairs(self:GetSynthesisTargetUnits()) do
        v:UpdateSynthesisCount(count);
    end
    if (self.mNeedMaterialUnitDic ~= nil) then
        for k, v in pairs(self.mNeedMaterialUnitDic) do
            v:UpdateSynthesisCount(count);
        end
    end

    self:UpdateSynthesisCost();
end

---@param bagItemInfo bagV2.BagItemInfo
---@returns ELuaSynthesisStateCode 0:可正常合成, 1:此物品不能合成, 2:需求数量不足 3:可合成
function UISynthesisViewTemplate:TrySetSelectBagItem(bagItemInfo)
    if (bagItemInfo ~= nil) then
        ---@type LuaSynthesisMgr
        local SynthesisMgr = gameMgr:GetPlayerDataMgr():GetSynthesisMgr()
        local synthesis = SynthesisMgr:GetSynthesisByItemId(bagItemInfo.itemId)
        ---@type ELuaSynthesisStateCode
        local stateCode = SynthesisMgr:GetSynthesisStateCode(synthesis, bagItemInfo, 1)
        if (stateCode ~= ELuaSynthesisStateCode.NoCan) then
            if (self.mSelectBagItem == nil or self.mSelectBagItem.lid ~= bagItemInfo.lid) then
                self.mSelectBagItem = bagItemInfo;
                luaEventManager.DoCallback(LuaCEvent.Synthesis_OnChangeItem, bagItemInfo);
            end
        end
        return stateCode;
    else
        self.mSelectBagItem = nil;
    end
    return 1;
end

---@param targetUnit UISynthesisTargetUnitTemplate
function UISynthesisViewTemplate:SetChooseTargetUnit(targetUnit)
    self:UpdateRightButton();

    if (targetUnit ~= nil and not CS.StaticUtility.IsNull(targetUnit.go)) then
        if (not CS.StaticUtility.IsNull(self:GetChoose_GameObject())) then
            CS.NGUITools.SetParent(targetUnit.go.transform, self:GetChoose_GameObject().gameObject)
            --self:GetChoose_GameObject().transform.position = targetUnit.go.transform.position;
        end
        if (self.mTargetSynthesisTable == nil or self.mTargetSynthesisTable.id ~= targetUnit:GetSynthesisTable().id) then
            self.mTargetSynthesisTable = targetUnit:GetSynthesisTable();
            local itemIdList = self.mTargetSynthesisTable:GetOutputgoods()
            --local itemIdList = self.mTargetSynthesisTable:GetOutputgoods();
            --if(itemIdList == nil and self.mTargetSynthesisTable.GetOutputgoods ~= nil) then
            --    itemIdList = self.mTargetSynthesisTable:GetOutputgoods();
            --end
            local name = ""
            if (self.mSelectBagItem ~= nil and self.mSelectBagItem.itemId == 6240001) then
                --name = "[FF0000]高级技能书[-]";
                name = targetUnit:GetTargetName();
            else
                if itemIdList.list and #itemIdList.list > 0 then
                    for i, itemId in pairs(itemIdList.list) do
                        local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
                        if res then
                            name = name .. itemInfo.name .. " "
                            self.nowSynthesisItem = itemInfo
                        end
                    end
                end
            end
            self:GetCurrentSynthesisName_Text().text = luaEnumColorType.Gray .. "正在合成[-] " .. name
            local isMultiply = false
            if self.mTargetSynthesisTable ~= nil then
                local luaTbl = clientTableManager.cfg_synthesisManager:TryGetValue(self.mTargetSynthesisTable.id)
                isMultiply = luaTbl:GetNumberChoose() == 1
            end
            if (self.mSelectBagItem ~= nil) then
                if isMultiply then
                    self:GetInputCountParent_GameObject():SetActive(self.mTargetSynthesisTable ~= nil);
                    self:GetCountInput_UIInput().value = self:GetMaxSynthesisCount(true);
                else
                    self:GetInputCountParent_GameObject():SetActive(false);
                    self:GetCountInput_UIInput().value = 1
                end
            else
                if (self.mTargetSynthesisTable ~= nil) then
                    local itemId = nil;
                    if (#self.mTargetSynthesisTable:GetItemid().list > 0) then
                        itemId = self.mTargetSynthesisTable:GetItemid().list[1];
                    end

                    if (itemId ~= nil) then
                        if isMultiply then
                            self:GetInputCountParent_GameObject():SetActive(self.mTargetSynthesisTable ~= nil);
                            self:GetCountInput_UIInput().value = self:GetMaxSynthesisCount(true);
                        else
                            self:GetInputCountParent_GameObject():SetActive(false);
                            self:GetCountInput_UIInput().value = 1
                        end
                    end
                end
            end
        end
        --region 合成列表切换材料取用逻辑
        self:UpdateMaterialLogic();
        --endregion
    else
        self.mTargetSynthesisTable = nil;
        self.nowSynthesisItem = nil
    end
    self:GetNotHasSynthesis_GameObject():SetActive(self.mTargetSynthesisTable == nil);
    self:GetView_GameObject():SetActive(self.mTargetSynthesisTable ~= nil);
    self:GetBtnSynthesis_GameObject():SetActive(self.mTargetSynthesisTable ~= nil);
    self:GetChoose_GameObject():SetActive(self.mTargetSynthesisTable ~= nil);
    if (self.mTargetSynthesisTable ~= nil and self:GetBtnSynthesis_UILabel() ~= nil) then
        self:GetBtnSynthesis_UILabel().text = self.mTargetSynthesisTable:GetSynthesisType() == 2 and '分解' or '合成'
    end
    self:RefreshCurCount()
end

function UISynthesisViewTemplate:GetSynthesisMainBagItemInfo()
    return self.mSelectBagItem;
end

---刷新合成使用主材料的逻辑
function UISynthesisViewTemplate:UpdateMaterialLogic(logicType)
    self:GetChangeMaterialLogic_GameObject():SetActive(false);

    if (CS.CSScene.MainPlayerInfo == nil) then
        return ;
    end
    if (self.mLeftPanelType ~= LuaEnumSynthesisLeftPanelType.SynthesisList) then
        self:GetChangeMaterialLogic_GameObject():SetActive(false);
        if (self.mTargetSynthesisTable ~= nil) then
            self:UpdateSynthesisNeedMaterial();
        end
        return ;
    end

    if (self.mTargetSynthesisTable ~= nil) then
        local mainMaterialId = self:GetMainMaterialId();
        local isBodyEquip = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfoByItemId(mainMaterialId) ~= nil;
        local isHMEquip = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():IsServantEquip(luaEnumServantType.HM, mainMaterialId);
        local isLXEquip = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():IsServantEquip(luaEnumServantType.LX, mainMaterialId);
        local isTCEquip = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():IsServantEquip(luaEnumServantType.TC, mainMaterialId);

        local isShowChangeUseMaterialLogic = (isHMEquip or isLXEquip or isTCEquip);
        self:GetChangeMaterialLogic_GameObject():SetActive(isShowChangeUseMaterialLogic);
        self:GetBtnUseRole_GameObject():SetActive(isBodyEquip);
        self:GetBtnUseHM_GameObject():SetActive(isHMEquip);
        self:GetBtnUseLX_GameObject():SetActive(isLXEquip);
        self:GetBtnUseTC_GameObject():SetActive(isTCEquip);

        local isMagicWeapon = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():IsMagicWeapon(mainMaterialId, self.mTargetSynthesisTable);
        --region 更新按钮位置
        if (isShowChangeUseMaterialLogic) then
            local gobjs = {};
            if (isBodyEquip) then
                if (logicType == nil) then
                    logicType = LuaEnumSynthesisUseMaterialLogicType.RoleAndBag;
                end
                table.insert(gobjs, self:GetBtnUseRole_GameObject());
            end
            if (isHMEquip) then
                if (logicType == nil) then
                    logicType = LuaEnumSynthesisUseMaterialLogicType.HMAndBag;
                end
                table.insert(gobjs, self:GetBtnUseHM_GameObject());
            end
            if (isLXEquip) then
                if (logicType == nil) then
                    logicType = LuaEnumSynthesisUseMaterialLogicType.LXAndBag;
                end
                table.insert(gobjs, self:GetBtnUseLX_GameObject());
            end
            if (isTCEquip) then
                if (logicType == nil) then
                    logicType = LuaEnumSynthesisUseMaterialLogicType.TCAndBag;
                end
                table.insert(gobjs, self:GetBtnUseTC_GameObject());
            end
            local posXs = { -80, -39, -19, -19 };
            local intervalY = 56;
            local startY = -60;
            for k, v in pairs(gobjs) do
                v.transform.localPosition = CS.UnityEngine.Vector3(posXs[k], startY + ((k - 1) * intervalY), 0);
            end
        else
            if (isMagicWeapon) then
                logicType = LuaEnumSynthesisUseMaterialLogicType.OnlyBag;
            elseif (self.mTargetSynthesisTable.synthesisType == 2) then
                ---分解装备只检测背包
                logicType = LuaEnumSynthesisUseMaterialLogicType.OnlyBag;
            else
                logicType = LuaEnumSynthesisUseMaterialLogicType.RoleAndBag;
            end
        end

        --endregion

        if (logicType ~= nil) then
            self.mSynthesisUseMaterialType = logicType;
        end

        self:SwitchTglUseMaterial(self.mSynthesisUseMaterialType);
        self:UpdateSynthesisNeedMaterial();
    end
end

function UISynthesisViewTemplate:SwitchTglUseMaterial(type)
    if (type == LuaEnumSynthesisUseMaterialLogicType.RoleAndBag) then
        self:SwitchTglState(self:GetTglUseRole_UIToggle(), true);
        self:SwitchTglState(self:GetTglUseHM_UIToggle(), false);
        self:SwitchTglState(self:GetTglUseLX_UIToggle(), false);
        self:SwitchTglState(self:GetTglUseTC_UIToggle(), false);

    elseif (type == LuaEnumSynthesisUseMaterialLogicType.HMAndBag) then
        self:SwitchTglState(self:GetTglUseRole_UIToggle(), false);
        self:SwitchTglState(self:GetTglUseHM_UIToggle(), true);
        self:SwitchTglState(self:GetTglUseLX_UIToggle(), false);
        self:SwitchTglState(self:GetTglUseTC_UIToggle(), false);

    elseif (type == LuaEnumSynthesisUseMaterialLogicType.LXAndBag) then
        self:SwitchTglState(self:GetTglUseRole_UIToggle(), false);
        self:SwitchTglState(self:GetTglUseHM_UIToggle(), false);
        self:SwitchTglState(self:GetTglUseLX_UIToggle(), true);
        self:SwitchTglState(self:GetTglUseTC_UIToggle(), false);

    elseif (type == LuaEnumSynthesisUseMaterialLogicType.TCAndBag) then
        self:SwitchTglState(self:GetTglUseRole_UIToggle(), false);
        self:SwitchTglState(self:GetTglUseHM_UIToggle(), false);
        self:SwitchTglState(self:GetTglUseLX_UIToggle(), false);
        self:SwitchTglState(self:GetTglUseTC_UIToggle(), true);
    end
end

function UISynthesisViewTemplate:RefreshCurCount()
    local txt = ""
    if self.mTargetSynthesisTable ~= nil then
        local targetCount = self.mTargetSynthesisTable:GetNumberLimit()
        if targetCount ~= nil and targetCount ~= 0 then
            local synthesCount = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetSynthesCount(self.mTargetSynthesisTable.id)
            local curCount = targetCount - synthesCount
            local strFormat = luaEnumColorType.Gray .. "今日剩余可合成次数%s次"
            local color = curCount == 0 and luaEnumColorType.Red or luaEnumColorType.Green
            txt = string.format(strFormat, color .. curCount .. '[-]')
        end
    end
    self:GetCurrentSynthesisCount_Text().text = txt
end

--endregion

--region Private

---播放成功特效
function UISynthesisViewTemplate:IEnumPlaySuccessEffect(bagItemInfo)
    if bagItemInfo == nil or self:GetSingleSynthesisTargetUnit() == nil then
        return
    end

    local effectPanel = uimanager:GetPanel("UIEffectPanel");
    if effectPanel then
        effectPanel:PlayEffect("700008", 125, self:GetSingleSynthesisTargetUnit().go.transform.position);

    end
end

---从合成面板飞向目标位置特效
function UISynthesisViewTemplate:FromSynthesisPanelToAimPanel(gobj, effectPanel, fromPos, wordPosition)
    local tweenPosition = CS.Utility_Lua.GetComponent(gobj, "TweenPosition");
    if (tweenPosition == nil) then
        tweenPosition = gobj:AddComponent(typeof(CS.TweenPosition));
        tweenPosition.enabled = false;
        tweenPosition.duration = 1;
    end
    tweenPosition:SetOnFinished(function()
        effectPanel:PlayEffect("700089", 1, wordPosition);
        effectPanel:CloseEffect("700088");
        tweenPosition:SetOnFinished(nil);
        if (self.mCustomData.synthesisSuccessClosePanel) then
            uimanager:ClosePanel("UISynthesisPanel");
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM)
        end
    end);

    tweenPosition.from = effectPanel:GetLocalPosition(fromPos);
    tweenPosition.to = effectPanel:GetLocalPosition(wordPosition);
    tweenPosition:PlayTween();
end

function UISynthesisViewTemplate:OpenItemTip(bagItemInfo)
    if (bagItemInfo == nil) then
        return ;
    end
    --打开物品信息界面
    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId)
    if (isFind) then
        if not uimanager:GetPanel("UIItemInfoPanel") and not uimanager:GetPanel("UIPetInfoPanel") then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItemInfo, showAssistPanel = true, showRight = true })
        end
        if uimanager:GetPanel("UISkillPanel") and itemTable.type == luaEnumItemType.SkillBook then
            if luaEventManager.HasCallback(LuaCEvent.ItemInfoPanel_SkillUseBtnClick) then
                luaEventManager.DoCallback(LuaCEvent.ItemInfoPanel_SkillUseBtnClick, bagItemInfo)
            end
        end
    end
end

function UISynthesisViewTemplate:TryCreateLevelDeficiencyTip(callBack)

    if self.nowSynthesisItem == nil then
        return false
    end
    local isCanUse = true

    if (CS.CSScene.MainPlayerInfo == nil) then
        return false;
    end

    if (self.nowSynthesisItem.type == luaEnumItemType.Signet) then
        isCanUse = CS.CSScene.MainPlayerInfo.SignetV2:IsCanUseSignet(self.nowSynthesisItem);
    elseif (self.nowSynthesisItem.type == luaEnumItemType.Element) then
        isCanUse = CS.CSScene.MainPlayerInfo.ElementInfo:IsCanInlayByEquip(self.nowSynthesisItem);
    elseif (clientTableManager.cfg_itemsManager:IsOfficialSealEquip(self.nowSynthesisItem.id)) then
        --官印，要比当前官阶低
        isCanUse = self:GetOfficialSealCanUse()
    else
        isCanUse = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(self.nowSynthesisItem.id) == LuaEnumUseItemParam.CanUse
    end

    --if self.nowSynthesisItem.reinLv == 0 then
    --    if CS.CSScene.MainPlayerInfo.Level < self.nowSynthesisItem.useLv then
    --        isCanUse = false
    --    end
    --else
    --    if CS.CSScene.MainPlayerInfo.ReinLevel < self.nowSynthesisItem.reinLv then
    --        isCanUse = false
    --    end
    --end

    ---检查宝物是否可以使用
    ---@type CSEquipInfoV2
    local mainPlayerEquipInfo = CS.CSScene.MainPlayerInfo.EquipInfo
    ---@type CSBagInfoV2
    local mainPlayerBagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    if mainPlayerEquipInfo:IsGem(self.nowSynthesisItem) then
        if mainPlayerEquipInfo:IsMedal(self.nowSynthesisItem) or mainPlayerEquipInfo:IsDoubelMedal(self.nowSynthesisItem) then
            if mainPlayerEquipInfo:MedalIsCanEquiped(self.nowSynthesisItem) == false then
                ---不可装备的勋章
                isCanUse = false
            end
        else
            if mainPlayerBagInfo:GemIsCanEquiped(self.nowSynthesisItem) == false then
                ---不可装备的宝物
                isCanUse = false
            end
        end
    end

    if (self.mSelectBagItem ~= nil) then
        if (CS.CSScene.MainPlayerInfo.ServantInfoV2:IsServantEquip(self.mSelectBagItem.lid)) then
            local servantPanel = uimanager:GetPanel("UIServantPanel");
            if (servantPanel ~= nil) then
                local servantTemplate = servantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel]
                if not self:IsServantItemTableCanEquip(self.nowSynthesisItem.id, servantTemplate) then
                    isCanUse = false;
                end
            end
        end
    end

    if isCanUse == false then
        if (self.mCoroutineCreateTip ~= nil) then
            StopCoroutine(self.mCoroutineCreateTip);
            self.mCoroutineCreateTip = nil;
        end
        self.mCoroutineCreateTip = StartCoroutine(self.CCreatLevelDeficiencyTip, self, callBack)
        return true
    end
    return false
end

function UISynthesisViewTemplate:GetOfficialSealCanUse()
    local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(self.nowSynthesisItem.id)
    if luaItemInfo ~= nil then
        local conditions = luaItemInfo:GetConditions()
        if conditions and conditions.list and #conditions.list > 0 then
            local str = ""
            for i = 1, #conditions.list do
                local id = conditions.list[i]
                local conditionInfo = clientTableManager.cfg_conditionsManager:TryGetValue(id)
                if conditionInfo then
                    ---@type LuaMatchConditionResult
                    local result = Utility.IsMainPlayerMatchCondition(id)
                    if result.success == false then
                        return false
                    end
                end
            end
        end
    end
    return true
end

function UISynthesisViewTemplate:CCreatLevelDeficiencyTip(callBack)
    coroutine.yield(0);
    coroutine.yield(0);
    coroutine.yield(0);
    coroutine.yield(0);
    local isFind, promptInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(119)
    if isFind then
        local temp = {}
        temp.Content = promptInfo.des
        temp.Title = promptInfo.title
        temp.LeftDescription = promptInfo.leftButton
        temp.RightDescription = promptInfo.rightButton
        temp.CallBack = callBack
        temp.ID = 119
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end

function UISynthesisViewTemplate:GetMinSynthesisCount()
    return 1;
end

---@param JustShowOne boolean 只显示一个
function UISynthesisViewTemplate:GetMaxSynthesisCount(JustShowOne)
    if (JustShowOne) then
        return 1;
    end
    if (self.mTargetSynthesisTable ~= nil and CS.CSScene.MainPlayerInfo ~= nil) then
        ---@type LuaSynthesis_Item
        local Synthesis_Item = clientTableManager.cfg_synthesisManager.AllSynthesisDic[self.mTargetSynthesisTable:GetId()]
        local maxSynthesisCount = Synthesis_Item:GetMaxSynthesisCount()
        maxSynthesisCount = maxSynthesisCount <= 0 and 1 or maxSynthesisCount;
        return maxSynthesisCount;
    end
    return 1;
end

function UISynthesisViewTemplate:GetOutItemIdList()
    if (self.mTargetSynthesisTable ~= nil) then
        if (self.mTargetSynthesisTable:GetOutputgoods() ~= nil and #self.mTargetSynthesisTable:GetOutputgoods().list > 0) then
            return self.mTargetSynthesisTable:GetOutputgoods().list;
        end
    end
    return nil;
end

---获得主材料id, 材料列表第一位为主材料
function UISynthesisViewTemplate:GetMainMaterialId()
    if (self.mTargetSynthesisTable ~= nil) then
        if (self.mTargetSynthesisTable:GetItemid() ~= nil and #self.mTargetSynthesisTable:GetItemid().list > 0) then
            return self.mTargetSynthesisTable:GetItemid().list[1];
        end
    end
    return nil;
end

function UISynthesisViewTemplate:InitEvents()

    self.CallOnUIInputValueChanged = function()
        self:UpdateSynthesisCount(tonumber(self:GetCountInput_UIInput().value));
    end

    CS.EventDelegate.Add(self:GetCountInput_UIInput().onChange, self.CallOnUIInputValueChanged);

    CS.UIEventListener.Get(self:GetBtnAdd_GameObject()).onClick = function()
        local count = tonumber(self:GetCountInput_UIInput().value);
        if count == nil then
            count = 1
        end
        count = count + 1;
        local maxCount = self:GetMaxSynthesisCount();
        if (count > maxCount) then
            count = self:GetMinSynthesisCount();
        end
        self:GetCountInput_UIInput().value = count;
    end

    CS.UIEventListener.Get(self:GetBtnLess_GameObject()).onClick = function()
        local count = tonumber(self:GetCountInput_UIInput().value);
        if count == nil then
            count = 2
        end
        count = count - 1;
        if (count <= 0) then
            count = self:GetMaxSynthesisCount();
        end
        self:GetCountInput_UIInput().value = count;
    end

    CS.UIEventListener.Get(self:GetBtnSynthesis_GameObject()).onClick = function()
        self:OnBtnSynthesisClick()
    end

    CS.UIEventListener.Get(self:GetTglRole_UIToggle().gameObject).onClick = function()
        self:TryUpdateLeftPanel(LuaEnumSynthesisLeftPanelType.Role);
    end

    CS.UIEventListener.Get(self:GetTglBag_UIToggle().gameObject).onClick = function()
        self:TryUpdateLeftPanel(LuaEnumSynthesisLeftPanelType.Bag);
    end

    CS.UIEventListener.Get(self:GetTglServant_UIToggle().gameObject).onClick = function()
        self:TryUpdateLeftPanel(LuaEnumSynthesisLeftPanelType.Servant);
    end

    CS.UIEventListener.Get(self:GetTglSynthesisList_UIToggle().gameObject).onClick = function()
        self:TryUpdateLeftPanel(LuaEnumSynthesisLeftPanelType.SynthesisList);
    end

    CS.UIEventListener.Get(self:GetTglYinJi_UIToggle().gameObject).onClick = function()
        self:OnBtnSignetClick();
    end

    CS.UIEventListener.Get(self:GetTglYuanSu_UIToggle().gameObject).onClick = function()
        self:OnBtnElementClick();
    end

    CS.UIEventListener.Get(self:GetTglEquip_UIToggle().gameObject).onClick = function()
        self:OnBtnEquipClick();
    end

    CS.UIEventListener.Get(self:GetBtnChangeMaterial_GameObject()).onClick = function()
        if (self.mSynthesisTables ~= nil and #self.mSynthesisTables > 0) then
            self:GetArrow_Tween():PlayReverse()
            uimanager:CreatePanel("UISynthesisTargetChoosePanel", nil, { synthesisTables = self.mSynthesisTables, CloseCallBack = function()
                self:GetArrow_Tween():PlayForward()
            end });
        end
    end

    CS.UIEventListener.Get(self:GetBtnUseRole_GameObject()).onClick = function()
        self:OnBtnUseRoleClick();
    end

    CS.UIEventListener.Get(self:GetBtnUseHM_GameObject()).onClick = function()
        self:OnBtnUseHMClick();
    end

    CS.UIEventListener.Get(self:GetBtnUseLX_GameObject()).onClick = function()
        self:OnBtnUseLXClick();
    end

    CS.UIEventListener.Get(self:GetBtnUseTC_GameObject()).onClick = function()
        self:OnBtnUseTCClick();
    end

    self.CallOnBagSingleClick = function(msgId, msgData)
        self:OnBagSingleClick(msgData);
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Synthesis_OnBagItemClicked, self.CallOnBagSingleClick)

    self.CallOnServantHeadClick = function(msgId, msgData)
        self:OnServantHeadClick(msgData);
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Synthesis_OnServantHeadClicked, self.CallOnServantHeadClick)

    self.CallOnResBagChangeMessage = function(msgId, msgData)
        if (self.mSelectBagItem ~= nil) then
            self:UpdateSynthesis();
        else
            if (self.mTargetSynthesisTable ~= nil) then
                local target = {};
                table.insert(target, self.mTargetSynthesisTable);
                self:UpdateSynthesisTable(target);
            end
        end
    end
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, self.CallOnResBagChangeMessage);
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEquipChangeMessage, self.CallOnResBagChangeMessage);

    self.CallOnResSynthesisMessage = function(msgId, msgData, csData)
        self:OnResSynthesisMessage(msgId, msgData);
        CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.Synthesis_HasRolePanelRedPoint);
        CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.Synthesis_HasServantPanelRedPoint)
    end
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSynthesisMessage, self.CallOnResSynthesisMessage);

    self.CallOnBagBtnClicked = function(msgId, msgData)
        --self:TryUpdateLeftPanel(LuaEnumSynthesisLeftPanelType.Bag);
        uimanager:ClosePanel("UISynthesisPanel");
        uimanager:CreatePanel("UIBagPanel");
    end
    ---因为角色面板绑定的此事件跟本界面的事件会冲突所以先移除， 再添加
    luaEventManager.ClearCallback(LuaCEvent.MainChatPanel_BtnBag);
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, self.CallOnBagBtnClicked);

    self.CallOnSelectSynthesisTarget = function(msgId, msgData)
        if (self.mTargetSynthesisTable ~= nil and self.mTargetSynthesisTable.id == msgData:GetSynthesisTable().id) then
            msgData:ShowItemInfo(false);
        else
            self:SetChooseTargetUnit(msgData);
        end
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Synthesis_OnSelectSynthesisTarget, self.CallOnSelectSynthesisTarget);

    self.CallOnRoleEquipGridClicked = function(msgId, msgData)
        if (msgData ~= nil and msgData.bagItemInfo ~= nil) then
            --self:UpdateSignetAndElementRedPoint(msgData.bagItemInfo.index);
            self:OnRoleEquipGridClick(msgData.bagItemInfo)
        end
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_EquipGridClicked, self.CallOnRoleEquipGridClicked);

    self.CallOnServantOnEquipSynthesisClick = function(msgId, msgData)
        if (msgData ~= nil) then
            local servantType = math.floor(msgData.index / 1000);
            if (servantType == luaEnumServantType.HM) then
                self.mSynthesisUseMaterialType = LuaEnumSynthesisUseMaterialLogicType.HMAndBag;
            elseif (servantType == luaEnumServantType.LX) then
                self.mSynthesisUseMaterialType = LuaEnumSynthesisUseMaterialLogicType.LXAndBag;
            elseif (servantType == luaEnumServantType.TC) then
                self.mSynthesisUseMaterialType = LuaEnumSynthesisUseMaterialLogicType.TCAndBag;
            end
            if (self:TrySetSelectBagItem(msgData) ~= 1) then
                self:UpdateSynthesis();
            end
        end
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Servant_OnEquipSynthesisClick, self.CallOnServantOnEquipSynthesisClick);

    self.CallOnSynthesisListTargetClick = function(msgId, msgData)
        self.mSynthesisTables = {};
        if (msgData ~= nil) then
            self.mSynthesisTables = msgData;
            if (msgData ~= nil and #msgData > 0) then
                local target = {};
                for i = 1, #msgData do
                    ---@type LuaSynthesis_Item
                    local synthesisData = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetSynthesisDataBySynthesisId(msgData[i].id)
                    if (synthesisData:IsCanSynthesis() or i == 1) then
                        target = {}
                        table.insert(target, synthesisData.synthesisTable);
                    end
                end

                ---@param a TABLE.cfg_synthesis
                ---@param b TABLE.cfg_synthesis
                table.sort(self.mSynthesisTables, function(a, b)
                    local aMainMaterialCount = 0;
                    if (a:GetItemid() ~= nil and a:GetItemid().list ~= nil and #a:GetItemid().list > 0) then
                        local mainMaterialId = a:GetItemid().list[1];
                        aMainMaterialCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndMoneyCount(mainMaterialId);
                    end

                    local bMainMaterialCount = 0;
                    if (b:GetItemid() ~= nil and b:GetItemid().list ~= nil and #b:GetItemid().list > 0) then
                        local mainMaterialId = b:GetItemid().list[1];
                        bMainMaterialCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndMoneyCount(mainMaterialId);
                    end

                    return aMainMaterialCount > bMainMaterialCount;
                end)

                self.mSelectBagItem = nil;
                self.mLastSelectBagItem = nil;
                self:UpdateSynthesisTable(target);
            end
        end
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Synthesis_OnSynthesisListTargetClick, self.CallOnSynthesisListTargetClick);

    self.CallOnSynthesisTargetChoose = function(msgId, msgData)
        if (msgData ~= nil) then
            self:UpdateSynthesisTable({ msgData });
        end
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Synthesis_OnSynthesisTargetChoose, self.CallOnSynthesisTargetChoose);

end

function UISynthesisViewTemplate:InitRedPoint()
    ---角色印记红点
    Utility.RegisterRedPoint(self:GetTglRole_RedPoint(), gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipSignet));
    ---角色元素红点
    Utility.RegisterRedPoint(self:GetTglRole_RedPoint(), gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipElement))

    ---合成列表红点
    local key = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetAllPageButtonRedPointKey()
    Utility.RegisterRedPoint(self:GetSynthesisListRedPointComponent(), key);
end

function UISynthesisViewTemplate:RemoveEvents()
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Synthesis_OnBagItemClicked, self.CallOnBagSingleClick);
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.MainChatPanel_BtnBag, self.CallOnBagBtnClicked);
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Synthesis_OnSelectSynthesisTarget, self.CallOnSelectSynthesisTarget);
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Role_EquipGridClicked, self.CallOnRoleEquipGridClicked);
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Servant_OnEquipSynthesisClick, self.CallOnServantOnEquipSynthesisClick);

    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResBagChangeMessage, self.CallOnResBagChangeMessage);
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResSynthesisMessage, self.CallOnResSynthesisMessage);

    local effectPanel = uimanager:GetPanel("UIEffectPanel");
    if (effectPanel ~= nil) then
        effectPanel:CloseEffect("700087");
        effectPanel:CloseEffect("700088");
        effectPanel:CloseEffect("700089");
    end

    if (self.mCoroutinePlayEffect ~= nil) then
        StopCoroutine(self.mCoroutinePlayEffect);
        self.mCoroutinePlayEffect = nil;
    end

    if (self.mCoroutineCreateTip ~= nil) then
        StopCoroutine(self.mCoroutineCreateTip);
        self.mCoroutineCreateTip = nil;
    end

    if (self.mCoroutineChangeToSignetOrElement ~= nil) then
        StopCoroutine(self.mCoroutineChangeToSignetOrElement);
        self.mCoroutineChangeToSignetOrElement = nil;
    end
end

function UISynthesisViewTemplate:Clear()
    self.mEffectDic = nil;
end

--endregion

--region 获取数据
---@return CSMainPlayerInfo
function UISynthesisViewTemplate:GetPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSServantInfoV2
function UISynthesisViewTemplate:GetServantInfo()
    if self.mServantInfoV2 == nil and self:GetPlayerInfo() then
        self.mServantInfoV2 = self:GetPlayerInfo().ServantInfoV2
    end
    return self.mServantInfoV2
end

---@return boolean 获取道具是否可装备
---@param bagItemInfo bagV2.BagItemInfo
function UISynthesisViewTemplate:IsItemCanEquip(bagItemInfo)
    return clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(bagItemInfo.itemId) == LuaEnumUseItemParam.CanUse
    --local mainPlayerInfo = self:GetPlayerInfo()
    --local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
    --if mainPlayerInfo and res then
    --    if itemInfo.reinLv > 0 then
    --        return mainPlayerInfo.ReinLevel >= itemInfo.reinLv
    --    else
    --        return mainPlayerInfo.Level >= itemInfo.useLv
    --    end
    --end
    --return false
end

---@return boolean 获去灵兽道具是否可装备
---@param bagItemInfo bagV2.BagItemInfo
---@param servantTemplate UIServantPanel_Base_Synthesis
function UISynthesisViewTemplate:IsServantItemCanEquip(bagItemInfo, servantTemplate)
    return self:IsServantItemTableCanEquip(bagItemInfo.itemId, servantTemplate);
end

function UISynthesisViewTemplate:IsServantItemTableCanEquip(itemId, servantTemplate)
    local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
    if res then
        if self:GetServantInfo() then
            local resServant, servantInfo = self:GetServantInfo().Servants:TryGetValue(servantTemplate.ServantSeatType)
            if resServant then
                return clientTableManager.cfg_itemsManager:CanUseItem(itemInfo.id, servantInfo.level, servantInfo.rein) == LuaEnumUseItemParam.CanUse
                --if itemInfo.reinLv > 0 then
                --    return servantInfo.rein >= itemInfo.reinLv
                --else
                --    return servantInfo.level >= itemInfo.useLv
                --end
            end
        end
    end
    return false
end

---@return UnityEngine.Vector3 背包位置
function UISynthesisViewTemplate:GetBagPos()
    if self.mBagPos == nil then
        local mainChatPanel = uimanager:GetPanel("UIMainChatPanel")
        if mainChatPanel then
            self.mBagPos = mainChatPanel.btn_bag.transform.position
        end
    end
    return self.mBagPos
end
--endregion

function UISynthesisViewTemplate:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel
    self:InitEvents();
    self:InitRedPoint()
end

function UISynthesisViewTemplate:OnDestroy()
    --uimanager:ClosePanel("UIBagPanel");
    self:RemoveEvents();
    self:Clear();

end

return UISynthesisViewTemplate;