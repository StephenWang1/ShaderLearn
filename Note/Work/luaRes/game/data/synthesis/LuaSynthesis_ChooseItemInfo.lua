---@class LuaSynthesis_ChooseItemInfo:luaobject 当前选择的物品信息
local LuaSynthesis_ChooseItemInfo = {}

---@type LuaEnumSynthesisLeftPanelType 当前选择的页签类型
LuaSynthesis_ChooseItemInfo.SynthesisChoosePage = nil
---@type number 装备位
LuaSynthesis_ChooseItemInfo.EquipIndex = nil

--region 解析数据
---@class ServantSynthesisChooseItemCommonData
---@field servantSeatType luaEnumServantSeatType
---@field servantEquipIndexType LuaEnumServantEquipIndexType

---解析灵兽合成选择物品数据
---@param commonData ServantSynthesisChooseItemCommonData
function LuaSynthesis_ChooseItemInfo:SetServantSynthesisChooseItemInfo(commonData)
    self.SynthesisChoosePage = LuaEnumSynthesisLeftPanelType.Servant
    self.EquipIndex = nil
    if commonData ~= nil and type(commonData.servantSeatType) == 'number' and type(commonData.servantEquipIndexType) == 'number' then
        self.EquipIndex = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():GetEquipIndex(commonData.servantSeatType,commonData.servantEquipIndexType)
    end
end
--endregion

--region 获取
---获取选择的物品
---@return bagV2.BagItemInfo/nil
function LuaSynthesis_ChooseItemInfo:GetChooseItem()
    if self.SynthesisChoosePage == LuaEnumSynthesisLeftPanelType.Servant then
        if self.EquipIndex == nil then
            return
        end
        return gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():GetEquipByEquipIndex(self.EquipIndex)
    end
end
--endregion

return LuaSynthesis_ChooseItemInfo