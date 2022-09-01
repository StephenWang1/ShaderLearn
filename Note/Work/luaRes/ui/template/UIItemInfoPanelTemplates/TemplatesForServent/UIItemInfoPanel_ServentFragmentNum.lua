---@type 物品信息界面信息
local UIItemInfoPanel_ServentFragmentNum = {}

setmetatable(UIItemInfoPanel_ServentFragmentNum, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 组件
---@return UILabel
function UIItemInfoPanel_ServentFragmentNum:GetTextLabel_UILabel()
    if self.mTextLabel_UILabel == nil then
        self.mTextLabel_UILabel = self:Get("Text", "UILabel")
    end
    return self.mTextLabel_UILabel
end
--endregion

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_ServentFragmentNum:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    if bagItemInfo and itemInfo then
        local bagAmount = bagItemInfo.count
        local showStr = "";
        local synthesisTable = clientTableManager.cfg_synthesisManager:TryGetValue(bagItemInfo.itemId)
        if(synthesisTable) then
            local colorStr = tonumber(synthesisTable:GetNumber().list[1])<= bagAmount and luaEnumColorType.Green or luaEnumColorType.Red;
            showStr = "当前精魄数量 "..colorStr..bagAmount.."[-]/"..luaEnumColorType.White..synthesisTable:GetNumber().list[1].."[-]";
        else
            local needAmount = 0;
            if(itemInfo.compoundParam.list ~= nil and itemInfo.compoundParam.list.Count > 1) then
                needAmount = itemInfo.compoundParam.list[1]
            end
            local colorStr = Utility.GetBBCode(bagAmount >= needAmount)
            showStr = "当前精魄数量 " .. colorStr .. tostring(bagAmount)
        end
        self:GetTextLabel_UILabel().text = showStr;
    end
end

return UIItemInfoPanel_ServentFragmentNum