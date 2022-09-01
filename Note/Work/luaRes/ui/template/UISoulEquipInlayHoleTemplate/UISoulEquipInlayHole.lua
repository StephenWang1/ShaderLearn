--- DateTime: 2021/04/16 10:11
--- Description 

---@class UISoulEquipInlayHole:TemplateBase
local UISoulEquipInlayHole = {}

--setmetatable(UISoulEquipInlayHole, UIBase)

--region parameters
---@type LuaSoulEquipHoleInfo
UISoulEquipInlayHole.equipHoleInfo = nil

---@type number 从左到右1,2,3
UISoulEquipInlayHole.subIndex = 0

---@type LuaEnumSoulEquipType
UISoulEquipInlayHole.mSuitBelong = LuaEnumSoulEquipType.XianZhuang
--endregion

--region Init
function UISoulEquipInlayHole:Init()
    self:InitComponent()
    self:InitEvent()
end

function UISoulEquipInlayHole:InitComponent()
    ---
    ---@type Top_UISprite
    self.go_lock = self:Get("lock", "GameObject")
    ---
    ---@type Top_UISprite
    self.sp_soulEquipIcon = self:Get("soulEquipIcon", "Top_UISprite")
    ---
    ---@type UnityEngine.GameObject
    self.go_remove = self:Get("soulEquipIcon/remove", "GameObject")
    ---
    ---@type UnityEngine.GameObject
    self.go_choose = self:Get("soulEquipIcon/choose", "GameObject")
    ---
    ---@type UnityEngine.GameObject
    self.go_redPoint = self:Get("redPoint", "GameObject")
end

function UISoulEquipInlayHole:InitEvent()
    CS.UIEventListener.Get(self.sp_soulEquipIcon.gameObject).onClick = function(go)
        self:OnSoulEquip(go.transform)
    end
    CS.UIEventListener.Get(self.go_remove).onClick = function(go)
        self:OnRemove(go.transform)
    end
end

--endregion

--region public methods
function UISoulEquipInlayHole:RefreshUI(customData)
    if (customData ~= nil and gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():CanItBeDisplayed(customData.subIndex)) then
        self.go:SetActive(true)
    else
        self.go:SetActive(false)
        return
    end
    ---变量赋值
    self.func = customData.func
    self.index = customData.index
    self.subIndex = customData.subIndex
    self.mSuitBelong = customData.mSuitBelong
    self.equipHoleInfo = customData.equipHoleInfo
    self.selectEquip = customData.selectEquip
    ---刷新界面
    self:RefreshIcon()
    self:ShowRemove(self.equipHoleInfo ~= nil and self.equipHoleInfo.bagItemInfo ~= nil)
    self:ShowSelectedEffects(false)
    self:ShowLock()
    self:ShowRedPoint()
end
--endregion

--region private methods
---显示ICon
function UISoulEquipInlayHole:RefreshIcon()
    if (self.equipHoleInfo == nil or self.equipHoleInfo.bagItemInfo == nil) then
        self.sp_soulEquipIcon.spriteName = '';
        return
    end
    ---@type TABLE.cfg_items
    local targetTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.equipHoleInfo.bagItemInfo.itemId);
    if targetTbl then
        self.sp_soulEquipIcon.spriteName = targetTbl:GetIcon();
    end
end

---显示移除按钮
function UISoulEquipInlayHole:ShowRemove(isShow)
    self.go_remove:SetActive(isShow)
end

---显示选中特效
function UISoulEquipInlayHole:ShowSelectedEffects(isShow)
    ---如果只有一个格子显示，不显示选中特效
    local canBeDisplayedCount = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():CanBeDisplayedCount()
    if (canBeDisplayedCount ~= nil and canBeDisplayedCount <= 1) then
        isShow = false
    end
    self.go_choose:SetActive(isShow)
end

---显示锁
function UISoulEquipInlayHole:ShowLock()
    local isLock = self.equipHoleInfo == nil
    luaclass.UIRefresh:RefreshActive(self.go_lock, isLock)
end

---显示红点
function UISoulEquipInlayHole:ShowRedPoint()
    local redPointState = self.selectEquip ~= nil and self.equipHoleInfo == nil and gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():CanTurnOnTheGrid(self.mSuitBelong, self.index)
    luaclass.UIRefresh:RefreshActive(self.go_redPoint, redPointState)
end

--endregion

--region bind event
function UISoulEquipInlayHole:OnSoulEquip(go)
    if (self.index == 0) then
        return
    end
    if (self.equipHoleInfo == nil) then
        ---@param condition LuaMatchConditionResult
        local isSuccess, condition = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():CanTurnOnTheGrid(self.mSuitBelong, self.index)
        local itemInfo, IsShowGoldLabel, GoldCount, GoldIcon = nil, false, 1, ''
        if (condition ~= nil and condition.mReplaceMatData ~= nil) then
            local isFindItem
            isFindItem, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(condition.mReplaceMatData.fullConditionItemId);
            if isFindItem then
                GoldIcon = itemInfo.icon
            end
            IsShowGoldLabel = true
            GoldCount = Utility.CombineStringQuickly(isSuccess and '[00ff00]' or '[e85038]', condition.mReplaceMatData.playerHasTotal, '[-]/', condition.mReplaceMatData.num)
        end
        Utility.ShowPromptTipsPanel({ id = 169, IsShowGoldLabel = IsShowGoldLabel, GoldIcon = GoldIcon, GoldCount = GoldCount, Callback = function()
            self:OnRightClickCallBack(isSuccess)
        end, itemGoldClickCallBack = function()
            self:OnItemGoldClickCallBack(itemInfo)
        end })
        return
    end
    if (self.func ~= nil) then
        self.func(self.subIndex, self)
    end
end

function UISoulEquipInlayHole:OnRightClickCallBack(isSuccess)
    if (isSuccess == false) then
        CS.Utility.ShowRedTips('所需道具不足')
        return
    end
    networkRequest.ReqUnlockSoulEquipIndex(self.subIndex, self.index);
end

function UISoulEquipInlayHole:OnItemGoldClickCallBack(itemInfo)
    if (itemInfo ~= nil) then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
    end
end

function UISoulEquipInlayHole:OnRemove()
    if self.equipHoleInfo ~= nil and self.equipHoleInfo.bagItemInfo ~= nil then
        networkRequest.ReqPutOffSoulEquip(self.index, self.mSuitBelong, self.subIndex);
    end
end
--endregion

--region destroy
--endregion

return UISoulEquipInlayHole