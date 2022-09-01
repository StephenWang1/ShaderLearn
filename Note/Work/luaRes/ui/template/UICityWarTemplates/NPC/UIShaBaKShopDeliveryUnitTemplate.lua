---@class UIShaBaKShopDeliveryUnitTemplate:TemplateBase
local UIShaBaKShopDeliveryUnitTemplate = {};

---@type TABLE.CFG_DELIVER 传送表数据
UIShaBaKShopDeliveryUnitTemplate.mTableData = nil;

UIShaBaKShopDeliveryUnitTemplate.mCostItemId = 0;

UIShaBaKShopDeliveryUnitTemplate.mCostItemNum = 0;

UIShaBaKShopDeliveryUnitTemplate.isSelectToggle = false

--region Components

function UIShaBaKShopDeliveryUnitTemplate:GetBtnGo_GameObject()
    return self.go;
end

function UIShaBaKShopDeliveryUnitTemplate:GetFirstBtnName_Text()
    if (self.mFirstBtnName_Text == nil) then
        self.mFirstBtnName_Text = self:Get("background/Name", "UILabel")
    end
    return self.mFirstBtnName_Text;
end

function UIShaBaKShopDeliveryUnitTemplate:GetSecondBtnName_Text()
    if (self.mSecondBtnName_Text == nil) then
        self.mSecondBtnName_Text = self:Get("check/Name", "UILabel");
    end
    return self.mSecondBtnName_Text;
end

function UIShaBaKShopDeliveryUnitTemplate:GetCostValue_Text()
    if (self.mCostValue_Text == nil) then
        self.mCostValue_Text = self:Get("background/cost", "UILabel");
    end
    return self.mCostValue_Text;
end

function UIShaBaKShopDeliveryUnitTemplate:GetCostItemIcon_UISprite()
    if (self.mCostItemIcon_UISprite == nil) then
        self.mCostItemIcon_UISprite = self:Get("background/cost/Sprite", "UISprite");
    end
    return self.mCostItemIcon_UISprite;
end

--endregion

--region CallFunction

function UIShaBaKShopDeliveryUnitTemplate:OnClickGoTo()
    if (self.mTableData == nil) then
        return
    end

    if not uiStaticParameter.mSaBakIsShowToggle then
        self:TryTrans(self.go)
        return
    end
    local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(79)
    if not isFind then
        return
    end
    --local isfind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mCostItemId)
    --if not isfind then
    --    return
    --end

    local costName = CS.Cfg_ItemsTableManager.Instance:GetItemName(self.mCostItemId)
    uimanager:CreatePanel("UIPromptPanel", nil, {
        Content = string.format(string.gsub(info.des, '\\n', '\n'), self.mTableData.showName, tostring(self.mCostItemNum), costName),
        CenterDescription = info.leftButton,
        IsClose = false,
        ID = 79,
        IsToggleVisable = true,
        --IsShowGoldLabel = true,
        --GoldIcon = itemTable.icon,
        --GoldCount = self.mCostItemNum,
        CallBack = function(panel)
            if panel.go ~= nil and panel.GetCenterButton_GameObject() ~= nil and not CS.StaticUtility.IsNull(panel.GetCenterButton_GameObject()) then
                self:TryTrans(panel.GetCenterButton_GameObject())
            end
        end,
        OptionBtnCallBack = function(value)
            UIShaBaKShopDeliveryUnitTemplate.isSelectToggle = value
        end
    })


end

--endregion

--region Method

--region Public

function UIShaBaKShopDeliveryUnitTemplate:UpdateUnit(deliverId)
    local isFind, deliverTable = CS.Cfg_DeliverTableManager.Instance:TryGetValue(deliverId);
    if (isFind) then
        self.mTableData = deliverTable
        local isOccupyShaBaK = false;
        if (CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID ~= 0 and CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionInfo.unionInfo ~= nil) then
            isOccupyShaBaK = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionInfo.unionInfo.seizeCityId == 1002;
        end
        local coinData
        if isOccupyShaBaK and self.mTableData.special == 1 and self.mTableData.speciaItem ~= nil then
            coinData = self.mTableData.speciaItem
        else
            if self.mTableData.item then
                coinData = self.mTableData.item
            end
        end
        local info = string.Split(coinData, '#')
        if info and #info >= 2 then
            self.mCostItemId = tonumber(info[1])
            self.mCostItemNum = tonumber(info[2])
        end
        self:UpdateUI();
    end
end

function UIShaBaKShopDeliveryUnitTemplate:UpdateUI()
    if (self.mTableData ~= nil) then
        self:GetFirstBtnName_Text().text = self.mTableData.showName;
        self:GetSecondBtnName_Text().text = self.mTableData.showName;
        --local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mCostItemId);
        --if(isFind) then
        --    self:GetCostValue_Text().gameObject:SetActive(self.mCostItemNum > 0);
        --    self:GetCostItemIcon_UISprite().spriteName = itemTable.icon;
        --    self:GetCostValue_Text().text = self.mCostItemNum;
        --else
        --    self:GetCostValue_Text().gameObject:SetActive(false);
        --end
    end
end

--endregion

--region Private

function UIShaBaKShopDeliveryUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnGo_GameObject()).onClick = function()
        self:OnClickGoTo();
    end
end

function UIShaBaKShopDeliveryUnitTemplate:RemoveEvents()

end

function UIShaBaKShopDeliveryUnitTemplate:TryTrans(go)
    if go == nil then
        return
    end
    local mCoinNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.mCostItemId);
    --if isFind then
    if (mCoinNum >= self.mCostItemNum) then
        if self:IsPlayerLevelEnough(go) then
            networkRequest.ReqDeliverByConfig(self.mTableData.id);
            if UIShaBaKShopDeliveryUnitTemplate.isSelectToggle then
                uiStaticParameter.mSaBakIsShowToggle = false
            end
            uimanager:ClosePanel("UICityWarShopTeleportPanel")
            uimanager:ClosePanel("UIPromptPanel")
        end
    else
        local configId = 0
        local showStr = nil
        if (self.mCostItemId == LuaEnumCoinType.JinBi) then
            configId = 68
        elseif (self.mCostItemId == LuaEnumCoinType.Diamond) then
            configId = 70
        elseif (self.mCostItemId == LuaEnumCoinType.YuanBao) then
            configId = 69
        else
            configId = 23
            showStr = CS.Cfg_ItemsTableManager.Instance:GetItemName(self.mCostItemId) .. "不足"
        end
        Utility.ShowPopoTips(go, showStr, configId, "UIPromptPanel")
    end
    --end
end

---@return boolean 玩家等级是否足够
function UIShaBaKShopDeliveryUnitTemplate:IsPlayerLevelEnough(go)
    local condition = self.mTableData.condition
    if condition == nil then
        return true
    end
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        local level = mainPlayerInfo.Level
        local res, limitLevelInfo = CS.Cfg_ConditionManager.Instance.dic:TryGetValue(condition)
        if res then
            ---@type TABLE.IntListJingHao
            local paramList = limitLevelInfo.conditionParam
            if paramList and paramList.list.Count > 0 then
                local limitLevel = paramList.list[0]
                if level >= limitLevel then
                    return true
                else
                    local res, popInfo = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(311)
                    if res then
                        local str = string.format(popInfo.content, limitLevel)
                        Utility.ShowPopoTips(go, str, 311)
                    end
                    return false
                end
            end
        else
            return true
        end
    end
end

--endregion

--endregion

function UIShaBaKShopDeliveryUnitTemplate:Init(panel)
    ---@type UICityWarShopTeleportPanel
    self.RootPanel = panel
    self:InitEvents();
end

function UIShaBaKShopDeliveryUnitTemplate:OnDestroy()
    self:RemoveEvents();
end

return UIShaBaKShopDeliveryUnitTemplate;