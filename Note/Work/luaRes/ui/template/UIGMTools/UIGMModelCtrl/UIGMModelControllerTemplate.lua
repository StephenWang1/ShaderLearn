---@class UIGMModelControllerTemplate:TemplateBase
local UIGMModelControllerTemplate = {}

function UIGMModelControllerTemplate:Init()
    ---@type UIGridContainer
    self.mModelInfoGridController = self:Get("ModelInfoView/Infos", "UIGridContainer")
    self.mTimer = 0
    self.mRefreshTimeInterval = 1
    self.mNextRefreshTime = 0
    local luaUpdate = CS.LuaUpdateBehaviour.Get(self.go)
    if luaUpdate then
        luaUpdate:SetLuaFunction(self, self.OnUpdate)
    end
end

function UIGMModelControllerTemplate:Show()
    self.go:SetActive(true)
end

function UIGMModelControllerTemplate:Hide()
    self.go:SetActive(false)
end

function UIGMModelControllerTemplate:OnUpdate()
    self.mTimer = CS.UnityEngine.Time.time
    if self.mTimer > self.mNextRefreshTime then
        self.mNextRefreshTime = self.mTimer + self.mRefreshTimeInterval
        self:RefreshInfos()
    end
end

function UIGMModelControllerTemplate:RefreshInfos()
    if CS.CSScene.Sington == nil then
        return
    end
    self.mInfoLabels = {}
    --local modelAmount = CS.CSScene.Sington.InViewData:GetModelAmount()
    --self:SetInfo("除主角外模型数量:  " .. tostring(modelAmount))
    self:RefreshAllInfoLabels()
end

function UIGMModelControllerTemplate:SetInfo(content)
    table.insert(self.mInfoLabels, content)
end

function UIGMModelControllerTemplate:RefreshAllInfoLabels()
    if self.mInfoLabels then
        local count = #self.mInfoLabels
        self.mModelInfoGridController.MaxCount = count
        for i = 0, count - 1 do
            local go = self.mModelInfoGridController.controlList[i]
            if go and CS.StaticUtility.IsNull(go) == false then
                local label = CS.Utility_Lua.GetComponent(go,"UILabel")
                if label and CS.StaticUtility.IsNull(label) == false then
                    label.text = self.mInfoLabels[i + 1]
                end
            end
        end
    end
end

return UIGMModelControllerTemplate