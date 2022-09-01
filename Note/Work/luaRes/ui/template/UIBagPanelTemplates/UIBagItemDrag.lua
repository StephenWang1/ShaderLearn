local UIBagItemDrag = {}
--region 组件
---被拖拽物体
function UIBagItemDrag:GetDragItem_GameObject()
    if self.mDragItem_GameObject == nil then
        self.mDragItem_GameObject = self:Get("dragItem", "GameObject")
    end
    return self.mDragItem_GameObject
end
---icon
function UIBagItemDrag:GetDragItemIcon_UISprite()
    if self.mDragItemIcon_UISprite == nil then
        self.mDragItemIcon_UISprite = self:Get("dragItem/icon", "UISprite")
    end
    return self.mDragItemIcon_UISprite
end
---UIPanel
function UIBagItemDrag:GetDragItem_UIPanel()
    if self.mDragItem_UIPanel == nil then
        self.mDragItem_UIPanel = self:Get("dragItem", "UIPanel")
    end
    return self.mDragItem_UIPanel
end

function UIBagItemDrag:Root()
    if self.mRoot == nil then
        self.mRoot = CS.Utility_Lua.GetComponent(CS.UnityEngine.GameObject.Find("UI Root"), 'UIRoot')
    end
    return self.mRoot
end
--endregion

function UIBagItemDrag:Init()
    self.effectIsLoad = false
end
---按下
function UIBagItemDrag:OnPress(go, state, bagItemInfo, itemInfo, inputEquipIndex)
    self.uiRolePanel = uimanager:GetPanel("UIRolePanel")
    self.uiBagPanel = uimanager:GetPanel("UIBagPanel")
    self.bagItemInfo = bagItemInfo
    self.itemInfo = itemInfo

    if self.uiRolePanel and self.uiBagPanel then
        ---设置拖拽物体的位置
        local cameras = CS.UnityEngine.Camera.allCameras
        for i = 0, cameras.Length - 1 do
            if cameras[i].gameObject.layer == 5 then
                self.uiCamera = cameras[i]
            end
        end
        local mouseWorldPosition = self.uiCamera:ScreenToWorldPoint(CS.UnityEngine.Input.mousePosition)
        self:GetDragItem_GameObject().transform.position = CS.UnityEngine.Vector3(mouseWorldPosition.x, mouseWorldPosition.y, 0)

        if go then
            self.buttonScale = CS.Utility_Lua.GetComponent(go.transform, "TweenScale")
            self.state = state
            if state then
                if self.buttonScale then
                    self.buttonScale:PlayForward()
                end
                ---加载特效
                if self.itemInfo ~= nil then
                    if self.itemInfo.type == luaEnumItemType.Equip then
                        if self.uiRolePanel ~= nil and self.uiRolePanel.mEquipTemplate ~= nil and self.uiRolePanel.mEquipTemplate.mEquipIndexToTemplate ~= nil then
                            local equipIndex
                            if inputEquipIndex ~= nil then
                                equipIndex = inputEquipIndex
                            else
                                equipIndex = CS.CSScene.MainPlayerInfo.EquipInfo:GetLowEquipIndexByEquipSubtype(self.itemInfo.subType)
                            end
                            local mequipTable = nil
                            if equipIndex ~= 0 then
                                mequipTable = self.uiRolePanel.mEquipTemplate.mEquipIndexToTemplate[equipIndex]
                            else
                                mequipTable = self.uiRolePanel.mEquipTemplate.mEquipIndexToTemplate[self.itemInfo.subType]
                            end
                            if mequipTable == nil then
                                return
                            end
                            --禅道单83456（拖拽的目标栏位的绿色选中框不需要）
                            --self:ShowGreenDragEffect(mequipTable)
                        end
                    end
                end
            else
                if self.buttonScale then
                    self.buttonScale:PlayReverse()
                end
                if self.effectPoint then
                    self.effectPoint:SetActive(false)
                end
            end
        end
    end
end

---开始拖拽
function UIBagItemDrag:OnStartDrag(bagItemInfo, itemInfo, nowDepth, equipIndex, go, luaEnumEndDragType)
    self.equipIndex = equipIndex
    self.item_Go = go
    self.dragType = luaEnumEndDragType
    self.beginDrag = true
    if self.uiRolePanel and self.uiBagPanel then
        ---消除拖拽物体的内容
        if luaEnumEndDragType == LuaEnumEndDragType.RolePanel then
            self.item_Go.transform:Find("icon").gameObject:SetActive(false)
        elseif luaEnumEndDragType == LuaEnumEndDragType.BagPanel then
            self.isgood = self.item_Go.transform:Find("good").gameObject.activeSelf
            self.isredPoint = self.item_Go.transform:Find("redpoint").gameObject.activeSelf
            self.item_Go.transform:Find("good").gameObject:SetActive(false)
            self.item_Go.transform:Find("icon").gameObject:SetActive(false)
            self.item_Go.transform:Find("count").gameObject:SetActive(false)
            self.item_Go.transform:Find("redpoint").gameObject:SetActive(false)
        end
        self:GetDragItem_GameObject():SetActive(true)
        self:GetDragItemIcon_UISprite().spriteName = itemInfo.icon
        self:GetDragItem_GameObject().transform.localPosition = CS.UnityEngine.Vector3(self:GetDragItem_GameObject().transform.localPosition.x, self:GetDragItem_GameObject().transform.localPosition.y, 0)
        if nowDepth ~= nil then
            self:GetDragItem_UIPanel().depth = 1000
        end
    end
end

---持续拖拽
function UIBagItemDrag:OnDrag(go, delta)
    if self.beginDrag then
        if self:GetDragItem_GameObject() ~= nil then
            if self.uiRolePanel and self.uiBagPanel then
                local mouseWorldPosition = self.uiCamera:ScreenToWorldPoint(CS.UnityEngine.Input.mousePosition)
                self:GetDragItem_GameObject().transform.position = CS.UnityEngine.Vector3(mouseWorldPosition.x, mouseWorldPosition.y, 0)
            end
        end
    end
end

--- 结束拖拽
function UIBagItemDrag:OnEndDrag(nowDepth)
    if self.uiRolePanel and self.uiBagPanel then
        self.beginDrag = false
        self:GetDragItem_GameObject():SetActive(false)
        if nowDepth ~= nil then
            self:GetDragItem_UIPanel().depth = nowDepth - 1
        end
        if self.effectPoint ~= nil then
            self.effectPoint:SetActive(false)
        end
        if self.buttonScale ~= nil then
            self.buttonScale:PlayReverse()
        end
        ---开启拖拽物体的内容
        if self.dragType == LuaEnumEndDragType.RolePanel then
            self.item_Go.transform:Find("icon").gameObject:SetActive(true)
        elseif self.dragType == LuaEnumEndDragType.BagPanel then
            self.item_Go.transform:Find("good").gameObject:SetActive(self.isgood)
            self.item_Go.transform:Find("icon").gameObject:SetActive(true)
            self.item_Go.transform:Find("count").gameObject:SetActive(true)
            self.item_Go.transform:Find("redpoint").gameObject:SetActive(self.isredPoint)
        end
        self:GetDragItemIcon_UISprite().spriteName = " "
        ---结束拖拽判定
        if self.dragType == LuaEnumEndDragType.BagPanel then
            if self.uiRolePanel ~= nil then
                if self.itemInfo ~= nil and self.itemInfo.type == luaEnumItemType.Equip then
                    ---装备物品（拖拽到格子）
                    --for k, v in pairs(self.uiRolePanel.mEquipTemplate.mEquipIndexToTemplate) do
                    --    if v ~= nil then
                    --        if self.itemInfo.subType == v.subType then
                    --            local targetPosition = CS.UnityEngine.Vector3(v.go.transform.position.x, v.go.transform.position.y, 0)
                    --            local dragItemPosition = CS.UnityEngine.Vector3(self:GetDragItem_GameObject().transform.position.x, self:GetDragItem_GameObject().transform.position.y, 0)
                    --            local diatance = CS.UnityEngine.Vector3.Distance(targetPosition, dragItemPosition)
                    --            if diatance <= 0.1 then
                    --                networkRequest.ReqPutOnTheEquip(k, self.bagItemInfo.lid)
                    --                --CS.CSScene.MainPlayerInfo.BagInfo:ReqEquipItem(self.bagItemInfo)
                    --                return
                    --            end
                    --        end
                    --    end
                    --end

                    ---装备物品（拖拽到角色面板）
                    local rolePanelPosition = self.uiRolePanel.go.transform.position
                    local distance_x = self:GetDragItem_GameObject().transform.position.x - rolePanelPosition.x
                    local distance_y = math.abs(self:GetDragItem_GameObject().transform.position.y - rolePanelPosition.y)
                    if distance_x >= -1.5 and distance_x <= -0.25 and distance_y >= 0 and distance_y <= 0.84 then
                        CS.CSScene.MainPlayerInfo.BagInfo:ReqEquipItem(self.bagItemInfo)
                        gameMgr:GetPlayerDataMgr():GetLuaStrengthInfo():CheckRoleNeedPushTransferItem(self.bagItemInfo)
                    end
                end
            end
        elseif self.dragType == LuaEnumEndDragType.RolePanel then
            if self.uiBagPanel ~= nil then
                if self.bagItemInfo ~= nil and self.itemInfo ~= nil then
                    local bagpanelposition = self.uiBagPanel.go.transform.position
                    local distance_x = math.abs(self:GetDragItem_GameObject().transform.position.x - bagpanelposition.x)
                    local distance_y = math.abs(self:GetDragItem_GameObject().transform.position.y - bagpanelposition.y)
                    if distance_x >= 0 and distance_x <= 0.58 and distance_y >= 0 and distance_y <= 0.84 then
                        networkRequest.ReqPutOffTheEquip(self.equipIndex)
                    end
                end
            end
        end
    end
end

return UIBagItemDrag