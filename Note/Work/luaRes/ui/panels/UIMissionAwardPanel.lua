---@class UIMissionAwardPanel:UIBase
local UIMissionAwardPanel = {}
--region parameters
---文本显示格式字数限制
UIMissionAwardPanel.mShowLabelLimit = nil
--endregion
--region components
function UIMissionAwardPanel.GetLBNameUILabel()
    if UIMissionAwardPanel.mLB_name_UILabele == nil then
        UIMissionAwardPanel.mLB_name_UILabel = UIMissionAwardPanel:GetCurComp("WidgetRoot/view/lb_name", "UILabel")
    end
    return UIMissionAwardPanel.mLB_name_UILabel
end

function UIMissionAwardPanel.GetLBdescribeUILabel()
    if UIMissionAwardPanel.mLB_describe_UILabele == nil then
        UIMissionAwardPanel.mLB_describe_UILabel = UIMissionAwardPanel:GetCurComp("WidgetRoot/view/lb_describe", "UILabel")
    end
    return UIMissionAwardPanel.mLB_describe_UILabel
end

function UIMissionAwardPanel.GetBtn_sureUISprite()
    if UIMissionAwardPanel.mBtn_sure_UISprite == nil then
        UIMissionAwardPanel.mBtn_sure_UISprite = UIMissionAwardPanel:GetCurComp("WidgetRoot/event/btn_sure", "UISprite")
    end
    return UIMissionAwardPanel.mBtn_sure_UISprite
end

function UIMissionAwardPanel.GetBtn_closeUISprite()
    if UIMissionAwardPanel.mBtn_close_UISprite == nil then
        UIMissionAwardPanel.mBtn_close_UISprite = UIMissionAwardPanel:GetCurComp("WidgetRoot/event/btn_close", "UISprite")
    end
    return UIMissionAwardPanel.mBtn_close_UISprite
end
--endregion
--region init
--endregion
function UIMissionAwardPanel:Init()
    ---@type Top_UIGridContainer
    UIMissionAwardPanel.rewardList = self:GetCurComp("WidgetRoot/rewardList", "Top_UIGridContainer")
    ---@type Top_UILabel
    UIMissionAwardPanel.label_sure = self:GetCurComp("WidgetRoot/event/btn_sure/label", "Top_UILabel")

    UIMissionAwardPanel.npcID = nil
    UIMissionAwardPanel.BindUIEvents()
    UIMissionAwardPanel.InitData()
end

function UIMissionAwardPanel:Show(taskTbl, missionData)
    --Utility.TryFadeOutMainMenusLeft("UIMissionAwardPanel");
    UIMissionAwardPanel:SetEffects()
    if taskTbl and missionData then
        self.ShowTask(taskTbl, missionData)
    end
end

---初始化数据
function UIMissionAwardPanel.InitData()
    UIMissionAwardPanel.mShowLabelLimit = UIMissionAwardPanel.GetGlobalData(20293)
end

---获取Global表数据
function UIMissionAwardPanel.GetGlobalData(dataId)
    local res, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(dataId)
    if res then
        return tonumber(info.value)
    end
    return nil
end

---@param tbl_task TABLE.CFG_TASK
---@param data CSMission
function UIMissionAwardPanel.ShowTask(tbl_task, data, npcID)
    UIMissionAwardPanel.tbl_task = tbl_task
    UIMissionAwardPanel.csmission = data
    UIMissionAwardPanel.npcID = npcID
    UIMissionAwardPanel.GetLBNameUILabel().text = CS.CSMissionManager.Instance:GetMeritInfo(tbl_task.id, tbl_task.completeinfo)
    local strs = string.Split(tbl_task.rewards, "&")

    UIMissionAwardPanel.uiItemTable = {}
    local showItemInfo = UIMissionAwardPanel:GetAwardItemList(strs)
    UIMissionAwardPanel.rewardList.MaxCount = #showItemInfo
    for i = 0, UIMissionAwardPanel.rewardList.MaxCount - 1 do
        if UIMissionAwardPanel.uiItemTable[i+1] == nil then
            UIMissionAwardPanel.uiItemTable[i+1] = templatemanager.GetNewTemplate(UIMissionAwardPanel.rewardList.controlList[i], luaComponentTemplates.UIItem)
        end
        local itemInfoTable = showItemInfo[i + 1]
        if itemInfoTable ~= nil then
            UIMissionAwardPanel.uiItemTable[i+1]:RefreshUIWithItemInfo(itemInfoTable.ItemInfo, itemInfoTable.showNum)
            UIMissionAwardPanel.uiItemTable[i+1]:GetEventListener().onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfoTable.ItemInfo, showRight = false })
            end
        end
    end
    UIMissionAwardPanel.SetBtnPosition(#showItemInfo)
    local describe = ''
    local num = data.State
    if num == CS.ETaskV2_TaskState.NOT_ACCEPT then
        UIMissionAwardPanel.label_sure.text = "接受任务"
        describe = tbl_task.tips4
    elseif num == CS.ETaskV2_TaskState.HAS_COMPLETE then
        UIMissionAwardPanel.label_sure.text = "提交任务"
        describe = tbl_task.tip3
    end
    UIMissionAwardPanel.GetLBdescribeUILabel().text = describe
    local length = CS.Utility_Lua.StringLength(describe)
    if UIMissionAwardPanel.mShowLabelLimit then
        if length > UIMissionAwardPanel.mShowLabelLimit then
            UIMissionAwardPanel.GetLBdescribeUILabel().pivot = CS.UIWidget.Pivot.BottomLeft
        else
            UIMissionAwardPanel.GetLBdescribeUILabel().pivot = CS.UIWidget.Pivot.Center
        end
    end
end

function UIMissionAwardPanel:GetAwardItemList(awardTable)
    local showItemTable = {}
    for k, v in pairs(awardTable) do
        local itemIdAndCount = string.Split(v, '#')
        if #itemIdAndCount < 2 then
            return showItemTable
        end
        local itemId = itemIdAndCount[1]
        local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
        if itemInfoIsFind then
            ---不可叠加则显示背包内物品的使用次数
            if itemInfo.overlying == 1 then
                local useNum = ternary(itemInfo.reuseAmount == 0, 1, itemInfo.reuseAmount)
                for i = 1, tonumber(itemIdAndCount[2]) do
                    local ItemInfoTable = { ItemInfo = itemInfo, showNum = useNum }
                    table.insert(showItemTable, ItemInfoTable)
                end
            else
                local ItemInfoTable = { ItemInfo = itemInfo, showNum = tonumber(itemIdAndCount[2]) }
                table.insert(showItemTable, ItemInfoTable)
            end
        end
    end
    return showItemTable
end

function UIMissionAwardPanel.BindUIEvents()
    -- bind uievents
    local UIEventListener = CS.UIEventListener

    UIEventListener.Get(UIMissionAwardPanel.GetBtn_sureUISprite().gameObject).onClick = UIMissionAwardPanel.OnClickBtnSure
    UIEventListener.Get(UIMissionAwardPanel.GetBtn_closeUISprite().gameObject).onClick = UIMissionAwardPanel.OnExitClick
    UIMissionAwardPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_AutoDoMission, UIMissionAwardPanel.OnClickBtnSure)
end

function UIMissionAwardPanel.OnClickBtnSure(go)
    if UIMissionAwardPanel.csmission == nil then
        return
    end
    local num = UIMissionAwardPanel.csmission.State
    if num == CS.ETaskV2_TaskState.NOT_ACCEPT then
        networkRequest.ReqAcceptTask(UIMissionAwardPanel.tbl_task.id, UIMissionAwardPanel.csmission.fnpc)
    elseif num == CS.ETaskV2_TaskState.HAS_COMPLETE then
        networkRequest.ReqSubmitTask(UIMissionAwardPanel.tbl_task.id, 1)
        -- CS.CSMissionManager.Instance:RemoveMission(UIMissionAwardPanel.tbl_task.id)
        UIMissionAwardPanel.Transfer(UIMissionAwardPanel.tbl_task)
    if  UIMissionAwardPanel.uiItemTable~=nil then
        for i = 1, #UIMissionAwardPanel.uiItemTable do
            luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = UIMissionAwardPanel.uiItemTable[i].ItemInfo.id, from = UIMissionAwardPanel.uiItemTable[i].go.transform.position}) 
        end
    end
              
    end
    uimanager:ClosePanel("UIMissionAwardPanel")
end

---传送
function UIMissionAwardPanel.Transfer(data)
    if data.positiondeliverid ~= 0 then
        networkRequest.ReqDeliverByConfig(data.positiondeliverid, nil)
        CS.CSMissionManager.Instance.IsNeedObstructAutoTask = true;
    end
end

function UIMissionAwardPanel:SetEffects()
    if self.btnEffect == nil then
        local effectparent = self.GetBtn_sureUISprite().transform
        if CS.StaticUtility.IsNull(effectparent) ~= true then
            CS.CSResourceManager.Singleton:AddQueueCannotDelete("700154", CS.ResourceType.UIEffect, function(res)
                if res and res.MirrorObj then
                    if CS.StaticUtility.IsNull(effectparent) ~= true then
                        local poolItem = res:GetUIPoolItem()
                        if poolItem ~= nil then
                            self.btnEffect = poolItem.go
                            if self.btnEffect then
                                self.btnEffect.transform.parent = effectparent
                                self.btnEffect.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
                                self.btnEffect.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
                            end
                        end
                    end
                end
            end
            , CS.ResourceAssistType.UI)
        end
    end
end

function UIMissionAwardPanel.OnExitClick(go)
    uimanager:ClosePanel("UIMissionAwardPanel")
end

function UIMissionAwardPanel.GetWorldRealLength(showWord)
    local length = 0
    local i = 1
    while true do
        local curByte = string.byte(showWord, i)
        local byteCount = 1
        if curByte > 239 then
            --4字节字符
            byteCount = 4
        elseif curByte > 223 then
            --汉子
            byteCount = 3
        elseif curByte > 128 then
            --双字节字符
            byteCount = 2
        else
            --单字节字符
            byteCount = 1
        end
        i = i + byteCount
        length = length + 1
        if i > #showWord then
            break
        end
    end
    return length
end

function UIMissionAwardPanel.SetBtnPosition(count)
    if UIMissionAwardPanel.GetBtn_sureUISprite() == nil then
        return
    end
    local y = count == 0 and 5 or -42
    local v3 = UIMissionAwardPanel.GetBtn_sureUISprite().transform.localPosition
    UIMissionAwardPanel.GetBtn_sureUISprite().transform.localPosition = CS.UnityEngine.Vector3(v3.x, y, 0)
end

function start()
    Utility.TryFadeOutMainMenusLeft("UIRolePanelTagPanel");
end

function ondestroy()
    UIMissionAwardPanel.mLB_name_UILabel = nil
    UIMissionAwardPanel.mLB_describe_UILabel = nil
    if UIMissionAwardPanel.ReleaseClientEventHandler ~= nil then
        UIMissionAwardPanel:ReleaseClientEventHandler()
    end
    if UIMissionAwardPanel.ReleaseSocketEventHandler ~= nil then
        UIMissionAwardPanel:ReleaseSocketEventHandler()
    end
    if (luaEventManager.HasCallback(LuaCEvent.MainMenus_LeftFadeIn)) then
        luaEventManager.DoCallback(LuaCEvent.MainMenus_LeftFadeIn, "UIMissionAwardPanel")
    end
end

return UIMissionAwardPanel