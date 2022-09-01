---获得物品提示模板
local UITreasurePanel_RecordItem = {}

function UITreasurePanel_RecordItem:Init()
    self.data = nil
    self.Label = CS.Utility_Lua.GetComponent(self.go,"Top_UILabel")
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClinkItem
end

function UITreasurePanel_RecordItem:RefreshUI(data)
    self.data = data
    self.str = data.history

    self.mBagItemInfo = data.itemInfo
    self.Label.text = self.str
end

function UITreasurePanel_RecordItem:OnClinkItem()
    if self.data == nil then
        return
    end
    if self.mBagItemInfo ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.mBagItemInfo,showAssistPanel = true,showMoreAssistData = true,showTabBtns= true,showRight = false })
    elseif self.itemInfo ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mItemInfo,showAssistPanel = true,showMoreAssistData = true,showTabBtns= true,showRight = false })
    end
    -- uimanager:CreatePanel("UIItemInfoPanel", nil, LuaEnumItemInfoPanelInitType.InitWithItemInfo, self.data)
end

---解析文本
function UITreasurePanel_RecordItem:AnalysisText(str)
    local text = ""
    local itemId = -1
    local pattern = "item:(\\d+)"
    local isFind
    local item
    local matchCollection = CS.System.Text.RegularExpressions.Regex.Matches(str, pattern)
    if matchCollection ~= nil and matchCollection.Count > 0 then
        if matchCollection[0].Groups[0] ~= nil then
            local itemInfo = tostring(matchCollection[0].Groups[0].Value)
            local strs = string.Split(itemInfo, ":")
            itemId = tonumber(strs[2])
            isFind, item = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
            if isFind then
                text = string.gsub(str, itemInfo, item.name)
            end
        end
    end
    return itemId, item, text
end
return UITreasurePanel_RecordItem