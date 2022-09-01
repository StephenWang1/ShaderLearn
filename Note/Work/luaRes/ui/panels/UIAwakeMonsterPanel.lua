---@class UIAwakeMonsterPanel:UIBase 唤醒面板
local UIAwakeMonsterPanel = {}

--region 局部变量
UIAwakeMonsterPanel.needFirstItemID = 6110001
UIAwakeMonsterPanel.needSecondItemID = 6110002
--endregion

--region 初始化

function UIAwakeMonsterPanel:Init()
    self:InitComponents()
    UIAwakeMonsterPanel.InitParameters()
    UIAwakeMonsterPanel.BindUIEvents()
    UIAwakeMonsterPanel.BindNetMessage()
end

--- 初始化变量
function UIAwakeMonsterPanel.InitParameters()
    --当前选中个数
    UIAwakeMonsterPanel.num = 1
    UIAwakeMonsterPanel.min = 1
    --当前拥有最大值
    UIAwakeMonsterPanel.ItemMaxCount = 0
    --当前进度
    UIAwakeMonsterPanel.curFill = 0
    --剩余唤醒进度
    UIAwakeMonsterPanel.remainCount = 0
    UIAwakeMonsterPanel.targetMonsterlId = 0
    UIAwakeMonsterPanel.targetMonsterInfo = nil
    UIAwakeMonsterPanel.des = "需要%s张塔罗牌唤醒"
end

--- 初始化组件
function UIAwakeMonsterPanel:InitComponents()
    ---@type UILabel 描述
    UIAwakeMonsterPanel.lb_describe = self:GetCurComp("WidgetRoot/view/lb_describe", "UILabel")
    ---@type UnityEngine.GameObject 按钮减
    UIAwakeMonsterPanel.reduce = self:GetCurComp("WidgetRoot/numSelect/reduce", "GameObject")
    ---@type UnityEngine.GameObject 按钮加
    UIAwakeMonsterPanel.add = self:GetCurComp("WidgetRoot/numSelect/add", "GameObject")
    ---@type Top_UILabel 数量
    UIAwakeMonsterPanel.countLabel = self:GetCurComp("WidgetRoot/numSelect/inputcount/Label", "Top_UILabel")
    ---@type Top_UILabel 当前拥有数量
    UIAwakeMonsterPanel.itemgold = self:GetCurComp("WidgetRoot/itemgold", "Top_UILabel")
    ---@type Top_UILabel 价格icon
    UIAwakeMonsterPanel.itemIcon = self:GetCurComp("WidgetRoot/itemgold/Sprite", "UISprite")
    ---@type Top_UILabel
    UIAwakeMonsterPanel.itemDes = self:GetCurComp("WidgetRoot/itemgold/Label", "UILabel")
    ---@type Top_UIInput
    UIAwakeMonsterPanel.inputcount = self:GetCurComp("WidgetRoot/numSelect/inputcount", "Top_UIInput")
    ---@type UnityEngine.GameObject 使用按钮
    UIAwakeMonsterPanel.btn_center = self:GetCurComp("WidgetRoot/event/btn_center", "GameObject")
    ---@type UnityEngine.GameObject 关闭按钮
    UIAwakeMonsterPanel.btn_close = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
    ---@type UnityEngine.GameObject 快捷途径按钮
    UIAwakeMonsterPanel.getwayBtn = self:GetCurComp("WidgetRoot/numSelect/getway", "GameObject")
    ---@type UISprite 快捷途径按钮背景
    UIAwakeMonsterPanel.getWayBtnBG = self:GetCurComp("WidgetRoot/numSelect/getway/Background", "UISprite")
end

function UIAwakeMonsterPanel.BindUIEvents()
    --点击加事件
    CS.UIEventListener.Get(UIAwakeMonsterPanel.add).onClick = UIAwakeMonsterPanel.OnClickAdd
    --点击减事件
    CS.UIEventListener.Get(UIAwakeMonsterPanel.reduce).onClick = UIAwakeMonsterPanel.OnClickReduce
    --点击购买事件
    CS.UIEventListener.Get(UIAwakeMonsterPanel.btn_center).onClick = UIAwakeMonsterPanel.OnClickCenter
    --点击购买事件
    CS.UIEventListener.Get(UIAwakeMonsterPanel.btn_close).onClick = UIAwakeMonsterPanel.OnClickClose
    --点击获取途径
    CS.UIEventListener.Get(UIAwakeMonsterPanel.getwayBtn).onClick = UIAwakeMonsterPanel.OnClickGetWay

    CS.EventDelegate.Add(UIAwakeMonsterPanel.inputcount.onChange, UIAwakeMonsterPanel.OnUIInputValueChanged);
end

function UIAwakeMonsterPanel.BindNetMessage()
    UIAwakeMonsterPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResMapCommonMessage, UIAwakeMonsterPanel.OnMapCommonMessage)
    UIAwakeMonsterPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UIAwakeMonsterPanel.OnResBagChangeMessage)
    UIAwakeMonsterPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.CloseMonsterHeadPanel, UIAwakeMonsterPanel.OnCloseMonsterHeadPanelMessage)
end

function UIAwakeMonsterPanel:Show(avater)
    if avater ~= nil and avater.BaseInfo ~= nil and avater.BaseInfo.monsterTable ~= nil and avater.BaseInfo.treasureMonsterTable ~= nil then
        UIAwakeMonsterPanel.targetMonsterInfo = avater.BaseInfo
        UIAwakeMonsterPanel.targetMonsterlId = avater.ID
        UIAwakeMonsterPanel.curFill = avater.BaseInfo.Data.wakeUpCount
        UIAwakeMonsterPanel.targetCount = avater.BaseInfo.treasureMonsterTable.wakeUpTime
        UIAwakeMonsterPanel.getwayBtn:SetActive(true)
        UIAwakeMonsterPanel.RefreshTopUI()
        UIAwakeMonsterPanel.RefreshDownUI()
        UIAwakeMonsterPanel.InitFill()
    else
        if isOpenLog then
            luaDebug.Log("参数错误,关闭面板")
        end
        uimanager:ClosePanel("UIAwakeMonsterPanel")
    end
end

--endregion

--region 函数监听
--点击加函数
---@param go UnityEngine.GameObject
function UIAwakeMonsterPanel.OnClickAdd(go)
    UIAwakeMonsterPanel.num = UIAwakeMonsterPanel.num + 1
    if UIAwakeMonsterPanel.ItemMaxCount > UIAwakeMonsterPanel.remainCount then
        UIAwakeMonsterPanel.num = UIAwakeMonsterPanel.remainCount
    else
        UIAwakeMonsterPanel.num = UIAwakeMonsterPanel.ItemMaxCount == 0 and 1 or UIAwakeMonsterPanel.ItemMaxCount
    end
    UIAwakeMonsterPanel.inputcount.value = tostring(UIAwakeMonsterPanel.num)
end

--点击减函数
---@param go UnityEngine.GameObject
function UIAwakeMonsterPanel.OnClickReduce(go)
    UIAwakeMonsterPanel.num = UIAwakeMonsterPanel.num - 1
    if UIAwakeMonsterPanel.num <= 0 then

        if UIAwakeMonsterPanel.ItemMaxCount > UIAwakeMonsterPanel.remainCount then
            UIAwakeMonsterPanel.num = UIAwakeMonsterPanel.remainCount
        else
            UIAwakeMonsterPanel.num = UIAwakeMonsterPanel.ItemMaxCount == 0 and 1 or UIAwakeMonsterPanel.ItemMaxCount
        end
    end
    UIAwakeMonsterPanel.inputcount.value = tostring(UIAwakeMonsterPanel.num)
end

--点击确定函数
---@param go UnityEngine.GameObject
function UIAwakeMonsterPanel.OnClickCenter(go)
    if UIAwakeMonsterPanel.num == 0 or UIAwakeMonsterPanel.targetMonsterID == 0 then
        return
    end
    if UIAwakeMonsterPanel.num > UIAwakeMonsterPanel.ItemMaxCount then
        Utility.ShowPopoTips(go, nil, 305)
        return
    end
    networkRequest.ReqMapCommon(4, UIAwakeMonsterPanel.num, nil, UIAwakeMonsterPanel.targetMonsterlId)
end

--点击关闭函数
---@param go UnityEngine.GameObject
function UIAwakeMonsterPanel.OnClickClose(go)
    if CS.CSScene.IsLanuchMainPlayer and CS.CSScene.Sington then
        if CS.CSAutoFightMgr.Instance.IsOn == false then
            CS.CSScene.Sington.MainPlayer.SkillEngine.SkillReleaseType = CS.ESkillReleaseMethodType.None
        end
        CS.CSScene.Sington.MainPlayer.TouchEvent:cancelSelect()
    end
    uimanager:ClosePanel("UIAwakeMonsterPanel")
end

--点击获取途径函数
---@param go UnityEngine.GameObject
function UIAwakeMonsterPanel.OnClickGetWay(go)
    Utility.ShowItemGetWay(UIAwakeMonsterPanel.needFirstItemID, go, LuaEnumWayGetPanelArrowDirType.Left)
end

function UIAwakeMonsterPanel.OnUIInputValueChanged()
    if UIAwakeMonsterPanel.countLabel.text == "" then
        UIAwakeMonsterPanel.num = 0
    else
        UIAwakeMonsterPanel.num = tonumber(UIAwakeMonsterPanel.countLabel.text)
    end

    if UIAwakeMonsterPanel.num > UIAwakeMonsterPanel.remainCount then
        UIAwakeMonsterPanel.num = UIAwakeMonsterPanel.remainCount == 0 and 1 or UIAwakeMonsterPanel.remainCount
    elseif UIAwakeMonsterPanel.num <= 0 then
        UIAwakeMonsterPanel.num = 1
    end
    UIAwakeMonsterPanel.inputcount.value = tostring(UIAwakeMonsterPanel.num)
end

--endregion


--region 网络消息处理

function UIAwakeMonsterPanel.OnMapCommonMessage(msgID, tblData)
    if tblData.type == LuaEnumCommonMapMsgType.Hunt_Status then
        if tblData.data64 == UIAwakeMonsterPanel.targetMonsterlId and UIAwakeMonsterPanel.targetMonsterlId ~= 0 then
            if tblData.data == 0 then
                uimanager:ClosePanel("UIAwakeMonsterPanel")
            end
            UIAwakeMonsterPanel.curFill = tonumber(tblData.str)
            UIAwakeMonsterPanel.RefreshTopUI()
        end
    end
end

function UIAwakeMonsterPanel.OnResBagChangeMessage()
    UIAwakeMonsterPanel.RefreshDownUI()
end

function UIAwakeMonsterPanel.OnCloseMonsterHeadPanelMessage(id, monsterid)
    if monsterid ~= nil and UIAwakeMonsterPanel.targetMonsterInfo then
        if monsterid == UIAwakeMonsterPanel.targetMonsterInfo.ID then
            uimanager:ClosePanel("UIAwakeMonsterPanel")
        end
    end
end

--endregion

--region UI

function UIAwakeMonsterPanel.InitFill()
    if UIAwakeMonsterPanel.ItemMaxCount == 0 then
        UIAwakeMonsterPanel.num = 1
    else
        UIAwakeMonsterPanel.num = UIAwakeMonsterPanel.ItemMaxCount > UIAwakeMonsterPanel.remainCount and UIAwakeMonsterPanel.remainCount or UIAwakeMonsterPanel.ItemMaxCount
    end
    UIAwakeMonsterPanel.inputcount.value = UIAwakeMonsterPanel.num
end

function UIAwakeMonsterPanel.RefreshTopUI()
    if UIAwakeMonsterPanel.targetCount ~= nil then
        local color = UIAwakeMonsterPanel.curFill >= UIAwakeMonsterPanel.targetCount and luaEnumColorType.Green or luaEnumColorType.Red
        local str = color .. UIAwakeMonsterPanel.curFill .. "[-]/" .. UIAwakeMonsterPanel.targetCount
        UIAwakeMonsterPanel.remainCount = UIAwakeMonsterPanel.targetCount - UIAwakeMonsterPanel.curFill
        UIAwakeMonsterPanel.lb_describe.text = string.format(UIAwakeMonsterPanel.des, str)
    end
end

function UIAwakeMonsterPanel.RefreshDownUI()
    UIAwakeMonsterPanel.ItemMaxCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UIAwakeMonsterPanel.needFirstItemID)
    UIAwakeMonsterPanel.ItemMaxCount = UIAwakeMonsterPanel.ItemMaxCount + CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UIAwakeMonsterPanel.needSecondItemID)
    local color = UIAwakeMonsterPanel.ItemMaxCount > 0 and luaEnumColorType.White or luaEnumColorType.Red
    UIAwakeMonsterPanel.itemgold.text = color .. tostring(UIAwakeMonsterPanel.ItemMaxCount)
    UIAwakeMonsterPanel.getWayBtnBG.color = UIAwakeMonsterPanel.ItemMaxCount > 0 and LuaEnumUnityColorType.DarkGray or LuaEnumUnityColorType.White
    --UIAwakeMonsterPanel.getwayBtn:SetActive(UIAwakeMonsterPanel.ItemMaxCount == 0)
    UIAwakeMonsterPanel.itemIcon:UpdateAnchors()
    UIAwakeMonsterPanel.itemDes:UpdateAnchors()
end

--endregion

return UIAwakeMonsterPanel