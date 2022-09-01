---@class UILsMissionPanel_PageUnitTemplate:TemplateBase 页签单元模板
local UILsMissionPanel_PageUnitTemplate = {}

--region 初始化

function UILsMissionPanel_PageUnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
    self:BindNetMessage()
end
--初始化变量
function UILsMissionPanel_PageUnitTemplate:InitParameters()

end

function UILsMissionPanel_PageUnitTemplate:InitComponents()
    ---@type Top_UISprite bg
    self.shadow = self:Get('shadow', 'Top_UISprite')
    ---@type Top_UISprite 高亮图标
    self.chooseIcon = self:Get('ChooseIcon/icon', 'Top_UISprite')
    ---@type Top_UIRedPoint 红点
    self.redpoint = self:Get('redpoint', 'Top_UIRedPoint')
    ---@type UnityEngine.GameObject 高亮
    self.choose = self:Get('ChooseIcon', 'GameObject')
    ---@type Top_UIRedPoint 红点
    self.redpoint = self:Get('redpoint', 'Top_UIRedPoint')
end

function UILsMissionPanel_PageUnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClickGoCallBack
end

function UILsMissionPanel_PageUnitTemplate:BindNetMessage()

end

--endregion

--region Show
---@param customData table
---{
---@field customData.sec      number
---@field customData.callBack function
---}
function UILsMissionPanel_PageUnitTemplate:SetTemplate(customData)
    if customData then
        self.sec = customData.sec
        self.callBack = customData.callBack
        self:InitView()
        self:BindRedPoint()
    end

end

function UILsMissionPanel_PageUnitTemplate:InitView()
    --local careerIndex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    local sexIndex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
    self.chooseIcon.spriteName = 'weaponBookPage_' .. tostring(self.sec) .. '_' .. tostring(sexIndex)
    self.shadow.spriteName = 'weaponBookShadow_' .. tostring(self.sec) .. '_' .. tostring(sexIndex)
end

function UILsMissionPanel_PageUnitTemplate:BindRedPoint()
    if self.redpoint then
        self.redpoint:RemoveRedPointKey()
    end
    local key = gameMgr:GetPlayerDataMgr():GetLsMissionData():GetRedPointKey(1, self.sec);
    self.redpoint:AddRedPointKey(key)
end

--endregion


--region UI函数监听
function UILsMissionPanel_PageUnitTemplate:OnClickGoCallBack(go)
    if self.callBack ~= nil then
        self.callBack(go, self.sec)
    end
end

--endregion


--region otherFunction

function UILsMissionPanel_PageUnitTemplate:ChangeChooseState(sec)
    local isShow = self.sec == sec
    if self.choose and self.choose.activeSelf ~= isShow then
        self.choose:SetActive(isShow)
    end
end

--endregion

--region ondestroy

function UILsMissionPanel_PageUnitTemplate:onDestroy()

end

--endregion

return UILsMissionPanel_PageUnitTemplate