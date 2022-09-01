---@class UIReforgedPanelTemplates_MaterialTemplate:TemplateBase 材料模板
local UIReforgedPanelTemplates_MaterialTemplate = {}

--region 初始化
function UIReforgedPanelTemplates_MaterialTemplate:Init()
    self:InitComponent()
    self:BindEvents()
end

function UIReforgedPanelTemplates_MaterialTemplate:InitComponent()
    ---@type UISprite
    self.itemIcon_UISprite = self:Get("Btn_Get/icon","UISprite")
    ---@type UILabel
    self.itemName_UILabel = self:Get("Btn_Get/itemName","UILabel")
    ---@type UILabel
    self.itemNum_UILabel = self:Get("Btn_Get/Label","UILabel")
    ---@type UnityEngine.GameObject
    self.WayGetBtn_GameObject = self:Get("Btn_ChangToBuy","GameObject")
end

function UIReforgedPanelTemplates_MaterialTemplate:BindEvents()
    luaclass.UIRefresh:BindClickCallBack(self.itemIcon_UISprite,function(go)
        if self.CSItemInfo ~= nil then
            uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = self.CSItemInfo})
        end
    end)

    luaclass.UIRefresh:BindClickCallBack(self.WayGetBtn_GameObject,function(go)
        if self.itemInfo ~= nil then
            Utility.ShowItemGetWay(self.itemInfo.id, go, LuaEnumWayGetPanelArrowDirType.Down)
        end
    end)
end
--endregion


--region 刷新
---@param materialInfo CostItemInfo 材料信息类
function UIReforgedPanelTemplates_MaterialTemplate:RefreshPanel(materialInfo)
    self:AnalysisPanel(materialInfo)
    self:RefreshMaterial()
end

---@param materialInfo CostItemInfo 材料信息类
function UIReforgedPanelTemplates_MaterialTemplate:AnalysisPanel(materialInfo)
    if materialInfo == nil or materialInfo.itemId == nil or materialInfo.costNumber == nil then
        return false
    end
    self.materialInfo = materialInfo
    self.itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(materialInfo.itemId)
    local CSItemInfoIsFind,CSItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(materialInfo.itemId)
    if CSItemInfoIsFind then
        self.CSItemInfo = CSItemInfo
    end
    self.needMaterialNumber = materialInfo.costNumber
    self.bagMaterialNumber = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndMoneyCount(self.itemInfo:GetId())
    return true
end

function UIReforgedPanelTemplates_MaterialTemplate:RefreshMaterial()
    luaclass.UIRefresh:RefreshSprite(self.itemIcon_UISprite,self.itemInfo:GetIcon())
    luaclass.UIRefresh:RefreshLabel(self.itemName_UILabel,self.itemInfo:GetName())
    luaclass.UIRefresh:RefreshLabel(self.itemNum_UILabel,  CS.Utility_Lua.SetProgressLabelColor(self.bagMaterialNumber, self.needMaterialNumber))

end

function UIReforgedPanelTemplates_MaterialTemplate:RefreshMaterialNum()
    self.bagMaterialNumber = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndMoneyCount(self.itemInfo:GetId())
    self:RefreshMaterial()
end
--endregion

return UIReforgedPanelTemplates_MaterialTemplate