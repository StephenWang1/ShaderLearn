---拍卖物品控制器
---@class UIAuctionItemController:TemplateBase
local UIAuctionItemController = {}

---获取归属的界面
---@return UIAuctionItemPanel
function UIAuctionItemController:GetOwnerPanel()
    return self._ownerPanel;
end

---获取初始数据
---@return AuctionItemData
function UIAuctionItemController:GetData()
    return self._data
end

---是AuctionItemController,以区别于之前的AuctionItemTemplateBase
---@private
function UIAuctionItemController:IsAuctionItemController()
    return true
end

---@param ownerPanel UIAuctionItemPanel
---@param data AuctionItemData
function UIAuctionItemController:Init(ownerPanel, data)
    self._ownerPanel = ownerPanel
    self._data = data
    ---@private
    ---@type UnityEngine.Transform
    self._mRootTrans = self:GetOwnerPanel():GetCurComp("WidgetRoot/view", "Transform")
    ---隐藏root下各个子物体
    if CS.StaticUtility.IsNull(self._mRootTrans) == false then
        for i = 0, self._mRootTrans.childCount - 1 do
            local transTemp = self._mRootTrans:GetChild(i)
            if CS.StaticUtility.IsNull(transTemp) == false then
                transTemp.gameObject:SetActive(false)
            end
        end
    end
    self:RegisterPartMappingRelationShip()
    ---排版位置Y值
    ---@private
    self._mComposePosY = 0
    ---@private
    ---@type table<number,{type:LuaEnumAuctionItemPartType,template:UIAuctionItemPartsBase,posY:number}>
    self._mComposeList = {}
    ---执行初始化
    self:InitializeCompose()
    ---执行排版
    self:Composing()
end

--region 注册各部位映射关系
---注册各部位映射关系
---@private
function UIAuctionItemController:RegisterPartMappingRelationShip()
    ---注册组件
    ---@private
    ---@type table<LuaEnumAuctionItemPartType,{template:UIAuctionItemPartsBase,sourceGo:UnityEngine.GameObject,height:number,centerOffsetY:number|nil}>
    self._mPartMap = {}
    self._mPartMap[LuaEnumAuctionItemPartType.BigButton] = {
        template = luaComponentTemplates.AuctionItemPart_BigButton,
        sourceGo = self:GetOwnerPanel():GetCurComp("WidgetRoot/view/dispose", "GameObject"),
        height = 57,
        centerOffsetY = 0,
    }
    self._mPartMap[LuaEnumAuctionItemPartType.Slider] = {
        template = luaComponentTemplates.AuctionItemPart_Slider,
        sourceGo = self:GetOwnerPanel():GetCurComp("WidgetRoot/view/Slider", "GameObject"),
        height = 21,
        centerOffsetY = 0,
    }
    self._mPartMap[LuaEnumAuctionItemPartType.NumberAddMinus] = {
        template = luaComponentTemplates.AuctionItemPart_NumberAddMinus,
        sourceGo = self:GetOwnerPanel():GetCurComp("WidgetRoot/view/Num", "GameObject"),
        height = 34,
        centerOffsetY = 0,
    }
    self._mPartMap[LuaEnumAuctionItemPartType.CoinInput] = {
        template = luaComponentTemplates.AuctionItemPart_CoinInput,
        sourceGo = self:GetOwnerPanel():GetCurComp("WidgetRoot/view/Coin/itemgold", "GameObject"),
        height = 32,
        centerOffsetY = 0,
    }
    self._mPartMap[LuaEnumAuctionItemPartType.DoubleButtons] = {
        template = luaComponentTemplates.AuctionItemPart_DoubleButtons,
        sourceGo = self:GetOwnerPanel():GetCurComp("WidgetRoot/view/btns", "GameObject"),
        height = 48,
        centerOffsetY = 0,
    }
    self._mPartMap[LuaEnumAuctionItemPartType.DoubleTitleBtns] = {
        template = luaComponentTemplates.AuctionItemPart_DoubleTitleBtns,
        sourceGo = self:GetOwnerPanel():GetCurComp("WidgetRoot/view/TitleBtns", "GameObject"),
        height = 46,
        centerOffsetY = -3,
    }
    self._mPartMap[LuaEnumAuctionItemPartType.Toggle] = {
        template = luaComponentTemplates.AuctionItemPart_Toggle,
        sourceGo = self:GetOwnerPanel():GetCurComp("WidgetRoot/view/Public", "GameObject"),
        height = 28,
        centerOffsetY = 0,
    }
end
--endregion

--region 排版
---排版
---@private
function UIAuctionItemController:Composing()
    for i = 1, #self._mComposeList do
        local temp = self._mComposeList[i]
        if temp.template then
            local posY = self._mComposePosY - 1 * temp.posY
            temp.template.go.transform.localPosition = { x = 0, y = posY, z = 0 }
        end
    end
    ---@type UISprite
    self.windowBackground = self:GetOwnerPanel():GetCurComp("WidgetRoot/window/background", "UISprite")
    if self.mIsFirstTime == nil then
        self.mIsFirstTime = false
    else
        local oldHeight = self.windowBackground.height
        local currentHeight = self._mComposePosY
        local offset = oldHeight - currentHeight
        local pos = self:GetOwnerPanel().go.transform.localPosition
        pos.y = pos.y + offset
        self:GetOwnerPanel().go.transform.localPosition = pos
    end
    self.windowBackground.height = self._mComposePosY
    local localPos = self.windowBackground.transform.localPosition
    localPos.y = math.floor(self._mComposePosY)
    self.windowBackground.transform.localPosition = localPos
    ---@type UnityEngine.BoxCollider
    self.windowBackgroundBoxCollider = self:GetCurComp(self.windowBackground.gameObject, "", "BoxCollider")
    local size = self.windowBackgroundBoxCollider.size
    size.y = self._mComposePosY
    self.windowBackgroundBoxCollider.size = size
    local center = self.windowBackgroundBoxCollider.center
    center.y = -0.5 * self._mComposePosY
    self.windowBackgroundBoxCollider.center = center

end

---设置位置
---@private
---@param itemPanelHeight number
---@param itemPanelWidth number
function UIAuctionItemController:SetPosition(itemPanelHeight, itemPanelWidth)
    local pos = self:GetOwnerPanel().go.transform.localPosition
    pos.x = self.windowBackground.width * 0.5 + itemPanelWidth
    pos.y = itemPanelHeight - self._mComposePosY + 3
    self:GetOwnerPanel().go.transform.localPosition = pos
end
--endregion

---获取部位
---@private
---@param partType LuaEnumAuctionItemPartType
---@return UIAuctionItemPartsBase
function UIAuctionItemController:CopyNewPart(partType)
    local mappingTbl = self._mPartMap[partType]
    if mappingTbl == nil then
        return
    end
    local templateTemp = self:GetPartTemplate(partType)
    if templateTemp == nil then
        return
    end
    local go = templateTemp.go
    go:SetActive(true)
    self._mComposePosY = self._mComposePosY + mappingTbl.height
    local centerOffsetY = mappingTbl.centerOffsetY or 0
    table.insert(self._mComposeList, {
        type = partType,
        posY = math.floor(self._mComposePosY - mappingTbl.height * 0.5 + centerOffsetY),
        template = templateTemp })
    return templateTemp
end

---@return UIAuctionItemPartsBase 获取对应类型模板
function UIAuctionItemController:GetPartTemplate(partType)
    local partTypeList = self:GetPartTypePool(partType)
    if #partTypeList > 0 then
        local partTypeTemplate = partTypeList[1]
        table.remove(partTypeList, 1)
        return partTypeTemplate
    else
        local mappingTbl = self._mPartMap[partType]
        if mappingTbl == nil then
            return
        end
        local go = CS.Utility_Lua.CopyGO(mappingTbl.sourceGo, self._mRootTrans)
        local templateTemp = templatemanager.GetNewTemplate(go, mappingTbl.template)
        return templateTemp
    end
end

---@param partType LuaEnumAuctionItemPartType
---@alias templateTemp UIAuctionItemPartsBase
---@return table<number,templateTemp>
function UIAuctionItemController:GetPartTypePool(partType)
    if self.mPartTypeToPool == nil then
        self.mPartTypeToPool = {}
    end
    local partTypeList = self.mPartTypeToPool[partType]
    if partTypeList == nil then
        partTypeList = {}
        self.mPartTypeToPool[partType] = partTypeList
    end
    return partTypeList
end

---重置并放回对象池
function UIAuctionItemController:ResetAll()
    for i = 1, #self._mComposeList do
        local data = self._mComposeList[i]
        local type = data.type
        local template = data.template
        if template then
            template:ResetAll()
            template.go:SetActive(false)
            local pool = self:GetPartTypePool(type)
            table.insert(pool, template)
        end
    end
    self._mComposePosY = 0
    self._mComposeList = {}
end

---重置并刷新
function UIAuctionItemController:ResetToRefresh()
    self:ResetAll()
    self:RefreshAllPart()
    self:Composing()
end

--region 对子类接口
---初始化排版,只执行一次,在此处拷贝、刷新组件数据
---@public
function UIAuctionItemController:InitializeCompose()

end

---这里仅仅包含需要刷新的部分逻辑
function UIAuctionItemController:RefreshAllPart()

end

---背包货币刷新事件
---@protected
function UIAuctionItemController:OnBagCoinRefreshed()

end
--endregion

--region 组件添加接口
---增加一个大按钮
---@return UIAuctionItemPart_BigButton
function UIAuctionItemController:AddBigButton()
    return self:CopyNewPart(LuaEnumAuctionItemPartType.BigButton)
end

---增加一个滑动条
---@return UIAuctionItemPart_Slider
function UIAuctionItemController:AddSlider()
    return self:CopyNewPart(LuaEnumAuctionItemPartType.Slider)
end

---增加一个数字增减
---@return UIAuctionItemPart_NumberAddMinus
function UIAuctionItemController:AddNumberAndMinus()
    return self:CopyNewPart(LuaEnumAuctionItemPartType.NumberAddMinus)
end

---增加一个货币输入框
---@return UIAuctionItemPart_CoinInput
function UIAuctionItemController:AddCoinInput()
    return self:CopyNewPart(LuaEnumAuctionItemPartType.CoinInput)
end

---增加一个双按钮
---@return UIAuctionItemPart_DoubleButtons
function UIAuctionItemController:AddDoubleButtons()
    return self:CopyNewPart(LuaEnumAuctionItemPartType.DoubleButtons)
end

---增加一个双标题按钮
---@return UIAuctionItemPart_DoubleTitleBtns
function UIAuctionItemController:AddDoubleTitleBtns()
    return self:CopyNewPart(LuaEnumAuctionItemPartType.DoubleTitleBtns)
end

---增加一个选项框
---@return UIAuctionItemPart_Toggle
function UIAuctionItemController:AddToggle()
    return self:CopyNewPart(LuaEnumAuctionItemPartType.Toggle)
end

---加个空格
---@param spaceHeight number 空格高度
function UIAuctionItemController:AddSpace(spaceHeight)
    if spaceHeight == nil or spaceHeight <= 0 then
        return
    end
    self._mComposePosY = self._mComposePosY + spaceHeight
    table.insert(self._mComposeList, {
        type = LuaEnumAuctionItemPartType.Space,
    })
end
--endregion

return UIAuctionItemController