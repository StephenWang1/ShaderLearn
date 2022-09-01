---获得物品提示模板
local UIFaceToFaceDealTemplates_TrdaeItemInfo = {}

function UIFaceToFaceDealTemplates_TrdaeItemInfo:Init()
    self.bagItemInfo = nil
    self.icon = self:Get('icon', 'Top_UISprite')
    self.lasting = self:Get('lasting', 'UILabel')
    self.notDeal = self:Get('notDeal', 'GameObject')
    ---@type UnityEngine.GameObject
    self.bloodSignGo = self:Get("BloodLv", "GameObject")
    ---@type UILabel
    self.bloodLevelLabel = self:Get("BloodLvLabel", "UILabel")
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClinkItem
end

---@param bagItemInfo bagV2.BagItemInfo
function UIFaceToFaceDealTemplates_TrdaeItemInfo:RefreshUI(bagItemInfo, IsNotAvailable, IsMy, isLock)
    self.IsNotAvailable = IsNotAvailable
    self.bagItemInfo = bagItemInfo
    self.IsMy = IsMy
    self.isLock = isLock
    if IsNotAvailable ~= nil then
        self.notDeal.gameObject:SetActive(IsNotAvailable)
    end
    if IsNotAvailable == true or bagItemInfo == nil then
        self.icon.spriteName = ""
        self.lasting.text = ""
        self.bloodSignGo:SetActive(false)
        self.bloodLevelLabel.gameObject:SetActive(false)
        return
    end
    self.icon.spriteName = bagItemInfo.ItemTABLE.icon
    self.lasting.text = bagItemInfo.count > 1 and tostring(bagItemInfo.count) or ""
    self.lasting.gameObject:SetActive(true)
    local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(bagItemInfo.itemId)
    local bloodlevel = bagItemInfo.bloodLevel
    if bloodsuitTbl and bloodlevel > 0 then
        self.bloodSignGo:SetActive(true)
        self.bloodLevelLabel.gameObject:SetActive(true)
        self.bloodLevelLabel.text = tostring(bloodlevel)
    else
        self.bloodSignGo:SetActive(false)
        self.bloodLevelLabel.gameObject:SetActive(false)
    end
end

---播放飞入动画
function UIFaceToFaceDealTemplates_TrdaeItemInfo:PlayFlyAnim()
    if self.IsNotAvailable == true then
        return
    end
    if self.bagItemInfo == nil then
        return
    end
    luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = self.bagItemInfo.itemId, from = self.go.transform.position })

end

function UIFaceToFaceDealTemplates_TrdaeItemInfo:OnClinkItem()
    if self.IsNotAvailable == true then
        return
    end
    if self.bagItemInfo ~= nil then
        if self.IsMy and not self.isLock then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.bagItemInfo, rightUpButtonsModule = luaComponentTemplates.UIFaceToFaceDeal_TrdaeItemPartRightUpOperate, showRight = true, showAssistPanel = true, showMoreAssistData = true, showTabBtns = true })
        else
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.bagItemInfo, showAssistPanel = true, showMoreAssistData = true, showTabBtns = true })

        end

    end

    -- if self.mBagItemInfo ~= nil then
    --     uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.mBagItemInfo,showAssistPanel = true,showMoreAssistData = true,showTabBtns= true })
    -- elseif self.itemInfo ~= nil then
    --     uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mItemInfo,showAssistPanel = true,showMoreAssistData = true,showTabBtns= true })
    -- end
end
return UIFaceToFaceDealTemplates_TrdaeItemInfo