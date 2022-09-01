---单个物品Item页签
local UITreasurePanel_Item = {}

function UITreasurePanel_Item:InitComponents()
    ---图片
    self.mIcon_UISprite = self:Get("icon", "Top_UISprite")
    self.count = self:Get("count", "Top_UILabel")
    self.effect = self:Get("effect", "CSUIEffectLoad")
    ---ItemId
    self.mItemId = -1
    ---Item数据
    self.mItemInfo = nil
    if self.mIcon_UISprite ~= nil then
        self.mIcon_UISprite.gameObject:SetActive(true)
    end
end

function UITreasurePanel_Item:InitOther()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClinkItem
end

function UITreasurePanel_Item:Init()
    self:InitComponents()
    self:InitOther()
    self.isShowBtn = true
end

---清除所有
function UITreasurePanel_Item:Clear()
    if self.mIcon_UISprite.spriteName ~= nil then
        self.mIcon_UISprite.spriteName = "110102089"
        self.count.text = ''
    end
    self.mItemId = -1
    self.mItemInfo = nil
end

---显示UI
function UITreasurePanel_Item:RefreshUI(itemID, bagItemInfo,effectID)
    self.mItemId = itemID
    self.oldmBagItemInfo=self.mBagItemInfo
    self.mBagItemInfo = bagItemInfo
    self.mItemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(itemID)
    local spriteName = ""
    if self.mItemInfo ~= nil then
        spriteName = self.mItemInfo.icon
    end
    if itemID==nil then
        self.count.text = ''
    end
    if self.mBagItemInfo ~= nil then
        if self.mBagItemInfo.count > 1 then
            self.count.text = self.mBagItemInfo.count
        else
            self.count.text = ''
        end

    end
    if self.mIcon_UISprite ~= nil then
        self.mIcon_UISprite.spriteName = spriteName
    end
    if self.effect~=nil and effectID~=nil and effectID~=0  then
        self.effect:ChangeEffect(effectID)
        self.effect.gameObject:SetActive(false)
        self.effect.gameObject:SetActive(true)
    end
end

---设置飞入动画
function UITreasurePanel_Item:SetFlyAnim()
    if self.oldmBagItemInfo~=nil and self.mBagItemInfo==nil then
        luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId =self.oldmBagItemInfo.itemId, from = self.go.transform.position })        
    end
end

function UITreasurePanel_Item:IsShowTipsBtn(IsShowBtn)
    self.isShowBtn = IsShowBtn
end


function UITreasurePanel_Item:OnClinkItem()
    if self.mItemInfo == nil then
        return
    end
    if self.mBagItemInfo ~= nil then
        
        ---tips会根据index字段显示已装备图标
        self.mBagItemInfo.index = 0
        uiStaticParameter.UIItemInfoManager:CreatePanel({bagItemInfo = self.mBagItemInfo ,
                 rightUpButtonsModule = luaComponentTemplates.UITreasurePanel_ItemPartRightUpOperate,
                 showRight = self.isShowBtn,
                 showAssistPanel = true,
                 showMoreAssistData = true,
                 showTabBtns= true})
    elseif self.mItemInfo ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = self.mItemInfo ,
                 rightUpButtonsModule = luaComponentTemplates.UITreasurePanel_ItemPartRightUpOperate,
                 showRight = false,
                 showAssistPanel = true,
                 showMoreAssistData = true,
                 showTabBtns= true})
    end
end

return UITreasurePanel_Item