---月老对话面板
local UIMoonManPanel = {}

--region 局部变量

---当前婚姻功能枚举
UIMoonManPanel.curMarrageBtnType = 1
UIMoonManPanel.viewId = 0
UIMoonManPanel.curMarrageType = 1
--endregion

--region 初始化

function UIMoonManPanel:Init()
    self:InitComponents()
    UIMoonManPanel.BindUIEvents()
    UIMoonManPanel.BindNetMessage()
    UIMoonManPanel.InitParams()
end

function UIMoonManPanel:Show(id)
    if id then
        UIMoonManPanel.viewId = id
    end
    UIMoonManPanel.InitUI()
end

--- 初始化组件
function UIMoonManPanel:InitComponents()
    ---@type Top_UILabel title
    UIMoonManPanel.lb_name = self:GetCurComp("WidgetRoot/view/lb_name", "Top_UILabel")
    ---@type Top_UILabel 内容
    UIMoonManPanel.lb_describe = self:GetCurComp("WidgetRoot/view/lb_describe", "Top_UILabel")
    ---@type Top_UIGridContainer btn列表
    UIMoonManPanel.BtnList = self:GetCurComp("WidgetRoot/view/Daily/BtnList", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 帮助按钮
    UIMoonManPanel.btn_help = self:GetCurComp("WidgetRoot/event/btn_help", "GameObject")
    ---@type UnityEngine.GameObject 关闭按钮
    UIMoonManPanel.btn_close = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
end

function UIMoonManPanel.InitParams()
    UIMoonManPanel.marryInfo = CS.CSScene.MainPlayerInfo.MarryInfo
end

function UIMoonManPanel.BindUIEvents()
    --点击帮助事件
    CS.UIEventListener.Get(UIMoonManPanel.btn_help).onClick = UIMoonManPanel.OnClickbtn_help
    --点击关闭事件
    CS.UIEventListener.Get(UIMoonManPanel.btn_close).onClick = UIMoonManPanel.OnClickbtn_close
end

function UIMoonManPanel.BindNetMessage()
    -- commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResOnlineDivorceConditionMessage, UIMoonManPanel.OnResulatCallBack)
    UIMoonManPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResChangeMarryMessage, UIMoonManPanel.OnChangeMarryMessageCallBack)
end
--endregion

--region 函数监听

--点击帮助函数
---@param go UnityEngine.GameObject
function UIMoonManPanel.OnClickbtn_help(go)
    local id = UIMoonManPanel.curMarrageType == LuaEnumMaritalState.Married and 88 or UIMoonManPanel.marryInfo.isRemarriage and 89 or 87
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

--点击关闭函数
---@param go UnityEngine.GameObject
function UIMoonManPanel.OnClickbtn_close(go)
    uimanager:ClosePanel('UIMoonManPanel')
end

--点击功能按钮
function UIMoonManPanel.OnClickbtn_Marriage(go)
    if UIMoonManPanel.curMarrageBtnType == LuaEnumMarriageType.Marry then
        UIMoonManPanel.StartMarry(go)
    elseif UIMoonManPanel.curMarrageBtnType == LuaEnumMarriageType.Wedding then
        UIMoonManPanel.HoldWedding(go)
    elseif UIMoonManPanel.curMarrageBtnType == LuaEnumMarriageType.FirstBrokenMirror then
        uimanager:CreatePanel("UIReMarryPanel", nil)
        uimanager:ClosePanel("UIMoonManPanel", nil)
    elseif UIMoonManPanel.curMarrageBtnType == LuaEnumMarriageType.WeddingRingMore then
        uimanager:CreatePanel("UIWeddingRingUpPanel", nil)
        uimanager:ClosePanel("UIMoonManPanel", nil)
    elseif UIMoonManPanel.curMarrageBtnType == LuaEnumMarriageType.Divorce then
        UIMoonManPanel.RefreshUI(20606)
    elseif UIMoonManPanel.curMarrageBtnType == LuaEnumMarriageType.ApplyDivorce then
        networkRequest.ReqDivorce(0)
    elseif UIMoonManPanel.curMarrageBtnType == LuaEnumMarriageType.ForceDivorce then
        networkRequest.ReqDivorce(1)
    elseif UIMoonManPanel.curMarrageBtnType == LuaEnumMarriageType.WeddingRingUp then
        UIMoonManPanel.UpWeddingRing(go)
    end
end

--endregion

--region 网络消息处理
--婚姻状态改变消息
function UIMoonManPanel.OnChangeMarryMessageCallBack(msgId, data)
    local viewId = UIMoonManPanel.CheckCurMarryState()
    UIMoonManPanel.RefreshUI(viewId)
end

--endregion

--region UI

function UIMoonManPanel.InitUI()
    if UIMoonManPanel.viewId == 0 then
        UIMoonManPanel.viewId = UIMoonManPanel.CheckCurMarryState()
    end
    local isFind, moomMamViewInfo = UIMoonManPanel.marryInfo.MarriageViewDic:TryGetValue(UIMoonManPanel.viewId)
    if isFind then
        UIMoonManPanel.lb_name.text = moomMamViewInfo.title
        UIMoonManPanel.lb_describe.text = moomMamViewInfo.des
        UIMoonManPanel.InitBtn(moomMamViewInfo.btnList)
    end
end

function UIMoonManPanel.RefreshUI(viewId)
    if UIMoonManPanel.viewId == viewId then
        return
    end
    UIMoonManPanel.viewId = viewId
    local isFind, moomMamViewInfo = UIMoonManPanel.marryInfo.MarriageViewDic:TryGetValue(UIMoonManPanel.viewId)
    if isFind then
        UIMoonManPanel.lb_name.text = moomMamViewInfo.title
        UIMoonManPanel.lb_describe.text = moomMamViewInfo.des
        UIMoonManPanel.InitBtn(moomMamViewInfo.btnList)
    end
end

function UIMoonManPanel.InitBtn(btnListInfo)
    local length = btnListInfo.Count - 1
    local gridCount = 0
    for i = 0, length do
        local btnInfo = btnListInfo[i]
        if UIMoonManPanel.CheckIsShow(btnInfo.type) then
            gridCount = gridCount + 1
            UIMoonManPanel.BtnList.MaxCount = gridCount
            local go = UIMoonManPanel.BtnList.controlList[gridCount - 1]
            if go == nil then
                return
            end
            local btnLabel = CS.Utility_Lua.GetComponent(go.transform:Find('label'), "Top_UILabel")
            if btnLabel then
                btnLabel.text = btnInfo.btnStr
            end
            CS.UIEventListener.Get(go).onClick = nil
            CS.UIEventListener.Get(go).onClick = function()
                UIMoonManPanel.curMarrageBtnType = btnInfo.type
                UIMoonManPanel.OnClickbtn_Marriage(go)
            end
        end
    end
end

--endregion

--region 婚姻功能

function UIMoonManPanel.CheckIsShow(type)
    if type == LuaEnumMarriageType.FirstBrokenMirror then
        local serverNowTime = CS.CSServerTime.Instance.TotalMillisecond
        if not UIMoonManPanel.marryInfo.isRemarriage or UIMoonManPanel.marryInfo.remarriageTime - serverNowTime <= 0 then
            return false
        end
    end
    return true
end

function UIMoonManPanel.StartMarry(go)
    if UIMoonManPanel.CheckCanMarry(go) then
        networkRequest.ReqMarry()
    end
end

---举办婚礼
function UIMoonManPanel.HoldWedding(go)
    UIMoonManPanel.ShowBubbleTips(go, 124)
end

---升级婚戒
function UIMoonManPanel.UpWeddingRing(go)
    uimanager:CreatePanel("UIWeddingRingUpPanel")
end

--endregion

--region otherFunction

---检测婚姻状态  返回id
function UIMoonManPanel.CheckCurMarryState()
    if CS.CSScene.MainPlayerInfo == nil or UIMoonManPanel.marryInfo == nil then
        return 0
    end
    UIMoonManPanel.curMarrageType = Utility.EnumToInt(UIMoonManPanel.marryInfo.curMarryState)
    local id = UIMoonManPanel.curMarrageType == LuaEnumMaritalState.UnMarried and 20600 or 20602
    return id
end

---判断能否结婚
function UIMoonManPanel.CheckCanMarry(go)
    if CS.CSScene.MainPlayerInfo == nil then
        return false
    end
    local groupInfo = CS.CSScene.MainPlayerInfo.GroupInfoV2
    local isOppositeSex = UIMoonManPanel.GetGroupPlayerState(groupInfo)
    --首先组队 队长 异性
    --判断是否为组队
    if not groupInfo.IsHaveGroup then
        UIMoonManPanel.ShowBubbleTips(go, 119)
        return false
    end
    --判断是否为队长
    if not groupInfo.IsCaptain then
        UIMoonManPanel.ShowBubbleTips(go, 121)
        return false
    end
    --判断人数
    if groupInfo.PlayerInfoList.Count ~= 2 then
        UIMoonManPanel.ShowBubbleTips(go, 119)
        return false
    end
    --判断是否为异性
    if not isOppositeSex then
        UIMoonManPanel.ShowBubbleTips(go, 119)
        return false
    end
    --判断自己是否到达等级
    if UIMoonManPanel.marryInfo.MarriageLevelLimit > CS.CSScene.MainPlayerInfo.Level then
        UIMoonManPanel.ShowBubbleTips(go, 120, UIMoonManPanel.marryInfo.MarriageLevelLimit)
        return false
    end
    --是否有婚戒
    if not UIMoonManPanel.CheckWeddingRingState() then
        UIMoonManPanel.ShowBubbleTips(go, 123, UIMoonManPanel.marryInfo.LimitLevel)
        return false
    end
    return true
end

---显示气泡
function UIMoonManPanel.ShowBubbleTips(go, id, ...)
    if go == nil then
        return
    end
    local TipsInfo = {}
    if ... ~= nil then
        local str = ''
        local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(id)
        if isfind then
            str = string.format(data.content, ...)
        end
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIMoonManPanel";
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

---获取队伍中另一个人的状态
function UIMoonManPanel.GetGroupPlayerState(groupInfo)
    local length = groupInfo.PlayerInfoList.Count - 1
    for i = 0, length do
        local playerData = groupInfo.PlayerInfoList[i]
        if playerData.roleId ~= CS.CSScene.MainPlayerInfo.ID then
            return playerData.sex ~= Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
        end
    end
    return false
end

---判断钻戒
function UIMoonManPanel.CheckWeddingRingState()
    local rings = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemtype(luaEnumItemType.Equip, LuaEnumEquiptype.WeddingRing)
    return rings ~= nil and rings ~= 0
end

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResOnlineDivorceConditionMessage, UIMoonManPanel.OnResulatCallBack)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResChangeMarryMessage, UIMoonManPanel.OnChangeMarryMessageCallBack)
end

--endregion

return UIMoonManPanel