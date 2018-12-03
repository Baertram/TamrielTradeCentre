-->BAERTRAM, 2018-12-03
TamrielTradeCentre = TamrielTradeCentre or {}
function TamrielTradeCentre:updatePriceToChatContextMenu()
	--LibCustomMenu library: Create context menu and add entries to it.
	--Show the selected languages from the LAM settings menu, stored in variable self.Settings.ItemPriceToChatLanguage[languageIndex]
	--Clear the context menu variable
	TamrielTradeCentre.priceToChatLangCtm = {}
	--For each entry in the price to chat language table: Check if the setting is enabled
	local settings = self.Settings
	local atLeastOneChatLanguageActivated = false
	for languageIndex, languageEnabled in pairs(settings.ItemPriceToChatLanguage) do
		if languageEnabled then
			table.insert(TamrielTradeCentre.priceToChatLangCtm, languageIndex)
			atLeastOneChatLanguageActivated = true
		end
	end
	--No chat language enabled in the settings?
	if not atLeastOneChatLanguageActivated then
		--Then enable the english language by default
		self.Settings.ItemPriceToChatLanguage[TTC_LANG_EN_INDEX] = true
		table.insert(TamrielTradeCentre.priceToChatLangCtm, TTC_LANG_EN_INDEX)
	end
	--Use this table TamrielTradeCenter.priceToChatLangCtm later on as the menu is shown and
	--add the entries to ZO_Menu dynamically.
	-->See file TamrielTradeCenterPrice.lua, function OverWriteInventoryShowContextMenuHandler()
end
--<BAERTRAM, 2018-12-03


function TamrielTradeCentre:InitSettingMenu()
	local panelData = {
		type = "panel",
		name = "Tamriel Trade Centre",
		author = "TamrielTradeCentre.com",
-->BAERTRAM, 2018-12-03
		website = "https://www.TamrielTradeCentre.com",
		version = "3.21.1226.48292",
--<BAERTRAM, 2018-12-03
	}

-->BAERTRAM, 2018-12-03
	TamrielTradeCentre:updatePriceToChatContextMenu()
--<BAERTRAM, 2018-12-03

	local optionsTable = {
		{
			type = "header", 
			name = GetString(TTC_SETTING_GENERALSETTINGS),
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_ENABLEITEMSOLDNOTIFICATION), 
			tooltip = GetString(TTC_SETTING_ENABLEITEMSOLDNOTIFICATION_TOOLTIP),
			getFunc = function()
						  return self.Settings.EnableItemSoldNotification
					  end,
			setFunc = function(value)
						  self.Settings.EnableItemSoldNotification = value
					  end,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_ENABLEAUTORECORDSEARCHRESULTS),
			tooltip = GetString(TTC_SETTING_ENABLEAUTORECORDSEARCHRESULTS_TOOLTIP),
			getFunc = function()
						  return self.Settings.EnableAutoRecordStoreEntries
					  end,
			setFunc = function(value)
						  self.Settings.EnableAutoRecordStoreEntries = value
					  end,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_ENABLEMYGUILDLISTINGSUPLOAD),
			getFunc = function()
						  return self.Settings.EnableSelfEntriesUpload
				      end,
		    setFunc = function(value)
						  self.Settings.EnableSelfEntriesUpload = value
					  end,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_ENABLEGENERALNOTIFICATIONS),
			getFunc = function()
						  return self.Settings.EnableGeneralNotifications
					  end,
			setFunc = function(value)
						  self.Settings.EnableGeneralNotifications = value
					  end,
		},
		{
			type = "slider",
			name = GetString(TTC_SETTING_MAXNUMBEROFAUTORECORDEDENTRIES),
			min = 0,
			max = 40000,
			step = 1000,
			getFunc = function()
						  return self.Settings.MaxAutoRecordStoreEntryCount
					  end,
			setFunc = function(value)
						  self.Settings.MaxAutoRecordStoreEntryCount = value
					  end,
			width = "full",
		},
		{
			type = "header",
			name = GetString(TTC_SETTING_TOOLTIPSETTINGS),
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_ENABLEITEMPANELPRICINGINFO),
			tooltip = GetString(TTC_SETTING_ENABLEITEMPANELPRICINGINFO_TOOLTIP),
			getFunc = function()
						  return self.Settings.EnableItemToolTipPricing
					  end,
			setFunc = function(value)
						  self.Settings.EnableItemToolTipPricing = value 
					  end,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDESUGGESTEDPRICE),
			getFunc = function()
						  return self.Settings.EnableToolTipSuggested
					  end,
			setFunc = function(value)
						  self.Settings.EnableToolTipSuggested = value
					  end,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDEAGGREGATE),
			getFunc = function()
						  return self.Settings.EnableToolTipAggregate
					  end,
			setFunc = function(value)
						  self.Settings.EnableToolTipAggregate = value
					  end,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDEENTRYCOUNT),
			getFunc = function()
						  return self.Settings.EnableToolTipStat
					  end,
			setFunc = function(value)
						  self.Settings.EnableToolTipStat = value
					  end,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDELASTUPDATETIME),
			getFunc = function()
						  return self.Settings.EnableToolTipLastUpdate
					  end,
			setFunc = function(value)
						  self.Settings.EnableToolTipLastUpdate = value
					  end,
		},
		{
			type = "header", 
			name = GetString(TTC_SETTING_PRICETOCHATSETTINGS),
		},

-->BAERTRAM, 2018-12-03
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_ENABLEPRICETOCHATBUTTON),
			tooltip = GetString(TTC_SETTING_ENABLEPRICETOCHATBUTTON_TOOLTIP),
			getFunc = function()
				return self.Settings.EnableItemPriceToChatBtn
			end,
			setFunc = function(value)
				self.Settings.EnableItemPriceToChatBtn = value
			end,
		},
		{
			type = "submenu",
			name = GetString(TTC_SETTING_PRICETOCHATSETTINGS_SUBMENU),
			controls = {
				{
					type = "description",
					text = GetString(TTC_SETTING_ENABLEPRICETOCHATDESCR),
					--title = "My Title", -- or string id or function returning a string (optional)
					width = "full",
				},
				{
					type = "checkbox",
					name = GetString(TTC_SETTING_ENABLEPRICETOCHATEN_TOOLTIP),
					tooltip = GetString(TTC_SETTING_ENABLEPRICETOCHATEN_TOOLTIP),
					getFunc = function()
						return self.Settings.ItemPriceToChatLanguage[TTC_LANG_EN_INDEX]
					end,
					setFunc = function(value)
						self.Settings.ItemPriceToChatLanguage[TTC_LANG_EN_INDEX] = value
						TamrielTradeCentre:updatePriceToChatContextMenu()
					end,
					width = "half",
					disabled = function() return not self.Settings.EnableItemPriceToChatBtn end,
				},
				{
					type = "checkbox",
					name = GetString(TTC_SETTING_ENABLEPRICETOCHATDE_TOOLTIP),
					tooltip = GetString(TTC_SETTING_ENABLEPRICETOCHATDE_TOOLTIP),
					getFunc = function()
						return self.Settings.ItemPriceToChatLanguage[TTC_LANG_DE_INDEX]
					end,
					setFunc = function(value)
						self.Settings.ItemPriceToChatLanguage[TTC_LANG_DE_INDEX] = value
						TamrielTradeCentre:updatePriceToChatContextMenu()
					end,
					width = "half",
					disabled = function() return not self.Settings.EnableItemPriceToChatBtn end,
				},
				{
					type = "checkbox",
					name = GetString(TTC_SETTING_ENABLEPRICETOCHATFR_TOOLTIP),
					tooltip = GetString(TTC_SETTING_ENABLEPRICETOCHATFR_TOOLTIP),
					getFunc = function()
						return self.Settings.ItemPriceToChatLanguage[TTC_LANG_FR_INDEX]
					end,
					setFunc = function(value)
						self.Settings.ItemPriceToChatLanguage[TTC_LANG_FR_INDEX] = value
						TamrielTradeCentre:updatePriceToChatContextMenu()
					end,
					width = "half",
					disabled = function() return not self.Settings.EnableItemPriceToChatBtn end,
				},
				{
					type = "checkbox",
					name = GetString(TTC_SETTING_ENABLEPRICETOCHATRU_TOOLTIP),
					tooltip = GetString(TTC_SETTING_ENABLEPRICETOCHATRU_TOOLTIP),
					getFunc = function()
						return self.Settings.ItemPriceToChatLanguage[TTC_LANG_RU_INDEX]
					end,
					setFunc = function(value)
						self.Settings.ItemPriceToChatLanguage[TTC_LANG_RU_INDEX] = value
						TamrielTradeCentre:updatePriceToChatContextMenu()
					end,
					width = "half",
					disabled = function() return not self.Settings.EnableItemPriceToChatBtn end,
				},
				{
					type = "checkbox",
					name = GetString(TTC_SETTING_ENABLEPRICETOCHATZH_TOOLTIP),
					tooltip = GetString(TTC_SETTING_ENABLEPRICETOCHATZH_TOOLTIP),
					getFunc = function()
						return self.Settings.ItemPriceToChatLanguage[TTC_LANG_ZH_INDEX]
					end,
					setFunc = function(value)
						self.Settings.ItemPriceToChatLanguage[TTC_LANG_ZH_INDEX] = value
						TamrielTradeCentre:updatePriceToChatContextMenu()
					end,
					width = "half",
					disabled = function() return not self.Settings.EnableItemPriceToChatBtn end,
				},
			}, -- controls submenu price to chat
		}, -- submenu price to chat
--<BAERTRAM, 2018-12-03
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDESUGGESTEDPRICE),
			getFunc = function()
						  return self.Settings.EnablePriceToChatSuggested
					  end,
			setFunc = function(value)
						  self.Settings.EnablePriceToChatSuggested = value
					  end,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDEAGGREGATE),
			getFunc = function()
						  return self.Settings.EnablePriceToChatAggregate
					  end,
			setFunc = function(value)
						  self.Settings.EnablePriceToChatAggregate = value
					  end,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDEENTRYCOUNT),
			getFunc = function()
						  return self.Settings.EnablePriceToChatStat
					  end,
			setFunc = function(value)
						  self.Settings.EnablePriceToChatStat = value
					  end,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDELASTUPDATETIME),
			getFunc = function()
						  return self.Settings.EnablePriceToChatLastUpdate
					  end,
			setFunc = function(value)
						  self.Settings.EnablePriceToChatLastUpdate = value
					  end,
		},
		{
			type = "header", 
			name = GetString(TTC_SETTING_CLEARDATA),
		},
		{
			type = "button",
			name = GetString(TTC_SETTING_CLEARRECORDEDENTRIES),
			width = "full",
			func = function()
					   self.Data.AutoRecordEntries.Guilds = {}
					   self.Data.AutoRecordEntries.Count = 0
				   end,
		},
	}

	local LAM = LibStub("LibAddonMenu-2.0")
	LAM:RegisterAddonPanel(GetString(TTC_SETTING_TTCOPTIONS), panelData)
	LAM:RegisterOptionControls(GetString(TTC_SETTING_TTCOPTIONS), optionsTable)
end