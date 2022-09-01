---锻造类型
local UIForgeTypeTemplate = {}
--region 局部变量定义
---当前接收到的物品信息
UIForgeTypeTemplate.mBagItemInfo = nil
---左的界面名字
UIForgeTypeTemplate.LeftPanelName = nil
---左的界面
UIForgeTypeTemplate.LeftPanel = nil
---父类
UIForgeTypeTemplate.UIForgePanel = nil

--endregion
function UIForgeTypeTemplate:Init()

end

function UIForgeTypeTemplate.Show(UIForgePanel)
    UIForgeTypeTemplate.UIForgePanel = UIForgePanel
end
---打开界面UIElementPanel
---@param strengthenType LuaEnumStrengthenType
function UIForgeTypeTemplate.LeftSwitchToPanel(strengthenType)
    local panelName
    local transform
    local callBack
    if strengthenType == nil then
        UIForgeTypeTemplate.mCurrentType = LuaEnumStrengthenType.Role
    else
        UIForgeTypeTemplate.mCurrentType = strengthenType
    end
    if UIForgeTypeTemplate.mCurrentType == LuaEnumStrengthenType.Bag then
        panelName = "UIBagPanel"
        transform = CS.UnityEngine.Vector3(-200, 8, 0)
        callBack = UIForgeTypeTemplate.InitBagPanel
    elseif UIForgeTypeTemplate.mCurrentType == LuaEnumStrengthenType.YuanLing then
        panelName = "UIServantPanel"
        transform = CS.UnityEngine.Vector3(-403, 7, 0)
    elseif UIForgeTypeTemplate.mCurrentType == LuaEnumStrengthenType.Role then
        panelName = "UIRolePanel"
        transform = CS.UnityEngine.Vector3(148, 28, 0)
        callBack = UIForgeTypeTemplate.InitRolePanel
    end
    UIForgeTypeTemplate.LeftOpenPanel(panelName, transform, callBack)
end

---打开界面
function UIForgeTypeTemplate.LeftOpenPanel(panelName, transform, initPanel)
    UIForgeTypeTemplate.UIForgePanel:ClosePanel(UIForgeTypeTemplate.LeftPanelName)
    if panelName ~= nil then
        UIForgeTypeTemplate.UIForgePanel:CreatePanel(panelName, function(panel)
            panel.go.transform.localPosition = transform
            panel.go.transform.parent = UIForgeTypeTemplate.UIForgePanel.GetLeft_GameObject().transform
            UIForgeTypeTemplate.LeftPanelName = panelName
            UIForgeTypeTemplate.LeftPanel = panel
            if initPanel ~= nil then
                initPanel(panel)
            end
        end)
    end
end

--region 背包初始化
---打开背包界面后
function UIForgeTypeTemplate.InitBagPanel(panel)
    --if panel ~= nil then
    --    panel:RemoveCollider()
    --    panel.SetSingleClickEvent(false, UIForgeTypeTemplate.OnItemClicked)
    --    panel.SetDoubleClickEvent(false)
    --    panel.SetHoldEvent(false)
    --    panel.SetFilterBagItem(false, UIForgeTypeTemplate.FilterItemsInBag)
    --    panel.GetBaseCloseBtn_GameObject():SetActive(false)
    --    panel.GetRecycleBtnArrow_UISprite().gameObject:SetActive(false)
    --end
end

---点击背包物品
function UIForgeTypeTemplate.OnItemClicked(itemTemp)
    if itemTemp ~= nil then
        UIForgeTypeTemplate.mBagItemInfo = itemTemp.BagItemInfo
        UIForgeTypeTemplate.UIForgePanel.RightPanelClass.RightPanel.RefreshPanel(UIForgeTypeTemplate.mCurrentType,UIForgeTypeTemplate.mBagItemInfo)
    end
end

---背包筛选方法
---@param bagItem bagV2.BagItemInfo 背包内物品
function UIForgeTypeTemplate.FilterItemsInBag(bagItem)
    return UIForgeTypeTemplate.UIForgePanel.FilterItemsInBagFunc(bagItem)
end
--endregion

--region 角色界面初始化
---打开角色界面后
function UIForgeTypeTemplate.InitRolePanel(panel)
    if panel ~= nil then
        panel.go.transform:Find("window/Sprite").gameObject:SetActive(false)
        panel.go.transform:Find("window/events2").gameObject:SetActive(false)
        panel.go.transform:Find("window/window/arrow").gameObject:SetActive(false)
        panel:Show(nil,nil,UIForgeTypeTemplate.RefreshRoleItemClicked)
    end
end
---装备点击事件
function UIForgeTypeTemplate.RefreshRoleItemClicked(go)
    if go ~= nil and go.bagItemInfo ~= nil then
        UIForgeTypeTemplate.mBagItemInfo = go.bagItemInfo
        UIForgeTypeTemplate.UIForgePanel.RightPanelClass.RightPanel.RefreshPanel(UIForgeTypeTemplate.mCurrentType,UIForgeTypeTemplate.mBagItemInfo,go)
    end
end

---刷新点击事件
function UIForgeTypeTemplate.RefreshClicked()
    if UIForgeTypeTemplate.mCurrentType == nil then
        return
    end
    if UIForgeTypeTemplate.mCurrentType == LuaEnumStrengthenType.Role then
        UIForgeTypeTemplate.LeftPanel:Show(nil,nil,UIForgeTypeTemplate.RefreshRoleItemClicked)
    elseif UIForgeTypeTemplate.mCurrentType == LuaEnumStrengthenType.Bag then
        UIForgeTypeTemplate.LeftPanel.SetSingleClickEvent(false, UIForgeTypeTemplate.OnItemClicked)
    end
end
--endregion

function UIForgeTypeTemplate.OnDestroy()
    UIForgeTypeTemplate.mCurrentType = nil
    UIForgeTypeTemplate.UIForgePanel = nil
    UIForgeTypeTemplate.LeftPanel = nil
    UIForgeTypeTemplate.LeftPanelName = nil
    UIForgeTypeTemplate.mBagItemInfo = nil
end

return UIForgeTypeTemplate