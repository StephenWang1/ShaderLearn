---@class UISkillShortcutConfigTemplate
local UISkillShortcutConfigTemplate = {}

function UISkillShortcutConfigTemplate:ShortcutIcon()
    if self.mShortcutIcon == nil then
        self.mShortcutIcon = self:Get('Icon', 'UISprite')
    end
    return self.mShortcutIcon
end

function UISkillShortcutConfigTemplate:ShortcutItemIcon()
    if self.mShortcutItemIcon == nil then
        self.mShortcutItemIcon = self:Get('Icon/itemicon', 'UISprite')
    end
    return self.mShortcutItemIcon
end

function UISkillShortcutConfigTemplate:GetIntensifySkillIcon()
    if self.mIntensifySkillIcon == nil then
        self.mIntensifySkillIcon = self:Get('intensifySkillIcon', 'UISprite')
    end
    return self.mIntensifySkillIcon
end

function UISkillShortcutConfigTemplate:Choose_GameObject()
    if self.mChoose_GameObject == nil then
        self.mChoose_GameObject = self:Get('choose', 'GameObject')
    end
    return self.mChoose_GameObject
end

function UISkillShortcutConfigTemplate:ID()
    return self.id
end

function UISkillShortcutConfigTemplate:KEY()
    return self.key
end

UISkillShortcutConfigTemplate.mIsFilled = false
function UISkillShortcutConfigTemplate.IsFilled()
    UISkillShortcutConfigTemplate:DisplayIcon(UISkillShortcutConfigTemplate.mIsFilled);
    return UISkillShortcutConfigTemplate.mIsFilled
end
function UISkillShortcutConfigTemplate:Key_int()
    if self:Key() then
        UISkillShortcutConfigTemplate.mKey = self:Key().text
    else
        UISkillShortcutConfigTemplate.mKey = -1
    end

    return UISkillShortcutConfigTemplate.mKey;
end
function UISkillShortcutConfigTemplate:Key_UILabel()
    if self.mkeyUILabel == nil then
        self.mkeyUILabel = self:Get('key', 'UILabel')
    end
    return self.mkeyUILabel
end

function UISkillShortcutConfigTemplate:Init()
    self.id = 0
    self.IsShortcutProp = false;
end

function UISkillShortcutConfigTemplate:RefreshID(id)
    self.id = id
    --local isFind, skillTable = CS.Cfg_SkillTableManager.Instance:TryGetValue(self.id)
    self:ShortcutIcon().gameObject:SetActive(self.id ~= 0);
    self:RefreshIntensifySkillIcon(id)
end
function UISkillShortcutConfigTemplate:SetShortcutProp(isOpen)
    self.IsShortcutProp = isOpen
end

function UISkillShortcutConfigTemplate:RefreshUI(id, key)
    self.id = id
    self.key = key
    if id == 0 then
        self:ShortcutIcon().gameObject:SetActive(false)
    else
        self:ShortcutIcon().gameObject:SetActive(true)
        local tableInfo = CS.Cfg_SkillTableManager.Instance[id]
        if tableInfo == nil then
            tableInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(id)
            if tableInfo ~= nil then
                self:ShortcutIcon().spriteName = tableInfo.icon
                self:ShortcutItemIcon().spriteName = tableInfo.icon
            end
        else
            self:ShortcutIcon().spriteName = tableInfo.icon
            self:ShortcutItemIcon().spriteName = tableInfo.icon
        end
    end
    self:RefreshIntensifySkillIcon(id)
end

---刷新强化技能Icon
function UISkillShortcutConfigTemplate:RefreshIntensifySkillIcon(skillID)
    if  self:GetIntensifySkillIcon()==nil then
        return
    end
    if skillID == 0 then
        self:GetIntensifySkillIcon().gameObject:SetActive(false)
        return
    end
    ---@type table<number,LuaSkillDetailedInfo>
    self.SkillInfoDic = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr().SkillInfoDic
    if self.SkillInfoDic ~= nil then
        ---@type LuaSkillDetailedInfo
        self.NowSkillInfo = self.SkillInfoDic[skillID]
    end
    if self.SkillInfoDic == nil or self.NowSkillInfo == nil then
        self:GetIntensifySkillIcon().gameObject:SetActive(false)
        return
    end
    local IntensifySkillInfo = self.NowSkillInfo:GetIntensifySkillInfo()
    self:GetIntensifySkillIcon().gameObject:SetActive(IntensifySkillInfo ~= nil)
    if IntensifySkillInfo ~= nil and IntensifySkillInfo:GetSkillTable() ~= nil then
        self:GetIntensifySkillIcon().spriteName = IntensifySkillInfo:GetSkillTable():GetIcon2()
    end
end

function UISkillShortcutConfigTemplate:DisplayIcon(value)
    if self:ShortcutIcon() ~= nil then
        self:ShortcutIcon().gameObject:SetActive(value);
    end
end

function UISkillShortcutConfigTemplate:RefreshChoose(lastChoose)
    if lastChoose ~= nil then
        lastChoose:Choose_GameObject():SetActive(false)
    end
    if self:Choose_GameObject() ~= nil and not CS.StaticUtility.IsNull(self:Choose_GameObject()) then
        self:Choose_GameObject():SetActive(true)
    end
    return self
end

return UISkillShortcutConfigTemplate