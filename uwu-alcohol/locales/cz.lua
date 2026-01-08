-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["cz"] = {
    
    WashHands = {
        title = "Umyvadlo",
        no_available = "Žádné umyvadlo není k dispozici",
        success = "Tvé ruce jsou nyní čisté!",
        error = "Chyba",
        fail = "Tvé ruce jsou již čisté!",
        targetfail = "Nejdřív si musíš umýt ruce!",
        item_cleaned = "Předmět byl úspěšně vyčištěn!",
        missing_required = "Chybí požadovaný předmět"
    },

    Terminal = {
        SubmitText = "Odeslat účet",

        -- Player Selection Tab
        select_player = "Vybrat hráče",
        nearby_players = "Hráči v okolí",
        search_players = "Hledat hráče...",
        no_players_found = "V okolí nebyli nalezeni žádní hráči",
        loading_players = "Načítání hráčů...",
        player_selected = "Hráč vybrán",

        -- Menu Items Tab
        menu_items = "Položky menu",
        items_added = "Položky přidány",
        search_menu_items = "Hledat položky menu...",
        available_items = "Dostupné položky",
        selected_items = "Vybrané položky",
        no_items_found = "Položky nenalezeny",
        no_items_selected = "Nebyly vybrány žádné položky",
        total_items = "Celkem položek",
        total = "Celkem",
        all = "Vše",

        -- Finalize Bill Tab
        finalize_bill = "Dokončit účet",
        customer_info = "Informace o zákazníkovi",
        order_summary = "Souhrn objednávky",
        amount_label = "Částka ($)",
        enter_amount = "Zadejte částku",
        reason_label = "Důvod (Volitelné)",
        reason_placeholder = "Zadejte důvod účtování",
        payment_method = "Způsob platby",
        cash = "Hotovost",
        bank = "Banka",
        send_bill = "Odeslat účet",

        -- Commission
        your_commission = "Tvoje provize",
        commission_rate = "Sazba provize",

        -- Bills sent counter
        bills_sent = "Odeslané účty:",
        commission = "Provize:",

        -- Error Messages
        bill_error = "Chyba účtování",
        select_player_error = "Vyberte prosím hráče",
        invalid_amount_error = "Zadejte prosím platnou částku",

        -- Success Messages
        bill_sent_success = "Účet byl úspěšně odeslán!",
        bill_sent_title = "Účet odeslán",
    },

    Consumable = {
        Drinking = "Pije ", -- Drinking ItemName
        Eating = "Jí " -- Eating ItemName
    },

    Garage = {
        title = "Garáž",
        no_vehicle = "Žádné vozidlo k vrácení",
        not_job_vehicle = "Toto není vozidlo Burgershot!",
        parked_title = "Vozidlo zaparkováno!",
        parked_message = "Tvé vozidlo bylo zaparkováno na tomto místě!",
        in_vehicle = "Nemůžeš být ve vozidle!",
        too_far = "Jsi příliš daleko od vozidla!",
        spawn_error = "Teď to nemůžeš udělat!",

        -- UI Text
        garage_title = "Garáž",
        garage_active_vehicles = "Aktivní",
        garage_manage = "Spravovat aktivní",
        close = "Zavřít",
        search_vehicles = "Hledat vozidla...",
        no_vehicles_found = "Vozidla nenalezena",
        dont_have_vehicle = "V této garáži nemáš uložená žádná vozidla.",
        select_vehicle = "Vybrat vozidlo",
        select_vehicle_message = "Vyberte vozidlo ze seznamu pro zobrazení podrobností a spawnutí.",
        back = "Zpět",
        spawn_vehicle = "Spawnout vozidlo",
        return_button = "Vrátit",
        return_vehicle = "Vrátit vozidlo",
        license_plate = "SPZ",

        -- Status Messages
        vehicle_spawned = "Vozidlo úspěšně spawnuto",
        no_vehicle_to_return = "Žádné vozidlo k vrácení",
        access_denied = "Nemáš přístup do této garáže.",
        all_spawn_points_blocked = "Všechna místa pro spawn jsou momentálně blokována, prosím čekejte.",
        vehicle_model_not_exist = "Model vozidla neexistuje",
        failed_load_model = "Nepodařilo se načíst model vozidla",
        failed_create_vehicle = "Nepodařilo se vytvořit vozidlo",
        invalid_vehicle_data = "Neplatná data modelu vozidla",

        -- Error Messages
        error = "Chyba",
        garage_error = "Chyba garáže",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "Nepodařilo se vytvořit entitu vozidla",
        no_spawn_points_available = "Žádná dostupná místa pro spawn",
        vehicle_returned_parked = "Vozidlo vráceno a zaparkováno.",
        vehicle_processed_remote = "Vozidlo zpracováno (vzdálené vrácení).",
    },

    Billing = {
        title = "Fakturace",
        payment_failed_byreceiver = "Platba selhala: %s nemá dostatek prostředků na zaplacení %s.",
        business_closed = "Fakturace je momentálně vypnuta vedením.",
        commission_earned = "Získána provize",
        commission_earned_description = "Získal jsi provizi $%s.",
        terminal_title = "Fakturační terminál",
        off_duty_error = "Musíš být ve službě, abys mohl používat fakturační terminál.",
        access_denied = "Nemáš přístup k fakturačnímu terminálu.",
        payment_received = "Platba přijata",
        payment_received_message = "Přijata platba $%s od %s",
        payment_failed = "Platba selhala",
        payment_failed_message = "Platba účtu selhala",
        bill_sent = "Účet odeslán",
        bill_sent_success = "Účet byl úspěšně odeslán!",
        bill_sent_error = "Nepodařilo se odeslat účet.",
        bill_error = "Chyba účtování",
        invalid_bill = "Neplatný účet!",
        invalid_bill_description = "Účet, který se snažíš zaplatit, neexistuje.",
        invalid_target_amount = "Neplatný cíl nebo částka!",
        player_not_found = "Hráč nenalezen!",
        must_be_on_duty = "Musíš být ve službě, abys mohl odeslat účet!",
        bill_sent_description = "Odeslán účet na $%s hráči %s za %s",
        bill_payment_successful = "✅ Platba účtu byla úspěšná",
        bill_payment_failed_insufficient = "❌ Platba účtu selhala - Nedostatek prostředků",
        bill_rejected = "❌ Účet byl zamítnut",
        insufficient_funds = "%s nemá dostatek!",
        order_processed = "🍔 Objednávka zpracována",
        command_access_denied = "Tento příkaz nemůžeš použít!",
        payment_failed_insufficient = "%s nemá dostatek!",
        bill_rejected_title = "Účet zamítnut",

        bill_rejected_sender = "%s zamítl tvůj účet na $%s",
        bill_rejected_receiver = "Zamítl jsi účet od %s",
        billing_disabled = "Fakturace je momentálně vypnuta vedením.",
        billing_off_duty = "Musíš být ve službě, abys mohl používat fakturaci.",
    },

    Delivery = {
        items_header = "Položky k doručení",
        reward_header = "Odměna",
        accept_header = "Přijmout doručení",
        decline_header = "Odmítnout doručení",
        menu_header = "Menu doručení",
        no_delivery = "Žádné aktivní doručení!",
        new_delivery_title = "Nové doručení",
        new_delivery_desc = "Obdržel jsi novou žádost o doručení.",
        delivery_expired = "Tvoje žádost o doručení vypršela.",
        delivery_timeout = "Nestihl jsi dokončit doručení včas.",
        delivery_declined = "Odmítl jsi žádost o doručení.",
        check_location = "Zkontroluj svou GPS pro místo doručení.",
        check_location_error = "Žádné aktivní doručení ke sledování.",
        delivery_accepted = "Doručení přijato",
        invalid_item = "Neplatná položka pro doručení",
        delivery_failed = "Doručení selhalo",
        invalid_items_data = "Neplatná data položek",

        -- UI Text
        delivery_title = "Doručení",
        close_menu = "Zavřít menu",
        new_order = "Nová objednávka",
        in_progress = "Probíhá",
        order_items = "Položky objednávky:",
        payment = "Platba",
        delivery_status = "Stav doručení",
        deliver_instruction = "Doruč jídlo na vyznačené místo na mapě.",
        time_remaining = "Zbývající čas:",
        order_summary = "Souhrn objednávky:",
        accept = "Přijmout",
        decline = "Odmítnout",
        cancel_delivery = "Zrušit doručení",

        -- Notifications
        delivery_accepted_notification = "Doručení úspěšně přijato",
        delivery_cancelled_notification = "Doručení úspěšně zrušeno",

        -- Status Messages
        complete_delivery = "Dokončit doručení",
        delivery_in_progress = "Doručení probíhá...",
        head_to_location = "Zamiř na vyznačené místo pro dokončení doručení",
    },

    Consumption = {
        title = "Konzumace",
        description = "Čerstvé a chutné!",
        refresh_title = "Osvěžení",
        refresh_description = "Byl jsi osvěžen",
    },

    Crafting = {
        craft_title = "Vyrobit %s",
        enter_amount_description = "Zadej množství k výrobě",
        crafting_successful = "Výroba úspěšná",
        crafted_description = "Vyrobeno %d x %s",
        crafting_cancelled = "Výroba zrušena",
        cancelled_description = "Zrušil jsi výrobu",
        no_space = "Nedostatek místa v inventáři",
    },

    Targets = {
        door = "Zaklepat na dveře",
        door_icon = "fas fa-door-open",
        delivery_food = "Doručit jídlo",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "Objednávkový tablet",
        ordering_tablet_error = "Funkce objednávkového tabletu není dostupná.",
        order_management_tablet = "Tablet správy objednávek",
        order_management_error = "Funkce tabletu správy objednávek není dostupná.",
        return_utensils = "Vrátit nádobí",
        employee_vending = "Zaměstnanecký automat",
    },

    Order = {
        complete = "Objednávka dokončena",
        description = "Tvoje objednávka byla zpracována. Účet byl přidán do tvého inventáře.",
        paycheck_suspended_description = "Výplaty jsou pozastaveny, zatímco je podnik zavřený.",
        paycheck_suspended = "Výplata pozastavena",
    },

    Door = {
        title = "Dveře ",
        description = "Dveře jsou ",
        locked = "Dveře jsou zamčené",
        no_permissions = "Nemáš oprávnění odemknout/zamknout tyto dveře",
        access_denied_title = "Přístup odepřen",
        access_granted = "Odemkl jsi dveře",
        access_denied = "Nemáš přístup k těmto dveřím",
    },

    Outfits = {
        title = "Oblečení",
        invalid = "Neplatné pohlaví",
        failed_equip = "Nepodařilo se obléknout oblečení",
        disabled = "Oblečení je vypnuto",
        civilian_clothes = "Změnit na civilní oblečení",
        reset_civilian_clothes = "Změněno zpět na civilní oblečení",
        no_civilian_saved = "Žádné uložené civilní oblečení. Nejdříve se převlékni do uniformy.",
        no_permission = "Nemáš oprávnění používat toto oblečení",
        outfit_not_found = "Oblečení nenalezeno",
        equip_success = "Oblečení úspěšně oblečeno",
        changed_to_uniform = "Změněno na %s",
        reset_success = "Oblečení úspěšně resetováno",
        no_civilian_for_reset = "Žádné uložené civilní oblečení. Nejdříve se převlékni do uniformy a ulož oblečení.",
    },

    System = {
        success = "Úspěch",
        paycheck_error = "Chyba výplaty",
        inventory_full = "Inventář plný",
        inventory_full_description = "Tvůj inventář je plný.",
        society_not_found = "Podnik nenalezen",
        business_funds_insufficient = "Podnik nemá dostatek prostředků na vyplacení mezd.",
        error = "Chyba",
        invalid = "Neplatné",
        no_license = "Nepodařilo se identifikovat tvou licenci. Kontaktuj administrátora.",
        missing_items = "Chybějící položky",
        item_cleaned = "Předmět úspěšně vyčištěn",
        missing_required = "Chybí požadovaný předmět",
        slot_error = "Umístěte množství do stejného slotu",
        ice_collected = "Led posbírán",
        refreshing = "Osvěžování",
        refreshed = "Osvěženo",
        consumption = "Konzumace",
        stress_increased = "Stres zvýšen",
        stress_amount = "Tvá úroveň stresu se zvýšila o %s",
        inventory_full = "Tvůj inventář je plný",
    },

    Experience = {
        gained_title = "Získána zkušenost",
        experience_earned_description = "Získal jsi %d XP.",
        gained_message = "Získal jsi %d XP za dokončení doručení!",
    },

    BossMenu = {
        title = "Menu šéfa",
        unable_jobdetermine = "Nepodařilo se určit tvou práci. Zkus to prosím později.",
        bankruptcy_alert = "⚠️ Upozornění na bankrot",
        description = "Nelze vyplatit mzdy! Zůstatek podniku: $%s, Požadováno: $%s",
        trans_failed_bossmenubalance = "Transakce selhala - Nedostatek firemních prostředků",
        menu_in_use = "Menu šéfa momentálně používá %s.",
        no_permissions = "Nemáš oprávnění šéfa! Musíš být šéf.",
        wrong_job = "Nemáš správnou práci",
        grade_updated = "Pracovní pozice aktualizována",
        grade_update_success = "Pozice %s úspěšně aktualizována.",
        menu_update = "Aktualizace menu",
        menu_update_success = "Položka menu úspěšně aktualizována!",
        vending_update = "Prodejní automat",
        vending_update_success = "Položka automatu úspěšně aktualizována!",
        menu_update_error = "Nepodařilo se aktualizovat položku menu!",
        menu_delete = "Smazat menu",
        menu_delete_success = "Položka menu úspěšně smazána!",
        menu_delete_error = "Nepodařilo se smazat položku menu!",
        invite_sent = "Pozvánka odeslána",
        invite_sent_success = "Pracovní pozvánka odeslána hráči %s",
        invite_error = "Neplatné ID hráče nebo role!",
        player_not_found = "Hráč nenalezen!",
        job_error = "Neplatná data pozvánky!",
        job_accepted = "Nyní jsi %s v %s",
        job_updated_title = "Práce aktualizována",
        job_updated = "Tvá pozice byla aktualizována na %s v %s",
        database_error = "Tvá práce byla nastavena, ale aktualizace databáze selhala.",
        invite_rejected = "Odmítl jsi pracovní pozvánku.",
        withdraw_error = "Neplatná částka!",
        business_error = "Podnik nenalezen!",
        insufficient_funds = "Nedostatek firemních prostředků!",
        money_withdrawn = "Vybral jsi $%s z firemního účtu.",
        transaction_failed = "Nepodařilo se aktualizovat firemní účet!",
        money_deposited = "Vložil jsi $%s na firemní účet.",
        transaction_failed_refund = "Nepodařilo se aktualizovat firemní účet! Tvé peníze byly vráceny.",
        shop_purchase = "Nový nákup v obchodě",
        shop_purchase_notification = "%s zakoupil položky za $%s",
        menu_occupied = "Menu šéfa je obsazeno",
        menu_occupied_by = "%s momentálně používá menu šéfa. Zkus to prosím později.",
        menu_released = "Menu šéfa je nyní k dispozici",

        -- Main Headers and Titles
        business_overview = "Přehled podniku",
        business_settings = "Nastavení podniku",
        menu_management = "Správa menu",
        staff_management = "Správa personálu",
        employee_leaderboard = "Žebříček zaměstnanců",
        sales_transactions = "Prodeje a transakce",

        -- Finance Section
        finance = "Finance",
        business_balance = "Zůstatek podniku",
        withdraw = "Vybrat",
        deposit = "Vložit",
        withdraw_money = "Vybrat peníze",
        deposit_money = "Vložit peníze",
        enter_amount_withdraw = "Zadej částku, kterou chceš vybrat z firemního účtu na svůj %s.",
        enter_amount_deposit = "Zadej částku, kterou chceš vložit ze svého %s na firemní účet.",
        available = "Dostupné",
        enter_amount = "Zadej částku",
        withdraw_to = "Vybrat na %s",
        deposit_from = "Vložit z %s",
        updating = "Aktualizace...",
        update_avatar = "Aktualizovat avatara",
        cancel = "Zrušit",
        cash = "Hotovost",
        bank = "Banka",
        invalid_url = "Neplatná URL",
        invalid_url_message = "Zadej prosím platnou URL obrázku",
        avatar_updated = "Avatar aktualizován",
        avatar_updated_message = "Avatar úspěšně aktualizován!",
        update_failed = "Aktualizace selhala",
        update_failed_message = "Nepodařilo se aktualizovat avatara",
        business_status = "Stav podniku",
        business_status_desc = "Ovládej provozní stav svého podniku",
        business_operations = "Firemní operace",
        business_open = "Momentálně přijímáme zákazníky - Fakturace je povolena",
        business_closed = "Momentálně zavřeno pro zákazníky - Fakturace je zakázána",
        business_status_updated = "Stav podniku",
        business_now_open = "Podnik je nyní otevřen",
        business_now_closed = "Podnik je nyní zavřen",
        business_status_error = "Chyba",
        business_status_failed = "Nepodařilo se aktualizovat stav podniku",

        -- Employees Section
        employees = "Zaměstnanci",
        invite_new_employee = "Pozvat nového zaměstnance",
        player_id = "ID hráče...",
        invite = "Pozvat",
        select_role = "Vybrat roli",
        choose_role_for = "Vyber roli pro %s",
        available_roles = "Dostupné role:",
        roles_available = "%d rolí k dispozici",
        send_invite = "Odeslat pozvánku",

        -- Sales Summary
        sales_summary = "Přehled prodejů",
        today = "Dnes",
        this_week = "Tento týden",
        this_month = "Tento měsíc",
        view_sales = "Zobrazit prodeje",

        -- Inventory Status
        inventory_status = "Stav zásob",
        storage_capacity = "Kapacita skladu",
        ingredients = "Ingredience",
        supplies = "Zásoby",
        manage_inventory = "Spravovat zásoby",

        -- Menu Management
        search_menu_items = "Hledat položky menu...",
        edit_menu_item = "Upravit položku menu",
        update_item_details = "Aktualizujte podrobnosti položky níže.",
        label_display_name = "Štítek (Zobrazovaný název)",
        price = "Cena ($)",
        category = "Kategorie",
        select_category = "Vyberte kategorii",
        update = "Aktualizovat",
        all_items = "Všechny položky",
        no_menu_items = "Nebyly nalezeny žádné položky menu",
        no_category_items = "Nenalezeno %s",

        -- Vending Machine Management
        vending_machine_management = "Správa prodejních automatů",
        search_vending_items = "Hledat položky automatu...",
        edit_vending_item = "Upravit položku automatu",
        update_vending_details = "Aktualizujte podrobnosti položky níže.",
        all_vending_items = "Všechny položky",
        no_vending_items = "Nebyly nalezeny žádné položky automatu",
        no_category_vending_items = "Nenalezeno %s",
        vending_update_error = "Nepodařilo se aktualizovat položku automatu",
        item_price = "Cena",
        item_type = "Typ",
        uncategorized = "Nezařazeno",
        enter_price = "např. 5",

        -- Staff Management
        employee_overview = "Přehled zaměstnanců",
        total_employees = "Celkem zaměstnanců",
        active_employees = "Aktivní zaměstnanci",
        pending_applications = "Čekající žádosti",
        employee_list = "Seznam zaměstnanců",
        search_employees = "Hledat zaměstnance...",
        all_employees = "Všichni zaměstnanci",
        name = "Jméno",
        role = "Role",
        salary = "Plat",
        last_seen = "Naposledy viděn",
        actions = "Akce",
        promote = "Povýšit",
        demote = "Degradovat",
        fire = "Propustit",
        employee_actions = "Akce zaměstnance",
        select_action = "Vyberte akci pro %s",
        promote_employee = "Povýšit zaměstnance",
        demote_employee = "Degradovat zaměstnance",
        fire_employee = "Propustit zaměstnance",
        confirm_action = "Potvrdit akci",
        confirm_promote = "Jste si jisti, že chcete povýšit %s na %s?",
        confirm_demote = "Jste si jisti, že chcete degradovat %s na %s?",
        confirm_fire = "Jste si jisti, že chcete propustit %s?",
        action_success = "Akce úspěšně dokončena",
        action_failed = "Akce selhala",
        employee_promoted = "Zaměstnanec úspěšně povýšen",
        employee_demoted = "Zaměstnanec úspěšně degradován",
        employee_fired = "Zaměstnanec úspěšně propuštěn",
        no_employees = "Žádní zaměstnanci nenalezeni",

            -- Job Grades Management Dialog
        manage_job_grades = "Spravovat pracovní pozice",
        configure_salary_commission = "Nakonfigurovat plat a provize pro každou pozici",
        search_job_grades = "Hledat pracovní pozice...",
        edit_job_grade = "Upravit pracovní pozici",
        update_job_grade_details = "Aktualizovat podrobnosti pozice",
        job_title = "Název práce",
        commission_rate = "Sazba provize",
        boss_access = "Přístup šéfa",
        boss_access_enabled = "Tato role má přístup k funkcím správy",
        boss_access_disabled = "Tato role má přístup na úrovni zaměstnance",
        save_changes = "Uložit změny",
        boss_role = "Role šéfa",
        grade_update_error = "Nepodařilo se aktualizovat pracovní pozici",

        -- Employee Details View
        employee_overview = "Podrobnosti o zaměstnanci",
        employee_profile = "Profil zaměstnance",
        performance_stats = "Metriky výkonu",
        back = "Zpět",
        
        -- Employee Profile Card Labels
        commission = "Provize",
        total_earnings = "Celkový výdělek",
        available_balance = "Dostupný zůstatek",
        employee_id = "ID zaměstnance",
        
        -- Performance Stats Labels
        deliveries_label = "Doručení",
        billings_label = "Fakturace",
        earnings_label = "Výdělek",
        experience_label = "Zkušenosti",
        level_label = "Úroveň",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "Rozdělení příjmů",
        delivery_income = "Doručení",
        commission_income = "Provize",
        paycheck_income = "Výplaty",
        completed_label = "dokončeno",
        bills_label = "účty",
        hourly_label = "Hodinový",

        -- Employee Card Labels (for list view)
        rank_label = "Hodnost",
        commission_label = "Provize",

        -- Role Change Dialog
        no_role_employees = "Nenalezeno %s",
        employee_updated = "Zaměstnanec aktualizován",
        employee_commission_updated = "Zaměstnanec aktualizován s provizí %s",
        fire_employee_error = "Nepodařilo se propustit zaměstnance",

        -- Employee Leaderboard
        top_performers = "Nejlepší výkony",
        this_month_leaders = "Lídři tohoto měsíce",
        rank = "Hodnost",
        employee = "Zaměstnanec",
        performance = "Výkon",
        orders_completed = "Dokončené objednávky",
        revenue_generated = "Vygenerované tržby",
        customer_rating = "Hodnocení zákazníků",
        no_data = "Žádná data o výkonu nejsou k dispozici",

        -- Transactions
        transaction_history = "Historie transakcí",
        recent_transactions = "Nedávné transakce",
        paycheck_history = "Historie výplat",
        transaction_type = "Typ transakce",
        amount = "Částka",
        date = "Datum",
        message = "Popis",
        customer = "Zákazník",
        filter_transactions = "Filtrovat transakce...",
        all_transactions = "Všechny transakce",
        sales_only = "Pouze prodeje",
        paychecks_only = "Pouze výplaty",
        no_transactions = "Nenalezeny žádné transakce",
        no_paychecks = "Nenalezeny žádné záznamy o výplatách",


        -- Settings
        avatar_settings = "Nastavení avatara",
        update_profile_picture = "Aktualizovat profilový obrázek",
        image_url = "URL obrázku",
        enter_url_preview = "Zadejte URL níže pro náhled avatara",
        preview = "Náhled",
        enter_url_message = "Zadejte URL obrázku avatara",
        ui_theme = "Téma UI",
        customize_appearance = "Přizpůsobit vzhled panelu",
        light_mode = "Světlý režim",
        dark_mode = "Tmavý režim",

        -- Navigation
        home = "Domů",
        staff = "Personál",
        menu = "Menu",
        sales = "Prodeje",
        top = "Top",
        settings = "Nastavení",

        -- Status Labels
        open = "Otevřeno",
        closed = "Zavřeno",
        online = "Online",
        offline = "Offline",
        active = "Aktivní",
        inactive = "Neaktivní",

        -- Common Actions
        save = "Uložit",
        edit = "Upravit",
        delete = "Smazat",
        confirm = "Potvrdit",
        close = "Zavřít",
        refresh = "Obnovit",
        loading = "Načítání...",

        -- Error Messages
        error_occurred = "Vyskytla se chyba",
        invalid_input = "Neplatný vstup",
        operation_failed = "Operace selhala",
        permission_denied = "Přístup odepřen",
        network_error = "Chyba sítě",
        data_load_failed = "Nepodařilo se načíst data",

        -- Success Messages
        operation_successful = "Operace úspěšně dokončena",
        data_saved = "Data úspěšně uložena",
        changes_applied = "Změny úspěšně aplikovány",
    },

    Shop = {
        shop_status = "Stav obchodu",
        shop_open = "Obchod je otevřen",
        shop_closed = "Obchod je zavřen",
        access_denied = "Nemáš přístup do tohoto obchodu!",
        purchase_title = "Obchod",
        purchase_success = "Nákup dokončen! Položky přidány do inventáře.",
        purchase_error = "Platba selhala!",

        -- Search and Inventory
        search_placeholder = "Hledat produkty podle názvu...",
        clear_search = "Vymazat hledání",
        shop_inventory = "Zásoby obchodu",
        items_count = "položky",

        -- Product Actions
        add_to_cart = "Přidat",
        per_item = "za/kus",

        -- Cart
        your_cart = "Tvůj košík",
        cart_empty = "Košík je prázdný",
        cart_empty_message = "Přidej položky a začni nakupovat",
        items_label = "položky",
        total = "Celkem",

        -- Search Results
        no_items_found = "Nebyly nalezeny žádné položky",
        no_items_message = "Zkuste upravit hledání nebo projděte všechny položky",

        -- Payment
        pay_with_cash = "Hotovost",
        pay_with_bank = "Banka",
        processing = "Zpracování...",
        inventory_notice = "Položky budou přidány přímo do tvého inventáře",

        -- Notifications
        cart_updated = "Košík aktualizován",
        item_added = "Položka přidána",
        item_removed = "Položka odebrrána",
        quantity_updated = "Množství aktualizováno",
        purchase_complete = "Nákup dokončen",
        transaction_failed = "Transakce selhala",
        checkout_error = "Chyba pokladny",
        cart_empty_error = "Tvůj košík je prázdný",
        paid_with_cash = "Zaplaceno hotovostí",
        charged_to_bank = "Strženo z bankovního účtu",
        not_enough_cash = "Nedostatek hotovosti",
        insufficient_bank = "Nedostatek prostředků na účtu",

        -- Quantity Messages
        added_more = "Přidáno %d více %s",
        removed_items = "Odebráno %d %s",
        added_to_cart = "%s přidáno do košíku",
        removed_from_cart = "Odebráno %s z košíku",

        -- Loading
        loading_shop = "Načítání menu obchodu...",
    },

    EmployeeMenu = {
        access_denied = "Nemáš přístup k tomuto portálu!",
        commission_withdrawn = "Provize vybrána",
        commission_withdrawn_description = "Vybral jsi $%s ze zůstatku provizí na svůj %s.",
        transaction_failed = "Transakce selhala",
        fire_employee = "Propustit zaměstnance",
        fire_employee_description = "%s byl propuštěn z tvého podniku!",
        employeeMent_notice = "Oznámení zaměstnanci",
        
        no_employee_active = "Žádní zaměstnanci momentálně nejsou online a aktivní, aby vyřídili tvou objednávku.",
        -- Main Headers and Navigation
        employee_portal = "Portál zaměstnanců",
        employee_profile = "Profil zaměstnance",
        performance_stats = "Statistiky výkonu",
        employee_leaderboard = "Žebříček zaměstnanců",
        job_outfits = "Pracovní uniformy",
        account_settings = "Nastavení účtu",

        -- Navigation Labels
        profile = "Profil",
        stats = "Statistiky",
        top = "Top",
        outfits = "Uniformy",
        settings = "Nastavení",

        -- Profile Tab
        personal_information = "Osobní informace",
        paycheck_information = "Informace o výplatě",
        job_role = "Pracovní role",
        salary = "Plat",
        experience = "Zkušenosti",
        duty_status = "Stav služby",
        on_duty = "Ve službě",
        off_duty = "Mimo službu",
        clock_in = "Příchod",
        clock_out = "Odchod",
        available_balance = "Dostupný zůstatek",
        withdraw = "Vybrat",
        withdraw_funds = "Vybrat prostředky",
        paycheck_interval = "Interval výplaty",
        total_deliveries = "Celkem doručení",
        bills_created = "Vytvořené účty",
        total_earnings = "Celkový výdělek",
        minutes = "minuty",

        -- Performance Tab
        career_statistics = "Kariérní statistiky",
        experience_points = "Zkušenosti",
        xp_points = "XP Body",
        total_earned = "Celkem vyděláno",
        current_balance = "Aktuální zůstatek",
        deliveries = "Doručení",
        total_completed = "Celkem dokončeno",
        billings = "Fakturace",
        invoices_created = "Vytvořené faktury",
        job_grade_progression = "Postup pracovní pozice",
        current_grade = "Aktuální pozice",
        level = "Úroveň",
        xp_needed_promotion = "XP potřebné pro povýšení",
        earn_more_xp = "Získej %d více XP pro povýšení na %s",
        max_grade_reached = "Dosáhl jsi nejvyšší automatické pozice! Další povýšení vyžadují schválení vedením.",
        promotions_by_management = "Povýšení jsou přidělována vedením.",
        loading_experience_data = "Načítání dat systému zkušeností...",
        loading_progression_data = "Načítání dat postupu...",

        -- Leaderboard Tab
        top_performers = "Nejlepší výkony",
        this_month_leaders = "Lídři tohoto měsíce",
        rank = "Hodnost",
        employee = "Zaměstnanec",
        performance = "Výkon",
        no_leaderboard_data = "Žádná data žebříčku nejsou k dispozici",

        -- Outfits Tab
        work_outfits = "Pracovní uniformy",
        select_outfit = "Vybrat uniformu",
        change_outfit = "Změnit uniformu",
        outfit_changed = "Uniforma změněna",
        outfit_changed_success = "Tvá uniforma byla úspěšně změněna!",
        outfit_change_failed = "Nepodařilo se změnit uniformu",
        outfit_preview = "Náhled uniformy",

        -- Settings Tab
        employee_settings = "Nastavení zaměstnance",
        avatar_settings = "Nastavení avatara",
        update_profile_picture = "Aktualizovat profilový obrázek",
        image_url = "URL obrázku",
        enter_url_preview = "Zadejte URL níže pro náhled avatara",
        preview = "Náhled",
        enter_url_message = "Zadejte URL obrázku avatara",
        avatar_updated = "Avatar aktualizován",
        avatar_created = "Avatar vytvořen",
        avatar_updated_message = "Avatar úspěšně aktualizován!",
        update_failed = "Aktualizace selhala",
        update_failed_message = "Nepodařilo se aktualizovat avatara",
        invalid_url = "Neplatná URL",
        invalid_url_message = "Zadej prosím platnou URL obrázku",
        updating = "Aktualizace...",
        update_avatar = "Aktualizovat avatara",

        -- UI Theme
        ui_theme = "Téma UI",
        customize_appearance = "Přizpůsobit vzhled panelu",
        light_mode = "Světlý režim",
        dark_mode = "Tmavý režim",

        -- Notifications
        notifications = "Oznámení",
        manage_notification_preferences = "Spravovat nastavení oznámení",
        employee_notifications = "Oznámení zaměstnance",
        notifications_enabled_desc = "Budeš dostávat všechny aktualizace o výplatách",
        notifications_disabled_desc = "Nebudeš dostávat oznámení",
        notifications_updated = "Oznámení aktualizována",
        notifications_enabled_message = "Oznámení o výplatách jsou nyní povolena",
        notifications_disabled_message = "Oznámení o výplatách jsou nyní zakázána",
        enabled = "Povoleno",
        disabled = "Zakázáno",

        -- Withdrawal Dialog
        withdraw_all_funds = "Vybrat všechny prostředky",
        select_balance_type = "Vybrat typ zůstatku",
        all_balance = "Celkový zůstatek",
        delivery_balance = "Zůstatek doručení",
        commission_balance = "Zůstatek provizí",
        paycheck_balance = "Zůstatek výplat",
        available_balance_type = "Dostupný zůstatek %s: $%d",
        enter_amount = "Zadej částku",
        insufficient_funds = "Nedostatek prostředků",
        insufficient_balance = "Nedostatečný zůstatek %s",
        funds_withdrawn = "Prostředky vybrány",
        funds_withdrawn_success = "Úspěšně vybráno $%d z tvého zůstatku",
        transaction_failed = "Transakce selhala",
        withdrawal_failed = "Nepodařilo se vybrat prostředky",
        invalid_amount = "Neplatná částka",
        invalid_amount_message = "Zadej prosím platnou částku",
        no_funds = "Žádné prostředky",
        no_funds_message = "Nemáš žádné prostředky k výběru",

        -- Common Actions
        cancel = "Zrušit",
        save = "Uložit",
        update = "Aktualizovat",
        confirm = "Potvrdit",
        close = "Zavřít",
        loading = "Načítání...",

        -- Status Labels
        active = "Aktivní",
        inactive = "Neaktivní",
        online = "Online",
        offline = "Offline",

        -- Error Messages
        error_occurred = "Vyskytla se chyba",
        operation_failed = "Operace selhala",
        data_load_failed = "Nepodařilo se načíst data",
        network_error = "Chyba sítě",
        employee_data_error = "Nepodařilo se načíst data zaměstnance.",
        identity_error = "Nepodařilo se ověřit tvou identitu.",
        withdraw_invalid_amount = "Neplatná částka!",
        insufficient_commission = "Nedostatečný zůstatek provizí!",
        transaction_failed_update = "Nepodařilo se aktualizovat zůstatek provizí!",
        fire_employee_not_found = "Zaměstnanec nenalezen!",
        fire_employee_wrong_business = "Tento zaměstnanec nepracuje pro tvůj podnik!",
        fire_employee_db_error = "Nepodařilo se propustit zaměstnance z databáze!",
        employment_notice_fired = "Byl jsi propuštěn z %s",
        avatar_invalid_url = "Poskytnuta neplatná URL obrázku.",
        avatar_updated_success = "Tvůj profilový avatar byl úspěšně aktualizován.",
        avatar_no_changes = "Nebyly provedeny žádné změny avatara.",
        avatar_created = "Tvůj profil zaměstnance a avatar byly vytvořeny.",
        avatar_create_failed = "Nepodařilo se vytvořit záznam zaměstnance.",
        withdrawal_invalid_amount = "Neplatná částka výběru.",
        employee_record_not_found_withdraw = "Záznam zaměstnance nenalezen.",
        insufficient_balance_withdraw = "Nedostatek prostředků na zůstatku.",
        withdraw_balance_failed = "Nepodařilo se vybrat ze zůstatku. Zkus to prosím znovu.",
        identity_error_toggle = "Nepodařilo se ověřit tvou identitu",
        invalid_grade_data = "Poskytnuta neplatná data pozice.",
        grade_id_not_found = "Nepodařilo se najít ID pozice pro tuto roli.",
        no_grade_changes = "Nebyly provedeny žádné změny pracovní pozice.",
        balance_withdrawn = "Vybral jsi $%d z tvého zůstatku %s na svůj %s.",
        player_not_found = "Hráč nenalezen!",
        invalid_purchase_data = "Neplatná data nákupu!",
        insufficient_funds = "Nedostatek prostředků v tvé %s!",
        inventory_full = "Nedostatek místa v inventáři nebo překročen limit váhy!",
        purchase_complete = "Nákup dokončen! Položky přidány do inventáře.",
        shop_purchase = "Nákup v obchodě: %s",
        business_balance_error = "Chyba při aktualizaci zůstatku podniku pro %s",
        business_balance_success = "Úspěšně přidáno $%s na firemní účet",
        transaction_record_error = "Chyba při záznamu transakce nákupu v obchodě",
        avatar_found = "Obchod: Nalezen avatar pro %s: %s",
        avatar_not_found = "Obchod: Nenalezen avatar pro %s, použit výchozí",
    },

    Vending = {
        invalid_item_data = "Neplatná data položky.",
        insufficient_item = "Nemáš dostatek této položky.",
        item_added_with_money = "Položka přidána do skladu. Obdrženo $%s za %sx %s",
        item_added = "Položka přidána do skladu.",
        business_balance_error = "Chyba při aktualizaci zůstatku podniku pro objednávku",
        database_error = "Chyba databáze",
        add_item_failed = "Nepodařilo se přidat položku.",
        invalid_collection_data = "Neplatná data vyzvednutí.",
        inventory_full = "Nepodařilo se přidat položku do inventáře.",
        item_collected = "Vyzvednuto %sx %s",
        stock_update_failed = "Nepodařilo se aktualizovat sklad automatu.",
        out_of_stock = "Vyprodáno",
        insufficient_stock = "Není dostatek položek k vyzvednutí.",
        sale_transaction_error = "Chyba při záznamu transakce prodeje v automatu",
        collection_transaction_error = "Chyba při záznamu transakce vyzvednutí z automatu",
    },

    JobSystem = {
        no_permission = "Nemáš oprávnění použít tento příkaz.",
        player_not_found = "Hráč nenalezen.",
        job_assigned = "Práce přidělena.",
        job_assign_failed = "Nepodařilo se přidělit práci.",
        job_removed = "Práce odebrána.",
        job_remove_failed = "Nepodařilo se odebrat práci.",
        job_changed_notification = "Práce změněna",
        job_changed = "Tvá práce byla změněna na %s (pozice %s).",
        job_removed_notification = "Tvá práce byla odebrána.",
        give_job_usage = "Použití: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "Použití: /%s [playerId]",
        job_info = "Práce: %s (Pozice: %s, Služba: %s)",
        job_info_error = "Nepodařilo se získat informace o tvé práci.",
        duty_status = "Nyní jsi %s službě.",
        not_on_duty = "Mimo službu",
        must_be_on_duty = "Musíš být ve službě, abys dostal výplatu.",
        paycheck_title = "Výplata",
        employer_insufficient_funds = "Tvůj šéf nemá dostatek prostředků, aby tě zaplatil.",
        paycheck_added = "Výplata $%s přidána k zůstatku zaměstnance %s za práci: %s",
        paycheck_received = "Obdržel jsi výplatu $%s od %s",
    },

    BillingInviteNotification = {
        message = "Obdržel jsi žádost o platbu.",

        -- Titles / headers
        title = "Žádost o platbu",
        label = "Upozornění na fakturaci",

        -- Button labels
        pay_button = "Zaplatit účet",
        decline_button = "Odmítnout",

        -- Small UI labels used inside the notification component
        business_label = "Podnik",
        total_amount_label = "Celková částka",
        reason_label = "Důvod",
        amount_label = "Částka:",

        -- Warning / helper texts
        warning_text = "Platba bude stržena z tvého účtu. Zajisti dostatek prostředků.",
        expires_text = "Vyprší za %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "Byl jsi pozván, aby ses připojil jako %s v Burgershot. Přijímáš?",

        -- Titles / headers
        title = "Pracovní pozvánka",
        label = "Upozornění na pracovní pozvánku",

        -- Button labels
        accept_button = "Přijmout",
        reject_button = "Odmítnout",

        -- Small UI labels used inside the notification component
        company_label = "Společnost",
        grade_label = "Pozice",
        invites_left_label = "Zbývající pozvánky",
        salary_label = "Plat",

        -- Warning / helper texts
        warning_text = "Přijetím této práce se zavazuješ k roli. Ujisti se, že jsi připraven začít.",
        expires_text = "Vyprší za %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "Menu restaurace",
        onduty = "Musíš být ve službě pro přístup k menu restaurace.",
    },

    Duty = {
        status = "Stav služby",
        management = "Správa služby",
        description = "Nyní jsi %s službě.",
        restaurant_area = "Oblast restaurace",
        clock_in = "Vstoupil jsi do oblasti restaurace. Použij menu zaměstnance k přihlášení.",
        enter_workplace = "Vstoupil jsi na pracoviště a jsi nyní ve službě.",
        leave_workplace = "Opustil jsi pracoviště a jsi nyní mimo službu.",
        inside_workplace = "Jsi uvnitř pracoviště - automaticky nastaveno na službu.",
        outside_workplace = "Jsi mimo pracoviště - automaticky nastaveno mimo službu.",
        duty_warning = "Upozornění služby",
        auto_off_duty = "Budeš automaticky nastaven mimo službu, když budeš mimo restauraci.",
        no_permission_manage_duty = "Nemáš oprávnění spravovat stav služby zaměstnanců",
        not_employee_of_job = "Hráč není zaměstnancem této práce",
        duty_set_by_management = "Tvůj stav služby byl nastaven na %s vedením",
        duty_management_success = "Úspěšně nastaven stav služby %s na %s",
        updated_offline_employee = "Aktualizován stav služby offline zaměstnance",
    },

    Paycheck = {
        title = "Výplata přijata",
        message = "Obdržel jsi výplatu $%s od %s",
    },

    VendingMachine = {
        sell_item = "Prodat položku",
        select_item_from_inventory = "Vybrat položku z inventáře",
        add_to_vending = "PŘIDAT %s DO AUTOMATU",
        cancel = "ZRUŠIT",
        no_matching_items = "Žádné odpovídající položky v inventáři",
        stocked_items = "Skladové položky",
        sell = "Prodat",
        no_stock = "Žádný sklad",
        items = "položky na skladě",
        ready_to_serve = "Připraveno k podávání!",
    },

    EmployeeVendingMachine = {
        title = "Vyzvednout z automatu",
        label = "Vyzvednout položky ze skladu automatu",
        collect = "Vyzvednout",
        cancel = "Zrušit",
        quantity_available = "Množství (Dostupné: %s)",
        collect_item = "Vyzvednout %s",
        collect_button = "Vyzvednout",
        in_stock = "Na skladě",
        vending_machine_empty = "Tento prodejní automat je prázdný.",
    },

    OrderingTab = {
        where_eating_today = "Kde budete dnes jíst?",
        eat_in = "Tady",
        take_out = "S sebou",
        whats_up = "co se děje?",
        popular = "Populární",
        done = "Hotovo",
        my_order = "Moje objednávka",
        empty = "Prázdné",
        total = "Celkem",
        checkout = "Pokladna",
        back = "Zpět",
        no_menu_items = "Žádné položky menu nejsou k dispozici pro %s",
        loading = "Načítání...",
        eat_in_label = "Tady",
        take_out_label = "S sebou",
        pay_cash = "Hotovost",
        cancel = "Zrušit",
        order = "Objednat",
        pay_bank = "Banka",
        all_items = "Všechny položky",
        bank_only_disclaimer = "Platbu lze provést pouze bankovním převodem.",
    },

    OrderManagementTable = {
        title = "Panel správy objednávek",
        label = "Administrace objednávek",
        filter_all = "Vše",
        filter_cooking = "Vaření",
        filter_ready = "Připraveno",
        filter_completed = "Dokončeno",
        filter_terminal_orders = "Objednávky terminálu",
        filter_self_pickup = "Objednávky kiosku",
        sort_by = "Seřadit podle",
        sort_day = "Den",
        sort_amount = "Částka",
        sort_name = "Jméno",
        no_orders = "Žádné objednávky neodpovídají aktuálnímu filtru.",
        accept = "PŘIJMOUT",
        accepting = "PŘIJÍMÁNÍ...",
        cooking = "VAŘENÍ",
        ready = "PŘIPRAVENO",
        complete = "DOKONČIT",
        completed = "DOKONČENO",
        assigned_to = "Přiřazeno k: ",
        items_label = "Položky:",
        order_label = "Objednávka #",
        status_cooking = "vaření",
        status_ready = "připraveno",
        status_completed = "dokončeno",
        status_cancelled = "zrušeno",
        self_pickup = "Vlastní odběr",
    },

    MenuSelectionDialog = {
        title = "Vybrat Akci",
        subtitle = "Co byste chtěli dělat?",
        options = {
            shop = {
                title = "Otevřít Obchod",
                description = "Procházet a kupovat položky z prodejního automatu"
            },
            manageBoss = {
                title = "Spravovat Obchod",
                description = "Spravovat inventář, zobrazit analýzy a ovládat prodejní automat"
            },
            manageEmployee = {
                title = "Spravovat Obchod",
                description = "Přidat a spravovat položky inventáře v prodejním automatu"
            }
        }
    },
}