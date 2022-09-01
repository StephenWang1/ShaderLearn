local UIIndividEscortChoosePanel_DartCarGrid = {}
--region 初始化
function UIIndividEscortChoosePanel_DartCarGrid:Init()
    self:InitComponent()
end

function UIIndividEscortChoosePanel_DartCarGrid:InitComponent()
    self.icon_UISprite = self:Get("icon","UISprite")
    --self.level_UISprite = self:Get("level","UISprite")
    self.name_UISprite = self:Get("name","UISprite")
    self.attribute_UILabel = self:Get("state","UILabel")
end
--endregion

--region 刷新
function UIIndividEscortChoosePanel_DartCarGrid:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        self:RefreshNoParamsState()
        return
    end
    self:RefreshHaveParamsState()
end

function UIIndividEscortChoosePanel_DartCarGrid:AnalysisParams(commonData)
    if commonData ~= nil and commonData.yabiaoTable ~= nil then
        self.yabiaoTable = commonData.yabiaoTable
        self.index = commonData.index
        local monsterTableIsFind,monsterTable = CS.Cfg_MonsterTableManager.Instance:TryGetValue(self.yabiaoTable.mid)
        if monsterTableIsFind then
            self.monsterTable = monsterTable
        end
        return true
    end
    return false
end

function UIIndividEscortChoosePanel_DartCarGrid:RefreshNoParamsState()
    if self.icon_UISprite ~= nil then
        self.icon_UISprite.spriteName = ""
    end
    --if self.level_UISprite ~= nil then
    --    self.level_UISprite.text = ""
    --end
    if self.name_UISprite ~= nil then
        self.name_UISprite.text = ""
    end
    if self.attribute_UILabel ~= nil then
        self.attribute_UILabel.text = ""
    end
end

function UIIndividEscortChoosePanel_DartCarGrid:RefreshHaveParamsState()
    if self.yabiaoTable ~= nil then
        if self.icon_UISprite ~= nil then
            self.icon_UISprite.spriteName = self.yabiaoTable.picture
        end
        --if self.level_UISprite ~= nil then
        --    self.level_UISprite.spriteName = self.yabiaoTable.dartLvPicture
        --end
        if self.name_UISprite ~= nil and self.monsterTable ~= nil then
            self.name_UISprite.spriteName = self.yabiaoTable.typePicture
        end
        if self.attribute_UILabel ~= nil then
            self.attribute_UILabel.text = "血量" .. self.yabiaoTable.dartHP
        end
    end
end
--endregion
return UIIndividEscortChoosePanel_DartCarGrid