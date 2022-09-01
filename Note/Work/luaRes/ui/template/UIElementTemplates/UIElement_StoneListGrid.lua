local UIElement_StoneListGrid = {}
function UIElement_StoneListGrid:Init()
    self:InitConpoment()
    self:ResetUI()
end

function UIElement_StoneListGrid:InitConpoment()
    self.choose = self:Get("choose", "GameObject")
    self.go_Sprite = self:Get("icon", "UISprite")
    self.good_UISprite = self:Get("add", "UISprite")
end

function UIElement_StoneListGrid:ResetUI()
    self:SetChoose(false)
    self.go_Sprite.spriteName = ""

    CS.UIEventListener.Get(self.go).onPress = function(grid, state)
        self:OnRolePanelGirdOnPress(grid, state)
    end

    self.updateItem = CS.CSListUpdateMgr.Add(300, nil, function()
        if self.mIsLongPress then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.bagItemInfo, showRight = false })
            self.IsNeedOnClick = false
        end
    end)
end

function UIElement_StoneListGrid:RefreshUI(commondata)
    self.bagItemInfo = commondata.bagItemInfo
    self.itemInfo = commondata.itemInfo
    self.index = ternary(commondata.index == nil, 0, commondata.index)
    self.btnCallBack = commondata.btnCallBack
    self.chooseIndex = commondata.chooseIndex
    self.arrowType = commondata.arrowType
    self:RefreshIcon()
    self:RefreshOnClick()
    self:RefreshGoodIcon()
    self:InitSetChooseItem()
    self:RefreshGray()
end

---初始选择元素石
function UIElement_StoneListGrid:InitSetChooseItem()
    if self.index == self.chooseIndex then
        self:StoneGridOnClilck(self.go)
    end
end

function UIElement_StoneListGrid:RefreshIcon()
    if self.itemInfo ~= nil then
        self.go_Sprite.spriteName = self.itemInfo.icon
        self.go_Sprite.gameObject:SetActive(true)
    end
end

function UIElement_StoneListGrid:SetChoose(state)
    if self.choose ~= nil and self.bagItemInfo ~= nil then
        self.choose:SetActive(state)
        self.isChoose = state
    end
end

function UIElement_StoneListGrid:RefreshGoodIcon()
    if self.good_UISprite ~= nil then
        if self.arrowType ~= LuaEnumArrowType.NONE then
            self.good_UISprite.gameObject:SetActive(true)
            self.good_UISprite.spriteName = CS.Cfg_GlobalTableManager.Instance:GetArrowSpriteName(self.arrowType)
        else
            self.good_UISprite.gameObject:SetActive(false)
        end
    end
end

function UIElement_StoneListGrid:RefreshOnClick()
    local mOnClick = CS.UIEventListener.Get(self.go)
    if self.itemInfo ~= nil and self.btnCallBack ~= nil then
        mOnClick.onClick = function(go)
            self:StoneGridOnClilck(go)
        end
    end
end

function UIElement_StoneListGrid:StoneGridOnClilck(go)
    if self.IsNeedOnClick == false then
        return
    end
    if self.isChoose then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.bagItemInfo, showRight = false })
    else
        self:btnCallBack(go, self.bagItemInfo, self.itemInfo)
        self:SetChoose(true)
    end
end

---刷新置灰
function UIElement_StoneListGrid:RefreshGray()
    local color = CS.UnityEngine.Color.white
    if self.arrowType == LuaEnumArrowType.YellowArrow then
        color = CS.UnityEngine.Color(0,0,0,128/255)
    end
    self.go_Sprite.color = color
    self.good_UISprite.color = color
end

---格子按下事件
function UIElement_StoneListGrid:OnRolePanelGirdOnPress(go, state)
    self.mTimer = 0;
    if (state) then
        self.mIsLongPress = true
        self.IsNeedOnClick = true
        self.updateItem.timeDelay = 300
        CS.CSListUpdateMgr.Instance:Add(self.updateItem)
    else
        self.mIsLongPress = false;
        CS.CSListUpdateMgr.Instance:Remove(self.updateItem)
    end
end


---打开获取途径面板
--function UIElement_StoneListGrid:OpenWayGetPanel()
--    local customData = {};
--    customData.arrowDir = LuaEnumWayGetPanelArrowDirType.Down;
--    customData.globalId = 20431;
--    uimanager:CreatePanel("UIFurnaceWayAndBuyPanel", nil, customData)
--end
return UIElement_StoneListGrid