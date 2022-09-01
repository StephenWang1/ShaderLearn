---@class UIArrestPromptUnitTemplate 搜索单元
local UIArrestPromptUnitTemplate = {}

--region 初始化

function UIArrestPromptUnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
    self:BindNetMessage()
end
--初始化变量
function UIArrestPromptUnitTemplate:InitParameters()
    self.id = 0
    self.palyerInfo = nil
    self.callBack = nil
end

function UIArrestPromptUnitTemplate:InitComponents()
    ---@type Top_UISprite icon
    self.icon = self:Get("icon", "Top_UISprite")
    ---@type Top_UILabel  name
    self.name = self:Get("name", "Top_UILabel")
    ---@type Top_UISprite level
    self.level = self:Get("level", "Top_UILabel")
    ---@type Top_UISprite level
    self.heightlight = self:Get("beSelected", "GameObject")
end

function UIArrestPromptUnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnGetGoClick
end

function UIArrestPromptUnitTemplate:BindNetMessage()

end

--endregion

--region Show
---@param data customData
---@alias customData{playerInfo:friendV2.OfferSearchPlayer,callback:function}
function UIArrestPromptUnitTemplate:SetTemplate(data)
    if data then

        self.id = data.playerInfo.rid
        self.callBack = data.callBack
        self.palyerInfo = data.playerInfo
        self.name.text = data.playerInfo.name
        self.level.text = data.playerInfo.level
        self.icon.spriteName = 'headicon' .. data.playerInfo.sex .. data.playerInfo.career
    end
end

function UIArrestPromptUnitTemplate:SetHeightlightState(state)
    self.heightlight:SetActive(state)
end

--endregion


--region UI函数监听

function UIArrestPromptUnitTemplate:OnGetGoClick(go)
    if self.callBack ~= nil then
        self.callBack()
    end
end

--endregion


--region otherFunction



--endregion

--region ondestroy

function UIArrestPromptUnitTemplate:onDestroy()

end

--endregion

return UIArrestPromptUnitTemplate