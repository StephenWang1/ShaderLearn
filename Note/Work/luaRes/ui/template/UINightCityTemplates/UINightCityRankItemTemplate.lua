local UINightCityRankItemTemplate = {}



function UINightCityRankItemTemplate:Init()
    ---@type Top_UILabel
    self.Number = self:Get("Number", "Top_UILabel")
    ---@type Top_UILabel
    self.Name = self:Get("Name", "Top_UILabel")
    ---@type Top_UILabel
    self.Level = self:Get("Level", "Top_UILabel")
    ---@type Top_UILabel
    self.Career = self:Get("Career", "Top_UILabel")
    ---@type Top_UILabel
    self.Score = self:Get("Score", "Top_UILabel")
    ---@type Top_UIGridContainer
    self.Awards = self:Get("Awards", "Top_UIGridContainer")
    ---@type Top_UISprite
    self.NumberSp = self:Get("NumberSp", "Top_UISprite")
end

---刷新UI
function UINightCityRankItemTemplate:RefreshUI(data, ranking)
    if data == nil then
        return
    end
    self.Name.text = data.name
    self.Level.text = data.lv
    self.Career.text = UINightCityRankItemTemplate.Setcareer(data.career)
    self.Score.text = data.score
    self:SetRanking(ranking)
    self:SetAward(ranking)

end

function UINightCityRankItemTemplate.Setcareer(data)
    if data == LuaEnumCareer.Common then
        return '通用'
    elseif data == LuaEnumCareer.Master then
        return '法师'
    elseif data == LuaEnumCareer.Taoist then
        return '道士'
    elseif data == LuaEnumCareer.Warrior then
        return '战士'
    end
end

function UINightCityRankItemTemplate:SetRanking(ranking)

    if ranking <= 3 then
        self.NumberSp.spriteName = 'rank' .. ranking
        self.Number.gameObject:SetActive(false);
        self.NumberSp.gameObject:SetActive(true);
    else
        self.Number.text = ranking
        self.NumberSp.gameObject:SetActive(false);
        self.Number.gameObject:SetActive(true);
    end

end

---设置奖励
function UINightCityRankItemTemplate:SetAward(rank)
    if rank > 10 then
        rank = 0
    end
    local data = CS.Cfg_LadderRankRewardManager.Instance:GetRandAward('激情夜战', rank)
    if data ~= nil then
        self.Awards.MaxCount = data.list.Count
        local index = 0
        for k, v in pairs(data.list) do
            local item = self.Awards.controlList[index]
            local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UINightCityItemTemplate)
            template:RefreshUI(v)
            index = index + 1
        end
    end

end

return UINightCityRankItemTemplate