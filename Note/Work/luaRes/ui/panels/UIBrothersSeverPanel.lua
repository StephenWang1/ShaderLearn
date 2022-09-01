---断义面板
---@class UIBrothersSeverPanel:UIBase
local UIBrothersSeverPanel = {}

--region 局部变量
UIBrothersSeverPanel.goTempDic = {}
UIBrothersSeverPanel.playTempDic = {}
UIBrothersSeverPanel.brotherList = {}
UIBrothersSeverPanel.isInitLoopPlus = true
--endregion

--region 初始化

function UIBrothersSeverPanel:Init()
    self:InitComponents()
    UIBrothersSeverPanel.BindUIEvents()
    UIBrothersSeverPanel.BindNetMessage()
    UIBrothersSeverPanel.RefreshBrotherLoopPlus()
end

--- 初始化组件
function UIBrothersSeverPanel:InitComponents()
    ---@type UnityEngine.GameObject 关闭按钮
    UIBrothersSeverPanel.CloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    ---@type Top_UIGridContainer    兄弟列表
    UIBrothersSeverPanel.playerLoopPlus = self:GetCurComp("WidgetRoot/view/Player/Scroll View/player", "UILoopScrollViewPlus")
end

function UIBrothersSeverPanel.BindUIEvents()
    --点击事件
    CS.UIEventListener.Get(UIBrothersSeverPanel.CloseBtn).onClick = UIBrothersSeverPanel.OnClickCloseBtn
end

function UIBrothersSeverPanel.BindNetMessage()
    UIBrothersSeverPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBreakOffRelationsMessage, UIBrothersSeverPanel.OnResBreakOffRelationsMessageCallBack)
end
--endregion

--region 函数监听

--点击关闭函数
---@param go UnityEngine.GameObject
function UIBrothersSeverPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel("UIBrothersSeverPanel")
end
--endregion


--region 网络消息处理
--移除兄弟信息
function UIBrothersSeverPanel.OnResRemoveBrotherMessageCallback()
    UIBrothersSeverPanel.RefreshBrotherLoopPlus()
end
--兄弟单个信息改变
function UIBrothersSeverPanel.OnResOneBrotherMessageCallBack(id, data)
    if data then
        UIBrothersSeverPanel.RefreshGrid(data.theBrothers)
    end
end

function UIBrothersSeverPanel.OnResBreakOffRelationsMessageCallBack()
    UIBrothersSeverPanel.RefreshBrotherLoopPlus()
end

--endregion

--region UI

function UIBrothersSeverPanel.RefreshBrotherLoopPlus()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return false
    end
    UIBrothersSeverPanel.brotherList = UIBrothersSeverPanel.SortDic()
    if #UIBrothersSeverPanel.brotherList == 0 then
        uimanager:ClosePanel('UIBrothersSeverPanel')
        return
    end
    if UIBrothersSeverPanel.isInitLoopPlus then
        UIBrothersSeverPanel.isInitLoopPlus = false
        UIBrothersSeverPanel.playerLoopPlus:Init(UIBrothersSeverPanel.RefreshTempCallBack, nil)
    else
        UIBrothersSeverPanel.playerLoopPlus:ResetPage()
    end
end

function UIBrothersSeverPanel.RefreshTempCallBack(go, line)
    if go == nil or CS.StaticUtility.IsNull(go) or line + 1 > #UIBrothersSeverPanel.brotherList then
        return false
    end
    local v = UIBrothersSeverPanel.brotherList[line + 1]
    local temp = UIBrothersSeverPanel.playTempDic[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBrotherSeverUnitTemplate) or UIBrothersSeverPanel.playTempDic[go]
    local infotemp = {}
    infotemp.id = v.rid
    infotemp.spriteName = 'headicon' .. v.sex .. v.career
    infotemp.status = v.isDissolution
    infotemp.level = v.level
    infotemp.name = v.name
    infotemp.time = v.disTime
    infotemp.qmd = v.intimacy
    infotemp.index = line + 1
    temp:SetTemplate(infotemp)
    if UIBrothersSeverPanel.playTempDic[go] == nil then
        UIBrothersSeverPanel.playTempDic[go] = temp
    end
    UIBrothersSeverPanel.goTempDic[v.rid] = go
    return true
end

function UIBrothersSeverPanel.RefreshGrid(info)
    local go = UIBrothersSeverPanel.goTempDic[info.rid]
    if go then
        local temp = UIBrothersSeverPanel.playTempDic[go]
        if temp then
            temp:RrfreshStatus(info.isDissolution, info.disTime)
        end
    end
end

--endregion

--region otherFunction
function UIBrothersSeverPanel.SortDic()
    local brotherList = {}
    local brotherDic = CS.CSScene.MainPlayerInfo.FriendInfoV2.AssertionDic
    if brotherDic.Count == 0 then
        return brotherList
    end
    for i, v in pairs(brotherDic) do
        table.insert(brotherList, v)
    end
    table.sort(brotherList, function(a, b)
        if a.isDissolution ~= b.isDissolution then

            return a.isDissolution < b.isDissolution
        end
        return a.disTime < b.disTime
    end)
    return brotherList
end
--endregion

return UIBrothersSeverPanel