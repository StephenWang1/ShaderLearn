---a@class UIActivityRankUnitTemplate 活动排行榜单元模板
local UIActivityRankUnitTemplate = {}

--region 组件
---@type Top_UISprite 排行图片
function UIActivityRankUnitTemplate:GetRankingSprite()
    if self.rankingSprite == nil and self.CloneManager ~= nil then
        self.rankingSprite = self.CloneManager:GetComponent("Total/rankingSprite", "Top_UISprite", "rankSprite", self.total)
    end
    return self.rankingSprite
end

---@type Top_UILabel 玩家排行
function UIActivityRankUnitTemplate:GetRankingValue()
    if self.rankingValue == nil and self.CloneManager ~= nil then
        self.rankingValue = self.CloneManager:GetComponent("Total/rankingValue", "Top_UILabel", "label", self.total)
    end
    return self.rankingValue
end

---@type Top_UILabel 玩家名称
function UIActivityRankUnitTemplate:GetRankPlayerName()
    if self.rankName == nil and self.CloneManager ~= nil then
        self.rankName = self.CloneManager:GetComponent("Total/name", "Top_UILabel", "label", self.total)
    end
    return self.rankName
end

---@type Top_UILabel
function UIActivityRankUnitTemplate:GetFirstValue()
    if self.mFirstValue == nil and self.CloneManager ~= nil then
        self.mFirstValue = self.CloneManager:GetComponent("Total/firstValue", "Top_UILabel", "label", self.total)
    end
    return self.mFirstValue
end

---@type Top_UILabel
function UIActivityRankUnitTemplate:GetSecondValue()
    if self.mSecondValue == nil and self.CloneManager ~= nil then
        self.mSecondValue = self.CloneManager:GetComponent("Total/secondValue", "Top_UILabel", "label", self.total)
    end
    return self.mSecondValue
end

---@type Top_UILabel
function UIActivityRankUnitTemplate:GetThirdValue()
    if self.mThirdValue == nil and self.CloneManager ~= nil then
        self.mThirdValue = self.CloneManager:GetComponent("Total/thirdValue", "Top_UILabel", "label", self.total)
    end
    return self.mThirdValue
end

---@type Top_UILabel
function UIActivityRankUnitTemplate:GetFourthValue()
    if self.mFourthValue == nil and self.CloneManager ~= nil then
        self.mFourthValue = self.CloneManager:GetComponent("Total/fourthValue", "Top_UILabel", "label", self.total)
    end
    return self.mFourthValue
end

---@type Top_UILabel
function UIActivityRankUnitTemplate:GetFifthValue()
    if self.mFifthValue == nil and self.CloneManager ~= nil then
        self.mFifthValue = self.CloneManager:GetComponent("Total/fifthValue", "Top_UILabel", "label", self.total)
    end
    return self.mFifthValue
end

---@type Top_UISprite  点赞
function UIActivityRankUnitTemplate:GetLikeSprite()
    if self.mLikeSprite == nil and self.CloneManager ~= nil then
        self.mLikeSprite = self.CloneManager:GetComponent("Total/like", "Top_UISprite", "like", self.total)
    end
    return self.mLikeSprite
end

---@type TweenPosition  点赞tween
function UIActivityRankUnitTemplate:GetLikeTween()
    if self.mLikeTween == nil and self.CloneManager ~= nil then
        self.mLikeTween = self.CloneManager:GetComponent("Total/like", "TweenPosition", "like", self.total)
    end
    return self.mLikeTween
end

---@type Top_UILabel  点赞数量
function UIActivityRankUnitTemplate:GetLikeNum()
    if self.mLikeNum == nil and self.CloneManager ~= nil then
        self.mLikeNum = self.CloneManager:GetComponent("Total/like/num", "Top_UILabel", "like", self.total, "like")
    end
    return self.mLikeNum
end

---@type Top_UISprite  mvp
function UIActivityRankUnitTemplate:GetMvpSprite()
    if self.mMvpSprite == nil and self.CloneManager ~= nil then
        self.mMvpSprite = self.CloneManager:GetComponent("Total/mvp", "Top_UISprite", "mvp", self.total)
    end
    return self.mMvpSprite
end

---@type Top_UISprite  mvpBg
function UIActivityRankUnitTemplate:GetMvpBgSprite()
    if self.mMvpBgSprite == nil and self.CloneManager ~= nil then
        self.mMvpBgSprite = self.CloneManager:GetComponent("Total/mvp/bg", "Top_UISprite", "mvp", self.total, "mvp")
    end
    return self.mMvpBgSprite
end

---@type TweenPosition  mvpTween
function UIActivityRankUnitTemplate:GetMvpTween()
    if self.mMvpTween == nil and self.CloneManager ~= nil then
        self.mMvpTween = self.CloneManager:GetComponent("Total/mvp", "TweenPosition", "mvp", self.total)
    end
    return self.mMvpTween
end

---@type Top_UILabel  评分
function UIActivityRankUnitTemplate:GetMvpNum()
    if self.mMvpNum == nil and self.CloneManager ~= nil then
        self.mMvpNum = self.CloneManager:GetComponent("Total/mvp/num", "Top_UILabel", "mvp", self.total, "mvp")
    end
    return self.mMvpNum
end

---@type Top_UIGridContainer  战损
function UIActivityRankUnitTemplate:GetBattleDamageGrid()
    if self.mBattleDamageGrid == nil and self.CloneManager ~= nil then
        self.mBattleDamageGrid = self.CloneManager:GetComponent("Total/battleDamage", "Top_UIGridContainer", "battleDamage", self.total)
    end
    return self.mBattleDamageGrid
end

---@type Top_UIGridContainer 物品列表
function UIActivityRankUnitTemplate:GetItemGrid()
    if self.itemGrid == nil and self.CloneManager ~= nil then
        self.itemGrid = self.CloneManager:GetComponent("Total/ItemGrid", "Top_UIGridContainer", "ItemGrid", self.total)
    end
    return self.itemGrid
end

---@type UnityEngine.GameObject  战损按钮
function UIActivityRankUnitTemplate:GetBattleDamageBtn()
    if self.mBattleDamageBtn == nil and self.CloneManager ~= nil then
        self.mBattleDamageBtn = self.CloneManager:GetComponent("Total/battleDamageBtn", "GameObject", "battleDamageBtn", self.total)
    end
    return self.mBattleDamageBtn
end

---@type Top_UILabel 人物击杀数
function UIActivityRankUnitTemplate:GetRankPlayerKill()
    if self.Playerkill == nil and self.CloneManager ~= nil then
        self.Playerkill = self.CloneManager:GetComponent("Total/Playerkill", "Top_UILabel", "label", self.total)
    end
    return self.Playerkill
end

---@type Top_UILabel 镖车押送距离
function UIActivityRankUnitTemplate:GetDartCarDistance()
    if self.DartCarDistance == nil and self.CloneManager ~= nil then
        self.DartCarDistance = self.CloneManager:GetComponent("Total/DartCarDistance", "Top_UILabel", "label", self.total)
    end
    return self.DartCarDistance
end

---@type Top_UILabel 人物死亡数
function UIActivityRankUnitTemplate:GetRankPlayerDead()
    if self.RankPlayerDead == nil and self.CloneManager ~= nil then
        self.RankPlayerDead = self.CloneManager:GetComponent("Total/RankPlayerDead", "Top_UILabel", "label", self.total)
    end
    return self.RankPlayerDead
end

---@type Top_UILabel 赔率
function UIActivityRankUnitTemplate:GetRankBetRate()
    if self.BetRate == nil and self.CloneManager ~= nil then
        self.BetRate = self.CloneManager:GetComponent("Total/BetRate", "Top_UILabel", "label", self.total)
    end
    return self.BetRate
end

---@type Top_UILabel 押注金额
function UIActivityRankUnitTemplate:GetRankBetAmount()
    if self.BetAmount == nil and self.CloneManager ~= nil then
        self.BetAmount = self.CloneManager:GetComponent("Total/BetAmount", "Top_UILabel", "label", self.total)
    end
    return self.BetAmount
end
--endregion

--region 初始化

function UIActivityRankUnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
    self:BindNetMessage()
end
--初始化变量
function UIActivityRankUnitTemplate:InitParameters()
    self.settleInfo = nil
end

function UIActivityRankUnitTemplate:InitComponents()
    self.total = self:Get('Total', 'GameObject')
    ---@type Top_DynamicCloneManager
    self.CloneManager = CS.Utility_Lua.GetComponent(self.go, "Top_DynamicCloneManager")
    self.bg = self:Get('Background', 'Top_UISprite')
    self.MyBackground = self:Get('MyBackground', 'GameObject')

    self.titleBg = self:Get('Mvp/bg', 'Top_UISprite')
    self.zhanSun = self:Get('zhanSun', 'Top_UIGridContainer')

end

function UIActivityRankUnitTemplate:BindUIMessage()
    --CS.UIEventListener.Get(self.likeSprite.gameObject).LuaEventTable = self
    --CS.UIEventListener.Get(self.likeSprite.gameObject).OnClickLuaDelegate = self.OnLikeBtnClick
    if self.go ~= nil then
        CS.UIEventListener.Get(self.go.gameObject).LuaEventTable = self
        CS.UIEventListener.Get(self.go.gameObject).OnClickLuaDelegate = self.OnIconBtnClick
    end
end

function UIActivityRankUnitTemplate:BindNetMessage()

end

--endregion

--region Show
---@param data customData
---@alias customData{settleInfo:IActivitySettleVO,feature:tabel,leaderboardID:number,Line:number,isLeft:boolean,icons:string,curFeatureType:number}
function UIActivityRankUnitTemplate:SetTemplate(customData)
    if customData then
        self.settleInfo = customData.settleInfo
        self.leaderboardID = customData.leaderboardID
        self.Line = customData.Line
        self.featureClass = customData.feature:New()
        self.isLeft = customData.isLeft
        if customData.icons then
            self.icons = string.Split(customData.icons, '#')
        end
        self.curFeatureType = customData.curFeatureType
        if self.settleInfo ~= nil then
            self.featureClass:Show(self)
        end
        if self.unitTabel ~= nil then
            self.unitTabel:Reposition()
        end
    end
end

function UIActivityRankUnitTemplate:RefreshTemplate()
    if self.settleInfo ~= nil and self.featureClass ~= nil then
        self.featureClass:Show(self)
    end
end

function UIActivityRankUnitTemplate:RefreshLikeInfo(settleInfo)
    self.settleInfo = settleInfo
    if self.featureClass ~= nil then
        self.featureClass:RefreshLike(self)
    end
end

--endregion


--region UI函数监听

function UIActivityRankUnitTemplate:OnLikeBtnClick(go)
    if self.featureClass ~= nil then
        self.featureClass:OnLikeBtnClick(self, go)
    end

end

function UIActivityRankUnitTemplate:OnIconBtnClick()
    if self.featureClass ~= nil then
        self.featureClass:OnDetailsBtnClick()
    end
end

--endregion


--region otherFunction

--endregion

--region ondestroy

function UIActivityRankUnitTemplate:Clear()
    if self.featureClass ~= nil then
        self.featureClass:OnDestruct()
    end
end

function UIActivityRankUnitTemplate:onDestroy()
    self:Clear()
end

--endregion

return UIActivityRankUnitTemplate