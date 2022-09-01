---类背包容器被拖拽的物品
---用于控制格子
---使用了子物体中"icon"游戏物体上的UISprite组件
---@class UIBagTypeDraggableItem:TemplateBase
local UIBagTypeDraggableItem = {}

---获取icon图片
---@public
---@return UISprite
function UIBagTypeDraggableItem:GetIconSprite()
    if self.mIconSprite == nil then
        self.mIconSprite = self:Get("icon", "UISprite")
    end
    return self.mIconSprite
end

---获取依赖界面,拖拽时层级设置在依赖界面所在层的最高层
---@public
---@return UIBase
function UIBagTypeDraggableItem:GetRelyPanel()
    return self.mRelyPanel
end

---初始化
---@private
---@param relyPanel UIBase 依赖界面,开始拖拽时将自身层级设置为依赖界面所在层级的最高层
function UIBagTypeDraggableItem:Init(relyPanel)
    self.mRelyPanel = relyPanel
    if self:GetIconSprite() ~= nil then
        self.mIconAtlas = self:GetIconSprite().atlas
    end
end

---设置激活/未激活状态
---@public
---@param isActive boolean
function UIBagTypeDraggableItem:SetActive(isActive)
    if CS.StaticUtility.IsNull(self.go) == false then
        if isActive then
            if self:GetRelyPanel() ~= nil then
                ---设置自身层级为当前层级的最高层级,但该操作将改变自身的父物体,所以事先缓存父物体,设置完层级再设置回来
                local parent = self.go.transform.parent
                CS.UILayerMgr.Instance:SetLayer(self.go, self:GetRelyPanel().PanelLayerType)
                self.go.transform:SetParent(parent)
            end
            if CS.StaticUtility.IsNull(self:GetIconSprite()) == false then
                self:GetIconSprite().gameObject:SetActive(true)
            end
        end
        self.go:SetActive(isActive)
    end
end

---重置图集
---@public
function UIBagTypeDraggableItem:ResetAtlas()
    if self.mIconAtlas ~= nil and CS.StaticUtility.IsNull(self.mIconAtlas) == false and CS.StaticUtility.IsNull(self:GetIconSprite()) == false then
        self:GetIconSprite().atlas = self.mIconAtlas
        self:GetIconSprite().enabled = false
        self:GetIconSprite().enabled = true
    end
end

---绑定额外的刷新方法
---@param extraRefreshFunction fun(self:UIBagTypeDraggableItem,item:TABLE.CFG_ITEMS|bagV2.BagItemInfo):boolean 返回是否中断执行之前的拖拽物品刷新逻辑
function UIBagTypeDraggableItem:BindExtraRefreshFunction(extraRefreshFunction)
    self.mExtraRefreshFunction = extraRefreshFunction
end

function UIBagTypeDraggableItem:ClearExtraRefreshFunction()
    self.mExtraRefreshFunction = nil
end

---使用背包物品数据/物品表数据刷新
---@public
---@overload fun(itemTbl:TABLE.CFG_ITEMS)
---@param bagItemInfo bagV2.BagItemInfo
function UIBagTypeDraggableItem:Refresh(bagItemInfo)
    if self.mExtraRefreshFunction ~= nil then
        if self.mExtraRefreshFunction(self, bagItemInfo) then
            return
        end
    end
    if CS.StaticUtility.IsNull(self:GetIconSprite()) == false then
        self:GetIconSprite().color = CS.UnityEngine.Color.white
        if bagItemInfo then
            local itemTbl = bagItemInfo.ItemTABLE
            if itemTbl then
                self:GetIconSprite().enabled = true
                self:GetIconSprite().spriteName = itemTbl.icon
            else
                itemTbl = bagItemInfo
                self:GetIconSprite().enabled = true
                self:GetIconSprite().spriteName = itemTbl.icon
            end
        else
            self:GetIconSprite().enabled = false
        end
    end
end

---设置icon的颜色,在隐藏并重新显示后
---@param color UnityEngine.Color
function UIBagTypeDraggableItem:SetIconColor(color)
    if color == nil then
        return
    end
    self:GetIconSprite().color = color
end

---设置世界坐标
---@public
---@param worldPosition UnityEngine.Vector3
function UIBagTypeDraggableItem:SetUIRootWorldPosition(worldPosition)
    if CS.StaticUtility.IsNull(self.go) == false then
        self.go.transform.position = worldPosition
    end
end

return UIBagTypeDraggableItem