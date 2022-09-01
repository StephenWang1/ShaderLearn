---@class UICarnivalPanel_ShopTemplate:TemplateBase
local UICarnivalPanel_ShopTemplate = {}

---@return UILabel 兑换次数
function UICarnivalPanel_ShopTemplate:GetChangeTime_UILabel()
    if self.mChangeTime == nil then
        self.mChangeTime = self:Get("time", "UILabel")
    end
    return self.mChangeTime
end

---@return UILabel 奖励名字
function UICarnivalPanel_ShopTemplate:GetRewardName_UILabel()
    if self.mRewardName == nil then
        self.mRewardName = self:Get("RewardItem/description", "UILabel")
    end
    return self.mRewardName
end

---@return UISprite 奖励图片
function UICarnivalPanel_ShopTemplate:GetRewardIcon_UISprite()
    if self.mRewardIcon == nil then
        self.mRewardIcon = self:Get("RewardItem/icon", "UISprite")
    end
    return self.mRewardIcon
end

---@return UISprite 花费图片
function UICarnivalPanel_ShopTemplate:GetCostSp_UISprite()
    if self.mCostSp == nil then
        self.mCostSp = self:Get("RewardItem/cost", "UISprite")
    end
    return self.mCostSp
end

---@return UILabel 花费数目
function UICarnivalPanel_ShopTemplate:GetCostNum_UILabel()
    if self.mCostNum == nil then
        self.mCostNum = self:Get("RewardItem/count", "UILabel")
    end
    return self.mCostNum
end

---@return UnityEngine.GameObject 奖励按钮
function UICarnivalPanel_ShopTemplate:GetRewardBtn_Go()
    if self.mRewardBtn == nil then
        self.mRewardBtn = self:Get("btn_get", "GameObject")
    end
    return self.mRewardBtn
end

---@return UILabel 按钮文本
function UICarnivalPanel_ShopTemplate:GetRewardBtn_Lb()
    if self.mRewardBtnLb == nil then
        self.mRewardBtnLb = self:Get("btn_get/Label", "UILabel")
    end
    return self.mRewardBtnLb
end

---@return UISprite 按钮背景
function UICarnivalPanel_ShopTemplate:GetRewardBtn_UISprite()
    if self.mRewardBtnSprite == nil then
        self.mRewardBtnSprite = self:Get("btn_get", "UISprite")
    end
    return self.mRewardBtnSprite
end

---@return UnityEngine.GameObject 奖励特效
function UICarnivalPanel_ShopTemplate:GetRewardBtnEffect_Go()
    if self.mRewardBtnEffect == nil then
        self.mRewardBtnEffect = self:Get("btn_get/effect", "GameObject")
    end
    return self.mRewardBtnEffect
end

function UICarnivalPanel_ShopTemplate:Init()
    self:BindEvents()
end

function UICarnivalPanel_ShopTemplate:BindEvents()
    CS.UIEventListener.Get(self:GetRewardBtn_Go()).onClick = function(go)
        self:OnRewardBtnClicked(go)
    end
end

function UICarnivalPanel_ShopTemplate:RefreshShop()
    self:GetChangeTime_UILabel().text = luaEnumColorType.Gray .. "可兑换[-]" .. luaEnumColorType.Green .. "3" .. luaEnumColorType.Gray .. "次[-]"
    self:GetRewardName_UILabel().text = "奖励名字七个字"
    self:GetRewardIcon_UISprite().spriteName = "1000026"
    self:GetCostSp_UISprite().spriteName = "1000002"
    self:GetCostNum_UILabel().text = "9999"
    self:GetRewardBtn_Lb().text = "快速领取"
    self:GetRewardBtn_UISprite().spriteName = "anniu13"
    self:GetRewardBtnEffect_Go():SetActive(true)
end

function UICarnivalPanel_ShopTemplate:OnRewardBtnClicked(go)

end

return UICarnivalPanel_ShopTemplate