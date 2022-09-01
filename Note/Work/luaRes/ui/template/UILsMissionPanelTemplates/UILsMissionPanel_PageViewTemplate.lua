---@class UILsMissionPanel_PageViewTemplate :TemplateBase 灵兽任务页签视图模板
local UILsMissionPanel_PageViewTemplate = {}

function UILsMissionPanel_PageViewTemplate:GetLsMissionData()
    if self.missionData == nil then
        self.missionData = gameMgr:GetPlayerDataMgr():GetLsMissionData()
    end
    return self.missionData
end

--region 初始化

function UILsMissionPanel_PageViewTemplate:Init()
    self:InitComponents()
    self:InitParameters()
end
--初始化变量
function UILsMissionPanel_PageViewTemplate:InitParameters()
    self.isInitialized = false
    self.curSec = 0
    ---@type table<UnityEngine.GameObject,UILsMissionPanel_PageUnitTemplate>
    self.goAndTemplateDic = {}
    ---@type table<number,UnityEngine.GameObject>
    --self.secAndGoDic = {}
end

function UILsMissionPanel_PageViewTemplate:InitComponents()
    ---页签父物体
    self.pageRoot = self:Get('huanshou', 'GameObject')
    ---@type Top_UIGridContainer 页签列表
    self.pageGrid = self:Get('huanshou', 'Top_UIGridContainer')
end



--endregion

--region Show

---@param data table
---@field data.targetSec      number   目标章节(用于外界跳转，页签未开启是不做  暂留接口)
---@field data.changeCallBack function 改变页签回调
function UILsMissionPanel_PageViewTemplate:SetTemplate(data)
    self.ChangeSecCallBack = data.changeCallBack
    self.targetSec = data.targetSec
    self:InitPage()
end

function UILsMissionPanel_PageViewTemplate:InitPage()
    local isShowPage = self:IsShowPageRoot()
    self.pageRoot:SetActive(isShowPage)

    if isShowPage then
        self:InitPageView()
        self:InitPageData()
    end
end

function UILsMissionPanel_PageViewTemplate:InitPageView()
    local count = self:GetLsMissionData():GetSecCount()
    self.pageGrid.MaxCount = count
    for i = 1, count do
        local go = self.pageGrid.controlList[i - 1]
        if go then
            ---@type UILsMissionPanel_PageUnitTemplate
            local template = self.goAndTemplateDic[go]
            if template == nil then
                template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UILsMissionPanel_PageUnitTemplate)
                self.goAndTemplateDic[go] = template
                -- self.secAndGoDic[i] = go
            end
            template:SetTemplate({
                sec = i,
                callBack = function(go, sec)
                    self:OnPageBtnClick(go, sec)
                end
            })
        end
    end
end

function UILsMissionPanel_PageViewTemplate:ChangePage(sec)
    if self.curSec == sec then
        return
    end
    sec = sec == 0 and 1 or sec
    self.curSec = sec
    if self.ChangeSecCallBack ~= nil then
        self.ChangeSecCallBack(sec)
    end
    for i, v in pairs(self.goAndTemplateDic) do
        if v then
            v:ChangeChooseState(sec)
        end
    end
end

function UILsMissionPanel_PageViewTemplate:Refresh()
    self:InitPage()
end

--endregion


--region UI函数监听

function UILsMissionPanel_PageViewTemplate:OnPageBtnClick(go, sec)
    local secStateDic = self:GetLsMissionData():GetSecStateDic()
    if secStateDic[sec] ~= nil and secStateDic[sec].lockState ~= LuaLsMissionSecStateEnum.Lock then
        self:ChangePage(sec)
    else
        Utility.ShowPopoTips(go, nil, 491, 'UILsMissionPanel')
    end
end

--endregion


--region otherFunction

function UILsMissionPanel_PageViewTemplate:InitPageData()
    if self.curSec == 0 then
        ---首次设置页签
        if self.targetSec ~= nil and self.targetSec ~= 0 then
            ---有跳转限制
            if self:GetLsMissionData():GetAllMissionDic()[self.targetSec] ~= nil then
                self:ChangePage(self.targetSec)
                return
            end
        end
        ---查找一个适合的页签
        self:ChangePage(self:CheckFirstTargetPage())
    else
        if self:GetLsMissionData():GetAllMissionDic()[self.curSec] ~= nil then
            ---页签信息还存在，用以前的页签信息
            self:ChangePage(self.curSec)
        else
            ---不存在，重新查找一个适合的页签
            self:ChangePage(self:CheckFirstTargetPage())
        end
    end
end

---判断首个显示的页签
---@return number
function UILsMissionPanel_PageViewTemplate:CheckFirstTargetPage()
    return self:GetLsMissionData():GetCurShowMissionSec()
end

function UILsMissionPanel_PageViewTemplate:IsShowPageRoot()
    return self:GetLsMissionData():GetAllMissionDic()[1] ~= nil and self:GetLsMissionData():GetAllMissionDic()[2] ~= nil
end

--endregion

--region ondestroy

function UILsMissionPanel_PageViewTemplate:onDestroy()

end

--endregion

return UILsMissionPanel_PageViewTemplate