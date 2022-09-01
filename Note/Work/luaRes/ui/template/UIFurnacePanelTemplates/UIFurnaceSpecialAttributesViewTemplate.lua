---@class UIFurnaceSpecialAttributesViewTemplate:TemplateBase
local UIFurnaceSpecialAttributesViewTemplate = {};

UIFurnaceSpecialAttributesViewTemplate.mOwnerPanel = nil;

---@type table<CS.UnityEngine.GameObject, UIFurnaceSpecialAttributesUnitTemplate>
UIFurnaceSpecialAttributesViewTemplate.mUnitDic = nil;

UIFurnaceSpecialAttributesViewTemplate.mCurFurnaceId = nil;

---@type table<number, number>
UIFurnaceSpecialAttributesViewTemplate.mFurnaceIds = nil;

UIFurnaceSpecialAttributesViewTemplate.mCallBack = nil;

function UIFurnaceSpecialAttributesViewTemplate:GetUnitGridContainer()
    if(self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = self:Get("Grid","UIGridContainer");
    end
    return self.mUnitGridContainer;
end

function UIFurnaceSpecialAttributesViewTemplate:UpdateView(curFurnaceId, furnaceIds, furnaceType, callBack)
    self.mCurFurnaceId = curFurnaceId;
    self.mFurnaceIds = furnaceIds;
    self.mCallBack = callBack;
    self.mFurnaceType = furnaceType;
    self:UpdateUI();
end

function UIFurnaceSpecialAttributesViewTemplate:UpdateUI()
    if(self.mUnitDic == nil) then
        self.mUnitDic = {};
    end

    local gridContainer = self:GetUnitGridContainer();
    if(self.mFurnaceIds ~= nil) then
        gridContainer.MaxCount = #self.mFurnaceIds;
        local index = 0;
        for k,v in pairs(self.mFurnaceIds) do
            local gobj = gridContainer.controlList[index];
            if(self.mUnitDic[gobj] == nil) then
                self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIFurnaceSpecialAttributesUnitTemplate, self);
            end
            local isEnd = k == #self.mFurnaceIds;
            self.mUnitDic[gobj]:UpdateUnit(self.mCurFurnaceId, v, k, self.mFurnaceType, isEnd, self.mCallBack);
            index = index + 1;
        end
    else
        gridContainer.MaxCount = 0;
    end
end

function UIFurnaceSpecialAttributesViewTemplate:Init(panel)
    self.mOwnerPanel = panel;
end

return UIFurnaceSpecialAttributesViewTemplate;