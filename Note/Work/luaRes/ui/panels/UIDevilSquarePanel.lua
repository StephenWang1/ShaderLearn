---@class UIDevilSquarePanel : UIBase 通用副本面板
local UIDevilSquarePanel = {}
local ItemsIDThatAddTime = 6200001

--region 初始化

function UIDevilSquarePanel:Init()
    self:InitComponents()
    UIDevilSquarePanel.InitParameters()
    UIDevilSquarePanel.BindUIEvents()
    UIDevilSquarePanel.BindNetMessage()

end

function UIDevilSquarePanel:Show(duplicateType, descriptionId)
    if self:ConditionClosePanel(duplicateType) then
        return
    end
    UIDevilSquarePanel.curDuplicateType = duplicateType == nil and 0 or duplicateType
    UIDevilSquarePanel.curDescriptionID = descriptionId == nil and 0 or descriptionId
    UIDevilSquarePanel.RefreshView()
    ---请求副本剩余时间
    networkRequest.ReqDevilSquareHasTime(UIDevilSquarePanel.curDuplicateType)
end

function UIDevilSquarePanel:ConditionClosePanel(duplicateType)
    local dic = LuaGlobalTableDeal:ConditionDevilSquarePanelDic()
    if dic == nil or dic[duplicateType] == nil then
        return false
    end
    local list = dic[duplicateType]
    for i = 1, #list do
        if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(list[i]) then
            uimanager:ClosePanel("UIDevilSquarePanel")
            return true
        end
    end
    return false
end

--- 初始化变量
function UIDevilSquarePanel.InitParameters()
    UIDevilSquarePanel.curDuplicateType = 0
    UIDevilSquarePanel.curDescriptionID = 0
    ---@type table<UnityEngine.GameObject,UIDevilSquarePanel_UnitTemplate>
    UIDevilSquarePanel.allGoAndTemplateDic = {}
end

--- 初始化组件
function UIDevilSquarePanel:InitComponents()
    ---@type Top_UILabel  副本标题
    self.title = self:GetCurComp("WidgetRoot/window/title", "Top_UILabel")
    ---@type Top_UILabel  简述
    self.details = self:GetCurComp("WidgetRoot/introduce/labelGroup/details", "Top_UILabel")
    ---@type Top_UILabel  传送标题
    self.deliverTitle = self:GetCurComp("WidgetRoot/introduce/labelGroup/title", "Top_UILabel")
    ---@type Top_UIGridContainer  副本列表
    self.duplicateGrid = self:GetCurComp("WidgetRoot/Scroll View/SafeArea", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject  关闭按钮
    self.closeBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    ---@type Top_UILabel  副本倒计时文本
    self.countDownTimeLabel = self:GetCurComp("WidgetRoot/eventcost", "Top_UILabel")
    ---@type UnityEngine.GameObject  增加副本倒计时按钮
    self.countDownTimeAddGo = self:GetCurComp("WidgetRoot/eventcost/btn_add", "GameObject")
    ---@type UnityEngine.GameObject  锚点
    self.AnchorPoint = self:GetCurComp("WidgetRoot/eventcost/AnchorPoint", "GameObject")
    ---@type Top_UILabel 增加副本倒计时提示文字
    self.countDownTimeAddTips = self:GetCurComp("WidgetRoot/introduce/labelGroup/enterConditon", "Top_UILabel")
end

function UIDevilSquarePanel.BindUIEvents()
    ---点击关闭按钮
    CS.UIEventListener.Get(UIDevilSquarePanel.closeBtn).onClick = UIDevilSquarePanel.OnClickCloseBtn
    ---点击增加副本倒计时
    CS.UIEventListener.Get(UIDevilSquarePanel.countDownTimeAddGo).onClick = UIDevilSquarePanel.OnClickAddCountDownTime
end

function UIDevilSquarePanel.BindNetMessage()
    --xx:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.xx, MessageCallback)
    UIDevilSquarePanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.UpdateDevilRemaining, UIDevilSquarePanel.ResDevilSquareHasTimeMessage)
end
--endregion

--region 函数监听

function UIDevilSquarePanel.OnClickCloseBtn()
    uimanager:ClosePanel("UIDevilSquarePanel")
end

function UIDevilSquarePanel.OnClickAddCountDownTime()
    local count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(ItemsIDThatAddTime)
    if count == 0 then
        Utility.ShowItemGetWay(ItemsIDThatAddTime, UIDevilSquarePanel.AnchorPoint, LuaEnumWayGetPanelArrowDirType.Down, CS.UnityEngine.Vector2(-132, 0));
    else
        UIDevilSquarePanel.ShowDisposeOrePanel(count)
    end
end

---显示使用道具面板
function UIDevilSquarePanel.ShowDisposeOrePanel(count)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil then
        return
    end
    local maxCount = count
    local info = {}
    info.itemid = ItemsIDThatAddTime
    info.price = 0
    info.minValue = 1
    info.maxValue = maxCount == 0 and 1 or maxCount
    info.curValue = maxCount == 0 and 1 or maxCount
    info.isDesprice = true
    info.IsShowItemTips = true
    info.rightBtnLabel = '使用'
    info.rightBtnCallBack = function(panel)
        if panel then
            local itemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(ItemsIDThatAddTime)
            networkRequest.ReqUseItem(panel.num, itemInfo.lid, UIDevilSquarePanel.curDuplicateType)
            local Numnber = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(ItemsIDThatAddTime)
            if Numnber <= panel.num then
                uimanager:ClosePanel('UIDisposeOrePanel')
            end
        end
    end
    uimanager:CreatePanel("UIDisposeOrePanel", nil, info)
end
--endregion


--region 网络消息处理

---服务器活动消息回调
---@private
---@param tblData duplicateV2.ResDevilSquareHasTime
function UIDevilSquarePanel.ResDevilSquareHasTimeMessage(id, tblData)
    local DevilRemaining = Utility.GetCopylastTimestamp(UIDevilSquarePanel.curDuplicateType)
    if (UIDevilSquarePanel.countDownTimeLabel) then
        local timer = DevilRemaining == nil or DevilRemaining <= 0 and '[FF0000]无可用时间' or CS.CSServerTime.Instance:FormatLongToTimeStr(DevilRemaining)
        UIDevilSquarePanel.countDownTimeLabel.text = timer
    end
end
--endregion

--region View

function UIDevilSquarePanel.RefreshView()
    UIDevilSquarePanel.RefreshMainView()
    UIDevilSquarePanel.RefreshGridView()
end

function UIDevilSquarePanel.RefreshMainView()
    local descriptionTbl = clientTableManager.cfg_descriptionManager:TryGetValue(UIDevilSquarePanel.curDescriptionID)
    if descriptionTbl == nil or descriptionTbl:GetValue() == nil then
        return
    end
    local infos = string.Split(descriptionTbl:GetValue(), '&')
    if #infos > 0 then
        UIDevilSquarePanel.title.text = infos[1]
    end
    if #infos > 1 then
        UIDevilSquarePanel.details.text = string.gsub(infos[2], '\\n', '\n')
    end
    if #infos > 2 then
        UIDevilSquarePanel.deliverTitle.text = infos[3]
    end
    if #infos > 3 then
        UIDevilSquarePanel.countDownTimeAddTips.text = infos[4]
    end
    if (UIDevilSquarePanel.countDownTimeLabel) then
        UIDevilSquarePanel.countDownTimeLabel.gameObject:SetActive(LuaGlobalTableDeal.IsCountdownCopy(UIDevilSquarePanel.curDuplicateType))
    end
end

function UIDevilSquarePanel.RefreshGridView()
    local showDuplicate = CS.Cfg_DuplicateTableManager.Instance:GetDuplicateInfoListByDuplicateType(UIDevilSquarePanel.curDuplicateType)
    if showDuplicate == nil then
        return
    end
    UIDevilSquarePanel.duplicateGrid.MaxCount = showDuplicate.Count
    for i = 0, showDuplicate.Count - 1 do
        local go = UIDevilSquarePanel.duplicateGrid.controlList[i]
        if go then
            if UIDevilSquarePanel.allGoAndTemplateDic[go] == nil then
                UIDevilSquarePanel.allGoAndTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIDevilSquarePanel_UnitTemplate)
            end
            ---@type UIDevilSquarePanel_UnitTemplate
            local temp = UIDevilSquarePanel.allGoAndTemplateDic[go]
            temp:SetTemplate({ tblInfo = showDuplicate[i] })
        end
    end
end

--endregion

--region otherFunction

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIDevilSquarePanel