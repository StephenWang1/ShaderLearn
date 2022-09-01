---@class UISnapItemUnitTemplate:UIBaseTemplate 临时物品使用快捷栏
local UISnapItemUnitTemplate = {}

--region 初始化

function UISnapItemUnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UISnapItemUnitTemplate:InitParameters()
    self.lid = 0
    self.itemId = 0
    self.IenumRefreshTime = nil
end

function UISnapItemUnitTemplate:InitComponents()
    self.icon = self:Get("rootNode/UIItem/icon", "UISprite")
    self.bg = self:Get("rootNode/UIItem/bg", "GameObject")
    self.cdMask = self:Get("rootNode/cdMask", "Top_UISprite")
    self.effectLoad = self:Get("rootNode/cdMask", "CSUIEffectLoad")
end

function UISnapItemUnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.bg).LuaEventTable = self
    CS.UIEventListener.Get(self.bg).OnClickLuaDelegate = self.OnClickBtnClick
end

--endregion

--region Show

---@param temp {ItemInfo:tabel,ItemInfo.lid:number,ItemInfo.itemId:number,timeEndCallBack:function,clickCallBack:function,ItemInfo.icon:string,ItemInfo.time:number}
function UISnapItemUnitTemplate:SetTemplate(data)
    if data and data.ItemInfo then
        self.lid = data.ItemInfo.lid
        self.itemId = data.ItemInfo.itemId
        self.clickCallBack = data.clickCallBack
        self.timeEndCallBack = data.timeEndCallBack
        self.icon.spriteName = data.ItemInfo.icon
        if data.ItemInfo.time then
            if self.IenumRefreshTime == nil then
                self.IenumRefreshTime = StartCoroutine(self.IEnumRefreshSnapRemainTime, self, data.ItemInfo.time)
            else
                if self.IenumRefreshTime ~= nil then
                    StopCoroutine(self.IenumRefreshTime)
                end
                self.IenumRefreshTime = StartCoroutine(self.IEnumRefreshSnapRemainTime, self, data.ItemInfo.time)
            end
        end
    end
end

function UISnapItemUnitTemplate:RefreshTemplate(data)
    self.clickCallBack = data.clickCallBack
    self.timeEndCallBack = data.timeEndCallBack
    self.icon.spriteName = data.icon
    if data.time then
        if self.IenumRefreshTime ~= nil then
            StopCoroutine(self.IenumRefreshTime)
        end
        self.IenumRefreshTime = StartCoroutine(self.IEnumRefreshSnapRemainTime, self, data.time)
    end
end


--endregion

function UISnapItemUnitTemplate:OnClickBtnClick()
    if self.clickCallBack ~= nil then
        self.clickCallBack()
    end
end

--region otherFunction

function UISnapItemUnitTemplate:IEnumRefreshSnapRemainTime(time)
    local targetTime = time
    local curTime = time
    local isStop = false
    while not isStop do
        if curTime <= 0 then
            isStop = true
            if self.timeEndCallBack ~= nil then
                self.timeEndCallBack()
            end
            StopCoroutine(self.IenumRefreshTime)
            self.IenumRefreshTime = nil
        end
        curTime = curTime - CS.UnityEngine.Time.deltaTime
        self:RefreshCdMaskEffect(curTime / targetTime)
        coroutine.yield(CS.NGUIAssist.waitForEndOfFrame)
    end

end

function UISnapItemUnitTemplate:CdMaskEffect()
    if self.mCdMaskEffect == nil and self.effectLoad ~= nil and self.effectLoad.EffectObject ~= nil then
        self.mCdMaskEffect = CS.Utility_Lua.GetComponent(self.effectLoad.EffectObject.transform, "Top_CSMatCollect")
    end
    return self.mCdMaskEffect
end

function UISnapItemUnitTemplate:CdMaskEffect_Rot()
    if self.mCdMaskEffect_Rot == nil and self:CdMaskEffect() ~= nil then
        self.mCdMaskEffect_Rot = self:CdMaskEffect().gameObject.transform:Find("low/rot")
    end
    return self.mCdMaskEffect_Rot
end

function UISnapItemUnitTemplate:RefreshCdMaskEffect(Value)
    if self:CdMaskEffect() == nil or self:CdMaskEffect_Rot() == nil then
        return
    end
    self:CdMaskEffect().gameObject:SetActive(Value > 0)
    local number = self:TransformRange(1 - Value, 0, 1, -0.03, 0.998)
    for i = 0, self:CdMaskEffect().matList.Count - 1 do
        if self:CdMaskEffect().matList[i].name == "ef_ui_136" then
            local mat = self:CdMaskEffect().matList[i]:SetTextureOffset("_MaskTex", CS.UnityEngine.Vector2(number, 0))
        end
    end
    number = self:TransformRange(1 - Value, 0, 1, 0, -361)
    self:CdMaskEffect_Rot().transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, number)

end

function UISnapItemUnitTemplate:TransformRange(OldValue, OldMin, OldMax, NewMin, NewMax)
    return ((OldValue - OldMin) / (OldMax - OldMin)) * (NewMax - NewMin) + NewMin
end


--endregion

--region ondestroy

function UISnapItemUnitTemplate:ondestroy()
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
end

--endregion

return UISnapItemUnitTemplate