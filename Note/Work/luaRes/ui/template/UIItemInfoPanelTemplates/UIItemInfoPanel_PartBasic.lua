---@class UIItemInfoPanel_PartBasic
local UIItemInfoPanel_PartBasic = {}

--region 参数
---最大外框高度
UIItemInfoPanel_PartBasic.mMaxFrameHeight = 600
---最小外框高度
UIItemInfoPanel_PartBasic.mMinFrameHeight = 100
---区域之间的距离(只用于up区域和center区域之间的间隔，有内容的情况下是策划定的15，否则是0)
UIItemInfoPanel_PartBasic.mDistanceBetweenParts = 10
---到顶部的距离
UIItemInfoPanel_PartBasic.mDistanceToTopBound = 10
---到底部的距离
UIItemInfoPanel_PartBasic.mDistanceToBottomBound = 20
---到左部的距离
UIItemInfoPanel_PartBasic.mDistanceToLeftBound = 0
---center模块与down模块间距（补充值，对于像素偏差的特殊处理）
UIItemInfoPanel_PartBasic.mCenterDownDistance = 0
--endregion

--region 属性
---子界面外框尺寸
function UIItemInfoPanel_PartBasic:FrameSize()
    return self:GetFrameSprite_UISprite().localSize
end
--endregion

--region 组件
---外框图片
---@return UISprite
function UIItemInfoPanel_PartBasic:GetFrameSprite_UISprite()
    if self.mFrameSprite_UISprite == nil then
        self.mFrameSprite_UISprite = self:Get("window/background", "UISprite")
    end
    return self.mFrameSprite_UISprite
end

---外框装饰图片
---@return UISprite
function UIItemInfoPanel_PartBasic:GetOutFrame_UISprite()
    if self.mOutFrame_UISprite == nil then
        self.mOutFrame_UISprite = self:Get("window/outframe", "UISprite")
    end
    return self.mOutFrame_UISprite
end

---外框碰撞体
---@return UISprite
function UIItemInfoPanel_PartBasic:GetFrameSprite_BoxCollider()
    if self.mFrameSprite_BoxCollider == nil then
        self.mFrameSprite_BoxCollider = self:Get("window/background", "BoxCollider")
    end
    return self.mFrameSprite_BoxCollider
end

---中央滑动区域
---@return UIPanel
function UIItemInfoPanel_PartBasic:GetCenterUIPanel_UIPanel()
    if self.mCenterUIPanel_UIPanel == nil then
        self.mCenterUIPanel_UIPanel = self:Get("content/center/Scroll View", "UIPanel")
    end
    return self.mCenterUIPanel_UIPanel
end

---中央滑动区域
---@return UIScrollView
function UIItemInfoPanel_PartBasic:GetCenterUIPanel_UIScrollView()
    if self.mCenterUIPanel_UIScrollView == nil then
        self.mCenterUIPanel_UIScrollView = self:Get("content/center/Scroll View", "UIScrollView")
    end
    return self.mCenterUIPanel_UIScrollView
end

---内容根物体
function UIItemInfoPanel_PartBasic:GetCenterRoot_Transform()
    if self.mCenterRoot_Transform == nil then
        self.mCenterRoot_Transform = self:Get("content/center", "Transform")
    end
    return self.mCenterRoot_Transform
end

---上方部分内容
---@return UITable
function UIItemInfoPanel_PartBasic:GetUpperContentTable_UITable()
    if self.mUpperContentTable_UITable == nil then
        self.mUpperContentTable_UITable = self:Get("content/up", "UITable")
    end
    return self.mUpperContentTable_UITable
end

---中央部分内容(滑动区域)
---@return UITable
function UIItemInfoPanel_PartBasic:GetCenterContentTable_UITable()
    if self.mCenterContentTable_UITable == nil then
        self.mCenterContentTable_UITable = self:Get("content/center/Scroll View/scrollContent", "UITable")
    end
    return self.mCenterContentTable_UITable
end

---下方部分内容
---@return UITable
function UIItemInfoPanel_PartBasic:GetLowerContentTable_UITable()
    if self.mLowerContentTable_UITable == nil then
        self.mLowerContentTable_UITable = self:Get("content/down", "UITable")
    end
    return self.mLowerContentTable_UITable
end

---右上方部分内容
---@return UITable
function UIItemInfoPanel_PartBasic:GetUpRightTable_UITable()
    if self.mUpRightTable_UITable == nil then
        self.mUpRightTable_UITable = self:Get("content/rightup", "UITable")
    end
    return self.mUpRightTable_UITable
end

---右下方部分内容
---@return UITable
function UIItemInfoPanel_PartBasic:GetDownRightTable_UITable()
    if self.mDownRightTable_UITable == nil then
        self.mDownRightTable_UITable = self:Get("content/rightdown", "UITable")
    end
    return self.mDownRightTable_UITable
end

---左上方部分内容
---@return UITable
function UIItemInfoPanel_PartBasic:GetLeftTopTable_UITable()
    if self.mLeftTopTable_UITable == nil then
        self.mLeftTopTable_UITable = self:Get("content/lefttop", "UITable")
    end
    return self.mLeftTopTable_UITable
end

---上滑动箭头
function UIItemInfoPanel_PartBasic:GetUpArrow_GameObject()
    if self.mUpArrow_GameObject == nil then
        self.mUpArrow_GameObject = self:Get("content/center/upArrow", "GameObject")
    end
    return self.mUpArrow_GameObject
end

---下滑动箭头
function UIItemInfoPanel_PartBasic:GetDownArrow_GameObject()
    if self.mDownArrow_GameObject == nil then
        self.mDownArrow_GameObject = self:Get("content/center/downArrow", "GameObject")
    end
    return self.mDownArrow_GameObject
end

---选择特效
function UIItemInfoPanel_PartBasic:GetChooseEffect_UISprite()
    if self.mChooseEffect_UISprite == nil then
        self.mChooseEffect_UISprite = self:Get("content/Choose", "UISprite")
    end
    return self.mChooseEffect_UISprite
end

---背景图toggle
function UIItemInfoPanel_PartBasic:GetBackGround_UIToggle()
    if self.mBackGround_UIToggle == nil then
        self.mBackGround_UIToggle = self:Get("window/background", "UIToggle")
    end
    return self.mBackGround_UIToggle
end

---滑动区域碰撞体
function UIItemInfoPanel_PartBasic:GetScrollBox_GameObject()
    if self.mScrollBox_GameObject == nil then
        self.mScrollBox_GameObject = self:Get("content/center/Scroll Box", "GameObject")
    end
    return self.mScrollBox_GameObject
end

---底图outframe2
---@return UISprite
function UIItemInfoPanel_PartBasic:GetOutframe2_UISprite()
    if self.mOutframe2_UISprite == nil then
        self.mOutframe2_UISprite = self:Get("window/outframe2", "UISprite")
    end
    return self.mOutframe2_UISprite
end
--endregion

--region 单条信息显示模板
---单条信息显示模板根节点
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetInfoTemplateRoot_GO()
    if self.mTemplateRoot_GO == nil then
        self.mTemplateRoot_GO = self:GetCurComp(self.widgetRoot_Go, "templates", "GameObject")
    end
    return self.mTemplateRoot_GO
end

---UIItem信息显示模板
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetInfoTemplate_UIItem_GO()
    if self.mInfoTemplate_UIItem_GO == nil then
        self.mInfoTemplate_UIItem_GO = self:GetCurComp(self.widgetRoot_Go, "templates/uiitemtemplate", "GameObject")
    end
    return self.mInfoTemplate_UIItem_GO
end

---双线信息显示模板
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetInfoTemplate_DoubleLine_GO()
    if self.mInfoTemplate_DoubleLine_GO == nil then
        self.mInfoTemplate_DoubleLine_GO = self:GetCurComp(self.widgetRoot_Go, "templates/doublelinetemplate", "GameObject")
    end
    return self.mInfoTemplate_DoubleLine_GO
end

---技能信息展示
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetInfoTemplate_SkillDesc_GO()
    if self.mGetInfoTemplate_SkillDesc_GO == nil then
        self.mGetInfoTemplate_SkillDesc_GO = self:GetCurComp(self.widgetRoot_Go, "templates/skilldesctemplate", "GameObject")
    end
    return self.mGetInfoTemplate_SkillDesc_GO
end

---单线信息显示模板
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetInfoTemplate_SingleLine_GO()
    if self.mInfoTemplate_SingleLine_GO == nil then
        self.mInfoTemplate_SingleLine_GO = self:GetCurComp(self.widgetRoot_Go, "templates/singlelinetemplate", "GameObject")
    end
    return self.mInfoTemplate_SingleLine_GO
end

---兵鉴信息显示模板
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetInfoTemplate_SLEquip_GO()
    if self.mInfoTemplate_SLEquip_GO == nil then
        self.mInfoTemplate_SLEquip_GO = self:GetCurComp(self.widgetRoot_Go, "templates/slequipleveltemplate", "GameObject")
    end
    return self.mInfoTemplate_SLEquip_GO
end

---按钮信息显示模板
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetInfoTemplate_Buttons_GO()
    if self.mInfoTemplate_Buttons_GO == nil then
        self.mInfoTemplate_Buttons_GO = self:GetCurComp(self.widgetRoot_Go, "templates/buttonstemplate", "GameObject")
    end
    return self.mInfoTemplate_Buttons_GO
end

---右上角按钮信息显示模板
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetInfoTemplate_RightButtons_Go()
    if self.mInfoTemplate_RightButtons_Go == nil then
        self.mInfoTemplate_RightButtons_Go = self:GetCurComp(self.widgetRoot_Go, "templates/rightbuttonstemplate", "GameObject")
    end
    return self.mInfoTemplate_RightButtons_Go
end

---右下角按钮信息显示模板
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetInfoTemplate_RightDownButtons_Go()
    if self.mInfoTemplate_RightDownButtons_Go == nil then
        self.mInfoTemplate_RightDownButtons_Go = self:GetCurComp(self.widgetRoot_Go, "templates/rightdownbuttonstemplate", "GameObject")
    end
    return self.mInfoTemplate_RightDownButtons_Go
end

---基础属性信息显示模板
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetInfoTemplate_BaseAttribute_GO()
    if self.mInfoTemplate_BaseAttribute_GO == nil then
        self.mInfoTemplate_BaseAttribute_GO = self:GetCurComp(self.widgetRoot_Go, "templates/baseattributetemplate", "GameObject")
    end
    return self.mInfoTemplate_BaseAttribute_GO
end

---标头信息显示模板
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetInfoTemplate_Header_GO()
    if self.mInfoTemplate_Header_GO == nil then
        self.mInfoTemplate_Header_GO = self:GetCurComp(self.widgetRoot_Go, "templates/uiheadertemplate", "GameObject")
    end
    return self.mInfoTemplate_Header_GO
end

---模型信息显示模板
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetInfoTemplate_Model_GO()
    if self.mInfoTemplate_Model_GO == nil then
        self.mInfoTemplate_Model_GO = self:GetCurComp(self.widgetRoot_Go, "templates/modeltemplate", "GameObject")
    end
    return self.mInfoTemplate_Model_GO
end

---灵兽基础属性显示模板
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetInfoTemplate_ServantBaseAttribute_GO()
    if self.mInfoTemplate_ServantBaseAttribute_GO == nil then
        self.mInfoTemplate_ServantBaseAttribute_GO = self:GetCurComp(self.widgetRoot_Go, "templates/servantbaseattributetemplate", "GameObject")
    end
    return self.mInfoTemplate_ServantBaseAttribute_GO
end
---印记信息显示模板
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetSignettemplate_GO()
    if self.mSignettemplate_GO == nil then
        self.mSignettemplate_GO = self:GetCurComp(self.widgetRoot_Go, "templates/signettemplate", "GameObject")
    end
    return self.mSignettemplate_GO
end

---额外属性信息显示模板
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetExtraAttribute_GO()
    if self.mExtraAttribute_GO == nil then
        self.mExtraAttribute_GO = self:GetCurComp(self.widgetRoot_Go, "templates/extraattributetemplate", "GameObject")
    end
    return self.mExtraAttribute_GO
end

---上部按钮列表
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetTopButtons_GO()
    if self.mTopButtons_GO == nil then
        self.mTopButtons_GO = self:GetCurComp(self.widgetRoot_Go, "templates/topbuttonstemplate", "GameObject")
    end
    return self.mTopButtons_GO
end

---物品列表显示模板
---@return UnityEngine.GameObject
function UIItemInfoPanel_PartBasic:GetItemListTemplate_GO()
    if self.ItemListTemplate_GO == nil then
        self.ItemListTemplate_GO = self:GetCurComp(self.widgetRoot_Go, "templates/exchangetemplate", "GameObject")
    end
    return self.ItemListTemplate_GO
end

---@return UIItemInfoPanel_Info_UIItem
function UIItemInfoPanel_PartBasic:GetUIItemTemplate()
    if (self.mUIItem == nil) then
        self.mUIItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.UIItemInfoPanel_Info_UIItem, self:GetUpperContentTable_UITable(), LuaEnumItemInfoModuleType.IconAndBaseMsg)
    end
    return self.mUIItem;
end

---@return UIItemInfoPanel_Info_BaseAttribute
function UIItemInfoPanel_PartBasic:GetBaseAttributeTemplate()
    if (self.mBaseAttribute == nil) then
        self.mBaseAttribute = self:CreateTemplateUnderArea(self:GetInfoTemplate_BaseAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_BaseAttribute, self:GetCenterContentTable_UITable(), LuaEnumItemInfoModuleType.BaseAttribute)
    end
    return self.mBaseAttribute;
end
--endregion

--region 初始化
function UIItemInfoPanel_PartBasic:Init(widgetRoot_Go)
    --面板主节点
    self.widgetRoot_Go = widgetRoot_Go
    --隐藏templates
    if self:GetInfoTemplateRoot_GO() and CS.StaticUtility.IsNull(self:GetInfoTemplateRoot_GO()) == false then
        self:GetInfoTemplateRoot_GO():SetActive(false)
    end
    self:BindEvents()
end

---绑定事件
function UIItemInfoPanel_PartBasic:BindEvents()
    self:GetCenterUIPanel_UIScrollView().onDragProgress = function()
        self:ScrollViewMove()
    end
    CS.UIEventListener.Get(self:GetFrameSprite_UISprite().gameObject).onClick = function()
        if self.commonData ~= nil and self.commonData.tipsOnClick ~= nil then
            self.commonData.tipsOnClick(self)
        end
    end
end
--endregion

--region 显示方法
---使用背包物品信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_PartBasic:RefreshWithBagItemInfo(commonData)
    ---@type UIItemTipInfoCommonData
    self.commonData = commonData
    self:AnalysisCommonData(commonData)
    self:RefreshUpperArea(commonData)
    self:RefreshCenterArea(commonData)
    self:RefreshLowerArea(commonData)
    if commonData.showRight == true then
        self:RefreshRightUpArea(commonData)
        self:RefreshRightDownArea(commonData)
    end
    if commonData.showTabBtns == true then
        self:RefreshTopLeftArea(commonData)
    end
    self:CheckCenterAreaHaveContent()
    if self.refreshBackGroundDelayContinue ~= nil then
        StopCoroutine(self.refreshBackGroundDelayContinue)
        self.refreshBackGroundDelayContinue = nil
    end
    self.refreshBackGroundDelayContinue = StartCoroutine(function()
        coroutine.yield(0)
        self:AdjustPartSize()
        self:RefreshToggle()
    end)
    ---主面板显示右上角按钮
    if CS.StaticUtility.IsNull(self:GetUpRightTable_UITable()) == false then
        self:GetUpRightTable_UITable().gameObject:SetActive(commonData.isMainPartTemplate == true)
        luaclass.UIRefresh:RefreshUITable(self:GetUpRightTable_UITable())
    end
end

---解析数据
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_PartBasic:AnalysisCommonData(commonData)
    self.commonData = commonData
    self.rightUpButtonsModule = commonData.rightUpButtonsModule
    self.mMaxFrameHeight = commonData.maxFrameHeight
    self.backGroundName = commonData.backGroundName
end

---检测中央区域是否有内容
function UIItemInfoPanel_PartBasic:CheckCenterAreaHaveContent()
    if self:GetCenterContentTable_UITable() ~= nil and CS.StaticUtility.IsNull(self:GetCenterContentTable_UITable()) == false and self:GetCenterContentTable_UITable().transform.childCount > 0 then
        for i = 0, self:GetCenterContentTable_UITable().transform.childCount - 1 do
            if self:GetCenterContentTable_UITable().transform:GetChild(i).gameObject.activeSelf == true then
                self.mDistanceBetweenParts = 10
                return
            end
        end
        self.mDistanceBetweenParts = 6
    end
end

---在区域内实例化一个模板
---@param templateGO UnityEngine.GameObject 模板预设游戏物体
---@param templateTable table 模板对应的表
---@param area UITable 区域
---@param moduleType LuaEnumItemInfoModuleType 模块类型
---@return 物品信息界面信息 返回实例化得到的table
function UIItemInfoPanel_PartBasic:CreateTemplateUnderArea(templateGO, templateTable, area, moduleType)
    if templateGO and CS.StaticUtility.IsNull(templateGO) == false and area and CS.StaticUtility.IsNull(area) == false and self:CheckHaveTemplate(moduleType) == false then
        local goTemp = CS.Utility_Lua.CopyGO(templateGO, area.transform)
        if goTemp then
            goTemp:SetActive(true)
            goTemp.transform:SetAsLastSibling()
            local template = templatemanager.GetNewTemplate(goTemp, templateTable)
            self:AddTemplateCache(template, moduleType)
            return template
        end
    else
        local template = self:GetTemplate(moduleType)
        template.go:SetActive(true)
        return template
    end
end

---高度是否超出限制
function UIItemInfoPanel_PartBasic:HightExceedLimit(totalHight)
    return totalHight > self.mMaxFrameHeight
end

---调整大小
function UIItemInfoPanel_PartBasic:AdjustPartSize()
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
    self.mCenterDownDistance = 0
    upperHeight = CS.NGUIMath.CalculateRelativeWidgetBounds(self:GetCenterRoot_Transform(), self:GetUpperContentTable_UITable().transform, false, true).size.y
    lowerHeight = CS.NGUIMath.CalculateRelativeWidgetBounds(self:GetCenterRoot_Transform(), self:GetLowerContentTable_UITable().transform, false, true).size.y
    centerHeight = CS.NGUIMath.CalculateRelativeWidgetBounds(self:GetCenterRoot_Transform(), self:GetCenterContentTable_UITable().transform, false, true).size.y
    --为了保证Scroll View组件能够在大小合适时禁止拖动,应将Scroll View的softclip的高度和UITable组件中用于的padding的高度计算进去
    centerHeight = centerHeight + 2 * self:GetCenterUIPanel_UIPanel().clipSoftness.y + self:GetCenterContentTable_UITable().padding.y * 2
    centerHeight = math.ceil(centerHeight)

    --面板高度超过设定高度，则将dowm节点向下移动
    if self:HightExceedLimit(self.mDistanceToTopBound + upperHeight + self.mDistanceBetweenParts + lowerHeight + self.mDistanceToBottomBound + centerHeight) then
        self:ChangeScrollViewArrowState(true)
        self.mCenterDownDistance = self.mCenterDownDistance - 8
    else
        self:ChangeScrollViewArrowState(false)
    end

    --计算出除中心区域的高度
    local heightExpectCenter = 0
    if self.mDistanceToTopBound and self.mDistanceBetweenParts and self.mDistanceToBottomBound then
        heightExpectCenter = self.mDistanceToTopBound + upperHeight + self.mDistanceBetweenParts + lowerHeight + self.mDistanceToBottomBound
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
        self:GetFrameSprite_UISprite().transform.localPosition = CS.UnityEngine.Vector3.zero
    end

    --调整特效背景高度
    if self:GetChooseEffect_UISprite() and CS.StaticUtility.IsNull(self:GetChooseEffect_UISprite()) == false then
        self:GetChooseEffect_UISprite():SetRect(0, 0, self.frameSize.x + 4, self.frameSize.y + 4)
        self:GetChooseEffect_UISprite().transform.localPosition = CS.UnityEngine.Vector3.zero
    end

    --将外框装饰高度调整至预定高度
    if self:GetOutFrame_UISprite() and CS.StaticUtility.IsNull(self:GetOutFrame_UISprite()) == false then
        self.outFrameSize_y = math.floor(self:GetOutFrame_UISprite().transform.localPosition.y - changeValue * 0.5)
        self:GetOutFrame_UISprite().transform.localPosition = CS.UnityEngine.Vector3(0, self.outFrameSize_y, 0)
    end

    --将中央部分高度调整至预定高度
    local clipRegion = 0
    if self:GetCenterUIPanel_UIPanel() and CS.StaticUtility.IsNull(self:GetCenterUIPanel_UIPanel()) == false then
        clipRegion = self:GetCenterUIPanel_UIPanel().baseClipRegion
        clipRegion.w = finalCenterHeight
        self:GetCenterUIPanel_UIPanel().baseClipRegion = clipRegion
        self.centerHight = finalCenterHeight
        self:ResetArrowPosition()
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
        lowerPos.y = math.floor(halfTotalHeight - self.mDistanceToTopBound - upperHeight - finalCenterHeight - self.mDistanceBetweenParts + self.mCenterDownDistance)
        self:GetLowerContentTable_UITable().transform.localPosition = lowerPos
    end
    --将右上角坐标调整到合适的高度
    if self:GetUpRightTable_UITable() and CS.StaticUtility.IsNull(self:GetUpRightTable_UITable()) == false then
        local rightUpPos = self:GetUpRightTable_UITable().transform.localPosition
        rightUpPos.y = (halfTotalHeight + 2)
        self:GetUpRightTable_UITable().transform.localPosition = rightUpPos
    end
    --将右下角坐标调整到合适的高度
    if self:GetDownRightTable_UITable() and CS.StaticUtility.IsNull(self:GetDownRightTable_UITable()) == false then
        local rightDownPos = self:GetDownRightTable_UITable().transform.localPosition
        rightDownPos.y = -halfTotalHeight
        self:GetDownRightTable_UITable().transform.localPosition = rightDownPos
    end
    --将右上角坐标调整到合适的高度
    if self:GetLeftTopTable_UITable() and CS.StaticUtility.IsNull(self:GetLeftTopTable_UITable()) == false then
        local leftTopPos = self:GetLeftTopTable_UITable().transform.localPosition
        leftTopPos.y = (halfTotalHeight + 2)
        self:GetLeftTopTable_UITable().transform.localPosition = leftTopPos
    end
    --endregion
    if self:GetOutframe2_UISprite() ~= nil then
        self:GetOutframe2_UISprite():UpdateAnchors()
    end
end
--endregion

--region 获取右上角按钮模块
function UIItemInfoPanel_PartBasic:GetRightUpButtonsModule(defaultRightUpButtonModule)
    ---默认模板
    local defaultRightUpButtonModule = defaultRightUpButtonModule
    local curRightUpButtonsModule = ternary(self.rightUpButtonsModule == nil, defaultRightUpButtonModule, self.rightUpButtonsModule)
    return curRightUpButtonsModule
end
--endregion

--region 数据清理刷新
---存储模板
function UIItemInfoPanel_PartBasic:AddTemplateCache(template, templateType)
    if template == nil or templateType == nil then
        return
    end
    if self.moduleTemplates == nil then
        self.moduleTemplates = {}
    end
    self.moduleTemplates[templateType] = template
end

---移除模板(直接隐藏不影响之后的排版)
---@param templateType LuaEnumItemInfoModuleType 模块类型
function UIItemInfoPanel_PartBasic:RemoveTemplateCache(templateType)
    if self.moduleTemplates ~= nil and self.moduleTemplates[templateType] ~= nil and CS.StaticUtility.IsNull(self.moduleTemplates[templateType].go) == false then
        self.moduleTemplates[templateType].go:SetActive(false)
    end
end

---检测是否有对应类型的模板
---@param templateType LuaEnumItemInfoModuleType 模块类型
---@return 是否注册过模块
function UIItemInfoPanel_PartBasic:CheckHaveTemplate(templateType)
    if self.moduleTemplates ~= nil and templateType ~= nil then
        return self.moduleTemplates[templateType] ~= nil
    end
    return false
end

---检测是否有对应类型的模板
---@param templateType LuaEnumItemInfoModuleType 模块类型
---@return template
function UIItemInfoPanel_PartBasic:GetTemplate(templateType)
    return self.moduleTemplates[templateType]
end

---刷新模板
---@param templateType LuaEnumItemInfoModuleType 模块类型
---@param commonData Table 参数表
---@return boolean 是否刷新成功
function UIItemInfoPanel_PartBasic:RefreshTemplate(templateType)
    if self.moduleTemplates ~= nil and self.moduleTemplates[templateType] ~= nil then
        self.moduleTemplates[templateType].go:SetActive(true)
        self.moduleTemplates[templateType]:RefreshWithInfo(self.commonData)
        return true
    end
    return false
end

---修改通用参数（修改指定内容表数据）
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_PartBasic:AmendCommonData(commonData)
    if commonData ~= nil then
        if commonData.bagItemInfo ~= nil then
            self.commonData.bagItemInfo = commonData.bagItemInfo
        end
        if commonData.itemInfo ~= nil then
            self.commonData.itemInfo = commonData.itemInfo
        end
        if commonData.bagItemInfo ~= nil then
            self.commonData.bagItemInfo = commonData.bagItemInfo
        end
        if commonData.bagItemInfo ~= nil then
            self.commonData.bagItemInfo = commonData.bagItemInfo
        end
        if commonData.showRight ~= nil then
            self.commonData.showRight = commonData.showRight
        end
        if commonData.compareBagItemInfo ~= nil then
            self.commonData.compareBagItemInfo = commonData.compareBagItemInfo
        end
        if commonData.compareItemInfo ~= nil then
            self.commonData.compareItemInfo = commonData.compareItemInfo
        end
        if commonData.career ~= nil then
            self.commonData.career = commonData.career
        end
        if commonData.rightUpButtonsModule ~= nil then
            self.commonData.rightUpButtonsModule = commonData.rightUpButtonsModule
        end
        if commonData.extraEquipIdTable ~= nil then
            self.commonData.extraEquipIdTable = commonData.extraEquipIdTable
        end
        if commonData.highLightBtnTable ~= nil then
            self.commonData.highLightBtnTable = commonData.highLightBtnTable
        end
        if commonData.itemInfoSource ~= nil then
            self.commonData.itemInfoSource = commonData.itemInfoSource
        end
        if commonData.assistPanelBagItemInfoTable ~= nil then
            self.commonData.assistPanelBagItemInfoTable = commonData.assistPanelBagItemInfoTable
        end
        if commonData.assistPanelItemInfoTable ~= nil then
            self.commonData.assistPanelItemInfoTable = commonData.assistPanelItemInfoTable
        end
        if commonData.isMainPartTemplate ~= nil then
            self.commonData.isMainPartTemplate = commonData.isMainPartTemplate
        end
    end
end

---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_PartBasic:TabChangeRefreshPanel(commonData)
    self:CloseDownArea()
    self:AmendCommonData(commonData)
    self:RefreshWithBagItemInfo(self.commonData)
end

---关闭下方区域面板
function UIItemInfoPanel_PartBasic:CloseDownArea()
    self:RemoveTemplateCache(LuaEnumItemInfoModuleType.ItemDescription)
    self:RemoveTemplateCache(LuaEnumItemInfoModuleType.WayGetDescription)
    self:RemoveTemplateCache(LuaEnumItemInfoModuleType.ItemDescription2)
end

---刷新toggle
function UIItemInfoPanel_PartBasic:RefreshToggle()
    if CS.StaticUtility.IsNull(self:GetBackGround_UIToggle()) == false then
        local toggleState = self.commonData.tipsOnClick ~= nil
        self:GetBackGround_UIToggle().enabled = toggleState
        if CS.StaticUtility.IsNull(self:GetFrameSprite_BoxCollider()) == false then
            self:GetFrameSprite_BoxCollider().enabled = toggleState
        end
        ---默认状态刷新
        if self.commonData.defaultChooseTable ~= nil and self.commonData.bagItemInfo ~= nil and Utility.IsContainsValue(self.commonData.defaultChooseTable, self.commonData.bagItemInfo) == true then
            self:GetBackGround_UIToggle():Set(true)
        end
    end
end
--endregion

--region 滑动箭头
---切换滑动箭头状态
function UIItemInfoPanel_PartBasic:ChangeScrollViewArrowState(state)
    state = ternary(state == nil, false, state)
    if type(state) == 'boolean' and self:GetUpArrow_GameObject() ~= nil and self:GetDownArrow_GameObject() ~= nil then
        if state == true then
            self:GetUpArrow_GameObject():SetActive(false)
            self:GetDownArrow_GameObject():SetActive(true)
            self:GetScrollBox_GameObject():SetActive(true)
        else
            self:GetUpArrow_GameObject():SetActive(false)
            self:GetDownArrow_GameObject():SetActive(false)
            self:GetScrollBox_GameObject():SetActive(false)
        end
        self.scrollViewArrowState = state
    end
end

---重置箭头位置
function UIItemInfoPanel_PartBasic:ResetArrowPosition()
    if self.scrollViewArrowState == true then
        self.upCenterArea = self.centerHight * 0.5 - 10
        self.downCenterArea = self.centerHight * -0.5 + 10
        local upArrowLocalPosition = CS.UnityEngine.Vector3.up * self.upCenterArea
        local downArrowLocalPosition = CS.UnityEngine.Vector3.up * self.downCenterArea
        self:GetUpArrow_GameObject().transform.localPosition = upArrowLocalPosition
        self:GetDownArrow_GameObject().transform.localPosition = downArrowLocalPosition
    end
end

---中央滑动区域滑动
function UIItemInfoPanel_PartBasic:ScrollViewMove()
    local scrollviewSoftState = self:GetCenterUIPanel_UIScrollView():GetScrollViewSoftState(false)
    self:GetUpArrow_GameObject():SetActive(scrollviewSoftState == CS.UIScrollView.ScrollViewSoftState.Middle or scrollviewSoftState == CS.UIScrollView.ScrollViewSoftState.Buttom)
    self:GetDownArrow_GameObject():SetActive(scrollviewSoftState == CS.UIScrollView.ScrollViewSoftState.Top or scrollviewSoftState == CS.UIScrollView.ScrollViewSoftState.Middle)
end
--endregion

--region 可重载方法
---刷新顶部区域
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_PartBasic:RefreshUpperArea(commonData)
    --在子类中调用self:CreateTemplateUnderArea(templateGO, templateTable, area)以在界面中加入物品信息选项
end

---刷新中央区域
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_PartBasic:RefreshCenterArea(commonData)
    --在子类中调用self:CreateTemplateUnderArea(templateGO, templateTable, area)以在界面中加入物品信息选项
end

---刷新底部区域
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_PartBasic:RefreshLowerArea(commonData)
    --在子类中调用self:CreateTemplateUnderArea(templateGO, templateTable, area)以在界面中加入物品信息选项
end

---刷新右上部区域
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_PartBasic:RefreshRightUpArea(commonData)
    --在子类中调用self:CreateTemplateUnderArea(templateGO, templateTable, area)以在界面中加入物品信息选项
end

---刷新右下部区域
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_PartBasic:RefreshRightDownArea(commonData)
    --在子类中调用self:CreateTemplateUnderArea(templateGO, templateTable, area)以在界面中加入物品信息选项
end

---刷新左上部区域
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_PartBasic:RefreshTopLeftArea(commonData)
    --在子类中调用self:CreateTemplateUnderArea(templateGO, templateTable, area)以在界面中加入物品信息选项
end
--endregion

--region OnDestroy
function UIItemInfoPanel_PartBasic:OnDestroy()
    if self.refreshBackGroundDelayContinue ~= nil then
        StopCoroutine(self.refreshBackGroundDelayContinue)
        self.refreshBackGroundDelayContinue = nil
    end
end
--endregion

return UIItemInfoPanel_PartBasic