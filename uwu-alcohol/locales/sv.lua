-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["sv"] = {
    
    WashHands = {
        title = "Handfat",
        no_available = "Inget handfat tillgängligt",
        success = "Dina händer är nu rena!",
        error = "Fel",
        fail = "Dina händer är redan rena!",
        targetfail = "Du måste tvätta händerna först!",
        item_cleaned = "Föremålet rengjordes framgångsrikt!",
        missing_required = "Saknar nödvändigt föremål"
    },

    Terminal = {
        SubmitText = "Skicka Faktura",

        -- Player Selection Tab
        select_player = "Välj Spelare",
        nearby_players = "Spelare i närheten",
        search_players = "Sök spelare...",
        no_players_found = "Inga spelare hittades i närheten",
        loading_players = "Laddar spelare...",
        player_selected = "Spelare vald",

        -- Menu Items Tab
        menu_items = "Menyalternativ",
        items_added = "Artiklar tillagda",
        search_menu_items = "Sök menyalternativ...",
        available_items = "Tillgängliga artiklar",
        selected_items = "Valda artiklar",
        no_items_found = "Inga artiklar hittades",
        no_items_selected = "Inga artiklar valda",
        total_items = "Totalt antal artiklar",
        total = "Totalt",
        all = "Alla",

        -- Finalize Bill Tab
        finalize_bill = "Slutför Faktura",
        customer_info = "Kundinfo",
        order_summary = "Beställningsöversikt",
        amount_label = "Belopp ($)",
        enter_amount = "Ange belopp",
        reason_label = "Anledning (Valfritt)",
        reason_placeholder = "Ange anledning till faktura",
        payment_method = "Betalningsmetod",
        cash = "Kontanter",
        bank = "Bank",
        send_bill = "Skicka Faktura",

        -- Commission
        your_commission = "Din provision",
        commission_rate = "Provisionssats",

        -- Bills sent counter
        bills_sent = "Skickade fakturor:",
        commission = "Provision:",

        -- Error Messages
        bill_error = "Fakturafel",
        select_player_error = "Vänligen välj en spelare",
        invalid_amount_error = "Vänligen ange ett giltigt belopp",

        -- Success Messages
        bill_sent_success = "Faktura skickad framgångsrikt!",
        bill_sent_title = "Faktura Skickad",
    },

    Consumable = {
        Drinking = "Dricker ", -- Drinking ItemName
        Eating = "Äter " -- Eating ItemName
    },

    Garage = {
        title = "Garage",
        no_vehicle = "Inget fordon att återlämna",
        not_job_vehicle = "Detta är inte ett Burgershot-fordon!",
        parked_title = "Fordon parkerat!",
        parked_message = "Ditt fordon har parkerats på denna plats!",
        in_vehicle = "Du kan inte vara i fordonet!",
        too_far = "För långt bort från fordonet!",
        spawn_error = "Kan inte göra det just nu!",

        -- UI Text
        garage_title = "Garage",
        garage_active_vehicles = "Aktiva",
        garage_manage = "Hantera Aktiva",
        close = "Stäng",
        search_vehicles = "Sök fordon...",
        no_vehicles_found = "Inga fordon hittades",
        dont_have_vehicle = "Du har inga fordon lagrade i detta garage.",
        select_vehicle = "Välj Fordon",
        select_vehicle_message = "Välj ett fordon från listan för att se detaljer och ta fram det.",
        back = "Tillbaka",
        spawn_vehicle = "Ta Fram Fordon",
        return_button = "Återlämna",
        return_vehicle = "Återlämna Fordon",
        license_plate = "Registreringsskylt",

        -- Status Messages
        vehicle_spawned = "Fordon framtaget framgångsrikt",
        no_vehicle_to_return = "Inget fordon att återlämna",
        access_denied = "Du har inte tillgång till detta garage.",
        all_spawn_points_blocked = "Alla framtagningsplatser är blockerade för tillfället, vänligen vänta.",
        vehicle_model_not_exist = "Fordonsmodell existerar inte",
        failed_load_model = "Misslyckades att ladda fordonsmodell",
        failed_create_vehicle = "Misslyckades att skapa fordon",
        invalid_vehicle_data = "Ogiltig fordonsmodelldata",

        -- Error Messages
        error = "Fel",
        garage_error = "Garagefel",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "Misslyckades att skapa fordonsentitet",
        no_spawn_points_available = "Inga framtagningsplatser tillgängliga",
        vehicle_returned_parked = "Fordon återlämnat och parkerat.",
        vehicle_processed_remote = "Fordon behandlat (Fjärråterlämning).",
    },

    Billing = {
        title = "Fakturering",
        payment_failed_byreceiver = "Betalning misslyckades: %s har inte tillräckligt med pengar för att betala %s.",
        business_closed = "Fakturering är för närvarande inaktiverad av ledningen.",
        commission_earned = "Provision Tjänad",
        commission_earned_description = "Du tjänade $%s i provision.",
        terminal_title = "Faktureringsterminal",
        off_duty_error = "Du måste vara i tjänst för att använda terminalen.",
        access_denied = "Du har inte tillgång till faktureringsterminalen.",
        payment_received = "Betalning Mottagen",
        payment_received_message = "Tog emot betalning på $%s från %s",
        payment_failed = "Betalning Misslyckades",
        payment_failed_message = "Fakturabetalning misslyckades",
        bill_sent = "Faktura Skickad",
        bill_sent_success = "Faktura skickad framgångsrikt!",
        bill_sent_error = "Misslyckades att skicka faktura.",
        bill_error = "Fakturafel",
        invalid_bill = "Ogiltig Faktura!",
        invalid_bill_description = "Fakturan du försöker betala existerar inte.",
        invalid_target_amount = "Ogiltigt mål eller belopp!",
        player_not_found = "Spelare hittades inte!",
        must_be_on_duty = "Du måste vara i tjänst för att skicka en faktura!",
        bill_sent_description = "Skickade faktura på $%s till %s för %s",
        bill_payment_successful = "✅ Fakturabetalning lyckades",
        bill_payment_failed_insufficient = "❌ Fakturabetalning misslyckades - Otillräckliga medel",
        bill_rejected = "❌ Faktura avvisad",
        insufficient_funds = "%s har inte tillräckligt!",
        order_processed = "🍔 Beställning Behandlad",
        command_access_denied = "Du kan inte använda detta kommando!",
        payment_failed_insufficient = "%s har inte tillräckligt!",
        bill_rejected_title = "Faktura Avvisad",

        bill_rejected_sender = "%s avvisade din faktura på $%s",
        bill_rejected_receiver = "Du avvisade fakturan från %s",
        billing_disabled = "Fakturering är för närvarande inaktiverad av ledningen.",
        billing_off_duty = "Du måste vara i tjänst för att använda fakturering.",
    },

    Delivery = {
        items_header = "Leveransartiklar",
        reward_header = "Belöning",
        accept_header = "Acceptera Leverans",
        decline_header = "Avvisa Leverans",
        menu_header = "Leveransmeny",
        no_delivery = "Ingen aktiv leverans!",
        new_delivery_title = "Ny Leverans",
        new_delivery_desc = "Du har fått en ny leveransförfrågan.",
        delivery_expired = "Din leveransförfrågan har gått ut.",
        delivery_timeout = "Du hann inte slutföra leveransen i tid.",
        delivery_declined = "Du avvisade leveransförfrågan.",
        check_location = "Kolla din GPS för leveransplatsen.",
        check_location_error = "Ingen aktiv leverans att spåra.",
        delivery_accepted = "Leverans Accepterad",
        invalid_item = "Ogiltig artikel för leverans",
        delivery_failed = "Leverans Misslyckades",
        invalid_items_data = "Ogiltig artikeldata",

        -- UI Text
        delivery_title = "Leverans",
        close_menu = "Stäng Meny",
        new_order = "Ny Beställning",
        in_progress = "Pågår",
        order_items = "Beställningsartiklar:",
        payment = "Betalning",
        delivery_status = "Leveransstatus",
        deliver_instruction = "Leverera maten till den markerade platsen på kartan.",
        time_remaining = "Tid kvar:",
        order_summary = "Beställningsöversikt:",
        accept = "Acceptera",
        decline = "Avvisa",
        cancel_delivery = "Avbryt Leverans",

        -- Notifications
        delivery_accepted_notification = "Leverans accepterad framgångsrikt",
        delivery_cancelled_notification = "Leverans avbruten framgångsrikt",

        -- Status Messages
        complete_delivery = "Slutför Leverans",
        delivery_in_progress = "Leverans pågår...",
        head_to_location = "Åk till den markerade platsen för att slutföra leveransen",
    },

    Consumption = {
        title = "Konsumtion",
        description = "Fräscht och gott!",
        refresh_title = "Uppfriskande",
        refresh_description = "Du känner dig uppfriskad",
    },

    Crafting = {
        craft_title = "Tillverka %s",
        enter_amount_description = "Ange antal att tillverka",
        crafting_successful = "Tillverkning Lyckades",
        crafted_description = "Tillverkade %d x %s",
        crafting_cancelled = "Tillverkning Avbruten",
        cancelled_description = "Du avbröt tillverkningen",
        no_space = "Inget utrymme i inventariet",
    },

    Targets = {
        door = "Knacka på dörren",
        door_icon = "fas fa-door-open",
        delivery_food = "Leverera Mat",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "Beställningsplatta",
        ordering_tablet_error = "Beställningsplattefunktionen är inte tillgänglig.",
        order_management_tablet = "Orderhanteringsplatta",
        order_management_error = "Orderhanteringsplattefunktionen är inte tillgänglig.",
        return_utensils = "Återlämna Redskap",
        employee_vending = "Anställd Varuautomat",
    },

    Order = {
        complete = "Beställning Klar",
        description = "Din beställning har behandlats. Fakturan har lagts till i ditt inventarium.",
        paycheck_suspended_description = "Löner är indragna medan verksamheten är stängd.",
        paycheck_suspended = "Lön Indragen",
    },

    Door = {
        title = "Dörr ",
        description = "Dörren är ",
        locked = "Dörren är låst",
        no_permissions = "Ingen behörighet att låsa/låsa upp denna dörr",
        access_denied_title = "Åtkomst Nekad",
        access_granted = "Du låste upp dörren",
        access_denied = "Du har inte tillgång till denna dörr",
    },

    Outfits = {
        title = "Kläder",
        invalid = "Ogiltigt kön",
        failed_equip = "Misslyckades att ta på kläder",
        disabled = "Kläder är inaktiverade",
        civilian_clothes = "Byt till Civila Kläder",
        reset_civilian_clothes = "Bytte tillbaka till civila kläder",
        no_civilian_saved = "Inga civila kläder sparade. Byt till uniform först.",
        no_permission = "Du har inte behörighet att använda denna klädsel",
        outfit_not_found = "Klädsel hittades inte",
        equip_success = "Klädsel påtagen framgångsrikt",
        changed_to_uniform = "Bytte till %s",
        reset_success = "Klädsel återställd framgångsrikt",
        no_civilian_for_reset = "Inga civila kläder sparade. Byt till uniform och spara kläder först.",
    },

    System = {
        success = "Framgång",
        paycheck_error = "Lönefel",
        inventory_full = "Inventarium Fullt",
        inventory_full_description = "Ditt inventarium är fullt.",
        society_not_found = "Verksamhet hittades inte",
        business_funds_insufficient = "Verksamheten har inte tillräckligt med medel för att betala löner.",
        error = "Fel",
        invalid = "Ogiltig",
        no_license = "Kunde inte identifiera din licens. Kontakta en administratör.",
        missing_items = "Saknade Artiklar",
        item_cleaned = "Artikel rengjord framgångsrikt",
        missing_required = "Saknar nödvändig artikel",
        slot_error = "Placera kvantiteten i samma fack",
        ice_collected = "Is insamlad",
        refreshing = "Uppfriskande",
        refreshed = "Uppfriskad",
        consumption = "Konsumtion",
        stress_increased = "Stress Ökad",
        stress_amount = "Din stressnivå ökade med %s",
        inventory_full = "Ditt inventarium är fullt",
    },

    Experience = {
        gained_title = "Erfarenhet Tjänad",
        experience_earned_description = "Du tjänade %d XP.",
        gained_message = "Du tjänade %d XP för att ha slutfört leveransen!",
    },

    BossMenu = {
        title = "Chefsmeny",
        unable_jobdetermine = "Kunde inte fastställa ditt jobb. Försök igen senare.",
        bankruptcy_alert = "⚠️ Konkursvarning",
        description = "Kan inte betala löner! Verksamhetssaldo: $%s, Krävs: $%s",
        trans_failed_bossmenubalance = "Transaktion Misslyckades - Otillräckliga Verksamhetsmedel",
        menu_in_use = "Chefsmenyn används för närvarande av %s.",
        no_permissions = "Du har inte chefsbehörighet! Du måste vara Chef.",
        wrong_job = "Du har inte rätt jobb",
        grade_updated = "Jobbgrad Uppdaterad",
        grade_update_success = "%s grad uppdaterad framgångsrikt.",
        menu_update = "Menyuppdatering",
        menu_update_success = "Menyalternativ uppdaterat framgångsrikt!",
        vending_update = "Varuautomat",
        vending_update_success = "Varuautomatsartikel uppdaterad framgångsrikt!",
        menu_update_error = "Misslyckades att uppdatera menyalternativ!",
        menu_delete = "Meny Ta Bort",
        menu_delete_success = "Menyalternativ borttaget framgångsrikt!",
        menu_delete_error = "Misslyckades att ta bort menyalternativ!",
        invite_sent = "Inbjudan Skickad",
        invite_sent_success = "Jobbinbjudan skickad till %s",
        invite_error = "Ogiltigt spelar-ID eller roll!",
        player_not_found = "Spelare hittades inte!",
        job_error = "Ogiltig inbjudningsdata!",
        job_accepted = "Du är nu en %s på %s",
        job_updated_title = "Jobb Uppdaterat",
        job_updated = "Din position uppdaterades till %s på %s",
        database_error = "Ditt jobb ställdes in men databasuppdatering misslyckades.",
        invite_rejected = "Du avvisade jobbinbjudan.",
        withdraw_error = "Ogiltigt belopp!",
        business_error = "Verksamhet hittades inte!",
        insufficient_funds = "Otillräckliga verksamhetsmedel!",
        money_withdrawn = "Du har tagit ut $%s från verksamhetskontot.",
        transaction_failed = "Misslyckades att uppdatera verksamhetskonto!",
        money_deposited = "Du har satt in $%s på verksamhetskontot.",
        transaction_failed_refund = "Misslyckades att uppdatera verksamhetskonto! Dina pengar har återlämnats.",
        shop_purchase = "Nytt Butiksköp",
        shop_purchase_notification = "%s köpte artiklar för $%s",
        menu_occupied = "Chefsmenyn är upptagen",
        menu_occupied_by = "%s använder för närvarande chefsmenyn. Försök igen senare.",
        menu_released = "Chefsmenyn är nu tillgänglig",

        -- Main Headers and Titles
        business_overview = "Verksamhetsöversikt",
        business_settings = "Verksamhetsinställningar",
        menu_management = "Menyhantering",
        staff_management = "Personalhantering",
        employee_leaderboard = "Anställdas Topplista",
        sales_transactions = "Försäljning & Transaktioner",

        -- Finance Section
        finance = "Ekonomi",
        business_balance = "Verksamhetssaldo",
        withdraw = "Ta Ut",
        deposit = "Sätt In",
        withdraw_money = "Ta Ut Pengar",
        deposit_money = "Sätt In Pengar",
        enter_amount_withdraw = "Ange beloppet du vill ta ut från verksamhetskontot till din %s.",
        enter_amount_deposit = "Ange beloppet du vill sätta in från din %s till verksamhetskontot.",
        available = "Tillgängligt",
        enter_amount = "Ange belopp",
        withdraw_to = "Ta ut till %s",
        deposit_from = "Sätt in från %s",
        updating = "Uppdaterar...",
        update_avatar = "Uppdatera Avatar",
        cancel = "Avbryt",
        cash = "Kontanter",
        bank = "Bank",
        invalid_url = "Ogiltig URL",
        invalid_url_message = "Vänligen ange en giltig bild-URL",
        avatar_updated = "Avatar Uppdaterad",
        avatar_updated_message = "Avatar uppdaterad framgångsrikt!",
        update_failed = "Uppdatering Misslyckades",
        update_failed_message = "Misslyckades att uppdatera avatar",
        business_status = "Verksamhetsstatus",
        business_status_desc = "Kontrollera din verksamhets driftstatus",
        business_operations = "Verksamhetsdrift",
        business_open = "Tar för närvarande emot kunder - Fakturering är aktiverad",
        business_closed = "För närvarande stängt för kunder - Fakturering är inaktiverad",
        business_status_updated = "Verksamhetsstatus",
        business_now_open = "Verksamheten är nu öppen",
        business_now_closed = "Verksamheten är nu stängd",
        business_status_error = "Fel",
        business_status_failed = "Misslyckades att uppdatera verksamhetsstatus",

        -- Employees Section
        employees = "Anställda",
        invite_new_employee = "Bjud in Ny Anställd",
        player_id = "Spelar-ID...",
        invite = "Bjud in",
        select_role = "Välj Roll",
        choose_role_for = "Välj en roll för %s",
        available_roles = "Tillgängliga Roller:",
        roles_available = "%d roller tillgängliga",
        send_invite = "Skicka Inbjudan",

        -- Sales Summary
        sales_summary = "Försäljningsöversikt",
        today = "Idag",
        this_week = "Denna Vecka",
        this_month = "Denna Månad",
        view_sales = "Visa Försäljning",

        -- Inventory Status
        inventory_status = "Lagerstatus",
        storage_capacity = "Lagerkapacitet",
        ingredients = "Ingredienser",
        supplies = "Förbrukningsvaror",
        manage_inventory = "Hantera Lager",

        -- Menu Management
        search_menu_items = "Sök menyalternativ...",
        edit_menu_item = "Redigera Menyalternativ",
        update_item_details = "Uppdatera artikeldetaljerna nedan.",
        label_display_name = "Etikett (Visningsnamn)",
        price = "Pris ($)",
        category = "Kategori",
        select_category = "Välj en kategori",
        update = "Uppdatera",
        all_items = "Alla Artiklar",
        no_menu_items = "Inga menyalternativ hittades",
        no_category_items = "Ingen %s hittades",

        -- Vending Machine Management
        vending_machine_management = "Varuautomats Hantering",
        search_vending_items = "Sök varuautomatsartiklar...",
        edit_vending_item = "Redigera Varuautomatsartikel",
        update_vending_details = "Uppdatera artikeldetaljerna nedan.",
        all_vending_items = "Alla Artiklar",
        no_vending_items = "Inga varuautomatsartiklar hittades",
        no_category_vending_items = "Ingen %s hittades",
        vending_update_error = "Misslyckades att uppdatera varuautomatsartikel",
        item_price = "Pris",
        item_type = "Typ",
        uncategorized = "Okategoriserad",
        enter_price = "t.ex., 5",

        -- Staff Management
        employee_overview = "Anställd Översikt",
        total_employees = "Totalt Antal Anställda",
        active_employees = "Aktiva Anställda",
        pending_applications = "Väntande Ansökningar",
        employee_list = "Anställd Lista",
        search_employees = "Sök anställda...",
        all_employees = "Alla Anställda",
        name = "Namn",
        role = "Roll",
        salary = "Lön",
        last_seen = "Senast Sedd",
        actions = "Åtgärder",
        promote = "Befordra",
        demote = "Degradera",
        fire = "Avskeda",
        employee_actions = "Anställd Åtgärder",
        select_action = "Välj en åtgärd för %s",
        promote_employee = "Befordra Anställd",
        demote_employee = "Degradera Anställd",
        fire_employee = "Avskeda Anställd",
        confirm_action = "Bekräfta Åtgärd",
        confirm_promote = "Är du säker på att du vill befordra %s till %s?",
        confirm_demote = "Är du säker på att du vill degradera %s till %s?",
        confirm_fire = "Är du säker på att du vill avskeda %s?",
        action_success = "Åtgärd slutförd framgångsrikt",
        action_failed = "Åtgärd misslyckades",
        employee_promoted = "Anställd befordrad framgångsrikt",
        employee_demoted = "Anställd degraderad framgångsrikt",
        employee_fired = "Anställd avskedad framgångsrikt",
        no_employees = "Inga anställda hittades",

            -- Job Grades Management Dialog
        manage_job_grades = "Hantera Jobbgrader",
        configure_salary_commission = "Konfigurera lön och provisionssatser för varje position",
        search_job_grades = "Sök jobbgrader...",
        edit_job_grade = "Redigera Jobbgrad",
        update_job_grade_details = "Uppdatera jobbgradsdetaljer",
        job_title = "Jobbtitel",
        commission_rate = "Provisionssats",
        boss_access = "Chefsåtkomst",
        boss_access_enabled = "Denna roll har tillgång till ledningsfunktioner",
        boss_access_disabled = "Denna roll har åtkomst på anställdnivå",
        save_changes = "Spara Ändringar",
        boss_role = "Chefsroll",
        grade_update_error = "Misslyckades att uppdatera jobbgrad",

        -- Employee Details View
        employee_overview = "Anställd Detaljer",
        employee_profile = "Anställd Profil",
        performance_stats = "Prestationsmått",
        back = "Tillbaka",
        
        -- Employee Profile Card Labels
        commission = "Provision",
        total_earnings = "Totala Intäkter",
        available_balance = "Tillgängligt Saldo",
        employee_id = "Anställd ID",
        
        -- Performance Stats Labels
        deliveries_label = "Leveranser",
        billings_label = "Faktureringar",
        earnings_label = "Intäkter",
        experience_label = "Erfarenhet",
        level_label = "Nivå",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "Inkomstfördelning",
        delivery_income = "Leveranser",
        commission_income = "Provision",
        paycheck_income = "Löner",
        completed_label = "slutförda",
        bills_label = "fakturor",
        hourly_label = "Timvis",

        -- Employee Card Labels (for list view)
        rank_label = "Rang",
        commission_label = "Provision",

        -- Role Change Dialog
        no_role_employees = "Ingen %s hittades",
        employee_updated = "Anställd Uppdaterad",
        employee_commission_updated = "Anställd uppdaterad med %s provisionssats",
        fire_employee_error = "Misslyckades att avskeda anställd",

        -- Employee Leaderboard
        top_performers = "Toppresterare",
        this_month_leaders = "Denna Månads Ledare",
        rank = "Rang",
        employee = "Anställd",
        performance = "Prestation",
        orders_completed = "Beställningar Slutförda",
        revenue_generated = "Intäkter Genererade",
        customer_rating = "Kundbetyg",
        no_data = "Ingen prestationsdata tillgänglig",

        -- Transactions
        transaction_history = "Transaktionshistorik",
        recent_transactions = "Senaste Transaktioner",
        paycheck_history = "Lönehistorik",
        transaction_type = "Transaktionstyp",
        amount = "Belopp",
        date = "Datum",
        message = "Beskrivning",
        customer = "Kund",
        filter_transactions = "Filtrera transaktioner...",
        all_transactions = "Alla Transaktioner",
        sales_only = "Endast Försäljning",
        paychecks_only = "Endast Löner",
        no_transactions = "Inga transaktioner hittades",
        no_paychecks = "Inga löneposter hittades",


        -- Settings
        avatar_settings = "Avatarinställningar",
        update_profile_picture = "Uppdatera din profilbild",
        image_url = "Bild-URL",
        enter_url_preview = "Ange en URL nedan för att förhandsgranska din avatar",
        preview = "Förhandsgranskning",
        enter_url_message = "Ange URL:en till din avatarbild",
        ui_theme = "UI-tema",
        customize_appearance = "Anpassa instrumentpanelens utseende",
        light_mode = "Ljust Läge",
        dark_mode = "Mörkt Läge",

        -- Navigation
        home = "Hem",
        staff = "Personal",
        menu = "Meny",
        sales = "Försäljning",
        top = "Topp",
        settings = "Inställningar",

        -- Status Labels
        open = "Öppet",
        closed = "Stängt",
        online = "Online",
        offline = "Offline",
        active = "Aktiv",
        inactive = "Inaktiv",

        -- Common Actions
        save = "Spara",
        edit = "Redigera",
        delete = "Ta Bort",
        confirm = "Bekräfta",
        close = "Stäng",
        refresh = "Uppdatera",
        loading = "Laddar...",

        -- Error Messages
        error_occurred = "Ett fel inträffade",
        invalid_input = "Ogiltig inmatning",
        operation_failed = "Åtgärd misslyckades",
        permission_denied = "Åtkomst nekad",
        network_error = "Nätverksfel",
        data_load_failed = "Misslyckades att ladda data",

        -- Success Messages
        operation_successful = "Åtgärd slutförd framgångsrikt",
        data_saved = "Data sparad framgångsrikt",
        changes_applied = "Ändringar tillämpade framgångsrikt",
    },

    Shop = {
        shop_status = "Butiksstatus",
        shop_open = "Butiken är Öppen",
        shop_closed = "Butiken är Stängd",
        access_denied = "Du har inte tillgång till denna butik!",
        purchase_title = "Butik",
        purchase_success = "Köp slutfört! Artiklar tillagda i ditt inventarium.",
        purchase_error = "Utcheckning misslyckades!",

        -- Search and Inventory
        search_placeholder = "Sök produkter efter namn...",
        clear_search = "Rensa sökning",
        shop_inventory = "Butikslager",
        items_count = "artiklar",

        -- Product Actions
        add_to_cart = "Lägg till",
        per_item = "per/styck",

        -- Cart
        your_cart = "Din Varukorg",
        cart_empty = "Varukorgen är Tom",
        cart_empty_message = "Lägg till artiklar för att börja handla",
        items_label = "artiklar",
        total = "Totalt",

        -- Search Results
        no_items_found = "Inga artiklar hittades",
        no_items_message = "Prova att justera din sökning eller bläddra bland alla artiklar",

        -- Payment
        pay_with_cash = "Kontanter",
        pay_with_bank = "Bank",
        processing = "Bearbetar...",
        inventory_notice = "Artiklar kommer att läggas till direkt i ditt inventarium",

        -- Notifications
        cart_updated = "Varukorg Uppdaterad",
        item_added = "Artikel Tillagd",
        item_removed = "Artikel Borttagen",
        quantity_updated = "Antal Uppdaterat",
        purchase_complete = "Köp Slutfört",
        transaction_failed = "Transaktion Misslyckades",
        checkout_error = "Utcheckningsfel",
        cart_empty_error = "Din varukorg är tom",
        paid_with_cash = "Betalt med kontanter",
        charged_to_bank = "Debiterat ditt bankkonto",
        not_enough_cash = "Inte tillräckligt med kontanter",
        insufficient_bank = "Otillräckligt banksaldo",

        -- Quantity Messages
        added_more = "Lade till %d mer %s",
        removed_items = "Tog bort %d %s",
        added_to_cart = "%s tillagd i varukorgen",
        removed_from_cart = "Tog bort %s från din varukorg",

        -- Loading
        loading_shop = "Laddar Butiksmeny...",
    },

    EmployeeMenu = {
        access_denied = "Du har inte tillgång till denna portal!",
        commission_withdrawn = "Provision Uttagen",
        commission_withdrawn_description = "Du har tagit ut $%s från ditt provisionssaldo till din %s.",
        transaction_failed = "Transaktion Misslyckades",
        fire_employee = "Avskeda Anställd",
        fire_employee_description = "%s har blivit avskedad från din verksamhet!",
        employeeMent_notice = "Anställd Notis",
        
        no_employee_active = "Inga anställda är för närvarande online och aktiva för att hantera din beställning.",
        -- Main Headers and Navigation
        employee_portal = "Anställd Portal",
        employee_profile = "Anställd Profil",
        performance_stats = "Prestationsstatistik",
        employee_leaderboard = "Anställd Topplista",
        job_outfits = "Jobbkläder",
        account_settings = "Kontoinställningar",

        -- Navigation Labels
        profile = "Profil",
        stats = "Statistik",
        top = "Topp",
        outfits = "Kläder",
        settings = "Inställningar",

        -- Profile Tab
        personal_information = "Personlig Information",
        paycheck_information = "Löneinformation",
        job_role = "Jobbroll",
        salary = "Lön",
        experience = "Erfarenhet",
        duty_status = "Tjänstgöringsstatus",
        on_duty = "I Tjänst",
        off_duty = "Ledig",
        clock_in = "Stämpla In",
        clock_out = "Stämpla Ut",
        available_balance = "Tillgängligt Saldo",
        withdraw = "Ta Ut",
        withdraw_funds = "Ta Ut Medel",
        paycheck_interval = "Löneintervall",
        total_deliveries = "Totala Leveranser",
        bills_created = "Fakturor Skapade",
        total_earnings = "Totala Intäkter",
        minutes = "minuter",

        -- Performance Tab
        career_statistics = "Karriärstatistik",
        experience_points = "Erfarenhet",
        xp_points = "XP Poäng",
        total_earned = "Totalt Tjänat",
        current_balance = "Nuvarande Saldo",
        deliveries = "Leveranser",
        total_completed = "Totalt Slutförda",
        billings = "Faktureringar",
        invoices_created = "Fakturor Skapade",
        job_grade_progression = "Jobbgradsprogression",
        current_grade = "Nuvarande Grad",
        level = "Nivå",
        xp_needed_promotion = "XP som behövs för befordran",
        earn_more_xp = "Tjäna %d mer XP för att bli befordrad till %s",
        max_grade_reached = "Du har nått den högsta automatiska graden! Ytterligare befordringar kräver ledningens godkännande.",
        promotions_by_management = "Befordringar tilldelas av ledningen.",
        loading_experience_data = "Laddar erfarenhetssystemdata...",
        loading_progression_data = "Laddar progressionsdata...",

        -- Leaderboard Tab
        top_performers = "Toppresterare",
        this_month_leaders = "Denna Månads Ledare",
        rank = "Rang",
        employee = "Anställd",
        performance = "Prestation",
        no_leaderboard_data = "Ingen topplistedata tillgänglig",

        -- Outfits Tab
        work_outfits = "Arbetskläder",
        select_outfit = "Välj Klädsel",
        change_outfit = "Byt Klädsel",
        outfit_changed = "Klädsel Ändrad",
        outfit_changed_success = "Din klädsel har ändrats framgångsrikt!",
        outfit_change_failed = "Misslyckades att byta klädsel",
        outfit_preview = "Klädsel Förhandsgranskning",

        -- Settings Tab
        employee_settings = "Anställd Inställningar",
        avatar_settings = "Avatarinställningar",
        update_profile_picture = "Uppdatera din profilbild",
        image_url = "Bild-URL",
        enter_url_preview = "Ange en URL nedan för att förhandsgranska din avatar",
        preview = "Förhandsgranskning",
        enter_url_message = "Ange URL:en till din avatarbild",
        avatar_updated = "Avatar Uppdaterad",
        avatar_created = "Avatar Skapad",
        avatar_updated_message = "Avatar uppdaterad framgångsrikt!",
        update_failed = "Uppdatering Misslyckades",
        update_failed_message = "Misslyckades att uppdatera avatar",
        invalid_url = "Ogiltig URL",
        invalid_url_message = "Vänligen ange en giltig bild-URL",
        updating = "Uppdaterar...",
        update_avatar = "Uppdatera Avatar",

        -- UI Theme
        ui_theme = "UI-tema",
        customize_appearance = "Anpassa instrumentpanelens utseende",
        light_mode = "Ljust Läge",
        dark_mode = "Mörkt Läge",

        -- Notifications
        notifications = "Aviseringar",
        manage_notification_preferences = "Hantera aviseringsinställningar",
        employee_notifications = "Anställd Aviseringar",
        notifications_enabled_desc = "Du kommer att få alla anställdas löneuppdateringar",
        notifications_disabled_desc = "Du kommer inte att få aviseringar",
        notifications_updated = "Aviseringar Uppdaterade",
        notifications_enabled_message = "Löneaviseringar är nu aktiverade",
        notifications_disabled_message = "Löneaviseringar är nu inaktiverade",
        enabled = "Aktiverad",
        disabled = "Inaktiverad",

        -- Withdrawal Dialog
        withdraw_all_funds = "Ta Ut Alla Medel",
        select_balance_type = "Välj Saldotyp",
        all_balance = "Alla Saldon",
        delivery_balance = "Leveranssaldo",
        commission_balance = "Provisionssaldo",
        paycheck_balance = "Lönesaldo",
        available_balance_type = "Tillgängligt %s Saldo: $%d",
        enter_amount = "Ange belopp",
        insufficient_funds = "Otillräckliga Medel",
        insufficient_balance = "Otillräckligt %s saldo",
        funds_withdrawn = "Medel Uttagna",
        funds_withdrawn_success = "Tog ut $%d framgångsrikt från ditt saldo",
        transaction_failed = "Transaktion Misslyckades",
        withdrawal_failed = "Misslyckades att ta ut medel",
        invalid_amount = "Ogiltigt Belopp",
        invalid_amount_message = "Vänligen ange ett giltigt belopp",
        no_funds = "Inga Medel",
        no_funds_message = "Du har inga medel att ta ut",

        -- Common Actions
        cancel = "Avbryt",
        save = "Spara",
        update = "Uppdatera",
        confirm = "Bekräfta",
        close = "Stäng",
        loading = "Laddar...",

        -- Status Labels
        active = "Aktiv",
        inactive = "Inaktiv",
        online = "Online",
        offline = "Offline",

        -- Error Messages
        error_occurred = "Ett fel inträffade",
        operation_failed = "Åtgärd misslyckades",
        data_load_failed = "Misslyckades att ladda data",
        network_error = "Nätverksfel",
        employee_data_error = "Kunde inte hämta din anställddata.",
        identity_error = "Kunde inte verifiera din identitet.",
        withdraw_invalid_amount = "Ogiltigt belopp!",
        insufficient_commission = "Otillräckligt provisionssaldo!",
        transaction_failed_update = "Misslyckades att uppdatera provisionssaldo!",
        fire_employee_not_found = "Anställd hittades inte!",
        fire_employee_wrong_business = "Denna anställda arbetar inte för din verksamhet!",
        fire_employee_db_error = "Misslyckades att avskeda anställd från databasen!",
        employment_notice_fired = "Du har blivit avskedad från %s",
        avatar_invalid_url = "Ogiltig bild-URL angiven.",
        avatar_updated_success = "Din profilavatar har uppdaterats framgångsrikt.",
        avatar_no_changes = "Inga ändringar gjordes på din avatar.",
        avatar_created = "Din anställdprofil och avatar har skapats.",
        avatar_create_failed = "Misslyckades att skapa anställdpost.",
        withdrawal_invalid_amount = "Ogiltigt uttagsbelopp.",
        employee_record_not_found_withdraw = "Anställdpost hittades inte.",
        insufficient_balance_withdraw = "Otillräckliga medel på ditt saldo.",
        withdraw_balance_failed = "Misslyckades att ta ut från saldo. Försök igen.",
        identity_error_toggle = "Kunde inte verifiera din identitet",
        invalid_grade_data = "Ogiltig graddata angiven.",
        grade_id_not_found = "Kunde inte hitta grad-ID för denna roll.",
        no_grade_changes = "Inga ändringar gjordes på jobbgraden.",
        balance_withdrawn = "Du tog ut $%d från ditt %s saldo till din %s.",
        player_not_found = "Spelare hittades inte!",
        invalid_purchase_data = "Ogiltig köpdata!",
        insufficient_funds = "Inte tillräckligt med medel i din %s!",
        inventory_full = "Inte tillräckligt med inventarieutrymme eller viktgräns överskriden!",
        purchase_complete = "Köp slutfört! Artiklar tillagda i ditt inventarium.",
        shop_purchase = "Butiksköp: %s",
        business_balance_error = "Fel vid uppdatering av verksamhetssaldo för %s",
        business_balance_success = "Lade till $%s till verksamhetskonto framgångsrikt",
        transaction_record_error = "Fel vid registrering av transaktion för butiksköp",
        avatar_found = "Butik: Hittade avatar för %s: %s",
        avatar_not_found = "Butik: Ingen avatar hittades för %s, använder standard",
    },

    Vending = {
        invalid_item_data = "Ogiltig artikeldata.",
        insufficient_item = "Du har inte tillräckligt av denna artikel.",
        item_added_with_money = "Artikel tillagd i lager. Mottog $%s för %sx %s",
        item_added = "Artikel tillagd i lager.",
        business_balance_error = "Fel vid uppdatering av verksamhetssaldo för beställning",
        database_error = "Databasfel",
        add_item_failed = "Misslyckades att lägga till artikel.",
        invalid_collection_data = "Ogiltig upphämtningsdata.",
        inventory_full = "Kunde inte lägga till artikel i ditt inventarium.",
        item_collected = "Hämtade %sx %s",
        stock_update_failed = "Misslyckades att uppdatera varuautomatslager.",
        out_of_stock = "Slut i Lager",
        insufficient_stock = "Inte tillräckligt med artiklar tillgängliga att hämta.",
        sale_transaction_error = "Fel vid registrering av varuautomatsförsäljningstransaktion",
        collection_transaction_error = "Fel vid registrering av varuautomatsupphämtningstransaktion",
    },

    JobSystem = {
        no_permission = "Du har inte behörighet att använda detta kommando.",
        player_not_found = "Spelare hittades inte.",
        job_assigned = "Jobb tilldelat.",
        job_assign_failed = "Misslyckades att tilldela jobb.",
        job_removed = "Jobb borttaget.",
        job_remove_failed = "Misslyckades att ta bort jobb.",
        job_changed_notification = "Jobb Ändrat",
        job_changed = "Ditt jobb har ändrats till %s (grad %s).",
        job_removed_notification = "Ditt jobb har tagits bort.",
        give_job_usage = "Användning: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "Användning: /%s [playerId]",
        job_info = "Jobb: %s (Grad: %s, Tjänst: %s)",
        job_info_error = "Kunde inte hämta din jobbinfo.",
        duty_status = "Du är nu %s tjänst.",
        not_on_duty = "Ej i Tjänst",
        must_be_on_duty = "Du måste vara i tjänst för att få lön.",
        paycheck_title = "Lön",
        employer_insufficient_funds = "Din chef har inte tillräckligt med medel för att betala dig.",
        paycheck_added = "Lön på $%s tillagd till anställdsaldo för %s för jobb: %s",
        paycheck_received = "Du fick en lön på $%s från %s",
    },

    BillingInviteNotification = {
        message = "Du har fått en betalningsförfrågan.",

        -- Titles / headers
        title = "Betalningsförfrågan",
        label = "Faktureringsavisering",

        -- Button labels
        pay_button = "Betala Faktura",
        decline_button = "Avvisa",

        -- Small UI labels used inside the notification component
        business_label = "Verksamhet",
        total_amount_label = "Totalbelopp",
        reason_label = "Anledning",
        amount_label = "Belopp:",

        -- Warning / helper texts
        warning_text = "Betalning kommer att dras från ditt konto. Säkerställ tillräckliga medel.",
        expires_text = "Går ut om %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "Du har blivit inbjuden att gå med som %s på Burgershot. Accepterar du?",

        -- Titles / headers
        title = "Jobbinbjudan",
        label = "Jobbinbjudan Avisering",

        -- Button labels
        accept_button = "Acceptera",
        reject_button = "Avvisa",

        -- Small UI labels used inside the notification component
        company_label = "Företag",
        grade_label = "Grad",
        invites_left_label = "Inbjudningar Kvar",
        salary_label = "Lön",

        -- Warning / helper texts
        warning_text = "Att acceptera detta jobb kommer att binda dig till rollen. Se till att du är redo att börja.",
        expires_text = "Går ut om %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "Restaurangmeny",
        onduty = "Du måste vara i tjänst för att komma åt restaurangmenyn.",
    },

    Duty = {
        status = "Tjänstgöringsstatus",
        management = "Tjänstgöringshantering",
        description = "Du är nu %s tjänst.",
        restaurant_area = "Restaurangområde",
        clock_in = "Du har gått in i restaurangområdet. Använd anställdmenyn för att stämpla in.",
        enter_workplace = "Du har gått in på din arbetsplats och är nu i tjänst.",
        leave_workplace = "Du har lämnat din arbetsplats och är nu ledig.",
        inside_workplace = "Du är inne på din arbetsplats - automatiskt satt till i tjänst.",
        outside_workplace = "Du är utanför din arbetsplats - automatiskt satt till ledig.",
        duty_warning = "Tjänstgöringsvarning",
        auto_off_duty = "Du kommer automatiskt att sättas som ledig när du är utanför restaurangen.",
        no_permission_manage_duty = "Du har inte behörighet att hantera anställdas tjänstgöringsstatus",
        not_employee_of_job = "Spelare är inte anställd i detta jobb",
        duty_set_by_management = "Din tjänstgöringsstatus sattes till %s av ledningen",
        duty_management_success = "Satte framgångsrikt %s:s tjänstgöringsstatus till %s",
        updated_offline_employee = "Uppdaterade offline-anställds tjänstgöringsstatus",
    },

    Paycheck = {
        title = "Lön Mottagen",
        message = "Du fick en lön på $%s från %s",
    },

    VendingMachine = {
        sell_item = "Sälj Artikel",
        select_item_from_inventory = "Välj Artikel från Inventarium",
        add_to_vending = "LÄGG TILL %s TILL VARUAUTOMAT",
        cancel = "AVBRYT",
        no_matching_items = "Inga matchande artiklar i inventariet",
        stocked_items = "Lagerförda Artiklar",
        sell = "Sälj",
        no_stock = "Inget Lager",
        items = "artiklar i lager",
        ready_to_serve = "Redo att Servera!",
    },

    EmployeeVendingMachine = {
        title = "Hämta från Varuautomat",
        label = "Hämta artiklar från varuautomatslager",
        collect = "Hämta",
        cancel = "Avbryt",
        quantity_available = "Antal (Tillgängligt: %s)",
        collect_item = "Hämta %s",
        collect_button = "Hämta",
        in_stock = "I Lager",
        vending_machine_empty = "Denna varuautomat är tom.",
    },

    OrderingTab = {
        where_eating_today = "Var ska du äta idag?",
        eat_in = "Äta Här",
        take_out = "Ta Med",
        whats_up = "läget?",
        popular = "Populärt",
        done = "Klart",
        my_order = "Min Beställning",
        empty = "Tom",
        total = "Totalt",
        checkout = "Kassa",
        back = "Tillbaka",
        no_menu_items = "Inga menyalternativ tillgängliga för %s",
        loading = "Laddar...",
        eat_in_label = "Äta Här",
        take_out_label = "Ta Med",
        pay_cash = "Kontanter",
        cancel = "Avbryt",
        order = "Beställ",
        pay_bank = "Bank",
        all_items = "Alla Artiklar",
        bank_only_disclaimer = "Betalning kan endast ske via bank.",
    },

    OrderManagementTable = {
        title = "Orderhanteringspanel",
        label = "Orderadministration",
        filter_all = "Alla",
        filter_cooking = "Tillagar",
        filter_ready = "Redo",
        filter_completed = "Slutförda",
        filter_terminal_orders = "Terminalbeställningar",
        filter_self_pickup = "Kioskbeställningar",
        sort_by = "Sortera Efter",
        sort_day = "Dag",
        sort_amount = "Belopp",
        sort_name = "Namn",
        no_orders = "Inga beställningar matchar det nuvarande filtret.",
        accept = "ACCEPTERA",
        accepting = "ACCEPTERAR...",
        cooking = "TILLAGAR",
        ready = "REDO",
        complete = "SLUTFÖR",
        completed = "SLUTFÖRD",
        assigned_to = "Tilldelad till: ",
        items_label = "Artiklar:",
        order_label = "Beställning #",
        status_cooking = "tillagar",
        status_ready = "redo",
        status_completed = "slutförd",
        status_cancelled = "avbruten",
        self_pickup = "Självupphämtning",
    },

    MenuSelectionDialog = {
        title = "Välj Åtgärd",
        subtitle = "Vad skulle du vilja göra?",
        options = {
            shop = {
                title = "Öppna Butik",
                description = "Bläddra och köp varor från automaten"
            },
            manageBoss = {
                title = "Hantera Butik",
                description = "Hantera lager, visa analyser och kontrollera automaten"
            },
            manageEmployee = {
                title = "Hantera Butik",
                description = "Lägg till och hantera lagerartiklar i automaten"
            }
        }
    },
}