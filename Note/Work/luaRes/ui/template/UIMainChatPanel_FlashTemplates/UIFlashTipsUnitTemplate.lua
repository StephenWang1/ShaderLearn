---@class UIFlashTipsUnitTemplate 闪烁提示对象
local UIFlashTipsUnitTemplate = {}

--region 初始化

function UIFlashTipsUnitTemplate:Init(tem)
    self.ViewTem = tem
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
    self:BindNetMessage()
end
--初始化变量
function UIFlashTipsUnitTemplate:InitParameters()
    self.flashId = 0
    self.configId = 0
    self.callBack = nil
end

function UIFlashTipsUnitTemplate:InitComponents()
    self.icon = self:Get("Sprite", "Top_UISprite")
    self.bg = self:Get("Sprite/promptbg", "Top_UISprite")
    self.effect = self:Get("Sprite/effectRoot", "GameObject")
end

function UIFlashTipsUnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnGoBtnClick
end

function UIFlashTipsUnitTemplate:BindNetMessage()

end

--endregion

--region Show
---@param data tabel
---{
---@field data.falshInfo tabel
---@field data.isShowEffect boolean
---}

function UIFlashTipsUnitTemplate:SetTemplate(data)
    if data then
        self.callBack = data.clickCallBack
        self.flashId = data.falshInfo.id
        self.mTime = data.falshInfo.mTime
        self.configId = data.falshInfo.configId
        self.icon.spriteName = data.falshInfo.icon
        self.effect:SetActive(data.isShowEffect ~= nil and data.isShowEffect)
        self.icon.gameObject:SetActive(true)
    end
    if (self.mTime ~= nil) then
        self:SetEndTimeCallBack(self.mTime)
    else
        if (self.IEnumTimeEndCallBack ~= nil) then
            StopCoroutine(self.IEnumTimeEndCallBack)
            self.IEnumTimeEndCallBack = nil
        end
    end
end


--endregion

--region UI函数监听

function UIFlashTipsUnitTemplate:OnGoBtnClick(go)
    if self.callBack ~= nil then
        self.callBack()
    end
end

--endregion


--region otherFunction

function UIFlashTipsUnitTemplate:SetEffectState(state)
    self.effect:SetActive(state)
end

function UIFlashTipsUnitTemplate:SetEndTimeCallBack(time)
    if (time ~= nil) then
        if (self.IEnumTimeEndCallBack == nil) then
            self.IEnumTimeEndCallBack = StartCoroutine(self.IEndTimeCallBack, self, time)
        else
            StopCoroutine(self.IEnumTimeEndCallBack)
            self.IEnumTimeEndCallBack = nil
            self.IEnumTimeEndCallBack = StartCoroutine(self.IEndTimeCallBack, self, time)
        end
    else
        return
    end
end

function UIFlashTipsUnitTemplate:IEndTimeCallBack(time)
    local meetTime = true
    local totalTime = (time - CS.CSServerTime.Instance.TotalMillisecond) / 1000
    --time * 0.001
    while meetTime do
        if totalTime <= 0 then
            meetTime = false
            --发送终止
            if (self.flashId ~= nil) then
                self.ViewTem:RemoveFlashPrompt(1, self.flashId)
            end
            StopCoroutine(self.IEnumTimeEndCallBack)
            self.IEnumTimeEndCallBack = nil
        end
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
        totalTime = totalTime - 1
    end
end
--endregion

--region ondestroy

function UIFlashTipsUnitTemplate:OnDestroy()
    if (self.IEnumTimeEndCallBack ~= nil) then
        StopCoroutine(self.IEnumTimeEndCallBack)
        self.IEnumTimeEndCallBack = nil
    end
end

--endregion

return UIFlashTipsUnitTemplate