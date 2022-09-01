---@class UIMrTarotPanel:UIBase 塔罗先生
local UIMrTarotPanel = {}

--region 局部变量

--endregion

--region 初始化

function UIMrTarotPanel:Init()
    self:InitComponents()
    UIMrTarotPanel.InitParameters()
    UIMrTarotPanel.BindUIEvents()
    UIMrTarotPanel.BindNetMessage()
    UIMrTarotPanel.InitUI()
    UIMrTarotPanel.InitMessage()
end

--- 初始化变量
function UIMrTarotPanel.InitParameters()
    UIMrTarotPanel.remainCount = 0
    UIMrTarotPanel.des = "[878787]剩余免费%s次[-]"
    ---是否加入过商会
    UIMrTarotPanel.isJoinedCommerce = CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.MonthCardInfo:IsJoinedCommerce() == true
    UIMrTarotPanel.needItemId = CS.Cfg_GlobalTableManager.Instance.TarotNeedItemId
    UIMrTarotPanel.needItemCount = CS.Cfg_GlobalTableManager.Instance.TarotNeedItemCount
end

--- 初始化组件
function UIMrTarotPanel:InitComponents()
    ---商会会员名称
    UIMrTarotPanel.commerceName = self:GetCurComp("WidgetRoot/panel/name", "GameObject")
    ---主角名称
    UIMrTarotPanel.name = self:GetCurComp("WidgetRoot/panel/name/name", "UILabel")
    ---剩余次数
    UIMrTarotPanel.FreeNum = self:GetCurComp("WidgetRoot/panel/FreeNum", "UILabel")
    ---入会描述
    UIMrTarotPanel.FreeEnter = self:GetCurComp("WidgetRoot/panel/FreeEnter", "GameObject")
    ---产出列表
    UIMrTarotPanel.rewards = self:GetCurComp("WidgetRoot/panel/rewards", "Top_UIGridContainer")
    ---入会按钮
    UIMrTarotPanel.btn_join = self:GetCurComp("WidgetRoot/panel/FreeEnter/btn_join", "GameObject")
    ---塔罗神庙按钮
    UIMrTarotPanel.btn_left = self:GetCurComp("WidgetRoot/events/btn_left", "GameObject")
    ---塔罗神庙按钮
    UIMrTarotPanel.btn_center = self:GetCurComp("WidgetRoot/events/btn_center", "GameObject")
    ---塔罗牌按钮
    UIMrTarotPanel.btn_right = self:GetCurComp("WidgetRoot/events/btn_right", "GameObject")
    ---关闭按钮
    UIMrTarotPanel.btn_close = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    ---主角名称
    UIMrTarotPanel.name = self:GetCurComp("WidgetRoot/panel/name/name", "UILabel")
    ---消耗数量
    UIMrTarotPanel.costItemCount = self:GetCurComp("WidgetRoot/panel/costitem", "UILabel")
    ---消耗icon
    UIMrTarotPanel.costItemIcon = self:GetCurComp("WidgetRoot/panel/costitem/Sprite", "UISprite")
    ---公告面板
    UIMrTarotPanel.AnnouncePanel = self:GetCurComp("WidgetRoot/panel/ScrollView/gird", "MrTarotLogLoopScrollView")
    ---公告底板
    UIMrTarotPanel.announce_bg = self:GetCurComp("WidgetRoot/panel/announce_bg", "GameObject")
    ---进入条件描述内容
    UIMrTarotPanel.EnterConditionDes = self:GetCurComp("WidgetRoot/panel/eventcost/OtherDesc","UILabel")
    ---进入条件增加按钮
    UIMrTarotPanel.EnterConditionAddBtn = self:GetCurComp("WidgetRoot/panel/eventcost/btn_add","GameObject")
    ---描述的内容
    UIMrTarotPanel.Content_UILabel = self:GetCurComp("WidgetRoot/panel/content","GameObject")
end

function UIMrTarotPanel.InitMessage()
    networkRequest.ReqReinNum(CS.Cfg_GlobalTableManager.Instance.TreasureReinLevelList)
    if not UIMrTarotPanel.isJoinedCommerce then
        --请求剩余次数
        networkRequest.ReqCommon(luaEnumReqServerCommonType.HUNT_MONSTER_MAP_NO_SPEND_COUNT)
    else
        UIMrTarotPanel.InitUI()
    end
    networkRequest.ReqHuntAnnounce()
end

function UIMrTarotPanel.BindUIEvents()
    --点击塔罗牌事件
    CS.UIEventListener.Get(UIMrTarotPanel.btn_right).onClick = UIMrTarotPanel.OnOpenTarot
    --点击塔罗神庙事件
    CS.UIEventListener.Get(UIMrTarotPanel.btn_left).onClick = UIMrTarotPanel.OnOpenTarotTemple
    --点击塔罗神庙事件
    CS.UIEventListener.Get(UIMrTarotPanel.btn_center).onClick = UIMrTarotPanel.OnOpenTarotTemple
    --点击关闭事件
    CS.UIEventListener.Get(UIMrTarotPanel.btn_close).onClick = UIMrTarotPanel.OnClickCloseBtn
    --点击入会事件
    CS.UIEventListener.Get(UIMrTarotPanel.btn_join).onClick = UIMrTarotPanel.OnClickJoinBtn
    --进入条件增加按钮点击事件
    CS.UIEventListener.Get(UIMrTarotPanel.EnterConditionAddBtn).onClick = UIMrTarotPanel.OnClickEnterConditionAddBtn
end

function UIMrTarotPanel.BindNetMessage()
    UIMrTarotPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, UIMrTarotPanel.OnCommentMessage)
    UIMrTarotPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResReinNumMessage, UIMrTarotPanel.OnResReinNumMessage)
    UIMrTarotPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResHuntAnnounceMessage, UIMrTarotPanel.OnResHuntAnnounce)
    UIMrTarotPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResHuntAnnounceUpdateMessage, UIMrTarotPanel.OnResChatMessageMessageReceived)
end
--endregion

--region 函数监听

--点击塔罗牌事件
---@param go UnityEngine.GameObject
function UIMrTarotPanel.OnOpenTarot(go)
    uimanager:CreatePanel("UITreasurePanel")
    uimanager:ClosePanel("UIMrTarotPanel")
end

--点击塔罗神庙事件
---@param go UnityEngine.GameObject
function UIMrTarotPanel.OnOpenTarotTemple(go)
    --if UIMrTarotPanel.isJoinedCommerce ~= true then
    --    ---若没有商会身份,则弹出提示“请先加入商会”
    --    Utility.ShowPopoTips(go, "请先加入商会", 290, "UIActivityDuplicatePanel")
    --    return
    --end
    if UIMrTarotPanel.CheckOpenGodTemple() then
        networkRequest.ReqDeliverByConfig(130001)
        uimanager:ClosePanel("UIMrTarotPanel")
        uimanager:ClosePanel("UICommercePanel")
    else
        Utility.ShowItemGetWay(UIMrTarotPanel.needItemId, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(110, 0));
    end
end

--点击关闭事件
---@param go UnityEngine.GameObject
function UIMrTarotPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel("UIMrTarotPanel")
end

--点击入会事件
---@param go UnityEngine.GameObject
function UIMrTarotPanel.OnClickJoinBtn(go)
    uimanager:CreatePanel("UICommercePanel")
    uimanager:ClosePanel("UIMrTarotPanel")
end

--点击进入条件增加按钮
function UIMrTarotPanel.OnClickEnterConditionAddBtn(go)
    uimanager:CreatePanel("UICommercePanel")
    uimanager:ClosePanel("UIActivityDuplicatePanel")
end
--endregion


--region 网络消息处理
---刷新公告
---@param tableData chatV2.ResHuntAnnounceHistory
function UIMrTarotPanel.OnResHuntAnnounce(id, tableData, csData)
    if (csData.info.Count == 0) then
        if (UIMrTarotPanel.rewards ~= nil and UIMrTarotPanel.rewards.gameObject ~= nil) then
            UIMrTarotPanel.rewards.gameObject:SetActive(true)
        end
        UIMrTarotPanel.announce_bg:SetActive(false)
        return
    else
        if (UIMrTarotPanel.rewards ~= nil and UIMrTarotPanel.rewards.gameObject ~= nil) then
            --UIMrTarotPanel.rewards.gameObject:SetActive(false)
        end
        UIMrTarotPanel.announce_bg:SetActive(true)

        if (UIMrTarotPanel.AnnouncePanel ~= nil) then
            UIMrTarotPanel.AnnouncePanel:Init(csData)
        end
    end
end

--region 日志
---收到聊天消息
---@param csData chatV2.ResHuntAnnounceUpdate
function UIMrTarotPanel.OnResChatMessageMessageReceived(msgID, tblData, csData)
    if not CS.StaticUtility.IsNull(UIMrTarotPanel.AnnouncePanel) then
        UIMrTarotPanel.AnnouncePanel:AddChatMessage(csData)
    end
end

---全服转生数据
function UIMrTarotPanel.OnResReinNumMessage(id, tableData, csData)
    UIMrTarotPanel.InitRewrads(csData)
end

function UIMrTarotPanel.OnCommentMessage(id, tableData)
    if tableData and tableData.type == luaEnumRspServerCommonType.HUNT_MONSTER_MAP_NO_SPEND_COUNT then
        UIMrTarotPanel.remainCount = tableData.data
        UIMrTarotPanel.InitUI()
    end
end

--endregion

--region UI

function UIMrTarotPanel.InitUI()
    UIMrTarotPanel.name.text = CS.CSScene.MainPlayerInfo.Name

    --商会会员
    UIMrTarotPanel.commerceName:SetActive(UIMrTarotPanel.isJoinedCommerce)

    --入会描述
    UIMrTarotPanel.FreeEnter:SetActive(not UIMrTarotPanel.isJoinedCommerce)

    --剩余免费次数
    --local color = UIMrTarotPanel.remainCount > 0 and luaEnumColorType.Green or luaEnumColorType.Red
    UIMrTarotPanel.FreeNum.text = string.format(UIMrTarotPanel.des, luaEnumColorType.Green .. UIMrTarotPanel.remainCount .. '[-]')
    UIMrTarotPanel.FreeNum.gameObject:SetActive(UIMrTarotPanel.remainCount > 0)

    --道具消耗
    UIMrTarotPanel.costItemCount.text = tostring(UIMrTarotPanel.needItemCount)
    local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(UIMrTarotPanel.needItemId)
    if isFind then
        UIMrTarotPanel.costItemIcon.spriteName = itemInfo.icon
    end

    UIMrTarotPanel.InitBtnState()
    UIMrTarotPanel:RefreshEnterCondition()
    --UIMrTarotPanel:RefreshContent()
end

function UIMrTarotPanel.InitRewrads(data)
    local list = CS.Cfg_Treasure_MapTableManager.Instance:GteAwardsShowList(data)
    local index = 0
    for i = 0, list.Count - 1 do
        index = index + 1
        UIMrTarotPanel.rewards.MaxCount = index
        local go = UIMrTarotPanel.rewards.controlList[i]
        if go ~= nil and not CS.StaticUtility.IsNull(go) then
            local isFind, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(list[i].itemID)
            if isFind then
                local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                temp:RefreshUIWithItemInfo(iteminfo)
                CS.UIEventListener.Get(go.gameObject).onClick = function(go)
                    if temp.ItemInfo ~= nil then
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = temp.ItemInfo })
                    end
                end
            else
                go.gameObject:SetActive(false)
            end
        end
        if index == 5 then
            return
        end
    end
end

function UIMrTarotPanel.InitBtnState()
    --是否开启神庙
    local isOpenGodTemple = CS.Cfg_NoticeTableManager.Instance:GetAscriptionState(35)
    --是否开启塔罗牌
    local isOpenTarot = CS.Cfg_NoticeTableManager.Instance:GetAscriptionState(27)

    --UIMrTarotPanel.btn_left:SetActive(isOpenTarot and UIMrTarotPanel.isJoinedCommerce and isOpenGodTemple)
    --UIMrTarotPanel.btn_center:SetActive(isOpenGodTemple and not isOpenTarot)
    --UIMrTarotPanel.btn_right:SetActive(isOpenTarot and UIMrTarotPanel.isJoinedCommerce and isOpenGodTemple)

    UIMrTarotPanel.costItemCount.gameObject:SetActive(not UIMrTarotPanel.isJoinedCommerce and UIMrTarotPanel.remainCount == 0 and isOpenGodTemple and not isOpenTarot)
end

---刷新进入条件
function UIMrTarotPanel:RefreshEnterCondition()
    local enterConditionDes = ternary(self.isJoinedCommerce == true,luaEnumColorType.Green .. "塔罗神庙",luaEnumColorType.Red .. "塔罗神庙[-][878787](商会会员专属)")
    if CS.StaticUtility.IsNull(self.EnterConditionDes) == false then
        self.EnterConditionDes.text = enterConditionDes
    end
    if CS.StaticUtility.IsNull(self.EnterConditionAddBtn) == false then
        self.EnterConditionAddBtn:SetActive(self.isJoinedCommerce == false)
    end
end

---刷新描述内容
function UIMrTarotPanel:RefreshContent()
    local contentOffset = ternary(self.isJoinedCommerce == true,0,20)
    if CS.StaticUtility.IsNull(self.Content_UILabel) == false then
        self.Content_UILabel.transform.localPosition = self.Content_UILabel.transform.localPosition + CS.UnityEngine.Vector3.up * contentOffset
    end
end
--endregion

--region otherFunction

---判断是否能够进入神庙
---@public
function UIMrTarotPanel.CheckOpenGodTemple()
    if UIMrTarotPanel.remainCount > 0 then
        return true
    elseif UIMrTarotPanel.isJoinedCommerce then
        return true
    else
        local count = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(UIMrTarotPanel.needItemId)
        return count >= UIMrTarotPanel.needItemCount
    end
end

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResHuntAnnounceUpdateMessage, UIMrTarotPanel.OnResChatMessageMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResHuntAnnounceMessage, UIMrTarotPanel.OnResHuntAnnounce)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResReinNumMessage, UIMrTarotPanel.OnResReinNumMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResCommonMessage, UIMrTarotPanel.OnCommentMessage)
end

--endregion

return UIMrTarotPanel