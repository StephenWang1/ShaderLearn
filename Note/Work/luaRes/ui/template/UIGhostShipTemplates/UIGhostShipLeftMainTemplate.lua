---@class UIGhostShipLeftMainTemplate :TemplateBase 副本传送单元模板
local UIGhostShipLeftMainTemplate = {}

--region 初始化

function UIGhostShipLeftMainTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
end

function UIGhostShipLeftMainTemplate:InitComponents()
    ---@type Top_UISprite ICON
    self.bg = self:Get("icon", "Top_UISprite")
end

function UIGhostShipLeftMainTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go.gameObject).onClick = function(go)
        self:OnClickedSelf()
    end
end

--endregion

--region Show

---@param data
---@field data TABLE.CFG_DUPLICATE
function UIGhostShipLeftMainTemplate:SetTemplate(data)
    if data == nil then
        return
    end
    self.data = data
    self:RefreshView()
end

--endregion

--region View

function UIGhostShipLeftMainTemplate:RefreshView()
    local itemTbl = self:GetItemTable()
    self.bg.spriteName = itemTbl.icon
end

function UIGhostShipLeftMainTemplate:OnClickedSelf()
    local itemTbl = self:GetItemTable()
    if itemTbl then
        uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = itemTbl,showRight = false})
    end
end

--endregion

--region 读取表

function UIGhostShipLeftMainTemplate:GetItemTable()
    local isFind, itemTbl = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.data)
    if isFind then
        return itemTbl
    end
end

--endregion


return UIGhostShipLeftMainTemplate