---@class UIJuLingZhuPanel 聚灵珠界面
local UIJuLingZhuPanel = {}

---@type bagV2.BagItemInfo
UIJuLingZhuPanel.mBagItemInfo = nil
---@type TABLE.CFG_ITEMS
UIJuLingZhuPanel.mItemInfo = nil
---@type number
UIJuLingZhuPanel.mCount = 1
UIJuLingZhuPanel.mBagItems = nil

---聚灵珠Id 对应货币信息
UIJuLingZhuPanel.ItemIdToCoinId = nil

---使用聚灵珠消耗道具名字
UIJuLingZhuPanel.mCostName = "道具"

---聚灵珠Id 对应花费信息
UIJuLingZhuPanel.ItemIdToCostNum = nil

---聚灵珠消费道具对应ItemInfo
UIJuLingZhuPanel.CostIdToItemInfo = {}

---是否正在使用聚灵珠
UIJuLingZhuPanel.isShowEffect = false
UIJuLingZhuPanel.btnType = 1
UIJuLingZhuPanel.EffectParent = nil
UIJuLingZhuPanel.EffectCallBack = nil

--region 组件
---标题文字
---@return UILabel
function UIJuLingZhuPanel.TitleLabel_UILabel()
    if UIJuLingZhuPanel.mTitleLabel_UILabel == nil then
        UIJuLingZhuPanel.mTitleLabel_UILabel = UIJuLingZhuPanel:GetCurComp("WidgetRoot/window/background/Label", "UILabel")
    end
    return UIJuLingZhuPanel.mTitleLabel_UILabel
end

---图片icon
---@return UISprite
function UIJuLingZhuPanel.BackgroundIcon_UISprite()
    if UIJuLingZhuPanel.mBackgroundIcon_UISprite == nil then
        UIJuLingZhuPanel.mBackgroundIcon_UISprite = UIJuLingZhuPanel:GetCurComp("WidgetRoot/window/background/Icon", "UISprite")
    end
    return UIJuLingZhuPanel.mBackgroundIcon_UISprite
end

---倍数文字
---@return UILabel
function UIJuLingZhuPanel.CountLabel_UILabel()
    if UIJuLingZhuPanel.mCountLabel_UILabel == nil then
        UIJuLingZhuPanel.mCountLabel_UILabel = UIJuLingZhuPanel:GetCurComp("WidgetRoot/view/Count", "UILabel")
    end
    return UIJuLingZhuPanel.mCountLabel_UILabel
end

---经验值
---@return UILabel
function UIJuLingZhuPanel.ExpValue_UILabel()
    if UIJuLingZhuPanel.mExpValue_UILabel == nil then
        UIJuLingZhuPanel.mExpValue_UILabel = UIJuLingZhuPanel:GetCurComp("WidgetRoot/view/expvalue", "UILabel")
    end
    return UIJuLingZhuPanel.mExpValue_UILabel
end

---单个价格
---@return GameObje
function UIJuLingZhuPanel.Singleprice_GameObject()
    if UIJuLingZhuPanel.mSingleprice_GameObject == nil then
        UIJuLingZhuPanel.mSingleprice_GameObject = UIJuLingZhuPanel:GetCurComp("WidgetRoot/view/singleprice", "GameObject")
    end
    return UIJuLingZhuPanel.mSingleprice_GameObject
end

---单个价格Icon
function UIJuLingZhuPanel.GetSinglePriceIcon_UISprite()
    if UIJuLingZhuPanel.mSinglePriceIcon == nil then
        UIJuLingZhuPanel.mSinglePriceIcon = UIJuLingZhuPanel:GetCurComp("WidgetRoot/view/singleprice/price/icon", "UISprite")
    end
    return UIJuLingZhuPanel.mSinglePriceIcon
end

---多个价格
---@return GameObject
function UIJuLingZhuPanel.Totalprice_GameObject()
    if UIJuLingZhuPanel.mTotalprice_GameObject == nil then
        UIJuLingZhuPanel.mTotalprice_GameObject = UIJuLingZhuPanel:GetCurComp("WidgetRoot/view/totalprice", "GameObject")
    end
    return UIJuLingZhuPanel.mTotalprice_GameObject
end

---多个价格Icon
function UIJuLingZhuPanel.GetTotalPriceIcon_UISprite()
    if UIJuLingZhuPanel.mTotalPriceIcon == nil then
        UIJuLingZhuPanel.mTotalPriceIcon = UIJuLingZhuPanel:GetCurComp("WidgetRoot/view/totalprice/price/icon", "UISprite")
    end
    return UIJuLingZhuPanel.mTotalPriceIcon
end

---关闭按钮
---@return UnityEngine.GameObject
function UIJuLingZhuPanel.CloseButton_GO()
    if UIJuLingZhuPanel.mCloseBtn_GO == nil then
        UIJuLingZhuPanel.mCloseBtn_GO = UIJuLingZhuPanel:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return UIJuLingZhuPanel.mCloseBtn_GO
end

function UIJuLingZhuPanel.GetLevelEffectRoot()
    if (UIJuLingZhuPanel.mLevelEffectRoot == nil) then
        local panel = uimanager:GetPanel("UIAllTextTipsContainerPanel")
        if (panel ~= nil) then
            UIJuLingZhuPanel.mLevelEffectRoot = panel.GetEffectRoot_GameObject()
        end
    end
    return UIJuLingZhuPanel.mLevelEffectRoot
end
--endregion

--region 初始化
function UIJuLingZhuPanel:Init()
    UIJuLingZhuPanel:InitComponent()
    UIJuLingZhuPanel.BindUIEvents()
    UIJuLingZhuPanel.InitData()
    self:BindMessage()
end

---@type bagV2.BagItemInfo 聚灵珠对应的背包物品
---@type TABLE.CFG_ITEMS
function UIJuLingZhuPanel:Show(customData)
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.JLZPanel
    UIJuLingZhuPanel:RunBaseFunction("Show")
    UIJuLingZhuPanel:AddCollider()
    UIJuLingZhuPanel.mItemInfo = customData.info
    if UIJuLingZhuPanel.mItemInfo == nil then
        uimanager:ClosePanel("UIJuLingZhuPanel")
        return
    end
    UIJuLingZhuPanel.mBagItems = CS.CSScene.MainPlayerInfo.BagInfo:GetGatheringBeads(customData.info.id)
    if UIJuLingZhuPanel.mBagItems and UIJuLingZhuPanel.mBagItems.Count > 0 then
        UIJuLingZhuPanel.mBagItemInfo = UIJuLingZhuPanel.mBagItems[0]
    end
    UIJuLingZhuPanel.mCount = UIJuLingZhuPanel.GetBeadsNum()
    UIJuLingZhuPanel.RefreshUI()
    UIJuLingZhuPanel.IsShowUseEffect()
end

---获取聚灵珠数目
function UIJuLingZhuPanel.GetBeadsNum()
    local num = 0
    if UIJuLingZhuPanel.mBagItems then
        for i = 0, UIJuLingZhuPanel.mBagItems.Count - 1 do
            num = num + UIJuLingZhuPanel.mBagItems[i].count
        end
    end
    return num
end

function UIJuLingZhuPanel.BindUIEvents()
    CS.UIEventListener.Get(UIJuLingZhuPanel.icon).onClick = UIJuLingZhuPanel.onShowInfo
    CS.UIEventListener.Get(UIJuLingZhuPanel.CloseButton_GO()).onClick = UIJuLingZhuPanel.OnCloseButtonClicked
    CS.UIEventListener.Get(UIJuLingZhuPanel.singleprice_Btn).onClick = UIJuLingZhuPanel.OnSingleprice_BtnClicked
    CS.UIEventListener.Get(UIJuLingZhuPanel.totalprice_Btn).onClick = UIJuLingZhuPanel.OnTotalprice_Btnlicked
    UIJuLingZhuPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UIJuLingZhuPanel.OnResBagChangeMessageReceived)
    -- commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResCanUseGatherSpiritBeadMessage, UIJuLingZhuPanel.OnResCanUseGatherSpiritBeadMessageCallBack)
    UIJuLingZhuPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, UIJuLingZhuPanel.RefreshUI);
    UIJuLingZhuPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, UIJuLingZhuPanel.ShowRoleLevelUpEffect);
end

function UIJuLingZhuPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, UIJuLingZhuPanel.RefreshSinglePriceAndTotalPrice)
end

---初始化组件
function UIJuLingZhuPanel:InitComponent()
    UIJuLingZhuPanel.singleprice_Lable = UIJuLingZhuPanel:GetComp(UIJuLingZhuPanel.Singleprice_GameObject().transform, "price", "UILabel")
    UIJuLingZhuPanel.singleprice_Btn = UIJuLingZhuPanel:GetComp(UIJuLingZhuPanel.Singleprice_GameObject().transform, "btn", "GameObject")
    UIJuLingZhuPanel.totalprice_Lable = UIJuLingZhuPanel:GetComp(UIJuLingZhuPanel.Totalprice_GameObject().transform, "price", "UILabel")
    UIJuLingZhuPanel.totalprice_Btn = UIJuLingZhuPanel:GetComp(UIJuLingZhuPanel.Totalprice_GameObject().transform, "btn", "GameObject")
    UIJuLingZhuPanel.icon = UIJuLingZhuPanel:GetComp(UIJuLingZhuPanel.go.transform, "WidgetRoot/window/background/Icon", "GameObject")
    UIJuLingZhuPanel.Icon_TweenPosition = UIJuLingZhuPanel:GetComp(UIJuLingZhuPanel.go.transform, "WidgetRoot/window/background/Icon", "TweenPosition")
    UIJuLingZhuPanel.Icon_TweenAphla = UIJuLingZhuPanel:GetComp(UIJuLingZhuPanel.go.transform, "WidgetRoot/window/background/Icon", "TweenAlpha")
    UIJuLingZhuPanel.Icon_TweenAphla:AddOnFinished(function()
        if UIJuLingZhuPanel.closePanel then
            uimanager:ClosePanel("UIJuLingZhuPanel")
        else
            UIJuLingZhuPanel.BackgroundIcon_UISprite().transform.localPosition = UIJuLingZhuPanel.Icon_TweenPosition.from
            UIJuLingZhuPanel.BackgroundIcon_UISprite().alpha = 1
        end
    end)
end

function UIJuLingZhuPanel.InitData()
    UIJuLingZhuPanel.GetCostData()
end
--endregion

--region UI事件
function UIJuLingZhuPanel.onShowInfo()
    if UIJuLingZhuPanel.mBagItemInfo ~= nil then
        --打开物品信息界面
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = UIJuLingZhuPanel.mBagItemInfo, showRight = false })
    end
end

function UIJuLingZhuPanel.OnCloseButtonClicked()
    uimanager:ClosePanel("UIJuLingZhuPanel")
end

function UIJuLingZhuPanel.OnSingleprice_BtnClicked()

    if UIJuLingZhuPanel.closePanel then
        return
    end
    if UIJuLingZhuPanel.mCount == 1 then
        UIJuLingZhuPanel.closePanel = true
    else
        UIJuLingZhuPanel.closePanel = false
    end
    UIJuLingZhuPanel.SinglepriceCallBack()
end

function UIJuLingZhuPanel.OnTotalprice_Btnlicked()
    if UIJuLingZhuPanel.closePanel then
        return
    end
    --使用全部聚灵珠
    if UIJuLingZhuPanel.playerHas and UIJuLingZhuPanel.totalPay then
        --足够全部使用
        if UIJuLingZhuPanel.playerHas >= UIJuLingZhuPanel.totalPay then
            UIJuLingZhuPanel.TotalpriceCallBack()
            UIJuLingZhuPanel.closePanel = true
            uimanager:ClosePanel("UIJuLingZhuPanel")
        else
            if UIJuLingZhuPanel.mBagItemInfo ~= nil then
                local remainCount = UIJuLingZhuPanel.mBagItemInfo.count
                local canBuyCount = math.floor(UIJuLingZhuPanel.playerHas / UIJuLingZhuPanel.singlePay)
                if canBuyCount > 0 and remainCount > 0 then
                    networkRequest.ReqUseItem(remainCount > canBuyCount and canBuyCount or remainCount, UIJuLingZhuPanel.mBagItemInfo.lid, 1)
                    UIJuLingZhuPanel.ShowJULINGBallEffect()
                    return
                end
            end
            UIJuLingZhuPanel.ShowTips(UIJuLingZhuPanel.totalprice_Btn, 37)
        end
    end
end

function UIJuLingZhuPanel.SinglepriceCallBack()
    if UIJuLingZhuPanel.mBagItemInfo ~= nil then
        networkRequest.ReqUseItem(1, UIJuLingZhuPanel.mBagItemInfo.lid, 1)
    end
    UIJuLingZhuPanel.ShowJULINGBallEffect()
    if UIJuLingZhuPanel.closePanel and UIJuLingZhuPanel.IsShowUseEffect() then
        uimanager:ClosePanel("UIJuLingZhuPanel")
    end
end

function UIJuLingZhuPanel.TotalpriceCallBack()
    if UIJuLingZhuPanel.mItemInfo then
        networkRequest.ReqUseAllExpBox(UIJuLingZhuPanel.mItemInfo.id)
        if isOpenLog then
            luaDebug.Log(" TotalpriceCallBack :   UIJuLingZhuPanel.mItemInfo ~= nil  ")
        end
    end
    UIJuLingZhuPanel.closePanel = true
    local panel = uimanager:GetPanel('UIMainChatPanel')
    if panel then
        panel.ShowJLZEffect(nil)
        if panel.mExpSlider then
            panel.mExpSlider.finishCallBack = function()
                UIJuLingZhuPanel.ShowExptips(1)
            end
        end
    end
end

---@param trans GameObject 按钮
---@param str string    内容
---@param id  number    提示框id
function UIJuLingZhuPanel.ShowTips(go, id)
    --local str = UIJuLingZhuPanel.mCostName .. "不足"
    local coinID = 0
    if UIJuLingZhuPanel.mItemInfo ~= nil then
        coinID = UIJuLingZhuPanel.ItemIdToCoinId[UIJuLingZhuPanel.mItemInfo.id]
    end
    --Utility.ShowPopoTips(go, str, id, "UIJuLingZhuPanel", { itemid = coinID })
    local EntranceWay
    if (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.JLZPanel) then
        if (coinID == 1000002) then
            --元宝
            EntranceWay = LuaEnumRechargePointType.UseJLZIngotNotEnough
        elseif (coinID == 1000004) then
            --金币
            EntranceWay = LuaEnumRechargePointType.UseJLZGoldNotEnough
        end
    end
    Utility.ShowItemGetWay(coinID, UIJuLingZhuPanel.singleprice_Btn, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(60, 0), nil, EntranceWay);
end

function UIJuLingZhuPanel.ShowJULINGBallEffect()
    local panel = uimanager:GetPanel('UIMainChatPanel')
    if panel then
        if (UIJuLingZhuPanel.IsShowUseEffect()) then
            panel.ShowJLZEffect(nil)
        else
            UIJuLingZhuPanel.closePanel = false
            UIJuLingZhuPanel.ShowTips(UIJuLingZhuPanel.singleprice_Btn, 37)
        end
        if panel.mExpSlider then
            panel.mExpSlider.finishCallBack = function()
                UIJuLingZhuPanel.ShowExptips(1)
            end
        end
    end
end

function UIJuLingZhuPanel.ShowExptips(count)
    --local dataTipsData = {}
    --dataTipsData.dialogType = LuaEnumDialogTipsShapeType.NoArrow
    --local exp = UIJuLingZhuPanel.mItemInfo == nil and 0 or tonumber(UIJuLingZhuPanel.mItemInfo.useParam.list[1]) * count
    --dataTipsData.contents = exp == 0 and '' or "经验 + " .. tostring(exp)
    --dataTipsData.highLightContent = nil
    --dataTipsData.closeAction = UIJuLingZhuPanel.OnClickDialogTipsPanelCloseBtn
    --if UIJuLingZhuPanel.mDialogTips then
    --    UIJuLingZhuPanel.mDialogTips:Hide()
    --    UIJuLingZhuPanel.mDialogTips = nil
    --end
    --dataTipsData.time = 3
    --uimanager:CreatePanel("UIDialogTipsContainerPanel", function(dialogTipsContainer)
    --    if UIJuLingZhuPanel then
    --        UIJuLingZhuPanel.mDialogTips = dialogTipsContainer.CreateDialogTips(dataTipsData)
    --        --设置聚灵珠位置
    --        UIJuLingZhuPanel.SetTipsPostion(UIJuLingZhuPanel.mDialogTips)
    --    end
    --    uiStaticParameter.isBreakjlzEffect = false
    --    UIJuLingZhuPanel.isShowEffect = false
    --end)
end
--endregion

--region 服务器事件

function UIJuLingZhuPanel.OnResBagChangeMessageReceived(id, data)
    if data.action ~= nil and data.action == 2052 then
        UIJuLingZhuPanel:RefreshPanel()
    end
end

---请求检验聚灵珠回调(暂时取消)
function UIJuLingZhuPanel.OnResCanUseGatherSpiritBeadMessageCallBack(id, data)
    if data.canUse then
        UIJuLingZhuPanel.isShowEffect = true
        if UIJuLingZhuPanel.mCount == 1 then
            UIJuLingZhuPanel.closePanel = true
        else
            UIJuLingZhuPanel.closePanel = false
        end
        UIJuLingZhuPanel.mCount = data.count - 1
        UIJuLingZhuPanel.RefreshUI()
        local panel = uimanager:GetPanel('UIMainChatPanel')
        if panel then
            panel.ShowJLZEffect(function()
                UIJuLingZhuPanel.SinglepriceCallBack()
            end)
        end
        if UIJuLingZhuPanel.closePanel then
            uimanager:ClosePanel("UIJuLingZhuPanel")
        end
    else
        UIJuLingZhuPanel.ShowTips(UIJuLingZhuPanel.singleprice_Btn, 37)
    end
end

--endregion

---计算单价
function UIJuLingZhuPanel.IsShowUseEffect()
    local costId = UIJuLingZhuPanel.ItemIdToCoinId[UIJuLingZhuPanel.mItemInfo.id]
    local singlePay = UIJuLingZhuPanel.ItemIdToCostNum[UIJuLingZhuPanel.mItemInfo.id]
    local playerHas = 0
    if singlePay then
        playerHas = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(costId)
    end
    if (singlePay > playerHas) then
        return false
    else
        return true
    end
end

---刷新面板
function UIJuLingZhuPanel:RefreshPanel()
    local mBagItems = CS.CSScene.MainPlayerInfo.BagInfo:FilterItemByMethod(function(bagItemTemp)
        return bagItemTemp.itemId == UIJuLingZhuPanel.mItemInfo.id and bagItemTemp.luck == bagItemTemp.maxStar
    end)
    if mBagItems ~= nil and mBagItems.Count > 0 then
        UIJuLingZhuPanel:Show({ info = UIJuLingZhuPanel.mItemInfo })
    end
end

---刷新UI界面
function UIJuLingZhuPanel.RefreshUI()
    UIJuLingZhuPanel.BackgroundIcon_UISprite().spriteName = UIJuLingZhuPanel.mItemInfo.icon
    UIJuLingZhuPanel.TitleLabel_UILabel().text = UIJuLingZhuPanel.mItemInfo.name
    if (UIJuLingZhuPanel.mBagItemInfo ~= nil) then
        UIJuLingZhuPanel.ExpValue_UILabel().text = tostring(UIJuLingZhuPanel.mBagItemInfo.maxStar) .. "经验" --luaEnumColorType.BluePurple ..
    end

    local playerLevel = CS.CSScene.MainPlayerInfo.Level
    local isShowTotal = UIJuLingZhuPanel.mCount > 1 and playerLevel >= 75
    UIJuLingZhuPanel.CountLabel_UILabel().gameObject:SetActive(UIJuLingZhuPanel.mCount > 1)
    UIJuLingZhuPanel.CountLabel_UILabel().text = ternary(UIJuLingZhuPanel.mCount > 1, "x " .. tostring(UIJuLingZhuPanel.mCount), "") --[fbd671]
    local singlePriceLocalPosition = UIJuLingZhuPanel.Singleprice_GameObject().transform.localPosition
    singlePriceLocalPosition.x = ternary(isShowTotal, -81, 16)
    UIJuLingZhuPanel.Singleprice_GameObject().transform.localPosition = singlePriceLocalPosition
    UIJuLingZhuPanel.Totalprice_GameObject():SetActive(isShowTotal)

    UIJuLingZhuPanel:RefreshSinglePriceAndTotalPrice()
end

---播放升级特效
function UIJuLingZhuPanel.ShowRoleLevelUpEffect()
    if (uiStaticParameter.LevelUpEffect == nil) then
        UIJuLingZhuPanel.LoadEffect('700115', UIJuLingZhuPanel.GetLevelEffectRoot().transform, function(path, obj)
            uiStaticParameter.LevelUpEffect = obj
        end)
    else
        uiStaticParameter.LevelUpEffect:SetActive(false)
        uiStaticParameter.LevelUpEffect:SetActive(true)
    end
end

function UIJuLingZhuPanel.LoadEffect(code, parent, CallBack)
    UIJuLingZhuPanel.EffectParent = parent
    UIJuLingZhuPanel.CallBack = CallBack
    CS.CSResourceManager.Singleton:AddQueueCannotDelete(code, CS.ResourceType.UIEffect, UIJuLingZhuPanel.LevelUpEffectFinished, CS.ResourceAssistType.UI)
end

function UIJuLingZhuPanel.LevelUpEffectFinished(res)
    if res ~= nil or res.MirrorObj ~= nil then
        --设置父物体
        if UIJuLingZhuPanel.EffectParent == nil and CS.StaticUtility.IsNull(UIJuLingZhuPanel.EffectParent) then
            return
        end
        UIJuLingZhuPanel.promptEffect_Path = res.Path
        local go = res:GetObjInst()
        if go then
            go.transform.parent = UIJuLingZhuPanel.EffectParent
            go.transform.localPosition = CS.UnityEngine.Vector3(0, 200, 0)
            go.transform.localScale = CS.UnityEngine.Vector3.one
        end
        if UIJuLingZhuPanel.CallBack then
            UIJuLingZhuPanel.CallBack(res.Path, go)
        end
    end
end

---刷新单个价格和总共价格
function UIJuLingZhuPanel:RefreshSinglePriceAndTotalPrice()
    if UIJuLingZhuPanel.mItemInfo then
        local costId = UIJuLingZhuPanel.ItemIdToCoinId[UIJuLingZhuPanel.mItemInfo.id]
        UIJuLingZhuPanel.singlePay = UIJuLingZhuPanel.ItemIdToCostNum[UIJuLingZhuPanel.mItemInfo.id]
        if UIJuLingZhuPanel.singlePay then
            UIJuLingZhuPanel.playerHas = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(costId)
            UIJuLingZhuPanel.totalPay = UIJuLingZhuPanel.singlePay * UIJuLingZhuPanel.mCount
            if costId then
                local itemInfo = UIJuLingZhuPanel.GetCostIcon(costId)
                UIJuLingZhuPanel.GetSinglePriceIcon_UISprite().spriteName = itemInfo.icon
                UIJuLingZhuPanel.GetTotalPriceIcon_UISprite().spriteName = itemInfo.icon
                UIJuLingZhuPanel.mCostName = itemInfo.name
                UIJuLingZhuPanel.singleprice_Lable.text = Utility.NewGetBBCode(UIJuLingZhuPanel.playerHas >= UIJuLingZhuPanel.singlePay) .. UIJuLingZhuPanel.singlePay
                UIJuLingZhuPanel.totalprice_Lable.text = Utility.NewGetBBCode(UIJuLingZhuPanel.playerHas >= UIJuLingZhuPanel.totalPay) .. UIJuLingZhuPanel.totalPay
                --UIJuLingZhuPanel:CheackCheatPush(itemInfo.id)
            end
        end
    end
end

---获取花费道具信息
function UIJuLingZhuPanel.GetCostIcon(id)
    if UIJuLingZhuPanel.CostIdToItemInfo[id] == nil then
        local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
        if res then
            UIJuLingZhuPanel.CostIdToItemInfo[id] = itemInfo
        end
    end
    return UIJuLingZhuPanel.CostIdToItemInfo[id]
end

---获取消耗道具信息
function UIJuLingZhuPanel.GetCostData()
    if UIJuLingZhuPanel.ItemIdToCoinId == nil or UIJuLingZhuPanel.ItemIdToCostNum == nil then
        UIJuLingZhuPanel.ItemIdToCoinId = {}
        UIJuLingZhuPanel.ItemIdToCostNum = {}
        local res, globalBeatsInfo = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20218)
        if res then
            local strs = string.Split(globalBeatsInfo.value, '&')
            for i = 0, #strs do
                local info = string.Split(strs[i], '#')
                if #info >= 2 then
                    if tonumber(info[1]) then
                        UIJuLingZhuPanel.ItemIdToCoinId[tonumber(info[1])] = tonumber(info[2])
                        UIJuLingZhuPanel.ItemIdToCostNum[tonumber(info[1])] = tonumber(info[3])
                    end
                end
            end
        end
    end
end

---播放动画
function UIJuLingZhuPanel:PlayTween()
    if UIJuLingZhuPanel.Icon_TweenPosition ~= nil and UIJuLingZhuPanel.Icon_TweenAphla ~= nil then
        UIJuLingZhuPanel.Icon_TweenPosition:PlayTween()
        UIJuLingZhuPanel.Icon_TweenAphla:PlayTween()
    end
end

--region 设置气泡位置

---设置tips位置
function UIJuLingZhuPanel.SetTipsPostion(panel)
    if panel == nil then
        return
    end
    local posY = -365
    local posX = 0

    local limitXMax = 610
    local limitXMin = -474
    --计算目标位置
    local curLevel = CS.CSScene.MainPlayerInfo.Level
    local curMaxExp = CS.Cfg_CharacterManager.Instance:GetUpGradeExpByLevel(curLevel)
    local curExp = CS.CSScene.MainPlayerInfo.Exp
    --当前进度
    local curAmount = curExp / curMaxExp
    curAmount = Utility.GetPreciseDecimal(curAmount, 3)
    ----目标进度
    --local targetAmount = 0
    --if curExp + exp < curMaxExp then
    --    targetAmount = (curExp + exp) / curMaxExp
    --    targetAmount = Utility.GetPreciseDecimal(targetAmount, 3)
    --else
    --    local minExp = curExp + exp - curMaxExp
    --    local targetMaxExp = CS.Cfg_CharacterManager.Instance:GetUpGradeExpByLevel(curLevel + 1)
    --    targetAmount = minExp / targetMaxExp
    --    targetAmount = Utility.GetPreciseDecimal(targetAmount, 3)
    --end
    --local conterAmount = targetAmount > curAmount and curAmount + (targetAmount - curAmount) / 2 or targetAmount < curAmount and targetAmount / 2 or targetAmount
    -- luaDebug.Log("conterAmount" .. conterAmount)
    posX = -(CS.CSGame.Sington.ContentSize.x / 2) + (CS.CSGame.Sington.ContentSize.x * curAmount)
    -- luaDebug.Log("posX" .. posX)
    posX = posX < limitXMin and limitXMin or posX > limitXMax and limitXMax or posX
    --判断界限 设置位置
    panel.go.transform.localPosition = CS.UnityEngine.Vector3(posX, posY, 3)
end

--endregion

--region 秘籍推送

---判断是否自动推送
function UIJuLingZhuPanel:CheackCheatPush(itemId)
    local isCheat, cheatId = Utility.CheckAutomaticCheatPush(itemId)
    if UIJuLingZhuPanel.playerHas < UIJuLingZhuPanel.singlePay and UIJuLingZhuPanel.Singleprice_GameObject() ~= nil and UIJuLingZhuPanel.Singleprice_GameObject().activeSelf then
        if isCheat then
            local data = {}
            data.id = cheatId
            data.dependPanel = "UIJuLingZhuPanel"
            data.isNotCheckCondition = true
            Utility.ShowCheatPushTips(data)
        end
    elseif UIJuLingZhuPanel.playerHas < UIJuLingZhuPanel.totalPay and UIJuLingZhuPanel.Totalprice_GameObject() ~= nil and UIJuLingZhuPanel.Totalprice_GameObject().activeSelf then
        if isCheat then
            local data = {}
            data.id = cheatId
            data.dependPanel = "UIJuLingZhuPanel"
            data.isNotCheckCondition = true
            Utility.ShowCheatPushTips(data)
        end
    end
end

--endregion

--region OnDestroy
function ondestroy()
    if UIJuLingZhuPanel.mBagItemInfo ~= nil and CS.CSScene.MainPlayerInfo and CS.CSScene.MainPlayerInfo.BagInfo ~= nil then
        CS.CSScene.MainPlayerInfo.BagInfo:RemoveBeadsList(UIJuLingZhuPanel.mBagItemInfo.itemId)
    end
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, UIJuLingZhuPanel.OnResBagChangeMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResCanUseGatherSpiritBeadMessage, UIJuLingZhuPanel.OnResCanUseGatherSpiritBeadMessageCallBack)
end
--endregion
return UIJuLingZhuPanel