-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["ge"] = {
    
    WashHands = {
        title = "Waschbecken",
        no_available = "Kein Waschbecken verfügbar",
        success = "Deine Hände sind jetzt sauber!",
        error = "Fehler",
        fail = "Deine Hände sind bereits sauber!",
        targetfail = "Du musst dir zuerst die Hände waschen!",
        item_cleaned = "Gegenstand erfolgreich gereinigt!",
        missing_required = "Benötigter Gegenstand fehlt"
    },

    Terminal = {
        SubmitText = "Rechnung senden",

        -- Player Selection Tab
        select_player = "Spieler auswählen",
        nearby_players = "Spieler in der Nähe",
        search_players = "Spieler suchen...",
        no_players_found = "Keine Spieler in der Nähe gefunden",
        loading_players = "Lade Spieler...",
        player_selected = "Spieler ausgewählt",

        -- Menu Items Tab
        menu_items = "Menüpunkte",
        items_added = "Artikel hinzugefügt",
        search_menu_items = "Menüpunkte suchen...",
        available_items = "Verfügbare Artikel",
        selected_items = "Ausgewählte Artikel",
        no_items_found = "Keine Artikel gefunden",
        no_items_selected = "Keine Artikel ausgewählt",
        total_items = "Gesamtartikel",
        total = "Gesamt",
        all = "Alle",

        -- Finalize Bill Tab
        finalize_bill = "Rechnung abschließen",
        customer_info = "Kundeninfo",
        order_summary = "Bestellübersicht",
        amount_label = "Betrag ($)",
        enter_amount = "Betrag eingeben",
        reason_label = "Grund (Optional)",
        reason_placeholder = "Grund für die Rechnung eingeben",
        payment_method = "Zahlungsmethode",
        cash = "Bar",
        bank = "Bank",
        send_bill = "Rechnung senden",

        -- Commission
        your_commission = "Deine Provision",
        commission_rate = "Provisionssatz",

        -- Bills sent counter
        bills_sent = "Gesendete Rechnungen:",
        commission = "Provision:",

        -- Error Messages
        bill_error = "Rechnungsfehler",
        select_player_error = "Bitte wähle einen Spieler aus",
        invalid_amount_error = "Bitte gib einen gültigen Betrag ein",

        -- Success Messages
        bill_sent_success = "Rechnung erfolgreich gesendet!",
        bill_sent_title = "Rechnung gesendet",
    },

    Consumable = {
        Drinking = "Trinkt ", -- Drinking ItemName
        Eating = "Isst " -- Eating ItemName
    },

    Garage = {
        title = "Garage",
        no_vehicle = "Kein Fahrzeug zum Rückgeben",
        not_job_vehicle = "Dies ist kein Burgershot-Fahrzeug!",
        parked_title = "Fahrzeug geparkt!",
        parked_message = "Dein Fahrzeug wurde an diesem Ort geparkt!",
        in_vehicle = "Du darfst nicht im Fahrzeug sitzen!",
        too_far = "Zu weit vom Fahrzeug entfernt!",
        spawn_error = "Das kannst du jetzt nicht tun!",

        -- UI Text
        garage_title = "Garage",
        garage_active_vehicles = "Aktiv",
        garage_manage = "Aktive verwalten",
        close = "Schließen",
        search_vehicles = "Fahrzeuge suchen...",
        no_vehicles_found = "Keine Fahrzeuge gefunden",
        dont_have_vehicle = "Du hast keine Fahrzeuge in dieser Garage gelagert.",
        select_vehicle = "Fahrzeug auswählen",
        select_vehicle_message = "Wähle ein Fahrzeug aus der Liste, um Details zu sehen und es auszuparken.",
        back = "Zurück",
        spawn_vehicle = "Fahrzeug ausparken",
        return_button = "Zurückgeben",
        return_vehicle = "Fahrzeug zurückgeben",
        license_plate = "Kennzeichen",

        -- Status Messages
        vehicle_spawned = "Fahrzeug erfolgreich ausgeparkt",
        no_vehicle_to_return = "Kein Fahrzeug zum Rückgeben",
        access_denied = "Du hast keinen Zugriff auf diese Garage.",
        all_spawn_points_blocked = "Alle Ausparkpunkte sind derzeit blockiert, bitte warte.",
        vehicle_model_not_exist = "Fahrzeugmodell existiert nicht",
        failed_load_model = "Laden des Fahrzeugmodells fehlgeschlagen",
        failed_create_vehicle = "Erstellen des Fahrzeugs fehlgeschlagen",
        invalid_vehicle_data = "Ungültige Fahrzeugmodelldaten",

        -- Error Messages
        error = "Fehler",
        garage_error = "Garagenfehler",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "Erstellen der Fahrzeug-Entity fehlgeschlagen",
        no_spawn_points_available = "Keine Ausparkpunkte verfügbar",
        vehicle_returned_parked = "Fahrzeug zurückgegeben und geparkt.",
        vehicle_processed_remote = "Fahrzeug verarbeitet (Fernrückgabe).",
    },

    Billing = {
        title = "Abrechnung",
        payment_failed_byreceiver = "Zahlung fehlgeschlagen: %s hat nicht genug Geld, um %s zu bezahlen.",
        business_closed = "Abrechnung ist derzeit vom Management deaktiviert.",
        commission_earned = "Provision verdient",
        commission_earned_description = "Du hast $%s Provision verdient.",
        terminal_title = "Abrechnungsterminal",
        off_duty_error = "Du musst im Dienst sein, um das Terminal zu nutzen.",
        access_denied = "Du hast keinen Zugriff auf das Abrechnungsterminal.",
        payment_received = "Zahlung erhalten",
        payment_received_message = "Zahlung von $%s von %s erhalten",
        payment_failed = "Zahlung fehlgeschlagen",
        payment_failed_message = "Rechnungszahlung fehlgeschlagen",
        bill_sent = "Rechnung gesendet",
        bill_sent_success = "Rechnung erfolgreich gesendet!",
        bill_sent_error = "Senden der Rechnung fehlgeschlagen.",
        bill_error = "Rechnungsfehler",
        invalid_bill = "Ungültige Rechnung!",
        invalid_bill_description = "Die Rechnung, die du bezahlen willst, existiert nicht.",
        invalid_target_amount = "Ungültiges Ziel oder Betrag!",
        player_not_found = "Spieler nicht gefunden!",
        must_be_on_duty = "Du musst im Dienst sein, um eine Rechnung zu senden!",
        bill_sent_description = "Rechnung über $%s an %s für %s gesendet",
        bill_payment_successful = "✅ Rechnungszahlung erfolgreich",
        bill_payment_failed_insufficient = "❌ Rechnungszahlung fehlgeschlagen - Unzureichende Mittel",
        bill_rejected = "❌ Rechnung abgelehnt",
        insufficient_funds = "%s hat nicht genug!",
        order_processed = "🍔 Bestellung verarbeitet",
        command_access_denied = "Du kannst diesen Befehl nicht verwenden!",
        payment_failed_insufficient = "%s hat nicht genug!",
        bill_rejected_title = "Rechnung abgelehnt",

        bill_rejected_sender = "%s hat deine Rechnung über $%s abgelehnt",
        bill_rejected_receiver = "Du hast die Rechnung von %s abgelehnt",
        billing_disabled = "Abrechnung ist derzeit vom Management deaktiviert.",
        billing_off_duty = "Du musst im Dienst sein, um die Abrechnung zu nutzen.",
    },

    Delivery = {
        items_header = "Liefergegenstände",
        reward_header = "Belohnung",
        accept_header = "Lieferung annehmen",
        decline_header = "Lieferung ablehnen",
        menu_header = "Liefermenü",
        no_delivery = "Keine aktive Lieferung!",
        new_delivery_title = "Neue Lieferung",
        new_delivery_desc = "Du hast eine neue Lieferanfrage erhalten.",
        delivery_expired = "Deine Lieferanfrage ist abgelaufen.",
        delivery_timeout = "Du hast die Lieferung nicht rechtzeitig abgeschlossen.",
        delivery_declined = "Du hast die Lieferanfrage abgelehnt.",
        check_location = "Überprüfe dein GPS für den Lieferort.",
        check_location_error = "Keine aktive Lieferung zu verfolgen.",
        delivery_accepted = "Lieferung angenommen",
        invalid_item = "Ungültiger Gegenstand für Lieferung",
        delivery_failed = "Lieferung fehlgeschlagen",
        invalid_items_data = "Ungültige Gegenstandsdaten",

        -- UI Text
        delivery_title = "Lieferung",
        close_menu = "Menü schließen",
        new_order = "Neue Bestellung",
        in_progress = "In Bearbeitung",
        order_items = "Bestellartikel:",
        payment = "Zahlung",
        delivery_status = "Lieferstatus",
        deliver_instruction = "Liefere das Essen an den markierten Ort auf der Karte.",
        time_remaining = "Verbleibende Zeit:",
        order_summary = "Bestellübersicht:",
        accept = "Annehmen",
        decline = "Ablehnen",
        cancel_delivery = "Lieferung abbrechen",

        -- Notifications
        delivery_accepted_notification = "Lieferung erfolgreich angenommen",
        delivery_cancelled_notification = "Lieferung erfolgreich abgebrochen",

        -- Status Messages
        complete_delivery = "Lieferung abschließen",
        delivery_in_progress = "Lieferung läuft...",
        head_to_location = "Fahre zum markierten Ort, um die Lieferung abzuschließen",
    },

    Consumption = {
        title = "Verzehr",
        description = "Frisch und lecker!",
        refresh_title = "Erfrischt",
        refresh_description = "Du fühlst dich erfrischt",
    },

    Crafting = {
        craft_title = "%s herstellen",
        enter_amount_description = "Menge zum Herstellen eingeben",
        crafting_successful = "Herstellung erfolgreich",
        crafted_description = "%d x %s hergestellt",
        crafting_cancelled = "Herstellung abgebrochen",
        cancelled_description = "Du hast die Herstellung abgebrochen",
        no_space = "Kein Platz im Inventar",
    },

    Targets = {
        door = "An die Tür klopfen",
        door_icon = "fas fa-door-open",
        delivery_food = "Essen liefern",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "Bestell-Tablet",
        ordering_tablet_error = "Bestell-Tablet-Funktion ist nicht verfügbar.",
        order_management_tablet = "Bestellverwaltungs-Tablet",
        order_management_error = "Bestellverwaltungs-Tablet-Funktion ist nicht verfügbar.",
        return_utensils = "Utensilien zurückgeben",
        employee_vending = "Mitarbeiterautomat",
    },

    Order = {
        complete = "Bestellung abgeschlossen",
        description = "Deine Bestellung wurde bearbeitet. Die Rechnung wurde deinem Inventar hinzugefügt.",
        paycheck_suspended_description = "Gehaltsschecks werden ausgesetzt, solange das Geschäft geschlossen ist.",
        paycheck_suspended = "Gehalt ausgesetzt",
    },

    Door = {
        title = "Tür ",
        description = "Die Tür ist ",
        locked = "Die Tür ist verschlossen",
        no_permissions = "Keine Berechtigung, diese Tür zu ver-/entriegeln",
        access_denied_title = "Zugriff verweigert",
        access_granted = "Du hast die Tür aufgeschlossen",
        access_denied = "Du hast keinen Zugriff auf diese Tür",
    },

    Outfits = {
        title = "Outfits",
        invalid = "Ungültiges Geschlecht",
        failed_equip = "Ausrüsten des Outfits fehlgeschlagen",
        disabled = "Outfits sind deaktiviert",
        civilian_clothes = "Zivilkleidung anziehen",
        reset_civilian_clothes = "Zurück zu Zivilkleidung gewechselt",
        no_civilian_saved = "Keine Zivilkleidung gespeichert. Ziehe erst eine Uniform an.",
        no_permission = "Du hast keine Berechtigung, dieses Outfit zu benutzen",
        outfit_not_found = "Outfit nicht gefunden",
        equip_success = "Outfit erfolgreich ausgerüstet",
        changed_to_uniform = "Zu %s gewechselt",
        reset_success = "Outfit erfolgreich zurückgesetzt",
        no_civilian_for_reset = "Keine Zivilkleidung gespeichert. Ziehe erst eine Uniform an und speichere deine Kleidung.",
    },

    System = {
        success = "Erfolg",
        paycheck_error = "Gehaltsfehler",
        inventory_full = "Inventar voll",
        inventory_full_description = "Dein Inventar ist voll.",
        society_not_found = "Geschäft nicht gefunden",
        business_funds_insufficient = "Das Geschäft hat nicht genug Mittel, um Gehälter zu zahlen.",
        error = "Fehler",
        invalid = "Ungültig",
        no_license = "Konnte deine Lizenz nicht identifizieren. Kontaktiere einen Administrator.",
        missing_items = "Fehlende Gegenstände",
        item_cleaned = "Gegenstand erfolgreich gereinigt",
        missing_required = "Benötigter Gegenstand fehlt",
        slot_error = "Lege die Menge in denselben Slot",
        ice_collected = "Eis gesammelt",
        refreshing = "Erfrischend",
        refreshed = "Erfrischt",
        consumption = "Verzehr",
        stress_increased = "Stress erhöht",
        stress_amount = "Dein Stresslevel ist um %s gestiegen",
        inventory_full = "Dein Inventar ist voll",
    },

    Experience = {
        gained_title = "Erfahrung erhalten",
        experience_earned_description = "Du hast %d XP erhalten.",
        gained_message = "Du hast %d XP für den Abschluss der Lieferung erhalten!",
    },

    BossMenu = {
        title = "Chefmenü",
        unable_jobdetermine = "Konnte deinen Job nicht bestimmen. Bitte versuche es später erneut.",
        bankruptcy_alert = "⚠️ Insolvenz-Warnung",
        description = "Kann Gehälter nicht zahlen! Geschäftskonto: $%s, Benötigt: $%s",
        trans_failed_bossmenubalance = "Transaktion fehlgeschlagen - Unzureichende Geschäftsmittel",
        menu_in_use = "Das Chefmenü wird gerade von %s benutzt.",
        no_permissions = "Du hast keine Chef-Berechtigungen! Du musst der Boss sein.",
        wrong_job = "Du hast nicht den richtigen Job",
        grade_updated = "Job-Grad aktualisiert",
        grade_update_success = "Grad %s erfolgreich aktualisiert.",
        menu_update = "Menü-Update",
        menu_update_success = "Menüpunkt erfolgreich aktualisiert!",
        vending_update = "Verkaufsautomat",
        vending_update_success = "Automatenartikel erfolgreich aktualisiert!",
        menu_update_error = "Aktualisieren des Menüpunkts fehlgeschlagen!",
        menu_delete = "Menü löschen",
        menu_delete_success = "Menüpunkt erfolgreich gelöscht!",
        menu_delete_error = "Löschen des Menüpunkts fehlgeschlagen!",
        invite_sent = "Einladung gesendet",
        invite_sent_success = "Job-Einladung an %s gesendet",
        invite_error = "Ungültige Spieler-ID oder Rolle!",
        player_not_found = "Spieler nicht gefunden!",
        job_error = "Ungültige Einladungsdaten!",
        job_accepted = "Du bist jetzt %s bei %s",
        job_updated_title = "Job aktualisiert",
        job_updated = "Deine Position wurde auf %s bei %s aktualisiert",
        database_error = "Dein Job wurde gesetzt, aber das Datenbank-Update schlug fehl.",
        invite_rejected = "Du hast die Job-Einladung abgelehnt.",
        withdraw_error = "Ungültiger Betrag!",
        business_error = "Geschäft nicht gefunden!",
        insufficient_funds = "Unzureichende Geschäftsmittel!",
        money_withdrawn = "Du hast $%s vom Geschäftskonto abgehoben.",
        transaction_failed = "Aktualisierung des Geschäftskontos fehlgeschlagen!",
        money_deposited = "Du hast $%s auf das Geschäftskonto eingezahlt.",
        transaction_failed_refund = "Aktualisierung des Geschäftskontos fehlgeschlagen! Dein Geld wurde zurückgegeben.",
        shop_purchase = "Neuer Shop-Kauf",
        shop_purchase_notification = "%s hat Artikel für $%s gekauft",
        menu_occupied = "Chefmenü ist belegt",
        menu_occupied_by = "%s benutzt gerade das Chefmenü. Bitte versuche es später erneut.",
        menu_released = "Chefmenü ist jetzt verfügbar",

        -- Main Headers and Titles
        business_overview = "Geschäftsüberblick",
        business_settings = "Geschäftseinstellungen",
        menu_management = "Menüverwaltung",
        staff_management = "Personalverwaltung",
        employee_leaderboard = "Mitarbeiter-Rangliste",
        sales_transactions = "Verkäufe & Transaktionen",

        -- Finance Section
        finance = "Finanzen",
        business_balance = "Geschäftsbilanz",
        withdraw = "Abheben",
        deposit = "Einzahlen",
        withdraw_money = "Geld abheben",
        deposit_money = "Geld einzahlen",
        enter_amount_withdraw = "Gib den Betrag ein, den du vom Geschäftskonto auf dein %s abheben möchtest.",
        enter_amount_deposit = "Gib den Betrag ein, den du von deinem %s auf das Geschäftskonto einzahlen möchtest.",
        available = "Verfügbar",
        enter_amount = "Betrag eingeben",
        withdraw_to = "Abheben auf %s",
        deposit_from = "Einzahlen von %s",
        updating = "Aktualisiere...",
        update_avatar = "Avatar aktualisieren",
        cancel = "Abbrechen",
        cash = "Bar",
        bank = "Bank",
        invalid_url = "Ungültige URL",
        invalid_url_message = "Bitte gib eine gültige Bild-URL ein",
        avatar_updated = "Avatar aktualisiert",
        avatar_updated_message = "Avatar erfolgreich aktualisiert!",
        update_failed = "Update fehlgeschlagen",
        update_failed_message = "Aktualisieren des Avatars fehlgeschlagen",
        business_status = "Geschäftsstatus",
        business_status_desc = "Steuere den Betriebsstatus deines Geschäfts",
        business_operations = "Geschäftsbetrieb",
        business_open = "Derzeit geöffnet - Abrechnung aktiviert",
        business_closed = "Derzeit geschlossen - Abrechnung deaktiviert",
        business_status_updated = "Geschäftsstatus",
        business_now_open = "Geschäft ist jetzt geöffnet",
        business_now_closed = "Geschäft ist jetzt geschlossen",
        business_status_error = "Fehler",
        business_status_failed = "Aktualisieren des Geschäftsstatus fehlgeschlagen",

        -- Employees Section
        employees = "Mitarbeiter",
        invite_new_employee = "Neuen Mitarbeiter einladen",
        player_id = "Spieler-ID...",
        invite = "Einladen",
        select_role = "Rolle auswählen",
        choose_role_for = "Wähle eine Rolle für %s",
        available_roles = "Verfügbare Rollen:",
        roles_available = "%d Rollen verfügbar",
        send_invite = "Einladung senden",

        -- Sales Summary
        sales_summary = "Verkaufszusammenfassung",
        today = "Heute",
        this_week = "Diese Woche",
        this_month = "Diesen Monat",
        view_sales = "Verkäufe anzeigen",

        -- Inventory Status
        inventory_status = "Lagerbestand",
        storage_capacity = "Lagerkapazität",
        ingredients = "Zutaten",
        supplies = "Vorräte",
        manage_inventory = "Lager verwalten",

        -- Menu Management
        search_menu_items = "Menüpunkte suchen...",
        edit_menu_item = "Menüpunkt bearbeiten",
        update_item_details = "Aktualisiere die Artikeldetails unten.",
        label_display_name = "Label (Anzeigename)",
        price = "Preis ($)",
        category = "Kategorie",
        select_category = "Wähle eine Kategorie",
        update = "Aktualisieren",
        all_items = "Alle Artikel",
        no_menu_items = "Keine Menüpunkte gefunden",
        no_category_items = "Kein %s gefunden",

        -- Vending Machine Management
        vending_machine_management = "Automatenverwaltung",
        search_vending_items = "Automatenartikel suchen...",
        edit_vending_item = "Automatenartikel bearbeiten",
        update_vending_details = "Aktualisiere die Artikeldetails unten.",
        all_vending_items = "Alle Artikel",
        no_vending_items = "Keine Automatenartikel gefunden",
        no_category_vending_items = "Kein %s gefunden",
        vending_update_error = "Aktualisieren des Automatenartikels fehlgeschlagen",
        item_price = "Preis",
        item_type = "Typ",
        uncategorized = "Unkategorisiert",
        enter_price = "z.B. 5",

        -- Staff Management
        employee_overview = "Mitarbeiterübersicht",
        total_employees = "Gesamtmitarbeiter",
        active_employees = "Aktive Mitarbeiter",
        pending_applications = "Ausstehende Bewerbungen",
        employee_list = "Mitarbeiterliste",
        search_employees = "Mitarbeiter suchen...",
        all_employees = "Alle Mitarbeiter",
        name = "Name",
        role = "Rolle",
        salary = "Gehalt",
        last_seen = "Zuletzt gesehen",
        actions = "Aktionen",
        promote = "Befördern",
        demote = "Degradieren",
        fire = "Entlassen",
        employee_actions = "Mitarbeiteraktionen",
        select_action = "Wähle eine Aktion für %s",
        promote_employee = "Mitarbeiter befördern",
        demote_employee = "Mitarbeiter degradieren",
        fire_employee = "Mitarbeiter entlassen",
        confirm_action = "Aktion bestätigen",
        confirm_promote = "Bist du sicher, dass du %s zu %s befördern möchtest?",
        confirm_demote = "Bist du sicher, dass du %s zu %s degradieren möchtest?",
        confirm_fire = "Bist du sicher, dass du %s entlassen möchtest?",
        action_success = "Aktion erfolgreich abgeschlossen",
        action_failed = "Aktion fehlgeschlagen",
        employee_promoted = "Mitarbeiter erfolgreich befördert",
        employee_demoted = "Mitarbeiter erfolgreich degradiert",
        employee_fired = "Mitarbeiter erfolgreich entlassen",
        no_employees = "Keine Mitarbeiter gefunden",

            -- Job Grades Management Dialog
        manage_job_grades = "Job-Grade verwalten",
        configure_salary_commission = "Konfiguriere Gehalt und Provisionssätze für jede Position",
        search_job_grades = "Job-Grade suchen...",
        edit_job_grade = "Job-Grad bearbeiten",
        update_job_grade_details = "Job-Grad-Details aktualisieren",
        job_title = "Berufsbezeichnung",
        commission_rate = "Provisionssatz",
        boss_access = "Chef-Zugriff",
        boss_access_enabled = "Diese Rolle hat Zugriff auf Verwaltungsfunktionen",
        boss_access_disabled = "Diese Rolle hat Mitarbeiter-Zugriff",
        save_changes = "Änderungen speichern",
        boss_role = "Chef-Rolle",
        grade_update_error = "Aktualisieren des Job-Grads fehlgeschlagen",

        -- Employee Details View
        employee_overview = "Mitarbeiterdetails",
        employee_profile = "Mitarbeiterprofil",
        performance_stats = "Leistungsmetriken",
        back = "Zurück",
        
        -- Employee Profile Card Labels
        commission = "Provision",
        total_earnings = "Gesamteinnahmen",
        available_balance = "Verfügbares Guthaben",
        employee_id = "Mitarbeiter-ID",
        
        -- Performance Stats Labels
        deliveries_label = "Lieferungen",
        billings_label = "Abrechnungen",
        earnings_label = "Einnahmen",
        experience_label = "Erfahrung",
        level_label = "Level",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "Einkommensverteilung",
        delivery_income = "Lieferungen",
        commission_income = "Provision",
        paycheck_income = "Gehälter",
        completed_label = "abgeschlossen",
        bills_label = "Rechnungen",
        hourly_label = "Stündlich",

        -- Employee Card Labels (for list view)
        rank_label = "Rang",
        commission_label = "Provision",

        -- Role Change Dialog
        no_role_employees = "Kein %s gefunden",
        employee_updated = "Mitarbeiter aktualisiert",
        employee_commission_updated = "Mitarbeiter mit %s Provisionssatz aktualisiert",
        fire_employee_error = "Entlassen des Mitarbeiters fehlgeschlagen",

        -- Employee Leaderboard
        top_performers = "Top-Performer",
        this_month_leaders = "Führende diesen Monat",
        rank = "Rang",
        employee = "Mitarbeiter",
        performance = "Leistung",
        orders_completed = "Bestellungen abgeschlossen",
        revenue_generated = "Umsatz generiert",
        customer_rating = "Kundenbewertung",
        no_data = "Keine Leistungsdaten verfügbar",

        -- Transactions
        transaction_history = "Transaktionsverlauf",
        recent_transactions = "Kürzliche Transaktionen",
        paycheck_history = "Gehaltsverlauf",
        transaction_type = "Transaktionstyp",
        amount = "Betrag",
        date = "Datum",
        message = "Beschreibung",
        customer = "Kunde",
        filter_transactions = "Transaktionen filtern...",
        all_transactions = "Alle Transaktionen",
        sales_only = "Nur Verkäufe",
        paychecks_only = "Nur Gehälter",
        no_transactions = "Keine Transaktionen gefunden",
        no_paychecks = "Keine Gehaltseinträge gefunden",


        -- Settings
        avatar_settings = "Avatar-Einstellungen",
        update_profile_picture = "Profilbild aktualisieren",
        image_url = "Bild-URL",
        enter_url_preview = "Gib unten eine URL ein, um deinen Avatar zu sehen",
        preview = "Vorschau",
        enter_url_message = "Gib die URL deines Avatarbildes ein",
        ui_theme = "UI-Design",
        customize_appearance = "Passe das Aussehen des Dashboards an",
        light_mode = "Heller Modus",
        dark_mode = "Dunkler Modus",

        -- Navigation
        home = "Start",
        staff = "Personal",
        menu = "Menü",
        sales = "Verkäufe",
        top = "Top",
        settings = "Einstellungen",

        -- Status Labels
        open = "Geöffnet",
        closed = "Geschlossen",
        online = "Online",
        offline = "Offline",
        active = "Aktiv",
        inactive = "Inaktiv",

        -- Common Actions
        save = "Speichern",
        edit = "Bearbeiten",
        delete = "Löschen",
        confirm = "Bestätigen",
        close = "Schließen",
        refresh = "Aktualisieren",
        loading = "Lädt...",

        -- Error Messages
        error_occurred = "Ein Fehler ist aufgetreten",
        invalid_input = "Ungültige Eingabe",
        operation_failed = "Vorgang fehlgeschlagen",
        permission_denied = "Zugriff verweigert",
        network_error = "Netzwerkfehler",
        data_load_failed = "Laden der Daten fehlgeschlagen",

        -- Success Messages
        operation_successful = "Vorgang erfolgreich abgeschlossen",
        data_saved = "Daten erfolgreich gespeichert",
        changes_applied = "Änderungen erfolgreich übernommen",
    },

    Shop = {
        shop_status = "Shop-Status",
        shop_open = "Shop ist geöffnet",
        shop_closed = "Shop ist geschlossen",
        access_denied = "Du kannst auf diesen Shop nicht zugreifen!",
        purchase_title = "Shop",
        purchase_success = "Kauf abgeschlossen! Artikel zu deinem Inventar hinzugefügt.",
        purchase_error = "Kaufabwicklung fehlgeschlagen!",

        -- Search and Inventory
        search_placeholder = "Produkte nach Namen suchen...",
        clear_search = "Suche löschen",
        shop_inventory = "Shop-Inventar",
        items_count = "Artikel",

        -- Product Actions
        add_to_cart = "Hinzufügen",
        per_item = "pro Stück",

        -- Cart
        your_cart = "Dein Warenkorb",
        cart_empty = "Warenkorb ist leer",
        cart_empty_message = "Füge Artikel hinzu, um einzukaufen",
        items_label = "Artikel",
        total = "Gesamt",

        -- Search Results
        no_items_found = "Keine Artikel gefunden",
        no_items_message = "Versuche deine Suche anzupassen oder durchsuche alle Artikel",

        -- Payment
        pay_with_cash = "Bar",
        pay_with_bank = "Bank",
        processing = "Verarbeite...",
        inventory_notice = "Artikel werden direkt deinem Inventar hinzugefügt",

        -- Notifications
        cart_updated = "Warenkorb aktualisiert",
        item_added = "Artikel hinzugefügt",
        item_removed = "Artikel entfernt",
        quantity_updated = "Menge aktualisiert",
        purchase_complete = "Kauf abgeschlossen",
        transaction_failed = "Transaktion fehlgeschlagen",
        checkout_error = "Kassenfehler",
        cart_empty_error = "Dein Warenkorb ist leer",
        paid_with_cash = "Bar bezahlt",
        charged_to_bank = "Vom Bankkonto abgebucht",
        not_enough_cash = "Nicht genug Bargeld",
        insufficient_bank = "Unzureichendes Bankguthaben",

        -- Quantity Messages
        added_more = "%d weitere %s hinzugefügt",
        removed_items = "%d %s entfernt",
        added_to_cart = "%s zum Warenkorb hinzugefügt",
        removed_from_cart = "%s aus deinem Warenkorb entfernt",

        -- Loading
        loading_shop = "Lade Shop-Menü...",
    },

    EmployeeMenu = {
        access_denied = "Du kannst auf dieses Portal nicht zugreifen!",
        commission_withdrawn = "Provision abgehoben",
        commission_withdrawn_description = "Du hast $%s von deinem Provisionsguthaben auf dein %s abgehoben.",
        transaction_failed = "Transaktion fehlgeschlagen",
        fire_employee = "Mitarbeiter entlassen",
        fire_employee_description = "%s wurde aus deinem Geschäft entlassen!",
        employeeMent_notice = "Mitarbeiter-Benachrichtigung",
        
        no_employee_active = "Derzeit sind keine Mitarbeiter online und aktiv, um deine Bestellung zu bearbeiten.",
        -- Main Headers and Navigation
        employee_portal = "Mitarbeiterportal",
        employee_profile = "Mitarbeiterprofil",
        performance_stats = "Leistungsstatistiken",
        employee_leaderboard = "Mitarbeiter-Rangliste",
        job_outfits = "Arbeitskleidung",
        account_settings = "Kontoeinstellungen",

        -- Navigation Labels
        profile = "Profil",
        stats = "Statistiken",
        top = "Top",
        outfits = "Kleidung",
        settings = "Einstellungen",

        -- Profile Tab
        personal_information = "Persönliche Informationen",
        paycheck_information = "Gehaltsinformationen",
        job_role = "Job-Rolle",
        salary = "Gehalt",
        experience = "Erfahrung",
        duty_status = "Dienststatus",
        on_duty = "Im Dienst",
        off_duty = "Außer Dienst",
        clock_in = "Einstempeln",
        clock_out = "Ausstempeln",
        available_balance = "Verfügbares Guthaben",
        withdraw = "Abheben",
        withdraw_funds = "Geld abheben",
        paycheck_interval = "Gehaltsintervall",
        total_deliveries = "Gesamtlieferungen",
        bills_created = "Erstellte Rechnungen",
        total_earnings = "Gesamteinnahmen",
        minutes = "Minuten",

        -- Performance Tab
        career_statistics = "Karrierestatistiken",
        experience_points = "Erfahrung",
        xp_points = "XP-Punkte",
        total_earned = "Gesamt verdient",
        current_balance = "Aktuelles Guthaben",
        deliveries = "Lieferungen",
        total_completed = "Gesamt abgeschlossen",
        billings = "Abrechnungen",
        invoices_created = "Erstellte Rechnungen",
        job_grade_progression = "Job-Grad-Fortschritt",
        current_grade = "Aktueller Grad",
        level = "Level",
        xp_needed_promotion = "XP benötigt für Beförderung",
        earn_more_xp = "Verdiene %d mehr XP für Beförderung zu %s",
        max_grade_reached = "Du hast den höchsten automatischen Grad erreicht! Weitere Beförderungen erfordern Management-Genehmigung.",
        promotions_by_management = "Beförderungen werden vom Management vergeben.",
        loading_experience_data = "Lade Erfahrungssystem-Daten...",
        loading_progression_data = "Lade Fortschrittsdaten...",

        -- Leaderboard Tab
        top_performers = "Top-Performer",
        this_month_leaders = "Führende diesen Monat",
        rank = "Rang",
        employee = "Mitarbeiter",
        performance = "Leistung",
        no_leaderboard_data = "Keine Ranglistendaten verfügbar",

        -- Outfits Tab
        work_outfits = "Arbeitskleidung",
        select_outfit = "Outfit auswählen",
        change_outfit = "Outfit wechseln",
        outfit_changed = "Outfit gewechselt",
        outfit_changed_success = "Dein Outfit wurde erfolgreich gewechselt!",
        outfit_change_failed = "Wechseln des Outfits fehlgeschlagen",
        outfit_preview = "Outfit-Vorschau",

        -- Settings Tab
        employee_settings = "Mitarbeitereinstellungen",
        avatar_settings = "Avatar-Einstellungen",
        update_profile_picture = "Profilbild aktualisieren",
        image_url = "Bild-URL",
        enter_url_preview = "Gib unten eine URL ein, um deinen Avatar zu sehen",
        preview = "Vorschau",
        enter_url_message = "Gib die URL deines Avatarbildes ein",
        avatar_updated = "Avatar aktualisiert",
        avatar_created = "Avatar erstellt",
        avatar_updated_message = "Avatar erfolgreich aktualisiert!",
        update_failed = "Update fehlgeschlagen",
        update_failed_message = "Aktualisieren des Avatars fehlgeschlagen",
        invalid_url = "Ungültige URL",
        invalid_url_message = "Bitte gib eine gültige Bild-URL ein",
        updating = "Aktualisiere...",
        update_avatar = "Avatar aktualisieren",

        -- UI Theme
        ui_theme = "UI-Design",
        customize_appearance = "Dashboard-Aussehen anpassen",
        light_mode = "Heller Modus",
        dark_mode = "Dunkler Modus",

        -- Notifications
        notifications = "Benachrichtigungen",
        manage_notification_preferences = "Benachrichtigungseinstellungen verwalten",
        employee_notifications = "Mitarbeiter-Benachrichtigungen",
        notifications_enabled_desc = "Du erhältst alle Gehalts-Updates",
        notifications_disabled_desc = "Du erhältst keine Benachrichtigungen",
        notifications_updated = "Benachrichtigungen aktualisiert",
        notifications_enabled_message = "Gehaltsbenachrichtigungen sind jetzt aktiviert",
        notifications_disabled_message = "Gehaltsbenachrichtigungen sind jetzt deaktiviert",
        enabled = "Aktiviert",
        disabled = "Deaktiviert",

        -- Withdrawal Dialog
        withdraw_all_funds = "Alles abheben",
        select_balance_type = "Guthabentyp auswählen",
        all_balance = "Gesamtguthaben",
        delivery_balance = "Lieferguthaben",
        commission_balance = "Provisionsguthaben",
        paycheck_balance = "Gehaltsguthaben",
        available_balance_type = "Verfügbares %s Guthaben: $%d",
        enter_amount = "Betrag eingeben",
        insufficient_funds = "Unzureichende Mittel",
        insufficient_balance = "Unzureichendes %s Guthaben",
        funds_withdrawn = "Geld abgehoben",
        funds_withdrawn_success = "Erfolgreich $%d von deinem Guthaben abgehoben",
        transaction_failed = "Transaktion fehlgeschlagen",
        withdrawal_failed = "Abheben fehlgeschlagen",
        invalid_amount = "Ungültiger Betrag",
        invalid_amount_message = "Bitte gib einen gültigen Betrag ein",
        no_funds = "Kein Geld",
        no_funds_message = "Du hast kein Geld zum Abheben",

        -- Common Actions
        cancel = "Abbrechen",
        save = "Speichern",
        update = "Aktualisieren",
        confirm = "Bestätigen",
        close = "Schließen",
        loading = "Lädt...",

        -- Status Labels
        active = "Aktiv",
        inactive = "Inaktiv",
        online = "Online",
        offline = "Offline",

        -- Error Messages
        error_occurred = "Ein Fehler ist aufgetreten",
        operation_failed = "Vorgang fehlgeschlagen",
        data_load_failed = "Laden der Daten fehlgeschlagen",
        network_error = "Netzwerkfehler",
        employee_data_error = "Konnte deine Mitarbeiterdaten nicht abrufen.",
        identity_error = "Konnte deine Identität nicht verifizieren.",
        withdraw_invalid_amount = "Ungültiger Betrag!",
        insufficient_commission = "Unzureichendes Provisionsguthaben!",
        transaction_failed_update = "Aktualisieren des Provisionsguthabens fehlgeschlagen!",
        fire_employee_not_found = "Mitarbeiter nicht gefunden!",
        fire_employee_wrong_business = "Dieser Mitarbeiter arbeitet nicht für dein Geschäft!",
        fire_employee_db_error = "Entlassen des Mitarbeiters aus der Datenbank fehlgeschlagen!",
        employment_notice_fired = "Du wurdest von %s entlassen",
        avatar_invalid_url = "Ungültige Bild-URL bereitgestellt.",
        avatar_updated_success = "Dein Profil-Avatar wurde erfolgreich aktualisiert.",
        avatar_no_changes = "Keine Änderungen an deinem Avatar vorgenommen.",
        avatar_created = "Dein Mitarbeiterprofil und Avatar wurden erstellt.",
        avatar_create_failed = "Erstellen des Mitarbeitereintrags fehlgeschlagen.",
        withdrawal_invalid_amount = "Ungültiger Abhebungsbetrag.",
        employee_record_not_found_withdraw = "Mitarbeitereintrag nicht gefunden.",
        insufficient_balance_withdraw = "Unzureichendes Guthaben.",
        withdraw_balance_failed = "Abheben vom Guthaben fehlgeschlagen. Bitte versuche es erneut.",
        identity_error_toggle = "Konnte deine Identität nicht verifizieren",
        invalid_grade_data = "Ungültige Graddaten bereitgestellt.",
        grade_id_not_found = "Konnte Grad-ID für diese Rolle nicht finden.",
        no_grade_changes = "Keine Änderungen am Job-Grad vorgenommen.",
        balance_withdrawn = "Du hast $%d von deinem %s Guthaben auf dein %s abgehoben.",
        player_not_found = "Spieler nicht gefunden!",
        invalid_purchase_data = "Ungültige Kaufdaten!",
        insufficient_funds = "Nicht genug Geld in deinem %s!",
        inventory_full = "Nicht genug Platz im Inventar oder Gewichtslimit überschritten!",
        purchase_complete = "Kauf abgeschlossen! Artikel zu deinem Inventar hinzugefügt.",
        shop_purchase = "Shop-Kauf: %s",
        business_balance_error = "Fehler beim Aktualisieren der Geschäftsbilanz für %s",
        business_balance_success = "Erfolgreich $%s zum Geschäftskonto hinzugefügt",
        transaction_record_error = "Fehler beim Aufzeichnen der Transaktion für Shop-Kauf",
        avatar_found = "Shop: Avatar für %s gefunden: %s",
        avatar_not_found = "Shop: Kein Avatar für %s gefunden, benutze Standard",
    },

    Vending = {
        invalid_item_data = "Ungültige Artikeldaten.",
        insufficient_item = "Du hast nicht genug von diesem Artikel.",
        item_added_with_money = "Artikel zum Lager hinzugefügt. $%s für %sx %s erhalten",
        item_added = "Artikel zum Lager hinzugefügt.",
        business_balance_error = "Fehler beim Aktualisieren der Geschäftsbilanz für Bestellung",
        database_error = "Datenbankfehler",
        add_item_failed = "Hinzufügen des Artikels fehlgeschlagen.",
        invalid_collection_data = "Ungültige Abholdaten.",
        inventory_full = "Konnte Artikel nicht zu deinem Inventar hinzufügen.",
        item_collected = "%sx %s abgeholt",
        stock_update_failed = "Aktualisieren des Automatenbestands fehlgeschlagen.",
        out_of_stock = "Nicht vorrätig",
        insufficient_stock = "Nicht genug Artikel zum Abholen verfügbar.",
        sale_transaction_error = "Fehler beim Aufzeichnen der Automatentransaktion",
        collection_transaction_error = "Fehler beim Aufzeichnen der Abholtransaktion",
    },

    JobSystem = {
        no_permission = "Du hast keine Berechtigung, diesen Befehl zu verwenden.",
        player_not_found = "Spieler nicht gefunden.",
        job_assigned = "Job zugewiesen.",
        job_assign_failed = "Zuweisen des Jobs fehlgeschlagen.",
        job_removed = "Job entfernt.",
        job_remove_failed = "Entfernen des Jobs fehlgeschlagen.",
        job_changed_notification = "Job geändert",
        job_changed = "Dein Job wurde zu %s (Grad %s) geändert.",
        job_removed_notification = "Dein Job wurde entfernt.",
        give_job_usage = "Verwendung: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "Verwendung: /%s [playerId]",
        job_info = "Job: %s (Grad: %s, Dienst: %s)",
        job_info_error = "Konnte deine Job-Infos nicht abrufen.",
        duty_status = "Du bist jetzt %s Dienst.",
        not_on_duty = "Nicht im Dienst",
        must_be_on_duty = "Du musst im Dienst sein, um Gehalt zu erhalten.",
        paycheck_title = "Gehalt",
        employer_insufficient_funds = "Dein Chef hat nicht genug Geld, um dich zu bezahlen.",
        paycheck_added = "Gehalt von $%s zum Mitarbeiterguthaben für %s für Job: %s hinzugefügt",
        paycheck_received = "Du hast ein Gehalt von $%s von %s erhalten",
    },

    BillingInviteNotification = {
        message = "Du hast eine Zahlungsaufforderung erhalten.",

        -- Titles / headers
        title = "Zahlungsaufforderung",
        label = "Rechnungsbenachrichtigung",

        -- Button labels
        pay_button = "Rechnung bezahlen",
        decline_button = "Ablehnen",

        -- Small UI labels used inside the notification component
        business_label = "Geschäft",
        total_amount_label = "Gesamtbetrag",
        reason_label = "Grund",
        amount_label = "Betrag:",

        -- Warning / helper texts
        warning_text = "Zahlung wird von deinem Konto abgebucht. Stelle sicher, dass genügend Deckung vorhanden ist.",
        expires_text = "Läuft ab in %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "Du wurdest eingeladen, als %s bei Burgershot anzufangen. Nimmst du an?",

        -- Titles / headers
        title = "Job-Einladung",
        label = "Job-Einladungsbenachrichtigung",

        -- Button labels
        accept_button = "Annehmen",
        reject_button = "Ablehnen",

        -- Small UI labels used inside the notification component
        company_label = "Firma",
        grade_label = "Grad",
        invites_left_label = "Verbleibende Einladungen",
        salary_label = "Gehalt",

        -- Warning / helper texts
        warning_text = "Die Annahme dieses Jobs verpflichtet dich zu dieser Rolle. Stelle sicher, dass du bereit bist.",
        expires_text = "Läuft ab in %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "Restaurant-Menü",
        onduty = "Du musst im Dienst sein, um auf das Restaurant-Menü zuzugreifen.",
    },

    Duty = {
        status = "Dienststatus",
        management = "Dienstverwaltung",
        description = "Du bist jetzt %s Dienst.",
        restaurant_area = "Restaurantbereich",
        clock_in = "Du hast den Restaurantbereich betreten. Benutze das Mitarbeitermenü zum Einstempeln.",
        enter_workplace = "Du hast deinen Arbeitsplatz betreten und bist jetzt im Dienst.",
        leave_workplace = "Du hast deinen Arbeitsplatz verlassen und bist jetzt außer Dienst.",
        inside_workplace = "Du bist am Arbeitsplatz - automatisch auf im Dienst gesetzt.",
        outside_workplace = "Du bist außerhalb des Arbeitsplatzes - automatisch auf außer Dienst gesetzt.",
        duty_warning = "Dienstwarnung",
        auto_off_duty = "Du wirst automatisch außer Dienst gesetzt, wenn du das Restaurant verlässt.",
        no_permission_manage_duty = "Du hast keine Berechtigung, den Dienststatus von Mitarbeitern zu verwalten",
        not_employee_of_job = "Spieler ist kein Mitarbeiter dieses Jobs",
        duty_set_by_management = "Dein Dienststatus wurde vom Management auf %s gesetzt",
        duty_management_success = "Dienststatus von %s erfolgreich auf %s gesetzt",
        updated_offline_employee = "Dienststatus eines Offline-Mitarbeiters aktualisiert",
    },

    Paycheck = {
        title = "Gehalt erhalten",
        message = "Du hast ein Gehalt von $%s von %s erhalten",
    },

    VendingMachine = {
        sell_item = "Artikel verkaufen",
        select_item_from_inventory = "Artikel aus Inventar auswählen",
        add_to_vending = "%s ZUM AUTOMATEN HINZUFÜGEN",
        cancel = "ABBRECHEN",
        no_matching_items = "Keine passenden Artikel im Inventar",
        stocked_items = "Gelagerte Artikel",
        sell = "Verkaufen",
        no_stock = "Kein Bestand",
        items = "Artikel auf Lager",
        ready_to_serve = "Bereit zum Servieren!",
    },

    EmployeeVendingMachine = {
        title = "Vom Automaten abholen",
        label = "Artikel aus dem Automatenbestand abholen",
        collect = "Abholen",
        cancel = "Abbrechen",
        quantity_available = "Menge (Verfügbar: %s)",
        collect_item = "%s abholen",
        collect_button = "Abholen",
        in_stock = "Auf Lager",
        vending_machine_empty = "Dieser Verkaufsautomat ist leer.",
    },

    OrderingTab = {
        where_eating_today = "Wo möchtest du heute essen?",
        eat_in = "Hier essen",
        take_out = "Zum Mitnehmen",
        whats_up = "was gibt's?",
        popular = "Beliebt",
        done = "Fertig",
        my_order = "Meine Bestellung",
        empty = "Leer",
        total = "Gesamt",
        checkout = "Kasse",
        back = "Zurück",
        no_menu_items = "Keine Menüpunkte verfügbar für %s",
        loading = "Lädt...",
        eat_in_label = "Hier essen",
        take_out_label = "Zum Mitnehmen",
        pay_cash = "Bar",
        cancel = "Abbrechen",
        order = "Bestellen",
        pay_bank = "Bank",
        all_items = "Alle Artikel",
        bank_only_disclaimer = "Zahlung kann nur per Bank erfolgen.",
    },

    OrderManagementTable = {
        title = "Bestellverwaltungs-Panel",
        label = "Bestelladministration",
        filter_all = "Alle",
        filter_cooking = "Kochen",
        filter_ready = "Bereit",
        filter_completed = "Abgeschlossen",
        filter_terminal_orders = "Terminal-Bestellungen",
        filter_self_pickup = "Kiosk-Bestellungen",
        sort_by = "Sortieren nach",
        sort_day = "Tag",
        sort_amount = "Betrag",
        sort_name = "Name",
        no_orders = "Keine Bestellungen entsprechen dem aktuellen Filter.",
        accept = "ANNEHMEN",
        accepting = "ANNEHMEN...",
        cooking = "KOCHEN",
        ready = "BEREIT",
        complete = "ABSCHLIESSEN",
        completed = "ABGESCHLOSSEN",
        assigned_to = "Zugewiesen an: ",
        items_label = "Artikel:",
        order_label = "Bestellung #",
        status_cooking = "kochen",
        status_ready = "bereit",
        status_completed = "abgeschlossen",
        status_cancelled = "storniert",
        self_pickup = "Selbstabholung",
    },

    MenuSelectionDialog = {
        title = "Aktion wählen",
        subtitle = "Was möchten Sie tun?",
        options = {
            shop = {
                title = "Shop öffnen",
                description = "Artikel aus dem Automaten durchsuchen und kaufen"
            },
            manageBoss = {
                title = "Shop verwalten",
                description = "Inventar verwalten, Analysen anzeigen und Automaten steuern"
            },
            manageEmployee = {
                title = "Shop verwalten",
                description = "Inventarartikel im Automaten hinzufügen und verwalten"
            }
        }
    },
}