---@class UIBossPanel_NewFinalViewTemplate:UIBossPanel_BaseViewTemplate  私服终极boss视图
local UIBossPanel_NewFinalViewTemplate = {}

setmetatable(UIBossPanel_NewFinalViewTemplate, luaComponentTemplates.UIBossPanel_BaseViewTemplate)


--region override
function UIBossPanel_NewFinalViewTemplate:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---@type Top_UILabel
    self.title = self:Get("Title", 'Top_UILabel')
    ---@type Top_UILabel
    self.time = self:Get("Table/time", 'Top_UILabel')
    ---@type Top_UILabel
    self.number = self:Get("Table/number", 'Top_UILabel')
    ---@type UnityEngine.GameObject
    self.addBtn_GameObject = self:Get("Table/add", 'GameObject')
    ---@type Top_UITable
    self.table_UITable = self:Get("Table", 'Top_UITable')
    CS.UIEventListener.Get(self.addBtn_GameObject).onClick = function(go)
        self:OnAddBtnClicked(go)
    end
end

function UIBossPanel_NewFinalViewTemplate:InitTemplate(customData)
    self:RunBaseFunction('InitTemplate', customData)
    self.unitTemplate = luaComponentTemplates.UIChallengeBoss_FinalBossBaseTemplate
end

function UIBossPanel_NewFinalViewTemplate:RefreshOtherView(pageInfo)
    self.mCurrentPageInfo = pageInfo
    self:RunBaseFunction("RefreshOtherView", pageInfo)
    if pageInfo == nil then
        return
    end
    self:RefreshTitle(pageInfo.detailDes)
    self:RefreshRightUpDes(pageInfo)
    self.table_UITable.gameObject:SetActive(false)
end

---是否显示左侧页签
---@protected
function UIBossPanel_NewFinalViewTemplate:IsShowLeftPageView()
    return true
end

---boss副页签是否显示boss击杀进度
---@return boolean
function UIBossPanel_NewFinalViewTemplate:BookMarkIsShowBossFill()
    return true
end

function UIBossPanel_NewFinalViewTemplate:IsNeedJumpToCanEnterLine()
    return true
end

---获取页签名字
---@param pageInfo table 页签数据
function UIBossPanel_NewFinalViewTemplate:GetPageName(pageInfo)

    if pageInfo == nil then
        return ""
    end

    if self:BookMarkIsShowBossFill() and pageInfo.type ~= nil then
        local all = self.curAllBossSurviveTotalCountDic[pageInfo.type]
        if all ~= nil and all ~= 0 then
            local remail = self.curAllBossSurviveNumDic[pageInfo.type]
            local killNum = remail == nil and 0 or remail
            local killNumMax = all == nil and 0 or all
            local stringFormat = pageInfo.typeDes .. "\n" .. "%d/%d"
            return string.format(stringFormat, killNum, killNumMax)
        end
    end
    return pageInfo.typeDes == nil and "" or pageInfo.typeDes
end
--endregion

---刷新标题
function UIBossPanel_NewFinalViewTemplate:RefreshTitle(showStr)
    luaclass.UIRefresh:RefreshLabel(self.title, titleDes)
end

---刷新右上角描述内容
---@param pageInfo table 当前点击的页签策划配置数据
function UIBossPanel_NewFinalViewTemplate:RefreshRightUpDes(pageInfo)
    if pageInfo == nil then
        return
    end
    self:ResetRightUpDes()
    self.mCurrentType = pageInfo.type
    if pageInfo.type == LuaEnumFinalBossType.MythBoss then
        local activieBossNum = self:GetGodBossActiveNum()
        local des = luaEnumColorType.Green .. "已刷新"
        if activieBossNum <= 0 then
            des = luaclass.FinalBossDataInfo:GetMythBossDataInfo():GetRefreshTimeDes()
        end

        luaclass.UIRefresh:RefreshActive(self.table_UITable, true)
        luaclass.UIRefresh:RefreshActive(self.number, true)
        luaclass.UIRefresh:RefreshActive(self.time, true)
        luaclass.UIRefresh:RefreshLabel(self.number, luaEnumColorType.Gray .. "刷新时间")
        luaclass.UIRefresh:RefreshLabel(self.time, des)
        self.table_UITable:Reposition()
    end
    self:RefreshKillDes()
end

---刷新击杀次数
function UIBossPanel_NewFinalViewTemplate:RefreshKillDes()
    local pageInfo = self.mCurrentPageInfo
    if self.mCurrentPageInfo == nil then
        return

    end
    if pageInfo.type == LuaEnumFinalBossType.XianZhuangBoss or
            pageInfo.type == LuaEnumFinalBossType.ShengQiBoss or
            pageInfo.type == LuaEnumFinalBossType.LingHunBoss or
            pageInfo.type == LuaEnumFinalBossType.FengHaoBoss then
        local data = gameMgr:GetPlayerDataMgr():GetBossDataManager():GetSingleTypeData(pageInfo.type)
        if data then
            luaclass.UIRefresh:RefreshActive(self.table_UITable, true)
            luaclass.UIRefresh:RefreshActive(self.number, true)
            luaclass.UIRefresh:RefreshActive(self.time, true)
            local color = data.surTimes > 0 and luaEnumColorType.Green or luaEnumColorType.Red
            local time = color .. data.surTimes .. "[-]/" .. data.maxTimes
            luaclass.UIRefresh:RefreshLabel(self.number, "击杀次数 " .. time)
            luaclass.UIRefresh:RefreshLabel(self.time, luaEnumColorType.Gray .. "(凌晨5点重置次数)")
            luaclass.UIRefresh:RefreshActive(self.addBtn_GameObject, true)
            self.table_UITable:Reposition()
        end
    end
end

---重置右上角显示
function UIBossPanel_NewFinalViewTemplate:ResetRightUpDes()
    luaclass.UIRefresh:RefreshActive(self.table_UITable, false)
    luaclass.UIRefresh:RefreshActive(self.time, false)
    luaclass.UIRefresh:RefreshActive(self.number, false)
    luaclass.UIRefresh:RefreshActive(self.addBtn_GameObject, false)
end

---点击Add
function UIBossPanel_NewFinalViewTemplate:OnAddBtnClicked(go)
    if self.mCurrentType == nil then
        return
    end
    local customData = {}
    customData.bossTimesBuy = { 288, 289 }
    customData.bossType = self.mCurrentType
    customData.target = go
    customData.arrowDir = LuaEnumWayGetPanelArrowDirType.Top
    uimanager:CreatePanel("UIFurnaceWayAndBuyPanel", nil, customData);
end

return UIBossPanel_NewFinalViewTemplate