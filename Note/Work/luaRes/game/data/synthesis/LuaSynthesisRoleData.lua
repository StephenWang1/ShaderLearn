---@class LuaSynthesisRoleData:luaobject
local LuaSynthesisRoleData = {}

---@type number 角色等级
LuaSynthesisRoleData.roleLevel = nil

---@type number 角色转生等级
LuaSynthesisRoleData.roleRein = nil

---@type number 角色职业
LuaSynthesisRoleData.Career = nil

---@type number 开服天数
LuaSynthesisRoleData.ServerOpenDay = nil

---@type number 角色性别
LuaSynthesisRoleData.Sex = nil

---@type table<number:道具ID> 角色装备信息
LuaSynthesisRoleData.EquipData = nil

---@type table<number:灵兽ID> 角色装备信息
LuaSynthesisRoleData.Servant = nil

---@type table<number:道具ID> 灵兽装备信息
LuaSynthesisRoleData.ServantEquipData = nil

---@type table<number:技能ID> 角色技能信息
LuaSynthesisRoleData.Skill = nil

---@type table<number:外观ID> 角色外观信息
LuaSynthesisRoleData.FashionList = nil

return LuaSynthesisRoleData