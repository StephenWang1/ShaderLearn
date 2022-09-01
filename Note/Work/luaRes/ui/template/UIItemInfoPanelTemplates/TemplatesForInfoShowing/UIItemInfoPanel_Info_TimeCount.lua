---@class UIItemInfoPanel_Info_TimeCount:UIItemInfoPanel_Info_Basic
local UIItemInfoPanel_Info_TimeCount = {}

setmetatable(UIItemInfoPanel_Info_TimeCount, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 组件
function UIItemInfoPanel_Info_TimeCount:GetTextLabel_UILabel()
    if self.mTextLabel_UILabel == nil then
        self.mTextLabel_UILabel = self:Get("Text", "UILabel")
    end
    return self.mTextLabel_UILabel
end
--endregion

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_TimeCount:RefreshWithInfo(commonData)
    if commonData.bagItemInfo.time == nil then
        return
    end
    local time = {}
    if self:GetTime(commonData.bagItemInfo.time) == true then
        time.Hour, time.Minute, time.Second = Utility.MillisecondToFormatTime(commonData.bagItemInfo.time - CS.CSServerTime.Instance.TotalMillisecond)
    else
        time.Day, time.Hour, time.Minute, time.Second = 0,0,0,0
    end
    time.Day = math.floor(time.Hour / 24)
    time.Hour = math.floor(time.Hour % 24)
    time.Minute = math.floor(time.Minute)
    time.Second = math.floor(time.Second)
    self:GetTextLabel_UILabel().text = commonData.itemInfo.tips2 ~= nil and  "剩余时间 ".."[00ff00]"..time.Day .. "天"..time.Hour.."小时"..time.Minute.."分"..time.Second.."秒[-]" .."\r\n"..commonData.itemInfo.tips2 or "剩余时间 ".."[00ff00]"..time.Day .. "天"..time.Hour.."小时"..time.Minute.."分"..time.Second.."秒"
    self.updateItem = CS.CSListUpdateMgr.Add(1000, nil, function()
        if CS.StaticUtility.IsNull(self:GetTextLabel_UILabel()) == true then
            CS.CSListUpdateMgr.Instance:Remove(self.updateItem)
            return
        end
        local remain = {}
        if self:GetTime(commonData.bagItemInfo.time) == true then
            remain.Hour, remain.Minute, remain.Second = Utility.MillisecondToFormatTime(commonData.bagItemInfo.time - CS.CSServerTime.Instance.TotalMillisecond)
        else
            remain.Day, remain.Hour, remain.Minute, remain.Second = 0,0,0,0
        end
        remain.Day = math.floor(remain.Hour / 24)
        remain.Hour = math.floor(remain.Hour % 24)
        remain.Minute = math.floor(remain.Minute)
        remain.Second = math.floor(remain.Second)
        self:GetTextLabel_UILabel().text = commonData.itemInfo.tips2 ~= nil and  "剩余时间 ".."[00ff00]"..remain.Day .. "天"..remain.Hour.."小时"..remain.Minute.."分"..remain.Second.."秒[-]" .."\r\n"..commonData.itemInfo.tips2 or "剩余时间 ".."[00ff00]"..remain.Day .. "天"..remain.Hour.."小时"..remain.Minute.."分"..remain.Second.."秒"
    end,true)
end

---查询当前时间
function UIItemInfoPanel_Info_TimeCount:GetTime(time)
    if time < CS.CSServerTime.Instance.TotalMillisecond then
        return false
    end
    return true
end

return UIItemInfoPanel_Info_TimeCount