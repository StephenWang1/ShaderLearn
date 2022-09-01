---商城数据
---@class LuaStoreData:luaobject
local LuaStoreData = {}

---获取商会商城刷新时间(毫秒时间戳)
---@return number
function LuaStoreData:GetCommerceStoreFlushTime()
    if self.mCommerceStoreFlushTime == nil or self.mCommerceStoreFlushTime == 0 then
        self:RequestStoreFlushTime(LuaEnumStoreType.CommerceDiamond)
        return 0
    else
        return self.mCommerceStoreFlushTime
    end
end

---设置商店刷新时间
---@param data playV2.CommonInfo
function LuaStoreData:SetStoreFlushTime(data)
    if data == nil or data.type ~= luaEnumRspServerCommonType.StoreNextFlush then
        return
    end
    local isChanged = false
    if data.data == LuaEnumStoreType.CommerceDiamond then
        if self.mCommerceStoreFlushTime ~= data.data64 then
            self.mCommerceStoreFlushTime = data.data64
            isChanged = true
        end
    end
    if isChanged then
        luaEventManager.DoCallback(LuaCEvent.StoreFlushTimeRefresh, data.data)
    end
end

---初始化
function LuaStoreData:Initialize()
    self.mCommerceStoreFlushTime = nil
    self:RequestStoreFlushTime(LuaEnumStoreType.CommerceDiamond)
end

---请求商店刷新时间
---@param storeType 商店类型
function LuaStoreData:RequestStoreFlushTime(storeType)
    networkRequest.ReqCommon(luaEnumReqServerCommonType.StoreNextFlush, storeType)
end

return LuaStoreData