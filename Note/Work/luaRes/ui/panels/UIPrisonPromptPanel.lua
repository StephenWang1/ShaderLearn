---贿赂监狱长
local UIPrisonPromptPanel = {}

--region 局部变量
UIPrisonPromptPanel.centerBtnCallBack = nil
UIPrisonPromptPanel.goldTbl = nil
--endregion

--region 初始化

function UIPrisonPromptPanel:Init()
    self:InitComponents()
    UIPrisonPromptPanel.BindUIEvents()
    UIPrisonPromptPanel.BindNetMessage()
end

function UIPrisonPromptPanel:Show(temp)
    if temp then
        UIPrisonPromptPanel.centerBtnCallBack = temp.centerBtnCallBack
    end
    UIPrisonPromptPanel.InitGold()
end

--- 初始化组件
function UIPrisonPromptPanel:InitComponents()
    ---@type UnityEngine.GameObject
    UIPrisonPromptPanel.CenterBtn = self:GetCurComp("events/CenterBtn", "GameObject")
    ---@type UnityEngine.GameObject
    UIPrisonPromptPanel.close = self:GetCurComp("events/close", "GameObject")
    ---@type Top_UILabel 货币数量
    UIPrisonPromptPanel.itemgold = self:GetCurComp("view/itemgold", "Top_UILabel")
    ---@type Top_UISprite 货币
    UIPrisonPromptPanel.Sprite = self:GetCurComp("view/itemgold/Sprite", "Top_UISprite")
end

function UIPrisonPromptPanel.BindUIEvents()
    --点击事件
    CS.UIEventListener.Get(UIPrisonPromptPanel.CenterBtn).onClick = UIPrisonPromptPanel.OnClickCenterBtn
    --点击事件
    CS.UIEventListener.Get(UIPrisonPromptPanel.close).onClick = UIPrisonPromptPanel.OnClickclose
end

function UIPrisonPromptPanel.BindNetMessage()
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.xx, MessageCallback)
end
--endregion

--region 函数监听
--点击函数
---@param go UnityEngine.GameObject
function UIPrisonPromptPanel.OnClickCenterBtn(go)
    local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    if bagInfo == nil then
        return
    end
    local value = bagInfo:GetCoinAmount(UIPrisonPromptPanel. coinId)
    --if isGetValue then
    if value < UIPrisonPromptPanel.coinCount then
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(155)
        if res then
            local cont = string.format(desInfo.content, UIPrisonPromptPanel.coinName)
            Utility.ShowPopoTips(go.transform, cont, 207)
        else
            Utility.ShowPopoTips(go.transform, UIPrisonPromptPanel.coinName, 207)
        end
        return
    end
    --end
    networkRequest.ReqEarlyLeavePrison(1)
    if UIPrisonPromptPanel.centerBtnCallBack ~= nil then
        UIPrisonPromptPanel.centerBtnCallBack(go)
    end

    uimanager:ClosePanel('UIPrisonPromptPanel')
end

--点击函数
---@param go UnityEngine.GameObject
function UIPrisonPromptPanel.OnClickclose(go)
    uimanager:ClosePanel('UIPrisonPromptPanel')
end

--endregion


--region 网络消息处理

--endregion

--region UI
function UIPrisonPromptPanel.InitGold()
    local list = CS.Cfg_GlobalTableManager.Instance:GetNeedCoinList()
    if list.Count < 4 then
        return
    end
    local needInfo = string.Split(list[3], '#')
    UIPrisonPromptPanel.coinId = tonumber(needInfo[2])
    UIPrisonPromptPanel.coinCount = tonumber(needInfo[1])
    local isFind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(UIPrisonPromptPanel.coinId)
    if isFind then
        UIPrisonPromptPanel.Sprite.spriteName = info.icon
        UIPrisonPromptPanel.coinName = CS.Cfg_ItemsTableManager.Instance:GetItemName(UIPrisonPromptPanel.coinId)
    end
    UIPrisonPromptPanel.itemgold.text = tostring(UIPrisonPromptPanel.coinCount)
end

--endregion

--region otherFunction

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIPrisonPromptPanel