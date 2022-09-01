---@class UIGuildSendRedPanelTemplate:TemplateBase 帮会发放红包
local UIGuildSendRedPanelTemplate = {}

--region 额外的显示
---@return UILabel 总额
function UIGuildSendRedPanelTemplate:GetMoneyInputName_UILabel()
    if self.mMoneyInputName == nil then
        self.mMoneyInputName = self:Get("reward/Content", "UILabel")
    end
    return self.mMoneyInputName
end

---@return UILabel 总额单位
function UIGuildSendRedPanelTemplate:GetMoneyInputGoldName_UILabel()
    if self.mMoneyInputGoldName == nil then
        self.mMoneyInputGoldName = self:Get("reward/goldName", "UILabel")
    end
    return self.mMoneyInputGoldName
end

---@return UnityEngine.GameObject 总额背景
function UIGuildSendRedPanelTemplate:GetMoneyInputBg_Go()
    if self.mMoneyInputBg == nil then
        self.mMoneyInputBg = self:Get("reward/inputcount/Background", "GameObject")
    end
    return self.mMoneyInputBg
end

---@return UnityEngine.BoxCollider 总数Collider
function UIGuildSendRedPanelTemplate:GetMoneyInputBox_BoxCollider()
    if self.mMoneyInputBoxCollider == nil then
        self.mMoneyInputBoxCollider = self:Get("reward/inputcount", "BoxCollider")
    end
    return self.mMoneyInputBoxCollider
end

---@retutn UILabel 数目
function UIGuildSendRedPanelTemplate:GetNumInputName_UILabel()
    if self.mNumInputName == nil then
        self.mNumInputName = self:Get("Num/Content", "UILabel")
    end
    return self.mNumInputName
end

---@retutn UILabel 数目单位
function UIGuildSendRedPanelTemplate:GetNumInputGoldName_UILabel()
    if self.mNumInputGoldName == nil then
        self.mNumInputGoldName = self:Get("Num/Content", "UILabel")
    end
    return self.mNumInputGoldName
end

---@return UnityEngine.GameObject 数目背景
function UIGuildSendRedPanelTemplate:GetNumInputBg_Go()
    if self.mNumInputBg == nil then
        self.mNumInputBg = self:Get("Num/inputcount/Background", "GameObject")
    end
    return self.mNumInputBg
end

---@return UnityEngine.BoxCollider 数目Collider
function UIGuildSendRedPanelTemplate:GetNumInputBox_BoxCollider()
    if self.mNunInputBoxCollider == nil then
        self.mNunInputBoxCollider = self:Get("Num/inputcount", "BoxCollider")
    end
    return self.mNunInputBoxCollider
end

---@return UILabel 发送按钮文本
function UIGuildSendRedPanelTemplate:GetSendBtn_UILabel()
    if self.mSendBtnLabel == nil then
        self.mSendBtnLabel = self:Get("CenterBtn/Label", "UILabel")
    end
    return self.mSendBtnLabel
end



--endregion

--黄色
UIGuildSendRedPanelTemplate.colorYellow = CS.UnityEngine.Color(255 / 255, 203 / 255, 61 / 255, 1)
--灰色
UIGuildSendRedPanelTemplate.colorGray = CS.UnityEngine.Color(135 / 255, 135 / 255, 135 / 255, 1)
--红色
UIGuildSendRedPanelTemplate.colorRed = CS.UnityEngine.Color(232 / 255, 80 / 255, 56 / 255, 1)

UIGuildSendRedPanelTemplate.mCanChangeMoneyNum = true

---@return CSMainPlayerInfo
function UIGuildSendRedPanelTemplate:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSUnionInfoV2
function UIGuildSendRedPanelTemplate:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mUnionInfoV2 = self:GetMainPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfoV2
end

function UIGuildSendRedPanelTemplate:Init(customData)
    self:InitComponent()
    if customData then
        self.mData = customData
        ---@type bagV2.BagItemInfo
        self.mBagItemInfo = customData.BagItemInfo

        local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mBagItemInfo.itemId)
        if res then
            if Utility.IsUnionRedPack(itemInfo) then
                if itemInfo.useParam and itemInfo.useParam.list.Count > 1 then
                    local coinId = itemInfo.useParam.list[0]
                    self:GetMoneyInputGoldName_UILabel().text = CS.Cfg_ItemsTableManager.Instance:GetItemName(coinId)
                end
            else
                self:GetMoneyInputGoldName_UILabel().text = CS.Cfg_ItemsTableManager.Instance:GetItemName(self.mBagItemInfo.itemId)
            end
        end

        ---@type number 需要发放人数
        self.mFinalSendMember = 0
        ---@type number 需要发放数目
        self.mFinalSendMoney = 0

        ---默认发放人数
        self.mNormalMemberNum = CS.Cfg_GlobalTableManager.Instance:GetRedPackNormalPersonNum()
        ---@type number  最大发放成员数
        self.mMaxSendMember = 0
        if self:GetUnionInfoV2() then
            local maxMemeber = self:GetUnionInfoV2().UnionMember.Count
            self.mMaxSendMember = math.max(maxMemeber, self.mNormalMemberNum)
        end

        self.mMinSendMember = CS.Cfg_GlobalTableManager.Instance:GetRedPackPersonNum()
        if self.mMinSendMember == nil then
            self.mMinSendMember = 0
        end
        if self.mMaxSendMember < self.mMinSendMember then
            self.mMaxSendMember = self.mMinSendMember
        end

        ---@type number 最大发放数目
        self.mMaxSendMoney = CS.Cfg_GlobalTableManager.Instance:GetUnionRedPackMaxNum()

        self:RefreshSendRedPack(customData)
        self:RefreshBtn()
        self:BindEvents()
    end
end

function UIGuildSendRedPanelTemplate:InitComponent()
    ---@type  UIGridContainer
    ---按钮
    self.mBtn_UIGridContainer = self:Get("Btns", "UIGridContainer")

    ---@type UIInput
    ---总额输入
    self.mMoneyInput_UIInput = self:Get("reward/inputcount", "UIInput")
    self.mMoneyInput_UIInput.submitOnUnselect = true

    ---@type UILabel
    ---总额输入文本
    self.mMoneyInput_UILabel = self:Get("reward/inputcount/Label", "UILabel")

    ---@type UIInput
    ---数目输入
    self.mMemberInput_UIInput = self:Get("Num/inputcount", "UIInput")
    self.mMemberInput_UIInput.submitOnUnselect = true

    ---@type UILabel
    ---数目输入文本
    self.mMemberInput_UILabel = self:Get("Num/inputcount/Label", "UILabel")
end

function UIGuildSendRedPanelTemplate:BindEvents()
    CS.EventDelegate.Add(self.mMemberInput_UIInput.onSubmit, function()
        self:OnMemberInputSubmit()
    end)
    CS.EventDelegate.Add(self.mMoneyInput_UIInput.onSubmit, function()
        self:OnMoneyInputSubmit()
    end)
end

---刷新红包显示
function UIGuildSendRedPanelTemplate:RefreshSendRedPack(customData)
    if customData == nil then
        return
    end
    ---@type bagV2.BagItemInfo
    local bagItemInfo = customData.BagItemInfo
    if bagItemInfo then
        local num = bagItemInfo.count
        local minNum = math.min(num, self.mMaxSendMoney)
        self:SetMoneyNum(minNum)
        self:SetMemberNum(self.mNormalMemberNum)
    end
end

---刷新按钮
function UIGuildSendRedPanelTemplate:RefreshBtn()
    self.mBtn_UIGridContainer.MaxCount = 1
    local go = self.mBtn_UIGridContainer.controlList[0].gameObject
    local lb = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    lb.text = "发放"
    CS.UIEventListener.Get(go).onClick = function(go)
        self:OnSendBtnClicked(go)
    end

end

---发送
function UIGuildSendRedPanelTemplate:OnSendBtnClicked(go)
    if self.mBagItemInfo then
        networkRequest.ReqUnionSendRedBag(self.mBagItemInfo.lid, self.mFinalSendMoney, self.mFinalSendMember)
        self:ClosePanel()
    end
end

---确认总数输入
function UIGuildSendRedPanelTemplate:OnMoneyInputSubmit()
    local num = tonumber(self.mMoneyInput_UIInput.value)
    if num then
        self:SetMoneyNum(num)
    else
        self:SetMoneyNum(self.mFinalSendTotalNum)
    end
end

---设置输入数目
function UIGuildSendRedPanelTemplate:SetMoneyNum(num)
    if num == nil then
        return
    end

    if num < self.mFinalSendMember then
        num = self.mFinalSendMember
    end

    local finalNum = num

    if num >= self.mMaxSendMoney then
        finalNum = self.mMaxSendMoney
    elseif num <= self.mMinSendMember then
        finalNum = self.mMinSendMember
    end
    local color = (self.mCanChangeMoneyNum and self.mMaxSendMoney ~= self.mMinSendMember) and self.colorYellow or self.colorGray
    self.mMoneyInput_UIInput.value = finalNum
    self.mMoneyInput_UILabel.color = color
    self.mFinalSendMoney = finalNum
end

---确认数目输入
function UIGuildSendRedPanelTemplate:OnMemberInputSubmit()
    local num = tonumber(self.mMemberInput_UIInput.value)
    if num then
        self:SetMemberNum(num)
    else
        self:SetMemberNum(self.mFinalSendMember)
    end
end

---设置输入人数
function UIGuildSendRedPanelTemplate:SetMemberNum(num)
    local finalNum = num
    if num >= self.mMaxSendMember then
        finalNum = self.mMaxSendMember
    elseif num <= self.mMinSendMember then
        finalNum = self.mMinSendMember
    end

    if finalNum > self.mFinalSendMoney then
        self:SetMoneyNum(finalNum)
    end
    self.mMemberInput_UIInput.value = finalNum
    self.mMemberInput_UILabel.color = self.colorYellow

    self.mFinalSendMember = finalNum
end

---关闭界面
function UIGuildSendRedPanelTemplate:ClosePanel()
    uimanager:ClosePanel("UIGuildSendRedPackPanel")
end

return UIGuildSendRedPanelTemplate