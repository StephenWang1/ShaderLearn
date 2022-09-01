---@class UIRankPanel  排行榜面板
local UIRankPanel = {}

--region 局部变量

--储存主页签模板（目前不需要字典，为后续修改 取模板方便）
UIRankPanel.mainBookMarkTemplatesDic = {}
--储存子侧页签模板
UIRankPanel.bookMarkTemplatesDic = {}
--排行榜页签所有数据
UIRankPanel.RankBookMarkList = {}
--视图类型
UIRankPanel.ViewType = 1
--当前子页签索引
UIRankPanel.curBookMarkIndex = 1
--当前页签索引
UIRankPanel.curMainBookMarkIndex = 1
---@type UIRankItemTemplate 主角排行榜单元模板
UIRankPanel.myRankItemTemplat = nil

UIRankPanel.itemBgSize = 0

UIRankPanel.itemTemplateDic = {}

---当前请求id
UIRankPanel.curRankTypeCfgReqId = nil

UIRankPanel.isInitOne = false

---当前自己排行榜id
UIRankPanel.curMainRankId = 0
---当前选中的模板
UIRankPanel.CurSelectTemplate = nil
---当前选中的Id
UIRankPanel.CurSelectId = 0
---当前奖励领取状况
UIRankPanel.curReceiveState = true

UIRankPanel.isInitTop = true

UIRankPanel.ranktbl = nil

UIRankPanel.isLianFu = false
---是否为本榜的初次刷新
UIRankPanel.isFirstRefreshRank = true

--endregion

---获取当前排行信息
---@return<number,rankV2.RoleRankDataInfo>
function UIRankPanel.GetCurRankList()
    if UIRankPanel.rankList == nil and gameMgr:GetPlayerDataMgr() ~= nil then
        UIRankPanel.rankList = gameMgr:GetPlayerDataMgr():GetRankData():GetCurRankTbl()
    end
    return UIRankPanel.rankList
end

--region 初始化

function UIRankPanel:Init()
    self:InitComponents()
    UIRankPanel.InitTemplate()
    UIRankPanel.InitData()
    UIRankPanel.BindUIEvents()
    UIRankPanel.BindNetMessage()
    UIRankPanel.InitUI()
end

--- 初始化组件
function UIRankPanel:InitComponents()

    ---@type UnityEngine.GameObject 关闭按钮
    UIRankPanel.CloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    ---@type UnityEngine.GameObject
    UIRankPanel.background = self:GetCurComp("WidgetRoot/window/BaseWindow/background", "GameObject")
    ---@type Top_UIGridContainer   主页签
    UIRankPanel.MainBookMarkList = self:GetCurComp("WidgetRoot/events/Scroll View/MainBookMarkList", "Top_UIGridContainer")
    ---@type Top_UIGridContainer   左侧副页签
    UIRankPanel.BookMark = self:GetCurComp("WidgetRoot/BookMark", "Top_UIGridContainer")
    ---@type Top_UIGridContainer  榜顶
    UIRankPanel.rankTops = self:GetCurComp("WidgetRoot/Panel/background/rankTops", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject  帮助按钮
    UIRankPanel.btn_help = self:GetCurComp("WidgetRoot/Panel/background/btn_help", "GameObject")

    ---@type UnityEngine.GameObject
    UIRankPanel.RankView = self:GetCurComp("WidgetRoot/Panel/RankView", "GameObject")

    ---@type Top_UIScrollView
    UIRankPanel.rankScrollView = self:GetCurComp("WidgetRoot/Panel/RankView/Scroll View", "Top_UIScrollView")

    ---@type Top_LoopScrollView 列表
    UIRankPanel.rankMiddle = self:GetCurComp("WidgetRoot/Panel/RankView/Scroll View/firstRankMiddle", "UILoopScrollViewPlus")

    ---@type Top_SpringPanel 列表spring
    UIRankPanel.scrollViewSpring = self:GetCurComp("WidgetRoot/Panel/RankView/Scroll View", "Top_SpringPanel")

    ---@type UnityEngine.GameObject 自己排名标识
    UIRankPanel.myRankGo = self:GetCurComp("WidgetRoot/Panel/myRankGo", "GameObject")
    ---@type UnityEngine.GameObject 自己排名标识按钮
    UIRankPanel.btn_myrank = self:GetCurComp("WidgetRoot/Panel/myRankGo/btn_myrank", "GameObject")

    ---@type UnityEngine.GameObject 我方排行信息
    UIRankPanel.OurRankItem = self:GetCurComp("WidgetRoot/Panel/RankView/OurRankItem", "GameObject")

    ---@type UnityEngine.GameObject 奖励
    UIRankPanel.Reward = self:GetCurComp("WidgetRoot/Panel/Reward", "GameObject")
    UIRankPanel.rewardList = self:GetCurComp("WidgetRoot/Panel/Reward/rewardList", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject
    UIRankPanel.rewordBox = self:GetCurComp("WidgetRoot/Panel/box", "GameObject")
    ---@type UnityEngine.GameObject
    UIRankPanel.rewardBg = self:GetCurComp("WidgetRoot/Panel/Reward/bg", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UIRankPanel.rewardPanel = self:GetCurComp("WidgetRoot/Panel", "GameObject")
    ---@type Top_UISprite 称号
    UIRankPanel.Title = self:GetCurComp("WidgetRoot/Panel/Reward/TitleEffect/Title", "Top_UISprite")
    ---@type Top_UISpriteAnimation
    UIRankPanel.titleAnim = self:GetCurComp("WidgetRoot/Panel/Reward/TitleEffect/Title", "Top_UISpriteAnimation")
    ---@type UnityEngine.GameObject
    UIRankPanel.modelRootObj = self:GetCurComp("WidgetRoot/Panel/RankView/Role", "GameObject")
end

function UIRankPanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UIRankPanel.CloseBtn).onClick = UIRankPanel.OnClickCloseBtn
    CS.UIEventListener.Get(UIRankPanel.rewordBox).onClick = UIRankPanel.OnHideReward
    CS.UIEventListener.Get(UIRankPanel.rewardBg.gameObject).onClick = UIRankPanel.OnHideReward
    CS.UIEventListener.Get(UIRankPanel.btn_myrank.gameObject).onClick = UIRankPanel.OnMyRankGoCallBack
    CS.UIEventListener.Get(UIRankPanel.btn_help.gameObject).onClick = UIRankPanel.OnClickHelpBtn

    if UIRankPanel.rankScrollView.onDragStarted ~= nil then
        UIRankPanel.rankScrollView.onDragStarted('+', UIRankPanel.OnDragStartCallBack)
    else
        UIRankPanel.rankScrollView.onDragStarted = UIRankPanel.OnDragStartCallBack
    end
end

function UIRankPanel.BindNetMessage()
    UIRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResShareLookRankMessage, UIRankPanel.OnResLookShareRankMessageCallback)
    UIRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLookRankMessage, UIRankPanel.OnResLookRankMessageCallback)
    UIRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRankRewardInfoMessage, UIRankPanel.OnResRankRewardInfoMessageCallback)
    UIRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBattleDamageRankDatailMessage, UIRankPanel.OnResBattleDamageRankDatailMessage)
    UIRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, UIRankPanel.OnCommentMessage)
    UIRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRoleModelInfoMessage, UIRankPanel.OnResRoleModelInfoMessage)
end

function UIRankPanel.InitTemplate()
    ---@type UIRankModelTemplate
    UIRankPanel.modelTemplate = templatemanager.GetNewTemplate(UIRankPanel.modelRootObj, luaComponentTemplates.UIRankModelTemplate)
end

--endregion

--region 函数监听
--点击关闭函数
---@param go UnityEngine.GameObject
function UIRankPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel('UIRankPanel')
end

---我的排名点击
function UIRankPanel.OnMyRankGoCallBack(go)
    UIRankPanel.RankJump()
end

function UIRankPanel.OnClickHelpBtn(go)
    if UIRankPanel.curDescriptionId == nil then
        return
    end
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(UIRankPanel.curDescriptionId)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

function UIRankPanel.OnDragStartCallBack()
    -- UIRankPanel.HideAllInfo()
end

--endregion

--region 网络消息处理

--联服排行榜信息 列表 + 个人信息
function UIRankPanel.OnResLookShareRankMessageCallback(id, data)
    if data and UIRankPanel.isLianFu then
        UIRankPanel.RefreshRankListview(data.rankId)
        UIRankPanel.RefreshFirstOurRankItem(data)
        UIRankPanel.OnRefreshRankTimeCallBack(data.refreshTime)
    end
end

--排行榜信息 列表 + 个人信息
function UIRankPanel.OnResLookRankMessageCallback(id, data)
    if data and not UIRankPanel.isLianFu then
        UIRankPanel.RefreshRankListview(data.rankId)
        UIRankPanel.RefreshFirstOurRankItem(data)
        UIRankPanel.OnRefreshRankTimeCallBack(data.refreshTime)
    end
end

--带奖励个人信息
function UIRankPanel.OnResRankRewardInfoMessageCallback(id, data)
    if data then
        UIRankPanel.RefreshSecondOurRankItem(data)
    end
end

---战损榜信息响应
---@param csData rankV2.DamageItemRankInfo
function UIRankPanel.OnResBattleDamageRankDatailMessage(msgId, tblData, csData)
    if csData and csData.infos and csData.infos.infos and csData.infos.infos.Count > 0 then
        local damageItemRankInfo = {}

        for i = 0, csData.infos.infos.Count - 1 do
            local v = csData.infos.infos[i]
            local itemViewVo = CS.BagItemViewVo(v)
            if itemViewVo then
                table.insert(damageItemRankInfo, itemViewVo)
            end
        end

        --for i, v in pairs(csData.infos.infos) do
        --    local itemViewVo = CS.BagItemViewVo(v)
        --    if itemViewVo then
        --        table.insert(damageItemRankInfo, itemViewVo)
        --    end
        --end
        uimanager:CreatePanel("UIItemListViewPanel", nil, { itemViewVos = damageItemRankInfo })
    end
end

function UIRankPanel.OnCommentMessage(msgId, serverData)
    if serverData and serverData.type == luaEnumRspServerCommonType.PlayIsOnLine then
        if UIRankPanel.CurSelectTemplate == nil or CS.StaticUtility.IsNull(UIRankPanel.CurSelectTemplate.go) then
            return
        end
        if serverData.data == nil or serverData.data64 == nil or serverData.data64 ~= UIRankPanel.CurSelectTemplate.rid then
            return
        end
        ---不在线
        if serverData.data == 0 then
            if UIRankPanel.CurSelectTemplate.promptPoint ~= nil and not CS.StaticUtility.IsNull(UIRankPanel.CurSelectTemplate.promptPoint) then
                Utility.ShowPopoTips(UIRankPanel.CurSelectTemplate.promptPoint, nil, 268, "UIRankPanel")
            end
            ---在线
        elseif serverData.data == 1 then
            uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                panelType = LuaEnumPanelIDType.RankPanel_RoleInfo,
                roleId = UIRankPanel.CurSelectTemplate.rid,
                roleName = UIRankPanel.CurSelectTemplate.rankData.name,
                roleSex = UIRankPanel.CurSelectTemplate.rankData.sex,
                roleCareer = UIRankPanel.CurSelectTemplate.rankData.career
            })
        end
    end
end

function UIRankPanel.OnResRoleModelInfoMessage(msgId, serverData)
    if serverData then
        UIRankPanel.modelTemplate:OnRoleModelInfoCallBack(serverData)
    end
end

--endregion

--region UI

function UIRankPanel.InitUI()
    UIRankPanel.HideAllInfo()
    UIRankPanel.InitMainBookMarksView()
end

function UIRankPanel.InitData()
    UIRankPanel.isInitOne = false
    UIRankPanel.itemTemplateDic = {}
    UIRankPanel.rankInfov2 = CS.CSScene.MainPlayerInfo.RankInfoV2
    UIRankPanel.RankBookMarkList = clientTableManager.cfg_rankManager:GetLuaRankBookMarkList()
    --UIRankPanel.OurRankTemplate = templatemanager.GetNewTemplate(UIRankPanel.myRankGo, luaComponentTemplates.UIOurRankTemplate)
    UIRankPanel.OurRankRewardTemplate = templatemanager.GetNewTemplate(UIRankPanel.OurRankItem, luaComponentTemplates.UIOurRankRewardTemplate)
    UIRankPanel.curMainBookMarkIndex, UIRankPanel.curBookMarkIndex = CS.Cfg_RankTableManager.Instance:GetFirstUnRewardIndex()
    UIRankPanel.curMainBookMarkIndex = UIRankPanel.curMainBookMarkIndex + 1
    UIRankPanel.curBookMarkIndex = UIRankPanel.curBookMarkIndex + 1
end

---刷新当前排行榜视图
function UIRankPanel.RefreshOurItemStatu()
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
function UIRankPanel.InitMainBookMarksView()
    if #UIRankPanel.RankBookMarkList == 0 then
        return
    end
    for i = 1, #UIRankPanel.RankBookMarkList do
        UIRankPanel.MainBookMarkList.MaxCount = i
        local go = UIRankPanel.MainBookMarkList.controlList[i - 1].gameObject
        ---@type TrankBookMark
        local v = UIRankPanel.RankBookMarkList[i]
        local unit = UIRankPanel.mainBookMarkTemplatesDic[i] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBookMarkTemplate) or UIRankPanel.mainBookMarkTemplatesDic[i]
        local temp = {}
        temp.dataID = 0
        temp.index = i
        temp.name = v.topStr
        temp.callBack = function(go)
            UIRankPanel.HideAllInfo()
            if UIRankPanel.curMainBookMarkIndex ~= i then
                UIRankPanel.curMainBookMarkIndex = i
                UIRankPanel.curBookMarkIndex = 1
                UIRankPanel.RefreshBookMarkView(i)
                UIRankPanel.RefreshBookMarksStatu(i, true)
            end
        end
        unit:SetTemplate(temp)
        if UIRankPanel.mainBookMarkTemplatesDic[i] == nil then
            UIRankPanel.mainBookMarkTemplatesDic[i] = unit
        end
    end
    UIRankPanel.RefreshBookMarksStatu(UIRankPanel.curMainBookMarkIndex, true)
    UIRankPanel.RefreshBookMarkView(UIRankPanel.curMainBookMarkIndex)
end

---刷新top视图
function UIRankPanel.RefreshTopsView(tops, posList)
    if tops.Count == 0 then
        return
    end
    local length = tops.Count
    for i = 0, length - 1 do
        UIRankPanel.rankTops.MaxCount = i + 1
        local goLabel = CS.Utility_Lua.GetComponent(UIRankPanel.rankTops.controlList[i].transform:Find("rankTop"), "Top_UILabel")
        if goLabel then
            goLabel.text = tops[i]
        end
    end
    UIRankPanel.RefreshTopPos(posList)
end

---刷新top坐标
function UIRankPanel.RefreshTopPos(posList)
    if posList ~= nil and posList.Count ~= 0 then
        local index = 0
        for i = 0, UIRankPanel.rankTops.transform.childCount - 1 do
            local go = UIRankPanel.rankTops.transform:GetChild(i)
            if go and go.gameObject.activeSelf and posList.Count - 1 >= index then
                go.transform.localPosition = CS.UnityEngine.Vector3(posList[index], 1, 0)
                index = index + 1
            end
        end
    end
end

---刷新帮助按钮
function UIRankPanel.RereshHelpBtn(descriptionId)
    if descriptionId then
        UIRankPanel.curDescriptionId = descriptionId
        UIRankPanel.btn_help.gameObject:SetActive(descriptionId ~= 0)
    end
end

---刷新页签高亮状态
function UIRankPanel.RefreshBookMarksStatu(index, isMain)
    local meet = isMain == nil or isMain
    local dic = meet and UIRankPanel.mainBookMarkTemplatesDic or UIRankPanel.bookMarkTemplatesDic
    for i, v in pairs(dic) do
        v:RefreshToggleStatu(index)
    end
end

--endregion

--region left

---刷新子页签视图
function UIRankPanel.RefreshBookMarkView(index)
    local v = UIRankPanel.RankBookMarkList[index]
    if UIRankPanel.RankBookMarkList[index] == nil or UIRankPanel.RankBookMarkList[index].branchBookMarkList == nil
            or #UIRankPanel.RankBookMarkList[index].branchBookMarkList == 0 then
        for i = 0, UIRankPanel.BookMark.controlList.Count do
            UIRankPanel.BookMark:ClearItem(i)
        end
        return
    end
    local branchMarkList = UIRankPanel.RankBookMarkList[index].branchBookMarkList
    UIRankPanel.bookMarkTemplatesDic = {}
    local length = #branchMarkList
    for i = 1, length do
        UIRankPanel.BookMark.MaxCount = i
        local go = UIRankPanel.BookMark.controlList[i - 1].gameObject
        ---@type BranchBookMark
        local v = branchMarkList[i]
        local unit = UIRankPanel.bookMarkTemplatesDic[i] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBookMarkTemplate) or UIRankPanel.bookMarkTemplatesDic[i]
        local temp = {}
        temp.index = i
        temp.name = v.branchBookMarkBaseInfo.rankStr
        temp.type = v.reqId
        temp.callBack = function(go)
            UIRankPanel.HideAllInfo()
            if UIRankPanel.curBookMarkIndex ~= i then
                UIRankPanel.curBookMarkIndex = i
                UIRankPanel.ViewType = v.branchBookMarkBaseInfo.viewType
                UIRankPanel.isLianFu = v.isLinfu
                UIRankPanel.RefreshOurItemStatu()
                UIRankPanel.RefreshBookMarksStatu(i, false)
                UIRankPanel.RefreshTopsView(v.branchBookMarkBaseInfo.TypeBookMarkList, v.branchBookMarkBaseInfo.TypeBookMarkPosList)
                UIRankPanel.RereshHelpBtn(v.branchBookMarkBaseInfo.descriptionId)
                if v.isLinfu then
                    networkRequest.ReqShareLookRank(v.reqId)
                else
                    networkRequest.ReqLookRank(v.reqId)
                end

                if UIRankPanel.ViewType == 2 then
                    networkRequest.ReqRankRewardInfo(v.reqId)
                    UIRankPanel.curReceiveState = true
                end
            end
        end
        unit:SetTemplate(temp)
        if UIRankPanel.bookMarkTemplatesDic[i] == nil then
            UIRankPanel.bookMarkTemplatesDic[i] = unit
        end
        if i == UIRankPanel.curBookMarkIndex then
            UIRankPanel.ViewType = v.viewType
            UIRankPanel.isLianFu = v.isLinfu
            UIRankPanel.RefreshOurItemStatu()
            UIRankPanel.RefreshTopsView(v.branchBookMarkBaseInfo.TypeBookMarkList, v.branchBookMarkBaseInfo.TypeBookMarkPosList)
            UIRankPanel.RereshHelpBtn(v.branchBookMarkBaseInfo.descriptionId)
            if v.isLinfu then
                networkRequest.ReqShareLookRank(v.reqId)
            else
                networkRequest.ReqLookRank(v.reqId)
            end
            if UIRankPanel.ViewType == 2 then
                networkRequest.ReqRankRewardInfo(v.reqId)
                UIRankPanel.curReceiveState = true
            end
        end
    end
    UIRankPanel.RefreshBookMarksStatu(UIRankPanel.curBookMarkIndex, false)
end

--endregion

--region center

---刷新排行榜列表视图
function UIRankPanel.RefreshRankListview(rankConfigId)
    UIRankPanel.ResetData()
    UIRankPanel.GetCurRankList()
    UIRankPanel.curRankTypeCfgReqId = rankConfigId
    if not UIRankPanel.isInitOne then
        UIRankPanel.isInitOne = true
        UIRankPanel.rankMiddle:Init(UIRankPanel.RankTempCallBack, UIRankPanel.CheckShowMyRankGo)
    else
        UIRankPanel.rankMiddle:ResetPage()
    end
    UIRankPanel.modelTemplate:ChangeState(uiStaticParameter.UIRankManager:IsShowModel(rankConfigId) and #UIRankPanel.GetCurRankList() > 0)
end

---设置数据
function UIRankPanel.RankTempCallBack(go, line)
    if UIRankPanel.curRankTypeCfgReqId == nil or UIRankPanel.GetCurRankList() == nil or #UIRankPanel.GetCurRankList() < line + 1 then
        return false
    end
    local useTemplate = uiStaticParameter.UIRankManager:GetLuaClassOfRankType(UIRankPanel.curRankTypeCfgReqId, UIRankPanel.isLianFu)
    if useTemplate == nil then
        return
    end
    local data = UIRankPanel.GetCurRankList()[line + 1]
    ---@type UIRankItemTemplate
    local rankTemp = UIRankPanel.itemTemplateDic[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIRankItemTemplate) or UIRankPanel.itemTemplateDic[go]
    local temp = {}
    temp.rankIndex = line + 1
    temp.rankConfigId = UIRankPanel.curRankTypeCfgReqId
    temp.rankInfo = data.roleRankInfo
    temp.wifeRankInfo = data.wifeRankInfo
    temp.servantRankInfo = data.servantRankInfo
    temp.damageItemRankInfo = data.damageItemRankInfo
    temp.rid = data.roleRankInfo.uid
    temp.rewardObj = UIRankPanel.Reward
    temp.ClickGoCallBack = function()
        if UIRankPanel.CurSelectTemplate ~= nil then
            if UIRankPanel.CurSelectTemplate.rid == temp.rid then
                return
            end
        end
        UIRankPanel.HideAllInfo()
        rankTemp:SetChoseHightState(true)
        UIRankPanel.CurSelectTemplate = rankTemp
        UIRankPanel.CurSelectId = temp.rid
    end
    temp.useTemplate = useTemplate
    rankTemp:SetTemplate(temp)
    if UIRankPanel.itemTemplateDic[go] == nil then
        UIRankPanel.itemTemplateDic[go] = rankTemp
    end
    if data.roleRankInfo.uid == CS.CSScene.MainPlayerInfo.ID then
        UIRankPanel.myRankItemTemplat = rankTemp
        --rankTemp:SetRewardBoxState(not UIRankPanel.curReceiveState)
    end
    rankTemp:SetChoseHightState(UIRankPanel.CurSelectId == temp.rid)
    if line == 0 and UIRankPanel.isFirstRefreshRank then
        UIRankPanel.isFirstRefreshRank = false
        if uiStaticParameter.UIRankManager:IsShowModel(UIRankPanel.curRankTypeCfgReqId) then
            rankTemp:OnTemplatBtnClick(go)
        end
    end
    return true
end

--endregion

--region down

---刷新我方排行视图
function UIRankPanel.RefreshFirstOurRankItem(data)
    --if UIRankPanel.ViewType == 2 then
    --    return
    --end

    UIRankPanel.curMainRankId = data.ranking == nil and 0 or data.ranking
    UIRankPanel.CheckShowMyRankGo(0)
end

---刷新主角排行榜奖励
function UIRankPanel.RefreshSecondOurRankItem(data)
    if UIRankPanel.OurRankRewardTemplate == nil then
        return
    end
    UIRankPanel.curMainRankId = data.todayRank == nil and 0 or data.todayRank
    UIRankPanel.curReceiveState = data.isReceive
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
        UIRankPanel.curReceiveState = true
    end
    UIRankPanel.OurRankRewardTemplate:SetTemplate(temp)
    --刷新当前宝箱状态（防止消息顺序发错导致刷新出错）
    if UIRankPanel.myRankItemTemplat ~= nil then
        UIRankPanel.myRankItemTemplat:SetRewardBoxState(not data.isReceive)
    end

    if UIRankPanel.JumpUpdateWait ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(UIRankPanel.JumpUpdateWait)
        UIRankPanel.JumpUpdateWait = nil
    end

    if not data.isReceive and data.todayRank ~= 0 then

        UIRankPanel.JumpUpdateWait = CS.CSListUpdateMgr.Add(200, nil, UIRankPanel.RankJump, false)
    end
    --UIRankPanel.OurRankRewardTemplate:SetRankRewardState(not data.isReceive and data.todayRank == 0)
    UIRankPanel.CheckShowMyRankGo(UIRankPanel.curMainRankId - 8 < 0 and 0 or UIRankPanel.curMainRankId - 8)
end

---刷新倒计时显示
function UIRankPanel.OnRefreshRankTimeCallBack(time)
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.RankInfoV2 ~= nil and CS.CSScene.MainPlayerInfo.RankInfoV2.DateInfo ~= nil then
        UIRankPanel.OurRankRewardTemplate:OnRefreshRankTimeState(time, CS.CSScene.MainPlayerInfo.RankInfoV2.DateInfo.Count ~= 0 and UIRankPanel.ViewType == 2)
    else
        UIRankPanel.OurRankRewardTemplate:OnRefreshRankTimeState(time, false)
    end
end

---判断是否显示跳转自己排行按钮
---@param line number 当前顶行
function UIRankPanel.CheckShowMyRankGo(line)
    if UIRankPanel.curMainRankId == 0 then
        UIRankPanel.myRankGo:SetActive(false)
    else
        --判断是否在下方
        UIRankPanel.myRankGo:SetActive(line + 8 < UIRankPanel.curMainRankId)
    end
end

function UIRankPanel.SetReWardTabel(rankId)
    if UIRankPanel.curMainRankId == 0 or UIRankPanel.curMainRankId == nil then
        return nil
    end
    local RewardList = CS.Cfg_RankingRewardTableManager.Instance:GetReward(rankId, UIRankPanel.curMainRankId)
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
UIRankPanel.curtitleModel = nil
UIRankPanel.curEffectPool = nil

---刷新奖励称号显示
function UIRankPanel.RefreshTitleShow(titleInfo)
    UIRankPanel.titleAnim.enabled = false
    if titleInfo ~= nil and titleInfo ~= "" then
        if titleInfo ~= UIRankPanel.curtitleModel then
            UIRankPanel.LoadTitleAtlas(titleInfo)
            return
        end
    end
    UIRankPanel.curtitleModel = titleInfo
    UIRankPanel.SetTitleShow()
end

---加载称号图集
function UIRankPanel.LoadTitleAtlas(code)
    if UIRankPanel.curEffectPool ~= nil then
        --删除之前的资源
        if CS.CSObjectPoolMgr.Instance ~= nil then
            CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(UIRankPanel.curEffectPool)
        end
    end
    CS.CSResourceManager.Singleton:AddQueueCannotDelete(code, CS.ResourceType.Effect, function(res)
        if res == nil or UIRankPanel.Title == nil or CS.StaticUtility.IsNull(UIRankPanel.Title) then
            return
        end
        UIRankPanel.curEffectPool = res:GetUIPoolItem(CS.EPoolType.Resource)
        if UIRankPanel.curEffectPool == nil then
            return
        end
        local go = res.MirrorObj
        if go == nil then
            UIRankPanel.curEffectPool = nil
            return
        end
        UIRankPanel.curtitleModel = code
        local effectAtlas = go:GetComponent('UIAtlas')
        if effectAtlas == nil then
            return
        end
        UIRankPanel.Title.atlas = effectAtlas
        UIRankPanel.SetTitleShow()
        UIRankPanel.SetRewardBgSize()
    end, CS.ResourceAssistType.UI)
end

function UIRankPanel.SetTitleShow()

    if UIRankPanel.curtitleModel == nil or UIRankPanel.curtitleModel == "" then
        UIRankPanel.titleAnim.gameObject:SetActive(false)
        return
    end
    UIRankPanel.titleAnim.namePrefix = UIRankPanel.curtitleModel
    UIRankPanel.titleAnim.enabled = true
    UIRankPanel.Title.enabled = true
    UIRankPanel.titleAnim:ResetToBeginning()
    UIRankPanel.titleAnim:Play()
    UIRankPanel.titleAnim.gameObject:SetActive(UIRankPanel.curtitleModel ~= "")
end

--endregion

--region 奖励

---刷新奖励
function UIRankPanel.RefreshReward(obj, infoArray, pos, titleInfo)
    UIRankPanel.OnHideReward()
    if infoArray == nil then
        --清空
        for i = 1, UIRankPanel.rewardList.controlList.Count do
            UIRankPanel.rewardList:ClearItem(i)
        end
        return
    end
    for i = 0, infoArray.list.Count - 1 do
        for i1 = 0, infoArray.list[i].list.Count - 1 do
            UIRankPanel.rewardList.MaxCount = i + 1
            local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(infoArray.list[i].list[0])
            if infobool then
                local go = UIRankPanel.rewardList.controlList[i]
                local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                temp:RefreshUIWithItemInfo(iteminfo, infoArray.list[i].list[1])
            end
        end
    end
    UIRankPanel.RefreshTitleShow(titleInfo)
    UIRankPanel.Reward.transform.position = pos
    if UIRankPanel.curEffectPool ~= nil then
        UIRankPanel.SetRewardBgSize()
    end
    UIRankPanel.Reward:SetActive(true)
    UIRankPanel.rewordBox:SetActive(true)
end

---设置奖励bg大小
function UIRankPanel.SetRewardBgSize()
    local sizeX = 282
    if UIRankPanel.curtitleModel ~= nil and UIRankPanel.curtitleModel ~= "" and UIRankPanel.curtitleModel ~= '' then
        if UIRankPanel.Title.width == 0 then
            sizeX = sizeX + 270
        else
            sizeX = sizeX + UIRankPanel.Title.width - 80
        end
    end
    UIRankPanel.rewardBg.width = sizeX
end

---隐藏奖励框
function UIRankPanel.OnHideReward()
    if (not CS.StaticUtility.IsNull(UIRankPanel.Reward) or UIRankPanel.Reward ~= nil) and UIRankPanel.Reward.activeSelf then
        UIRankPanel.Reward:SetActive(false)
    end
    UIRankPanel.rewordBox:SetActive(false)
end

---领奖回调
function UIRankPanel.GetRewardCallBack(rankConfigId, rankID)
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

function UIRankPanel.HideAllInfo()
    UIRankPanel.OnHideReward()
    if UIRankPanel.CurSelectTemplate ~= nil then
        UIRankPanel.CurSelectTemplate:SetChoseHightState(false)
        UIRankPanel.CurSelectTemplate = nil
        UIRankPanel.CurSelectId = 0
    end
end

--endregion

--region model

---刷新模型视图
---@param targetRoleId number
function UIRankPanel.RefreshModelView(targetRoleId, rankData)
    UIRankPanel.modelTemplate:RefreshView(UIRankPanel.curRankTypeCfgReqId, targetRoleId, rankData)
end



--endregion

--region otherFunction

---跳转至主角行
function UIRankPanel.RankJump()
    if UIRankPanel.scrollViewSpring == nil then
        return
    end
    --先移动
    local myIndex = UIRankPanel.curMainRankId - 7 - 1
    if myIndex >= 0 then
        local v3 = UIRankPanel.rankMiddle:GetJumpToLineV3(myIndex)
        UIRankPanel.scrollViewSpring.target = CS.UnityEngine.Vector3(v3.x, v3.y + 10, v3.z)
    else
        UIRankPanel.scrollViewSpring.target = CS.Vector3.zero
    end
    UIRankPanel.scrollViewSpring.onFinished = UIRankPanel.ScrollViewSoringFinishedCallBack

    UIRankPanel.scrollViewSpring.enabled = true

end

function UIRankPanel.ScrollViewSoringFinishedCallBack()
    UIRankPanel.myRankGo:SetActive(false)
    if uiStaticParameter.UIRankManager:IsShowModel(UIRankPanel.curRankTypeCfgReqId) then
        UIRankPanel.myRankItemTemplat:OnTemplatBtnClick(UIRankPanel.myRankItemTemplat.go)
    end
end

---根据id查看是否为本职业
function UIRankPanel.CheckISMeetCarrer(id)
    local isWarrior = id == LuaEnumRankType.LEVEL_ZHANSHI or id == LuaEnumRankType.FIGHT_POWER_ZHANSHI
    local isTaoist = id == LuaEnumRankType.LEVEL_DAOSHI or id == LuaEnumRankType.FIGHT_POWER_DAOSHI
    local isMaster = id == LuaEnumRankType.LEVEL_FASHI or id == LuaEnumRankType.FIGHT_POWER_FASHI
    local isAll = id == LuaEnumRankType.LEVEL_ALL or id == LuaEnumRankType.FIGHT_POWER_ALL
    return (isWarrior and CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior) or (isTaoist and CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist) or (isMaster and CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master) or isAll
end

function UIRankPanel.ResetData()
    UIRankPanel.myRankItemTemplat = nil
    UIRankPanel.rankList = nil
    UIRankPanel.modelTemplate:ClearModel()
    UIRankPanel.isFirstRefreshRank = true
end

--endregion

--region ondestroy

function ondestroy()
    if UIRankPanel.curEffectPool ~= nil then
        --删除之前的资源
        if CS.CSObjectPoolMgr.Instance ~= nil then
            CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(UIRankPanel.curEffectPool)
        end
    end

    if UIRankPanel.refreshWidgetUpdata ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(UIRankPanel.refreshWidgetUpdata)
        UIRankPanel.refreshWidgetUpdata = nil

        CS.CSListUpdateMgr.Instance:Remove(UIRankPanel.JumpUpdateWait)
        UIRankPanel.JumpUpdateWait = nil
    end

    UIRankPanel.titleAnim.enabled = false
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResCommonMessage, UIRankPanel.OnCommentMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResLookRankMessage, UIRankPanel.OnResLookRankMessageCallback)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResRankRewardInfoMessage, UIRankPanel.OnResRankRewardInfoMessageCallback)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBattleDamageRankDatailMessage, UIRankPanel.OnResBattleDamageRankDatailMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResUnRewardRankTypesMessage, UIRankPanel.OnResUnRewardRankTypesMessageCallback)
end

--endregion

return UIRankPanel