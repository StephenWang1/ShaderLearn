local UIHuanJingRandomRankPanel = {}

--region 组件
function UIHuanJingRandomRankPanel.GetmCurFloor()
    if (uimanager:GetPanel("UIHuanJingLeftMainPanel") ~= nil) then
        return uimanager:GetPanel("UIHuanJingLeftMainPanel").mCurFloor
    end
    return 1
end
function UIHuanJingRandomRankPanel.GetCloseBtn_GameObject()
    if (UIHuanJingRandomRankPanel.mCloseBtn == nil) then
        UIHuanJingRandomRankPanel.mCloseBtn = UIHuanJingRandomRankPanel:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return UIHuanJingRandomRankPanel.mCloseBtn
end

function UIHuanJingRandomRankPanel.GetReceiveBtn_GameObject()
    if (UIHuanJingRandomRankPanel.mReceiveBtn == nil) then
        UIHuanJingRandomRankPanel.mReceiveBtn = UIHuanJingRandomRankPanel:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    end
    return UIHuanJingRandomRankPanel.mReceiveBtn
end

function UIHuanJingRandomRankPanel.GetReceiveBtn_GameObject()
    if (UIHuanJingRandomRankPanel.mReceiveBtn == nil) then
        UIHuanJingRandomRankPanel.mReceiveBtn = UIHuanJingRandomRankPanel:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    end
    return UIHuanJingRandomRankPanel.mReceiveBtn
end

function UIHuanJingRandomRankPanel.GetPrizeList_GridContainer()
    if (UIHuanJingRandomRankPanel.mPrizeListGrid == nil) then
        UIHuanJingRandomRankPanel.mPrizeListGrid = UIHuanJingRandomRankPanel:GetCurComp("WidgetRoot/Reward/PanelArea/Grild", "Top_UIGridContainer")
    end
    return UIHuanJingRandomRankPanel.mPrizeListGrid
end

function UIHuanJingRandomRankPanel.GetRemainNumbers_UILabel()
    if (UIHuanJingRandomRankPanel.mRemainNumber == nil) then
        UIHuanJingRandomRankPanel.mRemainNumber = UIHuanJingRandomRankPanel:GetCurComp("WidgetRoot/Reward/Number/value", "Top_UILabel")
    end
    return UIHuanJingRandomRankPanel.mRemainNumber
end

--endregion

--region 初始化
function UIHuanJingRandomRankPanel:Init()
    UIHuanJingRandomRankPanel.BindMessage()
    UIHuanJingRandomRankPanel.BindUIEventes()
    networkRequest.ReqReceiveRankingForNpc(CS.CSSceneExt.Sington:GetNpcLid(315))
end

function UIHuanJingRandomRankPanel:Show()

end

function UIHuanJingRandomRankPanel.BindMessage()
    UIHuanJingRandomRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResReceiveRankingForNpcMessage, UIHuanJingRandomRankPanel.RefreshUIPanel)
end

function UIHuanJingRandomRankPanel.BindUIEventes()
    CS.UIEventListener.Get(UIHuanJingRandomRankPanel.GetCloseBtn_GameObject()).onClick = UIHuanJingRandomRankPanel.CloseBtnOnClick
    CS.UIEventListener.Get(UIHuanJingRandomRankPanel.GetReceiveBtn_GameObject()).onClick = UIHuanJingRandomRankPanel.ReceiveBtnOnClick
end
--endregion

--region 客户端事件
function UIHuanJingRandomRankPanel.CloseBtnOnClick()
    uimanager:ClosePanel("UIHuanJingRandomRankPanel")
end

function UIHuanJingRandomRankPanel.ReceiveBtnOnClick()
    networkRequest.ReqNpcReceivePrize(CS.CSSceneExt.Sington:GetNpcLid(315))
end

--endregion

--region 服务器事件

--endregion

--region 刷新界面
function UIHuanJingRandomRankPanel.RefreshUIPanel(id, data)
    local residuecount = Utility.GetLuaTableCount(data.peopleInfo)
    UIHuanJingRandomRankPanel.GetPrizeList_GridContainer().MaxCount = residuecount
    for i = 0, residuecount - 1 do
        local go = UIHuanJingRandomRankPanel.GetPrizeList_GridContainer().controlList[i]
        local rank = CS.Utility_Lua.GetComponent(go.transform:Find("rank"), "Top_UILabel")
        local rankSprite = CS.Utility_Lua.GetComponent(go.transform:Find("rankicon"), "Top_UISprite")
        local bg = CS.Utility_Lua.GetComponent(go.transform:Find("Awards/UIItem/bg"), "Top_UISprite")
        local count = CS.Utility_Lua.GetComponent(go.transform:Find("Awards/UIItem/count"), "Top_UILabel")
        rank.text = i + 1
        if (i < 3) then
            rankSprite.gameObject:SetActive(true)
            rankSprite.spriteName = i + 1
            rank.gameObject:SetActive(false)
        else
            rankSprite.gameObject:SetActive(false)
            rank.gameObject:SetActive(true)
        end
        local prizeinfo = UIHuanJingRandomRankPanel.GetPrizeIcon(i + 1)
        if (prizeinfo.list.Count >= 2) then
            count.text = prizeinfo.list[1]
            local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(prizeinfo.list[0])
            if (res) then
                bg.spriteName = itemInfo.icon
            end
        end
        local name = CS.Utility_Lua.GetComponent(go.transform:Find("name"), "Top_UILabel")
        name.text = data.peopleInfo[i + 1].name
    end
    UIHuanJingRandomRankPanel.GetRemainNumbers_UILabel().text = data.receiveCount - residuecount
end

function UIHuanJingRandomRankPanel.GetPrizeIcon(index)
    local isFind, Info = CS.Cfg_MiGongTableManager.Instance.dic:TryGetValue(CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateBasicInfo.cfgId)
    if (isFind) then
        if (index == 1) then
            return Info.firstPrize
        elseif (index == 2) then
            return Info.secondPrize
        elseif (index == 3) then
            return Info.thirdPrize
        else
            return Info.surplusPrize
        end
    end
end
--endregion

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResReceiveRankingForNpcMessage, UIHuanJingRandomRankPanel.RefreshUIPanel)
end

return UIHuanJingRandomRankPanel