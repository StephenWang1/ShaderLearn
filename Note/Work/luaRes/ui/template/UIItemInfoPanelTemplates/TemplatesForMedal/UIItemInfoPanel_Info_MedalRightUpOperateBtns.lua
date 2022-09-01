---@class UIItemInfoPanel_Info_MedalRightUpOperateBtns:UIItemInfoPanel_Info_RightUpOperateButtons 勋章右上按钮视图
local UIItemInfoPanel_Info_MedalRightUpOperateBtns = {}
setmetatable(UIItemInfoPanel_Info_MedalRightUpOperateBtns, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

--region overrid
---重写按钮是否开启高亮
function UIItemInfoPanel_Info_MedalRightUpOperateBtns:BtnNeedHighLight(btnId)
    if btnId == LuaEnumItemOperateType.Blend then
        return self:CheckNeedHighLightBlendBtn()
    end
    if btnId == LuaEnumItemOperateType.Repair then
        for k, v in pairs(self.highLightBtnTable) do
            if v == btnId then
                return true
            end
        end
    end
    self:RunBaseFunction("BtnNeedHighLight", btnId)
end
--endregion

--region private

function UIItemInfoPanel_Info_MedalRightUpOperateBtns:CheckNeedHighLightBlendBtn()
    local isHaveMedal, isHaveDoubleMedal = false

    --首先查看装备是否有勋章佩戴
    local itemInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(Utility.EnumToInt(CS.EEquipIndex.POS_MEDAL))
    if itemInfo ~= nil then
        if itemInfo.ItemTABLE.subType == LuaEnumEquiptype.Medal then
            isHaveMedal = true
        else
            if itemInfo.ItemTABLE.subType == LuaEnumEquiptype.DoubleMedal then
                isHaveDoubleMedal = true
            end
        end

    end

    --查看背包是否有勋章可佩戴
    if not isHaveMedal then
        isHaveMedal = CS.CSScene.MainPlayerInfo.BagInfo:GetBestEquipByBag(LuaEnumEquiptype.Medal) ~= nil
    end

    if not isHaveDoubleMedal then
        isHaveDoubleMedal = CS.CSScene.MainPlayerInfo.BagInfo:GetBestEquipByBag(LuaEnumEquiptype.DoubleMedal) ~= nil
    end

    return isHaveMedal and isHaveDoubleMedal
end


--endregion

return UIItemInfoPanel_Info_MedalRightUpOperateBtns