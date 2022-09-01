---@class UICarnivalPanel_CountRewardTemplate:TemplateBase
local UICarnivalPanel_CountRewardTemplate = {}

---@return UISprite
function UICarnivalPanel_CountRewardTemplate:GetIcon_UISprite()
    if self.mIconSp == nil then
        self.mIconSp = self:Get("icon", "UISprite")
    end
    return self.mIconSp
end

---@return UILabel
function UICarnivalPanel_CountRewardTemplate:GetCount_UILabel()
    if self.mCountLb == nil then
        self.mCountLb = self:Get("count", "UILabel")
    end
    return self.mCountLb
end

---@return UnityEngine.GameObject
function UICarnivalPanel_CountRewardTemplate:GetLock_GO()
    if self.mLockGo == nil then
        self.mLockGo = self:Get("lock", "GameObject")
    end
    return self.mLockGo
end

---@param panel UICarnivalPanel_CountTemplate
function UICarnivalPanel_CountRewardTemplate:Init(panel)
    self.mRootPanel = panel

end

---@param rewardInfo CarnivalRewardInfo
function UICarnivalPanel_CountRewardTemplate:RefreshReward(rewardInfo)
    if rewardInfo == nil then
        return
    end
    local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(rewardInfo.itemId)
    if res then
        self:GetIcon_UISprite().spriteName = itemInfo.icon
        CS.UIEventListener.Get(self:GetIcon_UISprite().gameObject).onClick = function()
            if rewardInfo.isLock then
                uimanager:CreatePanel("UICarnivalItemActivePanel", nil, self:GetAllLockReward())
            else
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
            end
        end
    end
    self:GetCount_UILabel().text = rewardInfo.num
    self:GetLock_GO():SetActive(rewardInfo.isLock)
end

function UICarnivalPanel_CountRewardTemplate:GetAllLockReward()
    if self.mRootPanel then
        return self.mRootPanel:GetAllLockReward()
    end
end

return UICarnivalPanel_CountRewardTemplate