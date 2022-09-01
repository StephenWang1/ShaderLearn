local UIPromptEscortDoubleRewardPanel = {}
--region 初始化
function UIPromptEscortDoubleRewardPanel:Init()
    self:InitComponent()
    self:BindEvents()
end

function UIPromptEscortDoubleRewardPanel:InitComponent()
    self.closeBtn_GameObject = self:GetCurComp("events/close","GameObject")
    self.LeftBtn_GameObject = self:GetCurComp("events/LeftBtn","GameObject")
    self.RightBtn_GameObject = self:GetCurComp("events/RightBtn","GameObject")
    self.DropDown = self:GetCurComp("view/DropDown","Top_UIDropDown")
    self.price_UILabel = self:GetCurComp("view/itemgold","UILabel")
    self.price_UISprite = self:GetCurComp("view/itemgold/Sprite","UISprite")
    self.RightBtn_UILabel = self:GetCurComp("events/RightBtn/Label","UILabel")
end

function UIPromptEscortDoubleRewardPanel:BindEvents()
    CS.UIEventListener.Get(self.closeBtn_GameObject).onClick = function()
        uimanager:ClosePanel(self)
    end
    CS.UIEventListener.Get(self.LeftBtn_GameObject).onClick = function()
        networkRequest.ReqReceivePersonalCartReward(self.dartLid, 1)
        uimanager:ClosePanel(self)
    end
    CS.UIEventListener.Get(self.RightBtn_GameObject).onClick = function(go)
        if self.priceIsEnough then
            networkRequest.ReqReceivePersonalCartReward(self.dartLid, self.dropDownChoose.Multiple)
            uimanager:ClosePanel(self)
        else
            Utility.ShowPopoTips(go, nil, 220)
        end
    end
end
--endregion

--region 刷新
function UIPromptEscortDoubleRewardPanel:Show(commonData)
    if self:Analysis(commonData) == false then
        uimanager:ClosePanel(self)
        return
    end
    self:RefreshPanel()
end

---解析数据
---@return 解析参数是否成功
function UIPromptEscortDoubleRewardPanel:Analysis(commonData)
    if commonData == nil or commonData.dartCarInfo == nil then
        return false
    end
    self.dartCarInfo = commonData.dartCarInfo
    self.dartLid = self.dartCarInfo.CarLid
    self.dartCarTableInfo = self.dartCarInfo.YaBiaoTable
    self.rewardList = CS.Cfg_PersonDartCarTableManager.Instance:GetMoreRewardArray(self.dartCarTableInfo.id,Utility.EnumToInt(self.dartCarInfo.EndDartCarState))
    if self.rewardList == nil or self.rewardList.Count == 0 then
        return false
    end
    self.rewardTable = self:GetDropDownParams()
    self.dropDownChoose = self.rewardList[0]
    self.priceIsEnough = self.dropDownChoose:PriceIsEnough()
    return true
end

function UIPromptEscortDoubleRewardPanel:GetDropDownParams()
    local rewardTable = {}
    if self.rewardList ~= nil then
        local length = self.rewardList.Count - 1
        for k = 0,length do
            local textName = self.rewardList[k].TextName
            if textName ~= nil then
                table.insert(rewardTable,textName)
            end
        end
    end
    return rewardTable
end

---刷新面板
function UIPromptEscortDoubleRewardPanel:RefreshPanel()
    self:SetDropDown()
    self:RefreshPrice()
end

---设置下拉列表
function UIPromptEscortDoubleRewardPanel:SetDropDown()
    if self.DropDown ~= nil then
        self.DropDown:SetOptions(self.rewardTable)
        self.DropDown:SetCaptionLabel(self.dropDownChoose.TextName)
        self.DropDown.OnValueChange:Add(function(params) self:DropDownBtnOnClick(params) end)
    end
end

---下拉列表点击
function UIPromptEscortDoubleRewardPanel:DropDownBtnOnClick(params)
    local index = params.index
    self.dropDownChoose = self.rewardList[index]
    self.priceIsEnough = self.dropDownChoose:PriceIsEnough()
    self:RefreshPrice()
end

function UIPromptEscortDoubleRewardPanel:RefreshPrice()
    if self.price_UILabel ~= nil and self.price_UISprite ~= nil and self.RightBtn_UILabel ~= nil and self.dropDownChoose ~= nil then
        self.price_UILabel.text = ternary(self.priceIsEnough == false,luaEnumColorType.Red,luaEnumColorType.White) ..  tostring(self.dropDownChoose.Num)
        self.price_UISprite.spriteName = self.dropDownChoose.IconName
        self.RightBtn_UILabel.text = self.dropDownChoose.TextName
    end
end
--endregion

return UIPromptEscortDoubleRewardPanel