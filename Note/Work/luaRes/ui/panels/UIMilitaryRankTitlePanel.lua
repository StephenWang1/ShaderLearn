---@class UIMilitaryRankTitlePanel : UIBase 封号面板
local UIMilitaryRankTitlePanel = {}

function UIMilitaryRankTitlePanel.GetCurId()
    if CS.CSScene.MainPlayerInfo ~= nil then
        return CS.CSScene.MainPlayerInfo.SealMarkId
    end
    return 0
end

--region 初始化

function UIMilitaryRankTitlePanel:Init()
    self:InitComponents()
    UIMilitaryRankTitlePanel.InitParameters()
    UIMilitaryRankTitlePanel.BindUIEvents()
    UIMilitaryRankTitlePanel.BindNetMessage()
    UIMilitaryRankTitlePanel.RefreshData()
    UIMilitaryRankTitlePanel.RefreshView()
    self:BindLuaRedPoint()
end

--- 初始化变量
function UIMilitaryRankTitlePanel.InitParameters()
    UIMilitaryRankTitlePanel.carrer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    ---@type TABLE.cfg_prefix_title
    UIMilitaryRankTitlePanel.curSealMarkTblInfo = nil
    ---@type TABLE.cfg_prefix_title
    UIMilitaryRankTitlePanel.nextSealMarkTblInfo = nil
    UIMilitaryRankTitlePanel.isCanUp = false
    UIMilitaryRankTitlePanel.needItemInfo = nil
    UIMilitaryRankTitlePanel.needSecondItemInfo = nil
end

--- 初始化组件
function UIMilitaryRankTitlePanel:InitComponents()
    ---@type Top_UISprite  当前军衔名称
    UIMilitaryRankTitlePanel.topMarkStr = self:GetCurComp("WidgetRoot/view/namez", "Top_UISprite")

    ---@type UnityEngine.GameObject 中间部分视图
    UIMilitaryRankTitlePanel.markView = self:GetCurComp("WidgetRoot/view/militaryRank", "GameObject")
    ---@type Top_UISprite  当前军衔名称 或小段
    UIMilitaryRankTitlePanel.curMarkStr = self:GetCurComp("WidgetRoot/view/militaryRank/name", "Top_UISprite")
    ---@type Top_UISprite  下阶军衔名称 或小段
    UIMilitaryRankTitlePanel.nextMarkStr = self:GetCurComp("WidgetRoot/view/militaryRank/name1", "Top_UISprite")

    ---@type UnityEngine.GameObject 达到最大
    UIMilitaryRankTitlePanel.maxObj = self:GetCurComp("WidgetRoot/view/max", "GameObject")
    ---@type UnityEngine.GameObject 达到最大
    UIMilitaryRankTitlePanel.maxSpriteObj = self:GetCurComp("WidgetRoot/view/center", "GameObject")

    ---@type UIGridContainer 属性Container
    UIMilitaryRankTitlePanel.grid = self:GetCurComp("WidgetRoot/view/Table/Attribute/Scroll View/arributelist", "UIGridContainer")

    ---@type UnityEngine.GameObject 特效父物体
    UIMilitaryRankTitlePanel.effectParent = self:GetCurComp("WidgetRoot/Game", "GameObject")

    ---@type UnityEngine.GameObject 关闭按钮
    UIMilitaryRankTitlePanel.CloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    ---@type UnityEngine.GameObject 升级按钮
    UIMilitaryRankTitlePanel.btn_up = self:GetCurComp("WidgetRoot/events/btn_up", "GameObject")


    ---@type Top_UILabel  升级按钮文本
    --UIMilitaryRankTitlePanel.UpBtnLabel = self:GetCurComp("WidgetRoot/events/btn_up/Label", "Top_UILabel")
    ---@type UnityEngine.GameObject  升级特效
    UIMilitaryRankTitlePanel.effect = self:GetCurComp("WidgetRoot/events/btn_up/effect", "GameObject")

    ---@type Top_UISprite 天赋按钮
    UIMilitaryRankTitlePanel.btn_flair = self:GetCurComp("WidgetRoot/events/btn_flair", "Top_UISprite")
    ---@type UIRedPoint
    UIMilitaryRankTitlePanel.mRedPoint_RedPoint = self:GetCurComp("WidgetRoot/events/btn_flair/redpoint", "UIRedPoint")

    --region 升级所需
    ---@type UnityEngine.GameObject 支撑table排序上边的属性不会掉下来
    UIMilitaryRankTitlePanel.widgetObj = self:GetCurComp("WidgetRoot/view/Table/Wight", "GameObject")
    ---@type UnityEngine.GameObject 标题文本
    UIMilitaryRankTitlePanel.rank2 = self:GetCurComp("WidgetRoot/view/Table/cost/Table/rank2", "GameObject")
    ---@type Top_UILabel 所需物品
    UIMilitaryRankTitlePanel.nextImg = self:GetCurComp("WidgetRoot/view/Table/cost/Table/costTable/nextCombat/img", "Top_UISprite")
    ---@type Top_UILabel 所需物品信息 格式：（战力/所需战力）
    UIMilitaryRankTitlePanel.nextCombat = self:GetCurComp("WidgetRoot/view/Table/cost/Table/costTable/nextCombat/label", "Top_UILabel")
    ---@type UnityEngine.GameObject 所需物品 格式：（战力/所需战力）
    UIMilitaryRankTitlePanel.nextCombatObj = self:GetCurComp("WidgetRoot/view/Table/cost/Table/costTable/nextCombat", "GameObject")
    ---@type UnityEngine.GameObject 添加按钮（推送入口）
    UIMilitaryRankTitlePanel.addBtn = self:GetCurComp("WidgetRoot/view/Table/cost/Table/costTable/nextCombat/addBtn", "GameObject")

    ---@type Top_UILabel 所需物品
    UIMilitaryRankTitlePanel.nextSecondImg = self:GetCurComp("WidgetRoot/view/Table/cost/Table/costTable/nextCombat2/img", "Top_UISprite")
    ---@type Top_UILabel 所需物品信息 格式：（战力/所需战力）
    UIMilitaryRankTitlePanel.nextSecondCombat = self:GetCurComp("WidgetRoot/view/Table/cost/Table/costTable/nextCombat2/label", "Top_UILabel")
    ---@type UnityEngine.GameObject 所需物品 格式：（战力/所需战力）
    UIMilitaryRankTitlePanel.nextSecondCombatObj = self:GetCurComp("WidgetRoot/view/Table/cost/Table/costTable/nextCombat2", "GameObject")
    ---@type UnityEngine.GameObject 添加按钮（推送入口）
    UIMilitaryRankTitlePanel.secondAddBtn = self:GetCurComp("WidgetRoot/view/Table/cost/Table/costTable/nextCombat2/addBtn", "GameObject")

    ---@type Top_UITable 一级
    UIMilitaryRankTitlePanel.firstTable = self:GetCurComp("WidgetRoot/view/Table", "Top_UITable")
    ---@type Top_UITable 二级
    UIMilitaryRankTitlePanel.secondTable = self:GetCurComp("WidgetRoot/view/Table/cost/Table", "Top_UITable")
    ---@type Top_UITable 三级
    UIMilitaryRankTitlePanel.thirdTable = self:GetCurComp("WidgetRoot/view/Table/cost/Table/costTable", "Top_UITable")
    --endregion
end

function UIMilitaryRankTitlePanel.BindUIEvents()
    ---点击关闭按钮
    CS.UIEventListener.Get(UIMilitaryRankTitlePanel.CloseBtn).onClick = UIMilitaryRankTitlePanel.OnClickCloseBtn
    ---点击升级按钮
    CS.UIEventListener.Get(UIMilitaryRankTitlePanel.btn_up).onClick = UIMilitaryRankTitlePanel.OnClickUpBtn
    ---点击添加按钮
    CS.UIEventListener.Get(UIMilitaryRankTitlePanel.addBtn).onClick = UIMilitaryRankTitlePanel.OnClickAddBtn
    ---点击添加按钮
    CS.UIEventListener.Get(UIMilitaryRankTitlePanel.secondAddBtn).onClick = UIMilitaryRankTitlePanel.OnClickSecondAddBtn
    ---点击icon按钮
    CS.UIEventListener.Get(UIMilitaryRankTitlePanel.nextImg.gameObject).onClick = UIMilitaryRankTitlePanel.OnClickIconBtn
    ---点击icon按钮
    CS.UIEventListener.Get(UIMilitaryRankTitlePanel.nextSecondImg.gameObject).onClick = UIMilitaryRankTitlePanel.OnClickSecondIconBtn
    ---点击天赋按钮
    CS.UIEventListener.Get(UIMilitaryRankTitlePanel.btn_flair.gameObject).onClick = UIMilitaryRankTitlePanel.OnClickFlairBtn
end

function UIMilitaryRankTitlePanel.BindNetMessage()
    UIMilitaryRankTitlePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSealMarkInfoMessage, UIMilitaryRankTitlePanel.OnResSealMarkInfoMessageCallBack)
    ---背包物品变化时触发一次满背包提醒(和一次技能可学提醒)
    UIMilitaryRankTitlePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, UIMilitaryRankTitlePanel.OnBagCoinChangedCallBack)
    UIMilitaryRankTitlePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, UIMilitaryRankTitlePanel.OnBagCoinChangedCallBack)

end

---@private
function UIMilitaryRankTitlePanel:BindLuaRedPoint()
    self.mRedPoint_RedPoint:AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.TitleTalentMark))
end
--endregion

--region 函数监听

---点击关闭按钮
---@private
function UIMilitaryRankTitlePanel.OnClickCloseBtn()
    local panel = uimanager:GetPanel("UIMilitaryRankTitleFlairPanel");
    if (panel ~= nil) then
        uimanager:ClosePanel("UIMilitaryRankTitleFlairPanel")
    end
    uimanager:ClosePanel("UIMilitaryRankTitlePanel")
end

---点击升级按钮
---@private
function UIMilitaryRankTitlePanel.OnClickUpBtn(go)
    if UIMilitaryRankTitlePanel.isCanUp then
        networkRequest.ReqUpgradeSealMark()
    else
        local sealMarkNeedInfo = uiStaticParameter.GetUpSealMarkNeedInfo()
        if (sealMarkNeedInfo ~= nil and #sealMarkNeedInfo.conditionInfo > 0) then
            if (sealMarkNeedInfo.conditionInfo[1] ~= nil and sealMarkNeedInfo.conditionInfo[1].conditions ~= nil and (not sealMarkNeedInfo.conditionInfo[1].conditions.success)) then
                Utility.ShowItemGetWay(sealMarkNeedInfo.conditionInfo[1].itemID, UIMilitaryRankTitlePanel.addBtn, LuaEnumWayGetPanelArrowDirType.up, CS.UnityEngine.Vector2.zero);
            elseif (#sealMarkNeedInfo.conditionInfo > 1 and sealMarkNeedInfo.conditionInfo[2] ~= nil) then
                Utility.ShowItemGetWay(sealMarkNeedInfo.conditionInfo[2].itemID, UIMilitaryRankTitlePanel.secondAddBtn, LuaEnumWayGetPanelArrowDirType.up, CS.UnityEngine.Vector2.zero);
            end
        else
            Utility.ShowPopoTips(go, nil, 436, 'UIMilitaryRankTitlePanel')
        end
    end
end

function UIMilitaryRankTitlePanel.OnClickIconBtn()
    if UIMilitaryRankTitlePanel.needItemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = UIMilitaryRankTitlePanel.needItemInfo, showRight = false })
    end
end

function UIMilitaryRankTitlePanel.OnClickSecondIconBtn()
    if UIMilitaryRankTitlePanel.needSecondItemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = UIMilitaryRankTitlePanel.needSecondItemInfo, showRight = false })
    end
end

---点击添加按钮
---@private
function UIMilitaryRankTitlePanel.OnClickAddBtn(go)
    local UpSealMarkNeedInfo = uiStaticParameter.GetUpSealMarkNeedInfo()
    if UpSealMarkNeedInfo == nil or UpSealMarkNeedInfo.conditionInfo == nil or #UpSealMarkNeedInfo.conditionInfo < 1 or UpSealMarkNeedInfo.conditionInfo[1] == nil then
        return
    end

    Utility.ShowItemGetWay(UpSealMarkNeedInfo.conditionInfo[1].itemID, go, LuaEnumWayGetPanelArrowDirType.up, CS.UnityEngine.Vector2.zero);
end

---点击添加按钮
---@private
function UIMilitaryRankTitlePanel.OnClickSecondAddBtn(go)
    local UpSealMarkNeedInfo = uiStaticParameter.GetUpSealMarkNeedInfo()
    if UpSealMarkNeedInfo == nil or UpSealMarkNeedInfo.conditionInfo == nil or #UpSealMarkNeedInfo.conditionInfo < 2 or UpSealMarkNeedInfo.conditionInfo[2] == nil then
        return
    end

    Utility.ShowItemGetWay(UpSealMarkNeedInfo.conditionInfo[2].itemID, go, LuaEnumWayGetPanelArrowDirType.up, CS.UnityEngine.Vector2.zero);
end

---点击天赋按钮
---@private
function UIMilitaryRankTitlePanel.OnClickFlairBtn(go)
    -- 未达到等级，气泡提示
    local isFind, tbl_global = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22918)
    if isFind then
        if tonumber(tbl_global.value) > UIMilitaryRankTitlePanel.GetCurId() then
            local isFind2, promptInfo = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(484)
            if isFind2 then
                Utility.ShowPopoTips(UIMilitaryRankTitlePanel.btn_flair.gameObject, string.format(promptInfo.content, tbl_global.value), 484)
            end
            return
        end
    end
    -- 封号达到等级可点击封号天赋
    uimanager:CreatePanel("UIMilitaryRankTitleFlairPanel", nil)
end

--endregion

--region 网络消息处理

---返回当前封号信息
function UIMilitaryRankTitlePanel.OnResSealMarkInfoMessageCallBack()
    UIMilitaryRankTitlePanel.isCanUp = true
    UIMilitaryRankTitlePanel.RefreshData()
    UIMilitaryRankTitlePanel.PlayEffect()
    UIMilitaryRankTitlePanel.updateItem = CS.CSListUpdateMgr.Add(20, nil, function()
        UIMilitaryRankTitlePanel.RefreshView()
    end)
end

function UIMilitaryRankTitlePanel.OnBagCoinChangedCallBack()
    UIMilitaryRankTitlePanel.RefreshNeedItem()
end

--endregion

--region View

function UIMilitaryRankTitlePanel.RefreshView()
    UIMilitaryRankTitlePanel.RefreshSealMarkView()
    UIMilitaryRankTitlePanel.RefreshAttributeGridView()
    UIMilitaryRankTitlePanel.RefreshNeedItem()
    UIMilitaryRankTitlePanel.RereshAllTable()
    UIMilitaryRankTitlePanel.RereshBtnFlairColor()
end

---刷新封号视图
function UIMilitaryRankTitlePanel.RefreshSealMarkView()
    local curInfo = UIMilitaryRankTitlePanel.curSealMarkTblInfo
    local nextInfo = UIMilitaryRankTitlePanel.nextSealMarkTblInfo

    local isMin = UIMilitaryRankTitlePanel.curSealMarkTblInfo == nil
    local isMax = UIMilitaryRankTitlePanel.nextSealMarkTblInfo == nil

    local isShowMarkView = not isMin and not isMax
    local isNextPrefixMin = isShowMarkView and nextInfo:GetClassNumber() == 1

    ---顶部封号显示
    UIMilitaryRankTitlePanel.topMarkStr.spriteName = isMin and 'min' .. tostring(UIMilitaryRankTitlePanel.carrer) or
            tostring(curInfo:GetGroup()) .. '_' .. tostring(UIMilitaryRankTitlePanel.carrer)

    ---当前封号显示
    UIMilitaryRankTitlePanel.curMarkStr.spriteName = not isShowMarkView and '' or
            not isNextPrefixMin and tostring(curInfo:GetClassNumber()) or
            tostring(curInfo:GetGroup() * 1000 + curInfo:GetClassNumber()) .. '_' .. UIMilitaryRankTitlePanel.carrer

    ---下阶封号显示
    UIMilitaryRankTitlePanel.nextMarkStr.spriteName = not isShowMarkView and '' or
            not isNextPrefixMin and tostring(nextInfo:GetClassNumber()) or
            tostring(nextInfo:GetGroup() * 1000 + nextInfo:GetClassNumber()) .. '_' .. UIMilitaryRankTitlePanel.carrer

    UIMilitaryRankTitlePanel.markView:SetActive(isShowMarkView)
    --UIMilitaryRankTitlePanel.UpBtnLabel.text = isMin and '激活' or '晋升'
    UIMilitaryRankTitlePanel.btn_up.gameObject:SetActive(not isMax)

    UIMilitaryRankTitlePanel.secondTable.gameObject:SetActive(not isMax)
    UIMilitaryRankTitlePanel.widgetObj:SetActive(isMax)
    --[[    UIMilitaryRankTitlePanel.nextCombatObj:SetActive(not isMax)
        UIMilitaryRankTitlePanel.nextSecondCombatObj:SetActive(not isMax)]]

    --UIMilitaryRankTitlePanel.addBtn:SetActive(not isMax)

    UIMilitaryRankTitlePanel.maxSpriteObj:SetActive(isMax)
    UIMilitaryRankTitlePanel.maxObj:SetActive(isMax)
end

---刷新属性视图
function UIMilitaryRankTitlePanel.RefreshAttributeGridView()
    local tbl = UIMilitaryRankTitlePanel.GetAttributeList()
    UIMilitaryRankTitlePanel.grid.MaxCount = #tbl
    for i = 1, #tbl do
        local go = UIMilitaryRankTitlePanel.grid.controlList[i - 1]
        local currentLabel = CS.Utility_Lua.GetComponent(go.transform:Find("curattribute/attack"), "UILabel")
        local nextLabel = CS.Utility_Lua.GetComponent(go.transform:Find("nextattribute/attack"), "UILabel")
        local nextLabelEffect = CS.Utility_Lua.GetComponent(go.transform:Find("nextattribute/attack"), "CSFontBlink")
        local name = CS.Utility_Lua.GetComponent(go.transform:Find("curattribute/attack/name"), "UILabel")
        local arrow = CS.Utility_Lua.GetComponent(go.transform:Find("curattribute/attack/arrow"), "UISprite")

        local curIsNull = tbl[i].curMaxValue == nil and tbl[i].curMinValue == nil
        local nextIsNull = tbl[i].nextMaxValue == nil and tbl[i].nextMinValue == nil
        local color = curIsNull and luaEnumColorType.Green3 or tbl[i].isUp and luaEnumColorType.Green3 or luaEnumColorType.White
        name.text = tbl[i].str
        currentLabel.text = curIsNull and '暂无' or tbl[i].curMaxValue == nil and tostring(tbl[i].curMinValue) or tostring(tbl[i].curMinValue) .. '-' .. tostring(tbl[i].curMaxValue)
        nextLabel.text = nextIsNull and luaEnumColorType.Green3 .. '已达最大' or tbl[i].nextMaxValue == nil and
                color .. tostring(tbl[i].nextMinValue) or color .. tostring(tbl[i].nextMinValue) .. '-' .. tostring(tbl[i].nextMaxValue)
        arrow.spriteName = ternary(nextIsNull, "arrow3", "arrow")
        if UIMilitaryRankTitlePanel.isCanUp then
            nextLabelEffect:Play()
        end
    end
    UIMilitaryRankTitlePanel.isCanUp = false
end

---刷新需求物品信息
function UIMilitaryRankTitlePanel.RefreshNeedItem()
    local UpSealMarkNeedInfo = uiStaticParameter.GetUpSealMarkNeedInfo()
    if (UpSealMarkNeedInfo == nil or UpSealMarkNeedInfo.conditionInfo == nil) then
        return
    end

    local firstIsNull = #UpSealMarkNeedInfo.conditionInfo < 1
    local secondIsNull = #UpSealMarkNeedInfo.conditionInfo < 2
    local isMeetFirst, isMeetSecond = true, true

    if not firstIsNull then
        if (#UpSealMarkNeedInfo.conditionInfo > 0 and UpSealMarkNeedInfo.conditionInfo[1].conditions ~= nil and UpSealMarkNeedInfo.conditionInfo[1].conditions.mReplaceMatData ~= nil) then
            local needId = UpSealMarkNeedInfo.conditionInfo[1].itemID
            local needCount = UpSealMarkNeedInfo.conditionInfo[1].conditions.mReplaceMatData.num
            local curCount = UpSealMarkNeedInfo.conditionInfo[1].conditions.mReplaceMatData.playerHasTotal
            local isFind, itemTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(needId)
            if isFind then
                UIMilitaryRankTitlePanel.nextImg.spriteName = itemTbl.icon
                UIMilitaryRankTitlePanel.needItemInfo = itemTbl
            end
            UIMilitaryRankTitlePanel.nextCombat.text = curCount < needCount and luaEnumColorType.Red .. tostring(curCount) .. '[-]/' .. tostring(needCount) or
                    luaEnumColorType.Green3 .. tostring(curCount) .. '[-]/' .. tostring(needCount)
            isMeetFirst = curCount >= needCount
        end
    end

    if not secondIsNull then
        if (#UpSealMarkNeedInfo.conditionInfo > 1 and UpSealMarkNeedInfo.conditionInfo[2].conditions ~= nil and UpSealMarkNeedInfo.conditionInfo[2].conditions.mReplaceMatData ~= nil) then
            local needId = UpSealMarkNeedInfo.conditionInfo[2].itemID
            local needCount = UpSealMarkNeedInfo.conditionInfo[2].conditions.mReplaceMatData.num
            local curCount = UpSealMarkNeedInfo.conditionInfo[2].conditions.mReplaceMatData.playerHasTotal
            local isFind, itemTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(needId)
            if isFind then
                UIMilitaryRankTitlePanel.nextSecondImg.spriteName = itemTbl.icon
                UIMilitaryRankTitlePanel.needSecondItemInfo = itemTbl
            end
            UIMilitaryRankTitlePanel.nextSecondCombat.text = curCount < needCount and luaEnumColorType.Red .. tostring(curCount) .. '[-]/' .. tostring(needCount) or
                    luaEnumColorType.Green3 .. tostring(curCount) .. '[-]/' .. tostring(needCount)
            isMeetSecond = curCount >= needCount
        end
    end

    if UIMilitaryRankTitlePanel.nextCombatObj.activeSelf ~= not firstIsNull then
        UIMilitaryRankTitlePanel.nextCombatObj:SetActive(not firstIsNull)
    end

    if UIMilitaryRankTitlePanel.nextSecondCombatObj.activeSelf ~= not secondIsNull then
        UIMilitaryRankTitlePanel.nextSecondCombatObj:SetActive(not secondIsNull)
    end

    UIMilitaryRankTitlePanel.isCanUp = isMeetFirst and isMeetSecond
    UIMilitaryRankTitlePanel.effect:SetActive(UIMilitaryRankTitlePanel.isCanUp)
end

function UIMilitaryRankTitlePanel.RereshAllTable()
    UIMilitaryRankTitlePanel.thirdTable:Reposition()
    UIMilitaryRankTitlePanel.secondTable:Reposition()
    UIMilitaryRankTitlePanel.firstTable:Reposition()
end

---播放升级特效
function UIMilitaryRankTitlePanel.PlayEffect()
    UIMilitaryRankTitlePanel.effectParent:SetActive(false)
    UIMilitaryRankTitlePanel.effectParent:SetActive(true)
end

--刷新天赋按钮颜色
function UIMilitaryRankTitlePanel.RereshBtnFlairColor()
    local isFind, tbl_global = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22918)
    if isFind then
        UIMilitaryRankTitlePanel.btn_flair.color = (tonumber(tbl_global.value) > UIMilitaryRankTitlePanel.GetCurId()) and CS.UnityEngine.Color.gray or CS.UnityEngine.Color.white
    end

end

--endregion

--region otherFunction

function UIMilitaryRankTitlePanel.RefreshData()
    local curID = UIMilitaryRankTitlePanel.GetCurId()
    UIMilitaryRankTitlePanel.curSealMarkTblInfo = clientTableManager.cfg_prefix_titleManager:TryGetValue(curID)
    UIMilitaryRankTitlePanel.nextSealMarkTblInfo = clientTableManager.cfg_prefix_titleManager:TryGetValue(curID + 1)
    UIMilitaryRankTitlePanel.mSealMarkNeedInfo = nil
end

---获取处理过的属性列表
---@return table<number,trungrowAttribute>
function UIMilitaryRankTitlePanel.GetAttributeList()
    local attributeNum = 6
    local tbl = {}
    for i = 1, attributeNum do
        local attributeTbl = UIMilitaryRankTitlePanel.GetAttributeShowData(i)
        if attributeTbl ~= nil then
            table.insert(tbl, attributeTbl)
        end
    end
    if #tbl >= 2 then
        table.sort(tbl, UIMilitaryRankTitlePanel.SortAttributeTbl)
    end
    return tbl
end

---获得显示的属性信息
---@return table<number,sealMarkAttribute>
function UIMilitaryRankTitlePanel.GetAttributeShowData(type)

    local mStr = ''
    local mCurMinValue = nil
    local mCurMaxValue = nil
    local mNextMinValue = nil
    local mNextMaxValue = nil
    local curInfo = UIMilitaryRankTitlePanel.curSealMarkTblInfo
    local nextInfo = UIMilitaryRankTitlePanel.nextSealMarkTblInfo
    if curInfo == nil and nextInfo == nil then
        return
    end
    if type == 1 then
        mStr = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp)

        if (curInfo == nil or curInfo:GetHp() == nil) and (nextInfo == nil or nextInfo:GetHp() == nil) then
            return nil
        end

        if curInfo ~= nil and curInfo:GetHp() ~= nil then
            mCurMinValue = UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(curInfo:GetHp())
        end

        mCurMaxValue = nil

        if nextInfo ~= nil and nextInfo:GetHp() ~= nil then
            mNextMinValue = UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(nextInfo:GetHp())
        end

        mNextMaxValue = nil
    elseif type == 2 then

        mStr = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))

        if (curInfo == nil or curInfo:GetCeLower() == nil) and (nextInfo == nil or nextInfo:GetCeLower() == nil) then
            return nil
        end

        if curInfo ~= nil and curInfo:GetCeLower() ~= nil then
            mCurMinValue = UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(curInfo:GetCeLower())
        end

        if curInfo ~= nil and curInfo:GetCeUpper() ~= nil then
            mCurMaxValue = UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(curInfo:GetCeUpper())
        end

        if nextInfo ~= nil and nextInfo:GetCeLower() ~= nil then
            mNextMinValue = UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(nextInfo:GetCeLower())
        end

        if nextInfo ~= nil and nextInfo:GetCeUpper() ~= nil then
            mNextMaxValue = UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(nextInfo:GetCeUpper())
        end

    elseif type == 3 then
        mStr = Utility.GetAttributeName(LuaEnumAttributeType.PhyDefenceMax)

        if (curInfo == nil or curInfo:GetDefLower() == nil) and (nextInfo == nil or nextInfo:GetDefLower() == nil) then
            return nil
        end

        if curInfo ~= nil and curInfo:GetDefLower() ~= nil then
            mCurMinValue = UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(curInfo:GetDefLower())
        end

        if curInfo ~= nil and curInfo:GetDefUpper() ~= nil then
            mCurMaxValue = UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(curInfo:GetDefUpper())
        end

        if nextInfo ~= nil and nextInfo ~= nil and nextInfo:GetDefLower() ~= nil then
            mNextMinValue = UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(nextInfo:GetDefLower())
        end

        if nextInfo ~= nil and nextInfo:GetDefUpper() ~= nil then
            mNextMaxValue = UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(nextInfo:GetDefUpper())
        end

    elseif type == 4 then
        mStr = Utility.GetAttributeName(LuaEnumAttributeType.MagicDefenceMax)

        if (curInfo == nil or curInfo:GetMDefUpper() == nil) and (nextInfo == nil or nextInfo:GetMDefUpper() == nil) then
            return nil
        end

        if curInfo ~= nil and curInfo:GetMDefLower() ~= nil then
            mCurMinValue = UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(curInfo:GetMDefLower())
        end

        if curInfo ~= nil and curInfo:GetMDefUpper() ~= nil then
            mCurMaxValue = UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(curInfo:GetMDefUpper())
        end

        if nextInfo ~= nil and nextInfo:GetMDefLower() ~= nil then
            mNextMinValue = UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(nextInfo:GetMDefLower())
        end

        if nextInfo ~= nil and nextInfo:GetMDefUpper() ~= nil then
            mNextMaxValue = UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(nextInfo:GetMDefUpper())
        end
    elseif type == 5 then
        mStr = "总属性点"

        if (curInfo == nil or curInfo:GetAttributeShow() == nil) and (nextInfo == nil or nextInfo:GetAttributeShow() == nil) then
            return nil
        end

        if curInfo ~= nil and curInfo:GetAttributeShow() ~= nil then
            mCurMinValue = curInfo:GetAttributeShow()
        end

        if nextInfo ~= nil and nextInfo:GetAttributeShow() ~= nil then
            mNextMinValue = nextInfo:GetAttributeShow()
        end
    elseif type == 6 then
        mStr = "封号天赋丹上限"

        if curInfo ~= nil and curInfo:GetAttributeItemShow() ~= nil then
            mCurMinValue = curInfo:GetAttributeItemShow()
        end

        if nextInfo ~= nil and nextInfo:GetAttributeItemShow() ~= nil then
            mNextMinValue = nextInfo:GetAttributeItemShow()
        end
    end

    local mIsUp = (mCurMinValue ~= nil and mNextMinValue ~= nil) and mNextMinValue > mCurMinValue or
            (mCurMaxValue ~= nil and mNextMaxValue ~= nil) and mCurMaxValue > mNextMaxValue or false

    ---@class sealMarkAttribute
    local sealMarkAttribute = {
        str = mStr,
        curMinValue = mCurMinValue,
        curMaxValue = mCurMaxValue,
        nextMinValue = mNextMinValue,
        nextMaxValue = mNextMaxValue,
        isUp = mIsUp
    }
    return sealMarkAttribute
end

---对应不同的角色类型设置参数
---@param
function UIMilitaryRankTitlePanel.GetRoleSealMarkGrow(param)
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

---@param l sealMarkAttribute
---@param r sealMarkAttribute
function UIMilitaryRankTitlePanel.SortAttributeTbl(l, r)
    local a, b = 0, 0
    if l.isUp then
        a = 1
    end
    if r.isUp then
        b = 1
    end
    return a > b
end

--endregion

--region ondestroy

function ondestroy()
    local panel = uimanager:GetPanel("UIMilitaryRankTitleFlairPanel");
    if (panel ~= nil) then
        uimanager:ClosePanel("UIMilitaryRankTitleFlairPanel")
    end
end

--endregion

return UIMilitaryRankTitlePanel