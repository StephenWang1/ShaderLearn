local UIItemInfoPanel_Info_RightDownOperateButtons ={}
setmetatable(UIItemInfoPanel_Info_RightDownOperateButtons, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

---背景图宽度
UIItemInfoPanel_Info_RightDownOperateButtons.BgWeightDistance = 10
---背景图高度
UIItemInfoPanel_Info_RightDownOperateButtons.BgHeightDistance = 20

--region 组件
---按钮列表
function UIItemInfoPanel_Info_RightDownOperateButtons:GetBtnList_GameObject()
    if self.mBtnList_GameObject == nil or CS.StaticUtility.IsNull(self.mBtnList_GameObject) then
        self.mBtnList_GameObject = self:Get("BtnList", "GameObject")
    end
    return self.mBtnList_GameObject
end
---按钮列表背景图
function UIItemInfoPanel_Info_RightDownOperateButtons:GetBtnBg_GameObject()
    if self.mBtnBg_GameObject == nil or CS.StaticUtility.IsNull(self.mBtnBg_GameObject) then
        self.mBtnBg_GameObject = self:Get("BtnList/window/Scroll View/itemGrid/bg", "GameObject")
    end
    return self.mBtnBg_GameObject
end
--endregion

function UIItemInfoPanel_Info_RightDownOperateButtons:Init()
    self.go.transform.parent.gameObject:SetActive(false)
end

---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_RightDownOperateButtons:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    self.BtnList = templatemanager.GetNewTemplate(self:GetBtnList_GameObject(),luaComponentTemplates.UIBtnListTemplate)
    self:InitUIAcquirePathPanel(itemInfo)
    self:BGSelfAdaptaion()
end

---初始化获取途径面板
function UIItemInfoPanel_Info_RightDownOperateButtons:InitUIAcquirePathPanel(itemInfo)
    if itemInfo.wayGet ~= nil then
        local wayGetTable = {}
        local length = itemInfo.wayGet.list.Count - 1
        for k = 0,length do
            table.insert(wayGetTable,itemInfo.wayGet.list[k])
        end
        self.BtnList:Show("获取途径",wayGetTable)
    end
end

---背景图自适应
function UIItemInfoPanel_Info_RightDownOperateButtons:BGSelfAdaptaion()
    ---调整背景图的尺寸\
    local bg_UISprite = CS.Utility_Lua.GetComponent(self:GetBtnBg_GameObject().transform,"UISprite")
    if self.BtnList.mbtnGird_UIGridContainer.controlList.Count > 0 then
        local lastBtnUISprite = CS.Utility_Lua.GetComponent(self.BtnList.mbtnGird_UIGridContainer.controlList[0].transform:Find("Checkmark"),"UISprite")
        local singleBtn_Size = lastBtnUISprite.localSize
        local btnHeightIntervals = self.BtnList.mbtnGird_UIGridContainer.CellHeight - singleBtn_Size.y
        local bgHeight = self.BtnList.mbtnGird_UIGridContainer.controlList.Count * singleBtn_Size.y + (self.BtnList.mbtnGird_UIGridContainer.controlList.Count - 1) * btnHeightIntervals + self.BgHeightDistance
        local bgWeight = singleBtn_Size.x + self.BgWeightDistance
        bg_UISprite:SetRect(0,0,bgWeight,bgHeight)
        ---调整背景图的位置
        local bgposition_y = lastBtnUISprite.transform.parent.localPosition.y * 0.5
        local bgposition_x = lastBtnUISprite.transform.localPosition.x + -1 * (self.BgWeightDistance / 2)
        bg_UISprite.transform.localPosition = CS.UnityEngine.Vector3(bgposition_x,bgposition_y,0)
    else
        bg_UISprite.gameObject:SetActive(false)
    end
end
return UIItemInfoPanel_Info_RightDownOperateButtons