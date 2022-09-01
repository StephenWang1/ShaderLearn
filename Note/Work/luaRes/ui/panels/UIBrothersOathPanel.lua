---@class UIBrothersOathPanel:UIBase
local UIBrothersOathPanel = {}

--region 局部变量
UIBrothersOathPanel.IEnuREfreshTime = nil
--endregion

--region 初始化

function UIBrothersOathPanel:Init()
    self:InitComponents()
    UIBrothersOathPanel.BindUIEvents()
    UIBrothersOathPanel.BindNetMessage()
    UIBrothersOathPanel.InitTime()
end

--- 初始化组件
function UIBrothersOathPanel:InitComponents()
    ---@type Top_UISlider 进度条
    UIBrothersOathPanel.ProcessBar = self:GetCurComp("ProcessBar", "Top_UISlider")
    ---@type UnityEngine.GameObject 跳过按钮
    UIBrothersOathPanel.btn_over = self:GetCurComp("btn_over", "GameObject")
    ---@type UnityEngine.Transform 特效节点
    UIBrothersOathPanel.effect = self:GetCurComp("Table/effect", "Transform")
    ---@type UnityEngine.GameObject
    UIBrothersOathPanel.btn_Close = self:GetCurComp("btn_Close", "GameObject")
end

function UIBrothersOathPanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UIBrothersOathPanel.btn_Close).onClick = UIBrothersOathPanel.OnClickbtn_Close
    --点击跳过事件
    CS.UIEventListener.Get(UIBrothersOathPanel.btn_over).onClick = UIBrothersOathPanel.OnClickbtn_over
end

function UIBrothersOathPanel.BindNetMessage()
    --终止结义消息
    UIBrothersOathPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResInterruptSwornMessage, UIBrothersOathPanel.OnResInterruptSwornMessageCallBack)
end
--endregion

--region 函数监听

--点击关闭函数
---@param go UnityEngine.GameObject
function UIBrothersOathPanel.OnClickbtn_Close(go)
    networkRequest.ReqInterruptSworn()
    uimanager:ClosePanel('UIBrothersOathPanel')
end

--点击跳过函数
---@param go UnityEngine.GameObject
function UIBrothersOathPanel.OnClickbtn_over(go)
    local leaderId = CS.CSScene.MainPlayerInfo.FriendInfoV2.LeaderID
    if leaderId == CS.CSScene.MainPlayerInfo.ID then
        networkRequest.ReqSwornSuccess()
    end
    uimanager:ClosePanel('UIBrothersOathPanel')
end
--endregion


--region 网络消息处理
function UIBrothersOathPanel.OnResInterruptSwornMessageCallBack()
    uimanager:ClosePanel('UIBrothersOathPanel')
end
--endregionu

--region UI

function UIBrothersOathPanel.InitTime ()
    if UIBrothersOathPanel.IEnuREfreshTime ~= nil then
        StopCoroutine(UIBrothersOathPanel.IEnuREfreshTime)
        UIBrothersOathPanel.IEnuREfreshTime = nil
    end
    UIBrothersOathPanel.IEnuREfreshTime = StartCoroutine(UIBrothersOathPanel.IenumRefreshTime)
end

--endregion

--region otherFunction
function UIBrothersOathPanel.IenumRefreshTime()
    local isRefresh = true
    local fillTime = 0.05
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return
    end
    local TargetfillAmount = CS.CSScene.MainPlayerInfo.FriendInfoV2.FillTime
    local fillAmount = 0
    while isRefresh do
        if fillAmount >= 1.0 then
            isRefresh = false
            UIBrothersOathPanel.ProcessBar.value = 1
            networkRequest.ReqSwornSuccess()
            uimanager:ClosePanel('UIBrothersOathPanel')
        end
        fillAmount = fillAmount + fillTime / TargetfillAmount
        UIBrothersOathPanel.ProcessBar.value = fillAmount
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(fillTime))
    end
end
--endregion

--region ondestroy

function ondestroy()
    if UIBrothersOathPanel.IEnuREfreshTime ~= nil then
        StopCoroutine(UIBrothersOathPanel.IEnuREfreshTime)
        UIBrothersOathPanel.IEnuREfreshTime = nil
    end
end

--endregion

return UIBrothersOathPanel