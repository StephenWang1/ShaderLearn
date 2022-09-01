---@class UIShareRankPanel  联服排行榜面板
local UIShareRankPanel = {}

--region 局部变量

--储存主页签模板（目前不需要字典，为后续修改 取模板方便）
UIShareRankPanel.mainBookMarkTemplatesDic = {}
--储存子侧页签模板
UIShareRankPanel.bookMarkTemplatesDic = {}

--排行榜页签所有数据
UIShareRankPanel.RankBookMarkList = {}
UIShareRankPanel.length = 0
--视图类型
UIShareRankPanel.ViewType = 1

--当前子页签索引
UIShareRankPanel.curBookMarkIndex = 0
--当前页签索引
UIShareRankPanel.curMainBookMarkIndex = 0
--主角排行榜单元模板
UIShareRankPanel.myRankItemTemplat = nil

UIShareRankPanel.itemBgSize = 0

UIShareRankPanel.itemTemplateDic = {}

UIShareRankPanel.curRankTypeCfgId = nil

UIShareRankPanel.isInitOne = false

---当前自己排行榜id
UIShareRankPanel.curMainRankId = 0
---当前选中的模板
UIShareRankPanel.CurSelectTemplate = nil
---当前奖励领取状况
UIShareRankPanel.curReceiveState = true

UIShareRankPanel.isInitTop = true

UIShareRankPanel.ranktbl = nil

--endregion

--region 初始化

function UIShareRankPanel:Init()
    self:InitComponents()
    UIShareRankPanel.InitData()
    UIShareRankPanel.BindUIEvents()
    UIShareRankPanel.BindNetMessage()
    UIShareRankPanel.InitUI()
end

--- 初始化组件
function UIShareRankPanel:InitComponents()

    ---@type UnityEngine.GameObject 关闭按钮
    UIShareRankPanel.CloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    ---@type UnityEngine.GameObject
    UIShareRankPanel.background = self:GetCurComp("WidgetRoot/window/BaseWindow/background", "GameObject")
    ---@type Top_UIGridContainer   主页签
    UIShareRankPanel.MainBookMarkList = self:GetCurComp("WidgetRoot/events/Scroll View/MainBookMarkList", "Top_UIGridContainer")
    ---@type Top_UIGridContainer   左侧副页签
    UIShareRankPanel.BookMark = self:GetCurComp("WidgetRoot/BookMark", "Top_UIGridContainer")
    ---@type Top_UIGridContainer  榜顶
    UIShareRankPanel.rankTops = self:GetCurComp("WidgetRoot/Panel/background/rankTops", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject  帮助按钮
    UIShareRankPanel.btn_help = self:GetCurComp("WidgetRoot/Panel/background/btn_help", "GameObject")

    ---@type UnityEngine.GameObject
    UIShareRankPanel.RankView = self:GetCurComp("WidgetRoot/Panel/RankView", "GameObject")

    ---@type Top_UIScrollView
    UIShareRankPanel.rankScrollView = self:GetCurComp("WidgetRoot/Panel/RankView/Scroll View", "Top_UIScrollView")

    ---@type Top_LoopScrollView 列表
    UIShareRankPanel.rankMiddle = self:GetCurComp("WidgetRoot/Panel/RankView/Scroll View/firstRankMiddle", "UILoopScrollViewPlus")

    ---@type Top_SpringPanel 列表spring
    UIShareRankPanel.scrollViewSpring = self:GetCurComp("WidgetRoot/Panel/RankView/Scroll View", "Top_SpringPanel")

    ---@type UnityEngine.GameObject 自己排名标识
    UIShareRankPanel.myRankGo = self:GetCurComp("WidgetRoot/Panel/myRankGo", "GameObject")
    ---@type UnityEngine.GameObject 自己排名标识按钮
    UIShareRankPanel.btn_myrank = self:GetCurComp("WidgetRoot/Panel/myRankGo/btn_myrank", "GameObject")

    ---@type UnityEngine.GameObject 我方排行信息
    UIShareRankPanel.OurRankItem = self:GetCurComp("WidgetRoot/Panel/RankView/OurRankItem", "GameObject")

    ---@type UnityEngine.GameObject 奖励
    UIShareRankPanel.Reward = self:GetCurComp("WidgetRoot/Panel/Reward", "GameObject")
    UIShareRankPanel.rewardList = self:GetCurComp("WidgetRoot/Panel/Reward/rewardList", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject
    UIShareRankPanel.rewordBox = self:GetCurComp("WidgetRoot/Panel/box", "GameObject")
    ---@type UnityEngine.GameObject
    UIShareRankPanel.rewardBg = self:GetCurComp("WidgetRoot/Panel/Reward/bg", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UIShareRankPanel.rewardPanel = self:GetCurComp("WidgetRoot/Panel", "GameObject")
    ---@type Top_UISprite 称号
    UIShareRankPanel.Title = self:GetCurComp("WidgetRoot/Panel/Reward/TitleEffect/Title", "Top_UISprite")
    ---@type Top_UISpriteAnimation
    UIShareRankPanel.titleAnim = self:GetCurComp("WidgetRoot/Panel/Reward/TitleEffect/Title", "Top_UISpriteAnimation")
end

function UIShareRankPanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UIShareRankPanel.CloseBtn).onClick = UIShareRankPanel.OnClickCloseBtn
    CS.UIEventListener.Get(UIShareRankPanel.rewordBox).onClick = UIShareRankPanel.OnHideReward
    CS.UIEventListener.Get(UIShareRankPanel.rewardBg.gameObject).onClick = UIShareRankPanel.OnHideReward
    CS.UIEventListener.Get(UIShareRankPanel.btn_myrank.gameObject).onClick = UIShareRankPanel.OnMyRankGoCallBack
    CS.UIEventListener.Get(UIShareRankPanel.btn_help.gameObject).onClick = UIShareRankPanel.OnClickHelpBtn

    if UIShareRankPanel.rankScrollView.onDragStarted ~= nil then
        UIShareRankPanel.rankScrollView.onDragStarted('+', UIShareRankPanel.OnDragStartCallBack)
    else
        UIShareRankPanel.rankScrollView.onDragStarted = UIShareRankPanel.OnDragStartCallBack
    end
end

function UIShareRankPanel.BindNetMessage()
    UIShareRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResShareLookRankMessage, UIShareRankPanel.OnResLookRankMessageCallback)
    UIShareRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRankRewardInfoMessage, UIShareRankPanel.OnResRankRewardInfoMessageCallback)
    UIShareRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBattleDamageRankDatailMessage, UIShareRankPanel.OnResBattleDamageRankDatailMessage)
    UIShareRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, UIShareRankPanel.OnCommentMessage)
end

--endregion

--region 函数监听
--点击关闭函数
---@param go UnityEngine.GameObject
function UIShareRankPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel('UIShareRankPanel')
end

---我的排名点击
function UIShareRankPanel.OnMyRankGoCallBack(go)
    UIShareRankPanel.RankJump()
end

function UIShareRankPanel.OnClickHelpBtn(go)
    if UIShareRankPanel.curDescriptionId == nil then
        return
    end
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(UIShareRankPanel.curDescriptionId)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

function UIShareRankPanel.OnDragStartCallBack()
    UIShareRankPanel.HideAllInfo()
end

--endregion

--region 网络消息处理

--排行榜信息 列表 + 个人信息
function UIShareRankPanel.OnResLookRankMessageCallback(id, data)
    if data then
        UIShareRankPanel.RefreshRankListview(data.rankId)
        UIShareRankPanel.RefreshFirstOurRankItem(data)
        UIShareRankPanel.OnRefreshRankTimeCallBack(data.refreshTime)
    end
end

--带奖励个人信息
function UIShareRankPanel.OnResRankRewardInfoMessageCallback(id, data)
    if data then
        UIShareRankPanel.RefreshSecondOurRankItem(data)
    end
end

function UIShareRankPanel.OnResBattleDamageRankDatailMessage(msgId, tblData, csData)
    if csData and csData.infos and csData.infos.infos then
        local damageItemRankInfo = {}
        for i, v in pairs(csData.infos.infos) do
            local itemViewVo = CS.BagItemViewVo(v)
            if itemViewVo then
                table.insert(damageItemRankInfo, itemViewVo)
            end
        end
        uimanager:CreatePanel("UIItemListViewPanel", nil, { itemViewVos = damageItemRankInfo })
    end
end

function UIShareRankPanel.OnCommentMessage(msgId, serverData)
    if serverData and serverData.type == luaEnumRspServerCommonType.PlayIsOnLine then
        if UIShareRankPanel.CurSelectTemplate == nil or CS.StaticUtility.IsNull(UIShareRankPanel.CurSelectTemplate.go) then
            return
        end
        if serverData.data == nil or serverData.data64 == nil or serverData.data64 ~= UIShareRankPanel.CurSelectTemplate.rid then
            return
        end
        ---不在线
        if serverData.data == 0 then
            if UIShareRankPanel.CurSelectTemplate.promptPoint ~= nil and not CS.StaticUtility.IsNull(UIShareRankPanel.CurSelectTemplate.promptPoint) then
                Utility.ShowPopoTips(UIShareRankPanel.CurSelectTemplate.promptPoint, nil, 268, "UIRankPanel")
            end
            ---在线
        elseif serverData.data == 1 then
            uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                panelType = LuaEnumPanelIDType.RankPanel_RoleInfo,
                roleId = UIShareRankPanel.CurSelectTemplate.rid,
                roleName = UIShareRankPanel.CurSelectTemplate.rankData.name,
                roleSex = UIShareRankPanel.CurSelectTemplate.rankData.sex,
                roleCareer = UIShareRankPanel.CurSelectTemplate.rankData.career
            })
        end
    end
end

--endregion

--region UI

function UIShareRankPanel.InitUI()
    UIShareRankPanel.HideAllInfo()
    --UIShareRankPanel.InitMainBookMarksView()
end

function UIShareRankPanel.InitData()
    UIShareRankPanel.isInitOne = false
    UIShareRankPanel.itemTemplateDic = {}
    UIShareRankPanel.rankInfov2 = CS.CSScene.MainPlayerInfo.RankInfoV2
    -- UIShareRankPanel.RankBookMarkList = clientTableManager.cfg_rankManager:GetShareRankBookMarkList()
    --UIShareRankPanel.length = UIShareRankPanel.RankBookMarkList.Count
    --UIRankPanel.OurRankTemplate = templatemanager.GetNewTemplate(UIRankPanel.myRankGo, luaComponentTemplates.UIOurRankTemplate)
    UIShareRankPanel.OurRankRewardTemplate = templatemanager.GetNewTemplate(UIShareRankPanel.OurRankItem, luaComponentTemplates.UIOurRankRewardTemplate)
    UIShareRankPanel.curMainBookMarkIndex, UIShareRankPanel.curBookMarkIndex = CS.Cfg_RankTableManager.Instance:GetFirstUnRewardIndex()
end

---刷新当前排行榜视图
function UIShareRankPanel.RefreshOurItemStatu()
    --UIRankPanel.RankView:SetActive(UIRankPanel.ViewType == 1)
    --UIRankPanel.secondRightView:SetActive(UIRankPanel.ViewType == 2)
    --if UIRankPanel.ViewType == 1 then
    --    if UIRankPanel.OurRankRewardTemplate ~= nil then
    --        UIRankPanel.OurRankRewardTemplate:Clear()
    --    end
    --end
end

--region top

---初始化主页签视图
function UIShareRankPanel.InitMainBookMarksView()
    if UIShareRankPanel.length == 0 then
        return
    end
    for i = 0, UIShareRankPanel.length - 1 do
        UIShareRankPanel.MainBookMarkList.MaxCount = i + 1
        local go = UIShareRankPanel.MainBookMarkList.controlList[i].gameObject
        local v = UIShareRankPanel.RankBookMarkList[i]
        local unit = UIShareRankPanel.mainBookMarkTemplatesDic[i] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBookMarkTemplate) or UIShareRankPanel.mainBookMarkTemplatesDic[i]
        local temp = {}
        temp.dataID = 0
        temp.index = i
        temp.name = v.topStr
        temp.callBack = function(go)
            if UIShareRankPanel.curMainBookMarkIndex ~= i then
                UIShareRankPanel.curMainBookMarkIndex = i
                UIShareRankPanel.curBookMarkIndex = 0
                UIShareRankPanel.RefreshBookMarkView(i)
                UIShareRankPanel.RefreshBookMarksStatu(i, true)
            end
            UIShareRankPanel.HideAllInfo()
        end
        unit:SetTemplate(temp)
        if UIShareRankPanel.mainBookMarkTemplatesDic[i] == nil then
            UIShareRankPanel.mainBookMarkTemplatesDic[i] = unit
        end
    end
    UIShareRankPanel.RefreshBookMarksStatu(UIShareRankPanel.curMainBookMarkIndex, true)
    UIShareRankPanel.RefreshBookMarkView(UIShareRankPanel.curMainBookMarkIndex)
end

---刷新top视图
function UIShareRankPanel.RefreshTopsView(tops, posList)
    if tops.Count == 0 then
        return
    end
    local length = tops.Count
    for i = 0, length - 1 do
        UIShareRankPanel.rankTops.MaxCount = i + 1
        local goLabel = CS.Utility_Lua.GetComponent(UIShareRankPanel.rankTops.controlList[i].transform:Find("rankTop"), "Top_UILabel")
        if goLabel then
            goLabel.text = tops[i]
        end
    end
    UIShareRankPanel.RefreshTopPos(posList)
end

---刷新top坐标
function UIShareRankPanel.RefreshTopPos(posList)
    if posList ~= nil and posList.Count ~= 0 then
        local index = 0
        for i = 0, UIShareRankPanel.rankTops.transform.childCount - 1 do
            local go = UIShareRankPanel.rankTops.transform:GetChild(i)
            if go and go.gameObject.activeSelf and posList.Count - 1 >= index then
                go.transform.localPosition = CS.UnityEngine.Vector3(posList[index], 1, 0)
                index = index + 1
            end
        end
    end
end

---刷新帮助按钮
function UIShareRankPanel.RereshHelpBtn(descriptionId)
    if descriptionId then
        UIShareRankPanel.curDescriptionId = descriptionId
        UIShareRankPanel.btn_help.gameObject:SetActive(descriptionId ~= 0)
    end
end

---刷新页签高亮状态
function UIShareRankPanel.RefreshBookMarksStatu(index, isMain)
    local meet = isMain == nil or isMain
    local dic = meet and UIShareRankPanel.mainBookMarkTemplatesDic or UIShareRankPanel.bookMarkTemplatesDic
    for i, v in pairs(dic) do
        v:RefreshToggleStatu(index)
    end
end

--endregion

--region left

---刷新子页签视图
function UIShareRankPanel.RefreshBookMarkView(index)
    local v = UIShareRankPanel.RankBookMarkList[index]
    if UIShareRankPanel.RankBookMarkList[index] == nil or UIShareRankPanel.RankBookMarkList[index].branchBookMarkList.Count == 0 then
        for i = 0, UIShareRankPanel.BookMark.controlList.Count do
            UIShareRankPanel.BookMark:ClearItem(i)
        end
        return
    end
    local branchMarkList = UIShareRankPanel.RankBookMarkList[index].branchBookMarkList
    UIShareRankPanel.bookMarkTemplatesDic = {}
    local length = branchMarkList.Count
    for i = 0, length - 1 do
        UIShareRankPanel.BookMark.MaxCount = i + 1
        local go = UIShareRankPanel.BookMark.controlList[i].gameObject
        local v = branchMarkList[i]
        local unit = UIShareRankPanel.bookMarkTemplatesDic[i] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBookMarkTemplate) or UIShareRankPanel.bookMarkTemplatesDic[i]
        local temp = {}
        temp.index = i
        temp.name = v.rankStr
        temp.type = v.id
        temp.callBack = function(go)
            if UIShareRankPanel.curBookMarkIndex ~= i then
                UIShareRankPanel.curBookMarkIndex = i
                UIShareRankPanel.ViewType = v.viewType
                UIShareRankPanel.RefreshOurItemStatu()
                UIShareRankPanel.RefreshBookMarksStatu(i, false)
                UIShareRankPanel.RefreshTopsView(v.TypeBookMarkList, v.TypeBookMarkPosList)
                UIShareRankPanel.RereshHelpBtn(v.descriptionId)
                networkRequest.ReqShareLookRank(v.id)
                --if UIShareRankPanel.ViewType == 2 then
                --    networkRequest.ReqShareLookRank(v.id)
                --    UIShareRankPanel.curReceiveState = true
                --end
            end
            UIShareRankPanel.HideAllInfo()
        end
        unit:SetTemplate(temp)
        if UIShareRankPanel.bookMarkTemplatesDic[i] == nil then
            UIShareRankPanel.bookMarkTemplatesDic[i] = unit
        end
        if i == UIShareRankPanel.curBookMarkIndex then
            UIShareRankPanel.ViewType = v.viewType
            UIShareRankPanel.RefreshOurItemStatu()
            UIShareRankPanel.RefreshTopsView(v.TypeBookMarkList, v.TypeBookMarkPosList)
            UIShareRankPanel.RereshHelpBtn(v.descriptionId)
            networkRequest.ReqShareLookRank(v.id)
            if UIShareRankPanel.ViewType == 2 then
                networkRequest.ReqRankRewardInfo(v.id)
                UIShareRankPanel.curReceiveState = true
            end
        end
    end
    UIShareRankPanel.RefreshBookMarksStatu(UIShareRankPanel.curBookMarkIndex, false)
end

--endregion

--region center

---刷新排行榜列表视图
function UIShareRankPanel.RefreshRankListview(rankConfigId)
    UIShareRankPanel.curRankTypeCfgId = rankConfigId
    UIShareRankPanel.myRankItemTemplat = nil
    if not UIShareRankPanel.isInitOne then
        UIShareRankPanel.isInitOne = true
        UIShareRankPanel.rankMiddle:Init(UIShareRankPanel.RankTempCallBack, UIShareRankPanel.CheckShowMyRankGo)
    else
        UIShareRankPanel.rankMiddle:ResetPage()
    end

end

---设置数据
function UIShareRankPanel.RankTempCallBack(go, line)
    if UIShareRankPanel.curRankTypeCfgId == nil or CS.CSScene.MainPlayerInfo.RankInfoV2.DateInfo.Count < line + 1 then
        return false
    end
    local data = CS.CSScene.MainPlayerInfo.RankInfoV2.DateInfo[line]
    local rankTemp = UIShareRankPanel.itemTemplateDic[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIRankItemTemplate) or UIShareRankPanel.itemTemplateDic[go]
    local temp = {}
    temp.rankIndex = line + 1
    temp.rankConfigId = UIShareRankPanel.curRankTypeCfgId
    temp.rankInfo = data.roleRankInfo
    temp.wifeRankInfo = data.wifeRankInfo
    temp.servantRankInfo = data.servantRankInfo
    temp.damageItemRankInfo = data.damageItemRankInfo
    temp.rid = data.roleRankInfo.uid
    temp.rewardObj = UIShareRankPanel.Reward
    temp.ClickGoCallBack = function()
        if UIShareRankPanel.CurSelectTemplate ~= nil then
            if UIShareRankPanel.CurSelectTemplate.rid == temp.rid then
                return
            end
            UIShareRankPanel.CurSelectTemplate:SetChoseHightState(false)
        end
        rankTemp:SetChoseHightState(true)
        UIShareRankPanel.CurSelectTemplate = rankTemp
    end
    temp.useTemplate = uiStaticParameter.UIRankManager:GetLuaClassOfRankType(UIShareRankPanel.curRankTypeCfgId, true)
    rankTemp:SetTemplate(temp)
    if UIShareRankPanel.itemTemplateDic[go] == nil then
        UIShareRankPanel.itemTemplateDic[go] = rankTemp
    end
    if data.roleRankInfo.uid == CS.CSScene.MainPlayerInfo.ID then
        UIShareRankPanel.myRankItemTemplat = rankTemp
        rankTemp:SetRewardBoxState(not UIShareRankPanel.curReceiveState)
    end
    return true
end

--endregion

--region down

---刷新我方排行视图
function UIShareRankPanel.RefreshFirstOurRankItem(data)
    --if UIRankPanel.ViewType == 2 then
    --    return
    --end

    UIShareRankPanel.curMainRankId = data.ranking == nil and 0 or data.ranking
    UIShareRankPanel.CheckShowMyRankGo(0)
end

---刷新主角排行榜奖励
function UIShareRankPanel.RefreshSecondOurRankItem(data)
    if UIShareRankPanel.OurRankRewardTemplate == nil then
        return
    end
    UIShareRankPanel.curMainRankId = data.todayRank == nil and 0 or data.todayRank
    UIShareRankPanel.curReceiveState = data.isReceive
    local temp = {}
    --temp.rankID = data.yesterdayRank
    --temp.type = data.rankId
    --temp.time = data.refreshTime
    --temp.receive = not data.isReceive
    --temp.rewardCallBack = function()
    --    UIRankPanel.GetRewardCallBack(data.yesterdayRank, data.rankId)
    --end
    temp.timeEndCallBack = function()
        networkRequest.ReqLookRank(data.rankId)
        networkRequest.ReqRankRewardInfo(data.rankId)
        UIShareRankPanel.curReceiveState = true
    end
    UIShareRankPanel.OurRankRewardTemplate:SetTemplate(temp)
    --刷新当前宝箱状态（防止消息顺序发错导致刷新出错）
    if UIShareRankPanel.myRankItemTemplat ~= nil then
        UIShareRankPanel.myRankItemTemplat:SetRewardBoxState(not data.isReceive)
    end

    if UIShareRankPanel.JumpUpdateWait ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(UIShareRankPanel.JumpUpdateWait)
        UIShareRankPanel.JumpUpdateWait = nil
    end

    if not data.isReceive and data.todayRank ~= 0 then

        UIShareRankPanel.JumpUpdateWait = CS.CSListUpdateMgr.Add(200, nil, UIShareRankPanel.RankJump, false)
    end
    --UIRankPanel.OurRankRewardTemplate:SetRankRewardState(not data.isReceive and data.todayRank == 0)
    UIShareRankPanel.CheckShowMyRankGo(UIShareRankPanel.curMainRankId - 8 < 0 and 0 or UIShareRankPanel.curMainRankId - 8)
end

---刷新倒计时显示
function UIShareRankPanel.OnRefreshRankTimeCallBack(time)
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.RankInfoV2 ~= nil and CS.CSScene.MainPlayerInfo.RankInfoV2.DateInfo ~= nil then
        UIShareRankPanel.OurRankRewardTemplate:OnRefreshRankTimeState(time, CS.CSScene.MainPlayerInfo.RankInfoV2.DateInfo.Count ~= 0 and UIShareRankPanel.ViewType == 2)
    else
        UIShareRankPanel.OurRankRewardTemplate:OnRefreshRankTimeState(time, false)
    end
end

---判断是否显示跳转自己排行按钮
---@param line number 当前顶行
function UIShareRankPanel.CheckShowMyRankGo(line)
    if UIShareRankPanel.curMainRankId == 0 then
        UIShareRankPanel.myRankGo:SetActive(false)
    else
        --判断是否在下方
        UIShareRankPanel.myRankGo:SetActive(line + 8 < UIShareRankPanel.curMainRankId)
    end
end

function UIShareRankPanel.SetReWardTabel(rankId)
    if UIShareRankPanel.curMainRankId == 0 or UIShareRankPanel.curMainRankId == nil then
        return nil
    end
    local RewardList = CS.Cfg_RankingRewardTableManager.Instance:GetReward(rankId, UIShareRankPanel.curMainRankId)
    if RewardList == nil then
        return nil
    end
    local rewardTable = {}
    for i = 0, RewardList.list.Count - 1 do
        local value = RewardList.list[i]
        if value ~= nil and value.list.Count > 1 then
            local temp = {}
            temp.itemId = value.list[0]
            temp.count = value.list[1]
            table.insert(rewardTable, temp)
        end
    end
    return #rewardTable == 0 and nil or rewardTable
end

--endregion

--region 称号
UIShareRankPanel.curtitleModel = nil
UIShareRankPanel.curEffectPool = nil

---刷新奖励称号显示
function UIShareRankPanel.RefreshTitleShow(titleInfo)
    UIShareRankPanel.titleAnim.enabled = false
    if titleInfo ~= nil and titleInfo ~= "" then
        if titleInfo ~= UIShareRankPanel.curtitleModel then
            UIShareRankPanel.LoadTitleAtlas(titleInfo)
            return
        end
    end
    UIShareRankPanel.curtitleModel = titleInfo
    UIShareRankPanel.SetTitleShow()
end

---加载称号图集
function UIShareRankPanel.LoadTitleAtlas(code)
    if UIShareRankPanel.curEffectPool ~= nil then
        --删除之前的资源
        if CS.CSObjectPoolMgr.Instance ~= nil then
            CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(UIShareRankPanel.curEffectPool)
        end
    end
    CS.CSResourceManager.Singleton:AddQueueCannotDelete(code, CS.ResourceType.Effect, function(res)
        if res == nil or UIShareRankPanel.Title == nil or CS.StaticUtility.IsNull(UIShareRankPanel.Title) then
            return
        end
        UIShareRankPanel.curEffectPool = res:GetUIPoolItem(CS.EPoolType.Resource)
        if UIShareRankPanel.curEffectPool == nil then
            return
        end
        local go = res.MirrorObj
        if go == nil then
            UIShareRankPanel.curEffectPool = nil
            return
        end
        UIShareRankPanel.curtitleModel = code
        local effectAtlas = go:GetComponent('UIAtlas')
        if effectAtlas == nil then
            return
        end
        UIShareRankPanel.Title.atlas = effectAtlas
        UIShareRankPanel.SetTitleShow()
        UIShareRankPanel.SetRewardBgSize()
    end, CS.ResourceAssistType.UI)
end

function UIShareRankPanel.SetTitleShow()

    if UIShareRankPanel.curtitleModel == nil or UIShareRankPanel.curtitleModel == "" then
        UIShareRankPanel.titleAnim.gameObject:SetActive(false)
        return
    end
    UIShareRankPanel.titleAnim.namePrefix = UIShareRankPanel.curtitleModel
    UIShareRankPanel.titleAnim.enabled = true
    UIShareRankPanel.Title.enabled = true
    UIShareRankPanel.titleAnim:ResetToBeginning()
    UIShareRankPanel.titleAnim:Play()
    UIShareRankPanel.titleAnim.gameObject:SetActive(UIShareRankPanel.curtitleModel ~= "")
end

--endregion

--region 奖励

---刷新奖励
function UIShareRankPanel.RefreshReward(obj, infoArray, pos, titleInfo)
    UIShareRankPanel.OnHideReward()
    if infoArray == nil then
        --清空
        for i = 1, UIShareRankPanel.rewardList.controlList.Count do
            UIShareRankPanel.rewardList:ClearItem(i)
        end
        return
    end
    for i = 0, infoArray.list.Count - 1 do
        for i1 = 0, infoArray.list[i].list.Count - 1 do
            UIShareRankPanel.rewardList.MaxCount = i + 1
            local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(infoArray.list[i].list[0])
            if infobool then
                local go = UIShareRankPanel.rewardList.controlList[i]
                local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                temp:RefreshUIWithItemInfo(iteminfo, infoArray.list[i].list[1])
            end
        end
    end
    UIShareRankPanel.RefreshTitleShow(titleInfo)
    UIShareRankPanel.Reward.transform.position = pos
    if UIShareRankPanel.curEffectPool ~= nil then
        UIShareRankPanel.SetRewardBgSize()
    end
    UIShareRankPanel.Reward:SetActive(true)
    UIShareRankPanel.rewordBox:SetActive(true)
end

---设置奖励bg大小
function UIShareRankPanel.SetRewardBgSize()
    local sizeX = 282
    if UIShareRankPanel.curtitleModel ~= nil and UIShareRankPanel.curtitleModel ~= "" and UIShareRankPanel.curtitleModel ~= '' then
        if UIShareRankPanel.Title.width == 0 then
            sizeX = sizeX + 270
        else
            sizeX = sizeX + UIShareRankPanel.Title.width - 80
        end
    end
    UIShareRankPanel.rewardBg.width = sizeX
end

---隐藏奖励框
function UIShareRankPanel.OnHideReward()
    if (not CS.StaticUtility.IsNull(UIShareRankPanel.Reward) or UIShareRankPanel.Reward ~= nil) and UIShareRankPanel.Reward.activeSelf then
        UIShareRankPanel.Reward:SetActive(false)
    end
    UIShareRankPanel.rewordBox:SetActive(false)
end

---领奖回调
function UIShareRankPanel.GetRewardCallBack(rankConfigId, rankID)
    local info = CS.Cfg_RankingRewardTableManager.Instance:GetRewardTabelInfo(rankConfigId, rankID)
    if info ~= nil then
        local rewardInfo = {}
        if info.item == nil then
            return
        end
        for i = 0, info.item.list.Count - 1 do
            if info.item.list[i].list.Count > 1 then
                local temp = {}
                temp.itemId = info.item.list[i].list[0]
                temp.count = info.item.list[i].list[1]
                table.insert(rewardInfo, temp)
            end
        end
        if #rewardInfo == 0 then
            return
        end

        local text = "昨日 " .. info.rankingName .. " 第" .. info.rank .. "名"
        uimanager:CreatePanel("UIRewardTipsPanel", nil, { rewards = rewardInfo }, { tips = text })
    end
    networkRequest.ReqReceiveReward(rankConfigId)
end

--endregion

function UIShareRankPanel.HideAllInfo()
    UIShareRankPanel.OnHideReward()
    if UIShareRankPanel.CurSelectTemplate ~= nil then
        UIShareRankPanel.CurSelectTemplate:SetChoseHightState(false)
    end
end

--endregion

--region otherFunction

---跳转至主角行
function UIShareRankPanel.RankJump()
    if UIShareRankPanel.scrollViewSpring == nil then
        return
    end
    --先移动
    local myIndex = UIShareRankPanel.curMainRankId - 7 - 1
    if myIndex >= 0 then
        local v3 = UIShareRankPanel.rankMiddle:GetJumpToLineV3(myIndex)
        UIShareRankPanel.scrollViewSpring.target = CS.UnityEngine.Vector3(v3.x, v3.y + 10, v3.z)
    else
        UIShareRankPanel.scrollViewSpring.target = CS.Vector3.zero
    end
    UIShareRankPanel.scrollViewSpring.onFinished = UIShareRankPanel.ScrollViewSoringFinishedCallBack

    UIShareRankPanel.scrollViewSpring.enabled = true

end

function UIShareRankPanel.ScrollViewSoringFinishedCallBack()
    UIShareRankPanel.myRankGo.gameObject:SetActive(false)
end

---根据id查看是否为本职业
function UIShareRankPanel.CheckISMeetCarrer(id)
    local isWarrior = id == LuaEnumRankType.LEVEL_ZHANSHI or id == LuaEnumRankType.FIGHT_POWER_ZHANSHI
    local isTaoist = id == LuaEnumRankType.LEVEL_DAOSHI or id == LuaEnumRankType.FIGHT_POWER_DAOSHI
    local isMaster = id == LuaEnumRankType.LEVEL_FASHI or id == LuaEnumRankType.FIGHT_POWER_FASHI
    local isAll = id == LuaEnumRankType.LEVEL_ALL or id == LuaEnumRankType.FIGHT_POWER_ALL
    return (isWarrior and CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior) or (isTaoist and CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist) or (isMaster and CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master) or isAll
end

--endregion

--region ondestroy

function ondestroy()
    if UIShareRankPanel.curEffectPool ~= nil then
        --删除之前的资源
        if CS.CSObjectPoolMgr.Instance ~= nil then
            CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(UIShareRankPanel.curEffectPool)
        end
    end

    if UIShareRankPanel.refreshWidgetUpdata ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(UIShareRankPanel.refreshWidgetUpdata)
        UIShareRankPanel.refreshWidgetUpdata = nil

        CS.CSListUpdateMgr.Instance:Remove(UIShareRankPanel.JumpUpdateWait)
        UIShareRankPanel.JumpUpdateWait = nil
    end

    UIShareRankPanel.titleAnim.enabled = false
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResCommonMessage, UIRankPanel.OnCommentMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResLookRankMessage, UIRankPanel.OnResLookRankMessageCallback)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResRankRewardInfoMessage, UIRankPanel.OnResRankRewardInfoMessageCallback)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBattleDamageRankDatailMessage, UIRankPanel.OnResBattleDamageRankDatailMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResUnRewardRankTypesMessage, UIRankPanel.OnResUnRewardRankTypesMessageCallback)
end

--endregion

return UIShareRankPanel