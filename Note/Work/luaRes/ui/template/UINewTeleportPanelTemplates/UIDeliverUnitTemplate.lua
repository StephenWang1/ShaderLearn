---@class UIDeliverUnitTemplate 传送员按钮模板
local UIDeliverUnitTemplate = {}

--region 初始化

function UIDeliverUnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIDeliverUnitTemplate:InitParameters()
    ---@type DeliverMapUnit
    self.deliverData = nil
    self.clickCallBack = nil
end

function UIDeliverUnitTemplate:InitComponents()
    ---@type UnityEngine.GameObject tip
    self.tip = self:Get("tip", 'GameObject')
    ---@type Top_UISprite 背景
    self.bg = self:Get("background", 'Top_UISprite')
    ---@type UnityEngine.GameObject 特效
    self.effect = self:Get("background/effect", 'GameObject')
    ---@type Top_UILabel 地图名称
    self.showLabel = self:Get("TitleName", 'Top_UILabel')
end

function UIDeliverUnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnSelfGoClick
end

--endregion

--region Show
---@param data.deliverUnitInfo CS.DeliverMapUnit 传送单元信息
---@param data.clickCallBack function 点击回调
---@param data.isDelive boolean 是否可以传送
---@param data.isShowEffect boolean 是否显示特效
function UIDeliverUnitTemplate:SetTemplate(data)
    if data then
        self.clickCallBack = data.clickCallBack
        self.deliverData = data.deliverUnitInfo
        self:RefreshEffectState(data.isShowEffect)
        self:RefreshUI()
    end
end

function UIDeliverUnitTemplate:RefreshUI()
    self.tip:SetActive(false)
    self.bg.spriteName = self.deliverData.isDelive and 'c3' or 'c5'

    local fontColor = self.deliverData.isDelive and luaEnumColorType.Blue or luaEnumColorType.Gray

    local mSuffixName = ""
    if self.deliverData.level ~= 0 then
        local level = "级"
        if self.deliverData.isReinCheck then
            level = "转"
        end
        if self.deliverData.type == LuaEnumTeleportType.MainCityMap then

            if fontColor ~= luaEnumColorType.Gray then
                if (self.deliverData.level ~= 0) then
                    mSuffixName = ' [6B99A2]' .. self.deliverData.level .. level .. '[-]'
                end
            else
                if (self.deliverData.level ~= 0) then
                    mSuffixName = ' ' .. self.deliverData.level .. level
                end
            end
        elseif self.deliverData.type == LuaEnumTeleportType.levelMap then
            if fontColor ~= luaEnumColorType.Gray then
                mSuffixName = ' [6B99A2]' .. self.deliverData.level .. level .. '[-]'
            else
                mSuffixName = ' ' .. self.deliverData.level .. level .. '[-]'
            end
        elseif self.deliverData.type == LuaEnumTeleportType.ReinMap then
            if fontColor ~= luaEnumColorType.Gray then
                mSuffixName = ' [6B99A2]' .. self.deliverData.level .. level .. '[-]'
            else
                mSuffixName = ' ' .. self.deliverData.level.. level .. '[-]'
            end
        elseif self.deliverData.type == LuaEnumTeleportType.SpecialMap then
            mSuffixName = ""
        elseif self.deliverData.type == LuaEnumTeleportType.ClothesMap then
            mSuffixName = ""
        end
    end
    local prefixName = ""
    local isKuaFuOpen = gameMgr:GetPlayerDataMgr():GetShareMapInfo():IsOpenShareMap()
    if self.deliverData and self.deliverData.deliverId and isKuaFuOpen then
        local data = clientTableManager.cfg_deliverManager:TryGetValue(self.deliverData.deliverId)
        if data then
            local shareMapMark = data:GetLianfuMark()
            if shareMapMark and shareMapMark ~= 0 and gameMgr:GetPlayerDataMgr() then
                local curkuaFuNum = gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetOpenKuaFuNum()
                if shareMapMark <= curkuaFuNum then
                    prefixName = self.deliverData.isDelive and "[00ff00]联服 [-]" or luaEnumColorType.Gray .. "联服 [-]"
                end
            end
        end
    end
    self.showLabel.text = prefixName .. fontColor .. self.deliverData.mapName .. mSuffixName
end

function UIDeliverUnitTemplate:RefreshEffectState(isShow)
    self.effect:SetActive(isShow)
end

--endregion


--region UI函数监听

function UIDeliverUnitTemplate:OnSelfGoClick(go)
    if self.clickCallBack ~= nil then
        self.clickCallBack(go)
    end
end

--endregion


--region otherFunction

--endregion

--region ondestroy

function UIDeliverUnitTemplate:onDestroy()

end

--endregion

return UIDeliverUnitTemplate