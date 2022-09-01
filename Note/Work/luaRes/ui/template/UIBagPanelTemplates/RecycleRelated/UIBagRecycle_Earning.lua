---回收收益
---@class UIBagRecycleEarning:TemplateBase
local UIBagRecycle_Earning = {}

---获取收益数量文本
---@private
---@return UILabel
function UIBagRecycle_Earning:GetEarningCountLabel()
    if self.mEarningCountLabel == nil then
        self.mEarningCountLabel = self:Get("Label/EarningLabel", "UILabel")
    end
    return self.mEarningCountLabel
end

---获取加成效果文本
---@private
---@return UILabel
function UIBagRecycle_Earning:GetEarningAdditionLabel()
    if self.mEarningAdditionLabel == nil then
        self.mEarningAdditionLabel = self:Get("Label/AdditionLabel", "UILabel")
    end
    return self.mEarningAdditionLabel
end

---获取收益描述table
---@return UITable
function UIBagRecycle_Earning:GetEarningTable()
    if self.mEarningTable == nil then
        self.mEarningTable = self:Get("Label", "UITable")
    end
    return self.mEarningTable
end

---获取收益Icon
---@private
---@return UISprite
function UIBagRecycle_Earning:GetEarningIconSprite()
    if self.mEarningIconSprite == nil then
        self.mEarningIconSprite = self:Get("icon", "UISprite")
    end
    return self.mEarningIconSprite
end

---刷新
---@param itemID number 物品ID
---@param itemCount number 物品数量
---@param extraDes string 额外的描述
function UIBagRecycle_Earning:Refresh(itemID, itemCount, extraDes)
    self.itemID = itemID
    self.itemCount = itemCount
    local itemTblMgr = CS.Cfg_ItemsTableManager.Instance
    if itemTblMgr then
        local itemTbl = itemTblMgr:GetItems(itemID)
        if itemTbl then
            self:GetEarningIconSprite().spriteName = itemTbl.icon
        else
            self:GetEarningIconSprite().spriteName = ""
        end
    else
        self:GetEarningIconSprite().spriteName = ""
    end
    local content = tostring(itemCount)
    self:GetEarningCountLabel().text = content
    luaclass.UIRefresh:RefreshLabel(self:GetEarningAdditionLabel(),extraDes)
    luaclass.UIRefresh:RefreshUITable(self:GetEarningTable())
end

---获取回收收益商会描述
function UIBagRecycle_Earning:GetRecycleEarningMonthCardDes()
    local Interval = " "
    if self.itemID == 1000002 or self.itemID == 1000006 then
        return Interval .. CS.Cfg_GlobalTableManager.Instance:GetRecycleEarningMonthCardDescribe(self.itemID, CS.CSScene.MainPlayerInfo.MonthCardInfo:GetMonthCardRecycleMultiple(self.itemID))
    end
    return ""
end

return UIBagRecycle_Earning