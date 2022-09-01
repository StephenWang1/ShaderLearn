---GM道具模板
local UIGMItemTemplate = {}

--region 局部变量

--endregion

--region 初始化
function UIGMItemTemplate:Init()
    self:InitComponents()
    self:BindUIEvents()
end

function UIGMItemTemplate:InitComponents()
    self.icon_UISprite = self:Get("icon", "UISprite")
    self.iconChoose_UISprite = self:Get("itemchoose", "UISprite")
    self.name_UILabel = self:Get("name", "UILabel")
    self.id_UILabel = self:Get("id", "UILabel")
    self.ItemID = nil
end

function UIGMItemTemplate:InitParameters(info)
    --TABLE.CFG_ITEMS
    self.info = info
    self.servantId = info.servantId
end
--endregion

--region UI事件
function UIGMItemTemplate:BindUIEvents()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.IconOnClick
end

function UIGMItemTemplate:IconOnClickEvent(IconOnClickCallBack)
    self.mIconOnClickEvent = IconOnClickCallBack
end

function UIGMItemTemplate:IconOnClick()
    if (self.mIconOnClickEvent ~= nil) then
        self:mIconOnClickEvent()
    end
end
--endregion

--region 界面
function UIGMItemTemplate:ReFreshUI()
    self.name_UILabel.text = self.info.name
    local color = tostring(string.Split(self.info.name, ']')[1]) .. ']'
    self.id_UILabel.text = color .. self.info.id
    self.ItemID = self.info.id
    self.icon_UISprite.spriteName = tostring(self.info.icon)
end
--endregion
return UIGMItemTemplate