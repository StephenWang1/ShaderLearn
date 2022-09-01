---@class UIServantHeadPanel:UIBase
local UIServantHeadPanel = {}

--region 局部变量
UIServantHeadPanel.mIsShowServantList = false
UIServantHeadPanel.CanChangeServantState = true
UIServantHeadPanel.mCoroutineCDTime = nil
UIServantHeadPanel.ChangeStateCD = nil
UIServantHeadPanel.TemplateDic = {}
UIServantHeadPanel.id = 1000000
UIServantHeadPanel.isGet = false
UIServantHeadPanel.AllBtnOn = true
UIServantHeadPanel.SpecialOpen = false
---特效集合
UIServantHeadPanel.mEffectDic = {};
--endregion

--region 属性
function UIServantHeadPanel:GetServantList_GameObject()
    if (self.mServantList == nil) then
        self.mServantList = self:GetCurComp("WidgetRoot/ServantList", "GameObject")
    end
    return self.mServantList
end

function UIServantHeadPanel:GetServant1_GameObject()
    if (self.mServant1 == nil) then
        self.mServant1 = self:GetCurComp("WidgetRoot/ServantList/Pos/huanshou1", "GameObject")
    end
    return self.mServant1
end

function UIServantHeadPanel:GetServant1Icon_GameObject()
    if (self.mServant1Icon_GameObject == nil) then
        self.mServant1Icon_GameObject = self:GetCurComp("WidgetRoot/ServantList/Pos/huanshou1/icon", "GameObject")
    end
    return self.mServant1Icon_GameObject
end

function UIServantHeadPanel:GetServant1Icon_TweenAlpha()
    if (self.mServant1Icon_TweenAlpha == nil) then
        self.mServant1Icon_TweenAlpha = self:GetCurComp("WidgetRoot/ServantList/Pos/huanshou1/icon/light", "TweenAlpha")
    end
    return self.mServant1Icon_TweenAlpha
end

function UIServantHeadPanel:GetServant2_GameObject()
    if (self.mServant2 == nil) then
        self.mServant2 = self:GetCurComp("WidgetRoot/ServantList/Pos/huanshou2", "GameObject")
    end
    return self.mServant2
end

function UIServantHeadPanel:GetServant2Icon_GameObject()
    if (self.mServant2Icon_GameObject == nil) then
        self.mServant2Icon_GameObject = self:GetCurComp("WidgetRoot/ServantList/Pos/huanshou2/icon", "GameObject")
    end
    return self.mServant2Icon_GameObject
end

function UIServantHeadPanel:GetServant2Icon_TweenAlpha()
    if (self.mServant2Icon_TweenAlpha == nil) then
        self.mServant2Icon_TweenAlpha = self:GetCurComp("WidgetRoot/ServantList/Pos/huanshou2/icon/light", "TweenAlpha")
    end
    return self.mServant2Icon_TweenAlpha
end

function UIServantHeadPanel:GetServant3_GameObject()
    if (self.mServant3 == nil) then
        self.mServant3 = self:GetCurComp("WidgetRoot/ServantList/Pos/huanshou3", "GameObject")
    end
    return self.mServant3
end

function UIServantHeadPanel:GetServant3Icon_GameObject()
    if (self.mServant3Icon_GameObject == nil) then
        self.mServant3Icon_GameObject = self:GetCurComp("WidgetRoot/ServantList/Pos/huanshou3/icon", "GameObject")
    end
    return self.mServant3Icon_GameObject
end

function UIServantHeadPanel:GetServant3Icon_TweenAlpha()
    if (self.mServant3Icon_TweenAlpha == nil) then
        self.mServant3Icon_TweenAlpha = self:GetCurComp("WidgetRoot/ServantList/Pos/huanshou3/icon/light", "TweenAlpha")
    end
    return self.mServant3Icon_TweenAlpha
end

function UIServantHeadPanel:GetAllChuZhanBtn_GameObject()
    if (self.mAllChuZhan == nil) then
        self.mAllChuZhan = self:GetCurComp("WidgetRoot/ServantList/Pos/zhan", "GameObject")
    end
    return self.mAllChuZhan
end

function UIServantHeadPanel:GetAllHeTiBtn_GameObject()
    if (self.mAllHeTi == nil) then
        self.mAllHeTi = self:GetCurComp("WidgetRoot/ServantList/Pos/he", "GameObject")
    end
    return self.mAllHeTi
end

function UIServantHeadPanel:GetCdMask_UISprite()
    if (self.mCdMask_UISprite == nil) then
        self.mCdMask_UISprite = self:GetCurComp("WidgetRoot/ServantList/Pos/cdMask", "UISprite")
    end
    return self.mCdMask_UISprite
end

function UIServantHeadPanel.GetServantCD_GameObject()
    if UIServantHeadPanel.mServantCD == nil then
        UIServantHeadPanel.mServantCD = UIServantHeadPanel:GetCurComp("WidgetRoot/ServantList/Pos/CD", "GameObject")
    end
    return UIServantHeadPanel.mServantCD
end

function UIServantHeadPanel.GetServantListCount_Int()
    return CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count
end

---@return UIRedPoint
function UIServantHeadPanel:GetServant1RedPoint_UIRedPoint()
    if self.mServant1RedPoint == nil then
        self.mServant1RedPoint = self:GetCurComp("WidgetRoot/ServantList/Pos/huanshou1/RedPoint", "UIRedPoint")
    end
    return self.mServant1RedPoint
end

---@return UIRedPoint
function UIServantHeadPanel:GetServant2RedPoint_UIRedPoint()
    if self.mServant2RedPoint == nil then
        self.mServant2RedPoint = self:GetCurComp("WidgetRoot/ServantList/Pos/huanshou2/RedPoint", "UIRedPoint")
    end
    return self.mServant2RedPoint
end

---@return UIRedPoint
function UIServantHeadPanel:GetServant3RedPoint_UIRedPoint()
    if self.mServant3RedPoint == nil then
        self.mServant3RedPoint = self:GetCurComp("WidgetRoot/ServantList/Pos/huanshou3/RedPoint", "UIRedPoint")
    end
    return self.mServant3RedPoint
end

--endregion

--region 初始化
function UIServantHeadPanel:Init()
    UIServantHeadPanel.InitOther()
    UIServantHeadPanel:InitUI()
    UIServantHeadPanel:BindMessage()
    UIServantHeadPanel:BindUIEvents()
    --CS.CSUIRedPointManager.GetInstance():RegisterLuaCallRedPointFunction(CS.RedPointKey.SERVANT_GatherSoul1, self.CallShowServantGatherSoul1RedPoint)
    --CS.CSUIRedPointManager.GetInstance():RegisterLuaCallRedPointFunction(CS.RedPointKey.SERVANT_GatherSoul2, self.CallShowServantGatherSoul2RedPoint)
    --CS.CSUIRedPointManager.GetInstance():RegisterLuaCallRedPointFunction(CS.RedPointKey.SERVANT_GatherSoul3, self.CallShowServantGatherSoul3RedPoint)

    --networkRequest.ReqGetLevelPacksInfo()--请求等级奖励预告，用来开启灵兽位
end

function UIServantHeadPanel:InitUI()
    UIServantHeadPanel.InitlockServantList()
    UIServantHeadPanel.RefreshAllChuZhanBtn()
    self:AddRedPoint()
end

function UIServantHeadPanel:BindMessage()

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResReliveMessage, UIServantHeadPanel.PlayerReliveEvent)
    --self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRemindOpenServantSiteMessage, UIServantHeadPanel.OpenServantSite)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantHpUpdateMessage, UIServantHeadPanel.RefreshServantHP)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantExpUpdateMessage, UIServantHeadPanel.RefreshServantExp)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantInfoMessage, UIServantHeadPanel.UnlockServantList)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantCultivateRedMessage, UIServantHeadPanel.OnResServantCultivateRedMessage)
    --self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnlockEffectMessage, UIServantHeadPanel.OnResServantOpen)

    UIServantHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, UIServantHeadPanel.UnlockServantList)
    UIServantHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.DeathEvent, UIServantHeadPanel.PlayerDeathEvent)
    UIServantHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_RefushServantHp, UIServantHeadPanel.RefreshOnlyServantHP)
    UIServantHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ServantLevelUp, UIServantHeadPanel.OnResServantLevelUpMessage)
    UIServantHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ResServantInfo, UIServantHeadPanel.ResServantInfoMessage)
    UIServantHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ShowReadyToUseServantEgg, UIServantHeadPanel.onResShowEffectInServantHead)
    UIServantHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_HideReadyToUseServantEgg, UIServantHeadPanel.onResHideEffectInServantHead)
    UIServantHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UpdateBagServantReliveDrugUseableState, UIServantHeadPanel.OnServantReliveDrugStateChanged)
end

function UIServantHeadPanel:BindUIEvents()
    local UIEventListener = CS.UIEventListener
    UIEventListener.Get(UIServantHeadPanel:GetAllChuZhanBtn_GameObject()).onClick = UIServantHeadPanel.AllChuZhanOnClick
    UIEventListener.Get(UIServantHeadPanel:GetAllHeTiBtn_GameObject()).onClick = UIServantHeadPanel.AllHeTiOnClick
    UIServantHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_EquipUpdated, UIServantHeadPanel.RefreshAllChuZhanBtn)

    self.CallShowServantGatherSoul1RedPoint = function()
        local servantinfo = gameMgr:GetPlayerDataMgr():GetLuaServantInfo()
        if (1 <= CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count and
                CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[0].servantId ~= 0 and
                servantinfo:GetGatherSoulData().manaPoll ~= nil and
                servantinfo:GetGatherSoulData().manaPoll > 0 and
                (Utility.CanGetServantRechargeAward(servantinfo:GetGatherSoulData()) == 1 or
                        Utility.CanGetServantFreeAward(servantinfo:GetGatherSoulData()))
        ) then
            if (LuaGlobalTableDeal.IsOpenServantRein()) then
                return true
            else
                return false
            end
        else
            return false
        end
    end
    self.CallShowServantGatherSoul2RedPoint = function()
        local servantinfo = gameMgr:GetPlayerDataMgr():GetLuaServantInfo()
        if (2 <= CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count and
                CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[1].servantId ~= 0 and
                servantinfo:GetGatherSoulData().manaPoll ~= nil and
                servantinfo:GetGatherSoulData().manaPoll > 0 and
                (Utility.CanGetServantRechargeAward(servantinfo:GetGatherSoulData()) == 1 or
                        Utility.CanGetServantFreeAward(servantinfo:GetGatherSoulData()))) then
            if (LuaGlobalTableDeal.IsOpenServantRein()) then
                return true
            else
                return false
            end
        else
            return false
        end
    end
    self.CallShowServantGatherSoul3RedPoint = function()
        local servantinfo = gameMgr:GetPlayerDataMgr():GetLuaServantInfo()
        if (3 <= CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count and
                CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[2].servantId ~= 0 and
                servantinfo:GetGatherSoulData().manaPoll ~= nil and
                servantinfo:GetGatherSoulData().manaPoll > 0 and
                (Utility.CanGetServantRechargeAward(servantinfo:GetGatherSoulData()) == 1 or
                        Utility.CanGetServantFreeAward(servantinfo:GetGatherSoulData()))) then
            if (LuaGlobalTableDeal.IsOpenServantRein()) then
                return true
            else
                return false
            end
        else
            return false
        end
    end
end

function UIServantHeadPanel:Show()
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    CS.CSScene.MainPlayerInfo.BagInfo:CheckServantEggInbagToUse()
    if CS.CSScene.MainPlayerInfo.ServantInfoV2.IsServantCultivateRed == true then
        UIServantHeadPanel.OnResServantCultivateRedMessage()
    end
end
--endregion

--region 刷新信息

--刷新灵兽信息
function UIServantHeadPanel.ResServantInfoMessage()
    UIServantHeadPanel.RefreshServantList()
    UIServantHeadPanel.RefreshAllChuZhanBtn()
end

---灵兽复活药状态变化事件
function UIServantHeadPanel.OnServantReliveDrugStateChanged()
    UIServantHeadPanel.RefreshServantList()
end

--region 刷新灵兽模板UI
function UIServantHeadPanel.RefreshServantList()
    ---解锁灵兽栏
    for i = 1, 3 do
        local go = UIServantHeadPanel:GetServantList_GameObject().transform:Find("Pos"):GetChild(i - 1).gameObject
        if (UIServantHeadPanel.TemplateDic[go] == nil) then
            UIServantHeadPanel.TemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIServantHeadTemplate, UIServantHeadPanel)
        end
        if (i <= CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count) then
            --判定该灵兽位置是否处于锁定状态
            UIServantHeadPanel.TemplateDic[go].IsUnLock = false
        else
            UIServantHeadPanel.TemplateDic[go].IsUnLock = true
        end
        UIServantHeadPanel.ServantHeadTemplateInit(go, i)
    end
end

function UIServantHeadPanel.ServantHeadTemplateInit(go, pos)
    local servantinfo
    if (CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count >= pos) then
        servantinfo = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[pos - 1]
    end
    if (UIServantHeadPanel.TemplateDic[go].IsUnLock == true and UIServantHeadPanel.TemplateDic[go].FirstEmpty == false) then
        UIServantHeadPanel.TemplateDic[go].FirstEmpty = true
    end
    UIServantHeadPanel.TemplateDic[go].IsEmpty = true
    UIServantHeadPanel.TemplateDic[go]:BindClickEvent()
    --当前位置有灵兽
    if (servantinfo ~= nil) then
        if (servantinfo.itemId ~= 0) then
            UIServantHeadPanel.TemplateDic[go].IsEmpty = false
        end
        UIServantHeadPanel.TemplateDic[go]:InitParameters(servantinfo)
    else
        UIServantHeadPanel.TemplateDic[go].type = pos
    end
    UIServantHeadPanel.TemplateDic[go]:RefreshUI()
    --UIServantHeadPanel.TemplateDic[go]:RefreshServantExp()
end
--endregion

--region 一键出战/合体
function UIServantHeadPanel.RefreshAllChuZhanBtn()
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        local List = CS.CSScene.MainPlayerInfo.ServantInfoV2.BattleServantList
        if (List == nil) then
            return
        end
        local MiBaores, MiBaotab = CS.CSScene.MainPlayerInfo.EquipInfo.Equips:TryGetValue(Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA))
        if (not MiBaores) then
            return
        end
        local LiveCount = List.Count
        if (LiveCount == 1) then
            if (List[0].reviveState == 1) then
                UIServantHeadPanel:GetAllHeTiBtn_GameObject():SetActive(true)
                UIServantHeadPanel:GetAllChuZhanBtn_GameObject():SetActive(false)
            else
                UIServantHeadPanel:GetAllHeTiBtn_GameObject():SetActive(false)
                UIServantHeadPanel:GetAllChuZhanBtn_GameObject():SetActive(true)
            end
            return
        elseif (LiveCount == 2) then
            if (List[0].reviveState == List[1].reviveState) then
                if (List[0].reviveState == 1) then
                    UIServantHeadPanel:GetAllHeTiBtn_GameObject():SetActive(true)
                    UIServantHeadPanel:GetAllChuZhanBtn_GameObject():SetActive(false)
                elseif (List[0].reviveState == 2) then
                    UIServantHeadPanel:GetAllHeTiBtn_GameObject():SetActive(false)
                    UIServantHeadPanel:GetAllChuZhanBtn_GameObject():SetActive(true)
                end
            else
                UIServantHeadPanel:GetAllHeTiBtn_GameObject():SetActive(false)
                UIServantHeadPanel:GetAllChuZhanBtn_GameObject():SetActive(true)
            end
        elseif (LiveCount == 3) then
            if (List[0].reviveState == List[1].reviveState and List[1].reviveState == List[2].reviveState) then
                if (List[0].reviveState == 1) then
                    UIServantHeadPanel:GetAllHeTiBtn_GameObject():SetActive(true)
                    UIServantHeadPanel:GetAllChuZhanBtn_GameObject():SetActive(false)
                elseif (List[0].reviveState == 2) then
                    UIServantHeadPanel:GetAllHeTiBtn_GameObject():SetActive(false)
                    UIServantHeadPanel:GetAllChuZhanBtn_GameObject():SetActive(true)
                end
            else
                UIServantHeadPanel:GetAllHeTiBtn_GameObject():SetActive(false)
                UIServantHeadPanel:GetAllChuZhanBtn_GameObject():SetActive(true)
            end
        end
    end
end

function UIServantHeadPanel.IEnumChangeStateCD()
    UIServantHeadPanel.CanChangeServantState = false
    local count = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count
    if count < 3 then
        count = count + 1
    end
    local size = 70
    coroutine.yield((CS.NGUIAssist.GetWaitForSeconds(5)))
    UIServantHeadPanel.CanChangeServantState = true
end

function UIServantHeadPanel.RefreshButtonPos()
    if (UIServantHeadPanel.GetServantListCount_Int() >= 2) then
        UIServantHeadPanel.RefreshAllChuZhanBtn()
    end
    if UIServantHeadPanel.showServantHeadPanel == false then
        luaclass.UIRefresh:RefreshActive(UIServantHeadPanel:GetServantList_GameObject(),false)
    end
    if (UIServantHeadPanel.SpecialOpen) then
        local pos = CS.UnityEngine.Vector3(32, -13, 0)
        UIServantHeadPanel:GetServant1_GameObject():SetActive(true)
        UIServantHeadPanel:GetServant2_GameObject():SetActive(false)
        UIServantHeadPanel:GetServant3_GameObject():SetActive(false)
        UIServantHeadPanel:GetAllChuZhanBtn_GameObject().transform.localPosition = pos
        UIServantHeadPanel:GetAllHeTiBtn_GameObject().transform.localPosition = pos
        UIServantHeadPanel:GetCdMask_UISprite().transform.localPosition = pos
    else
        if (uiStaticParameter.ServantMaxCount == 0) then
            local pos = CS.UnityEngine.Vector3(-43, -13, 0)
            UIServantHeadPanel:GetAllChuZhanBtn_GameObject().transform.localPosition = pos
            UIServantHeadPanel:GetAllHeTiBtn_GameObject().transform.localPosition = pos
            UIServantHeadPanel:GetCdMask_UISprite().transform.localPosition = pos
        elseif (uiStaticParameter.ServantMaxCount == 1) then
            local pos = CS.UnityEngine.Vector3(32, -13, 0)
            UIServantHeadPanel:GetServant1_GameObject():SetActive(true)
            UIServantHeadPanel:GetServant2_GameObject():SetActive(true)
            UIServantHeadPanel:GetAllChuZhanBtn_GameObject().transform.localPosition = pos
            UIServantHeadPanel:GetAllHeTiBtn_GameObject().transform.localPosition = pos
            UIServantHeadPanel:GetCdMask_UISprite().transform.localPosition = pos
        elseif (uiStaticParameter.ServantMaxCount == 2) then
            local pos = CS.UnityEngine.Vector3(90, -13, 0)
            UIServantHeadPanel:GetServant1_GameObject():SetActive(true)
            UIServantHeadPanel:GetServant2_GameObject():SetActive(true)
            UIServantHeadPanel:GetServant3_GameObject():SetActive(true)
            UIServantHeadPanel:GetAllChuZhanBtn_GameObject().transform.localPosition = pos
            UIServantHeadPanel:GetAllHeTiBtn_GameObject().transform.localPosition = pos
            UIServantHeadPanel:GetCdMask_UISprite().transform.localPosition = pos
        elseif (uiStaticParameter.ServantMaxCount == 3) then
            local pos = CS.UnityEngine.Vector3(90, -13, 0)
            UIServantHeadPanel:GetServant1_GameObject():SetActive(true)
            UIServantHeadPanel:GetServant2_GameObject():SetActive(true)
            UIServantHeadPanel:GetServant3_GameObject():SetActive(true)
            UIServantHeadPanel:GetAllChuZhanBtn_GameObject().transform.localPosition = pos
            UIServantHeadPanel:GetAllHeTiBtn_GameObject().transform.localPosition = pos
            UIServantHeadPanel:GetCdMask_UISprite().transform.localPosition = pos
        end
    end
end
--endregion

function UIServantHeadPanel.InitlockServantList()
    local info = CS.CSScene.MainPlayerInfo
    if (info == nil) then
        return
    end

    uiStaticParameter.ServantMaxCount = info.ServantInfoV2.ServantInfoList.Count
    if (uiStaticParameter.ServantMaxCount == 0) then
        local isfind, condition = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22915)
        if (isfind) then
            UIServantHeadPanel.SpecialOpen = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(tonumber(condition.value))
        end
    else
        UIServantHeadPanel.SpecialOpen = false
    end

    UIServantHeadPanel.RefreshButtonPos()

    UIServantHeadPanel.RefreshServantList()
end

function UIServantHeadPanel.InitOther()
    UIServantHeadPanel.showServantHeadPanel = LuaGlobalTableDeal.CanShowServantHeadPanel()
end

--region 根据等级解锁幻兽栏
function UIServantHeadPanel.UnlockServantList(id, data)
    UIServantHeadPanel.InitlockServantList()
    --CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:RefreshHint(CS.CSBagItemHint.BagHintReason.None);
end
--endregion

--region 气泡
---显示灵兽经验池气泡
function UIServantHeadPanel.OnResServantCultivateRedMessage()
    if CS.StaticUtility.IsNull(UIServantHeadPanel:GetServant1_GameObject()) == false and UIServantHeadPanel.tipsTemplate == nil then
        UIServantHeadPanel.tipsTemplate = Utility.TryCreateHintTips({ point = UIServantHeadPanel:GetServant1_GameObject(), id = 3, clickCallBack = function()
            Utility.OpenPracticePanel()
            UIServantHeadPanel.RemovePop()
        end, timeEndCallBack = function()
            UIServantHeadPanel.tipsTemplate = nil
        end })
    end
end

function UIServantHeadPanel.OnResServantOpen(id, tblData)
    if tblData == nil or tblData.sec == nil then
        return
    end

    local trans = UIServantHeadPanel:GetServantList_GameObject()
    if trans == nil then
        return
    end
    local targetObj = nil
    if tblData.sec == 2 then
        targetObj = trans.transform:Find("Pos/huanshou2/icon")
    elseif tblData.sec == 3 then
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
---移除气泡
function UIServantHeadPanel.RemovePop()
    if UIServantHeadPanel.tipsTemplate ~= nil then
        UIServantHeadPanel.tipsTemplate:addClickNum()
        UIServantHeadPanel.tipsTemplate:RemoveTimeEndToHide()
        Utility.RemoveHintTips(UIServantHeadPanel.tipsTemplate)
        UIServantHeadPanel.tipsTemplate = nil
    end
end
--endregion

--region Tips
function UIServantHeadPanel.ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIServantHeadPanel"
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion
--endregion

function update()
    if UIServantHeadPanel.mNeedPlayEffect then
        UIServantHeadPanel.mNeedPlayEffect = UIServantHeadPanel.mNeedPlayEffect - 1
        if UIServantHeadPanel.mNeedPlayEffect == 0 then
            UIServantHeadPanel.mNeedPlayEffect = nil
            for i, v in pairs(UIServantHeadPanel.TemplateDic) do
                if v.headIcon_UISprite ~= nil and CS.StaticUtility.IsNull(v.headIcon_UISprite.gameObject) == false and v.IsUnLock == false then
                    ---在头像上创建特效
                    local effectLoad = CS.UILocalScreenEffectLoader.Instance:CreateNewEffect()
                    effectLoad:AddTimeLineData("700235", CS.UILayerType.BasicPlane, nil,
                            { transform = v.headIcon_UISprite.transform, timePoint = 0.4 },
                            { transform = v.headIcon_UISprite.transform, timePoint = 5 })

                    effectLoad:Play()
                end
            end
        end
    end
end

--region UI点击事件
function UIServantHeadPanel.AllChuZhanOnClick(go)
    --if (CS.CSScene.MainPlayerInfo.ServantInfoV2.LiveServantList.Count == 0) then
    --    UIServantHeadPanel.ShowTips(go, 108)
    --    return
    --end
    --灵兽不能出战tips
    --if (CS.Cfg_GlobalTableManager.Instance:IsServantCantFight()) then
    --    UIServantHeadPanel.ShowTips(go, 97)
    --    return
    --end
    local isFind, mapTable = CS.Cfg_MapTableManager.Instance:TryGetValue(CS.CSScene.MainPlayerInfo.MapID);
    if (isFind and mapTable.innerCondition ~= nil and mapTable.innerCondition.list.Count > 0) then
        local lv = mapTable.innerCondition.list[0]
        local rein = mapTable.innerCondition.list[1]
        for k, v in pairs(UIServantHeadPanel.TemplateDic) do
            if (v.info ~= nil and v.info.itemId ~= 0) then
                if (v.info.level < lv) then
                    UIServantHeadPanel.ShowTips(go, 102, "灵兽等级不足" .. lv)
                    return
                end
                if (v.info.rein < rein) then
                    UIServantHeadPanel.ShowTips(go, 102, "灵兽转生不足" .. rein)
                    return
                end
            end
        end
    end
    if (UIServantHeadPanel.CanChangeServantState) then
        for i = 1, CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count do
            local info = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[i - 1]
            if (info.servantId ~= 0 and info.state ~= LuaEnumServantStateType.Battle) then
                networkRequest.ReqServantChangeState(LuaEnumServantStateType.Battle, i)
            end
        end
        UIServantHeadPanel.LimitCD()
        if (UIServantHeadPanel.AllBtnOn) then
            UIServantHeadPanel:TryStartCDTime(5000)
        end
    else
        --UIServantHeadPanel.ShowTips(go, 11)
    end
    CS.CSScene.MainPlayerInfo.ServantInfoV2.CombineWay = CS.AllCombineWay.Manual
end

function UIServantHeadPanel.AllHeTiOnClick(go)
    --if (CS.CSScene.MainPlayerInfo.ServantInfoV2.LiveServantList.Count == 0) then
    --    UIServantHeadPanel.ShowTips(go, 109)
    --    return
    --end

    local MiBaores, MiBaotab = CS.CSScene.MainPlayerInfo.EquipInfo.Equips:TryGetValue(Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA))
    if (not MiBaores) then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Parent] = UIServantHeadPanel:GetAllHeTiBtn_GameObject().transform
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 12
        TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIServantHeadPanel"
        uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
        return
    end

    if (UIServantHeadPanel.CanChangeServantState) then
        for i = 1, CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count do
            local info = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[i - 1]
            if (info.servantId ~= 0 and info.state ~= LuaEnumServantStateType.Combine) then
                networkRequest.ReqServantChangeState(LuaEnumServantStateType.Combine, i)
            end
        end
        UIServantHeadPanel.LimitCD()
        if (UIServantHeadPanel.AllBtnOn) then
            UIServantHeadPanel:TryStartCDTime(5000)
        end
    else
        --UIServantHeadPanel.ShowTips(go, 11)
    end
    CS.CSScene.MainPlayerInfo.ServantInfoV2.CombineWay = CS.AllCombineWay.Manual
end

function UIServantHeadPanel.LimitCD()
    local MiBaores, MiBaotab = CS.CSScene.MainPlayerInfo.EquipInfo.Equips:TryGetValue(Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA))
    if MiBaores then
        UIServantHeadPanel.ChangeStateCD = StartCoroutine(UIServantHeadPanel.IEnumChangeStateCD)
    end
end

function UIServantHeadPanel.PlayEffect(effectId, parent, scale)
    if (scale == nil) then
        scale = 100;
    end
    if (parent == nil) then
        parent = UIServantHeadPanel.go.transform;
    end
    if (UIServantHeadPanel.mEffectDic == nil) then
        UIServantHeadPanel.mEffectDic = {};
    end
    if (UIServantHeadPanel.mEffectDic[effectId] == nil) then
        CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectId, CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj then
                res.IsCanBeDelete = false
                UIServantHeadPanel.mEffectDic[effectId] = res:GetObjInst();
                if UIServantHeadPanel.mEffectDic[effectId] ~= nil then
                    UIServantHeadPanel.mEffectDic[effectId].transform.parent = parent;
                    UIServantHeadPanel.mEffectDic[effectId].transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0);
                    UIServantHeadPanel.mEffectDic[effectId].transform.localScale = CS.UnityEngine.Vector3(scale, scale, scale);
                end
            end
        end, CS.ResourceAssistType.UI);
    else
        UIServantHeadPanel.mEffectDic[effectId]:SetActive(false);
        UIServantHeadPanel.mEffectDic[effectId]:SetActive(true);
    end
end
--endregion

--region 客户端事件
function UIServantHeadPanel.OpenServantPanelByServantID(id)
    for k, v in pairs(UIServantHeadPanel.TemplateDic) do
        if (v.info ~= nil and v.info.servantId == id) then
            v:HeadonClick()
        end
    end
end
--region 背包内有可使用灵兽蛋
function UIServantHeadPanel.onResShowEffectInServantHead(id, index)
    local go = nil
    if (index == LuaEnumServantSpeciesType.First) then
        go = UIServantHeadPanel:GetServant1_GameObject()
    elseif (index == LuaEnumServantSpeciesType.Second) then
        go = UIServantHeadPanel:GetServant2_GameObject()
    elseif (index == LuaEnumServantSpeciesType.Third) then
        go = UIServantHeadPanel:GetServant3_GameObject()
    end
    if (go ~= nil) then
        UIServantHeadPanel.TemplateDic[go]:GetBtnUseLight_GameObject():SetActive(true)
    end
    UIServantHeadPanel.ResetAllHeadTweenAnimation()
end
--endregion

function UIServantHeadPanel.onResHideEffectInServantHead(id, index)
    local go = nil
    if (index == LuaEnumServantSpeciesType.First) then
        go = UIServantHeadPanel:GetServant1_GameObject()
    elseif (index == LuaEnumServantSpeciesType.Second) then
        go = UIServantHeadPanel:GetServant2_GameObject()
    elseif (index == LuaEnumServantSpeciesType.Third) then
        go = UIServantHeadPanel:GetServant3_GameObject()
    end
    if (go ~= nil) then
        UIServantHeadPanel.TemplateDic[go]:GetBtnUseLight_GameObject():SetActive(false)
    end
end

function UIServantHeadPanel:TryStartCDTime(cdTime)
    UIServantHeadPanel.AllBtnOn = false
    if (UIServantHeadPanel.mCoroutineCDTime ~= nil) then
        StopCoroutine(UIServantHeadPanel.mCoroutineCDTime);
        UIServantHeadPanel.mCoroutineCDTime = nil;
    end
    UIServantHeadPanel.mCoroutineCDTime = StartCoroutine(UIServantHeadPanel.IEnumCDTime, cdTime);
end

function UIServantHeadPanel.IEnumCDTime(targetTime)
    UIServantHeadPanel:GetCdMask_UISprite().gameObject:SetActive(true);
    UIServantHeadPanel:GetCdMask_UISprite().fillAmount = 1;
    local tableCDTime = 5000
    local cur_timestamp = 0;
    if (tableCDTime > 0) then
        while cur_timestamp < tableCDTime do
            UIServantHeadPanel:GetCdMask_UISprite().fillAmount = (targetTime - cur_timestamp) / tableCDTime
            coroutine.yield(CS.NGUIAssist.waitForEndOfFrame);
            cur_timestamp = cur_timestamp + CS.UnityEngine.Time.deltaTime * 1000;
        end
    end
    UIServantHeadPanel:GetCdMask_UISprite().fillAmount = 0;
    UIServantHeadPanel:GetCdMask_UISprite().gameObject:SetActive(false);
    UIServantHeadPanel.AllBtnOn = true
    UIServantHeadPanel.mCoroutineCDTime = nil;
end
--endregion

--region 主角死亡事件
function UIServantHeadPanel.PlayerDeathEvent()
    if (CS.CSScene.MainPlayerInfo:IsInShaBakHuangGong() and CS.CSScene.MainPlayerInfo.DuplicateV2.ShaBakInfo ~= nil and CS.CSScene.MainPlayerInfo.UnionInfoV2 ~= nil and
            CS.CSScene.MainPlayerInfo.DuplicateV2.ShaBakInfo.unionId == CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID) then
        for i, v in pairs(UIServantHeadPanel.TemplateDic) do
            if (v.info ~= nil and v.info.itemId ~= 0 and v.info.state == 0) then
                v:GetReliveCD():StopCountDown()
            end
        end
    end
end
--endregion

--region 主角复活事件
function UIServantHeadPanel.PlayerReliveEvent()
    if (CS.CSScene.MainPlayerInfo:IsInShaBakHuangGong() and CS.CSScene.MainPlayerInfo.DuplicateV2.ShaBakInfo ~= nil and CS.CSScene.MainPlayerInfo.UnionInfoV2 ~= nil and
            CS.CSScene.MainPlayerInfo.DuplicateV2.ShaBakInfo.unionId == CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID) then
        for i, v in pairs(UIServantHeadPanel.TemplateDic) do
            if (v.info ~= nil and v.info.itemId ~= 0 and v.info.state == 0) then
                v:GetReliveCD():StartCountDown("[f00000]{0}", (v.info.callAgainTime - CS.CSServerTime.Instance.TotalMillisecond) / 1000 + 1)
            end
        end
    end
end
--endregion

--region 客户端事件刷新灵兽血量
function UIServantHeadPanel.RefreshOnlyServantHP(type, hp)
    for k, v in pairs(UIServantHeadPanel.TemplateDic) do
        if (v.info ~= nil and v.info.itemId ~= 0 and v.info.type == type) then
            v:RefreshOnlyServantHP(type, hp)
        end
    end
end
--endregion

--region 服务器消息
function UIServantHeadPanel.RefreshServantHP(id, data)
    for k, v in pairs(UIServantHeadPanel.TemplateDic) do
        if (v.info ~= nil and v.info.itemId ~= 0 and v.info.type == data.type) then
            v:RefreshServantHP(id, data)
        end
    end
end

function UIServantHeadPanel.OpenServantSite()
    local uiMainMenusPanel = uimanager:GetPanel("UIMainMenusPanel")
    if (uiMainMenusPanel ~= nil) then
        uiMainMenusPanel:AddMainMenuModule("UIServantMainTipsPanel", uiMainMenusPanel:GetTopLeftDynamicNode())
    end
end

function UIServantHeadPanel.RefreshServantExp(id, data)
    --for k, v in pairs(UIServantHeadPanel.TemplateDic) do
    --    v:RefreshServantExp(id, data)
    --end
    ---若遇到宝箱(灵兽经验丹)和回收导致的灵兽经验池变化,则需要播放blingbling的特效
    if data ~= nil and data.actId ~= nil and (data.actId == 4001 or data.actId == 12001) and (data.pool ~= nil and data.pool > 0) then
        --延迟10帧
        UIServantHeadPanel.mNeedPlayEffect = 10
    end
end

function UIServantHeadPanel.OnResServantLevelUpMessage(msgId, data)
    local parent = nil;
    if (data == LuaEnumServantSpeciesType.First) then
        parent = UIServantHeadPanel:GetServant1Icon_GameObject().transform;
    elseif (data == LuaEnumServantSpeciesType.Second) then
        parent = UIServantHeadPanel:GetServant2Icon_GameObject().transform;
    elseif (data == LuaEnumServantSpeciesType.Third) then
        parent = UIServantHeadPanel:GetServant3Icon_GameObject().transform;
    end
    UIServantHeadPanel.PlayEffect("700062", parent);
end

function UIServantHeadPanel.OnResLevelPacksInfoMessageCallBack(id, data)
    if data then
        if UIServantHeadPanel.id == data.LevelPacks then
            return
        end
        UIServantHeadPanel.id = data.LevelPacks
        if (UIServantHeadPanel.id == 1) then
            UIServantHeadPanel:GetServant1_GameObject():SetActive(true)
        end
    end
end

function UIServantHeadPanel.ResetAllHeadTweenAnimation()
    UIServantHeadPanel:GetServant1Icon_TweenAlpha():PlayForward()
    UIServantHeadPanel:GetServant2Icon_TweenAlpha():PlayForward()
    UIServantHeadPanel:GetServant3Icon_TweenAlpha():PlayForward()
    UIServantHeadPanel:GetServant1Icon_TweenAlpha():ResetToBeginning()
    UIServantHeadPanel:GetServant2Icon_TweenAlpha():ResetToBeginning()
    UIServantHeadPanel:GetServant3Icon_TweenAlpha():ResetToBeginning()
end
--endregion

--region 红点
---添加红点
function UIServantHeadPanel:AddRedPoint()
    --if not CS.StaticUtility.IsNull(self:GetServant1RedPoint_UIRedPoint()) then
    --    self:GetServant1RedPoint_UIRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ServantPractice_HM))
    --end
    --if not CS.StaticUtility.IsNull(self:GetServant2RedPoint_UIRedPoint()) then
    --    self:GetServant2RedPoint_UIRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ServantPractice_LX))
    --end
    --if not CS.StaticUtility.IsNull(self:GetServant3RedPoint_UIRedPoint()) then
    --    self:GetServant3RedPoint_UIRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ServantPractice_TC))
    --end
    --self:GetServant1RedPoint_UIRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LianZhi_LingShou))
    --self:GetServant2RedPoint_UIRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LianZhi_LingShou))
    --self:GetServant3RedPoint_UIRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LianZhi_LingShou))
end
--endregion

function ondestroy()
    if UIServantHeadPanel.ChangeStateCD ~= nil then
        StopCoroutine(UIServantHeadPanel.ChangeStateCD)
        UIServantHeadPanel.ChangeStateCD = nil
    end
    if UIServantHeadPanel.mCoroutineCDTime ~= nil then
        StopCoroutine(UIServantHeadPanel.mCoroutineCDTime);
        UIServantHeadPanel.mCoroutineCDTime = nil
    end
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResRemindOpenServantSiteMessage, UIServantHeadPanel.OpenServantSite)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantInfoMessage, UIServantHeadPanel.UnlockServantList)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantHpUpdateMessage, UIServantHeadPanel.RefreshServantHP)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantExpUpdateMessage, UIServantHeadPanel.RefreshServantExp)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantCultivateRedMessage, UIServantHeadPanel.OnResServantCultivateRedMessage)
end

return UIServantHeadPanel