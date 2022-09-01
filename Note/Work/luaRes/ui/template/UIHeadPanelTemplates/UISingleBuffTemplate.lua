---@class UIHeadPanel_SingleBuff 单个Buff
local UISingleBuffTemplate = {}

local UnityEngineVector3 = CS.UnityEngine.Vector3

--region 初始化
function UISingleBuffTemplate:Init()
    self:InitComponents(self.go)
end

function UISingleBuffTemplate:InitComponents(go)
    self.buff_UIPanel = CS.Utility_Lua.GetComponent(go, "UIPanel")
    self.buff_TweenAlpha = CS.Utility_Lua.GetComponent(go, "TweenAlpha")
    ---@type UISprite
    self.bufficon_UISprite = CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "UISprite")
    self.dikuangicon_UISprite = CS.Utility_Lua.GetComponent(go.transform:Find("dikuang"), "UISprite")

    if self.buff_TweenAlpha ~= nil and self.buff_TweenAlpha.enabled then
        self.buff_TweenAlpha.enabled = false
    end
    if self.bufficon_UISprite ~= nil then
        self.bufficon_UISprite.alpha = 1
    end
end

---@param buffInfoItem CustomBuffInfo
function UISingleBuffTemplate:Show(buffInfoItem)
    if buffInfoItem == nil then
        return
    end
    if (buffInfoItem.buffInfo.Info == nil and buffInfoItem.buffInfo.tbl_buff == nil) then
        return
    end
    self.bufferInfo = buffInfoItem.buffInfo.Info
    self.buff_tab = buffInfoItem.buffInfo.tbl_buff
    self:RefreshSingleBuff()
    local mUIRoot = CS.UIManager.Instance:GetUIRoot()
    if buffInfoItem.buffInfo.Info.bufferConfigId == 88000002 and mUIRoot and CS.StaticUtility.IsNull(self.bufficon_UISprite) == false then
        local pos = -1 * self.bufficon_UISprite.gameObject.transform:InverseTransformPoint(mUIRoot.transform.position)
        pos.y = pos.y - 10
        uiStaticParameter.mJuBaoPenBufferPos = pos
        ---@type UIBubbleBuffTipsPanel
        local panel = uimanager:GetPanel("UIBubbleBuffTipsPanel")
        if panel then
            panel:SetPos(uiStaticParameter.mJuBaoPenBufferPos)
        end
    end
end

---将屏幕坐标转化为UIRoot的相对坐标(z轴与UIBagPanel同值)
---@private
---@param screenPosition UnityEngine.Vector2
---@return UnityEngine.Vector3
function UISingleBuffTemplate:TransferScreenPosToWorldPosition(screenPosition)
    if self.mUIRoot == nil then
        self.mUIRoot = CS.UIManager.Instance:GetUIRoot()
    end
    if self.mUICamera == nil then
        self.mUICamera = CS.UICamera.currentCamera
    end
    local pos = self.mUICamera:ScreenToWorldPoint(UnityEngineVector3(screenPosition.x, screenPosition.y, 0))
    pos.z = self.go.transform.position.z
    return pos
end
--endregion

--region 刷新
---刷新单个buff
function UISingleBuffTemplate:RefreshSingleBuff()
    if self.bufficon_UISprite ~= nil and self.dikuangicon_UISprite ~= nil and self.buff_tab ~= nil then
        self:OnDestroy()
        self:RefreshIcon()
        self:RefreshBuffState()
        --self:RefreshTimeToClose(function() self:OnDestroy()end)
    end
end

---刷新Icon
function UISingleBuffTemplate:RefreshIcon()
    if self.buff_tab.icon ~= nil then
        --CS.UnityEngine.Debug.LogError("设置icon")
        if self.buff_tab.type == LuaEnumBuffType.AnimalBossHurtBuff then
            local buffValue = LuaGlobalTableDeal:GetMeetAnimalBossServantBuffShowInfo()
            self.bufficon_UISprite.spriteName = self.buff_tab.icon .. '_' .. buffValue
        else
            self.bufficon_UISprite.spriteName = self.buff_tab.icon
        end
    end
end

---刷新buff状态
function UISingleBuffTemplate:RefreshBuffState()
    if self.buff_tab.isGood ~= nil then
        --CS.UnityEngine.Debug.LogError("设置增益buff")
        if Utility.IntToBool(self.buff_tab.isGood) then
            self.dikuangicon_UISprite.spriteName = "circle"
        else
            self.dikuangicon_UISprite.spriteName = "circlebg"
        end

    end
end

---开始闪烁
function UISingleBuffTemplate:StartFlash()
    --CS.UnityEngine.Debug.LogError("开始闪烁")
    if self.buff_TweenAlpha ~= nil and CS.StaticUtility.IsNull(self.buff_TweenAlpha) == false then
        self.buff_TweenAlpha.enabled = true
    end
end

---Buff点击事件
function UISingleBuffTemplate:BuffOnClick()
    return CS.UIEventListener.Get(self.buff_TweenAlpha.gameObject)
end
--endregion

--region 功能
--endregion
function UISingleBuffTemplate:OnDestroy()
end
return UISingleBuffTemplate