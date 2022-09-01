--等级奖励
---@class UILvPackPanel:UIBase
local UILvPackPanel = {}
UILvPackPanel.PanelLayerType = CS.UILayerType.BasicPlane

--region 局部变量

UILvPackPanel.id = 1000000
UILvPackPanel.isGet = false
UILvPackPanel.targetValue = 0
UILvPackPanel.flyTargeTrans = nil
UILvPackPanel.IconName = ''
UILvPackPanel.TimeRefreshCoroutine = nil
UILvPackPanel.lvPackTemp = nil
---物品按钮的交互开关
UILvPackPanel.isClick = true
--防止第一时间加载多个特效
UILvPackPanel. isLoadNum = -1
---提示特效
UILvPackPanel.promptEffect1 = nil
UILvPackPanel.promptEffect1_Path = ''
UILvPackPanel.promptEffect2 = nil
UILvPackPanel.promptEffect2_Path = ''

UILvPackPanel.promptEffectTask1 = nil
UILvPackPanel.promptEffectTask1_Path = ''
UILvPackPanel.promptEffectTask2 = nil
UILvPackPanel.promptEffectTask2_Path = ''
UILvPackPanel.promptEffectTask3 = nil
UILvPackPanel.promptEffectTask3_Path = ''

--endregion

--region 初始化

function UILvPackPanel:Init()
    self:InitComponents()
    UILvPackPanel.BindUIEvents()
    UILvPackPanel.BindMessage()
    UILvPackPanel.InitUI()
    networkRequest.ReqGetLevelPacksInfo()
end

--- 初始化组件
function UILvPackPanel:InitComponents()

    ---@type UnityEngine.GameObject  父节点
    UILvPackPanel.main = self:GetCurComp("WidgetRoot/main", "GameObject")
    ---@type Top_UILabel 标题
    UILvPackPanel.lb_state = self:GetCurComp("WidgetRoot/main/topTitle", "Top_UILabel")
    ---@type UnityEngine.GameObject 物品预设父物体
    UILvPackPanel.spr_static = self:GetCurComp("WidgetRoot/main/btn_lvPacks/spr_static", "UISprite")
    ---@type UnityEngine.GameObject 物品按钮
    UILvPackPanel.btn_lvPacks = self:GetCurComp("WidgetRoot/main/btn_lvPacks", "GameObject")
    ---@type UnityEngine.GameObject 带有动画的Icon
    UILvPackPanel.spr_animation = self:GetCurComp("WidgetRoot/main/btn_lvPacks/spr_animation", "GameObject")
    ---@type GameObject 静态的Icon
    UILvPackPanel.spr_staticGo = nil;
    ---@type UISpriteAnimation
    UILvPackPanel.spr_staticAnimation1 = self:GetCurComp("WidgetRoot/main/btn_lvPacks/spr_animation1", "Top_UISpriteAnimation")
    ---@type UISpriteAnimation
    UILvPackPanel.spr_staticAnimation2 = self:GetCurComp("WidgetRoot/main/btn_lvPacks/spr_animation2", "Top_UISpriteAnimation")
    ---@type UISpriteAnimation
    UILvPackPanel.spr_staticAnimation3 = self:GetCurComp("WidgetRoot/main/btn_lvPacks/spr_animation3", "Top_UISpriteAnimation")
    ---@type UnityEngine.GameObject  bg
    UILvPackPanel.bg = self:GetCurComp("WidgetRoot/main/bg", "GameObject")
    ---@type UnityEngine.GameObject 任务父节点
    UILvPackPanel.lv_TaskFill = self:GetCurComp("WidgetRoot/main/lv_TaskFill", "GameObject")
    ---@type Top_UISprite 任务进度条
    UILvPackPanel.Taskexp = self:GetCurComp("WidgetRoot/main/lv_TaskFill/Taskexp", "Top_UISprite")
    ---@type Top_UILabel  任务进度
    UILvPackPanel.taskexpvalue = self:GetCurComp("WidgetRoot/main/taskeAmount", "Top_UILabel")
    UILvPackPanel.taskexpLabelBg = self:GetCurComp("WidgetRoot/main/btn_lvPacks/bg2", "GameObject")
    ---@type Top_UISprite 背景底
    UILvPackPanel.lowBG = self:GetCurComp("WidgetRoot/main/bg/Sprite", "Top_UISprite")

    --UILvPackPanel.effectParent = self:GetCurComp("WidgetRoot/main/btn_lvPacks/spr_static", "Transform")

    ---@type UnityEngine.Transform
    UILvPackPanel.effectParent = self:GetCurComp("WidgetRoot/main/btn_lvPacks/effectParent", "Transform")

    ---当前中的活动图标
    self.WidgetRoot_GameObject = self:GetCurComp("WidgetRoot", "GameObject")
    self.leftIconTemplate = templatemanager.GetNewTemplate(self.WidgetRoot_GameObject, luaComponentTemplates.UILvPackPanel_LeftIconTemplate)
end

function UILvPackPanel.BindUIEvents()
    CS.UIEventListener.Get(UILvPackPanel.btn_lvPacks).onClick = UILvPackPanel.OnClickbtn_lvPacks
end

function UILvPackPanel.BindMessage()
    UILvPackPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLevelPacksInfoMessage, UILvPackPanel.OnResLevelPacksInfoMessageCallBack)
    UILvPackPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLingShouTaskInfoMessage, UILvPackPanel.OnUpdataLsStcCallBack)
    UILvPackPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLinshouSectionInfoMessage, UILvPackPanel.OnUpdataLsStcCallBack)
    UILvPackPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLingShouTaskPanelMessage, UILvPackPanel.OnUpdataLsStcCallBack)
    UILvPackPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ShowLvPackEffect, UILvPackPanel.ShowLvPackEffect)
    --监听客户端升级事件
    UILvPackPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, UILvPackPanel.onLevelChangeCallBack)
end
--endregion

--region 函数监听

---点击物品按钮函数
---@param go UnityEngine.GameObject
function UILvPackPanel.OnClickbtn_lvPacks(go)
    if not UILvPackPanel.isClick then
        return
    end
    StopCoroutine(UILvPackPanel.TimeRefreshCoroutine)
    UILvPackPanel.TimeRefreshCoroutine = nil
    if UILvPackPanel.lvPackTemp ~= nil then
        if UILvPackPanel.lvPackTemp.tasktype == LuaEnumLvPackTaskType.OpenLsSchoolPanel and UILvPackPanel.lvPackTemp.type == 1 then
            UILvPackPanel.ShowLsSchool()
        else
            --UILvPackPanel.ShowRewardTips()
        end
    end

end

--endregion

--region 网络消息处理

function UILvPackPanel.OnResLevelPacksInfoMessageCallBack(id, data)
    if data then
        if UILvPackPanel.id == data.LevelPacks and UILvPackPanel.isGet == data.isDraw then
            return
        end
        UILvPackPanel.id = data.LevelPacks
        UILvPackPanel.isGet = data.isDraw
        _, UILvPackPanel.lvPackTemp = CS.Cfg_LvpackTableManager.Instance.dic:TryGetValue(data.LevelPacks)
        if UILvPackPanel.lvPackTemp == nil then
            if isOpenLog then
                luaDebug.Log(" 表里无此id的数据" .. data.LevelPacks)
            end
        end
        UILvPackPanel.RefreshUI()
        if data.isDraw and UILvPackPanel.lvPackTemp ~= nil then
            if UILvPackPanel.lvPackTemp.tasktype ~= LuaEnumLvPackTaskType.OpenLsSchoolPanel and UILvPackPanel.isClick then
                if UILvPackPanel.TimeRefreshCoroutine ~= nil then
                    StopCoroutine(UILvPackPanel.TimeRefreshCoroutine)
                    UILvPackPanel.TimeRefreshCoroutine = nil
                end
                UILvPackPanel.TimeRefreshCoroutine = StartCoroutine(UILvPackPanel.IEnumTimeRefresh)
            end
        else
            Utility.ShowUnionPushPrompt()
        end
    end
end

function UILvPackPanel.OnUpdataLsStcCallBack(id, data)
    if UILvPackPanel.lvPackTemp == nil or UILvPackPanel.lvPackTemp.tasktype ~= LuaEnumLvPackTaskType.OpenLsSchoolPanel then
        return
    end
    UILvPackPanel.GetLsSchooTaskInfo()
    UILvPackPanel.RefreshTaskFill()
    UILvPackPanel.RefreshTitle()
end

function UILvPackPanel.onLevelChangeCallBack()
    if not UILvPackPanel.isGet then
        UILvPackPanel.RefreshTaskState()
    end
end

function UILvPackPanel.ShowLvPackEffect()
    UILvPackPanel.isClick = true
    UILvPackPanel.RefreshTaskFill()
end

--endregion

--region UI

function UILvPackPanel.InitUI()
    UILvPackPanel.main:SetActive(false)
end

function UILvPackPanel.RefreshUI()
    if UILvPackPanel.lvPackTemp == nil then
        UILvPackPanel.main:SetActive(false)
        return
    end

    if not UILvPackPanel.main.activeSelf then
        UILvPackPanel.main:SetActive(true)
    end

    UILvPackPanel.targetValue = UILvPackPanel.GetInfoValue()
    if UILvPackPanel.lvPackTemp == nil then
        return
    end
    --region 刷新图片
    UILvPackPanel.IconName = UILvPackPanel.SelectItem(UILvPackPanel.lvPackTemp.model)

    UILvPackPanel.spr_staticAnimation1.gameObject:SetActive(false)
    UILvPackPanel.spr_staticAnimation2.gameObject:SetActive(false)
    UILvPackPanel.spr_staticAnimation3.gameObject:SetActive(false)
    if (UILvPackPanel.IconName == 1) then
        UILvPackPanel.spr_static.spriteName = "1"
        UILvPackPanel.spr_staticAnimation1.gameObject:SetActive(true)
        UILvPackPanel.spr_staticGo = UILvPackPanel.spr_staticAnimation1
    elseif (UILvPackPanel.IconName == 2) then
        UILvPackPanel.spr_static.spriteName = "2"
        UILvPackPanel.spr_staticAnimation2.gameObject:SetActive(true)
        UILvPackPanel.spr_staticGo = UILvPackPanel.spr_staticAnimation2
    elseif (UILvPackPanel.IconName == 3) then
        UILvPackPanel.spr_static.spriteName = "3"
        UILvPackPanel.spr_staticAnimation3.gameObject:SetActive(true)
        UILvPackPanel.spr_staticGo = UILvPackPanel.spr_staticAnimation3
    end
    --endregion

    --region 刷新奖励进度
    if UILvPackPanel.lvPackTemp.tasktype == LuaEnumLvPackTaskType.GetAward then
        UILvPackPanel.RefreshTaskState()
        UILvPackPanel.lv_TaskFill:SetActive(false)
        --UILvPackPanel.lowBG.color = UILvPackPanel.isGet and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black
    elseif UILvPackPanel.lvPackTemp.tasktype == LuaEnumLvPackTaskType.OpenLsSchoolPanel then
        UILvPackPanel.GetLsSchooTaskInfo()
        UILvPackPanel.RefreshTaskFill()
    end
    --endregion
    UILvPackPanel.RefreshTitle()
    UILvPackPanel.SetFlyTarget()
end

---刷新奖励进度
function UILvPackPanel.RefreshTaskState()
    if (UILvPackPanel.lvPackTemp == nil) then
        return
    end
    if UILvPackPanel.lvPackTemp.tasktype == LuaEnumLvPackTaskType.OpenLsSchoolPanel then
        return
    end
    if UILvPackPanel.isGet then
        UILvPackPanel.taskexpvalue.text = '可领取'
    else
        local level = CS.CSScene.MainPlayerInfo.Level
        local a, b = math.modf(UILvPackPanel.targetValue - level)
        UILvPackPanel.taskexpvalue.text = '还剩[FF0000FF]' .. a .. '[-]级'
    end
    UILvPackPanel.ShowEffect(1, UILvPackPanel.isGet)
end

---刷新标题
function UILvPackPanel.RefreshTitle()
    if UILvPackPanel.lvPackTemp == nil then
        return
    end
    if UILvPackPanel.lvPackTemp.title == nil or UILvPackPanel.lvPackTemp.title == "" then
        if UILvPackPanel.lvPackTemp.tasktype == LuaEnumLvPackTaskType.OpenLsSchoolPanel then
            if UILvPackPanel.curStcInfo ~= nil then
                UILvPackPanel.lb_state.text = UILvPackPanel.curStcInfo.title
            end
        end
    else
        UILvPackPanel.lb_state.text = UILvPackPanel.lvPackTemp.title
    end
end

---刷新灵兽试炼任务进度
function UILvPackPanel.RefreshTaskFill()
    if UILvPackPanel.curStcInfo ~= nil then
        if UILvPackPanel.curStcInfo .min ~= nil and UILvPackPanel.curStcInfo .max ~= nil then
            UILvPackPanel.Taskexp.fillAmount = UILvPackPanel.curStcInfo .min / UILvPackPanel.curStcInfo .max
            UILvPackPanel.lv_TaskFill:SetActive(true)
        end
        local isShow = CS.CSMissionManager.Instance.LsMisssionMgr:isReveiveMissionOfStc(UILvPackPanel.curStcInfo.stc)
        UILvPackPanel.ShowEffect(2, UILvPackPanel.isClick and (UILvPackPanel.curStcStatu == CS.LsMissionStatu.Get or isShow))
    end

    if UILvPackPanel.curStcStatu ~= nil then
        if UILvPackPanel.curStcStatu == CS.LsMissionStatu.NotGet then
            if CS.CSMissionManager.Instance.LsMisssionMgr then
                local max = tostring(CS.CSMissionManager.Instance.LsMisssionMgr.lsMissionMaxCount)
                local cur = tostring(CS.CSMissionManager.Instance.LsMisssionMgr.finishLsMissionCount)
                UILvPackPanel.taskexpvalue.text = cur .. '/' .. max
            end
            --[[ if UILvPackPanel.curStcInfo ~= nil then
                 if UILvPackPanel.curStcInfo .min ~= nil and UILvPackPanel.curStcInfo .max ~= nil then
                     UILvPackPanel.taskexpvalue.text = UILvPackPanel.curStcInfo.min .. '/' .. tostring(CS.CSMissionManager.Instance.LsMisssionMgr.lsMissionMaxCount) --UILvPackPanel.curStcInfo.max
                 end
             end]]--
        elseif UILvPackPanel.curStcStatu == CS.LsMissionStatu.Get then
            UILvPackPanel.taskexpvalue.text = '已开启'
        end
    end

    -- UILvPackPanel.lowBG.color = UILvPackPanel.curStcStatu == CS.LsMissionStatu.Get and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black
end

---显示物品奖励tips
function UILvPackPanel.ShowRewardTips()
    ---打开Tips 关闭按钮交互
    UILvPackPanel.isClick = false
    local temp = {}
    temp.id = UILvPackPanel.lvPackTemp.id
    temp.TargetLv = UILvPackPanel.targetValue
    temp.TweenTarget = UILvPackPanel.flyTargeTrans
    temp.tweenType = UILvPackPanel.lvPackTemp.position
    local isOpen, panelName = UILvPackPanel.IsOpenPanel()
    temp.IsOpenClick = UILvPackPanel.lvPackTemp.hsType == LuaEnumServantSpeciesType.None and UILvPackPanel.lvPackTemp.type == LuaEnumLvPackTaskType.OpenLsSchoolPanel
    temp.IsGet = UILvPackPanel.isGet
    temp.EnterCallBack = function()
        networkRequest.ReqGetLevelPacks()
        UILvPackPanel.isClick = true
        if isOpen then
            --单独处理
            if panelName == 'UILsSchoolPanel' then
                UILvPackPanel.ShowLsSchool()
            else
                uimanager:CreatePanel(panelName)
            end

        end
    end
    temp.CloseCallBack = function()
        UILvPackPanel.isClick = true
        UILvPackPanel.ShowEffect(1, UILvPackPanel.isGet)
    end
    uimanager:CreatePanel('UIRewardShowTipPanel', nil, temp)
    UILvPackPanel.ShowEffect(1, false)
end

---显示灵兽试炼界面
function UILvPackPanel.ShowLsSchool()
    UILvPackPanel.isClick = false
    uimanager:CreatePanel('UILsSchoolPanel', nil)
    UILvPackPanel.ShowEffect(2, false)
end

--endregion

--region otherFunction

---刷新数据
function UILvPackPanel.RefreshLvPackData(id)
    local isFind, Info = CS.Cfg_LvpackTableManager.Instance.dic:TryGetValue(id)
    return Info
end

---获取灵兽试炼当前章节信息
---isFind stcStatu stcInfo
function UILvPackPanel.GetLsSchooTaskInfo()

    UILvPackPanel.curStcStatu = nil
    UILvPackPanel.curStcInfo = nil
    if CS.CSMissionManager.Instance.LsMisssionMgr ~= nil then
        --当前所在章节
        local Stc = CS.CSMissionManager.Instance.LsMisssionMgr:GetCurStc()
        local isFind, info = CS.CSMissionManager.Instance.LsMisssionMgr.secStatuDic:TryGetValue(Stc)
        local stcStatru = info
        if isFind then
            --章节信息
            local stcTemp = {}
            --当前章节任务总数
            local maxValue = 0
            local title = ''
            --本章节任务已经完成的个数
            local value = CS.CSMissionManager.Instance.LsMisssionMgr:GetFulfillMissionCount(Stc)
            --获取所属章节的任务列表
            isFind, info = CS.CSMissionManager.Instance.LsMisssionMgr.missionDic:TryGetValue(Stc)
            if isFind then
                maxValue = info.Count
            end
            isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(50002)
            if isFind then
                local titleList = string.Split(info.value, '#')
                local topstitle = titleList[Stc]
                local top = string.Split(titleList[Stc], '&')
                title = top[2]
            end
            stcTemp.stc = Stc
            stcTemp.max = maxValue
            stcTemp.min = value
            stcTemp.title = title
            UILvPackPanel.curStcStatu = stcStatru
            UILvPackPanel.curStcInfo = stcTemp
        end
    end
end

---获取目标等级（是否可获得）
function UILvPackPanel.GetInfoValue()
    --根据id
    local isFind, Info = CS.Cfg_LvpackTableManager.Instance.dic:TryGetValue(UILvPackPanel.id)
    if isFind then
        return CS.Cfg_ConditionManager.Instance.dic[Info.conditions].conditionParam.list[0]
    end
end

---根据id筛选合适物品Icon名称
function UILvPackPanel.SelectItem(infoListList)
    if infoListList ~= nil then
        local length = infoListList.list.Count - 1
        for k = 0, length do
            local v = infoListList.list[k]
            local items = infoListList.list[k].list
            ---职业符合
            local MeetCareer_Bool = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career) == tonumber(items[3]) or tonumber(items[3]) == 0
            ---性别符合
            local MeetSex_Bool = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex) == tonumber(items[2]) or tonumber(items[2]) == 0
            if items ~= nil and MeetCareer_Bool and MeetSex_Bool then
                return items[0]
            end
        end
    end
end

---设置飞行目标
function UILvPackPanel.SetFlyTarget()
    local isFind, Info = CS.Cfg_LvpackTableManager.Instance.dic:TryGetValue(UILvPackPanel.id)
    if isFind then
        if Info.position == LuaEnumFlyPos.GodFurnace then
            UILvPackPanel.flyTargeTrans = uimanager:GetPanel('UINavigationPanel').mOpenBtn_GameObject.transform
        elseif Info.position == LuaEnumFlyPos.Bag then
            UILvPackPanel.flyTargeTrans = uimanager:GetPanel('UIMainChatPanel').btn_bag.transform
        elseif Info.position == LuaEnumFlyPos.None then
            UILvPackPanel.flyTargeTrans = nil
        else
            local panel = uimanager:GetPanel('UIServantHeadPanel')
            if panel == nil then
                return
            end
            local trans = panel:GetServantList_GameObject()
            if trans == nil then
                return
            end
            local targetObj = nil
            if Info.position == LuaEnumFlyPos.Ls1 then
                targetObj = trans.transform:Find("Pos/huanshou1/icon")
            elseif Info.position == LuaEnumFlyPos.Ls2 then
                targetObj = trans.transform:Find("Pos/huanshou2/icon")
            elseif Info.position == LuaEnumFlyPos.Ls3 then
                targetObj = trans.transform:Find("Pos/huanshou3/icon")
            end
            if targetObj ~= nil then
                UILvPackPanel.flyTargeTrans = targetObj.transform
            end
        end
    end
end

function UILvPackPanel.IsOpenPanel()
    local isFind, Info = CS.Cfg_LvpackTableManager.Instance.dic:TryGetValue(UILvPackPanel.id)
    if isFind then
        if Info.type == LuaEnumLevelRewardType.item then
            return false, nil
        elseif Info.type == LuaEnumLevelRewardType.OpenPanel then
            return true, Info.openInterface
        end
    end
end

---获得自动领取时间
function UILvPackPanel.GetTime()
    local isFind, Info = CS.Cfg_LvpackTableManager.Instance.dic:TryGetValue(UILvPackPanel.id)
    if isFind then
        return Info.time
    end
end

---是否可以弹出tips
function UILvPackPanel.IsPopUpTips()
    local wlParentPoint = CS.UILayerMgr.Instance:GetLayerObj(CS.UILayerType.WindowsPlane)
    if wlParentPoint ~= nil then
        if wlParentPoint.childCount > 0 then
            return false
        end
    end
    return true
end

---控制特效开关
function UILvPackPanel.ShowEffect(number, isOpen)
    if CS.StaticUtility.IsNull(UILvPackPanel.spr_staticGo) == false then
        UILvPackPanel.spr_staticGo.gameObject:SetActive(isOpen)
    end
end

function UILvPackPanel.LoadEffect(code, parent, CallBack)
    CS.CSResourceManager.Singleton:AddQueueCannotDelete(code, CS.ResourceType.UIEffect, function(res)
        if res ~= nil or res.MirrorObj ~= nil then
            --设置父物体
            if parent == nil and CS.StaticUtility.IsNull(parent) then
                return
            end
            UILvPackPanel.promptEffect_Path = res.Path
            local go = res:GetObjInst()
            if go then
                go.transform.parent = parent
                go.transform.localPosition = CS.UnityEngine.Vector3.zero
                go.transform.localScale = CS.UnityEngine.Vector3.one
                -- go.name = "promptEffect";
            end
            if CallBack then
                CallBack(res.Path, go)
            end
        end
    end, CS.ResourceAssistType.UI)
end

--endregion

--region 倒计时协程

function UILvPackPanel.IEnumTimeRefresh()
    local isTimeArrives = true
    local isPopUp = false
    local time = 0
    local targetTime = UILvPackPanel.GetTime()
    if targetTime ~= 0 then
        --时间到达
        while isTimeArrives do
            coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
            time = time + 1
            if time == targetTime then
                isTimeArrives = false
                if UILvPackPanel.IsPopUpTips() then
                    if UILvPackPanel.lvPackTemp.tasktype == LuaEnumLvPackTaskType.GetAward then
                        --UILvPackPanel.ShowRewardTips()
                    elseif UILvPackPanel.lvPackTemp.tasktype == LuaEnumLvPackTaskType.OpenLsSchoolPanel then
                        UILvPackPanel.ShowLsSchool()
                    end
                    StopCoroutine(UILvPackPanel.TimeRefreshCoroutine)
                    UILvPackPanel.TimeRefreshCoroutine = nil
                else
                    isPopUp = true
                end
            end
        end

        --有无其他界面
        while isPopUp do
            coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
            if UILvPackPanel.IsPopUpTips() then
                isPopUp = false
                coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(targetTime))
                if UILvPackPanel.lvPackTemp.tasktype == LuaEnumLvPackTaskType.GetAward then
                    --UILvPackPanel.ShowRewardTips()
                elseif UILvPackPanel.lvPackTemp.tasktype == LuaEnumLvPackTaskType.OpenLsSchoolPanel then
                    UILvPackPanel.ShowLsSchool()
                end
                StopCoroutine(UILvPackPanel.TimeRefreshCoroutine)
                UILvPackPanel.TimeRefreshCoroutine = nil
            end
        end

    end

end

--endregion

--region ondestroy

function UILvPackPanel.Ondestroy()
    UILvPackPanel:GetClientEventHandler():RemoveEvent(CS.CEvent.Role_UpdateLevel_Delay, UILvPackPanel.onLevelChangeCallBack)
    if CS.CSResourceManager.Instance ~= nil and self ~= nil then
        --if UILvPackPanel.promptEffect1_Path ~= nil or UILvPackPanel.promptEffect1_Path ~= '' then
        --    CS.CSResourceManager.Instance:ForceDestroyResource(UILvPackPanel.promptEffect1_Path)
        --end
        --if UILvPackPanel.promptEffect2_Path ~= nil or UILvPackPanel.promptEffect2_Path ~= '' then
        --    CS.CSResourceManager.Instance:ForceDestroyResource(UILvPackPanel.promptEffect2_Path)
        --end
        if UILvPackPanel.promptEffectTask1_Path ~= nil or UILvPackPanel.promptEffectTask1_Path ~= '' then
            CS.CSResourceManager.Instance:ForceDestroyResource(UILvPackPanel.promptEffectTask1_Path)
        end
        if UILvPackPanel.promptEffectTask2_Path ~= nil or UILvPackPanel.promptEffectTask2_Path ~= '' then
            CS.CSResourceManager.Instance:ForceDestroyResource(UILvPackPanel.promptEffectTask2_Path)
        end
        if UILvPackPanel.promptEffectTask3_Path ~= nil or UILvPackPanel.promptEffectTask3_Path ~= '' then
            CS.CSResourceManager.Instance:ForceDestroyResource(UILvPackPanel.promptEffectTask3_Path)
        end
    end
end

function ondestroy()
    UILvPackPanel.Ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResLevelPacksInfoMessage, UILvPackPanel.OnResLevelPacksInfoMessageCallBack)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResLinshouSectionInfoMessage, UILvPackPanel.OnUpdataLsStcCallBack)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResLingShouTaskInfoMessage, UILvPackPanel.OnUpdataLsStcCallBack)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResLingShouTaskPanelMessage, UILvPackPanel.OnUpdataLsStcCallBack)
    --luaEventManager.RemoveCallback(LuaCEvent.ShowLvPackEffect, UILvPackPanel.ShowLvPackEffect)
    if UILvPackPanel.TimeRefreshCoroutine ~= nil then
        StopCoroutine(UILvPackPanel.TimeRefreshCoroutine)
        UILvPackPanel.TimeRefreshCoroutine = nil
    end
end

--endregion

return UILvPackPanel