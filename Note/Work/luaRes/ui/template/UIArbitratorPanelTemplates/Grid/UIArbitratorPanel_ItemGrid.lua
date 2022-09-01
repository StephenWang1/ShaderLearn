local UIArbitratorPanel_ItemGrid = {}
--region 初始化
function UIArbitratorPanel_ItemGrid:Init()
    self:InitComponent()
    self:BindClick()
end

function UIArbitratorPanel_ItemGrid:InitComponent()
    self.go_UISprite = self:Get("","UISprite")
    self.star_UILabel = self:Get("star","UILabel")
    self.star_bg_GameObject = self:Get("star_bg","GameObject")
end

function UIArbitratorPanel_ItemGrid:BindClick()
    CS.UIEventListener.Get(self.go_UISprite.gameObject).onClick = function()
        self:ShowItemInfo()
    end
end
--endregion

--region 事件
function UIArbitratorPanel_ItemGrid:ShowItemInfo()
    uiStaticParameter.UIItemInfoManager:CreatePanel({bagItemInfo = self.bagItemInfo,showRight = false})
end
--endregion

--region 刷新
function UIArbitratorPanel_ItemGrid:RefreshUI(grid)
    self.bagItemInfo = grid.bagItemInfo
    self.itemInfo = grid.itemInfo
    self:RefreshIcon()
    self:RefreshStrength()
end

function UIArbitratorPanel_ItemGrid:RefreshIcon()
    if self.go_UISprite ~= nil and not CS.StaticUtility.IsNull(self.go_UISprite) and self.itemInfo ~= nil then
        self.go_UISprite.spriteName = self.itemInfo.icon
    end
end

function UIArbitratorPanel_ItemGrid:RefreshStrength()
    if self.star_UILabel ~= nil and not CS.StaticUtility.IsNull(self.star_UILabel) and self.star_bg_GameObject  ~= nil and not CS.StaticUtility.IsNull(self.star_bg_GameObject) and self.bagItemInfo ~= nil then
        if self.bagItemInfo.intensify > 0 then
            self.star_UILabel.text =  "★" .. tostring(self.bagItemInfo.intensify)
            self.star_bg_GameObject:SetActive(true)
        else
            self.star_UILabel.text = ""
            self.star_bg_GameObject:SetActive(false)
        end
    end
end
--endregion
return UIArbitratorPanel_ItemGrid