
---------------------------------------------------------------
-- Notification about the gifts from CS
--------------------------------------------------------------- 
GameEvents.MinorGift.Add(function(iCS, iMajor, iData2, iData3, iFlags, bOpt1, bOpt2, sType)
    -- iFlags will always be 0 and bOpt2 will always be false
    print(string.format("CS %s gave a gift to %s of %i (amount or ID), %i (friendship boost), %s (if first met), %s (gift)", Players[iCS]:GetName(), Players[iMajor]:GetName(), iData2, iData3, (bOpt1 and "true" or "false"), sType))
    
    local pPlayer = Players[iMajor];
    local pMinor = Players[iCS];
    
    if pPlayer:IsHuman() then -- notification only needed, if human
    
        -- Info
        local strNameKey = pMinor:GetCivilizationShortDescriptionKey();
        local strShortDescKey = pMinor:GetCivilizationShortDescriptionKey();
        local strTitle = Locale.ConvertTextKey("{" .. strShortDescKey.. ":upper}");
        local strPersonalityKey = "";
        local strPersonalityText = "";
        local strPersonalityTT = "";
        local iPersonality = pMinor:GetPersonality();
        if (iPersonality == MinorCivPersonalityTypes.MINOR_CIV_PERSONALITY_FRIENDLY) then
            strPersonalityKey = "TXT_KEY_CITY_STATE_PERSONALITY_FRIENDLY"
        elseif (iPersonality == MinorCivPersonalityTypes.MINOR_CIV_PERSONALITY_NEUTRAL) then
            strPersonalityKey = "TXT_KEY_CITY_STATE_PERSONALITY_NEUTRAL"
        elseif (iPersonality == MinorCivPersonalityTypes.MINOR_CIV_PERSONALITY_HOSTILE) then
            strPersonalityKey = "TXT_KEY_CITY_STATE_PERSONALITY_HOSTILE"
        elseif (iPersonality == MinorCivPersonalityTypes.MINOR_CIV_PERSONALITY_IRRATIONAL) then
            strPersonalityKey = "TXT_KEY_CITY_STATE_PERSONALITY_IRRATIONAL"
        end
        local pCapital = pMinor:GetCapitalCity();
        local thisX, thisY
        if pCapital==nil then -- in first round they have no city, only settler
            for pUnit in pPlayer:Units() do -- get any unit
                thisX = pUnit:GetX();
                thisY = pUnit:GetY();
            end
        else
            thisX = pCapital:GetX();
            thisY = pCapital:GetY();
        end

        
        strPersonalityText = "[COLOR_POSITIVE_TEXT]" .. Locale.ConvertTextKey(strPersonalityKey) .. "[ENDCOLOR]";
        strPersonalityTT = Locale.ConvertTextKey(strPersonalityKey .. "_TT");
        
        -- Gifts
        --   iCS is the minor player id 
        --   iMajor is the major player id 
        --   iData2 is the gift "value" (Gold/Culture/Faith amount, UnitId, CityId of population growth)
        --   iData3 is the friendship boost
        --   bOpt1 is first met 
        --   bOpt2 is nil
        --   sType is suffix for the TXT_KEY_ to format with

        local bFirstMajorCiv = bOpt1;
        local strGiftString = "";
        
        local strGiftTxtKey = string.format("TXT_KEY_MINOR_CIV_%sCONTACT_BONUS_%s", (bFirstMajorCiv and "FIRST_" or ""), sType)
        
        if (iData2 == 0) then
              if (iData3 == 0) then
                strGiftString = Locale.ConvertTextKey("TXT_KEY_MINOR_CIV_CONTACT_BONUS_NOTHING")
              else
                strGiftString = Locale.ConvertTextKey("TXT_KEY_MINOR_CIV_CONTACT_BONUS_FRIENDSHIP", iData3, strPersonalityKey)
              end
        else
          if (sType == "UNIT") then
            strGiftString = Locale.ConvertTextKey(strGiftTxtKey, GameInfo.Units[iData2].Description, strPersonalityKey, iData3)
          else
            strGiftString = Locale.ConvertTextKey(strGiftTxtKey, iData2, strPersonalityKey, iData3)
          end
        end
        
        local strDescription = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_MEETING", strNameKey, strGiftString, "");

        -- pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, strDescription, strTitle, thisX, thisY) -- a notification on the right
        pPlayer:AddMessage(strDescription) -- method from whowards dll -- floating strings in the middle of the screen, should not be too long, otherwise it is truncated!
    end
  
end)
