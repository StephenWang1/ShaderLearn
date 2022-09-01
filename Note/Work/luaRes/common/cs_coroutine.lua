local cs_coroutine = {}

local gameobject = CS.UnityEngine.GameObject('Coroutine_Runner')
CS.UnityEngine.Object.DontDestroyOnLoad(gameobject)
local cs_coroutine_runner = gameobject:AddComponent(typeof(CS.Coroutine_Runner))

local function async_yield_return(to_yield, cb)
    cs_coroutine_runner:YieldAndCallback(to_yield, cb)
end

---启动C#中的协程,返回开启的协程
function cs_coroutine.StartCoroutine(coroutinefunction, ...)
    if coroutinefunction == nil or cs_coroutine_runner == nil or CS.StaticUtility.IsNull(cs_coroutine_runner) then
        return nil
    end
    return cs_coroutine_runner:StartCoroutine(util.cs_generator(coroutinefunction, ...))
end

---关闭从本脚本启动的C#中的协程
function cs_coroutine.StopCoroutine(coroutine)
    if coroutine ~= nil and cs_coroutine_runner ~= nil and CS.StaticUtility.IsNull(cs_coroutine_runner) == false then
        cs_coroutine_runner:StopCoroutine(coroutine)
    end
end

cs_coroutine.yield_return = util.async_to_sync(async_yield_return)
return cs_coroutine