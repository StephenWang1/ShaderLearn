---@class UIProficientCostMaterialTemplate 专精界面的个体模板下的消耗材料
local UIProficientCostMaterialTemplate = {}

---@type table<LuaMaterialData>
UIProficientCostMaterialTemplate.CostMaterialDataList = {}

UIProficientCostMaterialTemplate.NeedCount = nil
UIProficientCostMaterialTemplate.NeedItemId = nil

UIProficientCostMaterialTemplate.IsMeet = nil
---名字label
function UIProficientCostMaterialTemplate:GetIconSprite()
    if(self.mGetIconSprite == nil) then
        self.mGetIconSprite = self:Get("icon", "Top_UISprite")
    end
    return self.mGetIconSprite
end

---数量label
function UIProficientCostMaterialTemplate:GetCountLabel()
    if(self.mGetCountLabel == nil) then
        self.mGetCountLabel = self:Get("count", "Top_UILabel")
    end
    return self.mGetCountLabel
end

---@param data table<number> 第一个数字为itemId  第二个数字为数量
function UIProficientCostMaterialTemplate:UpdateCostMaterialItem(data)
    local itemId = data[1]
    local count = data[2]
    self.NeedCount = count;
    self.NeedItemId = itemId
    ---@type TABLE.cfg_items
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)

    CS.UIEventListener.Get(self:GetIconSprite().gameObject).onClick = function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTbl.csTABLE })
    end

    if(UIProficientCostMaterialTemplate.CostMaterialDataList[itemId] == nil) then
        UIProficientCostMaterialTemplate.CostMaterialDataList[itemId] = luaclass.LuaMaterialData:New()
        UIProficientCostMaterialTemplate.CostMaterialDataList[itemId]:GenerateData(itemId)
    end
    ---@type LuaMaterialData
    local materialData = UIProficientCostMaterialTemplate.CostMaterialDataList[itemId]

    self:GetIconSprite().spriteName = itemTbl:GetIcon()
    self:UpdateCostMaterialItemCount()
end



function UIProficientCostMaterialTemplate:UpdateCostMaterialItemCount()
    ---@type LuaMaterialData
    local materialData = UIProficientCostMaterialTemplate.CostMaterialDataList[self.NeedItemId]
    local count = materialData:GetMaterialCount(LuaItemSavePos.Bag, true)

    if(count >= self.NeedCount) then
        self:GetCountLabel().text = "[00ff00]"..tostring(count).."/"..tostring(self.NeedCount)
    else
        self:GetCountLabel().text = "[dde6eb]"..tostring(count).."/"..tostring(self.NeedCount)
    end
    self.IsMeet = count >= self.NeedCount
end


return UIProficientCostMaterialTemplate