---送花界面模板
---@class UISendFlowerPanelGridTemplate
local UISendFlowerPanelGridTemplate = {}

--region组件
function UISendFlowerPanelGridTemplate:Init()
    self:InitComponents()
    self.flowerType = 0
    self.ItemInfo = nil
    self.flowerCount = 0
end

function UISendFlowerPanelGridTemplate:InitComponents()
    self.count = self:Get("count", "UILabel")
    ---头像
    self.Icon_UISprite = self:Get("icon", "UISprite")
    -----名字
    --self.name_UILabel = self:Get("name", "UILabel")
    -----描述
    --self.dec_UILabel = self:Get("dec", "UILabel")
    ---选中
    self.Choose_GameObject = self:Get("effect", "GameObject")
end
--endregion

---设置选中
function UISendFlowerPanelGridTemplate:ChooseItem(isShow)
    self.Choose_GameObject:SetActive(isShow)
end

---刷新
---@param flowerType XLua.Cast.Int32 LuaEnumFlowerType 花类型
function UISendFlowerPanelGridTemplate:RefreshGrid(flowerType)
    if flowerType then
        self.flowerType = flowerType
        local res, ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.flowerType)
        if res then
            self.ItemInfo = ItemInfo
            self.Icon_UISprite.spriteName = ItemInfo.icon
            self.flowerCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(self.flowerType)
            self.count.text = self.flowerCount == 0 and "" or tostring(self.flowerCount)
            --self.Icon_UISprite.color = self.flowerCount == 0 and CS.UnityEngine.Color.gray or CS.UnityEngine.Color.white
            --self.name_UILabel.text = ItemInfo.name
            --local intimate = 0
            --if ItemInfo.useParam and ItemInfo.useParam.list.Count >= 1 then
            --    intimate = ItemInfo.useParam.list[1]
            --end
            --local addInfo = ternary(intimate == 1, "", "并公告全服")
            --self.dec_UILabel.text = "增加" .. intimate .. "点亲密度" .. addInfo
        end
    end
end

return UISendFlowerPanelGridTemplate