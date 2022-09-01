---@class UIEliteMissionTemplates:TemplateBase 精英任务
local UIEliteMissionTemplates = {}

function UIEliteMissionTemplates:InitComponents()

    self.ScrollView = self:Get('ScrollView', 'UIScrollView')
    ---等级Grid
    self.LevelUIGridContainer = self:Get('events/topbuttonstemplate/ScrollView/btns', 'UIGridContainer')
    ---Boss
    self.BossUIGridContainer = self:Get('events/topbuttonstemplate_boss/ScrollView/btns', 'UIGridContainer')
    ---等级Grid
    self.LevelRoot = self:Get('events/topbuttonstemplate', 'GameObject')
    ---Boss
    self.BossRoot = self:Get('events/topbuttonstemplate_boss', 'GameObject')
    ---Boss头像Grid
    self.headUIGridContainer = self:Get('ScrollView/HeadGrid', 'UIGridContainer')
    ---Boss名称
    self.lab_monster = self:Get('lab_monster', 'UILabel')
    ---杀敌数量描述
    self.killNumber = self:Get('lab_killNum', 'UILabel')
end
function UIEliteMissionTemplates:InitOther()
    self.headPotX = self.headUIGridContainer.transform.localPosition.x
    self.headPot = self.headUIGridContainer.transform.localPosition
    self.StartEnterTop = false
    self.StartEnterHead = false
end

function UIEliteMissionTemplates:Init()
    self:InitComponents()
    self:InitOther()
end

function UIEliteMissionTemplates:InitData(data,useTemplateSource)
    if data == nil then
        return
    end
    self.csmission = data
    self.Tab_Task = self.csmission.tbl_tasks
    self.tbl_taskBoss = self.csmission.tbl_taskBoss
    self.useTemplateSource = useTemplateSource
    if self.tbl_taskBoss == nil then
        print("tbl_taskBoss表有问题！！！！！！！")
        return
    end
    ---CS.List<TaskShowInfo> 
    self.TaskShowInfoList = self.csmission:GetDailyTaskShowInfo()
    self.TaskBossSelect = nil
    self.type = 0

    self.type = tonumber(self.tbl_taskBoss.type)

    if self.type == LuaEnumTaskBossType.Elite then
        self.TaskBossList = Utility.GetTaskBossLevelListInfo(self.tbl_taskBoss)
    elseif self.type == LuaEnumTaskBossType.Boss then
        self.TaskBossList = Utility.GetTaskBossTypeListInfo(self.tbl_taskBoss)
    end
    self:RefreshUI()
end

function UIEliteMissionTemplates:RefreshUI()
    if self.type == LuaEnumTaskBossType.Elite then
        self:RefreshLevel(self.LevelUIGridContainer, LuaEnumTaskBossType.Elite)
    elseif self.type == LuaEnumTaskBossType.Boss then
        self:RefreshLevel(self.BossUIGridContainer, LuaEnumTaskBossType.Boss)
    end
    self.LevelRoot.gameObject:SetActive(self.type == LuaEnumTaskBossType.Elite)
    self.BossRoot.gameObject:SetActive(self.type == LuaEnumTaskBossType.Boss)

    self:ShowSchedule()
end

---刷新顶部等级
function UIEliteMissionTemplates:RefreshLevel(Grid, type)
    if self.TaskBossList == nil then
        return
    end
    if Grid == nil then
        return
    end

    Grid.MaxCount = Utility.GetTableCount(self.TaskBossList)
    if  Grid.MaxCount==1 then
        Grid.gameObject:SetActive(false)
    end
    local index = 0
    for i, v in pairs(self.TaskBossList) do
        local item = Grid.controlList[index].gameObject
        local Label = CS.Utility_Lua.GetComponent(item.transform:Find("check/Label"), "UILabel");
        local bgLabel = CS.Utility_Lua.GetComponent(item.transform:Find("backGround/Label"), "UILabel");
        local check = CS.Utility_Lua.GetComponent(item.transform:Find("check"), "GameObject");
        local des = ""
        if type == LuaEnumTaskBossType.Elite then
            des = v.level .. "级"
        elseif type == LuaEnumTaskBossType.Boss then
            des = v.bossType
        end
        Label.text = des
        bgLabel.text = des
        check:SetActive(index == 0)
        if index == 0 and self.StartEnterTop == false then
            self.TaskBossSelect = v.bossinfo
            luaEventManager.DoCallback(LuaCEvent.Task_EliteSelectLevel, self.TaskBossSelect);
            self:RefreshHeadList()
            self.StartEnterTop = true
        end

        local nowSelect = v
        CS.UIEventListener.Get(item.gameObject).onClick = function(go)
            self.TaskBossSelect = nowSelect.bossinfo
            luaEventManager.DoCallback(LuaCEvent.Task_EliteSelectLevel, self.TaskBossSelect);
            self:RefreshHeadList()
            for i = 0, Grid.MaxCount - 1 do
                local nowItem = Grid.controlList[i].gameObject
                local check = CS.Utility_Lua.GetComponent(nowItem.transform:Find("check"), "GameObject");
                check:SetActive(nowItem.name == go.name)
            end
        end
        index = index + 1
    end
end

function UIEliteMissionTemplates:RefreshHeadList()
    local nowSelect = self.TaskBossSelect
    if nowSelect == nil then
        return
    end
    if nowSelect.TblList == nil then
        return
    end
    self.lab_monster.text = ""
    self.headUIGridContainer.MaxCount = Utility.GetTableCount(nowSelect.TblList)

    local offsetIndex = Utility.GetTableCount(nowSelect.TblList) - 1
    if offsetIndex > 2 then
        offsetIndex = 2
    end
    self.headPot.x = self.headPotX - offsetIndex * self.headUIGridContainer.CellWidth / 2
    if self.useTemplateSource == LuaEnumUseUIEliteMissionTemplateSource.BossSkillTips then
        self.headUIGridContainer.transform.localPosition = self.headPot
    end
    local index = 0
    for i, v in pairs(nowSelect.TblList) do
        local item = self.headUIGridContainer.controlList[index].gameObject
        local headIcon = CS.Utility_Lua.GetComponent(item.transform:Find("bossHead/headIcon"), "UISprite");
        local select = CS.Utility_Lua.GetComponent(item.transform:Find("choose"), "GameObject");
        local lb_lv = CS.Utility_Lua.GetComponent(item.transform:Find("lb_lv"), "UILabel");
        headIcon.spriteName = v.head
        if v.reinLv ~= 0 then
            lb_lv.text = v.reinLv .. "转"
        else
            lb_lv.text = v.level
        end
        if index == 0 then
            local isfind, color = CS.Cfg_GlobalTableManager.Instance.monsterNameColorDic:TryGetValue(v.type)
            if isfind then
                self.lab_monster.color = color
            end
            self.lab_monster.text = v.name

        end
        select.gameObject:SetActive(index == 0)
        local nowindex = index
        local monTbl = v
        if index == 0 then
            self.mCurrentChooseMonsterId = monTbl.id
        end
        CS.UIEventListener.Get(item).onClick = function(go)
            for i = 0, self.headUIGridContainer.MaxCount - 1 do
                local nowItem = self.headUIGridContainer.controlList[i].gameObject
                local select = CS.Utility_Lua.GetComponent(nowItem.transform:Find("choose"), "GameObject");
                select:SetActive(nowItem.name == go.name)
                local isfind, color = CS.Cfg_GlobalTableManager.Instance.monsterNameColorDic:TryGetValue(monTbl.type)
                if isfind then
                    self.lab_monster.color = color
                end
                self.lab_monster.text = monTbl.name
                self.mCurrentChooseMonsterId = monTbl.id
            end
        end

        index = index + 1
    end
    if (self.useTemplateSource == LuaEnumUseUIEliteMissionTemplateSource.BossSkillTips and (index > 2))
            or (self.useTemplateSource == LuaEnumUseUIEliteMissionTemplateSource.SpecialMission and index > 5) then
        self.ScrollView:ResetPosition()
    end
end

---显示进度
function UIEliteMissionTemplates:ShowSchedule()
    if self.TaskShowInfoList == nil or self.TaskShowInfoList.Count == 0 then
        return
    end
    local info = self.TaskShowInfoList[0]
    local curCount = info.CurCount
    local sumColor = ""
    local MaxsumColor = ""
    if info.CurCount < info.MaxCount then
        curCount = "[e85038]" .. info.CurCount .. "[-]"
    elseif info.CurCount >= info.MaxCount then
        sumColor = "[00ff00]"
    end
    self.killNumber.text = info.Des .. " " .. sumColor .. curCount .. "/" .. info.MaxCount
end

function UIEliteMissionTemplates:RefreShBg(commonBG,bossBG)
    local nowGridMaxCount=0
    if self.type == LuaEnumTaskBossType.Elite then
        nowGridMaxCount=self.LevelUIGridContainer.MaxCount
    elseif self.type == LuaEnumTaskBossType.Boss then
        nowGridMaxCount=self.BossUIGridContainer.MaxCount
    end
    local isShowBossBG=nowGridMaxCount<=1 and self.type == LuaEnumTaskBossType.Boss
    if commonBG~=nil and  bossBG~=nil then
        commonBG.gameObject:SetActive(not isShowBossBG)
        bossBG.gameObject:SetActive(isShowBossBG)
    end
end

return UIEliteMissionTemplates