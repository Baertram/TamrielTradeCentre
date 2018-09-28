function TamrielTradeCentre:InitSettingMenu()
	local panelData = {
		type 	= "panel",
	--> BAERTRAM
		name	= TamrielTradeCentre.AddonLAMName,
		author 	= TamrielTradeCentre.AddonLAMAuthor,
		website = TamrielTradeCentre.AddonLAMWebsite,
		version = TamrielTradeCentre.AddonVersion,
	}
	--Local speed-up for savedvariables read/write
	local TTCsettings = self.Settings
	local TTCDefaultSettings = self.DefaultSettings["Settings"]
	--Build the chat output languages list according to the actually supported languages
	-- + 1st entry:client language
	local chatChannelLanguageList 		= {}
	local chatChannelLanguageListValues = {}
	local supportedLanguages = TamrielTradeCentre.supportedLanguages
	--Build tables for the shown language string and it's internal value for the savedvars
	--Do not use ipairs here as the table index needs to be integer (it is!) and without gaps (it isn't!)
	local cnt = 0
	for langIdx, langText in pairs(supportedLanguages) do
		cnt = cnt + 1
		chatChannelLanguageList[cnt] 		= langText
		chatChannelLanguageListValues[cnt]	= langIdx
	end
	--< BAERTRAM
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
						  return TTCsettings.EnableItemSoldNotification
					  end,
			setFunc = function(value)
						  TTCsettings.EnableItemSoldNotification = value
					  end,
			default = TTCDefaultSettings.EnableItemSoldNotification,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_ENABLEAUTORECORDSEARCHRESULTS),
			tooltip = GetString(TTC_SETTING_ENABLEAUTORECORDSEARCHRESULTS_TOOLTIP),
			getFunc = function()
						  return TTCsettings.EnableAutoRecordStoreEntries
					  end,
			setFunc = function(value)
						  TTCsettings.EnableAutoRecordStoreEntries = value
					  end,
			default = TTCDefaultSettings.EnableAutoRecordStoreEntries,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_ENABLEMYGUILDLISTINGSUPLOAD),
			getFunc = function()
						  return TTCsettings.EnableSelfEntriesUpload
				      end,
		    setFunc = function(value)
						  TTCsettings.EnableSelfEntriesUpload = value
					  end,
			default = TTCDefaultSettings.EnableSelfEntriesUpload,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_ENABLEGENERALNOTIFICATIONS),
			getFunc = function()
						  return TTCsettings.EnableGeneralNotifications
					  end,
			setFunc = function(value)
						  TTCsettings.EnableGeneralNotifications = value
					  end,
			default = TTCDefaultSettings.EnableGeneralNotifications,
		},
		{
			type = "slider",
			name = GetString(TTC_SETTING_MAXNUMBEROFAUTORECORDEDENTRIES),
			min = 0,
			max = 40000,
			step = 1000,
			getFunc = function()
						  return TTCsettings.MaxAutoRecordStoreEntryCount
					  end,
			setFunc = function(value)
						  TTCsettings.MaxAutoRecordStoreEntryCount = value
					  end,
			width = "full",
			default = TTCDefaultSettings.MaxAutoRecordStoreEntryCount,
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
						  return TTCsettings.EnableItemToolTipPricing
					  end,
			setFunc = function(value)
						  TTCsettings.EnableItemToolTipPricing = value 
					  end,
			default = TTCDefaultSettings.EnableItemToolTipPricing,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDESUGGESTEDPRICE),
			getFunc = function()
						  return TTCsettings.EnableToolTipSuggested
					  end,
			setFunc = function(value)
						  TTCsettings.EnableToolTipSuggested = value
					  end,
			default = TTCDefaultSettings.EnableToolTipSuggested,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDEAGGREGATE),
			getFunc = function()
						  return TTCsettings.EnableToolTipAggregate
					  end,
			setFunc = function(value)
						  TTCsettings.EnableToolTipAggregate = value
					  end,
			default = TTCDefaultSettings.EnableToolTipAggregate,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDEENTRYCOUNT),
			getFunc = function()
						  return TTCsettings.EnableToolTipStat
					  end,
			setFunc = function(value)
						  TTCsettings.EnableToolTipStat = value
					  end,
			default = TTCDefaultSettings.EnableToolTipStat,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDELASTUPDATETIME),
			getFunc = function()
						  return TTCsettings.EnableToolTipLastUpdate
					  end,
			setFunc = function(value)
						  TTCsettings.EnableToolTipLastUpdate = value
					  end,
			default = TTCDefaultSettings.EnableToolTipLastUpdate,
		},
		{
			type = "header", 
			name = GetString(TTC_SETTING_PRICETOCHATSETTINGS),
		},
		--> BAERTRAM
		{
			type = "submenu",
			name = GetString(TTC_SETTING_CHAT_LANGUAGES),
			tooltip = GetString(TTC_SETTING_CHAT_LANGUAGES),
			controls = {
				--Dropdown: Language for chat channel "say"
				{
					type = "dropdown",
					name = GetString(TTC_SETTING_CHAT_LANGUAGE_SAY),
					tooltip = GetString(TTC_SETTING_CHAT_LANGUAGE_SAY),
					choices = chatChannelLanguageList,
					choicesValues = chatChannelLanguageListValues,
					getFunc = function()
						return TTCsettings.chatLanguage[CHAT_CHANNEL_SAY]
					end,
					setFunc = function(value)
						TTCsettings.chatLanguage[CHAT_CHANNEL_SAY] = value
					end,
					scrollable = true,
					sort = "name-up",
					default = TTCDefaultSettings.chatLanguage[CHAT_CHANNEL_SAY],
				},
				--Dropdown: Language for chat channel "yell"
				{
					type = "dropdown",
					name = GetString(TTC_SETTING_CHAT_LANGUAGE_YELL),
					tooltip = GetString(TTC_SETTING_CHAT_LANGUAGE_YELL),
					choices = chatChannelLanguageList,
					choicesValues = chatChannelLanguageListValues,
					getFunc = function()
						return TTCsettings.chatLanguage[CHAT_CHANNEL_YELL]
					end,
					setFunc = function(value)
						TTCsettings.chatLanguage[CHAT_CHANNEL_YELL] = value
					end,
					scrollable = true,
					sort = "name-up",
					default = TTCDefaultSettings.chatLanguage[CHAT_CHANNEL_YELL],
				},
				--Dropdown: Language for chat channel "zone"
				{
					type = "dropdown",
					name = GetString(TTC_SETTING_CHAT_LANGUAGE_ZONE),
					tooltip = GetString(TTC_SETTING_CHAT_LANGUAGE_ZONE),
					choices = chatChannelLanguageList,
					choicesValues = chatChannelLanguageListValues,
					getFunc = function()
						return TTCsettings.chatLanguage[CHAT_CHANNEL_ZONE]
					end,
					setFunc = function(value)
						TTCsettings.chatLanguage[CHAT_CHANNEL_ZONE] = value
					end,
					scrollable = true,
					sort = "name-up",
					default = TTCDefaultSettings.chatLanguage[CHAT_CHANNEL_ZONE],
				},
				--Dropdown: Language for chat channel "zone en"
				{
					type = "dropdown",
					name = GetString(TTC_SETTING_CHAT_LANGUAGE_ZONE1),
					tooltip = GetString(TTC_SETTING_CHAT_LANGUAGE_ZONE1),
					choices = chatChannelLanguageList,
					choicesValues = chatChannelLanguageListValues,
					getFunc = function()
						return TTCsettings.chatLanguage[CHAT_CHANNEL_ZONE_LANGUAGE_1]
					end,
					setFunc = function(value)
						TTCsettings.chatLanguage[CHAT_CHANNEL_ZONE_LANGUAGE_1] = value
					end,
					scrollable = true,
					sort = "name-up",
					default = TTCDefaultSettings.chatLanguage[CHAT_CHANNEL_ZONE_LANGUAGE_1],
				},
				--Dropdown: Language for chat channel "zone de"
				{
					type = "dropdown",
					name = GetString(TTC_SETTING_CHAT_LANGUAGE_ZONE2),
					tooltip = GetString(TTC_SETTING_CHAT_LANGUAGE_ZONE2),
					choices = chatChannelLanguageList,
					choicesValues = chatChannelLanguageListValues,
					getFunc = function()
						return TTCsettings.chatLanguage[CHAT_CHANNEL_ZONE_LANGUAGE_2]
					end,
					setFunc = function(value)
						TTCsettings.chatLanguage[CHAT_CHANNEL_ZONE_LANGUAGE_2] = value
					end,
					scrollable = true,
					sort = "name-up",
					default = TTCDefaultSettings.chatLanguage[CHAT_CHANNEL_ZONE_LANGUAGE_2],
				},
				--Dropdown: Language for chat channel "zone fr"
				{
					type = "dropdown",
					name = GetString(TTC_SETTING_CHAT_LANGUAGE_ZONE3),
					tooltip = GetString(TTC_SETTING_CHAT_LANGUAGE_ZONE3),
					choices = chatChannelLanguageList,
					choicesValues = chatChannelLanguageListValues,
					getFunc = function()
						return TTCsettings.chatLanguage[CHAT_CHANNEL_ZONE_LANGUAGE_3]
					end,
					setFunc = function(value)
						TTCsettings.chatLanguage[CHAT_CHANNEL_ZONE_LANGUAGE_3] = value
					end,
					scrollable = true,
					sort = "name-up",
					default = TTCDefaultSettings.chatLanguage[CHAT_CHANNEL_ZONE_LANGUAGE_3],
				},
				--Dropdown: Language for chat channel "zone jp"
				{
					type = "dropdown",
					name = GetString(TTC_SETTING_CHAT_LANGUAGE_ZONE4),
					tooltip = GetString(TTC_SETTING_CHAT_LANGUAGE_ZONE4),
					choices = chatChannelLanguageList,
					choicesValues = chatChannelLanguageListValues,
					getFunc = function()
						return TTCsettings.chatLanguage[CHAT_CHANNEL_ZONE_LANGUAGE_4]
					end,
					setFunc = function(value)
						TTCsettings.chatLanguage[CHAT_CHANNEL_ZONE_LANGUAGE_4] = value
					end,
					scrollable = true,
					sort = "name-up",
					default = TTCDefaultSettings.chatLanguage[CHAT_CHANNEL_ZONE_LANGUAGE_4],
				},
				--Dropdown: Language for chat channel "guild1"
				{
					type = "dropdown",
					name = GetString(TTC_SETTING_CHAT_LANGUAGE_GUILD1),
					tooltip = GetString(TTC_SETTING_CHAT_LANGUAGE_GUILD1),
					choices = chatChannelLanguageList,
					choicesValues = chatChannelLanguageListValues,
					getFunc = function()
						return TTCsettings.chatLanguage[CHAT_CHANNEL_GUILD_1]
					end,
					setFunc = function(value)
						TTCsettings.chatLanguage[CHAT_CHANNEL_GUILD_1] = value
					end,
					scrollable = true,
					sort = "name-up",
					default = TTCDefaultSettings.chatLanguage[CHAT_CHANNEL_GUILD_1],
				},
				--Dropdown: Language for chat channel "guild2"
				{
					type = "dropdown",
					name = GetString(TTC_SETTING_CHAT_LANGUAGE_GUILD2),
					tooltip = GetString(TTC_SETTING_CHAT_LANGUAGE_GUILD2),
					choices = chatChannelLanguageList,
					choicesValues = chatChannelLanguageListValues,
					getFunc = function()
						return TTCsettings.chatLanguage[CHAT_CHANNEL_GUILD_2]
					end,
					setFunc = function(value)
						TTCsettings.chatLanguage[CHAT_CHANNEL_GUILD_2] = value
					end,
					scrollable = true,
					sort = "name-up",
					default = TTCDefaultSettings.chatLanguage[CHAT_CHANNEL_GUILD_2],
				},
				--Dropdown: Language for chat channel "guild3"
				{
					type = "dropdown",
					name = GetString(TTC_SETTING_CHAT_LANGUAGE_GUILD3),
					tooltip = GetString(TTC_SETTING_CHAT_LANGUAGE_GUILD3),
					choices = chatChannelLanguageList,
					choicesValues = chatChannelLanguageListValues,
					getFunc = function()
						return TTCsettings.chatLanguage[CHAT_CHANNEL_GUILD_3]
					end,
					setFunc = function(value)
						TTCsettings.chatLanguage[CHAT_CHANNEL_GUILD_3] = value
					end,
					scrollable = true,
					sort = "name-up",
					default = TTCDefaultSettings.chatLanguage[CHAT_CHANNEL_GUILD_3],
				},
				--Dropdown: Language for chat channel "guild4"
				{
					type = "dropdown",
					name = GetString(TTC_SETTING_CHAT_LANGUAGE_GUILD4),
					tooltip = GetString(TTC_SETTING_CHAT_LANGUAGE_GUILD4),
					choices = chatChannelLanguageList,
					choicesValues = chatChannelLanguageListValues,
					getFunc = function()
						return TTCsettings.chatLanguage[CHAT_CHANNEL_GUILD_4]
					end,
					setFunc = function(value)
						TTCsettings.chatLanguage[CHAT_CHANNEL_GUILD_4] = value
					end,
					scrollable = true,
					sort = "name-up",
					default = TTCDefaultSettings.chatLanguage[CHAT_CHANNEL_GUILD_4],
				},
				--Dropdown: Language for chat channel "guild5"
				{
					type = "dropdown",
					name = GetString(TTC_SETTING_CHAT_LANGUAGE_GUILD5),
					tooltip = GetString(TTC_SETTING_CHAT_LANGUAGE_GUILD5),
					choices = chatChannelLanguageList,
					choicesValues = chatChannelLanguageListValues,
					getFunc = function()
						return TTCsettings.chatLanguage[CHAT_CHANNEL_GUILD_5]
					end,
					setFunc = function(value)
						TTCsettings.chatLanguage[CHAT_CHANNEL_GUILD_5] = value
					end,
					scrollable = true,
					sort = "name-up",
					default = TTCDefaultSettings.chatLanguage[CHAT_CHANNEL_GUILD_5],
				},
				--Dropdown: Language for chat channel "whisper sent"
				{
					type = "dropdown",
					name = GetString(TTC_SETTING_CHAT_LANGUAGE_WHISPER_SENT),
					tooltip = GetString(TTC_SETTING_CHAT_LANGUAGE_WHISPER_SENT),
					choices = chatChannelLanguageList,
					choicesValues = chatChannelLanguageListValues,
					getFunc = function()
						return TTCsettings.chatLanguage[CHAT_CHANNEL_WHISPER_SENT]
					end,
					setFunc = function(value)
						TTCsettings.chatLanguage[CHAT_CHANNEL_WHISPER_SENT] = value
					end,
					scrollable = true,
					sort = "name-up",
					default = TTCDefaultSettings.chatLanguage[CHAT_CHANNEL_WHISPER_SENT],
				},
				--Dropdown: Language for chat channel "group"
				{
					type = "dropdown",
					name = GetString(TTC_SETTING_CHAT_LANGUAGE_PARTY),
					tooltip = GetString(TTC_SETTING_CHAT_LANGUAGE_PARTY),
					choices = chatChannelLanguageList,
					choicesValues = chatChannelLanguageListValues,
					getFunc = function()
						return TTCsettings.chatLanguage[CHAT_CHANNEL_PARTY]
					end,
					setFunc = function(value)
						TTCsettings.chatLanguage[CHAT_CHANNEL_PARTY] = value
					end,
					scrollable = true,
					sort = "name-up",
					default = TTCDefaultSettings.chatLanguage[CHAT_CHANNEL_PARTY],
				},
			} -- controls submneu chat language
		}, -- submenu chat language,
		--< BAERTRAM
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_ENABLEPRICETOCHATBUTTON),
			tooltip = GetString(TTC_SETTING_ENABLEPRICETOCHATBUTTON_TOOLTIP),
			getFunc = function()
						  return TTCsettings.EnableItemPriceToChatBtn
					  end,
			setFunc = function(value)
						  TTCsettings.EnableItemPriceToChatBtn = value
					  end,
			default = TTCDefaultSettings.EnableItemPriceToChatBtn,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDESUGGESTEDPRICE),
			getFunc = function()
						  return TTCsettings.EnablePriceToChatSuggested
					  end,
			setFunc = function(value)
						  TTCsettings.EnablePriceToChatSuggested = value
					  end,
			default = TTCDefaultSettings.EnablePriceToChatSuggested,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDEAGGREGATE),
			getFunc = function()
						  return TTCsettings.EnablePriceToChatAggregate
					  end,
			setFunc = function(value)
						  TTCsettings.EnablePriceToChatAggregate = value
					  end,
			default = TTCDefaultSettings.EnablePriceToChatAggregate,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDEENTRYCOUNT),
			getFunc = function()
						  return TTCsettings.EnablePriceToChatStat
					  end,
			setFunc = function(value)
						  TTCsettings.EnablePriceToChatStat = value
					  end,
			default = TTCDefaultSettings.EnablePriceToChatStat,
		},
		{
			type = "checkbox",
			name = GetString(TTC_SETTING_INCLUDELASTUPDATETIME),
			getFunc = function()
						  return TTCsettings.EnablePriceToChatLastUpdate
					  end,
			setFunc = function(value)
						  TTCsettings.EnablePriceToChatLastUpdate = value
					  end,
			default = TTCDefaultSettings.EnablePriceToChatLastUpdate,
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