---@type 勋章信息界面额外属性
------@class UIItemInfoPanel_Info_ExtraAttribute_Medal :UIItemInfoPanel_Info_ExtraAttribute
local UIItemInfoPanel_Info_ExtraAttribute_Medal = {}
setmetatable(UIItemInfoPanel_Info_ExtraAttribute_Medal, luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute)

function UIItemInfoPanel_Info_ExtraAttribute_Medal:GetMedalMaxDurable()
    if self.MedalMaxDurable == nil then
        self.MedalMaxDurable = CS.Cfg_GlobalTableManager.Instance:GetMedalMaxDurable()
    end
    if self.MedalMaxDurable == nil then
        return 0
    end
    return self.MedalMaxDurable
end

---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function UIItemInfoPanel_Info_ExtraAttribute_Medal:RefreshAttributes(bagItemInfo, itemInfo)
    --region 额外属性(buff属性)
    if itemInfo ~= nil then
        local des = clientTableManager.cfg_itemsManager:GetBuffDes(itemInfo.id)
        if CS.StaticUtility.IsNullOrEmpty(des) == false then
            local des = string.gsub(des, '\\n', '\n')
            self:AddAttribute("[73ddf7]特殊效果", "","[00FF00]" .. des)
        end
    end
    --endregion

   --region 镶嵌属性
    self:ShowInlayAttribute(bagItemInfo,itemInfo)
    --endregion

    --region 重铸属性
    self:AddRecastAttribute(bagItemInfo, itemInfo)
    --endregion

    --region 被镶嵌装备(神器，仙装，魂装)
    self:SetInlayEquipExtraAttribute(bagItemInfo,itemInfo,LuaEnumSoulEquipType.ShenQi)
    self:SetInlayEquipExtraAttribute(bagItemInfo,itemInfo,LuaEnumSoulEquipType.XianZhuang)
    self:SetInlayEquipExtraAttribute(bagItemInfo,itemInfo,LuaEnumSoulEquipType.HunZhuang)
    --endregion

    if bagItemInfo and itemInfo then
        --查询镶嵌位
        if bagItemInfo.inlayInfoList == nil or bagItemInfo.inlayInfoList.Count == 0 then
            return
        end
        local inlayInfo = bagItemInfo.inlayInfoList[0]
        local isFind, info = CS.Cfg_GlobalTableManager.Instance.MedalTipsDic:TryGetValue(inlayInfo.itemId)
        if isFind then
            local titleName = "[73ddf7]融合效果"
            local attrValue = string.gsub(info, '\\n', '\n')
            local totalLasting = ternary(itemInfo.maxLasting > 0, tostring(itemInfo.maxLasting), '--')
            local nowCurrentLastringColor = ternary(inlayInfo.currentLasting <= 0, luaEnumColorType.Red, luaEnumColorType.White)
            local showCantRepair = ternary(inlayInfo.currentLasting >= itemInfo.maxLasting, "", luaEnumColorType.Red .. '  (持久不可维修)[-]')
            attrValue = attrValue .. '\n' .. '持久' .. nowCurrentLastringColor .. tostring(inlayInfo.currentLasting) .. '[-] / ' .. totalLasting .. showCantRepair
            self:AddAttribute(titleName, '', attrValue)
        end
    end
end

return UIItemInfoPanel_Info_ExtraAttribute_Medal