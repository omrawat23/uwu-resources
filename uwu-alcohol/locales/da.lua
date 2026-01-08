-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["da"] = {
    
    WashHands = {
        title = "Vask",
        no_available = "Ingen vask tilgængelig",
        success = "Dine hænder er nu rene!",
        error = "Fejl",
        fail = "Dine hænder er allerede rene!",
        targetfail = "Du skal vaske dine hænder først!",
        item_cleaned = "Genstand blev rengjort!",
        missing_required = "Mangler nødvendig genstand"
    },

    Terminal = {
        SubmitText = "Send Regning",

        -- Player Selection Tab
        select_player = "Vælg Spiller",
        nearby_players = "Spillere i nærheden",
        search_players = "Søg efter spillere...",
        no_players_found = "Ingen spillere fundet i nærheden",
        loading_players = "Indlæser spillere...",
        player_selected = "Spiller valgt",

        -- Menu Items Tab
        menu_items = "Menuvalg",
        items_added = "Varer tilføjet",
        search_menu_items = "Søg i menuvalg...",
        available_items = "Tilgængelige varer",
        selected_items = "Valgte varer",
        no_items_found = "Ingen varer fundet",
        no_items_selected = "Ingen varer valgt",
        total_items = "Samlede varer",
        total = "I alt",
        all = "Alle",

        -- Finalize Bill Tab
        finalize_bill = "Afslut Regning",
        customer_info = "Kundeinfo",
        order_summary = "Ordreoversigt",
        amount_label = "Beløb ($)",
        enter_amount = "Indtast beløb",
        reason_label = "Årsag (Valgfri)",
        reason_placeholder = "Indtast årsag til regning",
        payment_method = "Betalingsmetode",
        cash = "Kontant",
        bank = "Bank",
        send_bill = "Send Regning",

        -- Commission
        your_commission = "Din provision",
        commission_rate = "Provisionssats",

        -- Bills sent counter
        bills_sent = "Regninger sendt:",
        commission = "Provision:",

        -- Error Messages
        bill_error = "Regningsfejl",
        select_player_error = "Vælg venligst en spiller",
        invalid_amount_error = "Indtast venligst et gyldigt beløb",

        -- Success Messages
        bill_sent_success = "Regning sendt succesfuldt!",
        bill_sent_title = "Regning Sendt",
    },

    Consumable = {
        Drinking = "Drikker ", -- Drinking ItemName
        Eating = "Spiser " -- Eating ItemName
    },

    Garage = {
        title = "Garage",
        no_vehicle = "Intet køretøj at returnere",
        not_job_vehicle = "Dette er ikke et Burgershot køretøj!",
        parked_title = "Køretøj parkeret!",
        parked_message = "Dit køretøj er blevet parkeret her!",
        in_vehicle = "Du må ikke sidde i køretøjet!",
        too_far = "For langt væk fra køretøjet!",
        spawn_error = "Kan ikke gøre det lige nu!",

        -- UI Text
        garage_title = "Garage",
        garage_active_vehicles = "Aktive",
        garage_manage = "Administrer Aktive",
        close = "Luk",
        search_vehicles = "Søg efter køretøjer...",
        no_vehicles_found = "Ingen køretøjer fundet",
        dont_have_vehicle = "Du har ingen køretøjer i denne garage.",
        select_vehicle = "Vælg Køretøj",
        select_vehicle_message = "Vælg et køretøj fra listen for at se detaljer og hente det.",
        back = "Tilbage",
        spawn_vehicle = "Hent Køretøj",
        return_button = "Returner",
        return_vehicle = "Returner Køretøj",
        license_plate = "Nummerplade",

        -- Status Messages
        vehicle_spawned = "Køretøj hentet succesfuldt",
        no_vehicle_to_return = "Intet køretøj at returnere",
        access_denied = "Du har ikke adgang til denne garage.",
        all_spawn_points_blocked = "Alle pladser er optaget lige nu, vent venligst.",
        vehicle_model_not_exist = "Køretøjsmodel findes ikke",
        failed_load_model = "Kunne ikke indlæse køretøjsmodel",
        failed_create_vehicle = "Kunne ikke oprette køretøj",
        invalid_vehicle_data = "Ugyldige køretøjsdata",

        -- Error Messages
        error = "Fejl",
        garage_error = "Garagefejl",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "Kunne ikke oprette køretøjsenhed",
        no_spawn_points_available = "Ingen ledige pladser",
        vehicle_returned_parked = "Køretøj returneret og parkeret.",
        vehicle_processed_remote = "Køretøj behandlet (Fjernreturnering).",
    },

    Billing = {
        title = "Fakturering",
        payment_failed_byreceiver = "Betaling fejlede: %s har ikke penge nok til at betale %s.",
        business_closed = "Fakturering er i øjeblikket deaktiveret af ledelsen.",
        commission_earned = "Provision Optjent",
        commission_earned_description = "Du optjente $%s i provision.",
        terminal_title = "Faktureringsterminal",
        off_duty_error = "Du skal være på arbejde for at bruge terminalen.",
        access_denied = "Du har ikke adgang til terminalen.",
        payment_received = "Betaling Modtaget",
        payment_received_message = "Modtog betaling på $%s fra %s",
        payment_failed = "Betaling Fejlede",
        payment_failed_message = "Betaling af regning fejlede",
        bill_sent = "Regning Sendt",
        bill_sent_success = "Regning sendt succesfuldt!",
        bill_sent_error = "Kunne ikke sende regning.",
        bill_error = "Regningsfejl",
        invalid_bill = "Ugyldig Regning!",
        invalid_bill_description = "Regningen du forsøger at betale findes ikke.",
        invalid_target_amount = "Ugyldigt mål eller beløb!",
        player_not_found = "Spiller ikke fundet!",
        must_be_on_duty = "Du skal være på arbejde for at sende en regning!",
        bill_sent_description = "Sendte en regning på $%s til %s for %s",
        bill_payment_successful = "✅ Betaling af regning gennemført",
        bill_payment_failed_insufficient = "❌ Betaling fejlede - Ikke nok penge",
        bill_rejected = "❌ Regning afvist",
        insufficient_funds = "%s har ikke nok midler!",
        order_processed = "🍔 Ordre Behandlet",
        command_access_denied = "Du kan ikke bruge denne kommando!",
        payment_failed_insufficient = "%s har ikke nok midler!",
        bill_rejected_title = "Regning Afvist",

        bill_rejected_sender = "%s afviste din regning på $%s",
        bill_rejected_receiver = "Du afviste regningen fra %s",
        billing_disabled = "Fakturering er i øjeblikket deaktiveret af ledelsen.",
        billing_off_duty = "Du skal være på arbejde for at bruge fakturering.",
    },

    Delivery = {
        items_header = "Leveringsvarer",
        reward_header = "Belønning",
        accept_header = "Accepter Levering",
        decline_header = "Afvis Levering",
        menu_header = "Leveringsmenu",
        no_delivery = "Ingen aktiv levering!",
        new_delivery_title = "Ny Levering",
        new_delivery_desc = "Du har modtaget en ny leveringsanmodning.",
        delivery_expired = "Din leveringsanmodning er udløbet.",
        delivery_timeout = "Du nåede ikke at fuldføre leveringen i tide.",
        delivery_declined = "Du afviste leveringsanmodningen.",
        check_location = "Tjek din GPS for leveringsstedet.",
        check_location_error = "Ingen aktiv levering at spore.",
        delivery_accepted = "Levering Accepteret",
        invalid_item = "Ugyldig vare til levering",
        delivery_failed = "Levering Fejlede",
        invalid_items_data = "Ugyldige varedata",

        -- UI Text
        delivery_title = "Levering",
        close_menu = "Luk Menu",
        new_order = "Ny Ordre",
        in_progress = "I Gang",
        order_items = "Ordrevarer:",
        payment = "Betaling",
        delivery_status = "Leveringsstatus",
        deliver_instruction = "Lever maden til det markerede sted på kortet.",
        time_remaining = "Tid tilbage:",
        order_summary = "Ordreoversigt:",
        accept = "Accepter",
        decline = "Afvis",
        cancel_delivery = "Annuller Levering",

        -- Notifications
        delivery_accepted_notification = "Levering accepteret succesfuldt",
        delivery_cancelled_notification = "Levering annulleret succesfuldt",

        -- Status Messages
        complete_delivery = "Fuldfør Levering",
        delivery_in_progress = "Levering i gang...",
        head_to_location = "Kør til det markerede sted for at fuldføre leveringen",
    },

    Consumption = {
        title = "Forbrug",
        description = "Frisk og lækkert!",
        refresh_title = "Forfriskende",
        refresh_description = "Du føler dig forfrisket",
    },

    Crafting = {
        craft_title = "Fremstil %s",
        enter_amount_description = "Indtast antal at fremstille",
        crafting_successful = "Fremstilling Succes",
        crafted_description = "Fremstillede %d x %s",
        crafting_cancelled = "Fremstilling Annulleret",
        cancelled_description = "Du annullerede fremstillingen",
        no_space = "Ikke plads i inventar",
    },

    Targets = {
        door = "Bank på",
        door_icon = "fas fa-door-open",
        delivery_food = "Lever Mad",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "Bestillingstablet",
        ordering_tablet_error = "Bestillingstablet funktionen er ikke tilgængelig.",
        order_management_tablet = "Ordrestyringstablet",
        order_management_error = "Ordrestyringstablet funktionen er ikke tilgængelig.",
        return_utensils = "Returner Redskaber",
        employee_vending = "Medarbejderautomat",
    },

    Order = {
        complete = "Ordre Fuldført",
        description = "Din ordre er blevet behandlet. Regningen er tilføjet til dit inventar.",
        paycheck_suspended_description = "Lønudbetalinger er suspenderet mens virksomheden er lukket.",
        paycheck_suspended = "Løn Suspenderet",
    },

    Door = {
        title = "Dør ",
        description = "Døren er ",
        locked = "Døren er låst",
        no_permissions = "Ingen tilladelse til at låse/låse op for denne dør",
        access_denied_title = "Adgang Nægtet",
        access_granted = "Du låste døren op",
        access_denied = "Du har ikke adgang til denne dør",
    },

    Outfits = {
        title = "Tøj",
        invalid = "Ugyldigt køn",
        failed_equip = "Kunne ikke tage tøjet på",
        disabled = "Tøj er deaktiveret",
        civilian_clothes = "Skift til Civilt Tøj",
        reset_civilian_clothes = "Skiftede tilbage til civilt tøj",
        no_civilian_saved = "Intet civilt tøj gemt. Skift til uniform først.",
        no_permission = "Du har ikke tilladelse til at bruge dette tøj",
        outfit_not_found = "Tøj ikke fundet",
        equip_success = "Tøj skiftet succesfuldt",
        changed_to_uniform = "Skiftede til %s",
        reset_success = "Tøj nulstillet succesfuldt",
        no_civilian_for_reset = "Intet civilt tøj gemt. Skift til uniform og gem tøjet først.",
    },

    System = {
        success = "Succes",
        paycheck_error = "Lønfejl",
        inventory_full = "Inventar Fuld",
        inventory_full_description = "Dit inventar er fuldt.",
        society_not_found = "Virksomhed ikke fundet",
        business_funds_insufficient = "Virksomheden har ikke midler nok til at betale løn.",
        error = "Fejl",
        invalid = "Ugyldig",
        no_license = "Kunne ikke finde din licens. Kontakt en administrator.",
        missing_items = "Mangler Varer",
        item_cleaned = "Genstand rengjort succesfuldt",
        missing_required = "Mangler nødvendig genstand",
        slot_error = "Placer mængden i samme plads",
        ice_collected = "Is indsamlet",
        refreshing = "Forfrisker",
        refreshed = "Forfrisket",
        consumption = "Forbrug",
        stress_increased = "Stress Øget",
        stress_amount = "Dit stressniveau steg med %s",
        inventory_full = "Dit inventar er fuldt",
    },

    Experience = {
        gained_title = "Erfaring Opnået",
        experience_earned_description = "Du fik %d XP.",
        gained_message = "Du fik %d XP for at fuldføre leveringen!",
    },

    BossMenu = {
        title = "Chef Menu",
        unable_jobdetermine = "Kunne ikke bestemme dit job. Prøv igen senere.",
        bankruptcy_alert = "⚠️ Konkursvarsel",
        description = "Kan ikke betale lønninger! Forretningssaldo: $%s, Påkrævet: $%s",
        trans_failed_bossmenubalance = "Transaktion Fejlede - Utilstrakkelige Forretningsmidler",
        menu_in_use = "Chef menuen bruges i øjeblikket af %s.",
        no_permissions = "Du har ikke chef rettigheder! Du skal være chef.",
        wrong_job = "Du har ikke det rigtige job",
        grade_updated = "Jobgrad Opdateret",
        grade_update_success = "%s grad opdateret succesfuldt.",
        menu_update = "Menu Opdatering",
        menu_update_success = "Menuvalg opdateret succesfuldt!",
        vending_update = "Salgsautomat",
        vending_update_success = "Salgsautomat vare opdateret succesfuldt!",
        menu_update_error = "Kunne ikke opdatere menuvalg!",
        menu_delete = "Menu Slet",
        menu_delete_success = "Menuvalg slettet succesfuldt!",
        menu_delete_error = "Kunne ikke slette menuvalg!",
        invite_sent = "Invitation Sendt",
        invite_sent_success = "Job invitation sendt til %s",
        invite_error = "Ugyldigt spiller ID eller rolle!",
        player_not_found = "Spiller ikke fundet!",
        job_error = "Ugyldig invitationsdata!",
        job_accepted = "Du er nu %s hos %s",
        job_updated_title = "Job Opdateret",
        job_updated = "Din stilling blev opdateret til %s hos %s",
        database_error = "Dit job blev sat, men databaseopdatering fejlede.",
        invite_rejected = "Du afviste job invitationen.",
        withdraw_error = "Ugyldigt beløb!",
        business_error = "Virksomhed ikke fundet!",
        insufficient_funds = "Utilstrakkelige forretningsmidler!",
        money_withdrawn = "Du har hævet $%s fra forretningskontoen.",
        transaction_failed = "Kunne ikke opdatere forretningskonto!",
        money_deposited = "Du har indsat $%s på forretningskontoen.",
        transaction_failed_refund = "Kunne ikke opdatere forretningskonto! Dine penge er blevet returneret.",
        shop_purchase = "Nyt Butikskøb",
        shop_purchase_notification = "%s købte varer for $%s",
        menu_occupied = "Chef menu er i brug",
        menu_occupied_by = "%s bruger i øjeblikket chef menuen. Prøv igen senere.",
        menu_released = "Chef menu er nu tilgængelig",

        -- Main Headers and Titles
        business_overview = "Forretningsoversigt",
        business_settings = "Forretningsindstillinger",
        menu_management = "Menu Styring",
        staff_management = "Personale Styring",
        employee_leaderboard = "Medarbejder Rangliste",
        sales_transactions = "Salg & Transaktioner",

        -- Finance Section
        finance = "Økonomi",
        business_balance = "Forretningssaldo",
        withdraw = "Hæv",
        deposit = "Indsæt",
        withdraw_money = "Hæv Penge",
        deposit_money = "Indsæt Penge",
        enter_amount_withdraw = "Indtast beløbet du vil hæve fra forretningskontoen til din %s.",
        enter_amount_deposit = "Indtast beløbet du vil indsætte fra din %s til forretningskontoen.",
        available = "Tilgængelig",
        enter_amount = "Indtast beløb",
        withdraw_to = "Hæv til %s",
        deposit_from = "Indsæt fra %s",
        updating = "Opdaterer...",
        update_avatar = "Opdater Avatar",
        cancel = "Annuller",
        cash = "Kontant",
        bank = "Bank",
        invalid_url = "Ugyldig URL",
        invalid_url_message = "Indtast venligst en gyldig billede URL",
        avatar_updated = "Avatar Opdateret",
        avatar_updated_message = "Avatar opdateret succesfuldt!",
        update_failed = "Opdatering Fejlede",
        update_failed_message = "Kunne ikke opdatere avatar",
        business_status = "Forretningsstatus",
        business_status_desc = "Kontroller din forretnings driftsstatus",
        business_operations = "Forretningsdrift",
        business_open = "Modtager kunder - Fakturering er aktiveret",
        business_closed = "Lukket for kunder - Fakturering er deaktiveret",
        business_status_updated = "Forretningsstatus",
        business_now_open = "Forretningen er nu åben",
        business_now_closed = "Forretningen er nu lukket",
        business_status_error = "Fejl",
        business_status_failed = "Kunne ikke opdatere forretningsstatus",

        -- Employees Section
        employees = "Medarbejdere",
        invite_new_employee = "Inviter Ny Medarbejder",
        player_id = "Spiller ID...",
        invite = "Inviter",
        select_role = "Vælg Rolle",
        choose_role_for = "Vælg en rolle til %s",
        available_roles = "Tilgængelige Roller:",
        roles_available = "%d roller tilgængelige",
        send_invite = "Send Invitation",

        -- Sales Summary
        sales_summary = "Salgsoversigt",
        today = "I dag",
        this_week = "Denne Uge",
        this_month = "Denne Måned",
        view_sales = "Se Salg",

        -- Inventory Status
        inventory_status = "Lagerstatus",
        storage_capacity = "Lagerkapacitet",
        ingredients = "Ingredienser",
        supplies = "Forsyninger",
        manage_inventory = "Administrer Lager",

        -- Menu Management
        search_menu_items = "Søg i menuvalg...",
        edit_menu_item = "Rediger Menuvalg",
        update_item_details = "Opdater varedetaljerne nedenfor.",
        label_display_name = "Label (Visningsnavn)",
        price = "Pris ($)",
        category = "Kategori",
        select_category = "Vælg en kategori",
        update = "Opdater",
        all_items = "Alle Varer",
        no_menu_items = "Ingen menuvalg fundet",
        no_category_items = "Ingen %s fundet",

        -- Vending Machine Management
        vending_machine_management = "Salgsautomat Styring",
        search_vending_items = "Søg i automatvarer...",
        edit_vending_item = "Rediger Automatvare",
        update_vending_details = "Opdater varedetaljerne nedenfor.",
        all_vending_items = "Alle Varer",
        no_vending_items = "Ingen automatvarer fundet",
        no_category_vending_items = "Ingen %s fundet",
        vending_update_error = "Kunne ikke opdatere automatvare",
        item_price = "Pris",
        item_type = "Type",
        uncategorized = "Ukategoriseret",
        enter_price = "f.eks., 5",

        -- Staff Management
        employee_overview = "Medarbejderoversigt",
        total_employees = "Total Medarbejdere",
        active_employees = "Aktive Medarbejdere",
        pending_applications = "Afventende Ansøgninger",
        employee_list = "Medarbejderliste",
        search_employees = "Søg efter medarbejdere...",
        all_employees = "Alle Medarbejdere",
        name = "Navn",
        role = "Rolle",
        salary = "Løn",
        last_seen = "Sidst Set",
        actions = "Handlinger",
        promote = "Forfrem",
        demote = "Nedgrader",
        fire = "Fyr",
        employee_actions = "Medarbejderhandlinger",
        select_action = "Vælg en handling for %s",
        promote_employee = "Forfrem Medarbejder",
        demote_employee = "Nedgrader Medarbejder",
        fire_employee = "Fyr Medarbejder",
        confirm_action = "Bekræft Handling",
        confirm_promote = "Er du sikker på at du vil forfremme %s til %s?",
        confirm_demote = "Er du sikker på at du vil nedgradere %s til %s?",
        confirm_fire = "Er du sikker på at du vil fyre %s?",
        action_success = "Handling udført succesfuldt",
        action_failed = "Handling fejlede",
        employee_promoted = "Medarbejder forfremmet succesfuldt",
        employee_demoted = "Medarbejder nedgraderet succesfuldt",
        employee_fired = "Medarbejder fyret succesfuldt",
        no_employees = "Ingen medarbejdere fundet",

            -- Job Grades Management Dialog
        manage_job_grades = "Administrer Jobgrader",
        configure_salary_commission = "Konfigurer løn og provisionssatser for hver stilling",
        search_job_grades = "Søg i jobgrader...",
        edit_job_grade = "Rediger Jobgrad",
        update_job_grade_details = "Opdater jobgrad detaljer",
        job_title = "Jobtitel",
        commission_rate = "Provisionssats",
        boss_access = "Chef Adgang",
        boss_access_enabled = "Denne rolle har adgang til ledelsesfunktioner",
        boss_access_disabled = "Denne rolle har medarbejder niveau adgang",
        save_changes = "Gem Ændringer",
        boss_role = "Chef Rolle",
        grade_update_error = "Kunne ikke opdatere jobgrad",

        -- Employee Details View
        employee_overview = "Medarbejder Detaljer",
        employee_profile = "Medarbejder Profil",
        performance_stats = "Præstationsmålinger",
        back = "Tilbage",
        
        -- Employee Profile Card Labels
        commission = "Provision",
        total_earnings = "Samlet Indtjening",
        available_balance = "Tilgængelig Saldo",
        employee_id = "Medarbejder ID",
        
        -- Performance Stats Labels
        deliveries_label = "Leveringer",
        billings_label = "Faktureringer",
        earnings_label = "Indtjening",
        experience_label = "Erfaring",
        level_label = "Niveau",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "Indkomstfordeling",
        delivery_income = "Leveringer",
        commission_income = "Provision",
        paycheck_income = "Lønudbetalinger",
        completed_label = "fuldført",
        bills_label = "regninger",
        hourly_label = "Time",

        -- Employee Card Labels (for list view)
        rank_label = "Rang",
        commission_label = "Provision",

        -- Role Change Dialog
        no_role_employees = "Ingen %s fundet",
        employee_updated = "Medarbejder Opdateret",
        employee_commission_updated = "Medarbejder opdateret med %s provisionssats",
        fire_employee_error = "Kunne ikke fyre medarbejder",

        -- Employee Leaderboard
        top_performers = "Top Præsterende",
        this_month_leaders = "Denne Måneds Ledere",
        rank = "Rang",
        employee = "Medarbejder",
        performance = "Præstation",
        orders_completed = "Ordrer Fuldført",
        revenue_generated = "Omsætning Genereret",
        customer_rating = "Kunde Vurdering",
        no_data = "Ingen præstationsdata tilgængelig",

        -- Transactions
        transaction_history = "Transaktionshistorik",
        recent_transactions = "Seneste Transaktioner",
        paycheck_history = "Lønhistorik",
        transaction_type = "Transaktionstype",
        amount = "Beløb",
        date = "Dato",
        message = "Beskrivelse",
        customer = "Kunde",
        filter_transactions = "Filtrer transaktioner...",
        all_transactions = "Alle Transaktioner",
        sales_only = "Kun Salg",
        paychecks_only = "Kun Løn",
        no_transactions = "Ingen transaktioner fundet",
        no_paychecks = "Ingen lønoptegnelser fundet",


        -- Settings
        avatar_settings = "Avatar Indstillinger",
        update_profile_picture = "Opdater dit profilbillede",
        image_url = "Billede URL",
        enter_url_preview = "Indtast en URL nedenfor for at forhåndsvise din avatar",
        preview = "Forhåndsvisning",
        enter_url_message = "Indtast URL'en på dit avatar billede",
        ui_theme = "UI Tema",
        customize_appearance = "Tilpas udseendet af dashboardet",
        light_mode = "Lys Tilstand",
        dark_mode = "Mørk Tilstand",

        -- Navigation
        home = "Hjem",
        staff = "Personale",
        menu = "Menu",
        sales = "Salg",
        top = "Top",
        settings = "Indstillinger",

        -- Status Labels
        open = "Åben",
        closed = "Lukket",
        online = "Online",
        offline = "Offline",
        active = "Aktiv",
        inactive = "Inaktiv",

        -- Common Actions
        save = "Gem",
        edit = "Rediger",
        delete = "Slet",
        confirm = "Bekræft",
        close = "Luk",
        refresh = "Opdater",
        loading = "Indlæser...",

        -- Error Messages
        error_occurred = "Der opstod en fejl",
        invalid_input = "Ugyldigt input",
        operation_failed = "Operation fejlede",
        permission_denied = "Adgang nægtet",
        network_error = "Netværksfejl",
        data_load_failed = "Kunne ikke indlæse data",

        -- Success Messages
        operation_successful = "Operation fuldført succesfuldt",
        data_saved = "Data gemt succesfuldt",
        changes_applied = "Ændringer anvendt succesfuldt",
    },

    Shop = {
        shop_status = "Butik Status",
        shop_open = "Butikken er Åben",
        shop_closed = "Butikken er Lukket",
        access_denied = "Du har ikke adgang til denne butik!",
        purchase_title = "Butik",
        purchase_success = "Køb gennemført! Varer tilføjet til dit inventar.",
        purchase_error = "Betaling fejlede!",

        -- Search and Inventory
        search_placeholder = "Søg efter produkter ved navn...",
        clear_search = "Ryd søgning",
        shop_inventory = "Butiksinventar",
        items_count = "varer",

        -- Product Actions
        add_to_cart = "Tilføj",
        per_item = "pr/stk",

        -- Cart
        your_cart = "Din Kurv",
        cart_empty = "Kurven er Tom",
        cart_empty_message = "Tilføj varer for at begynde at handle",
        items_label = "varer",
        total = "I alt",

        -- Search Results
        no_items_found = "Ingen varer fundet",
        no_items_message = "Prøv at justere din søgning eller gennemse alle varer",

        -- Payment
        pay_with_cash = "Kontant",
        pay_with_bank = "Bank",
        processing = "Behandler...",
        inventory_notice = "Varer vil blive tilføjet direkte til dit inventar",

        -- Notifications
        cart_updated = "Kurv Opdateret",
        item_added = "Vare Tilføjet",
        item_removed = "Vare Fjernet",
        quantity_updated = "Antal Opdateret",
        purchase_complete = "Køb Gennemført",
        transaction_failed = "Transaktion Fejlede",
        checkout_error = "Betalingsfejl",
        cart_empty_error = "Din kurv er tom",
        paid_with_cash = "Betalt med kontanter",
        charged_to_bank = "Opkrævet fra din bankkonto",
        not_enough_cash = "Ikke nok kontanter",
        insufficient_bank = "Utilstrakkelig banksaldo",

        -- Quantity Messages
        added_more = "Tilføjede %d mere %s",
        removed_items = "Fjernede %d %s",
        added_to_cart = "%s tilføjet til kurv",
        removed_from_cart = "Fjernede %s fra din kurv",

        -- Loading
        loading_shop = "Indlæser Butiksmenu...",
    },

    EmployeeMenu = {
        access_denied = "Du har ikke adgang til denne portal!",
        commission_withdrawn = "Provision Hævet",
        commission_withdrawn_description = "Du har hævet $%s fra din provisionssaldo til din %s.",
        transaction_failed = "Transaktion Fejlede",
        fire_employee = "Fyr Medarbejder",
        commission_withdrawn_description = "Du har hævet $%s fra din provisionssaldo til din %s.",
        fire_employee_description = "%s er blevet fyret fra din forretning!",
        employeeMent_notice = "Medarbejder Varsel",
        
        no_employee_active = "Ingen medarbejdere er i øjeblikket online og aktive til at håndtere din ordre.",
        -- Main Headers and Navigation
        employee_portal = "Medarbejder Portal",
        employee_profile = "Medarbejder Profil",
        performance_stats = "Præstations Statistik",
        employee_leaderboard = "Medarbejder Rangliste",
        job_outfits = "Job Uniformer",
        account_settings = "Konto Indstillinger",

        -- Navigation Labels
        profile = "Profil",
        stats = "Statistik",
        top = "Top",
        outfits = "Uniformer",
        settings = "Indstillinger",

        -- Profile Tab
        personal_information = "Personlig Information",
        paycheck_information = "Løn Information",
        job_role = "Jobrolle",
        salary = "Løn",
        experience = "Erfaring",
        duty_status = "Vagtstatus",
        on_duty = "På Vagt",
        off_duty = "Fri",
        clock_in = "Stempel Ind",
        clock_out = "Stempel Ud",
        available_balance = "Tilgængelig Saldo",
        withdraw = "Hæv",
        withdraw_funds = "Hæv Midler",
        paycheck_interval = "Løninterval",
        total_deliveries = "Totale Leveringer",
        bills_created = "Regninger Oprettet",
        total_earnings = "Samlet Indtjening",
        minutes = "minutter",

        -- Performance Tab
        career_statistics = "Karriere Statistik",
        experience_points = "Erfaring",
        xp_points = "XP Point",
        total_earned = "Total Tjent",
        current_balance = "Nuværende Saldo",
        deliveries = "Leveringer",
        total_completed = "Total Fuldført",
        billings = "Faktureringer",
        invoices_created = "Fakturaer Oprettet",
        job_grade_progression = "Jobgrad Progression",
        current_grade = "Nuværende Grad",
        level = "Niveau",
        xp_needed_promotion = "XP nødvendig for forfremmelse",
        earn_more_xp = "Tjen %d mere XP for at blive forfremmet til %s",
        max_grade_reached = "Du har nået den højeste automatiske grad! Yderligere forfremmelser kræver ledelsens godkendelse.",
        promotions_by_management = "Forfremmelser tildeles af ledelsen.",
        loading_experience_data = "Indlæser erfaringssystem data...",
        loading_progression_data = "Indlæser progressionsdata...",

        -- Leaderboard Tab
        top_performers = "Top Præsterende",
        this_month_leaders = "Denne Måneds Ledere",
        rank = "Rang",
        employee = "Medarbejder",
        performance = "Præstation",
        no_leaderboard_data = "Ingen rangliste data tilgængelig",

        -- Outfits Tab
        work_outfits = "Arbejdsuniformer",
        select_outfit = "Vælg Uniform",
        change_outfit = "Skift Uniform",
        outfit_changed = "Uniform Skiftet",
        outfit_changed_success = "Din uniform er blevet skiftet succesfuldt!",
        outfit_change_failed = "Kunne ikke skifte uniform",
        outfit_preview = "Uniform Forhåndsvisning",

        -- Settings Tab
        employee_settings = "Medarbejder Indstillinger",
        avatar_settings = "Avatar Indstillinger",
        update_profile_picture = "Opdater dit profilbillede",
        image_url = "Billede URL",
        enter_url_preview = "Indtast en URL nedenfor for at forhåndsvise din avatar",
        preview = "Forhåndsvisning",
        enter_url_message = "Indtast URL'en på dit avatar billede",
        avatar_updated = "Avatar Opdateret",
        avatar_created = "Avatar Oprettet",
        avatar_updated_message = "Avatar opdateret succesfuldt!",
        update_failed = "Opdatering Fejlede",
        update_failed_message = "Kunne ikke opdatere avatar",
        invalid_url = "Ugyldig URL",
        invalid_url_message = "Indtast venligst en gyldig billede URL",
        updating = "Opdaterer...",
        update_avatar = "Opdater Avatar",

        -- UI Theme
        ui_theme = "UI Tema",
        customize_appearance = "Tilpas dashboard udseende",
        light_mode = "Lys Tilstand",
        dark_mode = "Mørk Tilstand",

        -- Notifications
        notifications = "Notifikationer",
        manage_notification_preferences = "Administrer notifikationsindstillinger",
        employee_notifications = "Medarbejder Notifikationer",
        notifications_enabled_desc = "Du vil modtage alle medarbejderløn opdateringer",
        notifications_disabled_desc = "Du vil ikke modtage notifikationer",
        notifications_updated = "Notifikationer Opdateret",
        notifications_enabled_message = "Lønnotifikationer er nu aktiveret",
        notifications_disabled_message = "Lønnotifikationer er nu deaktiveret",
        enabled = "Aktiveret",
        disabled = "Deaktiveret",

        -- Withdrawal Dialog
        withdraw_all_funds = "Hæv Alle Midler",
        select_balance_type = "Vælg Saldotype",
        all_balance = "Alt Saldo",
        delivery_balance = "Leveringssaldo",
        commission_balance = "Provisionssaldo",
        paycheck_balance = "Lønsaldo",
        available_balance_type = "Tilgængelig %s Saldo: $%d",
        enter_amount = "Indtast beløb",
        insufficient_funds = "Utilstrakkelige Midler",
        insufficient_balance = "Utilstrakkelig %s saldo",
        funds_withdrawn = "Midler Hævet",
        funds_withdrawn_success = "Hævede succesfuldt $%d fra din saldo",
        transaction_failed = "Transaktion Fejlede",
        withdrawal_failed = "Kunne ikke hæve midler",
        invalid_amount = "Ugyldigt Beløb",
        invalid_amount_message = "Indtast venligst et gyldigt beløb",
        no_funds = "Ingen Midler",
        no_funds_message = "Du har ingen midler at hæve",

        -- Common Actions
        cancel = "Annuller",
        save = "Gem",
        update = "Opdater",
        confirm = "Bekræft",
        close = "Luk",
        loading = "Indlæser...",

        -- Status Labels
        active = "Aktiv",
        inactive = "Inaktiv",
        online = "Online",
        offline = "Offline",

        -- Error Messages
        error_occurred = "Der opstod en fejl",
        operation_failed = "Operation fejlede",
        data_load_failed = "Kunne ikke indlæse data",
        network_error = "Netværksfejl",
        employee_data_error = "Kunne ikke hente dine medarbejderdata.",
        identity_error = "Kunne ikke bekræfte din identitet.",
        withdraw_invalid_amount = "Ugyldigt beløb!",
        insufficient_commission = "Utilstrakkelig provisionssaldo!",
        transaction_failed_update = "Kunne ikke opdatere provisionssaldo!",
        fire_employee_not_found = "Medarbejder ikke fundet!",
        fire_employee_wrong_business = "Denne medarbejder arbejder ikke for din forretning!",
        fire_employee_db_error = "Kunne ikke fyre medarbejder fra databasen!",
        employment_notice_fired = "Du er blevet fyret fra %s",
        avatar_invalid_url = "Ugyldig billede URL angivet.",
        avatar_updated_success = "Din profil avatar er blevet opdateret succesfuldt.",
        avatar_no_changes = "Ingen ændringer blev foretaget på din avatar.",
        avatar_created = "Din medarbejderprofil og avatar er blevet oprettet.",
        avatar_create_failed = "Kunne ikke oprette medarbejderoptegnelse.",
        withdrawal_invalid_amount = "Ugyldigt hævebeløb.",
        employee_record_not_found_withdraw = "Medarbejderoptegnelse ikke fundet.",
        insufficient_balance_withdraw = "Utilstrakkelige midler på din saldo.",
        withdraw_balance_failed = "Kunne ikke hæve fra saldo. Prøv venligst igen.",
        identity_error_toggle = "Kunne ikke bekræfte din identitet",
        invalid_grade_data = "Ugyldig graddata angivet.",
        grade_id_not_found = "Kunne ikke finde grad ID for denne rolle.",
        no_grade_changes = "Ingen ændringer blev foretaget på jobgraden.",
        balance_withdrawn = "Du hævede $%d fra din %s saldo til din %s.",
        player_not_found = "Spiller ikke fundet!",
        invalid_purchase_data = "Ugyldig købsdata!",
        insufficient_funds = "Ikke nok midler i din %s!",
        inventory_full = "Ikke nok inventarplads eller vægtgrænse overskredet!",
        purchase_complete = "Køb gennemført! Varer tilføjet til dit inventar.",
        shop_purchase = "Butikskøb: %s",
        business_balance_error = "Fejl ved opdatering af forretningssaldo for %s",
        business_balance_success = "Tilføjede succesfuldt $%s til forretningskonto",
        transaction_record_error = "Fejl ved registrering af transaktion for butikskøb",
        avatar_found = "Butik: Fandt avatar for %s: %s",
        avatar_not_found = "Butik: Ingen avatar fundet for %s, bruger standard",
    },

    Vending = {
        invalid_item_data = "Ugyldig varedata.",
        insufficient_item = "Du har ikke nok af denne vare.",
        item_added_with_money = "Vare tilføjet til lager. Modtog $%s for %sx %s",
        item_added = "Vare tilføjet til lager.",
        business_balance_error = "Fejl ved opdatering af forretningssaldo for bestilling",
        database_error = "Database Fejl",
        add_item_failed = "Kunne ikke tilføje vare.",
        invalid_collection_data = "Ugyldig afhentningsdata.",
        inventory_full = "Kunne ikke tilføje vare til dit inventar.",
        item_collected = "Hentede %sx %s",
        stock_update_failed = "Kunne ikke opdatere automatlager.",
        out_of_stock = "Udsolgt",
        insufficient_stock = "Ikke nok varer tilgængelige til at hente.",
        sale_transaction_error = "Fejl ved registrering af automatsalg transaktion",
        collection_transaction_error = "Fejl ved registrering af automathentning transaktion",
    },

    JobSystem = {
        no_permission = "Du har ikke tilladelse til at bruge denne kommando.",
        player_not_found = "Spiller ikke fundet.",
        job_assigned = "Job tildelt.",
        job_assign_failed = "Kunne ikke tildele job.",
        job_removed = "Job fjernet.",
        job_remove_failed = "Kunne ikke fjerne job.",
        job_changed_notification = "Job Ændret",
        job_changed = "Dit job er blevet ændret til %s (grad %s).",
        job_removed_notification = "Dit job er blevet fjernet.",
        give_job_usage = "Brug: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "Brug: /%s [playerId]",
        job_info = "Job: %s (Grad: %s, Vagt: %s)",
        job_info_error = "Kunne ikke hente din jobinfo.",
        duty_status = "Du er nu %s vagt.",
        not_on_duty = "Ikke På Vagt",
        must_be_on_duty = "Du skal være på vagt for at modtage løn.",
        paycheck_title = "Løn",
        employer_insufficient_funds = "Din chef har ikke nok midler til at betale dig.",
        paycheck_added = "Løn på $%s tilføjet til medarbejdersaldo for %s for job: %s",
        paycheck_received = "Du modtog en løn på $%s fra %s",
    },

    BillingInviteNotification = {
        message = "Du har modtaget en betalingsanmodning.",

        -- Titles / headers
        title = "Betalingsanmodning",
        label = "Faktureringsnotifikation",

        -- Button labels
        pay_button = "Betal Regning",
        decline_button = "Afvis",

        -- Small UI labels used inside the notification component
        business_label = "Forretning",
        total_amount_label = "Total Beløb",
        reason_label = "Årsag",
        amount_label = "Beløb:",

        -- Warning / helper texts
        warning_text = "Betaling vil blive trukket fra din konto. Sørg for tilstrækkelige midler.",
        expires_text = "Udløber om %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "Du er blevet inviteret til at deltage som %s hos Burgershot. Accepterer du?",

        -- Titles / headers
        title = "Job Invitation",
        label = "Job Invitationsnotifikation",

        -- Button labels
        accept_button = "Accepter",
        reject_button = "Afvis",

        -- Small UI labels used inside the notification component
        company_label = "Firma",
        grade_label = "Grad",
        invites_left_label = "Invitationer Tilbage",
        salary_label = "Løn",

        -- Warning / helper texts
        warning_text = "At acceptere dette job vil forpligte dig til rollen. Sørg for at du er klar til at starte.",
        expires_text = "Udløber om %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "Restaurant Menu",
        onduty = "Du skal være på vagt for at få adgang til restaurant menuen.",
    },

    Duty = {
        status = "Vagtstatus",
        management = "Vagtstyring",
        description = "Du er nu %s vagt.",
        restaurant_area = "Restaurant Område",
        clock_in = "Du er gået ind i restaurantområdet. Brug medarbejdermenuen til at stemple ind.",
        enter_workplace = "Du er gået ind på din arbejdsplads og er nu på vagt.",
        leave_workplace = "Du har forladt din arbejdsplads og er nu af vagt.",
        inside_workplace = "Du er inde på din arbejdsplads - automatisk sat til på vagt.",
        outside_workplace = "Du er uden for din arbejdsplads - automatisk sat til af vagt.",
        duty_warning = "Vagt Advarsel",
        auto_off_duty = "Du vil automatisk blive sat af vagt når du er uden for restauranten.",
        no_permission_manage_duty = "Du har ikke tilladelse til at administrere medarbejdervagtstatus",
        not_employee_of_job = "Spiller er ikke ansat i dette job",
        duty_set_by_management = "Din vagtstatus blev sat til %s af ledelsen",
        duty_management_success = "Satte succesfuldt %s's vagtstatus til %s",
        updated_offline_employee = "Opdaterede offline medarbejders vagtstatus",
    },

    Paycheck = {
        title = "Løn Modtaget",
        message = "Du modtog en løn på $%s fra %s",
    },

    VendingMachine = {
        sell_item = "Sælg Vare",
        select_item_from_inventory = "Vælg Vare fra Inventar",
        add_to_vending = "TILFØJ %s TIL AUTOMAT",
        cancel = "ANNULLER",
        no_matching_items = "Ingen matchende varer i inventar",
        stocked_items = "Lagerførte Varer",
        sell = "Sælg",
        no_stock = "Intet Lager",
        items = "varer på lager",
        ready_to_serve = "Klar til Servering!",
    },

    EmployeeVendingMachine = {
        title = "Hent fra Salgsautomat",
        label = "Hent varer fra automatlager",
        collect = "Hent",
        cancel = "Annuller",
        quantity_available = "Antal (Tilgængelig: %s)",
        collect_item = "Hent %s",
        collect_button = "Hent",
        in_stock = "På Lager",
        vending_machine_empty = "Denne salgsautomat er tom.",
    },

    OrderingTab = {
        where_eating_today = "Hvor vil du spise i dag?",
        eat_in = "Spis Her",
        take_out = "Take Away",
        whats_up = "hvad så?",
        popular = "Populær",
        done = "Færdig",
        my_order = "Min Ordre",
        empty = "Tom",
        total = "I alt",
        checkout = "Betaling",
        back = "Tilbage",
        no_menu_items = "Ingen menuvalg tilgængelige for %s",
        loading = "Indlæser...",
        eat_in_label = "Spis Her",
        take_out_label = "Take Away",
        pay_cash = "Kontant",
        cancel = "Annuller",
        order = "Bestil",
        pay_bank = "Bank",
        all_items = "Alle Varer",
        bank_only_disclaimer = "Betaling kan kun ske via bank.",
    },

    OrderManagementTable = {
        title = "Ordrestyringspanel",
        label = "Ordre Administration",
        filter_all = "Alle",
        filter_cooking = "Tilbereder",
        filter_ready = "Klar",
        filter_completed = "Fuldført",
        filter_terminal_orders = "Terminal Ordrer",
        filter_self_pickup = "Kiosk Ordrer",
        sort_by = "Sorter Efter",
        sort_day = "Dag",
        sort_amount = "Beløb",
        sort_name = "Navn",
        no_orders = "Ingen ordrer matcher det nuværende filter.",
        accept = "ACCEPTER",
        accepting = "ACCEPTERER...",
        cooking = "TILBEREDER",
        ready = "KLAR",
        complete = "FULDFØR",
        completed = "FULDFØRT",
        assigned_to = "Tildelt til: ",
        items_label = "Varer:",
        order_label = "Ordre #",
        status_cooking = "tilbereder",
        status_ready = "klar",
        status_completed = "fuldført",
        status_cancelled = "annulleret",
        self_pickup = "Selvhentning",
    },

    MenuSelectionDialog = {
        title = "Vælg Handling",
        subtitle = "Hvad vil du gerne gøre?",
        options = {
            shop = {
                title = "Åbn Butik",
                description = "Gennemse og køb varer fra salgsautomaten"
            },
            manageBoss = {
                title = "Administrer Butik",
                description = "Administrer lager, se analyser og styr salgsautomaten"
            },
            manageEmployee = {
                title = "Administrer Butik",
                description = "Tilføj og administrer lagerartikler i salgsautomaten"
            }
        }
    },
}