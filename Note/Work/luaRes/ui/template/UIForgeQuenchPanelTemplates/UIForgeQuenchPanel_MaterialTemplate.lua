---@class UIForgeQuenchPanel_MaterialTemplate:TemplateBase 淬炼材料模板
local UIForgeQuenchPanel_MaterialTemplate = {}

--region 初始化

function UIForgeQuenchPanel_MaterialTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIForgeQuenchPanel_MaterialTemplate:InitParameters()
    self.itemTbl = nil
    self.bagItemInfo = nil
    self.targetCount = 0
    ---@type LuaForgeQuenchItemData
    self.forgeQuenchData = nil
end

function UIForgeQuenchPanel_MaterialTemplate:InitComponents()
    ---@type Top_UISprite
    self.icon = self:Get("UIItem/icon", "Top_UISprite")
    ---@type Top_UISprite
    self.count = self:Get("count", "Top_UILabel")
    ---@type UnityEngine.GameObject
    self.UIItem = self:Get("UIItem", "GameObject")
end

function UIForgeQuenchPanel_MaterialTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.UIItem).LuaEventTable = self
    CS.UIEventListener.Get(self.UIItem).OnClickLuaDelegate = self.OnGoClickCallBack
end

--endregion

--region Show

---@param data
---@field data.materialInfo {itemID:number,count:number}
---@field forgeQuenchData LuaForgeQuenchItemData
function UIForgeQuenchPanel_MaterialTemplate:SetTemplate(data)
    if data and data.materialInfo then
        self.itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(data.materialInfo.itemID)
        self.targetCount = data.materialInfo.count
        self.forgeQuenchData = data.forgeQuenchData
    end
    self.bagItemInfo = nil
    self:RefreshMainView()
    self:RefreshLabelView()
end

---刷新主视图
---@private
function UIForgeQuenchPanel_MaterialTemplate:RefreshMainView()
    self.icon.spriteName = self.itemTbl ~= nil and self.itemTbl:GetIcon()
end

---刷新文本
---@public
function UIForgeQuenchPanel_MaterialTemplate:RefreshLabelView()
    local itemID = self.itemTbl:GetId()
    local curCount = self:GetCurCountByItemId(itemID)
    local color = curCount >= self.targetCount and luaEnumColorType.Green or luaEnumColorType.Red
    self.count.text = color .. curCount .. '[-]/' .. self.targetCount
end

--endregion


--region UI函数监听
function UIForgeQuenchPanel_MaterialTemplate:OnGoClickCallBack()
    if self.bagItemInfo ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.bagItemInfo, showRight = false })
    elseif self.itemTbl ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.itemTbl:CsTABLE(), showRight = false })
    end
end
--endregion

function UIForgeQuenchPanel_MaterialTemplate:GetCurCountByItemId(id)
    if self.forgeQuenchData == nil then
        return gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndCurCoinMoneyCount(id, nil, function(itemInfo)
            return not gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(itemInfo)
        end)
    else
        local curCount, repliceCount = self.forgeQuenchData:GetForgeQuenchMaterialCurCount(id)
        return curCount + repliceCount
    end
end

function UIForgeQuenchPanel_MaterialTemplate:RefreshBagItemInfo(data)
    self.bagItemInfo = data
end

return UIForgeQuenchPanel_MaterialTemplate