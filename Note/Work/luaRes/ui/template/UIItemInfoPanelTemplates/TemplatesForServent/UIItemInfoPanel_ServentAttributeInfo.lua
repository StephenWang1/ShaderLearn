---@type 物品信息界面信息
local UIItemInfoPanel_ServentAttributeInfo = {}

setmetatable(UIItemInfoPanel_ServentAttributeInfo, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 自定义变量
---浮动颜色
UIItemInfoPanel_ServentAttributeInfo.rateColor = "[39ce1b]"
---属性名字颜色
UIItemInfoPanel_ServentAttributeInfo.attributeNameColor = ""
---属性图参数值
UIItemInfoPanel_ServentAttributeInfo.attributeTable = {}
---基础属性显示内容
UIItemInfoPanel_ServentAttributeInfo.baseAttributeTable = {}
--endregion

--region 组件
---标题文本
---@return UILabel
function UIItemInfoPanel_ServentAttributeInfo:GetTitleLabel_UILabel()
    if self.mTitleLabel_UILabel == nil then
        self.mTitleLabel_UILabel = self:Get("title", "UILabel")
    end
    return self.mTitleLabel_UILabel
end

---属性名文本
---@return UILabel
function UIItemInfoPanel_ServentAttributeInfo:GetAttributeNameLabel_UILabel()
    if self.mAttributeNameLabel_UILabel == nil then
        self.mAttributeNameLabel_UILabel = self:Get("AttrName", "UILabel")
    end
    return self.mAttributeNameLabel_UILabel
end

---属性值文本
---@return UILabel
function UIItemInfoPanel_ServentAttributeInfo:GetAttributeValueLabel_UILabel()
    if self.mAttributeValueLabel_UILabel == nil then
        self.mAttributeValueLabel_UILabel = self:Get("AttrValue", "UILabel")
    end
    return self.mAttributeValueLabel_UILabel
end

---属性箭头集合
---@return UIGridContainer
function UIItemInfoPanel_ServentAttributeInfo:GetAttributeArrow_UIGridContainer()
    if self.mAttributeArrow_UIGridContainer == nil then
        self.mAttributeArrow_UIGridContainer = self:Get("AttrArrow", "UIGridContainer")
    end
    return self.mAttributeArrow_UIGridContainer
end

---强化属性集合
---@return UIGridContainer
function UIItemInfoPanel_ServentAttributeInfo:GetAttrIntensify_UIGridContainer()
    if self.mAttrIntensify_UIGridContainer == nil then
        self.mAttrIntensify_UIGridContainer = self:Get("AttrIntensify", "UIGridContainer")
    end
    return self.mAttrIntensify_UIGridContainer
end

---属性图形面板
---@return UIGridContainer
function UIItemInfoPanel_ServentAttributeInfo:GetAttributeBackGround_GameObject()
    if self.mAttributeBackGround_GameObject == nil then
        self.mAttributeBackGround_GameObject = self:Get("attributebackground", "GameObject")
        self:GetAttributeValue_GameObject()
    end
    return self.mAttributeBackGround_GameObject
end

---设置属性脚本
function UIItemInfoPanel_ServentAttributeInfo:GetAttributeValue_SixStarGraph()
    if self.mGetAttributeValue_SixStarGraph == nil or CS.StaticUtility.IsNull(self.mGetAttributeValue_SixStarGraph) == true then
        self.mGetAttributeValue_SixStarGraph = self:Get("attributebackground/value", "SixStarGraph")
    end
    return self.mGetAttributeValue_SixStarGraph
end

function UIItemInfoPanel_ServentAttributeInfo:GetAttributeValue_GameObject()
    if self.mGetAttributeValue_GameObject == nil then
        self.mGetAttributeValue_GameObject = self:Get("attributebackground/value", "GameObject")
        local effectRenderQueue = self.mGetAttributeValue_GameObject.gameObject:AddComponent(typeof(CS.Top_CSEffectRenderQueue))
        effectRenderQueue:EffectBindMaterial()
    end
    return self.mGetAttributeValue_GameObject
end

---基础属性集合
---@return UIGridContainer
function UIItemInfoPanel_ServentAttributeInfo:GetBaseAttr_UIGridContainer()
    if self.mBaseAttr_UIGridContainer == nil then
        self.mBaseAttr_UIGridContainer = self:Get("Attr", "UIGridContainer")
    end
    return self.mBaseAttr_UIGridContainer
end

--endregion

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_ServentAttributeInfo:RefreshWithInfo(commonData)
    if self.go == nil or CS.StaticUtility.IsNull(self.go) == true then
        return
    end
    self:ClearAttributeData()
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    local compareBagItemInfo = commonData.compareBagItemInfo
    local compareItemInfo = commonData.compareItemInfo
    if commonData.career ~= nil and type(commonData.career) ~= 'number' then
        self.career = Utility.EnumToInt(commonData.career)
    else
        self.career = commonData.career
    end
    if itemInfo ~= nil then
        self:RefreshAttributes(bagItemInfo, itemInfo,compareBagItemInfo,compareItemInfo)
    end
    self:ShowAttribute(itemInfo)
end

---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
---@param compareBagItemInfo bagV2.BagItemInfo
function UIItemInfoPanel_ServentAttributeInfo:RefreshAttributes(bagItemInfo, itemInfo,compareBagItemInfo,compareItemInfo)
    local isCarryServant = false
    if self:GetAttributeBackGround_GameObject() and CS.StaticUtility.IsNull(self:GetAttributeBackGround_GameObject()) == false then
        self:GetAttributeBackGround_GameObject():SetActive(false)
    end
    if bagItemInfo then
        isCarryServant = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsCarryServant(bagItemInfo.lid)
        self.showBagItemInfo = bagItemInfo
    end
    ---传入的灵兽信息
    if itemInfo then
        ___, self.serventInfoTable = CS.Cfg_ServantTableManager.Instance:TryGetValue(itemInfo.useParam.list[0])
    end
    if itemInfo then
        self.isCarryServantInfo = nil
        ---做比较的灵兽信息
        if compareBagItemInfo ~= nil then
            self.isCarryServantInfo = compareBagItemInfo
        else
            if isCarryServant == false then
                local serventIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetEmptyServentCfgId(itemInfo.useParam.list[0])
                if serventIndex ~= 0 then
                    self.isCarryServantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServentIndexByDic(serventIndex).servantEgg
                    if self.isCarryServantInfo ~= nil then
                        self.isCarryserventInfoItemTable = CS.Cfg_ItemsTableManager.Instance:GetItems(self.isCarryServantInfo.itemId)
                        if self.isCarryserventInfoItemTable ~= nil then
                            ___, self.isCarryserventInfoServentTable = CS.Cfg_ServantTableManager.Instance:TryGetValue(self.isCarryserventInfoItemTable.useParam.list[0])
                        end
                    end
                end
            end
        end
    end
    self.compareBagItemInfo = compareBagItemInfo
    self.luaHuanshouTbl = clientTableManager.cfg_huanshouManager:TryGetValue(self.serventInfoTable.id)
    if compareBagItemInfo ~= nil then
        self.luaCompareItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(compareBagItemInfo.itemId)
    end
    ---@type TABLE.cfg_huanshou
    self.luaCompareHuanShouTbl = nil
    if self.luaCompareItemTbl ~= nil then
        self.luaCompareHuanShouTbl = clientTableManager.cfg_huanshouManager:TryGetValue(self.luaCompareItemTbl:GetUseParam().list[0])
    end

    if itemInfo then
        --region 私服基础属性刷新
        self:SiFuServantAttributeAdd()
        --endregion

        --region 老的基础属性刷新
        --self:NormalServantAttributeAdd()
        --endregion
    end
end

---私服灵兽基础属性刷新
function UIItemInfoPanel_ServentAttributeInfo:SiFuServantAttributeAdd()
    ---@type ServantAttribute
    local curServantAttribute = nil
    ---@type ServantAttribute
    local compareServantAttribute = nil
    --region 物理攻击
    if self.career == LuaEnumCareer.Warrior then
        curServantAttribute = {}
        curServantAttribute.minAttributeValue = self.luaHuanshouTbl:GetPhyAttackMin()
        curServantAttribute.maxAttributeValue = self.luaHuanshouTbl:GetPhyAttackMax()
        curServantAttribute.rateMinAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.PhyAttackMin, curServantAttribute.minAttributeValue)
        curServantAttribute.rateMaxAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.PhyAttackMax, curServantAttribute.maxAttributeValue)
        curServantAttribute.attributeName = Utility.GetAttributeName(LuaEnumAttributeType.PhyAttackMax)

        compareServantAttribute = nil
        if self.luaCompareHuanShouTbl ~= nil then
            compareServantAttribute = {}
            compareServantAttribute.minAttributeValue = self.luaCompareHuanShouTbl:GetPhyAttackMin()
            compareServantAttribute.maxAttributeValue = self.luaCompareHuanShouTbl:GetPhyAttackMax()
            compareServantAttribute.rateMinAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.PhyAttackMin,compareServantAttribute.minAttributeValue)
            compareServantAttribute.rateMaxAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.PhyAttackMax,compareServantAttribute.maxAttributeValue)
        end

        self:AddBaseAttribute(curServantAttribute,compareServantAttribute)
    end
    --endregion

    --region 魔法攻击
    if self.career == LuaEnumCareer.Master then
        curServantAttribute = {}
        curServantAttribute.minAttributeValue = self.luaHuanshouTbl:GetMagicAttackMin()
        curServantAttribute.maxAttributeValue = self.luaHuanshouTbl:GetMagicAttackMax()
        curServantAttribute.rateMinAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.MagicAttackMin, curServantAttribute.minAttributeValue)
        curServantAttribute.rateMaxAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.MagicAttackMax, curServantAttribute.maxAttributeValue)
        curServantAttribute.attributeName = Utility.GetAttributeName(LuaEnumAttributeType.MagicAttackMax)

        compareServantAttribute = nil
        if self.luaCompareHuanShouTbl ~= nil then
            compareServantAttribute = {}
            compareServantAttribute.minAttributeValue = self.luaCompareHuanShouTbl:GetMagicAttackMin()
            compareServantAttribute.maxAttributeValue = self.luaCompareHuanShouTbl:GetMagicAttackMax()
            compareServantAttribute.rateMinAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.MagicAttackMin,compareServantAttribute.minAttributeValue)
            compareServantAttribute.rateMaxAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.MagicAttackMax,compareServantAttribute.maxAttributeValue)
        end

        self:AddBaseAttribute(curServantAttribute,compareServantAttribute)
    end
    --endregion

    --region 道术攻击
    if self.career == LuaEnumCareer.Taoist then
        curServantAttribute = {}
        curServantAttribute.minAttributeValue = self.luaHuanshouTbl:GetTaoAttackMin()
        curServantAttribute.maxAttributeValue = self.luaHuanshouTbl:GetTaoAttackMax()
        curServantAttribute.rateMinAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.TaoAttackMin, curServantAttribute.minAttributeValue)
        curServantAttribute.rateMaxAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.TaoAttackMax, curServantAttribute.maxAttributeValue)
        curServantAttribute.attributeName = Utility.GetAttributeName(LuaEnumAttributeType.TaoAttackMax)

        compareServantAttribute = nil
        if self.luaCompareHuanShouTbl ~= nil then
            compareServantAttribute = {}
            compareServantAttribute.minAttributeValue = self.luaCompareHuanShouTbl:GetTaoAttackMin()
            compareServantAttribute.maxAttributeValue = self.luaCompareHuanShouTbl:GetTaoAttackMax()
            compareServantAttribute.rateMinAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.TaoAttackMin,compareServantAttribute.minAttributeValue)
            compareServantAttribute.rateMaxAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.TaoAttackMax,compareServantAttribute.maxAttributeValue)
        end

        self:AddBaseAttribute(curServantAttribute,compareServantAttribute)
    end
    --endregion

    --region 物防
    curServantAttribute = {}
    curServantAttribute.minAttributeValue = self.luaHuanshouTbl:GetPhyDefenceMin()
    curServantAttribute.maxAttributeValue = self.luaHuanshouTbl:GetPhyDefenceMax()
    curServantAttribute.rateMinAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.PhyDefenceMin, curServantAttribute.minAttributeValue)
    curServantAttribute.rateMaxAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.PhyDefenceMax, curServantAttribute.maxAttributeValue)
    curServantAttribute.attributeName = Utility.GetAttributeName(LuaEnumAttributeType.PhyDefenceMax)

    compareServantAttribute = nil
    if self.luaCompareHuanShouTbl ~= nil then
        compareServantAttribute = {}
        compareServantAttribute.minAttributeValue = self.luaCompareHuanShouTbl:GetPhyDefenceMin()
        compareServantAttribute.maxAttributeValue = self.luaCompareHuanShouTbl:GetPhyDefenceMax()
        compareServantAttribute.rateMinAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.PhyDefenceMin,compareServantAttribute.minAttributeValue)
        compareServantAttribute.rateMaxAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.PhyDefenceMax,compareServantAttribute.maxAttributeValue)
    end

    self:AddBaseAttribute(curServantAttribute,compareServantAttribute)
    --endregion

    --region 魔防
    curServantAttribute = {}
    curServantAttribute.minAttributeValue = self.luaHuanshouTbl:GetMagicDefenceMin()
    curServantAttribute.maxAttributeValue = self.luaHuanshouTbl:GetMagicDefenceMax()
    curServantAttribute.rateMinAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.MagicDefenceMin, curServantAttribute.minAttributeValue)
    curServantAttribute.rateMaxAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.MagicDefenceMax, curServantAttribute.maxAttributeValue)
    curServantAttribute.attributeName = Utility.GetAttributeName(LuaEnumAttributeType.MagicDefenceMax)

    compareServantAttribute = nil
    if self.luaCompareHuanShouTbl ~= nil then
        compareServantAttribute = {}
        compareServantAttribute.minAttributeValue = self.luaCompareHuanShouTbl:GetMagicDefenceMin()
        compareServantAttribute.maxAttributeValue = self.luaCompareHuanShouTbl:GetMagicDefenceMax()
        compareServantAttribute.rateMinAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.MagicDefenceMin,compareServantAttribute.minAttributeValue)
        compareServantAttribute.rateMaxAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.MagicDefenceMax,compareServantAttribute.maxAttributeValue)
    end

    self:AddBaseAttribute(curServantAttribute,compareServantAttribute)
    --endregion

    --region 血量
    curServantAttribute = {}
    curServantAttribute.normalAttributeValue = self.luaHuanshouTbl:GetMaxHp()
    curServantAttribute.rateNormalAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.MaxHp, curServantAttribute.normalAttributeValue)
    curServantAttribute.attributeName = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp)

    compareServantAttribute = nil
    if self.luaCompareHuanShouTbl ~= nil then
        compareServantAttribute = {}
        compareServantAttribute.normalAttributeValue = self.luaCompareHuanShouTbl:GetMaxHp()
        compareServantAttribute.rateNormalAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.MaxHp,compareServantAttribute.normalAttributeValue)
    end

    self:AddBaseAttribute(curServantAttribute,compareServantAttribute)
    --endregion

    --region 神圣攻击
    curServantAttribute = {}
    curServantAttribute.minAttributeValue = self.luaHuanshouTbl:GetHolyAttackMin()
    curServantAttribute.maxAttributeValue = self.luaHuanshouTbl:GetHolyAttackMax()
    curServantAttribute.rateMinAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.HolyAttackMin, curServantAttribute.minAttributeValue)
    curServantAttribute.rateMaxAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.HolyAttackMax, curServantAttribute.maxAttributeValue)
    curServantAttribute.attributeName = Utility.GetAttributeName(LuaEnumAttributeType.HolyAttackMax)

    compareServantAttribute = nil
    if self.luaCompareHuanShouTbl ~= nil then
        compareServantAttribute = {}
        compareServantAttribute.minAttributeValue = self.luaCompareHuanShouTbl:GetHolyAttackMin()
        compareServantAttribute.maxAttributeValue = self.luaCompareHuanShouTbl:GetHolyAttackMax()
        compareServantAttribute.rateMinAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.HolyAttackMin,compareServantAttribute.minAttributeValue)
        compareServantAttribute.rateMaxAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.HolyAttackMax,compareServantAttribute.maxAttributeValue)
    end

    self:AddBaseAttribute(curServantAttribute,compareServantAttribute)
    --endregion

    --region 神圣防御
    curServantAttribute = {}
    curServantAttribute.minAttributeValue = self.luaHuanshouTbl:GetHolyDefenceMin()
    curServantAttribute.maxAttributeValue = self.luaHuanshouTbl:GetHolyDefenceMax()
    curServantAttribute.rateMinAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.HolyDefenceMin, curServantAttribute.minAttributeValue)
    curServantAttribute.rateMaxAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.HolyDefenceMax, curServantAttribute.maxAttributeValue)
    curServantAttribute.attributeName = Utility.GetAttributeName(LuaEnumAttributeType.HolyDefenceMax)

    compareServantAttribute = nil
    if self.luaCompareHuanShouTbl ~= nil then
        compareServantAttribute = {}
        compareServantAttribute.minAttributeValue = self.luaCompareHuanShouTbl:GetHolyDefenceMin()
        compareServantAttribute.maxAttributeValue = self.luaCompareHuanShouTbl:GetHolyDefenceMax()
        compareServantAttribute.rateMinAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.HolyDefenceMin,compareServantAttribute.minAttributeValue)
        compareServantAttribute.rateMaxAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.HolyDefenceMax,compareServantAttribute.maxAttributeValue)
    end

    self:AddBaseAttribute(curServantAttribute,compareServantAttribute)
    --endregion

    --region 生命恢复(策划要求不显示)
    --curServantAttribute = {}
    --curServantAttribute.normalAttributeValue = self.luaHuanshouTbl:GetHpRecover()
    --curServantAttribute.rateNormalAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.HpRecover, curServantAttribute.normalAttributeValue)
    --curServantAttribute.attributeName = Utility.GetAttributeName(LuaEnumAttributeType.HpRecover)
    --
    --compareServantAttribute = nil
    --if self.luaCompareHuanShouTbl ~= nil then
    --    compareServantAttribute = {}
    --    compareServantAttribute.normalAttributeValue = self.luaCompareHuanShouTbl:GetHpRecover()
    --    compareServantAttribute.rateNormalAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.HpRecover,compareServantAttribute.normalAttributeValue)
    --end
    --
    --self:AddBaseAttribute(curServantAttribute,compareServantAttribute)
    --endregion

    --region 闪避
    curServantAttribute = {}
    curServantAttribute.normalAttributeValue = self.luaHuanshouTbl:GetDodge()
    curServantAttribute.rateNormalAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.Dodge, curServantAttribute.normalAttributeValue)
    curServantAttribute.attributeName = Utility.GetAttributeName(LuaEnumAttributeType.Dodge)

    compareServantAttribute = nil
    if self.luaCompareHuanShouTbl ~= nil then
        compareServantAttribute = {}
        compareServantAttribute.normalAttributeValue = self.luaCompareHuanShouTbl:GetDodge()
        compareServantAttribute.rateNormalAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.Dodge,compareServantAttribute.normalAttributeValue)
    end

    self:AddBaseAttribute(curServantAttribute,compareServantAttribute)
    --endregion

    --region 准确
    curServantAttribute = {}
    curServantAttribute.normalAttributeValue = self.luaHuanshouTbl:GetAccurate()
    curServantAttribute.rateNormalAttributeValue = self:GetRateUpValue(self.showBagItemInfo, LuaEnumAttributeType.Accurate, curServantAttribute.normalAttributeValue)
    curServantAttribute.attributeName = Utility.GetAttributeName(LuaEnumAttributeType.Accurate)

    compareServantAttribute = nil
    if self.luaCompareHuanShouTbl ~= nil then
        compareServantAttribute = {}
        compareServantAttribute.normalAttributeValue = self.luaCompareHuanShouTbl:GetAccurate()
        compareServantAttribute.rateNormalAttributeValue = self:GetRateUpValue(self.compareBagItemInfo, LuaEnumAttributeType.Accurate,compareServantAttribute.normalAttributeValue)
    end

    self:AddBaseAttribute(curServantAttribute,compareServantAttribute)
    --endregion
end

---@class ServantAttribute 灵兽属性
---@field minAttributeValue number
---@field maxAttributeValue number
---@field normalAttributeValue number
---@field rateMinAttributeValue number
---@field rateMaxAttributeValue number
---@field rateNormalAttributeValue number
---@field attributeName string
---@field valueProportion number

---添加属性
---@param servantAttribute ServantAttribute
---@param compareServantAttribute ServantAttribute
function UIItemInfoPanel_ServentAttributeInfo:AddBaseAttribute(servantAttribute,compareServantAttribute)
    if servantAttribute == nil or (servantAttribute.minAttributeValue == nil and servantAttribute.maxAttributeValue == nil and servantAttribute.normalAttributeValue == nil) or servantAttribute.attributeName == nil then
        return
    end

    ---当前显示的实际属性
    local curServantMinValue = ternary(servantAttribute.minAttributeValue == nil,0,servantAttribute.minAttributeValue)
    if type(servantAttribute.rateMinAttributeValue) == 'number' then
        curServantMinValue = curServantMinValue + servantAttribute.rateMinAttributeValue
    end
    local curServantMaxValue = ternary(servantAttribute.maxAttributeValue == nil,0,servantAttribute.maxAttributeValue)
    if type(servantAttribute.rateMaxAttributeValue) == 'number' then
        curServantMaxValue = curServantMaxValue + servantAttribute.rateMaxAttributeValue
    end
    local curNormalAttributeValue = ternary(servantAttribute.normalAttributeValue == nil,0,servantAttribute.normalAttributeValue)
    if type(servantAttribute.rateNormalAttributeValue) == 'number' then
        curNormalAttributeValue = curNormalAttributeValue + servantAttribute.rateNormalAttributeValue
    end

    if curServantMinValue <= 0 and curServantMaxValue <= 0 and curNormalAttributeValue <= 0 then
        return
    end

    ---对比对象的实际属性
    local compareServantMinValue = nil
    local compareServantMaxValue = nil
    local compareNormalAttributeValue = nil
    if type(compareServantAttribute) == 'table' and Utility.GetLuaTableCount(compareServantAttribute) > 0 then
        compareServantMinValue = ternary(compareServantAttribute.minAttributeValue == nil,0,compareServantAttribute.minAttributeValue)
        if type(compareServantAttribute.rateMinAttributeValue) == 'number' then
            compareServantMinValue = compareServantMinValue + compareServantAttribute.rateMinAttributeValue
        end
        compareServantMaxValue = ternary(compareServantAttribute.maxAttributeValue == nil,0,compareServantAttribute.maxAttributeValue)
        if type(compareServantAttribute.rateMaxAttributeValue) == 'number' then
            compareServantMaxValue = compareServantMaxValue + compareServantAttribute.rateMaxAttributeValue
        end
        compareNormalAttributeValue = ternary(compareServantAttribute.normalAttributeValue == nil,0,compareServantAttribute.normalAttributeValue)
        if type(compareServantAttribute.rateNormalAttributeValue) == 'number' then
            compareNormalAttributeValue = compareNormalAttributeValue + compareServantAttribute.rateNormalAttributeValue
        end
    end

    ---属性颜色
    local attributeColor = luaEnumColorType.White
    ---属性提升文本
    local attributeUpValue = ""
    ---属性值描述内容
    local attributeValueDes = ""
    ---数值比例
    local attributeProportion = ternary(type(servantAttribute.valueProportion) ~= 'number' or servantAttribute.valueProportion <= 0,1,servantAttribute.valueProportion)
    ---是否有绿色箭头
    local isHigherAttack = false

    if (type(servantAttribute.rateMinAttributeValue) == 'number' and servantAttribute.rateMinAttributeValue > 0) or
            (type(servantAttribute.rateMaxAttributeValue) == 'number' and servantAttribute.rateMaxAttributeValue > 0) or
            (type(servantAttribute.rateNormalAttributeValue) == 'number' and servantAttribute.rateNormalAttributeValue > 0) then
        attributeColor = luaEnumColorType.Green
    end

    if type(servantAttribute.normalAttributeValue) == 'number' then
        attributeValueDes = string.format("%g", curNormalAttributeValue / attributeProportion)
    else
        attributeValueDes = string.format("%g", curServantMinValue / attributeProportion) .. " - " .. string.format("%g", curServantMaxValue / attributeProportion)
    end

    if type(servantAttribute.rateMaxAttributeValue) == 'number' and servantAttribute.rateMaxAttributeValue >= 0 and type(servantAttribute.maxAttributeValue) == 'number' and servantAttribute.maxAttributeValue >= 0 then
        attributeUpValue = self:GetRateAttributeUpValue(servantAttribute.rateMaxAttributeValue + servantAttribute.maxAttributeValue, servantAttribute.maxAttributeValue)
    elseif type(servantAttribute.rateNormalAttributeValue) == 'number' and servantAttribute.rateNormalAttributeValue >= 0 and type(servantAttribute.normalAttributeValue) == 'number' and servantAttribute.normalAttributeValue >= 0 then
        attributeUpValue = self:GetRateAttributeUpValue(servantAttribute.rateNormalAttributeValue + servantAttribute.normalAttributeValue, servantAttribute.normalAttributeValue)
    end

    if compareServantAttribute ~= nil then
        if type(curServantMinValue) == 'number' and type(curServantMaxValue) == 'number' and type(compareServantMinValue) == 'number' and type(compareServantMaxValue) == 'number'  then
            isHigherAttack = self:CompareAttribute(curServantMinValue,curServantMaxValue,compareServantMinValue,compareServantMaxValue)
        elseif type(curNormalAttributeValue) == 'number' and type(compareNormalAttributeValue) == 'number' then
            isHigherAttack = curNormalAttributeValue > compareNormalAttributeValue
        end
    end
    if CS.StaticUtility.IsNullOrEmpty(attributeValueDes) == false then
        self:AddAttribute(attributeColor .. servantAttribute.attributeName .. '[-]', attributeColor .. attributeValueDes .. attributeUpValue, isHigherAttack)
    end
end

---老的属性增加
function UIItemInfoPanel_ServentAttributeInfo:NormalServantAttributeAdd()
    ---物防
    local basePhyDefence = self.serventInfoTable.phyDefenceQualifications
    local isHigherphyDefence = false
    local rotaMaxDefence = self:FindRateAttributeValue(self.showBagItemInfo, LuaEnumAttributeType.PhyDefenceMax)
    local defenceColor = Utility.GetGRCode(rotaMaxDefence > basePhyDefence)
    local defenceAttributeUpValue = self:GetRateAttributeUpValue(rotaMaxDefence, basePhyDefence)
    local showPhyDefenceAttributeValue = ternary(rotaMaxDefence > 0,rotaMaxDefence,basePhyDefence)
    if self.isCarryServantInfo then
        isHigherphyDefence = showPhyDefenceAttributeValue > self:FindRateAttributeValue(self.isCarryServantInfo, LuaEnumAttributeType.PhyDefenceMax)
    end
    if basePhyDefence > 0 then
        self:AddAttribute(defenceColor .. "防       御" .. "[-]" .. '', defenceColor .. string.format("%g", showPhyDefenceAttributeValue / 10) .. defenceAttributeUpValue .. '', isHigherphyDefence)
    end

    ---魔防
    local baseMagicDefence = self.serventInfoTable.magicDefenceQualifications
    local isHighermagicDefence = false
    local rotaMaxMagicDefence = self:FindRateAttributeValue(self.showBagItemInfo, LuaEnumAttributeType.MagicDefenceMax)
    local magicDefenceColor = Utility.GetGRCode(rotaMaxMagicDefence > baseMagicDefence)
    local magicDefenceAttributeUpValue = self:GetRateAttributeUpValue(rotaMaxMagicDefence, baseMagicDefence)
    local showMagicDefenceAttributeValue = ternary(rotaMaxMagicDefence > 0,rotaMaxMagicDefence,baseMagicDefence)
    if self.isCarryServantInfo then
        isHighermagicDefence = showMagicDefenceAttributeValue > self:FindRateAttributeValue(self.isCarryServantInfo, LuaEnumAttributeType.MagicDefenceMax)
    end
    if baseMagicDefence > 0 then
        self:AddAttribute(magicDefenceColor .. "魔       防" .. "[-]" .. '', magicDefenceColor .. string.format("%g", showMagicDefenceAttributeValue / 10) .. magicDefenceAttributeUpValue .. '', isHighermagicDefence)
    end

    ---生命
    local baseHp = self.serventInfoTable.hpQualifications
    local isHigherHP = false
    local rotaMaxHp = self:FindRateAttributeValue(self.showBagItemInfo, LuaEnumAttributeType.MaxHp)
    local hpColor = Utility.GetGRCode(rotaMaxHp > baseHp)
    local hpAttributeUpValue = self:GetRateAttributeUpValue(rotaMaxHp, baseHp)
    local showHPAttributeValue = ternary(rotaMaxHp > 0,rotaMaxHp,baseHp)
    if self.isCarryServantInfo then
        isHigherHP = showHPAttributeValue > self:FindRateAttributeValue(self.isCarryServantInfo, LuaEnumAttributeType.MaxHp)
    end
    if baseHp > 0 then
        self:AddAttribute(hpColor .. "血       量" .. "[-]" .. '', hpColor .. string.format("%g", showHPAttributeValue / 10) .. hpAttributeUpValue .. '', isHigherHP)
    end

    ---神圣攻击
    local baseHolyAttack = self.serventInfoTable.holyAttackQualifications
    local isHigherholyAttack = false
    local rotaMaxHolyAttack = self:FindRateAttributeValue(self.showBagItemInfo, LuaEnumAttributeType.HolyAttackMax)
    local magicDefenceColor = Utility.GetGRCode(rotaMaxHolyAttack > baseHolyAttack)
    local magicDefenceAttributeUpValue = self:GetRateAttributeUpValue(rotaMaxHolyAttack, baseHolyAttack)
    local showHolyAttackAttributeValue = ternary(rotaMaxHolyAttack > 0,rotaMaxHolyAttack,baseHolyAttack)
    if self.isCarryServantInfo then
        isHigherholyAttack = showHolyAttackAttributeValue > self:FindRateAttributeValue(self.isCarryServantInfo, LuaEnumAttributeType.HolyAttackMax)
    end
    if baseHolyAttack > 0 then
        self:AddAttribute(magicDefenceColor .. Utility.GetAttributeName(LuaEnumAttributeType.HolyAttackMax) .. "[-]" .. '', magicDefenceColor .. string.format("%g", showHolyAttackAttributeValue / 10) .. magicDefenceAttributeUpValue .. '', isHigherholyAttack)
    end

    ---神圣防御
    local baseHolyDefence = self.serventInfoTable.holyDefenceQualifications
    local isHigherholyDefence = false
    local rotaMaxHolyDefence = self:FindRateAttributeValue(self.showBagItemInfo, LuaEnumAttributeType.HolyDefenceMax)
    local magicDefenceColor = Utility.GetGRCode(rotaMaxHolyDefence > baseHolyDefence)
    local magicDefenceAttributeUpValue = self:GetRateAttributeUpValue(rotaMaxHolyDefence, baseHolyDefence)
    local showHolyDefenceAttributeValue = ternary(rotaMaxHolyDefence > 0,rotaMaxHolyDefence,baseHolyDefence)
    if self.isCarryServantInfo then
        isHigherholyDefence = showHolyDefenceAttributeValue > self:FindRateAttributeValue(self.isCarryServantInfo, LuaEnumAttributeType.HolyDefenceMax)
    end
    if baseHolyDefence > 0 then
        self:AddAttribute(magicDefenceColor .. Utility.GetAttributeName(LuaEnumAttributeType.HolyDefenceMax) .. "[-]" .. '', magicDefenceColor .. string.format("%g", showHolyDefenceAttributeValue / 10) .. magicDefenceAttributeUpValue .. '', isHigherholyDefence)
    end

    ---设置属性图（条形）
    local attributeMaxValue = CS.Cfg_GlobalTableManager.Instance:GetAttributeMaxValue(self.serventInfoTable.type)
    if attributeMaxValue.Length > 0 then
        local attributeTable = {}
        attributeTable[0] = showAttackAttributeValue
        attributeTable[1] = showPhyDefenceAttributeValue
        attributeTable[2] = showMagicDefenceAttributeValue
        attributeTable[3] = showHPAttributeValue
        attributeTable[4] = showHolyAttackAttributeValue
        attributeTable[5] = showHolyDefenceAttributeValue
        self:UIItemInfoPanel_ServentAttributeInfo_Bar(attributeTable, attributeMaxValue)
    end
end

function UIItemInfoPanel_ServentAttributeInfo:ClearAttributeData()
    self.count = 0
    self.attrNameStr = ""
    self.attrValueStr = ""
    self.showArrowSign = 0
    self.attributeTable = {}
    self.baseAttributeTable = {}
end

---设置属性
function UIItemInfoPanel_ServentAttributeInfo:SetAttribute(attributeName, minValue, maxValue, rateValue, isHigherPhyAttack)
    local mattributeName = nil
    local mattributeValue = nil
    if isHigherPhyAttack then
        mattributeName = UIItemInfoPanel_ServentAttributeInfo.rateColor .. attributeName .. "[-]"
        if #rateValue > 1 then
            mattributeValue = UIItemInfoPanel_ServentAttributeInfo.rateColor .. tostring(minValue + rateValue[1]) .. tostring(maxValue + rateValue[2]) .. "(+" .. rateValue[2] .. ")[-]"
        else
            mattributeValue = UIItemInfoPanel_ServentAttributeInfo.rateColor .. tostring(minValue + rateValue[1]) .. "(+" .. rateValue[1] .. ")[-]"
        end
    else
        mattributeName = UIItemInfoPanel_ServentAttributeInfo.rateColor .. attributeName .. "[-]"
        if maxValue ~= nil then
            mattributeValue = minValue .. maxValue
        else
            mattributeValue = minValue
        end
    end
    UIItemInfoPanel_ServentAttributeInfo:AddAttribute(mattributeName, mattributeValue, isHigherPhyAttack)
end

function UIItemInfoPanel_ServentAttributeInfo:AddAttribute(attributeName, attributeValue, isShowArrow)
    self.count = self.count + 1
    local singleAttribute = {}
    singleAttribute.attributeName = attributeName
    singleAttribute.attributeValue = attributeValue
    singleAttribute.isShowArrow = isShowArrow
    table.insert(self.baseAttributeTable, singleAttribute)
end

---刷新属性内容
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentAttributeInfo:ShowAttribute(itemInfo)
    self:GetTitleLabel_UILabel().gameObject:SetActive(true)
    self:GetTitleLabel_UILabel().text = ternary(self.count == 0, "", "[73ddf7]灵兽属性")

    self:GetBaseAttr_UIGridContainer().MaxCount = #self.baseAttributeTable
    self:GetAttributeArrow_UIGridContainer().MaxCount = #self.baseAttributeTable
    for i = 0, #self.baseAttributeTable - 1 do
        local attribute = self.baseAttributeTable[i + 1]
        local attr = self:GetBaseAttr_UIGridContainer().controlList[i]
        local attrName = self:GetCurComp(attr, "AttrName", "UILabel")
        local attrValue = self:GetCurComp(attr, "AttrValue/AttrValue", "UILabel")
        local arrow = self:GetAttributeArrow_UIGridContainer().controlList[i]
        luaclass.UIRefresh:RefreshLabel(attrName,attribute.attributeName)
        luaclass.UIRefresh:RefreshLabel(attrValue,attribute.attributeValue)
        arrow:SetActive(attribute.isShowArrow)
    end
end

function UIItemInfoPanel_ServentAttributeInfo:ShowSliderAttribute(itemInfo)
    self:GetTitleLabel_UILabel().gameObject:SetActive(true)
    self:GetTitleLabel_UILabel().text = ternary(self.count == 0, "", "[73ddf7]灵兽属性")

    self:GetBaseAttr_UIGridContainer().MaxCount = #self.baseAttributeTable
    self:GetAttributeArrow_UIGridContainer().MaxCount = #self.baseAttributeTable
    for i = 0, #self.baseAttributeTable - 1 do
        local attribute = self.baseAttributeTable[i + 1]
        local attr = self:GetBaseAttr_UIGridContainer().controlList[i]
        local attrName = self:GetCurComp(attr, "AttrName", "UILabel")
        local attrValue = self:GetCurComp(attr, "AttrValue", "UILabel")
        local arrow = self:GetAttributeArrow_UIGridContainer().controlList[i]
        attrName.text = attribute.attributeName
        attrValue.text = attribute.attributeValue
        arrow:SetActive(attribute.isShowArrow)

        ---设置属性条
        local uiSlider = self:GetCurComp(attr, "Slider", "UISlider")
        if self.attributePercentum[i] ~= nil then
            uiSlider.sliderValue = self.attributePercentum[i]
        end
    end
end

---设置属性图（六芒星）
function UIItemInfoPanel_ServentAttributeInfo:SetAttributeGraph(attributeTable, attributeMaxValue)
    --属性百分比
    local attributePercentum = {}
    for i = 0, #attributeTable do
        attributePercentum[i] = attributeTable[i] / attributeMaxValue[i] * 70
    end
end

---设置属性图(条形)
function UIItemInfoPanel_ServentAttributeInfo:UIItemInfoPanel_ServentAttributeInfo_Bar(attributeTable, attributeMaxValue)
    self.attributePercentum = {}
    for i = 0, #attributeTable do
        self.attributePercentum[i] = 0.1 + (attributeTable[i] / attributeMaxValue[i]) * 0.9
    end
    self:GetAttributeValue_SixStarGraph():SetSixStarGraph(self.attributePercentum[0], self.attributePercentum[1], self.attributePercentum[2], self.attributePercentum[3], self.attributePercentum[4], self.attributePercentum[5])
end

---获取浮动增加值
---@param bagItemInfo bagV2.BagItemInfo
---@param attributeType LuaEnumAttributeType
---@param baseValue number
---@return string
function UIItemInfoPanel_ServentAttributeInfo:GetRateUpValue(bagItemInfo, attributeType, baseValue)
    local rateValue = self:FindRateAttributeValue(bagItemInfo, attributeType)
    if rateValue <= 0 then
        return 0
    end
    baseValue = ternary(type(baseValue) ~= 'number',0,baseValue)
    return rateValue - baseValue
end

---根据属性类型找到属性浮动表的值
function UIItemInfoPanel_ServentAttributeInfo:FindRateAttributeValue(bagItemInfo, type)
    if bagItemInfo and bagItemInfo.rateAttribute and bagItemInfo.rateAttribute.Count then
        for i = 0, bagItemInfo.rateAttribute.Count - 1 do
            if bagItemInfo.rateAttribute[i].type == type then
                return bagItemInfo.rateAttribute[i].num
            end
        end
    end
    return 0
end

---获取属性提升值
function UIItemInfoPanel_ServentAttributeInfo:GetRateAttributeUpValue(rateAttribute, baseAttribute)
    if rateAttribute ~= nil and baseAttribute ~= nil then
        if rateAttribute > baseAttribute then
            return "(+" .. string.format("%g", (rateAttribute - baseAttribute)) .. ")"
        else
            return ""
        end
    end
    return ""
end

---属性比较(目前只针对攻击和防御，其他需求后续增加)
---@param equipAttributeMin number 对比物品的基础属性最小值
---@param equipRotaAttributeMax number 对比物品的BagItemInfo浮动属性最大值
---@param playerEquipAttributeMin number 被对比物品基础属性最小值
---@param playerEquipRotaValueMax number 被对比物品BagItemInfo浮动属性最大值
---@return boolean 对比结果
function UIItemInfoPanel_ServentAttributeInfo:CompareAttribute(equipAttributeMin, equipRotaAttributeMax,playerEquipAttributeMin, playerEquipRotaValueMax)
    if equipRotaAttributeMax ~= nil and playerEquipRotaValueMax ~= nil then
        if equipRotaAttributeMax > playerEquipRotaValueMax then
            return true
        elseif playerEquipRotaValueMax < playerEquipRotaValueMax then
            return false
        else
            return equipAttributeMin > playerEquipAttributeMin
        end
    else

    end
    return false
end

return UIItemInfoPanel_ServentAttributeInfo