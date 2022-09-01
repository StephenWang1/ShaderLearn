---@class UISpecialMissionPanel:UIBase NPC任务
local UISpecialMissionPanel = {}

local Utility = Utility

UISpecialMissionPanel.subType = 0
UISpecialMissionPanel.missionstate = 0
--是否需要获取新的任务
UISpecialMissionPanel.isNeedGetNewMission = false
UISpecialMissionPanel.isOver = false
UISpecialMissionPanel.isOrigon = true

---双倍领取道具id
UISpecialMissionPanel.mDoubleGetCostItemId = nil
---双倍领取道具数目
UISpecialMissionPanel.mDoubleGetCostItemNum = nil
---双倍领取道具M名字
UISpecialMissionPanel.mDoubleGetCostItemName = nil

--region 属性
---背包信息
---@return CSBagInfoV2
function UISpecialMissionPanel:GetBagInfo()
    if self.mBagInfo == nil then
        self.mBagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    end
    return self.mBagInfo
end
--endregion
--region 初始化
function UISpecialMissionPanel:Init()
    self:AddCollider()
    self:InitComponents()
    UISpecialMissionPanel.BindUIEvents()
    UISpecialMissionPanel.BindNetMessage()
    UISpecialMissionPanel.InitParams()
end

function UISpecialMissionPanel:InitComponents()
    ---@type Top_UIGridContainer
    UISpecialMissionPanel.rewardList = self:GetCurComp("WidgetRoot/down/rewardList", "Top_UIGridContainer")
    ---@type Top_UILabel
    UISpecialMissionPanel.label_sure = self:GetCurComp("WidgetRoot/down/btn_sure/label", "Top_UILabel")
    ---标题名称
    UISpecialMissionPanel.lb_name = self:GetCurComp("WidgetRoot/up/lb_name", "UILabel")

    ---提交
    UISpecialMissionPanel.mBtn_sure = self:GetCurComp("WidgetRoot/down/btn_sure", "GameObject")
    ---关闭按钮
    UISpecialMissionPanel.mBtn_close = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
    ---一倍领取
    UISpecialMissionPanel.btn_get1 = self:GetCurComp("WidgetRoot/down/btn_get1", "GameObject")
    ---双倍领取
    UISpecialMissionPanel.btn_get2 = self:GetCurComp("WidgetRoot/down/btn_get2", "GameObject")
    ---三倍领取
    UISpecialMissionPanel.btn_get3 = self:GetCurComp("WidgetRoot/down/btn_get3", "GameObject")
    ---购买次数
    UISpecialMissionPanel.btn_add = self:GetCurComp("WidgetRoot/up/btn_add", "GameObject")
    ---购买次数icon
    UISpecialMissionPanel.btn_addIcon = self:GetCurComp("WidgetRoot/up/btn_add", "UISprite")
    ---购买次数描述
    UISpecialMissionPanel.btn_addLabel = self:GetCurComp("WidgetRoot/up/btn_add/Label", "UILabel")
    ---购买次数底图
    UISpecialMissionPanel.btn_addUISprite = self:GetCurComp("WidgetRoot/up/btn_add/Sprite", "UISprite")
    ---描述_上(任务说明)
    UISpecialMissionPanel.lb_dec = self:GetCurComp("WidgetRoot/up/lb_dec", "UILabel")
    ---任务进度（xx/xx）
    UISpecialMissionPanel.describe = self:GetCurComp("WidgetRoot/center/lb_describe2", "UILabel")
    ---双倍领取花费
    UISpecialMissionPanel.twoBuy = self:GetCurComp("WidgetRoot/down/btn_get2/lb_cost", "UILabel")
    ---双倍领取花费图标
    UISpecialMissionPanel.twoBuy_UISprite = self:GetCurComp("WidgetRoot/down/btn_get2/lb_cost/Sprite", "UISprite")
    ---三倍领取花费
    UISpecialMissionPanel.threeBuy = self:GetCurComp("WidgetRoot/down/btn_get3/lb_cost", "UILabel")
    ---三倍领取花费图标
    UISpecialMissionPanel.threeBuy_UISprite = self:GetCurComp("WidgetRoot/down/btn_get3/lb_cost/Sprite", "UISprite")

    UISpecialMissionPanel.up = self:GetCurComp("WidgetRoot/up", "GameObject")
    UISpecialMissionPanel.center = self:GetCurComp("WidgetRoot/center", "GameObject")
    UISpecialMissionPanel.down = self:GetCurComp("WidgetRoot/down", "GameObject")
    UISpecialMissionPanel.other = self:GetCurComp("WidgetRoot/other", "GameObject")

    UISpecialMissionPanel.otherSprite = self:GetCurComp("WidgetRoot/other/Label", "Top_UISprite")

    ---@type Top_UIGridContainer 任务目标
    UISpecialMissionPanel.CostList = self:GetCurComp("WidgetRoot/center/CostList", "Top_UIGridContainer")
    ---中部描述背景
    UISpecialMissionPanel.centerDesBG = self:GetCurComp("WidgetRoot/center/Sprite", "Top_UISprite")
    ---中部描述长度
    UISpecialMissionPanel.lb_desLenght = self:GetCurComp("WidgetRoot/center/lb_desLenght", "UILabel")

    UISpecialMissionPanel.CostListLocation = UISpecialMissionPanel.CostList.transform.localPosition

end

function UISpecialMissionPanel.BindUIEvents()
    --点击前往函数
    CS.UIEventListener.Get(UISpecialMissionPanel.mBtn_sure.gameObject).onClick = UISpecialMissionPanel.OnClickBtnSure
    --点击关闭函数
    CS.UIEventListener.Get(UISpecialMissionPanel.mBtn_close.gameObject).onClick = UISpecialMissionPanel.OnExitClick
    --点击一倍领取函数
    CS.UIEventListener.Get(UISpecialMissionPanel.btn_get1.gameObject).onClick = UISpecialMissionPanel.GetOneAward
    --点击双倍领取函数
    CS.UIEventListener.Get(UISpecialMissionPanel.btn_get2.gameObject).onClick = UISpecialMissionPanel.GetTwoAward
    --点击三倍领取函数
    CS.UIEventListener.Get(UISpecialMissionPanel.btn_get3.gameObject).onClick = UISpecialMissionPanel.GetThreeAward
    --点击购买函数
    CS.UIEventListener.Get(UISpecialMissionPanel.btn_add.gameObject).onClick = UISpecialMissionPanel.BuyCount
end

function UISpecialMissionPanel.BindNetMessage()
    UISpecialMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerBeginWalk, UISpecialMissionPanel.MainPlayerBeginWalk)
    UISpecialMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_NewDailyTaskRefresh, UISpecialMissionPanel.OnDaliyTaskUpdate)
    --更新目标任务
    --UISpecialMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.Task_GoalUpdate, UISpecialMissionPanel.RefeshUI)

    UISpecialMissionPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Task_GotoTask, UISpecialMissionPanel.OnGotoTask)
    UISpecialMissionPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Task_BuyItem, UISpecialMissionPanel.OnOpenSaleOreClick)

    UISpecialMissionPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResMercenaryTaskInfoMessage, UISpecialMissionPanel.TaskInfoMessage)
    UISpecialMissionPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDailyTaskInfoMessage, UISpecialMissionPanel.DailyTaskInfoMessage)
    ---刷新背包数据
    UISpecialMissionPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UISpecialMissionPanel.RefreshBuyColor)
    UISpecialMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UpDateTaskSchedule, UISpecialMissionPanel.OnResBagChangeMessage)
    UISpecialMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UpDateTaskSchedule, UISpecialMissionPanel.RefeshUI)
end

function UISpecialMissionPanel.InitParams()
    UISpecialMissionPanel.npcID = nil
    UISpecialMissionPanel.mapNpcId = nil
    UISpecialMissionPanel.IsNeedBuy = false
    UISpecialMissionPanel.isShowDummy = false
    UISpecialMissionPanel.dummyMaxCount = 0
    UISpecialMissionPanel.uiItemTable = {}
    UISpecialMissionPanel.missionItemTemplatDic = {}
end

function UISpecialMissionPanel:Show(npcid)
    CS.CSMissionManager.Instance.isUpDateTaskSchedule = true;
    if npcid then
        local missionNpcID, csmission = CS.CSMissionManager.Instance:IsTaskNpc(npcid, false)
        if missionNpcID ~= 0 then
            CS.CSMissionManager.Instance.CurrentTask = csmission
            local isFind, tbl_task = CS.Cfg_TaskTableManager.Instance.dic:TryGetValue(csmission.taskId)
            if isFind then
                UISpecialMissionPanel.ShowTask(tbl_task, missionNpcID)
            end
        else
            CS.Utility.ShowTips("[ffe7be]暂无可领任务[-]", 1.5, CS.ColorType.White)
            uimanager:ClosePanel('UISpecialMissionPanel')
        end
    end
end

--endregion
---显示任务
---@param tbl_task TABLE.CFG_TASK
---@param data CSMission
function UISpecialMissionPanel.ShowTask(tbl_task, npcID)
    ---任务表
    UISpecialMissionPanel.tbl_task = tbl_task
    --MapNpcID
    UISpecialMissionPanel.npcID = npcID
    ---任务子类型
    UISpecialMissionPanel.subtype = 0
    if tbl_task ~= nil then
        UISpecialMissionPanel.subtype = tbl_task.subtype
    end
    ---任务增加次数道具ID
    UISpecialMissionPanel.addNumberItemID = gameMgr:GetLuaMissionManager():GetDailyTaskAddNumberItemId(UISpecialMissionPanel.subtype)
    ---日常任务额外次数
    ---UISpecialMissionPanel.extraSurplus = gameMgr:GetLuaMissionManager().DailyExtraSurplusTimeDic[UISpecialMissionPanel.subtype]
    ---三倍领取限制
    UISpecialMissionPanel.ThreeAwardLimit = gameMgr:GetLuaMissionManager():IsMeetDailyTaskThreeAwardLimit()

    UISpecialMissionPanel.RefeshUI()
end

function UISpecialMissionPanel.RefeshUI()
    local isfindMission, mission = CS.CSMissionManager.Instance.mMissionDic:TryGetValue(UISpecialMissionPanel.tbl_task.id)
    if not isfindMission then
        return
    end
    UISpecialMissionPanel.csmission = mission
    --服务器taskGoalInfo
    UISpecialMissionPanel.taskGoalInfo = UISpecialMissionPanel.csmission:GetTaskGoal(0)
    --任务状态
    UISpecialMissionPanel.missionstate = UISpecialMissionPanel.csmission.State
    --当前任务进度
    UISpecialMissionPanel.curCount = 0
    --最大任务进度
    UISpecialMissionPanel.maxCount = 0
    --任务目标道具列表
    UISpecialMissionPanel.items = nil
    --任务道具表
    local isfindtab_dailyTask, tab_dailyTask = CS.Cfg_Daily_TaskTableManager.Instance:TryGetValue(UISpecialMissionPanel.csmission.Tab_dailyID);
    UISpecialMissionPanel.Tab_dailyTask = tab_dailyTask
    UISpecialMissionPanel.Tab_dailyTaskLua = clientTableManager.cfg_daily_taskManager:TryGetValue(UISpecialMissionPanel.csmission.Tab_dailyID)

    if UISpecialMissionPanel.taskGoalInfo ~= nil then
        UISpecialMissionPanel.curCount = UISpecialMissionPanel.taskGoalInfo.curCount
        UISpecialMissionPanel.maxCount = UISpecialMissionPanel.taskGoalInfo.maxCount
        UISpecialMissionPanel.items = UISpecialMissionPanel.taskGoalInfo.items
    end
    local isfind, info = CS.Cfg_MapNpcTableManager.Instance.dic:TryGetValue(UISpecialMissionPanel.npcID)
    if isfind then
        UISpecialMissionPanel.mapNpcId = info.npcid
    end
    UISpecialMissionPanel.SetHeadline()
    UISpecialMissionPanel.SetShow()
    UISpecialMissionPanel.RefreshCentralInfo()
    UISpecialMissionPanel.InitMissionNeedItemList()
    UISpecialMissionPanel.SetTwoBuy()
    UISpecialMissionPanel.SetThreeBuy()
    UISpecialMissionPanel.ShowMissionReward()
    UISpecialMissionPanel.RefreshBuyBtnDes()
end

---背包变化消息
function UISpecialMissionPanel.OnResBagChangeMessage()
    if self == nil or CS.StaticUtility.IsNull(self.go) then
        return
    end
    UISpecialMissionPanel.taskGoalInfo = UISpecialMissionPanel.csmission:GetTaskGoal(0)
    UISpecialMissionPanel.RefreshCentralInfo()
    UISpecialMissionPanel.InitMissionNeedItemList()
end

---判断是否可购买状态设置标题（可购买）
function UISpecialMissionPanel.SetHeadline()
    local mission = UISpecialMissionPanel.csmission
    if mission == nil then
        return
    end
    mission:InitDailyTaskInfo();
    --可买最大数量
    local BuyMaxCount = mission.BuyMaxCount
    --任务总数量
    local TaskMaxCount = mission.TaskMaxCount
    -- 已经购买数量（服务器）
    local BuyCount = mission.BuyCount
    -- 任务当前进行数量（服务器）
    local AccepCount = mission.AccepCount
    -- 显示总数量
    local ShowMaxCount = BuyCount + TaskMaxCount
    -- 剩余可买次数
    UISpecialMissionPanel.LastBuyCount = BuyMaxCount - BuyCount
    local IsNeedBuy = mission.IsNeedBuy
    UISpecialMissionPanel.IsNeedBuy = mission.IsNeedBuy
    UISpecialMissionPanel.isOver = TaskMaxCount + BuyMaxCount <= AccepCount
    if AccepCount > ShowMaxCount then
        AccepCount = ShowMaxCount
    end
    --local number = ShowMaxCount + 1 - AccepCount

    --if AccepCount > ShowMaxCount then
    --    AccepCount = ShowMaxCount
    --end
    -- 剩余次数
    --local LastCount = ShowMaxCount + 1 - AccepCount

    -- print("额外次数：", UISpecialMissionPanel.extraSurplus," 配置总次数：", mission.TaskMaxCount,"可买数量：",BuyCount, " 当前进行数量",AccepCount)
    ---是否需要购买
    --local IsNeedBuy = LastCount <= 0
    ---
    local number = ShowMaxCount + 1 - AccepCount
    local numberColor = "[00ff00]"
    local numberDic = ""
    UISpecialMissionPanel.btn_add:SetActive(IsNeedBuy);
    if IsNeedBuy then
        if (UISpecialMissionPanel.LastBuyCount > 0) then
            numberDic = ""-- '[878787]  可买' .. numberColor .. UISpecialMissionPanel.LastBuyCount .. '[-]次 '
        else
            number = 0
            numberColor = "[e85038]"
            numberDic = '[878787]  剩' .. numberColor .. number .. '[-]次 '
        end
    else
        numberDic = '[878787]  剩' .. numberColor .. number .. '[-]次 '
    end
    UISpecialMissionPanel.lb_name.text = UISpecialMissionPanel.tbl_task.name .. numberDic
    UISpecialMissionPanel.center:SetActive(not IsNeedBuy)
    UISpecialMissionPanel.down:SetActive(not IsNeedBuy)
    UISpecialMissionPanel.other:SetActive(IsNeedBuy)
    if not UISpecialMissionPanel.IsNeedBuy then
        uimanager:ClosePanel('UIPromptPanel')
    end
end

function UISpecialMissionPanel.SetShow()
    local isACCEPT = UISpecialMissionPanel.missionstate == CS.ETaskV2_TaskState.HAS_ACCEPT
    local IsSubmit = UISpecialMissionPanel.csmission.IsSubmit;
    UISpecialMissionPanel.btn_get1:SetActive(IsSubmit)
    UISpecialMissionPanel.btn_get2:SetActive(IsSubmit)
    UISpecialMissionPanel.btn_get3:SetActive(IsSubmit and UISpecialMissionPanel.ThreeAwardLimit)
    UISpecialMissionPanel.mBtn_sure:SetActive(not IsSubmit)
    UISpecialMissionPanel.SetBtnPosition()
    UISpecialMissionPanel.lb_dec.text = UISpecialMissionPanel.tbl_task.tips4

end

function UISpecialMissionPanel.SetBtnPosition()
    if UISpecialMissionPanel.ThreeAwardLimit then
        UISpecialMissionPanel.btn_get1.gameObject.transform.localPosition = CS.UnityEngine.Vector3(-121, -222, 0)
        UISpecialMissionPanel.btn_get2.gameObject.transform.localPosition = CS.UnityEngine.Vector3(19, -222, 0)
    else
        UISpecialMissionPanel.btn_get1.gameObject.transform.localPosition = CS.UnityEngine.Vector3(-84, -222, 0)
        UISpecialMissionPanel.btn_get2.gameObject.transform.localPosition = CS.UnityEngine.Vector3(107, -222, 0)
    end
end

--刷新中部信息
function UISpecialMissionPanel.RefreshCentralInfo()
    ---任务进度（xx/xx）
    local des = UISpecialMissionPanel.GetItemName(false)
    UISpecialMissionPanel.describe.text = des
    if UISpecialMissionPanel.describe.height > 40 then
        UISpecialMissionPanel.describe.text = UISpecialMissionPanel.GetItemName(true)
    end
    UISpecialMissionPanel.SetCentralInfoLocation()
end

---设置中部位置
function UISpecialMissionPanel.SetCentralInfoLocation()
    if CS.StaticUtility.IsNull(UISpecialMissionPanel.CostList) then
        return
    end
    local v3 = CS.UnityEngine.Vector3(0, UISpecialMissionPanel.describe.height - 20, 0)
    UISpecialMissionPanel.CostList.transform.localPosition = UISpecialMissionPanel.CostListLocation - v3
    UISpecialMissionPanel.centerDesBG.height = UISpecialMissionPanel.describe.height + 25
    local describev3 = UISpecialMissionPanel.describe.transform.localPosition;
    describev3.x = -(UISpecialMissionPanel.lb_desLenght.width / 2) + 20
    UISpecialMissionPanel.describe.transform.localPosition = describev3
    CS.CSListUpdateMgr.Instance:Add(CS.ListUpdateItem(2, nil, function()
        UISpecialMissionPanel.describe:ResizeCollider()
    end));

end

function UISpecialMissionPanel.GetItemName(isNeedLineFeed)
    local des = ''
    local vacancy = ''
    local IsSubmit = UISpecialMissionPanel.csmission.IsSubmit;
    local count = " " .. CS.Utility_Lua.SetProgressLabelColor(UISpecialMissionPanel.curCount, UISpecialMissionPanel.maxCount)
    local IsShowMaxNumber = false
    if IsSubmit then
        des = "已达成收集"
        vacancy = '\r\n　　　　　'
    else
        des = "收集"
        vacancy = '\r\n　　'
    end

    local isStartEnter = true
    for i = 0, UISpecialMissionPanel.items.Count - 1 do
        if UISpecialMissionPanel.items[i] ~= nil then
            local isFind, tbl_item = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(UISpecialMissionPanel.items[i].item)
            if isFind then
                local dot = ","
                if i == UISpecialMissionPanel.items.Count - 1 or isNeedLineFeed then
                    dot = " "
                end
                local itemID = UISpecialMissionPanel.items[i].item;
                local itemName = tbl_item.name   --CS.Cfg_ItemsTableManager.Instance:GetItemName(itemID)
                local count = "  " .. CS.Utility_Lua.SetProgressLabelColor(UISpecialMissionPanel.items[i].count, UISpecialMissionPanel.items[i].maxCount)
                if UISpecialMissionPanel.items[i].maxCount == 0 then
                    IsShowMaxNumber = true
                    count = ''
                end
                if isNeedLineFeed and (not isStartEnter) then
                    des = des .. vacancy .. "[u]" .. "[url=itemInfo:" .. itemID .. "]" .. tostring(itemName) .. "[/url]" .. "[/u]" .. count
                else
                    des = des .. "[u]" .. "[url=itemInfo:" .. itemID .. "]" .. tostring(itemName) .. "[/url]" .. "[/u]" .. count .. dot
                end
                if isStartEnter then
                    if CS.StaticUtility.IsNull(UISpecialMissionPanel.lb_desLenght) == false then
                        UISpecialMissionPanel.lb_desLenght.text = des
                    end
                end
                isStartEnter = false
            end
        end
    end
    if IsShowMaxNumber then
        des = des .. count
        if UISpecialMissionPanel.csmission ~= nil then
            if IsSubmit then
                des = "已达成收集任意"
            else
                des = "收集任意"
            end
            local itemInfo = "[u][url=activeId:" .. UISpecialMissionPanel.csmission.id .. "][A4CEF6]" .. UISpecialMissionPanel.csmission:GetDailyTaskTypeName() .. "[-][/url][/u]"
            des = des .. itemInfo .. count
        end
        if CS.StaticUtility.IsNull(UISpecialMissionPanel.lb_desLenght) == false then
            UISpecialMissionPanel.lb_desLenght.text = des
        end
    end

    return des
end

---初始化任务所需道具列表
function UISpecialMissionPanel.InitMissionNeedItemList()
    local lst = UISpecialMissionPanel.items
    if lst == nil or lst.Count == 0 then
        return
    end
    UISpecialMissionPanel.CostList.MaxCount = lst.Count
    for i = 0, lst.Count - 1 do
        local go = UISpecialMissionPanel.CostList.controlList[i].gameObject
        if go ~= nil then
            local temp = UISpecialMissionPanel.missionItemTemplatDic[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UISpecialMissionPanel_Item) or UISpecialMissionPanel.missionItemTemplatDic[go]
            if temp ~= nil then
                temp:RefreshUI(lst[i].item, lst[i].count, lst[i].maxCount)
                if UISpecialMissionPanel.missionItemTemplatDic[go] == nil then
                    UISpecialMissionPanel.uiItemTable[go] = temp
                end
            end
        end
    end
end
---任务奖励
function UISpecialMissionPanel.ShowMissionReward()

    if UISpecialMissionPanel.Tab_dailyTask == nil then
        return
    end
    local list = UISpecialMissionPanel.Tab_dailyTask.rewards.list
    local items = {}
    local count = list.Count - 1
    for i = 0, count do
        local idToNums = list[i].list
        if idToNums.Count == 2 then
            items[i] = { itemID = tonumber(idToNums[0]), num = tonumber(idToNums[1]) }
        end
    end
    UISpecialMissionPanel.rewardList.MaxCount = Utility.GetLuaTableCount(items)
    for i = 0, UISpecialMissionPanel.rewardList.MaxCount - 1 do
        if UISpecialMissionPanel.uiItemTable[i] == nil then
            UISpecialMissionPanel.uiItemTable[i] = templatemanager.GetNewTemplate(UISpecialMissionPanel.rewardList.controlList[i], luaComponentTemplates.UIItem)
        end
        UISpecialMissionPanel.uiItemTable[i]:ResetUI(true)
        local isFind, tbl_item = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(items[i].itemID)
        if isFind then
            UISpecialMissionPanel.uiItemTable[i]:RefreshUIWithItemInfo(tbl_item, items[i].num)
            UISpecialMissionPanel.uiItemTable[i]:GetEventListener().onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = tbl_item })
            end
        end
    end
end

--endregion
--region 功能
---传送
function UISpecialMissionPanel.Transfer(data)
    if data.addchuan ~= 0 then
        local isFind, NextTask = CS.Cfg_TaskTableManager.Instance.dic:TryGetValue(data.next)
        if isFind then
            networkRequest.ReqDeliverByConfig(data.addchuan, nil)
        end
    end

end

---购买
function UISpecialMissionPanel.Buy()
    if UISpecialMissionPanel.tbl_task.type == LuaEnumTaskType.Mercenary then
        networkRequest.ReqBuyMercenaryTaskTimes(1)
    elseif UISpecialMissionPanel.tbl_task.type == LuaEnumTaskType.Everyday then
        networkRequest.ReqBuyDailyTaskTimes(UISpecialMissionPanel.tbl_task.subtype, 1)
    end
    UISpecialMissionPanel.isNeedGetNewMission = true
end

--endregion
--region otherFunc
---显示购买tips
function UISpecialMissionPanel.ShowBuyTips()
    local temp = {}
    local info = CS.Cfg_GlobalTableManager.Instance:GetMissionDelItemInfoOfType(UISpecialMissionPanel.tbl_task.type)
    local buyNumber = '0'
    local itemID = '0'
    local daily_TaskTable = CS.Cfg_Daily_TaskTableManager.Instance:FilterDailyTask(UISpecialMissionPanel.tbl_task.subtype)
    if daily_TaskTable == nil then
        buyNumber = '0'
    else
        if daily_TaskTable.buy ~= nil and daily_TaskTable.buy.list ~= nil and daily_TaskTable.buy.list.Count == 2 then
            itemID = daily_TaskTable.buy.list[0]
            buyNumber = daily_TaskTable.buy.list[1]

            temp.IsShowGoldLabel = true
            temp.GoldIcon = itemID
            temp.GoldCount = daily_TaskTable.buy.list[1]
        end
    end

    local enum = itemID
    local itemName = '元宝'
    itemName = CS.Cfg_ItemsTableManager.Instance:GetItemName(itemID)
    itemName = itemName == nil and '元宝' or itemName

    local isFind, promptInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(29)
    if not isFind then
        return
    end

    temp.Title = promptInfo.title
    --temp.des = promptInfo.des-- string.format(promptInfo.des, buyNumber, itemName)
    temp.Content = string.gsub(promptInfo.des, '\\n', '\n')
    --   "是否消耗" .. buyNumber .. itemName .. "购买1次"
    temp.IsClose = false
    temp.LeftDescription = promptInfo.leftButton
    temp.RightDescription = promptInfo.rightButton
    temp.CallBack = function(panel)
        UISpecialMissionPanel.CheckAbleBuy({ panel, enum, buyNumber, itemName }, "UIPromptPanel")
    end
    uimanager:CreatePanel("UIPromptPanel", nil, temp)
end

---刷新购买按钮描述
function UISpecialMissionPanel.RefreshBuyBtnDes()
    local bagItemNumber = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UISpecialMissionPanel.addNumberItemID)
    if bagItemNumber <= 0 then
        UISpecialMissionPanel.btn_addLabel.text = "[6F7480]获得卷轴"
        UISpecialMissionPanel.btn_addUISprite.spriteName = "MedalInlay_textbtn"
        UISpecialMissionPanel.btn_addIcon.spriteName = "SpecialMission_booknum"
    else
        UISpecialMissionPanel.btn_addLabel.text = "[C3F4FF]使用卷轴"
        UISpecialMissionPanel.btn_addUISprite.spriteName = "MedalInlay_textbtn1"
        UISpecialMissionPanel.btn_addIcon.spriteName = "SpecialMission_booknum1"
    end

    if bagItemNumber <= 0 then
        UISpecialMissionPanel.otherSprite.spriteName = "juanzhou"
    else
        UISpecialMissionPanel.otherSprite.spriteName = "SpecialMission_freeNum"
    end
end

function UISpecialMissionPanel.UseItem(go)
    local bagItemNumber = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UISpecialMissionPanel.addNumberItemID)
    local LastBuyCount = UISpecialMissionPanel.LastBuyCount
    local maxCount = LastBuyCount
    if bagItemNumber < LastBuyCount then
        maxCount = bagItemNumber
    end
    if maxCount == 0 then
        uiTransferManager:TransferToPanel(1130)
        -- Utility.ShowItemGetWay(UISpecialMissionPanel.addNumberItemID, go, LuaEnumWayGetPanelArrowDirType.LeftUp, CS.UnityEngine.Vector2(310, 50), nil, uiStaticParameter.RechargePoint);
        return
    end

    --若批量使用类型为弹出数量界面选择使用数量
    local useFunction = function(count)
        networkRequest.ReqBuyDailyTaskTimes(UISpecialMissionPanel.tbl_task.subtype, count)
        -- local mBagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(UISpecialMissionPanel.addNumberItemID)
        -- networkRequest.ReqUseItem(count, mBagItemInfo.lid, UISpecialMissionPanel.subType)
        uimanager:ClosePanel("UIBagPanel")
        uimanager:ClosePanel("UIPromptPanel")
        uimanager:ClosePanel("UIPetInfoPanel")
        uimanager:ClosePanel('UIItemInfoPanel')
        uimanager:ClosePanel("UIItemCountPanel")
    end
    local isfind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(UISpecialMissionPanel.addNumberItemID)
    if isfind then
        uimanager:CreatePanel("UIItemCountPanel", function()
            uimanager:ClosePanel("UIItemInfoPanel")
        end, {
            Title = "使 用",
            ItemInfo = itemInfo,
            CallBack = useFunction,
            MinCount = 1,
            BeginningCount = maxCount,
            MaxCount = maxCount == 0 and 1 or maxCount
        })
    end

end

---检测是否可购买
function UISpecialMissionPanel.CheckAbleBuy(info, panelName)
    if not UISpecialMissionPanel.IsNeedBuy then
        uimanager:ClosePanel('UIPromptPanel')
        return
    end
    local dependPanel = panelName == nil and "UISpecialMissionPanel" or panelName
    local needNum = tonumber(info[3]);
    local mNum = CS.CSScene.MainPlayerInfo.BagInfo.DiamondNum
    if (Utility.IsPushSpecialGift()) then
        uimanager:CreatePanel("UIRechargeGiftPanel")
        return
    end
    if (mNum >= needNum) then
        UISpecialMissionPanel.Buy();
    else
        if (CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList:Contains(info[2])) then
            Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.BuyDailyTaskDiamondNotEnough);
            uimanager:ClosePanel('UIPromptPanel')
        else
            Utility.ShowItemGetWay(info[2], info[1].GetCenterButton_GameObject(), LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(60, 0), nil, LuaEnumRechargePointType.BuyDailyTaskGoldNotEnoughToRewardGift);
        end
    end
end

---设置双倍领取
function UISpecialMissionPanel.SetTwoBuy()
    if UISpecialMissionPanel.Tab_dailyTask == nil then
        return
    end
    local mutireward = UISpecialMissionPanel.Tab_dailyTask.twice
    if mutireward == nil or mutireward.list.Count < 2 then
        return
    end
    local isfind, item = CS.Cfg_ItemsTableManager.Instance:TryGetValue(mutireward.list[0])
    if isfind then

        local yuanbao = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(mutireward.list[0])

        local color = luaEnumColorType.White
        if yuanbao < mutireward.list[1] then
            color = luaEnumColorType.Red
            --UISpecialMissionPanel.CheackCheatPush(item.id)
        end
        UISpecialMissionPanel.twoBuy.text = color .. tostring(mutireward.list[1])
        UISpecialMissionPanel.twoBuy_UISprite.spriteName = item.icon

        UISpecialMissionPanel.mDoubleGetCostItemId = mutireward.list[0]
        UISpecialMissionPanel.mDoubleGetCostItemNum = tonumber(mutireward.list[1])
        UISpecialMissionPanel.mDoubleGetCostItemName = item.name
    end
    UISpecialMissionPanel.subType = UISpecialMissionPanel.tbl_task.subtype
end

---设置三倍领取
function UISpecialMissionPanel.SetThreeBuy()
    if UISpecialMissionPanel.Tab_dailyTaskLua == nil then
        return
    end
    local mutireward = UISpecialMissionPanel.Tab_dailyTaskLua:GetTreble()
    if mutireward == nil or #mutireward.list < 2 then
        return
    end
    local isfind, item = CS.Cfg_ItemsTableManager.Instance:TryGetValue(mutireward.list[1])
    if isfind then

        local yuanbao = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(mutireward.list[1])
        local color = luaEnumColorType.White
        if yuanbao < mutireward.list[2] then
            color = luaEnumColorType.Red
            --UISpecialMissionPanel.CheackCheatPush(item.id)
        end
        UISpecialMissionPanel.threeBuy.text = color .. tostring(mutireward.list[2])
        UISpecialMissionPanel.threeBuy_UISprite.spriteName = item.icon

        UISpecialMissionPanel.mthreeGetCostItemId = mutireward.list[1]
        UISpecialMissionPanel.mthreeGetCostItemNum = tonumber(mutireward.list[2])
        UISpecialMissionPanel.mthreeGetCostItemName = item.name
    end
end

---刷新购买按钮颜色信息
function UISpecialMissionPanel.RefreshBuyColor()
    UISpecialMissionPanel.RefreshBuyBtnDes()
    UISpecialMissionPanel.SetRefreshBuyColor(UISpecialMissionPanel.Tab_dailyTaskLua:GetTwice(), UISpecialMissionPanel.twoBuy, 0)
    UISpecialMissionPanel.SetRefreshBuyColor(UISpecialMissionPanel.Tab_dailyTaskLua:GetTreble(), UISpecialMissionPanel.threeBuy, 1)
end
---设置购买字体颜色信息
function UISpecialMissionPanel.SetRefreshBuyColor(expenditureInfo, Label, StartIndex)
    local mutireward = expenditureInfo
    if mutireward == nil or mutireward.list == nil or mutireward.list[StartIndex] == nil or mutireward.list[StartIndex + 1] == nil then
        return
    end
    local isfind, item = CS.Cfg_ItemsTableManager.Instance:TryGetValue(mutireward.list[StartIndex])
    if isfind then
        local yuanbao = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(mutireward.list[StartIndex])

        local color = luaEnumColorType.White
        if yuanbao < mutireward.list[StartIndex + 1] then
            color = luaEnumColorType.Red
        end
        Label.text = color .. tostring(mutireward.list[StartIndex + 1])
    end
end

function UISpecialMissionPanel.GetMission()
    if UISpecialMissionPanel.csmission ~= nil then
        return UISpecialMissionPanel.csmission
    elseif UISpecialMissionPanel.tbl_task ~= nil and UISpecialMissionPanel.tbl_task.id ~= nil then
        local isfindMission, mission = CS.CSMissionManager.Instance.mMissionDic:TryGetValue(UISpecialMissionPanel.tbl_task.id)
        if isfindMission then
            return mission
        end
    else
        return nil
    end

end
--endregion
--region 函数监听
---点击买卖材料函数
function UISpecialMissionPanel.OnOpenSaleOreClick(go)
    if UISpecialMissionPanel.subType ~= 0 then
        uimanager:CreatePanel("UISaleOrePanel", nil, { isOpenBag = false, type = UISpecialMissionPanel.subType })
    end
    UISpecialMissionPanel:SetCurrentActive();
end

---前往做任务
function UISpecialMissionPanel.OnGotoTask(msgId, msgData)

    local mission = UISpecialMissionPanel.GetMission()
    if mission == nil then
        return
    end
    if msgData ~= nil and msgData.id ~= nil then

        mission:SetTaskTarget(msgData.id)
    end
    UISpecialMissionPanel:SetCurrentActive();
    CS.CSMissionManager.Instance:FindTaskTarget(mission, true)
    uimanager:ClosePanel("UIDailyMissionAwardPanel")
    uimanager:ClosePanel("UISpecialMissionPanel")
end

function UISpecialMissionPanel:SetCurrentActive()
    local mission = UISpecialMissionPanel.GetMission()
    if (mission ~= nil) then
        CS.CSScene.MainPlayerInfo.ActiveInfo:SetCurrentActive(mission);
    end
end

---点击提交函数
function UISpecialMissionPanel.OnClickBtnSure(msgId, msgData)
    if UISpecialMissionPanel.items ~= nil then
        if UISpecialMissionPanel.items.Count > 1 then
            uimanager:CreatePanel("UIActiveItemShowPanel", nil, { mission = UISpecialMissionPanel.csmission })
            return
        end
        for k, v in pairs(UISpecialMissionPanel.uiItemTable) do
            if v.isMeet == false then
                v:OnClinkItem()
                return
            end
        end
    end
end

---是否能提交
function UISpecialMissionPanel.IsCanSure()
    local lst = UISpecialMissionPanel.items
    if lst == nil or lst.Count == 0 then
        return false
    end
    local isCanSure = true
    local isNeedwillItem = UISpecialMissionPanel.maxCount ~= 0
    if isNeedwillItem then
        return UISpecialMissionPanel.curCount >= UISpecialMissionPanel.maxCount
    else
        for i = 0, lst.Count - 1 do
            if lst[i].count < lst[i].maxCount then
                isCanSure = false
            end
        end
    end

    return isCanSure
end

---一倍领取
function UISpecialMissionPanel.GetOneAward(go)
    CS.CSScene.MainPlayerInfo.ActiveInfo:SetCurrentActive(nil);
    networkRequest.ReqSubmitTask(UISpecialMissionPanel.tbl_task.id, 1)
    CS.CSMissionManager.Instance:ClearCurrentTask();
    --uimanager:ClosePanel("UISpecialMissionPanel")
    UISpecialMissionPanel.IsNeedClosePanel()
end

---双倍领取
function UISpecialMissionPanel.GetTwoAward(go)
    CS.CSScene.MainPlayerInfo.ActiveInfo:SetCurrentActive(nil);
    -- print("UISpecialMissionPanel:IsMoneyEnough(2)",UISpecialMissionPanel:IsMoneyEnough(2),UISpecialMissionPanel.mDoubleGetCostItemId)
    if UISpecialMissionPanel:IsMoneyEnough(2) then
        networkRequest.ReqSubmitTask(UISpecialMissionPanel.tbl_task.id, 2)
        CS.CSMissionManager.Instance:ClearCurrentTask();
        --uimanager:ClosePanel("UISpecialMissionPanel")
        UISpecialMissionPanel.IsNeedClosePanel()
    else
        UISpecialMissionPanel.NoMoneyProcess();
        --Utility.ShowItemGetWay(UISpecialMissionPanel.mDoubleGetCostItemId, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(80, 0));
    end
end

---三倍领取
function UISpecialMissionPanel.GetThreeAward(go)
    CS.CSScene.MainPlayerInfo.ActiveInfo:SetCurrentActive(nil);
    if UISpecialMissionPanel:IsMoneyEnough(3) then
        networkRequest.ReqSubmitTask(UISpecialMissionPanel.tbl_task.id, 3)
        CS.CSMissionManager.Instance:ClearCurrentTask();
        --uimanager:ClosePanel("UISpecialMissionPanel")
        UISpecialMissionPanel.IsNeedClosePanel()
    else
        UISpecialMissionPanel.NoMoneyProcess();
        --Utility.ShowItemGetWay(UISpecialMissionPanel.mthreeGetCostItemId, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(80, 0));
    end
end

---多倍领取的时候,如果没有足够的货币,跳转到充值/首充界面
function UISpecialMissionPanel.NoMoneyProcess()
    Utility.TryShowFirstRechargePanel()
end

---是否需要关闭
function UISpecialMissionPanel.IsNeedClosePanel()
    if UISpecialMissionPanel.isOver then
        uimanager:ClosePanel("UISpecialMissionPanel")
    end
end

---玩家身上的道具是否足够双倍领取
function UISpecialMissionPanel:IsMoneyEnough(multiple)
    if multiple == 2 then
        if self.mDoubleGetCostItemId and self.mDoubleGetCostItemNum and self.mDoubleGetCostItemName then
            local playerHas = self:GetBagInfo():GetCoinAmount(self.mDoubleGetCostItemId)
            if playerHas < self.mDoubleGetCostItemNum then
                return false
            end
        end
    elseif multiple == 3 then
        if self.mthreeGetCostItemId and self.mthreeGetCostItemNum and self.mthreeGetCostItemName then
            local playerHas = self:GetBagInfo():GetCoinAmount(self.mthreeGetCostItemId)
            if playerHas < self.mthreeGetCostItemNum then
                return false
            end
        end
    end

    return true
end

---关闭面板
function UISpecialMissionPanel.OnExitClick(go)
    uimanager:ClosePanel("UISpecialMissionPanel")
end

---点击购买
function UISpecialMissionPanel.BuyCount(go)
    -- UISpecialMissionPanel.ShowBuyTips()

    UISpecialMissionPanel.UseItem(go)
end



--endregion
--region消息监听
function UISpecialMissionPanel.MainPlayerBeginWalk()
    uimanager:ClosePanel('UISpecialMissionPanel')
end

function UISpecialMissionPanel.TaskNpcDepartureView(id, npcID)
    local isFind, data = CS.Cfg_MapNpcTableManager.Instance.dic:TryGetValue(UISpecialMissionPanel.npcID)
    if isFind then
        if data.npcid == npcID then
            UISpecialMissionPanel.OnExitClick()
        end
    end
end

---返回雇佣兵任务面板信息(server)
function UISpecialMissionPanel.TaskInfoMessage()
    UISpecialMissionPanel.SetHeadline()
end

---返回日常任务面板信息(server)
function UISpecialMissionPanel.DailyTaskInfoMessage()
    UISpecialMissionPanel.SetHeadline()
end

--endregion
function ondestroy()
    UISpecialMissionPanel.mLB_name_UILabel = nil
    UISpecialMissionPanel.mLB_describe_UILabel = nil
    if UISpecialMissionPanel.ReleaseClientEventHandler ~= nil then
        UISpecialMissionPanel:ReleaseClientEventHandler()
    end

    uimanager:ClosePanel('UIActiveItemShowPanel')
    uimanager:ClosePanel("UISaleOrePanel");
    uimanager:ClosePanel("UIItemInfoPanel");
end

return UISpecialMissionPanel