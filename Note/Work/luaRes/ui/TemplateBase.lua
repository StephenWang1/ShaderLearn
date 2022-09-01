---模板基类
---go表示模板所指向的游戏物体
---生命周期对应的函数为:
---  Init 初始化函数,Table定义时执行
---  Start 与MonoBehaviour的Start函数运行位置一致;
---  OnEnable 使能函数,Table对应的游戏物体使能时执行
---  OnDisable 禁用函数,Table对应的游戏物体被禁用时执行
---  OnDestroy 销毁函数,Table对应的游戏物体被销毁时执行
---@class TemplateBase
local TemplateBase = {}

local Utility = Utility
local IsNullFunction = CS.StaticUtility.IsNull

TemplateBase.__index = TemplateBase
---@type string 模块名
TemplateBase.chunkName = "TemplateBase"
---@type UnityEngine.GameObject
TemplateBase.go = nil
---@type function
TemplateBase.Init = nil
---@type function
TemplateBase.Start = nil
---@type function
TemplateBase.OnEnable = nil
---@type function
TemplateBase.OnDisable = nil
---@type function
TemplateBase.OnDestroy = nil
---析构时被调用
---@type function
TemplateBase.OnDestruct = nil
---是否包含Unity生命周期函数
---@type boolean
TemplateBase.__UnityFunctionExist = false

---运行基类时对每层基类的调用进行计数,以确定元表的调用次数
---@type table
TemplateBase.__RunBaseCountDic = {}
---C#的Utility_Lua.Get方法
---@type function
TemplateBase.CSGetFunction = CS.Utility_Lua.Get

---根据路径获取模板的物体下组件或Transform,GameObject
---@protected
---@param path string 相对路径
---@param typeStr string 组件类型字符串
function TemplateBase:Get(path, typeStr)
    if self == nil or CS.StaticUtility.IsNull(self.go) or self.go.transform == nil or path == nil or typeStr == nil then
        return nil
    end
    return TemplateBase.CSGetFunction(self.go.transform, path, typeStr)
end

---根据路径获取模板的物体下组件或Transform,GameObject
---@protected
---@param go UnityEngine.GameObject 父节点
---@param path string 相对路径
---@param typeStr string 组件类型字符串
function TemplateBase:GetCurComp(go, path, typeStr)
    if IsNullFunction(go) or path == nil or typeStr == nil then
        return nil
    end
    return TemplateBase.CSGetFunction(go.transform, path, typeStr)
end

---执行元表中的函数
---@protected
---@param functionName string 元表中的函数名
---@vararg any
function TemplateBase:RunBaseFunction(functionName, ...)
    if self ~= nil and functionName ~= nil then
        --调用函数时,在__RunBaseCountDic表中对传入的self对象的调用次数加一或初始化为一
        if Utility.IsContainsKey(TemplateBase.__RunBaseCountDic, self) == false then
            TemplateBase.__RunBaseCountDic[self] = {}
        end
        if Utility.IsContainsKey(TemplateBase.__RunBaseCountDic[self], functionName) == false then
            TemplateBase.__RunBaseCountDic[self][functionName] = 1
        else
            TemplateBase.__RunBaseCountDic[self][functionName] = TemplateBase.__RunBaseCountDic[self][functionName] + 1
        end
        --该函数中传入的self一般为以模板为元表新建的表,所以需要先取一次元表以获取模板
        local baseMetaTable = getmetatable(self)
        --根据调用本函数的次数决定向上取多少次才能获取到上一级的元表,次数为1表示只需要取一次元表
        for i = 1, TemplateBase.__RunBaseCountDic[self][functionName] do
            if baseMetaTable ~= nil then
                baseMetaTable = getmetatable(baseMetaTable)
            else
                break
            end
        end
        local result
        --若元表中找到了该方法
        if baseMetaTable ~= nil and baseMetaTable[functionName] ~= nil then
            if Utility.IsTruelyContainsKey(baseMetaTable, functionName) then
                --若元表本表中有该方法,则调用元表中的方法,并将返回值放入返回值表中
                result = { baseMetaTable[functionName](self, ...) }
            else
                --若元表本表中没有该方法,则再次递归本方法
                result = { self:RunBaseFunction(functionName, ...) }
            end
        end
        --将__RunBaseCountDic表中self对应的调用次数减一
        TemplateBase.__RunBaseCountDic[self][functionName] = TemplateBase.__RunBaseCountDic[self][functionName] - 1
        if TemplateBase.__RunBaseCountDic[self][functionName] == 0 then
            TemplateBase.__RunBaseCountDic[self][functionName] = nil
            if Utility.IsNullTable(TemplateBase.__RunBaseCountDic[self]) then
                TemplateBase.__RunBaseCountDic[self] = nil
            end
        end
        --将返回值表中的元素依次放入返回队列中
        if result ~= nil then
            return table.unpack(result)
        end
    end
end

return TemplateBase