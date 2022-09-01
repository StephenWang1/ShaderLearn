---@class UIArrestPanelUniversalUnitTemplate 悬赏通用格子模板
local UIArrestPanelUniversalUnitTemplate = {}

--region 初始化

function UIArrestPanelUniversalUnitTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
    self:InitParameters()
end

---初始化变量
---@private
function UIArrestPanelUniversalUnitTemplate:InitParameters()
    self.arrestVO = nil
    self.callBack = nil
    self.temp = {}
    self.mapNpcId = 0
    self.origionTextPoint = self.monsterState.transform.localPosition
    self.changeTextPoint = CS.UnityEngine.Vector3(self.origionTextPoint.x, self.origionTextPoint.y - 15, self.origionTextPoint.z)

    self.origionNamePoint = self.name.transform.localPosition
    self.changeNamePoint = CS.UnityEngine.Vector3(self.origionNamePoint.x, self.origionNamePoint.y - 11, self.origionNamePoint.z)
end

function UIArrestPanelUniversalUnitTemplate:InitComponents()
    --region 通用
    ---@type Top_UISprite 头像
    self.headicon = self:Get("headicon", "Top_UISprite")
    ---@type Top_UILabel top label
    self.name = self:Get("name", "Top_UILabel")
    ---@type Top_UISprite 背景
    self.bg = self:Get("background", "Top_UISprite")
    ---@type UnityEngine.GameObject 按钮列表
    self.btnGridGo = self:Get("btnTemplat", "GameObject")
    --endregion

    --region 全服
    ---@type UnityEngine.GameObject
    self.WordView = self:Get("WordView", "GameObject")
    ---@type Top_UISprite 赏金
    self.hatred = self:Get("WordView/hatred", "Top_UISprite")
    ---@type UILabel 赏金
    self.hatredValue = self:Get("WordView/hatred/value", "Top_UILabel")
    ---@type Top_UILabel 状态（进行中）
    self.wordState = self:Get("WordView/state", "Top_UILabel")
    ---@type Top_UILabel 时间
    self.wordTime = self:Get("WordView/time", "Top_UILabel")
    ---@type Top_UISprite 通缉标识
    self.wanted = self:Get("wanted", "Top_UISprite")

    --endregion

    --region 个人
    ---@type UnityEngine.GameObject
    self.PlayerView = self:Get("PlayerView", "GameObject")
    ---@type UnityEngine.GameObject 撤销悬赏
    self.btn_unarrest = self:Get("PlayerView/btn_unarrest", "GameObject")
    ---@type Top_UILabel
    self.personalTime = self:Get("PlayerView/time", "Top_UILabel")
    ---@type Top_UILabel 完成日期
    self.day = self:Get("PlayerView/day", "Top_UILabel")
    ---@type Top_UILabel 完成者名称
    self.completeplayer = self:Get("PlayerView/completeplayer", "Top_UILabel")
    --endregion

    --region 怪物
    ---@type UnityEngine.GameObject
    self.MonsterView = self:Get("MonsterView", "GameObject")
    ---@type Top_UILabel 目标地图 [878787]目标地点：[dde6eb]沃玛寺庙
    self.mapname = self:Get("MonsterView/mapname", "Top_UILabel")
    ---@type Top_UILabel 完成人数
    self.count = self:Get("MonsterView/count", "Top_UILabel")
    ---@type Top_UILabel 状态（进行中）
    self.monsterState = self:Get("MonsterView/state", "Top_UILabel")
    ---@type Top_UILabel 倒计时
    self.monsterTime = self:Get("MonsterView/time", "Top_UILabel")
    ---@type UnityEngine.GameObject 接取
    self.getBtn = self:Get("MonsterView/btn", "GameObject")
    ---@type Top_UISprite 按钮底图
    self.btnBG = self:Get("MonsterView/btn/Background", "Top_UISprite")
    ---@type Top_UILabel 按钮文本（暂不需要）
    self.btnLabel = self:Get("MonsterView/btn/Label", "Top_UILabel")
    ---@type Top_UISprite 赏金
    self.monsterHatred = self:Get("MonsterView/hatred", "Top_UISprite")
    ---@type UILabel 赏金
    self.monsterHatredValue = self:Get("MonsterView/hatred/value", "Top_UILabel")
    --endregion
end

function UIArrestPanelUniversalUnitTemplate:BindUIMessage()
    --点击go事件
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnGoBtnClick
    --点击撤销悬赏
    CS.UIEventListener.Get(self.btn_unarrest).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_unarrest).OnClickLuaDelegate = self.OnClickbtn_unarrest
    --点击接取
    CS.UIEventListener.Get(self.getBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.getBtn).OnClickLuaDelegate = self.OnClickbtn_get
end

--endregion

--region Show
---@field
---@param customData.mapNpcId number
---@param customdata.data IArrestVO 悬赏数据类型
---@param customdata.clickCallBack function 点击回调
---end
function UIArrestPanelUniversalUnitTemplate:SetTemplate(customData)
    if customData then
        self.data = customData
        self.arrestVO = customData.data
        self.callBack = customData.clickCallBack
        local btnTempInfo = {}
        btnTempInfo.data = customData.data
        btnTempInfo.panelType = 2
        if self.btnGridGo ~= nil then
            if self.btnTemp == nil then
                self.btnTemp = templatemanager.GetNewTemplate(self.btnGridGo, luaComponentTemplates.UIArrestAllBtnTemplate)
            end
            self.btnTemp:SetTemplate(btnTempInfo)
        end

        if self.arrestVO ~= nil then
            self:RefreshView()
        end
    end
end

function UIArrestPanelUniversalUnitTemplate:RefreshView()
    self.MonsterView:SetActive(self.arrestVO.arrestType == CS.ArrestTypeEnum.Monster)
    self.WordView:SetActive(self.arrestVO.arrestType == CS.ArrestTypeEnum.NormalWord or self.arrestVO.arrestType == CS.ArrestTypeEnum.System)
    self.PlayerView:SetActive(self.arrestVO.arrestType == CS.ArrestTypeEnum.NormalPersonal)
    self.headicon.spriteName = self.arrestVO:GetHeadIcon()
    self.name.text = self.arrestVO.arrestName
    self.name.transform.localPosition = self.changeNamePoint
    if self.data.index ~= nil and self.data.index ~= 0 then
        self.bg.alpha = self.data.index % 2 == 0 and 1 or 0.01
    end
    self:ShowPlayerArrest()
    self:ShowWordArrest()
    self:ShowMonsterArrest()
end

---玩家悬赏
function UIArrestPanelUniversalUnitTemplate:ShowPlayerArrest()
    if self.arrestVO.arrestType ~= CS.ArrestTypeEnum.NormalPersonal then
        return
    end
    self.wanted.gameObject:SetActive(false)
    self.day.gameObject:SetActive(self.arrestVO.arrestState == CS.ArrestStateEnum.Finish)
    self.completeplayer.gameObject:SetActive(self.arrestVO.arrestState == CS.ArrestStateEnum.Finish)
    self.day.text = self.arrestVO.finisherName
    local year, month, data = self.arrestVO:GetFinishTimeOfDate()
    if self.arrestVO.arrestState == CS.ArrestStateEnum.Finish then
        self.name.transform.localPosition = self.origionNamePoint
    end
    self.btn_unarrest:SetActive(true)
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
    if self.personalTime ~= nil then
        if self.arrestVO:GetRemainTime() ~= 0 and self.arrestVO.arrestState == CS.ArrestStateEnum.OnGoing then
            self.IenumRefreshTime = StartCoroutine(UIArrestPanelUniversalUnitTemplate.IEnumRefreshTime, self, self.arrestVO:GetRemainTime(), self.personalTime)
        else
            self.personalTime.text = ''
        end
    end
end

---世界悬赏
function UIArrestPanelUniversalUnitTemplate:ShowWordArrest()
    if self.arrestVO.arrestType ~= CS.ArrestTypeEnum.NormalWord and self.arrestVO.arrestType ~= CS.ArrestTypeEnum.System then
        return
    end
    self.hatredValue.text = tostring(self.arrestVO.reward)
    self.wanted.gameObject:SetActive(self.arrestVO.isWanted)
    self.delayRefresh = CS.CSListUpdateMgr.Add(100, nil, function()
        if CS.StaticUtility.IsNull(self.go) then
            return
        end
        CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
        self.delayRefresh = nil
        self.wanted:UpdateAnchors()
    end, true)
    self.wordState.text = self.arrestVO.arrestState == CS.ArrestStateEnum.OnGoing and '进行中' or ''
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
    if self.wordTime ~= nil then
        if self.arrestVO:GetRemainTime() ~= 0 and self.arrestVO.arrestState == CS.ArrestStateEnum.OnGoing then
            self.IenumRefreshTime = StartCoroutine(UIArrestPanelUniversalUnitTemplate.IEnumRefreshTime, self, self.arrestVO:GetRemainTime(), self.wordTime)
        else
            self.wordTime.text = ''
        end
    end
end

---怪物悬赏
function UIArrestPanelUniversalUnitTemplate:ShowMonsterArrest()
    if self.arrestVO.arrestType ~= CS.ArrestTypeEnum.Monster then
        return
    end
    self.monsterRewardList = {}
    local rewardInfo = self.arrestVO:GetRewardInfo()
    if rewardInfo ~= nil and rewardInfo.Length > 2 then
        local temp = {}
        temp.itemId = rewardInfo[1]
        temp.count = rewardInfo[2]
        table.insert(self.monsterRewardList, temp)
        self.monsterHatredValue.text = tostring(rewardInfo[2])
    end
    self.wanted.gameObject:SetActive(false)
    local color = self.arrestVO.killCount < self.arrestVO.targetKillCount and luaEnumColorType.Red or ''
    self.name.text = '击杀' .. self.arrestVO.arrestName .. '[-](' .. color .. tostring(self.arrestVO.killCount) .. '[-]/' .. tostring(self.arrestVO.targetKillCount) .. ')'
    self.name.transform.localPosition = self.origionNamePoint
    --self.mapname.text = "" --luaEnumColorType.Gray .. '目标地点  ' .. luaEnumColorType.White .. self.arrestVO.mapName
    self.count.text = luaEnumColorType.Gray .. '完成人数  ' .. luaEnumColorType.White .. self.arrestVO.completeNum
    self.monsterState.text = self.arrestVO.arrestState == CS.ArrestStateEnum.OnGoing and '进行中' or ''
    if CS.CSScene.MainPlayerInfo.FriendInfoV2 ~= nil and CS.CSScene.MainPlayerInfo.FriendInfoV2.RemainMonsterArrestCount == 0 then
        self.btnBG.color = CS.UnityEngine.Color.gray
    end
    self.getBtn:SetActive(self.arrestVO.arrestState == CS.ArrestStateEnum.Submit or self.arrestVO.arrestState == CS.ArrestStateEnum.Received)
    if self.arrestVO.arrestState == CS.ArrestStateEnum.Received then
        self.btnLabel.text = '接取'
    elseif self.arrestVO.arrestState == CS.ArrestStateEnum.Submit then
        self.btnLabel.text = '交付'
    end
    self.monsterState.transform.localPosition = self.origionTextPoint
    if self.arrestVO.arrestState == CS.ArrestStateEnum.Finish then
        self.monsterState.text = '已悬赏'
    elseif self.arrestVO.arrestState == CS.ArrestStateEnum.Expired then
        self.monsterState.text = luaEnumColorType.Red .. '已结束'
        self.monsterState.transform.localPosition = self.changeTextPoint
    elseif self.arrestVO.arrestState == CS.ArrestStateEnum.OnGoing then
        self.monsterState.text = '进行中'
    end
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
    if self.monsterTime ~= nil then
        if self.arrestVO.arrestState ~= CS.ArrestStateEnum.Expired and self.arrestVO:GetRemainTime() > 0 then
            self.monsterTime.gameObject:SetActive(true)
            self.IenumRefreshTime = StartCoroutine(UIArrestPanelUniversalUnitTemplate.IEnumRefreshTime, self, self.arrestVO:GetRemainTime(), self.monsterTime)
        else
            self.monsterTime.text = ''
            --self.monsterTime.gameObject:SetActive(false)
        end
    end
end


--endregion


--region UI函数监听

function UIArrestPanelUniversalUnitTemplate:OnGoBtnClick(go)
    if self.arrestVO == nil then
        return
    end
    if self.arrestVO.arrestType == CS.ArrestTypeEnum.Monster then
        if self.arrestVO.arrestState == CS.ArrestStateEnum.OnGoing then
            CS.CSScene.MainPlayerInfo.AsyncOperationController.ArrestFindNPC:DoOperation(self.arrestVO)
            --if self.arrestVO ~= nil and self.arrestVO.mapTabel ~= nil then
            --    --判断是否在同一地图
            --    if self.arrestVO.mapTabel.id == CS.CSScene:getMapID() then
            --        -- CS.Utility.ShowTips("已在当前地图", 1.5, CS.ColorType.Yellow)
            --    else
            --        local isFind = CS.CSPathFinderManager.Instance:SetFixedDestination(self.arrestVO.mapTabel.id, CS.SFMiscBase.Dot2(1, 1), CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardPoint, 2)
            --        if not isFind then
            --            if isOpenLog then
            --                luaDebug.LogError("寻路失败请查询")
            --            end
            --        end
            --    end
            --end
        end
        return
    end
    --if self.callBack then
    --    self.callBack()
    --end

    uimanager:CreatePanel("UIGuildTipsPanel", nil, {
        panelType = LuaEnumPanelIDType.ArrestHeadPanel,
        roleId = self.arrestVO.prisonerID,
        roleName = self.arrestVO.arrestName,
        roleSex = self.arrestVO.prisonerSex,
        roleCareer = self.arrestVO.prisonerCareer
    })

end

---点击撤销悬赏
function UIArrestPanelUniversalUnitTemplate:OnClickbtn_unarrest()
    if self.arrestVO == nil then
        return
    end

    if self.arrestVO.arrestType == CS.ArrestTypeEnum.NormalPersonal then
        self:ShowUnarrestTips()
    end
end

---点击接取
function UIArrestPanelUniversalUnitTemplate:OnClickbtn_get(go)
    if self.arrestVO.arrestType ~= CS.ArrestTypeEnum.Monster then
        return
    end
    if self.arrestVO.arrestState == CS.ArrestStateEnum.Received then
        --人物等级限制
        if CS.CSScene.MainPlayerInfo.FriendInfoV2 ~= nil and CS.CSScene.MainPlayerInfo.FriendInfoV2.MonsterArRreceivLevel > CS.CSScene.MainPlayerInfo.Level then
            Utility.ShowPopoTips(go.transform, nil, 203)
            return
        end
        -- 地图限制
        if self.arrestVO.mapTabel ~= nil and not CS.Cfg_MapTableManager.Instance:IsMeetMapCondition(self.arrestVO.mapTabel.id) then
            Utility.ShowPopoTips(go.transform, nil, 204)
            return
        end
        --接取次数
        if CS.CSScene.MainPlayerInfo.FriendInfoV2 ~= nil and CS.CSScene.MainPlayerInfo.FriendInfoV2.RemainMonsterArrestCount == 0 then
            Utility.ShowPopoTips(go.transform, nil, 205)
            return
        end
        networkRequest.ReqPickUpMonsterOffer(self.arrestVO.id)
    elseif self.arrestVO.arrestState == CS.ArrestStateEnum.Submit then
        networkRequest.ReqSubmitMonsterOffer(self.arrestVO.id)
    end
end

--endregion


--region otherFunction
function UIArrestPanelUniversalUnitTemplate:IEnumRefreshTime(time, label)
    if label == nil or CS.StaticUtility.IsNull(label) then
        return
    end

    local isRefresh = true
    local refreshTime = time
    local defaultStr = luaEnumColorType.TimeCountRed
    local isMonsterRed = false
    while isRefresh do
        if refreshTime <= 0 then
            isRefresh = false

            label.text = self.arrestVO.arrestType == CS.ArrestTypeEnum.Monster and "00:00" or defaultStr .. "00:00:00"
        end
        local hour, minute, second = Utility.MillisecondToFormatTime(refreshTime)
        local str = self.arrestVO.arrestType == CS.ArrestTypeEnum.Monster and string.format("%02.0f:%02.0f", minute, second) .. "后结束" or self:GetTimeStr(refreshTime)

        if self.arrestVO.arrestType == CS.ArrestTypeEnum.Monster and minute < 2 and not isMonsterRed then
            isMonsterRed = true
            defaultStr = luaEnumColorType.TimeCountRed
        end
        label.text = defaultStr .. str
        refreshTime = refreshTime - 1000
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end

function UIArrestPanelUniversalUnitTemplate:GetTimeStr(millisecond)
    local str
    local secondTemp = millisecond / 1000
    if (secondTemp < 86399) then
        str = string.format("%02.0f:%02.0f:%02.0f", secondTemp / 3600, (secondTemp % 3600) / 60, (secondTemp % 3600) % 60)
    else
        str = string.format("%1.0f天%02.0f小时", math.floor(secondTemp / 86400), math.floor((secondTemp % 86400) / 3600))
    end
    return str .. "后结束"
end

function UIArrestPanelUniversalUnitTemplate:SetShowTemplate(isOpen)
    if isOpen then
        self.btnGridGo:SetActive(not self.btnGridGo.activeSelf)
    else
        self.btnGridGo:SetActive(isOpen)
    end
end

--撤销悬赏二次确认
function UIArrestPanelUniversalUnitTemplate:ShowUnarrestTips()
    local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(71)
    if isFind then
        local temp = {}
        temp.Content = info.des
        temp.LeftDescription = info.leftButton
        temp.RightDescription = info.rightButton
        temp.ID = 71
        temp.CallBack = function()
            --发送通行证为0指令
            --Utility.ReqExitDuplicate()
            if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                networkRequest.ReqWithdrawOfferShare(self.arrestVO.prisonerID, self.data.mapNpcId)
            else
                networkRequest.ReqWithdrawOffer(self.arrestVO.prisonerID, self.data.mapNpcId)
            end
        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end


--endregion

function UIArrestPanelUniversalUnitTemplate:OnDestroy()
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end

    if self.delayRefresh ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
        self.delayRefresh = nil
    end
end

return UIArrestPanelUniversalUnitTemplate