---@class UIRankFeatureBaseTemplate:luaobject 排行榜单元功能基类
local UIRankFeatureBaseTemplate = {}

function UIRankFeatureBaseTemplate:Show(unitTbl)
    if unitTbl == nil then
        return
    end
    ---@type UIRankItemTemplate
    self.unitTbl = unitTbl
    ---@type rankV2.RoleRankInfo
    self.rankData = unitTbl.rankData
    self.rid = unitTbl.rid
    self:RefreshOpendState()
    self:BindEvent()
    self:SetView()
end

function UIRankFeatureBaseTemplate:SetView()
    self:SetTemplate()
    self:SetOther()
    self:TrySetPos()
    self:InitParam()
    self:SetBgSize()
end

function UIRankFeatureBaseTemplate:InitParam()
    self.bgSize = 550
    self.checkBgSize = 550
end

function UIRankFeatureBaseTemplate:SetOther()

end

function UIRankFeatureBaseTemplate:BindEvent()

end

---处理已显示组件逻辑
function UIRankFeatureBaseTemplate:RefreshOpendState()
    if self.unitTbl.openedCompotantDic == nil then
        return
    end
    for i, v in pairs(self.unitTbl.openedCompotantDic) do
        if v ~= nil then
            if not self:GetIsShowOfId(i) then
                v:SetActive(false)
            end
        end
    end
end

function UIRankFeatureBaseTemplate:SetTemplate()
    if self.unitTbl == nil then
        return
    end

    if self.unitTbl:GetRankingSprite() ~= nil then
        self.unitTbl:GetRankingSprite().spriteName = self.unitTbl.rankID > 3 and '' or (self.unitTbl.rankID)
        self.unitTbl:GetRankingSprite().gameObject:SetActive(self:IsShowRanking())
    end

    if self.unitTbl:GetRankingValue() ~= nil then
        self.unitTbl:GetRankingValue().text = self.unitTbl.rankID > 3 and tostring(self.unitTbl.rankID) or ''
        self.unitTbl:GetRankingValue().gameObject:SetActive(self:IsShowRanking())
    end

    if self.unitTbl:GetRankName() ~= nil and self.rankData ~= nil then
        self.unitTbl.promptPoint = self.unitTbl:GetRankName()
        self.unitTbl:GetRankName().text = self.rankData.name
        self.unitTbl:GetRankName().gameObject:SetActive(self:IsShowRankName())
        self.unitTbl:GetRankName():MakePixelPerfect()
    end

    --[[if self.unitTbl:GetRankMothIcon() ~= nil then
        self.unitTbl:GetRankMothIcon().spriteName = self:GetMothName(self.rankData.monthCard)
        --print("spriteName = ",self:GetMothName(self.rankData.monthCard))
        self.unitTbl:GetRankMothIcon():MakePixelPerfect()
        self.unitTbl:GetRankMothIcon():DelayUpdateAnchors()
        self.unitTbl:GetRankMothIcon().gameObject:SetActive(self:IsShowRankNameMothIcon())
            --local memberLevel = self.rankData.vipMemberLevel
            --if memberLevel > 0 then
                --local memberData = clientTableManager.cfg_memberManager:TryGetValue(memberLevel)
                --local spriteName = memberData:GetSpirit()
                --self.unitTbl:GetRankMothIcon().spriteName = spriteName--self:GetMothName(self.rankData.monthCard)
                --self.unitTbl:GetRankMothIcon():MakePixelPerfect()
                --self.unitTbl:GetRankMothIcon():DelayUpdateAnchors()
            --else
                --self.unitTbl:GetRankMothIcon().gameObject:SetActive(false)
            --end
    end
]]
    self.unitTbl.bg.gameObject:SetActive(self.unitTbl.rankID % 2 ~= 1)
    self.unitTbl.chosenhight.gameObject:SetActive(self:IsShowMyMark())
end

function UIRankFeatureBaseTemplate:TrySetPos()
    if self.unitTbl:GetRankingSprite() ~= nil then
        local origionPos = self.unitTbl:GetRankingSprite().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.ranking)
        self.unitTbl:GetRankingSprite().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRankingValue() ~= nil then
        local origionPos = self.unitTbl:GetRankingValue().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.ranking)
        self.unitTbl:GetRankingValue().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRankName() ~= nil then
        local origionPos = self.unitTbl:GetRankName().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.name)
        self.unitTbl:GetRankName().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end

function UIRankFeatureBaseTemplate:SetBgSize()
    if self.unitTbl == nil then
        return
    end
    self.unitTbl.bg.width = self.bgSize
    self.unitTbl.ChosenEffect.width = self.bgSize
end

--region checkActive

--是否显示排行名次
function UIRankFeatureBaseTemplate:IsShowRanking()
    return true
end

--是否显示名字
function UIRankFeatureBaseTemplate:IsShowRankName()
    return true
end

--是否显示商会icon
function UIRankFeatureBaseTemplate:IsShowRankNameMothIcon()
    if self.rankData == nil then
        return false
    end
    return self.rankData.monthCard ~= 0 --true
end

--是否显示职业
function UIRankFeatureBaseTemplate:IsShowRankCareer()
    return false
end

--是否显示职业图片
function UIRankFeatureBaseTemplate:IsShowRankCareerSprite()
    return false
end

--是否显示等级
function UIRankFeatureBaseTemplate:IsShowRankLevel()
    return false
end

--是否需要显示灵兽列表
function UIRankFeatureBaseTemplate:IsShowServantList()
    return false
end

--是否显示划拳积分
function UIRankFeatureBaseTemplate:IsShowFistValue()
    return false
end

--是否需要显示宝箱按钮
function UIRankFeatureBaseTemplate:IsShowBoxBtn()
    return false
end

--是否显示魅力值
function UIRankFeatureBaseTemplate:IsShowCharmValue()
    return false
end

--是否需要显示夫妻信息
function UIRankFeatureBaseTemplate:IsShowLoverValue()
    return false
end

--是否显示亲密度
function UIRankFeatureBaseTemplate:IsShowIntimacy()
    return false
end

--是否显示性别
function UIRankFeatureBaseTemplate:IsShowSex()
    return false
end

--是否显示送花数
function UIRankFeatureBaseTemplate:IsShowFlowerValue()
    return false
end

--是否显示元宝交易额
function UIRankFeatureBaseTemplate:IsShowCoinValue()
    return false
end

--是否显示行会名
function UIRankFeatureBaseTemplate:IsShowUnionName()
    return false
end

--是否显示boss击杀数
function UIRankFeatureBaseTemplate:IsShowKillBossNum()
    return false
end

--是否显示杀人数量
function UIRankFeatureBaseTemplate:IsShowKillPlayerNum()
    return false
end

--是否需要显示装备掉落列表
function UIRankFeatureBaseTemplate:IsShowDropItemList()
    return false
end

--是否需要显示详情按钮
function UIRankFeatureBaseTemplate:IsShowDetailBtn()
    return false
end

--是否需要显示战勋
function UIRankFeatureBaseTemplate:IsShowPrefix()
    return false
end

--是否显示自己标记
function UIRankFeatureBaseTemplate:IsShowMyMark()
    return self.rid ~= nil and self.rid == CS.CSScene.MainPlayerInfo.ID
end

--是否显示法阵等级
function UIRankFeatureBaseTemplate:IsShowFormationLevle()
    return false
end

--endregion

--region UI函数回调

---点击回调
---@param target UIRankItemTemplate
function UIRankFeatureBaseTemplate:OnTemplatBtnClick(target, go)
    if target.rankData == nil then
        return
    end
    ---@type UIRankPanel
    local panel = uimanager:GetPanel("UIRankPanel")
    if panel then
        panel.OnHideReward(nil)
        panel.RefreshModelView(target.rid, target.rankData)
    end
--[[    local panel = uimanager:GetPanel("UIRankPanel")
    if panel then
        panel.OnHideReward(nil)
        if target.rankData.uid == CS.CSScene.MainPlayerInfo.ID then
            if target:GetRankName() ~= nil then
                Utility.ShowPopoTips(target:GetRankName().gameObject, nil, 308, "UIRankPanel")
            end
            return
        end

        uimanager:CreatePanel("UIGuildTipsPanel", nil, {
            panelType = LuaEnumPanelIDType.RankPanel_RoleInfo,
            roleId = target.rid,
            roleName = target.rankData.name,
            roleSex = target.rankData.sex,
            roleCareer = target.rankData.career,
            hostId = target.rankData.sid,
        })
    end]]
end

function UIRankFeatureBaseTemplate:OnWifeNameTwoClick(target, go)

end

function UIRankFeatureBaseTemplate:OnRewardboxBtnClick(target, go, pos)
    if not self:IsShowBoxBtn() then
        return
    end
    --根据排行读rank表的奖励
    local panel = uimanager:GetPanel("UIRankPanel")
    if panel == nil then
        return
    end
    panel.GetRewardCallBack(target.rankConfigId, target.rankID)
    --local rewardArray, titleInfo = CS.Cfg_RankingRewardTableManager.Instance:GetReward(target.rankConfigId, target.rankID)
    --panel.RefreshReward(go, rewardArray, pos, titleInfo)

end

function UIRankFeatureBaseTemplate:OnDetailsBtnClick(target)

end
--endregion

--region otherFunc

function UIRankFeatureBaseTemplate:GetCurCareer()
    if self.rankData == nil then
        return ""
    end
    return self.rankData.career == LuaEnumCareer.Warrior and "战士" or self.rankData.career == LuaEnumCareer.Master and "法师" or "道士"
end

function UIRankFeatureBaseTemplate:GetCurSex()
    if self.rankData == nil then
        return ""
    end
    return self.rankData.sex == LuaEnumSex.Man and "男" or "女"
end

---根据id处理显示逻辑
function UIRankFeatureBaseTemplate:GetIsShowOfId(id)
    if id == LuaRankComponentSystem.career then
        return self:IsShowRankCareer()
    elseif id == LuaRankComponentSystem.level then
        return self:IsShowRankLevel()
    elseif id == LuaRankComponentSystem.servant then
        return self:IsShowServantList()
    elseif id == LuaRankComponentSystem.finger then
        return self:IsShowFistValue()
    elseif id == LuaRankComponentSystem.rewardBox then
        return self:IsShowBoxBtn()
    elseif id == LuaRankComponentSystem.charm then
        return self:IsShowCharmValue()
    elseif id == LuaRankComponentSystem.lover then
        return self:IsShowLoverValue()
    elseif id == LuaRankComponentSystem.intimacy then
        return self:IsShowIntimacy()
    elseif id == LuaRankComponentSystem.sex then
        return self:IsShowSex()
    elseif id == LuaRankComponentSystem.flower then
        return self:IsShowFlowerValue()
    elseif id == LuaRankComponentSystem.dealIngot then
        return self:IsShowCoinValue()
    elseif id == LuaRankComponentSystem.guild then
        return self:IsShowUnionName()
    elseif id == LuaRankComponentSystem.killBoss then
        return self:IsShowKillBossNum()
    elseif id == LuaRankComponentSystem.KillPlayer then
        return self:IsShowKillPlayerNum()
    elseif id == LuaRankComponentSystem.quiteDrop then
        return self:IsShowDropItemList()
    elseif id == LuaRankComponentSystem.details then
        return self:IsShowDetailBtn()
    elseif id == LuaRankComponentSystem.prefix then
        return self:IsShowPrefix()
    elseif id == LuaRankComponentSystem.formation then
        return self:IsShowFormationLevle()
    end
    return false
end

---获取商会前缀图片名称
function UIRankFeatureBaseTemplate:GetMothName(monthCardId)
    return monthCardId == 1 and 'Commerce_bq' or monthCardId == 2 and 'Commerce_mc' or ''
end

--endregion

--region ondestroy

function UIRankFeatureBaseTemplate:onDestroy()
    self.unitTbl = nil
    self.rid = nil
    self.rankData = nil
end

--endregion

return UIRankFeatureBaseTemplate