---@class UIDevilSquarePanel_UnitTemplate :TemplateBase 副本传送单元模板
local UIDevilSquarePanel_UnitTemplate = {}

--region 初始化

function UIDevilSquarePanel_UnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIDevilSquarePanel_UnitTemplate:InitParameters()
    ---@type TABLE.CFG_DUPLICATE
    self.duplicateTbl = nil
    self.conditionResult = false
end

function UIDevilSquarePanel_UnitTemplate:InitComponents()
    ---@type Top_UILabel 名称
    self.name = self:Get("check/TitleName", "Top_UILabel")
    ---@type Top_UISprite 背景
    self.bg = self:Get("check", "Top_UISprite")
    ---@type Top_UILabel 限制
    self.conditionStr = self:Get("condition", "Top_UILabel")
end

function UIDevilSquarePanel_UnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClickGOCallBack
end

--endregion

--region Show

---@param data
---@field data.tblInfo TABLE.CFG_DUPLICATE
function UIDevilSquarePanel_UnitTemplate:SetTemplate(data)
    if data == nil or data.tblInfo == nil then
        return
    end
    self.duplicateTbl = data.tblInfo
    self.conditionResult = Utility.IsMainPlayerMatchCondition(data.tblInfo.condition)
    self:RefreshView()
end

--endregion


--region UI函数监听

function UIDevilSquarePanel_UnitTemplate:OnClickGOCallBack(go)
    local IsCountdownCopy = LuaGlobalTableDeal.IsCountdownCopy(self.duplicateTbl.type)
    if (IsCountdownCopy and Utility.GetCopylastTimestamp(self.duplicateTbl.type) <= 0) then
        CS.Utility.ShowRedTips('剩余时间不足')
        --self.parentPanel.OnClickAddCountDownTime(self.parentPanel.countDownTimeAddGo);
    elseif self.isMeetConditon then
        networkRequest.ReqEnterDuplicate(self.duplicateTbl.id)
        uimanager:ClosePanel("UIDevilSquarePanel")
    else
        Utility.ShowPopoTips(go, nil, 483, "UIDevilSquarePanel")
    end
end

--endregion

--region View

function UIDevilSquarePanel_UnitTemplate:RefreshView()
    self.isMeetConditon = (self.conditionResult ~= nil and self.conditionResult.success)
    self.name.text = self.isMeetConditon and "[c3f4ff]" .. self.duplicateTbl.name or luaEnumColorType.Gray .. self.duplicateTbl.name
    self.bg.spriteName = self.isMeetConditon and "c3" or "c3"
    local color = self.isMeetConditon and luaEnumColorType.Green3 or luaEnumColorType.Red
    if not self.isMeetConditon then
        self.conditionStr.text = (self.conditionResult == nil or self.conditionResult.txt == nil) and "" or color .. self.conditionResult.txt
    end
end

--endregion


--region otherFunction

--endregion

--region ondestroy

function UIDevilSquarePanel_UnitTemplate:onDestroy()

end

--endregion

return UIDevilSquarePanel_UnitTemplate