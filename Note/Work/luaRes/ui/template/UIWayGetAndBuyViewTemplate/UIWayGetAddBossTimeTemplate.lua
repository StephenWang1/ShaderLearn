---@class UIWayGetAddBossTimeTemplate:TemplateBase
local UIWayGetAddBossTimeTemplate = {}

--region 组件
---@return UILabel 标题文本
function UIWayGetAddBossTimeTemplate:GetTitleLb_UILabel()
    if self.mTitleLb == nil then
        self.mTitleLb = self:Get("Label", "UILabel")
    end
    return self.mTitleLb
end

---@return UISprite 按钮图片
function UIWayGetAddBossTimeTemplate:GetBtn_UISprite()
    if self.mBtnSP == nil then
        self.mBtnSP = self:Get("btn_buy", "UISprite")
    end
    return self.mBtnSP
end

---@return UILabel 按钮文本
function UIWayGetAddBossTimeTemplate:GetBtn_UILabel()
    if self.mBtnLb == nil then
        self.mBtnLb = self:Get("btn_buy/Label", "UILabel")
    end
    return self.mBtnLb
end

---@return UILabel 花费文本
function UIWayGetAddBossTimeTemplate:GetCostNum_UILabel()
    if self.mCostNumLb == nil then
        self.mCostNumLb = self:Get("cost/num", "UILabel")
    end
    return self.mCostNumLb
end

---@return UISprite 道具图片
function UIWayGetAddBossTimeTemplate:GetCostIcon_UISprite()
    if self.mCostIconSP == nil then
        self.mCostIconSP = self:Get("cost/icon", "UISprite")
    end
    return self.mCostIconSP
end
--endregion

---@param panel UIFurnaceWayAndBuyPanel
function UIWayGetAddBossTimeTemplate:Init(panel)
    self.mOwnerPanel = panel
    self.mOwnerPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RefreshCostNum()
    end)
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.FinalBossTimesChange, function()
        self:RefreshTitleShow()
    end)
    CS.UIEventListener.Get(self:GetBtn_UISprite().gameObject).onClick = function(go)
        self:OnBtnClicked(go)
    end
end

---@param wayGetId number way-get表id
---@param bossType LuaEnumFinalBossType boss类型
function UIWayGetAddBossTimeTemplate:RefreshItem(wayGetId, bossType)
    --print(wayGetId, bossType)
    self.mWayGetId = wayGetId
    self.mBossType = bossType
    self:RefreshTitleShow()
    self:RefreshBtns()
    self:RefreshCostSP()
    self:RefreshCostNum()
end

---刷新左侧标题文本
function UIWayGetAddBossTimeTemplate:RefreshTitleShow()
    local tblData = clientTableManager.cfg_way_getManager:TryGetValue(self.mWayGetId)
    if tblData then
        local name = tblData:GetName()
        local time = gameMgr:GetPlayerDataMgr():GetBossDataManager():GetSingleTypeData(self.mBossType)
        if self.mWayGetId == 289 then
            if time then
                local canBuyTime = LuaGlobalTableDeal:GetBossBuyNormalTime()
                local playerVIPLevel = gameMgr:GetPlayerDataMgr():GetLuaMemberInfo():GetPlayerMemberLevel()
                local vipTbl = clientTableManager.cfg_memberManager:TryGetValue(playerVIPLevel)
                if vipTbl then
                    local maxTime = vipTbl:GetExCount()
                    canBuyTime = canBuyTime + maxTime
                end

                canBuyTime = canBuyTime- time.buyTimes
                name = string.format(name, canBuyTime)
            end
            local cost = LuaGlobalTableDeal:GetBossBuyCost()
            self.mCostId = cost.itemId
        else
            self.mCostId = tonumber(tblData:GetOpenPanel())
        end
        self:GetTitleLb_UILabel().text = name
    end
end

---刷新按钮
function UIWayGetAddBossTimeTemplate:RefreshBtns()
    local isDiamond = self.mWayGetId == 289
    local color = isDiamond and luaEnumColorType.Red3 or luaEnumColorType.Blue
    local lbShow = isDiamond and "购买" or "使用"
    self:GetBtn_UILabel().text = color .. lbShow
    local spShow = isDiamond and "anniu14" or "anniu16"
    self:GetBtn_UISprite().spriteName = spShow
end

---刷新花费
function UIWayGetAddBossTimeTemplate:RefreshCostSP()
    if self.mCostId == nil then
        return
    end
    local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mCostId)
    if res then
        self:GetCostIcon_UISprite().spriteName = itemInfo.icon
        self.mCoinName = CS.Cfg_ItemsTableManager.Instance:GetItemName(self.mCostId)
        CS.UIEventListener.Get(self:GetCostIcon_UISprite().gameObject).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({
                itemInfo = itemInfo,
                showRight = false })
        end
    end
end

---刷新数目
function UIWayGetAddBossTimeTemplate:RefreshCostNum()
    local isDiamond = self.mWayGetId == 289
    local needCost
    local playerHas
    if isDiamond then
        local cost = LuaGlobalTableDeal:GetBossBuyCost()
        playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(cost.itemId)
        needCost = cost.costNum
        self:GetCostNum_UILabel().text = needCost
        self.mCoinEnough = playerHas >= needCost
    else
        playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(self.mCostId)
        self:GetCostNum_UILabel().text = playerHas .. "/1"
        self.mCoinEnough = playerHas >= 1
    end
end

---点击按钮
function UIWayGetAddBossTimeTemplate:OnBtnClicked(go)
    local isDiamond = self.mWayGetId == 289
    if not self.mCoinEnough then
        if isDiamond then
            Utility.JumpRechargePanel()
        else
            CS.Utility.ShowTips(self.mCoinName .. "不足", 1.5)
        end
        return
    end
    local addType = isDiamond and 2 or 1
    networkRequest.ReqAddBossKillTimes(self.mBossType, addType)
end

return UIWayGetAddBossTimeTemplate