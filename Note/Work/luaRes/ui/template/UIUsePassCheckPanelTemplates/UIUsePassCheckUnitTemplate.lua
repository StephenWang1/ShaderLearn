local UIUsePassCheckUnitTemplate = {};

UIUsePassCheckUnitTemplate.mNpcId = nil;

--region Components

function UIUsePassCheckUnitTemplate:GetName_Text()
    if (self.mName_Text == nil) then
        self.mName_Text = self:Get("Background/Label", "UILabel");
    end
    return self.mName_Text;
end

--endregion

--region Method

--region Public

function UIUsePassCheckUnitTemplate:UpdateUnit(mapId, mapNpcId)
    local isFind, mapTable = CS.Cfg_MapTableManager.Instance:TryGetValue(mapId);
    self.mNpcId = mapNpcId;
    if (isFind) then
        self.mMapTable = mapTable;
        self:GetName_Text().text = mapTable.name;
    end
end

function UIUsePassCheckUnitTemplate:TryGoToTheMap()
    if (self.mNpcId ~= nil) then
        CS.CSScene.MainPlayerInfo.AsyncOperationController.MapPassCheckUsedToFindNPCOperation:DoOperation(self.mNpcId, self.mMapTable == nil and 0 or self.mMapTable.id)
        uimanager:ClosePanel("UIUsePassCheckPanel");
    end
end

--endregion

--region Private

---@return number 是否可以使用门票 0没有异常可以进入 1:所需门票不足
function UIUsePassCheckUnitTemplate:GetGoToMapCode()
    if (self.mMapTable ~= nil) then
        local conditionIds = self.mMapTable.conditionId
        if (conditionIds ~= nil and conditionIds.list ~= nil and conditionIds.list.Count > 0) then
            for i = 0, conditionIds.list.Count - 1 do
                local conditionId = conditionIds.list[i];
                if (conditionId ~= nil) then
                    local isMatch = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionId);
                    if (not isMatch) then
                        return 1;
                    end
                end
            end
        end
    end
    return 0;
end

function UIUsePassCheckUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        self:TryGoToTheMap();
    end
end

function UIUsePassCheckUnitTemplate:RemoveEvents()

end

--endregion

--endregion

function UIUsePassCheckUnitTemplate:Init()
    self:InitEvents();
end

function UIUsePassCheckUnitTemplate:OnDestroy()
    self:RemoveEvents();
end

return UIUsePassCheckUnitTemplate;