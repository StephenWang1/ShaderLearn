---@class UIGuildVoiceBaseTemplate:UIVoiceBaseTemplate
local UIGuildVoiceBaseTemplate = {}

setmetatable(UIGuildVoiceBaseTemplate, luaComponentTemplates.UIVoiceBaseTemplate)

---获取频道类型
function UIGuildVoiceBaseTemplate:GetChannelType()
    return luaEnumChatChannelType.UNION
end

return UIGuildVoiceBaseTemplate