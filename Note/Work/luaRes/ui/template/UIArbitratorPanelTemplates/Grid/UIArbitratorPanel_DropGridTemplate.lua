local UIArbitratorPanel_DropGridTemplate = {}
setmetatable(UIArbitratorPanel_DropGridTemplate,luaComponentTemplates.UIArbitratorPanel_BaseGridTemplate)
--region 初始化
function UIArbitratorPanel_DropGridTemplate:Init()
    self:RunBaseFunction("BaseInit")
end

function UIArbitratorPanel_DropGridTemplate:RefreshUI(info)
    self:RunBaseFunction("RefreshUI",info)
    self:RefreshGrid()
end

function UIArbitratorPanel_DropGridTemplate:RefreshGrid()
    if self.gridType == LuaEnumDropDataType.Drop_FreeGetItem then
        self:RefreshDropFreeGetItem()
    elseif self.gridType == LuaEnumDropDataType.Drop_WaitGetItem then
        self:RefreshDropWaitGetItem()
    end
end

--endregion

--region 无偿领取物品刷新
function UIArbitratorPanel_DropGridTemplate:RefreshDropFreeGetItem()
    self:RefreshActive(self:GetLb_name_UILael(),false)
    self:RefreshActive(self:GetLb_return_GameObject(),true)
    self:RefreshLabel(self:GetBtn_UILabel(),"领取")
    self:RefreshCallBack(function(go) self:FreeGetItemCallBack(go) end)
end

function UIArbitratorPanel_DropGridTemplate:FreeGetItemCallBack(go)
    --print("无偿领取物品")
    if self:ShowPopByCheckDropRedPointState(go) then
        return
    end
    if self:ShowPopByCheckFullBag(go) then
        return
    end
    if self.bagItemInfo ~= nil then
        if uiStaticParameter.OpenPanelIsKuaFuMap == true then
            networkRequest.ReqShareDropReturnAward(self.bagItemInfo.lid)
        else
            networkRequest.ReqDropReturnAward(self.bagItemInfo.lid)
        end
    end
end
--endregion

--region 待赎回物品刷新
function UIArbitratorPanel_DropGridTemplate:RefreshDropWaitGetItem()
    self:RefreshActive(self:GetPrice_GameObject(),true)
    self:RefreshLabel(self:GetPrice_UILabel(),tostring(self.dropInfo.dropMoneyPrice))
    self:RefreshPriceIcon()
    self:RefreshLabel(self:GetBtn_UILabel(),"赎回")
    self:RefreshCallBack(function(go) self:WaitGetItemCallBack(go) end)
    self:RefreshTime()
end

function UIArbitratorPanel_DropGridTemplate:WaitGetItemCallBack(go)
    if self:ShowPopByCheckYuanBao(go) then
        return
    end

    local customData = {}
    customData.ID = LuaEnumSecondConfirmType.Aribitrator_DropBuy
    customData.CenterCostID = self.priceItemInfo.id
    customData.CenterCostNum = self.dropInfo.dropMoneyPrice
    customData.CenterCallBack = function(go)
        print("待赎回物品")
        if self:ShowPopByCheckFullBag(go) then
            return
        end
        if self.bagItemInfo ~= nil then
            if uiStaticParameter.OpenPanelIsKuaFuMap == true then
                networkRequest.ReqShareDropBuy(self.bagItemInfo.lid)
            else
                networkRequest.ReqDropBuy(self.bagItemInfo.lid)
            end
            uimanager:ClosePanel("UIGuildAccusePromptPanel")
        end
    end
    uimanager:CreatePanel("UIGuildAccusePromptPanel", function(panel)
        panel:GetConfirmBtn_UISprite().spriteName = "anniu10"
    end , customData,self.itemInfo.name)
end
--endregion
return UIArbitratorPanel_DropGridTemplate