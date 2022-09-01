local UIOptionalBoxPanelGrid_Base = {}
--region 组件
---背景图
function UIOptionalBoxPanelGrid_Base:GetBg_GameObject()
    if self.Bg_GameObject == nil then
        self.Bg_GameObject = self:Get("bg","GameObject")
    end
    return self.Bg_GameObject
end

---选择状态图片
function UIOptionalBoxPanelGrid_Base:GetSelect_GameObject()
    if self.Select_GameObject == nil then
        self.Select_GameObject = self:Get("isSelected","GameObject")
    end
    return self.Select_GameObject
end

---物品名字文本
function UIOptionalBoxPanelGrid_Base:GetItemName_UILabel()
    if self.ItemName_UILabel == nil then
        self.ItemName_UILabel = self:Get("Label","UILabel")
    end
    return self.ItemName_UILabel
end

---物品icon
function UIOptionalBoxPanelGrid_Base:GetItem_UISprite()
    if self.Item_UISprite == nil then
        self.Item_UISprite = self:Get("frame/icon","UISprite")
    end
    return self.Item_UISprite
end

---物品数量
function UIOptionalBoxPanelGrid_Base:GetItemNum_UILabel()
    if self.ItemNum_UILabel == nil then
        self.ItemNum_UILabel = self:Get("frame/num","UILabel")
    end
    return self.ItemNum_UILabel
end

---物品星级
function UIOptionalBoxPanelGrid_Base:GetItemStar_UILabel()
    if self.ItemStar_UILabel == nil then
        self.ItemStar_UILabel = self:Get("frame/star","UILabel")
    end
    return self.ItemStar_UILabel
end

---物品信息
function UIOptionalBoxPanelGrid_Base:GetFrame_GameObject()
    if self.Frame_GameObject == nil then
        self.Frame_GameObject = self:Get("frame","GameObject")
    end
    return self.Frame_GameObject
end
--endregion

--region 初始化
function UIOptionalBoxPanelGrid_Base:Init()
    self:BindEvents()
end

function UIOptionalBoxPanelGrid_Base:BindEvents()
    self:BindClickCallBack(self:GetItem_UISprite(),function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.itemInfo, showRight = false, refreshEndFunc = function(panel)
            self:SetItemInfoPos(panel)
        end, })
    end)
    self:BindClickCallBack(self.go,function()
        self:ItemChooseClick()
    end)
end
--endregion

--region 事件
function UIOptionalBoxPanelGrid_Base:ItemChooseClick()

end

---矫正物品信息面板位置
function UIOptionalBoxPanelGrid_Base:SetItemInfoPos(panel)
    if self.UIOptionalBoxPanel ~= nil then
        self.UIOptionalBoxPanel:AdjustAdaption({ panel = panel, adaptionType = LuaEnumAdjustAdaptionType.RightDown, verticalInterval = -4 })
    end
end
--endregion

--region 刷新
function UIOptionalBoxPanelGrid_Base:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        return false
    end
    self:DefaultRefresh()
    return true
end

---解析数据
---@return boolean 是否解析成功
function UIOptionalBoxPanelGrid_Base:AnalysisParams(commonData)
    if commonData == nil or commonData.optionalBoxIteminfo == nil then
        return false
    end
    self.optionalBoxIteminfo = commonData.optionalBoxIteminfo
    self.index = ternary(commonData.index == nil,0,commonData.index)
    self.itemInfo = self.optionalBoxIteminfo.ItemInfo
    self.UIOptionalBoxPanel = commonData.UIOptionalBoxPanel
    self.isChoose = false
    if self.optionalBoxIteminfo.ItemInfo == nil or self.optionalBoxIteminfo.MainPlayerCanUse == false then
        return false
    end
    return true
end

function UIOptionalBoxPanelGrid_Base:DefaultRefresh()
    self:RefreshActive(self:GetBg_GameObject(),self.index % 2 == 0)
    self:RefreshActive(self:GetSelect_GameObject(),false)
    self:RefreshLabel(self:GetItemName_UILabel(),self.optionalBoxIteminfo.ItemInfo.name)
    self:RefreshSprite(self:GetItem_UISprite(),self.optionalBoxIteminfo.ItemInfo.icon)
    self:RefreshLabel(self:GetItemNum_UILabel(),self.optionalBoxIteminfo.Count)
    self:RefreshActive(self:GetItemNum_UILabel(),self.optionalBoxIteminfo.Count > 1)
    self:RefreshLabel(self:GetItemStar_UILabel(),"★" .. tostring(self.optionalBoxIteminfo.StarLevel))
    self:RefreshActive(self:GetItemStar_UILabel(),self.optionalBoxIteminfo.StarLevel > 0)
end

function UIOptionalBoxPanelGrid_Base:RefreshChooseState(state)
    self:RefreshActive(self:GetSelect_GameObject(),state)
    self.isChoose = state
end
--endregion

--region UI刷新
---控制显示
function UIOptionalBoxPanelGrid_Base:RefreshActive(obj,state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        obj.gameObject:SetActive(state)
    end
end

---设置Sprite
function UIOptionalBoxPanelGrid_Base:RefreshSprite(obj,spriteName)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UISprite)) then
            obj.spriteName = spriteName
        else
            local curSprite = self:GetCurComp(obj,"","UISprite")
            if curSprite ~= nil then
                curSprite.spriteName = spriteName
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj,true)
        end
    end
end

---设置Label
function UIOptionalBoxPanelGrid_Base:RefreshLabel(obj,text)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UILabel)) then
            obj.text = text
        else
            local curLabel = self:GetCurComp(obj,"","UILabel")
            if curLabel ~= nil then
                curLabel.text = text
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj,true)
        end
    end
end

---设置特效
function UIOptionalBoxPanelGrid_Base:RefreshCSUIEffectLoad(obj,effectName)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.CSUIEffectLoad)) then
            obj:ChangeEffect(effectName)
        else
            local curCSUIEffectLoad = self:GetCurComp(obj,"","CSUIEffectLoad")
            if curCSUIEffectLoad ~= nil then
                curCSUIEffectLoad:ChangeEffect(effectName)
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj,true)
        end
    end
end

---通过路径设置对应特效
function UIOptionalBoxPanelGrid_Base:RefreshCSUIEffectLoadByPath(path,effectName)
    if CS.StaticUtility.IsNullOrEmpty(path) == false and CS.StaticUtility.IsNullOrEmpty(effectName) == false then
        local curEffectLoad = self:Get(path,"CSUIEffectLoad")
        if CS.StaticUtility.IsNull(curEffectLoad) == true then
            curEffectLoad = self:Get(path,"GameObject")
            if curEffectLoad ~= nil then
                curEffectLoad:AddComponent("CSUIEffectLoad")
            end
        end
        self:RefreshCSUIEffectLoad(curEffectLoad,effectName)
    end
end

---绑定点击事件
function UIOptionalBoxPanelGrid_Base:BindClickCallBack(obj,action)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        CS.UIEventListener.Get(obj.gameObject).onClick = action
    end
end
--endregion
return UIOptionalBoxPanelGrid_Base