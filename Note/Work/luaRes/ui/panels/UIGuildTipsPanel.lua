---@class UIGuildTipsPanel:UIBase 头像Tips
local UIGuildTipsPanel = {}

--region 局部变量定义
UIGuildTipsPanel.baseInfo = nil
UIGuildTipsPanel.roleId = 0
---选中玩家等级
UIGuildTipsPanel.roleLevel = 0
---按钮对应的客户端数据
UIGuildTipsPanel.clientData = {}

UIGuildTipsPanel.ItemInfoList = {}

UIGuildTipsPanel.AllBtnTemplateDic = {}

---所有职位位置
UIGuildTipsPanel.PosList = { 20, 15, 10, 5, 1, 0 }
---间隔
UIGuildTipsPanel.BtnGap = { 15, 12 }
---按钮对应的职位
UIGuildTipsPanel.mGridToPos = {}
---玩家名字
UIGuildTipsPanel.mPlayerName = nil
---玩家性别
UIGuildTipsPanel.mPlayerSex = nil
---玩家职业
UIGuildTipsPanel.mPlayerCarrer = nil
---队伍ID
UIGuildTipsPanel.TeamID = 0

---帮会ID
UIGuildTipsPanel.GuildID = 0
---面板类型
UIGuildTipsPanel.panelType = nil

---送花不足提示信息
UIGuildTipsPanel.mSendFlowerTipsInfo = nil
---当前选中职位
UIGuildTipsPanel.mCurrentChoose = nil

---转让帮会Tips信息
UIGuildTipsPanel.mTransferUnionTipsInfo = nil

---帮会职位
UIGuildTipsPanel.mCurrentUnionPosition = nil

---@type number 帮会踢人花费
UIGuildTipsPanel.mUnionKickCost = nil

---帮会踢人花费道具名字
---@type string
UIGuildTipsPanel.mUnionKickCostName = nil

---@type boolean 玩家踢人货币是否足够
UIGuildTipsPanel.mKickEnough = nil

UIGuildTipsPanel.curIsOnLine = false

UIGuildTipsPanel.showArrow = false

UIGuildTipsPanel.mIsFromHeadPanel = false;
--endregion

---@return CSMainPlayerInfo
function UIGuildTipsPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSUnionInfoV2
function UIGuildTipsPanel:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mUnionInfoV2 = self:GetMainPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfoV2
end

--region 组件

function UIGuildTipsPanel.TypeOne_GameObject()
    if UIGuildTipsPanel.mTypeOneObj == nil then
        UIGuildTipsPanel.mTypeOneObj = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_1", "GameObject")
    end
    return UIGuildTipsPanel.mTypeOneObj
end

---标题（玩家名字）
function UIGuildTipsPanel.PlayerName_UILabel()
    if UIGuildTipsPanel.mShowPlayerName == nil then
        UIGuildTipsPanel.mShowPlayerName = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_1/totalTable/playername", "UILabel")
    end
    return UIGuildTipsPanel.mShowPlayerName
end

---bg箭头
function UIGuildTipsPanel.TypeOneArrow_UISprite()
    if UIGuildTipsPanel.mTypeOneArrowSprite == nil then
        UIGuildTipsPanel.mTypeOneArrowSprite = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_1/window/arrow", "Top_UISprite")
    end
    return UIGuildTipsPanel.mTypeOneArrowSprite
end

---显示列表Container
function UIGuildTipsPanel.GridList_UIGridContainer()
    if UIGuildTipsPanel.mType1GridList == nil then
        UIGuildTipsPanel.mType1GridList = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_1/totalTable/childTable/GrildList", "UIGridContainer")
    end
    return UIGuildTipsPanel.mType1GridList
end

---显示大按钮列表Container
function UIGuildTipsPanel.BigBtnGridList_UIGridContainer()
    if UIGuildTipsPanel.mType1GridList2 == nil then
        UIGuildTipsPanel.mType1GridList2 = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_1/totalTable/childTable/GrildList_1", "UIGridContainer")
    end
    return UIGuildTipsPanel.mType1GridList2
end

---控制所有按钮与玩家名字的tabel
function UIGuildTipsPanel.TypeOneTotal_UITable()
    if UIGuildTipsPanel.mTypeOneTotal == nil then
        UIGuildTipsPanel.mTypeOneTotal = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_1/totalTable", "Top_UITable")
    end
    return UIGuildTipsPanel.mTypeOneTotal
end

---控制所有按钮的tabel
function UIGuildTipsPanel.AllBtnTotal_UITable()
    if UIGuildTipsPanel.mAllBtnTotal_UITable == nil then
        UIGuildTipsPanel.mAllBtnTotal_UITable = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_1/totalTable/childTable", "Top_UITable")
    end
    return UIGuildTipsPanel.mAllBtnTotal_UITable
end

---类型一（普通信息）
function UIGuildTipsPanel.Type_GameObject()
    if UIGuildTipsPanel.mType_GameObject == nil then
        UIGuildTipsPanel.mType_GameObject = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_1", "GameObject")
    end
    return UIGuildTipsPanel.mType_GameObject
end

function UIGuildTipsPanel.GetFrame_UISprite()
    if UIGuildTipsPanel.mFrame == nil then
        UIGuildTipsPanel.mFrame = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_1/window/Texture", "UITexture")
    end
    return UIGuildTipsPanel.mFrame
end

function UIGuildTipsPanel.GetBackGround_UISprite()
    if UIGuildTipsPanel.mBackGround == nil then
        UIGuildTipsPanel.mBackGround = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_1/window/background", "UISprite")
    end
    return UIGuildTipsPanel.mBackGround
end

--region Type2（帮会调整职位）
---调整职位界面
function UIGuildTipsPanel.Type2_GameObject()
    if UIGuildTipsPanel.mType2 == nil then
        UIGuildTipsPanel.mType2 = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_2", "GameObject")
    end
    return UIGuildTipsPanel.mType2
end

---职位Container
function UIGuildTipsPanel.GetGridList_UIGridContainer()
    if UIGuildTipsPanel.mGridList == nil then
        UIGuildTipsPanel.mGridList = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_2/GrildList", "UIGridContainer")
    end
    return UIGuildTipsPanel.mGridList
end

function UIGuildTipsPanel.outframe2()
    if UIGuildTipsPanel.moutframe2 == nil then
        UIGuildTipsPanel.moutframe2 = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_1/window/outframe2", "UISprite")
    end
    return UIGuildTipsPanel.moutframe2
end

---取消按钮
function UIGuildTipsPanel.GetCancelButton_GameObject()
    if UIGuildTipsPanel.mCancelButton == nil then
        UIGuildTipsPanel.mCancelButton = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_2/LeftBtn", "GameObject")
    end
    return UIGuildTipsPanel.mCancelButton
end

---确认按钮
function UIGuildTipsPanel.GetConfirmButton_GameObject()
    if UIGuildTipsPanel.mConfirmButton == nil then
        UIGuildTipsPanel.mConfirmButton = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_2/RightBtn", "GameObject")
    end
    return UIGuildTipsPanel.mConfirmButton
end

---调整职位标题
function UIGuildTipsPanel.GetSetPosTitle_UILabel()
    if UIGuildTipsPanel.mSetPosTitle == nil then
        UIGuildTipsPanel.mSetPosTitle = UIGuildTipsPanel:GetCurComp("WidgetRoot/Root/Type_2/window/playername", "UILabel")
    end
    return UIGuildTipsPanel.mSetPosTitle
end

---@return UnityEngine.BoxCollider
function UIGuildTipsPanel:GetCollider()
    if self.mCollider == nil then
        self.mCollider = self:GetCurComp("", "BoxCollider")
    end
    return self.mCollider
end

--endregion

--endregion

--region 初始化
function UIGuildTipsPanel:Init()
    self:AddCollider()
    UIGuildTipsPanel.BindEvents()
    UIGuildTipsPanel:BindMessage()

end

---@param CustomData XLua.ILuaTable
---@field CustomData.roleId      number
---@field CustomData.roleSex     number  送花必传!!!
---@field CustomData.roleCarrer  number
---@field CustomData.roleName    string
---@field CustomData.panelType   number  LuaEnumPanelIDType
---@field CustomData.UnionData   XLua.ILuaTable {Pos:number,Cost:number,CostName:string}
---@field CustomData.teamData    groupV2.PlayerInfo
---@field CustomData.hostId      number  服务器主机id (联服接口)
---@field CustomData.isShowArrow boolean
function UIGuildTipsPanel:Show(CustomData)
    if CustomData ~= nil and UIGuildTipsPanel.roleId ~= nil and type(UIGuildTipsPanel.roleId) == "number" then
        UIGuildTipsPanel.roleId = CustomData.roleId
        UIGuildTipsPanel.mPlayerName = CustomData.roleName
        UIGuildTipsPanel.panelType = CustomData.panelType
        if CustomData.roleSex ~= nil then
            UIGuildTipsPanel.mPlayerSex = CustomData.roleSex
        end
        if CustomData.roleCarrer ~= nil then
            UIGuildTipsPanel.mPlayerCarrer = CustomData.roleCarrer
        end
        if CustomData.baseInfo ~= nil then
            self.baseInfo = CustomData.baseInfo
        end
        if CustomData.UnionData then
            if CustomData.UnionData.Pos then
                UIGuildTipsPanel.mCurrentUnionPosition = CustomData.UnionData.Pos
            end
            if CustomData.UnionData.Cost then
                self.mUnionKickCost = CustomData.UnionData.Cost
            end
            if CustomData.UnionData.CostName then
                self.mUnionKickCostName = CustomData.UnionData.CostName
            end
            if CustomData.UnionData.costEnough ~= nil then
                self.mKickEnough = CustomData.UnionData.costEnough
            end
            if CustomData.UnionData.info ~= nil then
                self.mUnionMemberInfo = CustomData.UnionData.info
                UIGuildTipsPanel.unionMemberInfo = CustomData.UnionData.info
            end
        end

        UIGuildTipsPanel.mTeamPlayerData = CustomData.teamData;

        if CustomData.isShowArrow ~= nil then
            UIGuildTipsPanel.showArrow = CustomData.isShowArrow
        end

        if (CustomData.isFromHeadPanel ~= nil) then
            UIGuildTipsPanel.mIsFromHeadPanel = CustomData.isFromHeadPanel;
        end

        UIGuildTipsPanel.hostId = CustomData.hostId ~= nil and CustomData.hostId or 0

        ---是否为联服玩家(非本服)
        if (gameMgr:GetLuaMainPlayer():GetMainPlayerRemoteHostInfo() == nil) then
            UIGuildTipsPanel.isSharePlayer = false
        else
            UIGuildTipsPanel.isSharePlayer = CustomData.hostId ~= nil and not luaclass.RemoteHostDataClass:SameMainPlayerHostId(CustomData.hostId)
        end

        UIGuildTipsPanel.InitData()
        UIGuildTipsPanel.InitUI()
    end
end

function UIGuildTipsPanel.BindEvents()
    CS.UIEventListener.Get(UIGuildTipsPanel.GetCancelButton_GameObject()).onClick = UIGuildTipsPanel.OnCancelButtonClicked
    CS.UIEventListener.Get(UIGuildTipsPanel.GetConfirmButton_GameObject()).onClick = UIGuildTipsPanel.OnConfirmButtonClicked
end

function UIGuildTipsPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResHasPlayerSomeInfoMessage, UIGuildTipsPanel.HasPlayerSomeInfoMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResShareHasPlayerSomeInfoMessage, UIGuildTipsPanel.HasPlayerSomeInfoMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOtherRoleInfoMessage, UIGuildTipsPanel.OnResOtherRoleInfoMessageReceived)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, UIGuildTipsPanel.OnResCommonMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOtherServantInfoMessage, UIGuildTipsPanel.onResOtherSercantMessage)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.CloseMonsterHeadPanel, UIGuildTipsPanel.OnCloseMonsterHeadPanelMessage)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResShareCommonMessage, UIGuildTipsPanel.OnResCommonMessage)

end

function UIGuildTipsPanel.InitData()
    ___, UIGuildTipsPanel.mTransferUnionTipsInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(7)
    ___, UIGuildTipsPanel.mSendFlowerTipsInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(16)
    UIGuildTipsPanel.curIsOnLine = false
    if UIGuildTipsPanel.panelType ~= LuaEnumPanelIDType.ServantHeadPanel then
        if (type(UIGuildTipsPanel.roleId) == "number") then
            if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                networkRequest.ReqShareHasPlayerSomeInfo(UIGuildTipsPanel.roleId)
            else
                networkRequest.ReqHasPlayerSomeInfo(UIGuildTipsPanel.roleId)
            end
        end
    end
end

--endregion

--region UI

function UIGuildTipsPanel.InitUI()
    if not UIGuildTipsPanel.isSharePlayer then
        UIGuildTipsPanel.PlayerName_UILabel().text = UIGuildTipsPanel.mPlayerName
    else
        local prefixStr = luaclass.RemoteHostDataClass:GetLianFuShowSocialInfoByHostId(UIGuildTipsPanel.hostId)
        UIGuildTipsPanel.PlayerName_UILabel().text = prefixStr .. UIGuildTipsPanel.mPlayerName
    end
end

---打开面板
---@param panelID 面板ID类型
---@param data groupV2.ResHasPlayerSomeInfo 是否在线
function UIGuildTipsPanel.OpenPanel(panelID, data)
    if data == nil then
        if (panelID == LuaEnumPanelIDType.ServantHeadPanel) then
            UIGuildTipsPanel.curIsOnLine = true
        else
            UIGuildTipsPanel.ClosePanel()
        end
    else
        UIGuildTipsPanel.curIsOnLine = data.isOnline
    end
    if UIGuildTipsPanel.TypeOne_GameObject() ~= nil and not CS.StaticUtility.IsNull(UIGuildTipsPanel.TypeOne_GameObject()) then
        UIGuildTipsPanel.TypeOne_GameObject().transform.localPosition = CS.UnityEngine.Vector3(10000, 0, 0)
    end
    if UIGuildTipsPanel.Type_GameObject() ~= nil and not CS.StaticUtility.IsNull(UIGuildTipsPanel.Type_GameObject()) then
        UIGuildTipsPanel.Type_GameObject().gameObject:SetActive(true)
    end
    --获取客户端数据  UIGuildBTnManager
    UIGuildTipsPanel.clientData = uiStaticParameter.UIPlayerMenuBtnManager:GetMeetPlayerMenuBtns(panelID,
            { playerSomeInfo = data, unionMemberInfo = UIGuildTipsPanel.unionMemberInfo, teamPlayerData = UIGuildTipsPanel.mTeamPlayerData, isSharePlayer = UIGuildTipsPanel.isSharePlayer })
    if UIGuildTipsPanel.clientData ~= nil and #UIGuildTipsPanel.clientData > 0 then
        UIGuildTipsPanel.SetGridInfo()
        UIGuildTipsPanel.delayRefresh = CS.CSListUpdateMgr.Add(100, nil, function()
            if UIGuildTipsPanel.go == nil or CS.StaticUtility.IsNull(UIGuildTipsPanel.go) then
                CS.CSListUpdateMgr.Instance:Remove(UIGuildTipsPanel.delayRefresh)
                return
            end
            UIGuildTipsPanel.BgAdaptiveOfItemCount(panelID)
            CS.CSListUpdateMgr.Instance:Remove(UIGuildTipsPanel.delayRefresh)
            UIGuildTipsPanel.delayRefresh = nil
            UIGuildTipsPanel.delayRefresh = CS.CSListUpdateMgr.Add(100, nil, function()
                if CS.StaticUtility.IsNull(UIGuildTipsPanel.go) then
                    return
                end
                UIGuildTipsPanel.SetTypePos(panelID)
                CS.CSListUpdateMgr.Instance:Remove(UIGuildTipsPanel.delayRefresh)
                UIGuildTipsPanel.delayRefresh = nil
            end, false)
        end, false)
    end
end

---设置列表信息
function UIGuildTipsPanel.SetGridInfo()
    local smallBtnCount = #UIGuildTipsPanel.clientData[1]
    local bigBtnCount = 0
    if #UIGuildTipsPanel.clientData > 1 then
        bigBtnCount = #UIGuildTipsPanel.clientData[2]
    end
    --小按钮显示
    if smallBtnCount > 0 then
        UIGuildTipsPanel.GridList_UIGridContainer().MaxCount = smallBtnCount
        for i = 1, smallBtnCount do
            local v = UIGuildTipsPanel.clientData[1][i]
            local go = UIGuildTipsPanel.GridList_UIGridContainer().controlList[i - 1]
            local isFind, info = CS.Cfg_GuildButtonsTableManager.Instance.dic:TryGetValue(tonumber(v))
            if isFind then
                local template = {}
                if UIGuildTipsPanel.AllBtnTemplateDic[go] == nil then
                    ---@class UIGuildTipsUnitTemplate
                    template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGuildTipsUnitTemplate)
                    UIGuildTipsPanel.AllBtnTemplateDic[go] = template
                else
                    template = UIGuildTipsPanel.AllBtnTemplateDic[go]
                end
                local temp = {}
                local txtList = string.Split(info.name, '#')
                temp.txt = #txtList > 0 and txtList[1] or ''
                temp.spriteName = info.icon
                temp.btnClickCallBack = function(go)
                    UIGuildTipsPanel.OnClickBtn(go, tonumber(v))
                end
                template:SetTemplate(temp)
            end
        end
    end
    --大按钮显示
    if bigBtnCount > 0 then
        UIGuildTipsPanel.BigBtnGridList_UIGridContainer().MaxCount = bigBtnCount
        for i = 1, bigBtnCount do
            local v = UIGuildTipsPanel.clientData[2][i]
            local go = UIGuildTipsPanel.BigBtnGridList_UIGridContainer().controlList[i - 1]
            local isFind, info = CS.Cfg_GuildButtonsTableManager.Instance.dic:TryGetValue(tonumber(v))
            if isFind then
                local template = {}
                if UIGuildTipsPanel.AllBtnTemplateDic[go] == nil then
                    template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGuildTipsUnitTemplate)
                else
                    template = UIGuildTipsPanel.AllBtnTemplateDic[go]
                end
                local temp = {}
                local txtList = string.Split(info.name, '#')
                temp.txt = #txtList > 1 and txtList[2] or ''
                temp.spriteName = info.icon
                temp.btnClickCallBack = function(go)
                    UIGuildTipsPanel.OnClickBtn(go, tonumber(v))
                end
                template:SetTemplate(temp)
            end
        end
    end
end

function UIGuildTipsPanel.BgAdaptiveOfItemCount(panelID)
    if UIGuildTipsPanel.PlayerName_UILabel() ~= nil then
        UIGuildTipsPanel.PlayerName_UILabel().gameObject:SetActive(not UIGuildTipsPanel.IsShowArrow(panelID))
    end
    if UIGuildTipsPanel.TypeOneArrow_UISprite() ~= nil then
        UIGuildTipsPanel.TypeOneArrow_UISprite().gameObject:SetActive(UIGuildTipsPanel.IsShowArrow(panelID))
    end
    --执行tabel操作 排列
    if UIGuildTipsPanel.AllBtnTotal_UITable() ~= nil then
        UIGuildTipsPanel.AllBtnTotal_UITable():Reposition()
    end
    if UIGuildTipsPanel.TypeOneTotal_UITable() ~= nil then
        UIGuildTipsPanel.TypeOneTotal_UITable():Reposition()
    end
    --背景自适应
    if UIGuildTipsPanel.GetBackGround_UISprite() == nil then
        return
    end
    local totalHeight = CS.NGUIMath.CalculateRelativeWidgetBounds(UIGuildTipsPanel.TypeOneTotal_UITable().transform).size.y
    totalHeight = math.floor(totalHeight)
    totalHeight = tonumber(totalHeight) + tonumber(UIGuildTipsPanel.BtnGap[1]) + tonumber(UIGuildTipsPanel.BtnGap[2])
    UIGuildTipsPanel.GetBackGround_UISprite().height = math.floor(totalHeight)
end

function UIGuildTipsPanel.SetTypePos(panelID)
    if UIGuildTipsPanel.IsShowArrow(panelID) then
        UIGuildTipsPanel.TypeOne_GameObject().transform.localPosition = CS.UnityEngine.Vector3.zero
    else
        UIGuildTipsPanel.TypeOne_GameObject().transform.localPosition = CS.UnityEngine.Vector3(0, -100, 0)
    end
end

--endregion

--region UI事件


---按钮统一点击事件
function UIGuildTipsPanel.OnClickBtn(go, infodata)

    if LuaEnumGuildTipType.CheckInformation == infodata then
        if UIGuildTipsPanel.panelType ~= LuaEnumPanelIDType.RankPanel_RoleInfo and UIGuildTipsPanel.CheckIsShowBubbleTips(go) then
            return
        end
        --查看信息
        UIGuildTipsPanel:ViewInfo()
    elseif LuaEnumGuildTipType.PrivateChat == infodata then
        if UIGuildTipsPanel.CheckIsShowBubbleTips(go) then
            return
        end
        -- 私聊
        UIGuildTipsPanel:PrivateChat()
    elseif LuaEnumGuildTipType.AddFriend == infodata then
        if UIGuildTipsPanel.CheckIsShowBubbleTips(go) then
            return
        end
        --添加好友
        UIGuildTipsPanel:AddFriends()
    elseif LuaEnumGuildTipType.InvitedTeam == infodata then
        if UIGuildTipsPanel.CheckIsShowBubbleTips(go) then
            return
        end
        -- 邀请入队
        UIGuildTipsPanel:InviteEnqueue()
    elseif LuaEnumGuildTipType.ApplyTeam == infodata then
        if UIGuildTipsPanel.CheckIsShowBubbleTips(go) then
            return
        end
        --申请入队
        if UIGuildTipsPanel.TeamID ~= 0 then
            if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                networkRequest.ReqShareJoinGroup(UIGuildTipsPanel.TeamID, 2);
            else
                networkRequest.ReqJoinGroup(UIGuildTipsPanel.TeamID, 2)
            end
            --CS.Utility.ShowTips("已向对方发出入队申请")
            UIGuildTipsPanel.ClosePanel()
        end
    elseif LuaEnumGuildTipType.LeaveTeam == infodata then
        -- 退出队伍
        UIGuildTipsPanel:LeaveTeam();
    elseif LuaEnumGuildTipType.RemoveBlackList == infodata then
        -- 移除黑名单
        UIGuildTipsPanel:RemoveBlacklist()
    elseif LuaEnumGuildTipType.LookCircle == infodata then
        -- 查看圈子
        UIGuildTipsPanel.Circle()
    elseif LuaEnumGuildTipType.Deal == infodata then
        -- 交易
        UIGuildTipsPanel.Transaction()
    elseif LuaEnumGuildTipType.OurTutors == infodata then
        -- 拜师
        UIGuildTipsPanel.OurTutors()
    elseif LuaEnumGuildTipType.SendFlowers == infodata then
        if UIGuildTipsPanel.CheckIsShowBubbleTips(go) then
            return
        end
        --送花
        UIGuildTipsPanel.Flowers()
    elseif LuaEnumGuildTipType.SetPosition == infodata then
        --设置职位
        UIGuildTipsPanel:SetPost(go)
    elseif LuaEnumGuildTipType.OutGuild == infodata then
        -- 踢出公会
        UIGuildTipsPanel:Society(go)
    elseif LuaEnumGuildTipType.OutTemp == infodata then
        -- 踢出队伍
        UIGuildTipsPanel:OutTeam()
    elseif LuaEnumGuildTipType.TransferCaptain == infodata then
        -- 转让队长
        UIGuildTipsPanel:TransferCaptain()
    elseif LuaEnumGuildTipType.InviteMembership == infodata then
        if UIGuildTipsPanel.CheckIsShowBubbleTips(go) then
            return
        end
        -- 邀请入会
        UIGuildTipsPanel.InviteSociety()
    elseif LuaEnumGuildTipType.PullFist == infodata then
        if UIGuildTipsPanel.CheckIsShowBubbleTips(go) then
            return
        end
        --划拳
        UIGuildTipsPanel.Fist()
    elseif LuaEnumGuildTipType.SendDiamond == infodata then
        UIGuildTipsPanel.SendDiamondFunc()
    elseif LuaEnumGuildTipType.AuthorizationVoice == infodata then
        if UIGuildTipsPanel.CheckIsShowBubbleTips(go) then
            return
        end
        --语音授权
        UIGuildTipsPanel.AuthorizationVoice()
    elseif LuaEnumGuildTipType.UnAuthorizationVoice == infodata then
        if UIGuildTipsPanel.CheckIsShowBubbleTips(go) then
            return
        end
        --取消语音授权
        UIGuildTipsPanel.UnAuthorizationVoice()
    elseif LuaEnumGuildTipType.ApplyUnion == infodata then
        if UIGuildTipsPanel.CheckIsShowBubbleTips(go) then
            return
        end
        --申请入会
        UIGuildTipsPanel:ApplyAddUnion()
    elseif LuaEnumGuildTipType.CheckOtherPeopleServant == infodata then
        --查看灵兽信息
        if UIGuildTipsPanel.panelType ~= LuaEnumPanelIDType.RankPanel_RoleInfo and UIGuildTipsPanel.CheckIsShowBubbleTips(go) then
            return
        end
        UIGuildTipsPanel.CheckOtherServantGo = go
        if UIGuildTipsPanel.baseInfo ~= nil or UIGuildTipsPanel.roleId ~= nil then
            --networkRequest.ReqOtherServantInfo(UIGuildTipsPanel.baseInfo.ID)
            UIGuildTipsPanel.CheckOtherServant(go)
        else
            --networkRequest.ReqOtherServantInfo(UIGuildTipsPanel.roleId)
            UIGuildTipsPanel.CheckMasterInfo(go)
        end
    elseif LuaEnumGuildTipType.CheckMasterInfo == infodata then
        if UIGuildTipsPanel.CheckIsShowBubbleTips(go) then
            return
        end
        --查看灵兽主人信息
        UIGuildTipsPanel.CheckMasterInfo(go)
    elseif LuaEnumGuildTipType.Track == infodata then
        if UIGuildTipsPanel.CheckIsShowBubbleTips(go) then
            return
        end
        --追踪
        networkRequest.ReqLastEnemyPosition(UIGuildTipsPanel.roleId)
        uimanager:ClosePanel("UIGuildTipsPanel")
    elseif LuaEnumGuildTipType.Trade == infodata then
        ---请求与玩家交易
        local mFaceToFaceLimitLevel = CS.Cfg_GlobalTableManager.Instance.FaceToFaceLimitLevel
        local mMainPlayerLevel = CS.CSScene.MainPlayerInfo.Level
        if UIGuildTipsPanel.mOtherPlayerData ~= nil then
            if UIGuildTipsPanel.mOtherPlayerData.level >= mFaceToFaceLimitLevel and mMainPlayerLevel >= mFaceToFaceLimitLevel then
                networkRequest.ReqTrade(UIGuildTipsPanel.mOtherPlayerData.roleId)
                uimanager:ClosePanel("UIGuildTipsPanel")
            else
                local IsFind, wordInfo = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(343)
                if IsFind then
                    Utility.ShowPopoTips(go, string.format(wordInfo.content, tostring(mFaceToFaceLimitLevel)), 343, "UIGuildTipsPanel")
                end
            end
        end
        --if self.curData ~= nil and self.curData.playerSomeInfo
        --        and mainPlayerinfo.Level >= CS.Cfg_GlobalTableManager.Instance.FaceToFaceLimitLevel
        --        and self.curData.playerSomeInfo.level >= CS.Cfg_GlobalTableManager.Instance.FaceToFaceLimitLevel then
        --
        --end
        --networkRequest.ReqTrade(UIGuildTipsPanel.roleId)
        --uimanager:ClosePanel("UIGuildTipsPanel")
        -- uimanager:CreatePanel("UIPlayerMenuBtnManager")
    end
end

---关闭面板
function UIGuildTipsPanel.ClosePanel()
    uimanager:ClosePanel("UIGuildTipsPanel")
end

---点击取消
function UIGuildTipsPanel.OnCancelButtonClicked()
    uimanager:ClosePanel("UIGuildTipsPanel")
end

--endregion

--region 服务器消息
---玩家是否在线及部分消息
function UIGuildTipsPanel.HasPlayerSomeInfoMessage(msgId, tblData)
    if tblData == nil then
        return
    end
    UIGuildTipsPanel.mOtherPlayerData = tblData
    UIGuildTipsPanel.TeamID = tblData.teamId
    UIGuildTipsPanel.GuildID = tblData.unionId
    UIGuildTipsPanel.OpenPanel(UIGuildTipsPanel.panelType, tblData)
end

---查看其他玩家信息响应
function UIGuildTipsPanel.OnResOtherRoleInfoMessageReceived(msgID, data, csData)
    --local customData = {}
    --if data then
    --    local player = CS.CSScene.Sington:getAvatar(data.roleId)
    --
    --    ---region 特殊装备列表
    --    if (data.extraEquipList ~= nil) then
    --        customData.ExtraEquipList = data.extraEquipList;
    --    end
    --    --endregion
    --
    --    --region 称谓
    --    if (data.appellation ~= nil) then
    --        customData.appellation = data.appellation;
    --    end
    --    --endregion
    --
    --    if player ~= nil then
    --        customData.avatarInfo = player.BaseInfo
    --    else
    --        if data.roleId then
    --            --如果是离线玩家
    --            local ESex = {};
    --            ESex[LuaEnumSex.WoMan] = CS.ESex.WoMan
    --            ESex[LuaEnumSex.Man] = CS.ESex.Man
    --            ESex[LuaEnumSex.Common] = CS.ESex.Common;
    --
    --            local ECareer = {};
    --            ECareer[LuaEnumCareer.Common] = CS.ECareer.Common;
    --            ECareer[LuaEnumCareer.Taoist] = CS.ECareer.Taoist;
    --            ECareer[LuaEnumCareer.Master] = CS.ECareer.Master;
    --            ECareer[LuaEnumCareer.Warrior] = CS.ECareer.Warrior;
    --            ECareer[LuaEnumCareer.Assassin] = CS.ECareer.Assassin;
    --            ECareer[LuaEnumCareer.CunMin] = CS.ECareer.CunMin;
    --            local avatarInfo = {};
    --            avatarInfo.Name = data.roleName;
    --            avatarInfo.UIUnionName = data.unionName
    --            avatarInfo.Sex = ESex[data.sex];
    --            avatarInfo.Career = ECareer[data.career];
    --            if data.armor and data.armor ~= 0 then
    --                avatarInfo.BodyModel = CS.Cfg_ItemsTableManager.Instance:GetItems(data.armor).model.list[0]
    --            else
    --                avatarInfo.BodyModel = data.armor
    --            end
    --            if data.weapon and data.weapon ~= 0 then
    --                avatarInfo.Weapon = CS.Cfg_ItemsTableManager.Instance:GetItems(data.weapon).model.list[0]
    --            else
    --                avatarInfo.Weapon = data.weapon
    --            end
    --            if data.helmet and data.helmet ~= 0 then
    --                avatarInfo.Hair = 301000
    --                local hairModel = CS.Cfg_ItemsTableManager.Instance:GetItems(data.helmet).model
    --                if hairModel.list ~= nil and hairModel.list.Count == 1 then
    --                    avatarInfo.Hair = hairModel.list[0]
    --                elseif hairModel.list ~= nil and hairModel.list.Count == 2 then
    --                    avatarInfo.Hair = hairModel.list[data.sex - 1]
    --                end
    --            else
    --                avatarInfo.Hair = data.helmet
    --            end
    --            avatarInfo.GetWeaponModelID = function(info)
    --                if info == nil or info.Weapon == nil then
    --                    return 0
    --                end
    --                return info.Weapon
    --            end
    --            avatarInfo.GetBodyModelID = function(info)
    --                if info == nil or info.BodyModel == nil then
    --                    return 0
    --                end
    --                return info.BodyModel
    --            end
    --            avatarInfo.GetHairModelID = function(info)
    --                if info == nil or info.Hair == nil then
    --                    return 0
    --                end
    --                return info.Hair
    --            end
    --            customData.avatarInfo = avatarInfo;
    --        else
    --            customData.avatarInfo = nil
    --        end
    --    end
    --else
    --    customData.avatarInfo = nil
    --end
    --local equipInfo = {}
    --if csData.equipList and csData.equipList.Count > 0 then
    --    for i = 0, csData.equipList.Count - 1 do
    --        equipInfo[csData.equipList[i].index] = csData.equipList[i]
    --    end
    --end
    --if csData.marryInfo then
    --    customData.marryInfo = csData.marryInfo
    --    equipInfo[LuaEnumEquiptype.WeddingRing] = CS.CSScene.MainPlayerInfo.EquipInfo:ReverseMarryRing(csData.marryInfo)
    --end
    --customData.equipInfo = equipInfo;
    --customData.equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateOtherPlayer
    --customData.equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateOtherPlayer
    --if customData.avatarInfo then
    --
    --    uimanager:CreatePanel("UIOtherPlayerMessagePanel", nil, {btnType = LuaEnumOtherPlayerBtnType.ROLE,commonData = customData})
    --end
    --UIGuildTipsPanel.ClosePanel()
end

function UIGuildTipsPanel.OnResCommonMessage(msgId, serverData)
    if serverData and serverData.type == luaEnumRspServerCommonType.PlayIsOnLine then
        if serverData.data == nil then
            return
        end
        if serverData.data == 0 then
            CS.Utility.ShowTips("玩家不在线", 1.5, CS.ColorType.Yellow)
        elseif serverData .data == 1 then
            UIGuildTipsPanel.CheckFlower()
        end
    end
end

function UIGuildTipsPanel.onResOtherSercantMessage(msgId, tblData, csData)
    if (csData.infos.Count == 0) then
        if (UIGuildTipsPanel.CheckOtherServantGo ~= nil) then
            Utility.ShowPopoTips(UIGuildTipsPanel.CheckOtherServantGo, nil, 226)
        end
    else
        UIGuildTipsPanel.CheckOtherServant(UIGuildTipsPanel.CheckOtherServantGo)
    end
end

function UIGuildTipsPanel.OnCloseMonsterHeadPanelMessage(id, avaterId)
    if avaterId == nil then
        return
    end
    if UIGuildTipsPanel.baseInfo then
        if UIGuildTipsPanel.baseInfo.ID == avaterId then
            uimanager:ClosePanel("UIGuildTipsPanel")
        end
    else
        if UIGuildTipsPanel.roleId == avaterId then
            uimanager:ClosePanel("UIGuildTipsPanel")
        end
    end
end

--endregion

--region Features

---查看信息
function UIGuildTipsPanel:ViewInfo()
    self:SaveViewPlayerBackData()
    CS.CSScene.MainPlayerInfo.OtherPlayerInfo:ReqOtherPlayerMsg(UIGuildTipsPanel.roleId, LuaEnumOtherPlayerBtnType.ROLE, LuaEnumOtherPlayerBtnSubtype.OTHERROLE)
    if (UIGuildTipsPanel.mIsFromHeadPanel) then
        networkRequest.ReqMapCommon(7, nil, nil, UIGuildTipsPanel.roleId);
    end
    uimanager:ClosePanel("UIGuildTipsPanel")
end

---私聊
function UIGuildTipsPanel.PrivateChat()
    local newinfo = CS.friendV2.FriendInfo()
    if (UIGuildTipsPanel.baseInfo ~= nil) then
        newinfo.rid = UIGuildTipsPanel.baseInfo.ID
        newinfo.name = UIGuildTipsPanel.baseInfo.Name
        newinfo.career = Utility.EnumToInt(UIGuildTipsPanel.baseInfo.Career)
        newinfo.sex = Utility.EnumToInt(UIGuildTipsPanel.baseInfo.Sex)
        newinfo.hostId = UIGuildTipsPanel.hostId
    else
        newinfo.rid = UIGuildTipsPanel.roleId
        newinfo.name = UIGuildTipsPanel.mPlayerName
        newinfo.career = UIGuildTipsPanel.mPlayerSex
        newinfo.sex = UIGuildTipsPanel.mPlayerCarrer
        newinfo.hostId = UIGuildTipsPanel.hostId
    end
    local rid = newinfo.rid
    uiStaticParameter.PrivateChatID = rid
    local mainchatpanel = uimanager:GetPanel("UIMainChatPanel")
    local chatpanel = uimanager:GetPanel("UIChatPanel")
    if (CS.CSScene.MainPlayerInfo.FriendInfoV2:GetFriend(rid) ~= nil) then
        if (mainchatpanel ~= nil) then
            mainchatpanel.ChatBtnonClick()
        end
        --chatpanel.OnCloseBtn()
        --是好友
        local CustomData = {}
        CustomData.type = LuaEnumSocialFriendPanelType.LastChatPanel
        CustomData.CallBack = UIGuildTipsPanel.FindFriendToChat
        CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel = false;
        uimanager:CreatePanel("UISocialContactPanel", nil, CustomData)
    else
        --非好友
        if (mainchatpanel ~= nil) then
            mainchatpanel.HideMainChatPanel()
        end
        ---如果hostid相同，加进聊天系统的hostId同服需要为0，内部逻辑
        if (UIGuildTipsPanel.isSharePlayer == false) then
            newinfo.hostId = 0
        end
        CS.CSScene.MainPlayerInfo.FriendInfoV2:AddPrivateChatFriend(LuaEnumSocialLieBiaoType.ZuiJinLieBiao, newinfo)
        uiStaticParameter.UIChatPanel_SelectIndex = 5
        local name = " "
        if (newinfo.hostId == 0) then
            name = newinfo.name
        else
            name = luaclass.RemoteHostDataClass:GetLianFuPrefixNameByHostId(newinfo.hostId) .. newinfo.name
        end
        uiStaticParameter.mSocialChatFriendName = name

        if (chatpanel == nil) then
            uimanager:CreatePanel("UIChatPanel")
        else
            chatpanel:Init()
        end
    end
    uimanager:ClosePanel("UIGuildTipsPanel")
end
function UIGuildTipsPanel.FindFriendToChat(panel)
    uimanager:ClosePanel("UIChatPanel")
    panel:GetCurBranchPanel():SwitchFriendTemplate(uiStaticParameter.PrivateChatID)
end

---添加好友
function UIGuildTipsPanel.AddFriends()
    if (UIGuildTipsPanel.roleId ~= 0) then
        networkRequest.ReqAddFriend(1, UIGuildTipsPanel.roleId)
    end
    CS.Utility.ShowTips("已向对方发出好友申请")
    uimanager:ClosePanel("UIGuildTipsPanel")
end

---邀请入队
function UIGuildTipsPanel.InviteEnqueue()
    local GroupInfoV2 = CS.CSScene.MainPlayerInfo.GroupInfoV2
    if GroupInfoV2 ~= nil then
        --主角无队伍
        if GroupInfoV2.PlayerInfoList.Count == 0 then
            if UIGuildTipsPanel.TeamID == 0 then
                local reqID
                if (UIGuildTipsPanel.baseInfo ~= nil) then
                    reqID = UIGuildTipsPanel.baseInfo.ID
                else
                    reqID = UIGuildTipsPanel.roleId
                end
                if reqID then
                    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                        networkRequest.ReqShareInvitationPlayer(reqID)
                    else
                        networkRequest.ReqInvitationPlayer(reqID)
                    end
                end

            else
                if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                    networkRequest.ReqShareJoinGroup(UIGuildTipsPanel.TeamID);
                else
                    networkRequest.ReqJoinGroup(UIGuildTipsPanel.TeamID)
                end
            end
        end
        --主角有队伍
        if GroupInfoV2.PlayerInfoList.Count > 0 then
            if UIGuildTipsPanel.TeamID == 0 then
                local reqID
                if (UIGuildTipsPanel.baseInfo ~= nil) then
                    reqID = UIGuildTipsPanel.baseInfo.ID
                else
                    reqID = UIGuildTipsPanel.roleId
                end
                if reqID then
                    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                        networkRequest.ReqShareInvitationPlayer(reqID)
                    else
                        networkRequest.ReqInvitationPlayer(reqID)
                    end
                end
            else
                CS.Utility.ShowTips("对方已有队伍无法加入", 1.5, CS.ColorType.Red)
            end
        end
    end
    uimanager:ClosePanel('UIGuildTipsPanel')
end

---拉入黑名单
function UIGuildTipsPanel.Blacklist()
    if UIGuildTipsPanel.roleId ~= 0 then
        networkRequest.ReqAddFriend(3, UIGuildTipsPanel.roleId)
    end
    CS.Utility.ShowTips("已将对方拉入黑名单")
    uimanager:ClosePanel("UIGuildTipsPanel")
end

---移除黑名单
function UIGuildTipsPanel.RemoveBlacklist()
    if UIGuildTipsPanel.roleId ~= 0 then
        networkRequest.ReqDeleteFriend(3, UIGuildTipsPanel.roleId)
    end
    CS.Utility.ShowTips("已将对方移除黑名单")
    uimanager:ClosePanel("UIGuildTipsPanel")
end

---查看圈子
function UIGuildTipsPanel.Circle()
    --print("圈子")
end

---交易
function UIGuildTipsPanel.Transaction()
    --print("交易")
end

---拜师
function UIGuildTipsPanel.OurTutors()
    --print("拜师")
end

---划拳
function UIGuildTipsPanel.Fist()
    if (UIGuildTipsPanel.roleId ~= 0) then
        networkRequest.ReqInviteFinger(UIGuildTipsPanel.roleId, UIGuildTipsPanel.mPlayerName)
    end
    -- uimanager:CreatePanel('UIGuessChoosePanel')
    uimanager:ClosePanel('UIGuildTipsPanel')
end

---赠送钻石
function UIGuildTipsPanel.SendDiamondFunc()
    if (UIGuildTipsPanel.baseInfo) then
        uimanager:CreatePanel("UISendDiamondPanel", nil, UIGuildTipsPanel.baseInfo.Name)
    else
        uimanager:CreatePanel("UISendDiamondPanel", nil, UIGuildTipsPanel.mPlayerName)
    end
end

---踢出队伍
function UIGuildTipsPanel:OutTeam()
    if UIGuildTipsPanel.baseInfo ~= nil then
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareExitGroup(UIGuildTipsPanel.baseInfo.ID)
        else
            networkRequest.ReqExitGroup(UIGuildTipsPanel.baseInfo.ID)
        end
        UIGuildTipsPanel.ClosePanel()
    else
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareExitGroup(UIGuildTipsPanel.roleId)
        else
            networkRequest.ReqExitGroup(UIGuildTipsPanel.roleId)
        end
        CS.Utility.ShowTips("已将对方踢出队伍")
        UIGuildTipsPanel.ClosePanel()
        --print("找不到玩家数据")
    end
end

function UIGuildTipsPanel:LeaveTeam()
    if (CS.CSScene.MainPlayerInfo.GroupInfoV2.IsHaveGroup) then
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareExitGroup(CS.CSScene.MainPlayerInfo.ID)
        else
            networkRequest.ReqExitGroup(CS.CSScene.MainPlayerInfo.ID);
        end
    end
    uimanager:ClosePanel("UIGuildTipsPanel");
end

---转让队长
function UIGuildTipsPanel:TransferCaptain()
    if UIGuildTipsPanel.baseInfo ~= nil then
        --print("转让队长成功")
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareChangeCaptain(UIGuildTipsPanel.baseInfo.ID)
        else
            networkRequest.ReqChangeCaptain(UIGuildTipsPanel.baseInfo.ID)
        end
    else
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareChangeCaptain(UIGuildTipsPanel.roleId)
        else
            networkRequest.ReqChangeCaptain(UIGuildTipsPanel.roleId)
        end
        CS.Utility.ShowTips("已转让队长")
        --print("找不到玩家数据")
    end
    UIGuildTipsPanel.ClosePanel()
end

---授权语音
function UIGuildTipsPanel.AuthorizationVoice()
    if UIGuildTipsPanel.mUnionMemberInfo ~= nil then
        networkRequest.ReqToggleSendVoice(UIGuildTipsPanel.mUnionMemberInfo.roleId, 1)
        UIGuildTipsPanel.ClosePanel()
    end

end

---取消授权语音
function UIGuildTipsPanel.UnAuthorizationVoice()
    if UIGuildTipsPanel.mUnionMemberInfo ~= nil then
        networkRequest.ReqToggleSendVoice(UIGuildTipsPanel.mUnionMemberInfo.roleId, 0)
        UIGuildTipsPanel.ClosePanel()
    end
end

--- 点击查看灵兽
function UIGuildTipsPanel.CheckOtherServant(go)
    UIGuildTipsPanel.CheckOtherServantGo = go
    if UIGuildTipsPanel.baseInfo ~= nil and UIGuildTipsPanel.baseInfo.MasterID ~= nil then
        local servantIndex = Utility.EnumToInt(UIGuildTipsPanel.baseInfo.ServantType)
        local otherServantBtnSubType = LuaEnumOtherPlayerBtnSubtype.SERVANT_HANMANG
        if servantIndex == luaEnumServantType.LX then
            otherServantBtnSubType = LuaEnumOtherPlayerBtnSubtype.SERVANT_LUOXING
        elseif servantIndex == luaEnumServantType.TC then
            otherServantBtnSubType = LuaEnumOtherPlayerBtnSubtype.SERVANT_TIANCHENG
        end
        CS.CSScene.MainPlayerInfo.OtherPlayerInfo:ReqOtherPlayerMsg(UIGuildTipsPanel.baseInfo.MasterID, LuaEnumOtherPlayerBtnType.SERVANT, otherServantBtnSubType)
    else
        CS.CSScene.MainPlayerInfo.OtherPlayerInfo:ReqOtherPlayerMsg(UIGuildTipsPanel.roleId, LuaEnumOtherPlayerBtnType.SERVANT, LuaEnumOtherPlayerBtnSubtype.SERVANT_HANMANG)
    end
    UIGuildTipsPanel:SaveViewPlayerBackData()
    if (UIGuildTipsPanel.mIsFromHeadPanel) then
        networkRequest.ReqMapCommon(8, nil, nil, UIGuildTipsPanel.roleId);
    end
    uimanager:ClosePanel("UIGuildTipsPanel")
end

--- 查看主人信息
function UIGuildTipsPanel.CheckMasterInfo(go)
    local masterId = 0
    if UIGuildTipsPanel.baseInfo ~= nil and UIGuildTipsPanel.baseInfo.MasterID ~= 0 then
        masterId = UIGuildTipsPanel.baseInfo.MasterID
    end
    if UIGuildTipsPanel.baseInfo ~= nil and UIGuildTipsPanel.baseInfo.Data ~= nil and UIGuildTipsPanel.baseInfo.Data.masterId ~= 0 then
        masterId = UIGuildTipsPanel.baseInfo.Data.masterId
    end
    if masterId ~= 0 then
        if (UIGuildTipsPanel.mIsFromHeadPanel) then
            networkRequest.ReqMapCommon(7, nil, nil, masterId);
        end
        CS.CSScene.MainPlayerInfo.OtherPlayerInfo:ReqOtherPlayerMsg(masterId, LuaEnumOtherPlayerBtnType.ROLE, LuaEnumOtherPlayerBtnSubtype.OTHERROLE)
        uimanager:ClosePanel("UIGuildTipsPanel")
    end
end

--region 送花
---点击送花
function UIGuildTipsPanel.Flowers()
    if UIGuildTipsPanel.baseInfo then
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, UIGuildTipsPanel.baseInfo.ID)
        else
            networkRequest.ReqCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, UIGuildTipsPanel.baseInfo.ID)
        end
    else
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, UIGuildTipsPanel.roleId)
        else
            networkRequest.ReqCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, UIGuildTipsPanel.roleId)
        end
    end
end

function UIGuildTipsPanel.CheckFlower()
    if (UIGuildTipsPanel.baseInfo) then
        local isshowSendPanel, isShowPromptPanel = Utility.TryOpenSendFlowerPanel({
            Sex = Utility.EnumToInt(UIGuildTipsPanel.baseInfo.Sex),
            rid = UIGuildTipsPanel.baseInfo.ID,
            name = UIGuildTipsPanel.baseInfo.Name,
            isSharePlayer = UIGuildTipsPanel.isSharePlayer,
            hostId = UIGuildTipsPanel.hostId,
            PromptClickFunc = function()
                uimanager:ClosePanel("UIGuildTipsPanel")
            end
        })
        if isshowSendPanel then
            uimanager:ClosePanel("UIGuildTipsPanel")
        end
    else
        local isshowSendPanel, isShowPromptPanel = Utility.TryOpenSendFlowerPanel({
            Sex = UIGuildTipsPanel.mPlayerSex,
            rid = UIGuildTipsPanel.roleId,
            name = UIGuildTipsPanel.mPlayerName,
            isSharePlayer = UIGuildTipsPanel.isSharePlayer,
            hostId = UIGuildTipsPanel.hostId,
            PromptClickFunc = function()
                uimanager:ClosePanel("UIGuildTipsPanel")
            end
        })
        if isshowSendPanel then
            uimanager:ClosePanel("UIGuildTipsPanel")
        end
    end
end
--endregion

--region 帮会
---设置职位
function UIGuildTipsPanel:SetPost(go)
    if Utility.IsSabacActivityNotOpen(go) then
        UIGuildTipsPanel.Type_GameObject():SetActive(false)
        UIGuildTipsPanel.Type2_GameObject():SetActive(true)
        self:RemoveCollider()
        self:GetCollider().enabled = true
        if UIGuildTipsPanel.GetSetPosTitle_UILabel() and UIGuildTipsPanel.mPlayerName then
            UIGuildTipsPanel.GetSetPosTitle_UILabel().text = "将" .. UIGuildTipsPanel.mPlayerName .. "职位调整为"
        end
        ---@type CSMainPlayerInfo
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        if mainPlayerInfo == nil then
            return
        end
        ---@type CSUnionInfoV2
        local playerUnionInfo = mainPlayerInfo.UnionInfoV2
        if playerUnionInfo == nil then
            return
        end
        local playerPos = playerUnionInfo:GetCurrentPosition()
        local container = UIGuildTipsPanel.GetGridList_UIGridContainer()
        container.MaxCount = #UIGuildTipsPanel.PosList
        UIGuildTipsPanel.mGridToPos = {}
        for i = 0, container.controlList.Count - 1 do
            local item = container.controlList[i].gameObject
            if item and CS.StaticUtility.IsNull(item) == false then
                local label = CS.Utility_Lua.GetComponent(item.transform:Find("Label"), "UILabel")
                local toggle = CS.Utility_Lua.GetComponent(item, "UIToggle")
                local color = ""
                if playerPos == LuaEnumGuildPosType.President then
                    UIGuildTipsPanel.SetPosToggle(toggle, UIGuildTipsPanel.PosList[i + 1])
                else
                    if playerPos <= UIGuildTipsPanel.PosList[i + 1] then
                        color = "[878787]"
                        CS.Utility_Lua.GetComponent(item, "BoxCollider").enabled = false
                    else
                        UIGuildTipsPanel.SetPosToggle(toggle, UIGuildTipsPanel.PosList[i + 1])
                    end
                end
                --代理会长不可设置副会长
                --local vicePresident = UIGuildTipsPanel.PosList[i + 1] == LuaEnumGuildPosType.VicePresident and playerPos == LuaEnumGuildPosType.ActingPresident
                --同职位不可点
                local aimPos = UIGuildTipsPanel.PosList[i + 1]
                if aimPos == UIGuildTipsPanel.mCurrentUnionPosition or self:IsPosEnough(aimPos) then
                    color = "[878787]"
                    CS.Utility_Lua.GetComponent(item, "BoxCollider").enabled = false
                end
                local pos = UIGuildTipsPanel.PosList[i + 1]
                label .text = color .. uiStaticParameter.PosStringList[pos]
            end
        end
    end
end

---判断该行会职位是否已满
function UIGuildTipsPanel:IsPosEnough(pos)
    if pos < LuaEnumGuildPosType.ActingPresident and pos > LuaEnumGuildPosType.Member then
        if self:GetUnionInfoV2() then
            local unionPosDic = self:GetUnionInfoV2().UnionPosToNum

            local res, num = unionPosDic:TryGetValue(pos)
            if res then
                local limitNum = self:GetPosLimitNum(pos)
                return num >= limitNum
            end
        end
    end
    return false
end

function UIGuildTipsPanel:GetPosLimitNum(pos)
    if self.mPosLimitNum == nil then
        self.mPosLimitNum = {}
        local res, info = CS.Cfg_UnionTableManager.Instance.dic:TryGetValue(1)
        if res then
            self.mPosLimitNum[LuaEnumGuildPosType.VicePresident] = info.numberTwo
            self.mPosLimitNum[LuaEnumGuildPosType.Elder] = info.numberThree
            self.mPosLimitNum[LuaEnumGuildPosType.Owner] = info.numberFour
            self.mPosLimitNum[LuaEnumGuildPosType.Elite] = info.numberFive
        end
    end
    return self.mPosLimitNum[pos]
end

---设置职位按钮
---@param toggle UIToggle 单选
---@param pos XLua.Cast.Int32 职位
function UIGuildTipsPanel.SetPosToggle(toggle, pos)
    CS.EventDelegate.Add(toggle.onChange, function()
        if toggle.value then
            UIGuildTipsPanel.mCurrentChoose = pos
        end
    end)
end

---邀请入会
function UIGuildTipsPanel.InviteSociety()
    networkRequest.ReqInviteForEnterUnion(UIGuildTipsPanel.roleId)
    UIGuildTipsPanel.ClosePanel()
end

---踢出公会
function UIGuildTipsPanel:Society(go)
    if Utility.IsSabacActivityNotOpen(go) then
        local KickInfo
        if self.mUnionKickCost == 0 then
            if self:GetUnionKickFreeTips() then
                KickInfo = {
                    Title = self:GetUnionKickFreeTips().title,
                    LeftDescription = self:GetUnionKickFreeTips().leftButton,
                    RightDescription = self:GetUnionKickFreeTips().rightButton,
                    Content = self:GetUnionKickFreeContent(),
                    ID = self:GetUnionKickFreeTips().id,
                    CallBack = UIGuildTipsPanel.ConfirmKick
                }
            end
            uimanager:CreatePanel("UIPromptPanel", nil, KickInfo)
        else
            local customData = {}
            customData.ID = 44
            customData.CenterCostID = self.mUnionKickCostName
            customData.CenterCostNum = self.mUnionKickCost
            customData.CenterCallBack = function(go)
                if self.mKickEnough then
                    self.ConfirmKick()
                    uimanager:ClosePanel("UIGuildAccusePromptPanel")
                else
                    local str = self:GetCostKickNotEnoughDes()
                    Utility.ShowPopoTips(go, str, 156)
                end
            end
            uimanager:CreatePanel("UIGuildAccusePromptPanel", nil, customData)
        end
    end
end

---@return TABLE.CFG_PROMPTWORD 帮会踢人二次弹窗
function UIGuildTipsPanel:GetUnionKickFreeTips()
    if self.mKickFreeUnionTipsInfo == nil then
        ___, self.mKickFreeUnionTipsInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(6)
    end
    return self.mKickFreeUnionTipsInfo
end

---@return string 获取帮会免费踢人二次弹窗描述
function UIGuildTipsPanel:GetUnionKickFreeContent()
    if self.mFreeKickContent == nil and self.mPlayerName and self:GetUnionKickFreeTips() then
        self.mFreeKickContent = string.format(string.gsub(self:GetUnionKickFreeTips().des, "\\n", '\n'), self.mPlayerName)
    end
    return self.mFreeKickContent
end

---@return TABLE.CFG_PROMPTWORD 踢出公会需要花费二次弹窗
function UIGuildTipsPanel:GetUnionKickCostTips()
    if self.mKickCostUnionTipsInfo == nil then
        ___, self.mKickCostUnionTipsInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(44)
    end
    return self.mKickCostUnionTipsInfo
end

---@return string 获取帮会花费踢人二次弹窗描述
function UIGuildTipsPanel:GetUnionKickCostContent()
    if self.mFreeKickCost == nil and self:GetUnionKickCostTips() then
        self.mFreeKickCost = string.format(self:GetUnionKickCostTips().des, self.mUnionKickCost, self.mUnionKickCostName)
    end
    return self.mFreeKickCost
end

---@return string 获取帮会花费踢人货币不足提示
function UIGuildTipsPanel:GetCostKickNotEnoughDes()
    if self.mCostKickNotEnoughDes == nil then
        local res, info = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(156)
        if res then
            self.mCostKickNotEnoughDes = string.format(info.content, self.mUnionKickCostName)
        end
    end
    return self.mCostKickNotEnoughDes
end

---申请入会
function UIGuildTipsPanel:ApplyAddUnion()
    networkRequest.ReqJoinOrWithdrawUnion(UIGuildTipsPanel.GuildID, 1)
    UIGuildTipsPanel.ClosePanel()
end

---点击确认设置职位
function UIGuildTipsPanel.OnConfirmButtonClicked(go)
    if UIGuildTipsPanel.mCurrentChoose == LuaEnumGuildPosType.President then
        if UIGuildTipsPanel.mTransferUnionTipsInfo then
            --二次弹框确认
            local AdjustInfo = {
                Title = UIGuildTipsPanel.mTransferUnionTipsInfo.title,
                LeftDescription = UIGuildTipsPanel.mTransferUnionTipsInfo.leftButton,
                RightDescription = UIGuildTipsPanel.mTransferUnionTipsInfo.rightButton,
                Content = string.gsub(UIGuildTipsPanel.mTransferUnionTipsInfo.des, "\\n", '\n'),
                IsClose = false,
                ID = UIGuildTipsPanel.mTransferUnionTipsInfo.id,
                CallBack = function(panel)
                    UIGuildTipsPanel.ConfirmAdjustPos(panel)
                end
            }
            uimanager:CreatePanel("UIPromptPanel", nil, AdjustInfo)
        end
    else
        if UIGuildTipsPanel.mCurrentChoose then
            if (UIGuildTipsPanel.baseInfo ~= nil) then
                networkRequest.ReqChangePosition(UIGuildTipsPanel.baseInfo.ID, UIGuildTipsPanel.mCurrentChoose)
            else
                networkRequest.ReqChangePosition(UIGuildTipsPanel.roleId, UIGuildTipsPanel.mCurrentChoose)
            end
            UIGuildTipsPanel.ClosePanel()
        else
            Utility.ShowPopoTips(go, nil, 252)
        end
    end
end

---确认转让会长
---@param panel UIPromptPanel
function UIGuildTipsPanel.ConfirmAdjustPos(panel)
    if UIGuildTipsPanel:GetUnionInfoV2() and UIGuildTipsPanel:GetUnionInfoV2().UnionInfo.unionInfo.isImpeachment then
        Utility.ShowPopoTips(panel.GetCenterButton_GameObject(), nil, 232)
        return
    end
    if not UIGuildTipsPanel.curIsOnLine then
        Utility.ShowPopoTips(panel.GetCenterButton_GameObject(), nil, 271)
        return
    end

    if (UIGuildTipsPanel.baseInfo ~= nil) then
        networkRequest.ReqAssignmentMonster(UIGuildTipsPanel.baseInfo.ID, 20)
    else
        networkRequest.ReqAssignmentMonster(UIGuildTipsPanel.roleId, 20)
    end
    CS.Utility.ShowTips("确认转让会长")
    uimanager:ClosePanel("UIPromptPanel")
    UIGuildTipsPanel.ClosePanel()
end

---确认踢出公会
function UIGuildTipsPanel.ConfirmKick()
    local id
    if (UIGuildTipsPanel.baseInfo ~= nil) then
        id = UIGuildTipsPanel.baseInfo.ID
    else
        id = UIGuildTipsPanel.roleId
    end
    networkRequest.ReqKickOutGuild(id)
    UIGuildTipsPanel.ClosePanel()
end

---保存查看玩家回溯数据
function UIGuildTipsPanel:SaveViewPlayerBackData()
    ---@type UIGuildPanel
    local panel = uimanager:GetPanel("UIGuildPanel")
    if panel then
        if panel.mCurrentPanelType == LuaEnumGuildPanelType.GuildMember then
            uiStaticParameter.mUnionMemberOpenViewPerson = true
        elseif panel.mCurrentPanelType == LuaEnumGuildPanelType.GuildInfo then
            uiStaticParameter.mUnionRedPackOpenViewPerson = true
            uimanager:ClosePanel("UIGuildRedPacketPanel")
        end
    end
end

--endregion

--endregion

--region otherFunc

function UIGuildTipsPanel.CheckIsShowBubbleTips(go)
    if go == nil then
        return false
    end
    if not UIGuildTipsPanel.curIsOnLine then
        Utility.ShowPopoTips(go, nil, 268, 'UIGuildTipsPanel')
        return true
    end
    return false
end

--是否显示上方箭头
function UIGuildTipsPanel.IsShowArrow(panelID)
    return panelID == LuaEnumPanelIDType.ServantHeadPanel or
            panelID == LuaEnumPanelIDType.MonsterHeadPanel or
            UIGuildTipsPanel.showArrow
end

--endregion

--region onDestroy
function ondestroy()
    if UIGuildTipsPanel.delayRefresh ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(UIGuildTipsPanel.delayRefresh)
        UIGuildTipsPanel.delayRefresh = nil
    end
end
--endregion

return UIGuildTipsPanel