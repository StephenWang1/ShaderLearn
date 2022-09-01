---@type 物品信息界面信息
local UIItemInfoPanel_ElementBaseAttribute = {}

setmetatable(UIItemInfoPanel_ElementBaseAttribute, luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute)

---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function UIItemInfoPanel_ElementBaseAttribute:RefreshAttributes(bagItemInfo, itemInfo)
    local elementTab = CS.Cfg_ElementTableManager.Instance:getElementStone(itemInfo.id)
    --region 元素攻击属性
    if elementTab ~= nil then
        local elementAttackName = CS.CSScene.MainPlayerInfo.ElementInfo:GetElementAttackName(elementTab)
        local elementAttack = CS.CSScene.MainPlayerInfo.ElementInfo:GetElementAttackAttributeContent(elementTab)
        local titleName = "[73ddf7]元素属性"
        self:AddAttribute(titleName , "", elementAttackName..elementAttack)
    end
    --endregion
    --region 元素镶嵌部位
    local elementTab = CS.Cfg_ElementTableManager.Instance:getElementStone(itemInfo.id)
    local equipIndexText = ""
    if elementTab ~= nil then
        local elementEquipIndexName = CS.CSScene.MainPlayerInfo.ElementInfo:GetElementEquipIndexName(elementTab)
        if elementEquipIndexName ~= nil and elementEquipIndexName.Length > 0 then
            for i = 0,elementEquipIndexName.Length - 1 do
                equipIndexText = equipIndexText ..elementEquipIndexName[i] .. " "
            end
        end
        local titleName = "[73ddf7]镶嵌部位"
        self:AddAttribute(titleName, "" ,equipIndexText)
    end
    --endregion
    --region 套装等级
    if elementTab ~= nil then
        local titleName = CS.Cfg_ElementTableManager.Instance:GetSuitTitleName(elementTab.id)
        local suitDescribeContent = CS.Cfg_ElementTableManager.Instance:GetSuitDescribeContent(elementTab.id)
        self:AddAttribute("[73ddf7]" .. titleName, "" ,suitDescribeContent)
    end
    --endregion
end
return UIItemInfoPanel_ElementBaseAttribute