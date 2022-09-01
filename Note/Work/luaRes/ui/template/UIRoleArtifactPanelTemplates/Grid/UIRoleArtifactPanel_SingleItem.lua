---@class UIRoleArtifactPanel_SingleItem:TemplateBase 单个物品模板
local UIRoleArtifactPanel_SingleItem = {}

setmetatable(UIRoleArtifactPanel_SingleItem, luaComponentTemplates.UIRefreshTemplate)

--region 数据
---@type number 装备位
UIRoleArtifactPanel_SingleItem.equipIndex = nil
---@type LuaMagicEquipDataItem 法宝装备信息类
UIRoleArtifactPanel_SingleItem.equipItemData = nil
--endregion

--region 初始化
function UIRoleArtifactPanel_SingleItem:Init()
    self:InitComponent()
    self:BindEvents()
end

---初始化组件
function UIRoleArtifactPanel_SingleItem:InitComponent()
    ---@type UnityEngine.GameObject
    self.Item_GameObject = self:Get("", "GameObject")
    ---@type UISprite
    self.icon_UISprite = self:Get("icon", "UISprite")
    ---@type UILabel
    self.count_UILabel = self:Get("count", "UILabel")
    ---@type UILabel
    self.strengthen_UILabel = self:Get("strengthen", "UILabel")
    ---@type UnityEngine.GameObject
    self.Add_GameObject = self:Get("add", "GameObject")
    ---@type UISprite
    self.baseIcon_UISprite = self:Get("baseMap", "UISprite")
end

---绑定事件
function UIRoleArtifactPanel_SingleItem:BindEvents()
    self:BindClickCallBack(self.Item_GameObject, function(obj)
        self:ItemOnClick()
    end)
end

---物品点击
function UIRoleArtifactPanel_SingleItem:ItemOnClick()
    if self.equipItemData == nil then
        return
    end
    local haveEquip = self:GridHaveEquip()
    if haveEquip then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.equipItemData.BagItemInfo, showRight = true })
    else
        local betterEquip = self.equipItemData:GetBestItemByBag()
        if betterEquip ~= nil then
            networkRequest.ReqPutOnTheEquip(self.equipIndex, betterEquip.lid)
        end
    end
end
--endregion

--region 刷新
---刷新面板
---@param commonData table 通用参数
---@param commonData.equipIndex number 装备位
function UIRoleArtifactPanel_SingleItem:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        return
    end
    self:RefreshBackGroundSprite()
    self:RefreshIcon()
    self:RefreshAdd()
    ---当如果是缓存中的模板，刷新是不会吧点击事件重新绑定
    self:BindEvents()
end

---解析参数
---@param commonData table 通用参数
---@return boolean 解析结果
function UIRoleArtifactPanel_SingleItem:AnalysisParams(commonData)
    if commonData == nil or commonData.equipIndex == nil then
        return false
    end
    self.equipIndex = commonData.equipIndex
    self.equipItemData = commonData.equipItemData
    if self.equipItemData == nil then
        return false
    end
    return true
end

---刷新Icon
function UIRoleArtifactPanel_SingleItem:RefreshIcon()
    if self.equipItemData == nil then
        self:RefreshActive(self.icon_UISprite, false)
        return
    end
    ---@type boolean 装备位是否有装备
    local equipIndexHaveItem = self.equipItemData:EquipIndexHaveItem()
    if equipIndexHaveItem then
        self:RefreshSprite(self.icon_UISprite, self.equipItemData.ItemInfo:GetIcon())
    end
    self:RefreshActive(self.icon_UISprite, equipIndexHaveItem)
end

---刷新底图
function UIRoleArtifactPanel_SingleItem:RefreshBackGroundSprite()
    if self.equipItemData ~= nil then
        self:RefreshSprite(self.baseIcon_UISprite, self.equipItemData:GetItemBaseSprite())
        --self:RefreshSprite(self.baseIcon_UISprite,LuaGlobalTableDeal:GetBaseBackGroundSpriteName(self.equipIndex))
    end
end

---刷新Add
function UIRoleArtifactPanel_SingleItem:RefreshAdd()
    if self.equipItemData == nil then
        self:RefreshActive(self.Add_GameObject, false)
        return
    end
    self:RefreshActive(self.Add_GameObject, self.equipItemData.BagItemInfo == nil and self.equipItemData:GetBestItemByBag() ~= nil)
end
--endregion

--region 查询
---格子上是否有装备
---@return boolean
function UIRoleArtifactPanel_SingleItem:GridHaveEquip()
    return self.equipItemData ~= nil and self.equipItemData.BagItemInfo ~= nil
end
--endregion

return UIRoleArtifactPanel_SingleItem