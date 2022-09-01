---@class UIHireMinersPanel:UIBase 矿工
local UIHireMinersPanel = {}

function UIHireMinersPanel:Init()
    self:AddCollider()
    self:InitComponents()
    self:InitOther()
end
--通过工具生成 控件变量
function UIHireMinersPanel:InitComponents()

    --雇佣按钮
    UIHireMinersPanel.EnterBtn = self:GetCurComp("WidgetRoot/events/EnterBtn", "GameObject")
    --雇佣按钮描述
    UIHireMinersPanel.EnterBtnLabel = self:GetCurComp("WidgetRoot/events/EnterBtn/Label", "Top_UILabel")
    --关闭按钮
    UIHireMinersPanel.CloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    --帮助按钮
    UIHireMinersPanel.HelpBtn = self:GetCurComp("WidgetRoot/events/HelpBtn", "GameObject")

    --标题（选择矿工）
    UIHireMinersPanel.title = self:GetCurComp("WidgetRoot/view/ChooseMiners/title", "Top_UILabel")
    --挖矿状态
    UIHireMinersPanel.lb_state = self:GetCurComp("WidgetRoot/view/ChooseMiners/lb_state", "Top_UILabel")
    --剩余时间
    UIHireMinersPanel.lb_time = self:GetCurComp("WidgetRoot/view/ChooseMiners/lb_time", "UICountdownLabel")
     --完成时间
    UIHireMinersPanel.lb_complete = self:GetCurComp("WidgetRoot/view/ChooseMiners/lb_complete", "Top_UILabel")
    --矿工成员Grid
    UIHireMinersPanel.MinersGrid = self:GetCurComp("WidgetRoot/view/ChooseMiners/MinersList/Grid", "Top_UIGridContainer")


    --挖掘数量面板
    UIHireMinersPanel.Reward = self:GetCurComp("WidgetRoot/view/Reward", "GameObject")
    -- --挖掘数量面板
    -- UIHireMinersPanel.NoHire = self:GetCurComp("WidgetRoot/view/NoHire", "GameObject")
    --挖掘数量Grid
    UIHireMinersPanel.RewardGrid = self:GetCurComp("WidgetRoot/view/Reward/ScrollView/Awards", "Top_UIGridContainer")

    --矿区坐标面板
    UIHireMinersPanel.Location = self:GetCurComp("WidgetRoot/view/Location", "GameObject")
    --矿区坐标
    UIHireMinersPanel.LocationLabel = self:GetCurComp("WidgetRoot/view/Location/location", "Top_UILabel")
    --坐标刷新
    UIHireMinersPanel.LocationrefreshBtn = self:GetCurComp("WidgetRoot/view/Location/location/btn_add", "GameObject")
    --雇佣按钮
    UIHireMinersPanel.HireBtn = self:GetCurComp("WidgetRoot/view/Location/HireBtn", "GameObject")
    --花费金额
    UIHireMinersPanel.costvalue = self:GetCurComp("WidgetRoot/view/Location/costvalue/costvalue", "Top_UILabel")
    --花费Icon
    UIHireMinersPanel.costvalueIcon = self:GetCurComp("WidgetRoot/view/Location/costvalue/costvalue/icon", "Top_UISprite")
    --雇佣次数
    UIHireMinersPanel.hirevalue = self:GetCurComp("WidgetRoot/view/Location/costvalue/hirevalue", "Top_UILabel")




end
--初始化 变量 按钮点击 服务器消息事件等
function UIHireMinersPanel:InitOther()
    UIHireMinersPanel.NoHirePoint = -80
    CS.UIEventListener.Get(UIHireMinersPanel.CloseBtn).onClick = UIHireMinersPanel.OnClickCloseBtn
    CS.UIEventListener.Get(UIHireMinersPanel.EnterBtn).onClick = UIHireMinersPanel.OnClickEnterBtn
    CS.UIEventListener.Get(UIHireMinersPanel.HelpBtn).onClick = UIHireMinersPanel.OnClickHelpBtn

    CS.UIEventListener.Get(UIHireMinersPanel.LocationrefreshBtn.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(UIHireMinersPanel.LocationrefreshBtn.gameObject).OnClickLuaDelegate = self.RefreShMinerInfoPosition

    CS.UIEventListener.Get(UIHireMinersPanel.HireBtn.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(UIHireMinersPanel.HireBtn.gameObject).OnClickLuaDelegate = self.HiretMiner

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGetMinerInfoMessage, UIHireMinersPanel.ResGetMinerInfoMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUpdateMineInfoMessage, UIHireMinersPanel.ResUpdateMineInfoMessage)


end
function UIHireMinersPanel:Show()
    networkRequest.ReqGetMinerInfo()
    --  CS.CSScene.MainPlayerInfo.HireMinersInfo:ReqGetMinerInfoMessage()
    self.ResGetMinerInfoMessage()
end

---刷新矿工成员
function UIHireMinersPanel.RefreshMinersGrid(HireMinersInfoList)
    UIHireMinersPanel.MinersGrid.MaxCount = HireMinersInfoList.Count
    for i = 0, HireMinersInfoList.Count - 1 do
        local item = UIHireMinersPanel.MinersGrid.controlList[i].gameObject
        local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UIHireMiners_MinerTemplate)
        template:RefreshUI(HireMinersInfoList[i], UIHireMinersPanel, i)
    end
end

---刷新挖矿数量
function UIHireMinersPanel.RefreshRewardGrid(MineItemInfoList)
    local count = 5;
    if MineItemInfoList.Count > 5 then
        count = MineItemInfoList.Count;
    end
    local MaxCount = count
    UIHireMinersPanel.RewardGrid.MaxCount = MaxCount

    for i = 0, MaxCount - 1 do
        local item = UIHireMinersPanel.RewardGrid.controlList[i].gameObject
        local label = CS.Utility_Lua.GetComponent(item.transform:Find("count"), "Top_UILabel")
        local icon = CS.Utility_Lua.GetComponent(item.transform:Find("icon"), "Top_UISprite")
        if MineItemInfoList.Count > i then
            local Tab_Item = MineItemInfoList[i].Tab_Item
            local count = MineItemInfoList[i].Count
            if label ~= nil then
                label.text = count
            end
            if icon ~= nil then
                icon.gameObject:SetActive(true)
                icon.spriteName = Tab_Item.icon
            end
            CS.UIEventListener.Get(item.gameObject).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = Tab_Item })
            end
        else
            if label ~= nil then
                label.text = ""
            end
            if icon ~= nil then
                icon.gameObject:SetActive(false)
            end
        end
    end
end

---
---刷新
function UIHireMinersPanel.RefreshRewardOpen()
    if UIHireMinersPanel.HireMinersInfoList == nil then
        return
    end
    local count = UIHireMinersPanel.HireMinersInfoList.Count
    UIHireMinersPanel.isHaveMinersState = false
    UIHireMinersPanel.isMinersDeath = false
    for i = 0, count - 1 do
        if not UIHireMinersPanel.HireMinersInfoList[i].IsCanMayEmployed then
            UIHireMinersPanel.isHaveMinersState = true
        end
    end
    if UIHireMinersPanel.MineItemInfoList ~= nil and UIHireMinersPanel.MineItemInfoList.Count > 0 then
        UIHireMinersPanel.isHaveMinersState = true
    end
    if UIHireMinersPanel.HireMinersInfo~=nil and UIHireMinersPanel.HireMinersInfo.Type==CS.HireMinersActivityType.Death and (UIHireMinersPanel.MineItemInfoList==nil or UIHireMinersPanel.MineItemInfoList.Count == 0)  then
        UIHireMinersPanel.isHaveMinersState=false
        UIHireMinersPanel.isMinersDeath=true
    end
    UIHireMinersPanel.costvalue.gameObject:SetActive(not  UIHireMinersPanel.isMinersDeath)
    UIHireMinersPanel.Location.gameObject:SetActive(not UIHireMinersPanel.isHaveMinersState)
    UIHireMinersPanel.Reward.gameObject:SetActive(UIHireMinersPanel.isHaveMinersState)
  -- UIHireMinersPanel.NoHire.gameObject:SetActive(not UIHireMinersPanel.isHaveMinersState)
    -- if UIHireMinersPanel.HireMinersInfoList ~= nil then
    --     UIHireMinersPanel.NoHire.transform.localPosition = CS.UnityEngine.Vector3(0, UIHireMinersPanel.NoHirePoint * UIHireMinersPanel.HireMinersInfoList.Count, 0);
    -- end
    UIHireMinersPanel.EnterBtn.gameObject:SetActive(UIHireMinersPanel.isHaveMinersState)

end

---刷新选择的矿工信息
function UIHireMinersPanel:RefreShSelectMinerInfo(HireMinersInfo, tab_kuanggong)
    UIHireMinersPanel.tab_kuanggong = tab_kuanggong
    UIHireMinersPanel.HireMinersInfo = HireMinersInfo
    UIHireMinersPanel.costvalue.text = HireMinersInfo.Costvalue
    UIHireMinersPanel.costvalueIcon.spriteName = HireMinersInfo.IconName
    UIHireMinersPanel.SelectLocation = nil
    UIHireMinersPanel.kuangGongGatherPointList = CS.Cfg_KuangGongShuaiJianManager.Instance:GetPointList(HireMinersInfo.Tab_id)
    if UIHireMinersPanel.kuangGongGatherPointList ~= nil and UIHireMinersPanel.kuangGongGatherPointList.Count > 0 then
        UIHireMinersPanel.SelectLocation = UIHireMinersPanel.kuangGongGatherPointList[0]
    end
    UIHireMinersPanel.Location.gameObject:SetActive((not UIHireMinersPanel.isHaveMinersState) and UIHireMinersPanel.HireMinersInfo ~= nil)
    UIHireMinersPanel.LocationLabel.text = UIHireMinersPanel:SetPointListShowInfo(UIHireMinersPanel.SelectLocation.x, UIHireMinersPanel.SelectLocation.y)
    UIHireMinersPanel.RefreShMinerState()
end

---刷新矿工坐标
function UIHireMinersPanel:RefreShMinerInfoPosition()
    if UIHireMinersPanel.kuangGongGatherPointList ~= nil then
        local random = math.random(0, self.kuangGongGatherPointList.Count - 1)
        UIHireMinersPanel.SelectLocation = self.kuangGongGatherPointList[random]
        UIHireMinersPanel.LocationLabel.text = UIHireMinersPanel:SetPointListShowInfo(UIHireMinersPanel.SelectLocation.x, UIHireMinersPanel.SelectLocation.y)
    end
end

---刷新矿工状态
function UIHireMinersPanel.RefreShMinerState()
    if UIHireMinersPanel.HireMinersInfo == nil then
        return
    end
    local IsCanMayEmployed = UIHireMinersPanel.HireMinersInfo.IsCanMayEmployed
    local Type = UIHireMinersPanel.HireMinersInfo.Type
    local strdic = ''
    UIHireMinersPanel.title.gameObject:SetActive(false)
    UIHireMinersPanel.lb_state.gameObject:SetActive(false)
    UIHireMinersPanel.lb_time.gameObject:SetActive(false)
    UIHireMinersPanel.lb_complete.gameObject:SetActive(Type ==  CS.HireMinersActivityType.Accomplish)
    if Type ==  CS.HireMinersActivityType.MiningIng then
        strdic = "[00FF00]正在挖矿中"
        UIHireMinersPanel.lb_time:StartCountDown(nil, 3, UIHireMinersPanel.HireMinersInfo.EndTime, "(剩余时间 ", " )")
    elseif Type ==  CS.HireMinersActivityType.Accomplish then
        strdic = "[00FF00]完成本次挖矿"
        UIHireMinersPanel.lb_time.gameObject:SetActive(false)
        UIHireMinersPanel.lb_complete.text='(挖矿'..UIHireMinersPanel.HireMinersInfo.Tab_kuanggong.Tab_kuanggong.time ..'小时）'
    elseif Type ==  CS.HireMinersActivityType.Death then
        strdic = "[ff0000]矿工被击杀"
        UIHireMinersPanel.lb_time:StartCountDown(nil, 3, UIHireMinersPanel.HireMinersInfo.EndTime, "(剩余时间 ", " )")
    end
    UIHireMinersPanel.lb_state.text=strdic

    UIHireMinersPanel.hirevalue.text="[878787]雇佣次数[-]    "..UIHireMinersPanel.HireMinersInfo.SurplusCount.."[878787]/" ..UIHireMinersPanel.HireMinersInfo.MaxCount.. "[-]"

end

--雇佣矿工
function UIHireMinersPanel:HiretMiner()
    if UIHireMinersPanel.HireMinersInfo == nil then
        return
    end
    if  UIHireMinersPanel.isMinersDeath then
        local KuangGongGatherPoint = UIHireMinersPanel.SelectLocation
        networkRequest.ReqHireMiner(UIHireMinersPanel.HireMinersInfo.Tab_id, KuangGongGatherPoint.x, KuangGongGatherPoint.y)
        return
    end
    if UIHireMinersPanel.tab_kuanggong ~= nil and CS.CSScene.MainPlayerInfo ~= nil then
        if UIHireMinersPanel.tab_kuanggong.level > CS.CSScene.MainPlayerInfo.Level then
            local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(247)
            if isfind == false then
                return
            end
            local direction = data.content
            local strList = string.Split(direction, "#")
            local str = "";
            if #strList == 2 then
                str = strList[1] .. UIHireMinersPanel.tab_kuanggong.level .. strList[2]
            else
                str = "请" .. UIHireMinersPanel.tab_kuanggong.level .. "级再来雇佣"
            end
            Utility.ShowPopoTips(UIHireMinersPanel.HireBtn.transform, str, 247, "UIHireMinersPanel")
            return
        end
    end
  
    local bagItemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinNum(UIHireMinersPanel.HireMinersInfo.CostvalueItemID)
    if tonumber(bagItemCount) < tonumber(UIHireMinersPanel.HireMinersInfo.Costvalue) then
        UIHireMinersPanel.ShowTip(UIHireMinersPanel.HireBtn.transform, UIHireMinersPanel.HireMinersInfo.CostvalueItem.name)
        return
    end

    local KuangGongGatherPoint = UIHireMinersPanel.SelectLocation
    networkRequest.ReqHireMiner(UIHireMinersPanel.HireMinersInfo.Tab_id, KuangGongGatherPoint.x, KuangGongGatherPoint.y)


end

function UIHireMinersPanel.ShowTip(go, name)
    local isFind, BubbleInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(67)
    if isFind then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Describe] = string.format(BubbleInfo.content, name)
        TipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 67
        TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIHireMinersPanel"
        uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    end
end

function UIHireMinersPanel:SetPointListShowInfo(x, y)
    if x == 0 and y == 0 and UIHireMinersPanel.HireMinersInfo ~= nil then
        local kuangGongGatherPointList = CS.Cfg_KuangGongShuaiJianManager.Instance:GetPointList(UIHireMinersPanel.HireMinersInfo.Tab_id)
        if kuangGongGatherPointList ~= nil and kuangGongGatherPointList.Count > 0 then
            x = kuangGongGatherPointList[0].x
            y = kuangGongGatherPointList[0].y
            UIHireMinersPanel.SelectLocation = kuangGongGatherPointList[0]
        end
    end
    return "比奇矿区一层  " .. tostring(x) .. "," .. tostring(y)

end


--region 服务器消息
---请求查看矿工信息
function UIHireMinersPanel.ResGetMinerInfoMessage()
    UIHireMinersPanel.HireMinersInfoList = CS.CSScene.MainPlayerInfo.HireMinersInfo.HireMinersInfoList
    UIHireMinersPanel.MineItemInfoList = CS.CSScene.MainPlayerInfo.HireMinersInfo.MineItemInfoList
    UIHireMinersPanel.RefreshMinersGrid(UIHireMinersPanel.HireMinersInfoList)
    UIHireMinersPanel.RefreshRewardGrid(UIHireMinersPanel.MineItemInfoList)
    UIHireMinersPanel.RefreshRewardOpen()
end

---刷新矿石信息
function UIHireMinersPanel.ResUpdateMineInfoMessage()
    UIHireMinersPanel.MineItemInfoList = CS.CSScene.MainPlayerInfo.HireMinersInfo.MineItemInfoList
    UIHireMinersPanel.RefreshRewardGrid(UIHireMinersPanel.MineItemInfoList)
    UIHireMinersPanel.RefreshRewardOpen()
end

--endregion
--region 请求领取矿石
function UIHireMinersPanel.OnClickEnterBtn(go)
    networkRequest.ReqReceiveMineral()
end
--关闭
function UIHireMinersPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel('UIHireMinersPanel')
end
--帮助
function UIHireMinersPanel.OnClickHelpBtn(go)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(113)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end
--endregion
function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResGetMinerInfoMessage, UIHireMinersPanel.ResGetMinerInfoMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResUpdateMineInfoMessage, UIHireMinersPanel.ResUpdateMineInfoMessage)
end
return UIHireMinersPanel