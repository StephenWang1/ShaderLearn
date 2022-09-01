local UIRefineServantPanel = {}

--region 变量
---@type table
UIRefineServantPanel.mHeadTemplateList = {}
UIRefineServantPanel.cfgId = 0
UIRefineServantPanel.mSelectServantType = nil
UIRefineServantPanel.mCanRefine = false
UIRefineServantPanel.ShowGainResultCor = nil
---修为id
UIRefineServantPanel.mItemId = 1000020
--endregion

--region 组件
function UIRefineServantPanel:GetHeadRoot_GameObject()
    if (self.mHeadRoot == nil) then
        self.mHeadRoot = self:GetCurComp("WidgetRoot/head", "GameObject")
    end
    return self.mHeadRoot
end

function UIRefineServantPanel:GetCloseBtn_GameObject()
    if (self.mCloseBtn == nil) then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

function UIRefineServantPanel:GetHelpBtn_GameObject()
    if (self.mHelpBtn == nil) then
        self.mHelpBtn = self:GetCurComp("WidgetRoot/btn_help", "GameObject")
    end
    return self.mHelpBtn
end

function UIRefineServantPanel:GetEnterBtn_GameObject()
    if (self.mEnterBtn == nil) then
        self.mEnterBtn = self:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    end
    return self.mEnterBtn
end

function UIRefineServantPanel:GetCurLevel_UILabel()
    if (self.mCurLevelLabel == nil) then
        self.mCurLevelLabel = self:GetCurComp("WidgetRoot/lvChange/before/num", "Top_UILabel")
    end
    return self.mCurLevelLabel
end

function UIRefineServantPanel:GetAfterLevel_UILabel()
    if (self.mAfterLevelLabel == nil) then
        self.mAfterLevelLabel = self:GetCurComp("WidgetRoot/lvChange/after/num", "Top_UILabel")
    end
    return self.mAfterLevelLabel
end

function UIRefineServantPanel:GetRefineCount_UILabel()
    if (self.mRefineCount == nil) then
        self.mRefineCount = self:GetCurComp("WidgetRoot/remainTime", "Top_UILabel")
    end
    return self.mRefineCount
end

function UIRefineServantPanel:GetCostNum_UILabel()
    if (self.mCostNum == nil) then
        self.mCostNum = self:GetCurComp("WidgetRoot/cost/num/num", "Top_UILabel")
    end
    return self.mCostNum
end

function UIRefineServantPanel:GetGainNum_UILabel()
    if (self.mGainNum == nil) then
        self.mGainNum = self:GetCurComp("WidgetRoot/gain/num/num", "Top_UILabel")
    end
    return self.mGainNum
end

function UIRefineServantPanel:GetGainResultNum_GameObject()
    if (self.mGainNumResultGo == nil) then
        self.mGainNumResultGo = self:GetCurComp("WidgetRoot/gainresult", "GameObject")
    end
    return self.mGainNumResultGo
end

function UIRefineServantPanel:GetGainResultNum_UILabel()
    if (self.mGainNumResult == nil) then
        self.mGainNumResult = self:GetCurComp("WidgetRoot/gainresult/num/num", "UILabel")
    end
    return self.mGainNumResult
end

function UIRefineServantPanel:GetSuccedEffect_GameObject()
    if (self.mSuccedEffectGameObject == nil) then
        self.mSuccedEffectGameObject = self:GetCurComp("WidgetRoot/succedEffect", "GameObject")
    end
    return self.mSuccedEffectGameObject
end
--endregion

---修为Grid
function UIRefineServantPanel.GetGrid()
    if (UIRefineServantPanel.mGrid == nil) then
        UIRefineServantPanel.mGrid = UIRefineServantPanel:GetCurComp("WidgetRoot/gain/Grid", "Top_UIGridContainer")
    end
    return UIRefineServantPanel.mGrid
end

--region 初始化
function UIRefineServantPanel:Init()
    --self:InitTemplate()
    self:BindUIEvent()
    self:BindMessage()
end

function UIRefineServantPanel:Show()
    UIRefineServantPanel.nowMaxCount = gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr():GetLianZhiCount(2)
    networkRequest.ReqRefineMasterPanel(2)
    --self:ChooseDefalutServant()
end

function UIRefineServantPanel:InitTemplate()
    local count = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count
    for i = 0, count - 1 do
        if (UIRefineServantPanel:GetHeadRoot_GameObject().transform:GetChild(i).gameObject ~= nil) then
            if (UIRefineServantPanel.mHeadTemplateList[i] == nil) then
                local go = UIRefineServantPanel:GetHeadRoot_GameObject().transform:GetChild(i).gameObject
                UIRefineServantPanel.mHeadTemplateList[i] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIServantHeadInfoInRefineMasterTemplate, self, i)
            else
                if (CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList ~= nil and CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count > i) then
                    UIRefineServantPanel.mHeadTemplateList[i].info = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[i]
                end
            end
            --判定该灵兽位置是否处于锁定状态
            UIRefineServantPanel.mHeadTemplateList[i].info = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[i]
            UIRefineServantPanel.mHeadTemplateList[i]:InitParameters()
            if (UIRefineServantPanel.mHeadTemplateList[i].info.level < CS.Cfg_GlobalTableManager.Instance.ServantRefineMasterLevel) then
                UIRefineServantPanel.mHeadTemplateList[i].IsUnLock = true
            else
                UIRefineServantPanel.mHeadTemplateList[i].IsUnLock = false
            end
            UIRefineServantPanel.mHeadTemplateList[i]:RefreshIcon()
        end
    end
end

function UIRefineServantPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRefineMasterPanelMessage, UIRefineServantPanel.OnResRefineMasterPanel)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRefineMasterResultMessage, UIRefineServantPanel.OnResRefineMasterResult)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantExpUpdateMessage, UIRefineServantPanel.ResServantExpUpdate)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantInfoMessage, UIRefineServantPanel.ResServantExpUpdate)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        if UIRefineServantPanel.datacfgId ~= nil then
            UIRefineServantPanel.RefreshGrid(UIRefineServantPanel.datacfgId)
        end
    end)
end

function UIRefineServantPanel:BindUIEvent()
    CS.UIEventListener.Get(UIRefineServantPanel:GetCloseBtn_GameObject()).onClick = UIRefineServantPanel.CloseBtnOnClick
    CS.UIEventListener.Get(UIRefineServantPanel:GetHelpBtn_GameObject()).onClick = UIRefineServantPanel.HelpBtnOnClick
    CS.UIEventListener.Get(UIRefineServantPanel:GetEnterBtn_GameObject()).onClick = UIRefineServantPanel.EnterBtnOnClick
end
--endregion

--region 刷新界面
---@return string 文本前缀
function UIRefineServantPanel:GetPreStr()
    if self.mPreStr == nil then
        self.mPreStr = "[f7f2e6]获得了"
    end
    return self.mPreStr
end

---@return TABLE.CFG_ITEMS 修为信息
function UIRefineServantPanel:GetItemInfo()
    if self.mItemInfo == nil then
        ___, self.mItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mItemId)
    end
    return self.mItemInfo
end

function UIRefineServantPanel:ChooseDefalutServant()
    if (UIRefineServantPanel.mHeadTemplateList ~= nil) then
        local count = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count
        for i = 0, count - 1 do
            if (UIRefineServantPanel.mHeadTemplateList[i].IsUnLock == false) then
                UIRefineServantPanel.mHeadTemplateList[i]:IconOnClick()
                break
            end
        end
    end
end

function UIRefineServantPanel:RefreshPanel()
    --self:RefreshServantHead()
    if (UIRefineServantPanel.RefineInfo ~= nil) then
        UIRefineServantPanel:GetGainResultNum_UILabel().text = CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool
        local RefineTable = CS.Cfg_RefineMasterTableManager.Instance
        local allExp = CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool
        if (UIRefineServantPanel.RefineInfo.costNum > allExp) then
            UIRefineServantPanel:GetCostNum_UILabel().text = allExp
            UIRefineServantPanel:GetGainNum_UILabel().text = math.floor(allExp / CS.Cfg_GlobalTableManager.Instance.ServantRefineMasterExp * RefineTable:GetRandomReinMasterExpratio(UIRefineServantPanel.cfgId))
        else
            UIRefineServantPanel:GetCostNum_UILabel().text = UIRefineServantPanel.RefineInfo.costNum
            UIRefineServantPanel:GetGainNum_UILabel().text = math.floor(UIRefineServantPanel.RefineInfo.gainNum * RefineTable:GetRandomReinMasterExpratio(UIRefineServantPanel.cfgId))
        end
    end
end

function UIRefineServantPanel:RefreshServantHead()
    local count = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count
    for i = count + 1, 3 do
        local go = UIRefineServantPanel:GetHeadRoot_GameObject().transform:GetChild(i - 1).gameObject
        go:SetActive(false)
    end
    if (count == 3) then
        UIRefineServantPanel.mHeadTemplateList[0].go.transform.localPosition = CS.UnityEngine.Vector3(-100, 0, 0)
        UIRefineServantPanel.mHeadTemplateList[1].go.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
        UIRefineServantPanel.mHeadTemplateList[2].go.transform.localPosition = CS.UnityEngine.Vector3(100, 0, 0)
    elseif (count == 2) then
        UIRefineServantPanel.mHeadTemplateList[0].go.transform.localPosition = CS.UnityEngine.Vector3(-50, 0, 0)
        UIRefineServantPanel.mHeadTemplateList[1].go.transform.localPosition = CS.UnityEngine.Vector3(50, 0, 0)
    elseif (count == 1) then
        UIRefineServantPanel.mHeadTemplateList[0].go.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
    end
end

function UIRefineServantPanel:HideHeadChooseIcon()
    local count = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count
    for i = 0, count - 1 do
        UIRefineServantPanel.mHeadTemplateList[i].ChooseIcon:SetActive(false)
    end
end

function UIRefineServantPanel:ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIRefineServantPanel"
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

function UIRefineServantPanel:ShowEffect()
    self:GetGainResultNum_GameObject():SetActive(true)
    self:GetSuccedEffect_GameObject():SetActive(false)
    self:GetSuccedEffect_GameObject():SetActive(true)

    --if self.ShowGainResultCor then
    --    StopCoroutine(self.ShowGainResultCor)
    --end
    --self.ShowGainResultCor = StartCoroutine(UIRefineServantPanel.StartHideEffect)
end

function UIRefineServantPanel.StartHideEffect()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(2))
    if not CS.StaticUtility.IsNull(UIRefineServantPanel:GetSuccedEffect_GameObject()) then
        UIRefineServantPanel:GetSuccedEffect_GameObject():SetActive(false)
    end
    if not CS.StaticUtility.IsNull(UIRefineServantPanel:GetGainResultNum_GameObject()) then
        UIRefineServantPanel:GetGainResultNum_GameObject():SetActive(false)
    end
end

---检测请求炼制时是否经验过低
function UIRefineServantPanel:ShowExpLowTips(go)
    if UIRefineServantPanel.nowSelect ~= nil then
        if UIRefineServantPanel.IsMeetLianZhiExp() == false then
            Utility.ShowPopoTips(go.transform, nil, 468)
            return
        end
        if self:IsMeetShowTip(go) == false then
            ---104443 【优化】【聚灵】【client】聚灵炼制时，当前炼制经验过少时弹出的tips去除不再提示（点击炼制直接炼制即可）
            networkRequest.ReqRefineMaster(2, 0, UIRefineServantPanel.nowSelect.nowIndex + 1)
        end

        --local diamondNumber = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(LuaEnumCoinType.Diamond)
        --if UIRefineServantPanel.nowSelect.dataInfo.itemCost > diamondNumber then
        --    if go ~= nil then
        --        Utility.ShowPopoTips(go.transform, "钻石不足", 238)
        --    end
        --else
        --    ---104443 【优化】【聚灵】【client】聚灵炼制时，当前炼制经验过少时弹出的tips去除不再提示（点击炼制直接炼制即可）
        --    networkRequest.ReqRefineMaster(2, 0, UIRefineServantPanel.nowSelect.nowIndex + 1)
        --end
    end
    --[[    local allExp = CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool
        if (UIRefineServantPanel.RefineInfo.costNum > allExp) then
            local TipData = {}
            TipData.PromptWordId = 144
            TipData.des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(144)
            --TipData.Time=  tblData.endTime-CS.CSServerTime.Instance.TotalMillisecond
            TipData.ComfireAucion = function()
                networkRequest.ReqRefineMaster(2, 0)
            end
            TipData.CloseCallBack = function()
                uimanager:ClosePanel('UIPromptPanel')
            end
            Utility.ShowSecondConfirmPanel(TipData)
        else
            networkRequest.ReqRefineMaster(2, 0)
        end]]
end

---是否需要显示提示
function UIRefineServantPanel:IsMeetShowTip(go)
    if UIRefineServantPanel.nowSelect == nil then
        return false
    end
    local ItemID = UIRefineServantPanel.nowSelect.dataInfo.itemID
    local itemNumber = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(ItemID)
    if tonumber(UIRefineServantPanel.nowSelect.costnum) > itemNumber then
        if ItemID == LuaEnumCoinType.YuanBao then
            Utility.ShowItemGetWay(ItemID, go, LuaEnumWayGetPanelArrowDirType.Down, CS.UnityEngine.Vector2.zero)
        else
            Utility.TryShowFirstRechargePanel()
        end
        return true
    else
        return false
    end
end


--endregion

--region 点击事件
function UIRefineServantPanel.CloseBtnOnClick(go)
    uimanager:ClosePanel("UIRefineServantPanel")
end

function UIRefineServantPanel.HelpBtnOnClick(go)
    local isFind, descriptionInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(159)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, descriptionInfo)
    end
end

function UIRefineServantPanel.EnterBtnOnClick(go)
    if (UIRefineServantPanel.mCount >= UIRefineServantPanel.nowMaxCount) then
        UIRefineServantPanel:ShowTips(UIRefineServantPanel:GetEnterBtn_GameObject(), 238)
    else

        UIRefineServantPanel:ShowExpLowTips(go)
    end
end
--endregion

--region 服务器消息
function UIRefineServantPanel.OnResRefineMasterPanel(id, data, csdata)
    --if (UIRefineServantPanel.mSelectServantType ~= nil) then
    UIRefineServantPanel.cfgId = data.cfgId
    UIRefineServantPanel.datacfgId = data.cfgId
    UIRefineServantPanel.RefreshGrid(data.cfgId)
    UIRefineServantPanel.RefreshExp()
    UIRefineServantPanel.mCount = data.count
    UIRefineServantPanel:GetRefineCount_UILabel().text = "炼制灵力  [878787]剩[-]" .. Utility.GetBBCode(UIRefineServantPanel.nowMaxCount - data.count ~= 0) .. tostring(UIRefineServantPanel.nowMaxCount - data.count) .. "[-][878787]次[-]"
    --end
    --if true then
    --    return
    --end
    --local RefineTable = CS.Cfg_RefineMasterTableManager.Instance
    ----local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[UIRefineServantPanel.mSelectServantType - 1]
    ----local isfind, lastLevelServantInfo = CS.Cfg_HsLevelTableManager.Instance:TryGetValue(servantInfo.level - 1)
    ----if (isfind) then
    --UIRefineServantPanel.RefineInfo = RefineTable:GetReinMasterInfo(data.cfgId)
    --local refineTable = clientTableManager.cfg_refine_masterManager:TryGetValue(data.cfgId)
    --if (UIRefineServantPanel.RefineInfo ~= nil and refineTable ~= nil) then
    --    --local allExp = servantInfo.exp + lastLevelServantInfo.upgrade
    --    local allExp = CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool
    --    if (UIRefineServantPanel.RefineInfo.costNum > allExp) then
    --        UIRefineServantPanel:GetCostNum_UILabel().text = allExp
    --        UIRefineServantPanel:GetGainNum_UILabel().text = math.floor(allExp / refineTable:GetRatio() * RefineTable:GetRandomReinMasterExpratio(data.cfgId))
    --    else
    --        UIRefineServantPanel:GetCostNum_UILabel().text = UIRefineServantPanel.RefineInfo.costNum
    --        UIRefineServantPanel:GetGainNum_UILabel().text = math.floor(UIRefineServantPanel.RefineInfo.gainNum * RefineTable:GetRandomReinMasterExpratio(data.cfgId))
    --    end
    --end
    ----if (UIRefineServantPanel.RefineInfo.costNum > servantInfo.exp) then
    ----    UIRefineServantPanel:GetAfterLevel_UILabel().text = servantInfo.level - 1
    ----else
    ----    UIRefineServantPanel:GetAfterLevel_UILabel().text = servantInfo.level
    ----end
    ----end
    --UIRefineServantPanel.mCount = data.count
    --UIRefineServantPanel:GetRefineCount_UILabel().text = "炼制灵力  [878787]剩[-]" .. Utility.GetBBCode(3 - data.count ~= 0) .. tostring(3 - data.count) .. "[-][878787]次[-]"
    ----end
    --UIRefineServantPanel:RefreshPanel()
end

function UIRefineServantPanel.OnResRefineMasterResult(id, data, csdata)
    --成功
    --local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[UIRefineServantPanel.mSelectServantType - 1]
    if (data.isSuccess == 1) then
        UIRefineServantPanel.mCount = data.count
        UIRefineServantPanel:GetRefineCount_UILabel().text = "炼制灵力  [878787]剩[-]" .. Utility.GetBBCode(UIRefineServantPanel.nowMaxCount - data.count ~= 0) .. tostring(UIRefineServantPanel.nowMaxCount - data.count) .. "[-][878787]次[-]"
        --UIRefineServantPanel:GetCurLevel_UILabel().text = servantInfo.level

        --if (UIRefineServantPanel.RefineInfo.costNum > servantInfo.exp) then
        --    UIRefineServantPanel:GetAfterLevel_UILabel().text = servantInfo.level - 1
        --else
        --    UIRefineServantPanel:GetAfterLevel_UILabel().text = servantInfo.level
        --end

        local info = {}
        info.Str = UIRefineServantPanel:GetPreStr()
        info.IconName = UIRefineServantPanel:GetItemInfo().icon
        info.secondLabel = "灵力" .. data.gain
        luaEventManager.DoCallback(LuaCEvent.SendMiddleTopTips, info)
        UIRefineServantPanel:ShowEffect()
    else
        UIRefineServantPanel:ShowTips(UIRefineServantPanel:GetEnterBtn_GameObject(), 239)
    end
    UIRefineServantPanel:RefreshPanel()
end

function UIRefineServantPanel.ResServantExpUpdate(id, data)
    ---UIRefineServantPanel.RefreshExp()
    networkRequest.ReqRefineMasterPanel(2)
    ---  UIRefineServantPanel:RefreshPanel()
end
--endregion

UIRefineServantPanel.isStartRefreshGrid = false

function UIRefineServantPanel.RefreshGrid(id)
    ---@type table<number,checkSelectData>
    UIRefineServantPanel.checkList = {}
    local Grid = UIRefineServantPanel.GetGrid()
    ---@type table<number,TableRefineDetailedInfo>
    local detailedInfo = clientTableManager.cfg_refine_masterManager:GetSingleRefineDetailedInfo(id, true)
    if detailedInfo == nil then
        return
    end
    local allExp = CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool
    Grid.MaxCount = #detailedInfo
    local index = 0
    for i, v in pairs(detailedInfo) do
        local go = Grid.controlList[index]
        ---单选框
        local Table = CS.Utility_Lua.GetComponent(go.transform:Find("Table"), "Top_UITable")
        ---单选框
        local check = CS.Utility_Lua.GetComponent(go.transform:Find("Table/check"), "GameObject")
        ---单选框选中
        local checkSelect = CS.Utility_Lua.GetComponent(go.transform:Find("Table/check/check"), "GameObject")
        ---炼制获得的道具数量
        local num = CS.Utility_Lua.GetComponent(go.transform:Find("Table/num"), "Top_UILabel")
        ---消耗道具父节点
        local costObj = CS.Utility_Lua.GetComponent(go.transform:Find("cost"), "GameObject")
        ---消耗数量
        local costnum = CS.Utility_Lua.GetComponent(go.transform:Find("cost/num"), "Top_UILabel")
        ---消耗道具Icon
        local costIcon = CS.Utility_Lua.GetComponent(go.transform:Find("cost/icon"), "Top_UISprite")
        check.gameObject:SetActive(#detailedInfo ~= 1)

        local costnumNow = 0
        local color = ""
        if allExp < v.cost then
            color = "[e85038]"
        end
        --if v.cost > allExp then
        --    num.text =color.. math.ceil(allExp / v.ratio)
        --    costnumNow = math.ceil(allExp / v.ratio * v.costRate / 1000000)
        --end
        costnumNow = v.itemCost
        num.text = color .. v.gain
        costnum.text = gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr():GetHuaFeiDes(costnumNow, v.itemID)
        costObj.gameObject:SetActive(v.itemCost ~= 0)

        local itemTable = clientTableManager.cfg_itemsManager:TryGetValue(v.itemID)
        if itemTable ~= nil then
            costIcon.spriteName = itemTable:GetIcon()
        end

        ---@class UIRefineServantPanel_checkSelectData
        local checkSelectData = {
            ---@type GameObject
            obj = check,
            ---@type GameObject
            checkSelect = checkSelect,
            ---@type number
            nowIndex = index,
            ---@type TableRefineDetailedInfo
            dataInfo = v,
            ---@type number
            costnum = tonumber(costnumNow)
        }
        if UIRefineServantPanel.isStartRefreshGrid == false then
            checkSelect.gameObject:SetActive(index == 0)
            if index == 0 then
                ---@type UIRefineServantPanel_checkSelectData
                UIRefineServantPanel.nowSelect = checkSelectData
            end
        end
        if UIRefineServantPanel.nowSelect ~= nil and UIRefineServantPanel.nowSelect.nowIndex == checkSelectData.nowIndex then
            UIRefineServantPanel.nowSelect = checkSelectData
        end
        table.insert(UIRefineServantPanel.checkList, checkSelectData)
        CS.UIEventListener.Get(check.gameObject).onClick = function(go)
            for i, v in pairs(UIRefineServantPanel.checkList) do
                if v.obj == go then
                    v.checkSelect.gameObject:SetActive(true)
                    UIRefineServantPanel.nowSelect = checkSelectData
                    UIRefineServantPanel.RefreshExp()
                else
                    v.checkSelect.gameObject:SetActive(false)
                end
            end
        end
        Table:Reposition()

        index = index + 1
    end
    UIRefineServantPanel.isStartRefreshGrid = true
end

---刷新炼制后的灵兽经验
function UIRefineServantPanel.RefreshExp()
    local allExp = CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool
    UIRefineServantPanel:GetGainResultNum_UILabel().text = allExp
    if UIRefineServantPanel.nowSelect == nil or UIRefineServantPanel.nowSelect.dataInfo == nil then
        return
    end
    ---@type TableRefineDetailedInfo
    local dataInfo = UIRefineServantPanel.nowSelect.dataInfo

    if (dataInfo.cost > allExp) then
        UIRefineServantPanel:GetCostNum_UILabel().text = "[e85038]" .. dataInfo.cost
    else
        UIRefineServantPanel:GetCostNum_UILabel().text = dataInfo.cost
    end
end

---是否满足炼制消耗Exp
function UIRefineServantPanel.IsMeetLianZhiExp()
    local allExp = CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool
    if UIRefineServantPanel.nowSelect == nil or UIRefineServantPanel.nowSelect.dataInfo == nil then
        return false
    end
    ---@type TableRefineDetailedInfo
    local dataInfo = UIRefineServantPanel.nowSelect.dataInfo
    if (dataInfo.cost > allExp) then
        return false
    else
        return true
    end
end

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResRefineMasterPanelMessage, UIRefineServantPanel.OnResRefineMasterPanel)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResRefineMasterResultMessage, UIRefineServantPanel.OnResRefineMasterResult)
    if UIRefineServantPanel.ShowGainResultCor then
        StopCoroutine(self.ShowGainResultCor)
        UIRefineServantPanel.ShowGainResultCor = nil
    end
end

return UIRefineServantPanel