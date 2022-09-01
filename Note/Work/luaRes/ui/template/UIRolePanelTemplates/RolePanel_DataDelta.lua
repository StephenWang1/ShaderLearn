---@class RolePanel_DataDelta:TemplateBase
local RolePanel_DataDelta = {}
function RolePanel_DataDelta:Init()
    self:InitComponents()
end

function RolePanel_DataDelta:InitComponents()
    ---@type Top_UILabel
    self.baojishanghai = self:Get("Main/Scroll View/Attribute/baojishanghai", "Top_UILabel")
    ---@type Top_UILabel
    self.baoji = self:Get("Main/Scroll View/Attribute/baoji", "Top_UILabel")
    ---@type Top_UILabel
    self.shengwang = self:Get("Main/Scroll View/shengwang", "Top_UILabel")
    ---@type Top_UILabel
    self.xingyun = self:Get("Main/Scroll View/Attribute/xingyun", "Top_UILabel")
    ---@type Top_UILabel
    self.gongxun = self:Get("Main/Scroll View/gongxun", "Top_UILabel")
    ---@type Top_UILabel
    self.shanbi = self:Get("Main/Scroll View/Attribute/shanbi", "Top_UILabel")
    ---@type Top_UILabel
    self.PKfangyu = self:Get("Main/Scroll View/Attribute/PKfangyu", "Top_UILabel")
    ---@type Top_UILabel
    self.mofahuifu = self:Get("Main/Scroll View/Attribute/mofahuifu", "Top_UILabel")
    ---@type Top_UILabel
    self.shengminghuifu = self:Get("Main/Scroll View/Attribute/shengminghuifu", "Top_UILabel")
    ---@type Top_UILabel
    self.zhuansheng = self:Get("Main/Scroll View/zhuansheng", "Top_UILabel")
    ---@type Top_UILabel
    self.shenshenggong = self:Get("Main/Scroll View/Attribute/shenshenggongji", "Top_UILabel")
    ---@type Top_UILabel
    self.shenshengfang = self:Get("Main/Scroll View/Attribute/shenshengfangyu", "Top_UILabel")
    ---@type Top_UILabel
    ---对战增伤
    self.duizhanzengshang = self:Get("Main/Scroll View/Attribute/duizhanzengshang", "Top_UILabel")
    ---@type Top_UILabel
    ---受战减伤
    self.shouzhanjianshang = self:Get("Main/Scroll View/Attribute/shouzhanjianshang", "Top_UILabel")
    ---@type Top_UILabel
    ---对法增伤
    self.duifazengshang = self:Get("Main/Scroll View/Attribute/duifazengshang", "Top_UILabel")
    ---@type Top_UILabel
    ---受法减伤
    self.shoufajianshang = self:Get("Main/Scroll View/Attribute/shoufajianshang", "Top_UILabel")
    ---@type Top_UILabel
    ---对道增伤
    self.duidaozengshang = self:Get("Main/Scroll View/Attribute/duidaozengshang", "Top_UILabel")
    ---@type Top_UILabel
    ---受道减伤
    self.shoudaojianshang = self:Get("Main/Scroll View/Attribute/shoudaojianshang", "Top_UILabel")

    ---@type Top_UILabel
    self.dengji = self:Get("Main/Scroll View/dengji", "Top_UILabel")
    ---@type Top_UILabel
    self.chuantou = self:Get("Main/Scroll View/Attribute/chuantou", "Top_UILabel")
    ---@type Top_UILabel
    self.wulifangyu = self:Get("Main/Scroll View/Attribute/wulifangyu", "Top_UILabel")
    ---@type Top_UILabel
    self.zhunque = self:Get("Main/Scroll View/Attribute/zhunque", "Top_UILabel")
    ---@type Top_UILabel
    self.hanghui = self:Get("Main/Scroll View/hanghui", "Top_UILabel")
    ---@type Top_UILabel
    self.sudu = self:Get("Main/Scroll View/Attribute/sudu", "Top_UILabel")
    ---@type Top_UILabel
    self.mofafangyu = self:Get("Main/Scroll View/Attribute/mofafangyu", "Top_UILabel")
    ---@type Top_UILabel
    self.InnerPower = self:Get("Main/Scroll View/Attribute/InnerPower", "Top_UILabel")
    ---@type Top_UILabel
    self.baojikangxing = self:Get("Main/Scroll View/Attribute/baojikangxing", "Top_UILabel")
    ---@type Top_UIPopupList
    self.moshi_popuplist = self:Get("Main/Scroll View/moshi/DropDown", "Top_UIDropDown")
    ---@type UnityEngine.GameObject
    self.moshi_GameObject = self:Get("Main/Scroll View/moshi/DropDown/Caption", "GameObject")
    ---@type Top_UILabel
    self.moshi_label = self:Get("Main/Scroll View/moshi/DropDown/CaptionLabel", "Top_UILabel")
    ---@type Top_UILabel
    self.moshi_ArrowBtn = self:Get("Main/Scroll View/moshi/DropDown/Btn_program", "GameObject")
    ---@type Top_UILabel
    self.PKgongji = self:Get("Main/Scroll View/Attribute/PKgongji", "Top_UILabel")
    ---@type Top_UILabel
    self.gongji = self:Get("Main/Scroll View/Attribute/gongji", "Top_UILabel")
    ---@type Top_UILabel
    self.gongji_Label = self:Get("Main/Scroll View/Attribute/gongji/Label", "Top_UILabel")
    ---@type Top_UILabel
    self.shengming = self:Get("Main/Scroll View/Attribute/shengming", "Top_UILabel")
    ---@type Top_UILabel
    self.shengming_Label = self:Get("Main/Scroll View/Attribute/shengming/Label", "Top_UILabel")
    ---@type Top_UILabel
    self.moshi_Light = self:Get("Main/light", "GameObject")
    ---@type Top_UILabel
    self.weiming = self:Get("Main/Scroll View/weiming", "Top_UILabel")
    self.PKModelBG = self:Get("Main/Scroll View/moshi/DropDown/Template", "GameObject")
    self.renxing = self:Get("Main/Scroll View/Attribute/renxing", "Top_UILabel")
    self.huoyan = self:Get("Main/Scroll View/Attribute/huoyan", "Top_UILabel")
    self.bingshuang = self:Get("Main/Scroll View/Attribute/bingshuang", "Top_UILabel")
    self.leiting = self:Get("Main/Scroll View/Attribute/leiting", "Top_UILabel")
    self.anying = self:Get("Main/Scroll View/Attribute/anying", "Top_UILabel")
    self.chuanci = self:Get("Main/Scroll View/Attribute/chuanci", "Top_UILabel")

    ---魔法（MP）
    ---@type Top_UILabel
    self.maxMp_Label = self:Get("Main/Scroll View/Attribute/fali", "Top_UILabel")

    ---@param DropdownData Top_UIDropDownDropdownData
    self.moshi_popuplist.CanItemSelectChange = function(DropdownData, go)
        if DropdownData then
            if DropdownData.Label == "队伍" then
                return Utility.TryChangeMode(go, 1, 1)
            elseif DropdownData.Label == "行会" then
                return Utility.TryChangeMode(go, 2, 1)
            end
        end
        return true
    end

    self.moshi_popuplist.OnValueChange:Add(function(eventTemp)
        local pkmode = nil
        if eventTemp.Label == "和平" then
            pkmode = Utility.EnumToInt(CS.PkMode.Peace)
        elseif eventTemp.Label == "队伍" then
            pkmode = Utility.EnumToInt(CS.PkMode.Team)
        elseif eventTemp.Label == "行会" then
            pkmode = Utility.EnumToInt(CS.PkMode.Union)
        elseif eventTemp.Label == "全体" then
            pkmode = Utility.EnumToInt(CS.PkMode.All)
            --elseif eventTemp.Label == "善恶" then
            --    pkmode = Utility.EnumToInt(CS.PkMode.Red)
        end
        if pkmode ~= nil then
            networkRequest.ReqSwitchFightModel(pkmode)
            CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(CS.EConfigOption.PkMode, pkmode)
            self.pkMode = pkmode
        end
        --self.PKModelBoxCollider:SetActive(false)
        --self.inPKModelBoxCollider:SetActive(false)
    end)
    self.moshi_popuplist.LuaEventTable = self
    self.moshi_popuplist:AddClickArrowEvent(self.CheckCanChange)
end

---刷新属性
function RolePanel_DataDelta:RefreshAttribute()
    coroutine.yield(0);
    self:Show()
end

function RolePanel_DataDelta:Show()
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    local p0, p1
    self.fontColor = "[dde6eb]"
    self.dengji.text = self.fontColor .. tostring(CS.CSScene.MainPlayerInfo.Level)
    self.zhuansheng.text = self.fontColor .. tostring(CS.CSScene.MainPlayerInfo.ReinLevel)
    self.weiming.text = self.fontColor .. "暂无"
    local prefixID = CS.CSScene.MainPlayerInfo.PrefixId
    local str = CS.Cfg_PrefixTableManager.Instance:GetPrefixName(CS.CSScene.MainPlayerInfo.PrefixId, CS.CSScene.MainPlayerInfo.Career)
    str = str == "" and '暂无' or str
    self.gongxun.text = self.fontColor .. str
    self.hanghui.text = self.fontColor .. "暂无"

    ---PK模式
    local pkMode = CS.CSScene.MainPlayerInfo.PKMode
    if pkMode == Utility.EnumToInt(CS.PkMode.Peace) then
        self.moshi_label.text = "和平"
    elseif pkMode == Utility.EnumToInt(CS.PkMode.Team) then
        self.moshi_label.text = "队伍"
    elseif pkMode == Utility.EnumToInt(CS.PkMode.Union) then
        self.moshi_label.text = "行会"
    elseif pkMode == Utility.EnumToInt(CS.PkMode.All) then
        self.moshi_label.text = "全体"
        --elseif pkMode == Utility.EnumToInt(CS.PkMode.Red) then
        --    self.moshi_label.text = "善恶"
    end
    --
    --print("RolePanel_DataDelta Show")
    self.gongji_Label.text = "[878787]" .. Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
    if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
        p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.showPhyAttackMin))
        p1 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.showPhyAttackMax))
        self.gongji.text = self.fontColor .. p0 .. "-" .. p1
    elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
        p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.showMagicAttackMin))
        p1 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.showMagicAttackMax))
        self.gongji.text = self.fontColor .. p0 .. "-" .. p1
    elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
        p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.showTaoAttackMin))
        p1 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.showTaoAttackMax))
        self.gongji.text = self.fontColor .. p0 .. "-" .. p1
    end
    self.shengming.text = self.fontColor .. CS.CSScene.MainPlayerInfo.MaxHP

    self.maxMp_Label.text = self.fontColor .. mainPlayerInfo.MaxMP

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.PhyDefenceMin))
    p1 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.PhyDefenceMax))
    self.wulifangyu.text = self.fontColor .. p0 .. "-" .. p1

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.MagicDefenceMin))
    p1 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.MagicDefenceMax))
    self.mofafangyu.text = self.fontColor .. p0 .. "-" .. p1

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.Accurate))
    self.zhunque.text = self.fontColor .. p0 .. ""

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.Dodge))
    self.shanbi.text = self.fontColor .. p0 .. ""

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.AttackSpeed))
    self.sudu.text = self.fontColor .. p0 .. ""

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.CriticalDamage))
    self.baojishanghai.text = self.fontColor .. p0 .. ""

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.showCritical))
    p0 = self:GetPercentShowValue(p0)
    self.baoji.text = self.fontColor .. p0 .. "%"

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.HpRecover))
    self.shengminghuifu.text = self.fontColor .. p0 .. ""

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.MpRecover))
    self.mofahuifu.text = self.fontColor .. p0 .. ""

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.HolyAttackMax))
    p1 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.HolyAttackMin))
    self.shenshenggong.text = self.fontColor .. p0

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.HolyDefenceMax))
    p1 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.HolyDefenceMin))
    self.shenshengfang.text = self.fontColor .. p1 .. "-" .. p0

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.PkAtt))
    self.PKgongji.text = self.fontColor .. p0 .. ""

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.PkDef))
    self.PKfangyu.text = self.fontColor .. p0 .. ""

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.Luck))
    self.xingyun.text = self.fontColor .. p0 .. ""

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.ResistanceCrit))
    p0 = self:GetPercentShowValue(p0)
    self.baojikangxing.text = self.fontColor .. p0 .. "%"

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.PenetrationAttributes))
    self.chuantou.text = self.fontColor .. p0 .. ""

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.InnerPowerMax))
    self.InnerPower.text = self.fontColor .. p0 .. ""

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.curse))
    self.renxing.text = self.fontColor .. p0 .. ""

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.FireAttackMin))
    p1 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.FireAttackMax))
    self.huoyan.text = self.fontColor .. p0 .. "-" .. p1

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.IceAttackMin))
    p1 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.IceAttackMax))
    self.bingshuang.text = self.fontColor .. p0 .. "-" .. p1

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.ElectricAttackMin))
    p1 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.ElectricAttackMax))
    self.leiting.text = self.fontColor .. p0 .. "-" .. p1

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.DarkAttackMin))
    p1 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.DarkAttackMax))
    self.anying.text = self.fontColor .. p0 .. "-" .. p1

    p0 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.PunctureAttackMin))
    p1 = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.PunctureAttackMax))
    self.chuanci.text = self.fontColor .. p0 .. "-" .. p1

    local mBagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    local value = mBagInfo:GetCoinAmount(LuaEnumCoinType.ShengWang);
    if value == 0 then
        value = "暂无"
    end
    self.shengwang.text = self.fontColor .. value
    self:RefreshTalent()
end

--region 封号天赋
function RolePanel_DataDelta:RefreshTalent()
    local talentData = gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():GetTalentData()
    local ismeet = talentData and #talentData >= 6 and self.duizhanzengshang
    if ismeet then
        self.duizhanzengshang.text = self:GetRateShow(talentData[1])
        self.shouzhanjianshang.text = self:GetRateShow(talentData[2])
        self.duifazengshang.text = self:GetRateShow(talentData[3])
        self.shoufajianshang.text = self:GetRateShow(talentData[4])
        self.duidaozengshang.text = self:GetRateShow(talentData[5])
        self.shoudaojianshang.text = self:GetRateShow(talentData[6])
    end
    self.duizhanzengshang.gameObject:SetActive(ismeet and talentData[1] ~= 0)
    self.shouzhanjianshang.gameObject:SetActive(ismeet and talentData[2] ~= 0)
    self.duifazengshang.gameObject:SetActive(ismeet and talentData[3] ~= 0)
    self.shoufajianshang.gameObject:SetActive(ismeet and talentData[4] ~= 0)
    self.duidaozengshang.gameObject:SetActive(ismeet and talentData[5] ~= 0)
    self.shoudaojianshang.gameObject:SetActive(ismeet and talentData[6] ~= 0)
end

---@return string 百分比数值
function RolePanel_DataDelta:GetRateShow(data)
    if data then
        return "[dde6eb]".. Utility.RemoveEndZero(data / 100) .. "%"
    end
end
--endregion

---获取百分比显示数据
function RolePanel_DataDelta:GetPercentShowValue(value)
    local showValue = value * 0.01
    local a, b = math.modf(tonumber(showValue))
    return ternary(b > 0, showValue, a)
end

---切换模式高亮
function RolePanel_DataDelta:ChangeMoShiLight(state)
    if self.moshi_Light ~= nil then
        self.moshi_Light:SetActive(state)
    end
end

function RolePanel_DataDelta:CheckCanChange()
    self:ChangeMoShiLight(false)
    return Utility.CheckChangePkMode({ dropDown = self.moshi_popuplist, parent = self.moshi_ArrowBtn.transform })
end

return RolePanel_DataDelta