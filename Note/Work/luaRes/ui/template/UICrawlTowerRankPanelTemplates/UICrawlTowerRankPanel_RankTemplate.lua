---@class UICrawlTowerRankPanel_RankTemplate:TemplateBase 闯天关单个模板
local UICrawlTowerRankPanel_RankTemplate = {}

---@return UISprite 排名图片
function UICrawlTowerRankPanel_RankTemplate:GetRank_UISprite()
    if self.mRankSp == nil then
        self.mRankSp = self:Get("Total/rankingSprite", "UISprite")
    end
    return self.mRankSp
end

---@return UILabel 排名文本
function UICrawlTowerRankPanel_RankTemplate:GetRank_UILabel()
    if self.mRankLb == nil then
        self.mRankLb = self:Get("Total/rankingValue", "UILabel")
    end
    return self.mRankLb
end

---@return UILabel 名字
function UICrawlTowerRankPanel_RankTemplate:GetName_Lb()
    if self.mNameLb == nil then
        self.mNameLb = self:Get("name", "UILabel")
    end
    return self.mNameLb
end

---@return UILabel 等级
function UICrawlTowerRankPanel_RankTemplate:GetLevel_UILabel()
    if self.mLevelLb == nil then
        self.mLevelLb = self:Get("level", "UILabel")
    end
    return self.mLevelLb
end

---@return UILabel 层数
function UICrawlTowerRankPanel_RankTemplate:GetFloor_UILabel()
    if self.mFloorLb == nil then
        self.mFloorLb = self:Get("floor", "UILabel")
    end
    return self.mFloorLb
end

---@return UnityEngine.GameObject 自己
function UICrawlTowerRankPanel_RankTemplate:GetSelf_Go()
    if self.mSelfGo == nil then
        self.mSelfGo = self:Get("chosenhight", "GameObject")
    end
    return self.mSelfGo
end

---@return UnityEngine.GameObject 选中
function UICrawlTowerRankPanel_RankTemplate:GetChoose_Go()
    if self.mChooseGo == nil then
        self.mChooseGo = self:Get("ChosenEffect", "GameObject")
    end
    return self.mChooseGo
end

---@return UISprite 背景图片
function UICrawlTowerRankPanel_RankTemplate:GetBg_UISprite()
    if self.mBgSp == nil then
        self.mBgSp = self:Get("Background", "UISprite")
    end
    return self.mBgSp
end

---@param panel UICrawlTowerRankPanel
function UICrawlTowerRankPanel_RankTemplate:Init(panel)
    self.mRootPanel = panel
    self:BindEvents()
end

function UICrawlTowerRankPanel_RankTemplate:BindEvents()
    if self.mRootPanel then
        CS.UIEventListener.Get(self.go).onClick = function()
            self.mRootPanel:ChooseItem(self.rankInfo)
        end
    end
end

---@param rankInfo rankV2.RoleRankDataInfo
function UICrawlTowerRankPanel_RankTemplate:RefreshSingleRank(rankInfo, line, selfRank)
    self.rankInfo = rankInfo
    self.mRoleId = rankInfo.roleRankInfo.uid
    self:GetFloor_UILabel().text = rankInfo.roleRankInfo.towerHigh
    self:GetLevel_UILabel().text = rankInfo.roleRankInfo.level
    self:GetName_Lb().text = rankInfo.roleRankInfo.name
    if line + 1 > 3 then
        self:GetRank_UILabel().text = line + 1
    else
        self:GetRank_UISprite().spriteName = tostring(line + 1)
    end
    self:GetRank_UISprite().gameObject:SetActive(line + 1 <= 3)
    self:GetRank_UILabel().gameObject:SetActive(line + 1 > 3)
    self:GetSelf_Go():SetActive(selfRank == line + 1)
    self:GetBg_UISprite().color = line % 2 == 0 and LuaEnumUnityColorType.Normal or LuaEnumUnityColorType.Transparent
end

function UICrawlTowerRankPanel_RankTemplate:ChooseItem(isChoose)
    self:GetChoose_Go():SetActive(isChoose)
end

return UICrawlTowerRankPanel_RankTemplate