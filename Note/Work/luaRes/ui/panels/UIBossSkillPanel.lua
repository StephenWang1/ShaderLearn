---@class UIBossSkillPanel:UIBase 技能信息面板
local UIBossSkillPanel = {}

--region 数据
UIBossSkillPanel.minHigh = 296
UIBossSkillPanel.maxHigh = 450
--endregion

--region 初始化
function UIBossSkillPanel:Init()
    self:InitComponents()
    self:InitOther()
    self:AddCollider()
end

function UIBossSkillPanel:InitComponents()
    --region 背景图
    ---@type UISprite
    self.infoPanelBG = self:GetCurComp("WidgetRoot/infoPanel/bg", "Top_UISprite")
    --endregion

    --region Top
    ---@type UISprite
    self.mIcon = self:GetCurComp("WidgetRoot/infoPanel/skillIcon", "UISprite");
    ---@type UILabel
    self.mTopFirstDes_UILabel = self:GetCurComp("WidgetRoot/infoPanel/skillName", "UILabel");
    ---@type UILabel
    self.mTopSecondDes_UILabel = self:GetCurComp("WidgetRoot/infoPanel/skillLevel", "UILabel");
    --endregion

    --region 描述
    ---@type UILabel
    self.mCenterFirstDes_UILabel = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/FirstDes", "Top_UILabel")
    ---@type UILabel
    self.mCenterSecondDes_UILabel = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/SecondDes", "Top_UILabel")
    ---@type UILabel
    self.mCenterThirdDes_UILabel = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/ThirdDes", "Top_UILabel")
    --endregion

    --region 获取途径
    ---@type UnityEngine.GameObject 获取方式节点
    self.GetWay = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/GetWay", "GameObject");
    ---@type UIGridContainer 获取方式列表
    self.GetWayItemGrid = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot/GetWay/itemGrid", "Top_UIGridContainer");
    --endregion

    ---@type UITable
    self.Center_UITable = self:GetCurComp("WidgetRoot/infoPanel/skillInfo/tableRoot", "Top_UITable");
    ---@type UIScrollView
    self.Center_UIScrollView = self:GetCurComp("WidgetRoot/infoPanel/skillInfo", "Top_UIScrollView");
    ---@type UIPanel
    self.Center_UIPanel = self:GetCurComp("WidgetRoot/infoPanel/skillInfo", "UIPanel");
end

function UIBossSkillPanel:InitOther()
    ---延时刷新参数
    self.DelayRefresh = nil
    ---默认高度尺寸
    self.defaultTopSize = 140
end
--endregion

--region 刷新
---@class skillInfoPanelCommonData table
---@field bossSkillDesTable TABLE.cfg_boss_skill_describe

---@param skillInfoPanelCommonData skillInfoPanelCommonData
function UIBossSkillPanel:Show(skillInfoPanelCommonData)
    if self:AnalysisParams(skillInfoPanelCommonData) == false then
        uimanager:ClosePanel(self)
        return
    end
    self:RefreshUI()
end

---@param skillInfoPanelCommonData skillInfoPanelCommonData
---@return boolean
function UIBossSkillPanel:AnalysisParams(skillInfoPanelCommonData)
    if type(skillInfoPanelCommonData) ~= 'table' or skillInfoPanelCommonData.bossSkillDesTable == nil then
        return false
    end
    self.bossSkillDesTable = skillInfoPanelCommonData.bossSkillDesTable
    ---@type table<table<string>> 描述内容
    self.tips2DesTable = {}
    if CS.StaticUtility.IsNullOrEmpty(self.bossSkillDesTable:GetTips2()) == false then
        local allTipsTable = string.Split(self.bossSkillDesTable:GetTips2(),'&')
        if type(allTipsTable) == 'table' and #allTipsTable > 0 then
            for k,v in pairs(allTipsTable) do
                local singleTypeTipsList = string.Split(v,'#')
                table.insert(self.tips2DesTable,singleTypeTipsList)
            end
        end
    end
    self.tipsConditionList = {}
    if self.bossSkillDesTable ~= nil and self.bossSkillDesTable:GetConditions() ~= nil and self.bossSkillDesTable:GetConditions().list ~= nil then
        for k,v in pairs(self.bossSkillDesTable:GetConditions().list) do
            table.insert(self.tipsConditionList,v)
        end
    end
    self.defaultTips2 = ""
    if Utility.GetLuaTableCount(self.tips2DesTable) > 0 then
        self.defaultTips2 = self.tips2DesTable[1]
    end
    self:AnalysisSkillDes()
    return true
end

---解析技能描述内容
function UIBossSkillPanel:AnalysisSkillDes()
    ---@type string tips1
    self.tips1 = string.gsub(self.bossSkillDesTable:GetTips(), '\\n', '\n')
    ---@type table<string> tips2
    self.tips2 = self:GetNextBossSKillDesList()
    self.tips2 = ternary(self.tips2 == nil,{},self.tips2)
end

---获取boss第二条技能描述
---@return table<string>
function UIBossSkillPanel:GetNextBossSKillDesList()
    if type(self.tips2DesTable) ~= 'table' or Utility.GetLuaTableCount(self.tips2DesTable) <= 0 then
        return
    end
    local tipsTable = {}
    for k,v in pairs(self.tips2DesTable) do
        ---@type number
        local tipsIndex = k
        ---@type table<string> 描述内容列表
        local tipsDesTable = v
        ---@type table<number> conditionId列表
        local conditonList = self.tipsConditionList[tipsIndex].list
        ---@type string 描述内容
        local des = ""

        if type(tipsDesTable) == 'table' and Utility.GetLuaTableCount(tipsDesTable) > 1 then
            des = tipsDesTable[2]
            if type(conditonList) == 'table' and Utility.GetLuaTableCount(conditonList) > 0 then
                local conditionResult = Utility.IsServantMatchConditionList_AND(conditonList)
                if conditionResult.success == false then
                    des = tipsDesTable[1]
                end
            end
        end
        if CS.StaticUtility.IsNullOrEmpty(des) == false then
            local des = string.gsub(des, '\\n', '\n')
            table.insert(tipsTable,des)
        end
    end
    return tipsTable
end

---刷新UI数据
function UIBossSkillPanel:RefreshUI()
    self:RefreshTopInfo()
    self:RefreshCenterInfo()
    self.DelayRefresh = nil
end

---刷新顶部数据
function UIBossSkillPanel:RefreshTopInfo()
    luaclass.UIRefresh:RefreshSprite(self.mIcon,self.bossSkillDesTable:GetIcon())
    luaclass.UIRefresh:RefreshLabel(self.mTopFirstDes_UILabel,self.bossSkillDesTable:GetName())
    luaclass.UIRefresh:RefreshLabel(self.mTopSecondDes_UILabel,"")
end

---刷新中间数据
function UIBossSkillPanel:RefreshCenterInfo()
    luaclass.UIRefresh:RefreshLabel(self.mCenterFirstDes_UILabel,self.tips1)
    luaclass.UIRefresh:RefreshActive(self.mCenterSecondDes_UILabel,false)
    luaclass.UIRefresh:RefreshActive(self.mCenterThirdDes_UILabel,false)
    for k,v in pairs(self.tips2) do
        local index = k
        local des = v
        if index == 1 then
            luaclass.UIRefresh:RefreshActive(self.mCenterSecondDes_UILabel,true)
            luaclass.UIRefresh:RefreshLabel(self.mCenterSecondDes_UILabel,des)
        elseif index == 2 then
            luaclass.UIRefresh:RefreshActive(self.mCenterThirdDes_UILabel,true)
            luaclass.UIRefresh:RefreshLabel(self.mCenterThirdDes_UILabel,des)
        end
    end
end
--endregion

--region 自适应
---位置适配
function UIBossSkillPanel:AdaptiveSize()
    self.Center_UITable:Reposition()
    self.Center_UIScrollView:ResetPosition()
    ---@type UnityEngine.Bounds
    local Bounds = CS.NGUIMath.CalculateRelativeWidgetBounds(self.Center_UITable.gameObject.transform);
    local Bounds2 = CS.NGUIMath.CalculateRelativeWidgetBounds(self.infoPanelBG.gameObject.transform);
    if Bounds then
        local totalHigh = Bounds.size.y + self.defaultTopSize
        if totalHigh > self.maxHigh then
            totalHigh = self.maxHigh
        end
        local curBoundsSize = totalHigh - self.defaultTopSize
        local scrollViewClipAddSize = 10
        self.Center_UIPanel:SetRect(Bounds.center.x,Bounds.center.y + scrollViewClipAddSize,Bounds.size.x + scrollViewClipAddSize,curBoundsSize + scrollViewClipAddSize)

        self.infoPanelBG.height = math.ceil(totalHigh)
    end
end

function update()
    UIBossSkillPanel:OnUpdate()
end

function UIBossSkillPanel:OnUpdate()
    ---延时一帧刷新
    if self.DelayRefresh == nil then
        self:AdaptiveSize()
        self.DelayRefresh = true
    end
end
--endregion

return UIBossSkillPanel