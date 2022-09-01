local UIArbitratorPanel_BaseGridTemplate = {}
--region 数据
---格子下标
UIArbitratorPanel_BaseGridTemplate.index = 0
---@param LuaEnumDropDataType
UIArbitratorPanel_BaseGridTemplate.gridType = 0
---@param mapV2.DropProtect
UIArbitratorPanel_BaseGridTemplate.dropInfo = nil

function UIArbitratorPanel_BaseGridTemplate:GetMainPlayerInfo()
    if self.mainPlayerInfo == nil then
        self.mainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mainPlayerInfo
end
--endregion

--region 组件
---按钮
function UIArbitratorPanel_BaseGridTemplate:GetBtn_GameObject()
    if self.btn_GameObject == nil then
        self.btn_GameObject = self:Get("btn","GameObject")
    end
    return self.btn_GameObject
end

---按钮文字
function UIArbitratorPanel_BaseGridTemplate:GetBtn_UILabel()
    if self.btn_UILabel == nil then
        self.btn_UILabel = self:Get("btn/Label","UILabel")
    end
    return self.btn_UILabel
end

---物品icon
function UIArbitratorPanel_BaseGridTemplate:GetIcon_UISprite()
    if self.icon_UISprite == nil then
        self.icon_UISprite = self:Get("icon","GameObject")
    end
    return self.icon_UISprite
end

---冷却时间
function UIArbitratorPanel_BaseGridTemplate:GetCountDown_UILabel()
    if self.countDown_UILabel == nil then
        self.countDown_UILabel = self:Get("countDown","UILabel")
    end
    return self.countDown_UILabel
end

---价格
function UIArbitratorPanel_BaseGridTemplate:GetPrice_GameObject()
    if self.price_GameObject == nil then
        self.price_GameObject = self:Get("ransom","UILabel")
    end
    return self.price_GameObject
end

---价格文本
function UIArbitratorPanel_BaseGridTemplate:GetPrice_UILabel()
    if self.price_UILabel == nil then
        self.price_UILabel = self:Get("ransom/price","UILabel")
    end
    return self.price_UILabel
end

---价格图片
function UIArbitratorPanel_BaseGridTemplate:GetPrice_UISprite()
    if self.price_UISprite == nil then
        self.price_UISprite = self:Get("ransom/price/icon","UISprite")
    end
    return self.price_UISprite
end

---掉落状态
function UIArbitratorPanel_BaseGridTemplate:GetLb_state()
    if self.lb_state == nil then
        self.lb_state = self:Get("lb_state","UILabel")
    end
    return self.lb_state
end

---归属者名字
function UIArbitratorPanel_BaseGridTemplate:GetLb_name_UILael()
    if self.lb_name_UILael == nil then
        self.lb_name_UILael = self:Get("lb_name","UILabel")
    end
    return self.lb_name_UILael
end

---无偿领取状态
function UIArbitratorPanel_BaseGridTemplate:GetLb_return_GameObject()
    if self.lb_return_GameObject == nil then
        self.lb_return_GameObject = self:Get("lb_return","GameObject")
    end
    return self.lb_return_GameObject
end

---同帮会图片
function UIArbitratorPanel_BaseGridTemplate:GetSameUnion_GameObject()
    if self.SameUnion_GameObject == nil then
        self.SameUnion_GameObject = self:Get("lb_name/same_sign","GameObject")
    end
    return self.SameUnion_GameObject
end

---背景图
function UIArbitratorPanel_BaseGridTemplate:GetBackground_GameObject()
    if self.Background_GameObject == nil then
        self.Background_GameObject = self:Get("background","GameObject")
    end
    return self.Background_GameObject
end

---物品名字
function UIArbitratorPanel_BaseGridTemplate:GetItemName_UILabel()
    if self.ItemName_UILabel == nil then
        self.ItemName_UILabel = self:Get("lb_name","UILabel")
    end
    return self.ItemName_UILabel
end
--endregion

--region 初始设置
function UIArbitratorPanel_BaseGridTemplate:BaseInit()
    self:RefreshActive(self:GetCountDown_UILabel(),false)
    self:RefreshActive(self:GetPrice_GameObject(),false)
    self:RefreshActive(self:GetLb_state(),false)
    self:RefreshActive(self:GetLb_name_UILael(),false)
    self:RefreshActive(self:GetLb_return_GameObject(),false)
    self:RefreshTweenPosition(self:GetPrice_GameObject(),false)
    self:RefreshTweenPosition(self:GetLb_name_UILael(),false)
end
--endregion

--region UI刷新
function UIArbitratorPanel_BaseGridTemplate:RefreshUI(info)
    self.index = info.curIndex
    self.gridType = info.type
    self.dropInfo = info.curDropItem
    self.bagItemInfo = self.dropInfo.bagItemInfo
    self.itemTimeOut = self:GetMainPlayerInfo().DropInfo.ItemTimeOut
    self.needRefreshTime = self:NeedRefreshTime()
    local itemInfoIsFind,itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.bagItemInfo.itemId)
    if itemInfoIsFind then
        self.itemInfo = itemInfo
    end
    local priceItemInfoIsFind,priceItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.dropInfo.moneyType)
    if priceItemInfoIsFind then
        self.priceItemInfo = priceItemInfo
    end
    self:RefreshIcon()
    self:RefreshLabel(self:GetItemName_UILabel(),self.itemInfo.name)
    self:RefreshActive(self:GetBackground_GameObject(),self.index % 2 ~= 0)
end
--endregion

--region UI控制
---控制显示
function UIArbitratorPanel_BaseGridTemplate:RefreshActive(obj,state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        obj.gameObject:SetActive(state)
    end
end

---设置Sprite
function UIArbitratorPanel_BaseGridTemplate:RefreshSprite(obj,spriteName)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UISprite)) then
            obj.spriteName = spriteName
        else
            local curSprite = self:GetCurComp(obj,"","UISprite")
            if curSprite ~= nil then
                curSprite.spriteName = spriteName
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj,true)
        end
    end
end

---设置Label
function UIArbitratorPanel_BaseGridTemplate:RefreshLabel(obj,text)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UILabel)) then
            obj.text = text
        else
            local curLabel = self:GetCurComp(obj,"","UILabel")
            if curLabel ~= nil then
                curLabel.text = text
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj,true)
        end
    end
end

---播放tween
function UIArbitratorPanel_BaseGridTemplate:RefreshTweenPosition(obj,state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_TweenPosition)) then
            obj:PlayForward()
        else
            local curTweenPosition = self:GetCurComp(obj,"","TweenPosition")
            if curTweenPosition ~= nil then
                if state == true then
                    curTweenPosition:PlayForward()
                else
                    curTweenPosition:PlayReverse()
                end
            end
        end
    end
end

---设置按钮回调
function UIArbitratorPanel_BaseGridTemplate:RefreshCallBack(action)
    if self:GetBtn_GameObject() ~= nil and  not CS.StaticUtility.IsNull(self:GetBtn_GameObject()) then
        CS.UIEventListener.Get(self:GetBtn_GameObject()).onClick = action
    end
end

---刷新icon
function UIArbitratorPanel_BaseGridTemplate:RefreshIcon()
    self.iconTemplate = templatemanager.GetNewTemplate(self:GetIcon_UISprite(),luaComponentTemplates.UIArbitratorPanel_ItemGrid)
    if self.iconTemplate ~= nil then
        self.iconTemplate:RefreshUI(self)
    end
end

---刷新货币icon
function UIArbitratorPanel_BaseGridTemplate:RefreshPriceIcon()
    if self.priceItemInfo ~= nil then
        self:RefreshSprite(self:GetPrice_UISprite(),self.priceItemInfo.icon)
    end
end
--endregion

--region 查询
---获取剩余时间
function UIArbitratorPanel_BaseGridTemplate:GetCutDownTime()
    local remainTime = self.dropInfo.pickUpTime  + self.itemTimeOut * 1000 - self:GetMainPlayerInfo().serverTime
    if remainTime <= 0 then
        return 0,0,0
    end
    local hour, minute, second = Utility.MillisecondToFormatTime(remainTime)
    return hour, minute, second
end

---获取剩余时间显示文本
function UIArbitratorPanel_BaseGridTemplate:GetCutTimeText()
    local hour, minute, second = self:GetCutDownTime()
    return string.format("%02.0f:%02.0f:%02.0f",hour,minute,second)
end

---查询是否有足够的时间（剩余时间>0则表示有足够的时间）
function UIArbitratorPanel_BaseGridTemplate:HaveEnoughTime()
    return self:GetMainPlayerInfo().DropInfo:HaveEnoughTime(self.dropInfo)
end

---查询是否需要刷新时间
function UIArbitratorPanel_BaseGridTemplate:NeedRefreshTime()
    return self:GetMainPlayerInfo().DropInfo:NeedRefreshTime(self.gridType)
end
--endregion

--region 刷新时间
function UIArbitratorPanel_BaseGridTemplate:RefreshTime()
    if self.needRefreshTime then
        ---如果有足够的时间，则刷新时间，如果有物品没有足够的时间，则说明需要重新获取物品列表并刷新面板状态
        if self:HaveEnoughTime() then
            self:RefreshLabel(self:GetCountDown_UILabel(),self:GetCutTimeText())
        else
            if uiStaticParameter.OpenPanelIsKuaFuMap == true then
                networkRequest.ReqShareDropProtect()
            else
                networkRequest.ReqDropProtect()
            end
        end
    end
end
--endregion

--region 气泡相关
---（满背包）检查显示气泡(若果显示气泡，则返回true，否则返回false)
function UIArbitratorPanel_BaseGridTemplate:ShowPopByCheckFullBag(go)
    if not self:GetMainPlayerInfo().BagInfo:CheckIsAbleToAddItem(self.itemInfo) then
        Utility.ShowPopoTips(go, nil, LuaEnumPopoTipsType.FullBag)
        return true
    end
    return false
end

---（拾取红点）检查显示气泡(若果显示气泡，则返回true，否则返回false)
function UIArbitratorPanel_BaseGridTemplate:ShowPopByCheckPickRedPointState(go)
    if not self:GetMainPlayerInfo().DropInfo:GetPickRedPointState() then
        Utility.ShowPopoTips(go, nil, LuaEnumPopoTipsType.Arbitrator_CantReceive)
        return true
    end
    return false
end

---（掉落红点）检查显示气泡(若果显示气泡，则返回true，否则返回false)
function UIArbitratorPanel_BaseGridTemplate:ShowPopByCheckDropRedPointState(go)
    if not self:GetMainPlayerInfo().DropInfo:GetDropRedPointState() then
        Utility.ShowPopoTips(go, nil, LuaEnumPopoTipsType.Arbitrator_CantReceive)
        return true
    end
    return false
end

---(货币不足)检查显示气泡(若果显示气泡，则返回true，否则返回false)
function UIArbitratorPanel_BaseGridTemplate:ShowPopByCheckYuanBao(go)
    if self:GetMainPlayerInfo().BagInfo:GetCoinNum(self.dropInfo.moneyType) < self.dropInfo.dropMoneyPrice then
        Utility.ShowPopoTips(go, CS.Cfg_PromptFrameTableManager.Instance:GetShowContent(LuaEnumPopoTipsType.NoEnoughYuanBao,self.priceItemInfo.name), LuaEnumPopoTipsType.NoEnoughYuanBao)
        return true
    end
    return false
end
--endregion
return UIArbitratorPanel_BaseGridTemplate