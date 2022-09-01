---@class UIItemInfoPanel_Info_Basic:TemplateBase
local UIItemInfoPanel_Info_Basic = {}

---使用信息刷新
---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function UIItemInfoPanel_Info_Basic:RefreshWithInfo(bagItemInfo, itemInfo)
    --子类中重写
end

---添加闪烁对象到闪烁列表
function UIItemInfoPanel_Info_Basic:AddBlinkList(transform)
    local blink_UILabel = self:GetCurComp(transform.transform, "", "UILabel")
    local blink_TweenColor = self:GetCurComp(transform.transform, "", "TweenColor")
    if blink_UILabel ~= nil and blink_TweenColor ~= nil and luaEventManager.HasCallback(LuaCEvent.ItemInfoPanel_AddBlinkList) then
        blink_UILabel.color = blink_TweenColor.to
        luaEventManager.DoCallback(LuaCEvent.ItemInfoPanel_AddBlinkList, {go = transform,blink = blink_TweenColor})
    end
end

---移除闪烁对象到闪烁列表
function UIItemInfoPanel_Info_Basic:RemoveBlinkList(transform)
    if CS.StaticUtility.IsNull(transform) == false then
        luaEventManager.DoCallback(LuaCEvent.ItemInfoPanel_RemoveBlinkList, transform)
    end
end

return UIItemInfoPanel_Info_Basic