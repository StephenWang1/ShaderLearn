local BagMarryRingItemInfo_BaseInfo = {}
setmetatable(BagMarryRingItemInfo_BaseInfo,luaComponentTemplates.RoleMarryRingItemInfo_BaseInfo)

function BagMarryRingItemInfo_BaseInfo:RefreshAttributes(bagItemInfo, itemInfo, compareBagItemInfo, compareItemInfo, career)

    --region 基础属性显示
    self:RunBaseFunction("RefreshAttributes",bagItemInfo, itemInfo, compareBagItemInfo, compareItemInfo, career)
    --endregion

    local str = ""
    if itemInfo ~= nil and itemInfo.useParam ~= nil and itemInfo.useParam.list ~= nil and itemInfo.useParam.list.Count > 0 and itemInfo.useParam.list[0] > 0  then
        str = self:GetGlobalTableManager():GetBagMarryRingIntimacyUpText(itemInfo.useParam.list[0])
        self:AddAttribute(str, '', false)
    end
end
return BagMarryRingItemInfo_BaseInfo