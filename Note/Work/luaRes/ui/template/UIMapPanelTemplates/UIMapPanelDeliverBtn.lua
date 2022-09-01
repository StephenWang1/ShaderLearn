---@class UIMapPanelDeliver 小地图界面传送按钮
local UIMapPanelDeliverBtn = {}

function UIMapPanelDeliverBtn:Init()
    self.mLabel = self:Get("Label", "UILabel")
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnDeliverBtnClicked
end

---@param npcTbl TABLE.CFG_MAP_NPC
function UIMapPanelDeliverBtn:Refresh(npcTbl)
    self.npcTbl = npcTbl
    if self.npcTbl then
        local res, deliver
        res, deliver = CS.Cfg_DeliverTableManager.Instance:TryGetValue(self.npcTbl.deliverId)
        if res then
            self.mLabel.text = deliver.showName
        else
            self.mLabel.text = self.npcTbl.remarks
        end
    end
end

---绑定点击事件
---@param btnClickEvent function func(UIMapPanelDeliver)
function UIMapPanelDeliverBtn:BindClickEvent(btnClickEvent)
    self.mBtnClickEvent = btnClickEvent
end

function UIMapPanelDeliverBtn:OnDeliverBtnClicked()
    if self.mBtnClickEvent then
        self:mBtnClickEvent()
    end
    --[[    if self.npcTbl then
            if networkRequest.ReqDeliverByConfig(self.npcTbl.deliverId, false) then
                clientMessageDeal.OpenNpcFunc(self.npcTbl.npcid, nil)
                uimanager:ClosePanel("UIMapPanel")
            end
        end]]
end

return UIMapPanelDeliverBtn