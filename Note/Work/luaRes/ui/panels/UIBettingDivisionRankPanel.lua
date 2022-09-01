---@class UIBettingDivisionRankPanel:UIBase 武道会上次排行
local UIBettingDivisionRankPanel = {}

--region 局部变量

--endregion

--region 初始化

function UIBettingDivisionRankPanel:Init()
    self:InitComponents()
    UIBettingDivisionRankPanel.BindUIEvents()
    UIBettingDivisionRankPanel.BindNetMessage()
    CS.CSScene.MainPlayerInfo.ActivityInfo.ShowRank = false
    networkRequest.ReqLookDuboRank(0)
end

--- 初始化组件
function UIBettingDivisionRankPanel:InitComponents()
    ---@type Top_LoopScrollView
    UIBettingDivisionRankPanel.firstRankMiddle = self:GetCurComp("WidgetRoot/Panel/firstRightView/Scroll View/firstRankMiddle", "Top_LoopScrollView")
    ---@type UnityEngine.GameObject
    UIBettingDivisionRankPanel.closeBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
end

function UIBettingDivisionRankPanel.BindUIEvents()
    --点击事件
    CS.UIEventListener.Get(UIBettingDivisionRankPanel.closeBtn).onClick = UIBettingDivisionRankPanel.OnClickCloseBtn
end

function UIBettingDivisionRankPanel.BindNetMessage()
    UIBettingDivisionRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLookDuboRankMessage, UIBettingDivisionRankPanel.RefreshRankList)
end
--endregion

--region 函数监听

--点击函数
---@param go UnityEngine.GameObject
function UIBettingDivisionRankPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel('UIBettingDivisionRankPanel')
end
--endregion


--region 网络消息处理

function UIBettingDivisionRankPanel.RefreshRankList()
    UIBettingDivisionRankPanel.RefreshRankListUI()
end

--endregion

--region UI

function UIBettingDivisionRankPanel.RefreshRankListUI()
    local rankList = CS.CSScene.MainPlayerInfo.RankInfoV2.mWDHRankInfo
    if rankList.Count == 0 then
        return
    end
    UIBettingDivisionRankPanel.firstRankMiddle:ResetToBegining(true)
    UIBettingDivisionRankPanel.rankUnitInfo = {}
    UIBettingDivisionRankPanel.firstRankMiddle:Init(rankList, UIBettingDivisionRankPanel.RankTempCallBack)

end

function UIBettingDivisionRankPanel.RankTempCallBack(item, data)
    --拿到对应的预设
    local go = item.widget.gameObject
    if go == nil or data == nil then
        return
    end
    local bg = go.transform:Find("Background")
    local firstSprite = CS.Utility_Lua.GetComponent(go.transform:Find("firstSprite"), "UISprite")
    local firstValue = CS.Utility_Lua.GetComponent(go.transform:Find("firstValue"), "UILabel")
    local secondValue = CS.Utility_Lua.GetComponent(go.transform:Find("secondValue"), "UILabel")
    local thirdValue = CS.Utility_Lua.GetComponent(go.transform:Find("thirdValue"), "UILabel")
    local rewardList = CS.Utility_Lua.GetComponent(go.transform:Find("Reward/rewardList"), "Top_UIGridContainer")
    if firstSprite and data.no then
        firstSprite.spriteName = data.no > 4 and '' or tostring(data.no)
        bg.gameObject:SetActive(data.no % 2 ~= 1)
    end
    if firstValue and data.no then
        firstValue.text = data.no < 4 and '' or tostring(data.no)
    end
    if secondValue and data.name then
        secondValue.text = data.name
    end
    if thirdValue and data.killNum then
        thirdValue.text = tostring(data.killNum)
    end
    if rewardList and data.awardItems then
        for i = 0, data.awardItems.Count - 1 do
            rewardList.MaxCount = i + 1
            local infobool, miteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(data.awardItems[i].ItemConfigId)
            if infobool then
                local rewardGo = rewardList.controlList[i]
                if rewardGo then
                    local temp = templatemanager.GetNewTemplate(rewardGo, luaComponentTemplates.UIActivityDuplicateRewardItemTemplate)
                    temp:RefreshUI(miteminfo.id, data.awardItems[i].count)
                end
            end
        end
    end
end
--endregion

return UIBettingDivisionRankPanel