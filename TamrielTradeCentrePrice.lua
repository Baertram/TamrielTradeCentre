local _settings

function TamrielTradeCentrePrice:GetPriceTableUpdatedDateString()
	if (self.PriceTable == nil) then
		return GetString(TTC_ERROR_PRICETABLEMISSING)
	end

	local totalSecPerDay = 24 * 60 * 60 
	local timeStamp = self.PriceTable.TimeStamp
	local elapsedTime = GetTimeStamp() - timeStamp
	local elapsedDays = elapsedTime/totalSecPerDay
	if (elapsedTime < totalSecPerDay * 1.5) then
		return GetString(TTC_PRICE_UPDATEDTODAY)
	elseif (elapsedDays > 3) then
		return GetString(TTC_ERROR_PRICETABLEOUTDATED)
	else
		return string.format(GetString(TTC_PRICE_LASTUPDATEDXDAYSAGO), elapsedDays)
	end
end

function TamrielTradeCentrePrice:GetPriceInfo(itemLink)
	if (self.PriceTable == nil or not TamrielTradeCentre:IsItemLink(itemLink)) then
		return nil
	end

	local itemInfo = TamrielTradeCentre_ItemInfo:New(itemLink)
	if (itemInfo == nil or itemInfo.ID == nil) then
		return nil
	end
	
	local itemIDDict = self.PriceTable.Data
	local qualityDict = itemIDDict[itemInfo.ID]
	if (qualityDict == nil) then
		TamrielTradeCentre:DebugWriteLine("itemIDDict not found")
		return nil
	end

	local levelDict = qualityDict[itemInfo.QualityID]
	if (levelDict == nil) then
		TamrielTradeCentre:DebugWriteLine("qualityDict not found")
		return nil
	end

	local traitDict = levelDict[itemInfo.Level]
	if (traitDict == nil) then
		TamrielTradeCentre:DebugWriteLine("levelDict not found")
		return nil
	end

	local priceDict = nil
	if (itemInfo.Category2IDOverWrite ~= nil) then
		local category2Dict = traitDict[itemInfo.TraitID or -1]
		if (category2Dict == nil) then
			TamrielTradeCentre:DebugWriteLine("traitDict not found")
			return nil
		end

		priceDict = category2Dict[itemInfo.Category2IDOverWrite]
	elseif (itemInfo.ItemType == ITEMTYPE_POTION or itemType == ITEMTYPE_POISON) then
		local potionEffectDict = traitDict[itemInfo.TraitID or -1]
		if (potionEffectDict == nil) then
			TamrielTradeCentre:DebugWriteLine("traitDict not found")
			return nil
		end
		
		local potionEffectString = ""
		if (itemInfo.PotionEffects ~= nil) then
			for i = 1, table.getn(itemInfo.PotionEffects) do
				if (potionEffectString ~= "") then
					potionEffectString = potionEffectString .. "|"
				end

				potionEffectString = potionEffectString .. itemInfo.PotionEffects[i]
			end
		end

		priceDict = potionEffectDict[potionEffectString]
	elseif (itemInfo.ItemType == ITEMTYPE_MASTER_WRIT) then
		local masterWritInfo = itemInfo.MasterWritInfo
		if (masterWritInfo == nil) then
			TamrielTradeCentre:DebugWriteLine("masterWritInfo is nil")
			return nil
		end

		local masterWritInfoDict = traitDict[itemInfo.TraitID or -1]
		if (masterWritInfoDict == nil) then
			TamrielTradeCentre:DebugWriteLine("masterWritInfoDict not found")
			return nil
		end

		local requiredItemIDDict = masterWritInfoDict[masterWritInfo.RequiredItemID or -1]
		if (requiredItemIDDict == nil) then	
			TamrielTradeCentre:DebugWriteLine("requiredItemIDDict not found")
			return nil
		end

		local requiredQualityIDDict = requiredItemIDDict[masterWritInfo.RequiredQualityID or -1]
		if (requiredQualityIDDict == nil) then	
			TamrielTradeCentre:DebugWriteLine("requiredQualityIDDict not found")
			return nil
		end

		local numVoucherDict = requiredQualityIDDict[masterWritInfo.NumVoucher or -1]
		if (numVoucherDict == nil) then	
			TamrielTradeCentre:DebugWriteLine("numVoucherDict not found")
			return nil
		end

		priceDict = numVoucherDict[masterWritInfo.RequiredTraitID or -1]
	else
		priceDict = traitDict[itemInfo.TraitID or -1]
	end

	if (priceDict == nil or priceDict.Avg == nil) then
		TamrielTradeCentre:DebugWriteLine("priceDict not found")
		return nil
	end

	return TamrielTradeCentre_PriceInfo:New(priceDict.Avg, priceDict.Max, priceDict.Min, priceDict.EntryCount, priceDict.AmountCount, priceDict.SuggestedPrice)
end

function TamrielTradeCentrePrice:AppendPriceInfo(toolTipControl, itemLink)
	local priceInfo = self:GetPriceInfo(itemLink)

	toolTipControl:AddVerticalPadding(5)
	ZO_Tooltip_AddDivider(toolTipControl)

	if (priceInfo ~= nil) then
		if (_settings.EnableToolTipSuggested and priceInfo.SuggestedPrice ~= nil) then
			toolTipControl:AddLine(string.format("TTC " .. GetString(TTC_PRICE_SUGGESTEDXTOY), 
				TamrielTradeCentre:FormatNumber(priceInfo.SuggestedPrice, 0), TamrielTradeCentre:FormatNumber(priceInfo.SuggestedPrice * 1.25, 0)))
		end

		if (_settings.EnableToolTipAggregate) then
			toolTipControl:AddLine(string.format(GetString(TTC_PRICE_AGGREGATEPRICESXYZ), TamrielTradeCentre:FormatNumber(priceInfo.Avg), 
				TamrielTradeCentre:FormatNumber(priceInfo.Min), TamrielTradeCentre:FormatNumber(priceInfo.Max)))
		end

		if (_settings.EnableToolTipStat) then
			if (priceInfo.EntryCount ~= priceInfo.AmountCount) then
				toolTipControl:AddLine(string.format(GetString(TTC_PRICE_XLISTINGSYITEMS), TamrielTradeCentre:FormatNumber(priceInfo.EntryCount), TamrielTradeCentre:FormatNumber(priceInfo.AmountCount)))
			else
				toolTipControl:AddLine(string.format(GetString(TTC_PRICE_XLISTINGS), TamrielTradeCentre:FormatNumber(priceInfo.EntryCount)))
			end
		end

		if (_settings.EnableToolTipLastUpdate) then
			toolTipControl:AddLine(self:GetPriceTableUpdatedDateString())
		end
	end
end

function TamrielTradeCentrePrice:PriceInfoToChat(itemLink)
	-->BAERTRAM
	local chatChannel
	local changeLanguageBecauseOfChatChannel = false
	--Get the currently used chat channel at the active chat tab
	if CHAT_SYSTEM and CHAT_SYSTEM.currentChannel then chatChannel = CHAT_SYSTEM.currentChannel end
	--Check if the chat channel is given and supported
	if chatChannel ~= nil then
		local supportedChatChannels = TamrielTradeCentre.supportedChatChannels
		--Is the current chat channel suppported?
		local isChatChannelSupported = supportedChatChannels[chatChannel] or false
		if isChatChannelSupported then
			--Get the wished chat language for the channel
			local wishedChatChannelLang = _settings.chatLanguage[chatChannel]
			--Is the current client language <> the wished chat output language for the currently active chat channel?
			changeLanguageBecauseOfChatChannel = wishedChatChannelLang ~= nil and wishedChatChannelLang ~= TTC_LANG_CLIENT_INDEX
			if changeLanguageBecauseOfChatChannel then
				--Change the needed localization variables to the wished chat channel output language
				-->Function is defined in files /lang/common.lua
				TamrielTradeCentre.PriceToChatLanguage(wishedChatChannelLang)
			end
		end
	end
	--<BAERTRAM

	local priceInfo = self:GetPriceInfo(itemLink)
	local priceString = string.format(GetString(TTC_PRICE_FORX), itemLink)
	if (priceInfo == nil) then
		priceString = priceString .. GetString(TTC_PRICE_NOLISTINGDATA)
	else
		if (_settings.EnablePriceToChatSuggested) then
			if (priceInfo.SuggestedPrice ~= nil) then
				priceString = priceString .. string.format(GetString(TTC_PRICE_SUGGESTEDXTOY), TamrielTradeCentre:FormatNumber(priceInfo.SuggestedPrice, 0), 
					TamrielTradeCentre:FormatNumber(priceInfo.SuggestedPrice * 1.25, 0))
			else
				priceString = priceString .. GetString(TTC_PRICE_NOTENOUGHDATAFORSUGGESTION)
			end
		end

		if (_settings.EnablePriceToChatAggregate) then
			priceString = priceString .. " " .. string.format(GetString(TTC_PRICE_AGGREGATEPRICESXYZ), TamrielTradeCentre:FormatNumber(priceInfo.Avg), 
				TamrielTradeCentre:FormatNumber(priceInfo.Min), TamrielTradeCentre:FormatNumber(priceInfo.Max))
		end

		if (_settings.EnablePriceToChatStat) then
			if (priceInfo.EntryCount ~= priceInfo.AmountCount) then
				priceString = priceString .. " " .. string.format(GetString(TTC_PRICE_XLISTINGSYITEMS), TamrielTradeCentre:FormatNumber(priceInfo.EntryCount), TamrielTradeCentre:FormatNumber(priceInfo.AmountCount))
			else
				priceString = priceString .. " " .. string.format(GetString(TTC_PRICE_XLISTINGS), TamrielTradeCentre:FormatNumber(priceInfo.EntryCount))
			end
		end
	end

	if (_settings.EnablePriceToChatLastUpdate) then
		priceString = priceString .. " " .. self:GetPriceTableUpdatedDateString()
	end

	CHAT_SYSTEM.textEntry.editControl:InsertText(priceString)

	--Change the price to chat texts back to the original language of your client so the tooltips look fine for you again
	if changeLanguageBecauseOfChatChannel then
		--Change the ölanguage back to the client's language now
		-->Function is defined in files /lang/common.lua
		TamrielTradeCentre.PriceToChatLanguage(TTC_LANG_CLIENT_INDEX)
	end
end

local function OverWriteLinkMouseUpHandler()
	local base = ZO_LinkHandler_OnLinkMouseUp
	ZO_LinkHandler_OnLinkMouseUp = function(link, button, control)
		base(link, button, control)
		
		if (_settings.EnableItemPriceToChatBtn) then
			if (button ~= MOUSE_BUTTON_INDEX_RIGHT or not TamrielTradeCentre:IsItemLink(link)) then
				return
			end

			AddMenuItem(GetString(TTC_PRICE_PRICETOCHAT), function() TamrielTradeCentrePrice:PriceInfoToChat(link) end)
			ShowMenu(control)
		end
	end
end

local function OverWriteInventoryShowContextMenuHandler()
	ZO_PreHook('ZO_InventorySlot_ShowContextMenu', 
		function(inventorySlot)
			if (_settings.EnableItemPriceToChatBtn) then
				local slotType = ZO_InventorySlot_GetType(inventorySlot)
				local link = nil
				if slotType == SLOT_TYPE_ITEM or slotType == SLOT_TYPE_EQUIPMENT or slotType == SLOT_TYPE_BANK_ITEM or slotType == SLOT_TYPE_GUILD_BANK_ITEM or 
				   slotType == SLOT_TYPE_TRADING_HOUSE_POST_ITEM or slotType == SLOT_TYPE_REPAIR or slotType == SLOT_TYPE_CRAFTING_COMPONENT or slotType == SLOT_TYPE_PENDING_CRAFTING_COMPONENT or 
				   slotType == SLOT_TYPE_PENDING_CRAFTING_COMPONENT or slotType == SLOT_TYPE_PENDING_CRAFTING_COMPONENT then
					local bag, index = ZO_Inventory_GetBagAndIndex(inventorySlot)
					link = GetItemLink(bag, index)
				end
				if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT then
					link = GetTradingHouseSearchResultItemLink(ZO_Inventory_GetSlotIndex(inventorySlot))
				end
				if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING then
					link = GetTradingHouseListingItemLink(ZO_Inventory_GetSlotIndex(inventorySlot))
				end
				if link ~= nil and TamrielTradeCentre:IsItemLink(link) then
					zo_callLater(
						function() 
							AddMenuItem(GetString(TTC_PRICE_PRICETOCHAT), function() TamrielTradeCentrePrice:PriceInfoToChat(link) end)
							ShowMenu(self)
						end, 50)
				end
			end
		end
	)
end

local function OverWriteToolTipFunction(toolTipControl, functionName, getItemLinkFunction)
	local base = toolTipControl[functionName]
	toolTipControl[functionName] = function(control, ...)
		base(control, ...)

		if (_settings.EnableItemToolTipPricing) then
			local itemLink = getItemLinkFunction(...)
			TamrielTradeCentrePrice:AppendPriceInfo(control, itemLink)
		end
	end
end

local function GetWornItemLink(equipSlot)
	return GetItemLink(BAG_WORN, equipSlot)
end

local function GetItemLinkFirstParam(itemLink)
	return itemLink
end

function TamrielTradeCentrePrice:Init()
	TamrielTradeCentre:DebugWriteLine("TTC Price Init")
	_settings = TamrielTradeCentre.Settings

	if (self.LoadPriceTable ~= nil) then
		self:LoadPriceTable()
	end

	OverWriteToolTipFunction(ItemTooltip, "SetAttachedMailItem", GetAttachedItemLink)
	OverWriteToolTipFunction(ItemTooltip, "SetBagItem", GetItemLink)
	OverWriteToolTipFunction(ItemTooltip, "SetBuybackItem", GetBuybackItemLink)
	OverWriteToolTipFunction(ItemTooltip, "SetLootItem", GetLootItemLink)
	OverWriteToolTipFunction(ItemTooltip, "SetTradeItem", GetTradeItemLink)
	OverWriteToolTipFunction(ItemTooltip, "SetStoreItem", GetStoreItemLink)
	OverWriteToolTipFunction(ItemTooltip, "SetTradingHouseItem", GetTradingHouseSearchResultItemLink)
	OverWriteToolTipFunction(ItemTooltip, "SetTradingHouseListing", GetTradingHouseListingItemLink)
	OverWriteToolTipFunction(ItemTooltip, "SetWornItem", GetWornItemLink)
	OverWriteToolTipFunction(ItemTooltip, "SetQuestReward", GetQuestRewardItemLink)
	OverWriteToolTipFunction(PopupTooltip, "SetLink", GetItemLinkFirstParam)

	OverWriteLinkMouseUpHandler()
	OverWriteInventoryShowContextMenuHandler()
	TamrielTradeCentrePrice.SavedVars = ZO_SavedVars:NewAccountWide("TTCPriceVars", 1)
end