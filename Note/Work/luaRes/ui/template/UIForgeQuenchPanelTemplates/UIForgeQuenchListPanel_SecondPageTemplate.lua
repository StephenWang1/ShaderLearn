---@class UIForgeQuenchListPanel_SecondPageTemplate:TemplateBase
local UIForgeQuenchListPanel_SecondPageTemplate = {}

---@return LuaForgeQuenchDataManager
function UIForgeQuenchListPanel_SecondPageTemplate:GetForgeQuenchMgr()
    if self.mForgeQuenchMgr == nil then
        self.mForgeQuenchMgr = gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr()
    end
    return self.mForgeQuenchMgr
end

--region 初始化

function UIForgeQuenchListPanel_SecondPageTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIForgeQuenchListPanel_SecondPageTemplate:InitParameters()
    self.cuiLianId = 0
    ---@type LuaForgeQuenchItemData
    self.forgeQuenchData = nil
end

function UIForgeQuenchListPanel_SecondPageTemplate:InitComponents()
    ---@type UnityEngine.GameObject
    self.chekMarkGo = self:Get("checkMarkBg", "GameObject")
    ---@type Top_UILabel
    self.chekMarkLabel = self:Get("checkMarkBg/Label", "Top_UILabel")
    ---@type Top_UILabel
    self.label = self:Get("Label", "Top_UILabel")
    ---@type UIRedPoint
    self.redPoint = self:Get("redPoint", "UIRedPoint")
end

function UIForgeQuenchListPanel_SecondPageTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnGoClickCallBack
end

function UIForgeQuenchListPanel_SecondPageTemplate:BindRedPoint()

    if self.redPoint == nil or CS.StaticUtility.IsNull(self.redPoint.gameObject) then
        return
    end
    if self.forgeQuenchData == nil or self.forgeQuenchData:GetForgeQuenchTbl() == nil then
        return
    end

    self.redPoint:RemoveRedPointKey()

    if self.forgeQuenchData:IsNeedShowRedPoint() then
        local key = self:GetForgeQuenchMgr():GetRedPointKey(self.cuiLianId, 3)
        self.redPoint:AddRedPointKey(key)
    end
end

--endregion

--region Show

---@param data table
---@field data.cuiLianId number
---@field data.clickCallBack function
function UIForgeQuenchListPanel_SecondPageTemplate:SetTemplate(data)
    self.cuiLianId = data.cuiLianId
    self.clickGoCallBack = data.clickCallBack
    self.forgeQuenchData = self:GetForgeQuenchMgr():GetAllForgeQuenchItemByIdDic()[self.cuiLianId]
    self:BindRedPoint()
    self:InitView()
end

function UIForgeQuenchListPanel_SecondPageTemplate:InitView()
    if self.forgeQuenchData == nil or self.forgeQuenchData:GetForgeQuenchTbl() == nil then
        return
    end
    local str = self.forgeQuenchData:GetForgeQuenchTbl():GetReplaceName()
    self.chekMarkLabel.text = str
    self.label.text = str
end

--endregion


--region UI函数监听

function UIForgeQuenchListPanel_SecondPageTemplate:OnGoClickCallBack()
    if self.clickGoCallBack ~= nil then
        self.clickGoCallBack(self.cuiLianId)
    end
end

--endregion


--region otherFunction

function UIForgeQuenchListPanel_SecondPageTemplate:ChangeState(id)
    local isOpen = id == self.cuiLianId
    if isOpen == self.isOpen then
        return
    end
    self.isOpen = isOpen
    if self.isOpen ~= self.chekMarkGo.activeSelf then
        self.chekMarkGo:SetActive(self.isOpen)
        self.label.gameObject:SetActive(not self.isOpen)
    end
    if self.isOpen then
        luaEventManager.DoCallback(LuaCEvent.ForgeQuenchItemCheck, {
            type = LuaEnumForgeQuenchItemCheckReason.ForgeQuenchList,
            id = self.cuiLianId,
            itemId = self.forgeQuenchData:GetMainMaterialItemId()
        })
    end
end


--endregion

--region ondestroy

function UIForgeQuenchListPanel_SecondPageTemplate:onDestroy()

end

--endregion

return UIForgeQuenchListPanel_SecondPageTemplate