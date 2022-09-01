---@class UIDefKingRankSecondUnit 排行榜单元类型二（成员）
local UIDefKingRankSecondUnit = {}

--region 初始化

function UIDefKingRankSecondUnit:Init()
    self:InitComponents()
    self:BindUIMessage()
    self:BindNetMessage()
end
--初始化变量
function UIDefKingRankSecondUnit:InitParameters()
    self.callBack = nil
end

function UIDefKingRankSecondUnit:InitComponents()
    ---@type Top_UISprite
    self.firstSprite = self:Get("firstSprite", "Top_UISprite")
    ---@type Top_UILabel
    self.firstValue = self:Get("firstValue", "Top_UILabel")
    ---@type Top_UILabel
    self.secondValue = self:Get("secondValue", "Top_UILabel")
    ---@type Top_UILabel
    self.thirdValue = self:Get("thirdValue", "Top_UILabel")
    ---@type Top_UILabel
    self.fouthValue = self:Get("fouthValue", "Top_UILabel")
    ---@type Top_UILabel
    self.fifthValue = self:Get("fifthValue", "Top_UILabel")
    ---@type Top_UILabel
    self.sixthValue = self:Get("sixthValue", "Top_UILabel")
end

function UIDefKingRankSecondUnit:BindUIMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnGoBtnClick
end

function UIDefKingRankSecondUnit:BindNetMessage()

end

--endregion

--region Show
---@param customData table
---{
---@field customData.firstSpriteName string
---@field customData.firstValue      number
---@field customData.secondValue     number
---@field customData.thirdValue      number
---@field customData.fouthValue      number
---@field customData.fifthValue      number
---@field customData.sixthValue      number
---@field customData.callBack        function
---}
function UIDefKingRankSecondUnit:SetTemplate(customData)
    if customData then
        self.callBack = customData.callBack
        self.firstSprite.spriteName = customData.firstSpriteName
        self.firstValue.text = tostring(customData.firstValue)
        self.secondValue.text = tostring(customData.secondValue)
        self.thirdValue.text = tostring(customData.thirdValue)
        self.fouthValue.text = tostring(customData.fouthValue)
        self.fifthValue.text = tostring(customData.fifthValue)
        self.sixthValue.text = tostring(customData.sixthValue)
    end
end

--endregion

--region UI函数监听

function UIDefKingRankSecondUnit:OnGoBtnClick(go)
    if self.callBack ~= nil then
        self.callBack()
    end
end

--endregion

--region otherFunction



--endregion

return UIDefKingRankSecondUnit