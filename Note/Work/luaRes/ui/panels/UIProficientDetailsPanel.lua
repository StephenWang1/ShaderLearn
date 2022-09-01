---@class UIProficientDetailsPanel 专精技能详情
local UIProficientDetailsPanel = {}

---@type LuaProficientItem
UIProficientDetailsPanel.ProficientItem = nil
---当前专精ID
---@type number
UIProficientDetailsPanel.ID = nil
---当前专精等级
---@type number
UIProficientDetailsPanel.Level = nil

---@type TABLE.cfg_equip_proficient
UIProficientDetailsPanel.NowLevelProficientTbl = nil

---@type TABLE.cfg_equip_proficient
UIProficientDetailsPanel.NextLevelProficientTbl = nil

function UIProficientDetailsPanel:GetSkillIcon()
    if (self.mGetSkillIcon == nil) then
        self.mGetSkillIcon = self:GetCurComp("root/skillIcon", "Top_UISprite")
    end
    return self.mGetSkillIcon
end

function UIProficientDetailsPanel:GetSkillName()
    if (self.mGetSkillName == nil) then
        self.mGetSkillName = self:GetCurComp("root/skillName", "Top_UILabel")
    end
    return self.mGetSkillName
end

function UIProficientDetailsPanel:GetCurrentSkillRoot()
    if (self.mGetCurrentSkillRoot == nil) then
        self.mGetCurrentSkillRoot = self:GetCurComp("root/skillInfo/tableRoot/currentSkill", "GameObject")
    end
    return self.mGetCurrentSkillRoot
end

function UIProficientDetailsPanel:GetNextSkillRoot()
    if (self.mGetNextSkillRoot == nil) then
        self.mGetNextSkillRoot = self:GetCurComp("root/skillInfo/tableRoot/nextSkill", "GameObject")
    end
    return self.mGetNextSkillRoot
end

function UIProficientDetailsPanel:GetSkillDescTable()
    if (self.mGetSkillDescTable == nil) then
        self.mGetSkillDescTable = self:GetCurComp("root/skillInfo/tableRoot", "Top_UITable")
    end
    return self.mGetSkillDescTable
end

function UIProficientDetailsPanel:GetSkillDescWidget()
    if (self.mGetSkillDescWidget == nil) then
        self.mGetSkillDescWidget = self:GetCurComp("root/skillInfo/UIAdapt", "Top_UIWidget")
    end
    return self.mGetSkillDescWidget
end

---得到获取途径
function UIProficientDetailsPanel:GetGetWay()
    if (self.mGetGetWay == nil) then
        self.mGetGetWay = self:GetCurComp("root/skillInfo/tableRoot/GetWay", "GameObject")
    end
    return self.mGetGetWay
end

---得到获取途径
function UIProficientDetailsPanel:GetGetWayGridContainer()
    if (self.mGetGetWayGridContainer == nil) then
        self.mGetGetWayGridContainer = self:GetCurComp("root/skillInfo/tableRoot/GetWay/itemGrid", "Top_UIGridContainer")
    end
    return self.mGetGetWayGridContainer
end

function UIProficientDetailsPanel:GetMask()
    if (self.mGetMask == nil) then
        self.mGetMask = self:GetCurComp("mask", "GameObject")
    end
    return self.mGetMask
end

---面板根节点
function UIProficientDetailsPanel:GetRootObj()
    if (self.mRootObj == nil) then
        self.mRootObj = self:GetCurComp("root", "GameObject")
    end
    return self.mRootObj
end

---背景图片
function UIProficientDetailsPanel:GetBGSprite()
    if (self.mBGSprite == nil) then
        self.mBGSprite = self:GetCurComp("root/bg", "Top_UISprite")
    end
    return self.mBGSprite
end

function UIProficientDetailsPanel:Init()
    CS.UIEventListener.Get(self:GetMask().gameObject).onClick = function()
        uimanager:ClosePanel("UIProficientDetailsPanel");
    end
    if self:GetRootObj() ~= nil then
        ---初次显示先移除视野外
        self:GetRootObj().transform.localPosition = { x = 10000, y = 10000, z = 0 }
    end
end

---更新详细数据
---@param data LuaProficientItem
---@param otherData table
---@field otherData.posInfo table 坐标信息
function UIProficientDetailsPanel:UpdateData(ScollViewPos, data, otherData)
    self.ProficientItem = data

    self:UpdateSkillInfo()
    self:UpdateNowLevelInfo()
    self:UpdateNextLevelInfo()
    self:UpdateGetWay()

    self:GetSkillDescTable():Reposition()
    self:GetSkillDescWidget():ReCalculateRelativeWidgetBounds(self:GetSkillDescTable().transform, true);
    if otherData then
        self.updateItem = CS.CSListUpdateMgr.Add(300, nil, function()
            if self.go == nil or CS.StaticUtility.IsNull(self.go) then
                return
            end
            self:SetRootPos(otherData.posInfo)
        end)

    end
end

--region 刷新当前技能信息
function UIProficientDetailsPanel:UpdateSkillInfo()
    local tbl = self.ProficientItem.tbl ~= nil and self.ProficientItem.tbl or self.ProficientItem.nextTbl

    self:GetSkillIcon().spriteName = tbl:GetIcon()
    self:GetSkillName().text = tbl:GetName()
end
--endregion

--region 刷新当前等级以及下一级的信息(PS:里面没有什么东西  就不写模板了,直接定义2个小方法处理掉了)

function UIProficientDetailsPanel:UpdateNowLevelInfo()
    self:UpdateLevelInfo(1, self:GetCurrentSkillRoot(), self.ProficientItem.tbl);
end

function UIProficientDetailsPanel:UpdateNextLevelInfo()
    self:UpdateLevelInfo(2, self:GetNextSkillRoot(), self.ProficientItem.nextTbl)
end

---@param root GameObject 组件的节点
---@param type number 类型1就是当前等级
---@param tbl TABLE.cfg_equip_proficient 表格
function UIProficientDetailsPanel:UpdateLevelInfo(type, root, tbl)
    local levelDescLabel = CS.Utility_Lua.GetComponent(root.transform:Find("skillLevel"), "Top_UILabel")
    local infoDescLabel = CS.Utility_Lua.GetComponent(root.transform:Find("skillDescription"), "Top_UILabel")
    local upgradeRequire = CS.Utility_Lua.GetComponent(root.transform:Find("upgradeRequire"), "GameObject")

    if (upgradeRequire ~= nil) then
        upgradeRequire:SetActive(false)
    end
    if (tbl ~= nil) then
        root:SetActive(true)
        if (type == 1) then
            levelDescLabel.text = "[878787]当前等级 " .. tostring(tbl:GetLevel()) .. "级"
            infoDescLabel.text = CS.Utility_Lua.ReplaceSpecialCharToColor(tbl:GetTips(), "[ffe36f]");
        else
            levelDescLabel.text = "[878787]下一等级 " .. tostring(tbl:GetLevel()) .. "级"
            infoDescLabel.text = CS.Utility_Lua.ReplaceSpecialCharToColor(tbl:GetTips(), "[00ff00]");
        end
    else
        root:SetActive(false)
    end
end
--endregion

--region 刷新获取途径

UIProficientDetailsPanel.UIWayGetUnitTemplateList = nil

function UIProficientDetailsPanel:UpdateGetWay()
    if (self.ProficientItem.nextTbl == nil) then
        self:GetGetWay():SetActive(false)
        return
    end
    ---目前只有一個材料,先赶时间处理一下
    local materialItem = self.ProficientItem.nextTbl:GetCost().list[1].list[1]

    if (self.UIWayGetUnitTemplateList == nil) then
        self.UIWayGetUnitTemplateList = {}
    end

    local data = self:GetWayIdList(materialItem)

    self:GetGetWay():SetActive(#data > 0)
    self:GetGetWayGridContainer().MaxCount = #data;
    for i = 1, #data do
        local obj = self:GetGetWayGridContainer().controlList[i - 1];
        if (self.UIWayGetUnitTemplateList[obj] == nil) then
            self.UIWayGetUnitTemplateList[obj] = templatemanager.GetNewTemplate(obj, luaComponentTemplates.UIWayGetUnitTemplate);
        end
        ---@type UIWayGetUnitTemplate
        local temp = self.UIWayGetUnitTemplateList[obj]
        temp:UpdateUnit(data[i]);
    end
end
--endregion

---得到获取途径ID列表
function UIProficientDetailsPanel:GetWayIdList(itemId)
    local list = {}
    ---@type TABLE.cfg_items
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil or itemTbl:GetWayGet() == nil or itemTbl:GetWayGet().list.Count == 0 then
        return list
    end

    for i = 0, itemTbl:GetWayGet().list.Count - 1 do
        local isfind, wayGetInfoTemp = CS.Cfg_Way_GetTableManager.Instance:TryGetValue(itemTbl:GetWayGet().list[i])
        if isfind and wayGetInfoTemp.openType ~= 3 and wayGetInfoTemp.openType ~= 8 then
            if (wayGetInfoTemp.conditions ~= nil and wayGetInfoTemp.conditions.list.Count > 0) then
                if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(wayGetInfoTemp.conditions.list)) then
                    table.insert(list, itemTbl:GetWayGet().list[i])
                end
            else
                table.insert(list, itemTbl:GetWayGet().list[i])
            end
        end
    end
    return list
end

--endregion

---@param posInfo
---@field posInfo.heightPos UnityEngine.Vector3
---@field posInfo.lowPos   UnityEngine.Vector3
function UIProficientDetailsPanel:SetRootPos(posInfo)
    if self:GetRootObj() == nil then
        return
    end
    if posInfo == nil or posInfo.lowPos == nil or posInfo.heightPos == nil then
        return
    end
    --最高点y
    local heightLocalPosy = 332
    --最低点y
    local lowLocalPointy = -314

    local bgHeight = self:GetBGSprite().height
    local bgWidth = self:GetBGSprite().width

    self:GetRootObj().transform.position = posInfo.heightPos
    local tipsHeightLocalpos = self:GetRootObj().transform.localPosition
    local meetHeightPoint = tipsHeightLocalpos.y

    --[[    self:GetRootObj().transform.position = posInfo.lowPos
        local tipsLocalLowpos = self:GetRootObj().transform.localPosition
        local meetLowPoint = tipsLocalLowpos.y]]
    ---判断是否超过最高点
    local y = meetHeightPoint >= heightLocalPosy and heightLocalPosy or
            ---判断是否低于最低点
            meetHeightPoint - bgHeight >= lowLocalPointy and meetHeightPoint or lowLocalPointy + bgHeight
    --meetLowPoint >= lowLocalPointy and meetLowPoint + bgHeight or lowLocalPointy + bgHeight
    local targetLocalPos = CS.UnityEngine.Vector3(tipsHeightLocalpos.x, y, 0)
    self:GetRootObj().transform.localPosition = targetLocalPos
end

function UIProficientDetailsPanel:OnDestroy()
    if self.updateItem ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.updateItem)
        self.updateItem = nil
    end
end

function ondestroy()
    UIProficientDetailsPanel:OnDestroy()
end

return UIProficientDetailsPanel