---GM工具分面板-客户端日志面板
---分为3块:
---1.检索模块
---2.左侧消息列表
---3.右侧消息详情
local UIGMPanel_Client = {}


--region 初始化
function UIGMPanel_Client:Init(panel)
end


function UIGMPanel_Client:Show(pos)
    self.go:SetActive(true)
end

function UIGMPanel_Client:Hide()
    self.go:SetActive(false)
end


return UIGMPanel_Client