---传送按钮模板

local UITeleportBtnTemplate = {}

function UITeleportBtnTemplate:Init()
    self:InitComponents()
    self:InitOther()
end

---通过工具生成 控件变量
function UITeleportBtnTemplate:InitComponents()
    self.mTitleName_UILabel = self:Get("TitleName", "UILabel")
    self.tip_GameObject = self:Get("tip", "GameObject")
end

---初始化 变量 按钮点击 服务器消息事件等
function UITeleportBtnTemplate:InitOther()
    --条件是否匹配
    self.mMatchCondition = false
    --传送点id
    self.mDeliverId = -1
    --是否消耗传送石
    self.mIsStone = false

    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClickDetail
end
---显示
function UITeleportBtnTemplate:Show(deliverId, isStone, name, matchCondition,IsTask)
    self.mDeliverId = deliverId
    self.mTitleName_UILabel.text = name
    self.mMatchCondition = matchCondition
    self.mIsStone = isStone
    self.tip_GameObject:SetActive(IsTask)
end
---点击回调
function UITeleportBtnTemplate:OnClickDetail(go)
    if self.mMatchCondition == false then
        CS.Utility.ShowTips("前路危险，请变强后再来！")
        return
    end
    if self.mDeliverId ~= -1 then
        --uimanager:ClosePanel("UITeleportPanel")
        networkRequest.ReqDeliverByConfig(self.mDeliverId, self.mIsStone)
    end
end
return UITeleportBtnTemplate