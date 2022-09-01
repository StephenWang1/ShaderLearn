---@class UIRechargeRewardTemplate:TemplateBase 充值领奖格子模板
local UIRechargeRewardTemplate = {}

function UIRechargeRewardTemplate:Init(panel)
    ---@type UIRechargePanel
    self.RootPanel = panel
    self:InitComponent()
    self:BindEvents()
end

function UIRechargeRewardTemplate:InitComponent()

    ---充值标题（X元礼包）
    ---@type UILabel
    self.mTitle_UILabel = self:Get("background/Table/title", "UILabel")

    ---充值标题（X元礼包）
    ---@type UISprite
    self.mRechargeTitle_UISprite = self:Get("background/Table/sprite", "UISprite")

    ---居中标题（登录/在线礼包）
    ---@type UISprite
    self.mMiddleTitle_UISprite = self:Get("background/titleM", "UISprite")

    ---背景图片
    ---@type UISprite
    self.mRewardBg_UISprite = self:Get("background/reward_bg", "UISprite")

    ---奖励图片
    ---@type UISprite
    self.mRewardSp_UISprite = self:Get("background/reward_sprite", "UISprite")

    ---描述1
    ---@type UILabel
    self.mDes1_UILabel = self:Get("background/description1", "UILabel")

    ---描述1数字文本
    ---@type UILabel
    self.mDesNumLabel_UILabel = self:Get("background/description1/sprite/num", "UILabel")

    ---描述2  ---充值标题（X元）
    ---@type UILabel
    self.mDes2_UILabel = self:Get("background/description2", "UILabel")

    ---倒计时文本
    ---@type UICountdownLabel
    self.mDes2TimeCount_UILabel = self:Get("background/description2", "UICountdownLabel")

    ---奖励列表
    ---@type UIGridContainer
    self.mRewardList_UIGridContainer = self:Get("rewardsList", "UIGridContainer")

    ---领取/价格文字
    ---@type UILabel
    self.price_UILabel = self:Get("btn_get/cost/label", "UILabel")

    ---领奖特效
    ---@type UnityEngine.GameObject
    self.btnEffect_GameObject = self:Get("btn_get/effect", "GameObject")

    ---领取/价格按钮
    ---@type UILabel
    self.price_GameObject = self:Get("btn_get", "GameObject")

    ---领取/价格按钮图片
    ---@type UISprite
    self.btnGet_Sprite = self:Get("btn_get", "UISprite")

    ---领取/价格文字倒计时
    ---@type UILabel
    self.price_UITimeCountLabel = self:Get("btn_get/cost/label", "UICountdownLabel")

    ---帮助按钮
    ---@type UnityEngine.GameObject
    self.BtnHelp_Go = self:Get("btn_help", "GameObject")

    ---@type UnityEngine.GameObject
    ---分享按钮
    self.mShareBtn_Go = self:Get("btn_Share", "GameObject")

    ---@type UnityEngine.GameObject
    ---微信分享按钮
    self.mWeChatShare_Go = self:Get("btn_Share/wechat", "GameObject")

    ---@type UnityEngine.GameObject
    ---QQ分享
    self.mQQShare_Go = self:Get("btn_Share/QQ", "GameObject")

    ---@type UnityEngine.GameObject
    ---背景选中特效框
    self.mBgEffect = self:Get("background/effect", "GameObject")

    ---@type UnityEngine.GameObject
    ---直购礼包
    self.BuyRewardGO = self:Get("background/reward_limit", "GameObject")

    ---@type UnityEngine.GameObject
    ---限时标记
    self.mLimitSign = self:Get("background/Table/limit", "GameObject")

    ---@type UISprite
    ---直购礼包图片
    self.mBuyRewardIcon = self:Get("background/reward_limit/reward_icon", "UISprite")

    ---@type UISprite
    ---直购礼包图片
    self.mBuyRewardDesIcon = self:Get("background/reward_limit/reward_label", "UISprite")

    ---@type CSUIEffectLoad
    ---直购特效
    self.mBuyRewardEffect = self:Get("background/reward_limit/reward_icon/effect", "CSUIEffectLoad")

    ---@type UILabel
    ---直购奖励数目
    self.mBuyRewardCount = self:Get("background/reward_limit/reward_count", "UILabel")

    ---@type UnityEngine.GameObject
    ---限时礼包背景
    self.mBuyLimit_Go = self:Get("background/reward_limit/Sprite", "GameObject")

    ---@type UITable
    self.mBuyingTable_UITable = self:Get("background/Table", "UITable")

    ---@type UnityEngine.GameObject
    self.mRewardBuyNum_Go = self:Get("reward_num", "GameObject")

    ---@type UISprite
    self.mRewardBuyNum_UISprite = self:Get("reward_num/sprite", "UISprite")

    ---@type UILabel
    self.mRewardBuyNum_UILabel = self:Get("reward_num/num", "UILabel")

    ---@type UISprite
    self.mRewardBuydescription1_Sprite = self:Get("reward_num/description1", "UISprite")
    ---@type UISprite
    self.mRewardBuydescription2_Sprite = self:Get("reward_num/description2", "UISprite")
    ---@type UISprite
    self.mRewardBuyGet_Sprite = self:Get("reward_num/get", "UISprite")

    ---@type UnityEngine.GameObject
    self.mDiamondSprite_Go = self:Get("btn_get/cost/DiamondSprite", "GameObject")
    ---@type UISprite
    self.mDiamondSprite_Sprite = self:Get("btn_get/cost/DiamondSprite", "UISprite")

    ---@type UISprite
    self.mDiamondSprite_UISprite = self:Get("btn_get/cost/DiamondSprite", "UISprite")

    ---@type UnityEngine.GameObject 花费的root节点用来适应居中
    self.mCost_Go = self:Get("btn_get/cost", "GameObject")

    ---@type  UnityEngine.GameObject 已领取Obj
    self.rewardObj = self:Get("reward", "GameObject")

end

function UIRechargeRewardTemplate:BindEvents()
    if self.price_GameObject ~= nil then
        CS.UIEventListener.Get(self.price_GameObject).onClick = function()
            self:OnGetItemClicked(self.price_GameObject)
        end
    end

    if self.BtnHelp_Go ~= nil then
        CS.UIEventListener.Get(self.BtnHelp_Go).onClick = function()
            if self.RootPanel then
                local info = self.RootPanel:GetRechargeHelpDes()
                uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
            end
        end
    end

    if self.mWeChatShare_Go ~= nil then
        CS.UIEventListener.Get(self.mWeChatShare_Go).onClick = function()
            self:OnShareBtnClick()
        end
    end

    if self.mQQShare_Go ~= nil then
        CS.UIEventListener.Get(self.mQQShare_Go).onClick = function()
            self:OnShareBtnClick()
        end
    end

    if self.mBuyRewardIcon ~= nil then
        CS.UIEventListener.Get(self.mBuyRewardIcon.gameObject).onClick = function()
            self:OnClickBuyingReward()
        end
    end
end

function UIRechargeRewardTemplate:Refresh(data, onlineTime, selectID)
    if data == nil then
        return
    end
    ---@type TABLE.cfg_tower
    self.data = data
    self.IsSelectNowRecharge = false
    self.mLimitSign:SetActive(false)
    self.mRewardBuyNum_Go:SetActive(false)
    self.mBuyingRewardInfo = nil
    self.mRewardList_UIGridContainer.MaxPerLine = 3;
    self.btnGet_Sprite.spriteName = "btn_reward"
    self.rewardObj.gameObject:SetActive(false)
    self.price_GameObject.gameObject:SetActive(true)
    if data.tableInfo then
        --限时购买和每次充值不要这个图片
        self.mRewardSp_UISprite.gameObject:SetActive(data.type ~= luaEnumRechargeRewardType.LimitBuy and data.type ~= luaEnumRechargeRewardType.DayRecharge)
        self.BuyRewardGO:SetActive(data.type == luaEnumRechargeRewardType.LimitBuy or data.type == luaEnumRechargeRewardType.LastRecharge or data.type == luaEnumRechargeRewardType.CircleDiamondGift or data.type == luaEnumRechargeRewardType.Buy)
        self.price_UITimeCountLabel:StopCountDown()
        self.mDes2TimeCount_UILabel:StopCountDown()

        --title价格
        local recharge = ""
        local Showrecharge = ""
        local des2 = ""
        ---@type TABLE.CFG_LINGJIANG_REWARD
        local tableInfo = data.tableInfo
        local rewardList
        self.isFinish = false
        if (data.type ~= luaEnumRechargeRewardType.DayRecharge) then
            self.mRewardBuyGet_Sprite.gameObject:SetActive(false)
            self.mRewardBuydescription1_Sprite.gameObject:SetActive(false)
            self.mRewardBuydescription2_Sprite.gameObject:SetActive(false)
        end
        if data.type == luaEnumRechargeRewardType.Online then
            self:RefreshOnlineReward(tableInfo, onlineTime)
            des2 = tableInfo.remarks
            rewardList = tableInfo.reward
            if rewardList and rewardList.list then
                self:ShowRewardList(rewardList)
            end
            if (self.mDiamondSprite_Go ~= nil) then
                self.mDiamondSprite_Go:SetActive(false)
            end
            self.rewardObj.gameObject:SetActive(data.receive == 1)
            self.price_GameObject.gameObject:SetActive(data.receive ~= 1)
        elseif data.type == luaEnumRechargeRewardType.Recharge then
            self.isFinish = data.receive == 1
            self.bubbleId = 198
            des2 = tableInfo.remarks
            if data.count and data.totalCount then
                local show
                if data.count == data.totalCount then
                    show = luaEnumColorType.SimpleYellow1 .. "可领取"
                else
                    show = string.format(tableInfo.remarks2, data.count .. "/" .. data.totalCount)
                end
                self.btnEffect_GameObject:SetActive(data.count == data.totalCount)
                self.price_UILabel.text = show
            end
            rewardList = tableInfo.reward
            if rewardList and rewardList.list then
                self:ShowRewardList(rewardList)
            end
        elseif data.type == luaEnumRechargeRewardType.IngotRecharge then
            self.isFinish = true
            if (tableInfo.storeIndex ~= 0 and CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic:TryGetValue(LuaEnumStoreType.DiamondRechargeGift) and CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic[LuaEnumStoreType.DiamondRechargeGift].storeUnitDic:TryGetValue(tableInfo.storeIndex)) then
                self.storeInfo = CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic[LuaEnumStoreType.DiamondRechargeGift].storeUnitDic[tableInfo.storeIndex]
                recharge = math.ceil(self.storeInfo.price)
                self.mDiamondSprite_Go:SetActive(true)
                self.mDiamondSprite_Sprite.spriteName = self.storeInfo.storeTable.moneyType
                self.price_UILabel.text = luaEnumColorType.SimpleYellow1 .. "" .. recharge
                local pos = self.mCost_Go.transform.localPosition
                pos.x = 16
                self.mCost_Go.transform.localPosition = pos
                self.mDiamondSprite_UISprite:MakePixelPerfect()
                self.mDiamondSprite_UISprite:UpdateAnchors()
                self.mDiamondSprite_UISprite:UpdateAnchors()
            end
            local rewardList = CS.Cfg_BoxTableManager.Instance:GetSemicolonReward(tableInfo.reward)
            self:ShowPurchaseIngotReward(rewardList)
        elseif data.type == luaEnumRechargeRewardType.Buy or data.type == luaEnumRechargeRewardType.LimitBuy then
            self.isFinish = true
            if (tableInfo.storeIndex ~= 0
                    and CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic:TryGetValue(LuaEnumStoreType.DiamondRechargeGift)
                    and CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic[LuaEnumStoreType.DiamondRechargeGift].storeUnitDic:TryGetValue(tableInfo.storeIndex)) then
                self.storeInfo = CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic[LuaEnumStoreType.DiamondRechargeGift].storeUnitDic[tableInfo.storeIndex]
                recharge = math.ceil(self.storeInfo.price / 100)
                --表示钻石直购礼包
                self.mDiamondSprite_Go:SetActive(true)
                self.mDiamondSprite_Sprite.spriteName = self.storeInfo.storeTable.moneyType
                self.price_UILabel.text = luaEnumColorType.SimpleYellow1 .. "" .. self.storeInfo.price
                local pos = self.mCost_Go.transform.localPosition
                pos.x = 16
                self.mCost_Go.transform.localPosition = pos
                self.mDiamondSprite_UISprite:MakePixelPerfect()
                self.mDiamondSprite_UISprite:UpdateAnchors()
                self.mDiamondSprite_UISprite:UpdateAnchors()
                if (self.mBuyRewardDesIcon ~= nil) then
                    self.mBuyRewardDesIcon.gameObject:SetActive(tableInfo.effectId ~= "")
                    self.mBuyRewardDesIcon.spriteName = tableInfo.effectId
                    self.mBuyRewardDesIcon:MakePixelPerfect()
                end
            else
                --表示人民币直购礼包
                self.mDiamondSprite_Go:SetActive(false)
                self.mCost_Go.transform.localPosition = { x = 0, y = 0, z = 0 }
                recharge = math.ceil(tableInfo.rmb / 100)
                self.price_UILabel.text = luaEnumColorType.SimpleYellow1 .. "￥" .. recharge
                self.mCost_Go.transform.localPosition = CS.UnityEngine.Vector3.zero
            end
            des2 = tableInfo.desc
            if data.type == luaEnumRechargeRewardType.Buy then
                self:RefreshBuyingReward2(tableInfo)
            else
                self:RefreshBuyingReward(tableInfo, data.type)
            end

            self:RefreshBuyingRewardOtherInfo(tableInfo)
        elseif data.type == luaEnumRechargeRewardType.LastRecharge then
            recharge = tableInfo.index
            if (self.mDiamondSprite_Go ~= nil) then
                self.mDiamondSprite_Go:SetActive(false)
            end
            self.isFinish = true
            self.mRewardList_UIGridContainer.MaxPerLine = 3;
            des2 = tableInfo.desc
            if (self.mBuyRewardDesIcon ~= nil) then
                self.mBuyRewardDesIcon.gameObject:SetActive(false)
            end
            self:RefreshLastRechargeReward(tableInfo)
        elseif data.type == luaEnumRechargeRewardType.Share then
            self.isFinish = true
            rewardList = tableInfo.reward
            local hasGet = data.receive == 1
            if rewardList and rewardList.list and not hasGet then
                self:ShowRewardList(rewardList)
            end
            local show = hasGet and "继续分享" or "分享下载地址"
            self.price_UILabel.text = luaEnumColorType.SimpleYellow1 .. show
            self.mClickShare = false
            self.mShareBtn_Go:SetActive(self.mClickShare)
        elseif data.type == luaEnumRechargeRewardType.DayRecharge then
            self.mRewardList_UIGridContainer.MaxPerLine = 2
            self.mRewardBuyNum_Go:SetActive(true)
            self.isFinish = true
            self.mCost_Go.transform.localPosition = CS.UnityEngine.Vector3.zero
            self.mRewardBuyNum_UILabel.text = "";

            self.btnEffect_GameObject:SetActive(data.remainRecharge <= 0)

            self.mRewardBuyGet_Sprite.gameObject:SetActive(data.remainRecharge <= 0)
            self.mRewardBuydescription1_Sprite.gameObject:SetActive(data.remainRecharge > 0)
            self.mRewardBuydescription2_Sprite.gameObject:SetActive(false)

            if (data.remainRecharge <= 0) then
                self.price_UILabel.text = luaEnumColorType.SimpleYellow1 .. "可领取"
            else
                --if (data.tableInfo.sequence == 1) then
                --    dayRechargeTxt = luaEnumColorType.SimpleYellow1 .. "充值任意金额可领取"
                --    self.btnEffect_GameObject:SetActive(true)
                --else
                self.mRewardBuyNum_UILabel.text = tostring(math.floor(data.remainRecharge / 100)) .. "元"
                --end
                self.price_UILabel.text = luaEnumColorType.Red3 .. "充值"
                self.btnEffect_GameObject:SetActive(false)
                self.btnGet_Sprite.spriteName = "btn_reward2"
            end
            self.mDiamondSprite_Go:SetActive(false)
            local rewardList = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(tableInfo.reward.list[0].list[0]);
            if rewardList then
                self:ShowListTypeReward(rewardList)
            end
            self.rewardObj.gameObject:SetActive(data.receive == 2)
            self.mRewardBuyNum_Go.gameObject:SetActive(data.receive ~= 2)
            self.price_GameObject.gameObject:SetActive(data.receive ~= 2)
        elseif (data.type == luaEnumRechargeRewardType.CircleDiamondGift) then
            self.isFinish = true
            self.mRewardList_UIGridContainer.MaxPerLine = 3;
            if (CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic:TryGetValue(LuaEnumStoreType.CircleDiamondRechargeGift)
                    and CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic[LuaEnumStoreType.CircleDiamondRechargeGift].storeUnitDic:TryGetValue(tableInfo.storeIndex)) then
                self.storeInfo = CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic[LuaEnumStoreType.CircleDiamondRechargeGift].storeUnitDic[tableInfo.storeIndex]
                recharge = math.ceil(self.storeInfo.price / 100)
                self.mDiamondSprite_Go:SetActive(true)
                self.mDiamondSprite_Sprite.spriteName = self.storeInfo.storeTable.moneyType
                self.price_UILabel.text = luaEnumColorType.SimpleYellow1 .. "" .. recharge * 100
                local pos = self.mCost_Go.transform.localPosition
                pos.x = 16
                self.mCost_Go.transform.localPosition = pos
                self.mDiamondSprite_UISprite:MakePixelPerfect()
                self.mDiamondSprite_UISprite:UpdateAnchors()
                self.mDiamondSprite_UISprite:UpdateAnchors()
                if (self.mBuyRewardDesIcon ~= nil and data.refreshType == 1) then
                    self.mBuyRewardDesIcon.spriteName = "giftsign_6"
                    self.mBuyRewardDesIcon:MakePixelPerfect()
                else
                    self.mBuyRewardDesIcon.spriteName = tableInfo.effectId
                    self.mBuyRewardDesIcon:MakePixelPerfect()
                end
                self:RefreshCircleDiamondGiftReward(data.tableInfo)
                self:RefreshCircleBuyingRewardOtherInfo(tableInfo)
            end
        end
        if recharge ~= "" then
            Showrecharge = math.ceil(tonumber(recharge))
        end
        if data.type == luaEnumRechargeRewardType.LastRecharge then
            ---如果是终身限购礼包,那么使用condition的参数作为其标题数值
            local conditionID = tonumber(data.tableInfo.conditions)
            if conditionID then
                Showrecharge = conditionID % 1000
            end
        end
        self:RefreshTitle(tableInfo.title, data.type, Showrecharge)
        self.mDes2_UILabel.text = des2
        self.BtnHelp_Go:SetActive(data.type == luaEnumRechargeRewardType.Recharge and tableInfo.sequence ~= 1)
        self.IsSelectNowRecharge = selectID ~= nil and data.tableInfo.id == selectID
        if selectID ~= nil and data.type ~= luaEnumRechargeRewardType.DayRecharge then
            self.btnEffect_GameObject:SetActive(self.IsSelectNowRecharge)
        end
        -- self.mBgEffect.gameObject:SetActive(self.IsSelectNowRecharge)
    end
    self.mBuyingTable_UITable.enabled = true
end

--region 在线礼包
---刷新在线礼包
function UIRechargeRewardTemplate:RefreshOnlineReward(tableInfo, onlineTime)
    ---是否是登录
    local isLogIn = tableInfo.type == 1 and tableInfo.sequence == 1
    if not isLogIn and onlineTime and tableInfo.onlineTime then
        --倒计时
        local time = tableInfo.onlineTime * 60
        local onlineSecond = onlineTime / 1000
        if time - onlineSecond > 0 then
            self.btnEffect_GameObject:SetActive(false)
            self.price_UITimeCountLabel:StartCountBySecond(nil, 7, time - onlineSecond, "[-][F5C725]", " [-][fff0c2]可领取", nil, function()
                self.isFinish = true
                self.price_UILabel.text = luaEnumColorType.SimpleYellow1 .. "可领取"
                self.btnEffect_GameObject:SetActive(true)
            end)
        else
            self.price_UILabel.text = luaEnumColorType.SimpleYellow1 .. "可领取"
            self.isFinish = true
            self.btnEffect_GameObject:SetActive(true)
        end
        self.bubbleId = 197
    else
        local isFinish = self:GetIsPlayerLevelCanReceivedReward()
        self.isFinish = isFinish
        self.price_UILabel.text = luaEnumColorType.SimpleYellow1 .. "可领取"
        self.btnEffect_GameObject:SetActive(isFinish)
        self.bubbleId = 251
    end
end
--endregion

--region 直购礼包
---刷新终生限购礼包
---@param tableInfo TABLE.CFG_LINGJIANG_REWARD
function UIRechargeRewardTemplate:RefreshLastRechargeReward(tableInfo)
    local recharge = math.ceil(tableInfo.rmb / 100)
    self.price_UILabel.text = luaEnumColorType.SimpleYellow1 .. "￥" .. recharge
    self.btnEffect_GameObject:SetActive(false)
    local rewardList = CS.Cfg_BoxTableManager.Instance:GetSemicolonReward(tableInfo.reward)
    if (rewardList.Count > 0) then
        local firstreward = rewardList[0]
        --第一个道具是展示道具
        self:RefreshBuyingShowReward(firstreward)
        rewardList:RemoveAt(0)
        self:ShowLastRechargeListReward(rewardList)
    end
end

---刷新直购礼包
---@param tableInfo TABLE.CFG_LINGJIANG_REWARD
---@param type number luaEnumRechargeRewardType 礼包类型
function UIRechargeRewardTemplate:RefreshBuyingReward(tableInfo, type)
    self.btnEffect_GameObject:SetActive(false)
    local rewardList = CS.Cfg_BoxTableManager.Instance:GetSemicolonReward(tableInfo.reward)
    ---用index为1表示那些需要前置的特殊钻石礼包
    if (tableInfo.index == 1) then
        if (tableInfo.isTimeLimit == 1) then
            self:ShowBuyingDiamondLimitFinalReward(rewardList)
        else
            self:ShowPurchaseDiamondReward(rewardList)
        end
    else
        if tableInfo.diamond ~= nil and tableInfo.diamond ~= 0 then
            --表示钻石礼包
            self:ShowDiamondReward(rewardList, tableInfo.diamond, type)
        else
            --表示元宝礼包
            self:ShowYuanBaoReward(rewardList, type)
        end
    end
end

---刷新直购礼包2
---@param tableInfo TABLE.CFG_LINGJIANG_REWARD
function UIRechargeRewardTemplate:RefreshBuyingReward2(tableInfo)
    self.btnEffect_GameObject:SetActive(false)
    local rewardList = CS.Cfg_BoxTableManager.Instance:GetSemicolonReward(tableInfo.reward)
    -----用index为1表示那些需要前置的特殊钻石礼包
    if (rewardList.Count > 0) then
        local firstreward = rewardList[0]
        --第一个道具是展示道具
        self:RefreshBuyingShowReward(firstreward)
        rewardList:RemoveAt(0)
        self:ShowCircleDiamondListReward(rewardList)
    end
end

---直购元宝礼包将钻石数目添加到奖励列表中
---@param rewardList System.Collections.Generic.List1bagV2.CoinInfo
---@param type number luaEnumRechargeRewardType 礼包类型
function UIRechargeRewardTemplate:ShowPurchaseIngotReward(rewardList)
    self.mRewardList_UIGridContainer.MaxPerLine = 2;
    self:ShowPurchaseListTypeReward(rewardList)
end

---直购钻石礼包将钻石数目添加到奖励列表中
---@param rewardList System.Collections.Generic.List1bagV2.CoinInfo
---@param type number luaEnumRechargeRewardType 礼包类型
function UIRechargeRewardTemplate:ShowPurchaseDiamondReward(rewardList)
    self.mRewardList_UIGridContainer.MaxPerLine = 2;
    self:ShowPurchaseListTypeReward(rewardList)
end

---刷新奖励显示
---@param rewardList table<number,bagV2.CoinInfo>
function UIRechargeRewardTemplate:ShowPurchaseListTypeReward(rewardList)
    self.mRewardList_UIGridContainer.MaxCount = rewardList.Count
    for i = 0, rewardList.Count - 1 do
        local go = self.mRewardList_UIGridContainer.controlList[i]
        local info = rewardList[i]
        self:RefreshRewardItem(go, info.itemId, info.count)
    end
end

---钻石礼包将钻石数目添加到奖励列表中
---@param rewardList System.Collections.Generic.List1bagV2.CoinInfo
---@param type number luaEnumRechargeRewardType 礼包类型
function UIRechargeRewardTemplate:ShowDiamondReward(rewardList, diamondNum)
    if rewardList == nil or diamondNum == nil then
        return
    end
    self:ShowListTypeReward(rewardList)
end

---@param tableType System.Collections.Generic.List1bagV2.CoinInfo 最终要显示的
---@param rewardList System.Collections.Generic.List1bagV2.CoinInfo
---@param type number luaEnumRechargeRewardType 礼包类型
function UIRechargeRewardTemplate:ShowBuyingDiamondLimitFinalReward(tableList)
    ---@type bagV2.CoinInfo
    local reward = tableList[0]
    --第一个道具是展示道具
    self:RefreshBuyingShowReward(reward)
    tableList:RemoveAt(0)
    self:ShowLastRechargeListReward(tableList)
end

---元宝礼包
---@param rewardList System.Collections.Generic.List1bagV2.CoinInfo
---@param type number luaEnumRechargeRewardType 礼包类型
function UIRechargeRewardTemplate:ShowYuanBaoReward(rewardList, type)
    local tableList = {}
    self:ShowBuyingFinalReward(tableList, rewardList, type)
end

---@param tableType System.Collections.Generic.List1bagV2.CoinInfo 最终要显示的
---@param rewardList System.Collections.Generic.List1bagV2.CoinInfo
---@param type number luaEnumRechargeRewardType 礼包类型
function UIRechargeRewardTemplate:ShowBuyingFinalReward(tableList, rewardList, type)
    for i = 0, rewardList.Count - 1 do
        ---策划需求 100892 直购礼包特殊处理：只有等于4的时候显示上边的
        if ((type == luaEnumRechargeRewardType.Buy and rewardList.Count == 4) or type ~= luaEnumRechargeRewardType.Buy) and i == 0 then
            ---@type bagV2.CoinInfo
            local reward = rewardList[i]
            --第一个道具是展示道具
            if type == luaEnumRechargeRewardType.LimitBuy then
                self:RefreshBuyingShowReward(reward)
            else
                self.mRewardBuyNum_Go:SetActive(true)
                local itemId = reward.itemId
                local count = reward.count
                if itemId then
                    local itemInfo = self:GetItemInfoCache(itemId)
                    if itemInfo then
                        self.mRewardBuyNum_UISprite.spriteName = itemInfo.icon
                    end
                end
                self.mRewardBuyNum_UILabel.text = (count and count > 1) and count or ""
            end
        else
            table.insert(tableList, rewardList[i])
        end
    end
    self:ShowTableTypeReward(tableList)
end

---刷新直购礼包其他显示数据
---@param tableInfo TABLE.CFG_LINGJIANG_REWARD
function UIRechargeRewardTemplate:RefreshBuyingRewardOtherInfo(tableInfo)
    local isLimit = tableInfo.isTimeLimit == 1
    self.mBuyLimit_Go:SetActive(isLimit)
    self.mLimitSign:SetActive(isLimit)

    if isLimit then
        local time = tableInfo.effectiveTime
        if time and time.list.Count >= 2 then
            local days = time.list[1]
            local finishTime = CS.CSRechargeInfoV2.GetFinishTimeStamp(days)
            self.mDes2TimeCount_UILabel:StartCountDown(nil, 10, finishTime * 1000, "[e85038]", "后结束", nil, function()
                networkRequest.ReqRechargeGiftBox()
            end)
        end
    end
end

---刷新循环钻石礼包其他显示数据
---@param tableInfo TABLE.CFG_LINGJIANG_REWARD
function UIRechargeRewardTemplate:RefreshCircleBuyingRewardOtherInfo(tableInfo)
    local isLimit = tableInfo.isTimeLimit == 1
    self.mBuyLimit_Go:SetActive(isLimit)
    self.mLimitSign:SetActive(isLimit)

    if isLimit then
        local time = tableInfo.effectiveTime
        if time and time.list.Count >= 2 then
            local days = time.list[1]
            local finishTime = CS.CSRechargeInfoV2.GetFinishTimeStamp(days)
            self.mDes2TimeCount_UILabel:StartCountDown(nil, 10, finishTime * 1000, "[e85038]", "后结束", nil, function()
                if (self.RootPanel.IsNeedReqGiftWithTimeOut) then
                    networkRequest.ReqRoleCycleGiftBoxInfo()
                    self.RootPanel.IsNeedReqGiftWithTimeOut = false
                end
            end)
        end
    end
end

---刷新直购奖励展示
function UIRechargeRewardTemplate:RefreshBuyingShowReward(info)
    local itemId = info.itemId
    local count = info.count
    if itemId then
        local itemInfo = self:GetItemInfoCache(itemId)
        if itemInfo then
            self.mBuyRewardIcon.spriteName = itemInfo.icon
            self.mBuyingRewardInfo = itemInfo
        end
    end
    if count and count > 1 then
        self.mBuyRewardCount.text = count
    else
        self.mBuyRewardCount.text = ""
    end
end

---点击直购礼包icon
function UIRechargeRewardTemplate:OnClickBuyingReward()
    if self.mBuyingRewardInfo then
        local backgroundPos = nil
        if (self.mBuyingRewardInfo.type == luaEnumItemType.SkillBook and self.mBuyingRewardInfo.subType == 3) then
            backgroundPos = CS.UnityEngine.Vector3(-128, 0, 0)
        end
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mBuyingRewardInfo, showRight = false, backgroundPos = backgroundPos })
        uiStaticParameter.UIItemInfoManager:TryCreateSkillVideoPanel();
    end
end
--endregion

---刷新标题
---@param title string 背景#标题#礼包图片
function UIRechargeRewardTemplate:RefreshTitle(title, type, recharge)
    local data = string.Split(title, '#')

    if #data >= 1 then
        self.mRewardBg_UISprite.spriteName = data[1]
    end
    if #data >= 2 then
        if type == luaEnumRechargeRewardType.Buy or type == luaEnumRechargeRewardType.LastRecharge then
            self.mRechargeTitle_UISprite.spriteName = data[2]
            self.mRechargeTitle_UISprite:MakePixelPerfect()
        else
            self.mMiddleTitle_UISprite.spriteName = data[2]
            self.mMiddleTitle_UISprite:MakePixelPerfect()
        end
        local isBuy = type == luaEnumRechargeRewardType.Buy or type == luaEnumRechargeRewardType.LimitBuy or type == luaEnumRechargeRewardType.LastRecharge or type == luaEnumRechargeRewardType.CircleDiamondGift -- 直购
        self.mTitle_UILabel.text = isBuy and recharge or ""
        self.mMiddleTitle_UISprite.gameObject:SetActive(not isBuy)
        self.mRechargeTitle_UISprite.gameObject:SetActive(isBuy)
        self.mTitle_UILabel.gameObject:SetActive(isBuy)
    end
    if #data >= 3 then
        self.mRewardSp_UISprite.spriteName = data[3]
        if type == luaEnumRechargeRewardType.LimitBuy then
            self.mBuyRewardEffect.effectId = data[3]
        end
        self.mBuyRewardEffect.gameObject:SetActive(type == luaEnumRechargeRewardType.LimitBuy or type == luaEnumRechargeRewardType.Buy)
    end
end

---刷新奖励显示
---@param rewardList TABLE.IntListJingHao
function UIRechargeRewardTemplate:ShowRewardList(rewardList)
    self.mRewardList_UIGridContainer.MaxCount = rewardList.list.Count
    for i = 0, rewardList.list.Count - 1 do
        local go = self.mRewardList_UIGridContainer.controlList[i]
        local info = rewardList.list[i]
        if info.list.Count >= 2 then
            self:RefreshRewardItem(go, info.list[0], info.list[1])
        end
    end
end

---刷新奖励显示
---@param rewardList table<number,bagV2.CoinInfo>
function UIRechargeRewardTemplate:ShowListTypeReward(rewardList)
    self.mRewardList_UIGridContainer.MaxCount = rewardList.Count
    for i = 0, rewardList.Count - 1 do
        local go = self.mRewardList_UIGridContainer.controlList[i]
        local info = rewardList[i]
        self:RefreshRewardItem(go, info.itemId, info.count)
    end
end

---刷新终生限购奖励显示
---@param rewardList table<number,bagV2.CoinInfo>
function UIRechargeRewardTemplate:ShowLastRechargeListReward(rewardList)
    self.mRewardList_UIGridContainer.MaxCount = rewardList.Count
    for i = 0, self.mRewardList_UIGridContainer.MaxCount - 1 do
        local go = self.mRewardList_UIGridContainer.controlList[i]
        local info = rewardList[i]
        self:RefreshRewardItem(go, info.itemId, info.count)
    end
end

---刷新循环钻石奖励显示
---@param rewardList table<number,bagV2.CoinInfo>
function UIRechargeRewardTemplate:RefreshCircleDiamondGiftReward(tableInfo)
    local rewardList = CS.Cfg_BoxTableManager.Instance:GetSemicolonReward(tableInfo.reward)
    if (rewardList.Count > 0) then
        local firstreward = rewardList[0]
        --第一个道具是展示道具
        self:RefreshBuyingShowReward(firstreward)
        rewardList:RemoveAt(0)
        self:ShowCircleDiamondListReward(rewardList)
    end
end

---刷新终生限购奖励显示
---@param rewardList table<number,bagV2.CoinInfo>
function UIRechargeRewardTemplate:ShowCircleDiamondListReward(rewardList)
    if (rewardList.Count > 3) then
        self.mRewardList_UIGridContainer.MaxCount = 3
    else
        self.mRewardList_UIGridContainer.MaxCount = rewardList.Count
    end
    for i = 0, self.mRewardList_UIGridContainer.MaxCount - 1 do
        local go = self.mRewardList_UIGridContainer.controlList[i]
        local info = rewardList[i]
        self:RefreshRewardItem(go, info.itemId, info.count)
    end
end

---显示table类型奖励
function UIRechargeRewardTemplate:ShowTableTypeReward(rewardList)
    self.mRewardList_UIGridContainer.MaxCount = #rewardList - 1
    for i = 0, self.mRewardList_UIGridContainer.MaxCount - 1 do
        local go = self.mRewardList_UIGridContainer.controlList[i]
        local info = rewardList[i + 1]
        self:RefreshRewardItem(go, info.itemId, info.count)
    end
end

---刷新单个奖励格子
---@param go UnityEngine.GameObject 奖励格子
---@param itemId number 奖励id
---@param rewardNum number 奖励数目
function UIRechargeRewardTemplate:RefreshRewardItem(go, itemId, rewardNum)
    local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
    local count = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
    local itemInfo = self.RootPanel:GetItemInfoCache(itemId)
    if itemInfo then
        icon.spriteName = itemInfo.icon
        CS.UIEventListener.Get(go).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
        end
    end
    if rewardNum and rewardNum > 1 then
        count.text = rewardNum
    else
        count.text = ""
    end
end

---点击领取
function UIRechargeRewardTemplate:OnGetItemClicked(go)
    if self.isFinish then
        if self.data and self.data.tableInfo then
            if self.data.type == luaEnumRechargeRewardType.Online then
                networkRequest.ReqReceiveOnlineGiftBox(self.data.id)
            elseif self.data.type == luaEnumRechargeRewardType.DayRecharge then
                --还需要继续充钱才能领奖
                if (self.data.remainRecharge > 0) then
                    Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.DayRecharge)
                else
                    networkRequest.ReqReceiveDailyRechargeGiftBox(self.data.id)
                end
            elseif self.data.type == luaEnumRechargeRewardType.Recharge then
                networkRequest.ReqReceiveTotalRechargeGiftBox(self.data.id)
            elseif self.data.type == luaEnumRechargeRewardType.Buy or self.data.type == luaEnumRechargeRewardType.LimitBuy or self.data.type == luaEnumRechargeRewardType.LastRecharge
                    or self.data.type == luaEnumRechargeRewardType.IngotRecharge or self.data.type == luaEnumRechargeRewardType.CircleDiamondGift then
                Utility.SetGiftRechargePoint()
                if (CS.CSVersionMgr.Instance.ServerVersion.OpenRecharge) then
                    if (self.storeInfo ~= nil) then
                        if (self.storeInfo.storeTable.moneyType == 1000001) then
                            if (CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(LuaEnumCoinType.Diamond) >= self.storeInfo.price) then
                                networkRequest.ReqBuyItem(self.storeInfo.storeId, 1, self.storeInfo.storeTable.itemId, 1)
                                local uiRechargePanel = uimanager:GetPanel("UIRechargePanel")
                                if uiRechargePanel ~= nil then
                                    uiRechargePanel.mIsRequestedBuyItem = true
                                end
                            else
                                Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.DiamondRechargeGiftPanel)
                            end
                        elseif (self.storeInfo.storeTable.moneyType == 1000002) then
                            local costCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.storeInfo.storeTable.moneyType);
                            if (costCount >= self.storeInfo.price) then
                                networkRequest.ReqBuyItem(self.storeInfo.storeId, 1, 0, 0, 0);
                            else
                                uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.IngotGiftToReward
                                Utility.ShowItemGetWay(self.storeInfo.storeTable.moneyType, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(80, 0), nil, LuaEnumRechargePointEntranceType.IngotGiftToReward)
                            end
                        end
                    else
                        if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor then
                            networkRequest.ReqGM("@43 " .. tostring(self.data.tableInfo.id))
                        else
                            local data = Utility:GetPayData(self.data.tableInfo)
                            if (data ~= nil) then
                                CS.SDKManager.GameInterface:Pay(data:GetPayParams())
                            end
                        end
                    end
                end
            elseif self.data.type == luaEnumRechargeRewardType.Share then
                if self.mShareSuccess and self.data.receive ~= 1 then
                    networkRequest.ReqReceiveShareGiftBox(self.data.id)
                else
                    self.mClickShare = not self.mClickShare
                    self.mShareBtn_Go:SetActive(self.mClickShare)
                end
            end
        end
    else
        if self.bubbleId then
            local str
            if self.bubbleId == 251 then
                str = self:GetLevelBubbleStr()
            end
            Utility.ShowPopoTips(go, str, self.bubbleId)
        end
    end
end

---@return boolean 获取玩家等级是否可以领取奖励
function UIRechargeRewardTemplate:GetIsPlayerLevelCanReceivedReward()
    local limitLevel = CS.Cfg_GlobalTableManager.Instance:GetRewardLevel()
    if self.RootPanel and self.RootPanel:GetPlayerInfo() and limitLevel then
        return self.RootPanel:GetPlayerInfo().Level >= limitLevel
    end
    return false
end

---等级不足气泡提示
function UIRechargeRewardTemplate:GetLevelBubbleStr()
    if self.mLevelBubbleStr == nil then
        local limitLevel = CS.Cfg_GlobalTableManager.Instance:GetRewardLevel()
        local res, bubbleInfo = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(251)
        if res then
            self.mLevelBubbleStr = string.format(bubbleInfo.content, limitLevel)
        end
    end
    return self.mLevelBubbleStr
end

---获取item取数据
function UIRechargeRewardTemplate:GetItemInfoCache(itemId)
    return self.RootPanel:GetItemInfoCache(itemId)
end

--region 分享

function UIRechargeRewardTemplate:OnShareBtnClick()
    self:ShareSuccess()
end

---分享成功回调
function UIRechargeRewardTemplate:ShareSuccess()
    self.mClickShare = false
    self.mShareBtn_Go:SetActive(false)
    local show = self.data.receive == 1 and "继续分享" or "可领取"
    self.price_UILabel.text = luaEnumColorType.SimpleYellow1 .. show
    self.mShareSuccess = true
end

--endregion

return UIRechargeRewardTemplate