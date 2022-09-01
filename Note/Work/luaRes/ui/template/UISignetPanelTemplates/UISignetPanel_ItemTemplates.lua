local UISignetPanel_ItemTemplates = {}

function UISignetPanel_ItemTemplates:InitComponents()
    ---选择特效
    self.choose = self:Get("choose", "GameObject")
    ---+号
    self.add = self:Get("add", "Top_UISprite")
    ---道具Icon图标
    self.activityBtnIcon = self:Get("icon", 'Top_UISprite')



end
function UISignetPanel_ItemTemplates:InitOther()
    ---data bagV2.BagItemInfo
    self.data = nil
    ---parentPanel  UISignetPanel
    self.parentPanel = nil
    ---Item表数据
    self.TABEL_Item = nil
    ---道具是否满足镶嵌条件
    self.isCanUse = nil

    self.choose:SetActive(false)
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClickItem

    CS.UIEventListener.Get(self.go).onPress = function(grid, state)
        self:OnRolePanelGirdOnPress(grid, state)
    end

    self.IsNeedOnClick = true

    self.updateItem = CS.CSListUpdateMgr.Add(300, nil, function()
        if self.mIsLongPress then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.data.BagItemInfo, showRight = false })
            self.IsNeedOnClick = false
        end
    end)
end

function UISignetPanel_ItemTemplates:Init()
    self:InitComponents()
    self:InitOther()
end
---刷新UI
---data CS.SignetInlayDetailInfo
---parentPanel  UISignetPanel
function UISignetPanel_ItemTemplates:RefreshUI(data, parentPanel)
    self.data = data
    self.parentPanel = parentPanel
    local isfind = false
    if data ~= nil then
        self.TABEL_Item = data.BagItemInfo.ItemTABLE
        if data.IsCanInlay then
            self.add.spriteName = "arrow2"-- CS.UnityEngine.Color(1, 1, 1);
        else
            self.add.spriteName = "arrow3"-- CS.UnityEngine.Color(0, 0, 0);
        end
    end
    if self.TABEL_Item ~= nil then
        self.activityBtnIcon.spriteName = tostring(self.TABEL_Item.icon);
    end

    self.add.gameObject:SetActive(data.IsBetter)
end

---点击道具
function UISignetPanel_ItemTemplates:OnClickItem()
    if self.IsNeedOnClick == false then
        return
    end
    local floatDes = ""
    if self.data.BagItemInfo ~= nil then
        if self.choose.gameObject.activeInHierarchy then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.data.BagItemInfo, showRight = false })
        else
            self.parentPanel.SelectBagSignet(self.data, self.data.BagItemInfo.imprint)
        end
    end
end

---格子按下事件
function UISignetPanel_ItemTemplates:OnRolePanelGirdOnPress(go, state)

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


return UISignetPanel_ItemTemplates