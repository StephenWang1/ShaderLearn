---结义面板
---@class UIBrothersSwornPanel:UIBase
local UIBrothersSwornPanel = {}

--region 局部变量
--时间类型 1：同意倒计时 2: 结义倒计时
UIBrothersSwornPanel.timeType = 1
--结义任务模板列表
UIBrothersSwornPanel.playTempDic = {}
UIBrothersSwornPanel.goTempDic = {}
UIBrothersSwornPanel.IEnuRefreshTime = nil
--endregion

--region 初始化

function UIBrothersSwornPanel:Init()
    self:InitComponents()
    UIBrothersSwornPanel.BindUIEvents()
    UIBrothersSwornPanel.BindNetMessage()
end

function UIBrothersSwornPanel:Show()
    UIBrothersSwornPanel.InitUI()
end

--- 初始化组件
function UIBrothersSwornPanel:InitComponents()

    ---@type Top_UIGridContainer 好友列表
    UIBrothersSwornPanel.playerGrid = self:GetCurComp("WidgetRoot/view/Player/Scroll View/player", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 关闭按钮
    UIBrothersSwornPanel.CloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    ---@type UnityEngine.GameObject 拒绝按钮
    -- UIBrothersSwornPanel.btn_no = self:GetCurComp("WidgetRoot/events/btn_no", "GameObject")
    ---@type UnityEngine.GameObject 同意按钮
    --UIBrothersSwornPanel.btn_yes = self:GetCurComp("WidgetRoot/events/btn_yes", "GameObject")
    ---@type Top_UILabel 同意倒计时
    --UIBrothersSwornPanel.yestime = self:GetCurComp("WidgetRoot/events/yestime", "Top_UILabel")
    ---@type Top_UILabel 等待倒计时
    UIBrothersSwornPanel.publictime = self:GetCurComp("WidgetRoot/view/publictime", "Top_UILabel")

end

function UIBrothersSwornPanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UIBrothersSwornPanel.CloseBtn).onClick = UIBrothersSwornPanel.OnClickCloseBtn
    --点击拒绝事件
    --  CS.UIEventListener.Get(UIBrothersSwornPanel.btn_no).onClick = UIBrothersSwornPanel.OnClickbtn_no
    --点击同意事件
    -- CS.UIEventListener.Get(UIBrothersSwornPanel.btn_yes).onClick = UIBrothersSwornPanel.OnClickbtn_yes
end

function UIBrothersSwornPanel.BindNetMessage()
    --返回改变同意结义消息
    UIBrothersSwornPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAgreeSwornMessage, UIBrothersSwornPanel.OnResAgreeSwornMessageCallBack)
    --终止结义消息
    UIBrothersSwornPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResInterruptSwornMessage, UIBrothersSwornPanel.OnResInterruptSwornMessageCallBack)
    --进度条出现 关闭面板
    UIBrothersSwornPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSpecialEffectsMessage, UIBrothersSwornPanel.OnResSpecialEffectsMessageCallBack)
end
--endregion

--region 函数监听

--点击关闭函数
---@param go UnityEngine.GameObject
function UIBrothersSwornPanel.OnClickCloseBtn(go)
    networkRequest.ReqInterruptSworn()
    uimanager:ClosePanel('UIBrothersSwornPanel')
end

--endregion

--region 网络消息处理

function UIBrothersSwornPanel.OnResAgreeSwornMessageCallBack(id, data)
    if data then
        UIBrothersSwornPanel.RefreshStatu(data.rid, data.isAgree)
    end
end

function UIBrothersSwornPanel.OnResInterruptSwornMessageCallBack(id, data)
    uimanager:ClosePanel('UIBrothersSwornPanel')
end

function UIBrothersSwornPanel.OnResSpecialEffectsMessageCallBack(id, data)
    uimanager:ClosePanel('UIBrothersSwornPanel')
end

--endregion

--region UI
function UIBrothersSwornPanel.InitUI()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return
    end
    local swornList = UIBrothersSwornPanel.SortDic()
    UIBrothersSwornPanel.playerGrid.MaxCount = #swornList
    for i, v in pairs(swornList) do
        local go = UIBrothersSwornPanel.playerGrid.controlList[i - 1].gameObject
        local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBrotherSwornUnitTemplate)
        local infotemp = {}
        infotemp.spriteName = 'headicon' .. tostring(v.sex) .. tostring(v.career)
        infotemp.isMainPlayer = v.rid == CS.CSScene.MainPlayerInfo.ID
        infotemp.status = v.isAgree
        infotemp.time = v.disTime
        infotemp.name = v.name
        infotemp.levle = v.level
        infotemp.index = i
        temp:SetTemplate(infotemp)
        UIBrothersSwornPanel.goTempDic[v.rid] = go
        UIBrothersSwornPanel.playTempDic[go] = temp
    end
    UIBrothersSwornPanel.StartRefreshTime()
end

function UIBrothersSwornPanel.RefreshStatu(id, status)
    local go = UIBrothersSwornPanel.goTempDic[id]
    if go then
        local temp = UIBrothersSwornPanel.playTempDic[go]
        if temp then
            temp:RefreshStatu(status)
        end
    end
end
--endregion

--region otherFunction

function UIBrothersSwornPanel.StartRefreshTime()
    if UIBrothersSwornPanel.IEnuRefreshTime ~= nil then
        StopCoroutine(UIBrothersSwornPanel.IEnuRefreshTime)
        UIBrothersSwornPanel.IEnuRefreshTime = nil
    end
    UIBrothersSwornPanel.IEnuRefreshTime = StartCoroutine(UIBrothersSwornPanel.IenumRefreshTime)
end

function UIBrothersSwornPanel.IenumRefreshTime()

    local isRefresh = true
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return
    end
    coroutine.yield(nil)
    local refreshTime = CS.CSScene.MainPlayerInfo.FriendInfoV2.SwornRemainTime
    local serverNowTime = CS.CSServerTime.Instance.TotalMillisecond
    refreshTime = refreshTime - serverNowTime
    while isRefresh do
        if refreshTime <= 0 then
            isRefresh = false
            UIBrothersSwornPanel.publictime.text = luaEnumColorType.TimeCountRed .. "00:00后操作无效"
            networkRequest.ReqInterruptSworn()
            uimanager:ClosePanel('UIBrothersSwornPanel')
        end
        local hour, minute, second = Utility.MillisecondToFormatTime(refreshTime)
        local str = string.format("%02.0f:%02.0f", minute, second)
        UIBrothersSwornPanel.publictime.text = luaEnumColorType.TimeCountRed .. str .. "后操作无效"
        refreshTime = refreshTime - 1000
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end

function UIBrothersSwornPanel.SortDic()
    local swornList = {}
    local swronDic = CS.CSScene.MainPlayerInfo.FriendInfoV2.SwornDic
    local leaderId = CS.CSScene.MainPlayerInfo.FriendInfoV2.LeaderID
    for i, v in pairs(swronDic) do
        if v.rid == leaderId then
            table.insert(swornList, 1, v)
        else
            table.insert(swornList, v)
        end
    end
    return swornList
end

--endregion

--region ondestroy

function ondestroy()
    if UIBrothersSwornPanel.IEnuRefreshTime ~= nil then
        StopCoroutine(UIBrothersSwornPanel.IEnuRefreshTime)
        UIBrothersSwornPanel.IEnuRefreshTime = nil
    end
end

--endregion

return UIBrothersSwornPanel