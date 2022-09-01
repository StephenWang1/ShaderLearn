---@class UIRechargeUnitTemplate:UI模板
local UIRechargeUnitTemplate = {};

UIRechargeUnitTemplate.mTableData = nil;

UIRechargeUnitTemplate.mRewardUnitDic = nil;

UIRechargeUnitTemplate.mShowRewardItemIds = nil;

--region Component
function UIRechargeUnitTemplate:GetPrice_UILabel()
    if (self.mPrice_Text == nil) then
        self.mPrice_Text = self:Get("Price", "UILabel")
    end
    return self.mPrice_Text;
end

function UIRechargeUnitTemplate:GetIngot_UILabel()
    if (self.mIngot_Text == nil) then
        self.mIngot_Text = self:Get("Ingot", "UILabel")
    end
    return self.mIngot_Text;
end

function UIRechargeUnitTemplate:GetSprite_UISprite()
    if (self.mbgSprite == nil) then
        self.mbgSprite = self:Get("background/bg/Sprite", "UISprite")
    end
    return self.mbgSprite;
end

---@type UIEffectLoad
function UIRechargeUnitTemplate:GetSprite_UIEffectLoad()
    if (self.mbgUIEffectLoad == nil) then
        self.mbgUIEffectLoad = self:Get("background/bg/Sprite", "CSUIEffectLoad")
    end
    return self.mbgUIEffectLoad;
end

---@type GameObject
function UIRechargeUnitTemplate:GetDayRecharge_GameObject()
    if (self.mDayRechargeGo == nil) then
        self.mDayRechargeGo = self:Get("DayRecharge", "GameObject")
    end
    return self.mDayRechargeGo;
end

---@type Top_UISprite
function UIRechargeUnitTemplate:GetAttachedGift_Sprite()
    if (self.mGetAttachedGift_Sprite == nil) then
        self.mGetAttachedGift_Sprite = self:Get("AttachedGift", "Top_UISprite")
    end
    return self.mGetAttachedGift_Sprite;
end

function UIRechargeUnitTemplate:GetDayRechargeBg_GameObject()
    if (self.mDayRechargeBg_GameObject == nil) then
        self.mDayRechargeBg_GameObject = self:Get("DayRecharge/normalReward/bg", "GameObject");
    end
    return self.mDayRechargeBg_GameObject;
end

function UIRechargeUnitTemplate:GetDayRechargePrice_UILabel()
    if (self.mDayRechargePrice == nil) then
        self.mDayRechargePrice = self:Get("DayRecharge/normalReward/price", "UILabel")
    end
    return self.mDayRechargePrice
end

function UIRechargeUnitTemplate:GetDayRechargeIcon_UISprite()
    if (self.mDayRechargeIcon == nil) then
        self.mDayRechargeIcon = self:Get("DayRecharge/normalReward/icon", "UISprite")
    end
    return self.mDayRechargeIcon
end

function UIRechargeUnitTemplate:GetRewardGridContainer()
    if (self.mRewardGridContainer == nil) then
        self.mRewardGridContainer = self:Get("DayRecharge/rewards/rewards", "UIGridContainer");
    end
    return self.mRewardGridContainer;
end

function UIRechargeUnitTemplate:GetRewards_UIGridContainer()
    if (self.mRewardsGrid == nil) then
        self.mRewardsGrid = self:Get("DayRecharge/rewards/rewards", "Top_UIGridContainer")
    end
    return self.mRewardsGrid
end

--endregion

--endregion

--region 初始化
function UIRechargeUnitTemplate:Init(panel)
    self.panel = panel
    self:BindUIEvents()
    self.iconName = 0
    self:InitData()
end

function UIRechargeUnitTemplate:OnClickRewardItem()
    local customBagItemInfos = {};
    if (self.mShowRewardItemIds ~= nil) then
        local firstBagItemInfo = nil;
        for k, v in pairs(self.mShowRewardItemIds) do
            local customBagItemInfo = CS.Cfg_ItemsFakeTipsTableManager.Instance:GetFakeBagItemInfoByItemId(v);
            if (customBagItemInfo ~= nil) then
                if (firstBagItemInfo == nil) then
                    firstBagItemInfo = customBagItemInfo;
                else
                    table.insert(customBagItemInfos, customBagItemInfo);
                end
            end
        end
        if (firstBagItemInfo ~= nil) then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = firstBagItemInfo, showRight = false, showAssistPanel = true, assistBagItemInfoTable = customBagItemInfos });
        end
    end
end

function UIRechargeUnitTemplate:BindUIEvents()
    if CS.StaticUtility.IsNull(self:GetPrice_UILabel()) == false then
        CS.UIEventListener.Get(self:GetPrice_UILabel().gameObject).LuaEventTable = self
        CS.UIEventListener.Get(self:GetPrice_UILabel().gameObject).OnClickLuaDelegate = self.ItemOnClick
    end

    CS.UIEventListener.Get(self:GetDayRechargeBg_GameObject()).onClick = function()
        self:OnClickRewardItem();
    end
end

function UIRechargeUnitTemplate:InitData()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22088)
    if (isFind) then
        self.iconName = info.value
    end
end
--endregion

--region 刷新界面 -- 传入充值表格cfg_recharge
---@param tableData TABLE.cfg_recharge
function UIRechargeUnitTemplate:RefreshUIItem(tableData)
    self.mTableData = tableData;
    self:IsShowAttackedGift(tableData)
    if (Utility.IsContainsValue(self.panel.FirstRechargeGiftBoxList, tableData:GetId())) then
        if (Utility.IsContainsValue(LuaGlobalTableDeal:GetSpecialFirstRebateTable(), tostring(tableData:GetId()))) then
            self:FirstSiteDayRechargeRefresh()
        else
            self:GetDayRecharge_GameObject():SetActive(true)
        end
        local isFind, info = CS.Cfg_RechargeTableManager.Instance.BindDic:TryGetValue(tableData:GetId())
        if (isFind) then
            self:GetDayRechargePrice_UILabel().text = info
        end
    else
        self:GetDayRecharge_GameObject():SetActive(false)
    end

    if (self.mTableData ~= nil) then
        self:GetIngot_UILabel().text = self.mTableData:GetDiamond()
        self:GetPrice_UILabel().text = "[fff0c2]￥" .. math.ceil(self.mTableData:GetRmb() * 0.01) .. "[-]"
        self:GetSprite_UISprite().spriteName = self.mTableData:GetTitle()
        self:GetDayRechargeIcon_UISprite().spriteName = self.iconName
        self:GetSprite_UIEffectLoad().effectId = self.mTableData:GetEffectId()
        self:GetSprite_UIEffectLoad():LoadEffect()
    end

    self:UpdateRewards();
end

function UIRechargeUnitTemplate:FirstSiteDayRechargeRefresh()
    local isDayRecharge = self.panel:GetFirstRechargeRewardLogo_GameObject().activeSelf == false and self.panel:GetContinueRechargeLogo_GameObject().activeSelf == false
    self:GetDayRecharge_GameObject():SetActive(isDayRecharge)
end

---@param tableData TABLE.cfg_recharge
function UIRechargeUnitTemplate:IsShowAttackedGift(tableData)

    self:GetAttachedGift_Sprite().gameObject:SetActive(false)

    ---不要首充送礼了
    --[[    local buytimes = CS.CSScene.MainPlayerInfo.RechargeInfo.CurrentRechargeGiftBoxInfo.buyTimes
        CS.UIEventListener.Get(self:GetAttachedGift_Sprite().gameObject).onClick = function()
            ---@type TABLE.cfg_items
            local item = nil
            if (tableData:GetId() == 4) then
                item = clientTableManager.cfg_itemsManager:TryGetValue(14010003)
            elseif (tableData:GetId() == 6) then
                item = clientTableManager.cfg_itemsManager:TryGetValue(14010001)
            end

            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = item:CsTABLE(), showRight = false })
        end
        if ((tableData:GetId() == 4 or tableData:GetId() == 6) and gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsRecivedGive(tableData:GetId()) == false) then
            if (tableData:GetId() == 4) then
                if (buytimes[tableData:GetId() - 1] ~= nil and buytimes[tableData:GetId() - 1].totalBuyTimes == 0) then
                    self:GetAttachedGift_Sprite().spriteName = "14010003";
                    self:GetAttachedGift_Sprite().gameObject:SetActive(true)
                else
                    self:GetAttachedGift_Sprite().gameObject:SetActive(false)
                end
            elseif (tableData:GetId() == 6) then
                if (buytimes[tableData:GetId() - 1] ~= nil and buytimes[tableData:GetId() - 1].totalBuyTimes == 0) then
                    self:GetAttachedGift_Sprite().spriteName = "14010001";
                    self:GetAttachedGift_Sprite().gameObject:SetActive(true)
                else
                    self:GetAttachedGift_Sprite().gameObject:SetActive(false)
                end
            end
            self:GetAttachedGift_Sprite():MakePixelPerfect()
        else
            self:GetAttachedGift_Sprite().gameObject:SetActive(false)
        end]]
end
--endregion

function UIRechargeUnitTemplate:UpdateRewards()
    local hasReward = false;
    local gridContainer = self:GetRewardGridContainer();
    if (self.mRewardUnitDic == nil) then
        self.mRewardUnitDic = {};
    end

    self.mShowRewardItemIds = {};

    if (self.mTableData ~= nil) then
        local rewardBoxId = gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetRechargeDiamondRewardNum(self.mTableData:GetId(), CS.CSScene.MainPlayerInfo.ActualOpenDays);
        if (rewardBoxId ~= 0) then
            self:GetRewardGridContainer().gameObject:SetActive(true)
            local rewardList = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(rewardBoxId);
            gridContainer.MaxCount = rewardList.Count > 3 and 3 or rewardList.Count;
            if (gridContainer.MaxCount > 0) then
                hasReward = true;
                for i = 0, gridContainer.MaxCount - 1 do
                    local gobj = gridContainer.controlList[i];
                    if (self.mRewardUnitDic[gobj] == nil) then
                        self.mRewardUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                    end
                    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(rewardList[i].itemId);
                    table.insert(self.mShowRewardItemIds, rewardList[i].itemId);
                    if (isFind) then
                        self.mRewardUnitDic[gobj]:RefreshUIWithItemInfo(itemTable, rewardList[i].count);
                    end

                    CS.UIEventListener.Get(gobj).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable, showRight = false });
                    end
                end
            end
        end
    end

    if (not hasReward) then
        gridContainer.MaxCount = 0;
    end
end

--region 点击按钮进行充值
function UIRechargeUnitTemplate:ItemOnClick()
    local eachamount = CS.Cfg_GlobalTableManager.Instance.EachPayamount
    local totalamount = CS.Cfg_GlobalTableManager.Instance.TotalMonthPayAmount
    local content = ""
    if (eachamount == -1 or totalamount == -1) then
        Utility.SetPayRechargePoint()
        if (CS.CSVersionMgr.Instance.ServerVersion.OpenRecharge) then
            if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor then
                networkRequest.ReqRechargeEntrance(uiStaticParameter.RechargePoint)
                networkRequest.ReqGM("@43 " .. tostring(self.mTableData:GetId()))
            else
                local data = Utility:GetPayData(self.mTableData)
                if (data ~= nil) then
                    CS.SDKManager.GameInterface:Pay(data:GetPayParams())
                end
            end
        end
        networkRequest.ReqGetRechargeInfo()
        networkRequest.ReqRechargeGiftBox()
        --self:GetDayRecharge_GameObject():SetActive(false)
    else
        if (eachamount < self.mTableData:GetDiamond()) then
            content = CS.Cfg_GlobalTableManager.Instance.RechargeInfo
            uimanager:CreatePanel("UIPromptPanel", nil, { Title = "提示", Content = content, CallBack = function()
                uimanager:ClosePanel("UIPromptPanel")
            end, IsShowCloseBtn = true, CenterDescription = "好的" })
        elseif (totalamount < self.panel.TotalRechargeAmount) then
            content = CS.Cfg_GlobalTableManager.Instance.TotalMonthRechargeInfo
            uimanager:CreatePanel("UIPromptPanel", nil, { Title = "提示", Content = content, CallBack = function()
                uimanager:ClosePanel("UIPromptPanel")
            end, IsShowCloseBtn = true, CenterDescription = "好的" })
        end
    end
end
--endregion

return UIRechargeUnitTemplate;