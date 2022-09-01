local UIServantPracticeTipsPanel = {}

function UIServantPracticeTipsPanel:InitComponents()
    ---经验值
    self.expvalue = self:GetCurComp("WidgetRoot/view/expvalue", "UILabel")
    ---经验值百分比
    self.Count = self:GetCurComp("WidgetRoot/view/Exp/practice/panel2/Count", "UILabel")
    ---价格
    self.price = self:GetCurComp("WidgetRoot/view/singleprice/price", "UILabel")
    ---价格Icon
    self.priceIcon = self:GetCurComp("WidgetRoot/view/singleprice/price/icon", "UISprite")
    ---价格Icon
    self.priceGet = self:GetCurComp("WidgetRoot/view/singleprice/price/add", "UISprite")
    ---使用按钮
    self.Usebtn = self:GetCurComp("WidgetRoot/view/singleprice/btn", "GameObject")
    ---使用按钮
    self.UsebtnLabel = self:GetCurComp("WidgetRoot/view/singleprice/btn/Label", "UILabel")
    ---关闭按钮
    self.btn_close = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")

    self.effectLoad = self:GetCurComp("WidgetRoot/view/Exp/practice/Sprite2", "CSUIEffectLoad")
end
function UIServantPracticeTipsPanel:InitOther()
    CS.UIEventListener.Get(self.Usebtn).onClick = self.OnClickUsebtn
    CS.UIEventListener.Get(self.btn_close).onClick = self.OnClickbtn_close
    CS.UIEventListener.Get(self.priceIcon.gameObject).onClick = self.OnClickpriceIcon
    CS.UIEventListener.Get(self.priceGet.gameObject).onClick = self.OnClickpriceGet

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantCultivateInfoMessage, UIServantPracticeTipsPanel.OnResServantCultivateInfoMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UIServantPracticeTipsPanel.OnBagItemChangeCallBack)
    luaEventManager.DoCallback(LuaCEvent.ServantPracticeEffectRefresh, false)
end

function UIServantPracticeTipsPanel:Init()
    self:InitComponents()
    self:InitOther()
end

function UIServantPracticeTipsPanel:Show(nowExp)
    self.RefreshUI(nowExp)
end

function UIServantPracticeTipsPanel.RefreshUI(nowExp)
    if nowExp ~= nil then
        UIServantPracticeTipsPanel.nowExp = nowExp
    end
    if UIServantPracticeTipsPanel.nowExp == nil then
        return
    end

    ---经验最大值
    UIServantPracticeTipsPanel.PracticeExpMax = CS.Cfg_GlobalTableManager.Instance.PracticeExpMax
    ---修炼点兑换比
    UIServantPracticeTipsPanel.PracticeProportion = CS.Cfg_GlobalTableManager.Instance.PracticeProportion
    ---修炼点数量
    UIServantPracticeTipsPanel.PracticeNumber = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(LuaEnumCoinType.XiuLianDian)
    UIServantPracticeTipsPanel.expvalue.text = "[00ff00]" .. UIServantPracticeTipsPanel.nowExp .. "[-]/[dde6eb]" .. UIServantPracticeTipsPanel.PracticeExpMax .. "[-]"
    local exp = ((UIServantPracticeTipsPanel.nowExp / UIServantPracticeTipsPanel.PracticeExpMax) * 100)
    exp = string.format("%.2f", exp)
    UIServantPracticeTipsPanel.Count.text = exp .. "%"

    UIServantPracticeTipsPanel:RefreshBall(UIServantPracticeTipsPanel.nowExp / UIServantPracticeTipsPanel.PracticeExpMax)

    local PracticeColor = ""
    local priceNumber = math.modf(UIServantPracticeTipsPanel.nowExp / UIServantPracticeTipsPanel.PracticeProportion)
    local UsebtnDes = ""

    ---当前拥有聚灵点描述
    local practiceNumberDes = UIServantPracticeTipsPanel.PracticeNumber
    ---最大可提取聚灵点描述
    local priceNumberDes = ""

    ---当前可提取聚灵点次数
    local nowPriceNumber = priceNumber
    if practiceNumberDes <= priceNumber then
        nowPriceNumber = practiceNumberDes
    end

    local des = nowPriceNumber == 0 and "" or nowPriceNumber .. "次"
    UsebtnDes = "提取" .. des

    local fColor = UIServantPracticeTipsPanel.PracticeNumber == 0 and luaEnumColorType.Red or luaEnumColorType.Green
    practiceNumberDes = fColor .. UIServantPracticeTipsPanel.PracticeNumber .. "[-]"
    local bClolor = priceNumber == 0 and luaEnumColorType.Red or ""
    priceNumberDes = bClolor .. priceNumber

    UIServantPracticeTipsPanel.UsebtnLabel.text = UsebtnDes
    UIServantPracticeTipsPanel.price.text = practiceNumberDes .. "/" .. priceNumberDes--   PracticeColor .. priceNumber
    UIServantPracticeTipsPanel.priceIcon:UpdateAnchors()
    UIServantPracticeTipsPanel.priceGet:UpdateAnchors()
    UIServantPracticeTipsPanel.isfind, UIServantPracticeTipsPanel.xiuLianDian = CS.Cfg_ItemsTableManager.Instance:TryGetValue(LuaEnumCoinType.XiuLianDian)
    if UIServantPracticeTipsPanel.isfind then
        UIServantPracticeTipsPanel.priceIcon.spriteName = UIServantPracticeTipsPanel.xiuLianDian.icon
    end

    if UIServantPracticeTipsPanel.PracticeNumber > 0 then
        UIServantPracticeTipsPanel.priceGet.spriteName = "add_small2"
    else
        UIServantPracticeTipsPanel.priceGet.spriteName = "add_small"
    end

end

function UIServantPracticeTipsPanel.OnClickUsebtn(go)
    CS.CSScene.MainPlayerInfo.ServantInfoV2.IsServantCultivateRed = false
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_Practice_PUSH)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_Practice_Site1);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_Practice_Site2);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_Practice_Site3);
    UIServantPracticeTipsPanel.PracticeNumber = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(LuaEnumCoinType.XiuLianDian)
    if UIServantPracticeTipsPanel.PracticeNumber == 0 then
        Utility.ShowPopoTips(go.transform, nil, 324, UIServantPracticeTipsPanel)
        return
    elseif UIServantPracticeTipsPanel.PracticeProportion > UIServantPracticeTipsPanel.nowExp then
        Utility.ShowPopoTips(go.transform, nil, 325, UIServantPracticeTipsPanel)
        return
    end
    networkRequest.ReqServantCultivateTake()
    uimanager:ClosePanel("UIServantPracticeTipsPanel")
    luaEventManager.DoCallback(LuaCEvent.ServantPracticeGetExp)

end

function UIServantPracticeTipsPanel.OnClickbtn_close()
    uimanager:ClosePanel("UIServantPracticeTipsPanel")
end

function UIServantPracticeTipsPanel.OnClickpriceIcon()
    if UIServantPracticeTipsPanel.xiuLianDian ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = UIServantPracticeTipsPanel.xiuLianDian, showRight = false })
    end
end

function UIServantPracticeTipsPanel.OnClickpriceGet(go)
    -- Utility.ShowItemGetWay(LuaEnumCoinType.XiuLianDian, go, LuaEnumWayGetPanelArrowDirType.Left)
    Utility.ShowItemGetWay(LuaEnumCoinType.XiuLianDian, go, LuaEnumWayGetPanelArrowDirType.LeftUp, CS.UnityEngine.Vector2(200, 50));

end

function UIServantPracticeTipsPanel.OnResServantCultivateInfoMessage(id, data)
    if data ~= nil then
        UIServantPracticeTipsPanel.RefreshUI(data.exp)
    end
end

function UIServantPracticeTipsPanel.OnBagItemChangeCallBack()
    UIServantPracticeTipsPanel.RefreshUI()
end

function UIServantPracticeTipsPanel.ExpChangeEffect()
    local self = UIServantPracticeTipsPanel
    if self.mExpEffect == nil and self.effectLoad ~= nil and self.effectLoad.EffectObject ~= nil then
        self.mExpEffect = CS.Utility_Lua.GetComponent(self.effectLoad.EffectObject.transform, "Top_CSMatCollect")
    end
    return self.mExpEffect
end

function UIServantPracticeTipsPanel.matListName()
    if UIServantPracticeTipsPanel.mMatListName == nil then
        UIServantPracticeTipsPanel.mMatListName = {}
        table.insert(UIServantPracticeTipsPanel.mMatListName, "ef_UI_147")
        table.insert(UIServantPracticeTipsPanel.mMatListName, "ef_mask_058_xc")
        table.insert(UIServantPracticeTipsPanel.mMatListName, "ef_UI_147_m1")
    end
    return UIServantPracticeTipsPanel.mMatListName
end

function UIServantPracticeTipsPanel.SetExpEffectLoad()
    local nowValue = UIServantPracticeTipsPanel.nowExp / UIServantPracticeTipsPanel.PracticeExpMax
    if nowValue == nil then
        return
    end
    --local expEffect = UIServantPracticeTipsPanel.ExpChangeEffect()
    --if expEffect == nil then
    --    return
    --end
    if UIServantPracticeTipsPanel.oldExpValue == nowValue then
        return
    end
    UIServantPracticeTipsPanel.oldExpValue = nowValue
    UIServantPracticeTipsPanel:RefreshBall(nowValue)
    --Utility.RefreshEffect(expEffect, UIServantPracticeTipsPanel.matListName(), "_MaskTex", 1 - nowValue, 0.55, -0.45, 2)
end

--region 刷新球特效
UIServantPracticeTipsPanel.IsInitCircleEffect = false
function UIServantPracticeTipsPanel:GetBallObj()
    if self.mBallObj == nil then
        self.mBallObj = self:GetCurComp("WidgetRoot/view/Exp/practice", "GameObject")
    end
    return self.mBallObj
end

---@return UIServantGatherSoulCircleTemplate
function UIServantPracticeTipsPanel:GetBallTemplate()
    if self.mServantPracticeBallTemplate == nil then
        self.mServantPracticeBallTemplate = templatemanager.GetNewTemplate(self:GetBallObj(), luaComponentTemplates.UIServantPracticeLevelCircleTemplate)
    end
    return self.mServantPracticeBallTemplate
end

---刷新球比例
function UIServantPracticeTipsPanel:RefreshBall(rate, isTween, speed)
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

function update()
    UIServantPracticeTipsPanel.SetExpEffectLoad()
end

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantCultivateInfoMessage, UIServantPracticeTipsPanel.OnResServantCultivateInfoMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, UIServantPracticeTipsPanel.OnBagItemChangeCallBack)
    luaEventManager.DoCallback(LuaCEvent.ServantPracticeEffectRefresh, true)
end

return UIServantPracticeTipsPanel