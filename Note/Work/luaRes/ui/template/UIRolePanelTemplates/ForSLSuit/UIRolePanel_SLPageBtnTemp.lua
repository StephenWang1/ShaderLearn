---@class UIRolePanel_SLPageBtnTemp 角色界面神力页签按钮的模板
local UIRolePanel_SLPageBtnTemp ={}

---@type UIRolePanel
UIRolePanel_SLPageBtnTemp.RolePanel = nil

---@type LuaPlayerEquipmentListData
UIRolePanel_SLPageBtnTemp.PlayerEquipmentListData = nil

UIRolePanel_SLPageBtnTemp.IconName = nil

function UIRolePanel_SLPageBtnTemp:Init()
    self:InitComponent();
end

function UIRolePanel_SLPageBtnTemp:InitComponent()
    self.IconSprite = self:Get("Icon", "Top_UISprite")
end

---@param data LuaPlayerEquipmentListData
function UIRolePanel_SLPageBtnTemp:InitData(rolePanel, data)
    self.RolePanel = rolePanel;
    self.PlayerEquipmentListData = data
    self.IconName = "GodPower_big_"..tostring(data.EquipmentListType)
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClickPageBtn
end

function UIRolePanel_SLPageBtnTemp:OnClickPageBtn(go)
    self.RolePanel:SwitchSuitPage(self.PlayerEquipmentListData.EquipmentListType)
    luaEventManager.DoCallback(LuaCEvent.Bag_BagPanelChangeSLPage, self.PlayerEquipmentListData.EquipmentListType);
end

function UIRolePanel_SLPageBtnTemp:BeSelect(select)
    if(self.IconSprite ~= nil) then
        self.IconSprite.spriteName = self.IconName..(select == true and "_2" or "_1")
    end
end

return UIRolePanel_SLPageBtnTemp