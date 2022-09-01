local UIItemInfoPanel_Info_ItemList = {}
--region 初始化
function UIItemInfoPanel_Info_ItemList:Init()
    self:InitComponent()
end

function UIItemInfoPanel_Info_ItemList:InitComponent()
    self.title_UILabel = self:Get("title","UILabel")
    self.exchangeItem_UIGridContainer = self:Get("ExchangeItem","UIGridContainer")
end
--endregion

--region 刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_ItemList:RefreshWithInfo(commonData)
    if self:AnalysisParams(commonData) == false then
        self.go:SetActive(false)
    end
    self:RefreshPanel()
end

---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_ItemList:AnalysisParams(commonData)
    if commonData == nil or commonData.itemInfo == nil or commonData.getItemList == nil or commonData.getItemList.Count <= 0 then
        return false
    end
    self.itemInfo = commonData.itemInfo
    self.getItemList = commonData.getItemList
    return true
end

function UIItemInfoPanel_Info_ItemList:RefreshPanel()
    self.titleName = self:GetTitleName()
    self.title_UILabel.gameObject:SetActive(CS.StaticUtility.IsNullOrEmpty(self.titleName) == false)
    if self.title_UILabel ~= nil then
        self.title_UILabel.text = self.titleName
    end
    if self.exchangeItem_UIGridContainer ~= nil then
        self.exchangeItem_UIGridContainer.MaxCount = self.getItemList.Count
        local length = self.exchangeItem_UIGridContainer.MaxCount - 1
        for k = 0,length do
            local grid_Go = self.exchangeItem_UIGridContainer.controlList[k]
            local itemId = self.getItemList[k]
            local itemInfoIsFind,itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
            if itemInfoIsFind ~= nil then
                local itemTemplate = templatemanager.GetNewTemplate(grid_Go,luaComponentTemplates.UIItem_UIItemInfoPanel)
                if itemTemplate ~= nil then
                    itemTemplate:RefreshUIWithItemInfo(itemInfo)
                    itemTemplate:GetEventListener().onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTemplate.ItemInfo,isExhibitionPanel = true })
                    end
                end
            end
        end
    end
end
--endregion

--region 获取
function UIItemInfoPanel_Info_ItemList:GetTitleName()
    --if self.itemInfo ~= nil then
    --    return "可兑换"
    --end
    return ""
end
--endregion
return UIItemInfoPanel_Info_ItemList