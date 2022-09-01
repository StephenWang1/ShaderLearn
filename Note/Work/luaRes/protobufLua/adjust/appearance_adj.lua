--[[本文件为工具自动生成,禁止手动修改]]
local appearanceV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable appearanceV2.ResGetWearFashion
---@type appearanceV2.ResGetWearFashion
appearanceV2_adj.metatable_ResGetWearFashion = {
    _ClassName = "appearanceV2.ResGetWearFashion",
}
appearanceV2_adj.metatable_ResGetWearFashion.__index = appearanceV2_adj.metatable_ResGetWearFashion
--endregion

---@param tbl appearanceV2.ResGetWearFashion 待调整的table数据
function appearanceV2_adj.AdjustResGetWearFashion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, appearanceV2_adj.metatable_ResGetWearFashion)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.wearIds == nil then
        tbl.wearIds = {}
    else
        if appearanceV2_adj.AdjustwearPosition ~= nil then
            for i = 1, #tbl.wearIds do
                appearanceV2_adj.AdjustwearPosition(tbl.wearIds[i])
            end
        end
    end
end

--region metatable appearanceV2.ResGetHasFashion
---@type appearanceV2.ResGetHasFashion
appearanceV2_adj.metatable_ResGetHasFashion = {
    _ClassName = "appearanceV2.ResGetHasFashion",
}
appearanceV2_adj.metatable_ResGetHasFashion.__index = appearanceV2_adj.metatable_ResGetHasFashion
--endregion

---@param tbl appearanceV2.ResGetHasFashion 待调整的table数据
function appearanceV2_adj.AdjustResGetHasFashion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, appearanceV2_adj.metatable_ResGetHasFashion)
    if tbl.FashionInfo == nil then
        tbl.FashionInfo = {}
    else
        if appearanceV2_adj.AdjustFashionType ~= nil then
            for i = 1, #tbl.FashionInfo do
                appearanceV2_adj.AdjustFashionType(tbl.FashionInfo[i])
            end
        end
    end
end

--region metatable appearanceV2.wearPosition
---@type appearanceV2.wearPosition
appearanceV2_adj.metatable_wearPosition = {
    _ClassName = "appearanceV2.wearPosition",
}
appearanceV2_adj.metatable_wearPosition.__index = appearanceV2_adj.metatable_wearPosition
--endregion

---@param tbl appearanceV2.wearPosition 待调整的table数据
function appearanceV2_adj.AdjustwearPosition(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, appearanceV2_adj.metatable_wearPosition)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable appearanceV2.FashionType
---@type appearanceV2.FashionType
appearanceV2_adj.metatable_FashionType = {
    _ClassName = "appearanceV2.FashionType",
}
appearanceV2_adj.metatable_FashionType.__index = appearanceV2_adj.metatable_FashionType
--endregion

---@param tbl appearanceV2.FashionType 待调整的table数据
function appearanceV2_adj.AdjustFashionType(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, appearanceV2_adj.metatable_FashionType)
    if tbl.subType == nil then
        tbl.subTypeSpecified = false
        tbl.subType = 0
    else
        tbl.subTypeSpecified = true
    end
    if tbl.itemList == nil then
        tbl.itemList = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.itemList do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.itemList[i])
            end
        end
    end
end

--region metatable appearanceV2.ReqEnableFashion
---@type appearanceV2.ReqEnableFashion
appearanceV2_adj.metatable_ReqEnableFashion = {
    _ClassName = "appearanceV2.ReqEnableFashion",
}
appearanceV2_adj.metatable_ReqEnableFashion.__index = appearanceV2_adj.metatable_ReqEnableFashion
--endregion

---@param tbl appearanceV2.ReqEnableFashion 待调整的table数据
function appearanceV2_adj.AdjustReqEnableFashion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, appearanceV2_adj.metatable_ReqEnableFashion)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.close == nil then
        tbl.closeSpecified = false
        tbl.close = 0
    else
        tbl.closeSpecified = true
    end
end

--region metatable appearanceV2.ResGetHasAppellation
---@type appearanceV2.ResGetHasAppellation
appearanceV2_adj.metatable_ResGetHasAppellation = {
    _ClassName = "appearanceV2.ResGetHasAppellation",
}
appearanceV2_adj.metatable_ResGetHasAppellation.__index = appearanceV2_adj.metatable_ResGetHasAppellation
--endregion

---@param tbl appearanceV2.ResGetHasAppellation 待调整的table数据
function appearanceV2_adj.AdjustResGetHasAppellation(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, appearanceV2_adj.metatable_ResGetHasAppellation)
    if tbl.titleInfo == nil then
        tbl.titleInfo = {}
    else
        if appearanceV2_adj.AdjustTitleInfo ~= nil then
            for i = 1, #tbl.titleInfo do
                appearanceV2_adj.AdjustTitleInfo(tbl.titleInfo[i])
            end
        end
    end
end

--region metatable appearanceV2.TitleInfo
---@type appearanceV2.TitleInfo
appearanceV2_adj.metatable_TitleInfo = {
    _ClassName = "appearanceV2.TitleInfo",
}
appearanceV2_adj.metatable_TitleInfo.__index = appearanceV2_adj.metatable_TitleInfo
--endregion

---@param tbl appearanceV2.TitleInfo 待调整的table数据
function appearanceV2_adj.AdjustTitleInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, appearanceV2_adj.metatable_TitleInfo)
    if tbl.titleId == nil then
        tbl.titleIdSpecified = false
        tbl.titleId = 0
    else
        tbl.titleIdSpecified = true
    end
    if tbl.titleDes == nil then
        tbl.titleDesSpecified = false
        tbl.titleDes = ""
    else
        tbl.titleDesSpecified = true
    end
end

--region metatable appearanceV2.ReqEnableTitle
---@type appearanceV2.ReqEnableTitle
appearanceV2_adj.metatable_ReqEnableTitle = {
    _ClassName = "appearanceV2.ReqEnableTitle",
}
appearanceV2_adj.metatable_ReqEnableTitle.__index = appearanceV2_adj.metatable_ReqEnableTitle
--endregion

---@param tbl appearanceV2.ReqEnableTitle 待调整的table数据
function appearanceV2_adj.AdjustReqEnableTitle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, appearanceV2_adj.metatable_ReqEnableTitle)
    if tbl.titleId == nil then
        tbl.titleIdSpecified = false
        tbl.titleId = 0
    else
        tbl.titleIdSpecified = true
    end
    if tbl.close == nil then
        tbl.closeSpecified = false
        tbl.close = 0
    else
        tbl.closeSpecified = true
    end
end

--region metatable appearanceV2.ReqModifyTitle
---@type appearanceV2.ReqModifyTitle
appearanceV2_adj.metatable_ReqModifyTitle = {
    _ClassName = "appearanceV2.ReqModifyTitle",
}
appearanceV2_adj.metatable_ReqModifyTitle.__index = appearanceV2_adj.metatable_ReqModifyTitle
--endregion

---@param tbl appearanceV2.ReqModifyTitle 待调整的table数据
function appearanceV2_adj.AdjustReqModifyTitle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, appearanceV2_adj.metatable_ReqModifyTitle)
    if tbl.titleId == nil then
        tbl.titleIdSpecified = false
        tbl.titleId = 0
    else
        tbl.titleIdSpecified = true
    end
    if tbl.modifyTitle == nil then
        tbl.modifyTitleSpecified = false
        tbl.modifyTitle = ""
    else
        tbl.modifyTitleSpecified = true
    end
end

--region metatable appearanceV2.ResModifyTitle
---@type appearanceV2.ResModifyTitle
appearanceV2_adj.metatable_ResModifyTitle = {
    _ClassName = "appearanceV2.ResModifyTitle",
}
appearanceV2_adj.metatable_ResModifyTitle.__index = appearanceV2_adj.metatable_ResModifyTitle
--endregion

---@param tbl appearanceV2.ResModifyTitle 待调整的table数据
function appearanceV2_adj.AdjustResModifyTitle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, appearanceV2_adj.metatable_ResModifyTitle)
    if tbl.titleId == nil then
        tbl.titleIdSpecified = false
        tbl.titleId = 0
    else
        tbl.titleIdSpecified = true
    end
    if tbl.modifyTitle == nil then
        tbl.modifyTitleSpecified = false
        tbl.modifyTitle = ""
    else
        tbl.modifyTitleSpecified = true
    end
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
end

--region metatable appearanceV2.ResEnableAppellation
---@type appearanceV2.ResEnableAppellation
appearanceV2_adj.metatable_ResEnableAppellation = {
    _ClassName = "appearanceV2.ResEnableAppellation",
}
appearanceV2_adj.metatable_ResEnableAppellation.__index = appearanceV2_adj.metatable_ResEnableAppellation
--endregion

---@param tbl appearanceV2.ResEnableAppellation 待调整的table数据
function appearanceV2_adj.AdjustResEnableAppellation(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, appearanceV2_adj.metatable_ResEnableAppellation)
    if tbl.titleInfo == nil then
        tbl.titleInfoSpecified = false
        tbl.titleInfo = nil
    else
        if tbl.titleInfoSpecified == nil then 
            tbl.titleInfoSpecified = true
            if appearanceV2_adj.AdjustTitleInfo ~= nil then
                appearanceV2_adj.AdjustTitleInfo(tbl.titleInfo)
            end
        end
    end
end

--region metatable appearanceV2.ResAppearanceRedPoint
---@type appearanceV2.ResAppearanceRedPoint
appearanceV2_adj.metatable_ResAppearanceRedPoint = {
    _ClassName = "appearanceV2.ResAppearanceRedPoint",
}
appearanceV2_adj.metatable_ResAppearanceRedPoint.__index = appearanceV2_adj.metatable_ResAppearanceRedPoint
--endregion

---@param tbl appearanceV2.ResAppearanceRedPoint 待调整的table数据
function appearanceV2_adj.AdjustResAppearanceRedPoint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, appearanceV2_adj.metatable_ResAppearanceRedPoint)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

return appearanceV2_adj