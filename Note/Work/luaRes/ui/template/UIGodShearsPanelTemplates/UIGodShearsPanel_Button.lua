local UIGodShearsPanel_Button = {}
--region 组件
function UIGodShearsPanel_Button:Init()
    self:InitComponent()
    self:BindEvents()
end

function UIGodShearsPanel_Button:InitComponent()
    self.backGround_UISprite = self:Get("background","UISprite")
    self.titleName_UILabel = self:Get("TitleName","UILabel")
end

function UIGodShearsPanel_Button:BindEvents()
    if CS.StaticUtility.IsNull(self.go) == false then
        CS.UIEventListener.Get(self.go).onClick = function(go)
            self:DeliverBtnOnClick(go)
        end
    end
end
--endregion

--region 刷新
function UIGodShearsPanel_Button:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        uimanager:ClosePanel("UIGodShearsPanel")
        return
    end
    self:RefreshBtn()
end

function UIGodShearsPanel_Button:AnalysisParams(commonData)
    if commonData == nil or commonData.deliverTableInfo == nil then
        return false
    end
    self.deliverTableInfo = commonData.deliverTableInfo
    self.tableIsFind,self.mapTableInfo = CS.Cfg_MapTableManager.Instance:TryGetValue(self.deliverTableInfo.toMapId)
    self.index = commonData.index
    self.mapCanEnter = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(self.deliverTableInfo.condition)
    self:GetMapName()
    return true
end

function UIGodShearsPanel_Button:GetMapName()
    if self.deliverTableInfo ~= nil then
        self.conditionType,self.conditionParams = Utility.GetConditionParams(self.deliverTableInfo.condition)
        local conditionName = ""
        if self.conditionType ~= nil and self.conditionParams ~= nil then
            if self.conditionType == Utility.EnumToInt(CS.EConditionType.NotLowerThan_Level) then
                conditionName = tostring(self.conditionParams) .."级"
            end
        end
        if self.mapCanEnter == true then
            self.mapName = "[C3F4FFFF]" .. self.deliverTableInfo.showName .. "[-] [6B99A2]" .. conditionName .. "[-]"
        else
            self.mapName = "[878787]" .. self.deliverTableInfo.showName .. conditionName
        end
    end
    return self.mapName
end

function UIGodShearsPanel_Button:RefreshBtn()
    if CS.StaticUtility.IsNull(self.titleName_UILabel) == false then
        self.titleName_UILabel.text = self.mapName
    end
    if CS.StaticUtility.IsNull(self.backGround_UISprite) == false then
        self.backGround_UISprite.spriteName = ternary(self.mapCanEnter == true,"c3","c5")
    end
end
--endregion

--region 点击事件
function UIGodShearsPanel_Button:DeliverBtnOnClick(go)
    if self.deliverTableInfo ~= nil and self.mapTableInfo ~= nil then
        local conditionId = self.deliverTableInfo.condition
        if self.mapCanEnter == false then
            Utility.ShowConditionPop(go,conditionId)
            return
        end
        local costTable = string.Split(self.deliverTableInfo.item,'#')
        if costTable ~= nil and type(costTable) == 'table' and #costTable > 1 then
            local costItemId = tonumber(costTable[1])
            local costPrice = tonumber(costTable[2])
            local param = {}
            param.Content = "[fffff0]是否要传送到 " .. self.deliverTableInfo.showName
            param.CenterDescription = "[c3f4ff]传送[-]"
            param.IsShowGoldLabel = true
            if costItemId ~= 0 and costPrice > 0 then
                ---@type TABLE.CFG_ITEMS
                local tbl = CS.Cfg_ItemsTableManager.Instance:GetItems(costItemId)
                if tbl ~= nil then
                    param.GoldIcon = tbl.icon
                    param.GoldCount = costPrice
                end
            end
            param.CallBack = function()
                networkRequest.ReqDeliverByConfig(self.deliverTableInfo.id)
            end
            uimanager:CreatePanel("UIPromptPanel", nil, param)
            uimanager:ClosePanel("UIGodShearsPanel")
            return
        end
        networkRequest.ReqDeliverByConfig(self.deliverTableInfo.id)
    end
end
--endregion

return UIGodShearsPanel_Button