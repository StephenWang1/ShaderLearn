---@class UILsMissionPanel_TaskViewTemplate:TemplateBase 灵兽任务任务视图模板
local UILsMissionPanel_TaskViewTemplate = {}

function UILsMissionPanel_TaskViewTemplate:GetLsMissionData()
    if self.missionData == nil then
        self.missionData = gameMgr:GetPlayerDataMgr():GetLsMissionData()
    end
    return self.missionData
end

function UILsMissionPanel_TaskViewTemplate:GetMainPlayerCareer()
    if self.Career == nil then
        self.Career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    end
    return self.Career
end

--region 初始化

function UILsMissionPanel_TaskViewTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindEvents()
end
--初始化变量
function UILsMissionPanel_TaskViewTemplate:InitParameters()
    ---@type table<number,LsMission>
    self.curMissionList = {}
    self.mGoAndTemplateDic = {}
    self.missionIdAndTemplateDic = {}
    self.isInitialized = false
end

function UILsMissionPanel_TaskViewTemplate:InitComponents()
    ---@type UnityEngine.GameObject 底图1
    self.lxTexture = self:Get('view/lxTexture', 'GameObject')
    ---@type UnityEngine.GameObject 底图2
    self.tcTexture = self:Get('view/tcTexture', 'GameObject')
    ---@type CSUIEffectLoad 底图加载
    self.servantLoad = self:Get('view/servant', 'CSUIEffectLoad')
    ---@type UnityEngine.GameObject 底图
    self.servantObj = self:Get('view/servant', 'GameObject')
    ---@type UnityEngine.GameObject 底图
    self.lock = self:Get('view/lock', 'GameObject')
    ---@type UILoopScrollViewPlus
    self.taskLoopPlus = self:Get('missionView', 'UILoopScrollViewPlus')
end

function UILsMissionPanel_TaskViewTemplate:BindEvents()
    CS.UIEventListener.Get(self.servantObj).onClick = function()
        self:OnServantObjClicked()
    end
end

--endregion

--region Show

---@param sec number 章节
function UILsMissionPanel_TaskViewTemplate:Refresh(sec)
    self.curSec = sec
    self:RefreshData()
    self:RefreshView()
end

function UILsMissionPanel_TaskViewTemplate:RefreshView()
    --self.lxTexture:SetActive(self.curSec == 1)
    --self.tcTexture:SetActive(self.curSec == 2)
    local careerIndex = self:GetMainPlayerCareer()
    local sexIndex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
    self.servantLoad:ChangeEffect('weaponbook_' .. self.curSec .. '_' .. tostring(sexIndex))

    ---@type lingshouV2.LinshouSectionInfo
    local secInfo = self:GetLsMissionData():GetSecStateDic()[self.curSec]
    self.lock:SetActive(secInfo ~= nil and secInfo.lockState == LuaLsMissionSecStateEnum.Lock)

    if not self.isInitialized then
        self.isInitialized = true
        self.taskLoopPlus:Init(function(go, line)
            return self:UnitTemplateCallBack(go, line)
        end)
    else
        self.taskLoopPlus:ResetPage()
    end
end

function UILsMissionPanel_TaskViewTemplate:UnitTemplateCallBack(go, line)
    if go == nil or self.curMissionList == nil or line + 1 > #self.curMissionList then
        return false
    end
    local template = self.mGoAndTemplateDic[go]

    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UILsMissionPanel_UnitTemplate)
        self.mGoAndTemplateDic[go] = template
    end
    self.missionIdAndTemplateDic[self.curMissionList[line + 1].lsTaskId] = template
    template:SetTemplate({
        missionData = self.curMissionList[line + 1]
    })
    return true
end

---刷新单个任务视图
---@param tblData lingshouV2.ResLingShouTaskInfo
function UILsMissionPanel_TaskViewTemplate:RefreshTaskView(tblData)
    for i = 1, #tblData.taskInfo do
        local missionTemplate = self.missionIdAndTemplateDic[tblData.taskInfo[i].id]
        local missionData = self:GetLsMissionData():GetLsMissionBySecAndTaskID(self.curSec, taskId)
        if missionTemplate == nil or missionData == nil then
            return
        end
        missionTemplate:RefreshTask(missionData)
    end
end


--endregion

--region uiEvent
function UILsMissionPanel_TaskViewTemplate:OnServantObjClicked()
    --[[    local dic = LuaGlobalTableDeal.GetRingSecRewardDic()
        local secRewardTbl = dic[self.curSec]
        if secRewardTbl == nil then
            return
        end
        local itemId = secRewardTbl[self:GetMainPlayerCareer()]
        local isFind, itemTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(tonumber(itemId))
        if isFind then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTbl, showRight = false })
        end]]
    local itemId = LuaGlobalTableDeal.GetCurWeaponBookRewardItemId(self.curSec)
    local isFind, itemTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(tonumber(itemId))
    if isFind then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTbl, showRight = false })
    end
end
--endregion

--region otherFunction

function UILsMissionPanel_TaskViewTemplate:RefreshData()
    self.curMissionList = self:GetLsMissionData():GetAllMissionDic()[self.curSec]
end


--endregion

--region ondestroy

function UILsMissionPanel_TaskViewTemplate:onDestroy()

end

--endregion

return UILsMissionPanel_TaskViewTemplate