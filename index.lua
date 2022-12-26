print(WrapTextInColorCode("HideStanceBar успешно загружен.", "FF00FF1E"));
print("Что бы узнать как настроить аддон введите комманду " .. WrapTextInColorCode("/sbar info", "FFFF0000"));
SLASH_SBAR1 = '/sbar';

local InVisibleParent = CreateFrame("Frame");

function IsEmpty(value)
  return value == nil or value == '';
end

function OnEvent(__, event, ...)
  if (event == "PLAYER_ENTERING_WORLD") then
    -- Если аддон еще не настраивался через команду /sbar то ничего не делаем
    -- IsHided глобальня переменая в которой true если включено скрытие панели для персонажа
    -- иначе false
    -- для каждого персонажа своё значение
    if IsEmpty(IsHided) then
      ShowStanceBar();
      return;
    else
      HideStanceBar();
    end
  end
end

function HideStanceBar()
  InVisibleParent:Hide();
  InVisibleParent:UnregisterAllEvents();
  -- StanceBar глобальня переменая типа Frame. 
  -- В ней ссылка на панель со стойками вара или формами друида.
  StanceBar:SetParent(InVisibleParent);
  -- StanceBar:Hide();
  IsHided = true;
end

function ShowStanceBar()
  StanceBar:SetParent(UIParent);
  IsHided = nil;
  -- StanceBar:Show();
end

function SlashCmdList.SBAR(message)
  local trimCommand = message:match "^%s*(.-)%s*$";

  if trimCommand == "info" then
    print("Доступны следующие комманды:")
    print("Для того чтобы скрыть панель стоек введите " .. WrapTextInColorCode("/sbar hide", "ffffff00"));
    print("Для того чтобы скрыть панель стоек введите " .. WrapTextInColorCode("/sbar show", "ffffff00"));
  end

  if trimCommand == "hide" then
    HideStanceBar();
  end

  if trimCommand == "show" then
    ShowStanceBar();
  end
end

InVisibleParent:SetScript("OnEvent", OnEvent);

--Регистрация событий
InVisibleParent:RegisterEvent("PLAYER_ENTERING_WORLD");
