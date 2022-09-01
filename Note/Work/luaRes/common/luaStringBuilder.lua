---@class luaStringBuilder
local luaStringBuilder = {}

---@private
---@type table<number, string|number>
luaStringBuilder.cache = {}
---@private
---@type number
luaStringBuilder.headIndex = 1
---@private
---@type number
luaStringBuilder.tailIndex = 0
---@private
---@type luaStringBuilder
luaStringBuilder.__index = luaStringBuilder
---是否已处于released状态
---@private
---@type boolean
luaStringBuilder.mReleased = false
---@private
---@type table<number, luaStringBuilder>
luaStringBuilder.mStringBuilderPool = {}

---从缓存池中或者新创建一个luaStringBuilder,不使用时尽量调用release方法将其放入缓存池
---@public
---@return luaStringBuilder
function luaStringBuilder:new()
    local poolCount = #luaStringBuilder.mStringBuilderPool
    if poolCount > 0 then
        local tbl = luaStringBuilder.mStringBuilderPool[poolCount]
        table.remove(luaStringBuilder.mStringBuilderPool, poolCount)
        tbl:clear()
        ---@private
        tbl.mReleased = false
        return tbl
    end
    local tbl = {}
    setmetatable(tbl, luaStringBuilder)
    tbl.cache = {}
    tbl.headIndex = 1
    tbl.tailIndex = 0
    tbl.mReleased = false
    return tbl
end

---外部解除对其的引用,清空字符串,并将其放入缓存池
---@public
function luaStringBuilder:release()
    if self == luaStringBuilder then
        ---规避掉自身
        return
    end
    if self.mReleased == true then
        return
    end
    table.insert(luaStringBuilder.mStringBuilderPool, self)
    ---@private
    self.mReleased = true
    self:clear()
end

---清空字符串
---@public
function luaStringBuilder:clear()
    ---实质上字符串并未从内存中移除,而是移动了head和tail以保证调用tostring方法时将返回空字符串
    ---@private
    self.headIndex = 1
    ---@private
    self.tailIndex = 0
end

---Append字符串或者number,nil将被跳过,非string或number类型将使用tostring将其转为字符串
---@overload fun(str1:string|number)
---@overload fun(str1:string|number,str2:string|number)
---@overload fun(str1:string|number,str2:string|number,str3:string|number)
---@overload fun(str1:string|number,str2:string|number,str3:string|number,str4:string|number)
---@overload fun(str1:string|number,str2:string|number,str3:string|number,str4:string|number,str5:string|number)
---@overload fun(str1:string|number,str2:string|number,str3:string|number,str4:string|number,str5:string|number,str6:string|number)
---@overload fun(str1:string|number,str2:string|number,str3:string|number,str4:string|number,str5:string|number,str6:string|number,str7:string|number)
---@public
---@param str1 string|number
---@param str2 string|number
---@param str3 string|number
---@param str4 string|number
---@param str5 string|number
---@param str6 string|number
---@param str7 string|number
function luaStringBuilder:append(str1, str2, str3, str4, str5, str6, str7)
    if str1 then
        self:appendInternal(str1)
    end
    if str2 then
        self:appendInternal(str2)
    end
    if str3 then
        self:appendInternal(str3)
    end
    if str4 then
        self:appendInternal(str4)
    end
    if str5 then
        self:appendInternal(str5)
    end
    if str6 then
        self:appendInternal(str6)
    end
    if str7 then
        self:appendInternal(str7)
    end
end

---内部append,nil将被跳过,非string或number类型将使用tostring将其转为字符串
---@private
---@param strTemp string|nil
function luaStringBuilder:appendInternal(strTemp)
    ---@private
    self.tailIndex = self.tailIndex + 1
    local type = type(strTemp)
    ---避免存入了引用类型,进而引发内存泄漏,虽然会带来约四分之一到五分之一的额外时间开销,但是能够避免内存泄露问题,这种较小的时间开销是值得的
    if type == "string" or type == "number" then
        self.cache[self.tailIndex] = strTemp
    else
        self.cache[self.tailIndex] = tostring(strTemp)
    end
end

---合并字符串
---@return string
function luaStringBuilder:tostring()
    return table.concat(self.cache, nil, self.headIndex, self.tailIndex)
end

return luaStringBuilder