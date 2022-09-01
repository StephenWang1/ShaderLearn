---@class 元灵信息界面子界面
---@class UIPetInfoPanel_PartBasic
local UIPetInfoPanel_PartBasic = {}

--region 参数
---最大外框高度
UIPetInfoPanel_PartBasic.mMaxFrameHeight = 548
---最小外框高度
UIPetInfoPanel_PartBasic.mMinFrameHeight = 100
---区域之间的距离
UIPetInfoPanel_PartBasic.mDistanceBetweenParts = 0
---到顶部的距离
UIPetInfoPanel_PartBasic.mDistanceToTopBound = 10
---到底部的距离
UIPetInfoPanel_PartBasic.mDistanceToBottomBound = 20
---到左部的距离
UIPetInfoPanel_PartBasic.mDistanceToLeftBound = 0
---center模块与down模块间距（补充值，对于像素偏差的特殊处理）
UIPetInfoPanel_PartBasic.mCenterDownDistance = 0
--endregion

--region 属性
---子界面外框尺寸
function UIPetInfoPanel_PartBasic:FrameSize()
    return self.frameSize or CS.UnityEngine.Vector3.zero
end
--endregion

--region 组件
---外框图片
---@return UISprite
function UIPetInfoPanel_PartBasic:GetFrameSprite_UISprite()
    if self.mFrameSprite_UISprite == nil then
        self.mFrameSprite_UISprite = self:Get("window/background", "UISprite")
    end
    return self.mFrameSprite_UISprite
end

---外框装饰图片
---@return UISprite
function UIPetInfoPanel_PartBasic:GetOutFrame_UISprite()
    if self.mOutFrame_UISprite == nil then
        self.mOutFrame_UISprite = self:Get("window/outframe", "UISprite")
    end
    return self.mOutFrame_UISprite
end

---箭头界面
---@return UIPanel
function UIPetInfoPanel_PartBasic:GetArrowPanel_UIPanel()
    if self.mArrowPanel_UIPanel == nil then
        self.mArrowPanel_UIPanel = self:Get("arrowpanel", "UIPanel")
    end
    return self.mArrowPanel_UIPanel
end

---中央滑动区域
---@return UIPanel
function UIPetInfoPanel_PartBasic:GetCenterUIPanel_UIPanel()
    if self.mCenterUIPanel_UIPanel == nil then
        self.mCenterUIPanel_UIPanel = self:Get("content/center/Scroll View", "UIPanel")
    end
    return self.mCenterUIPanel_UIPanel
end

---内容根物体
function UIPetInfoPanel_PartBasic:GetCenterRoot_Transform()
    if self.mCenterRoot_Transform == nil then
        self.mCenterRoot_Transform = self:Get("content/center", "Transform")
    end
    return self.mCenterRoot_Transform
end

---上方部分内容
---@return UITable
function UIPetInfoPanel_PartBasic:GetUpperContentTable_UITable()
    if self.mUpperContentTable_UITable == nil then
        self.mUpperContentTable_UITable = self:Get("content/up", "UITable")
    end
    return self.mUpperContentTable_UITable
end

---中央部分内容(滑动区域)
---@return UITable
function UIPetInfoPanel_PartBasic:GetCenterContentTable_UITable()
    if self.mCenterContentTable_UITable == nil then
        self.mCenterContentTable_UITable = self:Get("content/center/Scroll View/scrollContent", "UITable")
    end
    return self.mCenterContentTable_UITable
end

---下方部分内容
---@return UITable
function UIPetInfoPanel_PartBasic:GetLowerContentTable_UITable()
    if self.mLowerContentTable_UITable == nil then
        self.mLowerContentTable_UITable = self:Get("content/down", "UITable")
    end
    return self.mLowerContentTable_UITable
end

---右上方部分内容
---@return UITable
function UIPetInfoPanel_PartBasic:GetUpRightTable_UITable()
    if self.mUpRightTable_UITable == nil then
        self.mUpRightTable_UITable = self:Get("content/rightup", "UITable")
    end
    return self.mUpRightTable_UITable
end
--endregion

--region 单条信息显示模板
---单条信息显示模板根节点
---@return UnityEngine.GameObject
function UIPetInfoPanel_PartBasic:GetInfoTemplateRoot_GO()
    if self.mTemplateRoot_GO == nil then
        self.mTemplateRoot_GO = self:Get("templates", "GameObject")
    end
    return self.mTemplateRoot_GO
end

---UIItem信息显示模板
---@return UnityEngine.GameObject
function UIPetInfoPanel_PartBasic:GetInfoTemplate_UIItem_GO()
    if self.mInfoTemplate_UIItem_GO == nil then
        self.mInfoTemplate_UIItem_GO = self:Get("templates/uiitemtemplate", "GameObject")
    end
    return self.mInfoTemplate_UIItem_GO
end


---双线信息显示模板
---@return UnityEngine.GameObject
function UIPetInfoPanel_PartBasic:GetInfoTemplate_DoubleLine_GO()
    if self.mInfoTemplate_DoubleLine_GO == nil then
        self.mInfoTemplate_DoubleLine_GO = self:Get("templates/doublelinetemplate", "GameObject")
    end
    return self.mInfoTemplate_DoubleLine_GO
end

---单线信息显示模板
---@return UnityEngine.GameObject
function UIPetInfoPanel_PartBasic:GetInfoTemplate_SingleLine_GO()
    if self.mInfoTemplate_SingleLine_GO == nil then
        self.mInfoTemplate_SingleLine_GO = self:Get("templates/singlelinetemplate", "GameObject")
    end
    return self.mInfoTemplate_SingleLine_GO
end

---按钮信息显示模板
---@return UnityEngine.GameObject
function UIPetInfoPanel_PartBasic:GetInfoTemplate_Buttons_GO()
    if self.mInfoTemplate_Buttons_GO == nil then
        self.mInfoTemplate_Buttons_GO = self:Get("templates/buttonstemplate", "GameObject")
    end
    return self.mInfoTemplate_Buttons_GO
end

---右上角按钮信息显示模板
---@return UnityEngine.GameObject
function UIPetInfoPanel_PartBasic:GetInfoTemplate_RightButtons_Go()
    if self.mInfoTemplate_RightButtons_Go == nil then
        self.mInfoTemplate_RightButtons_Go = self:Get("templates/rightbuttonstemplate", "GameObject")
    end
    return self.mInfoTemplate_RightButtons_Go
end

---基础属性信息显示模板
---@return UnityEngine.GameObject
function UIPetInfoPanel_PartBasic:GetInfoTemplate_BaseAttribute_GO()
    if self.mInfoTemplate_BaseAttribute_GO == nil then
        self.mInfoTemplate_BaseAttribute_GO = self:Get("templates/baseattributetemplate", "GameObject")
    end
    return self.mInfoTemplate_BaseAttribute_GO
end

---右下角按钮信息显示模板
---@return UnityEngine.GameObject
function UIPetInfoPanel_PartBasic:GetInfoTemplate_RightDownButtons_Go()
    if self.mInfoTemplate_RightDownButtons_Go == nil then
        self.mInfoTemplate_RightDownButtons_Go = self:Get("templates/rightdownbuttonstemplate", "GameObject")
    end
    return self.mInfoTemplate_RightDownButtons_Go
end

---标头信息显示模板
---@return UnityEngine.GameObject
function UIPetInfoPanel_PartBasic:GetInfoTemplate_Header_GO()
    if self.mInfoTemplate_Header_GO == nil then
        self.mInfoTemplate_Header_GO = self:Get("templates/uiheadertemplate", "GameObject")
    end
    return self.mInfoTemplate_Header_GO
end

---模型信息显示模板
---@return UnityEngine.GameObject
function UIPetInfoPanel_PartBasic:GetInfoTemplate_Model_GO()
    if self.mInfoTemplate_Model_GO == nil then
        self.mInfoTemplate_Model_GO = self:Get("templates/modeltemplate", "GameObject")
    end
    return self.mInfoTemplate_Model_GO
end

---灵兽基础属性显示模板
---@return UnityEngine.GameObject
function UIPetInfoPanel_PartBasic:GetInfoTemplate_ServantBaseAttribute_GO()
    if self.mInfoTemplate_ServantBaseAttribute_GO == nil then
        self.mInfoTemplate_ServantBaseAttribute_GO = self:Get("templates/servantbaseattributetemplate", "GameObject")
    end
    return self.mInfoTemplate_ServantBaseAttribute_GO
end

---右下方部分内容
---@return UITable
function UIPetInfoPanel_PartBasic:GetDownRightTable_UITable()
    if self.mDownRightTable_UITable == nil then
        self.mDownRightTable_UITable = self:Get("content/rightdown", "UITable")
    end
    return self.mDownRightTable_UITable
end

---印记信息显示模板
---@return UnityEngine.GameObject
function UIPetInfoPanel_PartBasic:GetSignettemplate_GO()
    if self.mSignettemplate_GO == nil then
        self.mSignettemplate_GO = self:Get("templates/signettemplate", "GameObject")
    end
    return self.mSignettemplate_GO
end

---额外属性信息显示模板
---@return UnityEngine.GameObject
function UIPetInfoPanel_PartBasic:GetExtraAttribute_GO()
    if self.mExtraAttribute_GO== nil then
        self.mExtraAttribute_GO = self:Get("templates/extraattributetemplate", "GameObject")
    end
    return self.mExtraAttribute_GO
end
--endregion

function UIPetInfoPanel_PartBasic:GetUIItemTemplate()
    if(self.mUIItem == nil) then
        self.mUIItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.UIItemInfoPanel_Info_UIItem, self:GetUpperContentTable_UITable())
    end
    return self.mUIItem;
end

function UIPetInfoPanel_PartBasic:GetBaseAttributeTemplate()
    if(self.mBaseAttribute == nil) then
        self.mBaseAttribute = self:CreateTemplateUnderArea(self:GetInfoTemplate_BaseAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_BaseAttribute, self:GetCenterContentTable_UITable())
    end
    return self.mBaseAttribute;
end
--region 初始化
function UIPetInfoPanel_PartBasic:Init()
    --隐藏templates
    if self:GetInfoTemplateRoot_GO() and CS.StaticUtility.IsNull(self:GetInfoTemplateRoot_GO()) == false then
        self:GetInfoTemplateRoot_GO():SetActive(false)
    end
end
--endregion

--region 显示方法
---使用背包物品信息刷新
---@param bagItemInfo bagV2.BagItemInfo
function UIPetInfoPanel_PartBasic:RefreshWithBagItemInfo(commonData)
    self:AnalysisCommonData(commonData)
    self:RefreshUpperArea(commonData.bagItemInfo, commonData.itemInfo,commonData.itemInfoSource)
    self:RefreshCenterArea(commonData.bagItemInfo, commonData.itemInfo,commonData.compareBagItemInfo,commonData.compareItemInfo,commonData.career,commonData.itemInfoSource)
    self:RefreshLowerArea(commonData.bagItemInfo, commonData.itemInfo,commonData.itemInfoSource)
    if commonData.showRight == true then
        self:RefreshRightUpArea(commonData.bagItemInfo, commonData.itemInfo,commonData.highLightBtnTable,commonData.itemInfoSource)
        self:RefreshRightDownArea(commonData.bagItemInfo, commonData.itemInfo,commonData.highLightBtnTable,commonData.itemInfoSource)
    end
    self:CheckCenterAreaHaveContent()
    self:AdjustPartSize()
end

---解析数据
function UIPetInfoPanel_PartBasic:AnalysisCommonData(commonData)
    self.rightUpButtonsModule = commonData.rightUpButtonsModule
end

---使用表物品信息刷新
function UIPetInfoPanel_PartBasic:RefreshWithItemInfo(itemInfo)
    self:RefreshUpperArea(nil, itemInfo)
    self:RefreshCenterArea(nil, itemInfo)
    self:RefreshLowerArea(nil, itemInfo)
    self:RefreshRightUpArea(nil, itemInfo)
    self:RefreshRightDownArea(nil, itemInfo)
    self:CheckCenterAreaHaveContent()
    self:AdjustPartSize()
end

---检测中央区域是否有内容
function UIPetInfoPanel_PartBasic:CheckCenterAreaHaveContent()
    if self:GetCenterContentTable_UITable() ~= nil and CS.StaticUtility.IsNull(self:GetCenterContentTable_UITable()) == false and self:GetCenterContentTable_UITable().transform.childCount > 0 then
        for i = 0,self:GetCenterContentTable_UITable().transform.childCount - 1 do
            if self:GetCenterContentTable_UITable().transform:GetChild(i).gameObject.activeSelf == true then
                self.mDistanceBetweenParts = 0
                return
            end
        end
    end
end

---在区域内实例化一个模板
---@param templateGO UnityEngine.GameObject 模板预设游戏物体
---@param templateTable table 模板对应的表
---@param area UITable 区域
---@return 物品信息界面信息 返回实例化得到的table
function UIPetInfoPanel_PartBasic:CreateTemplateUnderArea(templateGO, templateTable, area)
    if templateGO and CS.StaticUtility.IsNull(templateGO) == false and area and CS.StaticUtility.IsNull(area) == false then
        local goTemp = CS.Utility_Lua.CopyGO(templateGO, area.transform)
        if goTemp then
            goTemp:SetActive(true)
            goTemp.transform:SetAsLastSibling()
            return templatemanager.GetNewTemplate(goTemp, templateTable)
        end
    end
end

---判断当前中间是否有数据
function UIPetInfoPanel_PartBasic:IsNoCenter(centerHight)
    if centerHight <= 15 then
        return true
    end
    return false
end

---调整大小
function UIPetInfoPanel_PartBasic:AdjustPartSize()
    --region 刷新排版
    --顶部重新刷新排版
    if self:GetUpperContentTable_UITable() and CS.StaticUtility.IsNull(self:GetUpperContentTable_UITable()) == false then
        self:GetUpperContentTable_UITable():Reposition()
    end
    --中央重新刷新排版
    if self:GetCenterContentTable_UITable() and CS.StaticUtility.IsNull(self:GetCenterContentTable_UITable()) == false then
        self:GetCenterContentTable_UITable():Reposition()
    end
    --底部重新刷新排版
    if self:GetLowerContentTable_UITable() and CS.StaticUtility.IsNull(self:GetLowerContentTable_UITable()) == false then
        self:GetLowerContentTable_UITable():Reposition()
    end
    --endregion

    --region 计算
    --计算各区域高度
    local upperHeight = 0
    local lowerHeight = 0
    local centerHeight = 0
    upperHeight = CS.NGUIMath.CalculateRelativeWidgetBounds(self:GetCenterRoot_Transform(), self:GetUpperContentTable_UITable().transform, false, true).size.y
    lowerHeight = CS.NGUIMath.CalculateRelativeWidgetBounds(self:GetCenterRoot_Transform(), self:GetLowerContentTable_UITable().transform, false, true).size.y
    centerHeight = CS.NGUIMath.CalculateRelativeWidgetBounds(self:GetCenterRoot_Transform(), self:GetCenterContentTable_UITable().transform, false, true).size.y
    --为了保证Scroll View组件能够在大小合适时禁止拖动,应将Scroll View的softclip的高度和UITable组件中用于的padding的高度计算进去
    centerHeight = centerHeight + 2 * self:GetCenterUIPanel_UIPanel().clipSoftness.y + self:GetCenterContentTable_UITable().padding.y * 2
    centerHeight = math.ceil(centerHeight)
    --if self:IsNoCenter(centerHeight) then
    --    centerHeight = 0
    --end
    --计算出除中心区域的高度
    local heightExpectCenter = 0
    if self.mDistanceToTopBound and self.mDistanceBetweenParts and self.mDistanceToBottomBound then
        heightExpectCenter = self.mDistanceToTopBound + upperHeight + self.mDistanceBetweenParts  + lowerHeight + self.mDistanceToBottomBound
    end
    --整体高度 = 除中心区域的高度 + 中心区域高度
    local totalHeight = heightExpectCenter + centerHeight
    --考虑最大高度和最小高度,得到最终的整体高度
    if self.mMinFrameHeight and self.mMaxFrameHeight then
        totalHeight = math.clamp(totalHeight, self.mMinFrameHeight, self.mMaxFrameHeight)
    end
    local finalCenterHeight = math.max(totalHeight - heightExpectCenter, 0)
    --最终半高,用于后续计算坐标
    local halfTotalHeight = totalHeight * 0.5
    --原高度和计算后的高度的差值
    local changeValue = self:GetFrameSprite_UISprite().localSize.y - totalHeight
    --endregion

    --region 调整高度
    --将外框高度调整至预定高度
    if self:GetFrameSprite_UISprite() and CS.StaticUtility.IsNull(self:GetFrameSprite_UISprite()) == false then
        self.frameSize = self:GetFrameSprite_UISprite().localSize
        self.frameSize.y = math.floor(totalHeight)
        self:GetFrameSprite_UISprite():SetRect(0, 0, self.frameSize.x, self.frameSize.y)
        self:GetFrameSprite_UISprite().transform.localPosition = CS.UnityEngine.Vector3(0,0,0)
    end

    --将外框装饰高度调整至预定高度
    if self:GetOutFrame_UISprite() and CS.StaticUtility.IsNull(self:GetOutFrame_UISprite()) == false then
        self.outFrameSize_y = math.floor(self:GetOutFrame_UISprite().transform.localPosition.y - changeValue * 0.5)
        self:GetOutFrame_UISprite().transform.localPosition = CS.UnityEngine.Vector3(0,self.outFrameSize_y,0)
    end

    --将中央部分高度调整至预定高度
    local clipRegion = 0
    if self:GetCenterUIPanel_UIPanel() and CS.StaticUtility.IsNull(self:GetCenterUIPanel_UIPanel()) == false then
        clipRegion = self:GetCenterUIPanel_UIPanel().baseClipRegion
        clipRegion.w = finalCenterHeight
        self:GetCenterUIPanel_UIPanel().baseClipRegion = clipRegion
    end
    --将顶部坐标调整至合适的高度
    if self:GetUpperContentTable_UITable() and CS.StaticUtility.IsNull(self:GetUpperContentTable_UITable()) == false then
        local upperPos = self:GetUpperContentTable_UITable().transform.localPosition
        upperPos.x = math.floor(upperPos.x + self.mDistanceToLeftBound)
        upperPos.y = math.floor(halfTotalHeight - self.mDistanceToTopBound)
        self:GetUpperContentTable_UITable().transform.localPosition = upperPos
    end
    --将中央根节点调整至合适高度
    if self:GetCenterRoot_Transform() and CS.StaticUtility.IsNull(self:GetCenterRoot_Transform()) == false then
        local centerPos = self:GetCenterRoot_Transform().transform.localPosition
        centerPos.x = math.floor(centerPos.x + self.mDistanceToLeftBound)
        centerPos.y = math.floor(halfTotalHeight - self.mDistanceToTopBound - upperHeight - self.mDistanceBetweenParts - finalCenterHeight * 0.5)
        self:GetCenterRoot_Transform().transform.localPosition = centerPos
    end
    --将中央Scroll View中内容的相对坐标调整至ScrollView的顶部
    if self:GetCenterContentTable_UITable() and CS.StaticUtility.IsNull(self:GetCenterContentTable_UITable()) == false then
        local scrollContentPos = self:GetCenterContentTable_UITable().transform.localPosition
        scrollContentPos.y = math.floor(centerHeight * 0.5 - self:GetCenterContentTable_UITable().padding.y)
        self:GetCenterContentTable_UITable().transform.localPosition = scrollContentPos
    end
    --将 Scroll View 中内容拉至顶部
    if self:GetCenterUIPanel_UIPanel() and CS.StaticUtility.IsNull(self:GetCenterContentTable_UITable()) == false then
        local centerDis = (centerHeight - finalCenterHeight) * 0.5
        local centerClipOffset = self:GetCenterUIPanel_UIPanel().clipOffset
        centerClipOffset.y = math.floor(centerDis)
        self:GetCenterUIPanel_UIPanel().clipOffset = centerClipOffset
        local centerLocalPosition = self:GetCenterUIPanel_UIPanel().transform.localPosition
        centerLocalPosition.y = math.floor(-centerDis)
        self:GetCenterUIPanel_UIPanel().transform.localPosition = centerLocalPosition
    end
    --将底部坐标调整至合适的高度
    if self:GetLowerContentTable_UITable() and CS.StaticUtility.IsNull(self:GetLowerContentTable_UITable()) == false then
        local lowerPos = self:GetLowerContentTable_UITable().transform.localPosition
        --lowerPos.x = math.floor(lowerPos.x + self.mDistanceToLeftBound)
        --lowerPos.y = halfTotalHeight - self.mDistanceToTopBound - upperHeight - self.mDistanceBetweenParts - finalCenterHeight - self.mDistanceBetweenParts
        lowerPos.y = math.floor(halfTotalHeight - self.mDistanceToTopBound - upperHeight  - finalCenterHeight - self.mDistanceBetweenParts) + self.mCenterDownDistance
        self:GetLowerContentTable_UITable().transform.localPosition = lowerPos
    end
    --将右上角坐标调整到合适的高度
    if self:GetUpRightTable_UITable() and CS.StaticUtility.IsNull(self:GetUpRightTable_UITable()) == false then
        local rightUpPos = self:GetUpRightTable_UITable().transform.localPosition
        rightUpPos.y = (halfTotalHeight + 1)
        self:GetUpRightTable_UITable().transform.localPosition = rightUpPos
    end
    --endregion
end
--endregion

--region 获取右上角按钮模块
function UIPetInfoPanel_PartBasic:GetRightUpButtonsModule(defaultRightUpButtonModule)
    local defaultRightUpButtonModule = defaultRightUpButtonModule
    local curRightUpButtonsModule = ternary(self.rightUpButtonsModule == nil,defaultRightUpButtonModule,self.rightUpButtonsModule)
    return curRightUpButtonsModule
end
--endregion

--region 可重载方法
---刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIPetInfoPanel_PartBasic:RefreshUpperArea(bagItemInfo, itemInfo)
    --在子类中调用self:CreateTemplateUnderArea(templateGO, templateTable, area)以在界面中加入物品信息选项
end

---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIPetInfoPanel_PartBasic:RefreshCenterArea(bagItemInfo, itemInfo)
    --在子类中调用self:CreateTemplateUnderArea(templateGO, templateTable, area)以在界面中加入物品信息选项
end

---刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIPetInfoPanel_PartBasic:RefreshLowerArea(bagItemInfo, itemInfo)
    --在子类中调用self:CreateTemplateUnderArea(templateGO, templateTable, area)以在界面中加入物品信息选项
end
--endregion

return UIPetInfoPanel_PartBasic