---前往追踪面板
---@class UIArrestTrackPromptPanel:UIBase
local UIArrestTrackPromptPanel = {}

--region 局部变量
--1:追踪 2：前往追踪
UIArrestTrackPromptPanel.type = 1
UIArrestTrackPromptPanel.rid = 0
UIArrestTrackPromptPanel.mapId = 0
UIArrestTrackPromptPanel.posX = 0
UIArrestTrackPromptPanel.posY = 0
UIArrestTrackPromptPanel.goldTab = nil
UIArrestTrackPromptPanel.goldName = ''
--endregion

--region 初始化
---info FriendProto.ResEnemyPosition 仇人位置信息
function UIArrestTrackPromptPanel:Show(info)
    if info then
        UIArrestTrackPromptPanel.type = info.mapId == 0 and 1 or 2
        UIArrestTrackPromptPanel.rid = info.targetId
        UIArrestTrackPromptPanel.ChangeState()
        UIArrestTrackPromptPanel.SetInfo(info)
    end
    UIArrestTrackPromptPanel.InitGolb()
end

function UIArrestTrackPromptPanel:Init()
    self:InitComponents()
    UIArrestTrackPromptPanel.BindUIEvents()
    UIArrestTrackPromptPanel.BindNetEvent()
end

--- 初始化组件
function UIArrestTrackPromptPanel:InitComponents()
    ---@type UnityEngine.GameObject 追踪模块
    UIArrestTrackPromptPanel.Track = self:GetCurComp("view/Track", "GameObject")
    ---@type UnityEngine.GameObject 前往模块
    UIArrestTrackPromptPanel.Position = self:GetCurComp("view/Position", "GameObject")
    ---@type UnityEngine.GameObject 左侧按钮
    -- UIArrestTrackPromptPanel.LeftBtn = self:GetCurComp("events/LeftBtn", "GameObject")
    ---@type UnityEngine.GameObject 右侧按钮
    UIArrestTrackPromptPanel.RightBtn = self:GetCurComp("events/RightBtn", "GameObject")
    ---@type UnityEngine.GameObject
    UIArrestTrackPromptPanel.close = self:GetCurComp("events/close", "GameObject")
    ---@type Top_UILabel 右侧按钮文本
    UIArrestTrackPromptPanel.Label = self:GetCurComp("events/RightBtn/Label", "Top_UILabel")
    ---@type Top_UILabel 追踪名字文本
    UIArrestTrackPromptPanel.trackName = self:GetCurComp("view/Track/Name", "Top_UILabel")
    ---@type Top_UILabel 前往追踪名字文本
    UIArrestTrackPromptPanel.Name = self:GetCurComp("view/Position/Name", "Top_UILabel")
    ---@type Top_UILabel 地图文本
    UIArrestTrackPromptPanel.Map = self:GetCurComp("view/Position/Map/Map", "Top_UILabel")
    ---@type Top_UILabel 坐标文本
    UIArrestTrackPromptPanel.Locatin = self:GetCurComp("view/Position/Locatin/Locatin", "Top_UILabel")
    ---@type Top_UILabel 货币数量
    UIArrestTrackPromptPanel.itemgold = self:GetCurComp("view/Track/itemgold", "Top_UILabel")
    ---@type Top_UISprite 货币
    UIArrestTrackPromptPanel.Sprite = self:GetCurComp("view/Track/itemgold/Sprite", "Top_UISprite")

end

function UIArrestTrackPromptPanel.BindUIEvents()
    --点击左侧按钮事件
    -- CS.UIEventListener.Get(UIArrestTrackPromptPanel.LeftBtn).onClick = UIArrestTrackPromptPanel.OnClickclose
    --点击右侧按钮事件
    CS.UIEventListener.Get(UIArrestTrackPromptPanel.RightBtn).onClick = UIArrestTrackPromptPanel.OnClickRightBtn
    --点击关闭事件
    CS.UIEventListener.Get(UIArrestTrackPromptPanel.close).onClick = UIArrestTrackPromptPanel.OnClickclose
end

function UIArrestTrackPromptPanel.BindNetEvent()
    UIArrestTrackPromptPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOfferMatterCodeMessage, UIArrestTrackPromptPanel.OnResOfferMatterCodeMessage)
end

--endregion

--region 函数监听

--点击取消函数
---@param go UnityEngine.GameObject
function UIArrestTrackPromptPanel.OnClickclose(go)
    uimanager:ClosePanel('UIArrestTrackPromptPanel')
end

--点击右按钮函数
---@param go UnityEngine.GameObject
function UIArrestTrackPromptPanel.OnClickRightBtn(go)
    if UIArrestTrackPromptPanel.type == 1 then
        networkRequest.ReqEnemyPosition(UIArrestTrackPromptPanel.rid)
    else
        CS.Cfg_DeliverTableManager.Instance:FindPos(UIArrestTrackPromptPanel.mapId, UIArrestTrackPromptPanel.posX, UIArrestTrackPromptPanel.posY)
        uimanager:ClosePanel('UIArrestTrackPromptPanel')
    end
end

--endregion

--region 网络消息处理

function UIArrestTrackPromptPanel.OnResOfferMatterCodeMessage(id, data)
    if data then
        if data.code == 2 then
            --可追踪
            uimanager:ClosePanel('UIArrestTrackPromptPanel')
        elseif data.code == 23 then
            --钱不够
            UIArrestTrackPromptPanel.ShowBubbleTips(UIArrestTrackPromptPanel.RightBtn, 137, UIArrestTrackPromptPanel.goldName)
        elseif data.code == 21 then
            --不在线
            UIArrestTrackPromptPanel.ShowBubbleTips(UIArrestTrackPromptPanel.RightBtn, 114)
        elseif data.code == 22 then
            --在副本中
            UIArrestTrackPromptPanel.ShowBubbleTips(UIArrestTrackPromptPanel.RightBtn, 114)
        elseif data.code == 20 then
            --追踪不存在
            UIArrestTrackPromptPanel.ShowBubbleTips(UIArrestTrackPromptPanel.RightBtn, 115)
        end
    end
end
--endregion

--region UI

function UIArrestTrackPromptPanel.InitGolb()
    local list = CS.Cfg_GlobalTableManager.Instance.trackNeedCoin
    if list == nil or list.Length < 2 then
        return
    end
    local id = list[1]
    local isFind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        UIArrestTrackPromptPanel.goldName = CS.Cfg_ItemsTableManager.Instance:GetItemName(id)
        UIArrestTrackPromptPanel.Sprite.spriteName = info.icon
    end
    UIArrestTrackPromptPanel.itemgold.text = list[0]
end

function UIArrestTrackPromptPanel.SetInfo(Info)
    if Info.mapId ~= 0 then
        UIArrestTrackPromptPanel.posX = Info.x
        UIArrestTrackPromptPanel.posY = Info.y
        UIArrestTrackPromptPanel.mapId = Info.mapId

        UIArrestTrackPromptPanel.Name.text = Info.targetName
        UIArrestTrackPromptPanel.Map.text = Info.mapName
        UIArrestTrackPromptPanel.Locatin.text = tostring(Info.x) .. ',' .. tostring(Info.y)
    else
        UIArrestTrackPromptPanel.trackName.text = Info.targetName
    end
end

function UIArrestTrackPromptPanel.ChangeState()
    UIArrestTrackPromptPanel.Label.text = UIArrestTrackPromptPanel.type == 1 and '追踪' or '前往'
    UIArrestTrackPromptPanel.Track:SetActive(UIArrestTrackPromptPanel.type == 1)
    UIArrestTrackPromptPanel.Position:SetActive(UIArrestTrackPromptPanel.type == 2)
end

--endregion

--region otherFunction
function UIArrestTrackPromptPanel.ShowBubbleTips(go, id, ...)
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
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIArrestTrackPromptPanel";
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion

return UIArrestTrackPromptPanel
