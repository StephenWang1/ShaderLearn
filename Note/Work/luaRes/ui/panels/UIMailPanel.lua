---邮件面板
local UIMailPanel = {}

--region 局部变量
UIMailPanel.GetFalg_Bool = false
UIMailPanel.mCurMailInfo_MailInfo = nil
UIMailPanel.mCurMailInfo_GameObject = nil
UIMailPanel.newInfos = nil
UIMailPanel.Infos = nil
UIMailPanel.ExtractEffect = nil
UIMailPanel.ExtractEffectPath = ""
UIMailPanel.UIMainChatPanel = nil
UIMailPanel.GridToItemDic = {}
UIMailPanel.pattern_const = "\\[item:(\\d+)\\]"
UIMailPanel.StayCurMail = false
UIMailPanel.ItemList = {}
--endregion

--region 组件
---@type GameObject
function UIMailPanel.GetBottomView_GameObject()
    if (UIMailPanel.mBottomView == nil) then
        UIMailPanel.mBottomView = UIMailPanel:GetCurComp("view/UISocialPanel/Bottom/rightshadow", "GameObject")
    end
    return UIMailPanel.mBottomView
end

function UIMailPanel.Getnomore_GameObject()
    if (UIMailPanel.nomoreGO == nil) then
        UIMailPanel.nomoreGO = UIMailPanel:GetCurComp("view/nomore", "GameObject")
    end
    return UIMailPanel.nomoreGO
end

function UIMailPanel.GetMailAppendix_GameObject()
    if (UIMailPanel.mailAppendix == nil) then
        UIMailPanel.mailAppendix = UIMailPanel:GetCurComp("AwardList/maintext", "GameObject")
    end
    return UIMailPanel.mailAppendix
end

function UIMailPanel.GetContentScrollView_UIScrollView()
    if (UIMailPanel.mContentScrollView == nil) then
        UIMailPanel.mContentScrollView = UIMailPanel:GetCurComp("ContentScrollView", "UIScrollView")
    end
    return UIMailPanel.mContentScrollView
end

function UIMailPanel.GetMailScrollView_UIScrollView()
    if (UIMailPanel.mailScrollView == nil) then
        UIMailPanel.mailScrollView = UIMailPanel:GetCurComp("Scroll View", "UIScrollView")
    end
    return UIMailPanel.mailScrollView
end

function UIMailPanel.GetContentPanel_UIPanel()
    if (UIMailPanel.contentPanel == nil) then
        UIMailPanel.contentPanel = UIMailPanel:GetCurComp("ContentScrollView", "UIPanel")
    end
    return UIMailPanel.contentPanel
end

function UIMailPanel.GetMailNum_UILabel()
    if (UIMailPanel.mMailNum == nil) then
        UIMailPanel.mMailNum = UIMailPanel:GetCurComp("view/num", "UILabel")
    end
    return UIMailPanel.mMailNum
end

function UIMailPanel.GetMailGridContainer_UIGridContainer()
    if (UIMailPanel.mMailGridContainer == nil) then
        UIMailPanel.mMailGridContainer = UIMailPanel:GetCurComp("Scroll View/maillist", "UIGridContainer")
    end
    return UIMailPanel.mMailGridContainer
end

function UIMailPanel.GetAwardGridContainer_UIGridContainer()
    if (UIMailPanel.mAwardGridContainer == nil) then
        UIMailPanel.mAwardGridContainer = UIMailPanel:GetCurComp("AwardList/ScrollView/award", "UIGridContainer")
    end
    return UIMailPanel.mAwardGridContainer
end

function UIMailPanel.GetMailName_UILabel()
    if (UIMailPanel.mMailName == nil) then
        UIMailPanel.mMailName = UIMailPanel:GetCurComp("view/name", "UILabel")
    end
    return UIMailPanel.mMailName
end

function UIMailPanel.GetMailTimer_UILabel()
    if (UIMailPanel.mMailTimer == nil) then
        UIMailPanel.mMailTimer = UIMailPanel:GetCurComp("view/timer", "UILabel")
    end
    return UIMailPanel.mMailTimer
end

function UIMailPanel.GetMailTheme_UILabel()
    if (UIMailPanel.mMailTheme == nil) then
        UIMailPanel.mMailTheme = UIMailPanel:GetCurComp("view/theme", "UILabel")
    end
    return UIMailPanel.mMailTheme
end

function UIMailPanel.GetMailContent_UILabel()
    if (UIMailPanel.mMailContent == nil) then
        UIMailPanel.mMailContent = UIMailPanel:GetCurComp("view/content", "UILabel")
    end
    return UIMailPanel.mMailContent
end

function UIMailPanel.GetPullDown_GameObject()
    UIMailPanel.mPullDown = nil
    if (UIMailPanel.mPullDown == nil) then
        UIMailPanel.mPullDown = UIMailPanel:GetCurComp("AwardList/pulldown", "GameObject")
    end
    return UIMailPanel.mPullDown
end

function UIMailPanel.GetExtractEffect_GameObject()
    if (UIMailPanel.mExtractEffect == nil) then
        UIMailPanel.mExtractEffect = UIMailPanel:GetCurComp("events/btn_extract/Effect", "GameObject")
    end
    return UIMailPanel.mExtractEffect
end

function UIMailPanel.GetAllextractEffect_GameObject()
    if (UIMailPanel.mAllextractEffect == nil) then
        UIMailPanel.mAllextractEffect = UIMailPanel:GetCurComp("events/btn_allextract/Effect", "GameObject")
    end
    return UIMailPanel.mAllextractEffect
end

function UIMailPanel.GetMailList_UIGridContainer()
    if (UIMailPanel.mMailList == nil) then
        UIMailPanel.mMailList = UIMailPanel:GetCurComp("Scroll View/maillist", "UIGridContainer")
    end
    return UIMailPanel.mMailList
end

function UIMailPanel:GetDeleteBtn_GameObject()
    if (UIMailPanel.mDeleteBtn == nil) then
        UIMailPanel.mDeleteBtn = UIMailPanel:GetCurComp("events/btn_delete", "GameObject")
    end
    return UIMailPanel.mDeleteBtn
end

function UIMailPanel:GetExtractBtn_GameObject()
    if (UIMailPanel.mExtractBtn == nil) then
        UIMailPanel.mExtractBtn = UIMailPanel:GetCurComp("events/btn_extract", "GameObject")
    end
    return UIMailPanel.mExtractBtn
end

function UIMailPanel:GetAllExtractBtn_GameObject()
    if (UIMailPanel.mAllExtractBtn == nil) then
        UIMailPanel.mAllExtractBtn = UIMailPanel:GetCurComp("events/btn_allextract", "GameObject")
    end
    return UIMailPanel.mAllExtractBtn
end

--endregion

--region 初始化
function UIMailPanel:Init()
    self:RunBaseFunction("Init")
    UIMailPanel.BindUIEvents()
    UIMailPanel.BindMessage()
    ---@type UIMainChatPanel
    UIMailPanel.UIMainChatPanel = uimanager:GetPanel("UIMainChatPanel")
    if (UIMailPanel.UIMainChatPanel ~= nil) then
        UIMailPanel.UIMainChatPanel.mCurChoosePanel = LuaEnumSocialPanelType.MailPanel
        UIMailPanel.UIMainChatPanel.SocialBtnCanClick = false
        UIMailPanel.UIMainChatPanel.UIOpenIsShow()
    end

    --UIMailPanel.LoadeEffect("700074", UIMailPanel.ExtractEffect, UIMailPanel.GetExtractEffect_GameObject().transform, function(path, obj)
    --    UIMailPanel.ExtractEffect = obj
    --    UIMailPanel.ExtractEffectPath = path
    --end)
end

function UIMailPanel:Show()
    self:RunBaseFunction("Show")
    UIMailPanel.newInfos = nil
    UIMailPanel.ResetMailInfo()
    networkRequest.ReqGetMailList()
end

function UIMailPanel.BindMessage()
    --UIMailPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ClickURLAction, UIMailPanel.InfoOnClick)
    UIMailPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResMailListMessage, UIMailPanel.OnReceiveResMailListMessage)
    --UIMailPanel:GetSocketEventHandler():AddEvent(LuaEnumNetDef.ResMailListMessage, UIMailPanel.OnReceiveResMailListMessage)

    UIMailPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UIMailPanel.OnResBagChangeMessageReceivedEvent)
    UIMailPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDeleteMailMessage, UIMailPanel.OnReceiveResDeleteMailMessage)
    UIMailPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGetMailItemMessage, UIMailPanel.OnReceiveResGetMailItemMessage)
end

function UIMailPanel.BindUIEvents()
    UIMailPanel:AddClickEvent("events/btn_alldelete", UIMailPanel.OnDeleteAllMainClick)
    UIMailPanel:AddClickEvent("events/tg_close", UIMailPanel.OnCloseBtnClick)
    CS.UIEventListener.Get(UIMailPanel:GetDeleteBtn_GameObject()).onClick = UIMailPanel.OnDeleteClick
    CS.UIEventListener.Get(UIMailPanel:GetExtractBtn_GameObject()).onClick = UIMailPanel.OnExtractMailClick
    CS.UIEventListener.Get(UIMailPanel:GetAllExtractBtn_GameObject()).onClick = UIMailPanel.OnExtractAllMailClick

end
--endregion

--region 服务器消息处理
---刷新面板UI 默认flag=false
function UIMailPanel.RefreshUI(flag_bool)
    UIMailPanel.GetExtractEffect_GameObject():SetActive(false)
    UIMailPanel.GetAllextractEffect_GameObject():SetActive(false)
    UIMailPanel.Infos = CS.CSMailInfo.Instance.Lua_MailInfos

    if (UIMailPanel.Infos == nil) then
        return
    end
    UIMailPanel.RefreshMailTempList()
    UIMailPanel.MailSort()

    UIMailPanel.GetMailGridContainer_UIGridContainer().MaxCount = UIMailPanel.Infos.Count

    if (UIMailPanel.GetMailGridContainer_UIGridContainer().MaxCount > 0) then
        local goes = UIMailPanel.GetMailGridContainer_UIGridContainer().controlList[0]
        local info = CS.Utility_Lua.GetComponent(goes, "UIEventListener").parameter
        CS.Utility_Lua.GetComponent(UIMailPanel.GetMailGridContainer_UIGridContainer().controlList[0], "UIToggle").value = true
        UIMailPanel.RefreshMainTempInfo(goes)
        if (UIMailPanel.StayCurMail) then
            UIMailPanel.GetBottomView_GameObject():SetActive(true)
            UIMailPanel.Getnomore_GameObject():SetActive(false)
            UIMailPanel.StayCurMail = false
        else
            --UIMailPanel.GetMailGridContainer_UIGridContainer().controlList[0].transform:Find("background").gameObject:SetActive(false)
        end
    else
        UIMailPanel.ResetMailInfo()
    end
    UIMailPanel.RefreshUIPanel()
end

---刷新主要邮件信息
function UIMailPanel.RefreshMainTempInfo(goes)
    if (goes == nil) then
        return
    end
    UIMailPanel.GetBottomView_GameObject():SetActive(true)
    UIMailPanel.Getnomore_GameObject():SetActive(false)
    local conlist = UIMailPanel.GetMailGridContainer_UIGridContainer().controlList
    local length = conlist.Count - 1
    for k = 0, length do
        conlist[k].transform:Find("background").gameObject:SetActive(false)
    end
    goes.transform:Find("background").gameObject:SetActive(true)

    UIMailPanel.mCurMailInfo_GameObject = goes
    local info = CS.Utility_Lua.GetComponent(goes, "UIEventListener").parameter
    local mailIds = CS.System.Collections.Generic["List`1[System.Int64]"]()
    mailIds:Add(info.mailId)
    if (info == nil) then
        return
    end
    if (info.state == 0) then
        --未读邮件
        networkRequest.ReqReadMail(mailIds)
        CS.CSMailInfo.Instance:Lua_SetMailInfoState(math.ceil(info.mailId), 1)
        UIMailPanel.RefreshMailTempList()
        UIMailPanel.ChangeMainMailUI(goes, info)
    end
    UIMailPanel.mCurMailInfo_MailInfo = info
    UIMailPanel.GetMailName_UILabel().text = "[878787]发件人 [dde6eb]" .. tostring(info.from)
    UIMailPanel.GetMailTheme_UILabel().text = "[dde6eb]" .. tostring(info.title)
    UIMailPanel.GetMailTimer_UILabel().text = "[878787]" .. CS.Utility_Lua.GetAccurateTime(info.sendTime)
    local content = info.content
    if (CS.System.String.IsNullOrEmpty(content) == false) then
        local matchs = CS.System.Text.RegularExpressions.Regex.Matches(content, UIMailPanel.pattern_const)
        content = string.gsub(content, '\\n', '\n')

        UIMailPanel.GetMailContent_UILabel().text = content
    else
        UIMailPanel.GetMailContent_UILabel().text = ""
    end
    if (UIMailPanel.GetAwardGridContainer_UIGridContainer() == nil) then
        return
    end

    if (CS.System.String.IsNullOrEmpty(info.items)) then
        --如果没有奖励物品
        UIMailPanel.ItemList = {}
        UIMailPanel.GetDeleteBtn_GameObject():SetActive(true)
        UIMailPanel.GetExtractBtn_GameObject():SetActive(false)
        UIMailPanel.GetAwardGridContainer_UIGridContainer().MaxCount = 0
        UIMailPanel.GetAwardGridContainer_UIGridContainer().gameObject:SetActive(false)
        if (UIMailPanel.GetExtractEffect_GameObject().activeSelf) then
            UIMailPanel.GetExtractEffect_GameObject():SetActive(false)
        end
        --如果没有邮件物品，则将显示内容框放大
        UIMailPanel.GetContentPanel_UIPanel():SetRect(0, -90, 385, 350)
    else
        --有奖励物品
        --如果有邮件物品，将内容框还原
        UIMailPanel.GetContentPanel_UIPanel():SetRect(0, -2, 385, 180)

        if (info.state == 2) then
            --如果已经领取附件
            UIMailPanel.ItemList = {}
            UIMailPanel.GetExtractBtn_GameObject():SetActive(false)
            UIMailPanel.GetAwardGridContainer_UIGridContainer().gameObject:SetActive(false)
            UIMailPanel.GetExtractEffect_GameObject():SetActive(false)
            UIMailPanel.GetDeleteBtn_GameObject():SetActive(true)
        else
            UIMailPanel.GetDeleteBtn_GameObject():SetActive(false)
            UIMailPanel.GetExtractBtn_GameObject():SetActive(true)
            if (UIMailPanel.GetAwardGridContainer_UIGridContainer().gameObject.activeSelf == false) then
                UIMailPanel.GetAwardGridContainer_UIGridContainer().gameObject:SetActive(true)
            end
            local itemlist = info.items:Split(';')
            UIMailPanel.ItemList = itemlist
            local count = #itemlist
            UIMailPanel.GetAwardGridContainer_UIGridContainer().MaxCount = count

            local pos = UIMailPanel.GetAwardGridContainer_UIGridContainer().gameObject.transform.localPosition
            pos.y = count > 6 and 43 or -38
            UIMailPanel.GetAwardGridContainer_UIGridContainer().gameObject.transform.localPosition = pos
            for i = 0, count - 1 do
                local bagItemInfo = CS.Utility_Lua.ReverseItemInfo(tostring(itemlist[i + 1]))
                local iteminfo = nil
                if bagItemInfo ~= nil then
                    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
                    if itemInfoIsFind then
                        iteminfo = itemInfo
                    end
                    if (UIMailPanel.GridToItemDic[UIMailPanel.GetAwardGridContainer_UIGridContainer().controlList[i]] == nil) then
                        UIMailPanel.GridToItemDic[UIMailPanel.GetAwardGridContainer_UIGridContainer().controlList[i]] = templatemanager.GetNewTemplate(
                                UIMailPanel.GetAwardGridContainer_UIGridContainer().controlList[i], luaComponentTemplates.UIGridItem)
                    end
                    UIMailPanel.GridToItemDic[UIMailPanel.GetAwardGridContainer_UIGridContainer().controlList[i]]:RefreshUIWithItemInfo(iteminfo, bagItemInfo.count)
                    UIMailPanel.GridToItemDic[UIMailPanel.GetAwardGridContainer_UIGridContainer().controlList[i]].bagItemInfo = bagItemInfo
                    CS.UIEventListener.Get(UIMailPanel.GetAwardGridContainer_UIGridContainer().controlList[i].gameObject).onClick = UIMailPanel.OnCheckItemClicked
                else
                    UIMailPanel.GetAwardGridContainer_UIGridContainer().MaxCount = 0
                end
            end

            if (#itemlist > 0) then
                --如果邮件没有领取并且有物品，显示特效
                UIMailPanel.GetExtractEffect_GameObject():SetActive(true);
            else
                UIMailPanel.GetExtractEffect_GameObject():SetActive(false)
            end
        end
    end
    UIMailPanel.GetContentScrollView_UIScrollView():ResetPosition()

    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeRead)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeReadOrReceive)
end

---刷新显示邮件数量
function UIMailPanel.RefreshMailTempList()
    UIMailPanel.GetMailNum_UILabel().text = "邮件数量:" .. tostring(CS.CSMailInfo.Instance:Lua_GetReadMainCount()) .. "/" .. tostring(UIMailPanel.Infos.Count)
    if (UIMailPanel.Infos == nil) then
        return
    end
    UIMailPanel.GetMailGridContainer_UIGridContainer().MaxCount = UIMailPanel.Infos.Count
end

--region 邮件排序
function UIMailPanel.MailSort()
    CS.CSMailInfo.Instance:SortMailByState(function(a, b)
        if (a.state == b.state) then
            if (a.state == 1) then
                if (CS.System.String.IsNullOrEmpty(a.items)) then
                    return 1
                else
                    if (a.sendTime > b.sendTime) then
                        return -1
                    elseif (a.sendTime == b.sendTime) then
                        return 0
                    else
                        return 1
                    end
                end
            else
                if (a.sendTime > b.sendTime) then
                    return -1
                elseif (a.sendTime == b.sendTime) then
                    return 0
                else
                    return 1
                end
            end
        else
            if (a.state > b.state) then
                return 1
            else
                return -1
            end
        end
    end)
    for i = 1, UIMailPanel.GetMailGridContainer_UIGridContainer().MaxCount do
        local info = UIMailPanel.Infos[i - 1]
        local gos = UIMailPanel.GetMailGridContainer_UIGridContainer().controlList[i - 1]
        UIMailPanel.ChangeMainMailUI(gos, info)
    end
    if (UIMailPanel.GetMailGridContainer_UIGridContainer().MaxCount < 7) then
        UIMailPanel.GetMailScrollView_UIScrollView():ResetPosition()
    end
end
--endregion

function UIMailPanel.ChangeMainMailUI(gos, info)
    local icon = CS.Utility_Lua.Get(gos.transform, "icon", "UISprite")
    local awards = CS.Utility_Lua.Get(gos.transform, "awards", "UISprite")
    local title = CS.Utility_Lua.Get(gos.transform, "title", "UILabel")
    local name = CS.Utility_Lua.Get(gos.transform, "name", "UILabel")
    local time = CS.Utility_Lua.Get(gos.transform, "time", "UILabel")

    if (info.state == 0) then
        icon.spriteName = "mail1"
        if (not CS.System.String.IsNullOrEmpty(info.items)) then
            icon.spriteName = "fujian2"
        end
    elseif (info.state == 1) then
        if (not CS.System.String.IsNullOrEmpty(info.items)) then
            icon.spriteName = "fujian1_1"
        else
            icon.spriteName = "mail2"
        end
    elseif (info.state == 2) then
        icon.spriteName = "mail2"
        --elseif (info.state == 3) then
        --    icon.spriteName = "mail2"
    end

    local dateTime = CS.CSServerTime.StampToDateTimeForSecondToString("yyyy-MM-dd", info.sendTime)
    time.text = "[c9b39c]" .. dateTime

    icon:MakePixelPerfect()
    title.text = info.title
    name.text = info.from
    title.color = ternary(info.state == 0, CS.UnityEngine.Color.white, CS.UnityEngine.Color.gray)
    name.color = ternary(info.state == 0, CS.UnityEngine.Color.white, CS.UnityEngine.Color.gray)
    CS.UIEventListener.Get(gos).parameter = info;
    CS.UIEventListener.Get(gos).onClick = UIMailPanel.RefreshMainTempInfo
end

---重置邮件信息
function UIMailPanel.ResetMailInfo()
    UIMailPanel.GetBottomView_GameObject():SetActive(false)
    UIMailPanel.Getnomore_GameObject():SetActive(true)
    UIMailPanel.GetDeleteBtn_GameObject():SetActive(false)
    UIMailPanel.GetExtractBtn_GameObject():SetActive(false)
    UIMailPanel.GetMailName_UILabel().text = ""
    UIMailPanel.GetMailTheme_UILabel().text = ""
    UIMailPanel.GetMailTimer_UILabel().text = ""
    UIMailPanel.GetMailContent_UILabel().text = ""

    UIMailPanel.GetAwardGridContainer_UIGridContainer().MaxCount = 0

    if (UIMailPanel.GetContentScrollView_UIScrollView() ~= nil) then
        UIMailPanel.GetContentScrollView_UIScrollView():ResetPosition()
    end

    for i = 0, UIMailPanel.GetAwardGridContainer_UIGridContainer().MaxCount - 1 do
        if (UIMailPanel.GetAwardGridContainer_UIGridContainer().controlList ~= nil and UIMailPanel.GetAwardGridContainer_UIGridContainer().controlList[i] ~= nil) then
            local uiitem = UIMailPanel.GridToItemDic[UIMailPanel.GetAwardGridContainer_UIGridContainer().controlList[i]]
            if (uiitem ~= nil) then
                uiitem:ResetUI()
            end
        end
    end
    UIMailPanel.GetAwardGridContainer_UIGridContainer().gameObject:SetActive(true)
end

---附件格子点击事件
function UIMailPanel.OnCheckItemClicked(go)
    if go ~= nil and CS.StaticUtility.IsNull(go) == false then
        local itemTemp = UIMailPanel.GridToItemDic[go]
        if itemTemp ~= nil and itemTemp.ItemInfo ~= nil then
            --打开物品信息界面
            UIMailPanel:ShowItemInfo(itemTemp.ItemInfo, itemTemp.bagItemInfo)
        end
    end
end

function UIMailPanel:ShowItemInfo(itemInfo, bagItemInfo)
    Utility.OpenItemInfoAndCheckMarryRing(bagItemInfo, CS.CSScene.MainPlayerInfo.ID)
end

---邮件列表响应
function UIMailPanel.OnReceiveResMailListMessage(id, data)
    if (data == nil) then
        return
    end
    UIMailPanel.RefreshUI()
end

---删除邮件响应
function UIMailPanel.OnReceiveResDeleteMailMessage(id, data, luadata)
    if (data.mailIds == nil) then
        return
    end
    CS.CSMailInfo.Instance:Lua_RemoveMainInfo(data.mailIds[1])
    if (UIMailPanel.Infos ~= nil and UIMailPanel.Infos:Contains(data.mailIds[1])) then
        UIMailPanel.Infos:Remove(data.mailIds[1])
    end
    UIMailPanel.RefreshUI()
    UIMailPanel.GetMailScrollView_UIScrollView():ResetPosition()

    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeRead)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeReadOrReceive)
end

---提取物品响应
function UIMailPanel.OnReceiveResGetMailItemMessage(id, data, luadata)
    UIMailPanel.GetFalg_Bool = false
    local Count = Utility.GetLuaTableCount(data.mailIds)
    if (Count > 1) then
        for k = 1, Count do
            if (data.mailIds ~= nil) then
                CS.CSMailInfo.Instance:Lua_SetMailInfoState(data.mailIds[k], 2)
            end
        end
    else
        if (data.mailIds ~= nil) then
            CS.CSMailInfo.Instance:Lua_SetMailInfoState(data.mailIds[1], 2)
        end
    end

    UIMailPanel.RefreshUI(true)

    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeRead)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeReadOrReceive)
end

function UIMailPanel.OnResBagChangeMessageReceivedEvent(id, data, luadata)
    if (data.action == 20005) then
        local count = Utility.GetLuaTableCount(UIMailPanel.ItemList)
        if (UIMailPanel.UIMainChatPanel ~= nil) then
            local toPosition = UIMailPanel.UIMainChatPanel.bagPos.position;
            for i = 1, count do
                luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = UIMailPanel.ItemList[i]:Split('#')[1], from = UIMailPanel.GetAwardGridContainer_UIGridContainer().controlList[i - 1].transform.position, to = toPosition });
            end
        end
    end
end
--endregion

--region UI点击事件
---点击超链接
function UIMailPanel.InfoOnClick()
    --读取事件[url:]...[url/]
    local eventList = string.Split(tostring(UIMailPanel.GetMailContent_UILabel():GetUrlAtPosition(CS.UICamera.lastWorldPosition)), '|')

    local type = eventList[1]

    ---type为open表示打开面板，后续为参数
    ---type为deliver表示传送，暂时读表
    if (type == "event:open") then
        local parms = {}
        local count = Utility.GetLuaTableCount(eventList)
        if (count > 2) then
            if (eventList[2] == "UIGuildTipsPanel") then
                eventList[3] = tonumber(eventList[3])
                if (eventList[3] == CS.CSScene.Sington.MainPlayer.BaseInfo.ID) then
                    return
                end
                --eventList[5] = tonumber(eventList[5])
                uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                    panelType = #eventList > 4 and tonumber(eventList[5]) or 0,
                    roleId = #eventList > 2 and eventList[3] or 0,
                    roleName = #eventList > 3 and eventList[4] or "",
                    roleSex = Utility.GetLuaTableCount(eventList) > 5 and eventList[6] or nil,
                    roleCareer = Utility.GetLuaTableCount(eventList) > 6 and eventList[7] or nil,
                })
                return
            end
            for i = 3, Utility.GetLuaTableCount(eventList) do
                table.insert(parms, eventList[i])
            end
        end
    elseif (eventList[2] == "UIItemInfoPanel") then
        local item = nil
        local itemid = tonumber(eventList[4])
        if (CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemid)) then
            ___, item = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemid)
        end
        if (item ~= nil) then
            eventList[4] = item
        else
            eventList[4] = nil
        end
    elseif (eventList[2] == "UINavigationPanel") then
        if (luaEventManager.HasCallback(LuaCEvent.Navigation_OpenWithId)) then
            local customData = {};
            customData.targetId = eventList[3];
            luaEventManager.DoCallback(LuaCEvent.Navigation_OpenWithId, customData)
        end
        return
    elseif (type == "event:deliver") then
        networkRequest.ReqDeliverByConfig(tonumber(eventList[2]), false)
    end
end

---提取邮件附件
function UIMailPanel.OnExtractMailClick(go)
    if (UIMailPanel.mCurMailInfo_MailInfo == nil) then
        return
    end
    ---如果没有物品可领取
    if (UIMailPanel.mCurMailInfo_MailInfo.state == 2 or Utility.IsNilOrEmptyString(UIMailPanel.mCurMailInfo_MailInfo.items)) then
        UIMailPanel.ShowTips(go, 32)
        return
    end
    local idList = CS.System.Collections.Generic["List`1[System.Int64]"]()
    idList:Add(UIMailPanel.mCurMailInfo_MailInfo.mailId)
    networkRequest.ReqGetMailItem(idList)
    UIMailPanel.StayCurMail = true

    --local count = Utility.GetLuaTableCount(UIMailPanel.ItemList)
    --if (UIMailPanel.UIMainChatPanel ~= nil) then
    --    local toPosition = UIMailPanel.UIMainChatPanel.bagPos.position;
    --    for i = 1, count do
    --        luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = UIMailPanel.ItemList[i]:Split('#')[1], from = UIMailPanel.GetAwardGridContainer_UIGridContainer().controlList[i - 1].transform.position, to = toPosition });
    --    end
    --end
end

---提取所有附件
function UIMailPanel.OnExtractAllMailClick(go)
    local idList = CS.System.Collections.Generic["List`1[System.Int64]"]()
    local list = CS.CSMailInfo.Instance.Lua_MailInfos
    for k = 0, list.Count - 1 do
        if (list[k].state ~= 2 and not CS.System.String.IsNullOrEmpty(list[k].items)) then
            idList:Add(list[k].mailId)
        end
    end
    if (idList.Count == 0) then
        UIMailPanel.ShowTips(go, 32)
        return
    end
    networkRequest.ReqGetMailItem(idList)
end

---删除所有邮件
function UIMailPanel.OnDeleteAllMainClick()
    local mailList = CS.CSMailInfo.Instance.Lua_MailInfos
    local idList = CS.System.Collections.Generic["List`1[System.Int64]"]()
    for i = 0, mailList.Count - 1 do
        idList:Add(mailList[i].mailId)
    end
    networkRequest.ReqDeleteMail(idList)
end

---删除邮件
function UIMailPanel.OnDeleteClick(go)
    if (UIMailPanel.mCurMailInfo_MailInfo == nil) then
        return
    end
    if (not CS.System.String.IsNullOrEmpty(UIMailPanel.mCurMailInfo_MailInfo.items) and UIMailPanel.mCurMailInfo_MailInfo.state ~= 2) then
        UIMailPanel.ShowTips(go, 33)
        return
    end
    local idList = CS.System.Collections.Generic["List`1[System.Int64]"]()
    idList:Add(UIMailPanel.mCurMailInfo_MailInfo.mailId)
    networkRequest.ReqDeleteMail(idList)
    UIMailPanel.mCurMailInfo_MailInfo = nil
end

---关闭面板
function UIMailPanel.OnCloseBtnClick()
    uimanager:ClosePanel("UIMailPanel")
end
--endregion

--region 刷新界面
function UIMailPanel.RefreshUIPanel()
    local itemsCount = 0
    local items = nil
    for i = 0, UIMailPanel.Infos.Count - 1 do
        if (not CS.System.String.IsNullOrEmpty(UIMailPanel.Infos[i].items) and UIMailPanel.Infos[i].state ~= 2) then
            itemsCount = itemsCount + 1
            items = UIMailPanel.Infos[i]
        end
    end
    if (itemsCount >= 1) then
        UIMailPanel:GetAllExtractBtn_GameObject():SetActive(true)
        if (itemsCount == 1) then
            UIMailPanel:GetAllExtractBtn_GameObject():SetActive(false)
        end
    else
        UIMailPanel:GetAllExtractBtn_GameObject():SetActive(false)
    end
end
--endregion

--region Tips
function UIMailPanel.ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIMailPanel"
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion

--region 加载特效
function UIMailPanel.LoadeEffect(effectCode, obj, parent, callback)
    if obj ~= nil then
        obj.gameObject:SetActive(false)
        obj.gameObject:SetActive(true)
        return
    end

    CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectCode, CS.ResourceType.UIEffect, function(res)
        if res ~= nil or res.MirrorObj ~= nil then
            if parent == nil or CS.StaticUtility.IsNull(parent) then
                return
            end
            local obj = res:GetObjInst()
            if (obj ~= nil) then
                obj.transform.parent = parent
                obj.transform.localPosition = CS.UnityEngine.Vector3.zero
                obj.transform.localScale = CS.UnityEngine.Vector3(100, 100, 100)
                if callback ~= nil then
                    callback(res.Path, obj)
                end
            end
        end
    end, CS.ResourceAssistType.UI)
end
--endregion

--region 打开其他界面
function UIMailPanel.OpenItemInfoPanel(bagItemInfo)
    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItemInfo })
end

function ondestroy()
    if (UIMailPanel.UIMainChatPanel ~= nil) then
        if (not UIMailPanel.UIMainChatPanel.InnerClosePanel) then
            UIMailPanel.UIMainChatPanel.UIOpenIsHide()
            UIMailPanel.UIMainChatPanel.mCurShowPanelName = ""
        end
        UIMailPanel.UIMainChatPanel.InnerClosePanel = false
        UIMailPanel.UIMainChatPanel.SocialBtnCanClick = true
    end
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResMailListMessage, UIMailPanel.OnReceiveResMailListMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResDeleteMailMessage, UIMailPanel.OnReceiveResDeleteMailMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResGetMailItemMessage, UIMailPanel.OnReceiveResGetMailItemMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, UIMailPanel.OnResBagChangeMessageReceivedEvent)
end

--endregion

return UIMailPanel