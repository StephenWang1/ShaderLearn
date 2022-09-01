---@class UIPersonSendDiamondRedPackTemplate:UIGuildSendRedPanelTemplate 个人发放钻石红包
local UIPersonSendDiamondRedPackTemplate = {}

setmetatable(UIPersonSendDiamondRedPackTemplate, luaComponentTemplates.UIGuildSendRedPanelTemplate)

function UIPersonSendDiamondRedPackTemplate:Init(customData)
    self:InitComponent()
    if customData then
        self.mData = customData
        self:GetMoneyInputGoldName_UILabel().text = "钻石"

        ---@type number 需要发放人数
        self.mFinalSendMember = 0
        ---@type number 需要发放数目
        self.mFinalSendMoney = 0

        ---默认发放人数
        self.mNormalMemberNum = LuaGlobalTableDeal:GetPersonalRedPackMinNum()
        ---@type number  最大发放成员数
        self.mMaxSendMember = 0
        if self:GetUnionInfoV2() then
            local maxMemeber = self:GetUnionInfoV2().UnionMember.Count
            self.mMaxSendMember = maxMemeber
            self.mMinSendMember = math.min(self.mNormalMemberNum, maxMemeber)
        end
        if self.mMinSendMember == nil then
            self.mMinSendMember = self.mMaxSendMember
        end
        if self.mMaxSendMember < self.mMinSendMember then
            self.mMaxSendMember = self.mMinSendMember
        end

        ---@type number 最大发放数目
        self.mMaxSendMoney = LuaGlobalTableDeal:GetPersonalRedPackMaxDiamondNum()

        self:RefreshSendRedPack(customData)
        self:RefreshBtn()
        self:BindEvents()
    end
end

---刷新红包显示
function UIPersonSendDiamondRedPackTemplate:RefreshSendRedPack(customData)
    if customData == nil then
        return
    end
    self:SetMoneyNum(self.mMaxSendMoney)
    self:GetMoneyInputBg_Go():SetActive(true)
    self:SetMemberNum(self.mMinSendMember)
end

function UIPersonSendDiamondRedPackTemplate:SetMoneyNum(num)
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

    self.mMoneyInput_UIInput.value = finalNum
    self.mFinalSendMoney = finalNum
    self:RefreshLbColor()
end

---刷新货币颜色
function UIPersonSendDiamondRedPackTemplate:RefreshLbColor()
    local playerHas = Utility.GetAuctionDiamondNum()
    local color = playerHas >= self.mFinalSendMoney and self.colorYellow or self.colorRed
    self.mMoneyInput_UILabel.color = color
end

---发送FFCB3D
function UIPersonSendDiamondRedPackTemplate:OnSendBtnClicked(go)
    local playerHas = Utility.GetAuctionDiamondNum()
    local enough = playerHas >= self.mFinalSendMoney
    if not enough then
        Utility.ShowPopoTips(go, nil, 489)
        return
    end

    networkRequest.ReqUnionSendRedBag(0, self.mFinalSendMoney, self.mFinalSendMember, 1)
    self:ClosePanel()
end

return UIPersonSendDiamondRedPackTemplate