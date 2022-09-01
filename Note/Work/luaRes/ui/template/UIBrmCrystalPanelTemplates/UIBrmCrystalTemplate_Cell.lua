---白日门水晶单元模板
---@class UIBrmCrystalTemplate_Cell:TemplateBase
local UIBrmCrystalTemplate_Cell = {}

---@return UIBrmCrystalPanel
function UIBrmCrystalTemplate_Cell:GetOwnerPanel()
    return self.mOwnerPanel
end

---背景图特效
---@return CSUIEffectLoad
function UIBrmCrystalTemplate_Cell:GetBackgroundUIEffect()
    if self.mBackgroundUIEffect == nil then
        self.mBackgroundUIEffect = self:Get("backGround", "CSUIEffectLoad")
    end
    return self.mBackgroundUIEffect
end

---模型图
---@return UISprite
function UIBrmCrystalTemplate_Cell:GetModelUISprite()
    if self.mModelUISprite == nil then
        self.mModelUISprite = self:Get("Model", "UISprite")
    end
    return self.mModelUISprite
end

---名字图片
---@return UISprite
function UIBrmCrystalTemplate_Cell:GetNameUISprite()
    if self.mNameUISprite == nil then
        self.mNameUISprite = self:Get("name", "UISprite")
    end
    return self.mNameUISprite
end

---按钮图片
---@return UISprite
function UIBrmCrystalTemplate_Cell:GetButtonBGSprite()
    if self.mButtonBGSprite == nil then
        self.mButtonBGSprite = self:Get("btn_go/backGround", "UISprite")
    end
    return self.mButtonBGSprite
end

---点击事件
---@return UnityEngine.GameObject
function UIBrmCrystalTemplate_Cell:GetButtonGO()
    if self.mButtonGO == nil then
        self.mButtonGO = self:Get("btn_go", "GameObject")
    end
    return self.mButtonGO
end

---按钮文字文本组件
---@return UILabel
function UIBrmCrystalTemplate_Cell:GetButtonNameLabel()
    if self.mButtonNameLabel == nil then
        self.mButtonNameLabel = self:Get("btn_go/lab_name", "UILabel")
    end
    return self.mButtonNameLabel
end

---按钮数量文本组件
---@return UILabel
function UIBrmCrystalTemplate_Cell:GetButtonNumberLabel()
    if self.mButtonNumberLabel == nil then
        self.mButtonNumberLabel = self:Get("btn_go/lab_num", "UILabel")
    end
    return self.mButtonNumberLabel
end

---获取掉落物容器
---@return UIGridContainer
function UIBrmCrystalTemplate_Cell:GetDropItems()
    if self.mDropItems == nil then
        self.mDropItems = self:Get("dropScroll/DropItem", "UIGridContainer")
    end
    return self.mDropItems
end

function UIBrmCrystalTemplate_Cell:Init(ownerPanel)
    self.mOwnerPanel = ownerPanel
    CS.UIEventListener.Get(self:GetButtonGO()).onClick = function()
        if self.mClickCallBack ~= nil and self.mBairimenActivityTbl ~= nil then
            self.mClickCallBack(self:GetButtonGO(), self.mBairimenActivityTbl)
        end
    end
end

---绑定点击事件
---@param clickCallBack fun(UnityEngine.GameObject, TABLE.cfg_bairimen_activity)
function UIBrmCrystalTemplate_Cell:BindClickEvent(clickCallBack)
    self.mClickCallBack = clickCallBack
end

---@param bairimenActivityTbl TABLE.cfg_bairimen_activity
---@param mapID number
---@param lastAmount number
function UIBrmCrystalTemplate_Cell:RefreshUI(bairimenActivityTbl, mapID, lastAmount)
    self.mBairimenActivityTbl = bairimenActivityTbl
    if bairimenActivityTbl == nil then
        self:ResetUI()
        return
    end
    self:GetBackgroundUIEffect():ChangeEffect(bairimenActivityTbl:GetBackground())
    self:GetModelUISprite().spriteName = bairimenActivityTbl:GetModelPicture()
    self:GetNameUISprite().spriteName = bairimenActivityTbl:GetTitle()
    self:GetNameUISprite():MakePixelPerfect()
    ---按钮置灰条件
    --local currentLastingAmount = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_ShengWu():GetCurrentLastingShengWuGatherCount()
    local isShowGrayButton = lastAmount <= 0
    ---地图名
    local confirmType, confirmParam = self:GetOwnerPanel():ParseData(bairimenActivityTbl:GetEventParameters())
    local mapName
    if mapID == nil or mapID == 0 then
        ---如果传入的mapID为nil或0,则使用deliverID对应的地图ID
        if confirmType == 4 and confirmParam ~= nil then
            ---@type TABLE.CFG_DELIVER
            local deliverTblExist, deliverTbl = CS.Cfg_DeliverTableManager.Instance:TryGetValue(confirmParam)
            if deliverTbl and deliverTbl.toMapId ~= 0 then
                mapID = deliverTbl.toMapId
            end
        end
    end
    local isConfirmToCondition = true
    if mapID ~= nil and mapID ~= 0 then
        local mapTbl = clientTableManager.cfg_mapManager:TryGetValue(mapID)
        if mapTbl ~= nil then
            local nameMapTbl = mapTbl
            if mapTbl:GetRealMapId() ~= nil then
                local realMapTbl = clientTableManager.cfg_mapManager:TryGetValue(mapTbl:GetRealMapId())
                if realMapTbl ~= nil then
                    nameMapTbl = realMapTbl
                end
            end
            mapName = nameMapTbl:GetName()
            if mapTbl:GetConditionId() ~= nil and mapTbl:GetConditionId().list.Count > 0 then
                local targetConditionID
                isConfirmToCondition, targetConditionID = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionListAndReturnReason(mapTbl:GetConditionId().list)
                if isConfirmToCondition then
                    targetConditionID = mapTbl:GetConditionId().list[mapTbl:GetConditionId().list.Count - 1]
                end
                ---@type TABLE.CFG_CONDITIONS
                local conditionTblExist, conditionTbl = CS.Cfg_ConditionManager.Instance:TryGetValue(targetConditionID)
                if conditionTbl and conditionTbl.conditionParam ~= nil and conditionTbl.conditionParam.list.Count > 0 then
                    local param = conditionTbl.conditionParam.list[0]
                    if conditionTbl.conditionType == 1 then
                        ---等级
                        if isConfirmToCondition then
                            mapName = Utility.CombineStringQuickly(mapName, isShowGrayButton and "  " or "  [6B99A2]", param, "级[-]")
                        else
                            mapName = Utility.CombineStringQuickly(mapName, isShowGrayButton and "  " or "  [e85038]", param, "级[-]")
                        end
                    elseif conditionTbl.conditionType == 3 then
                        ---转生等级
                        if isConfirmToCondition then
                            mapName = Utility.CombineStringQuickly(mapName, isShowGrayButton and "  " or "  [6B99A2]", param, "转[-]")
                        else
                            mapName = Utility.CombineStringQuickly(mapName, isShowGrayButton and "  " or "  [e85038]", param, "转[-]")
                        end
                    end
                end
            end
        end
    end
    if isShowGrayButton then
        self:GetButtonBGSprite().spriteName = "bo2"
    else
        self:GetButtonBGSprite().spriteName = "bo1"
    end
    if mapName == nil then
        self:GetButtonNameLabel().text = ""
    else
        if isShowGrayButton then
            self:GetButtonNameLabel().text = Utility.CombineStringQuickly("[727272]", mapName, "[-]")
        else
            self:GetButtonNameLabel().text = mapName
        end
    end
    ---怪物数量
    if isShowGrayButton then
        self:GetButtonNumberLabel().text = Utility.CombineStringQuickly("[727272]", lastAmount == nil and "" or tostring(lastAmount), "个[-]")
    else
        if lastAmount ~= nil and lastAmount > 0 then
            self:GetButtonNumberLabel().text = Utility.CombineStringQuickly("[00ff00]", tostring(lastAmount), "个")
        else
            lastAmount = 0
            self:GetButtonNumberLabel().text = Utility.CombineStringQuickly(tostring(lastAmount), "个")
        end
    end
    self:RefreshDropItems(bairimenActivityTbl)
end

---@param bairimenActivityTbl TABLE.cfg_bairimen_activity
function UIBrmCrystalTemplate_Cell:RefreshDropItems(bairimenActivityTbl)
    if bairimenActivityTbl == nil then
        self:GetDropItems().MaxCount = 0
        return
    end
    local gatherID = bairimenActivityTbl:GetMonsterId()
    if gatherID == nil or gatherID == 0 then
        self:GetDropItems().MaxCount = 0
        return
    end
    ---@type TABLE.CFG_GATHER
    local gatherTblExist, gatherTbl = CS.Cfg_GatherTableManager.Instance:TryGetValue(gatherID)
    if gatherTbl == nil then
        return
    end
    local itemList = Utility.GetBossPanelDropListBySingleBossDropShowID(gatherTbl.gatherShow)
    if itemList == nil then
        return
    end
    local amount = #itemList
    self:GetDropItems().MaxCount = amount
    if amount > 0 then
        for i = 1, amount do
            local go = self:GetDropItems().controlList[i - 1]
            local itemID = itemList[i]
            local itemTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(itemID)
            ---@type UISprite
            local sprite = self:GetCurComp(go, "icon", "UISprite")
            if sprite and itemTbl then
                sprite.spriteName = itemTbl.icon
            end
            CS.UIEventListener.Get(go).onClick = function()
                self:OnDropItemClicked(itemTbl)
            end
        end
    end
end

---掉落物品点击事件
---@private
---@param itemTbl TABLE.CFG_ITEMS
function UIBrmCrystalTemplate_Cell:OnDropItemClicked(itemTbl)
    uiStaticParameter.UIItemInfoManager:CreatePanel({
        itemInfo = itemTbl,
        showRight = false
    })
end

function UIBrmCrystalTemplate_Cell:ResetUI()
    self:GetBackgroundUIEffect():ChangeEffect("")
    self:GetModelUISprite().spriteName = ""
    self:GetNameUISprite().spriteName = ""
    self:GetButtonNameLabel().text = ""
    self:GetButtonNumberLabel().text = ""
    self:GetDropItems().MaxCount = 0
end

return UIBrmCrystalTemplate_Cell