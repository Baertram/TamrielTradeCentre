local TryDetermineMissingItemID = function(savedVars)
	local serverRegion = TamrielTradeCentre.GetCurrentServerRegion()
	local data = nil

	if (serverRegion == "NA") then
		data = savedVars.NAData
	else
		data = savedVars.EUData
	end

	for guildName, savedVarGuildInfo in pairs(data.Guilds) do
		for index, listEntry in pairs(savedVarGuildInfo.Entries) do
			local itemLink = listEntry.ItemLink
			if (itemLink ~= nil and listEntry.ID == nil) then
				local _, specializedItemType = GetItemLinkItemType(itemLink)
				listEntry.ID = TamrielTradeCentre_ItemInfo:NameSpecializedItemTypeToItemID(listEntry.Name, specializedItemType)
			end
		end
	end
end

local Upgrade1 = function(savedVars)
	for guildName, savedVarGuildInfo in pairs(savedVars.Guilds) do
		if (savedVarGuildInfo.KioskInfo ~= nil) then
			savedVarGuildInfo.KioskLocationID = nil
			savedVarGuildInfo.KioskInfo = nil
		end

		for index, listEntry in pairs(savedVarGuildInfo.Entries) do
			local itemLink = listEntry.ItemLink
			if (itemLink ~= nil) then
				local newEntry = TamrielTradeCentre_ItemInfo:New(itemLink)
				newEntry.Amount = listEntry.Amount
				newEntry.TotalPrice = listEntry.TotalPrice
				newEntry.ItemLink = itemLink

				savedVarGuildInfo.Entries[index] = newEntry
			end
		end
	end

	savedVars.ActualVersion = 2
end

local Upgrade2 = function(savedVars)
	for _, savedVarGuildInfo in pairs(savedVars.Guilds) do
		for _, listEntry in pairs(savedVarGuildInfo.Entries) do
			if (listEntry.Level > 49) then
				listEntry.Level = 50 + (listEntry.Level - 49) * 10
			end
		end
	end
	
	local autoRecordEntries = savedVars.AutoRecordEntries
	for _, guildData in pairs(autoRecordEntries.Guilds) do
		for _, listEntries in pairs(guildData.PlayerListings) do
			for _, listEntry in pairs(listEntries) do
				if (listEntry.Level > 49) then
					listEntry.Level = 50 + (listEntry.Level - 49) * 10
				end
			end
		end
	end

	savedVars.ActualVersion = 3
end

local Upgrade3 = function(savedVars)
	local autoRecordEntries = savedVars.AutoRecordEntries
	for _, guildData in pairs(autoRecordEntries.Guilds) do
		for _, listEntries in pairs(guildData.PlayerListings) do
			for _, listEntry in pairs(listEntries) do
				listEntry.ExpireTime = listEntry.ExpireTime - listEntry.ExpireTime % 10
			end
		end
	end

	savedVars.ActualVersion = 4
end

local Upgrade5 = function(savedVars)
	for guildName, savedVarGuildInfo in pairs(savedVars.Guilds) do
		for index, listEntry in pairs(savedVarGuildInfo.Entries) do
			local itemLink = listEntry.ItemLink
			if (itemLink ~= nil) then
				listEntry = TamrielTradeCentre_ItemInfo:New(itemLink)
			end
		end
	end

	local autoRecordEntries = savedVars.AutoRecordEntries
	autoRecordEntries.Guilds = {}
	autoRecordEntries.Count = 0

	savedVars.ActualVersion = 6
end

local Upgrade6 = function(savedVars)
	local serverRegion = TamrielTradeCentre.GetCurrentServerRegion()
	local currentData = {}
	currentData["Guilds"] = savedVars["Guilds"]
	currentData["AutoRecordEntries"] = savedVars["AutoRecordEntries"]
	currentData["IsFirstExecute"] = savedVars["IsFirstExecute"]
	currentData["HasAutoScannedGuildStore"] = savedVars["HasAutoScannedGuildStore"]

	local defaultData = {}
	defaultData["Guilds"] = {}
	defaultData["AutoRecordEntries"] = {}
	defaultData["AutoRecordEntries"].Count = 0
	defaultData["AutoRecordEntries"].Guilds = {}
	defaultData["IsFirstExecute"] = true
	defaultData["HasAutoScannedGuildStore"] = false

	if (serverRegion == "NA") then
		savedVars["NAData"] = currentData
		savedVars["EUData"] = defaultData
	else
		savedVars["EUData"] = currentData
		savedVars["NAData"] = defaultData
	end

	savedVars["Guilds"] = nil
	savedVars["AutoRecordEntries"] = nil
	savedVars["IsFirstExecute"] = nil
	savedVars["HasAutoScannedGuildStore"] = nil

	savedVars.ActualVersion = 7
end

local Upgrade7 = function(savedVars)
	savedVars["Settings"].EnableSelfEntriesUpload = true

	savedVars.ActualVersion = 8
end

function TamrielTradeCentre:UpgradeSavedVar(savedVars)
	if (savedVars == nil) then
		self:DebugWriteLine("Saved var is nil. Bad sign")
		return
	end

	local actualVersion = savedVars.ActualVersion or 1
	if (actualVersion == 1) then
		Upgrade1(savedVars)
	elseif (actualVersion == 2) then
		Upgrade2(savedVars)
	elseif (actualVersion == 3) then
		Upgrade3(savedVars)
	elseif (actualVersion == 4 or actualVersion == 5) then
		Upgrade5(savedVars)
	elseif (actualVersion == 6) then
		Upgrade6(savedVars)
	elseif (actualVersion == 7) then
		Upgrade7(savedVars)
	end

	TryDetermineMissingItemID(savedVars)
end