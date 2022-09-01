---@class FindPath 寻路通用
local FindPath = {}

---寻路Npc
---@param npcId number
function FindPath:FindPath_Npc(npcId)
    local npcTblIsFind,npcTbl = CS.Cfg_NpcTableManager.Instance:TryGetValue(npcId)
    if npcTblIsFind then
        CS.CSScene.MainPlayerInfo.AsyncOperationController.ClickAndGoToNPCOperation:DoOperation(npcTbl)
    end
end

---通过DeliverId寻路
---@param deliverId number
function FindPath:FindPath_DeliverId(deliverId)
    CS.CSScene.MainPlayerInfo.AsyncOperationController.GeneralFindPathAndOpenPanelByDeliverIDOperation:DoOperation(deliverId)
end

---寻路地图点
---@param mapId number
---@param x number
---@param y number
function FindPath:FindPath_Point(mapId,x,y)
    CS.CSScene.MainPlayerInfo.AsyncOperationController.MapPointOperationFindPathOperation:DoOperation(mapId,x,y)
end

return FindPath