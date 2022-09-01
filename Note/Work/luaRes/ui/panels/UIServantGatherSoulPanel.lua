local UIServantGatherSoulPanel = {}

--region 变量
---@return servantV2.ServantMana
UIServantGatherSoulPanel.ServantManaData = nil

UIServantGatherSoulPanel.IsInitCircleEffect = false

UIServantGatherSoulPanel.SpeedBeginPos = CS.UnityEngine.Vector3(0, 0, 0)
UIServantGatherSoulPanel.SpeedAfterPos = CS.UnityEngine.Vector3(0, 9, 0)
--endregion

--region  组件
---@return UnityEngine.GameObject 关闭按钮
function UIServantGatherSoulPanel:GetmCloseBtn_GameObject()
    if (self.mCloseBtn == nil) then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/Main/window/left_main/events/btn_close", "GameObject")
    end
    return self.mCloseBtn
end

---@return UILabel 填充提示
function UIServantGatherSoulPanel:GetServantSoulSpeed_UILabel()
    if (self.mServantSoulSpeed == nil) then
        self.mServantSoulSpeed = self:GetCurComp("WidgetRoot/Main/view/Speed", "Top_UILabel")
    end
    return self.mServantSoulSpeed
end

---@return UILabel
--function UIServantGatherSoulPanel:GetServantSoulGetCount_UILabel()
--    if (self.mServantSoulGetCount == nil) then
--        self.mServantSoulGetCount = self:GetCurComp("WidgetRoot/Main/view/ball/panel2/title", "Top_UILabel")
--    end
--    return self.mServantSoulGetCount
--end
---@return UILabel 灵力池
function UIServantGatherSoulPanel:GetServantSoulPoolCount_UILabel()
    if (self.mServantSoulPoolCount == nil) then
        self.mServantSoulPoolCount = self:GetCurComp("WidgetRoot/Main/view/ball/panel2/expPool", "Top_UILabel")
    end
    return self.mServantSoulPoolCount
end

---@return UnityEngine.GameObject 普通领取
function UIServantGatherSoulPanel:GetGetBtn_GameObject()
    if (self.mGetBtn == nil) then
        self.mGetBtn = self:GetCurComp("WidgetRoot/Main/events/btn_get", "GameObject")
    end
    return self.mGetBtn
end
---@return UISprite 普通领取底图
function UIServantGatherSoulPanel:GetGetBtn_UISprite()
    if (self.mGetBtnSp == nil) then
        self.mGetBtnSp = self:GetCurComp("WidgetRoot/Main/events/btn_get", "UISprite")
    end
    return self.mGetBtnSp
end
---@return UILabel 普通领取文字
function UIServantGatherSoulPanel:GetGetBtn_UILabel()
    if (self.mGetBtnLb == nil) then
        self.mGetBtnLb = self:GetCurComp("WidgetRoot/Main/events/btn_get/Label", "UILabel")
    end
    return self.mGetBtnLb
end
---@return UnityEngine.GameObject 普通领取特效
function UIServantGatherSoulPanel:GetGetBtnEff_GameObject()
    if (self.mGetBtnEffect == nil) then
        self.mGetBtnEffect = self:GetCurComp("WidgetRoot/Main/events/btn_get/Effect", "GameObject")
    end
    return self.mGetBtnEffect
end
---@return UnityEngine.GameObject 充值按钮
function UIServantGatherSoulPanel:GetRechargeBtn_GameObject()
    if (self.mRechargeBtn == nil) then
        self.mRechargeBtn = self:GetCurComp("WidgetRoot/Main/events/btn_recharge", "GameObject")
    end
    return self.mRechargeBtn
end
---@return UnityEngine.GameObject 充值领取按钮
function UIServantGatherSoulPanel:GetRechargeGetBtn_GameObject()
    if (self.mRechargeGetBtn == nil) then
        self.mRechargeGetBtn = self:GetCurComp("WidgetRoot/Main/events/btn_recharge_get", "GameObject")
    end
    return self.mRechargeGetBtn
end
---@return UISprite 充值领取按钮底图
function UIServantGatherSoulPanel:GetRechargeGetBtn_UISprite()
    if (self.mRechargeGetBtnSp == nil) then
        self.mRechargeGetBtnSp = self:GetCurComp("WidgetRoot/Main/events/btn_recharge_get", "UISprite")
    end
    return self.mRechargeGetBtnSp
end
---@return UILabel 充值领取按钮文字
function UIServantGatherSoulPanel:GetRechargeGetBtn_UILabel()
    if (self.mRechargeGetBtnLb == nil) then
        self.mRechargeGetBtnLb = self:GetCurComp("WidgetRoot/Main/events/btn_recharge_get/Label", "UILabel")
    end
    return self.mRechargeGetBtnLb
end
---@return UnityEngine.GameObject 充值领取按钮特效
function UIServantGatherSoulPanel:GetRechargeGetBtnEffect_GameObject()
    if (self.mRechargeGetBtnEffect == nil) then
        self.mRechargeGetBtnEffect = self:GetCurComp("WidgetRoot/Main/events/btn_recharge_get/Effect", "GameObject")
    end
    return self.mRechargeGetBtnEffect
end
---@return UILabel 普通领取描述
function UIServantGatherSoulPanel:GetNextLevelGetServantSoulSpeed_UILabel()
    if (self.mNextLevelGetServantSoulSpeed == nil) then
        self.mNextLevelGetServantSoulSpeed = self:GetCurComp("WidgetRoot/Main/view/info/Speed", "Top_UILabel")
    end
    return self.mNextLevelGetServantSoulSpeed
end

--function UIServantGatherSoulPanel:GetNextLevelGetServantSoulDes_UILabel()
--    if (self.mNextLevelGetServantSoulDes == nil) then
--        self.mNextLevelGetServantSoulDes = self:GetCurComp("WidgetRoot/Main/view/info/Des", "Top_UILabel")
--    end
--    return self.mNextLevelGetServantSoulDes
--end
---@return UILabel 充值领取描述
function UIServantGatherSoulPanel:GetNextLevelGetServantSoulSpeed2_UILabel()
    if (self.mNextLevelGetServantSoulSpeed2 == nil) then
        self.mNextLevelGetServantSoulSpeed2 = self:GetCurComp("WidgetRoot/Main/view/info2/Speed", "Top_UILabel")
    end
    return self.mNextLevelGetServantSoulSpeed2
end

--function UIServantGatherSoulPanel:GetNextLevelGetServantSoulDes2_UILabel()
--    if (self.mNextLevelGetServantSoulDes2 == nil) then
--        self.mNextLevelGetServantSoulDes2 = self:GetCurComp("WidgetRoot/Main/view/info2/Des", "Top_UILabel")
--    end
--    return self.mNextLevelGetServantSoulDes2
--end
--function UIServantGatherSoulPanel:GetRechargeGold_UILabel()
--    if (self.mRechargeGold == nil) then
--        self.mRechargeGold = self:GetCurComp("WidgetRoot/Main/view/RechargeGold", "Top_UILabel")
--    end
--    return self.mRechargeGold
--end
---@return UnityEngine.GameObject 特效
function UIServantGatherSoulPanel:GetFlyEffect_GameObject()
    if (self.mFlyEffect == nil) then
        self.mFlyEffect = self:GetCurComp("WidgetRoot/Main/view/ball/GetEffect", "GameObject")
    end
    return self.mFlyEffect
end
---@return CSUIEffectLoad 特效
function UIServantGatherSoulPanel:GetBallEffect_UIEffectLoad()
    if (self.mBallEffectEffectLoad == nil) then
        self.mBallEffectEffectLoad = self:GetCurComp("WidgetRoot/Main/view/ball/Sprite1", "CSUIEffectLoad")
    end
    return self.mBallEffectEffectLoad
end
---@return CSUIEffectLoad 特效
function UIServantGatherSoulPanel:GetBallBottomEffect_UIEffectLoad()
    if (self.mBallBottomEffectEffectLoad == nil) then
        self.mBallBottomEffectEffectLoad = self:GetCurComp("WidgetRoot/Main/view/ball/BottomEffect", "CSUIEffectLoad")
    end
    return self.mBallBottomEffectEffectLoad
end
---@return CSUIEffectLoad 特效
function UIServantGatherSoulPanel:GetBallBottomEffect2_UIEffectLoad()
    if (self.mBallBottom2EffectEffectLoad == nil) then
        self.mBallBottom2EffectEffectLoad = self:GetCurComp("WidgetRoot/Main/view/ball/Sprite2", "CSUIEffectLoad")
    end
    return self.mBallBottom2EffectEffectLoad
end
---@return CSUIEffectLoad 特效
function UIServantGatherSoulPanel:GetBallGetEffect_UIEffectLoad()
    if (self.mBallGetEffectEffectLoad == nil) then
        self.mBallGetEffectEffectLoad = self:GetCurComp("WidgetRoot/Main/view/ball/GetEffect", "CSUIEffectLoad")
    end
    return self.mBallGetEffectEffectLoad
end
-----@return UnityEngine.GameObject 满级
--function UIServantGatherSoulPanel:GetLevelMax_GameObject()
--    if (self.mLevelMaxGo == nil) then
--        self.mLevelMaxGo = self:GetCurComp("WidgetRoot/Main/view/LevelMax", "GameObject")
--    end
--    return self.mLevelMaxGo
--end

---@return UnityEngine.GameObject 球节点
function UIServantGatherSoulPanel:GetBall_Go()
    if self.mBallGo == nil then
        self.mBallGo = self:GetCurComp("WidgetRoot/Main/view/ball", "GameObject")
    end
    return self.mBallGo
end

--endregion

--region 初始化
function UIServantGatherSoulPanel:Init()
    self:InitData()
    self:BindMessage()
    self:BindUIEvent()
end

function UIServantGatherSoulPanel:InitData()
    networkRequest.ReqOpneServantMana()
end

function UIServantGatherSoulPanel:BindUIEvent()
    CS.UIEventListener.Get(self:GetmCloseBtn_GameObject()).onClick = function(go)
        self:CloseBtnOnClick(go)
    end
    CS.UIEventListener.Get(self:GetGetBtn_GameObject()).onClick = function(go)
        self:GetBtnOnClick(go)
    end
    CS.UIEventListener.Get(self:GetRechargeBtn_GameObject()).onClick = function(go)
        self:RechargeBtnOnClick(go)
    end
    CS.UIEventListener.Get(self:GetRechargeGetBtn_GameObject()).onClick = function(go)
        self:RechargeGetBtnOnClick(go)
    end
    self:GetBallEffect_UIEffectLoad().onLoadFinish = function()
        self:RefreshPoolEffect(gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetGatherSoulData().manaPoll)
    end
end

function UIServantGatherSoulPanel:BindMessage()
    self.ResOpneServantManaFun = function(id, data, csdata)
        self:ResOpenGatherServantPanel(id, data, csdata)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOpneServantManaMessage, self.ResOpneServantManaFun)
end

function UIServantGatherSoulPanel:Show()
end
--endregion

--region 客户端事件
function UIServantGatherSoulPanel:CloseBtnOnClick(go)
    uimanager:ClosePanel("UIServantGatherSoulPanel")
end

function UIServantGatherSoulPanel:GetBtnOnClick(go)
    if self.ServantManaData == nil then
        return
    end

    if (self.ServantManaData.manaPoll <= 0) then
        self:ShowTips(go, 413)
        return
    end
    if (Utility.CanGetServantFreeAward(self.ServantManaData)) then
        --self:GetFlyEffect_GameObject():SetActive(false)
        --self:GetFlyEffect_GameObject():SetActive(true)
        self:DocPlayFlyEff(self.ServantManaData.manaPoll)
        networkRequest.ReqReceiveMana(1)
    else
        self:ShowTips(go, 404)
    end
end

function UIServantGatherSoulPanel:RechargeBtnOnClick(go)
    Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.ServantGatherSoulPanel)
end
function UIServantGatherSoulPanel:RechargeGetBtnOnClick(go)
    if (self.ServantManaData.manaPoll <= 0) then
        self:ShowTips(go, 413)
        return
    end
    if (Utility.CanGetServantRechargeAward(self.ServantManaData) ~= 2) then
        --self:GetFlyEffect_GameObject():SetActive(false)
        --self:GetFlyEffect_GameObject():SetActive(true)
        self:DocPlayFlyEff(self.ServantManaData.manaPoll)
        networkRequest.ReqReceiveMana(2)
    else
        self:ShowTips(go, 404)
    end
end
function UIServantGatherSoulPanel:PlayFlyEff()
    self:GetFlyEffect_GameObject():SetActive(false)
    self:GetFlyEffect_GameObject():SetActive(true)
end
function UIServantGatherSoulPanel:DocPlayFlyEff(num)
    self.docCurNum = num
end
function UIServantGatherSoulPanel:CheckPlayFlyEff()
    if (self.docCurNum == nil or self.ServantManaData == nil or self.ServantManaData.manaPoll >= self.docCurNum) then
        self.docCurNum = 0
        return
    end
    UIServantGatherSoulPanel:PlayFlyEff()
end
--endregion

--region 服务器消息
---@param tblData servantV2.ServantMana
function UIServantGatherSoulPanel:ResOpenGatherServantPanel(id, tblData, csData)
    self.ServantManaData = tblData
    self:RefreshUIPanel()
end
--endregion

--region 界面刷新
function UIServantGatherSoulPanel:RefreshUIPanel()
    if (self.ServantManaData ~= nil) then
        ---@type LuaServantInfo
        self.servantInfo = gameMgr:GetPlayerDataMgr():GetLuaServantInfo()
        --local nexttableinfo = servantInfo:GetNextVIPTableData()
        ---@type TABLE.cfg_vip_level
        self.tableinfo = self.servantInfo:GetVIPTableData()
        if (self.tableinfo ~= nil) then
            self:RefreshGatherSoulDes()
        end
        self:RefreshPoolEffect(self.ServantManaData.manaPoll)
        self:CheckPlayFlyEff()
    end
end

function UIServantGatherSoulPanel:RefreshGatherSoulDes()
    if (self.ServantManaData == nil or self.tableinfo == nil or self.servantInfo == nil) then
        return
    end
    self:GetServantSoulSpeed_UILabel().text = "[00ff00]" .. self.tableinfo:GetManaLevel() .. "[-]  " .. tostring(self.tableinfo:GetGatherSoulNum()) .. "灵力/天"
    --self:GetServantSoulGetCount_UILabel().text = "[b7c0c9]可领取第" .. tostring(self.ServantManaData.day) .. "天灵力数[-]"
    self:GetServantSoulPoolCount_UILabel().text = "[c7efff]" .. self.ServantManaData.manaPoll .. "/" .. tostring(self.servantInfo:GetServantLimit())

    local max = self.servantInfo:GetServantLimit()
    if max ~= 0 then
        local rate = self.ServantManaData.manaPoll / max
        self:RefreshBall(rate)
    end
    self:SetFirstLineInfo()
    self:SetTwoLineInfo()
    --if (nexttableinfo ~= nil) then
    --    self:GetNextLevelGetServantSoulSpeed_UILabel().text = "[ffbc1c]升级" .. nexttableinfo:GetManaLevel() .. "[-] " .. tostring(nexttableinfo:GetServantMana()) .. "灵力/天"
    --    self:GetLevelMax_GameObject():SetActive(false)
    --    self:GetRechargeGold_UILabel().gameObject:SetActive(true)
    --    self:GetRechargeBtn_GameObject().gameObject:SetActive(true)
    --    self:GetNextLevelGetServantSoulDes_UILabel().gameObject:SetActive(true)
    --    self:GetNextLevelGetServantSoulSpeed_UILabel().gameObject:SetActive(true)
    --else
    --    self:GetRechargeGold_UILabel().gameObject:SetActive(false)
    --    self:GetRechargeBtn_GameObject().gameObject:SetActive(false)
    --    self:GetNextLevelGetServantSoulDes_UILabel().gameObject:SetActive(false)
    --    self:GetNextLevelGetServantSoulSpeed_UILabel().gameObject:SetActive(false)
    --    self:GetLevelMax_GameObject():SetActive(true)
    --    return
    --end
    --if (servantInfo:GetPlayerSupplementServantMana(self.ServantManaData.receiveDay) == 0) then
    --    self:GetNextLevelGetServantSoulSpeed_UILabel().gameObject.transform.localPosition = self.SpeedBeginPos
    --    self:GetNextLevelGetServantSoulDes_UILabel().gameObject:SetActive(false)
    --else
    --    self:GetNextLevelGetServantSoulSpeed_UILabel().gameObject.transform.localPosition = self.SpeedAfterPos
    --    self:GetNextLevelGetServantSoulDes_UILabel().gameObject:SetActive(true)
    --    self:GetNextLevelGetServantSoulDes_UILabel().text = "[878787]且补充足" .. nexttableinfo:GetManaLevel() .. tostring(self.ServantManaData.receiveDay) .. "天灵力" .. tostring(servantInfo:GetPlayerSupplementServantMana(self.ServantManaData.receiveDay)) .. "[-]"
    --end
    --self:GetRechargeGold_UILabel().text = "再充[ff0000]" .. tostring(servantInfo:GetNeedCostToNextLevel()) .. "[-]元可升级"
end
---免费领取信息
function UIServantGatherSoulPanel:SetFirstLineInfo()
    if (self:GetGetBtn_UILabel() ~= nil) then
        self:GetGetBtn_UILabel().text = Utility.CanGetServantFreeAward(self.ServantManaData) and "[fff0c2]提取" or "[878787]已提取"
    end
    if (self:GetGetBtn_UISprite() ~= nil) then
        self:GetGetBtn_UISprite().enabled = Utility.CanGetServantFreeAward(self.ServantManaData)
    end
    if (self:GetNextLevelGetServantSoulSpeed_UILabel()) then
        self:GetNextLevelGetServantSoulSpeed_UILabel().text = "每日可提取" .. tostring(self.servantInfo:GetFreeServantNum()) .. "灵力"
    end
    if (self:GetGetBtnEff_GameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetGetBtnEff_GameObject())) then
        self:GetGetBtnEff_GameObject():SetActive(Utility.CanGetServantFreeAward(self.ServantManaData) and self.ServantManaData.manaPoll > 0)
    end
end
---充值领取信息
function UIServantGatherSoulPanel:SetTwoLineInfo()
    if (self:GetRechargeBtn_GameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetRechargeBtn_GameObject())) then
        self:GetRechargeBtn_GameObject():SetActive(Utility.CanGetServantRechargeAward(self.ServantManaData) == 0)
    end
    if (self:GetRechargeGetBtn_GameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetRechargeGetBtn_GameObject())) then
        self:GetRechargeGetBtn_GameObject():SetActive(Utility.CanGetServantRechargeAward(self.ServantManaData) ~= 0)
    end
    if (self:GetRechargeGetBtn_UISprite() ~= nil) then
        self:GetRechargeGetBtn_UISprite().enabled = Utility.CanGetServantRechargeAward(self.ServantManaData) ~= 2
    end
    if (self:GetRechargeGetBtn_UILabel() ~= nil) then
        self:GetRechargeGetBtn_UILabel().text = Utility.CanGetServantRechargeAward(self.ServantManaData) ~= 2 and "[fff0c2]提取" or "[878787]已提取"
    end
    if (self:GetNextLevelGetServantSoulSpeed2_UILabel()) then
        self:GetNextLevelGetServantSoulSpeed2_UILabel().text = "任意充值可提取全部灵力"
        --if(Utility.CanGetServantRechargeAward(self.ServantManaData)==2)then
        --    self:GetNextLevelGetServantSoulSpeed2_UILabel().text="任意充值可提取全部灵力"
        --elseif Utility.CanGetServantRechargeAward(self.ServantManaData)==0 then
        --    self:GetNextLevelGetServantSoulSpeed2_UILabel().text="任意充值可提取全部灵力"
        --elseif (Utility.CanGetServantFreeAward(self.ServantManaData)==true) then
        --local num =self.ServantManaData.manaPoll- self.servantInfo:GetFreeServantNum()>0 and self.ServantManaData.manaPoll- self.servantInfo:GetFreeServantNum() or 0
        --self:GetNextLevelGetServantSoulSpeed2_UILabel().text ="可提取"..tostring(num).."灵力"
        --else
        --self:GetNextLevelGetServantSoulSpeed2_UILabel().text ="可提取"..tostring(self.ServantManaData.manaPoll).."灵力"
        --    end
    end
    if (self:GetRechargeGetBtnEffect_GameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetRechargeGetBtnEffect_GameObject())) then
        self:GetRechargeGetBtnEffect_GameObject():SetActive(Utility.CanGetServantRechargeAward(self.ServantManaData) ~= 2 and self.ServantManaData.manaPoll > 0)
    end
end
function UIServantGatherSoulPanel:RefreshPoolEffect(exp)
    --if (exp == 0) then
    --    self:GetBallEffect_UIEffectLoad():DestroyEffect()
    --    self:GetBallBottomEffect_UIEffectLoad():DestroyEffect()
    --else
    --    self:GetBallEffect_UIEffectLoad():LoadEffect()
    --    self:GetBallBottomEffect_UIEffectLoad():LoadEffect()
    --end
    local expEffect = self:ExpChangeEffect()
    if expEffect == nil or exp == nil then
        return
    end
    local num = exp / gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantLimit()
    Utility.RefreshEffect(expEffect, self:matListName(), "_MaskTex", 1 - num, 0.55, -0.45, 2)
end

function UIServantGatherSoulPanel:matListName()
    if self.mMatListName == nil then
        self.mMatListName = {}
        table.insert(self.mMatListName, "ef_UI_153")
        table.insert(self.mMatListName, "ef_mask_058_xc")
        table.insert(self.mMatListName, "ef_UI_153_m1")
        table.insert(self.mMatListName, "ef_UI_31")
    end
    return self.mMatListName
end

function UIServantGatherSoulPanel:ExpChangeEffect()
    if self.mExpEffect == nil and self:GetBallEffect_UIEffectLoad() ~= nil and self:GetBallEffect_UIEffectLoad().EffectObject ~= nil then
        self.mExpEffect = CS.Utility_Lua.GetComponent(self:GetBallEffect_UIEffectLoad().EffectObject.transform, "Top_CSMatCollect")
    end
    return self.mExpEffect
end

function UIServantGatherSoulPanel:ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIServantPanel"
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion

--region 刷新球特效
---@return UIServantGatherSoulCircleTemplate
function UIServantGatherSoulPanel:GetBallTemplate()
    if self.mServantGatherSoulBallTemplate == nil then
        self.mServantGatherSoulBallTemplate = templatemanager.GetNewTemplate(self:GetBall_Go(), luaComponentTemplates.UIServantGatherSoulCircleTemplate)
    end
    return self.mServantGatherSoulBallTemplate
end

---刷新球比例
function UIServantGatherSoulPanel:RefreshBall(rate, isTween, speed)
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
---是否可以领取第一档
--function UIServantGatherSoulPanel:CanGetFirstReward()
--    if(self.ServantManaData==nil)then
--        return false
--    end
--    return not self.ServantManaData.receiveToday
--end
---是否可以领取第二档
---@return number  0:未充值,1:充值未领取,2:领取过,
--function UIServantGatherSoulPanel:CanGetTwoReward()
--    if(self.ServantManaData==nil or self.servantInfo==nil)then
--        return 0
--    end
--    if(self.ServantManaData.rechargeToday ==false)then
--        return 0
--    elseif ((self:CanGetFirstReward() ==false and self.ServantManaData.manaPoll<=self.servantInfo:GetFreeServantNum())or self.ServantManaData.manaPoll==0)then
--        return 2
--    else
--        return 1
--    end
--end
function update()

end
function ondestroy()

end

return UIServantGatherSoulPanel