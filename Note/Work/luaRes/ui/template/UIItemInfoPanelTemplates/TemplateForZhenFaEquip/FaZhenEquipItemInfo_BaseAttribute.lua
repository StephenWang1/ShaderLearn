---@class FaZhenEquipItemInfo_BaseAttribute:UIItemInfoPanel_Info_BaseAttribute 阵法装备基础属性
local FaZhenEquipItemInfo_BaseAttribute = {}

setmetatable(FaZhenEquipItemInfo_BaseAttribute, luaComponentTemplates.UIItemInfoPanel_Info_BaseAttribute)

---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function FaZhenEquipItemInfo_BaseAttribute:RefreshAttributes(bagItemInfo, itemInfo, compareBagItemInfo, compareItemInfo, career)
    self:RunBaseFunction("RefreshAttributes",bagItemInfo, itemInfo, compareBagItemInfo, compareItemInfo, career)
    self:ShowUseParamsUseCondition()
end

---显示使用参数条件
function FaZhenEquipItemInfo_BaseAttribute:ShowUseParamsUseCondition()
    if self.itemInfo ~= nil and self.itemInfo.useParam ~= nil then
        local conditionList = Utility.ListChangeTable(self.itemInfo.useParam.list)
        for k,v in pairs(conditionList) do
            if type(v) == 'number' then
                local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(v)
                if conditionTbl ~= nil and CS.StaticUtility.IsNullOrEmpty(conditionTbl:GetTxt()) == false then
                    local conditionResult = Utility.IsMainPlayerMatchCondition_LuaAndCS(v)
                    local desColor = ternary(conditionResult.success,luaEnumColorType.White,luaEnumColorType.Red1)
                    self:AddAttribute(desColor .. conditionTbl:GetTxt())
                end
            end
        end
    end
end

---@return boolean 是否显示等级
function FaZhenEquipItemInfo_BaseAttribute:mNeedShowLevelLimit(itemInfo)
    return false
end

return FaZhenEquipItemInfo_BaseAttribute