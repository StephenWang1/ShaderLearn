--[[本文件为工具自动生成,禁止手动修改]]
local lingshouV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable lingshouV2.LingShouInfo
---@type lingshouV2.LingShouInfo
lingshouV2_adj.metatable_LingShouInfo = {
    _ClassName = "lingshouV2.LingShouInfo",
}
lingshouV2_adj.metatable_LingShouInfo.__index = lingshouV2_adj.metatable_LingShouInfo
--endregion

---@param tbl lingshouV2.LingShouInfo 待调整的table数据
function lingshouV2_adj.AdjustLingShouInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_LingShouInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.xlevel == nil then
        tbl.xlevelSpecified = false
        tbl.xlevel = 0
    else
        tbl.xlevelSpecified = true
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
    if tbl.nowSkin == nil then
        tbl.nowSkinSpecified = false
        tbl.nowSkin = 0
    else
        tbl.nowSkinSpecified = true
    end
    if tbl.tianfuId == nil then
        tbl.tianfuIdSpecified = false
        tbl.tianfuId = 0
    else
        tbl.tianfuIdSpecified = true
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
    if tbl.talentList == nil then
        tbl.talentList = {}
    else
        if lingshouV2_adj.AdjustTalentInfo ~= nil then
            for i = 1, #tbl.talentList do
                lingshouV2_adj.AdjustTalentInfo(tbl.talentList[i])
            end
        end
    end
    if tbl.lsEquipList == nil then
        tbl.lsEquipList = {}
    else
        if lingshouV2_adj.AdjustLSEquipInfo ~= nil then
            for i = 1, #tbl.lsEquipList do
                lingshouV2_adj.AdjustLSEquipInfo(tbl.lsEquipList[i])
            end
        end
    end
end

--region metatable lingshouV2.HuanXingInfo
---@type lingshouV2.HuanXingInfo
lingshouV2_adj.metatable_HuanXingInfo = {
    _ClassName = "lingshouV2.HuanXingInfo",
}
lingshouV2_adj.metatable_HuanXingInfo.__index = lingshouV2_adj.metatable_HuanXingInfo
--endregion

---@param tbl lingshouV2.HuanXingInfo 待调整的table数据
function lingshouV2_adj.AdjustHuanXingInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_HuanXingInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.xlevel == nil then
        tbl.xlevelSpecified = false
        tbl.xlevel = 0
    else
        tbl.xlevelSpecified = true
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
    if tbl.tianfuId == nil then
        tbl.tianfuIdSpecified = false
        tbl.tianfuId = 0
    else
        tbl.tianfuIdSpecified = true
    end
    if tbl.timeout == nil then
        tbl.timeoutSpecified = false
        tbl.timeout = 0
    else
        tbl.timeoutSpecified = true
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
end

--region metatable lingshouV2.TalentInfo
---@type lingshouV2.TalentInfo
lingshouV2_adj.metatable_TalentInfo = {
    _ClassName = "lingshouV2.TalentInfo",
}
lingshouV2_adj.metatable_TalentInfo.__index = lingshouV2_adj.metatable_TalentInfo
--endregion

---@param tbl lingshouV2.TalentInfo 待调整的table数据
function lingshouV2_adj.AdjustTalentInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_TalentInfo)
    if tbl.cls == nil then
        tbl.clsSpecified = false
        tbl.cls = 0
    else
        tbl.clsSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
end

--region metatable lingshouV2.LSEquipInfo
---@type lingshouV2.LSEquipInfo
lingshouV2_adj.metatable_LSEquipInfo = {
    _ClassName = "lingshouV2.LSEquipInfo",
}
lingshouV2_adj.metatable_LSEquipInfo.__index = lingshouV2_adj.metatable_LSEquipInfo
--endregion

---@param tbl lingshouV2.LSEquipInfo 待调整的table数据
function lingshouV2_adj.AdjustLSEquipInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_LSEquipInfo)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.shengLingLv == nil then
        tbl.shengLingLvSpecified = false
        tbl.shengLingLv = 0
    else
        tbl.shengLingLvSpecified = true
    end
end

--region metatable lingshouV2.ResLingShouInfo
---@type lingshouV2.ResLingShouInfo
lingshouV2_adj.metatable_ResLingShouInfo = {
    _ClassName = "lingshouV2.ResLingShouInfo",
}
lingshouV2_adj.metatable_ResLingShouInfo.__index = lingshouV2_adj.metatable_ResLingShouInfo
--endregion

---@param tbl lingshouV2.ResLingShouInfo 待调整的table数据
function lingshouV2_adj.AdjustResLingShouInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ResLingShouInfo)
    if tbl.lingShou == nil then
        tbl.lingShouSpecified = false
        tbl.lingShou = nil
    else
        if tbl.lingShouSpecified == nil then 
            tbl.lingShouSpecified = true
            if lingshouV2_adj.AdjustLingShouInfo ~= nil then
                lingshouV2_adj.AdjustLingShouInfo(tbl.lingShou)
            end
        end
    end
    if tbl.huanXingList == nil then
        tbl.huanXingListSpecified = false
        tbl.huanXingList = nil
    else
        if tbl.huanXingListSpecified == nil then 
            tbl.huanXingListSpecified = true
            if lingshouV2_adj.AdjustHuanXingInfo ~= nil then
                lingshouV2_adj.AdjustHuanXingInfo(tbl.huanXingList)
            end
        end
    end
end

--region metatable lingshouV2.ReqLevelUpLingShou
---@type lingshouV2.ReqLevelUpLingShou
lingshouV2_adj.metatable_ReqLevelUpLingShou = {
    _ClassName = "lingshouV2.ReqLevelUpLingShou",
}
lingshouV2_adj.metatable_ReqLevelUpLingShou.__index = lingshouV2_adj.metatable_ReqLevelUpLingShou
--endregion

---@param tbl lingshouV2.ReqLevelUpLingShou 待调整的table数据
function lingshouV2_adj.AdjustReqLevelUpLingShou(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ReqLevelUpLingShou)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.useType == nil then
        tbl.useTypeSpecified = false
        tbl.useType = 0
    else
        tbl.useTypeSpecified = true
    end
end

--region metatable lingshouV2.ResLevelUpLingShou
---@type lingshouV2.ResLevelUpLingShou
lingshouV2_adj.metatable_ResLevelUpLingShou = {
    _ClassName = "lingshouV2.ResLevelUpLingShou",
}
lingshouV2_adj.metatable_ResLevelUpLingShou.__index = lingshouV2_adj.metatable_ResLevelUpLingShou
--endregion

---@param tbl lingshouV2.ResLevelUpLingShou 待调整的table数据
function lingshouV2_adj.AdjustResLevelUpLingShou(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ResLevelUpLingShou)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.xlevel == nil then
        tbl.xlevelSpecified = false
        tbl.xlevel = 0
    else
        tbl.xlevelSpecified = true
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
    if tbl.tianfuId == nil then
        tbl.tianfuIdSpecified = false
        tbl.tianfuId = 0
    else
        tbl.tianfuIdSpecified = true
    end
    if tbl.timeout == nil then
        tbl.timeoutSpecified = false
        tbl.timeout = 0
    else
        tbl.timeoutSpecified = true
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
end

--region metatable lingshouV2.ReqLevelUpLingShouTalent
---@type lingshouV2.ReqLevelUpLingShouTalent
lingshouV2_adj.metatable_ReqLevelUpLingShouTalent = {
    _ClassName = "lingshouV2.ReqLevelUpLingShouTalent",
}
lingshouV2_adj.metatable_ReqLevelUpLingShouTalent.__index = lingshouV2_adj.metatable_ReqLevelUpLingShouTalent
--endregion

---@param tbl lingshouV2.ReqLevelUpLingShouTalent 待调整的table数据
function lingshouV2_adj.AdjustReqLevelUpLingShouTalent(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ReqLevelUpLingShouTalent)
    if tbl.cls == nil then
        tbl.clsSpecified = false
        tbl.cls = 0
    else
        tbl.clsSpecified = true
    end
end

--region metatable lingshouV2.ResLevelUpLingShouTalent
---@type lingshouV2.ResLevelUpLingShouTalent
lingshouV2_adj.metatable_ResLevelUpLingShouTalent = {
    _ClassName = "lingshouV2.ResLevelUpLingShouTalent",
}
lingshouV2_adj.metatable_ResLevelUpLingShouTalent.__index = lingshouV2_adj.metatable_ResLevelUpLingShouTalent
--endregion

---@param tbl lingshouV2.ResLevelUpLingShouTalent 待调整的table数据
function lingshouV2_adj.AdjustResLevelUpLingShouTalent(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ResLevelUpLingShouTalent)
    if tbl.cls == nil then
        tbl.clsSpecified = false
        tbl.cls = 0
    else
        tbl.clsSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
end

--region metatable lingshouV2.ReqPutOnLingShouEquip
---@type lingshouV2.ReqPutOnLingShouEquip
lingshouV2_adj.metatable_ReqPutOnLingShouEquip = {
    _ClassName = "lingshouV2.ReqPutOnLingShouEquip",
}
lingshouV2_adj.metatable_ReqPutOnLingShouEquip.__index = lingshouV2_adj.metatable_ReqPutOnLingShouEquip
--endregion

---@param tbl lingshouV2.ReqPutOnLingShouEquip 待调整的table数据
function lingshouV2_adj.AdjustReqPutOnLingShouEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ReqPutOnLingShouEquip)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.uniqueId == nil then
        tbl.uniqueIdSpecified = false
        tbl.uniqueId = 0
    else
        tbl.uniqueIdSpecified = true
    end
end

--region metatable lingshouV2.ResLingShouEquipChange
---@type lingshouV2.ResLingShouEquipChange
lingshouV2_adj.metatable_ResLingShouEquipChange = {
    _ClassName = "lingshouV2.ResLingShouEquipChange",
}
lingshouV2_adj.metatable_ResLingShouEquipChange.__index = lingshouV2_adj.metatable_ResLingShouEquipChange
--endregion

---@param tbl lingshouV2.ResLingShouEquipChange 待调整的table数据
function lingshouV2_adj.AdjustResLingShouEquipChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ResLingShouEquipChange)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.lsEquip == nil then
        tbl.lsEquipSpecified = false
        tbl.lsEquip = nil
    else
        if tbl.lsEquipSpecified == nil then 
            tbl.lsEquipSpecified = true
            if lingshouV2_adj.AdjustLSEquipInfo ~= nil then
                lingshouV2_adj.AdjustLSEquipInfo(tbl.lsEquip)
            end
        end
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
end

--region metatable lingshouV2.ReqPutOffLingShouEquip
---@type lingshouV2.ReqPutOffLingShouEquip
lingshouV2_adj.metatable_ReqPutOffLingShouEquip = {
    _ClassName = "lingshouV2.ReqPutOffLingShouEquip",
}
lingshouV2_adj.metatable_ReqPutOffLingShouEquip.__index = lingshouV2_adj.metatable_ReqPutOffLingShouEquip
--endregion

---@param tbl lingshouV2.ReqPutOffLingShouEquip 待调整的table数据
function lingshouV2_adj.AdjustReqPutOffLingShouEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ReqPutOffLingShouEquip)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable lingshouV2.ReqPutOnSkin
---@type lingshouV2.ReqPutOnSkin
lingshouV2_adj.metatable_ReqPutOnSkin = {
    _ClassName = "lingshouV2.ReqPutOnSkin",
}
lingshouV2_adj.metatable_ReqPutOnSkin.__index = lingshouV2_adj.metatable_ReqPutOnSkin
--endregion

---@param tbl lingshouV2.ReqPutOnSkin 待调整的table数据
function lingshouV2_adj.AdjustReqPutOnSkin(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ReqPutOnSkin)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable lingshouV2.ResSkinChange
---@type lingshouV2.ResSkinChange
lingshouV2_adj.metatable_ResSkinChange = {
    _ClassName = "lingshouV2.ResSkinChange",
}
lingshouV2_adj.metatable_ResSkinChange.__index = lingshouV2_adj.metatable_ResSkinChange
--endregion

---@param tbl lingshouV2.ResSkinChange 待调整的table数据
function lingshouV2_adj.AdjustResSkinChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ResSkinChange)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
end

--region metatable lingshouV2.ReqPutOffLingSkin
---@type lingshouV2.ReqPutOffLingSkin
lingshouV2_adj.metatable_ReqPutOffLingSkin = {
    _ClassName = "lingshouV2.ReqPutOffLingSkin",
}
lingshouV2_adj.metatable_ReqPutOffLingSkin.__index = lingshouV2_adj.metatable_ReqPutOffLingSkin
--endregion

---@param tbl lingshouV2.ReqPutOffLingSkin 待调整的table数据
function lingshouV2_adj.AdjustReqPutOffLingSkin(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ReqPutOffLingSkin)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable lingshouV2.ReqActivateLingShou
---@type lingshouV2.ReqActivateLingShou
lingshouV2_adj.metatable_ReqActivateLingShou = {
    _ClassName = "lingshouV2.ReqActivateLingShou",
}
lingshouV2_adj.metatable_ReqActivateLingShou.__index = lingshouV2_adj.metatable_ReqActivateLingShou
--endregion

---@param tbl lingshouV2.ReqActivateLingShou 待调整的table数据
function lingshouV2_adj.AdjustReqActivateLingShou(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ReqActivateLingShou)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable lingshouV2.ReqLevelUpTianFu
---@type lingshouV2.ReqLevelUpTianFu
lingshouV2_adj.metatable_ReqLevelUpTianFu = {
    _ClassName = "lingshouV2.ReqLevelUpTianFu",
}
lingshouV2_adj.metatable_ReqLevelUpTianFu.__index = lingshouV2_adj.metatable_ReqLevelUpTianFu
--endregion

---@param tbl lingshouV2.ReqLevelUpTianFu 待调整的table数据
function lingshouV2_adj.AdjustReqLevelUpTianFu(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ReqLevelUpTianFu)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable lingshouV2.ResLevelUpTianFu
---@type lingshouV2.ResLevelUpTianFu
lingshouV2_adj.metatable_ResLevelUpTianFu = {
    _ClassName = "lingshouV2.ResLevelUpTianFu",
}
lingshouV2_adj.metatable_ResLevelUpTianFu.__index = lingshouV2_adj.metatable_ResLevelUpTianFu
--endregion

---@param tbl lingshouV2.ResLevelUpTianFu 待调整的table数据
function lingshouV2_adj.AdjustResLevelUpTianFu(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ResLevelUpTianFu)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.tianfuId == nil then
        tbl.tianfuIdSpecified = false
        tbl.tianfuId = 0
    else
        tbl.tianfuIdSpecified = true
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
end

--region metatable lingshouV2.ResRemoveSkin
---@type lingshouV2.ResRemoveSkin
lingshouV2_adj.metatable_ResRemoveSkin = {
    _ClassName = "lingshouV2.ResRemoveSkin",
}
lingshouV2_adj.metatable_ResRemoveSkin.__index = lingshouV2_adj.metatable_ResRemoveSkin
--endregion

---@param tbl lingshouV2.ResRemoveSkin 待调整的table数据
function lingshouV2_adj.AdjustResRemoveSkin(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ResRemoveSkin)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable lingshouV2.ReqShengLing
---@type lingshouV2.ReqShengLing
lingshouV2_adj.metatable_ReqShengLing = {
    _ClassName = "lingshouV2.ReqShengLing",
}
lingshouV2_adj.metatable_ReqShengLing.__index = lingshouV2_adj.metatable_ReqShengLing
--endregion

---@param tbl lingshouV2.ReqShengLing 待调整的table数据
function lingshouV2_adj.AdjustReqShengLing(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ReqShengLing)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable lingshouV2.ResLingShouTaskPanel
---@type lingshouV2.ResLingShouTaskPanel
lingshouV2_adj.metatable_ResLingShouTaskPanel = {
    _ClassName = "lingshouV2.ResLingShouTaskPanel",
}
lingshouV2_adj.metatable_ResLingShouTaskPanel.__index = lingshouV2_adj.metatable_ResLingShouTaskPanel
--endregion

---@param tbl lingshouV2.ResLingShouTaskPanel 待调整的table数据
function lingshouV2_adj.AdjustResLingShouTaskPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ResLingShouTaskPanel)
    if tbl.taskInfo == nil then
        tbl.taskInfo = {}
    else
        if lingshouV2_adj.AdjustLinshouTaskInfo ~= nil then
            for i = 1, #tbl.taskInfo do
                lingshouV2_adj.AdjustLinshouTaskInfo(tbl.taskInfo[i])
            end
        end
    end
    if tbl.secInfo == nil then
        tbl.secInfo = {}
    else
        if lingshouV2_adj.AdjustLinshouSectionInfo ~= nil then
            for i = 1, #tbl.secInfo do
                lingshouV2_adj.AdjustLinshouSectionInfo(tbl.secInfo[i])
            end
        end
    end
    if tbl.finishCount == nil then
        tbl.finishCountSpecified = false
        tbl.finishCount = 0
    else
        tbl.finishCountSpecified = true
    end
    if tbl.maxCount == nil then
        tbl.maxCountSpecified = false
        tbl.maxCount = 0
    else
        tbl.maxCountSpecified = true
    end
    if tbl.allComplete == nil then
        tbl.allCompleteSpecified = false
        tbl.allComplete = 0
    else
        tbl.allCompleteSpecified = true
    end
end

--region metatable lingshouV2.LinshouTaskInfo
---@type lingshouV2.LinshouTaskInfo
lingshouV2_adj.metatable_LinshouTaskInfo = {
    _ClassName = "lingshouV2.LinshouTaskInfo",
}
lingshouV2_adj.metatable_LinshouTaskInfo.__index = lingshouV2_adj.metatable_LinshouTaskInfo
--endregion

---@param tbl lingshouV2.LinshouTaskInfo 待调整的table数据
function lingshouV2_adj.AdjustLinshouTaskInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_LinshouTaskInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.goalInfo == nil then
        tbl.goalInfoSpecified = false
        tbl.goalInfo = nil
    else
        if tbl.goalInfoSpecified == nil then 
            tbl.goalInfoSpecified = true
            if adjustTable.task_adj ~= nil and adjustTable.task_adj.AdjustTaskGoalInfo ~= nil then
                adjustTable.task_adj.AdjustTaskGoalInfo(tbl.goalInfo)
            end
        end
    end
    if tbl.section == nil then
        tbl.sectionSpecified = false
        tbl.section = 0
    else
        tbl.sectionSpecified = true
    end
end

--region metatable lingshouV2.LinshouSectionInfo
---@type lingshouV2.LinshouSectionInfo
lingshouV2_adj.metatable_LinshouSectionInfo = {
    _ClassName = "lingshouV2.LinshouSectionInfo",
}
lingshouV2_adj.metatable_LinshouSectionInfo.__index = lingshouV2_adj.metatable_LinshouSectionInfo
--endregion

---@param tbl lingshouV2.LinshouSectionInfo 待调整的table数据
function lingshouV2_adj.AdjustLinshouSectionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_LinshouSectionInfo)
    if tbl.sec == nil then
        tbl.secSpecified = false
        tbl.sec = 0
    else
        tbl.secSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.lockState == nil then
        tbl.lockStateSpecified = false
        tbl.lockState = 0
    else
        tbl.lockStateSpecified = true
    end
end

--region metatable lingshouV2.ResLingShouTaskInfo
---@type lingshouV2.ResLingShouTaskInfo
lingshouV2_adj.metatable_ResLingShouTaskInfo = {
    _ClassName = "lingshouV2.ResLingShouTaskInfo",
}
lingshouV2_adj.metatable_ResLingShouTaskInfo.__index = lingshouV2_adj.metatable_ResLingShouTaskInfo
--endregion

---@param tbl lingshouV2.ResLingShouTaskInfo 待调整的table数据
function lingshouV2_adj.AdjustResLingShouTaskInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ResLingShouTaskInfo)
    if tbl.taskInfo == nil then
        tbl.taskInfo = {}
    else
        if lingshouV2_adj.AdjustLinshouTaskInfo ~= nil then
            for i = 1, #tbl.taskInfo do
                lingshouV2_adj.AdjustLinshouTaskInfo(tbl.taskInfo[i])
            end
        end
    end
end

--region metatable lingshouV2.ResLinshouSectionInfo
---@type lingshouV2.ResLinshouSectionInfo
lingshouV2_adj.metatable_ResLinshouSectionInfo = {
    _ClassName = "lingshouV2.ResLinshouSectionInfo",
}
lingshouV2_adj.metatable_ResLinshouSectionInfo.__index = lingshouV2_adj.metatable_ResLinshouSectionInfo
--endregion

---@param tbl lingshouV2.ResLinshouSectionInfo 待调整的table数据
function lingshouV2_adj.AdjustResLinshouSectionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ResLinshouSectionInfo)
    if tbl.secInfo == nil then
        tbl.secInfoSpecified = false
        tbl.secInfo = nil
    else
        if tbl.secInfoSpecified == nil then 
            tbl.secInfoSpecified = true
            if lingshouV2_adj.AdjustLinshouSectionInfo ~= nil then
                lingshouV2_adj.AdjustLinshouSectionInfo(tbl.secInfo)
            end
        end
    end
end

--region metatable lingshouV2.ReqGetRewards
---@type lingshouV2.ReqGetRewards
lingshouV2_adj.metatable_ReqGetRewards = {
    _ClassName = "lingshouV2.ReqGetRewards",
}
lingshouV2_adj.metatable_ReqGetRewards.__index = lingshouV2_adj.metatable_ReqGetRewards
--endregion

---@param tbl lingshouV2.ReqGetRewards 待调整的table数据
function lingshouV2_adj.AdjustReqGetRewards(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ReqGetRewards)
end

--region metatable lingshouV2.ReqGetSecRewards
---@type lingshouV2.ReqGetSecRewards
lingshouV2_adj.metatable_ReqGetSecRewards = {
    _ClassName = "lingshouV2.ReqGetSecRewards",
}
lingshouV2_adj.metatable_ReqGetSecRewards.__index = lingshouV2_adj.metatable_ReqGetSecRewards
--endregion

---@param tbl lingshouV2.ReqGetSecRewards 待调整的table数据
function lingshouV2_adj.AdjustReqGetSecRewards(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_ReqGetSecRewards)
end

--region metatable lingshouV2.UnlockLingShouTask
---@type lingshouV2.UnlockLingShouTask
lingshouV2_adj.metatable_UnlockLingShouTask = {
    _ClassName = "lingshouV2.UnlockLingShouTask",
}
lingshouV2_adj.metatable_UnlockLingShouTask.__index = lingshouV2_adj.metatable_UnlockLingShouTask
--endregion

---@param tbl lingshouV2.UnlockLingShouTask 待调整的table数据
function lingshouV2_adj.AdjustUnlockLingShouTask(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_UnlockLingShouTask)
    if tbl.sec == nil then
        tbl.secSpecified = false
        tbl.sec = 0
    else
        tbl.secSpecified = true
    end
end

--region metatable lingshouV2.UnlockSecEffect
---@type lingshouV2.UnlockSecEffect
lingshouV2_adj.metatable_UnlockSecEffect = {
    _ClassName = "lingshouV2.UnlockSecEffect",
}
lingshouV2_adj.metatable_UnlockSecEffect.__index = lingshouV2_adj.metatable_UnlockSecEffect
--endregion

---@param tbl lingshouV2.UnlockSecEffect 待调整的table数据
function lingshouV2_adj.AdjustUnlockSecEffect(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, lingshouV2_adj.metatable_UnlockSecEffect)
    if tbl.sec == nil then
        tbl.secSpecified = false
        tbl.sec = 0
    else
        tbl.secSpecified = true
    end
end

return lingshouV2_adj