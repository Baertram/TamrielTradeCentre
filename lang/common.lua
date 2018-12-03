--> BAERTRAM
TamrielTradeCentre = TamrielTradeCentre or {}
--Language # index constants (Position of first char of the language in alphabet * 10, to leave space between for other languages)
TTC_LANG_CLIENT_INDEX 	= 1
TTC_LANG_DE_INDEX 		= 40
TTC_LANG_EN_INDEX 		= 50
TTC_LANG_FR_INDEX 		= 60
TTC_LANG_RU_INDEX 		= 180
TTC_LANG_ZH_INDEX 		= 260

--Map the client's language to the TTC language index
function TamrielTradeCentre.ClientLanguageToTTCLanguageIndex()
    local langToUseIndex = TTC_LANG_CLIENT_INDEX
    --Get the client language
    local clientLang = GetCVar("language.2")
    --is the current language already Englisch?
    if      clientLang == "de" then
        langToUseIndex = TTC_LANG_DE_INDEX
    elseif  clientLang == "en" then
        langToUseIndex = TTC_LANG_EN_INDEX
    elseif  clientLang == "fr" then
        langToUseIndex = TTC_LANG_FR_INDEX
    elseif  clientLang == "ru" then
        langToUseIndex = TTC_LANG_RU_INDEX
    elseif  clientLang == "zh" then
        langToUseIndex = TTC_LANG_ZH_INDEX
    end
    return langToUseIndex
end

--Function to change the texts for the "price to chat" function of this addon
--> Keep the translations below updated if you update the language files
function TamrielTradeCentre.PriceToChatLanguage(langToUseIndex)
    --Was the client language requested?
    if langToUseIndex == TTC_LANG_CLIENT_INDEX then
        --Get the language index via the client's language
        langToUseIndex = TamrielTradeCentre.ClientLanguageToTTCLanguageIndex()
    end
    --English
    if langToUseIndex == TTC_LANG_EN_INDEX then
        --Pricing
        ZO_CreateStringId("TTC_PRICE_UPDATEDTODAY",                 "Updated Today")
        ZO_CreateStringId("TTC_PRICE_LASTUPDATEDXDAYSAGO",          "Last updated %i days ago")
        ZO_CreateStringId("TTC_PRICE_NOLISTINGDATA",                "No listing data")
        ZO_CreateStringId("TTC_PRICE_SUGGESTEDXTOY",                "Suggested : %s ~ %s")
        ZO_CreateStringId("TTC_PRICE_AGGREGATEPRICESXYZ",           "[Avg %s/Min %s/Max %s]")
        ZO_CreateStringId("TTC_PRICE_XLISTINGSYITEMS",              "(%s listings/%s items)")
        ZO_CreateStringId("TTC_PRICE_XLISTINGS",                    "(%s listings)")
        ZO_CreateStringId("TTC_PRICE_FORXNOLISTINGDATA",            "TTC Price for %s: No listing data. ")
        ZO_CreateStringId("TTC_PRICE_FORX",                         "TTC Price for %s : ")
        ZO_CreateStringId("TTC_PRICE_NOTENOUGHDATAFORSUGGESTION",   "Not enough data for suggestion")
        ZO_CreateStringId("TTC_PRICE_PRICETOCHAT", "Price to Chat")
    --German
    elseif langToUseIndex == TTC_LANG_DE_INDEX then
        --Pricing
        ZO_CreateStringId("TTC_PRICE_UPDATEDTODAY",                 "Heute aktualisiert")
        ZO_CreateStringId("TTC_PRICE_LASTUPDATEDXDAYSAGO",          "Zuletzt aktualisiert vor %i Tagen")
        ZO_CreateStringId("TTC_PRICE_NOLISTINGDATA",                "Keine Einträge")
        ZO_CreateStringId("TTC_PRICE_SUGGESTEDXTOY",                "Vorschlag: %s ~ %s")
        ZO_CreateStringId("TTC_PRICE_AGGREGATEPRICESXYZ",           "[Ø %s/min. %s/max. %s]")
        ZO_CreateStringId("TTC_PRICE_XLISTINGSYITEMS",              "(%s Einträge/%s Gegenstände)")
        ZO_CreateStringId("TTC_PRICE_XLISTINGS",                    "(%s Einträge)")
        ZO_CreateStringId("TTC_PRICE_FORXNOLISTINGDATA",            "TTC: Preis für %s: Keine Daten vorhanden. ")
        ZO_CreateStringId("TTC_PRICE_FORX",                         "TTC: Preis für %s : ")
        ZO_CreateStringId("TTC_PRICE_NOTENOUGHDATAFORSUGGESTION",   "Preisvorschlag nicht möglich; zu wenige Informationen.")
        ZO_CreateStringId("TTC_PRICE_PRICETOCHAT", "TTC-Preis in Chat einfügen")
    --French
    elseif langToUseIndex == TTC_LANG_FR_INDEX then
        --Pricing
        ZO_CreateStringId("TTC_PRICE_UPDATEDTODAY",                 "Mis à jour aujourd'hui")
        ZO_CreateStringId("TTC_PRICE_LASTUPDATEDXDAYSAGO",          "Dernière mise à jour il y a %i jours")
        ZO_CreateStringId("TTC_PRICE_NOLISTINGDATA",                "Aucune donnée de liste")
        ZO_CreateStringId("TTC_PRICE_SUGGESTEDXTOY",                "Prix proposé : %s ~ %s")
        ZO_CreateStringId("TTC_PRICE_AGGREGATEPRICESXYZ",           "[Moy %s/Min %s/Max %s]")
        ZO_CreateStringId("TTC_PRICE_XLISTINGSYITEMS",              "(%s offres/%s items)")
        ZO_CreateStringId("TTC_PRICE_XLISTINGS",                    "(%s offres)")
        ZO_CreateStringId("TTC_PRICE_FORXNOLISTINGDATA",            "TTC Prix pour %s : Aucune donnée disponible")
        ZO_CreateStringId("TTC_PRICE_FORX",                         "TTC Prix pour %s : ")
        ZO_CreateStringId("TTC_PRICE_NOTENOUGHDATAFORSUGGESTION",   "Données insuffisantes pour suggestion de prix")
        ZO_CreateStringId("TTC_PRICE_PRICETOCHAT", "Prix vers la fenêtre Dialogue")
    --Russian
    elseif langToUseIndex == TTC_LANG_RU_INDEX then
        --Pricing
        ZO_CreateStringId("TTC_PRICE_UPDATEDTODAY",                 "Обновлено сегодня")
        ZO_CreateStringId("TTC_PRICE_LASTUPDATEDXDAYSAGO",          "Дней с последнего обновления: %i")
        ZO_CreateStringId("TTC_PRICE_NOLISTINGDATA",                "Нет информации")
        ZO_CreateStringId("TTC_PRICE_SUGGESTEDXTOY",                "Рекомендованная цена: %s ~ %s")
        ZO_CreateStringId("TTC_PRICE_AGGREGATEPRICESXYZ",           "[Ср. %s/Мин. %s/Макс. %s]")
        ZO_CreateStringId("TTC_PRICE_XLISTINGSYITEMS",              "(Предложений: %s /Ед. товара: %s)")
        ZO_CreateStringId("TTC_PRICE_XLISTINGS",                    "(Предложений: %s)")
        ZO_CreateStringId("TTC_PRICE_FORXNOLISTINGDATA",            "TTC-цена на %s: нет информации. ")
        ZO_CreateStringId("TTC_PRICE_FORX",                         "TTC-цена на %s: ")
        ZO_CreateStringId("TTC_PRICE_NOTENOUGHDATAFORSUGGESTION",   "Недостаточно данных, чтобы рекомендовать цену")
        ZO_CreateStringId("TTC_PRICE_PRICETOCHAT", "TTC-цену в чат")
    --Chinese
    elseif langToUseIndex == TTC_LANG_ZH_INDEX then
        --Pricing
        ZO_CreateStringId("TTC_PRICE_UPDATEDTODAY",                 "最新")
        ZO_CreateStringId("TTC_PRICE_LASTUPDATEDXDAYSAGO",          "%i天前更新")
        ZO_CreateStringId("TTC_PRICE_NOLISTINGDATA",                "没有在售信息")
        ZO_CreateStringId("TTC_PRICE_SUGGESTEDXTOY",                "推荐价格 : %s ~ %s")
        ZO_CreateStringId("TTC_PRICE_AGGREGATEPRICESXYZ",           "[平均 %s/最低 %s/最高 %s]")
        ZO_CreateStringId("TTC_PRICE_XLISTINGSYITEMS",              "(%s 条在售/共%s 件)")
        ZO_CreateStringId("TTC_PRICE_XLISTINGS",                    "(%s 条在售)")
        ZO_CreateStringId("TTC_PRICE_FORXNOLISTINGDATA",            "TTC 对%s报价: 没有在售信息")
        ZO_CreateStringId("TTC_PRICE_FORX",                         "TTC 对%s报价: ")
        ZO_CreateStringId("TTC_PRICE_NOTENOUGHDATAFORSUGGESTION",   "推荐价格所需数据不足")
        ZO_CreateStringId("TTC_PRICE_PRICETOCHAT", "分享价格")
    end
end
--< BAERTRAM