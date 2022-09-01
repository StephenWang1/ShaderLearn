local UISpecialMissionEliteBossPanel = {}

function UISpecialMissionEliteBossPanel:InitComponents()
    ---节点
    self.up = self:GetCurComp("WidgetRoot/up", "GameObject")
    self.center = self:GetCurComp("WidgetRoot/center", "GameObject")
    self.down = self:GetCurComp("WidgetRoot/down", "GameObject")
    self.other = self:GetCurComp("WidgetRoot/other", "GameObject")

    ---top
    ---标题名称
    self.lb_name = self:GetCurComp("WidgetRoot/up/lb_name", "UILabel")
    ---顶部描述
    self.lb_dec = self:GetCurComp("WidgetRoot/up/lb_dec", "UILabel")
    ---关闭按钮
    self.btn_close = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")

    ---center
    ---怪物信息提示
    self.BossKillTips = self:GetCurComp("WidgetRoot/center/BossKillTips/view/Public", "GameObject")

    ---down
    ---奖励列表
    self.rewardList = self:GetCurComp("WidgetRoot/down/rewardList", "GameObject")
    ---前往击杀
    self.btn_GotoKill = self:GetCurComp("WidgetRoot/down/btn_sure", "GameObject")
    ---一倍领取
    self.btn_get = self:GetCurComp("WidgetRoot/down/btn_get1", "GameObject")
    ---二倍领取
    self.btn_double = self:GetCurComp("WidgetRoot/down/btn_get2", "GameObject")
    ---二倍领取花费
    self.cost = self:GetCurComp('WidgetRoot/down/btn_get2', 'GameObject')
    self.costLabel = self:GetCurComp('WidgetRoot/down/btn_get2/lb_cost', 'UILabel')
    self.costIcon = self:GetCurComp('WidgetRoot/down/btn_get2/lb_cost/Sprite', 'UISprite')

    ---other
    self.buy = self:GetCurComp('WidgetRoot/other/GetNum', 'GameObject')

end
function UISpecialMissionEliteBossPanel:InitOther()
    CS.UIEventListener.Get(self.btn_GotoKill).onClick = self.GotoKill
    CS.UIEventListener.Get(self.btn_get).onClick = self.OnwReceiveAward
    CS.UIEventListener.Get(self.btn_double).onClick = self.TwoReceiveAward
    CS.UIEventListener.Get(self.btn_close).onClick = self.OnClikeBlackbox
    CS.UIEventListener.Get(self.buy).onClick = self.OnClikebuy

    UISpecialMissionEliteBossPanel:GetClientEventHandler():AddEvent(CS.CEvent.Task_GoalUpdate, UISpecialMissionEliteBossPanel.OnResEliteTaskInfoPanelMessage)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Task_EliteSelectLevel, self.RefreShNowSelectLevelInfo)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEliteTaskInfoPanelMessage, UISpecialMissionEliteBossPanel.OnResEliteTaskInfoPanelMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEliteBuyPriceMessage, UISpecialMissionEliteBossPanel.OnResEliteBuyPriceMessage)
    
end

function UISpecialMissionEliteBossPanel:Init()
    self:InitComponents()
    self:InitOther()
   -- self:InitData()
    self.RefreshUI()
end

function UISpecialMissionEliteBossPanel:InitData()
    self.EliteTaskCount=CS.CSMissionManager.Instance.EliteTaskCount
    self.csmission = CS.CSMissionManager.Instance:GetEliteTask()
    if self.csmission == nil then
        return
    end
    self.Tab_Task = self.csmission.tbl_tasks
    self.tbl_taskBoss = self.csmission.tbl_taskBoss
end


function UISpecialMissionEliteBossPanel.RefreshUI()
    local self = UISpecialMissionEliteBossPanel
    self:InitData()
    self.SetTopDes()
    local IsNeedBuy= CS.CSMissionManager.Instance.IsNeedBuyEliteTask
    if self.csmission == nil then
        if IsNeedBuy==false then
            CS.Utility.ShowTips("[ffe7be]暂无可领任务[-]", 1.5, CS.ColorType.White)
            uimanager:ClosePanel('UISpecialMissionEliteBossPanel')
        end
    end
    self.IsNeedBuy(IsNeedBuy)
    if self.csmission == nil then
        return 
    end

    if self.Headtemplate == nil then
        self.Headtemplate = templatemanager.GetNewTemplate(self.BossKillTips, luaComponentTemplates.UIEliteMissionTemplates)
    end
    if self.rewardtemplate == nil then
        self.rewardtemplate = templatemanager.GetNewTemplate(self.rewardList, luaComponentTemplates.UIMissionRewardTemplates)
    end
    self.Headtemplate:InitData(self.csmission,LuaEnumUseUIEliteMissionTemplateSource.SpecialMission)
    self.rewardtemplate:InitData(self.Tab_Task)
    self.ShowBtn()
end

function UISpecialMissionEliteBossPanel.IsNeedBuy(isneedBuy)
    if isneedBuy == nil then
        return
    end
    UISpecialMissionEliteBossPanel.center.gameObject:SetActive(not isneedBuy)
    UISpecialMissionEliteBossPanel.down.gameObject:SetActive(not isneedBuy)
    UISpecialMissionEliteBossPanel.other.gameObject:SetActive(isneedBuy)

end

function UISpecialMissionEliteBossPanel.SetTopDes()
    if UISpecialMissionEliteBossPanel.EliteTaskCount==nil then
        UISpecialMissionEliteBossPanel.lb_name.text="精英任务"
        return 
    end
   
    local number =UISpecialMissionEliteBossPanel.EliteTaskCount.SurplusCount
    local BuyNumber =UISpecialMissionEliteBossPanel.EliteTaskCount.CanBuyCount
    local numberColor = "[00ff00]"
    if  UISpecialMissionEliteBossPanel.EliteTaskCount.IsNeedBuy then
        number = 0
        numberColor = "[e85038]"
    end
    local numberDic = ""
    if number~=0  then
        numberDic= '[878787]  剩' .. numberColor .. number .. '[-]次 '
    else
        numberDic= '[878787]  可买[00ff00]' .. BuyNumber .. '[-]次 '
    end
    
   
    UISpecialMissionEliteBossPanel.lb_name.text = "精英任务"..numberDic
end

---设置按钮描述
function UISpecialMissionEliteBossPanel.ShowBtn()
    local nowTask = UISpecialMissionEliteBossPanel.csmission
    if nowTask ~= nil and nowTask.tbl_tasks ~= nil then
        UISpecialMissionEliteBossPanel.btn_GotoKill.gameObject:SetActive(nowTask.State ~= CS.ETaskV2_TaskState.HAS_COMPLETE)
        ---领取奖励
        UISpecialMissionEliteBossPanel.btn_get.gameObject:SetActive(nowTask.State == CS.ETaskV2_TaskState.HAS_COMPLETE)
        ---二倍领取
        UISpecialMissionEliteBossPanel.btn_double.gameObject:SetActive(nowTask.State == CS.ETaskV2_TaskState.HAS_COMPLETE)
        ---二倍领取花费
        UISpecialMissionEliteBossPanel.cost.gameObject:SetActive(nowTask.State == CS.ETaskV2_TaskState.HAS_COMPLETE)
        UISpecialMissionEliteBossPanel.SetTwoBuy()
    end
end

---2倍领取花费的货币
UISpecialMissionEliteBossPanel.TwoBuyCostItem = 0
---2倍领取花费的货币数量
UISpecialMissionEliteBossPanel.TwoBuyCostItemCount = 0

---设置2倍购买的界面信息
function UISpecialMissionEliteBossPanel.SetTwoBuy()
    local nowTask = UISpecialMissionEliteBossPanel.csmission
    if nowTask == nil or nowTask.tbl_tasks == nil then
        return
    end
    local mutireward = nowTask.tbl_tasks.mutireward
    if mutireward == nil or mutireward=="" then
        UISpecialMissionEliteBossPanel.btn_get.gameObject.transform.localPosition = CS.UnityEngine.Vector3(19, -222, 0);
        UISpecialMissionEliteBossPanel.btn_double.gameObject:SetActive(false)
        UISpecialMissionEliteBossPanel.cost.gameObject:SetActive(false)
        return
    else
        UISpecialMissionEliteBossPanel.btn_get.gameObject.transform.localPosition = CS.UnityEngine.Vector3(-84, -222, 0);
    end
    local mutirewardList = _fSplit(mutireward, '#')
    if #mutirewardList ~= 3 then
        return
    end
    ---道具ID
    UISpecialMissionEliteBossPanel.TwoBuyCostItem = mutirewardList[1]
    ---花费
    UISpecialMissionEliteBossPanel.TwoBuyCostItemCount = mutirewardList[2]
    ---倍数
    local multiple = mutirewardList[3]
    local isfind, item = CS.Cfg_ItemsTableManager.Instance:TryGetValue(UISpecialMissionEliteBossPanel.TwoBuyCostItem)
    if isfind then
        UISpecialMissionEliteBossPanel.costIcon.spriteName = item.icon
    end
    UISpecialMissionEliteBossPanel.costLabel.text = UISpecialMissionEliteBossPanel.TwoBuyCostItemCount

end

function UISpecialMissionEliteBossPanel.OpenBuyTipPanel(itemid,costs)
    local isfind, item = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemid)
    local temp = {}
    local buyNumber = costs
    local enum = itemid ---itemID
    local itemName = "钻石"

    local isFind, promptInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(29)
    if not isFind then
        return
    end

    temp.IsShowGoldLabel = true
    temp.GoldIcon = item.icon
    temp.GoldCount = costs

    temp.Title = promptInfo.title
    temp.Content = string.gsub(promptInfo.des, '\\n', '\n')
    temp.IsClose = false
    temp.LeftDescription = promptInfo.leftButton
    temp.RightDescription = promptInfo.rightButton
    temp.CallBack = function(panel)
        UISpecialMissionEliteBossPanel.CheckAbleBuy({ panel, enum, buyNumber, itemName }, "UIPromptPanel")
    end
    uimanager:CreatePanel("UIPromptPanel", nil, temp)
end

---检测是否可购买
function UISpecialMissionEliteBossPanel.CheckAbleBuy(info, panelName)
    if not UISpecialMissionEliteBossPanel.IsNeedBuy then
        uimanager:ClosePanel('UIPromptPanel')
        return
    end
    local dependPanel = panelName == nil and "UISpecialMissionEliteBossPanel" or panelName
    local needNum = tonumber(info[3]);
    local mNum = CS.CSScene.MainPlayerInfo.BagInfo.DiamondNum
    if (mNum >= needNum) then
        networkRequest.ReqEliteTaskBuyTimes()
        uimanager:ClosePanel('UIPromptPanel')
    else
        if (CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList:Contains(info[2])) then
            Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.BuyDailyTaskDiamondNotEnough);
            uimanager:ClosePanel('UIPromptPanel')
        else
            Utility.ShowItemGetWay(info[2], info[1].GetCenterButton_GameObject(), LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(60, 0), nil, LuaEnumRechargePointType.BuyDailyTaskGoldNotEnoughToRewardGift);
        end
    end
end


--region 点击事件
---一倍领取奖励
function UISpecialMissionEliteBossPanel:OnwReceiveAward()
    networkRequest.ReqSubmitTask(UISpecialMissionEliteBossPanel.csmission.tbl_tasks.id, 1)
    uimanager:ClosePanel('UISpecialMissionEliteBossPanel')
end

---二倍领取奖励
function UISpecialMissionEliteBossPanel:TwoReceiveAward(go)
    --判定背包内是否存在所需的货币
    local bagCostCoinNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(UISpecialMissionEliteBossPanel.TwoBuyCostItem)
    if bagCostCoinNum < tonumber(UISpecialMissionEliteBossPanel.TwoBuyCostItemCount) then
        Utility.JumpRechargePanel(go)
        return
    end

    networkRequest.ReqSubmitTask(UISpecialMissionEliteBossPanel.csmission.tbl_tasks.id, 2)
    uimanager:ClosePanel('UISpecialMissionEliteBossPanel')
end

---前往击杀
function UISpecialMissionEliteBossPanel:GotoKill()
    local this = UISpecialMissionEliteBossPanel
    local nowSelectBoss = this.TaskBossSelect
    if nowSelectBoss == nil then
        return
    end
    local mapID = nowSelectBoss.MapID
    local deliverID = nowSelectBoss.DeliverID

    if mapID == CS.CSScene.getMapID() then
        CS.CSAutoFightMgr.Instance:Toggle(true);
    else
        networkRequest.ReqTaskBossDeliver(this.tbl_taskBoss.id, mapID)
    end
    uimanager:ClosePanel('UISpecialMissionEliteBossPanel')
end

function UISpecialMissionEliteBossPanel.OnClikebuy()
    networkRequest.ReqEliteBuyPrice()   
end

function UISpecialMissionEliteBossPanel.OnClikeBlackbox()
    uimanager:ClosePanel('UISpecialMissionEliteBossPanel')
end

--endregion
--region 服务器消息
---返回精英任务面板信息
function UISpecialMissionEliteBossPanel.OnResEliteTaskInfoPanelMessage()
    UISpecialMissionEliteBossPanel.RefreshUI()
end

---精英任务购买价格回复
function UISpecialMissionEliteBossPanel.OnResEliteBuyPriceMessage(id,data)
   
    if data==nil then
        return 
    end
    local itemid=data.itemid
    local  count=data.count
    UISpecialMissionEliteBossPanel.OpenBuyTipPanel(itemid,count)
end

--endregion
function UISpecialMissionEliteBossPanel.RefreShNowSelectLevelInfo(id, data)
    UISpecialMissionEliteBossPanel.TaskBossSelect = data
end



function ondestroy()
    --luaEventManager.RemoveCallback(LuaCEvent.Task_EliteSelectLevel, UISpecialMissionEliteBossPanel.RefreShNowSelectLevelInfo);
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResEliteTaskInfoPanelMessage, UISpecialMissionEliteBossPanel.OnResEliteTaskInfoPanelMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResEliteBuyPriceMessage, UISpecialMissionEliteBossPanel.OnResEliteBuyPriceMessage)
end

return UISpecialMissionEliteBossPanel