---@class UILsMissionPanel : UIBase 灵兽任务面板
local UILsMissionPanel = {}

function UILsMissionPanel.GetLsMissionData()
    if UILsMissionPanel.missionData == nil then
        UILsMissionPanel.missionData = gameMgr:GetPlayerDataMgr():GetLsMissionData()
    end
    return UILsMissionPanel.missionData
end


--region 初始化

function UILsMissionPanel:Init()
    self:InitComponents()
    UILsMissionPanel.InitParameters()
    UILsMissionPanel.BindUIEvents()
    UILsMissionPanel.BindNetMessage()
end

---@param customData table
---@field customData.jumpSec number 跳转页签（若页签未开启则不跳转  暂留接口）
function UILsMissionPanel:Show(customData)
    if customData then
        UILsMissionPanel.curSec = customData.jumpSec
    end
    UILsMissionPanel.InitMissionTemplate()
end

---初始化变量
function UILsMissionPanel.InitParameters()
    ---当前显示章节
    UILsMissionPanel.curSec = 0
    ---文本格式
    UILsMissionPanel.fillAmountStrFormat = '完成目标  %d/%d'
    ---当前章节花费信息
    UILsMissionPanel.curGoldInfo = nil
end

---初始化模板
function UILsMissionPanel.InitMissionTemplate()
    ---任务视图模板
    ---@type UILsMissionPanel_TaskViewTemplate
    UILsMissionPanel.taskViewTemplate = templatemanager.GetNewTemplate(UILsMissionPanel.taskView, luaComponentTemplates.UILsMissionPanel_TaskViewTemplate)

    local targetsec = UILsMissionPanel.curSec
    ---页签视图模板
    ---@type UILsMissionPanel_PageViewTemplate
    UILsMissionPanel.taskPageTemplate = templatemanager.GetNewTemplate(UILsMissionPanel.pageView, luaComponentTemplates.UILsMissionPanel_PageViewTemplate)
    UILsMissionPanel.taskPageTemplate:SetTemplate({
        changeCallBack = UILsMissionPanel.ChangeSecCallBack,
        targetSec = targetsec
    })
end

---初始化组件
function UILsMissionPanel:InitComponents()

    ---@type Top_UISprite 标题
    UILsMissionPanel.title = self:GetCurComp('WidgetRoot/view/otherView/title', 'Top_UISprite')
    ---@type Top_UILabel 进度
    UILsMissionPanel.fillAmount = self:GetCurComp('WidgetRoot/view/otherView/fillAmount', 'Top_UILabel')
    ---@type Top_UILabel 解锁花费
    UILsMissionPanel.itemgold = self:GetCurComp('WidgetRoot/view/otherView/itemgold', 'Top_UILabel')
    ---@type Top_UISprite 解锁花费icon
    UILsMissionPanel.itemgold_Icon = self:GetCurComp('WidgetRoot/view/otherView/itemgold/Sprite', 'Top_UISprite')

    ---@type UnityEngine.GameObject 章节返还父物体
    UILsMissionPanel.complete_Root = self:GetCurComp('WidgetRoot/view/otherView/complete', 'GameObject')
    ---@type Top_UISprite 章节返还花费icon
    UILsMissionPanel.complete_goldIcon = self:GetCurComp('WidgetRoot/view/otherView/complete/gold', 'Top_UISprite')
    ---@type Top_UILabel 章节返还文本
    UILsMissionPanel.complete_Label = self:GetCurComp('WidgetRoot/view/otherView/complete/label', 'Top_UILabel')
    ---@type Top_UILabel 章节返还花费文本
    UILsMissionPanel.complete_goldLabel = self:GetCurComp('WidgetRoot/view/otherView/complete/num', 'Top_UILabel')

    ---@type UnityEngine.GameObject 页签视图
    UILsMissionPanel.pageView = self:GetCurComp('WidgetRoot/view/TitleScrollView', 'GameObject')
    ---@type UnityEngine.GameObject 任务视图
    UILsMissionPanel.taskView = self:GetCurComp('WidgetRoot/view/TaskScrollView/GridContainer/lsMissionViewTemplate', 'GameObject')

    ---@type UnityEngine.GameObject 关闭按钮
    UILsMissionPanel.btn_close = self:GetCurComp('WidgetRoot/events/btn_close', 'GameObject')
    ---@type UnityEngine.GameObject 一键解锁
    UILsMissionPanel.btn_lock = self:GetCurComp('WidgetRoot/events/btn_lock', 'GameObject')
    ---@type UnityEngine.GameObject 获取返利
    UILsMissionPanel.btn_get = self:GetCurComp('WidgetRoot/events/btn_get', 'GameObject')
    ---@type UnityEngine.GameObject 已获取
    UILsMissionPanel.geted = self:GetCurComp('WidgetRoot/events/geted', 'GameObject')
    ---@type Top_UILabel 灵兽解锁描述
    UILsMissionPanel.lb_des = self:GetCurComp('WidgetRoot/view/TaskScrollView/GridContainer/lsMissionViewTemplate/view/lb_des', 'Top_UILabel')
end

function UILsMissionPanel.BindUIEvents()
    CS.UIEventListener.Get(UILsMissionPanel.btn_close).onClick = UILsMissionPanel.OnClickCloseBtnCallBack
    CS.UIEventListener.Get(UILsMissionPanel.btn_lock).onClick = UILsMissionPanel.OnClickUnLockBtnCallBack
    CS.UIEventListener.Get(UILsMissionPanel.btn_get).onClick = UILsMissionPanel.OnClickGetBtnCallBack
end

function UILsMissionPanel.BindNetMessage()
    UILsMissionPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLingShouTaskPanelMessage, UILsMissionPanel.OnResLingShouTaskPanelMessageCallBack)
    UILsMissionPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLingShouTaskInfoMessage, UILsMissionPanel.OnResLingShouTaskInfoMessageCallBack)
    --UILsMissionPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnlockEffectMessage, UILsMissionPanel.OnResUnlockEffectMessageCallBack)
end
--endregion

--region 函数监听

---点击关闭按钮回调
function UILsMissionPanel.OnClickCloseBtnCallBack()
    uimanager:ClosePanel("UILsMissionPanel")
end

---点击解锁按钮回调
function UILsMissionPanel.OnClickUnLockBtnCallBack(go)
    if UILsMissionPanel.curGoldInfo == nil then
        return
    end

    local isFind, info = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(64)
    if isFind then
        local needID = UILsMissionPanel.curGoldInfo.goldId
        local needCount = UILsMissionPanel.curGoldInfo.count
        --local coinName = UILsMissionPanel.curGoldInfo.name
        local nowCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinNum(needID)
        local temp = {}
        temp.IsClose = false
        temp.IsShowGoldLabel = true
        temp.Content = string.format(info.des, UILsMissionPanel.curSec == 2 and '二' or '三')
        temp.Content = string.gsub(temp.Content, '\\n', '\n')
        temp.LeftDescription = info.leftButton
        temp.RightDescription = info.rightButton
        temp.GoldIcon = UILsMissionPanel.curGoldInfo.icon
        temp.GoldCount = needCount
        temp.ID = 248
        temp.CallBack = function(go)
            if nowCount < needCount then
                --local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(248)
                --if isfind then
                --    local str = string.format(data.content, coinName)
                --    Utility.ShowPopoTips(go.GetCenterButton_GameObject(), str, 248, "UILsMissionPanel")
                --end
                if (UILsMissionPanel.curSec == 2) then
                    Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.SecondServantSiteCurrencyNotEnough);
                elseif (UILsMissionPanel.curSec == 3) then
                    Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.ThirdServantSiteCurrencyNotEnough);
                end
                uimanager:ClosePanel('UIPromptPanel')
                return
            end
            networkRequest.ReqUnlockLingShouTask(UILsMissionPanel.curSec)
            uimanager:ClosePanel('UIPromptPanel')
        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end

---点击获取返利
function UILsMissionPanel.OnClickGetBtnCallBack()
    networkRequest.ReqGetSecRewards(UILsMissionPanel.curSec)
end

---点击页签回调
function UILsMissionPanel.ChangeSecCallBack(sec)
    UILsMissionPanel.curSec = sec
    --UILsMissionPanel.RefreshGoldInfoByCurSec()
    UILsMissionPanel.RefreshMainView()
    UILsMissionPanel.RefreshTaskView()
end

--endregion

--region 网络消息处理

---更新灵兽任务大包
function UILsMissionPanel.OnResLingShouTaskPanelMessageCallBack(id, tblData)
    if tblData and tblData.allComplete == 1 then
        uimanager:ClosePanel("UILsMissionPanel")
        return
    end
    UILsMissionPanel.RefreshPageView()
    UILsMissionPanel.RefreshBtnState()
    UILsMissionPanel.RefreshTaskView()
end

---更新灵兽任务信息
function UILsMissionPanel.OnResLingShouTaskInfoMessageCallBack()
    if UILsMissionPanel.taskViewTemplate ~= nil then
        UILsMissionPanel.taskViewTemplate:RefreshView()
    end
end

---解锁灵兽
function UILsMissionPanel.OnResUnlockEffectMessageCallBack(id, tblData)
    if tblData == nil or tblData.sec == nil then
        return
    end
    local panel = uimanager:GetPanel('UIServantHeadPanel')
    if panel == nil then
        return
    end
    local trans = panel:GetServantList_GameObject()
    if trans == nil then
        return
    end
    local targetObj = nil
    if tblData.sec == 1 then
        targetObj = trans.transform:Find("Pos/huanshou2/icon")
    elseif tblData.sec == 2 then
        targetObj = trans.transform:Find("Pos/huanshou3/icon")
    end

    local temp = {}
    temp.id = tblData.sec
    temp.TweenTarget = targetObj
    temp.tweenType = tblData.sec + 2
    temp.IsGet = true
    temp.EnterCallBack = function()

    end
    uimanager:CreatePanel('UIRewardShowTipPanel', nil, temp)
end

--endregion

--region UI

function UILsMissionPanel.RefreshMainView()

    -- local careerIndex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    local sexIndex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
    UILsMissionPanel.title.spriteName = 'weaponBookTitle_' .. UILsMissionPanel.curSec .. '_' .. tostring(sexIndex)
    UILsMissionPanel.title:MakePixelPerfect()
    if (LuaGlobalTableDeal:GetLsMissionUnLockDescription() ~= nil) then
        UILsMissionPanel.lb_des.text = LuaGlobalTableDeal:GetLsMissionUnLockDescription()[UILsMissionPanel.curSec - 1]
    end
    if UILsMissionPanel.GetLsMissionData():GetAllMissionDic()[UILsMissionPanel.curSec] ~= nil then
        local curFill = UILsMissionPanel.GetLsMissionData():GetFulfillMissionCount(UILsMissionPanel.curSec)
        local maxCount = #UILsMissionPanel.GetLsMissionData():GetAllMissionDic()[UILsMissionPanel.curSec]
        UILsMissionPanel.fillAmount.text = string.format(UILsMissionPanel.fillAmountStrFormat, curFill, maxCount)
    else
        UILsMissionPanel.fillAmount.text = ''
    end

    ---设置花费
    if UILsMissionPanel.curGoldInfo ~= nil then
        UILsMissionPanel.itemgold_Icon.spriteName = UILsMissionPanel.curGoldInfo ~= nil and
                UILsMissionPanel.curGoldInfo.icon or ''
        UILsMissionPanel.itemgold.text = UILsMissionPanel.curGoldInfo ~= nil and
                UILsMissionPanel.curGoldInfo.count or ''
        UILsMissionPanel.itemgold:UpdateAnchors()

        UILsMissionPanel.complete_goldIcon.spriteName = UILsMissionPanel.curGoldInfo ~= nil and
                UILsMissionPanel.curGoldInfo.icon or ''
        UILsMissionPanel.complete_goldLabel.text = UILsMissionPanel.curGoldInfo ~= nil and
                UILsMissionPanel.curGoldInfo.count or ''
        UILsMissionPanel.complete_goldLabel:UpdateAnchors()
        UILsMissionPanel.complete_Label:UpdateAnchors()
    end
    UILsMissionPanel.RefreshBtnState()
end

---刷新页签
function UILsMissionPanel.RefreshPageView()
    UILsMissionPanel.taskPageTemplate:Refresh()
end

---刷新任务
function UILsMissionPanel.RefreshTaskView()
    UILsMissionPanel.taskViewTemplate:Refresh(UILsMissionPanel.curSec)
end

function UILsMissionPanel.RefreshBtnState()
    ---@type lingshouV2.LinshouSectionInfo
    local secInfo = UILsMissionPanel.GetLsMissionData():GetSecStateDic()[UILsMissionPanel.curSec]

    UILsMissionPanel.itemgold.gameObject:SetActive(secInfo ~= nil and secInfo.lockState == LuaLsMissionSecStateEnum.Lock and self.curGoldInfo ~= nil)

    UILsMissionPanel.complete_Root:SetActive(secInfo ~= nil and secInfo.lockState == LuaLsMissionSecStateEnum.UnLock and self.curGoldInfo ~= nil)

    UILsMissionPanel.btn_lock.gameObject:SetActive(secInfo ~= nil and secInfo.lockState == LuaLsMissionSecStateEnum.Lock and self.curGoldInfo ~= nil)

    UILsMissionPanel.btn_get:SetActive(secInfo ~= nil and secInfo.lockState == LuaLsMissionSecStateEnum.CanGet)

    UILsMissionPanel.geted:SetActive(secInfo ~= nil and secInfo.lockState == LuaLsMissionSecStateEnum.Geted)
end

--endregion

--region otherFunction

---刷新花费信息
function UILsMissionPanel.RefreshGoldInfoByCurSec()
    if UILsMissionPanel.curSec == 1 then
        UILsMissionPanel.curGoldInfo = LuaGlobalTableDeal:GetLsMissionLxUnlockCoinInfo()
    elseif UILsMissionPanel.curSec == 2 then
        UILsMissionPanel.curGoldInfo = LuaGlobalTableDeal:GetLsMissionTcUnlockCoinInfo()
    else
        UILsMissionPanel.curGoldInfo = nil
    end
end

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UILsMissionPanel