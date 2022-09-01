---@class UIBossPanel_ShengXiaoViewTemplate:UIBossPanel_BaseViewTemplate 游荡boss视图
local UIBossPanel_ShengXiaoViewTemplate = {}

setmetatable(UIBossPanel_ShengXiaoViewTemplate, luaComponentTemplates.UIBossPanel_BaseViewTemplate)

--region override
function UIBossPanel_ShengXiaoViewTemplate:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---@type Top_UILabel
    self.title = self:Get("Title", 'Top_UILabel')
    ---问号点击
    self.btnhelp = self:Get("btn_help", 'GameObject')
    ---怪物模型
    self.timeLabel = self:Get("Time", "UILabel")
end

function UIBossPanel_ShengXiaoViewTemplate:InitTemplate(customData)
    self:RunBaseFunction('InitTemplate', customData)
    self.unitTemplate = luaComponentTemplates.UIChallengeBoss_ShengXiaoBossTemplate
    CS.UIEventListener.Get(self.btnhelp).onClick = function()
        local data = {}
        data.id = 249
        Utility.ShowHelpPanel(data)
    end
    local des = gameMgr:GetPlayerDataMgr():GetBossDataManager():GetShengXiaoState()
    if des == nil then
        des = 1
    end
    if des == 1 then
        self.timeLabel.text = "[878787]刷新时间：[-][dde6eb]今日10:00"
    elseif des == 2 then
        self.timeLabel.text = "[878787]刷新时间：[-][00ff00]已刷新"
    elseif des == 3 then
        self.timeLabel.text = "[878787]刷新时间：[-][dde6eb]明日10:00"
    end
end

function UIBossPanel_ShengXiaoViewTemplate:RefreshOtherView(pageInfo)
    self:RunBaseFunction("RefreshOtherView", pageInfo)
    if pageInfo == nil then
        return
    end
end

---是否显示左侧页签
---@protected
function UIBossPanel_ShengXiaoViewTemplate:IsShowLeftPageView()
    return true
end

---解析数据
---@return boolean 是否解析成功
function UIBossPanel_ShengXiaoViewTemplate:ParsData(data)
    ---处理服务器boss数据

    if data == nil or data.boss == nil or data.type ~= self.mBossType then
        return
    end
    if self:GetBossPage() == nil then
        return
    end
    local subType
    local curAllBossDicValue
    local curAllBossDicConfigid
    local curAllBossStateDicValue
    local curAllBossStateDicValueConfigid
    local curAllBossSurviveNumDicValue
    local curAllBossSurviveTotalCountDicValue
    local curAllIsMeetBossStateDicValue
    local curAllIsMeetBossIsSurviveDicValue
    local curAllIsMeetBossIsSurviveDicValueConfigid
    local IsMeetBossCondition
    for i = 1, #data.boss do
        local info = data.boss[i]
        if info.bossId ~= nil then
            local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(info.bossId)
            if bossInfo then
                subType = bossInfo:GetSubType()
                curAllBossDicValue = self.curAllBossDic[subType]
                if curAllBossDicValue == nil then
                    curAllBossDicValue = {}
                    self.curAllBossDic[subType] = curAllBossDicValue
                end
                curAllBossDicConfigid = curAllBossDicValue[info.configId]
                if curAllBossDicConfigid == nil then
                    curAllBossDicConfigid = {}
                    curAllBossDicValue[info.configId] = curAllBossDicConfigid
                end
                curAllBossStateDicValue = self.curAllBossStateDic[subType]
                if curAllBossStateDicValue== nil then
                    curAllBossStateDicValue = {}
                    self.curAllBossStateDic[subType] = curAllBossStateDicValue
                end
                IsMeetBossCondition = Utility.IsMeetBossCondition(bossInfo)
                if IsMeetBossCondition then
                    curAllBossStateDicValueConfigid = curAllBossStateDicValue[info.configId]
                    if curAllBossStateDicValueConfigid == nil then
                        curAllBossStateDicValue[info.configId] = info.count
                        curAllBossStateDicValueConfigid = info.count
                    else
                        curAllBossStateDicValue[info.configId] = curAllBossStateDicValueConfigid + info.count
                        curAllBossStateDicValueConfigid = curAllBossStateDicValueConfigid + info.count
                    end
                end
                curAllBossSurviveNumDicValue = self.curAllBossSurviveNumDic[subType]
                --region 每个页签的存活总数量
                if curAllBossSurviveNumDicValue == nil then
                    self.curAllBossSurviveNumDic[subType] = info.count
                    curAllBossSurviveNumDicValue = info.count
                else
                    self.curAllBossSurviveNumDic[subType] = curAllBossSurviveNumDicValue + info.count
                    curAllBossSurviveNumDicValue = curAllBossSurviveNumDicValue + info.count
                end
                --endregion

                --region 页签的总数量
                if info.totalCount ~= nil then
                    curAllBossSurviveTotalCountDicValue = self.curAllBossSurviveTotalCountDic[subType]
                    if curAllBossSurviveTotalCountDicValue == nil then
                        self.curAllBossSurviveTotalCountDic[subType] = info.totalCount
                        curAllBossSurviveTotalCountDicValue = info.totalCount
                    else
                        self.curAllBossSurviveTotalCountDic[subType] = curAllBossSurviveTotalCountDicValue+ info.totalCount
                        curAllBossSurviveTotalCountDicValue= curAllBossSurviveTotalCountDicValue+ info.totalCount
                    end
                end
                --endregion
                curAllIsMeetBossStateDicValue = self.curAllIsMeetBossStateDic[subType]
                if curAllIsMeetBossStateDicValue == nil then
                    curAllIsMeetBossStateDicValue = {}
                    self.curAllIsMeetBossStateDic[subType] = curAllIsMeetBossStateDicValue
                end
                curAllIsMeetBossStateDicValue[info.bossId] = IsMeetBossCondition

                curAllIsMeetBossIsSurviveDicValue = self.curAllIsMeetBossIsSurviveDic[subType]
                if curAllIsMeetBossIsSurviveDicValue == nil then
                    curAllIsMeetBossIsSurviveDicValue = {}
                    self.curAllIsMeetBossIsSurviveDic[subType] = curAllIsMeetBossIsSurviveDicValue
                end
                curAllIsMeetBossIsSurviveDicValueConfigid = curAllIsMeetBossIsSurviveDicValue[info.configId]
                if curAllIsMeetBossIsSurviveDicValueConfigid == nil then
                    curAllIsMeetBossIsSurviveDicValue[info.configId] = info.count
                    curAllIsMeetBossIsSurviveDicValueConfigid = info.count
                else
                    if curAllIsMeetBossStateDicValue[info.bossId] then
                        curAllIsMeetBossIsSurviveDicValue[info.configId] = curAllIsMeetBossIsSurviveDicValueConfigid+ info.count
                        curAllIsMeetBossIsSurviveDicValueConfigid = curAllIsMeetBossIsSurviveDicValueConfigid+ info.count
                    end
                end

                table.insert(curAllBossDicConfigid, info)
            end
        end
    end
    for k1, v in pairs(self.curAllBossStateDic) do
        self.curBossPageStateDic[k1] = self:GetBossPageState(data.type, k1, v)
    end
    return
end

--endregion

return UIBossPanel_ShengXiaoViewTemplate
