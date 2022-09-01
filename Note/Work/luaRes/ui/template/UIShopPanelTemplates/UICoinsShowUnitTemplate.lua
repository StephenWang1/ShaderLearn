local UICoinsShowUnitTemplate = {};

UICoinsShowUnitTemplate.mCoinId = 0;

--region Components

--region GameObject
function UICoinsShowUnitTemplate:GetBtnAdd_GameObject()
    if (self.mBtnAdd_GameObject == nil) then
        self.mBtnAdd_GameObject = self:Get("BtnAdd", "GameObject");
    end
    return self.mBtnAdd_GameObject;
end
--endregion

--region Text
function UICoinsShowUnitTemplate:GetCoinValue_Text()
    if (self.mCoinValue_Text == nil) then
        self.mCoinValue_Text = CS.Utility_Lua.GetComponent(self.go, "UILabel");
    end
    return self.mCoinValue_Text;
end
--endregion

--region Sprite
function UICoinsShowUnitTemplate:GetCoin_Sprite()
    if (self.mCoin_Sprite == nil) then
        self.mCoin_Sprite = self:Get("Sprite2", "UISprite");
    end
    return self.mCoin_Sprite;
end
--endregion

--endregion

--region Method

--region Public
function UICoinsShowUnitTemplate:CheckShowCoins()
    if (UICoinsShowUnitTemplate:IsCreateCoin(self.mCoinId)) then
        local mBagInfo = CS.CSScene.MainPlayerInfo.BagInfo;

        local value = mBagInfo:GetCoinAmount(self.mCoinId);
        if value == 0 then
            if (UICoinsShowUnitTemplate:IsCreateCoin(self.mCoinId)) then
                value = value + mBagInfo:GetItemCountByItemId(6210001);
                value = value + mBagInfo:GetItemCountByItemId(6210002);
            else
                value = value + mBagInfo:GetItemCountByItemId(self.mCoinId);
            end
        end

        self:GetCoinValue_Text().text = value;
    end
end

function UICoinsShowUnitTemplate:SetShowCoins(mCoinId)
    self.mCoinId = mCoinId;
    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(mCoinId);
    local mBagInfo = CS.CSScene.MainPlayerInfo.BagInfo;
    local isGetValue = false;
    local value = 0;
    if (mBagInfo.DiamondIdList:Contains(self.mCoinId)) then
        value = tostring(mBagInfo.DiamondNum)
        --value = LuaEnumCoinsColor.ZuanShi .. tostring(mBagInfo.DiamondNum)
    else
        value = mBagInfo:GetCoinAmount(mCoinId);
        if value == 0 then
            if (UICoinsShowUnitTemplate:IsCreateCoin(mCoinId)) then
                value = value + mBagInfo:GetItemCountByItemId(6210001);
                value = value + mBagInfo:GetItemCountByItemId(6210002);
            else
                value = value + mBagInfo:GetItemCountByItemId(mCoinId);
            end
        else
            --if (mCoinId == LuaEnumCoinType.JinBi or mCoinId == LuaEnumCoinType.BangJin) then
            --    value = LuaEnumCoinsColor.JinBi .. tostring(value)
            --elseif (mCoinId == LuaEnumCoinType.YuanBao or mCoinId == LuaEnumCoinType.BangYuan) then
            --    value = LuaEnumCoinsColor.YuanBao .. tostring(value)
            --end
        end
    end
    self:GetCoinValue_Text().text = value;
    if (isFind) then
        self:GetCoin_Sprite().spriteName = tostring(itemTable.icon);
    end
end

---是否为创造宝石
function UICoinsShowUnitTemplate:IsCreateCoin(id)
    if (id == 6210001 or id == 6210002) then
        return true
    end
    return false
end

---是否为元宝
function UICoinsShowUnitTemplate:ItSIngot(id)
    if (id == 1000002 or id == 1000003) then
        return true
    end
    return false
end

function UICoinsShowUnitTemplate:CompareId(itemId)
    local mBagInfo = CS.CSScene.MainPlayerInfo.BagInfo;
    if (mBagInfo.DiamondIdList:Contains(self.mCoinId) and mBagInfo.DiamondIdList:Contains(itemId)) then
        return true;
    else
        if (UICoinsShowUnitTemplate:IsCreateCoin(itemId) and UICoinsShowUnitTemplate:IsCreateCoin(self.mCoinId)) then
            return true
        elseif (UICoinsShowUnitTemplate:ItSIngot(itemId) and UICoinsShowUnitTemplate:ItSIngot(self.mCoinId)) then
            return true
        end

        return itemId == self.mCoinId;
    end
    return false;
end

--endregion

function UICoinsShowUnitTemplate:Clear()
    self.mCoinValue_Text = nil;
    self.mCoin_Sprite = nil;
    self.mBtnAdd_GameObject = nil;
end

function UICoinsShowUnitTemplate:InitEvents()
    if (self:GetBtnAdd_GameObject() ~= nil) then
        CS.UIEventListener.Get(self:GetBtnAdd_GameObject()).onClick = function()
            luaDebug.Log("BtnAdd OnClick");
        end;
    end
end
--endregion

function UICoinsShowUnitTemplate:Init()
    self:Clear();
end

return UICoinsShowUnitTemplate;