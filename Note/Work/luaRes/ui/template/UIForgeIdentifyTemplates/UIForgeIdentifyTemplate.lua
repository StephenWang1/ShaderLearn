---@class UIForgeIdentifyTemplate
local UIForgeIdentifyTemplate = {}

function UIForgeIdentifyTemplate:InitComponents()
    self.Label = self:Get("Label", "UILabel")
    self.icon = self:Get("icon", "UISprite")
    self.costNum = self:Get("costNum", "UILabel")
    self.choose = self:Get("choose", "GameObject")
    self.toggle_identify = self:Get("toggle_identify", "GameObject")
    self.toggle = self:Get("toggle_identify", "UIToggle")
    self.lb_inIdentifyDes = self:Get("lb_inIdentifyDes", "UISprite")
    self.lb_inIdentifyDes_GameObject = self:Get("lb_inIdentifyDes", "GameObject")
    self.lock = self:Get("lock","GameObject")
end

function UIForgeIdentifyTemplate:InitOther()

    CS.UIEventListener.Get(self.go.gameObject).onClick = function(go)
        self:OnClickedSelf()
    end

    CS.UIEventListener.Get(self.toggle_identify).onClick = function(go)
        self:OnToggleClick()
    end
end

---初始化数据
function UIForgeIdentifyTemplate:Init()
    self:InitComponents()
    self:InitOther()
    self.sellectItemID =1
end

function UIForgeIdentifyTemplate:RefreshUI(data, basepanel)
    if data.id == 1 then
        self.lb_inIdentifyDes_GameObject:SetActive(false)
    elseif data.id == 3 then
        self.lb_inIdentifyDes.spriteName = "ForgeIdentify_lb_2"
    end
    self.data = data
    self.basepanel = basepanel
    self.Label.text = data.name
    self.icon.spriteName = data.itemId
    self.costNum.text = data.cost
    self.needShow = data.needShow
    if data.needShow == true then
        self.lock:SetActive(true)
    else
        self.lock:SetActive(false)
    end
    self:RefreshToggle(data)
end

function UIForgeIdentifyTemplate:RefreshToggle(data)
    local type = self.basepanel.sellectItemID
    if type == nil then
        type = 1
    end
    if type == 1 then
        self.toggle_identify.gameObject:SetActive(data.id == 1)
        return
    end
    self.toggle_identify.gameObject:SetActive(false)
end

function UIForgeIdentifyTemplate:RefreshChoose(data)
    self.choose.gameObject:SetActive(data.id == 1)
end

function UIForgeIdentifyTemplate:OnClickedSelf()
    if self.basepanel.IsUse == true then
        return
    end
    if self.basepanel.sellectItemID == self.data.id then
        if self.needShow == true then
            Utility.ShowItemGetWay(tonumber(self.data.itemId), self.go)
        else
            local res, itemData = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(tonumber(self.data.itemId))
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemData, showRight = false })
        end
        return
    end
    if self.basepanel ~= nil then
        self.basepanel:ChooseItem(self.data.id)
        self.basepanel:ForGeIdentifyUpdate(false)
    end
end

function UIForgeIdentifyTemplate:RefreShChoose(sellectItemID)
    self.sellectItemID = sellectItemID
    self.choose.gameObject:SetActive(sellectItemID == self.data.id)
end

function UIForgeIdentifyTemplate:OnToggleClick()
    if self.basepanel ~= nil then
        self.basepanel:IsToggleOn(self.toggle.isChecked)
    end
end

return UIForgeIdentifyTemplate