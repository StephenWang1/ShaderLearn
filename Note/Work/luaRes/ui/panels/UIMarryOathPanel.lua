---结婚誓言
local UIMarryOathPanel = {}

--region 局部变量
UIMarryOathPanel.ringId = 0
UIMarryOathPanel.originText = ""
--endregion

--region 初始化

function UIMarryOathPanel:Init()
    self:InitComponents()
    UIMarryOathPanel.BindUIEvents()
    UIMarryOathPanel.BindNetMessage()
end

function UIMarryOathPanel:Show(info)
    if info then
        UIMarryOathPanel.InitUI(info)
    end
    UIMarryOathPanel.inputBoxCollider.enabled = false
end

--- 初始化组件
function UIMarryOathPanel:InitComponents()
    ---@type Top_UISprite 男方icon
    UIMarryOathPanel.manHeadIcon = self:GetCurComp("WidgetRoot/marry/view/our/ourheadIcon", "Top_UISprite")
    ---@type Top_UILabel 男方名字
    UIMarryOathPanel.manName = self:GetCurComp("WidgetRoot/marry/view/our/ourname", "Top_UILabel")
    ---@type Top_UISprite 女方icon
    UIMarryOathPanel.womanHeadIcon = self:GetCurComp("WidgetRoot/marry/view/lover/loverheadIcon", "Top_UISprite")
    ---@type Top_UILabel 女方名字
    UIMarryOathPanel.womanName = self:GetCurComp("WidgetRoot/marry/view/lover/lovername", "Top_UILabel")
    ---@type Top_UISprite 戒指icon
    UIMarryOathPanel.ring = self:GetCurComp("WidgetRoot/marry/view/ring", "Top_UISprite")
    ---@type Top_UISprite 戒指名称
    UIMarryOathPanel.ringname = self:GetCurComp("WidgetRoot/marry/view/ringname", "Top_UILabel")
    ---@type Top_UIInput 输入
    UIMarryOathPanel.oathInput = self:GetCurComp("WidgetRoot/marry/view/oathInput", "Top_UIInput")
    ---@type Top_UILabel 显示
    UIMarryOathPanel.Label = self:GetCurComp("WidgetRoot/marry/view/oathInput/Label", "Top_UILabel")
    ---@type UnityEngine.GameObject 确定按钮
    UIMarryOathPanel.LeftBtn = self:GetCurComp("WidgetRoot/marry/events/LeftBtn", "GameObject")
    ---@type UnityEngine.GameObject 关闭按钮
    UIMarryOathPanel.btn_close = self:GetCurComp("WidgetRoot/marry/events/btn_close", "GameObject")
    ---@type UnityEngine.BoxCollider 输入框碰撞盒
    UIMarryOathPanel.inputBoxCollider = CS.Utility_Lua.GetComponent(UIMarryOathPanel.oathInput.gameObject, "BoxCollider")
    ---@type UnityEngine.GameObject 编辑按钮
    UIMarryOathPanel.write = self:GetCurComp("WidgetRoot/marry/events/write","GameObject")
end

function UIMarryOathPanel.BindUIEvents()
    --点击戒指事件
    --CS.UIEventListener.Get(UIMarryOathPanel.ring.gameObject).onClick = UIMarryOathPanel.OnClickring
    --点击确定事件
    CS.UIEventListener.Get(UIMarryOathPanel.LeftBtn).onClick = UIMarryOathPanel.OnClickLeftBtn
    --点击关闭事件
    CS.UIEventListener.Get(UIMarryOathPanel.btn_close).onClick = UIMarryOathPanel.OnClickbtn_close
    --点击编辑事件
    CS.UIEventListener.Get(UIMarryOathPanel.write).onClick = UIMarryOathPanel.OnClickwrite
end

function UIMarryOathPanel.BindNetMessage()
    UIMarryOathPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResMatchmakerMessage, UIMarryOathPanel.ResMatchmakerMessageCallback)
end
--endregion

--region 函数监听

--点击戒指函数
---@param go UnityEngine.GameObject
function UIMarryOathPanel.OnClickring(go)
end

--点击确定函数
---@param go UnityEngine.GameObject
function UIMarryOathPanel.OnClickLeftBtn(go)
    --誓言输入空
    if UIMarryOathPanel.Label.text == '' or UIMarryOathPanel.Label.text == "" or UIMarryOathPanel.Label.text == UIMarryOathPanel.originText then
        UIMarryOathPanel.ShowBubbleTips(go, 138)
        return
    end
    networkRequest.ReqMatchmaker(UIMarryOathPanel.Label.text)
end

--点击关闭函数
---@param go UnityEngine.GameObject
function UIMarryOathPanel.OnClickbtn_close(go)
    networkRequest.ReqInterruptMarry()
    uimanager:ClosePanel('UIMarryOathPanel')
end

--点击编辑函数
---@param go UnityEngine.GameObject
function UIMarryOathPanel.OnClickwrite(go)
    UIMarryOathPanel.write:SetActive(false)
    UIMarryOathPanel.inputBoxCollider.enabled = true
    UIMarryOathPanel.oathInput.isSelected = true
end


--endregion


--region 网络消息处理

function UIMarryOathPanel.ResMatchmakerMessageCallback(msgID, tblData, csData)
    if csData then
        UIMarryOathPanel.ShowStr(csData.checkingMatchmaker)
    end
end

--endregion

--region UI

function UIMarryOathPanel.InitUI(info)
    UIMarryOathPanel.manHeadIcon.spriteName = 'headicon' .. info.man.sex .. info.man.career
    UIMarryOathPanel.womanHeadIcon.spriteName = 'headicon' .. info.woman.sex .. info.woman.career
    UIMarryOathPanel.manName.text = info.man.name
    UIMarryOathPanel.womanName.text = info.woman.name
    UIMarryOathPanel.ringId = info.ringItemId
    local isFind,Info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(info.ringItemId)
    if isFind then
        UIMarryOathPanel.ring.spriteName = Info.icon
        UIMarryOathPanel.ringname.text = Info.name
    end
    UIMarryOathPanel.originText = UIMarryOathPanel.Label.text
end

--显示誓词
function UIMarryOathPanel.ShowStr(str)
    UIMarryOathPanel.LeftBtn:SetActive(false)
    UIMarryOathPanel.inputBoxCollider.enabled = false
    UIMarryOathPanel.Label.text = str == nil and '' or str
    UIMarryOathPanel.write:SetActive(false)
end

--endregion

--region otherFunction
---显示气泡
function UIMarryOathPanel.ShowBubbleTips(go, id, ...)
    if go == nil then
        return
    end
    local TipsInfo = {}
    if ... ~= nil then
        local str = ''
        local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(id)
        if isfind then
            str = string.format(data.content, ...)
        end
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResMatchmakerMessage, UIMarryOathPanel.ResMatchmakerMessageCallback)
end

--endregion

return UIMarryOathPanel