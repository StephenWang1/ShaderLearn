---@class UISummonTipsPanel:UIBase  召唤令弹窗界面 仅召唤令显示
local UISummonTipsPanel = {}

--region 变量
UISummonTipsPanel.PanelLayerType = CS.UILayerType.TopPlane
UISummonTipsPanel.mEnterCallBack = nil
UISummonTipsPanel.mCancelCallBack = nil
UISummonTipsPanel.mOptionBtnCallBack = nil
UISummonTipsPanel.mTimeEndCallBack = nil
UISummonTipsPanel.IEnumRefreshTime = nil
---确认按钮点击后是否关闭面板
UISummonTipsPanel.mIsClose = nil;
UISummonTipsPanel.isCanDeliver = true
UISummonTipsPanel.PromptWordID = nil
---传送失败弹窗回调
UISummonTipsPanel.mSpecialDeliverFailPromptCallBack = nil
--endregion

--region 组件
---标题组件
function UISummonTipsPanel.GetTitleLabel_UILabel()
    if UISummonTipsPanel.mTitleLabel_UILabel == nil then
        UISummonTipsPanel.mTitleLabel_UILabel = UISummonTipsPanel:GetCurComp("WidgetRoot/view/Title", "UILabel")
    end
    return UISummonTipsPanel.mTitleLabel_UILabel
end

---内容组件
function UISummonTipsPanel.GetContentLabel_UILabel()
    if UISummonTipsPanel.mContentLabel_UILabel == nil then
        UISummonTipsPanel.mContentLabel_UILabel = UISummonTipsPanel:GetCurComp("WidgetRoot/view/Content", "UILabel")
    end
    return UISummonTipsPanel.mContentLabel_UILabel
end

---选项框
function UISummonTipsPanel.GetValueToggle_GameObject()
    if UISummonTipsPanel.mValueToggle_GameObject == nil then
        UISummonTipsPanel.mValueToggle_GameObject = UISummonTipsPanel:GetCurComp("WidgetRoot/view/toggle_value", "GameObject")
    end
    return UISummonTipsPanel.mValueToggle_GameObject
end

---左按钮
function UISummonTipsPanel.GetLeftButton_GameObject()
    if UISummonTipsPanel.mLeftButton_GameObject == nil then
        UISummonTipsPanel.mLeftButton_GameObject = UISummonTipsPanel:GetCurComp("WidgetRoot/events/LeftBtn", "GameObject")
    end
    return UISummonTipsPanel.mLeftButton_GameObject
end

---左按钮文字
function UISummonTipsPanel.GetLeftButtonLabel_UILabel()
    if UISummonTipsPanel.mLeftButtonLabel_UILabel == nil then
        UISummonTipsPanel.mLeftButtonLabel_UILabel = UISummonTipsPanel:GetCurComp("WidgetRoot/events/LeftBtn/Label", "UILabel")
    end
    return UISummonTipsPanel.mLeftButtonLabel_UILabel
end

---倒计时
function UISummonTipsPanel.GetLastTimeLabel_UICountdownLabel()
    if UISummonTipsPanel.mLastTime_UICountdownLabel == nil then
        UISummonTipsPanel.mLastTime_UICountdownLabel = UISummonTipsPanel:GetCurComp("WidgetRoot/Time", "UICountdownLabel")
    end
    return UISummonTipsPanel.mLastTime_UICountdownLabel
end

function UISummonTipsPanel:GetLastTimeLabel_UILabel()
    if (UISummonTipsPanel.mLastTimeLabel_UILabel == nil) then
        UISummonTipsPanel.mLastTimeLabel_UILabel = UISummonTipsPanel:GetCurComp("WidgetRoot/Time", "UILabel")
    end
    return UISummonTipsPanel.mLastTimeLabel_UILabel;
end

---右按钮
function UISummonTipsPanel.GetRightButton_GameObject()
    if UISummonTipsPanel.mRightButton_GameObject == nil then
        UISummonTipsPanel.mRightButton_GameObject = UISummonTipsPanel:GetCurComp("WidgetRoot/events/RightBtn", "GameObject")
    end
    return UISummonTipsPanel.mRightButton_GameObject
end

---右按钮文字
function UISummonTipsPanel.GetRightButtonLabel_UILabel()
    if UISummonTipsPanel.mRightButtonLabel_UILabel == nil then
        UISummonTipsPanel.mRightButtonLabel_UILabel = UISummonTipsPanel:GetCurComp("WidgetRoot/events/RightBtn/Label", "UILabel")
    end
    return UISummonTipsPanel.mRightButtonLabel_UILabel
end

---关闭按钮
function UISummonTipsPanel.GetCloseButton_GameObject()
    if UISummonTipsPanel.mCloseButton_GameObject == nil then
        UISummonTipsPanel.mCloseButton_GameObject = UISummonTipsPanel:GetCurComp("WidgetRoot/events/close", "GameObject")
    end
    return UISummonTipsPanel.mCloseButton_GameObject
end

---bg按钮
function UISummonTipsPanel.GetHideButton_GameObject()
    if UISummonTipsPanel.mHideButton_GameObject == nil then
        UISummonTipsPanel.mHideButton_GameObject = UISummonTipsPanel:GetCurComp("WidgetRoot/view/background", "GameObject")
    end
    return UISummonTipsPanel.mHideButton_GameObject
end

function UISummonTipsPanel.GetCenterButton_GameObject()
    if UISummonTipsPanel.mCenterButton == nil then
        UISummonTipsPanel.mCenterButton = UISummonTipsPanel:GetCurComp("WidgetRoot/events/CenterBtn", "GameObject")
    end
    return UISummonTipsPanel.mCenterButton
end

function UISummonTipsPanel.GetCenterButtonLabel_UILabel()
    if UISummonTipsPanel.mCenterButtonLabel == nil then
        UISummonTipsPanel.mCenterButtonLabel = UISummonTipsPanel:GetCurComp("WidgetRoot/events/CenterBtn/Label", "UILabel")
    end
    return UISummonTipsPanel.mCenterButtonLabel
end

function UISummonTipsPanel.GetTimeLabel_UILabel()
    if UISummonTipsPanel.mTimeLabel == nil then
        UISummonTipsPanel.mTimeLabel = UISummonTipsPanel:GetCurComp("WidgetRoot/view/time", "UILabel")
    end
    return UISummonTipsPanel.mTimeLabel
end

function UISummonTipsPanel.GetItemgold_UILabel()
    if UISummonTipsPanel.mItemgoldLabel == nil then
        UISummonTipsPanel.mItemgoldLabel = UISummonTipsPanel:GetCurComp("WidgetRoot/itemgold", "UILabel")
    end
    return UISummonTipsPanel.mItemgoldLabel
end

function UISummonTipsPanel.GetItemgold_Sprite()
    if UISummonTipsPanel.mItemgoldSprite == nil then
        UISummonTipsPanel.mItemgoldSprite = UISummonTipsPanel:GetCurComp("WidgetRoot/itemgold/Sprite", "UISprite")
    end
    return UISummonTipsPanel.mItemgoldSprite
end

function UISummonTipsPanel.GetItemgoldAddBtn_GameObject()
    if UISummonTipsPanel.mItemgoldAddBtn == nil then
        UISummonTipsPanel.mItemgoldAddBtn = UISummonTipsPanel:GetCurComp("WidgetRoot/itemgold/btn_add", "GameObject")
    end
    return UISummonTipsPanel.mItemgoldAddBtn
end

function UISummonTipsPanel:GetLeftItemGold_UILabel()
    if self.mLeftItemGoldLabel == nil then
        self.mLeftItemGoldLabel = UISummonTipsPanel:GetCurComp("WidgetRoot/leftItemgold", "UILabel")
    end
    return self.mLeftItemGoldLabel
end

function UISummonTipsPanel:GetLeftItemGold_Sprite()
    if self.mLeftItemGoldSprite == nil then
        self.mLeftItemGoldSprite = UISummonTipsPanel:GetCurComp("WidgetRoot/leftItemgold/Sprite", "UISprite")
    end
    return self.mLeftItemGoldSprite
end

function UISummonTipsPanel:GetLeftItemGoldAddBtn_GameObject()
    if self.mLeftItemGoldAddBtn == nil then
        self.mLeftItemGoldAddBtn = UISummonTipsPanel:GetCurComp("WidgetRoot/leftItemgold/btn_add", "GameObject")
    end
    return self.mLeftItemGoldAddBtn
end

---@return UILabel
function UISummonTipsPanel:GetRightItemGold_UILabel()
    if self.mRightItemGoldLabel == nil then
        self.mRightItemGoldLabel = UISummonTipsPanel:GetCurComp("WidgetRoot/rightItemgold", "UILabel")
    end
    return self.mRightItemGoldLabel
end

---@return UISprite
function UISummonTipsPanel:GetRightItemGold_Sprite()
    if self.mRightItemGoldSprite == nil then
        self.mRightItemGoldSprite = UISummonTipsPanel:GetCurComp("WidgetRoot/rightItemgold/Sprite", "UISprite")
    end
    return self.mRightItemGoldSprite
end

function UISummonTipsPanel:GetRightItemGoldAddBtn_GameObject()
    if self.mRightItemGoldAddBtn == nil then
        self.mRightItemGoldAddBtn = UISummonTipsPanel:GetCurComp("WidgetRoot/rightItemgold/btn_add", "GameObject")
    end
    return self.mRightItemGoldAddBtn
end

---@return UnityEngine.GameObject 中间按钮背景图
function UISummonTipsPanel:GetConfirmBtn_UISprite()
    if self.mConfirmBtn_UISprite == nil then
        self.mConfirmBtn_UISprite = self:GetCurComp("WidgetRoot/events/CenterBtn/Background", "UISprite")
    end
    return self.mConfirmBtn_UISprite
end

---@return UnityEngine.GameObject 右边按钮背景图
function UISummonTipsPanel:GetRightBtn_UISprite()
    if self.mRightBtn_UISprite == nil then
        self.mRightBtn_UISprite = self:GetCurComp("WidgetRoot/events/RightBtn/Background", "UISprite")
    end
    return self.mRightBtn_UISprite
end

---@return UnityEngine.GameObject 左边按钮背景图
function UISummonTipsPanel:GetLeftBtn_UISprite()
    if self.mLeftBtn_UISprite == nil then
        self.mLeftBtn_UISprite = self:GetCurComp("WidgetRoot/events/LeftBtn/Background", "UISprite")
    end
    return self.mLeftBtn_UISprite
end

--endregion

--region 初始化
function UISummonTipsPanel:Init()
    UISummonTipsPanel.BindUIEvents()
    UISummonTipsPanel.BindNetEvents()
end

---显示弹窗界面
---在调用uimanager:CreatePanel("UISummonTipsPanel", table)时传入data,不要单独调用

---@class SummonTisData
---@field Title string 标题
---@field Content string 内容
---@field CallBack function 确认回调
---@field CancelCallBack function 取消回调
---@field CloseCallBack function 关闭回调
---@field TimeEndCallBack function 时间结束回调
---@field LeftDescription string 左按钮描述文字
---@field RightDescription string 右按钮描述文字
---@field CenterDescription string 中间按钮描述文字
---@field IsToggleVisable boolean 选项框是否可见
---@field OptionBtnCallBack function 选项框按钮回调
---@field Time              number   时间 单位毫秒
---@field IsShowCloseBtn    boolean  是否显示右上角关闭按钮
---@field InitCallBack      function 首次进入回调
---@field mapId number
---@field PromptWordID number 表格id
---@field mNeedShowCost boolean 是否需要显示花费（通过副本表读取）
---}

---@param data SummonTisData
function UISummonTipsPanel:Show(data)
    if data then
        if (data.IsClose == nil) then
            data.IsClose = true;
        end

        UISummonTipsPanel.PromptWordID = data.PromptWordID
        --标题
        UISummonTipsPanel.GetTitleLabel_UILabel().text = ternary(data.Title == nil, "", data.Title)
        --内容
        UISummonTipsPanel.GetContentLabel_UILabel().text = ternary(data.Content == nil, "", data.Content)
        --确认回调
        UISummonTipsPanel.mEnterCallBack = data.CallBack
        --取消回调
        UISummonTipsPanel.mCancelCallBack = data.CancelCallBack
        --选项回调
        UISummonTipsPanel.mOptionBtnCallBack = data.OptionBtnCallBack
        --倒计时结束回调
        UISummonTipsPanel.mTimeEndCallBack = data.TimeEndCallBack

        UISummonTipsPanel.mCloseCallBack = data.CloseCallBack
        --确认按钮点击后是否关闭面板
        UISummonTipsPanel.mIsClose = data.IsClose;
        local timeStamp = data.LastTime - CS.CSServerTime.Instance.TotalMillisecond;
        if (timeStamp > 0) then
            local minute = math.floor(timeStamp / 1000 / 60);
            local second = math.floor(timeStamp / 1000 % 60);
            UISummonTipsPanel:GetLastTimeLabel_UILabel().text = "00:" .. (minute > 9 and tostring(minute) or "0" .. minute) .. ":" .. (second > 9 and tostring(second) or "0" .. second)
            --召唤倒计时
            UISummonTipsPanel:GetLastTimeLabel_UICountdownLabel():StartCountDown(100, 6, data.LastTime, "" .. "", "内有效", nil, function()
                UISummonTipsPanel:GetLastTimeLabel_UILabel().text = "";
                UISummonTipsPanel.OnLeftButtonClicked()
            end);
        else
            UISummonTipsPanel.OnLeftButtonClicked()
            return
        end


        --关闭按钮
        local isShowCloseBtn = ternary(data.IsShowCloseBtn == nil, false, data.IsShowCloseBtn)
        UISummonTipsPanel.GetCloseButton_GameObject():SetActive(isShowCloseBtn)
        --倒计时
        -- UISummonTipsPanel.GetTimeLabel_UILabel().gameObject:SetActive(false)
        -- if data.Time ~= nil then
        --     if UISummonTipsPanel.IEnumRefreshTime ~= nil then
        --         StopCoroutine(UISummonTipsPanel.IEnumRefreshTime)
        --         UISummonTipsPanel.IEnumRefreshTime = nil
        --     end
        --     UISummonTipsPanel.IEnumRefreshTime = StartCoroutine(UISummonTipsPanel.IEnumTimeCount, data.Time)
        -- end
        UISummonTipsPanel.mapId = data.mapId

        self.mNeedShowCost = data.mNeedShowCost

        UISummonTipsPanel.RefreshNeedItem()

        UISummonTipsPanel:RefreshBtnData()
        self:RefreshCostInfoByDuplicateInfo()
    end
end

function UISummonTipsPanel.BindUIEvents()
    CS.UIEventListener.Get(UISummonTipsPanel.GetCloseButton_GameObject()).onClick = UISummonTipsPanel.OnCloseButtonClicked
    CS.UIEventListener.Get(UISummonTipsPanel.GetLeftButton_GameObject()).onClick = UISummonTipsPanel.OnLeftButtonClicked
    CS.UIEventListener.Get(UISummonTipsPanel.GetRightButton_GameObject()).onClick = UISummonTipsPanel.OnRightButtonClicked
    CS.UIEventListener.Get(UISummonTipsPanel.GetValueToggle_GameObject()).onClick = UISummonTipsPanel.OnOptionBtnClicked
    CS.UIEventListener.Get(UISummonTipsPanel.GetCenterButton_GameObject()).onClick = UISummonTipsPanel.OnRightButtonClicked
    --CS.UIEventListener.Get(UISummonTipsPanel.GetHideButton_GameObject()).onClick = function()
    --    uimanager:ClosePanel("UISummonTipsPanel")
    --end
end

function UISummonTipsPanel.BindNetEvents()
    UISummonTipsPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UISummonTipsPanel.OnResBagChangeMessage)
    UISummonTipsPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MapProcessAfterLoaded, UISummonTipsPanel.OnMapChanged)
end
--endregion

--region UI事件
---@return TABLE.CFG_PROMPTWORD 获取表格数据
function UISummonTipsPanel:GetTableData()
    if self.mTableInfo == nil and self.PromptWordID then
        ___, self.mTableInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(self.PromptWordID)
    end
    return self.mTableInfo
end

---关闭按钮点击事件
function UISummonTipsPanel.OnCloseButtonClicked()
    if UISummonTipsPanel.mCloseCallBack then
        UISummonTipsPanel.mCloseCallBack()
    end
    uimanager:ClosePanel("UISummonTipsPanel")
end

---左按钮点击事件
function UISummonTipsPanel.OnLeftButtonClicked()
    if UISummonTipsPanel.mCancelCallBack then
        UISummonTipsPanel.mCancelCallBack()
    end
    uimanager:ClosePanel("UISummonTipsPanel")
end

---右按钮点击事件
function UISummonTipsPanel.OnRightButtonClicked(go)
    if UISummonTipsPanel.mapId == 1007 then
        ---塔罗神庙
        ---是否加入了商会,没加入商会的话要花钱
        local isJoinedCommerce = CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.MonthCardInfo:IsJoinedCommerce() == true
        if isJoinedCommerce == false then
            local itemID = CS.Cfg_GlobalTableManager.Instance.TempleNeedItemId
            local count = CS.Cfg_GlobalTableManager.Instance.TempleNeedItemCount
            local currentItemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(itemID)
            ---钱不够时弹窗并返回
            if currentItemCount < count then
                Utility.ShowPopoTips(go, "元宝不足", 205, "UISummonTipsPanel")
                return
            end
        end
    end
    if UISummonTipsPanel.isCanDeliver then
        if UISummonTipsPanel:GetBtnBubbleId() == -1 then
            if UISummonTipsPanel.mEnterCallBack then
                UISummonTipsPanel.mEnterCallBack(UISummonTipsPanel)
            end
        else
            Utility.ShowPopoTips(go, nil, UISummonTipsPanel:GetBtnBubbleId())
            return
        end
    else
        if UISummonTipsPanel.mSpecialDeliverFailPromptCallBack then
            UISummonTipsPanel.mSpecialDeliverFailPromptCallBack(go)
        else
            if UISummonTipsPanel.itemid ~= nil then
                local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(284)
                if isfind then
                    local name = CS.Cfg_ItemsTableManager.Instance:GetItemName(UISummonTipsPanel.itemid)
                    local str = string.format(data.content, name)
                    Utility.ShowPopoTips(go, str, 284, "UISummonTipsPanel")
                end
            end
        end
        return
    end
    if (UISummonTipsPanel.mIsClose) then
        uimanager:ClosePanel("UISummonTipsPanel")
    end
end

function UISummonTipsPanel.OnItemgoldAddBtnClicked(go)
    if UISummonTipsPanel.itemid ~= nil then
        Utility.ShowItemGetWay(UISummonTipsPanel.itemid, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(120, 0))
    end
end

---选项框按钮事件
function UISummonTipsPanel.OnOptionBtnClicked()
    if UISummonTipsPanel.mOptionBtnCallBack then
        UISummonTipsPanel.mOptionBtnCallBack()
    end
end
--endregion

--region netEvent

function UISummonTipsPanel.OnResBagChangeMessage()
    UISummonTipsPanel.RefreshNeedItem()
    UISummonTipsPanel:RefreshCostInfoByDuplicateInfo()
end

function UISummonTipsPanel.OnMapChanged()
    UISummonTipsPanel.RefreshNeedItem()
    UISummonTipsPanel:RefreshCostInfoByDuplicateInfo()
end
--endregion

--region UI

function UISummonTipsPanel:SetButton(isShowTwoButton)
    --左按钮
    self.GetLeftButton_GameObject():SetActive(isShowTwoButton)
    --右按钮
    self.GetRightButton_GameObject():SetActive(isShowTwoButton)
    --中间按钮
    self.GetCenterButton_GameObject():SetActive(not isShowTwoButton)
end

--刷新消耗物品
function UISummonTipsPanel.RefreshNeedItem()
    UISummonTipsPanel.mSpecialDeliverFailPromptCallBack = nil
    local label = UISummonTipsPanel:GetRightItemGold_UILabel()
    local sprite = UISummonTipsPanel:GetRightItemGold_Sprite()
    local addBtnGO = UISummonTipsPanel:GetRightItemGoldAddBtn_GameObject()
    --print("RefreshNeedItem 0")
    if label == nil then
        return
    end
    if UISummonTipsPanel.mapId == nil or UISummonTipsPanel.mapId == 0 then
        --print("RefreshNeedItem 1")
        label.gameObject:SetActive(false)
        return
    end
    ---@type TABLE.CFG_MAP
    local temp, mapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(UISummonTipsPanel.mapId)
    UISummonTipsPanel.mapTbl = mapTbl

    if UISummonTipsPanel.mapTbl and UISummonTipsPanel.mapTbl.announceDeliver == 1024 then
        ---王者禁地副本地图
        --重置UI
        UISummonTipsPanel.GetItemgold_UILabel().gameObject:SetActive(false)
        UISummonTipsPanel.GetItemgold_Sprite().gameObject:SetActive(false)
        UISummonTipsPanel.GetItemgoldAddBtn_GameObject().gameObject:SetActive(false)
        UISummonTipsPanel:GetLeftItemGold_Sprite().gameObject:SetActive(false)
        UISummonTipsPanel:GetLeftItemGold_UILabel().gameObject:SetActive(false)
        UISummonTipsPanel:GetLeftItemGoldAddBtn_GameObject():SetActive(false)
        local mainPlayerMapID = CS.CSScene.getMapID()
        ---@type TABLE.CFG_MAP
        local targetMapTblExist, targetMapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(UISummonTipsPanel.mapId)
        ---@type TABLE.CFG_CONDITIONS
        local conditionTblExist, conditionTbl
        if targetMapTbl.costCondition ~= nil and targetMapTbl.costCondition.list.Count > 0 then
            conditionTblExist, conditionTbl = CS.Cfg_ConditionManager.Instance:TryGetValue(targetMapTbl.costCondition.list[0])
        end
        ---@type TABLE.CFG_ITEMS
        local needItemTableExist, needItemTable, needItemCount
        if conditionTbl and conditionTbl.conditionParam ~= nil and conditionTbl.conditionParam.list.Count > 1 then
            needItemCount = conditionTbl.conditionParam.list[0]
            needItemTableExist, needItemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(conditionTbl.conditionParam.list[1])
        end
        local currentAmountInMainPlayer = 0
        if needItemTable ~= nil then
            if needItemTable.type == luaEnumItemType.Coin then
                currentAmountInMainPlayer = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(needItemTable.id)
            else
                currentAmountInMainPlayer = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(needItemTable.id)
            end
        end
        if mainPlayerMapID == UISummonTipsPanel.mapId then
            --如果同地图,则认为可以传送
            UISummonTipsPanel.mNeedShowCost = false
            UISummonTipsPanel.isCanDeliver = true
        else
            UISummonTipsPanel.mNeedShowCost = true
        end
    elseif (UISummonTipsPanel.mapId >= 22001 and UISummonTipsPanel.mapId <= 22019) then
        ---BOSS之家
        UISummonTipsPanel.GetItemgold_UILabel().gameObject:SetActive(false)
        UISummonTipsPanel.GetItemgold_Sprite().gameObject:SetActive(false)
        UISummonTipsPanel.GetItemgoldAddBtn_GameObject().gameObject:SetActive(false)
        UISummonTipsPanel:GetLeftItemGold_Sprite().gameObject:SetActive(false)
        UISummonTipsPanel:GetLeftItemGold_UILabel().gameObject:SetActive(false)
        UISummonTipsPanel:GetLeftItemGoldAddBtn_GameObject():SetActive(false)
        ---@type TABLE.CFG_DUPLICATE
        local duplicateTable
        ___, duplicateTable = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(UISummonTipsPanel.mapId)
        if (duplicateTable ~= nil and duplicateTable.condition and CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(duplicateTable.condition)) then
            UISummonTipsPanel.isCanDeliver = true
        else
            UISummonTipsPanel.isCanDeliver = false
            UISummonTipsPanel.mSpecialDeliverFailPromptCallBack = function(go)
                uimanager:CreatePanel("UIVipInfoPanel")
            end
        end
    elseif UISummonTipsPanel.mapId == 1007 then
        ---塔罗神庙
        UISummonTipsPanel.GetItemgold_UILabel().gameObject:SetActive(false)
        UISummonTipsPanel.GetItemgold_Sprite().gameObject:SetActive(false)
        UISummonTipsPanel.GetItemgoldAddBtn_GameObject().gameObject:SetActive(false)
        UISummonTipsPanel:GetRightItemGoldAddBtn_GameObject():SetActive(false)

        ---是否加入了商会
        local isJoinedCommerce = CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.MonthCardInfo:IsJoinedCommerce() == true
        if isJoinedCommerce == false then
            UISummonTipsPanel:GetRightItemGold_UILabel().gameObject:SetActive(true)
            UISummonTipsPanel:GetRightItemGold_Sprite().gameObject:SetActive(true)
            UISummonTipsPanel:GetRightItemGold_UILabel().text = CS.Cfg_GlobalTableManager.Instance.TempleNeedItemCount
            local itemTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(CS.Cfg_GlobalTableManager.Instance.TempleNeedItemId)
            UISummonTipsPanel:GetRightItemGold_Sprite().spriteName = itemTbl.icon
        else
            UISummonTipsPanel:GetRightItemGold_UILabel().gameObject:SetActive(false)
        end
    else
        ---其他情况
        local isShow, info, isCanDeliver = CS.Cfg_MapTableManager.Instance:GetMapConsumptionInfo(UISummonTipsPanel.mapId)
        UISummonTipsPanel.isCanDeliver = isCanDeliver
        local isMeet = false
        local isNeedShow = isShow and info ~= nil and info.Count > 0 and info[0].Length > 1
        label.gameObject:SetActive(isNeedShow)
        if isNeedShow then
            isMeet = info[0][1] <= info[0][2]
            label.text = CS.Utility_Lua.SetProgressLabelColor(info[0][2], info[0][1])
            UISummonTipsPanel.itemid = info[0][0]
            local isFind, ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(UISummonTipsPanel.itemid)
            if isFind then
                sprite.spriteName = ItemInfo.icon
            end
            --加号显示
            if addBtnGO then
                addBtnGO:SetActive(not isMeet)
            end
        end
        CS.UIEventListener.Get(addBtnGO).onClick = UISummonTipsPanel.OnItemgoldAddBtnClicked
        UISummonTipsPanel.GetItemgold_UILabel().gameObject:SetActive(false)
        UISummonTipsPanel.GetItemgold_Sprite().gameObject:SetActive(false)
        UISummonTipsPanel.GetItemgoldAddBtn_GameObject().gameObject:SetActive(false)
        UISummonTipsPanel:GetLeftItemGold_Sprite().gameObject:SetActive(false)
        UISummonTipsPanel:GetLeftItemGold_UILabel().gameObject:SetActive(false)
        UISummonTipsPanel:GetLeftItemGoldAddBtn_GameObject():SetActive(false)
    end
end

---根据副本刷新花费
function UISummonTipsPanel:RefreshCostInfoByDuplicateInfo()
    if self.mNeedShowCost == nil or self.mNeedShowCost == false or self.mapId == nil then
        return
    end
    ---@type TABLE.CFG_DUPLICATE
    local res, duplicateTable = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(self.mapId)
    if res == false or duplicateTable.requireItems == nil then
        return
    end
    local cost = duplicateTable.requireItems
    local hasCost = cost and cost.list and cost.list.Count > 0
    if not hasCost then
        return
    end
    local costInfo = cost.list[0]
    if costInfo.list == nil and costInfo.list.Count < 2 then
        return
    end
    ---刷新花费显示
    local label = self:GetRightItemGold_UILabel()
    local sprite = self:GetRightItemGold_Sprite()
    local addBtnGO = self:GetRightItemGoldAddBtn_GameObject()
    label.gameObject:SetActive(true)
    sprite.gameObject:SetActive(true)
    addBtnGO:SetActive(true)
    local itemId = costInfo.list[0]
    local num = costInfo.list[1]

    ---刷新进入气泡
    local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(itemId)
    local costCanEnter = playerHas >= num
    local bubbleId = costCanEnter and -1 or 452
    self:SetBtnBubbleId(bubbleId)
    ---刷新花费图片
    local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if luaItemInfo then
        sprite.spriteName = luaItemInfo:GetIcon()
    end
    ---刷新数目
    local costColor = costCanEnter and luaEnumColorType.Green or luaEnumColorType.Red
    label.text = Utility.CombineStringQuickly(costColor, playerHas, "[-]/", num)
    ---刷新Add
    CS.UIEventListener.Get(addBtnGO).onClick = function()
        Utility.ShowItemGetWay(itemId, addBtnGO, LuaEnumWayGetPanelArrowDirType.Down, CS.UnityEngine.Vector2.zero)
    end
end

---设置气泡Id
---@param bubbleId number 气泡id/为-1表示可以进入
function UISummonTipsPanel:SetBtnBubbleId(bubbleId)
    self.isCanDeliver = true
    self.mBubbleId = bubbleId
end

---@return number 获取当前气泡id
function UISummonTipsPanel:GetBtnBubbleId()
    if self.mBubbleId == nil then
        self.mBubbleId = -1
    end
    return self.mBubbleId
end

---刷新按钮
function UISummonTipsPanel:RefreshBtnData()
    local desInfo = self:GetTableData()
    if desInfo then
        local leftBtn = desInfo.leftButtonSprite
        local rightBtn = desInfo.rightButtonSprite
        if leftBtn then
            if not CS.StaticUtility.IsNull(self:GetConfirmBtn_UISprite()) then
                self:GetConfirmBtn_UISprite().spriteName = leftBtn
            end
            if not CS.StaticUtility.IsNull(self:GetLeftBtn_UISprite()) then
                self:GetLeftBtn_UISprite().spriteName = leftBtn
            end
        end
        if not CS.StaticUtility.IsNull(self:GetRightBtn_UISprite()) and rightBtn then
            self:GetRightBtn_UISprite().spriteName = rightBtn
        end

        --左按钮文字,默认为 "取 消"
        self.GetLeftButtonLabel_UILabel().text = desInfo.leftButton == nil and "取 消" or desInfo.leftButton
        --右按钮文字,默认为 "确 定"
        self.GetRightButtonLabel_UILabel().text = desInfo.rightButton == nil and "确 定" or desInfo.rightButton
        --中间按钮文字，默认为"确 定"
        self.GetCenterButtonLabel_UILabel().text = desInfo.leftButton == nil and "确 定" or desInfo.leftButton

        self:SetButton(desInfo.rightButton ~= nil)
    end
end

--endregion

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, UISummonTipsPanel.OnResBagChangeMessage)
    if UISummonTipsPanel.IEnumRefreshTime ~= nil then
        StopCoroutine(UISummonTipsPanel.IEnumRefreshTime)
        UISummonTipsPanel.IEnumRefreshTime = nil
    end
end

return UISummonTipsPanel