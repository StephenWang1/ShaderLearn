local UIServantPracticeMapPanelTemplate = {}

function UIServantPracticeMapPanelTemplate:InitComponents()
    self.backgroud = self:Get('backgroud', 'GameObject')
    self.checkMark = self:Get('backgroud/checkMark', 'GameObject')

    ---地图名称描述
    self.checkMarkLabel = self:Get('backgroud/checkMark/Label', 'UILabel')

    ---子层级
    self.SecondLayer = self:Get('backgroud/SecondLayer', 'UIGridContainer')
    self.SecondLayerUITable = self:Get('backgroud/SecondLayer', 'Top_UITable')

end
function UIServantPracticeMapPanelTemplate:InitOther()
    CS.UIEventListener.Get(self.backgroud).LuaEventTable = self
    CS.UIEventListener.Get(self.backgroud).OnClickLuaDelegate = self.OnClickMark

end

function UIServantPracticeMapPanelTemplate:Init()
    self:InitComponents()
    self:InitOther()
end

function UIServantPracticeMapPanelTemplate:RefreshUI(data, basePanel)
    if data == nil then
        return
    end
    self.hsMapInfo = data
    self.basePanel = basePanel
    self.baseUITable = basePanel:AllToggleGridContainerTable()

    self.checkMarkLabel.text = data.Name
end

--region 点击事件
function UIServantPracticeMapPanelTemplate:OnClickMark()
    self:Unfold()
    self.basePanel:RefreshLeftTable(self.hsMapInfo.Type)
end

function UIServantPracticeMapPanelTemplate:Fold()
    self.SecondLayer.MaxCount = 0
end

function UIServantPracticeMapPanelTemplate:Unfold()
    local data = self.hsMapInfo.tabList
    self.SecondLayer.MaxCount = #data
    local index = 0
    for i, v in pairs(data) do
        local item = self.SecondLayer.controlList[index].gameObject
        local itemName = CS.Utility_Lua.GetComponent(item.transform:Find("Label"), "UILabel");
        local sprite = CS.Utility_Lua.GetComponent(item.transform:Find("checkMarkBg"), "UISprite");
        itemName.text = "[878787]" .. v.name2
        sprite.spriteName = "MissionOperation_btn1"
        CS.UIEventListener.Get(item).onClick = function(go)

            self.basePanel:SetMapDataInfo(v.map)
            local  nowindex=0
            for i, v in pairs(data) do
                local item2 = self.SecondLayer.controlList[nowindex].gameObject
                local itemName = CS.Utility_Lua.GetComponent(item2.transform:Find("Label"), "UILabel");
                local sprite2 = CS.Utility_Lua.GetComponent(item2.transform:Find("checkMarkBg"), "UISprite");
                if go.name ~= item2.name then
                    itemName.text = "[878787]" .. v.name2
                    sprite2.spriteName = "MissionOperation_btn1"
                else
                    itemName.text = "[FFCDA5]" .. v.name2
                    sprite2.spriteName = "MissionOperation_btn2"
                end
                nowindex=nowindex+1
            end
        end
        index = index + 1
    end
    self.SecondLayerUITable.IsDealy = true
    self.SecondLayerUITable:Reposition()
    if self.baseUITable ~= nil then
        self.baseUITable.IsDealy = true
        self.baseUITable:Reposition()
    end
end

--endregion
return UIServantPracticeMapPanelTemplate