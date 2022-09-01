---@class UIRechargeViewTemplate:BaseTemplate
local UIRechargeViewTemplate = {};

UIRechargeViewTemplate.mRechargeUnitDic = nil;

--region Component

function UIRechargeViewTemplate:GetUnitGridContainer()
    if (self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = self:Get("Grid", "UIGridContainer");
    end
    return self.mUnitGridContainer;
end

--endregion

--region 初始化
function UIRechargeViewTemplate:Init(panel)
    self.panel = panel
    --networkRequest.ReqRechargeGiftBox()
end

--endregion
--region Method

--region Public

---根据充值类型显示内容
function UIRechargeViewTemplate:ShowRechargeView(rechargeType)
    if (self.mRechargeUnitDic == nil) then
        self.mRechargeUnitDic = {};
    end

    if (rechargeType == nil) then
        rechargeType = LuaEnumRechargeType.NormalRecharge;
    end

    --CS.Cfg_GlobalTableManager.Instance:GetLastRechargeReplaceType()
    local List = CS.Cfg_GlobalTableManager.Instance.VipLevelList

    --local List = CS.Cfg_RechargeTableManager.Instance:GetRechargeInfoByRechargeType(rechargeType);
    if (List ~= nil) then
        ---不参与排序的
        local rechargeTables = {};
        ---参与排序的
        local sortRechargeTables = {};
        if (List.Count > 4) then
            for i = 0, 3 do
                table.insert(rechargeTables, List[i]);
            end

            ---index为4之后的参与排序
            for i = 4, List.Count - 1 do
                table.insert(sortRechargeTables, List[i]);
            end
        else
            for i = 0, List.Count - 1 do
                table.insert(rechargeTables, List[i]);
            end
        end

        ---结果列表
        local targetTables = {};

        for k, v in pairs(rechargeTables) do
            table.insert(targetTables, v);
        end

        for k, v in pairs(sortRechargeTables) do
            table.insert(targetTables, v);
        end

        local gridContainer = self:GetUnitGridContainer();
        gridContainer.MaxCount = #targetTables;
        local index = 0;
        for i = 0, gridContainer.MaxCount - 1 do
            local gobj = gridContainer.controlList[index]
            local params = targetTables[i + 1]
            local rechargeTableInfo = nil
            if type(params) == 'number' then
                rechargeTableInfo = clientTableManager.cfg_rechargeManager:TryGetValue(targetTables[i + 1])
            else
                rechargeTableInfo = clientTableManager.cfg_rechargeManager:TryGetValue(targetTables[i + 1].id)
            end
            local rechargeUnitTemplate = luaComponentTemplates.UIRechargeUnitTemplate

            if (self.mRechargeUnitDic[index] == nil) then
                self.mRechargeUnitDic[index] = templatemanager.GetNewTemplate(gobj, rechargeUnitTemplate, self.panel);
            end
            ---@type UIRechargeUnitTemplate
            local temp = self.mRechargeUnitDic[index]
            if temp ~= nil then
                temp:RefreshUIItem(rechargeTableInfo);
            end
            index = index + 1;
        end
    end
end
--endregion

--endregion

return UIRechargeViewTemplate;