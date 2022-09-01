---@class UIGoMapBtnView:luaobject
local UIGoMapBtnView = {};

---@type table<UnityEngine.GameObject,UIGoMapBtnUnit>
UIGoMapBtnView.mBtnUnitDic = nil;

--region Components
function UIGoMapBtnView:GetUnitGridContainer_UIGridContainer()
    if (self.mUnitGridContainer_UIGridContainer == nil) then
        self.mUnitGridContainer_UIGridContainer = CS.Utility_Lua.GetComponent(self.go, "UIGridContainer");
    end
    return self.mUnitGridContainer_UIGridContainer;
end
--endregion

--region Method
---@param sortData table
---@param count number
function UIGoMapBtnView:ShowBtnWithMapIds(sortData, count)
    local gridContainer = self:GetUnitGridContainer_UIGridContainer();
    gridContainer.MaxCount = count;
    local sortedBtnData = {}
    --for k_1, v_1 in pairs(sortData) do
    --    for k_2, v_2 in pairs(v_1) do
    --        table.insert(sortedBtnData, v_2)
    --    end
    --end
    local canChallenge = 1
    local notChallenge = 2
    if sortData[canChallenge] ~= nil then
        local temp = sortData[canChallenge]
        for i = 1, #temp do
            table.insert(sortedBtnData, temp[i])
        end
    end
    if sortData[notChallenge] ~= nil then
        local temp = sortData[notChallenge]
        for i = 1, #temp do
            table.insert(sortedBtnData, temp[i])
        end
    end
    --table.sort(sortedBtnData, self.BtnSortFunction)
    if count > 0 then
        local countOfData = #sortedBtnData
        for i = 1, count do
            if i <= countOfData then
                local v_2 = sortedBtnData[i]
                local gobj = gridContainer.controlList[i - 1];
                if (self.mBtnUnitDic[gobj] == nil) then
                    self.mBtnUnitDic[gobj] = luaclass.UIGoMapBtnUnit:NewWithGO(gobj)
                end
                self.mBtnUnitDic[gobj]:ShowWithData(v_2);
            end
        end
    end
end

---@private
function UIGoMapBtnView.BtnSortFunction(l, r)
    return l.order < r.order
end
--endregion

function UIGoMapBtnView:Init()
    --luaDebug.LogError("UIGoMapBtnView Init")
    self.mBtnUnitDic = {};
end

function UIGoMapBtnView:OnDestruct()
    self.mBtnUnitDic = nil
    --luaDebug.Log("UIGoMapBtnView OnDestruct")
end

return UIGoMapBtnView;