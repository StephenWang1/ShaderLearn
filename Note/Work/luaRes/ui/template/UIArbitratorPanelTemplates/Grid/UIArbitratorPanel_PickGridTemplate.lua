local UIArbitratorPanel_PickGridTemplate = {}
setmetatable(UIArbitratorPanel_PickGridTemplate,luaComponentTemplates.UIArbitratorPanel_BaseGridTemplate)
--region 初始化
function UIArbitratorPanel_PickGridTemplate:Init()
    self:RunBaseFunction("BaseInit")
end

function UIArbitratorPanel_PickGridTemplate:RefreshUI(info)
    self:RunBaseFunction("RefreshUI",info)
    self:RefreshGrid()
end

function UIArbitratorPanel_PickGridTemplate:RefreshGrid()
    if self.gridType == LuaEnumDropDataType.Pick_NoBodyGetItem then
        self:RefreshNoBodyGetItem()
    elseif self.gridType == LuaEnumDropDataType.Pick_WaitGetCoinItem then
        self:RefreshWaitGetCoinItem()
    elseif self.gridType == LuaEnumDropDataType.Pick_WaitGiveBack_SameUnion then
        self:RefreshWaitGiveBack_SameUnion()
    elseif self.gridType == LuaEnumDropDataType.Pick_WaitGiveBack_DifferentUnion then
        self:RefreshWaitGiveBack_DifferentUnion()
    end
end
--endregion

--region 无人赎回物品刷新
function UIArbitratorPanel_PickGridTemplate:RefreshNoBodyGetItem()
    self:RefreshActive(self:GetLb_name_UILael(),false)
    self:RefreshLabel(self:GetLb_state(),"过期未赎已无归属")
    self:RefreshLabel(self:GetBtn_UILabel(),"领取")
    self:RefreshCallBack(function(go) self:NoBodyGetItemCallBack(go) end)
end

function UIArbitratorPanel_PickGridTemplate:NoBodyGetItemCallBack(go)
    print("无人赎回物品刷新")
    if self:ShowPopByCheckPickRedPointState(go) then
        return
    end
    if self:ShowPopByCheckFullBag(go) then
        return
    end
    if self.bagItemInfo ~= nil then
        if uiStaticParameter.OpenPanelIsKuaFuMap == true then
            networkRequest.ReqSharePickUpAward(self.bagItemInfo.lid)
        else
            networkRequest.ReqPickUpAward(self.bagItemInfo.lid)
        end
    end
end
--endregion

--region 待领取赎金物品刷新
function UIArbitratorPanel_PickGridTemplate:RefreshWaitGetCoinItem()
    self:RefreshActive(self:GetSameUnion_GameObject(),false)
    self:RefreshLabel(self:GetLb_name_UILael(),self.dropInfo.ownerName)

    self:RefreshLabel(self:GetLb_state(),"已缴纳赎金")

    self:RefreshLabel(self:GetPrice_GameObject(),"可领奖励")
    self:RefreshLabel(self:GetPrice_UILabel(),tostring(self.dropInfo.pickUpPrice))
    self:RefreshPriceIcon()

    self:RefreshLabel(self:GetBtn_UILabel(),"领取")
    self:RefreshCallBack(function(go) self:WaitGetCoinItemCallBack(go) end)

    self:RefreshTweenPosition(self:GetPrice_GameObject(),true)
    self:RefreshTweenPosition(self:GetLb_name_UILael(),true)
end

function UIArbitratorPanel_PickGridTemplate:WaitGetCoinItemCallBack(go)
    print("待领取赎金物品刷新")
    if self:ShowPopByCheckPickRedPointState(go) then
        return
    end
    if self.bagItemInfo ~= nil then
        if uiStaticParameter.OpenPanelIsKuaFuMap == true then
            networkRequest.ReqSharePickUpAward(self.bagItemInfo.lid)
        else
            networkRequest.ReqPickUpAward(self.bagItemInfo.lid)
        end
    end
end
--endregion

--region 待归还物品（同帮会）刷新
function UIArbitratorPanel_PickGridTemplate:RefreshWaitGiveBack_SameUnion()
    self:RefreshLabel(self:GetLb_name_UILael(),self.dropInfo.ownerName)
    self:RefreshActive(self:GetSameUnion_GameObject(),true)

    self:RefreshLabel(self:GetPrice_GameObject(),"可领奖励")
    self:RefreshLabel(self:GetPrice_UILabel(),tostring(self.dropInfo.pickUpPrice))
    self:RefreshPriceIcon()

    self:RefreshLabel(self:GetBtn_UILabel(),"无偿归还")

    self:RefreshTime()

    self:RefreshCallBack(function() self:WaitGiveBack_SameUnionCallBack() end)
end

function UIArbitratorPanel_PickGridTemplate:WaitGiveBack_SameUnionCallBack()
    Utility.ShowSecondConfirmPanel({PromptWordId = LuaEnumSecondConfirmType.Aribitrator_PickGiveBack,ComfireAucion = function()
        print("待归还物品（同行会）")
        if self.bagItemInfo ~= nil then
            if uiStaticParameter.OpenPanelIsKuaFuMap == true then
                networkRequest.ReqShareDropReturn(self.bagItemInfo.lid)
            else
                networkRequest.ReqDropReturn(self.bagItemInfo.lid)
            end
        end
    end})
end
--endregion

--region 待归还物品（不同帮会）刷新
function UIArbitratorPanel_PickGridTemplate:RefreshWaitGiveBack_DifferentUnion()
    self:RefreshLabel(self:GetLb_name_UILael(),self.dropInfo.ownerName)
    self:RefreshActive(self:GetSameUnion_GameObject(),false)

    self:RefreshLabel(self:GetPrice_GameObject(),"可领奖励")
    self:RefreshLabel(self:GetPrice_UILabel(),tostring(self.dropInfo.pickUpPrice))
    self:RefreshPriceIcon()

    self:RefreshLabel(self:GetBtn_UILabel(),"无偿归还")

    self:RefreshTime()

    self:RefreshCallBack(function() self:WaitGiveBack_DifferentUnionCallBack() end)
end

function UIArbitratorPanel_PickGridTemplate:WaitGiveBack_DifferentUnionCallBack()
    Utility.ShowSecondConfirmPanel({PromptWordId = LuaEnumSecondConfirmType.Aribitrator_PickGiveBack,ComfireAucion = function()
        print("待归还物品（不同帮会）")
        if self.bagItemInfo ~= nil then
            if uiStaticParameter.OpenPanelIsKuaFuMap == true then
                networkRequest.ReqShareDropReturn(self.bagItemInfo.lid)
            else
                networkRequest.ReqDropReturn(self.bagItemInfo.lid)
            end
        end
    end})
end
--endregion
return UIArbitratorPanel_PickGridTemplate