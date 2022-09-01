---@class LuaRecastList:luaobject 重铸列表
local LuaRecastList = {}

--region 数据
---@type equipV2.ResRecast 服务器数据
LuaRecastList.ServerData = nil
---@type table<LuaEnumRecastType,LuaRecastEquipIndex> 装备位重铸信息列表
LuaRecastList.EquipIndexRecastInfoList = nil
--endregion

--region 数据刷新
---@param tblData equipV2.ResRecast
---@param career LuaEnumCareer 非必要参数
function LuaRecastList:RefreshEquipIndexRecastInfoList(tblData,career)
    self.ServerData = tblData
    if self.EquipIndexRecastInfoList == nil then
        self.EquipIndexRecastInfoList = {}
    end
    if type(tblData) == 'table' and Utility.GetLuaTableCount(tblData) > 0 then
        for k,v in pairs(tblData) do
            self:RefreshSingleRecastInfo(v.info,career)
        end
    end
end

---@param tblData equipV2.JewelryRecastInfo
---@param career LuaEnumCareer 非必要参数
function LuaRecastList:RefreshSingleRecastInfo(tblData,career)
    if type(tblData) ~= 'table' or tblData.type == nil or tblData.level == nil then
        return
    end
    if self.EquipIndexRecastInfoList[tblData.type] == nil then
        self.EquipIndexRecastInfoList[tblData.type] = luaclass.LuaRecastEquipIndex:New()
    end
    self.EquipIndexRecastInfoList[tblData.type]:RefreshEquipIndexRecastInfo(tblData,career)
end
--endregion

--region 获取
---@param curType LuaEnumRecastType
---@param career LuaEnumCareer
---@return LuaRecastEquipIndex
function LuaRecastList:GetRecastInfo(curType, career)
    if type(self.EquipIndexRecastInfoList) ~= 'table' then
        self.EquipIndexRecastInfoList = {}
    end
    if self.EquipIndexRecastInfoList[curType] == nil then
        self.EquipIndexRecastInfoList[curType] = luaclass.LuaRecastEquipIndex:New()
        self.EquipIndexRecastInfoList[curType]:DefaultDataInit(curType,career)
    end
    return self.EquipIndexRecastInfoList[curType]
end
--endregion

return LuaRecastList