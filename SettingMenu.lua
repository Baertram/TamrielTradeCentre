function TamrielTradeCentre:InitSettingMenu()
	local panelData = {
		type = "panel",
		name = "Tamriel Trade Centre",
		author = "TamrielTradeCentre.com",
		version = "3.4.6429.38725",
	}

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