---仇人单元模板
local UIHatredPlayerUnitTemplate = {}

--region 初始化

function UIHatredPlayerUnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
    self:BindNetMessage()
end
--初始化变量
function UIHatredPlayerUnitTemplate:InitParameters()
    self.id = 0
    self.info = nil
    self.temp = {}
    self.mapNpcid = 0
    self.callBack = nil
    self.btnTemp = nil
end

function UIHatredPlayerUnitTemplate:InitComponents()
    ---@type Top_UISprite icon
    self.headicon = self:Get("headicon", "Top_UISprite")
    ---@type Top_UILabel name
    self.name = self:Get("name", "Top_UILabel")
    ---@type Top_UILabel 等级
    --self.level = self:Get("level","Top_UILabel")
    ---@type Top_UISprite 黑心
    self.hatred = self:Get("hatred", "Top_UISprite")
    ---@type Top_UILabel 仇恨值
    self.value = self:Get("hatred/value", "Top_UILabel")
    ---@type Top_UILabel 仇恨级别
    self.hatredlevel = self:Get("hatredlevel", "Top_UILabel")
    ---@type Top_UISprite 追踪
    self.trackBack = self:Get("btn_track", "GameObject")
    ---@type UnityEngine.GameObject 悬赏按钮
    self.btn_arrest = self:Get("btn_arrest", "GameObject")
    ---@type UnityEngine.GameObject 底
    self.background = self:Get("background", "GameObject")
    ---@type UnityEngine.GameObject   按钮列表
    self.btnGridGo = self:Get("btnTemplat", "GameObject")
    ---@type Top_UISprite   同会标志
    self.sameguild = self:Get("sameguild", "Top_UISprite")
end

function UIHatredPlayerUnitTemplate:BindUIMessage()
    --点击追踪事件
    CS.UIEventListener.Get(self.trackBack).LuaEventTable = self
    CS.UIEventListener.Get(self.trackBack).OnClickLuaDelegate = self.OnClickbtn_track
    --点击悬赏事件
    CS.UIEventListener.Get(self.btn_arrest).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_arrest).OnClickLuaDelegate = self.OnClickbtn_arrest
    --点击模板事件
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClickGo
end

function UIHatredPlayerUnitTemplate:BindNetMessage()

end

--endregion

--region Show
---@param customData table
---@param customData.info CS.friendV2.FriendInfo 仇人信息
function UIHatredPlayerUnitTemplate:SetTemplate(info, index, clickCallBack, mapNpcid)
    if info then
        self.info = info
        self.id = info.rid
        if (info.hostId == 0) then
            self.name.text = info.name
        else
            self.name.text = info.name .. luaclass.RemoteHostDataClass:GetLianFuPrefixNameByHostId(info.hostId)
        end
        local friendLoverNum = info.friendLove < 0 and -info.friendLove or info.friendLove
        self.value.text = tostring(friendLoverNum)
        self.headicon.spriteName = 'headicon' .. tostring(info.sex) .. tostring(info.career)
        local hateValue = CS.CSScene.MainPlayerInfo.FriendInfoV2:GetRankNameForHateValue(friendLoverNum)
        hateValue = hateValue == nil and '' or hateValue
        self.hatredlevel.text = hateValue
        self.background:SetActive(index % 2 == 0)
        self.temp.data = info
        self.temp.panelType = 1
        self.btnGridGo:SetActive(false)
        self.callBack = clickCallBack
        self.mapNpcid = mapNpcid == nil and 0 or mapNpcid
        if self.btnTemp == nil then
            self.btnTemp = templatemanager.GetNewTemplate(self.btnGridGo, luaComponentTemplates.UIArrestAllBtnTemplate)
        end
        self.btnTemp:SetTemplate(self.temp)
        self.SetWidgetUpdata = CS.ListUpdateItem(2, nil, function()
            CS.CSListUpdateMgr.Instance:Remove(self.SetWidgetUpdata)
            self.SetWidgetUpdata = nil
            if self.go ~= nil and not CS.StaticUtility.IsNull(self.go) then
                self.hatredlevel:UpdateAnchors()
            end
        end, false)
        CS.CSListUpdateMgr.Instance:Add(self.SetWidgetUpdata)
        self:RefreshUninHostility(info.rid)
    end

end

function UIHatredPlayerUnitTemplate:ChangeFriendLove(friendlove)
    local friendLoverNum = friendlove < 0 and -friendlove or friendlove
    self.value.text = tostring(friendLoverNum)
    self.hatredlevel.text = CS.CSScene.MainPlayerInfo.FriendInfoV2:GetRankNameForHateValue(friendLoverNum)
end

--endregion


--region UI函数监听
--点击追踪函数
---@param go UnityEngine.GameObject
function UIHatredPlayerUnitTemplate:OnClickbtn_track(go)
    networkRequest.ReqLastEnemyPosition(self.id)
end

--点击悬赏函数
---@param go UnityEngine.GameObject
function UIHatredPlayerUnitTemplate:OnClickbtn_arrest(go)
    self:ShowTips()
    --[[
        --打开悬赏面板
        local info = {}
        info.name = self.info.name
        info.id = self.id
        info.mapNpcId = self.mapNpcid
        uimanager:CreatePanel("UIArrestPublishPromptPanel", nil, info)
        ]]--
end

--点击模板函数
function UIHatredPlayerUnitTemplate:OnClickGo(go)
    --弹出按钮列表
    --if self.callBack then
    --    self.callBack()
    --endUIGuildTipsPanel
    --弹出信息面板
    uimanager:CreatePanel("UIGuildTipsPanel", nil, {
        panelType = LuaEnumPanelIDType.HatredHeadPanel,
        roleId = self.id,
        roleName = self.info.name,
        roleSex = self.info.sex,
        roleCareer = self.info.career
    })
end

--endregion


--region otherFunction

function UIHatredPlayerUnitTemplate:SetShowTemplate(isOpen)
    if isOpen then
        self.btnGridGo:SetActive(not self.btnGridGo.activeSelf)
    else
        self.btnGridGo:SetActive(isOpen)
    end
end

function UIHatredPlayerUnitTemplate:ShowTips()
    if self.info == nil then
        return
    end
    local isFind, info = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(67)
    if isFind then
        local list = CS.Cfg_GlobalTableManager.Instance:GetNeedCoinList()
        if list.Count < 3 then
            return
        end
        local needInfo = nil
        local needID = 0
        local needCount = 0
        if list.Count >= 4 then
            --判断悬赏令
            needInfo = string.Split(list[4], '#')
            needID = tonumber(needInfo[2])
            needCount = tonumber(needInfo[1])
            local hasCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(needID)
            if needCount > hasCount then
                needInfo = string.Split(list[1], '#')
                needID = tonumber(needInfo[2])
            end
        else
            needInfo = string.Split(list[1], '#')
            needID = tonumber(needInfo[2])
        end
        needCount = tonumber(needInfo[1])
        local coinName = CS.Cfg_ItemsTableManager.Instance:GetItemName(needID)
        local temp = {}
        temp.IsClose = false
        temp.IsShowGoldLabel = true
        temp.Content = string.format(info.des, needCount, coinName)
        temp.Content = string.gsub(temp.Content, '\\n', '\n')
        temp.LeftDescription = info.leftButton
        temp.RightDescription = info.rightButton
        temp.ID = info.id
        temp.listenArrestCode = true
        isFind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(needID)
        if isFind then
            temp.GoldIcon = info.icon
        end
        temp.GoldCount = needCount
        temp.CallBack = function(go)
            if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                networkRequest.ReqPublishOfferShare(self.id, nil, self.info.name, self.mapNpcid)
            else
                networkRequest.ReqPublishOffer(self.id, nil, self.info.name, self.mapNpcid)
            end
        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end

---刷新行会敌对信息
function UIHatredPlayerUnitTemplate:RefreshUninHostility(playerID)
    local number = self:IsUninHostility(playerID)
    self.sameguild.gameObject:SetActive(number == 1)
    self.sameguild:UpdateAnchors()
end
---是否是敌对帮会
---return 0 玩家无行会 1 同帮 2敌帮
function UIHatredPlayerUnitTemplate:IsUninHostility(playerID)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.UnionInfoV2 == nil then
        return 0
    end
    local UnionInfoV2 = CS.CSScene.MainPlayerInfo.UnionInfoV2

    if UnionInfoV2.UnionInfo == nil or UnionInfoV2.UnionInfo.unionInfo == nil then
        return 0
    end
    if UnionInfoV2.UnionMember == nil then
        return 2
    end
    for i = 0, UnionInfoV2.UnionMember.Count - 1 do
        if UnionInfoV2.UnionMember[i].roleId == playerID then
            return 1
        end
    end
    return 2
end

--endregion

function UIHatredPlayerUnitTemplate:OnDestroy()
    if self.SetWidgetUpdata ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.SetWidgetUpdata)
        self.SetWidgetUpdata = nil
    end
end

return UIHatredPlayerUnitTemplate