---GM工具分面板-网络日志面板
---分为3块:
---1.检索模块
---2.左侧消息列表
---3.右侧消息详情
local UIGMPanel_NetLog = {}


--region 初始化
function UIGMPanel_NetLog:Init(panel)
end


function UIGMPanel_NetLog:Show(pos)
    self.go:SetActive(true)
end

function UIGMPanel_NetLog:Hide()
    self.go:SetActive(false)
end


return UIGMPanel_NetLog