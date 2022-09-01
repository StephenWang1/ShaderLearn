---@class UIStrengthenSkillPanel
local UIStrengthenSkillPanel = {}

function UIStrengthenSkillPanel:InitComponents()

    --region 当前等级
    ---@type Top_UILabel
    ---详细信息面板
    self.infoPanel = self.go
    ---@type UIPanel
    self.infoPanel_UIPanel = self:GetCurComp("WidgetRoot/infoPanel", "UIPanel")
    self.infoPanelBG = self:GetCurComp("WidgetRoot/infoPanel/bg", "Top_UISprite")
    self.infoPanelBGWidget = self:GetCurComp("WidgetRoot/infoPanel/bg", "UIWidget");
    ---当前技能节点
    self.currentSkill = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/currentSkill", "GameObject")
    ---当前等级
    self.skillLevel = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/currentSkill/skillLevel", "Top_UILabel")
    ---技能说明
    self.skillDescription = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/currentSkill/skillDescription", "Top_UILabel")
    --endregion

    --region 下一等级
    ---@type Top_UILabel
    ---技能等级_下一等级
    self.skillLevel_next = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/nextSkill/skillLevel", "Top_UILabel")
    ---技能描述_下一等级
    self.skillDescription_next = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/nextSkill/skillDescription", "Top_UILabel")
    ---技能以满级_下一等级
    self.maxLevelTips_next = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/nextSkill/maxLevelTips", "Top_UILabel")
    ---等级需求_下一等级
    self.requireLevel_next = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/nextSkill/upgradeRequire/requireLevel", "Top_UILabel")
    --endregion

    ---@type UIWidget
    ---界面适配相关
    self.mStateLabel = self:GetCurComp("WidgetRoot/infoPanel/skillIcon/stateLabel", "UILabel");

    self.mSkillIcon = self:GetCurComp("WidgetRoot/infoPanel/skillIcon", "UISprite");

    self.mSkillIconMatchNode = self:GetCurComp("WidgetRoot/infoPanel/skillIcon/matchNode", "Transform");

    self.skillName = self:GetCurComp("WidgetRoot/infoPanel/skillName", "UILabel");

    self.mBgSprite = self:GetCurComp("WidgetRoot/infoPanel/bg", "UISprite");

    self.nextSkillWidget = self:GetCurComp("WidgetRoot/infoPanel/nextSkill", "UIWidget");
    ---获取方式节点
    self.GetWay = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/GetWay", "GameObject");
    ---获取方式列表
    self.GetWayItemGrid = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/GetWay/itemGrid", "Top_UIGridContainer");
    ---Table
    self.skillInfoUITable = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot", "Top_UITable");
    ---ScrollView
    self.skillInfoScrollView = self:GetCurComp("WidgetRoot/infoPanel/skillInfo", "Top_UIScrollView");

    ---技能等级
    self.topSkillLevel = self:GetCurComp("WidgetRoot/infoPanel/skillLevel", "UILabel");
    ---使用技能书按钮
    self.UseSkillBookBtn = self:GetCurComp("WidgetRoot/infoPanel/UseSkillBookBtn", "GameObject");
end

function UIStrengthenSkillPanel:InitOther()
    ---橘黄色---灰色
    self.Orange = '[787878]'
    ---绿色---白色
    self.Green = '[dde6eb]'
    ---淡黄颜色---白色
    self.Yellowish = '[dde6eb]'
    ---白色
    self.White = luaEnumColorType.Gray
    ---红色
    self.Red = '[FF0000]'
    ---空位
    self.BLANK = '   '
    ---延时刷新参数
    self.DelayRefresh = nil
    ---当前坐标
    self.nowPos = self.go.transform.position

    CS.UIEventListener.Get(self.UseSkillBookBtn.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.UseSkillBookBtn.gameObject).OnClickLuaDelegate = self.OnUseSkillBookBtn

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSkillMessage, function()
        self:RefreshUI()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOneSkillChangeMessage, function()
        self:RefreshUI()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSkillBookUseMessage, function()
        self:RefreshUI()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, function()
        self:RefreshUseSkillBookBtn()
    end)
end

---初始化数据
function UIStrengthenSkillPanel:Init()
    self:InitComponents()
    self:InitOther()
end

function UIStrengthenSkillPanel:Show(skillID, proofreadObj)
    self.skillID = skillID
    ---校对面板
    self.proofreadObj = proofreadObj

    self:RefreshUI()
    self.UseSkillBookBtn.gameObject:SetActive(false)
end

---刷新UI数据
function UIStrengthenSkillPanel:RefreshUI()
    if self.skillID == nil then
        return
    end
    self:GetData(self.skillID)
    self:RefreShTopSkillInfo()
    self:RefreshNowSkillInfo()
    self:RefreshNextSkillInfo()
    self:RefreShGetWay()
    self.DelayRefresh = nil
end

---位置适配
function UIStrengthenSkillPanel:AdaptiveSize()
    self.skillInfoUITable:Reposition()
    self.skillInfoScrollView:ResetPosition()
    local Bounds = CS.NGUIMath.CalculateRelativeWidgetBounds(self.skillInfoUITable.gameObject.transform);
    local Bounds2 = CS.NGUIMath.CalculateRelativeWidgetBounds(self.infoPanelBG.gameObject.transform);
    if Bounds then
        local height = Bounds.size.y + 140
        self.infoPanelBG.height = math.ceil(height)
    end
    if self.proofreadObj ~= nil then
        self.nowPos.y = self.proofreadObj.transform.position.y
        self.go.transform.position = self.nowPos
    end
end

function update()
    ---延时一帧刷新
    if UIStrengthenSkillPanel.DelayRefresh == nil then
        UIStrengthenSkillPanel:AdaptiveSize()
        UIStrengthenSkillPanel.DelayRefresh = true
    end
end

---得到技能数据
function UIStrengthenSkillPanel:GetData(skillID)
    ---@type TABLE.cfg_skills 技能表信息
    self.Skill = nil
    ---@type TABLE.cfg_skills_condition 当前技能详细信息
    self.SkillsCondition_Now = nil
    ---@type TABLE.cfg_skills_condition 下一级技能详细信息
    self.SkillsCondition_Next = nil

    ---@type table<number,LuaSkillDetailedInfo>
    self.SkillInfoDic = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr().SkillInfoDic
    if self.SkillInfoDic ~= nil then
        ---@type LuaSkillDetailedInfo
        self.NowSkillInfo = self.SkillInfoDic[skillID]
    end
    if self.NowSkillInfo ~= nil then
        ---@type TABLE.cfg_skills
        self.Skill = self.NowSkillInfo:GetSkillTable()
        ---@type TABLE.cfg_skills_condition
        self.SkillsCondition_Now = self.NowSkillInfo:GetNowSkillsConditionTable()
        ---@type TABLE.cfg_skills_condition
        self.SkillsCondition_Next = self.NowSkillInfo:GetNextSkillsConditionTable()
    end
end

---刷新当前技能信息
function UIStrengthenSkillPanel:RefreshNowSkillInfo()
    if self.SkillsCondition_Now ~= nil then
        local level = self.SkillsCondition_Now:GetLevel()
        self.skillLevel.text = table.concat({ self.White, '当前等级', self.BLANK, self.White, math.max(level, 0), "级" })
        self.skillDescription.text = CS.Cfg_SkillsConditionManager.Instance:GetSecretSkillShowText(self.SkillsCondition_Now:GetId(), "[ffe36f]");
    else
        self.skillLevel.text = ''
        self.skillDescription.text = ''
    end
    self.currentSkill.gameObject:SetActive(self.SkillsCondition_Now ~= nil)
end

---刷新下一级技能信息
function UIStrengthenSkillPanel:RefreshNextSkillInfo()
    local level = ''
    local show = ''
    local needLevel = 0
    local nextSkillsConditionId = 0
    local nextlevelColor = self.Green
    self.IsSkillMax = self.SkillsCondition_Next == nil and self.SkillsCondition_Now ~= nil
    self.IsStudy = self.SkillsCondition_Now ~= nil
    self.maxLevelTips_next.gameObject:SetActive(self.IsSkillMax)
    --学习了技能但是未满级
    if self.IsStudy and self.IsSkillMax == false then
        if self.SkillsCondition_Next ~= nil then
            level = self.SkillsCondition_Next:GetLevel()
            show = self.SkillsCondition_Next:GetShow()
            needLevel = CS.Cfg_ConditionManager.Instance:GetCanLearnSkillLevel(self.SkillsCondition_Next:GetId())
            nextSkillsConditionId = self.SkillsCondition_Next:GetId()
        end
        --未学习技能
    elseif self.IsStudy == false then
        local nowInfo = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(self.Skill.id, 1)
        if nowInfo ~= nil then
            level = nowInfo.level
            show = nowInfo.show
            needLevel = CS.Cfg_ConditionManager.Instance:GetCanLearnSkillLevel(nowInfo.id)
            nextSkillsConditionId = nowInfo.id
        end
    end

    self.IsReachStudyLevel = CS.CSScene.MainPlayerInfo.Level >= needLevel and not self.IsSkillMax
    if self.IsReachStudyLevel == false then
        nextlevelColor = self.Red
    end

    if self.IsSkillMax then
        self.skillLevel_next.text = ''
        self.skillDescription_next.text = ''
        self.requireLevel_next.text = ''
        self.requireLevel_next.gameObject.transform.parent.gameObject:SetActive(false);
    else
        if self.Skill and self.Skill.id then
            if self.Skill.cls == 4 then
                level = level + 1
            end
        end
        self.skillLevel_next.text = table.concat({ self.White, '下一等级', self.BLANK, math.max(level, 0), "级" })
        self.skillDescription_next.text = CS.Cfg_SkillsConditionManager.Instance:GetSecretSkillShowText(nextSkillsConditionId, "[00ff00]");  --table.concat({ self.Orange, show })
        self.requireLevel_next.text = table.concat({ self.Orange, nextlevelColor, needLevel, "级" })
        self.requireLevel_next.gameObject.transform.parent.gameObject:SetActive(needLevel > CS.CSScene.MainPlayerInfo.Level);
    end
end

--region 刷新顶部技能数据

---刷新顶部技能数据
function UIStrengthenSkillPanel:RefreShTopSkillInfo()
    if self.Skill ~= nil then
        self.mSkillIcon.spriteName = self.Skill:GetIcon()
        self.skillName.text = '[dde6eb]' .. self.Skill:GetName()
        local IsStudy = self.SkillsCondition_Now;
        self.mSkillIcon.color = not IsStudy and CS.UnityEngine.Color.black or CS.UnityEngine.Color.white
    end
    if self.NowSkillInfo ~= nil then
        self.topSkillLevel.text = "当前强化   " .. tostring(self.NowSkillInfo.level) .. "段"
    end
    self:RefreshUseSkillBookBtn()
end

function UIStrengthenSkillPanel:RefreshUseSkillBookBtn()
    --if self.NowSkillInfo == nil then
    --    return
    --end
    --local ishaveSkillBook, bagItemInfo, skillTable = self.NowSkillInfo:GetSkillBookBagItem()
    --self.IntensifySkillBook_bagItemInfo = bagItemInfo
    --local isshowBtn = ishaveSkillBook and self.NowSkillInfo:IsSkillMax() == false
    --self.UseSkillBookBtn.gameObject:SetActive(false)
end

--endregion

--region 刷新获取途径
---刷新获取途径
function UIStrengthenSkillPanel:RefreShGetWay()
    local isShowGetWay = self:IsShowGetWay()
    self.GetWay.gameObject:SetActive(isShowGetWay)
    if isShowGetWay then
        self:SetGetWay()
    end
end

---设置获取方式
function UIStrengthenSkillPanel:SetGetWay()
    local data = self:GetWayIdList()
    if data == nil then
        self.GetWay.gameObject:SetActive(false)
        return
    end
    self.GetWayItemGrid.MaxCount = #data;
    for i = 1, #data do
        local gobj = self.GetWayItemGrid.controlList[i - 1];
        local temp = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIWayGetUnitTemplate);
        temp:UpdateUnit(data[i]);
    end
end

---得到获取途径ID列表
function UIStrengthenSkillPanel:GetWayIdList()
    if self.Skill == nil then
        return nil
    end
    local skillBookID = self:GetSkillUseBookID()
    if skillBookID == nil or skillBookID == 0 then
        return nil
    end
    local isfind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(skillBookID)
    if isfind == false then
        return nil;
    end
    if itemInfo.wayGet == nil then
        return nil
    end
    if itemInfo.wayGet.list.Count == 0 then
        return nil
    end
    local dataList = {}
    for i = 0, itemInfo.wayGet.list.Count - 1 do
        local isfind, wayGetInfoTemp = CS.Cfg_Way_GetTableManager.Instance:TryGetValue(itemInfo.wayGet.list[i])
        if isfind and wayGetInfoTemp.openType ~= 3 and wayGetInfoTemp.openType ~= 8 then
            if (wayGetInfoTemp.conditions ~= nil and wayGetInfoTemp.conditions.list.Count > 0) then
                if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(wayGetInfoTemp.conditions.list)) then
                    table.insert(dataList, itemInfo.wayGet.list[i])
                end
            else
                table.insert(dataList, itemInfo.wayGet.list[i])
            end
        end
    end
    return dataList
end

---得到技能使用技能书ID
function UIStrengthenSkillPanel:GetSkillUseBookID()
    if self.SkillsCondition_Now == nil or self.SkillsCondition_Now:GetCostBook() == nil or self.SkillsCondition_Now:GetCostBook().list == nil then
        return nil
    end
    local list = self.SkillsCondition_Now:GetCostBook().list
    for i = 0, list.Count do
        if list[i] ~= nil then
            return list[i]
        end
    end
end

---@return boolean 是否显示获取途径
function UIStrengthenSkillPanel:IsShowGetWay()
    local isShowGetWay = false
    if self.NowSkillInfo ~= nil and self.NowSkillInfo:GetNextSkillsConditionTable() == nil then
        return false
    end
    return true
end

--endregion

--region 点击

---點擊使用技能書按鈕
function UIStrengthenSkillPanel:OnUseSkillBookBtn()
    if self.IntensifySkillBook_bagItemInfo ~= nil then
        networkRequest.ReqUseItem(1, self.IntensifySkillBook_bagItemInfo.lid, 1)
    end
    networkRequest.ReqLevelUpSkill(self.NowSkillInfo.skillid)
end

--endregion

---
function UIStrengthenSkillPanel.OnResBagItemChangedMessage()

end

return UIStrengthenSkillPanel