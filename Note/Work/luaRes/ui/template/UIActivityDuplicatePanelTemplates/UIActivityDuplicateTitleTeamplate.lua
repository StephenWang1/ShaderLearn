local UIActivityDuplicateTitleTeamplate = {}
function UIActivityDuplicateTitleTeamplate:Init()
    self:InitConpoment()
end

function UIActivityDuplicateTitleTeamplate:InitConpoment()
    self.title_UILabel = self:Get("","UILabel")
    self.content_UILabel = self:Get("label","UILabel")
end

function UIActivityDuplicateTitleTeamplate:Refresh(commonData)
    self.titleName = ternary(commonData.titleName == nil,"",commonData.titleName)
    self.content = ternary(commonData.content == nil,"",commonData.content)
    self:RefreshTitle()
    self:RefreshContent()
end

function UIActivityDuplicateTitleTeamplate:RefreshTitle()
    if self.title_UILabel ~= nil then
        self.title_UILabel.text = self.titleName
    end
end

function UIActivityDuplicateTitleTeamplate:RefreshContent()
    if self.content_UILabel ~= nil then
        self.content_UILabel.text = self.content
    end
end
return UIActivityDuplicateTitleTeamplate