---@class UIFurnaceSpecialAttributesUnitTemplate:TemplateBase
local UIFurnaceSpecialAttributesUnitTemplate = {};

UIFurnaceSpecialAttributesUnitTemplate.mOwnerPanel = nil;

---@type number
UIFurnaceSpecialAttributesUnitTemplate.mFurnaceId = nil;

---@type LuaEnumFurnaceOpenType
UIFurnaceSpecialAttributesUnitTemplate.mFurnaceType = nil;

UIFurnaceSpecialAttributesUnitTemplate.mIndex = nil;

UIFurnaceSpecialAttributesUnitTemplate.mCurFurnaceTbl = nil;

---@type TABLE.cfg_godfurnace
UIFurnaceSpecialAttributesUnitTemplate.mCurFurnaceTbl = nil;
---@type TABLE.cfg_godfurnace
UIFurnaceSpecialAttributesUnitTemplate.mTargetFurnaceTbl = nil;


function UIFurnaceSpecialAttributesUnitTemplate:GetIcon_UISprite()
    if(self.mIcon_UISprite == nil) then
        self.mIcon_UISprite = self:Get("icon","UISprite");
    end
    return self.mIcon_UISprite;
end

--function UIFurnaceSpecialAttributesUnitTemplate:GetLevel_UISprite()
--    if(self.mLevel_UISprite == nil) then
--        self.mLevel_UISprite = self:Get("level","UISprite");
--    end
--    return self.mLevel_UISprite;
--end

function UIFurnaceSpecialAttributesUnitTemplate:GetArrow_UISprite()
    if(self.mArrow_UISprite == nil) then
        self.mArrow_UISprite = self:Get("arrow","UISprite");
    end
    return self.mArrow_UISprite;
end

function UIFurnaceSpecialAttributesUnitTemplate:GetLevel_Text()
    if(self.mLevel_Text == nil) then
        self.mLevel_Text = self:Get("level","UILabel");
    end
    return self.mLevel_Text;
end

---@return boolean
function UIFurnaceSpecialAttributesUnitTemplate:IsActive()
    if(self.mCurFurnaceTbl ~= nil and self.mTargetFurnaceTbl ~= nil) then
        return self.mCurFurnaceTbl:GetLv() >= self.mTargetFurnaceTbl:GetLv();
    end
    return false;
end

function UIFurnaceSpecialAttributesUnitTemplate:UpdateUnit(curFurnaceId, furnaceId, index, furnaceType, isEnd, callBack)
    self.mCurFurnaceId = curFurnaceId;
    self.mFurnaceId = furnaceId;
    self.mFurnaceType = furnaceType;
    self.mCallBack = callBack;
    self.mIsEnd = isEnd;
    self.mIndex = index;
    self.mCurFurnaceTbl = clientTableManager.cfg_godfurnaceManager:TryGetValue(self.mCurFurnaceId);
    self.mTargetFurnaceTbl = clientTableManager.cfg_godfurnaceManager:TryGetValue(self.mFurnaceId);

    self:UpdateUI();
end

function UIFurnaceSpecialAttributesUnitTemplate:UpdateUI()
    self:GetArrow_UISprite().gameObject:SetActive(not self.mIsEnd);
    local isActive = self:IsActive();
    --默认显示亮的图标
    self:GetIcon_UISprite().spriteName = self:GetIconSpriteName(self.mFurnaceType, self.mIndex,true);
    if(self.mTargetFurnaceTbl ~= nil) then
        local colorStr = isActive and "[388AE7]" or "[e85038]";
        self:GetLevel_Text().text = colorStr..self.mTargetFurnaceTbl:GetLv().."级[-]";
    end
    self:GetArrow_UISprite().spriteName = "FurnaceAttribute_arrow"..(isActive and "_1" or "_2");
end


function UIFurnaceSpecialAttributesUnitTemplate:GetIconSpriteName(furnaceType, index, isActive)
    local type = 1;
    if(furnaceType == LuaEnumFurnaceOpenType.ChyanLamp) then
        type = 1;
    elseif(furnaceType == LuaEnumFurnaceOpenType.SoulBead) then
        type = 2;
    elseif(furnaceType == LuaEnumFurnaceOpenType.Gem) then
        type = 3;
    end
    index = index == nil and 1 or index;
    local activeType = isActive and 1 or 2;
    return "FurnaceAttribute_"..type.."_"..activeType.."_"..index;
end

function UIFurnaceSpecialAttributesUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        if(self.mCallBack ~= nil) then
            self.mCallBack(self);
        end
    end
end

function UIFurnaceSpecialAttributesUnitTemplate:Init(panel)
    self.mOwnerPanel = panel;
    self:InitEvents();
end

return UIFurnaceSpecialAttributesUnitTemplate;