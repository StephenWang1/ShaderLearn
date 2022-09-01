---摊位总模板
---@class UIAuctionPanel_StallPanel
local UIAuctionPanel_StallPanel = {}

---@return UnityEngine.GameObject 摊位
function UIAuctionPanel_StallPanel:GetStall_Go()
    if self.StallInfo_Go == nil then
        self.StallInfo_Go = self:Get("StallInfo", "GameObject")
    end
    return self.StallInfo_Go
end

---@return UIAuctionPanel_StallInfo
function UIAuctionPanel_StallPanel:GetStallInfoTemplate()
    if self.UIAuctionPanel_StallInfo == nil then
        self.UIAuctionPanel_StallInfo = templatemanager.GetNewTemplate(self:GetStall_Go(), luaComponentTemplates.UIAuctionPanel_StallInfo, self)
    end
    return self.UIAuctionPanel_StallInfo
end

---刷新摊位信息
function UIAuctionPanel_StallPanel:RefreshStallPanel()

    ---当前没有摊位
    local boothInfo = CS.CSScene.MainPlayerInfo.AuctionInfo.BoothInfo
    if boothInfo == nil then
        self:GetStallInfoTemplate():StopRefreshTitleInfoTime()
        self:GetStallInfoTemplate():RefreshNameTemplate(true, { 1, 2, 3, 4 })
        self:GetStallInfoTemplate():RefreshStallInfoTemplate(false, { 1 })
        self:GetStallInfoTemplate():RefreshMapInfoTable(true, { 1 })
        self:GetStallInfoTemplate():ChangeMultitermChooseState(false)
    else
        self:GetStallInfoTemplate():RefreshNameTemplate(true, self:CheckListToTable(boothInfo.label))
        self:GetStallInfoTemplate():RefreshStallInfoTemplate(true, self:GetIndexByStallId(boothInfo.boothTypeId))
        self:GetStallInfoTemplate():RreshTitleInfoTime()
        self:GetStallInfoTemplate():RefreshMapInfoTable(true, self:GetIndexByMapId(boothInfo.boothMapId))
        self:GetStallInfoTemplate():RefreshMapTitleAndTween(false, self:GetMapName(boothInfo))
        self:GetStallInfoTemplate():ChangeMultitermChooseState(true)
    end
    local ShowBtn = ternary(boothInfo == nil, "摆摊", "收起摊位")
    self:GetStallInfoTemplate():RefreshBtnLabel(ShowBtn)
end

---检查列表转换成table
function UIAuctionPanel_StallPanel:CheckListToTable(list)
    if list == nil or type(list) == "table" then
        return list
    end
    local mTable = {}
    if list.Count ~= nil and list.Count > 0 then
        local length = list.Count - 1
        for k = 0, length do
            local v = list[k]
            mTable[k + 1] = v
        end
    end
    return mTable
end

---获取地图名字
function UIAuctionPanel_StallPanel:GetMapName(boothInfo)
    return CS.CSScene.MainPlayerInfo.AuctionInfo:AnalysisMapName(boothInfo)
end

---获取摊位类型名字
function UIAuctionPanel_StallPanel:GetStallTypeName(stallCostId)
    local stallTypeName = ""
    if stallCostId ~= nil then
        local stallCostInfoIsFind, stallCostInfo = CS.Cfg_StallCostTableManager.Instance:TryGetValue(stallCostId)
        if stallCostInfoIsFind then
            stallTypeName = CS.CSScene.MainPlayerInfo.AuctionInfo:AnalysisName(stallCostInfo)
        end
    end
    return stallTypeName
end

---获取摊位花费下标
function UIAuctionPanel_StallPanel:GetIndexByStallId(stallId)
    local curTable = {}
    if self:GetStallInfoTemplate() ~= nil and self:GetStallInfoTemplate().stallIdAndIndexTable ~= nil then
        table.insert(curTable,self:GetStallInfoTemplate().stallIdAndIndexTable[stallId])
        return curTable
    end
end

---获取地图id下标
function UIAuctionPanel_StallPanel:GetIndexByMapId(mapId)
    local curTable = {}
    if self:GetStallInfoTemplate() ~= nil and self:GetStallInfoTemplate().mapIdAndIndexTable ~= nil then
        table.insert(curTable,self:GetStallInfoTemplate().mapIdAndIndexTable[mapId])
        return curTable
    end
end

return UIAuctionPanel_StallPanel