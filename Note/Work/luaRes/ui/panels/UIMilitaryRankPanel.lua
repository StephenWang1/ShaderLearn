---军衔面板
local UIMilitaryRankPanel = {}

function UIMilitaryRankPanel.GetCurPrefixId()
    if CS.CSScene.MainPlayerInfo then
        return CS.CSScene.MainPlayerInfo.PrefixId
    end
    return 1000
end

--[[---获取主角最大战力值
function UIMilitaryRankPanel.GetPlayerMaxFightPower()
    if CS.CSScene.MainPlayerInfo then
        return CS.CSScene.MainPlayerInfo.MaxFightPower
    end
    return 0
end]]

---获取战力
---@return number
function UIMilitaryRankPanel.GetFightPower()
    if CS.CSScene.MainPlayerInfo then
        return CS.CSScene.MainPlayerInfo.FightPower
    end
    return 0
end

---获得攻击名称
---@return string
function UIMilitaryRankPanel.GetPlayerAttackType()
    if UIMilitaryRankPanel.attackType == nil then
        UIMilitaryRankPanel.attackType = Utility.GetMainPlayerAttackCount()
    end
    return UIMilitaryRankPanel.attackType
end

--region 局部变量

--记录服务器当前id
UIMilitaryRankPanel.curID = 1000
UIMilitaryRankPanel.nextID = 1001

UIMilitaryRankPanel.attributeCount = 2

UIMilitaryRankPanel.attributeGoAndTemplate = {}

UIMilitaryRankPanel.CheatPushId = 15

UIMilitaryRankPanel.SecreBookKeyward = ''



--endregion

--region 初始化
function UIMilitaryRankPanel:Init()
    self:InitComponents()
    UIMilitaryRankPanel.BindUIEvents()
    UIMilitaryRankPanel.BindNetMessage()
    UIMilitaryRankPanel.InitParameters()
    UIMilitaryRankPanel.InitUI()
end

--- 初始化组件
function UIMilitaryRankPanel:InitComponents()
    ---@type Top_UILabel  当前等级
    UIMilitaryRankPanel.level_Label = self:GetCurComp("WidgetRoot/view/level", "Top_UILabel")
    ---@type Top_UISprite 当前等级描述
    UIMilitaryRankPanel.levelDes = self:GetCurComp("WidgetRoot/view/levelDes", "Top_UISprite")

    ---@type Top_UISprite  未开启或已满级
    UIMilitaryRankPanel.center = self:GetCurComp("WidgetRoot/view/center", "Top_UISprite")

    -----@type  UnityEngine.GameObject 帮助按钮
    UIMilitaryRankPanel.helpBtn = self:GetCurComp("WidgetRoot/events/helpBtn", "GameObject")

    ---@type UnityEngine.GameObject 关闭按钮
    UIMilitaryRankPanel.CloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")

    ---@type UnityEngine.GameObject 变强
    UIMilitaryRankPanel.addBtn = self:GetCurComp("WidgetRoot/events/addBtn", "GameObject")

    ---@type UnityEngine.GameObject 升级按钮
    UIMilitaryRankPanel.btn_up = self:GetCurComp("WidgetRoot/events/btn_up", "GameObject")
    ---@type Top_UILabel  升级按钮文本
    UIMilitaryRankPanel.UpBtnLabel = self:GetCurComp("WidgetRoot/events/btn_up/Label", "Top_UILabel")
    ---@type UnityEngine.GameObject  升级按钮特效
    UIMilitaryRankPanel.effect = self:GetCurComp("WidgetRoot/events/btn_up/effect", "GameObject")

    ---@type UnityEngine.GameObject 最大显示
    UIMilitaryRankPanel.maxObj = self:GetCurComp("WidgetRoot/view/max", "GameObject")

    ---@type UIGridContainer 属性Container
    UIMilitaryRankPanel.attribute_UIGridContainer = self:GetCurComp("WidgetRoot/view/Attribute", "UIGridContainer")
    ---@type UnityEngine.GameObject 升级成功特效父物体
    UIMilitaryRankPanel.sucessEffectParent = self:GetCurComp("WidgetRoot/sucessEffectParent", "GameObject")
    ---@type UnityEngine.GameObject 循环特效父物体
    UIMilitaryRankPanel.loopEffectParent = self:GetCurComp("WidgetRoot/loopEffect", "GameObject")

    ---@type Top_UILabel 需求物品icon
    UIMilitaryRankPanel.needItemIcon = self:GetCurComp("WidgetRoot/view/nextCombat/img", "Top_UISprite")
    ---@type Top_UILabel 需求信息 格式：（战力/所需战力）
    UIMilitaryRankPanel.nextCombat = self:GetCurComp("WidgetRoot/view/nextCombat/label", "Top_UILabel")
    ---@type UnityEngine.GameObject 需求节点
    UIMilitaryRankPanel.needRoot = self:GetCurComp("WidgetRoot/view/nextCombat", "GameObject")

end

function UIMilitaryRankPanel.BindUIEvents()
    CS.UIEventListener.Get(UIMilitaryRankPanel.CloseBtn).onClick = UIMilitaryRankPanel.OnClickCloseBtn
    CS.UIEventListener.Get(UIMilitaryRankPanel.helpBtn).onClick = UIMilitaryRankPanel.OnClickhelpBtn
    CS.UIEventListener.Get(UIMilitaryRankPanel.btn_up).onClick = UIMilitaryRankPanel.OnClickbtn_up
    --点击添加按钮事件
    CS.UIEventListener.Get(UIMilitaryRankPanel.addBtn).onClick = UIMilitaryRankPanel.OnClickaddBtn
end

function UIMilitaryRankPanel.BindNetMessage()

    UIMilitaryRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResJunXianUpMessage, UIMilitaryRankPanel.OnResJunXianUpMessageCallback)

    UIMilitaryRankPanel:GetClientEventHandler():AddEvent(CS.CEvent.FightPowerChange, UIMilitaryRankPanel.OnResFightPowerChangeCallBack);

    UIMilitaryRankPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_AutoDoMission, UIMilitaryRankPanel.OnAutoDoMissionCallBack);

end

--- 初始化变量
function UIMilitaryRankPanel.InitParameters()
    UIMilitaryRankPanel.nextCombatFormat = '%s上限达到  %s' .. luaEnumColorType.Gray .. '（当前%s)'
    UIMilitaryRankPanel.mainPlayerId = CS.CSScene.MainPlayerInfo.ID
    UIMilitaryRankPanel.mainPlayerCarrer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    ---@type TABLE.CFG_PREFIX
    UIMilitaryRankPanel.curPrefixTblInfo = nil
    ---@type TABLE.CFG_PREFIX
    UIMilitaryRankPanel.nextPrefixTblInfo = nil

    UIMilitaryRankPanel.isinitialized = false

    UIMilitaryRankPanel.isCanUp = false
end


--endregion

--region 函数监听

---点击关闭函数
function UIMilitaryRankPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel("UIRolePanelTagPanel")
    uimanager:ClosePanel("UIMilitaryRankPanel")
end

---点击帮助按钮
function UIMilitaryRankPanel.OnClickhelpBtn(go)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(19)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

---点击升级函数
---@param go UnityEngine.GameObject
function UIMilitaryRankPanel.OnClickbtn_up(go)

    if UIMilitaryRankPanel.isCanUp then
        local curId = UIMilitaryRankPanel.curPrefixTblInfo == nil and 0 or UIMilitaryRankPanel.curPrefixTblInfo.id
        networkRequest.ReqJunXianUp(curId, UIMilitaryRankPanel.nextPrefixTblInfo.nextId, UIMilitaryRankPanel.GetFightPower())
        return
    end
    local configId = UIMilitaryRankPanel.curPrefixTblInfo == nil and 29 or UIMilitaryRankPanel.nextPrefixTblInfo == nil and 5 or 4
    UIMilitaryRankPanel.ShowTips(go.transform, nil, configId, UIMilitaryRankPanel.GetPlayerAttackType())
end

---点击添加按钮函数
---@param go UnityEngine.GameObject
function UIMilitaryRankPanel.OnClickaddBtn(go)
    if (UIMilitaryRankPanel.mShowMinLevel == nil) then
        local tbl = CS.Cfg_GlobalTableManager.CfgInstance:GetListTypeIntListJingHao(22503)
        if (tbl ~= nil and tbl.Count > 0) then
            UIMilitaryRankPanel.mShowMinLevel = tonumber(tbl[0])
        else
            UIMilitaryRankPanel.mShowMinLevel = 40
        end
    end
    if (CS.CSScene.MainPlayerInfo.Level < UIMilitaryRankPanel.mShowMinLevel) then
        Utility.ShowPopoTips(go.transform, "等级不足", 290, "UIMilitaryRankPanel")
    else
        uimanager:CreatePanel('UIStrongerPanel')
    end
end

--endregion

--region 网络消息处理

---战力信息改变消息
function UIMilitaryRankPanel.OnResFightPowerChangeCallBack(eventid, id)
    if UIMilitaryRankPanel.mainPlayerId == id then
        UIMilitaryRankPanel.RefreshPowerData()
        UIMilitaryRankPanel.RefreshPowerView()
    end
end

---军衔升级回调
function UIMilitaryRankPanel.OnResJunXianUpMessageCallback(id, data)
    if data then
        UIMilitaryRankPanel.RefreshAllData()
        UIMilitaryRankPanel.RefreshAllView()
        UIMilitaryRankPanel.PlaySucessEffect()
    end
end

function UIMilitaryRankPanel.OnAutoDoMissionCallBack()

    if UIMilitaryRankPanel.curPrefixTblInfo == nil or UIMilitaryRankPanel.nextPrefixTblInfo == nil then
        return
    end

    if not UIMilitaryRankPanel.isCanUp then
        return
    end

    networkRequest.ReqJunXianUp(UIMilitaryRankPanel.curPrefixTblInfo.id, UIMilitaryRankPanel.nextPrefixTblInfo.id, UIMilitaryRankPanel.GetFightPower())
    UIMilitaryRankPanel.OnClickCloseBtn()
end

--endregion

--region UI

function UIMilitaryRankPanel.InitUI()
    UIMilitaryRankPanel.RefreshAllData()
    UIMilitaryRankPanel.RefreshAllView()
    UIMilitaryRankPanel.isinitialized = true
    UIMilitaryRankPanel.needItemIcon.spriteName = 'Fight' .. UIMilitaryRankPanel.mainPlayerCarrer
end

function UIMilitaryRankPanel.RefreshAllView()
    UIMilitaryRankPanel.RefreshPrefixView()
    UIMilitaryRankPanel.RefreshPowerView()
    UIMilitaryRankPanel.RefreshAttributeView()
end

---刷新军衔视图
function UIMilitaryRankPanel.RefreshPrefixView()
    local curInfo = UIMilitaryRankPanel.curPrefixTblInfo
    local showStr = curInfo == nil and luaEnumColorType.Gray .. '0' or tostring((curInfo.group - 1) * 10 + curInfo.classNumber)

    UIMilitaryRankPanel.loopEffectParent:SetActive(curInfo ~= nil)
    UIMilitaryRankPanel.levelDes.color = curInfo == nil and LuaEnumUnityColorType.Grey or LuaEnumUnityColorType.White
    UIMilitaryRankPanel.level_Label.text = showStr
    --[[    UIMilitaryRankPanel.btn_up.gameObject:SetActive(nextInfo ~= nil)
        UIMilitaryRankPanel.nextCombatObj:SetActive(nextInfo ~= nil)
        UIMilitaryRankPanel.maxObj:SetActive(nextInfo ~= nil)]]
end

---刷新属性视图
function UIMilitaryRankPanel.RefreshAttributeView()
    local tbl = UIMilitaryRankPanel.GetAttributeList()
    UIMilitaryRankPanel.attribute_UIGridContainer.MaxCount = #tbl
    for i = 1, #tbl do
        local go = UIMilitaryRankPanel.attribute_UIGridContainer.controlList[i - 1]
        if go then
            local name = CS.Utility_Lua.GetComponent(go.transform:Find("name"), "UILabel")
            local currentLabel = CS.Utility_Lua.GetComponent(go.transform:Find("currentAttribute"), "UILabel")
            local nextLabel = CS.Utility_Lua.GetComponent(go.transform:Find("nextAttribute"), "UILabel")
            local nextLabelEffect = CS.Utility_Lua.GetComponent(go.transform:Find("nextAttribute"), "CSFontBlink")
            local arrow = CS.Utility_Lua.GetComponent(go.transform:Find("arrow"), "UISprite")

            local curIsNull = tbl[i].curMaxValue == nil and tbl[i].curMinValue == nil
            local nextIsNull = tbl[i].nextMaxValue == nil and tbl[i].nextMinValue == nil
            local color = tbl[i].isUp and luaEnumColorType.Green or luaEnumColorType.White

            name.text = tbl[i].str
            currentLabel.text = curIsNull and luaEnumColorType.Red .. '暂无' or tbl[i].curMaxValue == nil and tostring(tbl[i].curMinValue) or tostring(tbl[i].curMinValue) .. '-' .. tostring(tbl[i].curMaxValue)
            nextLabel.text = nextIsNull and luaEnumColorType.Green .. '已达最大' or tbl[i].nextMaxValue == nil and
                    color .. tostring(tbl[i].nextMinValue) or color .. tostring(tbl[i].nextMinValue) .. '-' .. tostring(tbl[i].nextMaxValue)
            arrow.spriteName = ternary(nextIsNull, "arrow3", "arrow")
            if UIMilitaryRankPanel.isinitialized then
                nextLabelEffect:Play()
            end
        end
    end
end

---刷新战力信息视图
function UIMilitaryRankPanel.RefreshPowerView()

    local color = UIMilitaryRankPanel.isCanUp and luaEnumColorType.Green or luaEnumColorType.Red

    UIMilitaryRankPanel.nextCombat.text = UIMilitaryRankPanel.nextPrefixTblInfo ~= nil and
            string.format(UIMilitaryRankPanel.nextCombatFormat, UIMilitaryRankPanel.GetPlayerAttackType(),
                    color .. tostring(UIMilitaryRankPanel.nextPrefixTblInfo.nbvalue), tostring(UIMilitaryRankPanel.GetFightPower()))
            or '[dde6eb]已达最大战勋等级[-]'

    UIMilitaryRankPanel.addBtn.gameObject:SetActive(not UIMilitaryRankPanel.isCanUp)
    UIMilitaryRankPanel.effect:SetActive(UIMilitaryRankPanel.isCanUp)
end

---播放成功动画
function UIMilitaryRankPanel.PlaySucessEffect()
    UIMilitaryRankPanel.sucessEffectParent:SetActive(false)
    UIMilitaryRankPanel.sucessEffectParent:SetActive(true)
end

---@param trans UnityEngine.Transform 按钮
---@param str string    内容
---@param id  number    提示框id
---@param param string    内容参数
function UIMilitaryRankPanel.ShowTips(trans, str, id, param)
    if param ~= nil and param ~= '' then
        local isFind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(id)
        if isFind then
            str = string.format(data.content, param)
        end
    end
    Utility.ShowPopoTips(trans, str, id, 'UIMilitaryRankPanel')
end

---秘籍跳转
function UIMilitaryRankPanel.ShowChatPushUI()
    -- if UIMilitaryRankPanel.curID < 1004 and nextInfo ~= nil and tonumber(fight) < tonumber(nextInfo.nbvalue) then
    local info = {}
    info.id = 15
    info.dependPanel = "UIMilitaryRankPanel"
    info.isNotCheckCondition = true
    Utility.ShowCheatPushTips(info)
    -- end
end

--endregion

--region otherFunction

---刷新数据
function UIMilitaryRankPanel.RefreshAllData()
    local curPrefix = UIMilitaryRankPanel.GetCurPrefixId()
    local isFind = false

    isFind, UIMilitaryRankPanel.curPrefixTblInfo = CS.Cfg_PrefixTableManager.Instance:TryGetValue(curPrefix)

    local nextId = UIMilitaryRankPanel.curPrefixTblInfo ~= nil and UIMilitaryRankPanel.curPrefixTblInfo.nextId or 1001

    isFind, UIMilitaryRankPanel.nextPrefixTblInfo = CS.Cfg_PrefixTableManager.Instance:TryGetValue(nextId)

    UIMilitaryRankPanel.RefreshPowerData()
end

function UIMilitaryRankPanel.RefreshPowerData()
    UIMilitaryRankPanel.isCanUp = false

    if UIMilitaryRankPanel.nextPrefixTblInfo then
        UIMilitaryRankPanel.isCanUp = UIMilitaryRankPanel.GetFightPower() >= UIMilitaryRankPanel.nextPrefixTblInfo.nbvalue
    end
end

---获取处理过的属性列表
---@return table<number,AttributeParam>
function UIMilitaryRankPanel.GetAttributeList()
    local attributeNum = 2
    local tbl = {}
    for i = 1, attributeNum do
        local attributeTbl = UIMilitaryRankPanel.GetAttributeShowData(i)
        if attributeTbl ~= nil then
            table.insert(tbl, attributeTbl)
        end
    end
    --[[    if #tbl >= 2 then
            table.sort(tbl, UIMilitaryRankPanel.SortAttributeTbl)
        end]]
    return tbl
end

---获得显示的属性信息
---@return table<number,AttributeParam>
function UIMilitaryRankPanel.GetAttributeShowData(type)

    local mStr = ''
    local mCurMinValue = nil
    local mCurMaxValue = nil
    local mNextMinValue = nil
    local mNextMaxValue = nil
    if UIMilitaryRankPanel.curPrefixTblInfo == nil and UIMilitaryRankPanel.nextPrefixTblInfo == nil then
        return nil
    end

    if type == 1 then
        ---神圣攻击
        mStr = CS.Cfg_Property_NameTableManager.Instance:GetRoleAttributeName(LuaEnumAttributeType.HolyAttackMax)

        if UIMilitaryRankPanel.curPrefixTblInfo ~= nil then
            mCurMinValue = UIMilitaryRankPanel.curPrefixTblInfo.holyAttackMin
            mCurMaxValue = UIMilitaryRankPanel.curPrefixTblInfo.holyAttackMax
        end
        if UIMilitaryRankPanel.nextPrefixTblInfo ~= nil then
            mNextMinValue = UIMilitaryRankPanel.nextPrefixTblInfo.holyAttackMin
            mNextMaxValue = UIMilitaryRankPanel.nextPrefixTblInfo.holyAttackMax
        end

    elseif type == 2 then
        ---神圣防御
        mStr = CS.Cfg_Property_NameTableManager.Instance:GetRoleAttributeName(LuaEnumAttributeType.HolyDefenceMax)

        if UIMilitaryRankPanel.curPrefixTblInfo ~= nil then
            mCurMinValue = UIMilitaryRankPanel.curPrefixTblInfo.holyDefenceMin
            mCurMaxValue = UIMilitaryRankPanel.curPrefixTblInfo.holyDefenceMax
        end
        if UIMilitaryRankPanel.nextPrefixTblInfo ~= nil then
            mNextMinValue = UIMilitaryRankPanel.nextPrefixTblInfo.holyDefenceMin
            mNextMaxValue = UIMilitaryRankPanel.nextPrefixTblInfo.holyDefenceMax
        end
    end
    local mIsUp = (mCurMinValue ~= nil and mNextMinValue ~= nil) and mNextMinValue > mCurMinValue or
            (mCurMaxValue ~= nil and mNextMaxValue ~= nil) and mCurMaxValue > mNextMaxValue or false
    ---@class AttributeParam
    local AttributeParam = {
        str = mStr,
        curMinValue = mCurMinValue,
        curMaxValue = mCurMaxValue,
        nextMinValue = mNextMinValue,
        nextMaxValue = mNextMaxValue,
        isUp = mIsUp
    }
    return AttributeParam
end

---对应不同的角色类型设置参数
---@param
function UIMilitaryRankPanel.GetRoleSealMarkGrow(param)
    local value = nil
    if param ~= nil and #param.list ~= nil then
        for i = 1, #param.list do
            if param.list[i].list[1] == UIMilitaryRankTitlePanel.carrer then
                return param.list[i].list[2]
            end
        end
    end
    return value
end

--endregion

--region ondestroy

function ondestroy()

end

--endregion

return UIMilitaryRankPanel