local UISanctuaryPanel_DuplicateList = {}
---最大显示数量
UISanctuaryPanel_DuplicateList.maxShow = 4

--region 初始化
function UISanctuaryPanel_DuplicateList:Init()
    self:InitComponent()
    self:InitParams()
end

function UISanctuaryPanel_DuplicateList:InitComponent()
    self.openListBtn_GameObject = self:Get("btn_add","GameObject")
    self.duplicateList_GameObject = self:Get("Location","GameObject")
    self.bg_UISprite = self:Get("Location/bg","UISprite")
    self.grid_UIGridContainer = self:Get("Location/LocationList/Grid","UIGridContainer")
    self.choose_UILabel = self:Get("label","UILabel")
end

function UISanctuaryPanel_DuplicateList:InitParams()
    self.gridHigh = self.grid_UIGridContainer.CellHeight
    self.gridTemplateTable = {}
end
--endregion

--region 刷新
function UISanctuaryPanel_DuplicateList:Refresh(commonData)
    self.duplicateInfoList = commonData.duplicateInfoList
    self.UISanctuaryPanel = commonData.UISanctuaryPanel
    self:RefreshPanel()
end

function UISanctuaryPanel_DuplicateList:RefreshPanel()
    self:ChangeBg()
    self:RefreshDuplicateList()
    self:RefreshNowDuplicateInfoByList(self.duplicateInfoList)
end

function UISanctuaryPanel_DuplicateList:ChangeBg()
    if self.duplicateInfoList ~= nil and self.duplicateInfoList.Count < 4 then
        local bgHigh = self.duplicateInfoList.Count * self.gridHigh
        self.bg_UISprite:SetDimensions(self.bg_UISprite.width,bgHigh)
    end
end

function UISanctuaryPanel_DuplicateList:RefreshDuplicateList()
    self.index = self.duplicateInfoList.Count
    if self.grid_UIGridContainer ~= nil and self.duplicateInfoList ~= nil then
        self.grid_UIGridContainer.MaxCount = self.duplicateInfoList.Count
        self.delayRefresh = CS.CSListUpdateMgr.Add(200,nil,function()
            --print("刷新圣域空间")
            if self.duplicateInfoList ~= nil and self.index > 0 then
                local grid_GameObject = self.grid_UIGridContainer.controlList[self.index - 1]
                local duplicate = self.duplicateInfoList[self.index - 1]
                local grid_Temolate = templatemanager.GetNewTemplate(grid_GameObject, luaComponentTemplates.UISanctuaryPanel_Grid)
                if grid_Temolate ~= nil then
                    table.insert(self.gridTemplateTable,grid_Temolate)
                    grid_Temolate:RefreshGrid({duplicateInfo = duplicate,onClick = function(gridTemplate)
                        self:RefreshNowDuplicateInfo(gridTemplate.duplicateInfo)
                        self.UISanctuaryPanel:ChangeDuplicateListState()
                    end})
                end
            else
                if self.delayRefresh ~= nil then
                    CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
                    self.delayRefresh = nil
                end
            end
            self.index = self.index - 1
        end,true)
    end
end

function UISanctuaryPanel_DuplicateList:RefreshNowDuplicateInfoByList(duplicateInfoList)
    local extraShowLayer = CS.CSScene.MainPlayerInfo.SanctuaryInfo.ExtraShowDuplicateLayerNum
    if duplicateInfoList ~= nil and duplicateInfoList.Count > extraShowLayer then
        self:RefreshNowDuplicateInfo(duplicateInfoList[duplicateInfoList.Count - 1 - extraShowLayer])
    else
        if self.choose_UILabel ~= nil then
            self:RefreshNowDuplicateInfo(duplicateInfoList[0])
        end
    end
end

function UISanctuaryPanel_DuplicateList:RefreshNowDuplicateInfo(duplicateInfo)
    if duplicateInfo ~= nil then
        self.curDuplicateInfo = duplicateInfo
        local duplicateNameColor = ternary(CS.CSScene.MainPlayerInfo.SanctuaryInfo:CheckSanctuaryIsCanEnter(duplicateInfo.id),"[00ff00]","[878787]")
        local prefixName = ""
        if duplicateInfo ~= nil and duplicateInfo.specialCondition ~= nil and duplicateInfo.specialCondition.list ~= nil and duplicateInfo.specialCondition.list.Count > 0 then
            prefixName = CS.Cfg_PrefixTableManager.Instance:GetPrefixName(duplicateInfo.specialCondition.list[0])
        end
        local text = duplicateNameColor .. duplicateInfo.name .. "[-][878787](" .. prefixName .. ")[-]"
        if self.choose_UILabel ~= nil then
            self.choose_UILabel.text = text
        end
    end
end

function UISanctuaryPanel_DuplicateList:OnDestroy()
    if self.delayRefresh ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
        self.delayRefresh = nil
    end
end
--endregion
return UISanctuaryPanel_DuplicateList