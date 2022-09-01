local UIShenXiangPanel = {}

--region 局部变量

UIShenXiangPanel.npcid = 0
UIShenXiangPanel.npcConfigid = 0
UIShenXiangPanel.DecNpcId = 0
UIShenXiangPanel.IEnumRefreshTime = nil

--endregion

--region 初始化

function UIShenXiangPanel:Init()
    self:InitComponents()
    UIShenXiangPanel.BindUIEvents()
    UIShenXiangPanel.BindNetMessage()
end

--- 初始化组件
function UIShenXiangPanel:InitComponents()
    ---@type UnityEngine.GameObject  关闭按钮
    UIShenXiangPanel.btn_close = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
    ---@type Top_UILabel  title
    UIShenXiangPanel.lb_name = self:GetCurComp("WidgetRoot/view2/lb_name", "Top_UILabel")
    ---@type Top_UILabel  倒计时
    UIShenXiangPanel.num = self:GetCurComp("WidgetRoot/view2/lb_time", "Top_UILabel")
    ---@type Top_UILabel  介绍
    UIShenXiangPanel.lb_dec = self:GetCurComp("WidgetRoot/view2/lb_dec", "Top_UILabel")
end

function UIShenXiangPanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UIShenXiangPanel.btn_close).onClick = UIShenXiangPanel.OnClickbtn_close
end

function UIShenXiangPanel.BindNetMessage()
    UIShenXiangPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSkyAngerGodInfoMessage, UIShenXiangPanel.onResSkyAngerGodInfoMessageCallBack)
    UIShenXiangPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_TaskNpcDepartureView, UIShenXiangPanel.NpcDepartureView)
end

function UIShenXiangPanel:Show(decId, npcConfigId, npcId)
    if decId and npcId then
        UIShenXiangPanel.DecNpcId = decId
        UIShenXiangPanel.npcid = npcId
        UIShenXiangPanel.npcConfigid = npcConfigId == nil and 0 or npcConfigId
        networkRequest.ReqSkyAngerGodInfo(UIShenXiangPanel.npcid)
        return
    end
    uimanager:ClosePanel('UIShenXiangPanel')
end

--endregion

--region 函数监听
--点击关闭函数
---@param go UnityEngine.GameObject
function UIShenXiangPanel.OnClickbtn_close(go)
    uimanager:ClosePanel('UIShenXiangPanel')
end
--endregion


--region 网络消息处理

function UIShenXiangPanel.onResSkyAngerGodInfoMessageCallBack(id, data)
    UIShenXiangPanel.InitUI()
    if UIShenXiangPanel.IEnumRefreshTime ~= nil then
        StopCoroutine(UIShenXiangPanel.IEnumRefreshTime)
        UIShenXiangPanel.IEnumRefreshTime = nil
    end
    UIShenXiangPanel.IEnumRefreshTime = StartCoroutine(UIShenXiangPanel.IEnumTimeCount, data.existenceTime)
end

---npc离开视野
function UIShenXiangPanel.NpcDepartureView(id, npcID)
    if npcID then
        if UIShenXiangPanel.npcConfigid == npcID then
            uimanager:ClosePanel('UIShenXiangPanel')
        end
    end
end

--endregion

--region UI

function UIShenXiangPanel.InitUI()
    local des = UIShenXiangPanel.GetDescription()
    if des then
        UIShenXiangPanel.lb_name .text = des[1]
        UIShenXiangPanel.lb_dec.text = des[2]
    end

end

--endregion

--region otherFunction
---获取天之boss的描述
function UIShenXiangPanel.GetDescription()
    if (UIShenXiangPanel.DecNpcId ~= 0) then
        local isFind, item = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(UIShenXiangPanel.DecNpcId)
        if isFind then
            return string.Split(item.value, '&')
        end
    end
    return nil
end

--endregion


--region 倒计时协程
--毫秒
function UIShenXiangPanel.IEnumTimeCount(time)
    local meetTime = true
    local totalTime = time
    while meetTime do
        local hour, minute, second = Utility.MillisecondToFormatTime(totalTime)
        if UIShenXiangPanel.num ~= nil then
            UIShenXiangPanel.num.text = luaEnumColorType.TimeCountRed .. string.format("%02.0f:%02.0f", minute, second) .. "后刷新"
        end
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
        totalTime = totalTime - 1000
        if totalTime <= 0 then
            meetTime = false
            UIShenXiangPanel.num.text = luaEnumColorType.TimeCountRed .. '00:00' .. "后刷新"
            uimanager:ClosePanel('UIShenXiangPanel')
        end

    end
end

--endregion

--region ondestroy

function UIShenXiangPanel.OnDestroy()
    if UIShenXiangPanel.IEnumRefreshTime ~= nil then
        StopCoroutine(UIShenXiangPanel.IEnumRefreshTime)
        UIShenXiangPanel.IEnumRefreshTime = nil
    end
    UIShenXiangPanel:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_TaskNpcDepartureView, UIShenXiangPanel.NpcDepartureView)
end

function ondestroy()
    UIShenXiangPanel.OnDestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResSkyAngerGodInfoMessage, UIShenXiangPanel.onResSkyAngerGodInfoMessageCallBack)

end

--endregion

return UIShenXiangPanel