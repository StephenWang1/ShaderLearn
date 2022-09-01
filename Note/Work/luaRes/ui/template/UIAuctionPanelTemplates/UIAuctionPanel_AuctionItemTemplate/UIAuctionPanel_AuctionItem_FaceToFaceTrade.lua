---面对面交易
---@class UIAuctionPanel_AuctionItem_FaceToFaceTrade:UIAuctionPanel_AuctionItemTemplateBase
local UIAuctionPanel_AuctionItem_FaceToFaceTrade = {}

setmetatable(UIAuctionPanel_AuctionItem_FaceToFaceTrade, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

function UIAuctionPanel_AuctionItem_FaceToFaceTrade:Init(data)
    self:RunBaseFunction("Init", data)
    self.mMaxNum = data.BagItemInfo.count
    self.mMinNum = 1
    self.ItemInfo = data.BagItemInfo.ItemTABLE
    self.num = 1
    self:SetNum()
    self:SuitPanel()
end

--region 用于重写
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:IsNumLabelNeedSpace()
    return false
end

---@return boolean 是否显示标题
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:ShowTitleBtn()
    return false
end

---@return boolean 是否显示数目
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:ShowNum()
    return true
end

---@return number 价格行数
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:ShowCoin()
    return 0
end

---@return boolean 是否显示滑条
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:ShowSlider()
    return true
end

---@return boolean 是否是单个按钮
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:IsSingleBtn()
    return true
end

---@return boolean 是否显示文本
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:ShowLabel()
    return false
end

---@return boolean 是否显示加号
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:ShowAddBtn()
    return true
end

---@return boolean 是否显示减号
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:ShowReduceBtn()
    return true
end

---滑条改变
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:SliderChange(sliderValue)
    if self.mIsSelfSet then
        return
    end
    self.num = math.ceil(sliderValue * self.mMaxNum)
    self.num = math.clamp(self.num, self.mMinNum, self.mMaxNum)
    self:SetNum()
end

---输入数目改变
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:NumChange(inputValue)
    local num = tonumber(inputValue)
    if num and self.mMaxNum then
        if num > self.mMaxNum then
            self.num = self.mMaxNum
        elseif num < self.mMinNum then
            self.num = self.mMinNum
        else
            self.num = num
        end
        self:SetNum()
        self.mIsSelfSet = true
        if self.mMaxNum > 1 then
            self.slider_UISlider.value = (self.num - 1) / (self.mMaxNum - 1)
        else
            self.slider_UISlider.value = 1
        end
        self.mIsSelfSet = nil
    end
end

---点击竞拍按钮(左按钮)
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:OnAuctionBtnClicked()
end

---点击直购按钮（右按钮）
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:OnBuyBtnClicked(go)
end

---用于数目变化后的处理
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:SetNum()
    self.num_UIInput.value = self.num
end

---公示改变
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:OnPublishToggleChange(value)
end

---点击上架按钮
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:OnShelfClicked(go)
    local uiFaceToFaceDealPanel = uimanager:GetPanel("UIFaceToFaceDealPanel")
    if uiFaceToFaceDealPanel == nil then
        return
    end
    if uiFaceToFaceDealPanel.IsReachTraderLimit then
        local name = "UIItemInfoPanel"
        if uimanager:GetPanel("UIItemInfoPanel") == nil then
            name = "UIPetInfoPanel"
        end
        Utility.ShowPopoTips(go.gameObject.transform, nil, 296, name)
        return
    end
    if (gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(self.data.BagItemInfo)) then
        gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():ShowInsurancePopup()
        return
    end
    networkRequest.ReqAddItemToTrade(self.data.BagItemInfo.lid, self.num)
    uimanager:ClosePanel("UIAuctionItemPanel")
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

function UIAuctionPanel_AuctionItem_FaceToFaceTrade:OnReduceBtnClicked(go)
    self:RunBaseFunction("OnReduceBtnClicked", go)
    self.mIsSelfSet = true
    if self.mMaxNum > 1 then
        self.slider_UISlider.value = (self.num - 1) / (self.mMaxNum - 1)
    else
        self.slider_UISlider.value = 1
    end
    self.mIsSelfSet = false
end

function UIAuctionPanel_AuctionItem_FaceToFaceTrade:OnAddBtnClicked(go)
    self:RunBaseFunction("OnAddBtnClicked", go)
    self.mIsSelfSet = true
    if self.mMaxNum > 1 then
        self.slider_UISlider.value = (self.num - 1) / (self.mMaxNum - 1)
    else
        self.slider_UISlider.value = 1
    end
    self.mIsSelfSet = false
end

---刷新标题
function UIAuctionPanel_AuctionItem_FaceToFaceTrade:RefreshTitle()
    self.centerBtn_UILabel.text = "放入"
end

function UIAuctionPanel_AuctionItem_FaceToFaceTrade:RefreshNumName()
    self.mNameTitle_UILabel.text = ternary(self:IsNumLabelNeedSpace(), "数     目", "数目")
end

--endregion

return UIAuctionPanel_AuctionItem_FaceToFaceTrade