---狂欢商店中的物品
---@class UICarnivalShop_ItemTemplate:TemplateBase
local UICarnivalShop_ItemTemplate = {}

---归属的界面
---@return UICarnivalShopPanel
function UICarnivalShop_ItemTemplate:GetOwnerPanel()
    return self.mOwnerPanel
end

--region 数据
---@type activitiesV2.OneActivitiesInfo 服务器数据
UICarnivalShop_ItemTemplate.activityData = nil
---@type number 剩余可兑换次数
UICarnivalShop_ItemTemplate.lastExchangeCount = 0
---@type TABLE.cfg_special_activity 活动表数据
UICarnivalShop_ItemTemplate.specialActivityTbl = nil
---@type number 奖励物品ID
UICarnivalShop_ItemTemplate.rewardItemID = 0
---@type number 奖励物品数量
UICarnivalShop_ItemTemplate.rewardItemCount = 0
---@type TABLE.cfg_items 奖励物品表数据
UICarnivalShop_ItemTemplate.rewardItemTbl = nil
---@type number 花费的物品ID
UICarnivalShop_ItemTemplate.costItemID = 0
---@type number 花费的物品数量
UICarnivalShop_ItemTemplate.costItemCount = 0
---@type TABLE.cfg_items 花费的物品表数据
UICarnivalShop_ItemTemplate.costItemTbl = 0
---@type number 数据是否有效
UICarnivalShop_ItemTemplate.dataAvailable = false
--endregion

--region 组件
---奖励物品icon
---@return UISprite
function UICarnivalShop_ItemTemplate:GetIconSprite()
    if self.mIconSprite == nil then
        self.mIconSprite = self:Get("RewardItem/icon", "UISprite")
    end
    return self.mIconSprite
end

---奖励物品名
---@return UILabel
function UICarnivalShop_ItemTemplate:GetNameLabel()
    if self.mNameLabel == nil then
        self.mNameLabel = self:Get("RewardItem/name", "UILabel")
    end
    return self.mNameLabel
end

---奖励物品数量
---@return UILabel
function UICarnivalShop_ItemTemplate:GetCountLabel()
    if self.mCountLabel == nil then
        self.mCountLabel = self:Get("RewardItem/count", "UILabel")
    end
    return self.mCountLabel
end

---消耗的货币icon
---@return UISprite
function UICarnivalShop_ItemTemplate:GetCostIconSprite()
    if self.mCostIconSprite == nil then
        self.mCostIconSprite = self:Get("RewardItem/cost", "UISprite")
    end
    return self.mCostIconSprite
end

---消耗的货币数量文本
---@return UILabel
function UICarnivalShop_ItemTemplate:GetCostAmountLabel()
    if self.mCostAmountLabel == nil then
        self.mCostAmountLabel = self:Get("RewardItem/cost/count", "UILabel")
    end
    return self.mCostAmountLabel
end

---兑换按钮
---@return UnityEngine.GameObject
function UICarnivalShop_ItemTemplate:GetExchangeButtonGO()
    if self.mExchangeButtonGO == nil then
        self.mExchangeButtonGO = self:Get("btn_get", "GameObject")
    end
    return self.mExchangeButtonGO
end

---兑换按钮背景
---@return UISprite
function UICarnivalShop_ItemTemplate:GetExchangeButtonBGSprite()
    if self.mExchangeButtonBGSprite == nil then
        self.mExchangeButtonBGSprite = self:Get("btn_get", "UISprite")
    end
    return self.mExchangeButtonBGSprite
end

---兑换按钮文本
---@return UILabel
function UICarnivalShop_ItemTemplate:GetExchangeButtonLabel()
    if self.mExchangeButtonLabel == nil then
        self.mExchangeButtonLabel = self:Get("btn_get/Label", "UILabel")
    end
    return self.mExchangeButtonLabel
end

---兑换按钮碰撞体
---@return UnityEngine.BoxCollider
function UICarnivalShop_ItemTemplate:GetExchangeButtonCollider()
    if self.mExchangeButtonCollider == nil then
        self.mExchangeButtonCollider = self:Get("btn_get", "BoxCollider")
    end
    return self.mExchangeButtonCollider
end

---获取剩余次数文本
---@return UILabel
function UICarnivalShop_ItemTemplate:GetLastTimeLabel()
    if self.mLastTimeLabel == nil then
        self.mLastTimeLabel = self:Get("time", "UILabel")
    end
    return self.mLastTimeLabel
end

---遮罩
---@return UnityEngine.GameObject
function UICarnivalShop_ItemTemplate:GetMaskGO()
    if self.mMaskGO == nil then
        self.mMaskGO = self:Get("mask", "GameObject")
    end
    return self.mMaskGO
end
--endregion

--region 初始化
---@param ownerPanel UICarnivalShopPanel
function UICarnivalShop_ItemTemplate:Init(ownerPanel)
    self.mOwnerPanel = ownerPanel
    self:BindUIEvents()
end
--endregion

--region 绑定事件
function UICarnivalShop_ItemTemplate:BindUIEvents()
    CS.UIEventListener.Get(self:GetExchangeButtonGO()).onClick = function(go)
        self:OnExchangeButtonClicked(go)
    end
    CS.UIEventListener.Get(self:GetIconSprite().gameObject).onClick = function(go)
        self:OnIconClicked(self.rewardItemID, go)
    end
    CS.UIEventListener.Get(self:GetCostIconSprite().gameObject).onClick = function(go)
        self:OnIconClicked(self.costItemID, go)
    end
end
--endregion

--region 刷新/重置
---使用活动数据刷新
---@param activityData activitiesV2.OneActivitiesInfo
function UICarnivalShop_ItemTemplate:Refresh(activityData)
    self:RefreshData(activityData)
    self:RefreshUI()
end

---刷新数据
---@private
---@param activityData activitiesV2.OneActivitiesInfo
function UICarnivalShop_ItemTemplate:RefreshData(activityData)
    self:ResetData()
    self.activityData = activityData
    if activityData == nil then
        return
    end
    self.dataAvailable = true
    self.specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(activityData.configId)
    if self.specialActivityTbl == nil then
        self.dataAvailable = false
        return
    end
    if self.specialActivityTbl:GetAwardType() ~= nil
            and self.specialActivityTbl:GetAwardType().list ~= nil
            and #self.specialActivityTbl:GetAwardType().list >= 2 then
        self.lastExchangeCount = self.specialActivityTbl:GetAwardType().list[2] - self.activityData.dataParam
    end
    if self.specialActivityTbl:GetAward() ~= nil
            and self.specialActivityTbl:GetAward().list ~= nil
            and #self.specialActivityTbl:GetAward().list >= 2 then
        self.rewardItemID = self.specialActivityTbl:GetAward().list[1]
        self.rewardItemCount = self.specialActivityTbl:GetAward().list[2]
        self.rewardItemTbl = self:AdjustRewardItem(self.rewardItemID)
        if self.rewardItemTbl then
            self.rewardItemID = self.rewardItemTbl:GetId()
        end
    end
    if self.specialActivityTbl:GetGoal() ~= nil
            and self.specialActivityTbl:GetGoal().list ~= nil
            and #self.specialActivityTbl:GetGoal().list >= 2 then
        self.costItemID = self.specialActivityTbl:GetGoal().list[1]
        self.costItemCount = self.specialActivityTbl:GetGoal().list[2]
        self.costItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.costItemID)
    end
end

---调整奖励物品
---@private
---@param rewardItemID number
---@return TABLE.cfg_items
function UICarnivalShop_ItemTemplate:AdjustRewardItem(rewardItemID)
    local rewardItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(rewardItemID)
    if rewardItemID == 5000710 or rewardItemID == 5000709 then
        ---xp技能宝箱根据职业显示开启后的物品
        ---@type TABLE.CFG_BOX
        local boxTblExist, boxTbl = CS.Cfg_BoxTableManager.Instance:TryGetValue(rewardItemID)
        if boxTbl then
            local mainPlayerCareer = tostring(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
            local str = boxTbl.Items
            local str1s = string.Split(str, '#')
            if #str1s > 0 then
                for i = 1, #str1s do
                    local str2s = string.Split(str1s[i], '-')
                    if #str2s >= 4 then
                        local itemID = tonumber(str2s[1])
                        local career = str2s[4]
                        if career == mainPlayerCareer then
                            local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemID)
                            if itemTbl then
                                return itemTbl
                            end
                        end
                    end
                end
            end
        end
    end
    return rewardItemTbl
end

---重置数据
---@public
function UICarnivalShop_ItemTemplate:ResetData()
    self.dataAvailable = false
    self.activityData = nil
    self.lastExchangeCount = 0
    self.specialActivityTbl = nil
    self.rewardItemID = 0
    self.rewardItemCount = 0
    self.rewardItemTbl = nil
    self.costItemID = 0
    self.costItemCount = 0
    self.costItemTbl = nil
end

---刷新UI
---@public
function UICarnivalShop_ItemTemplate:RefreshUI()
    if self.dataAvailable == false then
        return
    end
    if self.rewardItemTbl then
        self:GetIconSprite().spriteName = self.rewardItemTbl:GetIcon()
        self:GetNameLabel().text = self.rewardItemTbl:GetName()
        if self.rewardItemCount <= 1 then
            self:GetCountLabel().text = ""
        else
            self:GetCountLabel().text = tostring(self.rewardItemCount)
        end
    else
        self:GetIconSprite().spriteName = ""
        self:GetNameLabel().text = ""
        self:GetCountLabel().text = ""
    end
    local isCostEnoughInBag = false
    if self.costItemTbl then
        self:GetCostIconSprite().spriteName = self.costItemTbl:GetIcon()
        local currentCoinAmount
        if self.costItemID == 8310001 or self.costItemID == 8310002 then
            currentCoinAmount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(8310001) +
                    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(8310001) +
                    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(8310002) +
                    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(8310002)
        else
            currentCoinAmount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(self.costItemID) +
                    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(self.costItemID)
        end
        if currentCoinAmount < self.costItemCount then
            self:GetCostAmountLabel().text = "[e85038]" .. tostring(currentCoinAmount) .. "[-]/" .. tostring(self.costItemCount)
        else
            isCostEnoughInBag = true
            self:GetCostAmountLabel().text = "[00ff00]" .. tostring(currentCoinAmount) .. "[-]/" .. tostring(self.costItemCount)
        end
    else
        self:GetCostIconSprite().spriteName = ""
        self:GetCostAmountLabel().text = ""
    end
    local isNeedGray = self.lastExchangeCount <= 0
    if isNeedGray then
        self:GetIconSprite().color = CS.UnityEngine.Color(0, 0, 0, 128 / 255)
    else
        self:GetIconSprite().color = CS.UnityEngine.Color(1, 1, 1, 1)
    end
    if self.lastExchangeCount > 0 then
        ---剩余兑换次数大于0时
        if isCostEnoughInBag then
            ---如果货币或者物品数量充足,则显示正常按钮
            self:GetLastTimeLabel().text = "[878787]可兑换[00ff00]" .. tostring(self.lastExchangeCount) .. "[-]次[-]"
            self:GetExchangeButtonBGSprite().spriteName = "anniu11"
            self:GetExchangeButtonLabel().text = "兑换"
            self:GetExchangeButtonBGSprite().enabled = true
            self:GetExchangeButtonCollider().enabled = true
            self:GetMaskGO():SetActive(false)
        else
            ---如果货币或物品数量不足,则按钮置灰显示
            self:GetLastTimeLabel().text = "[878787]可兑换[00ff00]" .. tostring(self.lastExchangeCount) .. "[-]次[-]"
            self:GetExchangeButtonBGSprite().spriteName = "anniu26"
            self:GetExchangeButtonLabel().text = "[878787]兑换"
            self:GetExchangeButtonBGSprite().enabled = true
            self:GetExchangeButtonCollider().enabled = false
            self:GetMaskGO():SetActive(false)
        end
    else
        ---剩余兑换次数为0时,去掉按钮外框,置灰显示“已兑换”
        self:GetLastTimeLabel().text = "[878787]可兑换[e85038]" .. tostring(self.lastExchangeCount) .. "[-]次[-]"
        self:GetExchangeButtonBGSprite().enabled = false
        self:GetExchangeButtonLabel().text = "[878787]已兑换[-]"
        self:GetExchangeButtonCollider().enabled = false
        self:GetMaskGO():SetActive(true)
    end
end
--endregion

--region 事件
---兑换按钮点击事件
---@private
---@param go UnityEngine.GameObject
function UICarnivalShop_ItemTemplate:OnExchangeButtonClicked(go)
    if self.dataAvailable == false then
        ---数据无效
        return
    end
    local isEmptyGridExistInBag = CS.CSScene.MainPlayerInfo.BagInfo:CheckIsAbleToAddItemOfNumbers(self.rewardItemTbl:CsTABLE(), self.rewardItemCount)
    if isEmptyGridExistInBag == false then
        Utility.ShowPopoTips(go, "背包已满", 290, "UICarnivalShopPanel")
        return
    end
    networkRequest.ReqGetOneActivitiesAward(self.specialActivityTbl:GetId(), 1)
end

---物品点击事件
---@private
---@param itemID number
---@param go UnityEngine.GameObject
function UICarnivalShop_ItemTemplate:OnIconClicked(itemID, go)
    if itemID == 0 then
        return
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemID)
    uiStaticParameter.UIItemInfoManager:CreatePanel({
        itemID = itemID,
        itemInfo = itemTbl:CsTABLE(),
        showRight = true })
end
--endregion

return UICarnivalShop_ItemTemplate