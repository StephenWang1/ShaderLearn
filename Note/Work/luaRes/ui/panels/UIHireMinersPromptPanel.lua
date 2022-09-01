local UIHireMinersPromptPanel = {}

function UIHireMinersPromptPanel:Init()
    self:InitComponents()
    self:InitOther()
end
--通过工具生成 控件变量
function UIHireMinersPromptPanel:InitComponents()
    ---标题显示
    UIHireMinersPromptPanel.Title = self:GetCurComp("WidgetRoot/window/Title", "Top_UILabel")
    --位置选中显示
    UIHireMinersPromptPanel.location = self:GetCurComp("WidgetRoot/Location/location", "Top_UILabel")
    --下拉箭头
    UIHireMinersPromptPanel.locationBtn_add = self:GetCurComp("WidgetRoot/Location/location/btn_add", "GameObject")
    --位置下拉面板
    UIHireMinersPromptPanel.LocationList = self:GetCurComp("WidgetRoot/Location/LocationDown", "GameObject")
    --位置列表Grid
    UIHireMinersPromptPanel.LocationGrid = self:GetCurComp("WidgetRoot/Location/LocationDown/LocationList/Grid", "Top_UIGridContainer")
    --位置下拉遮罩
    UIHireMinersPromptPanel.shade = self:GetCurComp("WidgetRoot/Location/LocationDown/shade", "GameObject")

    --花费金额
    UIHireMinersPromptPanel.costvalue = self:GetCurComp("WidgetRoot/Cost/costvalue", "Top_UILabel")
    --花费Icon
    UIHireMinersPromptPanel.icon = self:GetCurComp("WidgetRoot/Cost/costvalue/icon", "Top_UISprite")
    --雇佣次数
    UIHireMinersPromptPanel.hirevalue = self:GetCurComp("WidgetRoot/Cost/hirevalue", "Top_UILabel")
    ---雇佣按钮
    UIHireMinersPromptPanel.ConfirmBtn = self:GetCurComp("WidgetRoot/ConfirmBtn", "GameObject")
    --关闭按钮
    UIHireMinersPromptPanel.CloseBtn = self:GetCurComp("WidgetRoot/window/CloseBtn", "GameObject")

end
--初始化 变量 按钮点击 服务器消息事件等
function UIHireMinersPromptPanel:InitOther()
    UIHireMinersPromptPanel.HireMinersInfo = nil
    UIHireMinersPromptPanel.SelectLocation = nil
    UIHireMinersPromptPanel.showInfo = "比奇矿区一层 "
    CS.UIEventListener.Get(UIHireMinersPromptPanel.CloseBtn.gameObject).onClick = UIHireMinersPromptPanel.OnClickCloseBtn
    CS.UIEventListener.Get(UIHireMinersPromptPanel.locationBtn_add.gameObject).onClick = UIHireMinersPromptPanel.OnClickLocationBtn_add
    CS.UIEventListener.Get(UIHireMinersPromptPanel.ConfirmBtn.gameObject).onClick = UIHireMinersPromptPanel.OnClickConfirmBtn
    CS.UIEventListener.Get(UIHireMinersPromptPanel.shade.gameObject).onClick = UIHireMinersPromptPanel.OnClickShade


end
--@class HireMinersInfo
function UIHireMinersPromptPanel:Show(HireMinersInfo)
    UIHireMinersPromptPanel.HireMinersInfo = HireMinersInfo
    if HireMinersInfo == nil then
        return
    end
    UIHireMinersPromptPanel.Title.text = HireMinersInfo.Tab_kuanggong.tips
    UIHireMinersPromptPanel.costvalue.text = HireMinersInfo.Costvalue
    UIHireMinersPromptPanel.icon.spriteName = HireMinersInfo.CostvalueItemID
    UIHireMinersPromptPanel.hirevalue.text = '[878787]雇佣次数[-]    ' .. tostring(HireMinersInfo.SurplusCount) .. '/' .. tostring(HireMinersInfo.MaxCount)
    UIHireMinersPromptPanel.location.text = UIHireMinersPromptPanel.SetPointListShowInfo(HireMinersInfo.Point.x, HireMinersInfo.Point.y)

end

function UIHireMinersPromptPanel.RefreshLocationPanelInfo(data)
    local activeInHierarchy = UIHireMinersPromptPanel.LocationList.gameObject.activeInHierarchy
    UIHireMinersPromptPanel.LocationList.gameObject:SetActive(not activeInHierarchy)
    if activeInHierarchy then
        return
    end
    local kuangGongGatherPointList = CS.Cfg_KuangGongShuaiJianManager.Instance:GetPointList(data)
    local MaxCount = kuangGongGatherPointList.Count
    UIHireMinersPromptPanel.LocationGrid.MaxCount = MaxCount

    for i = 0, MaxCount - 1 do
        local item = UIHireMinersPromptPanel.LocationGrid.controlList[i].gameObject
        local label = CS.Utility_Lua.GetComponent(item.transform:Find("lb_location"), "Top_UILabel")
        if label ~= nil then
            label.text = UIHireMinersPromptPanel.SetPointListShowInfo(kuangGongGatherPointList[i].x, kuangGongGatherPointList[i].y)
        end
        CS.UIEventListener.Get(item.gameObject).onClick = function()
            UIHireMinersPromptPanel.SelectLocation = kuangGongGatherPointList[i]
            UIHireMinersPromptPanel.location.text = label.text
            UIHireMinersPromptPanel.OnClickShade()
        end
    end
end

---默认点
function UIHireMinersPromptPanel:DefaultPoint()

end

---设置位置显示信息
function UIHireMinersPromptPanel.SetPointListShowInfo(x, y)
    if x == 0 and y == 0 and UIHireMinersPromptPanel.HireMinersInfo ~= nil then
        local kuangGongGatherPointList = CS.Cfg_KuangGongShuaiJianManager.Instance:GetPointList(UIHireMinersPromptPanel.HireMinersInfo.Tab_id)
        if kuangGongGatherPointList ~= nil and kuangGongGatherPointList.Count > 0 then
            x = kuangGongGatherPointList[0].x
            y = kuangGongGatherPointList[0].y
            UIHireMinersPromptPanel.SelectLocation = kuangGongGatherPointList[0]
        end
    end
    return "比奇矿区一层  " .. tostring(x) .. "," .. tostring(y)

end

function UIHireMinersPromptPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel('UIHireMinersPromptPanel')
end

function UIHireMinersPromptPanel.OnClickLocationBtn_add()
    if UIHireMinersPromptPanel.HireMinersInfo == nil then
        return
    end
    UIHireMinersPromptPanel.RefreshLocationPanelInfo(UIHireMinersPromptPanel.HireMinersInfo.Tab_id)
end

---点击雇佣
function UIHireMinersPromptPanel.OnClickConfirmBtn(go)
    if UIHireMinersPromptPanel.HireMinersInfo == nil then
        return
    end
    local bagItemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(UIHireMinersPromptPanel.HireMinersInfo.CostvalueItemID)
    if tonumber(bagItemCount) <= tonumber(UIHireMinersPromptPanel.HireMinersInfo.Costvalue) then
        UIHireMinersPromptPanel.ShowTip(go.transform, UIHireMinersPromptPanel.HireMinersInfo.CostvalueItem.name)
        return
    end

    local KuangGongGatherPoint = UIHireMinersPromptPanel.SelectLocation
    networkRequest.ReqHireMiner(UIHireMinersPromptPanel.HireMinersInfo.Tab_id, KuangGongGatherPoint.x, KuangGongGatherPoint.y)
    uimanager:ClosePanel('UIHireMinersPromptPanel')
end

function UIHireMinersPromptPanel.ShowTip(go, name)
    local isFind, BubbleInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(67)
    if isFind then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Describe] = string.format(BubbleInfo.content, name)
        TipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 67
        TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIHireMinersPromptPanel"
        uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    end
end

function UIHireMinersPromptPanel.OnClickShade()
    UIHireMinersPromptPanel.LocationList.gameObject:SetActive(false)
end

function ondestroy()

end

return UIHireMinersPromptPanel