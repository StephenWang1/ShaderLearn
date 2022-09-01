---@class UIServantPracticePanel:UIBase 灵兽修炼面板
local UIServantPracticePanel = {}

--region 局部变量定义
---当前显示灵兽信息
UIServantPracticePanel.mCurrentShowServants = nil

---@type number 当前修炼中灵兽类型
UIServantPracticePanel.mCurrentPracticeServant = nil
---@type number 当前选中灵兽类型
UIServantPracticePanel.mCurrentSelectServant = nil
---@type boolean 当前是否创建过灵兽模型
UIServantPracticePanel.mHasCreateServantModel = false
--endregion

--region 组件
---@return UnityEngine.GameObject 帮助按钮
function UIServantPracticePanel:GetHelpBtn_Go()
    if self.mHelpBtn_Go == nil then
        self.mHelpBtn_Go = self:GetCurComp("WidgetRoot/Main/events/btn_help", "GameObject")
    end
    return self.mHelpBtn_Go
end

---@return UICountdownLabel 倒计时文本
function UIServantPracticePanel:GetTimeCountLabel_UICountdownLabel()
    if self.mTimeCountLb == nil then
        self.mTimeCountLb = self:GetCurComp("WidgetRoot/Main/events/TimeCount", "UICountdownLabel")
    end
    return self.mTimeCountLb
end

function UIServantPracticePanel.ObservationModel()
    if UIServantPracticePanel.mObservationModel == nil then
        UIServantPracticePanel.mObservationModel = CS.ObservationModel()
    end
    return UIServantPracticePanel.mObservationModel
end

---灵兽修炼地图
---@return UIServantPracticeMapTemplate
function UIServantPracticePanel:GetServantPracticeMap()
    if self.mServantPracticeMap == nil then
        local mapGO = self:GetCurComp("WidgetRoot/Main/map", "GameObject")
        if CS.StaticUtility.IsNull(mapGO) == false then
            self.mServantPracticeMap = templatemanager.GetNewTemplate(mapGO, luaComponentTemplates.UIServantPracticeMapTemplate, UIServantPracticePanel)
        end
    end
    return self.mServantPracticeMap
end

---@return UnityEngine.GameObject 买活按钮
function UIServantPracticePanel:GetRevivalBtn_GO()
    if self.mRevivalBtn == nil then
        self.mRevivalBtn = self:GetCurComp("WidgetRoot/Main/events/btn_ revive", "GameObject")
    end
    return self.mRevivalBtn
end

---@return UISprite 买活花费图片
function UIServantPracticePanel:GetRevivalCost_UISprite()
    if self.mRevivalCostSp == nil then
        self.mRevivalCostSp = self:GetCurComp("WidgetRoot/Main/events/btn_ revive/icon", "UISprite")
    end
    return self.mRevivalCostSp
end

---@return UILabel 买活花费数目
function UIServantPracticePanel:GetRevivalCost_UILabel()
    if self.mRevivalCostLb == nil then
        self.mRevivalCostLb = self:GetCurComp("WidgetRoot/Main/events/btn_ revive/value", "UILabel")
    end
    return self.mRevivalCostLb
end

---@return UnityEngine.GameObject
function UIServantPracticePanel:GetRedPointEffect_GameObject()
    if self.mPracticeEffectGo == nil then
        self.mPracticeEffectGo = self:GetCurComp("WidgetRoot/Main/events/btn_practice/effect", "GameObject")
    end
    return self.mPracticeEffectGo
end
--endregion

--region 初始化
function UIServantPracticePanel:InitComponents()
    ---top
    ---修炼点背景
    self.PracticeBG = self:GetCurComp("WidgetRoot/Main/view/PracticeLevel", "GameObject")
    ---修炼点
    self.PracticeLevel = self:GetCurComp("WidgetRoot/Main/view/PracticeLevel/Label", "UILabel")
    ---关闭按钮
    self.btn_close = self:GetCurComp("WidgetRoot/Main/window/left_main/events/btn_close", "GameObject")

    ---center
    ---模型根节点
    self.ModelRoot = self:GetCurComp("WidgetRoot/Main/view/ModelRoot", "GameObject")
    ---经验百分比
    self.expPool = self:GetCurComp("WidgetRoot/Main/view/Exp/practice/panel2/expPool", "UILabel")
    ---提取经验
    self.btn_GetExp = self:GetCurComp("WidgetRoot/Main/view/Exp/gettext", "GameObject")
    ---提取经验
    self.getExpBtn = self:GetCurComp("WidgetRoot/Main/view/Exp/get", "GameObject")
    ---经验红点
    self.ExpRedEffect = self:GetCurComp("WidgetRoot/Main/view/Exp/practice/Sprite1/effectRoot", "GameObject")
    ---提取经验
    self.ExpEffect = self:GetCurComp("WidgetRoot/Main/view/Exp/practice/Sprite1/effect2", "GameObject")
    ---经验特效根节点
    self.effectLoad = self:GetCurComp("WidgetRoot/Main/view/Exp/practice/Sprite2", "CSUIEffectLoad")
    ---球根节点
    self.Ball_Go = self:GetCurComp("WidgetRoot/Main/view/Exp/practice", "GameObject")
    ---球点击提取
    self.expBtnBall = self:GetCurComp("WidgetRoot/Main/view/Exp", "GameObject")

    ---幻兽1背景
    self.huanshou1_BG = self:GetCurComp("WidgetRoot/Main/view/Scroll View/huanshou/huanshou1/ModelBG", "GameObject")
    ---幻兽1名称
    self.huanshou1_Name = self:GetCurComp("WidgetRoot/Main/view/Scroll View/huanshou/huanshou1/ModelBG/TypeName", "UILabel")
    ---幻兽1类型
    self.huanshou1_Type = self:GetCurComp("WidgetRoot/Main/view/Scroll View/huanshou/huanshou1/ModelBG/TypeName/TypeTips", "UILabel")

    ---幻兽2背景
    self.huanshou2_BG = self:GetCurComp("WidgetRoot/Main/view/Scroll View/huanshou/huanshou2/ModelBG", "GameObject")
    ---幻兽2名称
    self.huanshou2_Name = self:GetCurComp("WidgetRoot/Main/view/Scroll View/huanshou/huanshou2/ModelBG/TypeName", "UILabel")
    ---幻兽2类型
    self.huanshou2_Type = self:GetCurComp("WidgetRoot/Main/view/Scroll View/huanshou/huanshou2/ModelBG/TypeName/TypeTips", "UILabel")

    ---幻兽3背景
    self.huanshou3_BG = self:GetCurComp("WidgetRoot/Main/view/Scroll View/huanshou/huanshou3/ModelBG", "GameObject")
    ---幻兽3名称
    self.huanshou3_Name = self:GetCurComp("WidgetRoot/Main/view/Scroll View/huanshou/huanshou3/ModelBG/TypeName", "UILabel")
    ---幻兽3类型
    self.huanshou3_Type = self:GetCurComp("WidgetRoot/Main/view/Scroll View/huanshou/huanshou3/ModelBG/TypeName/TypeTips", "UILabel")

    ---down
    ---修炼速度
    self.Speed = self:GetCurComp("WidgetRoot/Main/view/Speed", "UILabel")
    ---修炼按钮
    self.btn_practice = self:GetCurComp("WidgetRoot/Main/events/btn_practice", "GameObject")
    ---修炼按钮图片
    self.btn_practiceSprite = self:GetCurComp("WidgetRoot/Main/events/btn_practice", "UISprite")
    ---修炼按钮Label
    self.btn_practiceLabel = self:GetCurComp("WidgetRoot/Main/events/btn_practice/Label", "UILabel")
    ---修炼中图片
    ---@return UnityEngine.GameObject
    self.Practicing = self:GetCurComp("WidgetRoot/Main/view/Practicing", "GameObject")
    ---修炼位置
    ---@type UILabel
    self.location = self:GetCurComp("WidgetRoot/Main/view/location", "UILabel")
    ---切换修炼位置按钮
    self.locationBtn_add = self:GetCurComp("WidgetRoot/Main/view/location/btn_add", "GameObject")
end

function UIServantPracticePanel:InitOther()
    CS.UIEventListener.Get(self.btn_close).onClick = self.OnClickClose
    CS.UIEventListener.Get(self.getExpBtn).onClick = self.OnClickGetExp
    CS.UIEventListener.Get(self.expBtnBall).onClick = self.OnClickGetExp
    CS.UIEventListener.Get(self.btn_practice).onClick = self.OnClickPractice
    CS.UIEventListener.Get(self.PracticeBG).onClick = self.OnClickPracticeBG
    CS.UIEventListener.Get(self.locationBtn_add).onClick = self.OnClickLocationBtn_add
    CS.UIEventListener.Get(self:GetRevivalBtn_GO()).onClick = function(go)
        self:OnRevivalBtnClicked(go)
    end

    self:GetHelpBtn_Go():SetActive(true)
    CS.UIEventListener.Get(self:GetHelpBtn_Go()).onClick = function()
        self:OnHelpBtnClicked()
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, function(msgId, serverData)
        if serverData and serverData.type == luaEnumRspServerCommonType.ServantCultivate_Fly_Fail then
            self:GetServantPracticeMap():OnServerCoordSetFailed()
        end
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantCultivateInfoMessage, self.OnResServantCultivateInfoMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, self.OnBagItemChangeCallBack)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantLevelUpMessage, self.OnResServantLevelUpMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantReinUpMessage, self.OnResServantLevelUpMessage)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.OnClickSetServantPlaceTab, self.OnClickSetServantPlaceTab)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ServantPracticeGetExp, self.OnServantPracticeGetExp)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ServantPracticeEffectRefresh, self.OnServantPracticeEffectRefresh)

    UIServantPracticePanel.isStart = false
    networkRequest.ReqServantCultivateOpenDlg(1)
    networkRequest.ReqServantCultivateBegin(0)
end

function UIServantPracticePanel:NeedGetBtnShow()
    local PracticeNumber = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(LuaEnumCoinType.XiuLianDian)
    local PracticeProportion = CS.Cfg_GlobalTableManager.Instance.PracticeProportion
    if PracticeNumber == 0 then
        return false
    elseif PracticeProportion > self.nowExp then
        return false
    end
    return true
end

function UIServantPracticePanel:Init()
    self:InitComponents()
    self:InitOther()
    UIServantPracticePanel.nowExp = 0
    self.go.transform.localPosition = CS.UnityEngine.Vector3(160, 0, 0)
    self.btn_practice.gameObject:SetActive(false)
    self.Practicing.gameObject:SetActive(false)
    self.Speed.gameObject:SetActive(false)
    self.location.gameObject:SetActive(true)
    UIServantPracticePanel.Speed.text = ""
    UIServantPracticePanel.PracticeLevel.text = ""
    UIServantPracticePanel.expPool.text = "0%"
    ---是否在修炼中
    UIServantPracticePanel.IsCultivating = false
    self:RefreshRevivalInfo()
end

--- data servantV2.ServantInfo
function UIServantPracticePanel:Show()
    self.mCurrentSelectServant = nil--初始化设为没有选中数据
    self.mHasCreateServantModel = false
    -- 修炼经验池最大值
    UIServantPracticePanel.PracticeExpMax = CS.Cfg_GlobalTableManager.Instance.PracticeExpMax
    -- 修炼经验池存储经验最大值
    UIServantPracticePanel:GetPracticeSaveExpMax();
    -- 修炼等级系数
    UIServantPracticePanel.PracticeLevelCoefficient = CS.Cfg_GlobalTableManager.Instance.PracticeLevelCoefficient
    -- 修炼转生系数
    UIServantPracticePanel.PracticeReinCoefficient = CS.Cfg_GlobalTableManager.Instance.PracticeReinCoefficient
    UIServantPracticePanel.ServantPracticeTipNumber()
end

--获取灵兽修炼存储的最大值
function UIServantPracticePanel:GetPracticeSaveExpMax()
    local res, globalInfo = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22339)
    if res then
        -- 修炼经验池存储经验最大值
        UIServantPracticePanel.PracticeSaveExpMax = tonumber(globalInfo.value)
    else
        UIServantPracticePanel.PracticeSaveExpMax = UIServantPracticePanel.PracticeExpMax;
    end
end
function UIServantPracticePanel:GetPracticeSaveExpMax()
    local res, globalInfo = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22339)
    if res then
        -- 修炼经验池存储经验最大值
        UIServantPracticePanel.PracticeSaveExpMax = tonumber(globalInfo.value)
    else
        UIServantPracticePanel.PracticeSaveExpMax = UIServantPracticePanel.PracticeExpMax;
    end
end
--endregion

--region 刷新UI
---刷新UI
---@param data servantcultivateV2.resCultivateInfo
function UIServantPracticePanel:RefreshUI(data)
    if data == nil then
        UIServantPracticePanel.RefreshComponentShowingState()
        return
    end
    self.ClearCD = data.clearCD

    if data.status == 1 then
        UIServantPracticePanel.serverType = data.type
    else
        UIServantPracticePanel.serverType = -1
    end

    UIServantPracticePanel.RefreshExp(data.exp)
    UIServantPracticePanel.RefreshHuanShouInfo(UIServantPracticePanel.mHasCreateServantModel == false)
    self:RefreshPracticePoint(data)
end

---刷新经验
function UIServantPracticePanel.RefreshExp(dataExp)
    local exp = "0"
    exp = (dataExp / (UIServantPracticePanel.PracticeExpMax) * 100)
    exp = string.format("%.2f", exp)
    UIServantPracticePanel.nowExp = dataExp
    UIServantPracticePanel.expPool.text = exp .. "%"
    UIServantPracticePanel.Isfull = dataExp >= (UIServantPracticePanel.PracticeSaveExpMax)
    UIServantPracticePanel:RefreshBall(dataExp / UIServantPracticePanel.PracticeExpMax);

    local show = UIServantPracticePanel:NeedGetBtnShow()
    UIServantPracticePanel.getExpBtn:SetActive(show)
end

---刷新幻兽信息
---NowType 当前类型
---PracticeType 正在修炼类型
---refreshType 刷新类型 0客户端刷新  1服务器刷新
function UIServantPracticePanel.RefreshHuanShouInfo(isNeedRefreshModle)
    local showType = UIServantPracticePanel.mCurrentSelectServant
    UIServantPracticePanel.IsCultivating = showType == UIServantPracticePanel.mCurrentPracticeServant and UIServantPracticePanel.mCurrentPracticeServant ~= nil

    ---刷新灵兽修炼点
    UIServantPracticePanel.RefreshPracticeLevel()
    -- 刷新灵兽背景
    UIServantPracticePanel.RefreshHuanShouBgInfo(showType)
    local isfind, Servants = CS.CSScene.MainPlayerInfo.ServantInfoV2.Servants:TryGetValue(showType)
    -- 刷新修炼速度
    if isfind then
        UIServantPracticePanel.PracticeSpeed(Servants.level, Servants.rein)
    else
        UIServantPracticePanel.Speed.gameObject:SetActive(false)
    end
    if isNeedRefreshModle then
        -- 刷新模型
        UIServantPracticePanel.UpdateServantModel(UIServantPracticePanel.ModelRoot, Servants)
    end

    if showType == 1 then
        UIServantPracticePanel.SetHuanShouNameAndType(UIServantPracticePanel.huanshou1_Name, UIServantPracticePanel.huanshou1_Type, Servants)
    elseif showType == 2 then
        UIServantPracticePanel.SetHuanShouNameAndType(UIServantPracticePanel.huanshou2_Name, UIServantPracticePanel.huanshou2_Type, Servants)
    elseif showType == 3 then
        UIServantPracticePanel.SetHuanShouNameAndType(UIServantPracticePanel.huanshou3_Name, UIServantPracticePanel.huanshou3_Type, Servants)
    else
        UIServantPracticePanel.SetHuanShouNameAndType(UIServantPracticePanel.huanshou1_Name, UIServantPracticePanel.huanshou1_Type, Servants)
        UIServantPracticePanel.SetHuanShouNameAndType(UIServantPracticePanel.huanshou2_Name, UIServantPracticePanel.huanshou2_Type, Servants)
        UIServantPracticePanel.SetHuanShouNameAndType(UIServantPracticePanel.huanshou2_Name, UIServantPracticePanel.huanshou2_Type, Servants)
    end
    UIServantPracticePanel.RefreshComponentShowingState()
end

---刷新修炼点
function UIServantPracticePanel.RefreshPracticeLevel()
    local XiuLianDian = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(LuaEnumCoinType.XiuLianDian)
    local color = "[00ff00]x"
    if XiuLianDian == 0 then
        color = "[ff0000]x"
    end
    UIServantPracticePanel.PracticeLevel.text = color .. XiuLianDian
end

---刷新幻兽背景信息
function UIServantPracticePanel.RefreshHuanShouBgInfo(showType)
    UIServantPracticePanel.huanshou1_BG.gameObject:SetActive(showType == 1)
    UIServantPracticePanel.huanshou2_BG.gameObject:SetActive(showType == 2)
    UIServantPracticePanel.huanshou3_BG.gameObject:SetActive(showType == 3)
end

---刷新幻兽名称和状态
function UIServantPracticePanel.SetHuanShouNameAndType(nameLabel, TypeLabel, Servants)
    if Servants == nil then
        nameLabel.text = ""
        TypeLabel.text = ""
        UIServantPracticePanel.btn_practice.gameObject:SetActive(false)
        UIServantPracticePanel.Practicing.gameObject:SetActive(false)
        UIServantPracticePanel.RefreshComponentShowingState()
        return
    end
    UIServantPracticePanel.mCurrentShowServants = Servants
    local servantSeatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(Servants.type)
    if servantSeatData == nil then
        nameLabel.text = ""
        TypeLabel.text = ""
        UIServantPracticePanel.btn_practice.gameObject:SetActive(false)
        UIServantPracticePanel.Practicing.gameObject:SetActive(false)
        UIServantPracticePanel.RefreshComponentShowingState()
        return
    end
    local name = servantSeatData:GetServantName(false, true)
    if (UIServantPracticePanel.IsCultivating) then
        nameLabel.text = name .. "（修炼中）"
    else
        nameLabel.text = name
    end

    UIServantPracticePanel:RefreshBtnState(TypeLabel, Servants.type)
end

---刷新按钮状态
function UIServantPracticePanel:RefreshBtnState(TypeLabel, showType)
    local type = ""
    local btnlabel = "[FFCDA5]修炼"
    --local isPracticing = false
    local spriteName = "anniu2"
    self:GetTimeCountLabel_UICountdownLabel():StopCountDown()
    local isShowPracticeBtn = true--是否显示修炼按钮
    if self.IsCultivating then
        type = ""
        btnlabel = "[878787]停止修炼"
        --isPracticing = true
        spriteName = "anniu19"
        self:GetTimeCountLabel_UICountdownLabel().gameObject:SetActive(false)
        isShowPracticeBtn = true
        self:GetRevivalBtn_GO():SetActive(false)
    else
        -- local ClearCD = self.ClearCD == 1
        --[[        if ClearCD then
                    self:SetPractice(TypeLabel)
                    self:GetTimeCountLabel_UICountdownLabel().gameObject:SetActive(false)
                    isShowPracticeBtn = true
                    self:GetRevivalBtn_GO():SetActive(false)
                else]]
        if self:IsServantDie(showType) then
            type = ""
            spriteName = "anniu19"
            btnlabel = ""
            local desTime = self:GetServantDieCD()
            local dieTime = self:GetServantDieTime(showType)
            local timeStamp = (dieTime + desTime) * 1000
            self:GetTimeCountLabel_UICountdownLabel().gameObject:SetActive(true)
            self:GetTimeCountLabel_UICountdownLabel():StartCountDown(nil, 5, timeStamp, luaEnumColorType.Red .. "休养中", nil, nil, function()
                self:SetPractice(TypeLabel)
            end)
            self:GetRevivalBtn_GO():SetActive(true)
            isShowPracticeBtn = false
        else
            self:GetTimeCountLabel_UICountdownLabel().gameObject:SetActive(false)
            self:GetRevivalBtn_GO():SetActive(false)
            isShowPracticeBtn = true
        end
        --   end
    end

    TypeLabel.text = type
    self.btn_practice.gameObject:SetActive(isShowPracticeBtn)

    --self.Practicing.gameObject:SetActive(isPracticing)

    self.btn_practiceLabel.text = btnlabel
    self.btn_practiceSprite.spriteName = spriteName
end

function UIServantPracticePanel:SetPractice(TypeLabel)
    local type = ""
    local btnlabel = "[FFCDA5]修炼"
    --local isPracticing = false
    local spriteName = "anniu2"
    TypeLabel.text = type
    self.btn_practice.gameObject:SetActive(true)
    --self.Practicing.gameObject:SetActive(isPracticing)
    self.btn_practiceLabel.text = btnlabel
    self.btn_practiceSprite.spriteName = spriteName
    self:GetRevivalBtn_GO():SetActive(false)
end

---刷新买活消费
function UIServantPracticePanel:RefreshRevivalInfo()
    local itemId = self:GetRevivalCost(1)
    local costInfo = self:CacheItemInfo(itemId)
    if costInfo then
        self:GetRevivalCost_UISprite().spriteName = costInfo.icon
    end
    self:GetRevivalCost_UILabel().text = self:GetRevivalCost(2)
end

---@return table<number,number> itemid 1/num 2
function UIServantPracticePanel:GetRevivalCost(index)
    if self.mRevivalInfo == nil then
        local revivalInfo = LuaGlobalTableDeal.GetGlobalTabl(22622)
        if revivalInfo then
            self.mRevivalInfo = string.Split(revivalInfo.value, '#')
        end
    end
    if self.mRevivalInfo then
        return tonumber(self.mRevivalInfo[index])
    end
end

---@return TABLE.CFG_ITEMS
function UIServantPracticePanel:CacheItemInfo(itemId)
    if itemId == nil then
        return
    end

    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local itemInfo = self.mItemIdToInfo[itemId]
    if itemInfo == nil then
        ___, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(tonumber(itemId))
        self.mItemIdToInfo[itemId] = itemInfo
    end
    return itemInfo
end

---灵兽是否死亡了
function UIServantPracticePanel:IsServantDie(showType)
    local dieTime = self:GetServantDieTime(showType)
    if dieTime and dieTime ~= 0 then
        local desTime = self:GetServantDieCD()
        local currentTime = 0
        if CS.CSServerTime.Instance then
            currentTime = CS.CSServerTime.Instance.TotalSeconds
        end
        if desTime then
            if currentTime - dieTime <= desTime then
                return true
            end
        end
    end
    return false
end

---@return XLua.Cast.Int64 死亡时间戳
function UIServantPracticePanel:GetServantDieTime(showType)
    if self.Data and self.Data.dieTimeMap then
        for i = 1, #self.Data.dieTimeMap do
            local info = self.Data.dieTimeMap[i]
            if info and info.type == showType then
                return info.dieTimeS
            end
        end
    end
    return 0
end

---修炼灵兽死亡CD
function UIServantPracticePanel:GetServantDieCD()
    if self.mServantDieCD == nil then
        local res, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22399)
        if res then
            self.mServantDieCD = tonumber(info.value)
        end
    end
    return self.mServantDieCD
end

---刷新灵兽修炼速度
function UIServantPracticePanel.PracticeSpeed(level, rein)
    local speed = "0"
    speed = level * UIServantPracticePanel.PracticeLevelCoefficient + rein * UIServantPracticePanel.PracticeReinCoefficient
    --speed= math.modf(speed/60)
    UIServantPracticePanel.Speed.gameObject:SetActive(true)
    local mapRate = UIServantPracticePanel:GetPracticeSpeed()
    speed = speed + mapRate
    UIServantPracticePanel.Speed.text = "修炼速度 [00ff00]" .. speed .. "/分"
end

function UIServantPracticePanel:GetPracticeSpeed()
    if self.Data and self.Data.mapId ~= 0 then
        local res, info = CS.Cfg_HsCultivationTableManager.Instance.PracticeSpeed:TryGetValue(self.Data.mapId)
        if res then
            return info
        end
    end
    return 0
end

---更新显示模型
---@param ModelRootGO UnityEngine.GameObject
---@param ServantInfo servantV2.ServantInfo
function UIServantPracticePanel.UpdateServantModel(ModelRootGO, ServantInfo)
    local ObservationModel = UIServantPracticePanel.ObservationModel()
    if ObservationModel == nil or CS.StaticUtility.IsNull(ModelRootGO) then
        UIServantPracticePanel.mPreviousServantModelMID = nil
        return
    end

    if ServantInfo == nil then
        ObservationModel:ClearModel()
        UIServantPracticePanel.mPreviousServantModelMID = nil
        return
    end
    ---@type CSServantSeatData
    local seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(ServantInfo.type)
    local servantID = ServantInfo.cfgId
    local isfindservant, ___ = CS.Cfg_ServantTableManager.Instance:TryGetValue(servantID)
    if isfindservant == false then
        ObservationModel:ClearModel()
        UIServantPracticePanel.mPreviousServantModelMID = nil
        return
    end
    local monsterID
    if seatData ~= nil then
        monsterID = seatData:GetMonsterID(true)
        servantID = monsterID
    end
    if UIServantPracticePanel.mPreviousServantModelMID == monsterID then
        return
    end
    UIServantPracticePanel.mPreviousServantModelMID = monsterID
    if servantID == nil or UIServantPracticePanel.mPreviousServantModelMID == nil or UIServantPracticePanel.mPreviousServantModelMID == 0 then
        ObservationModel:ClearModel()
        UIServantPracticePanel.mPreviousServantModelMID = nil
        return
    end

    local servant
    local monsterTbl
    ___, servant = CS.Cfg_ServantTableManager.Instance:TryGetValue(servantID)
    ___, monsterTbl = CS.Cfg_MonsterTableManager.Instance:TryGetValue(monsterID)
    if monsterTbl ~= nil then
        UIServantPracticePanel.mCurSerVantModelId = monsterTbl.model
    else
        UIServantPracticePanel.mCurSerVantModelId = 0
    end
    if (servant ~= nil) then
        UIServantPracticePanel.mWeight = servant.weight
        UIServantPracticePanel.mTotalWeight = servant.weight
        UIServantPracticePanel.mHSScale = servant.hsScale / 100
    else
        ObservationModel:ClearModel()
        UIServantPracticePanel.mPreviousServantModelMID = nil
        return
    end
    if isfindservant then
        UIServantPracticePanel.mWeight = servant.weight
        UIServantPracticePanel.mTotalWeight = servant.weight
        UIServantPracticePanel.mHSScale = servant.hsScale / 100
    end
    ObservationModel:ClearModel()
    ObservationModel:SetShowMotion(CS.CSMotion.ShowStand)
    ObservationModel:SetPosition(CS.UnityEngine.Vector3(0 - servant.offsetX, -150 + servant.y, 300))
    ObservationModel:SetRotation(CS.UnityEngine.Vector3(0, 180, 0))
    ObservationModel:SetPositionDeviation(servant.offsetX)
    ObservationModel:SetBindRenderQueue()
    ObservationModel:SetDragRoot(ModelRootGO)
    ObservationModel:CreateModel(UIServantPracticePanel.mCurSerVantModelId, CS.EAvatarType.Monster, ModelRootGO.transform, function()
        if (UIServantPracticePanel.mWeight ~= nil and UIServantPracticePanel.mTotalWeight ~= nil
                and UIServantPracticePanel.mTotalWeight ~= 0 and UIServantPracticePanel.mHSScale ~= 0)
        then
            ObservationModel:ResetCurScale()
            local num = tonumber(ServantInfo.weight / UIServantPracticePanel.mTotalWeight * UIServantPracticePanel.mHSScale) -- * self.mScaleK
            ObservationModel:SetScaleSizeforRatio(num * 1.2)
        end
    end)
end

function UIServantPracticePanel.ServantPracticeTipNumber()
    local number = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.ServantPracticeTipNumber)
    if number < 3 then
        local isShowTip = CS.CSUIRedPointManager.GetInstance():IsShowServantPracticeRedPoint()
        if isShowTip then
            Utility.ShowBlackPopoTips(UIServantPracticePanel.expPool.gameObject.transform, nil, 326, UIServantPracticePanel)
            number = number + 1
            CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(CS.EConfigOption.ServantPracticeTipNumber, number)
        end
    end
end

function UIServantPracticePanel.ExpChangeEffect()
    local self = UIServantPracticePanel
    if self.mExpEffect == nil and self.effectLoad ~= nil and self.effectLoad.EffectObject ~= nil then
        self.mExpEffect = CS.Utility_Lua.GetComponent(self.effectLoad.EffectObject.transform, "Top_CSMatCollect")
    end
    return self.mExpEffect
end

function UIServantPracticePanel.matListName()
    if UIServantPracticePanel.mMatListName == nil then
        UIServantPracticePanel.mMatListName = {}
        table.insert(UIServantPracticePanel.mMatListName, "ef_UI_147")
        table.insert(UIServantPracticePanel.mMatListName, "ef_mask_058_xc")
        table.insert(UIServantPracticePanel.mMatListName, "ef_UI_147_m1")
    end
    return UIServantPracticePanel.mMatListName
end

function UIServantPracticePanel.SetExpEffectLoad()
    local nowValue = 0
    if UIServantPracticePanel.SeverData ~= nil then
        nowValue = UIServantPracticePanel.SeverData.exp / UIServantPracticePanel.PracticeExpMax
    end
    --local expEffect = UIServantPracticePanel.ExpChangeEffect()
    --if expEffect == nil then
    --    return
    --end
    if UIServantPracticePanel.oldExpValue == nowValue then
        return
    end
    UIServantPracticePanel.oldExpValue = nowValue
    UIServantPracticePanel:RefreshBall(nowValue)
    --Utility.RefreshEffect(expEffect, UIServantPracticePanel.matListName(), "_MaskTex", 1 - nowValue, 0.55, -0.45, 2)

end

--region 刷新球特效
UIServantPracticePanel.IsInitCircleEffect = false
---@return UIServantGatherSoulCircleTemplate
function UIServantPracticePanel:GetBallTemplate()
    if self.mServantPracticeBallTemplate == nil then
        self.mServantPracticeBallTemplate = templatemanager.GetNewTemplate(self.Ball_Go, luaComponentTemplates.UIServantPracticeLevelCircleTemplate)
    end
    return self.mServantPracticeBallTemplate
end

---刷新球比例
function UIServantPracticePanel:RefreshBall(rate, isTween, speed)
    if (self.IsInitCircleEffect == false) then
        self.IsInitCircleEffect = true;
        isTween = false
    else
        isTween = true
    end
    if self:GetBallTemplate() then
        self:GetBallTemplate():SetRate(rate, isTween, speed)
    end
end
--endregion

--endregion

--region 点击事件
---关闭面板
function UIServantPracticePanel.OnClickClose()
    uimanager:ClosePanel("UIServantPracticePanel")
end
---提取经验
function UIServantPracticePanel.OnClickGetExp()
    uimanager:CreatePanel("UIServantPracticeTipsPanel", nil, UIServantPracticePanel.nowExp)
end
---点击修炼
function UIServantPracticePanel.OnClickPractice(go)
    if UIServantPracticePanel.IsCultivating then
        networkRequest.ReqServantCultivateStop()
    else
        --[[        local clear = UIServantPracticePanel.ClearCD == 1
                if not clear then

                end]]
        if UIServantPracticePanel.mCurrentShowServants then
            if UIServantPracticePanel:IsServantDie(UIServantPracticePanel.mCurrentShowServants.type) then
                return
            end
        end

        if UIServantPracticePanel.Isfull == true then
            Utility.ShowPopoTips(go.transform, nil, 328, UIServantPracticeTipsPanel)
            return
        end
        if UIServantPracticePanel.mCurrentSelectServant ~= nil then
            networkRequest.ReqServantCultivateBegin(UIServantPracticePanel.mCurrentSelectServant)
        end
    end
end

---点击背景
function UIServantPracticePanel.OnClickPracticeBG()
    local isfind, xiuLianDian = CS.Cfg_ItemsTableManager.Instance:TryGetValue(LuaEnumCoinType.XiuLianDian)
    if isfind then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = xiuLianDian })
    end
end

function UIServantPracticePanel.OnClickLocationBtn_add()
    --uimanager:CreatePanel('UIServantPracticeMapPanel')
    UIServantPracticePanel:GetServantPracticeMap():ToggleMapShowHideState()
    UIServantPracticePanel.RefreshComponentShowingState()
end
--endregion

--region 网络消息
---返回灵兽修炼信息
---@param data servantcultivateV2.resCultivateInfo
function UIServantPracticePanel.OnResServantCultivateInfoMessage(id, data, csdata)
    UIServantPracticePanel.Data = data
    if UIServantPracticePanel.isStart == false then
        UIServantPracticePanel.OuterSetServantPlaceTab(data)
        UIServantPracticePanel.isStart = nil
    end

    UIServantPracticePanel.mCurrentPracticeServant = data.status == 1 and data.type or nil
    if UIServantPracticePanel.mCurrentSelectServant == nil then
        UIServantPracticePanel.mCurrentSelectServant = data.type --第一次打开界面没有选中时候按修炼类型选中
    end

    UIServantPracticePanel.SeverData = data
    if data ~= nil then
        if data.reasons == 4 or data.reasons == 5 then
            UIServantPracticePanel.RefreshExp(data.exp)
        elseif data.reasons == LuaEnumServantPracticeInfoChangeReason.update then
            UIServantPracticePanel.RefreshHuanShouInfo(UIServantPracticePanel.mHasCreateServantModel == false)
            UIServantPracticePanel:RefreshPracticePoint(data)
        elseif data.reasons == 2 then
            UIServantPracticePanel:RefreshUI(data)
        elseif data.region == LuaEnumServantPracticeInfoChangeReason.Fly then
            UIServantPracticePanel:RefreshPracticePoint(data)
        else
            UIServantPracticePanel:RefreshUI(data)
        end
    end

    UIServantPracticePanel:ClickTab(UIServantPracticePanel.mCurrentSelectServant)

    UIServantPracticePanel.mHasCreateServantModel = true

    local hm = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():CanShowRedPoint(luaEnumServantType.HM)
    local lx = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():CanShowRedPoint(luaEnumServantType.LX)
    local tc = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():CanShowRedPoint(luaEnumServantType.TC)
    local isShow = hm or lx or tc
    UIServantPracticePanel:GetRedPointEffect_GameObject():SetActive(isShow)
end

---根据修炼灵兽选中头像
function UIServantPracticePanel.OuterSetServantPlaceTab(data)
    if data ~= nil and data.status == 1 then
        UIServantPracticePanel:ClickTab(data.type)
    end
end

---自己设置选中头像
function UIServantPracticePanel:ClickTab(type)
    if luaEventManager.HasCallback(LuaCEvent.OuterSetServantPlaceTab) then
        luaEventManager.DoCallback(LuaCEvent.OuterSetServantPlaceTab, type - 1)
        uiStaticParameter.SelectedServantType = type
    end
end

function UIServantPracticePanel.OnResServantLevelUpMessage()
    UIServantPracticePanel.RefreshHuanShouInfo(false)
end

function UIServantPracticePanel.OnBagItemChangeCallBack()
    UIServantPracticePanel.RefreshPracticeLevel()
end

function UIServantPracticePanel.OnClickSetServantPlaceTab(id, data)
    local neddRefresh = UIServantPracticePanel.mCurrentSelectServant ~= data + 1
    if neddRefresh then
        UIServantPracticePanel.mCurrentSelectServant = data + 1--选中灵兽头像切换当前选中类型
        UIServantPracticePanel.RefreshHuanShouInfo(true)
    end
end

function UIServantPracticePanel.OnServantPracticeGetExp()
    UIServantPracticePanel.ExpEffect.gameObject:SetActive(false)
    UIServantPracticePanel.ExpEffect.gameObject:SetActive(true)

end

function UIServantPracticePanel.OnServantPracticeEffectRefresh(id, data)
    if data == nil then
        return
    end
    UIServantPracticePanel.effectLoad.gameObject:SetActive(data)
    UIServantPracticePanel.ExpRedEffect.gameObject:SetActive(data)
end

function UIServantPracticePanel.RefreshComponentShowingState()
    if CS.StaticUtility.IsNull(UIServantPracticePanel.go) then
        return
    end
    ---@type UIServantPanel
    local servantPanel = uimanager:GetPanel("UIServantPanel")
    local isShowMap = false
    if servantPanel and servantPanel:GetSelectServantInfo() then
        isShowMap = true
    end
    if isShowMap == false then
        UIServantPracticePanel:GetServantPracticeMap():HideMap()
    end
    --if UIServantPracticePanel:GetServantPracticeMap():GetIsShowing() then
    --UIServantPracticePanel.ModelRoot.gameObject:SetActive(false)
    --UIServantPracticePanel.Exp.gameObject:SetActive(false)
    --UIServantPracticePanel.Practicing:SetActive(false)
    --UIServantPracticePanel.ExpEffect:SetActive(false)
    --else
    --UIServantPracticePanel.ModelRoot.gameObject:SetActive(true)
    --UIServantPracticePanel.Exp.gameObject:SetActive(true)
    --UIServantPracticePanel.Practicing:SetActive(UIServantPracticePanel.IsCultivating == true)
    --end
end
--endregion

--region 修炼坐标
---@param data servantcultivateV2.resCultivateInfo 刷新修炼坐标
function UIServantPracticePanel:RefreshPracticePoint(data)
    if data then
        local mapInfo = self:GetMapInfo(data.mapId)
        if mapInfo and data.x and data.y then
            self.location.text = "[00ff00]" .. mapInfo.name .. "[-]    [878787](" .. data.x .. "," .. data.y .. ")[-]"
        else
            self.location.text = ""
        end
        UIServantPracticePanel:GetServantPracticeMap():OnServerCoordinateRefreshed()
    end
end
--endregion

--region 缓存数据
---@return TABLE.CFG_MAP 地图表数据
function UIServantPracticePanel:GetMapInfo(mapId)
    if mapId == nil then
        return
    end
    if self.mMapIdToInfo == nil then
        self.mMapIdToInfo = {}
    end
    local info = self.mMapIdToInfo[mapId]
    if info == nil then
        ___, info = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(mapId)
        self.mMapIdToInfo[mapId] = info
    end
    return info
end
--endregion

--region 帮助
function UIServantPracticePanel:OnHelpBtnClicked()
    Utility.ShowHelpPanel({ id = 166 })
end
--endregion

--region 买活
function UIServantPracticePanel:OnRevivalBtnClicked(go)

    local cost = self:GetRevivalCost(2)
    local itemId = self:GetRevivalCost(1)
    local bagItemNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(itemId)
    if bagItemNum >= cost then
        networkRequest.ReqCommon(11, self.mCurrentSelectServant, nil, nil)
    else
        local itemInfo = self:CacheItemInfo(itemId)
        local des = self:CachePromptInfo(393)
        if des and itemInfo then
            local str = string.format(des.content, itemInfo.name)
            Utility.ShowPopoTips(go, str, 393)
        end
    end
end

---@return TABLE.CFG_PROMPTFRAME
function UIServantPracticePanel:CachePromptInfo(id)
    if self.mPromIdToInfo == nil then
        self.mPromIdToInfo = {}
    end
    local info = self.mPromIdToInfo[id]
    if info == nil then
        ___, info = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(id)
        self.mPromIdToInfo[id] = info
    end
    return info
end

--endregion

function update()
    UIServantPracticePanel.SetExpEffectLoad()
end

function ondestroy()
    if UIServantPracticePanel.mObservationModel ~= nil then
        UIServantPracticePanel.mObservationModel:ClearModel()
        UIServantPracticePanel.mObservationModel = nil
    end
    networkRequest.ReqServantCultivateOpenDlg(2)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantCultivateInfoMessage, UIServantPracticePanel.OnResServantCultivateInfoMessage)
    --luaEventManager.RemoveCallback(LuaCEvent.OnClickSetServantPlaceTab, UIServantPracticePanel.OnClickSetServantPlaceTab)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, UIServantPracticePanel.OnBagItemChangeCallBack)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantLevelUpMessage, UIServantPracticePanel.OnResServantLevelUpMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantReinUpMessage, UIServantPracticePanel.OnResServantLevelUpMessage)
    --luaEventManager.RemoveCallback(LuaCEvent.ServantPracticeGetExp, UIServantPracticePanel.OnServantPracticeGetExp)
    --luaEventManager.RemoveCallback(LuaCEvent.ServantPracticeEffectRefresh, UIServantPracticePanel.OnServantPracticeEffectRefresh)
end

return UIServantPracticePanel