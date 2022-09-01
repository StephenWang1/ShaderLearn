---极品奖励模板
---@class UICrawlTowerBestRewardTemplate
local UICrawlTowerBestRewardTemplate = {}

---初始化数据
function UICrawlTowerBestRewardTemplate:Init(list)
    self.RewardList = list
    self:BindUIEvent()

end

---@param data  commonV2.IntIntStruct
function UICrawlTowerBestRewardTemplate:RefreshUI(data, isFinish)
    local get = CS.Utility_Lua.Get(self.go.transform, "get", "GameObject")
    local frame = CS.Utility_Lua.Get(self.go.transform, "frame", "GameObject")
    local icon = CS.Utility_Lua.Get(self.go.transform, "icon", "UISprite")
    local count = CS.Utility_Lua.Get(self.go.transform, "count", "UILabel")
    ---@type CSUIEffectLoad
    ---@type CSUIEffectLoad
    local effectLoad = CS.Utility_Lua.Get(self.go.transform, "frame", "CSUIEffectLoad")
    count.text = data.value == 1 and "" or data.value
    local itemId = data.key
    self.itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if self.itemInfo == nil then
        return
    end
    icon.spriteName = self.itemInfo:GetIcon()

    if not isFinish then
        local effectID = gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo():GetItemEffectId(itemId)
        if effectID then
            effectLoad.effectId = effectID
        end
        frame:SetActive(effectID)
    else
        frame:SetActive(not isFinish)
    end

    get:SetActive(isFinish)
    icon.color = isFinish and LuaEnumUnityColorType.HalfTransparent or CS.UnityEngine.Color.white


end

function UICrawlTowerBestRewardTemplate:BindUIEvent()
    CS.UIEventListener.Get(self.go).onClick = function()
        if self.itemInfo == nil then
            return
        end
        local isFind, ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.itemInfo.id)
        uiStaticParameter.UIItemInfoManager:CreatePanel({
            itemInfo = ItemInfo,
            showRight = false
        })
    end
end

return UICrawlTowerBestRewardTemplate