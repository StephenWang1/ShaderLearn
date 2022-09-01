---灵兽装备格子模板
---@class UISelf_Rein:UIServantBasicPanel
local UIself_Rein = {}

setmetatable(UIself_Rein, luaComponentTemplates.UIServantBasicPanel)

local ReinErrorCode = {
    ---没有异常可升级
    NON = 0,
    ---没有灵兽
    NotHasServant = 5,
    ---等级不足
    ServantLevelNotEnough = 6,
    ---灵力不足
    LingLiNotEnough = 10,
    ---神石不足
    ShenShiNotEnough = 15,
    ---已经满级
    MAX = 20
}

UIself_Rein.self = nil;

UIself_Rein.isLoadBtnEffect = false;
--region 局部变量
UIself_Rein.ReinItemTopPos = CS.UnityEngine.Vector3(-104, -130, 0)
UIself_Rein.ReinItemBottomPos = CS.UnityEngine.Vector3(-104, -172, 0)
UIself_Rein.GrowLevelTopPos = CS.UnityEngine.Vector3(-350, -95, 0)
UIself_Rein.GrowLevelBottomPos = CS.UnityEngine.Vector3(-350, -135, 0)
UIself_Rein.attributeTopPos = CS.UnityEngine.Vector3(5, -15, 0)
UIself_Rein.attributeBottomPos = CS.UnityEngine.Vector3(5, -55, 0)
UIself_Rein.mGreenColor = CS.UnityEngine.Color(0.035, 1, 0)
UIself_Rein.UPArrowTopPos = CS.UnityEngine.Vector3(-118, 65, 0)
UIself_Rein.UPArrowBottomPos = CS.UnityEngine.Vector3(-118, 25, 0)
UIself_Rein.DownArrowTopPos = CS.UnityEngine.Vector3(-118, -85, 0)
UIself_Rein.DownArrowBottomPos = CS.UnityEngine.Vector3(-118, -125, 0)
UIself_Rein.ShowattributeCount = 0
UIself_Rein.maxRein = false
--endregion

--region 属性
--region 转生道具
function UIself_Rein:GetReinItem_GameObject()
    if (self.mReinItem == nil) then
        self.mReinItem = self:Get("view/shenshi", "GameObject")
    end
    return self.mReinItem
end

---@return UnityEngine.GameObject
function UIself_Rein:GetReinLingli_GameObject()
    if (self.mReinLingli == nil) then
        self.mReinLingli = self:Get("view/lingli", "GameObject")
    end
    return self.mReinLingli
end

function UIself_Rein:GetReinNeedLevel_Label()
    if (self.mReinNeedLevel == nil) then
        self.mReinNeedLevel = self:Get("view/needlevel", "UILabel")
    end
    return self.mReinNeedLevel
end

---@return UnityEngine.GameObject 灵力描述文本
function UIself_Rein:GetGrowLevel_GameObject()
    if (self.mgrowlevel == nil) then
        self.mgrowlevel = self:Get("view/growlevel", "GameObject")
    end
    return self.mgrowlevel
end

function UIself_Rein:Getattribute_GameObject()
    if (self.mattribute == nil) then
        self.mattribute = self:Get("view/attribute", "GameObject")
    end
    return self.mattribute
end

function UIself_Rein:GetReinNeedExp_UILabel()
    if (self.mReinNeedExp == nil) then
        self.mReinNeedExp = self:Get("view/lingli/value", "UILabel")
    end
    return self.mReinNeedExp
end

function UIself_Rein:GetLingLiName_UILabel()
    if self.mLingLiLabel == nil then
        self.mLingLiLabel = self:Get("view/lingli/name", "UILabel")
    end
    return self.mLingLiLabel
end

function UIself_Rein:GetReinNeedItem_UILabel()
    if (self.mReinNeedItem == nil) then
        self.mReinNeedItem = self:Get("view/shenshi/value", "UILabel")
    end
    return self.mReinNeedItem
end

function UIself_Rein:GetTurnGrowDescribe_UILabel()
    if self.mTurnGrowBtnDescribe_UILabel == nil then
        self.mTurnGrowBtnDescribe_UILabel = self:Get("events/btn_rein/Label", "Top_UILabel")
    end
    return self.mTurnGrowBtnDescribe_UILabel
end

function UIself_Rein:GetLevelUpDescribe_Label()
    if self.mLevelUpDescribe_Label == nil then
        self.mLevelUpDescribe_Label = self:Get("view/attribute/Label", "Top_UILabel")
    end
    return self.mLevelUpDescribe_Label
end

---升级条件label
function UIself_Rein:GetLevelUpCondition_Label()
    if self.mLevelUpCondition_Label == nil then
        self.mLevelUpCondition_Label = self:Get("view/growlevel", "UILabel")
    end
    return self.mLevelUpCondition_Label
end

function UIself_Rein:GetTurnBallGroup_GameObject()
    if (self.mTurnBallGroup == nil) then
        self.mTurnBallGroup = self:Get("view/reinLevel/ball", "GameObject")
    end
    return self.mTurnBallGroup
end
--endregion

--region 转生属性及特效
function UIself_Rein:GetReinPanelFirstAttributeCur_UILabel()
    if (self.mReinPanelAttack == nil) then
        self.mReinPanelAttack = self:Get("view/attribute/Scroll View/arributelist/arribute01/curarribute/gongji", "UILabel")
    end
    return self.mReinPanelAttack
end

function UIself_Rein:GetReinPanelSecondAttributeCur_UILabel()
    if (self.mReinPanelDefence == nil) then
        self.mReinPanelDefence = self:Get("view/attribute/Scroll View/arributelist/arribute11/curarribute/gongji", "UILabel")
    end
    return self.mReinPanelDefence
end

function UIself_Rein:GetReinPanelThirdAttributeCur_UILabel()
    if (self.mReinPanelMDefence == nil) then
        self.mReinPanelMDefence = self:Get("view/attribute/Scroll View/arributelist/arribute21/curarribute/gongji", "UILabel")
    end
    return self.mReinPanelMDefence
end

function UIself_Rein:GetReinPanelFourthAttributeCur_UILabel()
    if (self.mReinPanelHolyAttack == nil) then
        self.mReinPanelHolyAttack = self:Get("view/attribute/Scroll View/arributelist/arribute31/curarribute/gongji", "UILabel")
    end
    return self.mReinPanelHolyAttack
end

function UIself_Rein:GetReinPanelFifthAttributeCur_UILabel()
    if (self.mReinPanelAccurate == nil) then
        self.mReinPanelAccurate = self:Get("view/attribute/Scroll View/arributelist/arribute41/curarribute/gongji", "UILabel")
    end
    return self.mReinPanelAccurate
end

function UIself_Rein:GetReinPanelSixthAttributeCur_UILabel()
    if (self.mReinPanelDodge == nil) then
        self.mReinPanelDodge = self:Get("view/attribute/Scroll View/arributelist/arribute51/curarribute/gongji", "UILabel")
    end
    return self.mReinPanelDodge
end

function UIself_Rein:GetReinPanelFirstAttributeNext_UILabel()
    if (self.mReinPanelNextAttack == nil) then
        self.mReinPanelNextAttack = self:Get("view/attribute/Scroll View/arributelist/arribute01/nextarribute/gongji", "UILabel")
    end
    return self.mReinPanelNextAttack
end

function UIself_Rein:GetReinPanelSecondAttributeNextArrow_UISprite()
    if (self.mReinPanelNextAttackArrow == nil) then
        self.mReinPanelNextAttackArrow = self:Get("view/attribute/Scroll View/arributelist/arribute11/nextarribute/arrow", "UISprite")
    end
    return self.mReinPanelNextAttackArrow
end

function UIself_Rein:GetReinPanelSecondAttributeNextEffect_UILabel()
    if (self.mReinPanelNextAttackValueEffect == nil) then
        self.mReinPanelNextAttackValueEffect = self:Get("view/attribute/Scroll View/arributelist/arribute11/nextarribute/valueEffect", "UILabel")
    end
    return self.mReinPanelNextAttackValueEffect
end

function UIself_Rein:GetReinPanelSecondAttributeNextEffect_TweenAlpha()
    if (self.mReinPanelNextAttackEffectTweenAlpha == nil) then
        self.mReinPanelNextAttackEffectTweenAlpha = self:Get("view/attribute/Scroll View/arributelist/arribute11/nextarribute/valueEffect", "TweenAlpha")
    end
    return self.mReinPanelNextAttackEffectTweenAlpha
end

function UIself_Rein:GetReinPanelSecondAttributeNext_UILabel()
    if (self.mReinPanelNextDefence == nil) then
        self.mReinPanelNextDefence = self:Get("view/attribute/Scroll View/arributelist/arribute11/nextarribute/gongji", "UILabel")
    end
    return self.mReinPanelNextDefence
end

function UIself_Rein:GetReinPanelThirdAttributeNextArrow_UISprite()
    if (self.mReinPanelNextDefenceArrow == nil) then
        self.mReinPanelNextDefenceArrow = self:Get("view/attribute/Scroll View/arributelist/arribute21/nextarribute/arrow", "UISprite")
    end
    return self.mReinPanelNextDefenceArrow
end

function UIself_Rein:GetReinPanelThirdAttributeNextEffect_UILabel()
    if (self.mReinPanelNextDefenceValueEffect == nil) then
        self.mReinPanelNextDefenceValueEffect = self:Get("view/attribute/Scroll View/arributelist/arribute21/nextarribute/valueEffect", "UILabel")
    end
    return self.mReinPanelNextDefenceValueEffect
end

function UIself_Rein:GetReinPanelThirdAttributeNextEffect_TweenAlpha()
    if (self.mReinPanelNextDefenceEffectTweenAlpha == nil) then
        self.mReinPanelNextDefenceEffectTweenAlpha = self:Get("view/attribute/Scroll View/arributelist/arribute21/nextarribute/valueEffect", "TweenAlpha")
    end
    return self.mReinPanelNextDefenceEffectTweenAlpha
end

function UIself_Rein:GetReinPanelThirdAttributeNext_UILabel()
    if (self.mReinPanelNextMDefence == nil) then
        self.mReinPanelNextMDefence = self:Get("view/attribute/Scroll View/arributelist/arribute21/nextarribute/gongji", "UILabel")
    end
    return self.mReinPanelNextMDefence
end

function UIself_Rein:GetReinPanelFourthAttributeNextArrow_UISprite()
    if (self.mReinPanelNextMDefenceArrow == nil) then
        self.mReinPanelNextMDefenceArrow = self:Get("view/attribute/Scroll View/arributelist/arribute31/nextarribute/arrow", "UISprite")
    end
    return self.mReinPanelNextMDefenceArrow
end

function UIself_Rein:GetReinPanelFourthAttributeNextEffect_UILabel()
    if (self.mReinPanelNextMDefenceValueEffect == nil) then
        self.mReinPanelNextMDefenceValueEffect = self:Get("view/attribute/Scroll View/arributelist/arribute31/nextarribute/valueEffect", "UILabel")
    end
    return self.mReinPanelNextMDefenceValueEffect
end

function UIself_Rein:GetReinPanelFourthAttributeNextEffect_TweenAlpha()
    if (self.mReinPanelNextMDefenceEffectTweenAlpha == nil) then
        self.mReinPanelNextMDefenceEffectTweenAlpha = self:Get("view/attribute/Scroll View/arributelist/arribute31/nextarribute/valueEffect", "TweenAlpha")
    end
    return self.mReinPanelNextMDefenceEffectTweenAlpha
end

function UIself_Rein:GetReinPanelFourthAttributeNext_UILabel()
    if (self.mReinPanelNextHolyAttack == nil) then
        self.mReinPanelNextHolyAttack = self:Get("view/attribute/Scroll View/arributelist/arribute31/nextarribute/gongji", "UILabel")
    end
    return self.mReinPanelNextHolyAttack
end

function UIself_Rein:GetReinPanelFifthAttributeNextArrow_UISprite()
    if (self.mReinPanelNextHolyAttackArrow == nil) then
        self.mReinPanelNextHolyAttackArrow = self:Get("view/attribute/Scroll View/arributelist/arribute41/nextarribute/arrow", "UISprite")
    end
    return self.mReinPanelNextHolyAttackArrow
end

function UIself_Rein:GetReinPanelFifthAttributeNextEffect_UILabel()
    if (self.mReinPanelNextHolyAttackValueEffect == nil) then
        self.mReinPanelNextHolyAttackValueEffect = self:Get("view/attribute/Scroll View/arributelist/arribute41/nextarribute/valueEffect", "UILabel")
    end
    return self.mReinPanelNextHolyAttackValueEffect
end

function UIself_Rein:GetReinPanelFifthAttributeNextEffect_TweenAlpha()
    if (self.mReinPanelNextHolyAttackEffectTweenAlpha == nil) then
        self.mReinPanelNextHolyAttackEffectTweenAlpha = self:Get("view/attribute/Scroll View/arributelist/arribute41/nextarribute/valueEffect", "TweenAlpha")
    end
    return self.mReinPanelNextHolyAttackEffectTweenAlpha
end

function UIself_Rein:GetReinPanelFifthAttributeNext_UILabel()
    if (self.mReinPanelNextHP == nil) then
        self.mReinPanelNextHP = self:Get("view/attribute/Scroll View/arributelist/arribute41/nextarribute/gongji", "UILabel")
    end
    return self.mReinPanelNextHP
end

function UIself_Rein:GetReinPanelFirstAttributeNextArrow_UISprite()
    if (self.mReinPanelNextHPArrow == nil) then
        self.mReinPanelNextHPArrow = self:Get("view/attribute/Scroll View/arributelist/arribute01/nextarribute/arrow", "UISprite")
    end
    return self.mReinPanelNextHPArrow
end

function UIself_Rein:GetReinPanelFirstAttributeNextEffect_UILabel()
    if (self.mReinPanelNextHPValueEffect == nil) then
        self.mReinPanelNextHPValueEffect = self:Get("view/attribute/Scroll View/arributelist/arribute01/nextarribute/valueEffect", "UILabel")
    end
    return self.mReinPanelNextHPValueEffect
end

function UIself_Rein:GetReinPanelFirstAttributeNextEffect_TweenAlpha()
    if (self.mReinPanelNextHPEffectTweenAlpha == nil) then
        self.mReinPanelNextHPEffectTweenAlpha = self:Get("view/attribute/Scroll View/arributelist/arribute01/nextarribute/valueEffect", "TweenAlpha")
    end
    return self.mReinPanelNextHPEffectTweenAlpha
end

function UIself_Rein:GetReinPanelSixthAttributeNext_UILabel()
    if (self.mReinPanelNextHolyDefence == nil) then
        self.mReinPanelNextHolyDefence = self:Get("view/attribute/Scroll View/arributelist/arribute51/nextarribute/gongji", "UILabel")
    end
    return self.mReinPanelNextHolyDefence
end

function UIself_Rein:GetReinPanelSixthAttributeNextArrow_UISprite()
    if (self.mReinPanelNextHolyDefenceArrow == nil) then
        self.mReinPanelNextHolyDefenceArrow = self:Get("view/attribute/Scroll View/arributelist/arribute51/nextarribute/arrow", "UISprite")
    end
    return self.mReinPanelNextHolyDefenceArrow
end

function UIself_Rein:GetReinPanelSixthAttributeNextEffect_UILabel()
    if (self.mReinPanelNextHolyDefenceValueEffect == nil) then
        self.mReinPanelNextHolyDefenceValueEffect = self:Get("view/attribute/Scroll View/arributelist/arribute51/nextarribute/valueEffect", "UILabel")
    end
    return self.mReinPanelNextHolyDefenceValueEffect
end

function UIself_Rein:GetReinPanelSixthAttributeNextEffect_TweenAlpha()
    if (self.mReinPanelNextHolyDefenceEffectTweenAlpha == nil) then
        self.mReinPanelNextHolyDefenceEffectTweenAlpha = self:Get("view/attribute/Scroll View/arributelist/arribute51/nextarribute/valueEffect", "TweenAlpha")
    end
    return self.mReinPanelNextHolyDefenceEffectTweenAlpha
end

function UIself_Rein:GetReinPanelLevelEffect_UILabel()
    if (self.mReinPanelLevelValueEffect == nil) then
        self.mReinPanelLevelValueEffect = self:Get("view/reinLevel/valueEffect", "UILabel")
    end
    return self.mReinPanelLevelValueEffect
end

function UIself_Rein:GetReinPanelLevelEffect_TweenAlpha()
    if (self.mReinPanelLevelEffectTweenAlpha == nil) then
        self.mReinPanelLevelEffectTweenAlpha = self:Get("view/reinLevel/valueEffect", "TweenAlpha")
    end
    return self.mReinPanelLevelEffectTweenAlpha
end

function UIself_Rein:GetReinPanelHP_Transform()
    if (self.mReinPanelHPTransform == nil) then
        self.mReinPanelHPTransform = self:Get("view/attribute/Scroll View/arributelist/arribute01", "Transform")
    end
    return self.mReinPanelHPTransform
end

function UIself_Rein:GetReinPanelAttack_Transform()
    if (self.mReinPanelAttackTransform == nil) then
        self.mReinPanelAttackTransform = self:Get("view/attribute/Scroll View/arributelist/arribute11", "Transform")
    end
    return self.mReinPanelAttackTransform
end

function UIself_Rein:GetReinPanelDefence_Transform()
    if (self.mReinPanelDefenceTransform == nil) then
        self.mReinPanelDefenceTransform = self:Get("view/attribute/Scroll View/arributelist/arribute21", "Transform")
    end
    return self.mReinPanelDefenceTransform
end

function UIself_Rein:GetReinPanelMDefence_Transform()
    if (self.mReinPanelMDefenceTransform == nil) then
        self.mReinPanelMDefenceTransform = self:Get("view/attribute/Scroll View/arributelist/arribute31", "Transform")
    end
    return self.mReinPanelMDefenceTransform
end

function UIself_Rein:GetReinPanelHA_Transform()
    if (self.mReinPanelHATransform == nil) then
        self.mReinPanelHATransform = self:Get("view/attribute/Scroll View/arributelist/arribute41", "Transform")
    end
    return self.mReinPanelHATransform
end

function UIself_Rein:GetReinPanelHD_Transform()
    if (self.mReinPanelHDTransform == nil) then
        self.mReinPanelHDTransform = self:Get("view/attribute/Scroll View/arributelist/arribute51", "Transform")
    end
    return self.mReinPanelHDTransform
end

function UIself_Rein:GetReinFirstTitle_UILabel()
    if (self.mReinPanelFirstTitle == nil) then
        self.mReinPanelFirstTitle = self:Get("view/attribute/Scroll View/arributelist/arribute01/curarribute/gongji/title", "UILabel")
    end
    return self.mReinPanelFirstTitle
end

function UIself_Rein:GetReinSecondTitle_UILabel()
    if (self.mReinPanelSecondTitle == nil) then
        self.mReinPanelSecondTitle = self:Get("view/attribute/Scroll View/arributelist/arribute11/curarribute/gongji/title", "UILabel")
    end
    return self.mReinPanelSecondTitle
end

function UIself_Rein:GetReinThirdTitle_UILabel()
    if (self.mReinPanelThirdTitle == nil) then
        self.mReinPanelThirdTitle = self:Get("view/attribute/Scroll View/arributelist/arribute21/curarribute/gongji/title", "UILabel")
    end
    return self.mReinPanelThirdTitle
end

function UIself_Rein:GetReinFourthTitle_UILabel()
    if (self.mReinPanelFourthTitle == nil) then
        self.mReinPanelFourthTitle = self:Get("view/attribute/Scroll View/arributelist/arribute31/curarribute/gongji/title", "UILabel")
    end
    return self.mReinPanelFourthTitle
end

function UIself_Rein:GetReinFifthTitle_UILabel()
    if (self.mReinPanelFifthTitle == nil) then
        self.mReinPanelFifthTitle = self:Get("view/attribute/Scroll View/arributelist/arribute41/curarribute/gongji/title", "UILabel")
    end
    return self.mReinPanelFifthTitle
end

function UIself_Rein:GetReinSixthTitle_UILabel()
    if (self.mReinPanelSixthTitle == nil) then
        self.mReinPanelSixthTitle = self:Get("view/attribute/Scroll View/arributelist/arribute51/curarribute/gongji/title", "UILabel")
    end
    return self.mReinPanelSixthTitle
end
--endregion

--region 按钮
---转生帮助界面
function UIself_Rein:GetReinHelp_GameObject()
    if self.mReinHelp == nil then
        self.mReinHelp = self:Get("btn_help", "GameObject")
    end
    return self.mReinHelp
end

function UIself_Rein:GetReinBtn_GameObject()
    if (self.mReinBtn == nil) then
        self.mReinBtn = self:Get("events/btn_rein", "GameObject")
    end
    return self.mReinBtn
end

function UIself_Rein:GetReinExpAddBtn_GameObject()
    if (self.mReinExpAddBtn == nil) then
        self.mReinExpAddBtn = self:Get("view/lingli/add", "GameObject")
    end
    return self.mReinExpAddBtn
end

function UIself_Rein:GetReinItemAddBtn_GameObject()
    if (self.mReinItemAddBtn == nil) then
        self.mReinItemAddBtn = self:Get("view/shenshi/add", "GameObject")
    end
    return self.mReinItemAddBtn
end

function UIself_Rein:GetReinGatherSoulBtn_GameObject()
    if (self.mReinGatherSoulBtn == nil) then
        self.mReinGatherSoulBtn = self:Get("events/btn_gether", "GameObject")
    end
    return self.mReinGatherSoulBtn
end
--endregion

--region Root
function UIself_Rein:GetReinUpEffectRoot_Transform()
    if (self.mReinUpEffectRoot == nil) then
        self.mReinUpEffectRoot = self:Get("view/reinLevel/di", "Transform")
    end
    return self.mReinUpEffectRoot
end

function UIself_Rein:GetEffectRoot_GameObject()
    if (self.mEffectRoot == nil) then
        self.mEffectRoot = self:Get("view/EffectRoot", "GameObject")
    end
    return self.mEffectRoot
end

function UIself_Rein:GetReinExpIcon_GameObject()
    if (self.mReinExpIcon == nil) then
        self.mReinExpIcon = self:Get("view/lingli/icon", "GameObject")
    end
    return self.mReinExpIcon
end

function UIself_Rein:GetReinShenshiIcon_GameObject()
    if (self.mReinShenshiIcon == nil) then
        self.mReinShenshiIcon = self:Get("view/shenshi/icon", "GameObject")
    end
    return self.mReinShenshiIcon
end

function UIself_Rein:GetReinShenshiIcon_UISprite()
    if (self.mReinShenshiIconSprite == nil) then
        self.mReinShenshiIconSprite = self:Get("view/shenshi/icon", "UISprite")
    end
    return self.mReinShenshiIconSprite
end

---神石名称
function UIself_Rein:GetShenShiName_UILabel()
    if (self.mReinShenshiNameUILabel == nil) then
        self.mReinShenshiNameUILabel = self:Get("view/shenshi/name", "UILabel")
    end
    return self.mReinShenshiNameUILabel
end

function UIself_Rein:GetReinMax_GameObject()
    if (self.mReinMax == nil) then
        self.mReinMax = self:Get("view/LevelMax", "GameObject")
    end
    return self.mReinMax
end
--endregion

--region View
function UIself_Rein:GetReinLevel_UILabel()
    if (self.mReinLevel == nil) then
        self.mReinLevel = self:Get("view/reinLevel/value", "Top_UILabel")
    end
    return self.mReinLevel
end

function UIself_Rein:GetReinPanelLevelEffect_UILabel()
    if (self.mReinPanelLevelValueEffect == nil) then
        self.mReinPanelLevelValueEffect = self:Get("view/reinLevel/valueEffect", "UILabel")
    end
    return self.mReinPanelLevelValueEffect
end

function UIself_Rein:GetReinEffectViewDi_GameObject()
    if (self.mGetReinEffectViewDi_GameObject == nil) then
        self.mGetReinEffectViewDi_GameObject = self:Get("view/reinLevel/di", "GameObject")
    end
    return self.mGetReinEffectViewDi_GameObject
end

function UIself_Rein:GetReinEffectView_GameObject()
    if (self.mReinEffectView == nil) then
        self.mReinEffectView = self:Get("view/reinLevel/Sprite", "GameObject")
    end
    return self.mReinEffectView
end

function UIself_Rein:GetUpArrow_GameObject()
    if (self.mUpArrow_GameObject == nil) then
        self.mUpArrow_GameObject = self:Get("view/UpArrow", "GameObject");
    end
    return self.mUpArrow_GameObject;
end

function UIself_Rein:GetUpArrow_TweenAlpha()
    if (self.mUpArrow_TweenAlpha == nil) then
        self.mUpArrow_TweenAlpha = self:Get("view/UpArrow", "Top_TweenAlpha");
    end
    return self.mUpArrow_TweenAlpha;
end

function UIself_Rein:GetDownArrow_GameObject()
    if (self.mDownArrow_GameObject == nil) then
        self.mDownArrow_GameObject = self:Get("view/DownArrow", "GameObject");
    end
    return self.mDownArrow_GameObject;
end

function UIself_Rein:GetDownArrow_TweenAlpha()
    if (self.mDownArrow_TweenAlpha == nil) then
        self.mDownArrow_TweenAlpha = self:Get("view/DownArrow", "Top_TweenAlpha");
    end
    return self.mDownArrow_TweenAlpha;
end
--endregion

function UIself_Rein:GetScrollView_UIScrollView()
    if (self.mScrollView_UIScrollView == nil) then
        self.mScrollView_UIScrollView = self:Get("view/attribute/Scroll View", "UIScrollView");
    end
    return self.mScrollView_UIScrollView;
end

function UIself_Rein:GetGridContainer()
    if (self.mGridContainer == nil) then
        self.mGridContainer = self:Get("view/attribute/Scroll View/arributelist", "UIGridContainer");
    end
    return self.mGridContainer;
end

function UIself_Rein:GetUseTipsText()
    if (self.UseTipsText == nil) then
        self.UseTipsText = self:Get("UseTipsText", "GameObject")
    end
    return self.UseTipsText
end
--endregion

--region 初始化
function UIself_Rein:Init(panel)
    self.ServantPanel = panel;
    self.ServantPanel:ShowOtherServantPanel()
    self.CurWaterValue = 0
    self:BindUIEvents()
    self.mUpdateAttributeCoroutine = nil
end

function UIself_Rein:InitComponents()
    if (self.ServantPanel:GetSelectServantInfo() ~= nil) then
        local res, servantInfo = CS.Cfg_HsReinTableManager.Instance.dic:TryGetValue(self.ServantPanel:GetSelectServantInfo().reinId)
        if (res) then
            ---@type servantV2.ServantInfo
            self.ServantReinInfo = servantInfo
        end
        local nres, nextservantInfo = CS.Cfg_HsReinTableManager.Instance.dic:TryGetValue(self.ServantPanel:GetSelectServantInfo().reinId + 1)
        if (nres) then
            ---@type servantV2.ServantInfo
            self.NextServantReinInfo = nextservantInfo
        end
    end
end

function UIself_Rein:Show()
    ---判定是否满足聚灵的显示条件
    if (self:IsSatisfyJuLingCondition()) then
        ---策划需求先注释掉聚灵按钮
        self:GetReinGatherSoulBtn_GameObject():SetActive(false)
    else
        self:GetReinGatherSoulBtn_GameObject():SetActive(false)
    end
    self.go:SetActive(true)
    if not CS.StaticUtility.IsNull(self:GetLingLiName_UILabel()) then
        self:GetLingLiName_UILabel().text = self:GetItemName(1000020)
    end
    self:InitComponents()
end

function UIself_Rein:BindUIEvents()
    CS.UIEventListener.Get(self:GetReinBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetReinBtn_GameObject()).OnClickLuaDelegate = self.ReinBtnOnClick
    CS.UIEventListener.Get(self:GetReinExpIcon_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetReinExpIcon_GameObject()).OnClickLuaDelegate = self.ShowLingLiTipsOnClick
    CS.UIEventListener.Get(self:GetReinShenshiIcon_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetReinShenshiIcon_GameObject()).OnClickLuaDelegate = self.ShowShenShiTipsOnClick
    CS.UIEventListener.Get(self:GetReinHelp_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetReinHelp_GameObject()).OnClickLuaDelegate = self.OnReinHelpClicked
    CS.UIEventListener.Get(self:GetReinExpAddBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetReinExpAddBtn_GameObject()).OnClickLuaDelegate = self.ReqAddReinExpBtnOnClick
    CS.UIEventListener.Get(self:GetReinItemAddBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetReinItemAddBtn_GameObject()).OnClickLuaDelegate = self.ReqAddReinItemBtnOnClick
    CS.UIEventListener.Get(self:GetReinGatherSoulBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetReinGatherSoulBtn_GameObject()).OnClickLuaDelegate = self.ReinGatherSoulBtnOnClick

    self:GetScrollView_UIScrollView().onDragProgress = function()
        self:OnScrollViewMomentumMove();
    end
end
--endregion

--region Hide
function UIself_Rein:Hide()
    self.go:SetActive(false)
    if (self.mWinEffect ~= nil) then
        self.mWinEffect:SetActive(false)
    end
    if self.IEnumChangeWaterValue ~= nil then
        StopCoroutine(self.IEnumChangeWaterValue)
        self.IEnumChangeWaterValue = nil
    end
    self.ServantPanel:GetTabRein_UIToggle().value = false
end
--endregion

function UIself_Rein:ShowFull(full)
end

---@param panelOpenType XLua.Cast.Int32  装备界面刷新用（在此仅占位，可以nil，避免出错）
function UIself_Rein:RefreshServant(servantInfo, panelOpenType)
    self.ServantInfo = servantInfo

    if (self.ServantInfo == nil or self.ServantInfo.itemId == 0) then
        self:GetReinItem_GameObject():SetActive(false)
        --  self:GetReinLingli_GameObject():SetActive(false)
        self:GetReinBtn_GameObject():SetActive(false)
        --self:GetGrowLevel_GameObject():SetActive(false)
        self:GetUseTipsText():SetActive(true)
        self:RefreshTurnBallGroup(0)
    else
        self:GetUseTipsText():SetActive(false)
        -- self:GetGrowLevel_GameObject():SetActive(true)
        self:GetReinBtn_GameObject():SetActive(true)
        --self:GetReinLingli_GameObject():SetActive(true)
        self:GetReinItem_GameObject():SetActive(true)
        self:RefreshTurnBallGroup(self.ServantInfo.reinId)
    end
    self:UpdateServantAttriBute(servantInfo)
    self:UpdateReinNeedItem()
    self:RefreshLingLiShow()
    self:LoadEffect()
end

--region 特效
function UIself_Rein:LimitShowReinEffect()
    if (self.ServantInfo == nil or self.ServantInfo.reinId == 0) then
        if (self.waterEffect ~= nil and self.waterEffect ~= 0) then
            self.waterEffect:SetActive(false)
        end
        if (self.waterEffectb ~= nil and self.waterEffectb ~= 0) then
            self.waterEffectb:SetActive(false)
        end
    else
        if (self.waterEffect ~= nil and self.waterEffect ~= 0) then
            self.waterEffect:SetActive(true)
        end
        if (self.waterEffectb ~= nil and self.waterEffectb ~= 0) then
            self.waterEffectb:SetActive(true)
        end
    end
end
--region 加载特效
function UIself_Rein:RefreshEffect(effectName, parent, localPosition, localScale, callBack)
    local bagBtnEffect
    CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectName, CS.ResourceType.UIEffect, function(res)
        if res and res.MirrorObj then
            bagBtnEffect = res:GetObjInst()
            if bagBtnEffect and parent then
                bagBtnEffect.transform.parent = parent
                bagBtnEffect.transform.localPosition = localPosition
                bagBtnEffect.transform.localScale = localScale
                if callBack ~= nil then
                    callBack(bagBtnEffect)
                end
            end
        end
    end
    , CS.ResourceAssistType.UI)
end
--endregion

--region 加载液体特效
function UIself_Rein:LoadEffect()
    if self.waterEffect == nil and UIself_Rein.waterEffect ~= 0 then
        self.waterEffect = 0
        --700018
        self:RefreshEffect("700275", self:GetReinEffectView_GameObject().transform, CS.UnityEngine.Vector3(0, -3, 0), CS.UnityEngine.Vector3.one, function(effect)
            self.waterEffect = effect
        end)
    else
        --self:StartWaterChangeCoroutine()
    end

    if self.waterEffectb == nil and UIself_Rein.waterEffectb ~= 0 then
        self.waterEffectb = 0
        --700018
        self:RefreshEffect("700277", self:GetReinEffectViewDi_GameObject().transform, CS.UnityEngine.Vector3.zero, CS.UnityEngine.Vector3.one, function(effect)
            self.waterEffectb = effect
            self:LimitShowReinEffect()
            --self:StartWaterChangeCoroutine()
        end)
    else
        self:LimitShowReinEffect()
        --self:StartWaterChangeCoroutine()
    end

    if (self:GetReinErrorCode() == ReinErrorCode.NON) then
        if (self.mReinEffect == nil and not self.isLoadBtnEffect) then
            self.isLoadBtnEffect = true;
            self:RefreshEffect("700040", self:GetReinBtn_GameObject().transform, CS.UnityEngine.Vector3.zero, CS.UnityEngine.Vector3.one, function(effect)
                self.mReinEffect = effect;
                self.isLoadBtnEffect = false;
            end)
        else
            if self.mReinEffect ~= nil then
                self.mReinEffect:SetActive(false);
                self.mReinEffect:SetActive(true);
            end
        end
    else
        if (self.mReinEffect ~= nil) then
            self.mReinEffect:SetActive(false);
        end
    end
end
--endregion

--region 转生
---计算当前总进度 0-1
function UIself_Rein:CalculationWaterValue()
    local reinPool = CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.reinPool
    if self.ServantPanel:GetSelectServantInfo() == nil or reinPool == nil or self.ServantPanel:GetSelectServantInfo().itemId == 0 then
        self.WaterTargetValue = 0
        return
    end
    if self.NextServantReinInfo == nil then
        self.WaterTargetValue = 0
        return
    else
        if (self.NextServantReinInfo.needSoul ~= 0) then
            local xiuwei = (tonumber(reinPool) / tonumber(self.NextServantReinInfo.needSoul)) * 0.5
            xiuwei = xiuwei > 0.5 and 0.5 or xiuwei
            local itemid = self.NextServantReinInfo.needStone.list[0]
            local itemCount = self.NextServantReinInfo.needStone.list[1]
            local shenshi = (tonumber(CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemid)) / tonumber(itemCount)) * 0.5
            shenshi = shenshi > 0.5 and 0.5 or shenshi
            self.WaterTargetValue = xiuwei + shenshi
        else
            --修改数值，转生池为0的特殊情况
            local itemid = self.NextServantReinInfo.needStone.list[0]
            local itemCount = self.NextServantReinInfo.needStone.list[1]
            local shenshi = (tonumber(CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemid)) / tonumber(itemCount))
            shenshi = shenshi > 1 and 1 or shenshi
            self.WaterTargetValue = shenshi
        end
    end
end

---设置液体特效数值
--materialsNum 0-1
function UIself_Rein:SetWaterValue(materialsNum)
    if self.waterEffect == nil or self.waterEffect == 0 then
        return
    end
    local v2 = CS.UnityEngine.Vector2.zero
    -- 液体shader数值为从大到小 min数值为最大 液体数值为最小 max 数值为最小  液体数值为最大
    local min = 1
    local max = 0
    --TextureOffse 参数
    local str = ''
    local curEffectQueue = CS.Utility_Lua.GetComponent(self.waterEffect.transform, "Top_CSEffectRenderQueue")
    for i = 0, curEffectQueue.matS.Length - 1 do
        if i ~= 4 and i ~= 6 and i ~= 7 and i ~= 8 then
            min = i == 3 and 0.49 or i == 5 and 0.9 or 0.5
            max = i == 3 and -0.01 or i == 5 and 0.55 or 0
            str = i == 3 and "_MainTex" or "_MaskTex"
            v2.y = min - (materialsNum * (min - max))
            curEffectQueue.matS[i]:SetTextureOffset(str, v2)
        end
    end
    self.CurWaterValue = materialsNum
end

function UIself_Rein:IEnumWaterValueChange()
    self:CalculationWaterValue()
    local value = (self.WaterTargetValue - self.CurWaterValue) / 10
    value = tonumber(string.format("%.1f", value))
    local waterValue = 0
    if math.abs(value) <= 0.01 then
        self:SetWaterValue(self.WaterTargetValue)
    else
        while math.abs(self.CurWaterValue) < math.abs(self.WaterTargetValue) do
            waterValue = self.CurWaterValue + value
            waterValue = waterValue > 1 and 1 or waterValue
            self:SetWaterValue(waterValue)
            coroutine.yield(0.5)
        end
        self:SetWaterValue(self.WaterTargetValue)
    end
end
---开始协程
function UIself_Rein:StartWaterChangeCoroutine()
    if self.IEnumChangeWaterValue ~= nil then
        StopCoroutine(self.IEnumChangeWaterValue)
        self.IEnumChangeWaterValue = nil
    end
    self.IEnumChangeWaterValue = StartCoroutine(self.IEnumWaterValueChange, self)
end
--endregion
--endregion

--region Tips
---展示灵力tips
function UIself_Rein:ShowLingLiTipsOnClick()
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(1000020) })
end

---展示神石tips
function UIself_Rein:ShowShenShiTipsOnClick()
    if self.NextServantReinInfo ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(self.NextServantReinInfo.needStone.list[0]) })
    end
end
--endregion

--region 刷新面板
function UIself_Rein:ShowReinUpEffect()
    if self.mWinEffect == nil then
        self.mWinEffect = 0
        local resource = CS.CSResourceManager.Singleton:AddQueueCannotDelete("700020", CS.ResourceType.UIEffect, function(res)
            if res then
                local effect = res:GetObjInst()
                if (effect ~= nil) then
                    self.mWinEffect = effect
                    effect:SetActive(true)
                    effect.gameObject.transform:SetParent(self:GetReinUpEffectRoot_Transform())
                    effect.gameObject.transform.localPosition = CS.UnityEngine.Vector3.zero
                    effect.transform.localScale = CS.UnityEngine.Vector3.one
                end
            end
        end
        , CS.ResourceAssistType.UI)
        resource.IsCanBeDelete = true
    else
        if (self.mWinEffect ~= 0 and self.mWinEffect ~= nil) then
            self.mWinEffect:SetActive(false)
            self.mWinEffect:SetActive(true)
        end
    end
end

function UIself_Rein:RefreshTurnBallGroup(cfgid)
    local childCount = self:GetTurnBallGroup_GameObject().transform.childCount;
    ---@type TABLE.cfg_hsrein
    local reininfo = clientTableManager.cfg_hsreinManager:TryGetValue(cfgid)
    if (reininfo ~= nil) then
        for i = 0, childCount - 1 do
            self:GetTurnBallGroup_GameObject().transform:GetChild(i).gameObject:SetActive(i < reininfo:GetEightDoor())
        end
    end
    self:SetLevelUpDescribe(reininfo)
end

function UIself_Rein:SetLevelUpDescribe(reininfo)
    if (self.ServantInfo ~= nil) then
        local res, nextServantInfo = CS.Cfg_HsReinTableManager.Instance.dic:TryGetValue(tonumber(self.ServantInfo.reinId + 1))
        if (res) then
            if (nextServantInfo.level == 0) then
                ---处于小阶段
                self:GetTurnGrowDescribe_UILabel().text = "突破"
                self:GetLevelUpDescribe_Label().text = "突破" .. self:GetEightDoorName(reininfo:GetEightDoor() + 1) .. "效果"
                self:GetLevelUpCondition_Label().text = "突破" .. self:GetEightDoorName(reininfo:GetEightDoor() + 1) .. "条件"
            else
                if (self.ServantPanel:GetSelectServantInfo() ~= nil) then
                    self:GetTurnGrowDescribe_UILabel().text = "转生"
                    self:GetLevelUpDescribe_Label().text = "升级" .. CS.Utility_Lua.ArabicNumeralsToWordNumbers(self.ServantPanel:GetSelectServantInfo().rein + 1) .. "转属性"
                    self:GetLevelUpCondition_Label().text = "升级" .. CS.Utility_Lua.ArabicNumeralsToWordNumbers(self.ServantPanel:GetSelectServantInfo().rein + 1) .. "转条件"
                end
            end
        else
            self:GetLevelUpDescribe_Label().text = "升级属性"
            self:GetLevelUpCondition_Label().text = "升级条件"
            self:GetReinItem_GameObject():SetActive(false)
            --self:GetReinLingli_GameObject():SetActive(false)
        end
    end
end

---@type  number 八门类型
---获取八门名字
function UIself_Rein:GetEightDoorName(index)
    if (index == 1) then
        return "休门"
    elseif (index == 2) then
        return "生门"
    elseif (index == 3) then
        return "伤门"
    elseif (index == 4) then
        return "杜门"
    elseif (index == 5) then
        return "景门"
    elseif (index == 6) then
        return "死门"
    elseif (index == 7) then
        return "惊门"
    elseif (index == 8) then
        return "开门"
    else
        return ""
    end
end
--endregion

---背包发生变化
function UIself_Rein:OnResBagChangeMessageReceived()
    self.mNeedUpdateReinNeedItem = true
end

function UIself_Rein:OnUpdate()
    if self.mNeedUpdateReinNeedItem then
        self.mNeedUpdateReinNeedItem = nil
        self:UpdateReinNeedItem()
    end
end

--region 刷新转生所需道具
function UIself_Rein:UpdateReinNeedItem()
    if (self.ServantPanel:GetSelectServantInfo() ~= nil and self.ServantPanel:GetSelectServantInfo().itemId ~= 0) then
        local reinPool = CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.reinPool
        if self.NextServantReinInfo ~= nil then
            if (self.NextServantReinInfo.needStone ~= nil) then
                local itemid = self.NextServantReinInfo.needStone.list[0]
                self:GetReinItem_GameObject():SetActive(true)
                self:GetReinShenshiIcon_UISprite().spriteName = itemid
                self:GetShenShiName_UILabel().text = self:GetItemName(itemid)
                local itemCount = self.NextServantReinInfo.needStone.list[1]
                self:GetReinNeedItem_UILabel().text = CS.Utility_Lua.SetProgressLabelColor(CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemid), itemCount)
            else
                self:GetReinItem_GameObject():SetActive(false)
            end
            self:LabelSetValue(self.ServantPanel:GetSelectServantInfo().rein)
            self:GetReinPanelLevelEffect_UILabel().text = self.ServantPanel:GetSelectServantInfo().rein

            if (self.NextServantReinInfo.needSoul ~= 0) then
                -- self:GetReinLingli_GameObject():SetActive(true)
                self:GetReinNeedExp_UILabel().text = CS.Utility_Lua.SetProgressLabelColor(reinPool, self.NextServantReinInfo.needSoul)
            else
                --  self:GetReinLingli_GameObject():SetActive(false)
            end
        else
            self.NextServantReinInfo = self.ServantReinInfo
            if (self.NextServantReinInfo ~= nil and self.NextServantReinInfo.needStone ~= nil) then
                local itemid = self.NextServantReinInfo.needStone.list[0]
                self:GetReinNeedItem_UILabel().text = tostring(CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemid)) .. "/" .. tostring("---")
            end
            self:LabelSetValue(self.ServantPanel:GetSelectServantInfo().rein)
            self:GetReinNeedExp_UILabel().text = tostring(reinPool) .. "/" .. tostring("---")
        end
    else
        self:GetReinLevel_UILabel().text = ""
        self:GetReinNeedExp_UILabel().text = ""
        self:GetReinNeedItem_UILabel().text = ""
    end
    self:LoadEffect()
    ---满级不需要刷新
    if (self.maxRein) then
        self:GetReinItem_GameObject():SetActive(false)
        -- self:GetReinLingli_GameObject():SetActive(false)
    end
end

function UIself_Rein:LabelSetValue(value)
    local reinLevel = value == 0 and 1 or value
    local showInfo = CS.Utility_Lua.ArabicNumeralsToWordNumbers(reinLevel)
    self:GetReinLevel_UILabel().text = value == 0 and luaEnumColorType.Gray .. showInfo .. "转" .. '[-]' or showInfo .. "转"
end

function UIself_Rein:GetItemName(itemId)
    local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
    if res then
        return itemInfo.name
    end
    return ""
end

function UIself_Rein:ReqAddReinItemBtnOnClick()
    if self.NextServantReinInfo ~= nil and self.NextServantReinInfo.needStone ~= nil and self.NextServantReinInfo.needStone.list.Count > 0 then
        Utility.ShowItemGetWay(self.NextServantReinInfo.needStone.list[0], self:GetReinItemAddBtn_GameObject(), LuaEnumWayGetPanelArrowDirType.Down);
    end
end

function UIself_Rein:ReinGatherSoulBtnOnClick()
    if (CS.CSScene.MainPlayerInfo.OpenServerDayNumber >= 1) then
        uimanager:CreatePanel("UIServantGatherSoulPanel")
        uimanager:ClosePanel("UIBagPanel")
    else
        self:GetReinGatherSoulBtn_GameObject():SetActive(false)
    end

end

function UIself_Rein:ReqAddReinExpBtnOnClick()
    Utility.ShowItemGetWay(1000020, self:GetReinExpAddBtn_GameObject(), LuaEnumWayGetPanelArrowDirType.Down);
end

function UIself_Rein:OnScrollViewMomentumMove()
    self:CheckAttributeArrowShow();
end
--endregion

function UIself_Rein:CheckAttributeArrowShow()
    local gridContainer = self:GetGridContainer();
    local height = self.ShowattributeCount * gridContainer.CellHeight;
    local offsetY = self:GetScrollView_UIScrollView().panel.clipOffset.y;
    if (offsetY < 0) then
        if (math.abs(offsetY) > gridContainer.CellHeight / 2) then
            self:GetUpArrow_GameObject():SetActive(true);
            self:GetDownArrow_TweenAlpha():PlayTween()
        else
            self:GetUpArrow_GameObject():SetActive(false);
        end
    else
        self:GetUpArrow_GameObject():SetActive(false);
    end

    local interval = (height - self:GetScrollView_UIScrollView().panel.height) - math.abs(offsetY);
    if (interval > gridContainer.CellHeight / 2) then
        self:GetDownArrow_GameObject():SetActive(true);
        self:GetUpArrow_TweenAlpha():PlayTween()
    else
        self:GetDownArrow_GameObject():SetActive(false);
    end
end

--region 刷新属性
function UIself_Rein:UpdateServantAttriBute(info)
    --region 空档位
    if (self.ServantInfo == nil or self.ServantInfo.itemId == 0) then
        self:GetReinPanelFirstAttributeCur_UILabel().text = 0
        self:GetReinPanelSecondAttributeCur_UILabel().text = 0
        self:GetReinPanelThirdAttributeCur_UILabel().text = 0
        self:GetReinPanelFourthAttributeCur_UILabel().text = 0
        self:GetReinPanelFifthAttributeCur_UILabel().text = 0
        self:GetReinPanelSixthAttributeCur_UILabel().text = 0

        self:GetReinPanelFirstAttributeNext_UILabel().text = 0
        self:GetReinPanelSecondAttributeNext_UILabel().text = 0
        self:GetReinPanelThirdAttributeNext_UILabel().text = 0
        self:GetReinPanelFourthAttributeNext_UILabel().text = 0
        self:GetReinPanelFifthAttributeNext_UILabel().text = 0
        self:GetReinPanelSixthAttributeNext_UILabel().text = 0
        self:GetReinNeedLevel_Label().gameObject:SetActive(false)
        self:GetReinMax_GameObject():SetActive(false)
        self:EmptyAttributeArrowColor()
        self:SetAttributeLabelColor(0)
        self:ChangeAttackLabel()
        return
    end
    --endregion

    --region 当前级属性
    local res, servantInfo = CS.Cfg_HsReinTableManager.Instance.dic:TryGetValue(self.ServantInfo.reinId)
    if servantInfo then
        self.ServantReinInfo = servantInfo
        self:GetReinPanelFirstAttributeCur_UILabel().text = tostring(self.ServantReinInfo.maxHp)
        self:GetReinPanelSecondAttributeCur_UILabel().text = tostring(self.ServantReinInfo.phyAttackMin) .. " - " .. tostring(self.ServantReinInfo.phyAttackMax)
        self:GetReinPanelThirdAttributeCur_UILabel().text = tostring(self.ServantReinInfo.phyDefenceMin) .. " - " .. tostring(self.ServantReinInfo.phyDefenceMax)
        self:GetReinPanelFourthAttributeCur_UILabel().text = tostring(self.ServantReinInfo.magicDefenceMin) .. " - " .. tostring(self.ServantReinInfo.magicDefenceMax)
        self:GetReinPanelFifthAttributeCur_UILabel().text = tostring(self.ServantReinInfo.holyAttackMin) .. " - " .. tostring(self.ServantReinInfo.holyAttackMax)
        self:GetReinPanelSixthAttributeCur_UILabel().text = tostring(self.ServantReinInfo.holyDefenceMin) .. " - " .. tostring(self.ServantReinInfo.holyDefenceMax)
    else
        self.ServantReinInfo = nil
        self:GetReinPanelFirstAttributeCur_UILabel().text = 0
        self:GetReinPanelSecondAttributeCur_UILabel().text = 0
        self:GetReinPanelThirdAttributeCur_UILabel().text = 0
        self:GetReinPanelFourthAttributeCur_UILabel().text = 0
        self:GetReinPanelFifthAttributeCur_UILabel().text = 0
        self:GetReinPanelSixthAttributeCur_UILabel().text = 0
    end
    --endregion

    --region 下一级属性
    local res1, nextServantInfo = CS.Cfg_HsReinTableManager.Instance.dic:TryGetValue(tonumber(self.ServantInfo.reinId + 1))
    if res1 then
        self.maxRein = false
        self.NextServantReinInfo = nextServantInfo
        self.ServantPanel.ClickReinLevel = self.NextServantReinInfo.needLevel
        if (self.NextServantReinInfo.needSoul ~= 0 and self.NextServantReinInfo.needStone ~= nil) then
            self:ShowTopAttribute()
        else
            self:ShowBottomAttribute()
        end

        if self.ServantPanel.ClickReinLevel ~= nil and self.ServantPanel:GetSelectServantInfo().level < self.ServantPanel.ClickReinLevel then
            self:GetReinBtn_GameObject():SetActive(false)
            self:GetReinNeedLevel_Label().gameObject:SetActive(true)
            self:GetReinNeedLevel_Label().text = self.ServantPanel.ClickReinLevel
            self:GetReinItem_GameObject():SetActive(false)
        else
            self:GetReinBtn_GameObject():SetActive(true)
            self:GetReinItem_GameObject():SetActive(true)
            self:GetReinNeedLevel_Label().gameObject:SetActive(false)
        end

        --self:GetGrowLevel_GameObject():SetActive(true)
        self:GetReinMax_GameObject():SetActive(false)

        self:GetReinPanelFirstAttributeNext_UILabel().text = tostring(self.NextServantReinInfo.phyAttackMin) .. " - " .. tostring(self.NextServantReinInfo.phyAttackMax)
        self:GetReinPanelSecondAttributeNext_UILabel().text = tostring(self.NextServantReinInfo.phyDefenceMin) .. " - " .. tostring(self.NextServantReinInfo.phyDefenceMax)
        self:GetReinPanelThirdAttributeNext_UILabel().text = tostring(self.NextServantReinInfo.magicDefenceMin) .. " - " .. tostring(self.NextServantReinInfo.magicDefenceMax)
        self:GetReinPanelFourthAttributeNext_UILabel().text = tostring(self.NextServantReinInfo.holyAttackMin) .. " - " .. tostring(self.NextServantReinInfo.holyAttackMax)
        self:GetReinPanelFifthAttributeNext_UILabel().text = tostring(self.NextServantReinInfo.maxHp)
        self:GetReinPanelSixthAttributeNext_UILabel().text = tostring(self.NextServantReinInfo.holyDefenceMin) .. " - " .. tostring(self.NextServantReinInfo.holyDefenceMax)
    else
        self.maxRein = true
        self.NextServantReinInfo = self.ServantReinInfo
        self:ShowBottomAttribute()
        --self:GetReinLingli_GameObject():SetActive(false)
        self:GetReinItem_GameObject():SetActive(false)
        --self:GetGrowLevel_GameObject():SetActive(false)
        self:GetReinBtn_GameObject():SetActive(false)
        self:GetReinMax_GameObject():SetActive(true)
        self:GetReinFirstTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
        self:GetReinSecondTitle_UILabel().text = Utility.GetAttributeName(LuaEnumAttributeType.PhyDefenceMax)
        self:GetReinThirdTitle_UILabel().text = Utility.GetAttributeName(LuaEnumAttributeType.MagicDefenceMax)
        self:GetReinFourthTitle_UILabel().text = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp)
        self:GetReinFifthTitle_UILabel().text = Utility.GetAttributeName(LuaEnumAttributeType.HolyAttackMax)
        self:GetReinSixthTitle_UILabel().text = Utility.GetAttributeName(LuaEnumAttributeType.HolyDefenceMax)

        self:GetReinPanelFirstAttributeNext_UILabel().text = "已满"
        self:GetReinPanelHP_Transform().gameObject:SetActive(true)
        self:GetReinPanelSecondAttributeNext_UILabel().text = "已满"
        self:GetReinPanelAttack_Transform().gameObject:SetActive(true)
        self:GetReinPanelThirdAttributeNext_UILabel().text = "已满"
        self:GetReinPanelDefence_Transform().gameObject:SetActive(true)
        self:GetReinPanelFourthAttributeNext_UILabel().text = "已满"
        self:GetReinPanelMDefence_Transform().gameObject:SetActive(true)
        self:GetReinPanelFifthAttributeNext_UILabel().text = "已满"
        self:GetReinPanelHA_Transform().gameObject:SetActive(true)
        self:GetReinPanelSixthAttributeNext_UILabel().text = "已满"
        self:GetReinPanelHD_Transform().gameObject:SetActive(true)
        self:SetAttributeLabelColor(1)
        self:EmptyAttributeArrowColor()
        self:ChangeAttackLabel()
        self:GetReinNeedLevel_Label().gameObject:SetActive(false)
        self.ShowattributeCount = 6
        self:RefreshPanelReinUp()
        return
    end
    --endregion

    if (self.mUpdateAttributeCoroutine ~= nil) then
        StopCoroutine(self.mUpdateAttributeCoroutine)
        self.mUpdateAttributeCoroutine = nil
    end
    self.mUpdateAttributeCoroutine = StartCoroutine(self.UpdateNextAttributeLabelColor, self)
end

---刷新灵力是否显示
function UIself_Rein:RefreshLingLiShow()
    local needShow = self:GetNeedShowLingLiLb()
    self:GetReinLingli_GameObject():SetActive(needShow)
    self:GetGrowLevel_GameObject():SetActive(needShow)
end

---@return boolean 是否需要显示灵力
function UIself_Rein:GetNeedShowLingLiLb()
    if (self.ServantInfo and self.ServantInfo.itemId ~= 0) then
        local res1, nextServantInfo = CS.Cfg_HsReinTableManager.Instance.dic:TryGetValue(tonumber(self.ServantInfo.reinId + 1))
        if res1 then
            local levelEnough = self.ServantPanel.ClickReinLevel ~= nil and self.ServantPanel:GetSelectServantInfo().level >= self.ServantPanel.ClickReinLevel
            local needSoul = self.NextServantReinInfo.needSoul ~= 0
            return levelEnough and needSoul and not self.maxRein
        end
    end
    return false
end

function UIself_Rein:ShowTopAttribute()
    -- self:GetReinLingli_GameObject():SetActive(true)
    self:GetGrowLevel_GameObject().transform.localPosition = self.GrowLevelTopPos
    self:GetReinLingli_GameObject().transform.localPosition = self.ReinItemTopPos
    self:GetReinItem_GameObject().transform.localPosition = self.ReinItemBottomPos
    self:Getattribute_GameObject().transform.localPosition = self.attributeTopPos
    self:GetDownArrow_GameObject().transform.localPosition = self.DownArrowTopPos
    self:GetUpArrow_GameObject().transform.localPosition = self.UPArrowTopPos
end

function UIself_Rein:ShowBottomAttribute()
    -- self:GetReinLingli_GameObject():SetActive(false)
    self:GetReinLingli_GameObject().transform.localPosition = self.ReinItemBottomPos
    self:GetGrowLevel_GameObject().transform.localPosition = self.GrowLevelBottomPos
    self:GetReinItem_GameObject().transform.localPosition = self.ReinItemBottomPos
    self:Getattribute_GameObject().transform.localPosition = self.attributeBottomPos
    self:GetDownArrow_GameObject().transform.localPosition = self.DownArrowBottomPos
    self:GetUpArrow_GameObject().transform.localPosition = self.UPArrowBottomPos
end

function UIself_Rein:ChangeAttackLabel()
    if (self:GetReinFirstTitle_UILabel().text == "攻击") then
        self:GetReinFirstTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
        return
    end
    if (self:GetReinSecondTitle_UILabel().text == "攻击") then
        self:GetReinSecondTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
        return
    end
    if (self:GetReinThirdTitle_UILabel().text == "攻击") then
        self:GetReinThirdTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
        return
    end
    if (self:GetReinFourthTitle_UILabel().text == "攻击") then
        self:GetReinFourthTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
        return
    end
    if (self:GetReinFifthTitle_UILabel().text == "攻击") then
        self:GetReinFifthTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
        return
    end
    if (self:GetReinSixthTitle_UILabel().text == "攻击") then
        self:GetReinSixthTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
        return
    end
end

---@param type 颜色类型
--- 1:绿色 2:白色
function UIself_Rein:SetAttributeLabelColor(type)
    if (type == 1) then
        self:GetReinPanelFirstAttributeNext_UILabel().color = self.mGreenColor
        self:GetReinPanelSecondAttributeNext_UILabel().color = self.mGreenColor
        self:GetReinPanelThirdAttributeNext_UILabel().color = self.mGreenColor
        self:GetReinPanelFifthAttributeNext_UILabel().color = self.mGreenColor
        self:GetReinPanelFourthAttributeNext_UILabel().color = self.mGreenColor
        self:GetReinPanelSixthAttributeNext_UILabel().color = self.mGreenColor
    else
        self:GetReinPanelFirstAttributeNext_UILabel().color = CS.UnityEngine.Color.white
        self:GetReinPanelSecondAttributeNext_UILabel().color = CS.UnityEngine.Color.white
        self:GetReinPanelThirdAttributeNext_UILabel().color = CS.UnityEngine.Color.white
        self:GetReinPanelFifthAttributeNext_UILabel().color = CS.UnityEngine.Color.white
        self:GetReinPanelFourthAttributeNext_UILabel().color = CS.UnityEngine.Color.white
        self:GetReinPanelSixthAttributeNext_UILabel().color = CS.UnityEngine.Color.white
    end
end

function UIself_Rein:EmptyAttributeArrowColor()
    self:GetReinPanelSecondAttributeNextArrow_UISprite().spriteName = "arrow3"
    self:GetReinPanelThirdAttributeNextArrow_UISprite().spriteName = "arrow3"
    self:GetReinPanelFourthAttributeNextArrow_UISprite().spriteName = "arrow3"
    self:GetReinPanelFirstAttributeNextArrow_UISprite().spriteName = "arrow3"
    self:GetReinPanelFifthAttributeNextArrow_UISprite().spriteName = "arrow3"
    self:GetReinPanelSixthAttributeNextArrow_UISprite().spriteName = "arrow3"
end

function UIself_Rein:UpdateNextAttributeLabelColor()
    yield_return(0)
    local attributeList = CS.System.Collections.Generic["List`1[System.Int32]"]()
    self.curphyAttackMin = 0
    self.curphyAttackMax = 0
    self.curmaxHp = 0
    self.curphyDefenceMin = 0
    self.curphyDefenceMax = 0
    self.curholyDefenceMin = 0
    self.curholyDefenceMax = 0
    self.curholyAttackMin = 0
    self.curholyAttackMax = 0
    self.curmagicDefenceMin = 0
    self.curmagicDefenceMax = 0
    if (self.ServantReinInfo ~= nil) then
        self.curphyAttackMin = self.ServantReinInfo.phyAttackMin
        self.curphyAttackMax = self.ServantReinInfo.phyAttackMax
        self.curmaxHp = self.ServantReinInfo.maxHp
        self.curphyDefenceMin = self.ServantReinInfo.phyDefenceMin
        self.curphyDefenceMax = self.ServantReinInfo.phyDefenceMax
        self.curholyDefenceMin = self.ServantReinInfo.holyDefenceMin
        self.curholyDefenceMax = self.ServantReinInfo.holyDefenceMax
        self.curholyAttackMin = self.ServantReinInfo.holyAttackMin
        self.curholyAttackMax = self.ServantReinInfo.holyAttackMax
        self.curmagicDefenceMin = self.ServantReinInfo.magicDefenceMin
        self.curmagicDefenceMax = self.ServantReinInfo.magicDefenceMax
    end
    if (self.NextServantReinInfo.phyAttackMin == self.curphyAttackMin and self.NextServantReinInfo.phyAttackMax == self.curphyAttackMax) then
    else
        attributeList:Add(1)
    end
    if (self.NextServantReinInfo.phyDefenceMin == self.curphyDefenceMin and self.NextServantReinInfo.phyDefenceMax == self.curphyDefenceMax) then
    else
        attributeList:Add(2)
    end
    if (self.NextServantReinInfo.magicDefenceMin == self.curmagicDefenceMin and self.NextServantReinInfo.magicDefenceMax == self.curmagicDefenceMax) then
    else
        attributeList:Add(3)
    end
    if (self.curmaxHp == self.NextServantReinInfo.maxHp) then
    else
        attributeList:Add(4)
    end
    if (self.NextServantReinInfo.holyAttackMin == self.curholyAttackMin and self.NextServantReinInfo.holyAttackMax == self.curholyAttackMax) then
    else
        attributeList:Add(5)
    end
    if (self.NextServantReinInfo.holyDefenceMin == self.curholyDefenceMin and self.NextServantReinInfo.holyDefenceMax == self.curholyDefenceMax) then
    else
        attributeList:Add(6)
    end

    self:SortAttributeList(attributeList)
    if (self.mUpdateAttributeCoroutine ~= nil) then
        StopCoroutine(self.mUpdateAttributeCoroutine)
    end
end

function UIself_Rein:SortAttributeList(data)
    local index = 1
    local AttributeList = data

    for i = 0, 5 do
        if (data.Count <= i) then
            AttributeList:Add(index)
        else
            if (data[i] ~= index and not data:Contains(index)) then
                AttributeList:Add(index)
            end
        end
        index = index + 1
    end

    for j = 0, AttributeList.Count - 1 do
        local color = CS.UnityEngine.Color.white
        local spriteName = "arrow3"
        if (AttributeList[j] == 1) then
            if (self.NextServantReinInfo.phyAttackMin == self.curphyAttackMin and self.NextServantReinInfo.phyAttackMax == self.curphyAttackMax) then
            else
                color = self.mGreenColor
                spriteName = "arrow"
            end
            self:ChangeLabelValue(j, color, spriteName, Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)), tostring(self.curphyAttackMin) .. " - " .. tostring(self.curphyAttackMax), tostring(self.NextServantReinInfo.phyAttackMin) .. " - " .. tostring(self.NextServantReinInfo.phyAttackMax))
        elseif (AttributeList[j] == 2) then
            if (self.curphyDefenceMin == self.NextServantReinInfo.phyDefenceMin and self.curphyDefenceMax == self.NextServantReinInfo.phyDefenceMax) then
            else
                color = self.mGreenColor
                spriteName = "arrow"
            end
            self:ChangeLabelValue(j, color, spriteName, Utility.GetAttributeName(LuaEnumAttributeType.PhyDefenceMax), tostring(self.curphyDefenceMin) .. " - " .. tostring(self.curphyDefenceMax), tostring(self.NextServantReinInfo.phyDefenceMin) .. " - " .. tostring(self.NextServantReinInfo.phyDefenceMax))
        elseif (AttributeList[j] == 3) then
            if (self.curmagicDefenceMin == self.NextServantReinInfo.magicDefenceMin and self.curmagicDefenceMax == self.NextServantReinInfo.magicDefenceMax) then
            else
                color = self.mGreenColor
                spriteName = "arrow"
            end
            self:ChangeLabelValue(j, color, spriteName, Utility.GetAttributeName(LuaEnumAttributeType.MagicDefenceMax), tostring(self.curmagicDefenceMin) .. " - " .. tostring(self.curmagicDefenceMax), tostring(self.NextServantReinInfo.magicDefenceMin) .. " - " .. tostring(self.NextServantReinInfo.magicDefenceMax))
        elseif (AttributeList[j] == 4) then
            if (self.curmaxHp == self.NextServantReinInfo.maxHp) then
            else
                color = self.mGreenColor
                spriteName = "arrow"
            end
            self:ChangeLabelValue(j, color, spriteName, Utility.GetAttributeName(LuaEnumAttributeType.MaxHp), tostring(self.curmaxHp), tostring(self.NextServantReinInfo.maxHp))
        elseif (AttributeList[j] == 5) then
            if (self.NextServantReinInfo.holyAttackMin == self.curholyAttackMin and self.NextServantReinInfo.holyAttackMax == self.curholyAttackMax) then
            else
                color = self.mGreenColor
                spriteName = "arrow"
            end
            self:ChangeLabelValue(j, color, spriteName, Utility.GetAttributeName(LuaEnumAttributeType.HolyAttackMax), tostring(self.curholyAttackMin) .. " - " .. tostring(self.curholyAttackMax), tostring(self.NextServantReinInfo.holyAttackMin) .. " - " .. tostring(self.NextServantReinInfo.holyAttackMax))
        elseif (AttributeList[j] == 6) then
            if (self.NextServantReinInfo.holyDefenceMin == self.curholyDefenceMin and self.NextServantReinInfo.holyDefenceMax == self.curholyDefenceMax) then
            else
                color = self.mGreenColor
                spriteName = "arrow"
            end
            self:ChangeLabelValue(j, color, spriteName, Utility.GetAttributeName(LuaEnumAttributeType.HolyDefenceMax), tostring(self.curholyDefenceMin) .. " - " .. tostring(self.curholyDefenceMax), tostring(self.NextServantReinInfo.holyDefenceMin) .. " - " .. tostring(self.NextServantReinInfo.holyDefenceMax))
        end
    end
    self:RefreshPanelReinUp()
end

function UIself_Rein:ChangeLabelValue(num, color, spriteName, title, cur, next)
    if (num == 0) then
        self:GetReinFirstTitle_UILabel().text = title
        self:GetReinPanelFirstAttributeNextArrow_UISprite().spriteName = spriteName
        self:GetReinPanelFirstAttributeNext_UILabel().color = color
        self:GetReinPanelFirstAttributeCur_UILabel().text = cur
        self:GetReinPanelFirstAttributeNext_UILabel().text = next
    elseif (num == 1) then
        self:GetReinSecondTitle_UILabel().text = title
        self:GetReinPanelSecondAttributeNextArrow_UISprite().spriteName = spriteName
        self:GetReinPanelSecondAttributeNext_UILabel().color = color
        self:GetReinPanelSecondAttributeCur_UILabel().text = cur
        self:GetReinPanelSecondAttributeNext_UILabel().text = next
    elseif (num == 2) then
        self:GetReinThirdTitle_UILabel().text = title
        self:GetReinPanelThirdAttributeNextArrow_UISprite().spriteName = spriteName
        self:GetReinPanelThirdAttributeNext_UILabel().color = color
        self:GetReinPanelThirdAttributeCur_UILabel().text = cur
        self:GetReinPanelThirdAttributeNext_UILabel().text = next
    elseif (num == 3) then
        self:GetReinFourthTitle_UILabel().text = title
        self:GetReinPanelFourthAttributeNextArrow_UISprite().spriteName = spriteName
        self:GetReinPanelFourthAttributeNext_UILabel().color = color
        self:GetReinPanelFourthAttributeCur_UILabel().text = cur
        self:GetReinPanelFourthAttributeNext_UILabel().text = next
    elseif (num == 4) then
        self:GetReinFifthTitle_UILabel().text = title
        self:GetReinPanelFifthAttributeNextArrow_UISprite().spriteName = spriteName
        self:GetReinPanelFifthAttributeNext_UILabel().color = color
        self:GetReinPanelFifthAttributeCur_UILabel().text = cur
        self:GetReinPanelFifthAttributeNext_UILabel().text = next
    elseif (num == 5) then
        self:GetReinSixthTitle_UILabel().text = title
        self:GetReinPanelSixthAttributeNextArrow_UISprite().spriteName = spriteName
        self:GetReinPanelSixthAttributeNext_UILabel().color = color
        self:GetReinPanelSixthAttributeCur_UILabel().text = cur
        self:GetReinPanelSixthAttributeNext_UILabel().text = next
    end
end

function UIself_Rein:RefreshPanelReinUp()
    self.ShowattributeCount = 0
    if (self:GetReinPanelFirstAttributeNext_UILabel().text == "0" or self:GetReinPanelFirstAttributeNext_UILabel().text == "0 - 0") then
        self:GetReinPanelHA_Transform().gameObject:SetActive(false)
    else
        self.ShowattributeCount = self.ShowattributeCount + 1
        self:GetReinPanelHA_Transform().gameObject:SetActive(true)
        self:GetReinPanelFirstAttributeNextEffect_UILabel().text = self:GetReinPanelFirstAttributeNext_UILabel().text
        self:GetReinPanelFirstAttributeNextEffect_TweenAlpha():PlayTween();
    end

    if (self:GetReinPanelSecondAttributeNext_UILabel().text == "0" or self:GetReinPanelSecondAttributeNext_UILabel().text == "0 - 0") then
        self:GetReinPanelAttack_Transform().gameObject:SetActive(false)
    else
        self.ShowattributeCount = self.ShowattributeCount + 1
        self:GetReinPanelAttack_Transform().gameObject:SetActive(true)
        self:GetReinPanelSecondAttributeNextEffect_UILabel().text = self:GetReinPanelSecondAttributeNext_UILabel().text
        self:GetReinPanelSecondAttributeNextEffect_TweenAlpha():PlayTween();
    end

    if (self:GetReinPanelThirdAttributeNext_UILabel().text == "0" or self:GetReinPanelThirdAttributeNext_UILabel().text == "0 - 0") then
        self:GetReinPanelDefence_Transform().gameObject:SetActive(false)
    else
        self.ShowattributeCount = self.ShowattributeCount + 1
        self:GetReinPanelDefence_Transform().gameObject:SetActive(true)
        self:GetReinPanelThirdAttributeNextEffect_UILabel().text = self:GetReinPanelThirdAttributeNext_UILabel().text
        self:GetReinPanelThirdAttributeNextEffect_TweenAlpha():PlayTween();
    end

    if (self:GetReinPanelFourthAttributeNext_UILabel().text == "0" or self:GetReinPanelFourthAttributeNext_UILabel().text == "0 - 0") then
        self:GetReinPanelMDefence_Transform().gameObject:SetActive(false)
    else
        self.ShowattributeCount = self.ShowattributeCount + 1
        self:GetReinPanelMDefence_Transform().gameObject:SetActive(true)
        self:GetReinPanelFourthAttributeNextEffect_UILabel().text = self:GetReinPanelFourthAttributeNext_UILabel().text
        self:GetReinPanelFourthAttributeNextEffect_TweenAlpha():PlayTween();
    end

    if (self:GetReinPanelFifthAttributeNext_UILabel().text == "0" or self:GetReinPanelFifthAttributeNext_UILabel().text == "0 - 0") then
        self:GetReinPanelHA_Transform().gameObject:SetActive(false)
    else
        self.ShowattributeCount = self.ShowattributeCount + 1
        self:GetReinPanelHA_Transform().gameObject:SetActive(true)
        self:GetReinPanelFifthAttributeNextEffect_UILabel().text = self:GetReinPanelFifthAttributeNext_UILabel().text
        self:GetReinPanelFifthAttributeNextEffect_TweenAlpha():PlayTween();
    end

    if (self:GetReinPanelSixthAttributeNext_UILabel().text == "0" or self:GetReinPanelSixthAttributeNext_UILabel().text == "0 - 0") then
        self:GetReinPanelHD_Transform().gameObject:SetActive(false)
    else
        self.ShowattributeCount = self.ShowattributeCount + 1
        self:GetReinPanelHD_Transform().gameObject:SetActive(true)
        self:GetReinPanelSixthAttributeNextEffect_UILabel().text = self:GetReinPanelSixthAttributeNext_UILabel().text
        self:GetReinPanelSixthAttributeNextEffect_TweenAlpha():PlayTween();
    end

    self:GetReinPanelLevelEffect_TweenAlpha():PlayTween();
    self:CheckAttributeArrowShow();
    self:GetScrollView_UIScrollView():Reposition()

end
--endregion

--region UIEvents
---转生帮助界面
function UIself_Rein:OnReinHelpClicked()
    local info = self:GetHelpTableData(41)
    if info then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end
--endregion

function UIself_Rein:GetHelpTableData(id)
    local res, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if res then
        return info
    end
    return nil
end

function UIself_Rein:GetReinErrorCode()
    if self.ServantPanel ~= nil and self.ServantPanel:GetSelectServantInfo() ~= nil then
        if self.NextServantReinInfo ~= nil then
            local itemid = 0
            local itemCount = 0
            if (self.NextServantReinInfo.needStone ~= nil) then
                itemid = self.NextServantReinInfo.needStone.list[0]
                itemCount = self.NextServantReinInfo.needStone.list[1]
            end
            local lingli = tonumber(CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.reinPool) >= tonumber(self.NextServantReinInfo.needSoul)
            local shenshi
            if (itemid ~= 0) then
                shenshi = tonumber(CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemid)) >= tonumber(itemCount)
            else
                shenshi = true
            end
            if (not lingli) then
                return ReinErrorCode.LingLiNotEnough;
            end

            if (not shenshi) then
                return ReinErrorCode.ShenShiNotEnough;
            end

            if (self.ServantPanel:GetSelectServantInfo().level < self.ServantPanel.ClickReinLevel) then
                return ReinErrorCode.ServantLevelNotEnough;
            end
        else
            return ReinErrorCode.NotHasServant;
        end
    end
    return ReinErrorCode.NON;
end

function UIself_Rein:ReinBtnOnClick(go)
    if (self.ServantInfo.rein < CS.CSScene.MainPlayerInfo.ReinLevel) then
        local itemid = 0
        if (self.NextServantReinInfo.needStone ~= nil) then
            itemid = self.NextServantReinInfo.needStone.list[0]
        end
        local itemCount = 0
        if (self.NextServantReinInfo.needStone ~= nil) then
            itemCount = self.NextServantReinInfo.needStone.list[1]
        end
        local level = self.NextServantReinInfo.needLevel
        local reinPool = tonumber(CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.reinPool)
        local shenShiCount = tonumber(CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemid))
        local lingli = reinPool >= tonumber(self.NextServantReinInfo.needSoul)
        local shenshi
        if (itemid ~= 0) then
            shenshi = shenShiCount >= tonumber(itemCount)
        else
            shenshi = true
        end
        if self.ServantPanel ~= nil and self.NextServantReinInfo and reinPool then
            if (not lingli) then
                self.ServantPanel:ShowTips(self:GetReinBtn_GameObject(), 9)
                return
            end

            if (not shenshi) then
                local itemName = CS.Cfg_ItemsTableManager.Instance:GetItems(itemid).name
                self.ServantPanel:ShowTips(self:GetReinBtn_GameObject(), 10, "需要" .. itemName .. itemCount .. "个")
                return
            end
            if (level > self.ServantInfo.level) then
                self.ServantPanel:ShowTips(self:GetReinBtn_GameObject(), 127)
                return
            end
            networkRequest.ReqUpLevelServantRein(self.ServantPanel.ServantIndex + 1)
            self:ShowReinUpEffect()
        end
    else
        self.ServantPanel:ShowTips(self:GetReinBtn_GameObject(), 276)
    end
end
--endregion

--region 聚灵相关

---聚灵按钮的显示条件 lua的table格式
UIself_Rein.JuLingConditionList = nil

---是否满足聚灵按钮显示条件
function UIself_Rein:IsSatisfyJuLingCondition()
    --尝试获取聚灵显示条件
    if (self.JuLingConditionList == nil) then
        self.JuLingConditionList = self:GetJuLingBtnShowCondition();
    end
    ---还没有获取到,那么说明条件获取失败,默认隐藏
    if (self.JuLingConditionList == nil) then
        return false
    end
    ---循环条件列表,并传到C#的condition表格管理类进行检测是否主角满足条件
    for i, v in pairs(self.JuLingConditionList) do
        if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(v) == false) then
            return false
        end
    end

    return true
end

--endregion

--region 杂项表相关

---从杂项表中22656得到聚灵按钮的显示条件
function UIself_Rein:GetJuLingBtnShowCondition()
    local res, globalInfo = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22656)
    if res then
        local tbl = {};
        local strs = string.Split(globalInfo.value, '#')
        for i = 1, #strs do
            local conditionID = tonumber(strs[i]);
            table.insert(tbl, conditionID)
        end
        return tbl;
    end
    return nil
end

--endregion

return UIself_Rein