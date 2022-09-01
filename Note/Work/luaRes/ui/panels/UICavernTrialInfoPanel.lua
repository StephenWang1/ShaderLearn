---洞窟试炼信息面板
---@class UICavernTrialInfoPanel:UIBase
local UICavernTrialInfoPanel = {}

UICavernTrialInfoPanel.PanelLayerType = CS.UILayerType.BasicPlane

function UICavernTrialInfoPanel:Init()
    UICavernTrialInfoPanel.InitComponents()
    UICavernTrialInfoPanel.InitOther()
end

--通过工具生成 控件变量
function UICavernTrialInfoPanel.InitComponents()
    --倒计时
    UICavernTrialInfoPanel.mCountDown_UILabel =  UICavernTrialInfoPanel:GetCurComp("WidgetRoot/Constrain/Tweener/view/times", "UILabel")
    --退出按钮
    UICavernTrialInfoPanel.mExitBtn_GameObject =  UICavernTrialInfoPanel:GetCurComp("WidgetRoot/Constrain/Tweener/view/btn_exit", "GameObject")
    --奖励列表
    UICavernTrialInfoPanel.mRewardGrid_UIGrid =  UICavernTrialInfoPanel:GetCurComp("WidgetRoot/Constrain/Tweener/view/rewardItemList", "UIGridContainer")
    --排行列表
    UICavernTrialInfoPanel.mRankGrid_UIGrid =  UICavernTrialInfoPanel:GetCurComp("WidgetRoot/Constrain/Tweener/view/rankItemList", "UIGridContainer")

end
--初始化 变量 按钮点击 服务器消息事件等
function UICavernTrialInfoPanel.InitOther()

    --倒计时协程
    UICavernTrialInfoPanel.mCountDownCoroutine = nil
    --排行榜
    UICavernTrialInfoPanel.mRankPanel = ""
    --点击退出
    CS.UIEventListener.Get(UICavernTrialInfoPanel.mExitBtn_GameObject).onClick = function()
        networkRequest.ReqDeliverByConfig(1001, false)
    end
    --网络事件
    UICavernTrialInfoPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCavesDuplicateRankInfoMessage, UICavernTrialInfoPanel.OnResCavesDuplicateRankInfoMessage)
    UICavernTrialInfoPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDuplicateEndMessage, UICavernTrialInfoPanel.OnResDuplicateEndMessage)

end

function UICavernTrialInfoPanel:Show()
    UICavernTrialInfoPanel.RefreshRank()
    UICavernTrialInfoPanel.RefreshAward()
    UICavernTrialInfoPanel.StartCountDown()
end

---返回活动排行消息
function UICavernTrialInfoPanel.OnResCavesDuplicateRankInfoMessage(msgId, tblData, csData)
    UICavernTrialInfoPanel.RefreshRank()
end
---返回副本结束消息
function UICavernTrialInfoPanel.OnResDuplicateEndMessage(msgId, tblData, csData)
    local activity = "洞窟试炼"
    local rankList = {}
    local csRankList = CS.CSScene.MainPlayerInfo.DuplicateV2.CavesRankInfo
    for i = 0, csRankList.Count - 1 do
        local temp = {}
        temp.Rank = csRankList[i].no
        temp.RoleId = csRankList[i].duplicateItem.playerId
        temp.score = csRankList[i].duplicateItem.count
        table.insert(rankList, temp)
    end
    --uimanager:CreatePanel("UIActivityDuplicateRankPanel", function(panel)
    --    UICavernTrialInfoPanel.mRankPanel = panel
    --end, activity, rankList)
end

---刷新排行
function UICavernTrialInfoPanel.RefreshRank()
    --最大显示人数
    local isFind, item = CS.Cfg_GlobalTableManager.Instance:TryGetValue(20159)
    if isFind and CS.CSScene.MainPlayerInfo.DuplicateV2.CavesRankInfo then
        local count = tonumber(item.value)
        if CS.CSScene.MainPlayerInfo.DuplicateV2.CavesRankInfo.Count < count then
            count = CS.CSScene.MainPlayerInfo.DuplicateV2.CavesRankInfo.Count
        end
        UICavernTrialInfoPanel.mRankGrid_UIGrid.MaxCount = count
        if count == 0 then
            return
        end
        for i = 0, count - 1 do
            local info = CS.CSScene.MainPlayerInfo.DuplicateV2.CavesRankInfo[i]
            if info and info.duplicateItem then
                local template = templatemanager.GetNewTemplate(UICavernTrialInfoPanel.mRankGrid_UIGrid.controlList[i], luaComponentTemplates.UICavernTrialInfoRankInfoTemplate)
                if template then
                    local isMe = false
                    if info.playerId == CS.CSScene.MainPlayerInfo.ID then
                        isMe = true
                    end
                    template:Refresh(info.name, info.no, info.duplicateItem.count, isMe)
                end
            end
        end
    end

end
---刷新奖励
function UICavernTrialInfoPanel.RefreshAward()
    local isFind, item = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(8001)
    if isFind then
        --活动奖励
        UICavernTrialInfoPanel.mRewardGrid_UIGrid.MaxCount = item.rewards.list.Count
        for i = 0, UICavernTrialInfoPanel.mRewardGrid_UIGrid.controlList.Count - 1 do
            local data = item.rewards.list[i]
            if data.list.Count == 2 then
                local template = templatemanager.GetNewTemplate(UICavernTrialInfoPanel.mRewardGrid_UIGrid.controlList[i], luaComponentTemplates.UIActivityDuplicateRewardItemTemplate)
                template:RefreshUI(data.list[0], data.list[1])
            else
                luaDebug.LogError("活动副本的奖励的参数只应该有物品ID和数量两个")
            end
        end
    end

end
---开始倒计时
function UICavernTrialInfoPanel.StartCountDown()
    if UICavernTrialInfoPanel.mCountDownCoroutine then
        StopCoroutine(UICavernTrialInfoPanel.mCountDownCoroutine)
    end
    UICavernTrialInfoPanel.mCountDownCoroutine = StartCoroutine(UICavernTrialInfoPanel.IEnumStartCountDown)
end

function UICavernTrialInfoPanel.IEnumStartCountDown()
    local millisecond = CS.CSScene.MainPlayerInfo.DuplicateV2:GetCavesCountDownMillionSecond()
    local isRun = true
    while (isRun)
    do
        millisecond = millisecond - 1000
        if millisecond < 0 then
            isRun = false
            millisecond = 0
        end
        local hour, minute, second = Utility.MillisecondToFormatTime(millisecond)
        UICavernTrialInfoPanel.mCountDown_UILabel.text = string.format("[ff0000]%02.0f:%02.0f:%02.0f", hour, minute, second)
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end

function ondestroy()

    if UICavernTrialInfoPanel.mRankPanel then
        uimanager:ClosePanel(UICavernTrialInfoPanel.mRankPanel)
    end

    if UICavernTrialInfoPanel.mCountDownCoroutine then
        StopCoroutine(UICavernTrialInfoPanel.mCountDownCoroutine)
    end
end

return UICavernTrialInfoPanel