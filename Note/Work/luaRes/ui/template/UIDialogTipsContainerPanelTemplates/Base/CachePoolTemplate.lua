local CachePoolTemplate = {}

--region 初始化
---初始化缓存池
---@param point UnityEngine.GameObject unity对象缓存节点
---@param cloneGameObject UnityEngine.GameObject 拷贝模板
---@param maxCount number 缓存最大数量
function CachePoolTemplate:InitCachePool(commonData)
    self.isSuccessInit = self:AnalysisParams(commonData)
    if self.isSuccessInit == true then
        self:InitParams()
    end
end

---解析参数
function CachePoolTemplate:AnalysisParams(commonData)
    self.point = commonData.point
    self.cloneGameObject = commonData.cloneGameObject
    self.maxCount = commonData.maxCount
    if self.point == nil or self.cloneGameObject == nil or self.maxCount == nil then
        return false
    end
    return true
end

function CachePoolTemplate:InitParams()
    self.cachePoolTable = {}
    self.pushOutCount = 0
    self.pushOutPoolTable = {}
end
--endregion

--region 查询
---是否初始化成功
function CachePoolTemplate:InitSuccess()
    return self.isSuccessInit
end

---是否有缓存对象
function CachePoolTemplate:HaveCacheGameObject()
    return #self.cachePoolTable > 0
end
--endregion

--region 功能
---获取克隆物品（受数量限制）
---@return boolean,UnityEngine.GameObject 错误码，GameObject
function CachePoolTemplate:TryGetCloneGameObject()
    if self.pushOutCount < self.maxCount then
        local successPushOut,gameObject = self:PutOutCache()
        local pushOutCode = ternary(successPushOut == true,LuaEnumCachePoolFaultCode.NONE,LuaEnumCachePoolFaultCode.PushOutDefeat)
        return pushOutCode,gameObject
    else
        return LuaEnumCachePoolFaultCode.EXCEEDMAXCOUNT,nil
    end
end

---获取克隆物品（如果超过限制，则默认移除第一个）
---@return boolean,UnityEngine.GameObject 错误码，GameObject
function CachePoolTemplate:GetCloneGameObject()
    if self.pushOutCount >= self.maxCount then
        local gameObject = self.pushOutPoolTable[1]
        CachePoolTemplate:PushInCache(gameObject)
    end
    local successPushOut,gameObject = self:PutOutCache()
    local pushOutCode = ternary(successPushOut == true,LuaEnumCachePoolFaultCode.NONE,LuaEnumCachePoolFaultCode.PushOutDefeat)
    return pushOutCode,gameObject
end
--endregion

--region 数据处理
---推入缓存
---@param 预设 UnityEngine.GameObject
---@return 是否成功推出缓存
function CachePoolTemplate:PushInCache(gameObject)
    if gameObject ~= nil then
        if Utility.RemoveTableValue(self.pushOutPoolTable,gameObject) == true then
            gameObject.gameObject:SetActive(false)
            table.insert(self.cachePoolTable,gameObject)
            self.pushOutCount = self.pushOutCount - 1
            return true
        end
    end
    return false
end

---推出缓存
---@return boolean,UnityEngine.GameObject 是否成功推出，推出的预设
function CachePoolTemplate:PutOutCache()
    local gameObject = nil
    if #self.cachePoolTable > 0 then
        gameObject = self.cachePoolTable[1]
        table.remove(self.cachePoolTable,1)
    else
        gameObject = CS.Utility_Lua.CopyGO(self.cloneGameObject,self.point.transform)
    end
    if gameObject ~= nil then
        table.insert(self.pushOutPoolTable,gameObject)
        self.pushOutCount = self.pushOutCount + 1
        gameObject.gameObject:SetActive(true)
        return true,gameObject
    end
    return false,nil
end
--endregion

--region OnDestroy
function CachePoolTemplate:OnDestroy()
    if self.cachePoolTable ~= nil and #self.cachePoolTable > 0 then
        for k,v in pairs(self.cachePoolTable) do
            CS.UnityEngine.Object.Destroy(v)
        end
    end
    if self.pushOutPoolTable ~= nil and #self.pushOutPoolTable > 0 then
        for k,v in pairs(self.pushOutPoolTable) do
            CS.UnityEngine.Object.Destroy(v)
        end
    end
    self.cachePoolTable = {}
    self.pushOutPoolTable = {}
    self.pushOutCount = 0
end
--endregion

return CachePoolTemplate