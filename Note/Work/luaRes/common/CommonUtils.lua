---@class Utility
local Utility = {}

Utility.IsGetingChristmasReward = false--正在领取圣诞礼物的标志
Utility.isIdCardNumberEntered = nil--是否验证过身份信息
Utility.isOver18 = nil --是否大于18岁
---@type UIAntiAddictionPanel
Utility.UIAntiAddictionPanel = nil --是否是第一次登陆

Utility.BrotherRequesInfo = nil--结拜求援信息
Utility.mLastPushGiftTime = 0--上次6元礼包推送时间
---C#中将枚举转为Int的方法
Utility.CSConvertEnumToInt = CS.Utility_Lua.ConvertEnumToInt

Utility.IsOpenFrontHotLoad = false

---快速合并字符串,nil将被跳过,非string或number类型将使用tostring将其转为字符串
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
---@return string
function Utility.CombineStringQuickly(str1, str2, str3, str4, str5, str6, str7)
    local sbtemp = stringbuilder:new()
    sbtemp:append(str1, str2, str3, str4, str5, str6, str7)
    local str = sbtemp:tostring()
    sbtemp:release()
    return str
end

--分割字符串
function _fSplit(szFullString, szSeparator)
    local nFindStartIndex = 1
    local nSplitIndex = 1
    local nSplitArray = {}
    while true do
        local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
        if not nFindLastIndex then
            nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
            break
        end
        nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
        nFindStartIndex = nFindLastIndex + string.len(szSeparator)
        nSplitIndex = nSplitIndex + 1
    end
    return nSplitArray
end

-- 字符串sep里的每个字符都是分割符
function string.Split(inputstr, sep, removeSpace)
    if (inputstr == nil or type(inputstr) ~= 'string') then
        return {}
    end

    sep = sep or '%s'

    if (removeSpace == nil) then
        removeSpace = true
    end

    local result = {}
    local pattern = Utility.CombineStringQuickly("([^", sep, "]+)")
    for str in string.gmatch(inputstr, pattern) do
        if (removeSpace == false or str:find('%S')) then
            table.insert(result, str)
        end
    end

    return result
end

-- 字符串sep整个作为一个分割符
function string.SplitByStr(inputstr, sep, removeSpace)
    if (inputstr == nil or type(inputstr) ~= 'string') then
        return {}
    end

    sep = sep or '%s'

    if (removeSpace == nil) then
        removeSpace = true
    end

    local result = {}

    inputstr:gsub('(.-)' .. sep, function(str)
        if (removeSpace == false or str:find('%S')) then
            table.insert(result, str)
        end
    end)

    if (#result == 0) then
        table.insert(result, inputstr)
    end

    return result
end

function string.SplitStrToIntList(inputstr, sep)
    if (inputstr == nil or type(inputstr) ~= 'string') then
        return {}
    end
    sep = sep or '%s'

    local result = {}
    local pattern = Utility.CombineStringQuickly("([^", sep, "]+)")
    for str in string.gmatch(inputstr, pattern) do
        if (str:find('%S')) then
            table.insert(result, tonumber(str))
        end
    end
    return result
end

function string.SplitGlobalStrToStrList(id, sep)
    local isFind, globalCfg = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        return string.Split(globalCfg.value, sep)
    end
    return {}
end

function string.SplitGlobalStrToStrListList(id, sep1, sep2)
    local isFind, globalCfg = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        local tbl = string.Split(globalCfg.value, sep1)
        local resultTbl = {}
        for i = 1, #tbl do
            table.insert(resultTbl, string.Split(tbl[i], sep2))
        end
        return resultTbl
    end
    return {}
end

function string.SplitGlobalStrToIntList(id, sep)
    local isFind, globalCfg = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        return string.SplitStrToIntList(globalCfg.value, sep)
    end
    return {}
end

function string.SplitStrToIntListList(inputstr, sep1, sep2)
    local result = {}
    local tempResult = string.Split(inputstr, sep1)
    for i = 1, #tempResult do
        table.insert(result, string.SplitStrToIntList(tempResult[i], sep2))
    end
    return result
end

function string.SplitGlobalStrToIntListList(id, sep1, sep2)
    local isFind, globalCfg = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        return string.SplitStrToIntListList(globalCfg.value, sep1, sep2)
    end
    return {}
end

---@return LuaBehaviour
function Utility.InitLuaBehaviour(go, panelName)
    if (go == nil or CS.StaticUtility.IsNull(go)) then
        return nil
    end

    local luaBehavi = CS.Utility_Lua.GetComponent(go, "LuaBehaviour")

    if (luaBehavi == nil or CS.StaticUtility.IsNull(luaBehavi)) then
        -- print('Utility.InitLuaBehaviour1', panelName)
        luaBehavi = go:AddComponent(typeof(CS.LuaBehaviour))
        -- print('Utility.InitLuaBehaviour2', panelName, luaBehavi)
        --else
        --    luaBehavi:Show();
    end
    luaBehavi:InitWithFilePath('luaRes/ui/panels/' .. panelName .. '.lua', panelName)
    --luaBehavi:Init(file_util.ReadLuaFile('luaRes/ui/panels/' .. panelName .. '.lua'), panelName)
    return luaBehavi
end

--right右移num位
function Utility.rShiftOp(right, num)
    return math.floor(right / (2 ^ num))
end

--与
function Utility.__andBit(left, right)
    return (left == 1 and right == 1) and 1 or 0
end

--取位
function Utility.andOp(left, right)
    return Utility.__base(left, right, Utility.__andBit)
end

function Utility.__base(left, right, op)
    --对每一位进行op运算，然后将值返回
    if left < right then
        left, right = right, left
    end
    local res = 0
    local shift = 1
    while left ~= 0 do
        local ra = left % 2    --取得每一位(最右边)
        local rb = right % 2
        res = shift * op(ra, rb) + res
        shift = shift * 2
        left = math.modf(left / 2)  --右移
        right = math.modf(right / 2)
    end
    return res
end

function Utility.IsNilOrEmptyString(str)
    return type(str) ~= 'string' or str == nil or #str == 0
end

Utility.EnumToIntTable = {}
---由枚举转为int，实质上是直接调用GetHashCode方法,而枚举类型算出来的哈希值就是其值
---@param enumObj System.Enum C#的枚举
---@return number
function Utility.EnumToInt(enumObj)
    if Utility.EnumToIntTable[enumObj] then
        return Utility.EnumToIntTable[enumObj]
    end
    local res = Utility.CSConvertEnumToInt(enumObj)
    Utility.EnumToIntTable[enumObj] = res
    return res
end

----table operations
---@param tbl table
---@return number lua的table中的键值对数量
function Utility.GetLuaTableCount(tbl)
    local count = 0
    if (tbl) then
        for k, v in pairs(tbl) do
            count = count + 1
        end
    end
    return count
end

function Utility.IsNullTable(tbl)
    if (tbl and type(tbl) == 'table') then
        for k, v in pairs(tbl) do
            return false
        end
    end
    return true
end

function Utility.IsContainsKey(tbl, key)
    if Utility.IsNullTable(tbl) then
        return false
    end
    --for k, v in pairs(tbl) do
    --    if k == key then
    --        return true
    --    end
    --end
    --return false;

    return tbl[key] ~= nil;
end

function Utility.IsContainsValue(tbl, value)
    if Utility.IsNullTable(tbl) then
        return false
    end
    for k, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

---移除对应value
---@return boolean 是否成功移除
function Utility.RemoveTableValue(tbl, value)
    if Utility.IsNullTable(tbl) then
        return false
    end
    for k, v in pairs(tbl) do
        if v == value then
            table.remove(tbl, k)
            return true
        end
    end
    return false
end

---不考虑元表,返回表中是否有该键
---@param tbl table 待检测的表
---@param key any 待检测的键
---@return boolean 表中是否包含了该键
function Utility.IsTruelyContainsKey(tbl, key)
    if tbl == nil or type(tbl) ~= "table" or key == nil then
        return false
    end
    return rawget(tbl, key) ~= nil
end

---获取表内第一个数据
---@param tbl table 表数据
---@return any 表的第一个value
function Utility.GetTableFirstValue(tbl)
    if tbl ~= nil and type(tbl) == 'table' then
        for k, v in pairs(tbl) do
            return v
        end
    end
end

---清空table
---@param tbl table 需要清空的table
function Utility.ClearTable(tbl)
    if tbl then
        for i, v in pairs(tbl) do
            tbl[i] = nil
        end
    end
end

--为了兼容luajit，lua53版本直接用|操作符即可
local enum_or_op = debug.getmetatable(CS.System.Reflection.BindingFlags.Public).__bor
local enum_or_op_ex = function(first, ...)
    for _, e in ipairs({ ... }) do
        first = enum_or_op(first, e)
    end
    return first
end

-- description: 直接用C#函数创建delegate 同util.createdelegate
function Utility.createdelegate(delegate_cls, obj, impl_cls, method_name, parameter_type_list)
    local flag = enum_or_op_ex(CS.System.Reflection.BindingFlags.Public, CS.System.Reflection.BindingFlags.NonPublic,
            CS.System.Reflection.BindingFlags.Instance, CS.System.Reflection.BindingFlags.Static)
    local m = parameter_type_list and typeof(impl_cls):GetMethod(method_name, flag, nil, parameter_type_list, nil)
            or typeof(impl_cls):GetMethod(method_name, flag)
    return CS.System.Delegate.CreateDelegate(CS.System.Type.GetType(delegate_cls), obj, m)
end

-- description: 直接用C#函数创建delegate 同util.createdelegate,直接传入delegate的类型
function Utility.createdelegateByDelType(delegate_type, obj, impl_cls, method_name, parameter_type_list)
    local flag = enum_or_op_ex(CS.System.Reflection.BindingFlags.Public, CS.System.Reflection.BindingFlags.NonPublic,
            CS.System.Reflection.BindingFlags.Instance, CS.System.Reflection.BindingFlags.Static)
    local m = parameter_type_list and typeof(impl_cls):GetMethod(method_name, flag, nil, parameter_type_list, nil)
            or typeof(impl_cls):GetMethod(method_name, flag)
    return CS.System.Delegate.CreateDelegate(delegate_type, obj, m)
end

--获取所有子物体上的脚本返回一个CS集合或数组
--function Utility.LuaGetComponentsInChildren(parent, typeStr, CSType, includeInactive, isList)
--    if ((parent == nil) or (typeStr == nil) or (typeStr == "") or (type == nil)) then
--        return nil
--    end
--    if (parent:GetType() ~= typeof(CS.UnityEngine.Transform)) then
--        return nil
--    end
--    if (((includeInactive ~= nil) and (type(includeInactive) ~= 'boolean')) or (isList ~= nil) and (type(isList) ~= 'boolean')) then
--        return nil
--    end
--    if (includeInactive == nil) then
--        includeInactive = false
--    end
--    if (isList == nil) then
--        isList = false
--    end
--    local typestr = "List`1[" .. typeStr .. "]"
--    local comList = CS.System.Collections.Generic[typestr]()
--    local indexs = parent.childCount - 1
--    for i = 0, indexs, 1 do
--        if (includeInactive) then
--            CS.Utility_Lua.GetComponent(comList:Add(parent:GetChild(i), CSType))
--        else
--            if (parent:GetChild(i).gameObject.activeSelf) then
--                CS.Utility_Lua.GetComponent(comList:Add(parent:GetChild(i), CSType))
--            end
--        end
--    end
--    if (isList) then
--        return comList
--    else
--        return (comList:ToArray())
--    end
--    return nil
--end

--获取值的类型是否等于需要判断的cs类型
function Utility.IsValueTypeEqualsAimCSType(value, cstype)
    local isEquals = false

    if (value == nil) then
        return isEquals
    end

    local valuetypeName = string.SplitByStr(tostring(value), ':')[1]
    local cstypeName = string.SplitByStr(tostring(typeof(cstype)), ':')[1]

    isEquals = (valuetypeName == cstypeName)

    return isEquals
end

---获取整数的每一位
---@param num number 整数
---@param base number 基数，默认为2
---@return table 返回每一位上的数字,从低位到高位排列
function Utility.GetEachBitOfNumber(num, base)
    if num == nil or type(num) ~= "number" then
        return nil
    end
    if base == nil or type(base) ~= "number" then
        base = 2
    else
        base = math.floor(base)
    end
    if base < 2 then
        base = 2
    end
    num = math.floor(num)
    if num < 0 then
        num = num * -1
    end
    local res = {}
    if base == 2 then
        repeat
            table.insert(res, num | 1)
            num = num >> 1
        until (num == 0)
    else
        repeat
            table.insert(res, num % base)
            num = math.floor(num / base)
        until (num == 0)
    end
    return res
end

---向下取整 3.1 return 3
function Utility.GetIntPart(x)
    if x <= 0 then
        return math.ceil(x)
    end
    if math.ceil(x) == x then
        x = math.ceil(x)
    else
        x = math.ceil(x) - 1
    end
    return x
end

---向上取整 3.1 return 4
function Utility.GetMaxIntPart(x)

    return math.ceil(x)
end

---拆分浮点
---@param number number
function Utility.SplitFloat(number)
    if number ~= nil then
        return math.modf(number)
    end
end

---获取小数
---@param number number
function Utility.GetDecimal(number)
    local integer, decimal = Utility.SplitFloat(number)
    return decimal
end

---通过时间戳获取DateTime
---@param millisecond number 时间戳
---@return System.DateTime
function Utility.GetDateTimeByMillisecond(millisecond)
    return CS.CSServerTime.StampToDateTime(millisecond)
end

---通过年月日天时分秒获取时间戳
---@return number 时间戳
function Utility.GetMillisecondByYearTime(year, month, day, hour, minute, second)
    if year < 0 or month < 0 or month > 12 or day < 0 or day > 31 or hour < 0 or hour > 24 or minute < 0 or minute > 60 or second < 0 or second > 60 then
        return 0
    end
    local dateTime = CS.Utility_Lua.GetDateTimeByYearTime(year, month, day, hour, minute, second)
    return CS.CSServerTime.DateTimeToStamp(dateTime)
end

--- 毫秒转小时：分钟：秒
function Utility.MillisecondToFormatTime(millisecond)
    local secondTemp = millisecond / 1000
    local hour = (secondTemp - secondTemp % 3600) / 3600
    local minute = ((secondTemp - hour * 3600) - (secondTemp - hour * 3600) % 60) / 60
    local second = secondTemp - hour * 3600 - minute * 60
    return hour, minute, second
end

--- 毫秒转分钟：秒
function Utility.MillisecondToMinuteTime(millisecond)
    local secondTemp = millisecond / 1000
    local minute = Utility.GetIntPart(secondTemp / 60)
    local second = Utility.GetMaxIntPart(secondTemp - minute * 60)
    return minute, second
end
-- 删除table表中符合conditionFunc的数据
-- @param tb 要删除数据的table
-- @param conditionFunc 符合要删除的数据的条件函数
function Utility.RemoveTableData(tb, conditionFunc)
    if tb ~= nil and next(tb) ~= nil then
        for i = #tb, 1, -1 do
            if conditionFunc(tb[i]) then
                tb.remove(tb, i)
            end
        end
    end
end

---毫秒转总分钟
function Utility.MillisecondToTotalMinute(millisecond)
    local hour, minute, second = Utility.MillisecondToFormatTime(millisecond)
    return hour * 60 + minute
end

--- Int转Bool
function Utility.IntToBool(int)
    if int ~= 0 then
        return true
    else
        return false
    end
end

---小数四舍五入保留
---@param targetNum number
---@param n  number  位数
function Utility.FloatRounding(targetNum, n)
    if targetNum == nil or targetNum == 0 then
        return 0
    end
    if n == 0 then
        local t1, t2 = math.modf(targetNum)
        return t1
    end
    targetNum = targetNum * 10 * n
    if targetNum % 1 >= 0.5 then
        targetNum = math.ceil(targetNum)
    else
        targetNum = math.floor(targetNum)
    end
    return targetNum * (n / 10)
end

---去除小数末尾0
function Utility.RemoveEndZero(num)
    if num <= 0 then
        return 0
    else
        local t1, t2 = math.modf(num)
        if t2 > 0 then
            return num
        else
            return t1
        end
    end
end

function Utility.GetAttributeName(type)
    local attributeName = CS.Cfg_Property_NameTableManager.Instance:GetRoleAttributeName(type)
    return attributeName;
end

---获取角色属性名
function Utility.GetRoleAttributeName(attributeId)
    return CS.Cfg_Property_NameTableManager.Instance:GetRoleAttributeName(tonumber(attributeId))
end

function Utility.GetCareerAttackName(career)
    if career == LuaEnumCareer.Warrior then
        return "攻击"
    elseif career == LuaEnumCareer.Master then
        return "魔法"
    elseif career == LuaEnumCareer.Taoist then
        return "道术"
    else
        return "攻击"
    end
end

function Utility.GetCareerAttackNameInServantTips(career)
    if career == LuaEnumCareer.Warrior then
        return "攻       击"
    elseif career == LuaEnumCareer.Master then
        return "魔       法"
    elseif career == LuaEnumCareer.Taoist then
        return "道       术"
    else
        return "攻       击"
    end
end

---检查属性是否为空
---@param Attr string
function Utility.CheckAttributeIsEmpty(Attr)
    if (type(Attr) == 'number') then
        Attr = tostring(Attr)
    end
    if (#Attr == 0 or Attr == '0' or Attr == '-1') then
        return true
    end
    local attrs = string.Split(Attr, '-')
    if (#attrs > 1 and attrs[1] == '0' and attrs[2] == '0') then
        return true
    end
    return false
end

function Utility.GetWeekStr(weekNum)
    local weekStr = {};
    weekStr[1] = "一";
    weekStr[2] = "二"
    weekStr[3] = "三";
    weekStr[4] = "四"
    weekStr[5] = "五";
    weekStr[6] = "六"
    weekStr[7] = "日";
    return weekStr[weekNum];
end

---根据职业枚举得到职业名字
---@param  careerEnum number 职业枚举
function Utility.GetCareerName(careerEnum)
    local careerName = "通用"
    if careerEnum == 1 then
        careerName = "战士"
    elseif careerEnum == 2 then
        careerName = "法师"
    elseif careerEnum == 3 then
        careerName = "道士"
    elseif careerEnum == 4 then
        careerName = "刺客"
    elseif careerEnum == 5 then
        careerName = "c村民"
    end
    return careerName
end

---获取标识颜色（绿，红）
---@param isAvailable boolean
---@return string
function Utility.GetBBCode(isAvailable)
    if isAvailable then
        return '[00ff00]'
    else
        return '[ff0000]'
    end
end

---获取标识颜色（绿，白）
---@param isAvailable boolean
---@return string
function Utility.GetGRCode(isAvailable)
    if isAvailable then
        return '[00ff00]'
    else
        return '[dde6eb]'
    end
end

---新标识颜色（白，红）
---@param isAvailable boolean
---@return string
function Utility.NewGetBBCode(isAvailable)
    if isAvailable then
        return '[dde6eb]'
    else
        return '[ff0000]'
    end
end

---获取点击位置
function Utility.GetTouchPoint()
    local fingerID = 0
    local touchPos;
    return CS.UICamera.currentTouch.pos;
end

---把一个数据结构切割成分页结构(lua数据结构)
function SplitToList(list, rowCount)
    local returnList = {};
    if (list ~= nil) then
        local index = 0;
        local value = 0;
        local num = 0;
        for k, v in pairs(list) do
            if (value < rowCount) then
                value = value + 1;
            else
                value = 1;
                num = num + 1;
            end
            if (#returnList == num) then
                table.insert(returnList, {});
            end
            table.insert(returnList[num + 1], v);
            index = index + 1;
        end
        return returnList;
    end
    return nil;
end

function SplitToListSetShopShow(list, rowCount)
    local returnList = {};
    if (list ~= nil) then
        local index = 0;
        local value = 0;
        local num = 0;
        CS.Utility_Lua.luaForeachCsharp:Foreach(list, function(k, v)
            if (value < rowCount) then
                value = value + 1;
            else
                value = 1;
                num = num + 1;
            end
            if (#returnList == num) then
                table.insert(returnList, {});
            end
            table.insert(returnList[num + 1], v);
            index = index + 1;
        end)
        return returnList;
    end
    return nil;
end

---随机打乱表数据
function Utility.RandomTable(table)
    math.randomseed(os.time())
    for i = #table, 1, -1 do
        local randomValue = math.random(i)
        table[i], table[randomValue] = table[randomValue], table[i]
    end
    return table
end

---添加闪烁提示
---@param temp {id:number,configid:number,clickCallBack:function,panelPriority:function}
----id flash表id
---configid 唯一id （可以不填，自己定义的唯一id）
---clickCallBack 点击回调
---panelPriority 面板参数 如果需要打开面板
function Utility.AddFlashPrompt(temp)
    ---@type UIMainChatPanel
    local chatPanel = uimanager:GetPanel('UIMainChatPanel')
    if chatPanel and chatPanel.flashTipsTemplate then
        chatPanel.flashTipsTemplate:AddFlashPrompt(temp)
    else
        if uiStaticParameter.flashCache == nil then
            uiStaticParameter.flashCache = {}
        end
        table.insert(uiStaticParameter.flashCache, temp)
    end
end

---尝试添加闪烁提示，如果有该提示，则刷新回调
---@param temp {id:number,configid:number,clickCallBack:function,panelPriority:function}
----id flash表id
---configid 唯一id （可以不填，自己定义的唯一id）
---clickCallBack 点击回调
---panelPriority 面板参数 如果需要打开面板
function Utility.TryAddFlashPromp(temp)
    local haveFlashPromp = Utility.CheckFlashPrompt(1, temp.id)
    if haveFlashPromp == true then
        Utility.RefreshFlashPrompt(temp)
    else
        Utility.AddFlashPrompt(temp)
    end
end

---根据id类型删除闪烁提示
---@param id number id
---@param type number  ID类型: 1：flash表id 2：configid（自己定义）
function Utility.RemoveFlashPrompt(type, id)
    local chatPanel = uimanager:GetPanel('UIMainChatPanel')
    if chatPanel and chatPanel.flashTipsTemplate then
        chatPanel.flashTipsTemplate:RemoveFlashPrompt(type, id)
    end
    if type == 1 then
        CS.CSScene.MainPlayerInfo.GroupInfoV2.IsHaveNewTeamInvitat = false
        --CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.Team_Main);
    end
end

---根据id类型判断是否存在此提示
---@param id number id
---@param type number  ID类型: 1：flash表id 2：configid（自己定义）
function Utility.CheckFlashPrompt(type, id)
    local chatPanel = uimanager:GetPanel('UIMainChatPanel')
    if chatPanel and chatPanel.flashTipsTemplate then
        return chatPanel.flashTipsTemplate:CheckFlashPrompt(type, id)
    end
end

---刷新闪烁提示（刷新内部数据，要求id和config和内部数据完全一致）
function Utility.RefreshFlashPrompt(temp)
    local chatPanel = uimanager:GetPanel('UIMainChatPanel')
    if chatPanel and chatPanel.flashTipsTemplate then
        chatPanel.flashTipsTemplate:RefreshFlashPrompt(temp)
    end
end

---通过key删除表中指定的元素
function Utility.RemoveElementByKey(tbl, key)
    local keys = {}
    for i in pairs(tbl) do
        table.insert(keys, i)
    end
    local newtable = {}
    local i = 1
    while i <= #keys do
        local mkey = keys
        if mkey == key then
            table.remove(keys, i)
        else
            newtable[mkey] = tbl[mkey]
            i = i + 1
        end
    end
    return newtable
end

---获取表的个数
function Utility.GetTableCount(table)
    if table == nil then
        return 0
    else
        local count = 0
        for _, _ in pairs(table) do
            count = count + 1
        end
        return count
    end
end

---获取表下最后一个数据
function Utility.GetTableLastNum(table)
    if table == nil or type(table) ~= 'table' then
        return nil
    end
    local info = nil
    for k, v in pairs(table) do
        info = v
    end
    return info
end

---c#链表转lua表
function Utility.ListChangeTable(list)
    local cufTable = {}
    if list ~= nil then
        local length = list.Count - 1
        for k = 0, length do
            table.insert(cufTable, list[k])
        end
    end
    return cufTable
end

---将表中所有可转成数字的转成数字
function Utility.ChangeNumberTable(inputTable)
    if inputTable ~= nil and type(inputTable) == 'table' then
        local curTable = {}
        for k, v in pairs(inputTable) do
            local num = tonumber(v)
            if num ~= nil and type(num) == 'number' then
                table.insert(curTable, num)
            else
                table.insert(curTable, v)
            end
        end
        return curTable
    end
end

---表的头部添加value
---@param curTable table
---@param value any
function Utility.TableFirstSetValue(curTable, value)
    if type(curTable) ~= 'table' or value == nil then
        return
    end
    local newTable = {}
    table.insert(newTable, value)
    for k, v in pairs(curTable) do
        table.insert(newTable, v)
    end
    return newTable
end

---获取主角的攻击类型名称
function Utility.GetMainPlayerAttackCount()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20303)
    if isFind then
        local strArray = string.Split(info.value, '#')
        local careerIndex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
        return strArray[careerIndex]
    else
        return '战力'
    end
end

---清除指定下标后的数据
function Utility.RemoveTableLateDataByIndex(table, index)
    local mtable = table
    while (#mtable > index) do
        table.remove(mtable, index)
    end
    return mtable
end

function Utility.GetEquipIndexWithFurnacePanelId(furnacePanelId)
    local equipIndex;
    if (furnacePanelId == LuaEnumFurnaceOpenType.Gem) then
        equipIndex = Utility.EnumToInt(CS.EEquipIndex.POS_GEMGLOVE);
    elseif (furnacePanelId == LuaEnumFurnaceOpenType.TheSourceOfDefense) then
        equipIndex = Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA);
    elseif (furnacePanelId == LuaEnumFurnaceOpenType.TheSourceOfAttack) then
        equipIndex = Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA);
    elseif (furnacePanelId == LuaEnumFurnaceOpenType.ChyanLamp) then
        equipIndex = Utility.EnumToInt(CS.EEquipIndex.POS_LAMP);
    elseif (furnacePanelId == LuaEnumFurnaceOpenType.SoulBead) then
        equipIndex = Utility.EnumToInt(CS.EEquipIndex.POS_SOULJADE);
    end
    return equipIndex;
end

---创建全屏特效接口
---@param effectCode string 特效编码
---@param size UnityEngine.Vector3 特效大小
---@param pos UnityEngine.Vector3 位置
function Utility.ShowScreenEffect(effectCode, size, pos)
    ---@type UIScreenEffectPanel
    local effectPanel = uimanager:GetPanel('UIScreenEffectPanel')
    if effectPanel then
        effectPanel:Show(effectCode, size, pos)
    else
        uimanager:CreatePanel("UIScreenEffectPanel", nil, effectCode, size, pos)
    end
end

---移除全屏特效接口
function Utility.RemoveScreenEffect()
    uimanager:ClosePanel("UIScreenEffectPanel")
end

---显示气泡提示
---@param trans UnityEngine.GameObject|UnityEngine.Transform 按钮节点
---@param str string|nil 显示描述字符串,非nil则替换ID对应的提示内容
---@param id XLua.Cast.Int32 气泡Id
---@param dependPanel string|nil 依附于的界面名,非nil时将跟随界面关闭
function Utility.ShowPopoTips(trans, str, id, dependPanel, SecretBookTipsInfo)
    if CS.StaticUtility.IsNull(trans) or id == nil then
        return
    end
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.DependPanel] = dependPanel

    --推送判断
    if SecretBookTipsInfo ~= nil and SecretBookTipsInfo.itemid ~= nil then
        --是否有此物品的推送
        local isMeet, info = CS.Cfg_CheatPushManager.Instance:IsHasCheatPushOfItemID(SecretBookTipsInfo.itemid)
        if isMeet then
            TipsInfo[LuaEnumTipConfigType.ConfigTable] = info
            if not CS.StaticUtility.IsNull(SecretBookTipsInfo.Go) then
                TipsInfo[LuaEnumTipConfigType.Parent] = SecretBookTipsInfo.Go.transform
            end
            if (SecretBookTipsInfo.direction ~= nil) then
                TipsInfo[LuaEnumTipConfigType.Direction] = SecretBookTipsInfo.direction;
            end
            uimanager:CreatePanel("UISecretBookTipsPanel", nil, TipsInfo)
            return
        end
    end

    if not CS.StaticUtility.IsNullOrEmpty(str) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    TipsInfo[LuaEnumTipConfigType.Parent] = trans.transform

    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

---显示服务器气泡
---@param id Cfg_PromptFrame 通用id
---@param 文本 string
function Utility.ReceiveServerPromptTipsPanel(id, text)
    if id == nil then
        return
    end
    local isFind, promptInfo = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        local curText = text
        if CS.StaticUtility.IsNullOrEmpty(curText) == true then
            curText = promptInfo.content
        end
        if CS.StaticUtility.IsNullOrEmpty(promptInfo.panels) == false and CS.StaticUtility.IsNullOrEmpty(promptInfo.button) == false and CS.StaticUtility.IsNullOrEmpty(curText) == false then
            local commonData = {}
            commonData[LuaEnumTipConfigType.ConfigID] = id
            commonData[LuaEnumTipConfigType.Describe] = curText
            uimanager:CreatePanel("UIBubbleTipsPanel", nil, commonData)
        end
    end
end

function Utility.ShowBlackPopoTips(trans, str, id, dependPanel, SecretBookTipsInfo)
    if CS.StaticUtility.IsNull(trans) or id == nil then
        return
    end
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.DependPanel] = dependPanel
    if not CS.StaticUtility.IsNullOrEmpty(str) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    TipsInfo[LuaEnumTipConfigType.Parent] = trans.transform
    uimanager:CreatePanel("UIVoiceBubbleTipsPanel", nil, TipsInfo)
end

function Utility.ShowItemGetWayByData(data)
    if (data == nil or data.itemId == nil) then
        return ;
    end

    if (data.offset == nil) then
        data.offset = CS.UnityEngine.Vector2.zero;
    end
    if data.isRefreshHideItem == nil then
        data.isRefreshHideItem = true;
    end

    local customData = {};
    customData.itemId = data.itemId;
    customData.arrowDir = data.arrowType;
    customData.target = data.target;
    customData.offset = data.offset;
    customData.closeCallBack = data.closeCallBack;
    customData.dependPanel = data.dependPanel;
    customData.isRefreshHideItem = data.isRefreshHideItem;
    customData.isShowBox = data.isShowBox
    if (data.EntranceWay ~= nil) then
        customData.EntranceWay = data.EntranceWay
    end
    uimanager:CreatePanel("UIFurnaceWayAndBuyPanel", nil, customData);
end

function Utility.ShowItemGetWay(itemId, target, arrowType, offset, closeCallBack, EntranceWay, dependPanel, isRefreshHideItem)
    if (itemId == nil) then
        return ;
    end

    if (offset == nil) then
        offset = CS.UnityEngine.Vector2.zero;
    end
    if isRefreshHideItem == nil then
        isRefreshHideItem = true;
    end

    local customData = {};
    customData.itemId = itemId;
    customData.arrowDir = arrowType;
    customData.target = target;
    customData.offset = offset;
    customData.closeCallBack = closeCallBack;
    customData.dependPanel = dependPanel;
    customData.isRefreshHideItem = isRefreshHideItem;
    if (EntranceWay ~= nil) then
        customData.EntranceWay = EntranceWay
    end
    uimanager:CreatePanel("UIFurnaceWayAndBuyPanel", nil, customData);
end

function Utility.ShowGetWay(globalId, target, arrowType, offset, closeCallBack, EntranceWay, titleName, dependPanel)
    if (globalId == nil) then
        return ;
    end

    if (offset == nil) then
        offset = CS.UnityEngine.Vector2.zero;
    end

    local customData = {};
    customData.globalId = globalId;
    customData.arrowDir = arrowType;
    customData.target = target;
    customData.offset = offset;
    customData.closeCallBack = closeCallBack;
    customData.titleName = titleName;
    customData.dependPanel = dependPanel;
    if (EntranceWay ~= nil) then
        customData.EntranceWay = EntranceWay
    end
    uimanager:CreatePanel("UIFurnaceWayAndBuyPanel", nil, customData);
end

---根据way_get表ID的数组显示UIFurnaceWayAndBuyPanel界面
---@param wayGetArray table<number, number>
function Utility.ShowGetWayByWayGetArray(wayGetArray, target, arrowType, offset, closeCallBack, EntranceWay, titleName, dependPanel)
    if (wayGetArray == nil) then
        return ;
    end

    if (offset == nil) then
        offset = CS.UnityEngine.Vector2.zero;
    end

    local customData = {};
    customData.wayGetArray = wayGetArray;
    customData.arrowDir = arrowType;
    customData.target = target;
    customData.offset = offset;
    customData.closeCallBack = closeCallBack;
    customData.titleName = titleName;
    customData.dependPanel = dependPanel;
    if (EntranceWay ~= nil) then
        customData.EntranceWay = EntranceWay
    end
    uimanager:CreatePanel("UIFurnaceWayAndBuyPanel", nil, customData);
end

---检测是否符合自动推送
---@return isMeet boolean 是否符合
---@return info.id number 推送id
function Utility.CheckAutomaticCheatPush(itemid)
    --是否有此物品的推送，且是否符合推送限制
    local isMeet, info = CS.Cfg_CheatPushManager.Instance:IsHasCheatPushOfItemID(itemid)
    return isMeet, info.id
end

---显示推送 tuisong
---@field data tabel
---{
---@param data.id number cheatPush表Id
---@param data.dependPanel string 附着面板名称（必填）
---@param data.isNotCheckCondition boolean 是否强制推送显示(不判断限制，默认判断)
---@param data.direction  LuaEnumPromptframeDirectionType 方向（可不填）
---@param data.trans  GameObject 父物体（一般附着于面板，可不填）
---}
function Utility.ShowCheatPushTips(data)
    if data == nil then
        return false;
    end
    local isFind, info = CS.Cfg_CheatPushManager.Instance.dic:TryGetValue(data.id)
    if isFind then
        local TipsInfo = {}
        if data.isNotCheckCondition == nil or not data.isNotCheckCondition then
            local isMeet = CS.Cfg_CheatPushManager.Instance:IsMeetConditionOfId(data.id)
            if not isMeet then
                return false;
            end
        end

        if data.trans then
            TipsInfo[LuaEnumTipConfigType.Parent] = data.trans.transform
        end
        TipsInfo[LuaEnumTipConfigType.DependPanel] = data.dependPanel
        TipsInfo[LuaEnumTipConfigType.ConfigTable] = info
        TipsInfo[LuaEnumTipConfigType.Direction] = data.direction
        uimanager:CreatePanel("UISecretBookTipsPanel", nil, TipsInfo)
        return true;
    else
        if isOpenLog then
            luaDebug.Log("Error: id无对应cheatPush表内容")
        end
    end
    return false;
end

---退出副本二次确认提示
function Utility.ReqExitDuplicate()
    ---接收打断传送提示消息
    --二次弹框确认
    local isFind, showInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(63)
    if isFind then
        local data = {
            Title = showInfo.title == nil and '' or showInfo.title,
            Content = showInfo.des,
            CenterDescription = showInfo.leftButton,
            ID = 63,
            CallBack = function()
                networkRequest.ReqExitDuplicate(0)
            end
        }
        uimanager:CreatePanel("UIPromptPanel", nil, data)
    end
end

function Utility.GetStringLength(text)
    local count = 0
    local _, count = string.gsub(text, "[^\128-\193]", "")
    return count;
end

function Utility.GetPlayerHeadIconSpriteName(sex, career)
    return "headicon" .. sex .. career;
end

function Utility.GetRelationName(relationType, hasColor)
    if (hasColor == nil) then
        hasColor = false;
    end

    local value = "";
    if (relationType == LuaEnumSocialFriendRelationType.Spouse) then
        value = (hasColor and luaEnumColorType.Yellow or "") .. "夫妻";
    elseif (relationType == LuaEnumSocialFriendRelationType.Brother) then
        value = (hasColor and luaEnumColorType.White or "") .. "兄弟";
    end
    return value;
end
---@param nNum number 原数
---@param n    number 位数
---格式此原数的小数点后几位
function Utility.GetPreciseDecimal(nNum, n)
    if type(nNum) ~= "number" then
        return nNum;
    end
    n = n or 0;
    n = math.floor(n)
    if n < 0 then
        n = 0;
    end
    local nDecimal = 10 ^ n
    local nTemp = math.floor(nNum * nDecimal);
    local nRet = nTemp / nDecimal;
    return nRet;
end

---是否沙巴克活动期间修改任务面板显示
function Utility.IsSabacActivityChangeMissionPanel()
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        local isSabacActivity = Utility.IsOpenShaBaKe();
        --local isSabacActivity = CS.CSScene.MainPlayerInfo.DuplicateV2:IsOpenShaBaK()
        local isInShaBakMap = CS.CSScene.MainPlayerInfo:IsInShaBakMap();
        return isInShaBakMap and isSabacActivity
    end
    return false;
end

function Utility.IsOpenShaBaKe()
    local isSabacActivity = false;
    ---@type LuaActivityItem
    local activityItem = gameMgr:GetLuaActivityMgr():GetCalendarActivity(LuaEnumDailyActivityType.ShaBaKe)
    if (activityItem ~= nil) then
        local runningState, activitySubItem = activityItem:GetRunningState();
        isSabacActivity = runningState == LuaActivityRunningState.IsRunning;
    end
    return isSabacActivity;
end

---获得数字转万的字符串(800000 => 80万 大于6位数也就是十万才会转换)
function Utility.GetNumStr(num)
    if (num > 100000) then
        local valueStr;
        local value = num / 10000;
        if (value > 1000) then
            local v = value / 1000 - math.floor(value / 1000);
            local floorV = math.floor(v * 1000);
            local showValue = v > floorV and string.format('%.2f', v) or floorV;
            valueStr = math.floor(value / 1000) .. "," .. showValue .. "万";
        else
            local floorValue = math.floor(value);
            local showValue = value > floorValue and string.format('%.2f', value) or floorValue;
            valueStr = showValue .. "万";
        end
        return valueStr;
    end
    return tostring(num);
end

---PS:另外定一个数据类型真是。。。。

---@class UtilityPromptPanelInfo
---@field PromptWordId number 弹窗id
---@field des string 内容
---@field ComfireAucion function 确认回调
---@field CancelCallBack function 取消回调
---@field TimeEndCallBack function 时间结束回调
---@field CloseCallBack   function 点击关闭回调
---@field leftButton string 左按钮描述文字
---@field RightDescription string 右按钮描述文字
---@field CenterDescription string 中间按钮描述文字
---@field IsToggleVisable boolean 选项框是否可见
---@field isOpenToggleVisabel boolean 选项框是否选中
---@field OptionBtnCallBack function 选项框按钮回调
---@field visabelText       string    选项框文本
---@field Time              number   时间 单位毫秒
---@field IsShowCloseBtn    boolean  是否显示右上角关闭按钮
---@field InitCallBack      function 首次进入回调
---@field DestroyCallBack XLua.Cast.Int32 层级
---@field IsClose           boolean  点击确定是否关闭面板（默认关闭）
---@field IsShowGoldLabel   boolean  是否显示花费(默认不显示)
---@field GoldIcon          string   花费图片
---@field GoldCount         string   花费数量
---@field TimeText         string  倒计时文本格式
---@field listenArrestCode boolean 是否监听错误码
---@field timeLittleChangeColor boolean 时间过少是否修改颜色
---@field ID number 表数据id
---@field TimeType LuaEnumSecondComfirmTimeType 二次确认时间类型
---@field iconSpriteName string icon名字
---@field IconClickCallBack function 点击icon事件
---@field TimeCallBack function 倒计时回调
---@field ToggleStartState boolean 选择状态默认状态
---@field ToggleOnClick function 选择状态变更回调
---@field TimeColor string 倒计时颜色，默认红色

---二次确认面板显示
---@param commonData UtilityPromptPanelInfo
function Utility.ShowSecondConfirmPanel(commonData)
    local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(commonData.PromptWordId)
    if isFind then
        ---@type PromptPanelInfo
        local temp = {}
        temp.Content = string.format(string.gsub(commonData.des == nil and info.des or commonData.des, "\\n", '\n'), commonData.placeHolderData)
        temp.LeftDescription = info.leftButton
        temp.RightDescription = info.rightButton
        temp.CallBack = commonData.ComfireAucion
        temp.IsClose = ternary(commonData.IsClose == nil, true, commonData.IsClose)
        if CS.StaticUtility.IsNullOrEmpty(info.rightButton) == true then
            temp.CenterDescription = info.leftButton
        end
        temp.CancelCallBack = commonData.CancelCallBack
        temp.Time = commonData.Time
        temp.TimeText = commonData.TimeText
        temp.TimeEndCallBack = commonData.TimeEndCallBack
        temp.CloseCallBack = commonData.CloseCallBack
        temp.timeLittleChangeColor = ternary(commonData.timeLittleChangeColor == nil, true, commonData.timeLittleChangeColor)
        temp.ID = commonData.PromptWordId
        temp.TimeType = commonData.TimeType
        temp.TimeCallBack = commonData.TimeCallBack
        temp.iconSpriteName = commonData.iconSpriteName
        temp.IconClickCallBack = commonData.IconClickCallBack
        temp.ToggleStartState = commonData.ToggleStartState
        temp.ToggleOnClick = commonData.ToggleOnClick
        temp.TimeColor = commonData.TimeColor
        temp.itemGoldClickCallBack = commonData.itemGoldClickCallBack
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end

---通过PrompWordId获取二次确认面板参数
function Utility.GetSecondConfirmPanelParams(prompWordId)
    local commonData = {}
    local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(prompWordId)
    if isFind then
        commonData.Content = string.format(string.gsub(commonData.des == nil and info.des or commonData.des, "\\n", '\n'))
        commonData.LeftDescription = info.leftButton
        commonData.RightDescription = info.rightButton
    end
    return commonData
end

---显示帮助面板
---@param commonData {descriptionID:number}
function Utility.ShowHelpPanel(commonData)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(commonData.id)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

---请求进入副本（策划要求在请求进入副本前做二次确认处理，则另外开一个消息进行统一处理）
function Utility.ReqEnterDuplicate(duplicateId)
    ---在镖车活动中弹二次确认面板
    if uiStaticParameter.InCarAcitivity then
        Utility.ShowSecondConfirmPanel({ PromptWordId = LuaEnumSecondConfirmType.DortCar_EnterDuplicate, ComfireAucion = function()
            networkRequest.ReqEnterDuplicate(duplicateId)
        end })
        return
    end
    networkRequest.ReqEnterDuplicate(duplicateId)
end

---打开物品信息面板并检查婚戒（此方式打开的tips无右上角按钮）
function Utility.OpenItemInfoAndCheckMarryRing(bagItemInfo, rid, career)
    if bagItemInfo == nil then
        return
    end
    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId)
    if bagItemInfo ~= nil and itemInfoIsFind and CS.CSScene.MainPlayerInfo.EquipInfo:IsMarryRing(itemInfo) and bagItemInfo.index == LuaEnumEquiptype.WeddingRing then
        CS.CSScene.MainPlayerInfo.OtherPlayerInfo:ReqOtherPlayerMarryMsg(rid, LuaEnumOtherPlayerBtnType.MARRYRINGITEMINFO)
        return
    end
    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItemInfo, showRight = false, career = career, showAssistPanel = true, showMoreAssistData = true, showTabBtns = true, roleId = rid })
end

---获得日常任务按钮显示文本
function Utility.GetDailyTaskShowLabel(itemTable)
    if (itemTable ~= nil) then
        if (itemTable.type == luaEnumItemType.Material) then
            if (itemTable.subType == 1) then
                return "挖矿";
            elseif (itemTable.subType == 14) then
                return "钓鱼";
            elseif (itemTable.subType == 2) then
                return "挖肉";
            elseif (itemTable.subType == 3) then
                return "打怪";
            elseif (itemTable.subType == 15) then
                return "打怪";
            elseif (itemTable.subType == 4) then
                return "前往收集";
            end
        end
    end
    return "前往";
end

---是否是可穿戴的宝物
function Utility.IsCanEquippedGem(itemInfo, go)
    if itemInfo ~= nil and CS.CSScene.MainPlayerInfo.EquipInfo:IsGem(itemInfo) and CS.CSScene.MainPlayerInfo.BagInfo:GemIsCanEquiped(itemInfo) == false then
        if go ~= nil then
            if itemInfo.subType == LuaEnumEquiptype.Light then
                Utility.ShowPopoTips(go, nil, 213)
            elseif itemInfo.subType == LuaEnumEquiptype.SoulJade then
                Utility.ShowPopoTips(go, nil, 212)
            elseif itemInfo.subType == LuaEnumEquiptype.TheSecretTreasureOfYuanling then
                if CS.CSScene.MainPlayerInfo.BagInfo:CheckCompoundEquipIsCanEquiped(itemInfo, CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_JingGongZhiYuan) == false then
                    Utility.ShowPopoTips(go, nil, 215)
                elseif CS.CSScene.MainPlayerInfo.BagInfo:CheckCompoundEquipIsCanEquiped(itemInfo, CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShouHuZhiYuan) == false then
                    Utility.ShowPopoTips(go, nil, 216)
                end
            elseif itemInfo.subType == LuaEnumEquiptype.Baoshishoutao then
                Utility.ShowPopoTips(go, nil, 214)
            elseif itemInfo.subType == LuaEnumEquiptype.Medal then
                Utility.ShowPopoTips(go, nil, 100)
            elseif itemInfo.subType == LuaEnumEquiptype.DoubleMedal then
                Utility.ShowPopoTips(go, nil, 100)
            end
        end
        return false
    end
    return true
end

function Utility.SetScheduleColor(nowexp, maxExp)
    -- local color=luaEnumColorType.Red+luaEnumColorType.Gray+ luaEnumColorType.White
    local nowexpColor = ""
    local maxExpColor = ""
    local AllColor = luaEnumColorType.White
    if nowexp >= maxExp then
        AllColor = luaEnumColorType.Green
    end
    return AllColor .. nowexp .. '/' .. maxExp .. "[-]"
end

---获取需求数量文本显示内容（格式：1/100）
function Utility.GetNeedNumText(nowValue, nextValue)
    local curNowValue = Utility.GetBBCode(nowValue > 0 or nowValue >= nextValue) .. tostring(nowValue) .. "[-]"
    local curNextValue = Utility.GetGRCode(nowValue >= nextValue) .. tostring(nextValue) .. "[-]"
    return curNowValue .. '/' .. curNextValue
end

---Toggle隐藏背景图
function Utility.HideBackGround(uiToggle, backGroundName, state)
    if uiToggle == nil then
        return
    end
    local backGround = uiToggle.transform:Find(backGroundName)
    backGround.gameObject:SetActive(not state)
end

function Utility.GetDailyTaskTypeItemName(taskGoal)
    if (taskGoal == LuaEnumActiveGoalType.BlacksmithTask) then
        return "矿石"
    elseif (taskGoal == LuaEnumActiveGoalType.ButcherTask) then
        return "肉类"
    elseif (taskGoal == LuaEnumActiveGoalType.DruggistTask) then
        return "药材"
    elseif (taskGoal == LuaEnumActiveGoalType.FishermanTask) then
        return "鱼类"
    elseif (taskGoal == LuaEnumActiveGoalType.TrampTask) then
        return "橡树果"
    end
    return "材料";
end

function Utility.GetTaskTypeItemName(taskGoal)
    if (taskGoal == LuaEnumDailyTaskType.BlacksmithTask) then
        return "矿石"
    elseif (taskGoal == LuaEnumDailyTaskType.ButcherTask) then
        return "肉类"
    elseif (taskGoal == LuaEnumDailyTaskType.DruggistTask) then
        return "药材"
    elseif (taskGoal == LuaEnumDailyTaskType.FishermanTask) then
        return "鱼类"
    elseif (taskGoal == LuaEnumDailyTaskType.TrampTask) then
        return "橡树果"
    end
    return "材料";
end
--region Lua箭头获取
---获取箭头类型
---@param bagItemInfo bagV2.BagItemInfo lua的是数据结构
---@return LuaEnumArrowType 箭头类型 返回nil的时候,表示目前没有做处理,继续以前的旧逻辑
function Utility.GetArrowType_Lua(bagItemInfo)
    if (bagItemInfo == nil) then
        return nil
    end

    local isBetterItem = false
    local isCanUseItem = false
    ---@type TABLE.cfg_items
    local Lua_ItemTABLE = Utility.GetItemTblByBagItemInfo(bagItemInfo)

    if Lua_ItemTABLE == nil then
        return nil
    end

    if Lua_ItemTABLE:GetType() == luaEnumItemType.Collection then
        local collectionInfo = gameMgr:GetPlayerDataMgr():GetCollectionInfo()
        if collectionInfo == nil then
            return LuaEnumArrowType.NONE
        end
        if collectionInfo:IsMainPlayerCollectionOpened() == false then
            ---藏品系统未开启时,显示黄色箭头
            return LuaEnumArrowType.YellowArrow
        end
        local collectionTbl = clientTableManager.cfg_collectionManager:TryGetValue(Lua_ItemTABLE:GetId())
        if collectionTbl then
            ---处理藏品的箭头
            local sameCollectionInCabinet = collectionInfo:GetCollectionItemByCollectionID(Lua_ItemTABLE:GetId())
            if sameCollectionInCabinet ~= nil then
                if collectionInfo:IsLeftBetterThanRight(bagItemInfo, sameCollectionInCabinet:GetCollectionBagItem()) then
                    ---如果比藏品阁中同种藏品更好,那么显示绿色箭头,此处不用考虑黄色箭头
                    return LuaEnumArrowType.GreenArrow
                end
            else
                ---如果不能使用,那么显示黄色箭头
                isCanUseItem = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(bagItemInfo.itemId)
                if isCanUseItem ~= LuaEnumUseItemParam.CanUse then
                    return LuaEnumArrowType.YellowArrow
                end
                if collectionInfo:FetchSuitablePositionForCollection(collectionTbl) ~= nil then
                    --if collectionInfo:GetHistoryCollectionItems()[bagItemInfo.itemId] ~= true then
                    --    ---如果藏品阁中曾经装备过同类藏品,则不显示
                    --    return LuaEnumArrowType.GreenArrow
                    --end
                    return LuaEnumArrowType.GreenArrow
                end
            end
        end
        return LuaEnumArrowType.NONE
    end

    local divineId = Lua_ItemTABLE:GetDivineId()
    if (divineId ~= nil and divineId ~= 0 and Utility.GetDivineSuitTblByBagItemInfo(bagItemInfo) ~= nil) then
        --如果是神力装备,那么进入比较Lua比较
        isBetterItem, isCanUseItem = Utility.GetArrowTypeOfDivineSuit(bagItemInfo)
    else
        return nil
    end

    if isBetterItem == true then
        if isCanUseItem == LuaItemCanUseResult.CanUse then
            return LuaEnumArrowType.GreenArrow
        elseif (isCanUseItem == LuaItemCanUseResult.Sex) then
            --性别不符,直接不显示
            return LuaEnumArrowType.NONE
        else
            return LuaEnumArrowType.YellowArrow
        end
    else
        return LuaEnumArrowType.NONE
    end
end

---得到神力装备装备
---@param bagItemInfo bagV2.BagItemInfo lua的是数据结构
---@return number,number 是否比身上的更好,是否能用
function Utility.GetArrowTypeOfDivineSuit(bagItemInfo)
    local isBetterItem = false;
    local isCanUseItem = false;
    ---@type TABLE.cfg_items
    local Lua_ItemTABLE = Utility.GetItemTblByBagItemInfo(bagItemInfo)
    --神力装备
    ---@type TABLE.cfg_divinesuit
    local SuitTbl = Utility.GetDivineSuitTblByBagItemInfo(bagItemInfo)
    local type = 0
    local subType = 1
    if (SuitTbl ~= nil) then
        type = SuitTbl:GetType();
        subType = SuitTbl:GetSubType()
    end
    ---@type LuaPlayerEquipmentListData
    local LuaPlayerEquipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(type, subType)

    local index = Utility.GetSLEquipIndex(type, Lua_ItemTABLE:GetSubType())
    ---@type LuaEquipDataItem
    local EquipDataItem = LuaPlayerEquipmentListData:GetEquipItem(index)
    --这个装备位是空的
    if (EquipDataItem == nil or EquipDataItem.BagItemInfo == nil) then
        isBetterItem = true

    else
        ---@type LuaMainPlayerEquipMgr
        local MainPlayerEquipMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr()
        isBetterItem = MainPlayerEquipMgr:IsBetterEquipThanEquipped(bagItemInfo)
    end
    ---@type LuaMainPlayerBagMgr
    local MainPlayerBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    isCanUseItem = MainPlayerBagMgr:IsCanUseItem(bagItemInfo)

    return isBetterItem, isCanUseItem
end
--endregion

---获取箭头类型
---@param bagItemInfo bagV2.BagItemInfo C#的是数据结构
---@param isCompareFloatAttribute bagV2.BagItemInfo C#的是数据结构
---@return LuaEnumArrowType 箭头类型
function Utility.GetArrowType(bagItemInfo, isCompareFloatAttribute)
    if bagItemInfo == nil then
        return LuaEnumArrowType.NONE
    end

    if (isCompareFloatAttribute == nil) then
        isCompareFloatAttribute = true
    end

    -----@type LuaMainPlayerBagMgr
    --local MainPlayerBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    --local lua_bagItemInfo = MainPlayerBagMgr:GetBagItemData(bagItemInfo.lid)
    --
    --print(type(bagItemInfo))
    local state = Utility.GetArrowType_Lua(bagItemInfo)
    if (state ~= nil) then
        return state
    end

    local servantPanel = uimanager:GetPanel("UIServantPanel")
    local rolePanel = uimanager:GetPanel("UIRolePanel")

    local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2

    local isBetterItem = false
    local isCanUseItem = false

    ---这个道具是否是正常的灵兽装备
    if CS.CSServantInfoV2.IsServantEquip(bagItemInfo) then
        local servantType = 0
        if servantPanel then
            servantType = servantPanel:GetSelectHeadInfo():GetServantType()
            isBetterItem = servantInfo:IsShowBetterArrowInBag(bagItemInfo, bagItemInfo.ItemTABLE, servantType)
            isCanUseItem = servantInfo:ServantIsCanEquip(bagItemInfo, servantType)
        elseif CS.CSServantInfoV2.IsServantCommonBody(bagItemInfo.ItemTABLE.subType) then
            ---通用灵兽肉身专属一套自己的箭头判断逻辑
            return Utility.EnumToInt(CS.Utility_Lua.GetCommonServantBodyArrowType(bagItemInfo))
        else
            return Utility.GetArrowTypeByRoleAndAllServant(servantInfo, bagItemInfo);
        end
    elseif CS.CSServantInfoV2.isServantEgg(bagItemInfo.ItemTABLE) then
        ---灵兽蛋
        isCanUseItem = CS.Utility_Lua.ItemCanUseItem(bagItemInfo)
        if servantPanel then
            local bodyServantBagItemInfo = servantInfo:GetServentIndexByDic(uiStaticParameter.SelectedServantType)
            if bodyServantBagItemInfo == nil or bodyServantBagItemInfo.servantEgg == nil then
                isBetterItem = true
            else
                isBetterItem = servantInfo:CompareServant(bagItemInfo, bodyServantBagItemInfo.servantEgg) == -1
            end
        else
            isBetterItem = CS.Utility_Lua.IsBetterItem(bagItemInfo, false, isCompareFloatAttribute)
        end
    elseif CS.CSScene.MainPlayerInfo.SignetV2:IsSignet(bagItemInfo) then
        return CS.CSScene.MainPlayerInfo.SignetV2:SignetUseType(bagItemInfo)
    elseif bagItemInfo.ItemTABLE.type == luaEnumItemType.HunJi then
        if servantPanel ~= nil then
            local state = Utility.GetArrowTypeBySingleServantHunJi(servantInfo, servantPanel.ServantIndex + 1, bagItemInfo);
            if (state ~= nil) then
                return state;
            end
        else
            return Utility.GetArrowTypeByAllServantHunJi(servantInfo, bagItemInfo);
        end
    elseif clientTableManager.cfg_itemsManager:IsMagicEquip(bagItemInfo.itemId) then
        isCanUseItem = clientTableManager.cfg_itemsManager:CanUseMagicEquip(bagItemInfo.itemId) == LuaEnumUseItemParam.CanUse
        isBetterItem = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():CheckMagicEquipBetterThanBody(bagItemInfo)
    elseif clientTableManager.cfg_itemsManager:IsZhenFaEquip(bagItemInfo.itemId) then
        isCanUseItem = Utility.FaZhenEquipCanEquiped(bagItemInfo.itemId) == LuaEnumUseItemParam.CanUse
        isBetterItem = Utility.ZhenFaEquipIsBetterThenBody(bagItemInfo)
    else
        if (bagItemInfo.ItemTABLE.type == luaEnumItemType.Equip and bagItemInfo.ItemTABLE.subType == LuaEnumEquipSubType.Equip_seal) then
            local info = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.ItemTABLE.id)
            if (info ~= nil) then
                local isOpen = uimanager:IsOpenWithKey(info:GetConditions().list[1]);
                isCanUseItem = isOpen
                local LuaPlayerEquipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(LuaEquipmentListType.Base)
                ---@type LuaEquipDataItem
                local EquipDataItem = LuaPlayerEquipmentListData:GetEquipItemByBasicIndex(LuaEquipmentItemType.POS_SEAL)
                if (EquipDataItem == nil or EquipDataItem.ItemTbl == nil) then
                    isBetterItem = true
                else
                    if (EquipDataItem.ItemTbl:GetItemLevel() >= bagItemInfo.ItemTABLE.itemLevel) then
                        isBetterItem = false
                    else
                        isBetterItem = true
                    end
                end
            end
        elseif (bagItemInfo.ItemTABLE.type == luaEnumItemType.Equip and bagItemInfo.ItemTABLE.subType == LuaEnumEquipSubType.Equip_AnQi) then
            isCanUseItem, isBetterItem = Utility.GetArrowType_AnQi(bagItemInfo)
        elseif (bagItemInfo.ItemTABLE.type == luaEnumItemType.Equip and bagItemInfo.ItemTABLE.subType == LuaEnumEquipSubType.Equip_maPai) then
            isCanUseItem, isBetterItem = Utility.GetArrowType_MaPai(bagItemInfo)
        else
            if (bagItemInfo.ItemTABLE.type == luaEnumItemType.Equip and CS.CSServantInfoV2.IsServantRoleEquip(bagItemInfo.ItemTABLE.subType) == true) then
                --接下来就是人物的正常装备处理
                if (rolePanel) then
                    --1.当人物面板打开的时候,只比对人物身上的
                    --在上面一开始就比对好了
                    isBetterItem = CS.Utility_Lua.IsBetterItem(bagItemInfo, false)
                    isCanUseItem = CS.Utility_Lua.ItemCanUseItem(bagItemInfo)
                elseif (servantPanel and CS.CSServantInfoV2.IsServantRoleEquip(bagItemInfo.ItemTABLE.subType)) then
                    --打开了灵兽面板.并这个道具是灵兽可以穿的人物装备
                    local servantType = servantPanel:GetSelectHeadInfo():GetServantType()
                    isBetterItem = servantInfo:IsShowBetterArrowInBag(bagItemInfo, bagItemInfo.ItemTABLE, servantType, true)
                    isCanUseItem = servantInfo:ServantIsCanEquip(bagItemInfo, servantType)
                else
                    return Utility.GetArrowTypeByRoleAndAllServant(servantInfo, bagItemInfo);
                end
            else
                isBetterItem = CS.Utility_Lua.IsBetterItem(bagItemInfo, false)
                isCanUseItem = CS.Utility_Lua.ItemCanUseItem(bagItemInfo)
            end
        end

    end
    if isBetterItem == true then
        if isCanUseItem then
            return LuaEnumArrowType.GreenArrow
        else
            return LuaEnumArrowType.YellowArrow
        end
    else
        return LuaEnumArrowType.NONE
    end
end

---获取箭头类型_暗器
---@param bagItemInfo bagV2.BagItemInfo C#的是数据结构
---@return LuaEnumArrowType 箭头类型
function Utility.GetArrowType_AnQi(bagItemInfo)
    local isCanUseItem = false
    local isBetterItem = false
    local info = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.ItemTABLE.id)
    local anqiInfo_bag = clientTableManager.cfg_hidden_weaponManager:TryGetValue(bagItemInfo.ItemTABLE.id)
    if (info ~= nil and anqiInfo_bag ~= nil) then
        local limitIDList = LuaGlobalTableDeal.GetMaPaiOpenLimit()
        local isOpenSystem = Utility.IsOpenSystem(limitIDList)
        local matchCondition = Utility.IsMainPlayerMatchCondition(info:GetConditions().list[1])
        isCanUseItem = matchCondition.success and isOpenSystem
        local LuaPlayerEquipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(LuaEquipmentListType.Base)
        ---@type LuaEquipDataItem
        local EquipDataItem = LuaPlayerEquipmentListData:GetEquipItemByBasicIndex(LuaEquipmentItemType.POS_AnQi)
        if (EquipDataItem == nil or EquipDataItem.ItemTbl == nil) then
            isBetterItem = true
        else
            local anqiInfo_equip = clientTableManager.cfg_hidden_weaponManager:TryGetValue(EquipDataItem.ItemTbl.id)
            if anqiInfo_equip ~= nil and (anqiInfo_equip:GetStage() < anqiInfo_bag:GetStage()) then
                isBetterItem = true
            else
                isBetterItem = false
            end
        end
    end
    return isCanUseItem, isBetterItem
end

---获取箭头类型_马牌
---@param bagItemInfo bagV2.BagItemInfo C#的是数据结构
---@return LuaEnumArrowType 箭头类型
function Utility.GetArrowType_MaPai(bagItemInfo)
    local isCanUseItem = false
    local isBetterItem = false
    local info = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.ItemTABLE.id)
    local anqiInfo_bag = clientTableManager.cfg_horse_cardManager:TryGetValue(bagItemInfo.ItemTABLE.id)
    if (info ~= nil and anqiInfo_bag ~= nil) then
        local limitIDList = LuaGlobalTableDeal.GetMaPaiOpenLimit()
        local isOpenSystem = Utility.IsOpenSystem(limitIDList)
        local matchCondition = Utility.IsMainPlayerMatchCondition(info:GetConditions().list[1])
        isCanUseItem = matchCondition.success and isOpenSystem
        local LuaPlayerEquipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(LuaEquipmentListType.Base)
        ---@type LuaEquipDataItem
        local EquipDataItem = LuaPlayerEquipmentListData:GetEquipItemByBasicIndex(LuaEquipmentItemType.POS_MaPai)
        if (EquipDataItem == nil or EquipDataItem.ItemTbl == nil) then
            isBetterItem = true
        else
            local anqiInfo_equip = clientTableManager.cfg_horse_cardManager:TryGetValue(EquipDataItem.ItemTbl.id)
            if anqiInfo_equip ~= nil and (anqiInfo_equip:GetStage() < anqiInfo_bag:GetStage()) then
                isBetterItem = true
            else
                isBetterItem = false
            end
        end
    end
    return isCanUseItem, isBetterItem
end

---检测所有灵兽,返回指定道具是否比灵兽身上的魂继装备好
---@param servantInfo 人物灵兽信息
---@param bagItemInfo 目标道具
---@return LuaEnumArrowType 箭头类型
function Utility.GetArrowTypeBySingleServantHunJi(servantInfo, servantSeatType, bagItemInfo)
    ---@type CSServantSeatData_MainPlayer
    local seatData = servantInfo.MainPlayerServantData:GetServantSeatData(servantSeatType)
    if seatData ~= nil then
        if seatData.HunJi.HunJiMaxGridCount == 0 or seatData:IsHunJiBagItemInfoBetterToEquipInServantSeat(bagItemInfo, false) then
            local res, reason = seatData:IsHunJiAvailableToEquipInSeat(bagItemInfo)
            if res then
                return LuaEnumArrowType.GreenArrow
            else
                return LuaEnumArrowType.YellowArrow
            end
        else
            return LuaEnumArrowType.NONE
        end
    end
    return nil
end

---检测所有灵兽,返回指定道具是否比灵兽身上的魂继装备好
---@param servantInfo 人物灵兽信息
---@param bagItemInfo 目标道具
---@return LuaEnumArrowType 箭头类型
function Utility.GetArrowTypeByAllServantHunJi(servantInfo, bagItemInfo)
    ---@type CSServantData_MainPlayer
    local mainPlayerServantData = servantInfo.MainPlayerServantData
    local showGreenOrYellowLevel = 0
    local hunjiServantSeatType = bagItemInfo.ItemTABLE.subType
    --local testItemName = "[00FF00]神·屠夫[-]"
    -----寒芒位判定
    --if bagItemInfo.ItemTABLE.name == testItemName then
    --    print("beginning showGreenOrYellowLevel", showGreenOrYellowLevel)
    --end
    if mainPlayerServantData.HanMangSeatData.State ~= CS.CSServantSeatData.SeatState.Locked and (hunjiServantSeatType == 0 or hunjiServantSeatType == luaEnumServantSeatType.HM) then
        if mainPlayerServantData.HanMangSeatData.HunJi.HunJiMaxGridCount == 0 or mainPlayerServantData.HanMangSeatData:IsHunJiBagItemInfoBetterToEquipInServantSeat(bagItemInfo, false) then
            if mainPlayerServantData.HanMangSeatData:IsHunJiAvailableToEquipInSeat(bagItemInfo) then
                showGreenOrYellowLevel = 2
            else
                showGreenOrYellowLevel = 1
            end
        else
            showGreenOrYellowLevel = 0
        end
    end
    --if bagItemInfo.ItemTABLE.name == testItemName then
    --    print("hanmang check showGreenOrYellowLevel", showGreenOrYellowLevel)
    --end
    ---落星位判定
    if mainPlayerServantData.LuoXingSeatData.State ~= CS.CSServantSeatData.SeatState.Locked and (hunjiServantSeatType == 0 or hunjiServantSeatType == luaEnumServantSeatType.LX) then
        if mainPlayerServantData.LuoXingSeatData.HunJi.HunJiMaxGridCount == 0 or mainPlayerServantData.LuoXingSeatData:IsHunJiBagItemInfoBetterToEquipInServantSeat(bagItemInfo, false) then
            if mainPlayerServantData.LuoXingSeatData:IsHunJiAvailableToEquipInSeat(bagItemInfo) then
                ---有任意一个灵兽需要显示绿色箭头，则显示绿色箭头
                showGreenOrYellowLevel = 2
            else
                if showGreenOrYellowLevel ~= 2 then
                    showGreenOrYellowLevel = 1
                end
            end
        else
            if showGreenOrYellowLevel ~= 2 then
                ---不显示绿色箭头时，如果有任意一个位置不需要显示箭头，则不显示黄色箭头
                showGreenOrYellowLevel = 0
            end
        end
    end
    --if bagItemInfo.ItemTABLE.name == testItemName then
    --    print("luoxing check showGreenOrYellowLevel", showGreenOrYellowLevel)
    --end
    ---天成位判定
    if mainPlayerServantData.TianChengSeatData.State ~= CS.CSServantSeatData.SeatState.Locked and (hunjiServantSeatType == 0 or hunjiServantSeatType == luaEnumServantSeatType.TC) then
        if mainPlayerServantData.TianChengSeatData.HunJi.HunJiMaxGridCount == 0 or mainPlayerServantData.TianChengSeatData:IsHunJiBagItemInfoBetterToEquipInServantSeat(bagItemInfo, false) then
            if mainPlayerServantData.TianChengSeatData:IsHunJiAvailableToEquipInSeat(bagItemInfo) then
                ---有任意一个灵兽需要显示绿色箭头，则显示绿色箭头
                showGreenOrYellowLevel = 2
            else
                if showGreenOrYellowLevel ~= 2 then
                    showGreenOrYellowLevel = 1
                end
            end
        else
            if showGreenOrYellowLevel ~= 2 then
                ---不显示绿色箭头时，如果有任意一个位置不需要显示箭头，则不显示黄色箭头
                showGreenOrYellowLevel = 0
            end
        end
    end
    --if bagItemInfo.ItemTABLE.name == testItemName then
    --    print("tiancheng check showGreenOrYellowLevel", showGreenOrYellowLevel)
    --end
    ---判定绿色还是黄色还是空
    if showGreenOrYellowLevel == 2 then
        return LuaEnumArrowType.GreenArrow
    elseif showGreenOrYellowLevel == 1 then
        return LuaEnumArrowType.YellowArrow
    else
        return LuaEnumArrowType.NONE
    end
end

---检测所有灵兽以及人物装备,判定比穿戴着的更好
function Utility.GetArrowTypeByRoleAndAllServant(servantInfo, bagItemInfo)
    local finishState = LuaEnumArrowType.NONE

    --在没有灵兽/角色面板的情况下,按照 人物->灵兽位1->灵兽位2->灵兽位3 只要其中一个为绿色箭头  就跳出
    local isBetterItem = CS.Utility_Lua.IsBetterItem(bagItemInfo, false)
    local isCanUseItem = false
    if (isBetterItem == true) then
        --如果比人物身上的好,那么看看内不能用
        isCanUseItem = CS.Utility_Lua.ItemCanUseItem(bagItemInfo)
        if (isCanUseItem) then
            finishState = LuaEnumArrowType.GreenArrow;
            return LuaEnumArrowType.GreenArrow
        else
            finishState = LuaEnumArrowType.YellowArrow;
        end
    end
    --如果这个道具灵兽不能穿戴,那么到此为止
    if (CS.CSServantInfoV2.IsServantRoleEquip(bagItemInfo.ItemTABLE.subType) == false) then
        return finishState;
    end

    local state = Utility.GetIsBetterThanServant(servantInfo, bagItemInfo, 1);
    if (state == LuaEnumArrowType.GreenArrow) then
        return LuaEnumArrowType.GreenArrow
    end

    state = Utility.GetIsBetterThanServant(servantInfo, bagItemInfo, 2);
    if (state == LuaEnumArrowType.GreenArrow) then
        return LuaEnumArrowType.GreenArrow
    end

    state = Utility.GetIsBetterThanServant(servantInfo, bagItemInfo, 3);
    if (state == LuaEnumArrowType.GreenArrow) then
        return LuaEnumArrowType.GreenArrow
    end

    return finishState;
end

---判定装备对比灵兽指定位的装备
---如果当前的状态比传入的finishState状态更高一级
function Utility.GetIsBetterThanServant(servantInfo, bagItemInfo, servantType)
    local isBetterItem = servantInfo:IsShowBetterArrowInBag(bagItemInfo, bagItemInfo.ItemTABLE, servantType)
    local isCanUseItem = false
    if (isBetterItem) then
        isCanUseItem = servantInfo:ServantIsCanEquip(bagItemInfo, servantType)
        if (isCanUseItem) then
            return LuaEnumArrowType.GreenArrow
        else
            return LuaEnumArrowType.YellowArrow
        end
    else
        return LuaEnumArrowType.NONE
    end
end

---@return LuaEnumEquipTargetType 装备的目标
function Utility.GetEquipTargetType(bagItemInfo)
    if (bagItemInfo == nil) then
        return LuaEnumEquipTargetType.None
    end

    ---目前只有部分灵兽可以穿戴的装备需要特殊处理
    if (CS.CSServantInfoV2.IsServantRoleEquip(bagItemInfo.ItemTABLE.subType) == true) then
        local servantPanel = uimanager:GetPanel("UIServantPanel")
        if (servantPanel) then
            --灵兽面板开着的时候,根据所选的灵兽类型进行替换装备
            local type = servantPanel:GetSelectHeadInfo():GetServantType();
            if (type == 1) then
                return LuaEnumEquipTargetType.Servant_1
            elseif (type == 2) then
                return LuaEnumEquipTargetType.Servant_2
            elseif (type == 3) then
                return LuaEnumEquipTargetType.Servant_3
            end
        end
        --如果人物开着,那么穿戴到人物上(即和以前一样)
        local rolePanel = uimanager:GetPanel("UIRolePanel")
        if (rolePanel) then
            return LuaEnumEquipTargetType.None;
        end
        --如果灵兽/人物都没有开
        --那么就按照优先级
        local isBetterItem = CS.Utility_Lua.IsBetterItem(bagItemInfo, false)
        local isCanUse = false
        if (isBetterItem) then
            isCanUse = CS.Utility_Lua.ItemCanUseItem(bagItemInfo)
            if (isCanUse) then
                return LuaEnumEquipTargetType.None
            end
        end

        local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2
        local bagInfo, badBodyServantInfo, index = servantInfo:GetBadEquipOnServantBySubtype(bagItemInfo.ItemTABLE, false, true, true)
        if (index == nil) then
            return LuaEnumArrowType.NONE;
        end
        local type = math.floor(index / 1000);
        if (type == 1) then
            return LuaEnumEquipTargetType.Servant_1
        elseif (type == 2) then
            return LuaEnumEquipTargetType.Servant_2
        elseif (type == 3) then
            return LuaEnumEquipTargetType.Servant_3
        end
    end
    return LuaEnumEquipTargetType.None;
end

---显示不关闭气泡
---@param trans UnityEngine.GameObject 按钮节点
---@param id XLua.Cast.Int32 气泡Id
function Utility.ShowDisplayPopoTips(trans, id, ...)
    if CS.StaticUtility.IsNull(trans) or id == nil then
        return
    end
    uimanager:CreatePanel("UIDisplayBubbleTipsPanel", nil, trans, id, true, ...)
end

---解析其他玩家数据（将服务器数据解析为面板必要的customData数据）
function Utility.AnalysisOtherPlayerInfo(type, subType)
    local customData = {}
    if type == LuaEnumOtherPlayerBtnType.ROLE then
        ---其他玩家数据
        ---@type roleV2.RoleToOtherInfo
        local data = CS.CSScene.MainPlayerInfo.OtherPlayerInfo.OtherRoleInfo
        if data then
            local player = CS.CSScene.Sington:getAvatar(data.roleId)

            ---region 特殊装备列表
            if (data.extraEquipList ~= nil) then
                customData.ExtraEquipList = data.extraEquipList;
            end
            --endregion

            --region 称谓
            if (data.appellation ~= nil) then
                customData.appellation = data.appellation;
            end
            --endregion

            --if player ~= nil then
            --    customData.avatarInfo = player.BaseInfo
            --    customData.monthCard = data.monthCard
            --else
            if data.roleId then
                --如果是离线玩家
                local ESex = {};
                ESex[LuaEnumSex.WoMan] = CS.ESex.WoMan
                ESex[LuaEnumSex.Man] = CS.ESex.Man
                ESex[LuaEnumSex.Common] = CS.ESex.Common;

                local ECareer = {};
                ECareer[LuaEnumCareer.Common] = CS.ECareer.Common;
                ECareer[LuaEnumCareer.Taoist] = CS.ECareer.Taoist;
                ECareer[LuaEnumCareer.Master] = CS.ECareer.Master;
                ECareer[LuaEnumCareer.Warrior] = CS.ECareer.Warrior;
                ECareer[LuaEnumCareer.Assassin] = CS.ECareer.Assassin;
                ECareer[LuaEnumCareer.CunMin] = CS.ECareer.CunMin;
                local luaOtherRoleInfo = gameMgr:GetOtherPlayerDataMgr().RoleToOtherInfo
                local avatarInfo = {};
                avatarInfo.SealMarkId = luaOtherRoleInfo.sealMarkId
                avatarInfo.Name = data.roleName;
                avatarInfo.UIUnionName = data.unionName
                avatarInfo.officialPosistionId = data.officialPosistionId
                avatarInfo.Sex = ESex[data.sex];
                avatarInfo.Career = ECareer[data.career];
                if data.armor and data.armor ~= 0 then
                    avatarInfo.BodyModel = CS.Cfg_ItemsTableManager.Instance:GetItems(data.armor).model.list[0]
                else
                    avatarInfo.BodyModel = data.armor
                end
                if data.weapon and data.weapon ~= 0 then
                    avatarInfo.Weapon = CS.Cfg_ItemsTableManager.Instance:GetItems(data.weapon).model.list[0]
                else
                    avatarInfo.Weapon = data.weapon
                end
                if data.shield and data.shield ~= 0 then
                    avatarInfo.shield = CS.Cfg_ItemsTableManager.Instance:GetItems(data.shield).model.list[0]
                else
                    avatarInfo.shield = data.shield
                end
                if data.bambooHat and data.bambooHat ~= 0 then
                    avatarInfo.bambooHat = CS.Cfg_ItemsTableManager.Instance:GetItems(data.bambooHat).model.list[0]
                else
                    avatarInfo.bambooHat = data.bambooHat
                end
                if data.helmet and data.helmet ~= 0 then
                    avatarInfo.Hair = 301000
                    local hairModel = CS.Cfg_ItemsTableManager.Instance:GetItems(data.helmet).model
                    if hairModel.list ~= nil and hairModel.list.Count == 1 then
                        avatarInfo.Hair = hairModel.list[0]
                    elseif hairModel.list ~= nil and hairModel.list.Count == 2 then
                        avatarInfo.Hair = hairModel.list[data.sex - 1]
                    end
                else
                    avatarInfo.Hair = data.helmet
                end
                if data.face and data.face ~= 0 then
                    avatarInfo.Face = 0
                    local faceModel = CS.Cfg_ItemsTableManager.Instance:GetItems(data.face).model
                    if faceModel.list ~= nil and faceModel.list.Count == 1 then
                        avatarInfo.Face = faceModel.list[0]
                    elseif faceModel.list ~= nil and faceModel.list.Count == 2 then
                        avatarInfo.Face = faceModel.list[data.sex - 1]
                    end
                    ---此处因为面巾在角色界面中的点击是单独处理的,故再传一个FaceItemID过去以便点击
                    avatarInfo.FaceItemID = data.face
                else
                    avatarInfo.FaceItemID = 0
                    avatarInfo.Face = 0
                end
                if data.wearPosition ~= nil then
                    for i = 1, data.wearPosition.Count do
                        ---@type appearanceV2.wearPosition
                        local wearPos = data.wearPosition[i - 1]
                        local index = wearPos.index
                        local itemID = wearPos.id
                        ---@type TABLE.CFG_ITEMS
                        local itemTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(itemID)
                        if itemTbl ~= nil and itemTbl.appearanceId ~= 0 then
                            local appearanceID = itemTbl.appearanceId
                            ---@type TABLE.CFG_APPEARANCE
                            local appearanceTblExist, appearanceTbl = CS.Cfg_AppearanceTableManager.Instance:TryGetValue(appearanceID)
                            if appearanceTbl ~= nil and appearanceTbl.model ~= nil and appearanceTbl.model.list ~= nil
                                    and appearanceTbl.model.list.Count > 0 then
                                local modelID = appearanceTbl.model.list[0]
                                if appearanceTbl.model.list.Count > 1 then
                                    ---有2个时,男性#女性
                                    if data.sex ~= LuaEnumSex.Man then
                                        modelID = appearanceTbl.model.list[1]
                                    end
                                end
                                if index == 1 and modelID ~= 0 then
                                    avatarInfo.Weapon = modelID
                                elseif index == 2 and modelID ~= 0 then
                                    avatarInfo.Hair = modelID
                                elseif index == 3 and modelID ~= 0 then
                                    avatarInfo.BodyModel = modelID
                                end
                            end
                        end
                    end
                end
                if data.monthCard then
                    customData.monthCard = data.monthCard
                end
                if data.vipLevel then
                    customData.vipLevel = data.vipLevel
                end
                avatarInfo.GetWeaponModelID = function(info)
                    if info == nil or info.Weapon == nil then
                        return 0
                    end
                    return info.Weapon
                end
                avatarInfo.GetBodyModelID = function(info)
                    if info == nil or info.BodyModel == nil then
                        return 0
                    end
                    return info.BodyModel
                end
                avatarInfo.GetHairModelID = function(info)
                    if info == nil or info.Hair == nil then
                        return 0
                    end
                    return info.Hair
                end
                avatarInfo.GetFaceModelID = function(info)
                    if info == nil or info.Face == nil then
                        return 0
                    end
                    return info.Face
                end
                avatarInfo.GetDouLiModelID = function(info)
                    if info == nil or info.bambooHat == nil then
                        return 0
                    end
                    return info.bambooHat
                end
                avatarInfo.GetLeftWeaponModelID = function(info)
                    if info == nil or info.shield == nil then
                        return 0
                    end
                    return info.shield
                end
                avatarInfo.GetShowDouLiModelID = function(info)
                    if info == nil or info.bambooHat == nil then
                        return 0
                    end
                    return info.bambooHat
                end
                avatarInfo.GetShowLeftWeaponModelID = function(info)
                    if info == nil or info.shield == nil then
                        return 0
                    end
                    return info.shield
                end

                customData.avatarInfo = avatarInfo;
            else
                customData.avatarInfo = nil
            end
            --end
        else
            customData.avatarInfo = nil
        end
        local equipInfo = {}
        if data.equipList and data.equipList.Count > 0 then
            for i = 0, data.equipList.Count - 1 do
                equipInfo[data.equipList[i].index] = data.equipList[i]
            end
        end
        if data.marryInfo then
            customData.marryInfo = data.marryInfo
            equipInfo[LuaEnumEquiptype.WeddingRing] = CS.CSScene.MainPlayerInfo.EquipInfo:ReverseMarryRing(data.marryInfo)
        end
        customData.equipInfo = equipInfo;
        customData.equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateOtherPlayer
        customData.equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateOtherPlayer
    elseif type == LuaEnumOtherPlayerBtnType.SERVANT then
        local data = CS.CSScene.MainPlayerInfo.OtherPlayerInfo.OtherServantsInfo
        customData.openServantPanelType = LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant
        customData.OtherServantList = data
        local pos = nil
        if subType ~= nil then
            if subType == LuaEnumOtherPlayerBtnSubtype.SERVANT_HANMANG then
                pos = luaEnumServantType.HM
            elseif subType == LuaEnumOtherPlayerBtnSubtype.SERVANT_LUOXING then
                pos = luaEnumServantType.LX
            elseif subType == LuaEnumOtherPlayerBtnSubtype.SERVANT_TIANCHENG then
                pos = luaEnumServantType.TC
            end
        end
        customData.pos = pos
    end
    return customData
end

---跳转灵兽界面并打开背包
function Utility.TransferServantPanelOpenBag(bodyEquipIndex, bagItemInfo)
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return
    end
    local servantInfoV2 = mainPlayerInfo.ServantInfoV2
    if servantInfoV2 == nil then
        return
    end

    local canTransfer = servantInfoV2:BodyEquipToShowBaseServantPanel(bagItemInfo) ~= -1
    if canTransfer then
        if bodyEquipIndex == 4 then
            bodyEquipIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantTypeOfWeakestBodyEquip(bagItemInfo)
        end
        ---跳转
        if (bodyEquipIndex == 1) then
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM);
        elseif (bodyEquipIndex == 2) then
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_LX);
        elseif (bodyEquipIndex == 3) then
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_TC);
        else
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM);
        end
    end
end

---地图变换或切换位置后操作
---@param commonData.deliverId
---@param commonData.x
---@param commonData.y
function Utility.ChangeMapOrPosOpereation(commonData)
    if commonData == nil or commonData.deliverId == nil then
        return
    end
    local x = ternary(commonData.x == nil, 0, commonData.x)
    local y = ternary(commonData.y == nil, 0, commonData.y)
    ---商会
    if (commonData.deliverId == 10003 or commonData.deliverId == 10004) and CS.Cfg_DeliverTableManager.Instance:IsConfigParams(commonData.deliverId, x, y) and CS.CSScene.MainPlayerInfo.MonthCardInfo:IsHasGetMonthCard() == true then
        uimanager:CreatePanel("UICommerceAdministratorPanel")
    end
end

---显示通用弹窗
---@class PromptTipData
---@field id number Cfg_PromptWord表通用id (必填)
---@field str string 显示内容
---@field Callback function 点击回调 (必填)
------
---@param customData PromptTipData
---@return boolean 是否可创建
function Utility.ShowPromptTipsPanel(customData)
    if customData then
        local isFind, promptInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(customData.id)
        if isFind then
            local temp = {}
            temp.Content = customData.str == nil and promptInfo.des or customData.str
            temp.Title = promptInfo.title
            -- [878787][e85038]%s[-]的帮主[e85038]%s[-]申请与本帮主合并，是否同意？
            temp.LeftDescription = promptInfo.leftButton
            temp.RightDescription = promptInfo.rightButton
            temp.CallBack = customData.Callback
            temp.ID = customData.id
            temp.CancelCallBack = customData.CancelCallBack;
            temp.IsToggleVisable = customData.IsToggleVisable--是否显示toggle
            temp.OptionBtnCallBack = customData.OptionBtnCallBack--toggle回调
            temp.visabelText = customData.visabelText--toggle文本
            temp.IsShowGoldLabel = customData.IsShowGoldLabel
            temp.GoldIcon = customData.GoldIcon
            temp.GoldCount = customData.GoldCount
            temp.IsClose = customData.IsClose
            temp.itemGoldClickCallBack = customData.itemGoldClickCallBack

            uimanager:CreatePanel("UIPromptPanel", nil, temp)
            return true
        end
    end
    return false
end

---关闭通用弹窗界面
function Utility.ClosePromptTipsPanel()
    uimanager:ClosePanel("UIPromptPanel")
end

function Utility.GetIntervalDayString(intervalDay)
    if (intervalDay == 0) then
        return "今天";
    elseif (intervalDay == 1) then
        return "明天";
    elseif (intervalDay == 2) then
        return "后天";
    elseif (intervalDay == -1) then
        return "昨天";
    elseif (intervalDay == -2) then
        return "前天";
    else
        if (intervalDay > 0) then
            return (intervalDay - 1) .. "天后"
        elseif (intervalDay < 0) then
            return (math.abs(intervalDay) - 1) .. "天前"
        end
    end
    return "";
end

---尝试打开送花界面
---@param customData XLua.ILuaTable
---@field customData.rid number
---@field customData.Sex number
---@field customData.name string
---@field customData.PromptClickFunc function
---@field CustomData.isSharePlayer boolean 是否为联服玩家 (默认不是联服)
---@field CustomData.hostId   number  服务器主机id (联服接口)
---@return boolean 成功创建送花面板
---@return boolean 成功创建弹窗
function Utility.TryOpenSendFlowerPanel(customData)
    if customData == nil or customData.Sex == nil or customData.rid == nil then
        if isOpenLog then
            luaDebug.Log("参数错误")
        end
        return false, false
    end
    local mainPlayerInfoSex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
    local hasFlower = Utility.GetHasFlower(mainPlayerInfoSex == tonumber(customData.Sex))
    if hasFlower then
        local temp = {
            sex = tonumber(customData.Sex),
            rid = tonumber(customData.rid),
            name = customData.name,
            isSharePlayer = customData.isSharePlayer,
            hostId = customData.hostId,
        }
        uimanager:CreatePanel("UISendFlowerPanel", nil, temp)
        return true, false
    end
    local isFind, info = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(16)
    if isFind then
        local temp = {
            Title = info.title,
            LeftDescription = info.leftButton,
            RightDescription = info.rightButton,
            Content = string.gsub(info.des, '\\n', '\n'),
            CallBack = function()
                local sameSex = CS.CSScene.MainPlayerInfo.Sex == customData.Sex
                local flowerID = ternary(sameSex, LuaEnumFlowerType.FirstGoldOrchid, LuaEnumFlowerType.FirstRose)
                local isFind, jumpId = CS.Cfg_GlobalTableManager.Instance.allFlowerTransShopDic:TryGetValue(flowerID)
                if isFind then
                    uiTransferManager:TransferToPanel(tonumber(jumpId))
                end
                if customData.PromptClickFunc ~= nil then
                    customData.PromptClickFunc()
                end
            end,
            ID = 16
        }
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
        return false, true
    end
    return false, false
end

---获取背包是否有所需花
function Utility.GetHasFlower(sameSex)
    local hasFlower1 = CS.CSScene.MainPlayerInfo.BagInfo:IsContainByItemId(ternary(sameSex, LuaEnumFlowerType.FirstGoldOrchid, LuaEnumFlowerType.FirstRose))
    if hasFlower1 then
        return true
    end
    local hasFlower2 = CS.CSScene.MainPlayerInfo.BagInfo:IsContainByItemId(ternary(sameSex, LuaEnumFlowerType.SecondGoldOrchid, LuaEnumFlowerType.SecondRose))
    if hasFlower2 then
        return true
    end
    local hasFlower3 = CS.CSScene.MainPlayerInfo.BagInfo:IsContainByItemId(ternary(sameSex, LuaEnumFlowerType.ThirdGoldOrchid, LuaEnumFlowerType.ThirdRose))
    if hasFlower3 then
        return true
    end
    return false
end

---尝试开启活动图标（图标为等级奖励面板左侧的图标）
function Utility.TryOpenActivityIcon(dailyActivityTimeId)
    local UILvPackPanel = uimanager:GetPanel("UILvPackPanel")
    if UILvPackPanel ~= nil and UILvPackPanel.leftIconTemplate ~= nil then
        UILvPackPanel.leftIconTemplate:TryOpenLeftIcon({ dailyActivityTimeId = dailyActivityTimeId })
    end
end

---关闭活动图标
function Utility.CloseActivityIcon()
    local UILvPackPanel = uimanager:GetPanel("UILvPackPanel")
    if UILvPackPanel ~= nil and UILvPackPanel.leftIconTemplate ~= nil then
        UILvPackPanel.leftIconTemplate:CloseLeftIcon()
    end
end

function Utility.HasTableValue(tbl, value)
    if (tbl == nil) then
        return false;
    end
    for k, v in pairs(tbl) do
        if (v == value) then
            return true;
        end
    end
    return false;
end

function Utility.TryShowFirstRechargePanel(EntranceWay)
    if (gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFirstRecharge() == false) then
        uimanager:CreatePanel("UIRechargeFirstTips");
    else
        if (CS.CSVersionMgr.Instance.ServerVersion.OpenRecharge) then
            uimanager:CreatePanel("UIRechargeMainPanel", nil, LuaEnumRechargeMainBookMarkType.Recharge)
        end
        if (EntranceWay ~= nil) then
            uiStaticParameter.RechargePointPanelType = EntranceWay
        end
    end
end

---前七天未完成首冲跳转到首冲或者充值界面
---@return boolean 是不是显示了首冲面板
function Utility.TryShowSevenDayFirstRechargePanel(EntranceWay)
    ---开服前7天98元首充未领取完时 跳转首冲面板
    if (not gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFinishReceivingTheFirstRechargeReward()) then
        uimanager:CreatePanel("UIRechargeFirstTips");
        return true
    else
        if (EntranceWay ~= nil) then
            uiStaticParameter.RechargePointPanelType = EntranceWay
        end
        if (CS.CSVersionMgr.Instance.ServerVersion.OpenRecharge) then
            uimanager:CreatePanel("UIRechargeMainPanel", nil, LuaEnumRechargeMainBookMarkType.Recharge)
            return true
        end
    end
    return false
end

function Utility.MainPlayerHasTitle()
    if (CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleId > 0) then
        return true;
    end
    return false;
end

function Utility.MainPlayerIsShowTitle()
    if (CS.CSScene.MainPlayerInfo.IAvater ~= nil and CS.CSScene.MainPlayerInfo.IAvater.Head ~= nil) then
        return CS.CSScene.MainPlayerInfo.IAvater.Head:GetIsShowTitle();
    end
    return false;
end

---@param trans GameObject 按钮
---@param str string    内容
---@param id  number    提示框id
function Utility.ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

--region 日活行为

---尝试去做当前活跃度
function Utility.TryDoMainPlayerCurrentActive()
    if (CS.CSScene.MainPlayerInfo == nil) then
        return false;
    end
    local currentActive = CS.CSScene.MainPlayerInfo.ActiveInfo:GetCurrentActive();
    if (currentActive ~= nil) then
        if (currentActive.activeTable.type == Utility.EnumToInt(CS.ActiveActionType.DAILY_TASK)) then
            Utility.TryDoMainPlayerActive(currentActive.activeTable, currentActive.mission)
        else
            if currentActive.hasCompleteItem then
                uimanager:CreatePanel("UIDayToDayPanel")
                return false;
            else
                Utility.TryDoMainPlayerActive(currentActive.activeTable, nil)
                return true;
            end
        end
    else
        uimanager:CreatePanel("UIDayToDayPanel")
        return false;
    end
end

---尝试执行主角活跃度行为
---activeData: TABLE.CFG_ACTIVE
---mission: CSMission
function Utility.TryDoMainPlayerActive(activeData, mission)
    if (CS.CSScene.MainPlayerInfo == nil) then
        return false;
    end
    if (activeData == nil) then
        return false;
    end

    local activeInfo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetProgress(activeData.id);
    if (activeInfo ~= nil and activeInfo.hasCompleteItem) then
        CS.CSScene.MainPlayerInfo.ActiveInfo:SetCurrentActive(nil);
        if activeInfo.clientActiveNum > 0 then
            local panel = uimanager:GetPanel("UIDayToDayPanel");
            if (activeInfo.activeTable.type == Utility.EnumToInt(CS.ActiveActionType.KILL_BOSS)) then
                if (panel ~= nil) then
                    for i = 1, activeInfo.clientActiveNum do
                        networkRequest.ReqGetActiveComplete(activeData.goal);
                    end
                    if (activeData.extraAward ~= nil and activeData.extraAward.list.Count > 0) then
                        local rewardInfo = {};
                        for i = 0, activeData.extraAward.list.Count - 1 do
                            if activeData.extraAward.list[i].list.Count > 1 then
                                local temp = {}
                                temp.itemId = activeData.extraAward.list[i].list[0]
                                temp.count = activeData.extraAward.list[i].list[1] * activeInfo.clientActiveNum
                                table.insert(rewardInfo, temp)
                            end
                        end
                        uimanager:CreatePanel("UIRewardTipsPanel", nil, { rewards = rewardInfo })
                    end
                else
                    uimanager:CreatePanel("UIDayToDayPanel");
                end
            else
                if (panel ~= nil) then
                    for i = 1, activeInfo.clientActiveNum do
                        networkRequest.ReqGetActiveComplete(activeData.goal);
                    end
                else
                    uimanager:CreatePanel("UIDayToDayPanel");
                end
            end
        end
        --  networkRequest.ReqGetActiveComplete(activeData.goal);

        local CurrDailyTask = CS.CSMissionManager.Instance.CurrentTask
        if CurrDailyTask ~= nil and CurrDailyTask:IsEverydayTask() and CurrDailyTask.id == activeData.id then
            local activeVo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveByDailyTaskType(CurrDailyTask.tbl_tasks.subtype);
            if (activeVo ~= nil) then
                CS.CSScene.MainPlayerInfo.ActiveInfo:SetCurrentActive(activeVo.id);
            end
        end
        return false;
    else
        if (activeData ~= nil) then
            local currentActive = CS.CSScene.MainPlayerInfo.ActiveInfo:GetCurrentActive();
            if (currentActive ~= nil and currentActive.id ~= activeData.id) then
                CS.CSScene.MainPlayerInfo.ActiveInfo:SetCurrentActive(activeData.id);
            else
                CS.CSScene.MainPlayerInfo.ActiveInfo:SetCurrentActive(activeData.id);
            end
        end

        if activeData.type == Utility.EnumToInt(CS.ActiveActionType.DAILY_TASK) then
            return Utility.TryDoDailyTask(mission)
        elseif activeData.type == Utility.EnumToInt(CS.ActiveActionType.ELITE_REWARD) then
            return Utility.TryDoEliteReward(activeData, mission);
        elseif activeData.type == Utility.EnumToInt(CS.ActiveActionType.BOSS_REWARD) then
            local stateCode = CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveState(activeData.id);
            if (stateCode == 4) then
                local csmission = CS.CSMissionManager.Instance:GetBossTask()
                if csmission and csmission.tbl_tasks then
                    networkRequest.ReqSubmitTask(csmission.tbl_tasks.id, 1)
                end
            else
                local param = string.Split(activeData.paramter, '#')
                if #param > 1 then
                    uiTransferManager:TransferToPanel(tonumber(param[2]));
                    uimanager:ClosePanel("UIDayToDayPanel")
                end
            end
            return
        elseif activeData.type == Utility.EnumToInt(CS.ActiveActionType.BAIRIMEN_REWARD) or
                activeData.type == Utility.EnumToInt(CS.ActiveActionType.PERSONAL_BOSS) or
                activeData.type == Utility.EnumToInt(CS.ActiveActionType.KILL_UNIONLEADER) or
                activeData.type == Utility.EnumToInt(CS.ActiveActionType.DiamondMall) then
            Utility.TryDoBaiRiMenTask(activeData, mission)
        elseif activeData.type == Utility.EnumToInt(CS.ActiveActionType.DAILY_CHALLENGE) then
            Utility.TryDoDailyChallengeTask(activeData, mission)
        elseif activeData.type == Utility.EnumToInt(CS.ActiveActionType.Recharge) then
            Utility.TryDoRechargeTask(activeData, mission)
        end
    end
end

---尝试去做精英悬赏
function Utility.TryDoEliteReward(activeTable, mission, customData)
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        if (activeTable ~= nil) then
            local mapNpcId = CS.Cfg_MapNpcTableManager.Instance:GetNearbyMapNpcId(activeTable.npc);
            CS.CSScene.MainPlayerInfo.AsyncOperationController.ActiveFindPathOperation:DoOperation(mapNpcId, LuaEnumDailyTaskButtonType.Task);
        end
    end
    return true;
end

---尝试去做日常任务
---mission: CSMission
---customData: 额外参数 table
function Utility.TryDoDailyTask(mission, customData)
    if (CS.CSScene.MainPlayerInfo == nil) then
        return false;
    end
    if mission ~= nil then
        local isfind, tempMission = CS.CSMissionManager.Instance.mMissionDic:TryGetValue(mission.taskId)
        if isfind then
            mission = tempMission
        end
    end
    if (mission ~= nil and mission.tbl_tasks.tnpc ~= nil and mission.tbl_tasks.tnpc.list ~= nil and mission.tbl_tasks.tnpc.list.Count > 0) then
        local targetNpcId = mission:GetMinimumNodeCountTNPC();
        if (customData ~= nil and customData.buttonType ~= nil) then
            CS.CSScene.MainPlayerInfo.AsyncOperationController.ActiveFindPathOperation:DoOperation(targetNpcId, customData.buttonType);
        else
            if (mission:CanSubmission()) then
                CS.CSScene.MainPlayerInfo.AsyncOperationController.ActiveFindPathOperation:DoOperation(targetNpcId, LuaEnumDailyTaskButtonType.Task);
                CS.CSMissionManager.Instance.CurrentTask = mission
            elseif (mission.IsNeedBuy) then
                CS.CSScene.MainPlayerInfo.AsyncOperationController.ActiveFindPathOperation:DoOperation(targetNpcId, LuaEnumDailyTaskButtonType.Task);
            else
                local tableData, itemId = mission:GetMissionItemRecommend();
                if (itemId ~= 0) then
                    CS.CSMissionManager.Instance.TaskFindItemID = itemId;
                    CS.CSMissionManager.Instance:FindTaskTarget(mission, true);
                end
            end
        end

        return true
    end
    return false;
end

---尝试击杀Boss
---activeTable: TABLE.CFG_ACTIVE
function Utility.TryDoKillBoss(activeTable)

    local transferId = 0;
    transferId = tonumber(activeTable.paramter);
    if (transferId ~= 0) then
        uiTransferManager:TransferToPanel(transferId);
        CS.CSGame.Sington.EventHandler:SendEvent(CS.CEvent.V2_ActiveAcceptStatusChange, true);
        return true
    end
    return false;
end

---尝试处理白日门任务
---activeTable: TABLE.CFG_ACTIVE
function Utility.TryDoBaiRiMenTask(activeData, mission)

    if (CS.CSScene.MainPlayerInfo == nil or mission == nil) then
        return false
    end

    local isfind, tempMission = CS.CSMissionManager.Instance.mMissionDic:TryGetValue(mission.taskId)
    if isfind then
        mission = tempMission
    end

    if (mission ~= nil) then
        if (mission:CanSubmission()) then
            networkRequest.ReqSubmitTask(mission.taskId)
        else
            local param = string.Split(activeData.paramter, '#')
            if #param > 2 then
                uiTransferManager:TransferToPanel(tonumber(param[3]));
                uimanager:ClosePanel("UIGainGoldGuidePanel")
            end
        end
        return true
    end
    return false;
end

---尝试处理日常挑战
---activeTable: TABLE.CFG_ACTIVE
function Utility.TryDoDailyChallengeTask(activeData, mission)
    if (CS.CSScene.MainPlayerInfo == nil or mission == nil) then
        return false
    end

    local isfind, tempMission = CS.CSMissionManager.Instance.mMissionDic:TryGetValue(mission.taskId)
    if isfind then
        mission = tempMission
    end

    if (mission ~= nil) then
        if (mission:CanSubmission()) then
            networkRequest.ReqSubmitTask(mission.taskId)
        else

            local param = string.Split(activeData.paramter, '#')
            if #param > 2 then
                CS.CSScene.MainPlayerInfo.AsyncOperationController.ActiveFindPathOperation:DoOperation(tonumber(param[3]), LuaEnumDailyTaskButtonType.Task)
                CS.CSMissionManager.Instance.CurrentTask = mission
                uimanager:ClosePanel("UIGainGoldGuidePanel")
            end
        end
        return true
    end
    return false;
end

---尝试处理充值任务
---activeTable: TABLE.CFG_ACTIVE
function Utility.TryDoRechargeTask(activeData, mission)

    if (CS.CSScene.MainPlayerInfo == nil or mission == nil) then
        return false
    end

    local isfind, tempMission = CS.CSMissionManager.Instance.mMissionDic:TryGetValue(mission.taskId)
    if isfind then
        mission = tempMission
    end

    if (mission ~= nil) then
        if (mission:CanSubmission()) then
            networkRequest.ReqSubmitTask(mission.taskId)
        else
            Utility.TryShowFirstRechargePanel()
        end
        return true
    end
    return false;
end

--endregion

--region 获取技能Icon拖拽对象
function Utility.TryGetDragSkillSprite()
    local effectPanel = uimanager:GetPanel("UIEffectPanel");
    if (effectPanel ~= nil) then
        return effectPanel:GetDragSkillIcon_UISprite();
    end
    return nil;
end

---请求加入帮会押镖活动
---@param go UnityEngine.GameObject
---@return boolean 是否成功加入
function Utility.ReqJoinUnionDartCarActivity(go)
    if CS.StaticUtility.IsNullOrEmpty(CS.CSScene.MainPlayerInfo.UIUnionName) then
        if CS.StaticUtility.IsNull(go) == false then
            Utility.ShowPopoTips(go, nil, 134)
        end
        return false
    elseif CS.CSScene.MainPlayerInfo.Level < CS.Cfg_GlobalTableManager.Instance:GetDartCarPlayerLevel() then
        if CS.StaticUtility.IsNull(go) == false then
            Utility.ShowPopoTips(go, nil, 165)
        end
        return false
    elseif uiStaticParameter.InCarAcitivity == true then
        ---当前在活动中
        local UIGangEscortLeftPanel = uimanager:GetPanel("UIGangEscortLeftPanel")
        if UIGangEscortLeftPanel ~= nil then
            UIGangEscortLeftPanel:TryFindPath()
            return true
        end
    else
        networkRequest.ReqJoinUnionCart()
        return true
    end
end

function Utility.GetTeamReqTypeString(type)
    return CS.Cfg_GlobalTableManager.Instance:GetTeamReqTypeString(type);
end

function Utility.GetTeamJoinTypeString(type)
    return CS.Cfg_GlobalTableManager.Instance:GetTeamJoinTypeString(type);
end

function Utility.ShowChangAttackPatternTip(avater, skillID)
    if avater == nil then
        return
    end
    if skillID == nil then
        skillID = 0
    end
    local targetIsPlayer = avater.AvatarType == CS.EAvatarType.Player
    local isPeace = CS.CSScene.MainPlayerInfo.PKMode == Utility.EnumToInt(CS.PkMode.Peace)
    local isCanHurtMe = CS.CSScene.MainPlayerInfo:IsCanHurtMe(avater)
    local number = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.AttackPatternTipNumner)
    local isSameUnion = true
    local mainPlayerHaveUnion = CS.StaticUtility.IsNullOrEmpty(CS.CSScene.MainPlayerInfo.UIUnionName) == false
    if mainPlayerHaveUnion == true then
        local avaterUnionName = avater.Info.UIUnionName
        isSameUnion = CS.CSScene.MainPlayerInfo.UIUnionName == avaterUnionName
    else
        isSameUnion = false
    end
    local isInHintChangePKModeLvArea = CS.Cfg_GlobalTableManager.Instance:IsInHintChangePkModeLvArea(CS.CSScene.MainPlayerInfo.Level)
    local isInHintChangePkModeMap = CS.Cfg_GlobalTableManager.Instance:IsInNoHintChangePkModeMapIdList(CS.CSScene.MainPlayerInfo.MapID) == false
    --是否是不产生仇恨的技能
    local isHaveNoHatredSkill = CS.Cfg_GlobalTableManager.Instance.NoHatredSkillList:Contains(skillID);
    if not isCanHurtMe and targetIsPlayer and isPeace and number < 3 and not isHaveNoHatredSkill and not isSameUnion and isInHintChangePKModeLvArea and isInHintChangePkModeMap then
        local CancelInfo = {
            Content = "和平模式无法攻击目标，是否切换模式",
            CallBack = function()
                number = number + 1
                CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(CS.EConfigOption.AttackPatternTipNumner, number)
                uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Equip_Atr)
                uimanager:ClosePanel('UIPromptPanel')
            end,
        }
        uimanager:CreatePanel("UIPromptPanel", nil, CancelInfo)
    end

end

---添加临时道具提示
---@param temp {lid:number,itemId:number,clickCallBack:function}
function Utility.AddSnapItemPrompt(temp)
    local skillPanel = uimanager:GetPanel('UIMainSkillPanel')
    if skillPanel and skillPanel.SnapItemViewTemplate then
        skillPanel.SnapItemViewTemplate:AddSnapItemPrompt(temp)
    end
end

---尝试添加临时道具提示，如果有刷新回调和时间
---@param temp {lid:number,itemId:number,clickCallBack:function}
------@param type number  判断是否相同ID类型: 1：itemId 2：lid
function Utility.TryAddSnapItemPrompt(temp, type)
    local skillPanel = uimanager:GetPanel('UIMainSkillPanel')
    if skillPanel and skillPanel.SnapItemViewTemplate then
        skillPanel.SnapItemViewTemplate:TryAddSnapItemPrompt(temp, type)
    end
end

---根据id类型删除临时道具提示
---@param id number id
---@param type number  ID类型: 1：itemId 2：lid
function Utility.RemoveSnapItemPrompt(type, id)
    local skillPanel = uimanager:GetPanel('UIMainSkillPanel')
    if skillPanel and skillPanel.SnapItemViewTemplate then
        skillPanel.SnapItemViewTemplate:RemoveSnapItemPrompt(type, id)
    end
end

---根据id类型判断是否存在此临时道具提示
---@param id number id
---@param type number  ID类型: 1：itemId 2：lid
function Utility.CheckSnapItemPrompt(type, id)
    local skillPanel = uimanager:GetPanel('UIMainSkillPanel')
    if skillPanel and skillPanel.SnapItemViewTemplate then
        return skillPanel.SnapItemViewTemplate:CheckSnapItemPrompt(type, id)
    end
end

---尝试使用间谍牌到临时快捷栏
function Utility.TrySetSpySnapItemInfoGrid(data)
    local temp = {}
    temp.lid = data.lid
    temp.itemId = data.itemId
    temp.icon = data.icon
    temp.clickCallBack = function()
        Utility.TryUseSpyItemfunc(nil, data.lid)
    end
    temp.timeEndCallBack = function()
        Utility.RemoveSnapItemPrompt(2, data.lid)
    end
    Utility.TryAddSnapItemPrompt(temp, 1)
end

---尝试使用间谍牌
function Utility.TryUseSpyItemfunc(go, lid)
    local selectAvater = CS.CSScene.Sington.MainPlayer.TouchEvent.TargetAvater.Select
    if selectAvater == nil or selectAvater.AvatarType ~= CS.EAvatarType.Player or selectAvater.BaseInfo == nil then
        CS.Utility.ShowTips("选择一个人物才能使用")
    else
        --local isEnterDefArea = CS.CSScene.MainPlayerInfo.ActivityInfo.isEnterDefArea
        --if not isEnterDefArea then
        --    CS.Utility.ShowTips("未在活动范围内，无法使用")
        --    return
        --end
        networkRequest.ReqUseSpyBrand(lid, selectAvater.BaseInfo.ID)
        Utility.RemoveSnapItemPrompt(2, lid)
    end
end

---创建物品使用面板
---@param commonData 通用参数
---@param commonData.itemInfo TABLE.CFG_ITEMS
---@param commonData.singleUseBtnOnClick function
---@param commonData.moreUseBtnOnClick function
function Utility.CreateItemUsePanel(commonData)
    if commonData ~= nil and (commonData.itemInfo ~= nil or commonData.bagItemInfoList ~= nil) then
        uimanager:CreatePanel("UIMagicStonePanel", nil, commonData)
    end
end

--region 主角使用物品等级描述
---获取主角使用物品等级描述
---@param itemInfo TABLE.CFG_ITEMS 物品信息
---@return string 描述内容（包含颜色）
function Utility.GetMainPlayerUseItemLevelDes(itemInfo, type)
    if itemInfo == nil then
        return ""
    end
    if itemInfo.useLv == 0 and itemInfo.reinLv == 0 then
        return "无等级"
    end
    local itemUseLevelDesTable = Utility.GetItemUseLevelDes(type)
    if itemUseLevelDesTable == nil then
        return ""
    end
    local canUseItemParams = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(itemInfo.id)
    local color = Utility.NewGetBBCode(canUseItemParams == LuaEnumUseItemParam.CanUse)
    local conditionType = itemInfo.conditionType
    local des = ""
    if conditionType == LuaEnumUseConditionType.And then
        local level = ternary(itemInfo.reinLv > 0, itemInfo.reinLv, itemInfo.useLv)
        des = color .. ternary(itemInfo.reinLv > 0, itemUseLevelDesTable.reinLv, itemUseLevelDesTable.level) .. level
    elseif conditionType == LuaEnumUseConditionType.Or then
        des = color .. string.format(itemUseLevelDesTable.levelOrReinLv, itemInfo.useLv, itemInfo.reinLv)
    end
    return des
end

---初始化物品使用等级描述表
function Utility.InitItemUseLevelDesTable()
    if Utility.itemUseLevelDesTable == nil then
        Utility.itemUseLevelDesTable = {}
        ---装备
        Utility.itemUseLevelDesTable[LuaEnumLevelDesType.Equip] = { level = "需要等级%s", reinLv = "需要转生等级%s", levelOrReinLv = "需要等级 %s 或 转生 %s" }
    end
end

---获取物品使用等级描述
---@param type LuaEnumLevelDesType 等级描述类型
---@return table 描述内容
function Utility.GetItemUseLevelDes(type)
    if Utility.itemUseLevelDesTable == nil then
        Utility.InitItemUseLevelDesTable()
    end
    return Utility.itemUseLevelDesTable[type]
end
--endregion


---尝试开启神石闪烁气泡
function Utility.TryShowGodStoneFalshPop(tblData)
    if tblData ~= nil and tblData.itemList ~= nil and uimanager:GetPanel("UIMagicStonePanel") == nil and (tblData.action == 1001 or tblData.action == 31005) then
        for k, v in pairs(tblData.itemList) do
            if CS.CSScene.MainPlayerInfo.MagicCircleInfo:IsMagicBallItem(v.itemId) == true and CS.CSScene.MainPlayerInfo.MagicCircleInfo:IsCanUseMagicStoneItem() == true and CS.Cfg_GlobalTableManager.Instance:HintGodStone(CS.CSScene.MainPlayerInfo.Level) then
                Utility.TryAddFlashPromp({ id = LuaEnumFlashIdType.MagicGodStoneHint, clickCallBack = function()
                    Utility.RemoveFlashPrompt(1, LuaEnumFlashIdType.MagicGodStoneHint)
                    Utility.CreateItemUsePanel({ bagItemInfoList = CS.CSScene.MainPlayerInfo.MagicCircleInfo:GetAllMagicCircleMaterialInBag(), singleUseBtnOnClick = function()
                        CS.CSScene.MainPlayerInfo.MagicCircleInfo:TryPlayMagicBallTween()
                    end, moreUseBtnOnClick = function()
                        CS.CSScene.MainPlayerInfo.MagicCircleInfo:TryPlayMagicBallTween()
                    end })
                end })
                break
            end
        end
    end
    if tblData ~= nil and tblData.action == 2001 then
        local bagItemInfoList = CS.CSScene.MainPlayerInfo.MagicCircleInfo:GetAllMagicCircleMaterialInBag()
        if bagItemInfoList.Count <= 0 then
            Utility.RemoveFlashPrompt(1, LuaEnumFlashIdType.MagicGodStoneHint)
        end
    end
end


--function Utility.SetAutoFightState(isAutoFight)
--    if(isAutoFight) then
--        Utility.OpenAutoFight();
--    else
--        Utility.CloseAutoFight();
--    end
--end
--
--function Utility.OpenAutoFight()
--    CS.CSAutoFightMgr.Instance:Toggle(true);
--end
--
--function Utility.CloseAutoFight()
--    CS.CSAutoFightMgr.Instance:Toggle(false);
--end

--region 行会
---显示推荐加入帮会弹窗提示
function Utility.ShowUnionPushPrompt()
    if uiStaticParameter.mNeedShowUnionPush then
        uiStaticParameter.mNeedShowUnionPush = false
        Utility.ShowUnionPush()
    end
end

---行会推送弹窗
function Utility.ShowUnionPush()
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return
    end
    local unionInfo = mainPlayerInfo.UnionInfoV2
    local res, promptInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(75)
    if res then
        local PromptInfo = {
            Title = promptInfo.title,
            LeftDescription = promptInfo.leftButton,
            RightDescription = promptInfo.rightButton,
            Content = promptInfo.des,
            IsClose = false,
            ID = 75,
            CallBack = function()
                local cd = unionInfo:GetExitCD()
                if CS.StaticUtility.IsNullOrEmpty(cd) then
                    --申请推荐
                    local pushInfo
                    if unionInfo and unionInfo.PushList and unionInfo.PushList.Count > 0 then
                        pushInfo = unionInfo.PushList[0]
                        if pushInfo then
                            networkRequest.ReqJoinOrWithdrawUnion(pushInfo.unionId, 1)
                            uimanager:ClosePanel("UIPromptPanel")
                        end
                    end
                else
                    ---@type UIPromptPanel
                    local panel = uimanager:GetPanel("UIPromptPanel")
                    if panel then
                        local go = panel.GetCenterButton_GameObject()
                        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(210)
                        if res and not CS.StaticUtility.IsNull(go) then
                            local mExitUnionCD = desInfo.content
                            Utility.ShowPopoTips(go, string.format(mExitUnionCD, cd), 210)
                        end
                    end
                end
            end
        }
        uimanager:CreatePanel("UIPromptPanel", nil, PromptInfo)
    end
end

---沙巴克活动开启期间点击帮会按钮提示气泡
function Utility.IsSabacActivityNotOpen(go)
    local isSabacActivity = Utility.IsOpenShaBaKe();
    if isSabacActivity then
        Utility.ShowPopoTips(go, nil, 111)
        return true
    end
    return true
end

---尝试开启发送红包气泡
---@param tblData bagV2.ResBagChange
function Utility.TryAddSendUnionRedPackPop(tblData)
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return
    end
    ---@type CSUnionInfoV2 帮会信息
    local unionInfo = mainPlayerInfo.UnionInfoV2
    if unionInfo == nil or unionInfo.UnionID == 0 then
        return
    end
    if tblData and tblData.itemList then
        for k, v in pairs(tblData.itemList) do
            ---@type bagV2.BagItemInfo
            local bagItemInfo = v
            if bagItemInfo == nil then
                break
            end
            local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
            if not res then
                break
            end
            if Utility.IsUnionRedPack(itemInfo) then
                local level = mainPlayerInfo.Level
                local levelLimit = CS.Cfg_GlobalTableManager.Instance:GetPushUnionRedPackLevel()
                if level <= levelLimit then
                    Utility.TryAddFlashPromp({ id = LuaEnumFlashIdType.UnionSendRedPack, clickCallBack = function()
                        Utility.RemoveFlashPrompt(1, LuaEnumFlashIdType.UnionSendRedPack)
                        local customData = {}
                        customData.BagItemInfo = bagItemInfo
                        ---@type UIPersonSendRedPackCouponPanelTemplate
                        customData.Template = luaComponentTemplates.UIPersonSendRedPackCouponPanelTemplate
                        uimanager:CreatePanel("UIGuildSendRedPackPanel", nil, customData)
                    end })
                    break
                end
            end
        end
    end
end

---尝试开启宝箱自选列表
---@return boolean 是否打开自选列表
function Utility.TryCreateOptionalList(commonData)
    if commonData ~= nil then
        if commonData.bagItemInfo ~= nil then
            local optionalBox = CS.Cfg_BoxTableManager.Instance:GetOptionalBox(commonData.bagItemInfo.itemId)
            if optionalBox ~= nil then
                uimanager:CreatePanel("UIOptionalBoxPanel", nil, { optionalBox = optionalBox, bagItemInfo = commonData.bagItemInfo })
                return true
            end
        end
    end
    return false
end

---检测是否切换pk模式
---@return boolean 是否请求切换攻击模式
function Utility.CheckChangePkMode(commonData)
    if commonData == nil or commonData.dropDown == nil then
        return true
    end
    local dropDown = commonData.dropDown
    local mainPlayerMapId = CS.CSScene.getMapID()
    ---当前地图id是否可以切换攻击模式
    local showBubble = CS.Cfg_GlobalTableManager.Instance:CheckMapIdCanChangePkMode(mainPlayerMapId) == true
    dropDown.IsBreakArrowFunc = showBubble
    if showBubble and commonData.parent ~= nil then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Parent] = commonData.parent;
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 95
        TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIRolePanel"
        uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
        return false
    end
    return true
end

--region 行会仓库
---获取行会仓库箭头类型
---@param itemInfo TABLE.CFG_ITEMS
---@return LuaEnumArrowType 箭头类型
function Utility.GetArrowTypeByItemId(itemInfo)
    local isBetterItem = false
    local isCanUseItem = false

    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return
    end

    ---@type CSServantInfoV2
    local servantInfo = mainPlayerInfo.ServantInfoV2
    if CS.CSServantInfoV2.IsServantEquip(itemInfo) then
        --灵兽装备/肉身/通用肉身
        isBetterItem = servantInfo:IsBetterEquipThanEquipped(itemInfo, mainPlayerInfo.Career)
        isCanUseItem = servantInfo:IsItemCanEquipped(itemInfo)
    elseif CS.CSServantInfoV2.isServantEgg(itemInfo) then
        --灵兽蛋
        isBetterItem = servantInfo:IsBetterServantThanEquipped(itemInfo)
        isCanUseItem = servantInfo:IsServantEggCanEquipped(itemInfo, mainPlayerInfo.Level, mainPlayerInfo.ReinLevel)
    end
    if isBetterItem == true then
        if isCanUseItem then
            return LuaEnumArrowType.GreenArrow
        else
            return LuaEnumArrowType.YellowArrow
        end
    else
        return LuaEnumArrowType.NONE
    end
end

--endregion

--endregion

--region 元素
---@return string 元素颜色
function Utility.GetElementColor()
    local color = CS.Cfg_GlobalTableManager.Instance:GetElementColor()
    if color == nil then
        color = ""
    end
    return color
end

--endregion

--region商城
function Utility.TransferShopChooseItem(itemId)
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        mainPlayerInfo.StoreInfoV2:TryGetStoreInfoWithItemId(itemId, function(storeVo)
            if (storeVo ~= nil) then
                uimanager:CreatePanel("UIShopPanel", nil, { type = storeVo.storeTable.sellId, chooseStore = { storeVo.storeId } });
            else
                uimanager:CreatePanel("UIShopPanel");
            end
        end);
    end
end

function Utility.TransferShopChooseStore(storeId)
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        mainPlayerInfo.StoreInfoV2:TryGetStoreInfo(storeId, function(storeVo)
            if (storeVo ~= nil) then
                uimanager:CreatePanel("UIShopPanel", nil, { type = storeVo.storeTable.sellId, chooseStore = { storeVo.storeId } });
            else
                uimanager:CreatePanel("UIShopPanel");
            end
        end);
    end
end
--endregion

--region 根据道具信息判断是否是某个道具
---@param itemInfo TABLE.CFG_ITEMS
---@return boolean 是否是行会红包
function Utility.IsUnionRedPack(itemInfo)
    if itemInfo then
        if itemInfo.type == luaEnumItemType.Assist and itemInfo.subType == 25 then
            return true
        end
    end
    return false
end

---@param itemInfo TABLE.CFG_ITEMS
---@return boolean 是否是装备宝箱
function Utility.IsEquipBox(itemInfo)
    if itemInfo then
        if itemInfo.type == luaEnumItemType.TreasureBox and itemInfo.subType == 77 then
            return true
        end
    end
    return false
end

---@return boolean 判断该道具是否是钻石
function Utility.IsItemDiamond(itemId)
    if itemId == LuaEnumCoinType.Diamond or itemId == LuaEnumCoinType.Diamond1 or itemId == LuaEnumCoinType.Diamond2 or itemId == LuaEnumCoinType.Diamond3 or itemId == LuaEnumCoinType.Diamond4 then
        return true
    end
    return false
end

---@return boolean 是否是超级聚灵珠
function Utility.IsSuperJLZ(itemId)
    return itemId == 8040015
end

---@return boolean 是否是特殊装备宝箱（白银宝箱/黄金宝箱）
function Utility.IsSpecialEquipBox(itemInfo)
    if itemInfo then
        if itemInfo.type == luaEnumItemType.TreasureBox and itemInfo.subType == 78 then
            return true
        end
    end
    return false
end

function Utility.HasOpenTimes()


end

---@return boolean 是否是特殊装备宝箱钥匙（白银宝箱/黄金宝箱）
function Utility.IsSpecialEquipBoxKey(itemInfo)
    if itemInfo then
        if itemInfo.type == luaEnumItemType.Material and itemInfo.subType == 19 then
            return true
        end
    end
    return false
end
--endregion

---跳转充值面板
function Utility.JumpRechargePanel(go, type)
    --改为跳转充值
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        Utility.TryShowFirstRechargePanel(type)
    end
end

---推送6元限时礼包
---@return boolean
function Utility.IsPushSpecialGift()
    local isFindRechargeInfo = false
    local isFind, info = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22836)
    if (isFind) then
        local params = string.Split(info.value, '#')
        local isFind, rechargeinfo = CS.Cfg_RechargeTableManager.Instance:TryGetValue(params[4])

        CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStoreInfo(rechargeinfo.storeIndex, function(info)
            isFindRechargeInfo = true
        end)
        if (#params >= 4 and gameMgr ~= nil and gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetRechargeInfo() ~= nil and
                gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetResSendRechargeInfo() ~= nil and
                gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetResSendRechargeInfo().totalRechargeCount <= tonumber(params[1]) and
                (Utility.mLastPushGiftTime == 0 or CS.UnityEngine.Time.time - Utility.mLastPushGiftTime >= tonumber(params[2])) and
                CS.CSScene.MainPlayerInfo.OpenServerDayNumber < tonumber(params[3])
                and isFindRechargeInfo
        ) then
            Utility.mLastPushGiftTime = CS.UnityEngine.Time.time
            return true
        end
        --end
    end
    return false
end

function Utility:GetPayData(rechargeinfo)
    if (rechargeinfo ~= nil) then

        local id = rechargeinfo.id;
        if (id == nil) then
            id = rechargeinfo:GetId()
        end

        local data = CS.PayParams.CreatePaydata()
        local constant = CS.Constant
        ---@type CSMainPlayerInfo
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        data.app_User_Id = constant.UserID_SDK
        data.app_User_Id_SDK = constant.UserID_SDK
        data.app_User_Id_Game = constant.UserID_Game
        data.game_Role_Id = constant.RoleID_Game
        local notify_Uri = CS.SDKManager.PlatformData:GetPlatformData().notify_Uri
        if notify_Uri == nil or notify_Uri == "" then
            data.notify_Uri = "http://login.wjsf.app.9125flying.com:4000/recharge/" .. constant.platformid
        else
            data.notify_Uri = notify_Uri
        end

        --if (CS.Constant.platformid == 6) then
        --    data.notify_Uri = "http://test-login.wjrx.app.9125flying.com:4000/recharge/6"
        --    --appExt1 = tostring(constant.RoleID_Game) .. ":" .. tostring(id) .. ":" .. tostring(CS.CSServerTime.Instance.TotalSeconds)
        --end
        local rmb = rechargeinfo.rmb;
        if (rmb == nil) then
            rmb = rechargeinfo:GetRmb()
        end
        data.amount = rmb / 100

        --region 不同渠道的附带参数
        local appExt1 = "";
        --九州、星酪玩、麻探
        if (CS.Constant.platformid == 7 or CS.Constant.platformid == 19 or CS.Constant.platformid == 20) then
            appExt1 = tostring(constant.RoleID_Game) .. ":" .. tostring(id) .. ":" .. tostring(CS.CSServerTime.Instance.TotalSeconds) .. ":" .. constant.mSeverId
        end
        --endregion

        data.app_Ext1 = appExt1
        data.app_Ext2 = ""
        data.app_name = ""
        data.app_order_Id = tostring(CS.CSServerTime.Instance.TotalMillisecond) .. tostring(CS.CSScene.MainPlayerInfo.ID)
        data.app_user_Name = CS.CSScene.MainPlayerInfo.Name

        data.product_Id = id
        data.sid = tostring(constant.mSeverId)
        data.serverName = constant.mServerName

        local name = rechargeinfo.name;
        if (name == nil) then
            name = rechargeinfo:GetName()
        end
        data.product_name = name

        local desc = rechargeinfo.desc;
        if (desc == nil) then
            desc = rechargeinfo:GetDesc()
        end
        data.product_desc = desc

        local vipLevel = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetPlayerVip2Level()
        if vipLevel then
            data.vipLevel = vipLevel
        else
            data.vipLevel = 0
        end

        local roleLevel = gameMgr:GetLuaMainPlayer():GetLevel()
        if roleLevel then
            data.roleLevel = roleLevel
        else
            data.roleLevel = 0
        end

        local unionName = " "
        if mainPlayerInfo and mainPlayerInfo.UnionInfoV2 and mainPlayerInfo.UnionInfoV2.UnionName then
            unionName = mainPlayerInfo.UnionInfoV2.UnionName
        end
        data.UnionName = unionName

        data.CreateTime = CS.CSScene.MainPlayerInfo.CreateRoleTime
        data.balance = " ";
        data.sign = " "
        data.district = 1;
        data.remainder = " "
        if (constant.mSeverId == 0 or data.sid == nil or data.sid == "0") then
            CS.Utility.ShowTips("[ff0000]当前服务器信息获取失败,请返回登入后重试")
            CS.UnityEngine.Debug.LogError("当前服务器信息获取失败, 请返回登入后重试 ");
            return nil
        end
        return data
    end
    return nil
end

---关闭行会押镖活动
function Utility.CloseUnionDartCarActivity()
    uiStaticParameter.InCarAcitivity = false
    uimanager:ClosePanel("UIGangEscortLeftPanel")
    Utility.CloseActivityIcon()
    Utility.TryStopUnionDartCarFindPath()
end

---尝试停止行会押镖寻路
function Utility.TryStopUnionDartCarFindPath()
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.AsyncOperationController ~= nil and CS.CSScene.MainPlayerInfo.AsyncOperationController.DartCarFindPathOperation.IsOn == true then
        CS.CSScene.MainPlayerInfo.AsyncOperationController:Stop()
    end
end

function Utility.GetDeepAssetPaths(path, list, extension, excludeDirList)

    if CS.System.IO.Directory.Exists(path) == true then
        --CS.UnityEngine.Debug.Log('Exists = '..path)
        if excludeDirList ~= nil then
            local temp = string.gsub(path, "\\", "/");
            --CS.UnityEngine.Debug.Log('temp = '..temp..' excludeDirList.Count='..excludeDirList.Count)
            for i = 0, excludeDirList.Count - 1 do
                --CS.UnityEngine.Debug.Log('excludeDirList =  '..i..' '..excludeDirList[i])
                local index2 = string.len(path) - string.len(excludeDirList[i])
                local index = string.find(temp, excludeDirList[i], index2 - 1)
                if index ~= nil then
                    --Apk里面path前面有/Android/导致调用的时候返回了。考虑/Anadroid/xxx/Android情况。下周来写
                    CS.UnityEngine.Debug.Log('return = ' .. temp .. ' ' .. excludeDirList[i] .. ' ' .. tostring(index) .. ' ' .. string.len(path) .. ' ' .. string.len(excludeDirList[i]))
                    return
                end
            end
        end
        --CS.UnityEngine.Debug.Log('Create DirectoryInfo = ')
        local dir = CS.System.IO.DirectoryInfo(path)
        --CS.UnityEngine.Debug.Log('Create DirectoryInfo2 = ')
        local files = dir:GetFiles("*" .. extension);
        --CS.UnityEngine.Debug.Log('files = '..files.Length)
        for i = 0, files.Length - 1 do
            local file = files[i]
            local filePath = Utility.GetAssetPath(file.FullName);
            if list:Contains(filePath) == false then
                --CS.UnityEngine.Debug.Log('filePath = '..filePath)
                list:Add(filePath)
            end
        end
        local dirChild = dir:GetDirectories();
        for i = 0, dirChild.Length - 1 do
            Utility.GetDeepAssetPaths(dirChild[i].FullName, list, extension, excludeDirList);
        end

        if CS.System.IO.File.Exists(path) == true then
            local filePath = Utility.GetAssetPath(path);
            if list:Contains(filePath) == false then
                --CS.UnityEngine.Debug.Log('filePath = '..filePath)
                list:Add(filePath)
            end
        end
    end
end
function Utility.GetAssetPath(fileFullPath)
    return string.gsub(fileFullPath, "\\", "/");
end

---右上角按钮是否开启
function Utility.RightUpNoticeIsOpen(noticeId)
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.OpenSystemDic ~= nil and CS.CSScene.MainPlayerInfo.OpenSystemDic.Count > 0 then
        local strIsFind, str = CS.CSScene.MainPlayerInfo.OpenSystemDic:TryGetValue(noticeId)
        return strIsFind
    end
    return false
end

---打开地耐久气泡
function Utility.TryOpenLowLastingPop()
    if CS.CSScene.MainPlayerInfo ~= nil then
        local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo
        local lowLastingEquip = equipInfo:GetLowLastingEquip()
        local isLimitIndex = lowLastingEquip ~= nil
                and lowLastingEquip.index ~= LuaEquipmentItemType.SpecialRingL
                and lowLastingEquip.index ~= LuaEquipmentItemType.SpecialRingR
                and lowLastingEquip.index ~= LuaEquipmentItemType.MainSignet
                and lowLastingEquip.index ~= LuaEquipmentItemType.SubSignet
                and lowLastingEquip.index ~= 13
                and lowLastingEquip.index ~= 15
                and lowLastingEquip.index ~= 18
                and lowLastingEquip.index ~= 21
                and lowLastingEquip.index ~= 22
                and lowLastingEquip.index ~= 24
                and lowLastingEquip.index ~= 34
                and lowLastingEquip.index ~= 35
                and lowLastingEquip.index ~= 36
                and lowLastingEquip.index ~= 37
        if lowLastingEquip ~= nil and lowLastingEquip.ItemTABLE ~= nil and lowLastingEquip.index ~= nil and lowLastingEquip.index < 1000 and isLimitIndex then
            ---只处理人物角色的普通装备,不考虑血继等其他装备
            Utility.AddFlashPrompt({ showIntervalTime = CS.Cfg_GlobalTableManager.Instance:GetEquipLastingHintIntervalTime(), id = 29, clickCallBack = function()
                Utility.RemoveFlashPrompt(1, 29)
                Utility.ShowSecondConfirmPanel({ PromptWordId = 97,
                                                 des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(97, lowLastingEquip.ItemTABLE.name),
                                                 ComfireAucion = function()
                                                     Utility.TryTransfer(1013)
                                                     --[[                                                     CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ 55, 61 }, "UIRepairPanel",
                                                                                                                  CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC)]]
                                                 end })
            end })
        end
    end
end

--region 提醒气泡
---尝试创建气泡
---@param commonData.id number Cfg_Guide_BubbleTableManager表的id
---@param commonData.point UnityEngine.GameObject 挂载节点
---@param commonData.clickCallBack function 点击回调
---@param commonData.depth number 面板深度
---@return 提示tips luaComponentTemplates.HintClickTipTemplate
function Utility.TryCreateHintTips(commonData)
    ---@type HintPopTips
    local HintPopTipsPanel = uimanager:GetPanel("HintPopTips")
    if HintPopTipsPanel ~= nil then
        local tipTamplate = HintPopTipsPanel:TryHintTips(commonData)
        return tipTamplate
    end
end

---移除气泡
function Utility.RemoveHintTips(tipTemplate)
    if tipTemplate ~= nil and tipTemplate.go ~= nil then
        local HintPopTipsPanel = uimanager:GetPanel("HintPopTips")
        if HintPopTipsPanel ~= nil then
            HintPopTipsPanel:RemoveTips(tipTemplate)
        end
    end
end
--endregion

--region 聚灵珠
---打开聚灵珠界面
---@param customData table 聚灵珠
function Utility.TryOpenJLZPanel(customData)
    if customData and customData.info then
        local id = customData.info.id
        if id and CS.Cfg_GlobalTableManager.Instance.GetJLZCostJLDNum and CS.Cfg_GlobalTableManager.Instance:GetJLZCostJLDNum(id) == -1 then
            ---@type UIJuLingZhuPanel
            uimanager:CreatePanel("UIJuLingZhuPanel", nil, customData)
        else
            ---@type UISuperJuLingZhuPanel
            uimanager:CreatePanel("UISuperJuLingZhuPanel", nil, customData)
        end
    end
end
--endregion

function Utility.DoMainTask()
    local maintask = CS.CSMissionManager.Instance:GetMainTask()
    if maintask ~= nil then
        -- print("DoMainTask:", CS.Cfg_GlobalTableManager.Instance.TransferAutoTaskIdList:Contains(maintask.taskId))
        if CS.Cfg_GlobalTableManager.Instance.TransferAutoTaskIdList:Contains(maintask.taskId) then
            local dotask = CS.CSListUpdateMgr.Add(300, nil, function()
                if CS.CSResUpdateMgr.Instance ~= nil then
                    CS.CSMissionManager.Instance:FindTaskTarget(maintask, false, false)
                    -- print("DoMainTask")
                end
            end)
            CS.CSListUpdateMgr.Instance:Add(dotask)
        end
    end
end

---itemlabel UILabel
function Utility.RequestCharactersInTexture(itemlabel)
    if itemlabel == nil then
        return
    end
    if itemlabel.trueTypeFont == nil then
        return
    end
    itemlabel.trueTypeFont:RequestCharactersInTexture(itemlabel.text, itemlabel.fontSize, itemlabel.fontStyle)
end

function Utility.OpenPracticePanel()
    local customData = {};
    customData.servantIndex = 0
    customData.type = LuaEnumServantPanelType.LevelPanel;
    customData.IsOpenPracticePanel = true

    uimanager:CreatePanel("UIServantTagPanel", nil, customData)
end

---得到游戏名称
function Utility.GetGameName()
    if CS.SDKManager.GameInterface ~= nil then
        if CS.SDKManager.GameInterface:GetAppName() ~= "" then
            return CS.SDKManager.GameInterface:GetAppName()
        end
    end
    if CS.SDKManager.PlatformData:GetPlatformData() ~= nil then
        local gameDesc = CS.SDKManager.PlatformData:GetPlatformData().gameDesc
        if gameDesc ~= nil and gameDesc ~= "" then
            return gameDesc
        end
    end
    return nil
end

---深拷贝table
function Utility.CopyTable(cloneTable)
    local newTable = {}
    if type(cloneTable) ~= 'table' then
        return newtable
    end
    for k, v in pairs(cloneTable) do
        newTable[k] = v
    end
    return newTable
end

---判断某活动是否开启
function Utility.GetActivityOpen(noticeId)
    local turnedOnIds
    if CS.CSScene.MainPlayerInfo and CS.CSScene.MainPlayerInfo.OpenSystemTipInfo then
        turnedOnIds = CS.CSScene.MainPlayerInfo.OpenSystemTipInfo.yiKaiQi;
    end
    if noticeId and turnedOnIds then
        --for i = 0, turnedOnIds.Count - 1 do
        --    if (noticeId == turnedOnIds[i]) then
        --        return true
        --    end
        --end
        return turnedOnIds:Contains(noticeId)
    end
    return false
end

--任务Boss等级信息
function Utility.GetTaskBossLevelListInfo(tbl_taskBoss)
    if tbl_taskBoss == nil then
        return
    end
    if tbl_taskBoss.level == nil then
        return
    end
    local TaskBossList = {}
    local TaskBossLevelTbl = {
        level = 0,
        bossinfo = {},
    }
    for i = 0, tbl_taskBoss.level.list.Count - 1 do
        local level = tbl_taskBoss.level.list[i]
        local TaskBossLevelTbl = {
            level = level,
            bossinfo = Utility.GetTaskBossLevelInfo(tbl_taskBoss, i),
        }
        table.insert(TaskBossList, TaskBossLevelTbl)
    end
    return TaskBossList
end

--任务Boss类型信息
function Utility.GetTaskBossTypeListInfo(tbl_taskBoss)
    if tbl_taskBoss == nil then
        return
    end
    if tbl_taskBoss.display == nil or tbl_taskBoss.display == "" then
        return
    end
    local display = _fSplit(tbl_taskBoss.display, '#')
    local TaskBossList = {}
    for i = 1, #display do
        local bosstype = display[i]
        local TaskBossTypeTbl = {
            bossType = bosstype,
            bossinfo = Utility.GetTaskBossLevelInfo(tbl_taskBoss, i - 1),
        }
        table.insert(TaskBossList, TaskBossTypeTbl)
    end
    return TaskBossList
end

function Utility.GetTaskBossLevelInfo(tbl_taskBoss, index)
    ---配置ID 传送用
    local deliverID = 0;
    ---地图ID
    local mapID = 0;
    ---支线地图ID
    local branchmapID = 0;
    --怪物Tbl列表
    local monstersTblList = {}

    if tbl_taskBoss == nil or index == nil or index < 0 then
        return nil
    end
    if tbl_taskBoss.monsters.list.Count < index then
        return nil
    end

    if tbl_taskBoss.deliver ~= nil then
        if tbl_taskBoss.deliver.list.Count < index and tbl_taskBoss.deliver.list.Count ~= 1 then
            return nil
        end

        if tbl_taskBoss.deliver.list.Count == 1 then
            deliverID = tbl_taskBoss.deliver.list[0]
        else
            deliverID = tbl_taskBoss.deliver.list[index]
        end
    end

    if tbl_taskBoss.branch ~= nil then
        if tbl_taskBoss.branch.list.Count < index and tbl_taskBoss.branch.list.Count ~= 1 then
            return nil
        end
        if tbl_taskBoss.branch.list.Count == 1 then
            branchmapID = tbl_taskBoss.branch.list[0]
        else
            branchmapID = tbl_taskBoss.branch.list[index]
        end
    end

    if tbl_taskBoss.map ~= nil then
        if tbl_taskBoss.map.list.Count < index and tbl_taskBoss.map.list.Count ~= 1 then
            return nil
        end
        if tbl_taskBoss.map.list.Count == 1 then
            mapID = tbl_taskBoss.map.list[0]
        else
            mapID = tbl_taskBoss.map.list[index]
        end
    end

    for i = 0, tbl_taskBoss.monsters.list[index].list.Count - 1 do
        local monstersID = tbl_taskBoss.monsters.list[index].list[i]
        local isfind, mon = CS.Cfg_MonsterTableManager.Instance:TryGetValue(monstersID)
        if isfind then
            table.insert(monstersTblList, mon)
        end
    end
    local jumpID = ""
    if tbl_taskBoss.jump ~= nil and tbl_taskBoss.jump ~= "" then
        local jumpIDList = _fSplit(tbl_taskBoss.jump, '#')
        jumpID = jumpIDList[index + 1]
    end

    local BossInfo = {
        TblList = monstersTblList,
        DeliverID = deliverID,
        MapID = mapID,
        BranchmapID = branchmapID,
        JumpID = jumpID,
    }
    return BossInfo
end

--region 宝箱
---获取宝箱的钥匙信息
---@alias KeyInfo {keyId:number,keyNum:number}
---@param boxItemID
---@return KeyInfo
function Utility.GetSpecialBoxKeyInfo(boxItemID)
    if boxItemID == nil then
        return nil
    end
    local keyInfos = Utility.GetSpecialBoxKeyInfos()
    return keyInfos[boxItemID]
end

---获取钥匙的宝箱信息
---@param keyItemID number 钥匙id
---@return table<number,number> 宝箱信息
function Utility.GetSpecialKeyBoxInfo(keyItemID)
    if keyItemID == nil then
        return nil
    end
    local boxInfos = Utility.GetSpecialBoxKeyInfos(true)
    return boxInfos[keyItemID]
end

---获取宝箱及其钥匙的信息
---@return table<number, KeyInfo>
function Utility.GetSpecialBoxKeyInfos(isKey)
    if Utility.mBoxExtendInfo == nil or Utility.mKeyExtendInfo == nil then
        Utility.mBoxExtendInfo = {}
        Utility.mKeyExtendInfo = {}
        local res, globalInfo = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22413)
        if res then
            local idList = string.Split(globalInfo.value, '&')
            for i = 1, #idList do
                local idInfo = string.Split(idList[i], '#')
                if #idInfo >= 3 then
                    local boxId = tonumber(idInfo[1])
                    local key = {}
                    local keyId = tonumber(idInfo[3])
                    key.keyId = keyId
                    key.keyNum = tonumber(idInfo[2])
                    Utility.mBoxExtendInfo[boxId] = key
                    Utility.mKeyExtendInfo[keyId] = boxId
                end
            end
        end
    end
    if isKey then
        return Utility.mKeyExtendInfo
    end
    return Utility.mBoxExtendInfo
end

---获取宝箱每日最大使用数量
---@return number
function Utility.GetSpecialBoxUseCountLimitPerDay(itemID)
    ---白银宝箱,根据当前vip等级从vip_level表中读取该等级vip所能够使用的白银宝箱
    if gameMgr:GetPlayerDataMgr() then
        local mainPlayerLevel = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetPlayerVip2Level()
        local vipLevelTbl = clientTableManager.cfg_vip_levelManager:TryGetValue(mainPlayerLevel)
        if vipLevelTbl and vipLevelTbl:GetBoxUseTime() and vipLevelTbl:GetBoxUseTime().list then
            for i = 1, #vipLevelTbl:GetBoxUseTime().list do
                local list = vipLevelTbl:GetBoxUseTime().list[i].list
                if list and #list > 1 and list[1] == itemID then
                    return list[2]
                end
            end
        end
    end
    return 0
end

function Utility.CanUseSpecialEquipBox(itemTbl)
    local boxItemId = -1
    if Utility.IsSpecialEquipBox(itemTbl) then
        boxItemId = itemTbl.id
    elseif Utility.IsSpecialEquipBoxKey(itemTbl) then
        boxItemId = Utility.GetSpecialKeyBoxInfo(itemTbl.id)
    end
    if boxItemId ~= -1 then
        local maxNum = Utility.GetSpecialBoxUseCountLimitPerDay(boxItemId)
        local useNum = 0
        local res, useInfo = CS.CSScene.MainPlayerInfo.BagInfo.ItemUseTime:TryGetValue(boxItemId)
        if res then
            useNum = useInfo
        end
        if maxNum and maxNum ~= 0 and maxNum <= useNum then
            return false
        end
    end
    return true
end

--endregion

---创建左侧排行榜
---@param commonData.title string 标题
---@param commonData.rankTable table 排行榜列表
---@param commonData.titleTable table 标头文本列表
---@param commonData.rewardListBtnOnClick function  奖励列表按钮点击
---@param commonData.helpBtnOnClick function 帮助按钮点击
function Utility.CreateSidebarRankPanel(commonData)
    local UIMagicBossRankPanel = uimanager:GetPanel("UIMagicBossRankPanel")
    if UIMagicBossRankPanel ~= nil then
        uimanager:CreatePanel("UIMagicBossRankPanel", nil, commonData)
    else
        if commonData and commonData.rankTable ~= nil then
            local uiMainMenusPanel = uimanager:GetPanel("UIMainMenusPanel")
            if uiMainMenusPanel == nil then
                return
            end
            uimanager:ClosePanel(uiMainMenusPanel.LeftCenterPanelName)
            uiMainMenusPanel.LeftCenterPanelName = "UIMagicBossRankPanel"
            uimanager:CreatePanel("UIMagicBossRankPanel", nil, commonData)
        end
    end
end

---创建奖励排行榜
---@param commonData.type
function Utility.CreateRewardRankPanel(commonData)
    if commonData == nil or commonData.type == nil then
        return
    end
    local rankRewardInfo = CS.Cfg_Ranking_Reward_CommonTableManager.Instance:TryGetRankRewardInfoByType(commonData.type)
    if rankRewardInfo ~= nil then
        uimanager:CreatePanel("UIMagicBossRankRewardPanel", nil, { rankRewardInfo = rankRewardInfo })
    end
end

---通用调整特效材质百分比进度
---effectRoot CS.CSEffectRender_Queue
---matListName 需要操作的材质球列表
---textureOffsetName 修改贴图名称
---nowValue 当前百分比值 1-0
---traMin 转换目标最小值
---traMax 转换目标最大值
---offsetType 1 Offset.x 2 Offset.y
function Utility.RefreshEffect(effectRoot, matListName, textureOffsetName, nowValue, traMin, traMax, offsetType)
    if effectRoot == nil then
        return
    end
    local number = Utility.TransformRange(1 - nowValue, 0, 1, traMin, traMax)
    for i = 0, effectRoot.matList.Count - 1 do
        for k, v in pairs(matListName) do
            if effectRoot.matList[i].name == v then
                if offsetType == 1 then
                    effectRoot.matList[i]:SetTextureOffset(textureOffsetName, CS.UnityEngine.Vector2(number, 0))
                elseif offsetType == 2 then
                    effectRoot.matList[i]:SetTextureOffset(textureOffsetName, CS.UnityEngine.Vector2(0, number))
                end
            end
        end
    end
    return number
end

function Utility.TransformRange(OldValue, OldMin, OldMax, NewMin, NewMax)
    return ((OldValue - OldMin) / (OldMax - OldMin)) * (NewMax - NewMin) + NewMin
end

---打开boss任务面板
function Utility.OpenBossTaskPanel()
    local csmission = CS.CSMissionManager.Instance:GetBossTask()
    if csmission ~= nil and csmission.tbl_taskGoalS ~= nil and csmission.tbl_taskGoalS.Count ~= 0 then
        local uiMissionPanel = uimanager:GetPanel("UIMissionPanel")
        if uiMissionPanel ~= nil and uiMissionPanel.missionTemplate ~= nil then
            local task = uiMissionPanel.missionTemplate:SetTaskTemplates(LuaEnumShowTaskType.Boss)
            if task ~= nil then
                local y = task.go.transform.localPosition.y
                if y > -128 then
                    y = -128
                end
                uiMissionPanel.ScrollViewRefresh(y + 10)
                task:BossOnClick()
            end
        end
    end
end

---打开行会物品捐献面板
function Utility.CreateGuildBagItemPanel(bagItemInfo)
    if bagItemInfo == nil then
        return
    end
    local integralItemInfoIsFind, integralItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(1000013)
    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId)
    if itemInfoIsFind == true and integralItemInfoIsFind == true and bagItemInfo ~= nil and itemInfo ~= nil then
        local itemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(bagItemInfo.itemId)
        local info = {}
        info.MaxNum = bagItemInfo.count
        info.priceDate = integralItemInfo
        info.singlePrice = itemInfo.gongXian
        info.BagItemInfo = bagItemInfo
        ---@type UISaleOrePanel_GuildBagPanelInteractionTemplate
        info.Template = luaComponentTemplates.UISaleOrePanel_GuildBagPanelInteractionTemplate
        info.BuyCallBack = function(go, num)
            uiStaticParameter.UnionDonateOverlayItemLid = bagItemInfo.lid
            if num > bagItemInfo.count then
                num = bagItemInfo.count
            end
            networkRequest.ReqDonateEquip(bagItemInfo.lid, num)
            uimanager:ClosePanel('UIAuctionItemPanel')
        end
        uimanager:CreatePanel("UIAuctionItemPanel", nil, info)
    end
end

---此方法仅能获取到 itemid 的列表
---如有其他需求调用：clientTableManager.cfg_monstersManager:GetDropShowList(monsterId)
function Utility.GetBossPanelDropList(bossId)
    local res, bossInfo = CS.Cfg_MonsterTableManager.Instance.dic:TryGetValue(bossId)
    if not res then
        print("BossDic 不存在Key或Value为空")
        return nil
    end
    if (bossInfo.dropShow == nil) then
        return nil
    end
    local mdropList = {}
    local dropinfo = CS.Cfg_BossDropShowTableManager.Instance:GetDropItemList(bossInfo.dropShow.list)
    --有怪物掉落的物品信息
    if (dropinfo ~= nil) then
        --是否满足显示条件
        for i = 0, dropinfo.Length - 1 do
            if (dropinfo[i].displayConditionType == 1) then
            elseif (dropinfo[i].displayConditionType == 2) then
            elseif (dropinfo[i].displayConditionType == 3) then
            elseif (dropinfo[i].displayConditionType == 4) then
            elseif (dropinfo[i].displayConditionType == 5) then
                local list = CS.Cfg_BossDropShowTableManager.Instance:GetMeetDropItemList(dropinfo[i].id)
                for i = 0, list.Count - 1 do
                    table.insert(mdropList, list[i])
                end
            end
        end
    end
    return mdropList
end

---根据bossDropShow表的ID获取一个掉落物品列表
---@param bossDropShowID number
---@return table<number, number>
function Utility.GetBossPanelDropListBySingleBossDropShowID(bossDropShowID)
    if bossDropShowID == nil then
        return {}
    end
    ---@type TABLE.CFG_BOSS_DROP_SHOW
    local bossDropShowTblExist, bossDropShowTbl = CS.Cfg_BossDropShowTableManager.Instance:TryGetValue(bossDropShowID)
    if bossDropShowTbl == nil then
        return {}
    end
    local mdropList = {}
    local displayConditionType = bossDropShowTbl.displayConditionType
    if (displayConditionType == 1) then
    elseif (displayConditionType == 2) then
    elseif (displayConditionType == 3) then
    elseif (displayConditionType == 4) then
    elseif (displayConditionType == 5) then
        local list = CS.Cfg_BossDropShowTableManager.Instance:GetMeetDropItemList(bossDropShowTbl.id)
        for i = 0, list.Count - 1 do
            table.insert(mdropList, list[i])
        end
    end
    return mdropList
end

function Utility.GetBossPanelDropListByList(list)
    if (list == nil) then
        return nil
    end
    local mdropList = {}
    local dropinfo = CS.Cfg_BossDropShowTableManager.Instance:GetDropItemList(list)
    --有怪物掉落的物品信息
    if (dropinfo ~= nil) then
        --是否满足显示条件
        for i = 0, dropinfo.Length - 1 do
            if (dropinfo[i].displayConditionType == 1) then
            elseif (dropinfo[i].displayConditionType == 2) then
            elseif (dropinfo[i].displayConditionType == 3) then
            elseif (dropinfo[i].displayConditionType == 4) then
            elseif (dropinfo[i].displayConditionType == 5) then
                local list = CS.Cfg_BossDropShowTableManager.Instance:GetMeetDropItemList(dropinfo[i].id)
                for i = 0, list.Count - 1 do
                    table.insert(mdropList, list[i])
                end
            end
        end
    end
    return mdropList
end
--region 召唤令快捷设置

---放置召唤令
---isCoerce 是否强制放入
function Utility.PlaceCallToMake(isCoerce)
    local itemID = 8060001
    local configInfo = CS.CSScene.MainPlayerInfo.IConfigInfo
    local isHavaZHL = configInfo:GetInt(CS.EConfigOption.ShortcutItem1) == itemID
            or configInfo:GetInt(CS.EConfigOption.ShortcutItem2) == itemID
            or configInfo:GetInt(CS.EConfigOption.ShortcutItem3) == itemID
            or configInfo:GetInt(CS.EConfigOption.ShortcutItem4) == itemID
    if isHavaZHL then
        return
    end

    local number = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.CallToMakeNumber)
    if number == 0 or isCoerce == true then
        configInfo:SetInt(CS.EConfigOption.ShortcutItem4, itemID)
        number = number + 1
    else
        if configInfo:GetInt(CS.EConfigOption.ShortcutItem1) == 0 then
            configInfo:SetInt(CS.EConfigOption.ShortcutItem1, itemID)
            number = number + 1
        elseif configInfo:GetInt(CS.EConfigOption.ShortcutItem2) == 0 then
            configInfo:SetInt(CS.EConfigOption.ShortcutItem2, itemID)
            number = number + 1
        elseif configInfo:GetInt(CS.EConfigOption.ShortcutItem3) == 0 then
            configInfo:SetInt(CS.EConfigOption.ShortcutItem3, itemID)
            number = number + 1
        elseif configInfo:GetInt(CS.EConfigOption.ShortcutItem4) == 0 then
            configInfo:SetInt(CS.EConfigOption.ShortcutItem4, itemID)
            number = number + 1
        end
    end
    CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(CS.EConfigOption.CallToMakeNumber, number)
    if configInfo:GetInt(CS.EConfigOption.ShowItemShortcut) == 0 then
        configInfo:SetInt(CS.EConfigOption.ShowItemShortcut, 1);
        CS.CSNetwork.SendClientEvent(CS.CEvent.V2_OpenFastUseItem);
    end
end

--endregion

--region 交易行
---@param itemInfo TABLE.CFG_ITEMS 道具信息
---@param go UnityEngine.GameObject
---判断该道具是否需要限制购买等级
function Utility.IsItemCanBuy(itemInfo, go, priceItemID)
    if itemInfo == nil or go == nil then
        return false
    end
    if Utility.IsItemDiamond(priceItemID) then
        ---钻石不限制等级
        return true
    end

    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if Utility.NeedConsiderAuctionCondition() and mainPlayerInfo then
        local limitLevel = 0
        local conditions = LuaGlobalTableDeal.GetAuctionBuyYuanBaoItemLimit()
        if conditions and #conditions > 0 then
            local res, info = CS.Cfg_ConditionManager.Instance.dic:TryGetValue(conditions[1])
            if res then
                if info.conditionParam and info.conditionParam.list.Count > 0 then
                    limitLevel = info.conditionParam.list[0] + 1
                end
            end
        end

        local level = itemInfo.useLv
        local reinLevel = itemInfo.reinLv
        if reinLevel == 0 then
            local levelLimit = LuaGlobalTableDeal.GetAuctionBuyYuanBaoItemLevelLimit(1)
            local playerLevel = mainPlayerInfo.Level
            if levelLimit and playerLevel < level - levelLimit then
                local res, info = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(345)
                if res then
                    local min = math.min(limitLevel, level - levelLimit)
                    local str = string.format(info.content, min)
                    Utility.ShowPopoTips(go, str, 346)
                end
                return false
            end
        else
            local reinLevelLimit = LuaGlobalTableDeal.GetAuctionBuyYuanBaoItemLevelLimit(2)
            local palyerRein = mainPlayerInfo.ReinLevel
            if reinLevelLimit and palyerRein < reinLevel - reinLevelLimit then
                local res, info = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(346)
                if res then
                    local str = string.format(info.content, limitLevel, (reinLevel - reinLevelLimit))
                    Utility.ShowPopoTips(go, str, 345)
                end
                return false
            end
        end
    end
    return true
end

function Utility.NeedConsiderAuctionCondition()
    local conditions = LuaGlobalTableDeal.GetAuctionBuyYuanBaoItemLimit()
    if conditions and #conditions > 0 then
        for i = 1, #conditions do
            if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditions[i]) then
                return false
            end
        end
    end
    return true
end

--endregion

--region 根据行会排名获得对应繁荣度

function Utility.GetUnionActiveValue(rank)
    if CS.CSScene.MainPlayerInfo ~= nil then
        local unionInfo = CS.CSScene.MainPlayerInfo.UnionInfoV2
        --检测霸业是否开启
        if not CS.CSScene.MainPlayerInfo.OpenSystemDic:ContainsKey(43) then
            local isFind, activeValue = unionInfo.UnionProsPerity:TryGetValue(rank)
            if isFind then
                return activeValue
            end
        else
            if unionInfo.PhonyUnionProsPerityList ~= nil and unionInfo.PhonyUnionProsPerityList.Count > rank - 1 then
                return unionInfo.PhonyUnionProsPerityList[rank - 1]
            end
        end
    end
    return 0
end

--endregion

--region 切换模式
---@param type number 组队1/行会2
---@param direction number 左1/右2
function Utility.TryChangeMode(go, type, direction)
    local bubbleId = -1
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        if type == 1 then
            local hasTeam = mainPlayerInfo.GroupInfoV2.IsHaveGroup
            if hasTeam then
                return true
            end
            bubbleId = direction == 1 and 351 or 353
        elseif type == 2 then
            local unionId = mainPlayerInfo.UnionInfoV2.UnionID
            if unionId and unionId > 0 then
                return true
            end
            bubbleId = direction == 1 and 350 or 352
        end
    end
    if bubbleId ~= -1 then
        Utility.ShowPopoTips(go, nil, bubbleId)
    end
    return false
end
--endregion

function Utility.TryFadeOutMainMenusLeft(panelName)
    luaEventManager.DoCallback(LuaCEvent.MainMenus_LeftFadeOut, panelName);
end

---显示condition气泡
function Utility.ShowConditionPop(go, conditionID)
    if CS.StaticUtility.IsNull(go) == true or conditionID == nil then
        return
    end
    local conditionType = CS.Cfg_ConditionManager.Instance:GetConditionType(conditionID)
    if conditionType == CS.EConditionType.NotLowerThan_Level then
        Utility.ShowPopoTips(go.transform, nil, 168)
    end
end

---获取condition参数
function Utility.GetConditionParams(conditionId)
    local conditionType, conditionParams
    local conditionInfoIsFind, conditionInfo = CS.Cfg_ConditionManager.Instance:TryGetValue(conditionId)
    if conditionInfoIsFind == true then
        conditionType = conditionInfo.conditionType
        if conditionType == Utility.EnumToInt(CS.EConditionType.NotLowerThan_Level) or conditionType == Utility.EnumToInt(CS.EConditionType.LowerThan_Level) then
            if conditionInfo.conditionParam ~= nil and conditionInfo.conditionParam.list ~= nil and conditionInfo.conditionParam.list.Count > 0 then
                conditionParams = conditionInfo.conditionParam.list[0]
            end
        end
    end
    return conditionType, conditionParams
end

---技能书是否可以使用
function Utility.SkillBookCanUse(itemId)
    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)

    if itemInfoIsFind and gameMgr:GetPlayerDataMgr() ~= nil then
        return gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():IsCanUseSkillBookByItemInfo(itemInfo)
    end
    return false
end

---判断物品是否可以熔炼
function Utility.IsAvailableForSemelt(itemInfo)
    return itemInfo ~= nil and
            itemInfo.smelt ~= nil and
            itemInfo.smelt.list ~= nil and
            itemInfo.smelt.list.Count > 0
end

---是否是钻石itemId
function Utility.IsDiamondItemId(itemId)
    local diamondIdList = CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList
    if diamondIdList ~= nil and diamondIdList.Count > 0 then
        return diamondIdList:Contains(itemId)
    end
    return false
end

---添加红点
function Utility.RegisterRedPoint(redPoint_GO, redPointKey)
    local uiRedPoint = nil
    if CS.Utility_Lua.IsTypeEqual(redPoint_GO:GetType(), typeof(CS.Top_UIRedPoint)) then
        uiRedPoint = redPoint_GO
    else
        uiRedPoint = CS.Utility_Lua.GetComponent(redPoint_GO.gameObject, "Top_UIRedPoint")
        if uiRedPoint == nil then
            uiRedPoint = CS.Utility_Lua.AddComponent(redPoint_GO.gameObject, "Top_UIRedPoint")
        end
    end
    if uiRedPoint ~= nil and CS.StaticUtility.IsNull(uiRedPoint) == false then
        uiRedPoint:AddRedPointKey(redPointKey)
    end
end

--region 精力腕力

---是否腕力已经达到上限
---@return boolean
function Utility.IsWristStrengthBoundMax()
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.BuffInfo ~= nil then
        local isHas, buffInfo = CS.CSScene.MainPlayerInfo.BuffInfo:IsHasBuffAndOutInfo(610000008)
        if isHas and buffInfo.Info ~= nil then
            return buffInfo.Info.bufferValue >= LuaGlobalTableDeal:GetWristStrengthMaxValue()
        end
    end
    return false
end

---是否精力已经达到上限
---@return boolean
function Utility.IsEnergyBoundMax()
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.BuffInfo ~= nil then
        local isHas, buffInfo = CS.CSScene.MainPlayerInfo.BuffInfo:IsHasBuffAndOutInfo(610000009)
        if isHas and buffInfo.Info ~= nil then
            return buffInfo.Info.bufferValue >= LuaGlobalTableDeal:GetEnergyMaxValue()
        end
    end
    return false
end

---是否无腕力
---@return boolean
function Utility.IsWristStrengthZero()
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.BuffInfo ~= nil then
        local isHas, buffInfo = CS.CSScene.MainPlayerInfo.BuffInfo:IsHasBuffAndOutInfo(610000008)
        if isHas and buffInfo.Info ~= nil then
            return buffInfo.Info.bufferValue <= 0
        end
    end
    return true
end

---是否无精力
---@return boolean
function Utility.IsEnergyZero()
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.BuffInfo ~= nil then
        local isHas, buffInfo = CS.CSScene.MainPlayerInfo.BuffInfo:IsHasBuffAndOutInfo(610000009)
        if isHas and buffInfo.Info ~= nil then
            return buffInfo.Info.bufferValue <= 0
        end
    end
    return true
end

--endregion
---字符串拼接
function string.CSFormat(format, ...)
    assert(format ~= nil, "Format error:Invalid Format String")
    local parms = { ... }
    local function search(k)
        k = k + 1
        assert(k <= #parms and k >= 0, "Format error:IndexOutOfRange")
        return tostring(parms[k])
    end
    local resultStr = string.gsub(format, "{(%d)}", search);
    return resultStr;
end
--endregion

--region 上古战场
function Utility.CanEnterAncientBattlefileldMap(mapId)
    ---如果是上古战场地图，判断战勋
    local res, mapInfo = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(mapId)
    if res then
        if mapInfo.announceDeliver == 1054 then
            local res2, duplicateInfo = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(mapId)
            if res2 then
                local conditionId = duplicateInfo.condition
                local CanEnter = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionId)
                return CanEnter
            end
        end
    end
    return true
end
--endregion

---c#字典转表
function Utility.CSDicChangeTable(dic)
    local curDic = {}
    CS.Utility_Lua.luaForeachCsharp:Foreach(dic, function(k, v)
        curDic[k] = v
    end)
    return curDic
end

---c#列表转表
function Utility.CSListChangeTable(list)
    local curList = {}
    if list == nil then
        return curList
    end
    local length = list.Count
    for k = 0, length - 1 do
        table.insert(curList, list[k])
    end
    return curList
end

--region 挑战Boss
---是否满足条件
function Utility.IsMeetBossCondition(bossTable)
    if bossTable == nil then
        return false
    end
    local isMeet = true
    if bossTable:GetLevel() ~= nil then
        local conditionList = bossTable:GetLevel().list
        isMeet = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(conditionList)
    end
    return isMeet
end

--endregion

--region 主城相关
---获取最近经过的主城
---@return LuaEnumMainCity
function Utility.GetRecentPassedMainCity()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.MapInfoV2 == nil then
        return LuaEnumMainCity.None
    end
    return Utility.GetMainCityType(CS.CSScene.MainPlayerInfo.MapInfoV2.RecentMainCityMapID)
end

---获取当前主城
---@return LuaEnumMainCity
function Utility.GetCurrentMainCity()
    if CS.CSScene.MainPlayerInfo == nil then
        return LuaEnumMainCity.None
    end
    return Utility.GetMainCityType(CS.CSScene.MainPlayerInfo.MapID)
end

---根据MapID获取主城类型
---@param mapID number
---@return LuaEnumMainCity
function Utility.GetMainCityType(mapID)
    if mapID == 1001 or mapID == 1009 then
        return LuaEnumMainCity.BiQi
    elseif mapID == 1002 then
        return LuaEnumMainCity.MengZhong
    elseif mapID == 1011 then
        return LuaEnumMainCity.MaFaSenLin
    elseif mapID == 1021 then
        return LuaEnumMainCity.LvZhou
    elseif mapID == 1003 then
        return LuaEnumMainCity.ShaBaKe
    elseif mapID == 1006 then
        return LuaEnumMainCity.BaiRiMen
    else
        return LuaEnumMainCity.None
    end
end

---获取字符串是否是主城的结果
---@return LuaEnumMainCity
function Utility.IsMainCity(str)
    local lowerStr = string.lower(str)
    if lowerStr == "biqi" then
        return LuaEnumMainCity.BiQi
    elseif lowerStr == "mengzhong" then
        return LuaEnumMainCity.MengZhong
    elseif lowerStr == "bairimen" then
        return LuaEnumMainCity.BaiRiMen
    elseif lowerStr == "mafasenlin" then
        return LuaEnumMainCity.MaFaSenLin
    elseif lowerStr == "shabake" then
        return LuaEnumMainCity.ShaBaKe
    elseif lowerStr == "lvzhou" then
        return LuaEnumMainCity.LvZhou
    else
        return LuaEnumMainCity.None
    end
end
--endregion

--region 获取途径
---解析获取途径寻路类型,返回最佳匹配的寻路参数集合
---@alias WayGetTblOpenPanelData {deliverID:number,conditionID:number,bubbleID:number}
---@param wayGetTblOpenPanel string
---@return WayGetTblOpenPanelData
function Utility.ParseWayGetFindPathAndOpenFlyShoeOpenPanel(wayGetTblOpenPanel)
    local strs1 = string.Split(wayGetTblOpenPanel, '&')
    ---@type table<number,WayGetTblOpenPanelData>
    local resTbl = {}
    for i = 1, #strs1 do
        local strTemp = strs1[i]
        local strs2 = string.Split(strTemp, '#')
        local deliverID = 0
        local conditionID = nil
        local bubbleID = nil
        if #strs2 > 0 then
            deliverID = tonumber(strs2[1])
        end
        if #strs2 > 1 then
            conditionID = tonumber(strs2[2])
        end
        if #strs2 > 2 then
            bubbleID = tonumber(strs2[3])
        end
        table.insert(resTbl, { deliverID = deliverID, conditionID = conditionID, bubbleID = bubbleID })
    end
    local mainCity = Utility.GetRecentPassedMainCity()
    if mainCity == LuaEnumMainCity.None then
        if #resTbl > 0 then
            return resTbl[1]
        end
    end
    local deliverTblMgr = CS.Cfg_DeliverTableManager.Instance
    for i = 1, #resTbl do
        if resTbl[i].deliverID ~= nil and resTbl[i].deliverID ~= 0 then
            ---@type TABLE.CFG_DELIVER
            local deliverTblExist, deliverTbl = deliverTblMgr:TryGetValue(resTbl[i].deliverID)
            if deliverTbl then
                local mainCityTemp = Utility.IsMainCity(deliverTbl.region)
                if mainCityTemp then
                    if mainCityTemp == mainCity then
                        return resTbl[i]
                    end
                end
            end
        end
    end
    if #resTbl > 0 then
        return resTbl[1]
    end
    return nil
end
--endregion

--region 距离
---计算两点之间的距离（二维）
---@return number 距离（可能为nil）
function Utility.CalculateDistance(x1, y1, x2, y2)
    local firstVector2 = CS.UnityEngine.Vector2(x1, y1)
    local secondVector2 = CS.UnityEngine.Vector2(x2, y2)
    if firstVector2 ~= nil and secondVector2 ~= nil then
        local distance = CS.UnityEngine.Vector2.Distance(firstVector2, secondVector2)
        return distance
    end
end

---主角到目标点的距离
---@return number 距离（可能为nil）
function Utility.MainPlayerToTargetDistance(x, y)
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.Owner ~= nil and CS.CSScene.MainPlayerInfo.Owner.OldCell ~= nil and CS.CSScene.MainPlayerInfo.Owner.OldCell.Coord ~= nil then
        local mainPlayerCoord = CS.CSScene.MainPlayerInfo.Owner.OldCell.Coord
        if mainPlayerCoord ~= nil then
            return Utility.CalculateDistance(x, y, mainPlayerCoord.x, mainPlayerCoord.y)
        end
    end
end
---@type number 活动期间铁矿消耗的数量记录
Utility.BlackIronCost = 0
--endregion

---@param ServantManaData servantV2.ServantMana
---@return boolean 聚灵是否可领免费奖励
function Utility.CanGetServantFreeAward(ServantManaData)
    if (ServantManaData == nil) then
        return false
    end
    return not ServantManaData.receiveToday
end
---@param ServantManaData servantV2.ServantMana
---@return number 聚灵是否可领充值奖励 0:未充值,1:充值未领取,2:领取过,
function Utility.CanGetServantRechargeAward(ServantManaData)
    if (ServantManaData == nil) then
        return 0
    end
    if (ServantManaData.rechargeToday == false) then
        return 0
    elseif (ServantManaData.receiveRecharge) then
        return 2
    else
        return 1
    end
end

---行会地牢气泡显示
function Utility.GuildDungeonPrompShow()
    if uimanager:GetPanel("UIGuildPalaceLeftMainPanel") then
        Utility.RemoveFlashPrompt(1, 35)
        return
    end
    local AtciveID = Utility.GetNowGuildDungeonAtciveID()
    if AtciveID == 0 or AtciveID == nil then
        Utility.RemoveFlashPrompt(1, 35)
        return
    end
    if LuaGlobalTableDeal.GuildDungeonPrompShowListUpdate ~= nil then
        LuaGlobalTableDeal.GuildDungeonPrompShowListUpdate:Reset()
        CS.CSListUpdateMgr.Instance:Remove(LuaGlobalTableDeal.GuildDungeonPrompShowListUpdate)
    end
    local time = LuaGlobalTableDeal:GetUnionDungeonBubbleTime()
    LuaGlobalTableDeal.GuildDungeonPrompShowListUpdate = CS.CSListUpdateMgr.Add(time, nil, function()
        Utility.RemoveFlashPrompt(1, 35)
    end)
    CS.CSListUpdateMgr.Instance:Add(LuaGlobalTableDeal.GuildDungeonPrompShowListUpdate)
    Utility.GuildDungeonPrompUpdate()
end

function Utility.GuildDungeonPrompUpdate()
    if Utility.UnionDungeonEnterLimit() == false then
        Utility.RemoveFlashPrompt(1, 35)
        return
    end
    local PromptWordId = 133
    local dataID = 35
    local des = "--"
    local daily_activity_timeID = Utility.GetNowGuildDungeonAtciveID()
    local duplicateId = 24001
    local showEndTime = Utility.GetActivitySurplusTime(daily_activity_timeID)
    local windowEndTime = CS.CSServerTime.Instance.TotalMillisecond + LuaGlobalTableDeal:GetUnionDungeonBubbleTime()
    local activityTbl = clientTableManager.cfg_daily_activity_timeManager:TryGetValue(daily_activity_timeID)
    if activityTbl then
        local startTime = activityTbl:GetStartTime()
        local endTime = activityTbl:GetOverTime()
        des = Utility.MinutesToHours(startTime) .. "-" .. Utility.MinutesToHours(endTime)
    end

    local data = {}
    data.id = dataID
    data.clickCallBack = function()
        local TipData = {}
        TipData.PromptWordId = PromptWordId
        TipData.des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(PromptWordId, des)
        TipData.Time = windowEndTime
        TipData.ComfireAucion = function()
            Utility.RemoveFlashPrompt(1, dataID)
            if Utility.IsMainPlayerHasGuild() then
                networkRequest.ReqEnterDuplicate(duplicateId)
                CS.CSScene.MainPlayerInfo.AsyncOperationController:Stop()
                CS.CSPathFinderManager.Instance:Reset()
            else
                local showUnionPush = CS.CSListUpdateMgr.Add(10, nil, function()
                    Utility.ShowUnionPush()
                end)
                CS.CSListUpdateMgr.Instance:Add(showUnionPush)
            end
        end
        TipData.CancelCallBack = function()
            Utility.RemoveFlashPrompt(1, dataID)
        end

        TipData.CloseCallBack = function()
            uimanager:ClosePanel('UIPromptPanel')
        end

        TipData.TimeCallBack = function(UICountdownLabel)
            UICountdownLabel:StartCountDown(nil, 7, windowEndTime, "[bb3520]", "内有效[-]", nil, function()
                uimanager:ClosePanel("UIPromptPanel")
            end)
        end
        Utility.ShowSecondConfirmPanel(TipData)
    end
    Utility.TryAddFlashPromp(data)
end

---分钟转换小时 列 600分钟--> 10：00
function Utility.MinutesToHours(minutes)
    if minutes == nil or tonumber(minutes) == nil then
        return ""
    end
    local h = math.modf(tonumber(minutes) / 60)
    local m = math.fmod(tonumber(minutes), 60)
    local hDes = tostring(h)
    local mDes = tostring(m)

    if h < 10 then
        hDes = "0" .. tostring(h)
    end
    if m < 10 then
        mDes = "0" .. tostring(m)
    end
    return hDes .. ":" .. mDes
end

---得到活动剩余时间
---return number
function Utility.GetActivitySurplusTime(activeID)
    local TodayTimeStamp = gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()
    local activityTbl = clientTableManager.cfg_daily_activity_timeManager:TryGetValue(activeID)
    if activityTbl then
        local endTime = activityTbl:GetOverTime()
        return TodayTimeStamp + endTime * 60 * 1000
    end
    return TodayTimeStamp
end

---得到当前帮会分级信息
---return number 1 第一行会 2 第二行会 3 其他
function Utility.GetMyUnionClassificationInfo()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.UnionInfoV2 == nil or CS.CSScene.MainPlayerInfo.UnionInfoV2.AllUnionInfo == nil then
        return 3
    end
    local myUnionInfo = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionInfo
    if myUnionInfo == nil or myUnionInfo.unionInfo == nil then
        return 3
    end
    if tonumber(myUnionInfo.unionInfo.rank) <= 2 then
        return myUnionInfo.unionInfo.rank
    end
    return 3
end

---@return boolean 判断玩家是否有行会true有/false没有
function Utility.IsMainPlayerHasGuild()
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        local UnionInfo = mainPlayerInfo.UnionInfoV2.UnionInfo
        if UnionInfo then
            return UnionInfo.UnionID ~= 0
        end
    end
    return false
end

---请求刷新灵兽修炼红点数据
function Utility.CallServantPracticeRedPoint()
    --请求数据
    networkRequest.ReqServantCultivateOpenDlg(1)
    networkRequest.ReqServantCultivateBegin(0)
end

---根据灵兽类型获得灵兽修炼红点类型
function Utility.GetServantPracticeRedPointType(servantType)
    if servantType == 1 then
        return LuaRedPointName.ServantPractice_HM
    elseif servantType == 2 then
        return LuaRedPointName.ServantPractice_LX
    elseif servantType == 3 then
        return LuaRedPointName.ServantPractice_TC
    end
end

---判断灵兽是否处于上阵/合体/死亡状态
function Utility.IsServantBattle(servantType)
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        local seatData = mainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(servantType)
        if seatData then
            local isBattle = seatData.State == CS.CSServantSeatData.SeatState.Battle
            local isCombined = seatData.State == CS.CSServantSeatData.SeatState.Combined
            local isDead = seatData.State == CS.CSServantSeatData.SeatState.Dead
            return isBattle or isCombined or isDead
        end
    end
    return false
end

---@return number 根据道具信息获得装备位
function Utility.GetEquipIndexByBagItemInfo(bagItemInfo)
    local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
    if res then
        return Utility.GetEquipIndexByItemInfo(itemInfo)
    end
    return 0
end

---@return number 根据道具信息获得装备位
---@param itemInfo TABLE.CFG_ITEMS
function Utility.GetEquipIndexByItemInfo(itemInfo)
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if itemInfo and itemInfo.type == 2 and mainPlayerInfo then
        local subType = itemInfo.subType
        if subType == LuaEnumEquipSubType.Equip_wuqi then
            return 1
        elseif subType == LuaEnumEquipSubType.Equip_toukui then
            return 2
        elseif subType == LuaEnumEquipSubType.Equip_yifu then
            return 3
        elseif subType == LuaEnumEquipSubType.Equip_yaodai then
            return 7
        elseif subType == LuaEnumEquipSubType.Equip_xiezi then
            return 8
        elseif subType == LuaEnumEquipSubType.Equip_xianglian then
            return 4
        elseif subType == LuaEnumEquipSubType.Equip_face then
            return 24
        elseif subType == LuaEnumEquipSubType.Equip_jiezhi then
            local index = mainPlayerInfo.EquipInfo:GetEmptyIndexByEquipSubType(subType)
            if index == 0 then
                index = mainPlayerInfo.EquipInfo:GetLessAttackEquipByEquipSubType(subType)
            end
            return index
        elseif subType == LuaEnumEquipSubType.Equip_shouzhuo then
            local index = mainPlayerInfo.EquipInfo:GetEmptyIndexByEquipSubType(subType)
            if index == 0 then
                index = mainPlayerInfo.EquipInfo:GetLessAttackEquipByEquipSubType(subType)
            end
            return index
        elseif subType == LuaEnumEquipSubType.Equip_yuanlingmibao then
            return 18
        elseif subType == LuaEnumEquipSubType.Equip_chiyandeng then
            return 13
        elseif subType == LuaEnumEquipSubType.Equip_hunyu then
            return 15
        elseif subType == LuaEnumEquipSubType.Equip_baoshishoutao then
            return 21
        elseif subType == LuaEnumEquipSubType.Equip_xunzhang then
            return 22
        elseif subType == LuaEnumEquipSubType.Equip_doublexunzhang then
            return 22
        elseif subType == LuaEnumEquipSubType.Equip_maPai then
            return 28
        elseif subType == LuaEnumEquipSubType.Equip_AnQi then
            return 29
        end
    end
    return 0
end

---获取任意道具应该装备的装备位
---@param itemTbl TABLE.cfg_items luaTbl
function Utility.GetEquipIndexesByLuaItemTbl(itemTbl)
    local returnList = {};
    if (itemTbl ~= nil) then
        if itemTbl:GetType() == luaEnumItemType.Equip then
            local subType = itemTbl:GetSubType();
            if subType == LuaEnumEquipSubType.Equip_wuqi then
                table.insert(returnList, 1);
            elseif subType == LuaEnumEquipSubType.Equip_toukui then
                table.insert(returnList, 2);
            elseif subType == LuaEnumEquipSubType.Equip_yifu then
                table.insert(returnList, 3);
            elseif subType == LuaEnumEquipSubType.Equip_yaodai then
                table.insert(returnList, 7);
            elseif subType == LuaEnumEquipSubType.Equip_xiezi then
                table.insert(returnList, 8);
            elseif subType == LuaEnumEquipSubType.Equip_xianglian then
                table.insert(returnList, 4);
            elseif subType == LuaEnumEquipSubType.Equip_face then
                table.insert(returnList, 24);
            elseif subType == LuaEnumEquipSubType.Equip_jiezhi then
                table.insert(returnList, 6);
                table.insert(returnList, 61);
            elseif subType == LuaEnumEquipSubType.Equip_shouzhuo then
                table.insert(returnList, 5);
                table.insert(returnList, 51);
            elseif subType == LuaEnumEquipSubType.Equip_yuanlingmibao then
                table.insert(returnList, 18);
            elseif subType == LuaEnumEquipSubType.Equip_chiyandeng then
                table.insert(returnList, 13);
            elseif subType == LuaEnumEquipSubType.Equip_hunyu then
                table.insert(returnList, 15);
            elseif subType == LuaEnumEquipSubType.Equip_baoshishoutao then
                table.insert(returnList, 21);
            elseif subType == LuaEnumEquipSubType.Equip_xunzhang then
                table.insert(returnList, 22);
            elseif subType == LuaEnumEquipSubType.Equip_doublexunzhang then
                table.insert(returnList, 22);
            end
        end
    end
    return returnList;
end

function Utility.IsKuaFuMap(mapId)
    local res, mapInfo = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(mapId)
    if res then
        return mapInfo.serverType == 2
    end
    return false;
end

--region openSystem

---客户端功能开启添加
---@param id number notice表id
function Utility.AddClientSystem(id)
    luaclass.LuaSystemInfo:AddClientSystem(id)
end

---客户端功能开启移除
---@param id number notice表id
function Utility.RemoveClientSystem(id)
    luaclass.LuaSystemInfo:RemoveClientSystem(id)
end

---检测功能是否开启(系统)
---@param id number notice表id
---@return boolean
function Utility.CheckSystemOpenState(id)
    return luaclass.LuaSystemInfo:CheckSystemOpenState(id)
end

--endregion

--region 血继通用方法
---获取血继装备职业属性
---@param tblData TABLE.IntListJingHao
function Utility.DealBloodSuitEquipCareerAttribute(tblData)
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if tblData and tblData.list and mainPlayerInfo then
        local career = Utility.EnumToInt(mainPlayerInfo.Career)
        if career == 1 or career == 2 or career == 3 then
            if career <= #tblData.list then
                return tblData.list[career]
            end
        end
    end
    return 0
end

---获取血继装备属性
---@param itemId number 道具id
---@param level number 血继等级
---@param attributeType LuaEnumAttributeType 属性类型
---@return string,number,number 属性名/最低属性值/最高属性值
function Utility.GetBloodSuitEquipAttribute(itemId, level, attributeType)
    local data = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemId)

    local lowBaseData
    local highBaseData
    if attributeType == LuaEnumAttributeType.MaxHp then
        local hp = data:GetMaxHp()
        highBaseData = Utility.DealBloodSuitEquipCareerAttribute(hp)
    elseif attributeType == LuaEnumAttributeType.PhyAttackMax then
        lowBaseData = data:GetPhyAttackMin()
        highBaseData = data:GetPhyAttackMax()
    elseif attributeType == LuaEnumAttributeType.MagicAttackMax then
        lowBaseData = data:GetMagicAttackMin()
        highBaseData = data:GetMagicAttackMax()
    elseif attributeType == LuaEnumAttributeType.TaoAttackMax then
        lowBaseData = data:GetTaoAttackMin()
        highBaseData = data:GetTaoAttackMax()
    elseif attributeType == LuaEnumAttributeType.PhyDefenceMax then
        local phyDefenceMin = data:GetPhyDefenceMinByCareer()
        lowBaseData = Utility.DealBloodSuitEquipCareerAttribute(phyDefenceMin)
        local phyDefenceMax = data:GetPhyDefenceMaxByCareer()
        highBaseData = Utility.DealBloodSuitEquipCareerAttribute(phyDefenceMax)
    elseif attributeType == LuaEnumAttributeType.MagicDefenceMax then
        local magicDefenceMin = data:GetMagicDefenceMinByCareer()
        lowBaseData = Utility.DealBloodSuitEquipCareerAttribute(magicDefenceMin)
        local magicDefence = data:GetMagicDefenceMaxByCareer()
        highBaseData = Utility.DealBloodSuitEquipCareerAttribute(magicDefence)
    elseif attributeType == LuaEnumAttributeType.HolyAttackMax then
        lowBaseData = data:GetHolyAttackMin()
        highBaseData = data:GetHolyAttackMax()
    elseif attributeType == LuaEnumAttributeType.HolyDefenceMax then
        lowBaseData = data:GetHolyDefenceMin()
        highBaseData = data:GetHolyDefenceMax()
    elseif attributeType == LuaEnumAttributeType.Critical then
        highBaseData = data:GetCriticalDamage()
    end
    local attributeName = uiStaticParameter.mAttributeData[attributeType]
    local leftAttr
    local rightAttr

    local addRate = clientTableManager.cfg_bloodsuit_levelManager:TryGetValue(level)
    local rate = 1
    if addRate ~= nil then
        rate = (addRate:GetParams() / 10000)
    end
    if lowBaseData then
        leftAttr = math.ceil(rate * lowBaseData)
    end
    if highBaseData then
        rightAttr = math.ceil(rate * highBaseData)
    end
    return attributeName, leftAttr, rightAttr
end

--endregion

--region 维修
---道具是否需要维修
---@param bagIemInfo bagV2.BagItemInfo
---@return boolean true需要维修/false不需要维修
function Utility:IsItemNeedRepair(bagIemInfo)
    return Utility:GetItemRepairReason(bagIemInfo) == 0
end

---@return number 返回不可维修气泡id 0可以维修/35耐久已满/181不可维修
function Utility:GetItemRepairReason(bagIemInfo)
    if bagIemInfo then
        local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagIemInfo.itemId)
        if itemInfo then
            local career = CS.CSScene.MainPlayerInfo.Career
            ---耐久度未满需要维修
            local lastingNotFull = bagIemInfo.currentLasting < itemInfo:GetMaxLasting()
            if not lastingNotFull then
                return 35
            end

            ---维修有花费货币
            local costRepair = itemInfo:GetRepairCost() and itemInfo:GetRepairCost().list and itemInfo:GetRepairCost().list.Count > 0 and itemInfo:GetRepairCost().list[0].list
            if not costRepair then
                return 181
            end

            ---本职业可维修
            local careerNeedRepair = itemInfo:GetType() == luaEnumItemType.Equip and (Utility.EnumToInt(career) == itemInfo:GetCareer() or itemInfo:GetCareer() == LuaEnumCareer.Common)
            if not careerNeedRepair then
                return 181
            end
        end
    end
    return 0
end

--endregion


---item表格数据的缓存
Utility.ItemTABLECacheDic = {}

---得到lua的道具表
---@param bagItemInfo bagV2.BagItemInfo
---@return TABLE.cfg_items lua的cfg_item表
function Utility.GetItemTblByBagItemInfo(bagItemInfo)
    if (bagItemInfo == nil) then
        return nil
    end
    local Lua_ItemTABLE = nil
    if type(bagItemInfo) == 'table' then
        --lua的bagItemInfo
        if (bagItemInfo.Lua_ItemTABLE == nil) then
            bagItemInfo.Lua_ItemTABLE = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
        end
        Lua_ItemTABLE = bagItemInfo.Lua_ItemTABLE
    else
        if (Utility.ItemTABLECacheDic[bagItemInfo.itemId] == nil) then
            Utility.ItemTABLECacheDic[bagItemInfo.itemId] = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
        end
        Lua_ItemTABLE = Utility.ItemTABLECacheDic[bagItemInfo.itemId]
    end
    return Lua_ItemTABLE
end

---DivineSuit表格数据的缓存
Utility.DivineSuitTABLECacheDic = {}

---得到lua的套装表
---@param bagItemInfo bagV2.BagItemInfo
---@return TABLE.cfg_divinesuit lua的cfg_divineSuit表
function Utility.GetDivineSuitTblByBagItemInfo(bagItemInfo)
    if (bagItemInfo == nil or Utility.GetItemTblByBagItemInfo(bagItemInfo) == nil or Utility.GetItemTblByBagItemInfo(bagItemInfo):GetDivineId() == nil) then
        return nil
    end
    local Lua_DivineSuitTABLE = nil
    if type(bagItemInfo) == 'table' then
        if (bagItemInfo.Lua_DivineSuitTABLE == nil) then
            bagItemInfo.Lua_DivineSuitTABLE = clientTableManager.cfg_divinesuitManager:TryGetValue(Utility.GetItemTblByBagItemInfo(bagItemInfo):GetDivineId())
        end
        Lua_DivineSuitTABLE = bagItemInfo.Lua_DivineSuitTABLE
    else
        if (Utility.DivineSuitTABLECacheDic[bagItemInfo.itemId] == nil) then
            Utility.DivineSuitTABLECacheDic[bagItemInfo.itemId] = clientTableManager.cfg_divinesuitManager:TryGetValue(Utility.GetItemTblByBagItemInfo(bagItemInfo):GetDivineId())
        end
        Lua_DivineSuitTABLE = Utility.DivineSuitTABLECacheDic[bagItemInfo.itemId]
    end
    return Lua_DivineSuitTABLE
end

---得到lua的套装表
---@param id number 道具表的ID
---@return TABLE.cfg_divinesuit lua的cfg_divineSuit表
function Utility.GetDivineSuitTblByBagItemID(id)
    if (id == nil) then
        return nil
    end

    if (Utility.ItemTABLECacheDic[id] == nil) then
        Utility.ItemTABLECacheDic[id] = clientTableManager.cfg_itemsManager:TryGetValue(id)
    end

    local Lua_DivineSuitTABLE = nil
    if (Utility.DivineSuitTABLECacheDic[id] == nil) then
        Utility.DivineSuitTABLECacheDic[id] = clientTableManager.cfg_divinesuitManager:TryGetValue(Utility.ItemTABLECacheDic[id]:GetDivineId())
    end
    Lua_DivineSuitTABLE = Utility.DivineSuitTABLECacheDic[id]
    return Lua_DivineSuitTABLE
end

---DivineSuitLevel表格数据的缓存
Utility.Lua_DivineLevelUpDic = {}

---得到lua的套装表
---@param bagItemInfo bagV2.BagItemInfo
---@return TABLE.cfg_divinelevelup lua的cfg_divineSuit表
function Utility.GetDivineLevelUpTblByBagItemInfo(bagItemInfo)
    if (bagItemInfo == nil or Utility.GetItemTblByBagItemInfo(bagItemInfo) == nil or Utility.GetItemTblByBagItemInfo(bagItemInfo):GetDivineId() == nil) then
        return nil
    end
    local Lua_DivineLevelUpTbl = nil
    if type(bagItemInfo) == 'table' then
        if (bagItemInfo.Lua_DivineLevelUpTbl == nil) then
            bagItemInfo.Lua_DivineLevelUpTbl = clientTableManager.cfg_divinelevelupManager:TryGetValue(bagItemInfo.itemId)
        end
        Lua_DivineLevelUpTbl = bagItemInfo.Lua_DivineLevelUpTbl
    else
        if (Utility.Lua_DivineLevelUpDic[bagItemInfo.itemId] == nil) then
            Utility.Lua_DivineLevelUpDic[bagItemInfo.itemId] = clientTableManager.cfg_divinelevelupManager:TryGetValue(bagItemInfo.itemId)
        end
        Lua_DivineLevelUpTbl = Utility.DivineSuitTABLECacheDic[bagItemInfo.itemId]
    end
    return Lua_DivineLevelUpTbl
end

---购买直购礼包
---@param rechargeTbl TABLE.cfg_recharge
function Utility.PayRechargeItem(rechargeTbl)
    if rechargeTbl == nil then
        return
    end
    Utility.SetPayRechargePoint()
    if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor then
        networkRequest.ReqGM("@43 " .. tostring(rechargeTbl:GetId()))
    else
        local data = Utility:GetPayData(rechargeTbl)
        if (data ~= nil) then
            CS.SDKManager.GameInterface:Pay(data:GetPayParams())
        end
    end
end

---设置充值路径埋点
function Utility.SetGiftRechargePoint()
    if (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Shop) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ShopPanelToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ShopDiamondNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ShopPanelDiamondNotEnoughToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ShopIngotNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ShopPanelIngotNotEnoughToBuyRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ShopDiamondGetWay) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ShopPanelDiamondGetWayToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ShopIngotGetWay) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ShopPanelIngotGetWayToBuyRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Reward) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.RewardPanelToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.FirstRecharge) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.FirstRechargePanelToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.AuctionDiamondNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.AuctionDiamondNotEnoughToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.AuctionIngotNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.AuctionIngotNotEnoughToBuyRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.AuctionDiamondGetWay) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.AuctionDiamondGetWayToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.AuctionIngotGetWay) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.AuctionIngotGetWayToBuyRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BuyDailyTaskDiamondNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BuyDailyTaskDiamondNotEnoughToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CommerceShopDiamondNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CommerceShopDiamondNotEnoughToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CommerceShopGemsNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CommerceShopGemsNotEnoughToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CommercePanel) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CommercePanelDiamondNotEnoughToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ContinueRecharge) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ContinueRechargeToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CommercePanelIngotNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CommercePanelIngotNotEnoughToBuyRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CommerceShopIngotNotEngough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CommerceShopIngotNotEnoughToBuyRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.SecondServantSiteCurrencyNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.SecondServantSiteDiamondNotEnoughToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ThirdServantSiteCurrencyNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ThirdServantSiteDiamondNotEnoughToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.TaskOpenRechargePanel) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.TaskRechargePanelToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.DiamondRechargeGiftPanel) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.DiamondRechargeGiftPanelNotEnoughToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.SynthesisPanel) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.SynthesisPanelMaterialsNotEnoughToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BagIngotGetWay) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BagIngotGetWayToBuyRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.NPCStoreIngotNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.NPCStoreIngotNotEnoughToBuyRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.SecondServantSiteIngotNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.SecondServantSiteIngotNotEnoughToBuyRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ThirdServantSiteIngotNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ThirdServantSiteIngotNotEnoughToBuyRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.DiamondToPushGiftPanel) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.DiamondToPushGiftPanelToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ServantGatherSoulPanel) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ServantGatherSoulPanelToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ServantMagicWeapon) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ServantMagicWeaponToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.MagicBossPanel) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.MagicBossPanelToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BagDiamondGetWay) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BagPanelDiamondGetWayToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.DayRecharge) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.DayRechargeToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CrossServerRechargeToReward) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CrossServerRechargeToRewardToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CrossServerLimitGift) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CrossServerLimitGiftToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.IngotGiftToReward) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.IngotGiftToRewardToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Investment) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.InvestmentToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Carnival) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CarnivalToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CrawlTower) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CrawlTowerToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.PlayerDead) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.PlayerDeadToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.PotentialInvest) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.PotentialInvestToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.MemberPromote) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.MemberPromoteToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.MemberGift) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.MemberGiftToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BerserkPower) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BerserkPowerToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.QuickAuctionBuy) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.QuickAuctionBuyToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.QuickShopBuy) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.QuickShopBuyToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BuyExpElixir) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BuyExpElixirToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.PracticeRoom) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.PracticeRoomToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.AuthenticateDiamondNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.AuthenticateDiamondNotEnoughToRewardGift
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.UnionInspireDiamondNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.UnionInspireDiamondNotEnoughToRewardGift
    else
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ShopPanelToRewardGift
    end
    --print("---购买", uiStaticParameter.RechargePoint)
end

function Utility.SetPayRechargePoint()
    if (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Shop) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ShopPanelToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ShopDiamondNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ShopPanelDiamondNotEnoughToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ShopIngotNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ShopPanelIngotNotEnoughToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ShopDiamondGetWay) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ShopPanelDiamondGetWayToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ShopIngotGetWay) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ShopPanelIngotGetWayToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Reward) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.RewardPanelToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.FirstRecharge) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.FirstRechargePanelToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.AuctionDiamondNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.AuctionDiamondNotEnoughToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.AuctionIngotNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.AuctionIngotNotEnoughToReCharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.AuctionDiamondGetWay) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.AuctionDiamondGetWayToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.AuctionIngotGetWay) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.AuctionIngotGetWayToReCharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BuyDailyTaskDiamondNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BuyDailyTaskDiamondNotEnoughToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CommerceShopDiamondNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CommerceShopDiamondNotEnoughToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CommerceShopGemsNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CommerceShopGemsNotEnoughToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CommercePanel) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CommercePanelDiamondNotEnoughToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CommercePanelIngotNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CommercePanelIngotNotEnoughToReCharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CommerceShopIngotNotEngough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CommerceShopIngotNotEnoughToReCharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ContinueRecharge) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ContinueRechargeToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.SecondServantSiteCurrencyNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.SecondServantSiteDiamondNotEnoughToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ThirdServantSiteCurrencyNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ThirdServantSiteDiamondNotEnoughToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.TaskOpenRechargePanel) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.TaskRechargePanelToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.DiamondRechargeGiftPanel) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.DiamondRechargeGiftPanelNotEnoughToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.SynthesisPanel) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.SynthesisPanelMaterialsNotEnoughToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BagIngotGetWay) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BagIngotGetWayToReCharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.NPCStoreIngotNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.NPCStoreIngotNotEnoughToReCharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.SecondServantSiteIngotNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.SecondServantSiteIngotNotEnoughToReCharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ThirdServantSiteIngotNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ThirdServantSiteIngotNotEnoughToReCharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.DiamondToPushGiftPanel) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.DiamondToPushGiftPanelToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ServantGatherSoulPanel) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ServantGatherSoulPanelToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ServantMagicWeapon) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ServantMagicWeaponToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.MagicBossPanel) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.MagicBossPanelToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BagDiamondGetWay) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BagPanelDiamondGetWayToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.DayRecharge) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.DayRechargeToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CrossServerRechargeToReward) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CrossServerRechargeToRewardToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CrossServerLimitGift) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CrossServerLimitGiftToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.IngotGiftToReward) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.IngotGiftToRewardToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Investment) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.InvestmentToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Carnival) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CarnivalToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CrawlTower) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CrawlTowerToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.PlayerDead) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.PlayerDeadToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.PotentialInvest) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.PotentialInvestToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.MemberPromote) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.MemberPromoteToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.MemberGift) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.MemberGiftToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BerserkPower) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BerserkPowerToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.QuickAuctionBuy) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.QuickAuctionBuyToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.QuickShopBuy) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.QuickShopBuyToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BuyExpElixir) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BuyExpElixirToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.PracticeRoom) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.PracticeRoomToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.AuthenticateDiamondNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.AuthenticateDiamondNotEnoughToRecharge
    elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.UnionInspireDiamondNotEnough) then
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.UnionInspireDiamondNotEnoughToRecharge
    else
        uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ShopPanelToRecharge
    end
    --print("---购买", uiStaticParameter.RechargePoint)
end

---数字对比
---@param leftNumber number
---@param rightNumber number
---@return boolean >:1 ==:0 <:-1 null:-2
function Utility.NumberCompare(leftNumber, rightNumber)
    if type(leftNumber) ~= 'number' or type(rightNumber) ~= 'number' then
        return -2
    end
    if leftNumber > rightNumber then
        return 1
    end
    if leftNumber == rightNumber then
        return 0
    end
    return -1
end

---notice是否开启系统
function Utility.IsNoticeOpenSystem(noticeTable)
    if noticeTable == nil or noticeTable:GetId() == nil then
        return false
    end
    return Utility.CheckSystemOpenState(noticeTable:GetId())
end

---是否开启
---@param conditionIds table<number,number>
function Utility.IsOpenSystem(conditionIds)
    if conditionIds == nil then
        return true
    end
    if #conditionIds == nil then
        return false
    end
    for i = 1, #conditionIds do
        local v = conditionIds[i]
        if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(v) then
            return false
        end
    end
    return true
end

---拿取指定下表元素
---@param mTable table
---@param index number
---@return any
function Utility.GetAndRemoveTableValue(mTable, index)
    if type(mTable) ~= 'table' or type(index) ~= 'number' then
        return
    end
    local value = mTable[index]
    if value == nil then
        return
    end
    table.remove(mTable, index)
    return value
end

function Utility.IsOpenLianZhiGongXun(isopenProp, go)
    local lzxw = LuaGlobalTableDeal.GetLianZhiGongXunCondition()
    if lzxw == nil then
        return true
    end
    for i, v in pairs(lzxw) do
        if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(v.conditionID) then
            if isopenProp == true then
                Utility.ShowPopoTips(go.transform, nil, v.propID)
            end
            return false
        end
    end
    return true
end

---@param Type number 类型
---@param openServerTime number 开服时间
---@param combineServerTime number 合服时间
---@param serverCurTime number 服务器当前时间
function Utility.OnPreloadingTtexture(Type, openServerTime, combineServerTime, serverCurTime)
    if Type == 1 then
        gameMgr:GetLuaTimeMgr():SetCombineServerTime(serverCurTime, combineServerTime)
        gameMgr:GetLuaTimeMgr():SetServerTime(serverCurTime, openServerTime)
        if CS.Cfg_DailyActivityTimeTableManager.IsLoadFinish == true then
            gameMgr:GetPlayerDataMgr():GetActivityMgr():InitDailyActivities()
            local loadName = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetLoadingTextureName()
            CS.CSCalendarInfoV2.LoadingTextureName = loadName;
            CS.CSResourceManager.Instance:AddQueueCannotDelete(loadName, CS.ResourceType.UIEffect, nil, CS.ResourceAssistType.ForceLoad);
        end
    end
    if Type == 2 then
        if (CS.CSServerTime.OpenServerTime ~= 0) then
            local loadName = gameMgr:GetLuaActivityMgr():GetLoadingTextureName()
            CS.CSCalendarInfoV2.LoadingTextureName = loadName;
            if (loadName ~= nil and loadName ~= "") then
                local res = CS.CSResourceManager.Instance:AddQueueCannotDelete(loadName, CS.ResourceType.UIEffect, nil, CS.ResourceAssistType.ForceLoad);
                CS.UILoading.resPreLoadPath = res.Path;
            end
        end
    end
end

---@return number 自动拾取状态 0未设置 1开 2关 3 限时 4 不存在
function Utility.IsPlayerAutoPickOpen()
    local configInfo = CS.CSScene.MainPlayerInfo.IConfigInfo
    local state = configInfo:GetInt(CS.EConfigOption.AutoPickUpByBuffer)
    ---@type CSBuffInfoV2
    local buffInfo = CS.CSScene.MainPlayerInfo.BuffInfo
    if (buffInfo) then
        ---@type CSBuffInfoItem
        local buffItem = buffInfo:GetBuffByBuffType(LuaEnumBuffType.AutoPick)
        if buffItem then
            if buffItem.Info.totalTime == 0 then
                local configInfo = CS.CSScene.MainPlayerInfo.IConfigInfo
                if state == 0 then
                    configInfo:SetInt(CS.EConfigOption.AutoPickUpByBuffer, 1)
                    state = 1
                end
            else
                state = 3
            end
        else
            state = 4
        end
    end
    return state
end

---尝试传送
---@param deliverId number
---@param configLimit boolean 是否受配置传送限制
---@return TransferResult
function Utility.TryTransfer(deliverId, configLimit)
    configLimit = ternary(type(configLimit) ~= 'boolean', true, configLimit)
    local transferResult = CS.Cfg_DeliverTableManager.Instance:TryTransfer(deliverId, configLimit)
    if transferResult ~= nil and transferResult.resultType ~= CS.Enum_TransferResult.Success then
        if CS.CSDebug.developerConsoleVisible then
            print(transferResult.resultDes)
        end
    end
    return transferResult
end

---尝试提交任务
function Utility.TrySubmitTask(panelName)
    for i = 0, CS.CSMissionManager.Instance:GetTaskList().Count - 1 do
        local v = CS.CSMissionManager.Instance:GetTaskList()[i];
        if v ~= nil and v.tbl_tasks ~= nil then
            if v.tbl_tasks.submitShow == panelName and v.stateID == 3 then
                networkRequest.ReqSubmitTask(v.tbl_tasks.id, 1)
                return true
            end
        end
    end
    return false
end

---是否需要显示练功房任务特效
function Utility.IsNeedShowLianGongFangTaskEffect(id)
    local list = LuaGlobalTableDeal.GetLianGongFangEffectTaskList()
    for i, v in pairs(list) do

        if v ~= nil and #v >= 1 and tonumber(v[1]) == tonumber(id) then
            for i = 2, #v do

                local isfind, tempMission = CS.CSMissionManager.Instance.mMissionDic:TryGetValue(v[i])
                if isfind then
                    return true
                end
            end
        end
    end
    return false
end

---表内数据是否都是指定的数值
---@param curTable table
---@param value any
---@return boolean
function Utility.TableValueAllIsCurValue(curTable, value)
    if type(curTable) ~= 'table' or value == nil then
        return false
    end
    for k, v in pairs(curTable) do
        if v ~= value then
            return false
        end
    end
    return true
end

function Utility.GetShaBaKContributeRankColor(rank)
    if (rank == 1) then
        return luaEnumColorType.Red1;
    elseif (rank == 2) then
        return "[ff6c00]";
    elseif (rank == 3) then
        return "[ff00ff]";
    elseif (rank == 4) then
        return "[007add]";
    elseif (rank == 5) then
        return "[00ff00]";
    end
    return luaEnumColorType.White
end

---@return string 字符串拼接
function Utility.LuaTryStringFormat(str, ...)
    local finalStr = ""
    local args = { ... }
    try {
        main = function()
            finalStr = string.format(str, table.unpack(args))
        end,
        catch = function(errors)
            print("策划配置文本有问题" .. errors)
        end
    }
    return finalStr
end

---根据deliverId判断条件，条件不足弹气泡
---@param deliverId number 传送id
function Utility.TryDeliver(go, deliverId)
    local deliverTbl = clientTableManager.cfg_deliverManager:TryGetValue(deliverId)
    if deliverTbl == nil then
        return
    end
    local costItem = deliverTbl:GetItem()
    if costItem then
        if Utility.IsDeliverMaterialEnough(go, costItem) == false then
            return
        end
    end

    local condition = deliverTbl:GetCondition()
    if condition then
        if Utility.IsDeliverConditionEnough(go, condition) == false then
            return
        end
    end
    networkRequest.ReqDeliverByConfig(deliverId)
    return true
end

---@return boolean 玩家的材料是否可以进行传送
---@param go
---@param costItem string 传送材料
function Utility.IsDeliverMaterialEnough(go, costItem)
    local strs = string.Split(costItem, '#')
    local group = math.floor(#strs / 2)
    local canDeliver = true
    local materialShow = ""
    for i = 1, group do
        local costItemId = tonumber(strs[i * 2 - 1])
        local costItemNum = tonumber(strs[2 * i])
        local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(costItemId)
        if itemTbl then
            if itemTbl:GetType() == luaEnumItemType.Coin then
                local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(costItemId)
                if playerHas < costItemNum then
                    materialShow = materialShow .. itemTbl:GetName() .. " "
                    canDeliver = false
                end
            else
                local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(costItemId)
                if playerHas < costItemNum then
                    canDeliver = false
                end
                if costItemId ~= 6000008 then
                    materialShow = materialShow .. itemTbl:GetName() .. " "
                end
            end
        end
    end

    ---小飞鞋特殊处理弹面板，其他弹气泡
    if canDeliver == false then
        if materialShow ~= "" then
            Utility.ShowPopoTips(go, materialShow .. "不足", 1)
        else
            Utility.ShowSecondConfirmPanel({ PromptWordId = 96, nil, ComfireAucion = function()
                uiTransferManager:TransferToPanel(1131)
            end })
            uimanager:ClosePanel("UICalendarPanel")
            uimanager:ClosePanel("UIActivitiesDesPanel")
        end
    end
    return canDeliver
end

---@param condition TABLE.IntListList
function Utility.IsDeliverConditionEnough(go, condition)
    local canDeliver = false
    local cannotDeliverCondition
    local conditionShow
    for i = 0, condition.list.Count - 1 do
        local conditionList = condition.list[i].list
        local isSingleAllEnough = true
        for j = 0, conditionList.Count - 1 do
            local singleC = conditionList[j]
            if singleC then
                local result = Utility.IsMainPlayerMatchCondition(singleC)
                if result then
                    if result.success == false then
                        isSingleAllEnough = false
                        --优先提示转生
                        local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(singleC)
                        local isRein = conditionTbl:GetConditionType() == LuaConditionType.RoleReinLevel or conditionTbl:GetConditionType() == LuaConditionType.RoleReinLevelLessThan
                        if cannotDeliverCondition == nil or isRein then
                            cannotDeliverCondition = singleC
                            conditionShow = result.txt
                        end
                    end
                else
                    isSingleAllEnough = false
                end
            end
        end
        if isSingleAllEnough then
            return true
        end
    end
    local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(cannotDeliverCondition)
    if conditionTbl:GetConditionType() == LuaConditionType.RoleReinLevel or conditionTbl:GetConditionType() == LuaConditionType.RoleReinLevelLessThan then
        Utility.ShowPopoTips(go, nil, 175)--转生等级不足提示
    elseif conditionShow then
        Utility.ShowPopoTips(go, conditionShow, 175)--其他的策划没要求
    end
    return false
end

---解析其他玩家的模型数据
---@param data roleV2.RoleModelInfo
---@return LuaPlayerModelInfo
function Utility.AnalysisOtherPlayerModelInfo(data)
    ---@class LuaPlayerModelInfo
    ---@field Sex
    ---@field Career
    ---@field BodyModel
    ---@field Weapon
    ---@field Hair
    ---@field FaceItemID
    ---@field Face
    ---@field DouLi
    ---@field LeftWeapon
    local customData = {}
    customData.Sex = Utility.GetCSSex(data.sex)
    customData.Career = Utility.GetCSCareer(data.career)
    if data.armor and data.armor ~= 0 then
        customData.BodyModel = CS.Cfg_ItemsTableManager.Instance:GetItems(data.armor).model.list[0]
    else
        customData.BodyModel = data.armor
    end
    if data.weapon and data.weapon ~= 0 then
        customData.Weapon = CS.Cfg_ItemsTableManager.Instance:GetItems(data.weapon).model.list[0]
    else
        customData.Weapon = data.weapon
    end
    if data.shield and data.shield ~= 0 then
        customData.LeftWeapon = CS.Cfg_ItemsTableManager.Instance:GetItems(data.shield).model.list[0]
    else
        customData.LeftWeapon = data.shield
    end

    if data.bambooHat and data.bambooHat ~= 0 then
        customData.DouLi = CS.Cfg_ItemsTableManager.Instance:GetItems(data.bambooHat).model.list[0]
    else
        customData.DouLi = data.bambooHat
    end

    if data.helmet and data.helmet ~= 0 then
        customData.Hair = 301000
        local hairModel = CS.Cfg_ItemsTableManager.Instance:GetItems(data.helmet).model
        if hairModel.list ~= nil and hairModel.list.Count == 1 then
            customData.Hair = hairModel.list[0]
        elseif hairModel.list ~= nil and hairModel.list.Count == 2 then
            customData.Hair = hairModel.list[data.sex - 1]
        end
    else
        customData.Hair = data.helmet
    end
    if data.face and data.face ~= 0 then
        customData.Face = 0
        local faceModel = CS.Cfg_ItemsTableManager.Instance:GetItems(data.face).model
        if faceModel.list ~= nil and faceModel.list.Count == 1 then
            customData.Face = faceModel.list[0]
        elseif faceModel.list ~= nil and faceModel.list.Count == 2 then
            customData.Face = faceModel.list[data.sex - 1]
        end
        ---此处因为面巾在角色界面中的点击是单独处理的,故再传一个FaceItemID过去以便点击
        customData.FaceItemID = data.face
    else
        customData.FaceItemID = 0
        customData.Face = 0
    end
    if data.wearPosition ~= nil then
        for i = 1, #data.wearPosition do
            ---@type appearanceV2.wearPosition
            local wearPos = data.wearPosition[i]
            local index = wearPos.index
            local itemID = wearPos.id
            ---@type TABLE.CFG_ITEMS
            local itemTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(itemID)
            if itemTbl ~= nil and itemTbl.appearanceId ~= 0 then
                local appearanceID = itemTbl.appearanceId

                ---@type TABLE.CFG_APPEARANCE
                local appearanceTblExist, appearanceTbl = CS.Cfg_AppearanceTableManager.Instance:TryGetValue(appearanceID)
                if appearanceTbl ~= nil and appearanceTbl.model ~= nil and appearanceTbl.model.list ~= nil
                        and appearanceTbl.model.list.Count > 0 then
                    local modelID = appearanceTbl.model.list[0]
                    if appearanceTbl.model.list.Count > 1 then
                        ---有2个时,男性#女性
                        if data.sex ~= LuaEnumSex.Man then
                            modelID = appearanceTbl.model.list[1]
                        end
                    end
                    if index == 1 and modelID ~= 0 then
                        customData.Weapon = modelID
                    elseif index == 2 and modelID ~= 0 then
                        customData.Hair = modelID
                    elseif index == 3 and modelID ~= 0 then
                        customData.BodyModel = modelID
                    end
                end
            end
        end
    end
    if data.bambooHat ~= 0 then
        customData.Hair = 0
    end
    return customData
end

---获取对应的c#职业枚举
---@param career LuaEnumCareer
function Utility.GetCSCareer(career)
    if Utility.ECSCareerDic == nil then
        Utility.ECSCareerDic = {}
        Utility.ECSCareerDic[LuaEnumCareer.Common] = CS.ECareer.Common
        Utility.ECSCareerDic[LuaEnumCareer.Taoist] = CS.ECareer.Taoist
        Utility.ECSCareerDic[LuaEnumCareer.Master] = CS.ECareer.Master
        Utility.ECSCareerDic[LuaEnumCareer.Warrior] = CS.ECareer.Warrior
        Utility.ECSCareerDic[LuaEnumCareer.Assassin] = CS.ECareer.Assassin
        Utility.ECSCareerDic[LuaEnumCareer.CunMin] = CS.ECareer.CunMin
    end
    return Utility.ECSCareerDic[career]
end

---获取对应的c#性别枚举
---@param sex LuaEnumSex
function Utility.GetCSSex(sex)
    if Utility.ESexCSDic == nil then
        Utility.ESexCSDic = {}
        Utility.ESexCSDic[LuaEnumSex.WoMan] = CS.ESex.WoMan
        Utility.ESexCSDic[LuaEnumSex.Man] = CS.ESex.Man
        Utility.ESexCSDic[LuaEnumSex.Common] = CS.ESex.Common
    end
    return Utility.ESexCSDic[sex]
end

---@class ReplaceMateriaUpgradeConditionInformationBase 可替换材料升级条件
---@field canBeUpgraded boolean 能不能升级，true 能升级，false 不能升级
---@field conditionInfo ReplaceMateriaUpgradeConditionInformationItem[] 称号升级条件

---@class ReplaceMateriaUpgradeConditionInformationItem 可替换材料升级条件信息
---@field conditions LuaMatchConditionResult 条件
---@field addObj UnityEngine.GameObject 获取途径的GameObject
---@field itemID number 物品ID

---@param conditions LuaMatchConditionResult
---@param addObj UnityEngine.GameObject
---@param itemID number
function Utility.GetReplaceMateriaUpgradeConditionInformationItem(conditions, addObj, itemID)
    ---@type ReplaceMateriaUpgradeConditionInformationItem
    local Item = {}
    Item.conditions = conditions
    Item.addObj = addObj
    Item.itemID = itemID
    return Item
end

---@param conditions ReplaceMateriaUpgradeConditionInformationItem[]
---@return boolean
function Utility.GetReplaceMateriaUpgradeConditionInformationCanBeUpgraded(conditionInfo)
    if (conditionInfo == nil or #conditionInfo <= 0) then
        return false
    end
    local canBeUpgraded = true
    for i = 1, #conditionInfo do
        if (conditionInfo[i] ~= nil and conditionInfo[i].conditions ~= nil) then
            if (not conditionInfo[i].conditions.success) then
                canBeUpgraded = false
                break
            end
        end
    end
    return canBeUpgraded
end

---设置副本剩余时间戳
---@param tblData duplicateV2.ResDevilSquareHasTime
function Utility.SetCopylastTimestamp(tblData)
    if (tblData == nil) then
        return
    end
    if (uiStaticParameter.DevilRemaining == nil) then
        uiStaticParameter.DevilRemaining = {}
    end
    for i = 1, #uiStaticParameter.DevilRemaining do
        ---@type duplicateV2.ResDevilSquareEndTime
        if (uiStaticParameter.DevilRemaining[i].duplicateType == tblData.duplicateType) then
            uiStaticParameter.DevilRemaining[i] = tblData
            return
        end
    end
    table.insert(uiStaticParameter.DevilRemaining, tblData)
end

---获取副本剩余时间戳
function Utility.GetCopylastTimestamp(duplicateType)
    local DevilRemaining = uiStaticParameter.DevilRemaining
    if (DevilRemaining == nil or #DevilRemaining <= 0) then
        return 0
    end
    for i = 1, #DevilRemaining do
        ---@type duplicateV2.ResDevilSquareEndTime
        if (DevilRemaining[i].duplicateType == duplicateType) then
            return DevilRemaining[i].hasTime
        end
    end
    return 0
end

---设置副本结束时间戳
---@param tblData duplicateV2.ResDevilSquareHasTime
function Utility.SetCopyEndTimestamp(tblData)
    if (tblData == nil) then
        return
    end
    if (uiStaticParameter.DevilEndTime == nil) then
        uiStaticParameter.DevilEndTime = {}
    end
    for i = 1, #uiStaticParameter.DevilEndTime do
        ---@type duplicateV2.ResDevilSquareEndTime
        if (uiStaticParameter.DevilEndTime[i].duplicateType == tblData.duplicateType) then
            uiStaticParameter.DevilEndTime[i] = tblData
            return
        end
    end
    table.insert(uiStaticParameter.DevilEndTime, tblData)

end

---获取副本结束时间戳
---@param duplicateType number 副本类型
function Utility.GetCopyEndTimestamp(duplicateType)
    local DevilEndTime = uiStaticParameter.DevilEndTime
    if (DevilEndTime == nil or #DevilEndTime <= 0) then
        return 0
    end
    for i = 1, #DevilEndTime do
        ---@type duplicateV2.ResDevilSquareEndTime
        if (DevilEndTime[i].duplicateType == duplicateType) then
            return DevilEndTime[i].endTime
        end
    end
    return 0
end

---开启版本更新提示
function Utility.OpenVersionUpdateHint()
    local flashData = {}
    flashData.id = 39
    flashData.clickCallBack = function()
        local customData = {}
        customData.PromptWordId = 162
        customData.ComfireAucion = function()
            Utility.RemoveFlashPrompt(1, 39)
            gameMgr:RestartGame()
        end
        Utility.ShowSecondConfirmPanel(customData)
    end
    Utility.AddFlashPrompt(flashData)
end

---是否能打开跨服摆摊
---@return boolean
function Utility.IsOpenShareStall()
    return Utility.CheckSystemOpenState(92)
end

---返回登录
function Utility.OnClickBtn_BackLogin()
    uimanager:CloseAllPanel()

    CS.AndroidSDKCallback.Instance.IsGameLogoutAccout = true;
    CS.SDKManager.GameInterface:LogoutAccount()

    CS.HttpRequest.Instance:Stop();
    CS.Constant.mSeverId = 0;
    CS.CSNetwork.Instance:Close();

    CS.CSGame.Sington:ClearBeforeLeaveGame()
    uimanager:CreatePanel("UILoginPanel", nil)
end

---@class CommonShowRewards
---@field itemID number
---@field itemCount number

---获取满足条件的数据
---例如：80001#90003_1000001#80 & 80003_1000001#100  返回1000001#80或者1000001#100
---@return table
function Utility.GetDataThatMeetsTheConditions(value)
    if (Utility.IsNilOrEmptyString(value)) then
        return nil
    end
    local temStr = string.Split(value, '&')
    if (temStr ~= nil and #temStr > 0) then
        for i = 1, #temStr do
            local datas = string.Split(temStr[i], '_')
            if (datas ~= nil and #datas > 1 and not Utility.IsNilOrEmptyString(datas[1])) then
                local conditionList = string.Split(datas[1], '#')
                local sucess = true
                for j = 1, #conditionList do
                    local condition = Utility.IsMainPlayerMatchCondition(tonumber(conditionList[j]))
                    if (condition == nil or condition.success == false) then
                        sucess = false
                    end
                end
                if (sucess) then
                    return datas[2]
                end
            end
        end
    end
    return nil
end

return Utility