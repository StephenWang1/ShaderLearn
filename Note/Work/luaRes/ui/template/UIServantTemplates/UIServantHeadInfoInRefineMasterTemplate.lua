---灵兽界面头像
---@class UIServantHeadInfoInRefineMasterTemplate:TemplateBase
local UIServantHeadInfoInRefineMasterTemplate = {}

--region 变量
UIServantHeadInfoInRefineMasterTemplate.infoInstance = nil
---@type UIServantPanel
UIServantHeadInfoInRefineMasterTemplate.Self = nil
--endregion

--region 属性
function UIServantHeadInfoInRefineMasterTemplate:GetReliveCD()
    if self.mReliveCD == nil then
        self.mReliveCD = self:Get("deadtime", "CountDownTimeLabel")
    end
    return self.mReliveCD
end

function UIServantHeadInfoInRefineMasterTemplate:GetEffectRoot_GameObejct()
    if self.mEffectRoot == nil then
        self.mEffectRoot = self:Get("EffectRoot", "GameObject")
    end
    return self.mEffectRoot
end

function UIServantHeadInfoInRefineMasterTemplate:GetBtnUseLight_GameObject()
    if (self.mBtnUseLight_GameObject == nil) then
        self.mBtnUseLight_GameObject = self:Get("ModelBG/btnUse/light", "GameObject");
    end
    return self.mBtnUseLight_GameObject;
end

function UIServantHeadInfoInRefineMasterTemplate:GetLock_GameObject()
    if (self.mLock_GameObject == nil) then
        self.mLock_GameObject = self:Get("Lock", "GameObject");
    end
    return self.mLock_GameObject;
end

---@return UnityEngine.GameObject
function UIServantHeadInfoInRefineMasterTemplate:GetLockTipsText_GameObject()
    if (self.mLockTipsText_GameObject == nil) then
        self.mLockTipsText_GameObject = self:Get("Lock/LockTipsText", "GameObject");
    end
    return self.mLockTipsText_GameObject;
end

---锁tips文本
---@return UILabel
function UIServantHeadInfoInRefineMasterTemplate:GetLockTipsTextLabel()
    if self.mLockTipsText_Label == nil then
        self.mLockTipsText_Label = self:Get("Lock/LockTipsText", "UILabel")
    end
    return self.mLockTipsText_Label
end

---使用提示
---@return UILabel
function UIServantHeadInfoInRefineMasterTemplate:GetUseTipsTextLabel()
    if self.mUseTipsTextLabel == nil then
        self.mUseTipsTextLabel = self:Get("ModelBG/UseTipsText", "UILabel")
    end
    return self.mUseTipsTextLabel
end

function UIServantHeadInfoInRefineMasterTemplate:GetDeblock_GameObject()
    if (self.mDeblock_GameObject == nil) then
        self.mDeblock_GameObject = self:Get("Lock/btn_deblocking", "GameObject");
    end
    return self.mDeblock_GameObject;
end

function UIServantHeadInfoInRefineMasterTemplate:GetDeblock_UILabel()
    if (self.mDeblock_UILabel == nil) then
        self.mDeblock_UILabel = self:Get("Lock/costitem", "Top_UILabel");
    end
    return self.mDeblock_UILabel;
end

function UIServantHeadInfoInRefineMasterTemplate:GetModelBackGround_GameObject()
    if (self.mModelBackGround_GameObject == nil) then
        self.mModelBackGround_GameObject = self:Get("iconHead/backGround", "GameObject")
    end
    return self.mModelBackGround_GameObject;
end

function UIServantHeadInfoInRefineMasterTemplate:GetIconShadow_GameObject()
    if (self.mIconShadow_GameObject == nil) then
        self.mIconShadow_GameObject = self:Get("shadow", "GameObject");
    end
    return self.mIconShadow_GameObject
end
--endregion

--region 初始化
---@param openServantPanelType XLua.Cast.Int32
function UIServantHeadInfoInRefineMasterTemplate:Init(panel, index)
    UIServantHeadInfoInRefineMasterTemplate.Self = self
    self.panel = panel;
    self.index = index;
    self.info = nil
    self:InitComponents()
    self:BindMessage()
    self:BindUIEvent()
end

function UIServantHeadInfoInRefineMasterTemplate:InitComponents()
    self.hp_UISprite = self:Get("hp", "UISprite")
    self.ChooseIcon = self:Get("Choose", "GameObject")
    self.ChooseIconAlpha = self:Get("Choose", "Top_UISprite")
    self.mode_UILabel = self:Get("mode", "UILabel")
    self.level_UILabel = self:Get("rolelevel", "UILabel")
    self.CanLevelUp_Go = self:Get("canLevelUp", "GameObject")
    self.toggle = CS.Utility_Lua.GetComponent(self.go, "Top_UIToggle")
    self.ModelBG = self:Get("ModelBG", "GameObject")
    self.IsEmpty = true
    self.IsUnLock = true
    self.RedPoint = self:Get("RedPoint", "GameObject")
    self.headIcon_UISprite = self:Get("iconHead", "UISprite")
end

function UIServantHeadInfoInRefineMasterTemplate:InitParameters()
    self.id = self.info.servantId
    self.monsterid = self.info.mid
    if (self.id ~= 0) then
        self.IsEmpty = false
    end
end

function UIServantHeadInfoInRefineMasterTemplate:BindMessage()
    local servantHeadTemplateSelf = self
end

function UIServantHeadInfoInRefineMasterTemplate:BindUIEvent()
    CS.UIEventListener.Get(self.go).onPress = function(gobj, isPress)
        self:IconOnClick(self.go);
    end
end

--endregion

--region 事件
function UIServantHeadInfoInRefineMasterTemplate:ServantIconClickEvent(clickCallback)
    self.mServantIconclickCallback = clickCallback
end

---灵兽按钮点击事件
---@param openSourceType LuaEnumPanelOpenSourceType
function UIServantHeadInfoInRefineMasterTemplate:IconOnClick(go)
    if (self.IsUnLock) then
        --未解锁
        self.panel:ShowTips(go, 327)
    else
        self.panel:HideHeadChooseIcon()
        self.panel.mSelectServantType = self:GetServantType()
        self.panel:GetCurLevel_UILabel().text = self.info.level
        self.ChooseIcon:SetActive(true)
    end
end

function UIServantHeadInfoInRefineMasterTemplate:GetServantType()
    if (self.index == 0) then
        return LuaEnumServantSpeciesType.First;
    elseif (self.index == 1) then
        return LuaEnumServantSpeciesType.Second;
    elseif (self.index == 2) then
        return LuaEnumServantSpeciesType.Third;
    end
end

--region UI界面

--region 刷新灵兽头像

function UIServantHeadInfoInRefineMasterTemplate:RefreshIcon()
    if (self.IsUnLock) then
        self.headIcon_UISprite.color = CS.UnityEngine.Color.gray
    else
        self.headIcon_UISprite.color = CS.UnityEngine.Color.white
    end
    if (self.info ~= nil) then
        self.headIcon_UISprite.spriteName = self:GetHeadIcon()
        if (self.IsEmpty) then
            self.level_UILabel.text = ""
        else
            self.level_UILabel.text = self.info.level
        end
    end
end

---获取灵兽头像图片
function UIServantHeadInfoInRefineMasterTemplate:GetHeadIcon()
    ---自己的icon使用原icon
    if self.info then
        local res, iconInfo = CS.Cfg_MonsterTableManager.Instance.dic:TryGetValue(self.info.mid)
        if res then
            return iconInfo.head
        end
    end
    return ""
end
--endregion

--region 显示背景

--endregion

--region 特效的显示与隐藏
---@param effectName string 特效名
---@param state boolean 特效状态
function UIServantHeadInfoInRefineMasterTemplate:ChangeEffectState(effectName, state, scale, pos)
    if self.effectPool == nil then
        self.effectPool = {}
    end
    if self.effectPool[effectName] ~= nil and self.effectPool[effectName].state == state then
        if (self.effectPool[effectName].go ~= nil) then
            if (state) then
                self.effectPool[effectName].go:SetActive(false)
            end
            self.effectPool[effectName].go:SetActive(state)
        end
        return
    end
    if Utility.IsContainsKey(self.effectPool, effectName) == false then
        self.effectPool[effectName] = { go = nil, state = state }
    else
        self.effectPool[effectName].state = state
    end
    if self.effectPool[effectName].go == nil or CS.StaticUtility.IsNull(self.effectPool[effectName].go) == true then
        local mCurTem = self
        CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectName, CS.ResourceType.UIEffect, function(res)
            if mCurTem and mCurTem.go and res and res.MirrorObj then
                res.IsCanBeDelete = false
                if mCurTem.effectPool[effectName].go == nil or CS.StaticUtility.IsNull(mCurTem.effectPool[effectName].go) == true then
                    mCurTem.effectPool[effectName].go = res:GetObjInst()
                    if mCurTem.effectPool[effectName].go == nil or CS.StaticUtility.IsNull(mCurTem.effectPool[effectName].go) == true then
                        return
                    end
                    mCurTem.effectPool[effectName].go.transform.parent = mCurTem:GetEffectRoot_GameObejct().transform
                    if (pos == nil) then
                        mCurTem.effectPool[effectName].go.transform.localPosition = CS.UnityEngine.Vector3.zero
                    else
                        mCurTem.effectPool[effectName].go.transform.localPosition = pos
                    end
                    if (scale == nil) then
                        scale = 120
                    end
                    mCurTem.effectPool[effectName].go.transform.localScale = CS.UnityEngine.Vector3(scale, scale, scale)
                end
                mCurTem.effectPool[effectName].go:SetActive(mCurTem.effectPool[effectName].state)
            end
        end
        , CS.ResourceAssistType.UI)
    else
        if state then
            CS.CSReactiveAtFutureFrameMgr.Instance:ReactiveTarget(self.effectPool[effectName].go)
        else
            self.effectPool[effectName].go:SetActive(state)
        end
    end
end
--endregion
--endregion

function UIServantHeadInfoInRefineMasterTemplate:OnDestroy()
    UIServantHeadInfoInRefineMasterTemplate.Self = nil
end

return UIServantHeadInfoInRefineMasterTemplate
