---@class UILsSchoolPanel 灵兽学院
local UILsSchoolPanel = {}

--region 局部变量
--当前章节
UILsSchoolPanel.curPage = 1
--章节奖励id列表
UILsSchoolPanel.stcRewardIDList = {}
UILsSchoolPanel.rewardViewTemplat = nil

UILsSchoolPanel.itemTempDic = {}
UILsSchoolPanel.isCallCloseCallBack = true
--endregion

--region 初始化

function UILsSchoolPanel:Init()
    UILsSchoolPanel:InitComponents()
    UILsSchoolPanel.BindUIEvents()
    UILsSchoolPanel.BindNetMessage()
    UILsSchoolPanel.InitUI()
end
function UILsSchoolPanel:Show()
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.LSSchoolPanel
    UILsSchoolPanel.closeCallBack = callback
end

--- 初始化组件
function UILsSchoolPanel:InitComponents()
    ---@type Top_UIGridContainer  任务阶段进度模板Grid
    UILsSchoolPanel.GridContainer = self:GetCurComp("WidgetRoot/SchoolPanel/view/TitleScrollView/GridContainer", "Top_UIGridContainer")
    ---@type Top_UIGridContainer  任务模板Grid
    UILsSchoolPanel.GridTaskContainer = self:GetCurComp("WidgetRoot/SchoolPanel/view/TaskScrollView/GridContainer", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 关闭按钮
    UILsSchoolPanel.btn_close = self:GetCurComp("WidgetRoot/SchoolPanel/events/btn_close", "GameObject")
    ---@type Top_UILabel 任务描述
    UILsSchoolPanel.Label = self:GetCurComp("WidgetRoot/SchoolPanel/view/Label", "Top_UILabel")
    ---@type UnityEngine.GameObject 奖励展示模板
    UILsSchoolPanel.rewardShowTemplate = self:GetCurComp("WidgetRoot/SchoolPanel/view/rewardShowTemplate", "GameObject")
    ---@type UnityEngine.GameObject 一键解锁
    UILsSchoolPanel.btn_buy = self:GetCurComp("WidgetRoot/SchoolPanel/events/btn_buy", "GameObject")
    ---@type UnityEngine.GameObject 任务蒙层
    UILsSchoolPanel.shadow = self:GetCurComp("WidgetRoot/SchoolPanel/view/shadow", "GameObject")
    ---@type Top_TweenPosition
    UILsSchoolPanel.spr_TweenPos = self:GetCurComp("WidgetRoot/tweenPosition", "Top_TweenPosition")
    ---@type Top_UISpriteAnimation
    UILsSchoolPanel.spr_Anim1 = self:GetCurComp("WidgetRoot/tweenPosition/spr_animation1", "Top_UISpriteAnimation")
    ---@type Top_UISpriteAnimation
    UILsSchoolPanel.spr_Anim2 = self:GetCurComp("WidgetRoot/tweenPosition/spr_animation2", "Top_UISpriteAnimation")
    ---@type Top_UISpriteAnimation
    UILsSchoolPanel.spr_Anim3 = self:GetCurComp("WidgetRoot/tweenPosition/spr_animation3", "Top_UISpriteAnimation")
    ---@type UnityEngine.GameObject
    UILsSchoolPanel.SchoolPanel = self:GetCurComp("WidgetRoot/SchoolPanel", "GameObject")
end

function UILsSchoolPanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UILsSchoolPanel.btn_close).onClick = UILsSchoolPanel.OnClickbtn_close
    --点击一键解锁事件
    -- CS.UIEventListener.Get(UILsSchoolPanel.btn_buy).onClick = UILsSchoolPanel.OnClickbtn_buy
end

function UILsSchoolPanel.BindNetMessage()
    UILsSchoolPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLingShouTaskInfoMessage, UILsSchoolPanel.OnUpdataLsTaskCallBack)
    UILsSchoolPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLinshouSectionInfoMessage, UILsSchoolPanel.OnUpdataLsStcCallBack)
    UILsSchoolPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLingShouTaskPanelMessage, UILsSchoolPanel.OnUpdataLsStcCallBack)

end
--endregion

--region 函数监听
--点击关闭函数
---@param go UnityEngine.GameObject
function UILsSchoolPanel.OnClickbtn_close(go)
    uimanager:ClosePanel('UILsSchoolPanel')
end

--点击一键解锁函数
---@param go UnityEngine.GameObject
function UILsSchoolPanel.OnClickbtn_buy(go)
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20354)
    if isFind then
        local infoArray = string.Split(info.value, '#')
        uimanager:CreatePanel("UIPromptSecondPanel", nil, {
            Title = infoArray[1],
            Content = infoArray[2],
            ButtonDescription = infoArray[3],
            EnterCallBack = function()
                networkRequest.ReqUnlockLingShouTask()
            end
        })
    end
end

--endregion


--region 网络消息处理

---更新灵兽任务
function UILsSchoolPanel.OnUpdataLsTaskCallBack(id, data)
    UILsSchoolPanel.RefreshData()
    UILsSchoolPanel.RefreshTaskGrid()
    UILsSchoolPanel.RefreshAwardView()
    --UILsSchoolPanel.RefreshBuyBtnStatu()
end

---更新灵兽章节信息
function UILsSchoolPanel.OnUpdataLsStcCallBack(id, data)
    UILsSchoolPanel.RefreshData()
    --UILsSchoolPanel.RefreshTitleGrid()
    UILsSchoolPanel.RefreshTaskGrid()
    UILsSchoolPanel.RefreshAwardView()
    --UILsSchoolPanel.RefreshBuyBtnStatu()
end


--endregion

--region UI

function UILsSchoolPanel.InitUI()
    UILsSchoolPanel.RefreshData()
    --UILsSchoolPanel.RefreshTitleGrid()
    UILsSchoolPanel.RefreshTaskGrid()
    UILsSchoolPanel.RefreshAwardView()
    UILsSchoolPanel.InitAnim()
    --UILsSchoolPanel.RefreshBuyBtnStatu()
end

function UILsSchoolPanel.RefreshTitleGrid()
    local stcArray = UILsSchoolPanel.GetMaxStcCount()
    if stcArray then
        UILsSchoolPanel.GridContainer.MaxCount = #stcArray
        for i, v in pairs(stcArray) do
            local go = UILsSchoolPanel.GridContainer.controlList[i - 1].gameObject
            local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UILsSchoolTitleTemplate)
            local infotemp = {}
            local secCount = CS.CSMissionManager.Instance.LsMisssionMgr:GetFulfillStc()
            infotemp.title = v
            infotemp.isOpen = i <= secCount
            infotemp.isCur = i == UILsSchoolPanel.curPage
            infotemp.callBack = function()
                UILsSchoolPanel.curPage = i
                UILsSchoolPanel.RefreshTaskGrid()
                UILsSchoolPanel.RefreshAwardView()
                UILsSchoolPanel.RefreshTitleGrid()
                --UILsSchoolPanel.RefreshBuyBtnStatu()
                --UILsSchoolPanel.SetShadow(infotemp.isOpen)
            end
            if infotemp.isCur then
                --UILsSchoolPanel.SetShadow(infotemp.isOpen)
            end
            temp:SetTemplate(infotemp)
        end
    end
end

function UILsSchoolPanel.RefreshTaskGrid()
    if CS.CSMissionManager.Instance.LsMisssionMgr ~= nil then
        local isFind, missionList = CS.CSMissionManager.Instance.LsMisssionMgr.missionDic:TryGetValue(UILsSchoolPanel.curPage)
        if isFind then
            UILsSchoolPanel.GridTaskContainer.MaxCount = missionList.Count
            for i = 0, missionList.Count - 1 do
                local go = UILsSchoolPanel.GridTaskContainer.controlList[i].gameObject
                local temp = UILsSchoolPanel.itemTempDic[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UILsSchoolItemTemplate) or UILsSchoolPanel.itemTempDic[go]
                local infotemp = {}
                infotemp = missionList[i]
                temp:SetTemplate(infotemp, i)
                --local isfind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(infotemp.rewardID)
                --if isfind then
                --    CS.UIEventListener.Get(go.gameObject).onClick = function(go)
                --        uimanager:CreatePanel("UIItemInfoPanel", function(panel)
                --            --UILsSchoolPanel.SetItemInfoPos(panel)
                --        end, LuaEnumItemInfoPanelInitType.InitWithItemInfo, info)
                --    end
                --end
                if UILsSchoolPanel.itemTempDic[go] == nil then
                    UILsSchoolPanel.itemTempDic[go] = temp
                end
            end
        end
    end
end

function UILsSchoolPanel.RefreshAwardView()
    local rewardLsit = UILsSchoolPanel.GetRewardList()
    if rewardLsit.Count ~= 0 then
        if UILsSchoolPanel.rewardViewTemplat == nil then
            UILsSchoolPanel.rewardViewTemplat = templatemanager.GetNewTemplate(UILsSchoolPanel.rewardShowTemplate, luaComponentTemplates.UILsSchoolRewardViewTemplate)
        end
        local tempInfo = {}
        tempInfo.itemID = rewardLsit[UILsSchoolPanel.curPage]
        tempInfo.Stc = UILsSchoolPanel.curPage
        tempInfo.closeCallBack = UILsSchoolPanel.closeCallBack
        UILsSchoolPanel.rewardViewTemplat:SetTemplate(tempInfo)
    end
end

function UILsSchoolPanel.SetShadow(isHide)
    UILsSchoolPanel.shadow.gameObject:SetActive(not isHide)
end

function UILsSchoolPanel.RefreshBuyBtnStatu()
    local open = false
    local pageArray = UILsSchoolPanel.GetMaxStcCount()
    if UILsSchoolPanel.curPage == #pageArray and not CS.CSMissionManager.Instance.LsMisssionMgr:isRewardGeted(#pageArray) then
        open = true
    end
    UILsSchoolPanel.btn_buy:SetActive(open)

end

--endregion

--region otherFunction
function UILsSchoolPanel.RefreshData()
    UILsSchoolPanel.curPage = CS.CSMissionManager.Instance.LsMisssionMgr:GetCurStc()
    --  UILsSchoolPanel.ShowPage = CS.CSMissionManager.Instance.LsMisssionMgr:GetCurStc()
end


--获得章节总数及内容
function UILsSchoolPanel.GetMaxStcCount()
    local isFind, titleInfo = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(50002)
    if isFind then
        return string.Split(titleInfo.value, '#')
    end
end

function UILsSchoolPanel.GetRewardList()
    local isFind, rewardInfo = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(50001)
    if isFind then
        return string.Split(rewardInfo.value, '#')
    end
end


--endregion

--region 动画处理

---动画初始化
function UILsSchoolPanel.InitAnim()
    --UILsSchoolPanel.spr_Anim1.loop = false
    UILsSchoolPanel.spr_Anim1.gameObject:SetActive(false)
    UILsSchoolPanel.spr_Anim2.gameObject:SetActive(false)
    UILsSchoolPanel.spr_Anim3.gameObject:SetActive(false)
    UILsSchoolPanel.SchoolPanel:SetActive(true)
    UILsSchoolPanel.spr_TweenPos.enabled = false
end

---播放动画
function UILsSchoolPanel.PlayAnim()
    UILsSchoolPanel.SchoolPanel:SetActive(false)
    UILsSchoolPanel.spr_TweenPos.gameObject:SetActive(true);
    UILsSchoolPanel.spr_Anim1:ResetToBeginning()
    UILsSchoolPanel.spr_Anim1.OnFinish = function()
        UILsSchoolPanel.spr_Anim2:ResetToBeginning()
        UILsSchoolPanel.spr_Anim2.OnFinish = function()
            UILsSchoolPanel.PlayTweenPos()
        end
        UILsSchoolPanel.spr_Anim2:Play()
    end
    UILsSchoolPanel.spr_Anim1:Play()
end

---播放tweenPos动画
function UILsSchoolPanel.PlayTweenPos()
    local panel = uimanager:GetPanel('UIServantHeadPanel')
    if panel == nil then
        UILsSchoolPanel.spr_Anim1.gameObject:SetActive(false)
        UILsSchoolPanel.spr_Anim2.gameObject:SetActive(false)
        UILsSchoolPanel.spr_Anim3.gameObject:SetActive(false)
        return
    end
    local trans = panel:GetServantList_GameObject()
    if trans == nil then
        UILsSchoolPanel.spr_Anim1.gameObject:SetActive(false)
        UILsSchoolPanel.spr_Anim2.gameObject:SetActive(false)
        UILsSchoolPanel.spr_Anim3.gameObject:SetActive(false)
        return
    end
    local targetObj = trans.transform:Find("Pos/huanshou3/icon")
    if targetObj == nil then
        UILsSchoolPanel.spr_Anim1.gameObject:SetActive(false)
        UILsSchoolPanel.spr_Anim2.gameObject:SetActive(false)
        UILsSchoolPanel.spr_Anim3.gameObject:SetActive(false)
        return
    end
    ----设置目标
    UILsSchoolPanel.spr_TweenPos.to = UILsSchoolPanel.spr_TweenPos.transform.parent:InverseTransformPoint(targetObj.position)
    ----设置动画回调
    UILsSchoolPanel.spr_TweenPos:SetOnFinished(UILsSchoolPanel.TweenPosCallBack)
    UILsSchoolPanel.spr_TweenPos.enabled = true
    UILsSchoolPanel.spr_TweenPos:PlayTween()
end

---Pos动画回调
function UILsSchoolPanel.TweenPosCallBack()
    networkRequest.ReqUnlockLingShouTask()
    --UILsSchoolPanel.spr_Anim3.namePrefix = "greenend"
    UILsSchoolPanel.spr_Anim3:ResetToBeginning()
    UILsSchoolPanel.spr_Anim3.OnFinish = function()
        uimanager:ClosePanel('UILsSchoolPanel')
    end
    UILsSchoolPanel.spr_Anim3:Play()

end

--endregion

--region ondestroy

function ondestroy()
    Utility.ShowUnionPushPrompt()
    if UILsSchoolPanel.isCallCloseCallBack then
        luaEventManager.DoCallback(LuaCEvent.ShowLvPackEffect)
    end
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResLingShouTaskInfoMessage, UILsSchoolPanel.OnUpdataLsTaskCallBack)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResLinshouSectionInfoMessage, UILsSchoolPanel.OnUpdataLsStcCallBack)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResLingShouTaskPanelMessage, UILsSchoolPanel.OnUpdataLsStcCallBack)
end

--endregion

return UILsSchoolPanel