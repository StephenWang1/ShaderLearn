local UIZodiacalAnimalsPanel = {}

--region 局部变量

--传送id
UIZodiacalAnimalsPanel.deliverID = 0;
--npc唯一ip
UIZodiacalAnimalsPanel.npcid = 0
--npc配置表ip
UIZodiacalAnimalsPanel.npcConfigId = 0
--animal boss 表 id
UIZodiacalAnimalsPanel.sxBossID = 0
--剩余人数
UIZodiacalAnimalsPanel.remainNum = 0

UIZodiacalAnimalsPanel.IEnumRefreshTime = nil
--endregion

function UIZodiacalAnimalsPanel.GetBtnHelp_GameObject()
    if (UIZodiacalAnimalsPanel.mBtnHelp_GameObject == nil) then
        UIZodiacalAnimalsPanel.mBtnHelp_GameObject = UIZodiacalAnimalsPanel:GetCurComp("WidgetRoot/event/btn_help", "GameObject")
    end
    return UIZodiacalAnimalsPanel.mBtnHelp_GameObject;
end

--region 初始化

function UIZodiacalAnimalsPanel:Init()
    self:InitComponents()
    UIZodiacalAnimalsPanel.BindUIEvents()
    UIZodiacalAnimalsPanel.BindNetMessage()
end

--- 初始化组件
function UIZodiacalAnimalsPanel:InitComponents()

    ---@type Top_UILabel  title
    UIZodiacalAnimalsPanel.lb_name = self:GetCurComp("WidgetRoot/view1/lb_name", "Top_UILabel")
    ---@type Top_UILabel   描述
    UIZodiacalAnimalsPanel.lb_dec = self:GetCurComp("WidgetRoot/view1/lb_dec", "Top_UILabel")
    ---@type Top_UIGridContainer  限制条件
    UIZodiacalAnimalsPanel.lb_cons = self:GetCurComp("WidgetRoot/view1/lb_cons", "Top_UIGridContainer")
    ---@type Top_UILabel   剩余进入人数
    UIZodiacalAnimalsPanel.num = self:GetCurComp("WidgetRoot/view1/lb_j1/num", "Top_UILabel")
    ---@type Top_UILabel   倒计时显示
    UIZodiacalAnimalsPanel.time = self:GetCurComp("WidgetRoot/view1/lb_j2/num", "Top_UILabel")
    ---@type Top_UILabel   灵兽等级
    UIZodiacalAnimalsPanel.lsLv = self:GetCurComp("WidgetRoot/view1/lb_j3/num", "Top_UILabel")
    ---@type Top_UIGridContainer  奖励
    UIZodiacalAnimalsPanel.rewardList1 = self:GetCurComp("WidgetRoot/ScrollView/rewardList1", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 关闭按钮
    UIZodiacalAnimalsPanel.btn_close = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
    ---@type UnityEngine.GameObject 前往按钮
    UIZodiacalAnimalsPanel.btn_sure = self:GetCurComp("WidgetRoot/event/btn_sure", "GameObject")

end

function UIZodiacalAnimalsPanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UIZodiacalAnimalsPanel.btn_close).onClick = UIZodiacalAnimalsPanel.OnClickbtn_close
    --点击前往事件
    CS.UIEventListener.Get(UIZodiacalAnimalsPanel.btn_sure).onClick = UIZodiacalAnimalsPanel.OnClickbtn_sure

    CS.UIEventListener.Get(UIZodiacalAnimalsPanel.GetBtnHelp_GameObject()).onClick = function()
        local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(126)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
        end
    end
end

function UIZodiacalAnimalsPanel.BindNetMessage()
    UIZodiacalAnimalsPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_TaskNpcDepartureView, UIZodiacalAnimalsPanel.NpcDepartureView)
    UIZodiacalAnimalsPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAnimalNPCInfoMessage, UIZodiacalAnimalsPanel.onResAnimalNPCInfoMessageCallBack)
    UIZodiacalAnimalsPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEnterNumRefreshMessage, UIZodiacalAnimalsPanel.onResEnterNumRefreshMessageCallBack)
end

function UIZodiacalAnimalsPanel:Show(npcConfigId, npcId)
    if npcConfigId and npcId then
        UIZodiacalAnimalsPanel.npcConfigId = npcConfigId == nil and 0 or npcConfigId
        UIZodiacalAnimalsPanel.npcid = npcId
        networkRequest.ReqAnimalNPCInfo(UIZodiacalAnimalsPanel.npcid)
        return
    end
    uimanager:ClosePanel('UIZodiacalAnimalsPanel')
end

--endregion

--region 函数监听

--点击关闭函数
---@param go UnityEngine.GameObject
function UIZodiacalAnimalsPanel.OnClickbtn_close(go)
    uimanager:ClosePanel('UIZodiacalAnimalsPanel')
end

--点击前往函数
---@param go UnityEngine.GameObject
function UIZodiacalAnimalsPanel.OnClickbtn_sure(go)
    if UIZodiacalAnimalsPanel.CheckCanBeTransmit() then
        networkRequest.ReqEnterMapByNPC(UIZodiacalAnimalsPanel.npcid, UIZodiacalAnimalsPanel.deliverID)
        uimanager:ClosePanel('UIZodiacalAnimalsPanel')
    end
end

--endregion


--region 网络消息处理

--初始化面板信息
function UIZodiacalAnimalsPanel.onResAnimalNPCInfoMessageCallBack(id, data)
    if data then
        UIZodiacalAnimalsPanel.remainNum = data.num
        UIZodiacalAnimalsPanel.sxBossID = data.monsterId
        UIZodiacalAnimalsPanel.RefreshNum(data.num)
        UIZodiacalAnimalsPanel.InitUI()
        if UIZodiacalAnimalsPanel.IEnumRefreshTime ~= nil then
            StopCoroutine(UIZodiacalAnimalsPanel.IEnumRefreshTime)
            UIZodiacalAnimalsPanel.IEnumRefreshTime = nil
        end
        UIZodiacalAnimalsPanel.IEnumRefreshTime = StartCoroutine(UIZodiacalAnimalsPanel.IEnumTimeCount, data.duration)
    end
end

---npc离开视野
function UIZodiacalAnimalsPanel.NpcDepartureView(id, npcID)
    if npcID then
        if UIZodiacalAnimalsPanel.npcConfigId == npcID then
            uimanager:ClosePanel('UIZodiacalAnimalsPanel')
        end
    end
end

--发送剩余人数
function UIZodiacalAnimalsPanel.onResEnterNumRefreshMessageCallBack(id, data)
    if data then
        if data.npcId == UIZodiacalAnimalsPanel.npcid then
            UIZodiacalAnimalsPanel.RefreshNum(data.num)
        end
    end
end



--endregion

--region UI

function UIZodiacalAnimalsPanel.InitUI()
    local des = UIZodiacalAnimalsPanel.GetDescription()
    if des then
        if (des[1] ~= nil) then
            UIZodiacalAnimalsPanel.lb_name .text = des[1]
        end
        if (des[2] ~= nil) then
            local psLabels = string.Split(string.gsub(des[2], "\\n", '#'), '#')
            UIZodiacalAnimalsPanel.lb_cons.MaxCount = #psLabels
            for i = 1, #psLabels do
                local temp = CS.Utility_Lua.GetComponent(UIZodiacalAnimalsPanel.lb_cons.controlList[i - 1].transform, 'UILabel')
                temp.text = psLabels[i]
            end
        end
    end

    local isFind, sxInfo = CS.Cfg_AnimalBossManager.Instance.dic:TryGetValue(UIZodiacalAnimalsPanel.sxBossID)
    if isFind then
        UIZodiacalAnimalsPanel.deliverID = sxInfo.deliverId
        UIZodiacalAnimalsPanel.lb_dec.text = sxInfo.description
        UIZodiacalAnimalsPanel.ShowItems(sxInfo.dropShowId)
    end

    local isFind, info = CS.Cfg_DeliverTableManager.Instance.dic:TryGetValue(UIZodiacalAnimalsPanel.deliverID)
    if isFind then
        if info.condition ~= nil then
            isFind, info = CS.Cfg_ConditionManager.Instance.dic:TryGetValue(info.condition)
            if isFind then
                if info.conditionType and info.conditionParam ~= nil and info.conditionParam.list ~= nil then
                    local str = info.conditionType == LuaEnumConditionKeyType.GreatServantLevel and '级' or '转'
                    local color = ""
                    if not CS. Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(info.id) then
                        color = luaEnumColorType.Red
                    end
                    UIZodiacalAnimalsPanel.lsLv.text = color .. info.conditionParam.list[0] .. str
                end
            end
        end
    end
end

function UIZodiacalAnimalsPanel.ShowItems(dropid)
    local items = UIZodiacalAnimalsPanel.GetItemWithCareerAndSex(dropid)
    if items == nil then
        return
    end
    UIZodiacalAnimalsPanel.rewardList1.MaxCount = #items
    for k, v in pairs(items) do
        local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(v)

        local go = UIZodiacalAnimalsPanel.rewardList1.controlList[k - 1]
        if infobool then
            local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
            temp:RefreshUIWithItemInfo(iteminfo, 1)
            CS.UIEventListener.Get(go.gameObject).onClick = function(go)
                if temp.ItemInfo ~= nil then
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = temp.ItemInfo })
                end
            end

        end
    end

end

function UIZodiacalAnimalsPanel.RefreshNum(num)

    UIZodiacalAnimalsPanel.num.text = num == 0 and '人数已满' or tostring(num)
end

--endregion

--region otherFunction

---获取生肖描述 126
function UIZodiacalAnimalsPanel.GetDescription()
    local isFind, item = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(38)
    if isFind then
        return string.Split(item.value, '&')
    end
    return nil
end

---筛选
function UIZodiacalAnimalsPanel.GetItemWithCareerAndSex(id)
    local isFind, dropinfo = CS.Cfg_BossDropShowTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        if (dropinfo.displayConditionType == 5) then
            --elseif (dropinfo.displayConditionType == 2) then
            --elseif (dropinfo.displayConditionType == 3) then
            --elseif (dropinfo.displayConditionType == 4) then
            --elseif (dropinfo.displayConditionType == 5) then
            local items = dropinfo.dropShow.list
            local length = dropinfo.dropShow.list.Count - 1
            for i = 0, length do
                local careritems = items[i].list
                local meetCarrer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career) == tonumber(careritems[0]) or tonumber(careritems[0]) == 0
                local meetSex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex) == tonumber(careritems[1]) or tonumber(careritems[1]) == 0
                --找到对应职业和性格的道具
                if (careritems ~= nil and meetCarrer and meetSex) then
                    local tbl = {}
                    for i2 = 2, careritems.Count - 1 do
                        table.insert(tbl, careritems[i2])
                    end
                    return tbl
                end
            end
        end
    end
end

---检测是否能够传送
function UIZodiacalAnimalsPanel.CheckCanBeTransmit()
    if UIZodiacalAnimalsPanel.remainNum == 0 then
        Utility.ShowPopoTips(UIZodiacalAnimalsPanel.btn_sure.transform, nil, 178)
        return false
    end
    local isFind, info = CS.Cfg_DeliverTableManager.Instance.dic:TryGetValue(UIZodiacalAnimalsPanel.deliverID)
    if isFind then
        if info.condition ~= nil and info.condition ~= 0 then
            isFind, info = CS.Cfg_ConditionManager.Instance.dic:TryGetValue(info.condition)
            if isFind then
                if info.conditionType then
                    local isMeet = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(info.id)
                    if not isMeet then
                        Utility.ShowPopoTips(UIZodiacalAnimalsPanel.btn_sure.transform, nil, info.conditionType == LuaEnumConditionKeyType.GreatServantLevel and 163 or 164)
                        return isMeet
                    end
                end
            end
        end
    end
    return true
end

--endregion


--region 倒计时协程
--单位毫秒
function UIZodiacalAnimalsPanel.IEnumTimeCount(time)
    local meetTime = true
    local totalTime = time
    while meetTime do
        local hour, minute, second = Utility.MillisecondToFormatTime(totalTime)
        if UIZodiacalAnimalsPanel.time ~= nil then
            UIZodiacalAnimalsPanel.time.text = string.format(luaEnumColorType.Red .. "%02.0f:%02.0f", minute, second)
        end
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
        totalTime = totalTime - 1000
        if totalTime <= 0 then
            meetTime = false
            UIZodiacalAnimalsPanel.time.text = '00:00'
            UIZodiacalAnimalsPanel:ClosePanel('UIShenXiangPanel')
        end
    end
end

--endregion

--region ondestroy

function UIZodiacalAnimalsPanel.OnDestroy()
    if UIZodiacalAnimalsPanel.IEnumRefreshTime ~= nil then
        StopCoroutine(UIZodiacalAnimalsPanel.IEnumRefreshTime)
        UIZodiacalAnimalsPanel.IEnumRefreshTime = nil
    end
    UIZodiacalAnimalsPanel:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_TaskNpcDepartureView, UIZodiacalAnimalsPanel.NpcDepartureView)
end

function ondestroy()
    UIZodiacalAnimalsPanel.OnDestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResAnimalNPCInfoMessage, UIZodiacalAnimalsPanel.onResAnimalNPCInfoMessageCallBack)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResEnterNumRefreshMessage, UIZodiacalAnimalsPanel.onResEnterNumRefreshMessageCallBack)
end

--endregion

return UIZodiacalAnimalsPanel