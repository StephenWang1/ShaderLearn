local UIMonsterSiegeTipsPanel = {}
--region 局部变量定义
---倒计时协程
UIMonsterSiegeTipsPanel.mTimeCountCoroutine = nil
---是否显示界面
UIMonsterSiegeTipsPanel.isShowPanel = true
---当前波数
UIMonsterSiegeTipsPanel.wave = nil
---屏幕长
UIMonsterSiegeTipsPanel.screenWidth = nil
---屏幕宽
UIMonsterSiegeTipsPanel.screenHeight = nil
---window 长
UIMonsterSiegeTipsPanel.mWidth = 218
---window 宽
UIMonsterSiegeTipsPanel.mHeight = 218
---按钮长
UIMonsterSiegeTipsPanel.mButtonWidth = 40
---按钮宽
UIMonsterSiegeTipsPanel.mButtonHeight = 60
---怪物icon层级
UIMonsterSiegeTipsPanel.mLayer = 80
---怪物点
UIMonsterSiegeTipsPanel.mMonsterPoint = {}
---怪物点个数
UIMonsterSiegeTipsPanel.mMonsterPointCount = nil
--endregion

--region 组件
---第一阶段面板
function UIMonsterSiegeTipsPanel.GetFirstStagePanel_GameObject()
    if UIMonsterSiegeTipsPanel.mFirstStagePanel == nil then
        UIMonsterSiegeTipsPanel.mFirstStagePanel = UIMonsterSiegeTipsPanel:GetCurComp("view/Pos", "GameObject")
    end
    return UIMonsterSiegeTipsPanel.mFirstStagePanel
end
---第二阶段面板
function UIMonsterSiegeTipsPanel.GetSecondStagePanel_GameObject()
    if UIMonsterSiegeTipsPanel.mSecondStagePanel == nil then
        UIMonsterSiegeTipsPanel.mSecondStagePanel = UIMonsterSiegeTipsPanel:GetCurComp("view/Rank", "GameObject")
    end
    return UIMonsterSiegeTipsPanel.mSecondStagePanel
end
---位置寻路点
function UIMonsterSiegeTipsPanel.GetGridContainer()
    if UIMonsterSiegeTipsPanel.mGridContainer == nil then
        UIMonsterSiegeTipsPanel.mGridContainer = UIMonsterSiegeTipsPanel:GetCurComp("view/Pos/GridContainer", "UIGridContainer")
    end
    return UIMonsterSiegeTipsPanel.mGridContainer
end
---倒计时Label
function UIMonsterSiegeTipsPanel.GetTimeCount_UILabel()
    if UIMonsterSiegeTipsPanel.mTimeCount == nil then
        UIMonsterSiegeTipsPanel.mTimeCount = UIMonsterSiegeTipsPanel:GetCurComp("view/Pos/CountDown", "UILabel")
    end
    return UIMonsterSiegeTipsPanel.mTimeCount
end
---波数label
function UIMonsterSiegeTipsPanel.GetWaveCount_UILabel()
    if UIMonsterSiegeTipsPanel.mWaveCount == nil then
        UIMonsterSiegeTipsPanel.mWaveCount = UIMonsterSiegeTipsPanel:GetCurComp("view/Pos/Wave", "UILabel")
    end
    return UIMonsterSiegeTipsPanel.mWaveCount
end
---排行GridContainer
function UIMonsterSiegeTipsPanel.GetRankGrid_UIGridContainer()
    if UIMonsterSiegeTipsPanel.mRankGridContainer == nil then
        UIMonsterSiegeTipsPanel.mRankGridContainer = UIMonsterSiegeTipsPanel:GetCurComp("view/Rank/Scroll View/RankList", "UIGridContainer")
    end
    return UIMonsterSiegeTipsPanel.mRankGridContainer
end
---玩家名字
function UIMonsterSiegeTipsPanel.GetMyNameLabel_UILabel()
    if UIMonsterSiegeTipsPanel.mMyNameLabel == nil then
        UIMonsterSiegeTipsPanel.mMyNameLabel = UIMonsterSiegeTipsPanel:GetCurComp("view/Rank/MyName", "UILabel")
    end
    return UIMonsterSiegeTipsPanel.mMyNameLabel
end
---玩家分数
function UIMonsterSiegeTipsPanel.GetMyScoreLabel_UILabel()
    if UIMonsterSiegeTipsPanel.mMyScoreLabel == nil then
        UIMonsterSiegeTipsPanel.mMyScoreLabel = UIMonsterSiegeTipsPanel:GetCurComp("view/Rank/MyScore", "UILabel")
    end
    return UIMonsterSiegeTipsPanel.mMyScoreLabel
end
---玩家排名
function UIMonsterSiegeTipsPanel.GetMyRankLabel_UILabel()
    if UIMonsterSiegeTipsPanel.mMyRankLabel == nil then
        UIMonsterSiegeTipsPanel.mMyRankLabel = UIMonsterSiegeTipsPanel:GetCurComp("view/Rank/MyRank", "UILabel")
    end
    return UIMonsterSiegeTipsPanel.mMyRankLabel
end
---折叠按钮
function UIMonsterSiegeTipsPanel.GetFoldButton_GameObject()
    if UIMonsterSiegeTipsPanel.mFoldButtom == nil then
        UIMonsterSiegeTipsPanel.mFoldButtom = UIMonsterSiegeTipsPanel:GetCurComp("event/PopupBtn", "GameObject")
    end
    return UIMonsterSiegeTipsPanel.mFoldButtom
end
---window
function UIMonsterSiegeTipsPanel.GetWindow_GameObject()
    if UIMonsterSiegeTipsPanel.mWindow == nil then
        UIMonsterSiegeTipsPanel.mWindow = UIMonsterSiegeTipsPanel:GetCurComp("window", "GameObject")
    end
    return UIMonsterSiegeTipsPanel.mWindow
end
---view
function UIMonsterSiegeTipsPanel.GetView_GameObject()
    if UIMonsterSiegeTipsPanel.mView == nil then
        UIMonsterSiegeTipsPanel.mView = UIMonsterSiegeTipsPanel:GetCurComp("view", "GameObject")
    end
    return UIMonsterSiegeTipsPanel.mView
end
---event
function UIMonsterSiegeTipsPanel.GetEvent_GameObject()
    if UIMonsterSiegeTipsPanel.mEventObj == nil then
        UIMonsterSiegeTipsPanel.mEventObj = UIMonsterSiegeTipsPanel:GetCurComp("event", "GameObject")
    end
    return UIMonsterSiegeTipsPanel.mEventObj
end
--endregion

--region  初始化
function UIMonsterSiegeTipsPanel:Init()
    UIMonsterSiegeTipsPanel.BindEvents()
    UIMonsterSiegeTipsPanel.BindMessage()
    UIMonsterSiegeTipsPanel.InitPanel()
end

function UIMonsterSiegeTipsPanel.BindEvents()
    CS. UIEventListener.Get(UIMonsterSiegeTipsPanel.GetFoldButton_GameObject()).onClick = UIMonsterSiegeTipsPanel.OnFoldButtonClicked
    CS. UIEventListener.Get(UIMonsterSiegeTipsPanel.GetFoldButton_GameObject()).onDrag = UIMonsterSiegeTipsPanel.OnFoldDrag
end

function UIMonsterSiegeTipsPanel.BindMessage()
    UIMonsterSiegeTipsPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResActivityMonsterAttackTimesInfoMessage, UIMonsterSiegeTipsPanel.RefreshFirstPanel)
    UIMonsterSiegeTipsPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResActivityMonsterKillBossRankMessage, UIMonsterSiegeTipsPanel.RefreshSecondPanel)
    UIMonsterSiegeTipsPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPlayerChangeMapMessage, UIMonsterSiegeTipsPanel.PlayerChangeMap)
end
--endregion

--region UI事件
---初始化界面
function UIMonsterSiegeTipsPanel.InitPanel()
    UIMonsterSiegeTipsPanel.screenWidth = CS.UnityEngine.Screen.width
    UIMonsterSiegeTipsPanel.screenHeight = CS.UnityEngine.Screen.height
    --print(UIMonsterSiegeTipsPanel.screenHeight)
    UIMonsterSiegeTipsPanel.SuitScreen()
end
---切换地图
function UIMonsterSiegeTipsPanel.PlayerChangeMap()
    --print("切换地图")
    local mapInfo = CS.CSScene.getMapID()
    if mapInfo ~= 1003 then
        uimanager:ClosePanel("UIMonsterSiegeTipsPanel")
    end
end
---刷新第一阶段面板
---@param data activityV2.ResActivityMonsterAttackTimesInfo C# class类型消息数据
function UIMonsterSiegeTipsPanel:RefreshFirstPanel()
    --print("刷新第一阶段面板")
    if UIMonsterSiegeTipsPanel.mTimeCountCoroutine ~= nil then
        StopCoroutine(UIMonsterSiegeTipsPanel.mTimeCountCoroutine)
    end
    local data = CS.CSScene.MainPlayerInfo.ActivityInfo.FirstStageInfo
    if data == nil then
        --print("没有数据")
        return
    end
    UIMonsterSiegeTipsPanel.wave = data.curTimes
    ---刷新位置点
    local waveList = data.waveId
    if waveList ~= nil then
        UIMonsterSiegeTipsPanel.GetGridContainer().MaxCount = waveList.Count
        UIMonsterSiegeTipsPanel.mMonsterPointCount = waveList.Count
        for i = 0, waveList.Count - 1 do
            local waveInfo = UIMonsterSiegeTipsPanel.GetWavePosition(waveList[i])
            local mapInfo = CS.CSScene.getMapID()
            if waveInfo ~= nil and mapInfo ~= nil then
                CS.Utility_Lua.GetComponent(UIMonsterSiegeTipsPanel.GetGridContainer().controlList[i].gameObject, "UILabel").text = string.format("怪物坐标入侵点%d:[url=find:%d:%d:%d][u][2bcfed][%d,%d][-][/u][/url]", i + 1, mapInfo, waveInfo[1], waveInfo[2], waveInfo[1], waveInfo[2])
                if UIMonsterSiegeTipsPanel.mMonsterPoint[i] == nil then

                else
                    ---改变怪物点坐标
                    UIMonsterSiegeTipsPanel.mMonsterPoint[i].CoordX = waveInfo[1]
                    UIMonsterSiegeTipsPanel.mMonsterPoint[i].CoordY = waveInfo[1]
                end
            end
        end
    else
        UIMonsterSiegeTipsPanel.GetGridContainer().gameObject:SetActive(false)
    end
    ---刷新倒计时
    if data.subTime ~= nil then
        UIMonsterSiegeTipsPanel.mTimeCountCoroutine = StartCoroutine(UIMonsterSiegeTipsPanel.IEnumTimeCount, data.subTime)
    else
        UIMonsterSiegeTipsPanel.GetTimeCount_UILabel().gameObject:SetActive(false)
    end
    ---刷新波数显示
    if data.curTimes then
        UIMonsterSiegeTipsPanel.GetWaveCount_UILabel().text = "[00ff00]当前波数：" .. data.curTimes
    else
        UIMonsterSiegeTipsPanel.GetWaveCount_UILabel().gameObject:SetActive(false)
    end
end
---获取坐标点
function UIMonsterSiegeTipsPanel.GetWavePosition(waveID)
    if waveID == nil then
        return
    end
    local res, waveInfo = CS.Cfg_Monsters_WaveTableManager.Instance.dic:TryGetValue(tonumber(waveID))
    if res then
        local positionStr = waveInfo.position
        local mPosition = {}
        local str = string.Split(positionStr, "#")
        local index = 0;
        for k, v in pairs(str) do
            table.insert(mPosition, tonumber(v))
        end
        return mPosition
    end
end
---刷新第二阶段面板
---@param data activityV2.ResActivityMonsterKillBossRank C# class类型消息数据
function UIMonsterSiegeTipsPanel:RefreshSecondPanel(msgID, tblData, csData)
    local data = csData
    if data == nil then
        return
    end
    ---刷新排名
    local rank = data.info
    if rank ~= nil then
        UIMonsterSiegeTipsPanel.GetRankGrid_UIGridContainer().MaxCount = rank.Count
        for i = 0, rank.Count - 1 do
            local Grid = UIMonsterSiegeTipsPanel.GetRankGrid_UIGridContainer().controlList[i].gameObject
            CS.Utility_Lua.GetComponent(Grid.transform:Find("Score"), "UILabel").text = rank[i].param
            CS.Utility_Lua.GetComponent(Grid.transform:Find("Name"), "UILabel").text = rank[i].roleName
            CS.Utility_Lua.GetComponent(Grid.transform:Find("Number"), "UILabel").text = rank[i].rank
            local RankSprite = Grid.transform:Find("NumberSp").gameObject
            if rank[i].rank > 3 then
                RankSprite:SetActive(false)
            end
            if rank[i].id == CS.CSScene.MainPlayerInfo.ID then
                UIMonsterSiegeTipsPanel.GetMyNameLabel_UILabel().text = rank[i].roleName
                UIMonsterSiegeTipsPanel.GetMyScoreLabel_UILabel().text = rank[i].param
                UIMonsterSiegeTipsPanel.GetMyRankLabel_UILabel() .text = rank[i].rank
            end
        end
    end
end
---折叠按钮
function UIMonsterSiegeTipsPanel.OnFoldButtonClicked()
    UIMonsterSiegeTipsPanel.isShowPanel = not UIMonsterSiegeTipsPanel.isShowPanel
    UIMonsterSiegeTipsPanel.GetView_GameObject():SetActive(UIMonsterSiegeTipsPanel.isShowPanel)
    UIMonsterSiegeTipsPanel.GetWindow_GameObject():SetActive(UIMonsterSiegeTipsPanel.isShowPanel)
    if UIMonsterSiegeTipsPanel.isShowPanel then
        UIMonsterSiegeTipsPanel.SuitScreen()
    end
end
---切换面板1
function UIMonsterSiegeTipsPanel:SwitchToFirstPanel()
    UIMonsterSiegeTipsPanel.GetFirstStagePanel_GameObject():SetActive(true)
    UIMonsterSiegeTipsPanel.GetSecondStagePanel_GameObject():SetActive(false)
    UIMonsterSiegeTipsPanel.GetWaveCount_UILabel().text = "[00ff00]当前波数：1"
    UIMonsterSiegeTipsPanel.GetTimeCount_UILabel().text = "0"
end
---切换面板2
function UIMonsterSiegeTipsPanel:SwitchToSecondPanel()
    --print("切换到第二界面")
    StopCoroutine(UIMonsterSiegeTipsPanel.mTimeCountCoroutine)
    UIMonsterSiegeTipsPanel.GetFirstStagePanel_GameObject():SetActive(false)
    UIMonsterSiegeTipsPanel.GetSecondStagePanel_GameObject():SetActive(true)
    UIMonsterSiegeTipsPanel.DeleteAllMonsterPoint()
    local SecondWave = { [0] = 10200, [1] = 10201, [2] = 10202 }
    UIMonsterSiegeTipsPanel.mMonsterPointCount = 3
    for i = 0, UIMonsterSiegeTipsPanel.mMonsterPointCount - 1 do
        local info = UIMonsterSiegeTipsPanel.GetWavePosition(SecondWave[i])
        if info ~= nil then
            if UIMonsterSiegeTipsPanel.mMonsterPoint[i] == nil then

            else
                ---改变怪物点坐标
                UIMonsterSiegeTipsPanel.mMonsterPoint[i].CoordX = info[1]
                UIMonsterSiegeTipsPanel.mMonsterPoint[i].CoordY = info[1]
            end
        end
    end
end
---拖拽事件
function UIMonsterSiegeTipsPanel.OnFoldDrag(go, delta)
    if UIMonsterSiegeTipsPanel.isShowPanel then
        return
    end
    local mEventPos = UIMonsterSiegeTipsPanel.GetEvent_GameObject().transform.localPosition
    local mCurrentPos = UIMonsterSiegeTipsPanel.go.transform.localPosition
    local DragPos = mCurrentPos + CS.UnityEngine.Vector3(delta.x, delta.y, 0)
    local AimPos = DragPos
    if DragPos.x + mEventPos.x + UIMonsterSiegeTipsPanel.mButtonWidth / 2 > UIMonsterSiegeTipsPanel.screenWidth / 2 then
        AimPos.x = UIMonsterSiegeTipsPanel.screenWidth / 2 - UIMonsterSiegeTipsPanel.mButtonWidth / 2 - mEventPos.x
    elseif DragPos.x + mEventPos.x - UIMonsterSiegeTipsPanel.mButtonWidth / 2 <= -UIMonsterSiegeTipsPanel.screenWidth / 2 then
        AimPos.x = -UIMonsterSiegeTipsPanel.screenWidth / 2 + UIMonsterSiegeTipsPanel.mButtonWidth / 2 - mEventPos.x
    end
    if DragPos.y + mEventPos.y + UIMonsterSiegeTipsPanel.mButtonHeight / 2 > UIMonsterSiegeTipsPanel.screenHeight / 2 then
        AimPos.y = UIMonsterSiegeTipsPanel.screenHeight / 2 - UIMonsterSiegeTipsPanel.mButtonHeight / 2 - mEventPos.y
    elseif DragPos.y + mEventPos.y - UIMonsterSiegeTipsPanel.mButtonHeight / 2 <= -1 * UIMonsterSiegeTipsPanel.screenHeight / 2 then
        AimPos.y = -UIMonsterSiegeTipsPanel.screenHeight / 2 + UIMonsterSiegeTipsPanel.mButtonHeight / 2 - mEventPos.y
    end
    UIMonsterSiegeTipsPanel.go.transform.localPosition = AimPos
end
---适配屏幕
function UIMonsterSiegeTipsPanel.SuitScreen()
    local mEventPos = UIMonsterSiegeTipsPanel.GetEvent_GameObject().transform.localPosition
    local mCurrentPos = UIMonsterSiegeTipsPanel.go.transform.localPosition
    local width = mEventPos.x + mCurrentPos.x + UIMonsterSiegeTipsPanel.mWidth + UIMonsterSiegeTipsPanel.mButtonWidth / 2
    local height = mEventPos.y + mCurrentPos.y - UIMonsterSiegeTipsPanel.mHeight + UIMonsterSiegeTipsPanel.mButtonHeight / 2
    local xPos
    if width > UIMonsterSiegeTipsPanel.screenWidth / 2 then
        xPos = mEventPos.x - UIMonsterSiegeTipsPanel.mWidth / 2 - UIMonsterSiegeTipsPanel.mButtonWidth / 2
    else
        xPos = mEventPos.x + UIMonsterSiegeTipsPanel.mWidth / 2 + UIMonsterSiegeTipsPanel.mButtonWidth / 2
    end
    local yPos
    if height < -1 * UIMonsterSiegeTipsPanel.screenHeight / 2 then
        yPos = mEventPos.y + UIMonsterSiegeTipsPanel.mHeight / 2 - UIMonsterSiegeTipsPanel.mButtonHeight / 2
    else
        yPos = mEventPos.y - UIMonsterSiegeTipsPanel.mHeight / 2 + UIMonsterSiegeTipsPanel.mButtonHeight / 2
    end
    UIMonsterSiegeTipsPanel.GetWindow_GameObject().transform.localPosition = CS.UnityEngine.Vector3(xPos, yPos, 0)
    UIMonsterSiegeTipsPanel.GetView_GameObject().transform.localPosition = CS.UnityEngine.Vector3(xPos, yPos, 0)
end
---删除所有怪物点
function UIMonsterSiegeTipsPanel.DeleteAllMonsterPoint()
    if UIMonsterSiegeTipsPanel.mMonsterPointCount == nil or UIMonsterSiegeTipsPanel.mMonsterPointCount == 0 then
        return
    end
    UIMonsterSiegeTipsPanel.mMonsterPoint = {}
end
--endregion
--region 协程
---倒计时协程
---@param desTime int 剩余时间
function UIMonsterSiegeTipsPanel.IEnumTimeCount(desTime)
    local time = desTime
    local isRun = true
    while isRun do
        if desTime <= 0 then
            isRun = false
        end
        UIMonsterSiegeTipsPanel.GetTimeCount_UILabel().text = "[00ff00]下一波:" .. UIMonsterSiegeTipsPanel.SetTime(time)
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
        time = time - 1
        if UIMonsterSiegeTipsPanel.wave ~= nil then
            if UIMonsterSiegeTipsPanel.wave == 6 and time <= 0 then
                UIMonsterSiegeTipsPanel.GetTimeCount_UILabel().text = "[00ff00]等待Boss降临"
                isRun = false
            end
        end
    end
end
---时间换算
function UIMonsterSiegeTipsPanel.SetTime(time)
    local minute = math.modf(time / 60)
    local second = time - minute * 60
    if minute <= 0 then
        minute = 0
    end
    if second <= 0 then
        second = 0
    end
    return string.format("%02d分%02d秒", minute, second)
end
--endregion

--region onDestroy
function ondestroy()
    StopCoroutine(UIMonsterSiegeTipsPanel.mTimeCountCoroutine)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResActivityMonsterAttackTimesInfoMessage, UIMonsterSiegeTipsPanel.RefreshFirstPanel)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResActivityMonsterKillBossRankMessage, UIMonsterSiegeTipsPanel.RefreshSecondPanel)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResPlayerChangeMapMessage, UIMonsterSiegeTipsPanel.PlayerChangeMap)
    UIMonsterSiegeTipsPanel.DeleteAllMonsterPoint()
end
--endregion

return UIMonsterSiegeTipsPanel