---@class UIGangTrackPromptPanel:UIBase
local UIGangTrackPromptPanel = {}

UIGangTrackPromptPanel.roleID = 0
UIGangTrackPromptPanel.NeedItemInfo = nil
UIGangTrackPromptPanel.NeedItemCount = 0
UIGangTrackPromptPanel.FindMapID = 0
UIGangTrackPromptPanel.PosX = 0
UIGangTrackPromptPanel.PosY = 0
UIGangTrackPromptPanel.FindPathLine = 1
--region 组件
function UIGangTrackPromptPanel.GetCloseBtn_GameObject()
    if (UIGangTrackPromptPanel.mCloseBtn == nil) then
        UIGangTrackPromptPanel.mCloseBtn = UIGangTrackPromptPanel:GetCurComp("events/close", "GameObject")
    end
    return UIGangTrackPromptPanel.mCloseBtn
end

function UIGangTrackPromptPanel.GetItemgold_UILabel()
    if (UIGangTrackPromptPanel.mItemgold_UILabel == nil) then
        UIGangTrackPromptPanel.mItemgold_UILabel = UIGangTrackPromptPanel:GetCurComp("view/Track/itemgold", "UILabel")
    end
    return UIGangTrackPromptPanel.mItemgold_UILabel
end

function UIGangTrackPromptPanel.GetItemgold_UISprite()
    if (UIGangTrackPromptPanel.mItemgold_Sprite == nil) then
        UIGangTrackPromptPanel.mItemgold_Sprite = UIGangTrackPromptPanel:GetCurComp("view/Track/itemgold/Sprite", "UISprite")
    end
    return UIGangTrackPromptPanel.mItemgold_Sprite
end

function UIGangTrackPromptPanel.GetConfirmBtn_GameObject()
    if (UIGangTrackPromptPanel.mConfirmBtn == nil) then
        UIGangTrackPromptPanel.mConfirmBtn = UIGangTrackPromptPanel:GetCurComp("view/Track/ConfirmBtn", "GameObject")
    end
    return UIGangTrackPromptPanel.mConfirmBtn
end

function UIGangTrackPromptPanel.GetGoBtn_GameObject()
    if (UIGangTrackPromptPanel.mGoBtn == nil) then
        UIGangTrackPromptPanel.mGoBtn = UIGangTrackPromptPanel:GetCurComp("view/Position/GoBtn", "GameObject")
    end
    return UIGangTrackPromptPanel.mGoBtn
end

function UIGangTrackPromptPanel.GetTrack_GameObject()
    if (UIGangTrackPromptPanel.mTrack == nil) then
        UIGangTrackPromptPanel.mTrack = UIGangTrackPromptPanel:GetCurComp("view/Track", "GameObject")
    end
    return UIGangTrackPromptPanel.mTrack
end

function UIGangTrackPromptPanel.GetPosition_GameObject()
    if (UIGangTrackPromptPanel.mPosition == nil) then
        UIGangTrackPromptPanel.mPosition = UIGangTrackPromptPanel:GetCurComp("view/Position", "GameObject")
    end
    return UIGangTrackPromptPanel.mPosition
end

function UIGangTrackPromptPanel.GetPlayerName_UILabel()
    if (UIGangTrackPromptPanel.mPlayerName == nil) then
        UIGangTrackPromptPanel.mPlayerName = UIGangTrackPromptPanel:GetCurComp("view/Position/Name", "Top_UILabel")
    end
    return UIGangTrackPromptPanel.mPlayerName
end

function UIGangTrackPromptPanel.GetPlayerMap_UILabel()
    if (UIGangTrackPromptPanel.mPlayerMap == nil) then
        UIGangTrackPromptPanel.mPlayerMap = UIGangTrackPromptPanel:GetCurComp("view/Position/Map/Map", "Top_UILabel")
    end
    return UIGangTrackPromptPanel.mPlayerMap
end

function UIGangTrackPromptPanel.GetPlayerLocatin_UILabel()
    if (UIGangTrackPromptPanel.mPlayerLocatin == nil) then
        UIGangTrackPromptPanel.mPlayerLocatin = UIGangTrackPromptPanel:GetCurComp("view/Position/Locatin/Locatin", "Top_UILabel")
    end
    return UIGangTrackPromptPanel.mPlayerLocatin
end

---获取内容文本
---@return UILabel
function UIGangTrackPromptPanel:GetContentLabel()
    if self.mContentLabel == nil then
        self.mContentLabel = self:GetCurComp("view/Track/Content", "UILabel")
    end
    return self.mContentLabel
end
--endregion

--region 初始化
function UIGangTrackPromptPanel:Init()
    UIGangTrackPromptPanel:BindUIEvent()
    UIGangTrackPromptPanel:BindMessage()
end

function UIGangTrackPromptPanel:Show(id)
    if (id ~= nil) then
        UIGangTrackPromptPanel.roleID = id
    end
    UIGangTrackPromptPanel:RefreshUI()
end

function UIGangTrackPromptPanel:BindUIEvent()
    CS.UIEventListener.Get(UIGangTrackPromptPanel.GetCloseBtn_GameObject()).onClick = self.CloseBtnOnClickEvent
    CS.UIEventListener.Get(UIGangTrackPromptPanel.GetConfirmBtn_GameObject()).onClick = self.ConfirmBtnOnClickEvent
    CS.UIEventListener.Get(UIGangTrackPromptPanel.GetGoBtn_GameObject()).onClick = self.GoBtnOnClickEvent

end

function UIGangTrackPromptPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGetRevengePointMessage, UIGangTrackPromptPanel.ResGetRevengePointMessage)
end
--endregion

--region 刷新界面
function UIGangTrackPromptPanel:RefreshUI()
    ---@type TABLE.CFG_PROMPTWORD
    local promptWordTblExist, promptWordTbl = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(148)
    local contentText = [[追踪玩家可获得其地图坐标
追踪后坐标信息同时会进行邮件通知]]
    if promptWordTbl then
        contentText = string.gsub(promptWordTbl.des, '\\n', '\n')
    end
    self:GetContentLabel().text = contentText
    if (tonumber(LuaGlobalTableDeal.GetUnionEnemyCostTbl()[2]) ~= 0) then
        UIGangTrackPromptPanel.GetItemgold_UILabel().gameObject:SetActive(true)
        UIGangTrackPromptPanel.NeedItemCount = tonumber(LuaGlobalTableDeal.GetUnionEnemyCostTbl()[2])
        UIGangTrackPromptPanel.GetItemgold_UILabel().text = LuaGlobalTableDeal.GetUnionEnemyCostTbl()[2]
        local isfind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(tonumber(LuaGlobalTableDeal.GetUnionEnemyCostTbl()[1]))
        if (isfind) then
            UIGangTrackPromptPanel.NeedItemInfo = info
            UIGangTrackPromptPanel.GetItemgold_UISprite().spriteName = info.icon
        end
    else
        UIGangTrackPromptPanel.GetItemgold_UILabel().gameObject:SetActive(false)
    end
end

---@param trans GameObject 按钮
---@param str string    内容
---@param id  number    提示框id
function UIGangTrackPromptPanel:ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion

--region 客户端事件
function UIGangTrackPromptPanel.CloseBtnOnClickEvent(go)
    uimanager:ClosePanel("UIGangTrackPromptPanel")
end

function UIGangTrackPromptPanel.ConfirmBtnOnClickEvent(go)
    if (UIGangTrackPromptPanel.NeedItemInfo ~= nil
            and CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(UIGangTrackPromptPanel.NeedItemInfo.id) >= UIGangTrackPromptPanel.NeedItemCount) then
        networkRequest.ReqGetRevengePoint(UIGangTrackPromptPanel.roleID)
    else
        local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(78)
        if (isfind) then
            UIGangTrackPromptPanel:ShowTips(go, 78, string.format(data.content, UIGangTrackPromptPanel.NeedItemInfo.name))
        end
    end
end

function UIGangTrackPromptPanel.GoBtnOnClickEvent(go)
    --寻路
    local isfind
    ---@type TABLE.CFG_MAP
    local mapinfo
    isfind, mapinfo = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(UIGangTrackPromptPanel.FindMapID)
    if (isfind) then
        if mapinfo.conditionId then
            local res = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(mapinfo.conditionId)
            if (res) == false then
                UIGangTrackPromptPanel:ShowTips(go, 488)
                return
            end
        end
    else
        UIGangTrackPromptPanel:ShowTips(go, 488)
        return
    end
    UIGangTrackPromptPanel.FindPath(go)
end

---点击前往点击函数
function UIGangTrackPromptPanel.FindPath(go)
    if (UIGangTrackPromptPanel.FindMapID ~= 0) then
        local x = UIGangTrackPromptPanel.PosX
        local y = UIGangTrackPromptPanel.PosY
        local coord = CS.SFMiscBase.Dot2(x, y)
        local mapid = UIGangTrackPromptPanel.FindMapID
        local line = UIGangTrackPromptPanel.FindPathLine
        local operateRes = gameMgr:GetPlayerDataMgr():GetLuaAsyncOperationMgr():TryStartOperation(LuaAsyncOperationType.UnionRevenge, mapid, coord, line, go)
        if operateRes then
            uimanager:ClosePanel("UIGuildPanel")
            uimanager:ClosePanel("UIGangEnemyListPanel")
            uimanager:ClosePanel("UIGuildMemberListPanel")
            uimanager:ClosePanel("UIGangTrackPromptPanel")
        end
    end
end
--endregion

--region 服务器事件
function UIGangTrackPromptPanel.ResGetRevengePointMessage(id, data)
    UIGangTrackPromptPanel.GetTrack_GameObject():SetActive(false)
    UIGangTrackPromptPanel.GetPosition_GameObject():SetActive(true)
    UIGangTrackPromptPanel.GetPlayerName_UILabel().text = data.targetName
    local isfind, mapinfo = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(data.mapId)
    if (isfind) then
        UIGangTrackPromptPanel.GetPlayerMap_UILabel().text = mapinfo.name
        UIGangTrackPromptPanel.FindMapID = data.mapId
    end
    UIGangTrackPromptPanel.PosX = data.x
    UIGangTrackPromptPanel.PosY = data.y
    UIGangTrackPromptPanel.FindPathLine = data.line
    UIGangTrackPromptPanel.GetPlayerLocatin_UILabel().text = tostring(data.x) .. "," .. tostring(data.y)
end
--endregion

return UIGangTrackPromptPanel