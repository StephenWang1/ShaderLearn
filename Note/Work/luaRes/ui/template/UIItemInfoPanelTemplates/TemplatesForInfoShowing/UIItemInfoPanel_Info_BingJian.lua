---@class UIItemInfoPanel_Info_BingJian:UIItemInfoPanel_Info_Basic
local UIItemInfoPanel_Info_BingJian = {}

setmetatable(UIItemInfoPanel_Info_BingJian, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 组件
function UIItemInfoPanel_Info_BingJian:GetTextLabel_UILabel()
    if self.mMainTitle_UILabel == nil then
        self.mMainTitle_UILabel = self:Get("attributetemplate/title", "UILabel")
    end
    return self.mMainTitle_UILabel
end

function UIItemInfoPanel_Info_BingJian:GetAttrGrid()
    if self.mAttrGrid == nil then
        self.mAttrGrid = self:Get("attributetemplate/Attr", "Top_UIGridContainer")
    end
    return self.mAttrGrid
end

function UIItemInfoPanel_Info_BingJian:GetNextAttrGrid()
    if self.mNextAttrGrid == nil then
        self.mNextAttrGrid = self:Get("attributetemplate/AttrLevel", "Top_UIGridContainer")
    end
    return self.mNextAttrGrid
end
--endregion

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_BingJian:RefreshWithInfo(commonData)
    if commonData == nil then
        return
    end
    self:RefreshBaseAttr(commonData.bagItemInfo, commonData.itemInfo)

end

function UIItemInfoPanel_Info_BingJian:RefreshBaseAttr(bagItemInfo, itemInfo)
    if bagItemInfo == nil and itemInfo == nil then
        return
    end
    local itemId = bagItemInfo and bagItemInfo.itemId or itemInfo.id
    local growth = bagItemInfo and bagItemInfo.growthLevel or 0
    local levelData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetLevelTableByClassTable(itemId)
    local equipLevel = growth
    if equipLevel == nil then
        equipLevel = 0
    end
    local curData, nextData, isMaxLevel = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetCurAndNextTable(equipLevel, levelData)
    local data = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetCurAndNextAttr(curData, nextData, itemId)

    self:GetAttrGrid().MaxCount = #data + 1
    self.allGoAndTemplateDic = {}
    for i = 1, (#data + 1) do
        local go = self:GetAttrGrid().controlList[i - 1]
        if go then
            if self.allGoAndTemplateDic[go] == nil then
                self.allGoAndTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UISLequip_InfoTemplate)
            end
            if i == 1 then
                local temp = {}
                temp.name = "         "
                temp.addStr = "[00ff00]Lv." .. equipLevel
                self.allGoAndTemplateDic[go]:SetTemplate(temp, true)
            else
                self.allGoAndTemplateDic[go]:SetTemplate(data[i - 1], true)
            end
        end
    end
    if isMaxLevel then
        self:GetNextAttrGrid().MaxCount = 0
        return
    end
    self:GetNextAttrGrid().MaxCount = #data + 1
    self.allGoAndTemplateDic = {}
    for i = 1, (#data + 1) do
        local go = self:GetNextAttrGrid().controlList[i - 1]
        if go then
            if self.allGoAndTemplateDic[go] == nil then
                self.allGoAndTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UISLequip_InfoTemplate)
            end
            if i == 1 then
                local temp = {}
                temp.nextStr = "Lv." .. (equipLevel + 1)
                self.allGoAndTemplateDic[go]:SetTemplate(temp, false)
            else
                self.allGoAndTemplateDic[go]:SetTemplate(data[i - 1], false)
            end
        end
    end



end

return UIItemInfoPanel_Info_BingJian