---@class UIRankItemTemplate 排行单元模板 非功能
local UIRankItemTemplate = {}

--region 组件

---@type Top_UISprite 排行图片
function UIRankItemTemplate:GetRankingSprite()
    if self.rankingSprite == nil and self.CloneManager ~= nil then
        self.rankingSprite = self.CloneManager:GetComponent("Total/rankingSprite", "Top_UISprite", "rankSprite", self.total)
    end
    return self.rankingSprite
end

---@type Top_UILabel 玩家排行
function UIRankItemTemplate:GetRankingValue()
    if self.rankingValue == nil and self.CloneManager ~= nil then
        self.rankingValue = self.CloneManager:GetComponent("Total/rankingValue", "Top_UILabel", "label", self.total)
    end
    return self.rankingValue
end

---@type Top_UILabel 玩家名称
function UIRankItemTemplate:GetRankName()
    if self.rankName == nil and self.CloneManager ~= nil then
        self.rankName = self.CloneManager:GetComponent("Total/name", "Top_UILabel", "name", self.total, 'name')
    end
    return self.rankName
end

---@type Top_UISprite 玩家商会图片名称
function UIRankItemTemplate:GetRankMothIcon()
    if self.rankMothIcon == nil and self.CloneManager ~= nil then
        self.rankMothIcon = self.CloneManager:GetComponent("Total/name/icon", "Top_UISprite", "name", self.total, 'name')
    end
    return self.rankMothIcon
end

---@type Top_UISprite 玩家职业图片
function UIRankItemTemplate:GetRankCareerSprite()
    if self.rankCareerSprite == nil and self.CloneManager ~= nil then
        self.rankCareerSprite = self.CloneManager:GetComponent("Total/careerSprite", "Top_UISprite", "careerSprite", self.total)
    end
    return self.rankCareerSprite
end

---@type Top_UILabel 玩家职业
function UIRankItemTemplate:GetRankCareer()
    if self.rankCareer == nil and self.CloneManager ~= nil then
        self.rankCareer = self.CloneManager:GetComponent("Total/career", "Top_UILabel", "label", self.total)
    end
    return self.rankCareer
end

---@type Top_UILabel 玩家等级
function UIRankItemTemplate:GetRankLevel()
    if self.rankLevel == nil and self.CloneManager ~= nil then
        self.rankLevel = self.CloneManager:GetComponent("Total/level", "Top_UILabel", "label", self.total)
    end
    return self.rankLevel
end

---@type Top_UILabel  性别
function UIRankItemTemplate:GetRankSex()
    if self.sex == nil and self.CloneManager ~= nil then
        self.sex = self.CloneManager:GetComponent("Total/sex", "Top_UILabel", "label", self.total)
    end
    return self.sex
end

---@type Top_UILabel 划拳积分
function UIRankItemTemplate:GetRankFingerValue()
    if self.fingergameValue == nil and self.CloneManager ~= nil then
        self.fingergameValue = self.CloneManager:GetComponent("Total/fingergameValue", "Top_UILabel", "label", self.total)
    end
    return self.fingergameValue
end

---@type Top_UILabel 魅力值
function UIRankItemTemplate:GetRankCharmValue()
    if self.charmValue == nil and self.CloneManager ~= nil then
        self.charmValue = self.CloneManager:GetComponent("Total/charmValue", "Top_UILabel", "label", self.total)
    end
    return self.charmValue
end

---@type Top_UILabel  亲密度
function UIRankItemTemplate:GetRankIntimacyValue()
    if self.intimacyValue == nil and self.CloneManager ~= nil then
        self.intimacyValue = self.CloneManager:GetComponent("Total/intimacyValue", "Top_UILabel", "label", self.total)
    end
    return self.intimacyValue
end

---@type Top_UILabel 送花数
function UIRankItemTemplate:GetRankFlowerValue()
    if self.flower == nil and self.CloneManager ~= nil then
        self.flower = self.CloneManager:GetComponent("Total/flower", "Top_UILabel", "label", self.total)
    end
    return self.flower
end

---@return Top_UIGridContainer 元宝交易额
function UIRankItemTemplate:GetRankDealIngot()
    if self.dealIngot == nil and self.CloneManager ~= nil then
        self.dealIngot = self.CloneManager:GetComponent("Total/dealIngot", "Top_UIGridContainer", "Coin", self.total)
    end
    return self.dealIngot
end

---@type Top_UILabel 行会
function UIRankItemTemplate:GetRankGuild()
    if self.guild == nil and self.CloneManager ~= nil then
        self.guild = self.CloneManager:GetComponent("Total/guild", "Top_UILabel", "label", self.total)
    end
    return self.guild
end

---@type Top_UILabel boss击杀数
function UIRankItemTemplate:GetRankBossKill()
    if self.bosskill == nil and self.CloneManager ~= nil then
        self.bosskill = self.CloneManager:GetComponent("Total/bosskill", "Top_UILabel", "label", self.total)
    end
    return self.bosskill
end

---@type Top_UILabel 人物击杀数
function UIRankItemTemplate:GetRankPlayerKill()
    if self.Playerkill == nil and self.CloneManager ~= nil then
        self.Playerkill = self.CloneManager:GetComponent("Total/Playerkill", "Top_UILabel", "label", self.total)
    end
    return self.Playerkill
end

---@type UnityEngine.GameObject  夫妻信息
function UIRankItemTemplate:GetRankLover()
    if self.lover == nil and self.CloneManager ~= nil then
        self.lover = self.CloneManager:GetComponent("Total/lover", "GameObject", "lover", self.total)
    end
    return self.lover
end

---@type Top_UILabel  夫妻首位名字
function UIRankItemTemplate:GetRankLoverFirstName()
    if self.loverFirstName == nil and self.CloneManager ~= nil then
        self.loverFirstName = self.CloneManager:GetComponent("Total/lover/name1", "Top_UILabel", "lover", self.total, "lover")
    end
    return self.loverFirstName
end

---@type Top_UILabel  夫妻次位名字
function UIRankItemTemplate:GetRankLoverSecondName()
    if self.loverSecondName == nil and self.CloneManager ~= nil then
        self.loverSecondName = self.CloneManager:GetComponent("Total/lover/name2", "Top_UILabel", "lover", self.total, "lover")
    end
    return self.loverSecondName
end

---@type Top_UISprite  夫妻首位商会icon
function UIRankItemTemplate:GetRankLoverFirstMothIcon()
    if self.loverFirstMothIcon == nil and self.CloneManager ~= nil then
        self.loverFirstMothIcon = self.CloneManager:GetComponent("Total/lover/name1/icon", "Top_UISprite", "lover", self.total, "lover")
    end
    return self.loverFirstMothIcon
end

---@type Top_UISprite  夫妻次位商会icon
function UIRankItemTemplate:GetRankLoverSecondMothIcon()
    if self.loverSecondMothIcon == nil and self.CloneManager ~= nil then
        self.loverSecondMothIcon = self.CloneManager:GetComponent("Total/lover/name2/icon", "Top_UISprite", "lover", self.total, "lover")
    end
    return self.loverSecondMothIcon
end

---@type Top_UILabel  战勋
function UIRankItemTemplate:GetRankPrefix()
    if self.rankPrefix == nil and self.CloneManager ~= nil then
        self.rankPrefix = self.CloneManager:GetComponent("Total/rankPrefix", "Top_UILabel", "label", self.total)
    end
    return self.rankPrefix
end

---@type Top_UIGridContainer 灵兽列表
function UIRankItemTemplate:GetServantGrid()
    if self.servantGrid == nil and self.CloneManager ~= nil then
        self.servantGrid = self.CloneManager:GetComponent("Total/servantGrid", "Top_UIGridContainer", "ServantGrid", self.total)
    end
    return self.servantGrid
end

---@type Top_UIGridContainer 装备掉落
function UIRankItemTemplate:GetQuiteDropGrid()
    if self.quiteDropGrid == nil and self.CloneManager ~= nil then
        self.quiteDropGrid = self.CloneManager:GetComponent("Total/quiteDropGrid", "Top_UIGridContainer", "quiteDropGrid", self.total)
    end
    return self.quiteDropGrid
end

---@type Top_UIGridContainer 物品列表
function UIRankItemTemplate:GetItemGrid()
    if self.itemGrid == nil and self.CloneManager ~= nil then
        self.itemGrid = self.CloneManager:GetComponent("Total/quiteDropGrid", "Top_UIGridContainer", "itemGrid", self.total)
    end
    return self.itemGrid
end

---@type Top_UIGridContainer 详情按钮
function UIRankItemTemplate:GetDetailsBtn()
    if self.details == nil and self.CloneManager ~= nil then
        self.details = self.CloneManager:GetComponent("Total/details", "GameObject", "details", self.total)
    end
    return self.details
end

---@type Top_UISprite 奖励宝箱
function UIRankItemTemplate:GetRankRewardBox()
    if self.rewardbox == nil and self.CloneManager ~= nil then
        self.rewardbox = self.CloneManager:GetComponent("Total/rewardbox", "Top_UISprite", "rewardbox", self.total)
    end
    return self.rewardbox
end

---@type Top_UILabel  战勋
function UIRankItemTemplate:GetRankFormationLevle()
    if self.rankFormationLevle == nil and self.CloneManager ~= nil then
        self.rankFormationLevle = self.CloneManager:GetComponent("Total/formationLevle", "Top_UILabel", "label", self.total)
    end
    return self.rankFormationLevle
end

--endregion

--region 初始化

function UIRankItemTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIRankItemTemplate:InitParameters()
    self.callBack = nil
    self.callBackSecond = nil
    self.rankID = 0
    self.type = 0
    self.rewardObj = nil
    self.rid = 0
    self.useTemplate = nil
    self.mClickGoCallBack = nil
    self.rewardInfo = {}
    self.promptPoint = nil
end

function UIRankItemTemplate:InitComponents()
    ---@type Top_DynamicCloneManager
    self.CloneManager = CS.Utility_Lua.GetComponent(self.go, "Top_DynamicCloneManager")
    ---@type UnityEngine.GameObject 点击特效
    self.total = self:Get("Total", "GameObject")
    ---@type Top_UISprite 点击特效
    self.ChosenEffect = self:Get("ChosenEffect", "Top_UISprite")

    ---@type UnityEngine.GameObject 主角高亮
    self.chosenhight = self:Get("chosenhight", "GameObject")

    ---@type Top_UISprite 背景
    self.bg = self:Get("Background", "Top_UISprite")
end

function UIRankItemTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnTemplatBtnClick

    --CS.UIEventListener.Get(self.wifeNameTwo.gameObject).LuaEventTable = self
    --CS.UIEventListener.Get(self.wifeNameTwo.gameObject).OnClickLuaDelegate = nil
    --CS.UIEventListener.Get(self.wifeNameTwo.gameObject).OnClickLuaDelegate = self.OnWifeNameTwoClick
    --
    --CS.UIEventListener.Get(self.details.gameObject).LuaEventTable = self
    --CS.UIEventListener.Get(self.details.gameObject).OnClickLuaDelegate = nil
    --CS.UIEventListener.Get(self.details.gameObject).OnClickLuaDelegate = self.OnDetailsBtnClick

end

--endregion

--region Show

function UIRankItemTemplate:SetTemplate(data)
    if data then
        --人物id
        self.rid = data.rid
        --当前排名
        self.rankID = data.rankIndex
        ---@type rankV2.RoleRankInfo
        self.rankData = data.rankInfo
        self.rewardObj = data.rewardObj
        --排行榜配置id
        self.rankConfigId = data.rankConfigId
        self.wifeRankInfo = data.wifeRankInfo
        self.servantRankInfo = data.servantRankInfo
        self.damageItemRankInfo = data.damageItemRankInfo
        self.mClickGoCallBack = data.ClickGoCallBack

        self:SetOtherInfo()
        ---@type luaobject
        self.useTemplate = data.useTemplate:New()
        self:RefreshUseTemplate()
    end
end

function UIRankItemTemplate:SetOtherInfo()

end

function UIRankItemTemplate:RefreshUseTemplate()
    if self.useTemplate then
        self.useTemplate:Show(self)
        self:SetRewardBoxState(false)
    end
end

function UIRankItemTemplate:SetChoseHightState(isOpen)
    if self.ChosenEffect and self.ChosenEffect.gameObject.activeSelf ~= isOpen then
        self.ChosenEffect.gameObject:SetActive(isOpen)
    end
end

function UIRankItemTemplate:SetRewardBoxState(isOpen)
    if self.useTemplate and self:GetRankRewardBox() then
        self:GetRankRewardBox().gameObject:SetActive(self.useTemplate:IsShowBoxBtn() and isOpen)
    end
end

--endregion

--region UI函数监听

function UIRankItemTemplate:OnTemplatBtnClick(go)
    if self.mClickGoCallBack ~= nil then
        self.mClickGoCallBack()
    end
    if self.useTemplate then
        self.useTemplate:OnTemplatBtnClick(self, go)
    end
end

function UIRankItemTemplate:OnWifeNameTwoClick(go)
    if self.useTemplate then
        self.useTemplate:OnWifeNameTwoClick(self, go)
    end
end

function UIRankItemTemplate:OnRewardboxBtnClick(go)
    if self.useTemplate then
        local pos = self:SetRewardPos()
        self.useTemplate:OnRewardboxBtnClick(self, go, pos)
    end
end

---点击详情按钮
function UIRankItemTemplate:OnDetailsBtnClick()
    if self.useTemplate then
        self.useTemplate:OnDetailsBtnClick(self)
    end
end

---返回奖励位置
function UIRankItemTemplate:SetRewardPos()
    if CS.StaticUtility.IsNull(self.rewardObj) or self.rewardObj == nil then
        return CS.UnityEngine.Vector3.zero
    end
    local bg = CS.Utility_Lua.GetComponent(self.rewardObj.transform:Find('bg'), 'UISprite')
    if bg == nil then
        return CS.UnityEngine.Vector3.zero
    end

    --最高点y
    local heightLocalPosy = 179
    --最低点y
    local lowLocalPointy = -290

    --背景高度
    local bghight = bg.height
    local UnitLowpos = self.go.transform:Find('lowPoint').position
    local UnitHightpos = self. go.transform:Find('hightPoint').position

    self.rewardObj.transform.position = UnitHightpos
    local tipsHeightLocalpos = self.rewardObj.transform.localPosition
    local meetHeightPoint = tipsHeightLocalpos.y

    self.rewardObj.transform.position = UnitLowpos
    local tipsLocalLowpos = self.rewardObj.transform.localPosition
    local meetLowPoint = tipsLocalLowpos.y
    local y = meetHeightPoint >= heightLocalPosy and heightLocalPosy or meetHeightPoint - bghight >= lowLocalPointy and meetHeightPoint or meetLowPoint >= lowLocalPointy and meetLowPoint + bghight or lowLocalPointy + bghight
    return self.rewardObj.transform.parent:TransformPoint(CS.UnityEngine.Vector3(tipsLocalLowpos.x, y, 0))
end

--endregion

--region otherFunction

function UIRankItemTemplate:Clear()
    if self.useTemplate then
        self.useTemplate:onDestroy()
    end
end

function UIRankItemTemplate:SetActiveState(key, obj)
    if self.openedCompotantDic == nil then
        self.openedCompotantDic = {}
    end
    if obj ~= nil then
        self.openedCompotantDic[key] = obj
    end
end

--endregion


function UIRankItemTemplate:OnDestroy()
    --UIRankItemTemplate:Clear()
    self.useTemplate:onDestroy()
end

return UIRankItemTemplate