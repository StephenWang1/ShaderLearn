local BuDouKaiLuaDataClass = {}
--region 擂台
---打开隐形墙
function BuDouKaiLuaDataClass:OpenInVisibilityWall(tblData)
    --if tblData.wallPoint == nil or type(tblData.wallPoint) ~= 'table' or #tblData.wallPoint <= 0 or self:StageHaveWall(tblData.phase) == false then
    --    self:CloseInVisibilityWall()
    --    return
    --end
    self:CloseInVisibilityWall()
    if self.InVisibilityWallTable == nil then
        self.InVisibilityWallTable = {}
    end
    if self:StageHaveWall(tblData.phase) == true then
        for k,v in pairs(tblData.wallPoint) do
            local point = v
            local cell = CS.CSScene.Sington.Mesh:getCell(point.pointX,point.pointY)
            if cell ~= nil and cell.node ~= nil then
                cell.node:AddObstacleReason(CS.EObstacleReasonType.WudaohuiQiang)
                table.insert(self.InVisibilityWallTable,cell)
            end
        end
    end
end

---关闭隐形墙
function BuDouKaiLuaDataClass:CloseInVisibilityWall()
    if self.InVisibilityWallTable == nil or type(self.InVisibilityWallTable) ~= 'table' or #self.InVisibilityWallTable <= 0 then
        return
    end
    for k,v in pairs(self.InVisibilityWallTable) do
        if v ~= nil and v.node ~= nil then
            v.node:RemoveObstacleReason(CS.EObstacleReasonType.WudaohuiQiang)
        end
    end
end

---阶段是否有隐形墙
---@param 阶段 number
function BuDouKaiLuaDataClass:StageHaveWall(stage)
    local wudaohuiInfoIsFind,wudaohuiInfo = CS.Cfg_WuDaoHuiTableManager.Instance:TryGetValue(stage)
    if wudaohuiInfoIsFind then
        return wudaohuiInfo.fieldEffect ~= nil and wudaohuiInfo.fieldEffect.list ~= nil and  wudaohuiInfo.fieldEffect.list.Count > 0
    end
end
--endregion

---游戏场景退回到登录/选角界面时触发
function BuDouKaiLuaDataClass:OnExitDestroy()
    self.InVisibilityWallTable = nil
end

return BuDouKaiLuaDataClass