local UILsUnlockModePanel = {}

--region 局部变量
UILsUnlockModePanel.closeCallBack = nil
UILsUnlockModePanel.isCallBack = true
UILsUnlockModePanel.itemId = 0
--endregion

--region 初始化

function UILsUnlockModePanel:Init()
    self:AddCollider()
    self:InitComponents()
    UILsUnlockModePanel.InitParameters()
    UILsUnlockModePanel.BindUIEvents()
    --UILsUnlockModePanel.BindNetMessage()
    UILsUnlockModePanel.InitUI()
end

--- 初始化变量
function UILsUnlockModePanel.InitParameters()

end

--- 初始化组件
function UILsUnlockModePanel:InitComponents()
    ---@type UnityEngine.GameObject
    UILsUnlockModePanel.CloseBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    ---@type UnityEngine.GameObject 继续任务
    -- UILsUnlockModePanel.SchemeOneBtn = self:GetCurComp("WidgetRoot/view/Scheme1/Btn", "GameObject")
    ---@type UnityEngine.GameObject 快速解封
    -- UILsUnlockModePanel.SchemeTwoBtn = self:GetCurComp("WidgetRoot/view/Scheme2/Btn", "GameObject")

    ---@type UnityEngine.GameObject 灵兽
    UILsUnlockModePanel.Scheme2 = self:GetCurComp("WidgetRoot/view/Scheme2", "GameObject")
    ---@type UISprite 灵兽头像
    UILsUnlockModePanel.icon = self:GetCurComp("WidgetRoot/view/Scheme2/icon", "UISprite")
    ---@type UILabel 灵兽名称
    UILsUnlockModePanel.title = self:GetCurComp("WidgetRoot/view/Scheme2/title", "UILabel")
    ---@type UILabel 灵兽描述
    UILsUnlockModePanel.dec = self:GetCurComp("WidgetRoot/view/Scheme2/dec", "UILabel")
end

function UILsUnlockModePanel.BindUIEvents()
    --点击事件
    CS.UIEventListener.Get(UILsUnlockModePanel.CloseBtn).onClick = UILsUnlockModePanel.OnClickCloseBtn
    --点击继续任务事件
    CS.UIEventListener.Get(UILsUnlockModePanel.Scheme2).onClick = UILsUnlockModePanel.OnClickSchemeGoBtn
    --点击继续任务事件
    -- CS.UIEventListener.Get(UILsUnlockModePanel.SchemeOneBtn).onClick = UILsUnlockModePanel.OnClickSchemeOneBtn
    --点击快速解封事件
    --CS.UIEventListener.Get(UILsUnlockModePanel.SchemeTwoBtn).onClick = UILsUnlockModePanel.OnClickSchemeTwoBtn
end

function UILsUnlockModePanel.BindNetMessage()
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.UILsUnlockModePanel, MessageCallback)
end
--endregion

--region 函数监听
--点击函数
---@param go UnityEngine.GameObject
function UILsUnlockModePanel.OnClickCloseBtn(go)
    uimanager:ClosePanel('UILsUnlockModePanel')
end

--点击继续任务函数
---@param go UnityEngine.GameObject
function UILsUnlockModePanel.OnClickSchemeOneBtn(go)
    uimanager:ClosePanel('UILsUnlockModePanel')
end

--点击函数
---@param go UnityEngine.GameObject
function UILsUnlockModePanel.OnClickSchemeTwoBtn(go)
    UILsUnlockModePanel.ShowTips()
end

function UILsUnlockModePanel.OnClickSchemeGoBtn()
    if UILsUnlockModePanel.ServantItemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = UILsUnlockModePanel.ServantItemInfo, showRight = false })
    end
end
--endregion


--region 网络消息处理

--endregion

--region UI

function UILsUnlockModePanel.InitUI()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22153)
    if not isFind then
        return
    end
    local infoArray = string.Split(info.value, '#')
    local id = infoArray[1]
    isFind, UILsUnlockModePanel.ServantItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        UILsUnlockModePanel.icon.spriteName = UILsUnlockModePanel.ServantItemInfo.icon
        UILsUnlockModePanel.title.text = UILsUnlockModePanel.ServantItemInfo.name
        UILsUnlockModePanel.dec.text = infoArray[2]
    end

end

---显示购买tips
function UILsUnlockModePanel.ShowTips()
    local isFind, info = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(64)
    if isFind then
        local needID = CS.Cfg_GlobalTableManager.Instance.unlockTCLSNeedCoinId
        local needCount = CS.Cfg_GlobalTableManager.Instance.unLockTCLSNeedCoinCount
        local coinName = CS.Cfg_ItemsTableManager.Instance:GetItemName(needID)
        local nowCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinNum(needID)
        local temp = {}
        temp.IsClose = false
        temp.IsShowGoldLabel = true
        temp.Content = string.format(info.des, needCount, coinName)
        temp.Content = string.gsub(temp.Content, '\\n', '\n')
        temp.LeftDescription = info.leftButton
        temp.RightDescription = info.rightButton
        temp.ID = 64
        isFind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(needID)
        if isFind then
            temp.GoldIcon = info.icon
        end
        temp.GoldCount = needCount
        temp.CallBack = function(go)
            if nowCount < needCount then
                local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(248)
                if isfind then
                    local str = string.format(data.content, coinName)
                    Utility.ShowPopoTips(go.GetCenterButton_GameObject(), str, 248, "UILsUnlockModePanel")
                end
                return
            end
            networkRequest.ReqUnlockLingShouTask()
            uimanager:ClosePanel('UIPromptPanel')
            uimanager:ClosePanel('UILsUnlockModePanel')
        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end

--endregion

--region otherFunction

--endregion

--region ondestroy

function ondestroy()
    --if UILsUnlockModePanel.isCallBack then
    --    luaEventManager.DoCallback(LuaCEvent.ShowLvPackEffect)
    --end
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.UILsUnlockModePanel, MessageCallback)
end

--endregion

return UILsUnlockModePanel