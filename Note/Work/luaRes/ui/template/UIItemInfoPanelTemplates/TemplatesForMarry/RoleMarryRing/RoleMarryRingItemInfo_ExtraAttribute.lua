local RoleMarryRingItemInfo_ExtraAttribute = {}
setmetatable(RoleMarryRingItemInfo_ExtraAttribute,luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute)
--region 引用
function RoleMarryRingItemInfo_ExtraAttribute:GetPlayerMarryInfo()
    if self.PlayerMarryInfo == nil then
        self.PlayerMarryInfo = CS.CSScene.MainPlayerInfo.MarryInfo:GetPlayerMarryInfo()
    end
    return self.PlayerMarryInfo
end
--endregion

---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function RoleMarryRingItemInfo_ExtraAttribute:RefreshAttributes(bagItemInfo, itemInfo)
    if bagItemInfo and itemInfo then
        --region man誓言
        local titleName = "[73ddf7]" .. bagItemInfo.man.name .. "的誓言"
        local iconName = ""
        local attrValue = bagItemInfo.manOath
        self:AddAttribute(titleName,iconName,attrValue)
        --endregion

        --region woman誓言
        local titleName =  "[73ddf7]" ..bagItemInfo.woman.name  .. "的誓言"
        local iconName = ""
        local attrValue = bagItemInfo.womanOath
        self:AddAttribute(titleName,iconName,attrValue)
        --endregion

        --region 执子之手
        local titleName =  "[73ddf7]执子之手"
        local iconName = ""
        local attrValue = CS.Cfg_GlobalTableManager.Instance:GetBagMarryRingTogatherTimeText(self:SelfName(bagItemInfo),self:WithRoleName(bagItemInfo),CS.CSServerTime.Instance.TotalMillisecond - bagItemInfo.marryTime)
        self:AddAttribute(titleName,iconName,attrValue)
        --endregion
    end
end

function RoleMarryRingItemInfo_ExtraAttribute:SelfName(bagItemInfo)
    local selfName = ternary(bagItemInfo.man.rid == self.roleId,bagItemInfo.man.name,bagItemInfo.woman.name)
    return selfName
end

---相伴的玩家的名字
function RoleMarryRingItemInfo_ExtraAttribute:WithRoleName(bagItemInfo)
    local withRoleName = ternary(bagItemInfo.man.rid == self.roleId,bagItemInfo.woman.name,bagItemInfo.man.name)
    return withRoleName
end
return RoleMarryRingItemInfo_ExtraAttribute