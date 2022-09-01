---@class UIForgeQuenchPanel_OutputTemplate:TemplateBase 淬炼材料模板
local UIForgeQuenchPanel_OutputTemplate = {}

--region 初始化

function UIForgeQuenchPanel_OutputTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIForgeQuenchPanel_OutputTemplate:InitParameters()
    self.itemTbl = nil
    self.targetCount = 0
end

function UIForgeQuenchPanel_OutputTemplate:InitComponents()
    ---@type Top_UISprite
    self.icon = self:Get("UIItem/icon", "Top_UISprite")
    ---@type Top_UISprite
    self.count = self:Get("count", "Top_UILabel")
    ---@type Top_UISprite
    self.good = self:Get("UIItem/good", "Top_UISprite")
    ---@type UnityEngine.GameObject
    self.UIItem = self:Get("UIItem", "GameObject")
end

function UIForgeQuenchPanel_OutputTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.UIItem).LuaEventTable = self
    CS.UIEventListener.Get(self.UIItem).OnClickLuaDelegate = self.OnGoClickCallBack
end

--endregion

--region Show

---@param data
---@field data.itemId number
---@field data.equipIndex number
function UIForgeQuenchPanel_OutputTemplate:SetTemplate(data)
    if data then
        self.itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(data.itemId)
        self.equipIndex = data.equipIndex
    end
    self:RefreshView()
end

---刷新主视图
---@private
function UIForgeQuenchPanel_OutputTemplate:RefreshView()
    self.icon.spriteName = self.itemTbl ~= nil and self.itemTbl:GetIcon() or ""
    self:RefreshGoodIcon()
end

function UIForgeQuenchPanel_OutputTemplate:RefreshGoodIcon()
    if CS.StaticUtility.IsNull(self.good) then
        return
    end
    local bagItemInfo = CS.Cfg_ItemsFakeTipsTableManager.Instance:GetFakeBagItemInfoByItemId(self.itemTbl:GetId())
    local arrowSpriteName = ""
    if bagItemInfo then
        local arrowType = Utility.GetArrowType(bagItemInfo, false)
        if arrowType == LuaEnumArrowType.GreenArrow then
            arrowSpriteName = "arrow2"
        elseif arrowType == LuaEnumArrowType.YellowArrow then
            arrowSpriteName = "arrow3"
        end
    end
    self.good.spriteName = arrowSpriteName
end

--endregion


--region UI函数监听
function UIForgeQuenchPanel_OutputTemplate:OnGoClickCallBack()
    if self.itemTbl ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.itemTbl:CsTABLE(), showRight = false, showAssistPanel = true, showMoreAssistData = true })
    end
end
--endregion

return UIForgeQuenchPanel_OutputTemplate