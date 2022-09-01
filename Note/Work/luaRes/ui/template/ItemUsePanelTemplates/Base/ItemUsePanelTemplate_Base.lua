---@class ItemUsePanelTemplate_Base:TemplateBase
local ItemUsePanelTemplate_Base = {}
--region 组件
---物品名字Label
function ItemUsePanelTemplate_Base:GetItemName_UILabel()
    if self.ItemName_UILabel == nil then
        self.ItemName_UILabel = self:Get("WidgetRoot/window/background/Label", "UILabel")
    end
    return self.ItemName_UILabel
end

---物品图片
function ItemUsePanelTemplate_Base:GetItemIcon_UISprite()
    if self.ItemIcon_UISprite == nil then
        self.ItemIcon_UISprite = self:Get("WidgetRoot/window/background/Icon", "UISprite")
    end
    return self.ItemIcon_UISprite
end

---物品数量
function ItemUsePanelTemplate_Base:GetItemNum_UILabel()
    if self.ItemNum_UILabel == nil then
        self.ItemNum_UILabel = self:Get("WidgetRoot/view/Count", "UILabel")
    end
    return self.ItemNum_UILabel
end

---物品效果文本
function ItemUsePanelTemplate_Base:GetItemEffect_UILabel()
    if self.ItemEffect_UILabel == nil then
        self.ItemEffect_UILabel = self:Get("WidgetRoot/view/expvalue", "UILabel")
    end
    return self.ItemEffect_UILabel
end

---单个物品使用按钮动画组件（用于居中）
function ItemUsePanelTemplate_Base:GetSingleUseBtn_TweenPosition()
    if self.SingleUseBtn_TweenPosition == nil then
        self.SingleUseBtn_TweenPosition = self:Get("WidgetRoot/view/singleprice", "TweenPosition")
    end
    return self.SingleUseBtn_TweenPosition
end

---单个物品使用按钮
function ItemUsePanelTemplate_Base:GetSingleUseBtn_GameObject()
    if self.SingleUseBtn_GameObject == nil then
        self.SingleUseBtn_GameObject = self:Get("WidgetRoot/view/singleprice/btn", "GameObject")
    end
    return self.SingleUseBtn_GameObject
end

---单个物品价格文本
function ItemUsePanelTemplate_Base:GetSingleUseBtnPrice_UILabel()
    if self.SingleUseBtnPrice_UILabel == nil then
        self.SingleUseBtnPrice_UILabel = self:Get("WidgetRoot/view/singleprice/price", "UILabel")
    end
    return self.SingleUseBtnPrice_UILabel
end

---多个物品使用按钮
function ItemUsePanelTemplate_Base:GetMoreUseBtnObj_GameObject()
    if self.MoreUseBtnObj_GameObject == nil then
        self.MoreUseBtnObj_GameObject = self:Get("WidgetRoot/view/totalprice", "GameObject")
    end
    return self.MoreUseBtnObj_GameObject
end

---多个物品使用按钮
function ItemUsePanelTemplate_Base:GetMoreUseBtn_GameObject()
    if self.MoreUseBtn_GameObject == nil then
        self.MoreUseBtn_GameObject = self:Get("WidgetRoot/view/totalprice/btn", "GameObject")
    end
    return self.MoreUseBtn_GameObject
end

---多个物品价格文本
function ItemUsePanelTemplate_Base:GetMoreUseBtnPrice_UILabel()
    if self.MoreUseBtnPrice_UILabel == nil then
        self.MoreUseBtnPrice_UILabel = self:Get("WidgetRoot/view/totalprice/price", "UILabel")
    end
    return self.MoreUseBtnPrice_UILabel
end

---获取关闭按钮
function ItemUsePanelTemplate_Base:GetCloseBtn_GameObject()
    if self.CloseBtn_GameObject == nil then
        self.CloseBtn_GameObject = self:Get("WidgetRoot/events/btn_close", "GameObject")
    end
    return self.CloseBtn_GameObject
end

---使用物品特效
function ItemUsePanelTemplate_Base:GetUseEffect_GameObject()
    if self.UseEffect_GameObject == nil then
        self.UseEffect_GameObject = self:Get("WidgetRoot/window/background/Icon/effect", "GameObject")
    end
    return self.UseEffect_GameObject
end
--endregion

--region 初始化
function ItemUsePanelTemplate_Base:Init()
    self:BindEvents()
end

function ItemUsePanelTemplate_Base:BindEvents()
    self:BindClickCallBack(self:GetSingleUseBtn_GameObject(), function(go)
        self:SingleUseBtnOnClick(go)
    end)
    self:BindClickCallBack(self:GetMoreUseBtn_GameObject(), function(go)
        self:MoreUseBtnOnClick(go)
    end)
    self:BindClickCallBack(self:GetCloseBtn_GameObject(), function(go)
        self:CloseBtnOnClick(go)
    end)
    self:BindClickCallBack(self:GetItemIcon_UISprite(), function(go)
        self:IconOnClick(go)
    end)
end
--endregion

--region 点击事件
function ItemUsePanelTemplate_Base:SingleUseBtnOnClick(go)
    if self.singleUseBtnOnClick ~= nil then
        self.singleUseBtnOnClick(go)
    end
end

function ItemUsePanelTemplate_Base:MoreUseBtnOnClick(go)
    if self.moreUseBtnOnClick ~= nil then
        self.moreUseBtnOnClick(go)
    end
end

function ItemUsePanelTemplate_Base:CloseBtnOnClick(go)
    uimanager:ClosePanel("UIMagicStonePanel")
end

function ItemUsePanelTemplate_Base:IconOnClick(go)
    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.bagItemInfoList[0], showAssistPanel = true, showBind = true, showAction = true,showRight = false })
end
--endregion

--region 刷新
function ItemUsePanelTemplate_Base:RefreshPanel(commonData)
    if self:AnalysisParam(commonData) == false then
        return
    end
    self:DefaultRefresh()
end

function ItemUsePanelTemplate_Base:AnalysisParam(commonData)
    if commonData == nil then
        return false
    end
    self.commonData = commonData
    self.bagItemInfoList = commonData.bagItemInfoList
    local bagItemInfo = self:GetBagItemInfoListFirstItem()
    if bagItemInfo ~= nil then
        ---@type TABLE.CFG_ITEMS
        self.itemInfo = bagItemInfo.ItemTABLE
    end
    self.singleUseBtnOnClick = commonData.singleUseBtnOnClick
    self.moreUseBtnOnClick = commonData.moreUseBtnOnClick
    self.bagItemCount = self:GetItemCount()
    if self.bagItemInfoList == nil or self.bagItemInfoList.Count == 0 or self.bagItemCount == 0 then
        uimanager:ClosePanel("UIMagicStonePanel")
        return false
    end
    return true
end

function ItemUsePanelTemplate_Base:DefaultRefresh()
    self:RefreshLabel(self:GetItemName_UILabel(), self.itemInfo.name)
    self:RefreshActive(self:GetItemEffect_UILabel(), false)
    self:RefreshSprite(self:GetItemIcon_UISprite(), self.itemInfo.icon)
    self:RefreshLabel(self:GetItemNum_UILabel(), "x" .. self.bagItemCount)
    self:RefreshActive(self:GetSingleUseBtnPrice_UILabel(), false)
    self:RefreshActive(self:GetMoreUseBtnPrice_UILabel(), false)
    self:TryRefreshSingleBtn()

end

---对外开放的刷新方法（只刷新自己的物品）
function ItemUsePanelTemplate_Base:RefreshCurPanel()
    if self:AnalysisParam(self.commonData) == false then
        return
    end
    self:RefreshLabel(self:GetItemNum_UILabel(), "x" .. self.bagItemCount)
    self:TryRefreshSingleBtn()
end

function ItemUsePanelTemplate_Base:TryRefreshSingleBtn()
    if self.bagItemCount <= 1 then
        self:RefreshBtnState(false)
    end
end
--endregion

--region UI刷新
---控制显示
function ItemUsePanelTemplate_Base:RefreshActive(obj, state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        obj.gameObject:SetActive(state)
    end
end

---播放特效
function ItemUsePanelTemplate_Base:PlayEffect(obj)
    self:RefreshActive(obj, false)
    self:RefreshActive(obj, true)
end

---设置Sprite
function ItemUsePanelTemplate_Base:RefreshSprite(obj, spriteName)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UISprite)) then
            obj.spriteName = spriteName
        else
            local curSprite = self:GetCurComp(obj, "", "UISprite")
            if curSprite ~= nil then
                curSprite.spriteName = spriteName
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置Label
function ItemUsePanelTemplate_Base:RefreshLabel(obj, text)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UILabel)) then
            obj.text = text
        else
            local curLabel = self:GetCurComp(obj, "", "UILabel")
            if curLabel ~= nil then
                curLabel.text = text
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置特效
function ItemUsePanelTemplate_Base:RefreshCSUIEffectLoad(obj, effectName)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.CSUIEffectLoad)) then
            obj:ChangeEffect(effectName)
        else
            local curCSUIEffectLoad = self:GetCurComp(obj, "", "CSUIEffectLoad")
            if curCSUIEffectLoad ~= nil then
                curCSUIEffectLoad:ChangeEffect(effectName)
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置Tween
function ItemUsePanelTemplate_Base:RefreshTween(obj, state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.TweenPosition)) then
            if state == true then
                obj:PlayForward()
            else
                obj:PlayReverse()
            end
        else
            local tween = self:GetCurComp(obj, "", "TweenPosition")
            if tween ~= nil then
                if state == true then
                    tween:PlayForward()
                else
                    tween:PlayReverse()
                end
            end
        end
    end
end

---通过路径设置对应特效
function ItemUsePanelTemplate_Base:RefreshCSUIEffectLoadByPath(path, effectName)
    if CS.StaticUtility.IsNullOrEmpty(path) == false and CS.StaticUtility.IsNullOrEmpty(effectName) == false then
        local curEffectLoad = self:Get(path, "CSUIEffectLoad")
        if CS.StaticUtility.IsNull(curEffectLoad) == true then
            curEffectLoad = self:Get(path, "GameObject")
            if curEffectLoad ~= nil then
                curEffectLoad:AddComponent("CSUIEffectLoad")
            end
        end
        self:RefreshCSUIEffectLoad(curEffectLoad, effectName)
    end
end

---绑定点击事件
function ItemUsePanelTemplate_Base:BindClickCallBack(obj, action)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        CS.UIEventListener.Get(obj.gameObject).onClick = action
    end
end

---@param 是否是双按钮 boolean
function ItemUsePanelTemplate_Base:RefreshBtnState(isDoubleBtn)
    if isDoubleBtn == true then
        self:RefreshTween(self:GetSingleUseBtn_TweenPosition(), false)
        self:RefreshActive(self:GetMoreUseBtnObj_GameObject(), true)
    else
        self:RefreshTween(self:GetSingleUseBtn_TweenPosition(), true)
        self:RefreshActive(self:GetMoreUseBtnObj_GameObject(), false)
    end
end
--endregion

--region 获取
---获取物品数量
function ItemUsePanelTemplate_Base:GetItemCount()
    local count = 0
    if self.bagItemInfoList ~= nil then
        local length = self.bagItemInfoList.Count - 1
        for k = 0, length do
            local bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemBylId(self.bagItemInfoList[k].lid)
            if bagItemInfo ~= nil then
                count = count + bagItemInfo.count
            end
        end
    end
    return count
end

---获取背包物品列表中的第一个物品
function ItemUsePanelTemplate_Base:GetBagItemInfoListFirstItem()
    if self.bagItemInfoList ~= nil then
        local length = self.bagItemInfoList.Count - 1
        for k = 0, length do
            local bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemBylId(self.bagItemInfoList[k].lid)
            if bagItemInfo ~= nil then
                return bagItemInfo
            end
        end
    end
    return nil
end

---获取可使用的背包物品列表
function ItemUsePanelTemplate_Base:GetCanUseBagItemInfoList()
    if self.bagItemInfoList ~= nil then
        local length = self.bagItemInfoList.Count - 1
        for k = 0, length do
            local bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemBylId(self.bagItemInfoList[k].lid)
            if bagItemInfo == nil then
                self.bagItemInfoList:Remove(bagItemInfo)
            end
        end
    end
end
--endregion
return ItemUsePanelTemplate_Base