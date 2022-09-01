---@class UIItemInfoPanel_Info_BaseAttribute_Collection:UIItemInfoPanel_Info_Basic
local UIItemInfoPanel_Info_BaseAttribute_Collection = {}

setmetatable(UIItemInfoPanel_Info_BaseAttribute_Collection, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

---@return UILabel
function UIItemInfoPanel_Info_BaseAttribute_Collection:GetTitleLabel()
    if self.mTitleLabel == nil then
        self.mTitleLabel = self:Get("title", "UILabel")
    end
    return self.mTitleLabel
end

---@return UIGridContainer
function UIItemInfoPanel_Info_BaseAttribute_Collection:GetAttributeGridContainer()
    if self.mAttributeGridContainer == nil then
        self.mAttributeGridContainer = self:Get("Attr", "UIGridContainer")
    end
    return self.mAttributeGridContainer
end

---@return UIGridContainer
function UIItemInfoPanel_Info_BaseAttribute_Collection:GetAttributeArrowGridContainer()
    if self.mAttributeArrowGridContainer == nil then
        self.mAttributeArrowGridContainer = self:Get("AttrArrow", "UIGridContainer")
    end
    return self.mAttributeArrowGridContainer
end

---@param bagItemInfo bagV2.BagItemInfo 藏品的背包数据
---@param itemInfo TABLE.CFG_ITEMS 藏品的items表数据
---@param collectionInfo LuaCollectionInfo 归属者的collectionInfo数据
---@param isMainPlayer boolean 是否是主角的藏品数据
function UIItemInfoPanel_Info_BaseAttribute_Collection:RefreshWithInfo(bagItemInfo, itemInfo, collectionInfo, isMainPlayer)
    if bagItemInfo == nil or itemInfo == nil or itemInfo.type ~= luaEnumItemType.Collection then
        self:GetTitleLabel().gameObject:SetActive(false)
        self:ClearAttributes()
        return
    end
    self:GetTitleLabel().gameObject:SetActive(true)
    ---显示藏品的基础属性
    self:ClearAttributes()
    local isLuaTable = type(bagItemInfo) == "table"
    ---只加这些属性
    ---计算属性
    local phyAtkMin = luaclass.LuaCollectionInfo.GetCollectionItemAttribute(bagItemInfo, LuaEnumAttributeType.PhyAttackMin, isLuaTable)
    local phyAtkMax = luaclass.LuaCollectionInfo.GetCollectionItemAttribute(bagItemInfo, LuaEnumAttributeType.PhyAttackMax, isLuaTable)
    local phyAtkBetter = false
    local magicAtkMin = luaclass.LuaCollectionInfo.GetCollectionItemAttribute(bagItemInfo, LuaEnumAttributeType.MagicAttackMin, isLuaTable)
    local magicAtkMax = luaclass.LuaCollectionInfo.GetCollectionItemAttribute(bagItemInfo, LuaEnumAttributeType.MagicAttackMax, isLuaTable)
    local magicAtkBetter = false
    local taoAtkMin = luaclass.LuaCollectionInfo.GetCollectionItemAttribute(bagItemInfo, LuaEnumAttributeType.TaoAttackMin, isLuaTable)
    local taoAtkMax = luaclass.LuaCollectionInfo.GetCollectionItemAttribute(bagItemInfo, LuaEnumAttributeType.TaoAttackMax, isLuaTable)
    local taoAtkBetter = false
    local phyDefMin = luaclass.LuaCollectionInfo.GetCollectionItemAttribute(bagItemInfo, LuaEnumAttributeType.PhyDefenceMin, isLuaTable)
    local phyDefMax = luaclass.LuaCollectionInfo.GetCollectionItemAttribute(bagItemInfo, LuaEnumAttributeType.PhyDefenceMax, isLuaTable)
    local phyDefBetter = false
    local magicDefMin = luaclass.LuaCollectionInfo.GetCollectionItemAttribute(bagItemInfo, LuaEnumAttributeType.MagicDefenceMin, isLuaTable)
    local magicDefMax = luaclass.LuaCollectionInfo.GetCollectionItemAttribute(bagItemInfo, LuaEnumAttributeType.MagicDefenceMax, isLuaTable)
    local magicDefBetter = false
    local hp = luaclass.LuaCollectionInfo.GetCollectionItemAttribute(bagItemInfo, LuaEnumAttributeType.MaxHp, isLuaTable)
    local hpBetter = false
    ---计算属性是否更好
    if isMainPlayer and collectionInfo:GetCollectionDic()[bagItemInfo.lid] == nil then
        ---如果是主角的数据且不在藏品阁中
        local sameItemInCabinet = collectionInfo:GetCollectionItemByCollectionID(bagItemInfo.itemId)
        if sameItemInCabinet ~= nil and sameItemInCabinet:GetCollectionBagItem() ~= nil then
            local temp = sameItemInCabinet:GetCollectionBagItem()
            local funcTemp = luaclass.LuaCollectionInfo.GetCollectionItemAttribute
            local career = collectionInfo:GetCareer()
            if career == LuaEnumCareer.Warrior then
                phyAtkBetter = (phyAtkMin + phyAtkMax) > (funcTemp(temp, LuaEnumAttributeType.PhyAttackMin) + funcTemp(temp, LuaEnumAttributeType.PhyAttackMax))
            end
            if career == LuaEnumCareer.Master then
                magicAtkBetter = (magicAtkMin + magicAtkMax) > (funcTemp(temp, LuaEnumAttributeType.MagicAttackMin) + funcTemp(temp, LuaEnumAttributeType.MagicAttackMax))
            end
            if career == LuaEnumCareer.Taoist then
                taoAtkBetter = (taoAtkMin + taoAtkMax) > (funcTemp(temp, LuaEnumAttributeType.TaoAttackMin) + funcTemp(temp, LuaEnumAttributeType.TaoAttackMax))
            end
            phyDefBetter = (phyDefMin + phyDefMax) > (funcTemp(temp, LuaEnumAttributeType.PhyDefenceMin) + funcTemp(temp, LuaEnumAttributeType.PhyDefenceMax))
            magicDefBetter = (magicDefMin + magicDefMax) > (funcTemp(temp, LuaEnumAttributeType.MagicDefenceMin) + funcTemp(temp, LuaEnumAttributeType.MagicDefenceMax))
            hpBetter = hp > funcTemp(temp, LuaEnumAttributeType.MaxHp)
        end
    end
    ---增加属性
    if phyAtkMin ~= 0 or phyAtkMax ~= 0 then
        self:AddAttribute("攻击", Utility.CombineStringQuickly(phyAtkMin, " - ", phyAtkMax), phyAtkBetter)
    end
    if magicAtkMin ~= 0 or magicAtkMax ~= 0 then
        self:AddAttribute("魔法", Utility.CombineStringQuickly(magicAtkMin, " - ", magicAtkMax), magicAtkBetter)
    end
    if taoAtkMin ~= 0 or taoAtkMax ~= 0 then
        self:AddAttribute("道术", Utility.CombineStringQuickly(taoAtkMin, " - ", taoAtkMax), taoAtkBetter)
    end
    if phyDefMin ~= 0 or phyDefMax ~= 0 then
        self:AddAttribute("防御", Utility.CombineStringQuickly(phyDefMin, " - ", phyDefMax), phyDefBetter)
    end
    if magicDefMin ~= 0 or magicDefMax ~= 0 then
        self:AddAttribute("魔防", Utility.CombineStringQuickly(magicDefMin, " - ", magicDefMax), magicDefBetter)
    end
    if hp ~= 0 then
        self:AddAttribute("血量", hp, hpBetter)
    end

    if itemInfo.useLv == 0 and itemInfo.reinLv == 0 and CS.Cfg_GlobalTableManager.Instance:ShowNoLevel(itemInfo) then
        self:AddAttribute("无等级")
    else
        local canUseItem = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(itemInfo.id) == LuaEnumUseItemParam.CanUse
        if ((itemInfo.useLv and itemInfo.useLv > 0) or (itemInfo.reinLv and itemInfo.reinLv > 0)) then
            local conditionType = itemInfo.useCondition
            local useLevelColor = Utility.NewGetBBCode(canUseItem)
            local useLevel = ""
            local attributeName = ""
            if conditionType == LuaEnumUseConditionType.And then
                useLevel = ternary(itemInfo.reinLv > 0, tostring(itemInfo.reinLv), tostring(itemInfo.useLv))
                attributeName = ternary(itemInfo.reinLv > 0, "需要转生等级", "需要等级")
            elseif conditionType == LuaEnumUseConditionType.Or then
                attributeName = string.format("需要等级 %s 或 转生 %s", itemInfo.useLv, itemInfo.reinLv)
            end
            self:AddAttribute(useLevelColor .. attributeName .. "", useLevelColor .. useLevel .. "", false)
        end
    end

    self:ApplyAttributes()
end

---@private
function UIItemInfoPanel_Info_BaseAttribute_Collection:ClearAttributes()
    self:GetAttributeGridContainer().MaxCount = 0
    self:GetAttributeArrowGridContainer().MaxCount = 0
    ---@type table<number, {name:string, value:string, isBetter:boolean}>
    self.mAttrList = {}
end

---@private
function UIItemInfoPanel_Info_BaseAttribute_Collection:AddAttribute(attrName, attrValue, isBetter)
    table.insert(self.mAttrList, { name = attrName, value = attrValue, isBetter = isBetter })
end

---@private
function UIItemInfoPanel_Info_BaseAttribute_Collection:ApplyAttributes()
    local length = #self.mAttrList
    self:GetAttributeGridContainer().MaxCount = length
    self:GetAttributeArrowGridContainer().MaxCount = length
    if length > 0 then
        for i = 1, length do
            ---@type UnityEngine.GameObject
            local go = self:GetAttributeGridContainer().controlList[i - 1]
            ---@type UnityEngine.GameObject
            local arrowGo = self:GetAttributeArrowGridContainer().controlList[i - 1]
            ---@type UILabel
            local attrNameLabel = self:GetCurComp(go, "AttrName", "UILabel")
            ---@type UILabel
            local attrValueLabel = self:GetCurComp(go, "AttrValue/AttrValue", "UILabel")
            attrNameLabel.text = self.mAttrList[i].name
            attrValueLabel.text = self.mAttrList[i].value
            arrowGo:SetActive(self.mAttrList[i].isBetter == true)
        end
    end
end

return UIItemInfoPanel_Info_BaseAttribute_Collection