---@class UIConfigPanel_Pickup:UIConfigPanel_PartBasic
local UIConfigPanel_Pickup = {}

setmetatable(UIConfigPanel_Pickup, luaComponentTemplates.UIConfigPanel_PartBasic)

--region 组件
---@return UnityEngine.GameObject 帮助按钮
function UIConfigPanel_Pickup:GetHelpBtn()
    if self.mHelpBtn == nil then
        self.mHelpBtn = self:Get("pickup/helpBtn", "GameObject")
    end
    return self.mHelpBtn
end

---@return UILoopScrollViewPlus 目录
function UIConfigPanel_Pickup:GetMenuList_Loop()
    if self.mMenuListLoop == nil then
        self.mMenuListLoop = self:Get("pickup/ScrollView/loop", "UILoopScrollViewPlus")
    end
    return self.mMenuListLoop
end

---@return UnityEngine.GameObject 详情面板
function UIConfigPanel_Pickup:GetDetail_GO()
    if self.mDetailsGo == nil then
        self.mDetailsGo = self:Get("itemType", "GameObject")
    end
    return self.mDetailsGo
end

---@return UILabel 详情标题
function UIConfigPanel_Pickup:GetDetailName_UILabel()
    if self.mDetailNameLb == nil then
        self.mDetailNameLb = self:Get("itemType/Label", "UILabel")
    end
    return self.mDetailNameLb
end

---@return UILoopScrollViewPlus 详情
function UIConfigPanel_Pickup:GetDetail_Loop()
    if self.mDetailListLoop == nil then
        self.mDetailListLoop = self:Get("itemType/ScrollView/loop", "UILoopScrollViewPlus")
    end
    return self.mDetailListLoop
end
--endregion

--region 初始化
function UIConfigPanel_Pickup:Init(uiConfigPanel)
    self:RunBaseFunction("Init", uiConfigPanel, LuaEnumConfigPanelOpenType.PickupPanel)
    self:BindEvents()
    self:RefreshMenu()
    self:GetDetail_GO():SetActive(false)
end

function UIConfigPanel_Pickup:BindEvents()
    CS.UIEventListener.Get(self:GetHelpBtn()).onClick = function()
        Utility.ShowHelpPanel({ id = 203 })
    end
end
--endregion

--region 设置目录
function UIConfigPanel_Pickup:RefreshMenu()
    local allMenu = {}
    ---@param v TABLE.cfg_pick_up
    clientTableManager.cfg_pick_upManager:ForPair(function(k, v)
        if v:GetEffective() == 1 then
            table.insert(allMenu, v)
        end
    end)

    ---根据order字段排序,升序
    table.sort(allMenu, function(s1, s2)
        if (s1.order == nil or s2.order == nil) then
            return false
        end
        return s1.order < s2.order
    end)

    self:GetMenuList_Loop():Init(function(go, line)
        if line < #allMenu then

            local template = self:GetSingleMenuItemTemplate(go)
            if template then
                template:RefreshMenu(allMenu[line + 1])
            end
            return true
        else
            return false
        end
    end)
end

---@return UIConfigPanel_Pickup_Menu
function UIConfigPanel_Pickup:GetSingleMenuItemTemplate(go)
    if self.mGoToMenuTemplate == nil then
        self.mGoToMenuTemplate = {}
    end
    local template = self.mGoToMenuTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIConfigPanel_Pickup_Menu, self)
        self.mGoToMenuTemplate[go] = template
    end
    return template
end

---设置目录状态,每次存储和服务器数据对比，只有改变了，才在最后请求向服务器存储
---type -parentId为0时父级选项 parentId为父级id是为子级选项
function UIConfigPanel_Pickup:SaveNewMenuState(menuId, type, state)
    if self:GetConfigClass() then
        self:GetConfigClass():ChangeClientConfig(menuId, type, state)
    end
end

---查看详细设置
function UIConfigPanel_Pickup:SelectDetail(menuId, name)
    self:GetDetailName_UILabel().text = name
    self:GetDetail_GO():SetActive(true)
    self:RefreshChooseDetail(menuId)
end
--endregion

--region设置详细文本
---刷新详细信息
function UIConfigPanel_Pickup:RefreshChooseDetail(menuId)
    self.mCurrentChooseMenuId = menuId
    self.mGoToItemId = {}
    local allItem = clientTableManager.cfg_itemsManager:GetPickTypeItemList(menuId)
    if allItem then
        self:GetDetail_Loop():Init(function(go, line)
            if line < #allItem then
                self:RefreshSingleDetailItem(go, allItem[line + 1])
                return true
            else
                return false
            end
        end)
    end
end

---刷新单个详细信息
function UIConfigPanel_Pickup:RefreshSingleDetailItem(go, itemId)
    if go == nil or itemId == nil then
        return
    end
    ---@type UIToggle
    local toggle = self:GetGoToggle(go)
    ---@type UILabel
    local lb = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    ---@type UISprite
    local icon = CS.Utility_Lua.Get(go.transform, "Item/Item/icon", "UISprite")

    local itemGo = CS.Utility_Lua.Get(go.transform, "Item", "GameObject")
    local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if luaItemInfo == nil then
        return
    end

    self.mGoToItemId[go] = itemId
    lb.text = luaItemInfo:GetName()
    icon.spriteName = luaItemInfo:GetIcon()
    local singleState = self:IsItemValid(itemId, self.mCurrentChooseMenuId)
    toggle:Set(singleState)
end

---@return UIToggle 存储单个GO对应的toggle
function UIConfigPanel_Pickup:GetGoToggle(go)
    if self.mGoToToggle == nil then
        self.mGoToToggle = {}
    end
    ---@type UIToggle
    local toggle = self.mGoToToggle[go]
    if toggle == nil then
        toggle = CS.Utility_Lua.Get(go.transform, "Type", "UIToggle")
        self.mGoToToggle[go] = toggle
        CS.EventDelegate.Add(toggle.onChange, function()
            self:OnSingleStateChanged(go, toggle.value)
        end)
    end
    return toggle
end

---单个Toggle变化
function UIConfigPanel_Pickup:OnSingleStateChanged(go, chooseState)
    if self.mGoToItemId == nil then
        return
    end
    local itemId = self.mGoToItemId[go]
    if itemId == nil then
        return
    end
    local singleState = self:IsItemValid(itemId, self.mCurrentChooseMenuId)
    if singleState ~= chooseState then
        self:SaveNewMenuState(itemId, self.mCurrentChooseMenuId, chooseState)
    end
end
--endregion

--region 数据获取
---@return CSConfigInfo
function UIConfigPanel_Pickup:GetConfigClass()
    if self.uiConfigPanel then
        return self.uiConfigPanel.Config
    end
end

---某个选项是否勾选
---@param id number 大类是pickup表id/小类是itemId
---@param type number 类型 1大类/2小类
function UIConfigPanel_Pickup:IsItemValid(id, type)
    if self:GetConfigClass() then
        return self:GetConfigClass():IsValidConfig(id, type)
    end
    return false
end
--endregion

--region Destroy
function UIConfigPanel_Pickup:DestroyPanel()
    if self:GetConfigClass() then
        self:GetConfigClass():ReqSaveClientConfig()
    end
end
--endregion


return UIConfigPanel_Pickup