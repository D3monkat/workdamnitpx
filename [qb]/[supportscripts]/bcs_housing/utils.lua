function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function GetTargetScript()
  if IsResourceStarted(Config.exportname.ox_target) then
    return Config.exportname.ox_target
  elseif IsResourceStarted(Config.exportname.qtarget) then
    return Config.exportname.qtarget
  elseif IsResourceStarted(Config.exportname.qbtarget) then
    return Config.exportname.qbtarget
  end 
end

function IsResourceStarted(resource)
  return GetResourceState(resource) == 'started'
end
