---@class SingleHuFuTemplate:TemplateBase 虎符格子模板
local SingleHuFuTemplate = {}

--region 组件
---@return UISprite 虎符icon
function SingleHuFuTemplate:GetIcon_UISprite()
    if self.mIconSp == nil then
        self.mIconSp = self:Get("Icon", "UISprite")
    end
    return self.mIconSp
end

---@return UILabel 名字
function SingleHuFuTemplate:GetName_UILabel()
    if self.mNameLb == nil then
        self.mNameLb = self:Get("Name", "UILabel")
    end
    return self.mNameLb
end

---@return UILabel 描述
function SingleHuFuTemplate:GetDes_UILabel()
    if self.mDesLb == nil then
        self.mDesLb = self:Get("Label1", "UILabel")
    end
    return self.mDesLb
end

---@return UnityEngine.GameObject
function SingleHuFuTemplate:GetCost_GO()
    if self.mCostGo == nil then
        self.mCostGo = self:Get("ownNum", "GameObject")
    end
    return self.mCostGo
end

---@return UISprite
function SingleHuFuTemplate:GetCostIcon_UISprite()
    if self.mCostIconSP == nil then
        self.mCostIconSP = self:Get("ownNum/value/icon", "UISprite")
    end
    return self.mCostIconSP
end

---@return UILabel
function SingleHuFuTemplate:GetCostLb_UILabel()
    if self.mCostIconLb == nil then
        self.mCostIconLb = self:Get("ownNum/value", "UILabel")
    end
    return self.mCostIconLb
end

---@return UILabel
function SingleHuFuTemplate:GetBtn_UILabel()
    if self.mBtnLb == nil then
        self.mBtnLb = self:Get("Btn_Sale/Label", "UILabel")
    end
    return self.mBtnLb
end

function SingleHuFuTemplate:GetBtn_UISprite()
    if self.mBtnSp == nil then
        self.mBtnSp = self:Get("Btn_Sale", "UISprite")
    end
    return self.mBtnSp
end

---@return UILabel
function SingleHuFuTemplate:GetActive_GO()
    if self.mActiveGo == nil then
        self.mActiveGo = self:Get("lb_active", "UILabel")
    end
    return self.mActiveGo
end
--endregion

---@param panel UIHuFuPanel
function SingleHuFuTemplate:Init(panel)
    self.mRootPanel = panel
    self:BindEvents()
end

function SingleHuFuTemplate:BindEvents()
    CS.UIEventListener.Get(self:GetBtn_UISprite().gameObject).onClick = function(go)
        self:OnBtnClicked(go)
    end
end

---@param tblInfo TABLE.cfg_official_emperor_token
function SingleHuFuTemplate:Refresh(tblInfo)
    self.tblInfo = tblInfo
    local itemId = tblInfo:GetLinkItemId()

    local luaItemInfo = self:CacheItemInfo(itemId)
    if luaItemInfo then
        self:GetIcon_UISprite().spriteName = luaItemInfo:GetIcon()
        self:GetName_UILabel().text = luaItemInfo:GetName()
    end

    local desStr = tblInfo:GetTips()

    local dropStr = ""
    local drop = tblInfo:GetDrop()
    if drop and drop.list and #drop.list > 0 then
        for i = 1, #drop.list do
            local singleDrop = drop.list[i]
            if singleDrop and singleDrop.list and #singleDrop.list >= 2 then
                local num = singleDrop.list[2]
                local dropItemId = singleDrop.list[1]
                local luaItemInfo = self:CacheItemInfo(dropItemId)
                if luaItemInfo then
                    dropStr = Utility.CombineStringQuickly(num, luaItemInfo:GetName())
                end
            end
        end
        desStr = string.format(desStr, dropStr)
    end

    --[[    if tblInfo:GetDropRecycleRate() then
            local recycle = math.ceil(tblInfo:GetDropRecycleRate() / 100)
            desStr = Utility.CombineStringQuickly(desStr, "\n系统回收", recycle, "%")
        end]]

    self:GetDes_UILabel().text = desStr

    local costId, num = self:GetCostInfo()
    if costId ~= 0 then
        local luaItemInfo = self:CacheItemInfo(costId)
        if luaItemInfo then
            self:GetCostIcon_UISprite().spriteName = luaItemInfo:GetIcon()
        end
        local playerHas = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(costId)
        local color = playerHas >= num and luaEnumColorType.Green or luaEnumColorType.Red
        self:GetCostLb_UILabel().text = Utility.CombineStringQuickly(color, playerHas, "[-]/", num)
        self:GetCostIcon_UISprite():UpdateAnchors()
    end
    self:GetBtn_UILabel().text = self:IsSameToken() and luaEnumColorType.Gray .. "取消" or "[c3f4ff]激活"
    self:GetBtn_UISprite().spriteName = self:IsSameToken() and "anniu26" or "anniu7"
    self:GetCost_GO():SetActive(not self:IsSameToken())
    self:GetActive_GO().gameObject:SetActive(self:IsSameToken())
    self:GetActive_GO().text = self:IsActive() and luaEnumColorType.Green .. "已激活" or luaEnumColorType.Red .. "已失效"

    local res, csItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
    if res then
        CS.UIEventListener.Get(self:GetIcon_UISprite().gameObject).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = csItemInfo })
        end
    end
end

function SingleHuFuTemplate:IsSameToken()
    local playerToken = gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():GetOfficialInfo().emperorTokenId
    return playerToken == self.tblInfo:GetId()
end

function SingleHuFuTemplate:IsActive()
    return gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():GetOfficialInfo().emperorTokenValid ~= 0
end

---@return number,number 花费id/花费数目
function SingleHuFuTemplate:GetCostInfo()
    if self.tblInfo == nil then
        return 0, 0
    end
    local cost = self.tblInfo:GetCost()
    if cost and cost.list and #cost.list > 0 then
        local costInfo = cost.list[1]
        if costInfo and costInfo.list and #costInfo.list >= 2 then
            local id = costInfo.list[1]
            local num = costInfo.list[2]
            return id, num
        end
    end
    return 0, 0
end

function SingleHuFuTemplate:CacheItemInfo(itemId)
    if self.mRootPanel then
        return self.mRootPanel:CacheItemInfo(itemId)
    end
end

---激活
function SingleHuFuTemplate:OnBtnClicked(go)
    local costId, num = self:GetCostInfo()
    local playerHas = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(costId)
    local costEnough = playerHas >= num
    if self:IsSameToken() then
        uiStaticParameter.OfficialPositionLastRefreshOperation = LuaEnumOfficialPositionLastOperationReason.UnActiveHuFu
        networkRequest.ReqOfficialEmperorTokenActivateV2(0)
        return
    end
    if costEnough and self.tblInfo then
        uiStaticParameter.OfficialPositionLastRefreshOperation = LuaEnumOfficialPositionLastOperationReason.ActiveHuFu
        networkRequest.ReqOfficialEmperorTokenActivateV2(self.tblInfo:GetId())
    else
        Utility.ShowPopoTips(go, nil, 454)
    end
end

return SingleHuFuTemplate