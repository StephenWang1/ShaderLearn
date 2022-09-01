---GM道具模板
local UIGMMonsterTemplate = {}

--region 局部变量

--endregion

--region 初始化
function UIGMMonsterTemplate:Init()
    self:InitComponents()
    self:BindUIEvents()
end

function UIGMMonsterTemplate:InitComponents()
    self.icon_UISprite = self:Get("icon", "UISprite")
    self.iconChoose_UISprite = self:Get("itemchoose", "UISprite")
    self.name_UILabel = self:Get("name", "UILabel")
    self.id_UILabel = self:Get("id", "UILabel")
    self.ItemID = nil
end

function UIGMMonsterTemplate:InitParameters(info)
    --TABLE.CFG_ITEMS
    self.info = info
    self.servantId = info.servantId
end
--endregion

--region UI事件
function UIGMMonsterTemplate:BindUIEvents()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.IconOnClick
end

function UIGMMonsterTemplate:IconOnClickEvent(IconOnClickCallBack)
    self.mIconOnClickEvent = IconOnClickCallBack
end

function UIGMMonsterTemplate:IconOnClick()
    if (self.mIconOnClickEvent ~= nil) then
        self:mIconOnClickEvent()
    end
end
--endregion

--region 界面
function UIGMMonsterTemplate:ReFreshUI()
    self.name_UILabel.text = self.info.name
    self.id_UILabel.text = self.info.id
    self.ItemID = self.info.id
    self.icon_UISprite.spriteName = tostring(self.info.head)
end
--endregion
return UIGMMonsterTemplate