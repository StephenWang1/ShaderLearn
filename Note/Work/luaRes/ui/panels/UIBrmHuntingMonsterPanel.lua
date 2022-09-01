---@class UIBrmHuntingMonsterPanel : UIBase 白日门猎魔面板
local UIBrmHuntingMonsterPanel = {}

function UIBrmHuntingMonsterPanel.GetTotalCount()
    return LuaGlobalTableDeal.GetTotalHuntCount()
end

---@type BaiRiMenActController_Hunt 获取白日门猎魔活动数据管理
function UIBrmHuntingMonsterPanel.GetActController_Hunt()
    return gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_Hunt()
end

--region 初始化

function UIBrmHuntingMonsterPanel:Init()
    self:InitComponents()
    UIBrmHuntingMonsterPanel.InitParameters()
    UIBrmHuntingMonsterPanel.BindNetMessage()
    UIBrmHuntingMonsterPanel.RefreshData()
    UIBrmHuntingMonsterPanel.InitAllView()
end

function UIBrmHuntingMonsterPanel:Show()
    UIBrmHuntingMonsterPanel.GetActController_Hunt():RequestServerData()
end

--- 初始化变量
function UIBrmHuntingMonsterPanel.InitParameters()
    --UIBrmHuntingMonsterPanel.timeFormat = '每周六、周日 %s-%s 刷新'
    UIBrmHuntingMonsterPanel.timeFormat = '每日%s - %s开启'
    --UIBrmHuntingMonsterPanel.timeFormat = '每日%s - %s开启\r\n首次开启将在开服第五天,后续每周六、周日开启'
    UIBrmHuntingMonsterPanel.countFormat = '今日精英击杀数量  %s'
    UIBrmHuntingMonsterPanel.isInitialized = false
    UIBrmHuntingMonsterPanel.bossInfoList = {}
    UIBrmHuntingMonsterPanel.curSubType = 3
    ---@type< UnityEngine.GameObject ,luaComponentTemplates.UIBrmHuntingMonster_BossUnitTemplate>
    UIBrmHuntingMonsterPanel.BossUnitTemplateList = {}
end

--- 初始化组件
function UIBrmHuntingMonsterPanel:InitComponents()
    ---@type Top_UILabel 刷新时间
    UIBrmHuntingMonsterPanel.time = self:GetCurComp('WidgetRoot/view/time', 'Top_UILabel')
    ---@type Top_UITable 采集次数Table
    --UIBrmHuntingMonsterPanel.Table = self:GetCurComp('WidgetRoot/view/Table', 'Top_UITable')
    ---@type Top_UILabel 采集次数显示
    UIBrmHuntingMonsterPanel.number = self:GetCurComp('WidgetRoot/view/Table/number', 'Top_UILabel')
    ---@type UILoopScrollViewPlus boss列表
    UIBrmHuntingMonsterPanel.bossGrid = self:GetCurComp('WidgetRoot/view/Scroll/Grid', 'UILoopScrollViewPlus')
    ---@type Top_OptimizeClipShaderScript 特效裁剪
    UIBrmHuntingMonsterPanel.ClipShader = self:GetCurComp("WidgetRoot/view/Scroll", "Top_OptimizeClipShaderScript")
    ---@type Top_UILabel 消耗数值
    UIBrmHuntingMonsterPanel.Cost_UILabel = self:GetCurComp('WidgetRoot/view/Cost/number', 'Top_UILabel')
end

function UIBrmHuntingMonsterPanel.BindNetMessage()
    UIBrmHuntingMonsterPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.BaiRiMenActivityDataReceived, UIBrmHuntingMonsterPanel.OnBaiRiMenActivityDataReceivedCallBack)
end

--endregion

--region 网络消息处理

function UIBrmHuntingMonsterPanel.OnBaiRiMenActivityDataReceivedCallBack(eventID, activityType)
    if activityType ~= UIBrmHuntingMonsterPanel.curSubType then
        return
    end
    UIBrmHuntingMonsterPanel.RefreshData()
    --UIBrmHuntingMonsterPanel.RefrshCountView()
    UIBrmHuntingMonsterPanel.RefreshCurLastingStamina()
    UIBrmHuntingMonsterPanel.RefreshCostStamina()
    UIBrmHuntingMonsterPanel.RefreshBossGridView()
end

--endregion

--region View
function UIBrmHuntingMonsterPanel.InitAllView()
    ---初始化时间
    local openTime = UIBrmHuntingMonsterPanel.GetActController_Hunt():GetActiveOpenTime()
    local endTime = UIBrmHuntingMonsterPanel.GetActController_Hunt():GetActiveEndTime()
    UIBrmHuntingMonsterPanel.time.text = string.format(UIBrmHuntingMonsterPanel.timeFormat,
            UIBrmHuntingMonsterPanel.GetActController_Hunt():TimeChangeStr(openTime),
            UIBrmHuntingMonsterPanel.GetActController_Hunt():TimeChangeStr(endTime))

    --UIBrmHuntingMonsterPanel.RefrshCountView()
    UIBrmHuntingMonsterPanel.RefreshCurLastingStamina()
    UIBrmHuntingMonsterPanel.RefreshCostStamina()
    UIBrmHuntingMonsterPanel.RefreshBossGridView()
    --[[    if UIBrmHuntingMonsterPanel.GetActController_Hunt():IsActivityOpenedNow() then
            ---显示tips
            Utility.ShowSecondConfirmPanel({ PromptWordId = 145 })
        end]]
end

---刷新采集次数显示
function UIBrmHuntingMonsterPanel.RefrshCountView()
    local curCount = UIBrmHuntingMonsterPanel.GetActController_Hunt():GetCurKillNum()
    local color = curCount == 0 and luaEnumColorType.Red or luaEnumColorType.Green
    local str = color .. tostring(curCount) .. '[-]/' .. tostring(UIBrmHuntingMonsterPanel.GetTotalCount())
    UIBrmHuntingMonsterPanel.number.text = string.format(UIBrmHuntingMonsterPanel.countFormat, str)
end

---刷新当前剩余体力
function UIBrmHuntingMonsterPanel.RefreshCurLastingStamina()
    local curLastingStamina = UIBrmHuntingMonsterPanel.GetActController_Hunt():GetCurLastingStamina()
    local color = luaEnumColorType.Red
    if curLastingStamina > 0 then
        color = luaEnumColorType.Green
    end
    luaclass.UIRefresh:RefreshLabel(UIBrmHuntingMonsterPanel.number,"当前体力 " .. color .. tostring(curLastingStamina))
end

---刷新消耗的体力
function UIBrmHuntingMonsterPanel.RefreshCostStamina()
    local activityTbl = UIBrmHuntingMonsterPanel.GetActController_Hunt():GetRepresentActivityTbl()
    luaclass.UIRefresh:RefreshActive(UIBrmHuntingMonsterPanel.Cost_UILabel,false)
    if activityTbl == nil then
        return
    end
    local costStamina = activityTbl:GetPhysicalstrength()
    luaclass.UIRefresh:RefreshActive(UIBrmHuntingMonsterPanel.Cost_UILabel,true)
    luaclass.UIRefresh:RefreshLabel(UIBrmHuntingMonsterPanel.Cost_UILabel,"体力消耗 " .. luaEnumColorType.Red .. costStamina)
end

---刷新boss列表
function UIBrmHuntingMonsterPanel.RefreshBossGridView()
    if not UIBrmHuntingMonsterPanel.isInitialized then
        UIBrmHuntingMonsterPanel.bossGrid:Init(UIBrmHuntingMonsterPanel.RefreshBossUnitTemplate)
    else
        UIBrmHuntingMonsterPanel.bossGrid:ResetPage()
    end
end

---刷新boss单元
function UIBrmHuntingMonsterPanel.RefreshBossUnitTemplate(go, line)
    if go == nil or line + 1 > #UIBrmHuntingMonsterPanel.bossInfoList then
        return false
    end
    ---@type UIBrmHuntingMonster_BossUnitTemplate
    local template = UIBrmHuntingMonsterPanel.BossUnitTemplateList[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBrmHuntingMonster_BossUnitTemplate)
        UIBrmHuntingMonsterPanel.BossUnitTemplateList[go] = template
    end
    template:SetTemplate(UIBrmHuntingMonsterPanel.bossInfoList[line + 1], {
        ClipShader = UIBrmHuntingMonsterPanel.ClipShader
    })
    return true
end


--endregion

--region otherFunction

function UIBrmHuntingMonsterPanel.RefreshData()
    UIBrmHuntingMonsterPanel.bossInfoList = UIBrmHuntingMonsterPanel.GetActController_Hunt():GetShowBossClientData()
    --if #UIBrmHuntingMonsterPanel.bossInfoList > 1 then
    --    table.sort(UIBrmHuntingMonsterPanel.bossInfoList, UIBrmHuntingMonsterPanel.SortBossData)
    --end
end

---boss排序
function UIBrmHuntingMonsterPanel.SortBossData(l, f)

    if a.isSurvive ~= b.isSurvive then
        return a.isSurvive
    end
    if a.isSurvive ~= b.isSurvive then
        return a.isSurvive > b.isSurvive
    end
    local aOrder = 0
    local bOrder = 0
    if a and b and a.bossId and b.bossId then
        local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(a.bossId)
        if bossInfo then
            aOrder = bossInfo:GetOrder()
            aOrder = aOrder == nil and 0 or aOrder
        end
        bossInfo = clientTableManager.cfg_bossManager:TryGetValue(b.bossId)
        if bossInfo then
            bOrder = bossInfo:GetOrder()
            bOrder = bOrder == nil and 0 or bOrder
        end
    end
    return aOrder < bOrder

end

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIBrmHuntingMonsterPanel