---@class UIRefineMasterPanel:UIBase
local UIRefineMasterPanel = {}



--region 变量
UIRefineMasterPanel.RefineInfo = nil;
UIRefineMasterPanel.mCount = 0
UIRefineMasterPanel.ShowGainResultCor = nil
---修为id
UIRefineMasterPanel.mItemId = 1000012
--endregion
--region 组件
function UIRefineMasterPanel.GetPanelName_UILabel()
    if (UIRefineMasterPanel.mPanelName == nil) then
        UIRefineMasterPanel.mPanelName = UIRefineMasterPanel:GetCurComp("WidgetRoot/view/lb_name", "Top_UILabel")
    end
    return UIRefineMasterPanel.mPanelName
end

function UIRefineMasterPanel.GetPanelContent_UILabel()
    if (UIRefineMasterPanel.mPanelContent == nil) then
        UIRefineMasterPanel.mPanelContent = UIRefineMasterPanel:GetCurComp("WidgetRoot/view/lb_name", "Top_UILabel")
    end
    return UIRefineMasterPanel.mPanelContent
end

function UIRefineMasterPanel.GetHelpBtn_GameObject()
    if (UIRefineMasterPanel.mHelpBtnGo == nil) then
        UIRefineMasterPanel.mHelpBtnGo = UIRefineMasterPanel:GetCurComp("WidgetRoot/btn_help", "GameObject")
    end
    return UIRefineMasterPanel.mHelpBtnGo
end

function UIRefineMasterPanel.GetCloseBtn_GameObject()
    if (UIRefineMasterPanel.mCloseBtnGo == nil) then
        UIRefineMasterPanel.mCloseBtnGo = UIRefineMasterPanel:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return UIRefineMasterPanel.mCloseBtnGo
end

function UIRefineMasterPanel.GetEnterBtnBtn_GameObject()
    if (UIRefineMasterPanel.mEnterBtnBtnGo == nil) then
        UIRefineMasterPanel.mEnterBtnBtnGo = UIRefineMasterPanel:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    end
    return UIRefineMasterPanel.mEnterBtnBtnGo
end

function UIRefineMasterPanel.GetBtnList_UIGridContainer()
    if (UIRefineMasterPanel.mBtnList == nil) then
        UIRefineMasterPanel.mBtnList = UIRefineMasterPanel:GetCurComp("WidgetRoot/view/Daily/BtnList", "Top_UIGridContainer")
    end
    return UIRefineMasterPanel.mBtnList
end

function UIRefineMasterPanel.GetBeforeLevel_UILabel()
    if (UIRefineMasterPanel.mBeforeLevel == nil) then
        UIRefineMasterPanel.mBeforeLevel = UIRefineMasterPanel:GetCurComp("WidgetRoot/lvChange/before/num", "UILabel")
    end
    return UIRefineMasterPanel.mBeforeLevel
end

function UIRefineMasterPanel.GetAfterLevel_UILabel()
    if (UIRefineMasterPanel.mAfterLevel == nil) then
        UIRefineMasterPanel.mAfterLevel = UIRefineMasterPanel:GetCurComp("WidgetRoot/lvChange/after/num", "UILabel")
    end
    return UIRefineMasterPanel.mAfterLevel
end

function UIRefineMasterPanel.GetRemainTime_UILabel()
    if (UIRefineMasterPanel.mRemainTime == nil) then
        UIRefineMasterPanel.mRemainTime = UIRefineMasterPanel:GetCurComp("WidgetRoot/remainTime", "UILabel")
    end
    return UIRefineMasterPanel.mRemainTime
end

function UIRefineMasterPanel.GetExpEffect_GameObject()
    if (UIRefineMasterPanel.mExpEffectGameObject == nil) then
        UIRefineMasterPanel.mExpEffectGameObject = UIRefineMasterPanel:GetCurComp("WidgetRoot/expEffect", "GameObject")
    end
    return UIRefineMasterPanel.mExpEffectGameObject
end

function UIRefineMasterPanel.GetSuccedEffect_GameObject()
    if (UIRefineMasterPanel.mSuccedEffectGameObject == nil) then
        UIRefineMasterPanel.mSuccedEffectGameObject = UIRefineMasterPanel:GetCurComp("WidgetRoot/succedEffect", "GameObject")
    end
    return UIRefineMasterPanel.mSuccedEffectGameObject
end

function UIRefineMasterPanel.GetGainResultNum_GameObject()
    if (UIRefineMasterPanel.mGainNumResultGo == nil) then
        UIRefineMasterPanel.mGainNumResultGo = UIRefineMasterPanel:GetCurComp("WidgetRoot/gainresult", "GameObject")
    end
    return UIRefineMasterPanel.mGainNumResultGo
end

function UIRefineMasterPanel.GetGainResultNum_UILabel()
    if (UIRefineMasterPanel.mGainNumResult == nil) then
        UIRefineMasterPanel.mGainNumResult = UIRefineMasterPanel:GetCurComp("WidgetRoot/gainresult/num/num", "UILabel")
    end
    return UIRefineMasterPanel.mGainNumResult
end

function UIRefineMasterPanel.GetGainNum_UILabel()
    if (UIRefineMasterPanel.mGainNum == nil) then
        UIRefineMasterPanel.mGainNum = UIRefineMasterPanel:GetCurComp("WidgetRoot/gain/num/num", "UILabel")
    end
    return UIRefineMasterPanel.mGainNum
end

function UIRefineMasterPanel.GetGainIcon_GameObject()
    if (UIRefineMasterPanel.mGainIcon == nil) then
        UIRefineMasterPanel.mGainIcon = UIRefineMasterPanel:GetCurComp("WidgetRoot/gain/num/icon", "GameObject")
    end
    return UIRefineMasterPanel.mGainIcon
end

---修为Grid
function UIRefineMasterPanel.GetGrid()
    if (UIRefineMasterPanel.mGrid == nil) then
        UIRefineMasterPanel.mGrid = UIRefineMasterPanel:GetCurComp("WidgetRoot/gain/Grid", "Top_UIGridContainer")
    end
    return UIRefineMasterPanel.mGrid
end

--endregion

--region 初始化
function UIRefineMasterPanel:Init()
    UIRefineMasterPanel:BindMessage()
    UIRefineMasterPanel:BindUIEvents()
    self:UpdateOpenServerLimit()
end

function UIRefineMasterPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRefineMasterPanelMessage, UIRefineMasterPanel.OnResRefineMasterPanel)
    self.OnResRefineMasterResultFun = function(id, data, csdata)
        self:OnResRefineMasterResult(id, data, csdata)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRefineMasterResultMessage, self.OnResRefineMasterResultFun)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        if UIRefineMasterPanel.datacfgId ~= nil then
            UIRefineMasterPanel.RefreshGrid(UIRefineMasterPanel.datacfgId)
        end
    end)
end

function UIRefineMasterPanel:BindUIEvents()
    -- CS.UIEventListener.Get(UIRefineMasterPanel.GetGainIcon_GameObject()).onClick = UIRefineMasterPanel.ShowIconinfo
    CS.UIEventListener.Get(UIRefineMasterPanel.GetCloseBtn_GameObject()).onClick = UIRefineMasterPanel.CloseBtnOnClick
    CS.UIEventListener.Get(UIRefineMasterPanel.GetHelpBtn_GameObject()).onClick = UIRefineMasterPanel.HelpBtnOnClick
    CS.UIEventListener.Get(UIRefineMasterPanel.GetEnterBtnBtn_GameObject()).onClick = UIRefineMasterPanel.EnterBtnOnClick

end

function UIRefineMasterPanel:Show()
    UIRefineMasterPanel.nowMaxCount = gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr():GetLianZhiCount(1)
    networkRequest.ReqRefineMasterPanel(1)
    UIRefineMasterPanel:RefreshUIPanel()
end

--endregion

--region 数据处理
function UIRefineMasterPanel:UpdateOpenServerLimit()
    local difDay = CS.CSScene.MainPlayerInfo.OpenServerDayNumber + 1
    local isFind, item = CS.Cfg_GlobalTableManagerBase.Instance:TryGetValue(22224)
    if isFind then
        local value = string.Split(item.value, "&")
        for i = 1, #value do
            local info = string.Split(value[i], "#")
            if difDay >= tonumber(info[1]) and difDay <= tonumber(info[2]) then
                self.mOpenServerLimitLevel = tonumber(info[3])
                break
            end
        end
    end
end
--endregion

--region 客户端事件
function UIRefineMasterPanel:RefreshUIPanel()
    UIRefineMasterPanel.GetBeforeLevel_UILabel().text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level
end

function UIRefineMasterPanel.EnterBtnOnClick(go)
    if (UIRefineMasterPanel.mCount >= UIRefineMasterPanel.nowMaxCount) then
        UIRefineMasterPanel.ShowTips(UIRefineMasterPanel.GetEnterBtnBtn_GameObject(), 238)
    else
        if UIRefineMasterPanel.nowSelect ~= nil then
            if UIRefineMasterPanel.IsMeetShowTip(go) == false then
                networkRequest.ReqRefineMaster(1, 0, UIRefineMasterPanel.nowSelect.nowIndex + 1)
            end
        end
    end
end

function UIRefineMasterPanel.ShowIconinfo()
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(1000012) })
end

function UIRefineMasterPanel.CloseBtnOnClick()
    uimanager:ClosePanel("UIRefineMasterPanel", nil)
end

function UIRefineMasterPanel.HelpBtnOnClick()
    local isFind, descriptionInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(153)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, descriptionInfo)
    end
end

function UIRefineMasterPanel.ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end

    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIRefineMasterPanel"
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

function UIRefineMasterPanel.IEnumShowGainResult()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1));
    UIRefineMasterPanel.GetGainResultNum_GameObject():SetActive(true)
    UIRefineMasterPanel.GetSuccedEffect_GameObject():SetActive(false)
    UIRefineMasterPanel.GetSuccedEffect_GameObject():SetActive(true)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(2));
    UIRefineMasterPanel.GetSuccedEffect_GameObject():SetActive(false)
    UIRefineMasterPanel.GetGainResultNum_GameObject():SetActive(false)
    UIRefineMasterPanel.ShowGainResultCor = nil
end
--endregion

--region 服务器事件
function UIRefineMasterPanel.OnResRefineMasterPanel(id, data, csdata)
    local instance = CS.Cfg_RefineMasterTableManager.Instance
    UIRefineMasterPanel.datacfgId = data.cfgId
    UIRefineMasterPanel.RefreshGrid(data.cfgId)
    UIRefineMasterPanel.RefreshLevel()
    --UIRefineMasterPanel.RefineInfo = instance:GetReinMasterInfo(data.cfgId)
    --local refineTable = clientTableManager.cfg_refine_masterManager:TryGetValue(data.cfgId)
    --if (UIRefineMasterPanel.RefineInfo ~= nil and refineTable ~= nil) then
    --    if (UIRefineMasterPanel.RefineInfo.costNum > CS.CSScene.MainPlayerInfo.Exp) then
    --        local lastExp = CS.Cfg_CharacterManager.Instance:GetUpGradeExpByLevel(CS.CSScene.MainPlayerInfo.Level - 1)
    --        if (lastExp >= UIRefineMasterPanel.RefineInfo.costNum) then
    --            --       UIRefineMasterPanel.GetGainNum_UILabel().text = math.floor(UIRefineMasterPanel.RefineInfo.costNum / refineTable:GetRatio() * instance:GetRandomReinMasterExpratio(data.cfgId))
    --            UIRefineMasterPanel.GetAfterLevel_UILabel().text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level - 1
    --        else
    --            --      UIRefineMasterPanel.GetGainNum_UILabel().text = math.floor(lastExp / refineTable:GetRatio() * instance:GetRandomReinMasterExpratio(data.cfgId))
    --            if (lastExp > CS.CSScene.MainPlayerInfo.Exp) then
    --                UIRefineMasterPanel.GetAfterLevel_UILabel().text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level - 1
    --            else
    --                UIRefineMasterPanel.GetAfterLevel_UILabel().text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level
    --            end
    --        end
    --    else
    --        --   UIRefineMasterPanel.GetGainNum_UILabel().text = math.floor(UIRefineMasterPanel.RefineInfo.gainNum * instance:GetRandomReinMasterExpratio(data.cfgId))
    --        UIRefineMasterPanel.GetAfterLevel_UILabel().text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level
    --    end
    --end
    UIRefineMasterPanel.mCount = data.count
    UIRefineMasterPanel.GetRemainTime_UILabel().text = "炼制修为  [878787]剩[-]" .. Utility.GetBBCode(UIRefineMasterPanel.nowMaxCount - data.count ~= 0) .. tostring(UIRefineMasterPanel.nowMaxCount - data.count) .. "[-][878787]次[-]"
end

function UIRefineMasterPanel:OnResRefineMasterResult(id, data, csdata)
    --判定是否因降级导致小于最低打开面板等级，如果小于则直接关闭面板
    self:IsClosePanel()

    --成功
    local lastExp = CS.Cfg_CharacterManager.Instance:GetUpGradeExpByLevel(CS.CSScene.MainPlayerInfo.Level - 1)
    if (data.isSuccess == 1) then
        self.mCount = data.count
        self.GetRemainTime_UILabel().text = "炼制修为  [878787]剩[-]" .. Utility.GetBBCode(UIRefineMasterPanel.nowMaxCount - data.count ~= 0) .. tostring(UIRefineMasterPanel.nowMaxCount - data.count) .. "[-][878787]次[-]"
        self.GetBeforeLevel_UILabel().text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level
        local costNum = 0
        if UIRefineMasterPanel.nowSelect ~= nil then
            costNum = UIRefineMasterPanel.nowSelect.dataInfo.cost
        end
        if (costNum > CS.CSScene.MainPlayerInfo.Exp) then
            if (lastExp >= costNum) then
                self.GetAfterLevel_UILabel().text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level - 1
            else
                if (lastExp > CS.CSScene.MainPlayerInfo.Exp) then
                    self.GetAfterLevel_UILabel().text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level - 1
                else
                    self.GetAfterLevel_UILabel().text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level
                end
            end
        else
            self.GetAfterLevel_UILabel().text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level
        end

        ---修为提示
        self.GetGainResultNum_UILabel().text = tostring(data.gain)

        local info = {}
        info.Str = self:GetPreStr()
        info.IconName = self:GetItemInfo().icon
        info.secondLabel = "修为" .. data.gain
        luaEventManager.DoCallback(LuaCEvent.SendMiddleTopTips, info)

        self:ShowEffect()
        networkRequest.ReqRefineMasterPanel(1)
        --降级时有经验变化刷新收益所以再次请求
    else
        self.ShowTips(self.GetEnterBtnBtn_GameObject(), 239)
    end
end
--endregion

--region 刷新界面
function UIRefineMasterPanel:IsClosePanel()
    if (self.mOpenServerLimitLevel ~= nil and CS.CSScene.Sington.MainPlayer.BaseInfo.Level < self.mOpenServerLimitLevel) then
        uimanager:ClosePanel("UIRefineMasterPanel")
    end
end

function UIRefineMasterPanel:ShowEffect()
    self.GetGainResultNum_GameObject():SetActive(true)
    self.GetSuccedEffect_GameObject():SetActive(false)
    self.GetSuccedEffect_GameObject():SetActive(true)

    if self.ShowGainResultCor then
        StopCoroutine(self.ShowGainResultCor)
    end
    self.ShowGainResultCor = StartCoroutine(UIRefineMasterPanel.StartHideEffect)
end

function UIRefineMasterPanel.StartHideEffect()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(2))
    if not CS.StaticUtility.IsNull(UIRefineMasterPanel.GetSuccedEffect_GameObject()) then
        UIRefineMasterPanel.GetSuccedEffect_GameObject():SetActive(false)
    end
    if not CS.StaticUtility.IsNull(UIRefineMasterPanel.GetGainResultNum_GameObject()) then
        UIRefineMasterPanel.GetGainResultNum_GameObject():SetActive(false)
    end
end

---@return string 文本前缀
function UIRefineMasterPanel:GetPreStr()
    if self.mPreStr == nil then
        self.mPreStr = "[f7f2e6]获得了"
    end
    return self.mPreStr
end

---@return TABLE.CFG_ITEMS 修为信息
function UIRefineMasterPanel:GetItemInfo()
    if self.mItemInfo == nil then
        ___, self.mItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mItemId)
    end
    return self.mItemInfo
end
--endregion

---刷新Grid
function UIRefineMasterPanel:InitGrid()

end

UIRefineMasterPanel.isStartRefreshGrid = false
function UIRefineMasterPanel.RefreshGrid(id)
    ---@type table<number,checkSelectData>
    UIRefineMasterPanel.checkList = {}
    local Grid = UIRefineMasterPanel.GetGrid()
    ---@type table<number,TableRefineDetailedInfo>
    local detailedInfo = clientTableManager.cfg_refine_masterManager:GetSingleRefineDetailedInfo(id, true)
    if detailedInfo == nil then
        return
    end
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
        num.text = v.gain
        costObj.gameObject:SetActive(v.itemCost ~= 0)
        costnum.text = v.itemCost
        costnum.text = gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr():GetHuaFeiDes(v.itemCost, v.itemID)
        local itemTable = clientTableManager.cfg_itemsManager:TryGetValue(v.itemID)
        if itemTable ~= nil then
            costIcon.spriteName = itemTable:GetIcon()
        end

        ---@class checkSelectData
        local checkSelectData = {
            ---@type GameObject
            obj = check,
            ---@type GameObject
            checkSelect = checkSelect,
            ---@type number
            nowIndex = index,
            ---@type TableRefineDetailedInfo
            dataInfo = v
        }
        if UIRefineMasterPanel.isStartRefreshGrid == false then
            if index == 0 then
                UIRefineMasterPanel.nowSelect = checkSelectData
            end
            checkSelect.gameObject:SetActive(index == 0)
        end

        table.insert(UIRefineMasterPanel.checkList, checkSelectData)
        CS.UIEventListener.Get(check.gameObject).onClick = function(go)
            for i, v in pairs(UIRefineMasterPanel.checkList) do
                if v.obj == go then
                    v.checkSelect.gameObject:SetActive(true)
                    UIRefineMasterPanel.nowSelect = checkSelectData
                else
                    v.checkSelect.gameObject:SetActive(false)
                end
            end
            UIRefineMasterPanel.RefreshLevel()
        end
        Table:Reposition()
        index = index + 1
    end
    UIRefineMasterPanel.isStartRefreshGrid = true
end

---刷新炼制后的等级
function UIRefineMasterPanel.RefreshLevel()
    if UIRefineMasterPanel.nowSelect == nil or UIRefineMasterPanel.nowSelect.dataInfo == nil then
        return
    end
    ---@type TableRefineDetailedInfo
    local dataInfo = UIRefineMasterPanel.nowSelect.dataInfo
    if CS.CSScene.MainPlayerInfo.Exp > dataInfo.cost then
        UIRefineMasterPanel.GetAfterLevel_UILabel().text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level
    else
        UIRefineMasterPanel.GetAfterLevel_UILabel().text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level - 1
    end
end

function UIRefineMasterPanel.IsMeetShowTip(go)
    if UIRefineMasterPanel.nowSelect == nil then
        return false
    end
    local ItemID = UIRefineMasterPanel.nowSelect.dataInfo.itemID
    local itemNumber = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(ItemID)
    if UIRefineMasterPanel.nowSelect.dataInfo.itemCost > itemNumber then
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

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResRefineMasterPanelMessage, UIRefineMasterPanel.OnResRefineMasterPanel)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResRefineMasterResultMessage, UIRefineMasterPanel.OnResRefineMasterResult)
    if UIRefineMasterPanel.ShowGainResultCor then
        StopCoroutine(self.ShowGainResultCor)
        UIRefineMasterPanel.ShowGainResultCor = nil
    end
end
return UIRefineMasterPanel