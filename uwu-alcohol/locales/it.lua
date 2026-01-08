-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["it"] = {
    
    WashHands = {
        title = "Lavandino",
        no_available = "Nessun lavandino disponibile",
        success = "Le tue mani sono pulite ora!",
        error = "Errore",
        fail = "Le tue mani sono già pulite!",
        targetfail = "Devi prima lavarti le mani!",
        item_cleaned = "Oggetto pulito con successo!",
        missing_required = "Oggetto richiesto mancante"
    },

    Terminal = {
        SubmitText = "Invia Fattura",

        -- Player Selection Tab
        select_player = "Seleziona Giocatore",
        nearby_players = "Giocatori Vicini",
        search_players = "Cerca giocatori...",
        no_players_found = "Nessun giocatore trovato nelle vicinanze",
        loading_players = "Caricamento giocatori...",
        player_selected = "Giocatore selezionato",

        -- Menu Items Tab
        menu_items = "Voci Menu",
        items_added = "Articoli aggiunti",
        search_menu_items = "Cerca voci menu...",
        available_items = "Articoli Disponibili",
        selected_items = "Articoli Selezionati",
        no_items_found = "Nessun articolo trovato",
        no_items_selected = "Nessun articolo selezionato",
        total_items = "Totale Articoli",
        total = "Totale",
        all = "Tutti",

        -- Finalize Bill Tab
        finalize_bill = "Finalizza Fattura",
        customer_info = "Info Cliente",
        order_summary = "Riepilogo Ordine",
        amount_label = "Importo ($)",
        enter_amount = "Inserisci importo",
        reason_label = "Causale (Opzionale)",
        reason_placeholder = "Inserisci causale fattura",
        payment_method = "Metodo di Pagamento",
        cash = "Contanti",
        bank = "Banca",
        send_bill = "Invia Fattura",

        -- Commission
        your_commission = "La tua commissione",
        commission_rate = "Tasso Commissione",

        -- Bills sent counter
        bills_sent = "Fatture inviate:",
        commission = "Commissione:",

        -- Error Messages
        bill_error = "Errore Fattura",
        select_player_error = "Seleziona un giocatore",
        invalid_amount_error = "Inserisci un importo valido",

        -- Success Messages
        bill_sent_success = "Fattura inviata con successo!",
        bill_sent_title = "Fattura Inviata",
    },

    Consumable = {
        Drinking = "Bevendo ", -- Drinking ItemName
        Eating = "Mangiando " -- Eating ItemName
    },

    Garage = {
        title = "Garage",
        no_vehicle = "Nessun veicolo da restituire",
        not_job_vehicle = "Questo non è un veicolo Burgershot!",
        parked_title = "Veicolo parcheggiato!",
        parked_message = "Il tuo veicolo è stato parcheggiato in questa posizione!",
        in_vehicle = "Non puoi essere all'interno del veicolo!",
        too_far = "Troppo lontano dal veicolo!",
        spawn_error = "Non puoi farlo ora!",

        -- UI Text
        garage_title = "Garage",
        garage_active_vehicles = "Attivi",
        garage_manage = "Gestisci Attivi",
        close = "Chiudi",
        search_vehicles = "Cerca veicoli...",
        no_vehicles_found = "Nessun veicolo trovato",
        dont_have_vehicle = "Non hai veicoli parcheggiati in questo garage.",
        select_vehicle = "Seleziona Veicolo",
        select_vehicle_message = "Seleziona un veicolo dalla lista per vedere i dettagli e prelevarlo.",
        back = "Indietro",
        spawn_vehicle = "Preleva Veicolo",
        return_button = "Restituisci",
        return_vehicle = "Restituisci Veicolo",
        license_plate = "Targa",

        -- Status Messages
        vehicle_spawned = "Veicolo prelevato con successo",
        no_vehicle_to_return = "Nessun veicolo da restituire",
        access_denied = "Non hai accesso a questo garage.",
        all_spawn_points_blocked = "Tutti i punti di spawn sono bloccati, attendere prego.",
        vehicle_model_not_exist = "Il modello del veicolo non esiste",
        failed_load_model = "Impossibile caricare il modello del veicolo",
        failed_create_vehicle = "Impossibile creare il veicolo",
        invalid_vehicle_data = "Dati modello veicolo non validi",

        -- Error Messages
        error = "Errore",
        garage_error = "Errore Garage",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "Creazione entità veicolo fallita",
        no_spawn_points_available = "Nessun punto di spawn disponibile",
        vehicle_returned_parked = "Veicolo restituito e parcheggiato.",
        vehicle_processed_remote = "Veicolo processato (Restituzione remota).",
    },

    Billing = {
        title = "Fatturazione",
        payment_failed_byreceiver = "Pagamento fallito: %s non ha fondi sufficienti per pagare %s.",
        business_closed = "La fatturazione è attualmente disabilitata dalla gestione.",
        commission_earned = "Commissione Guadagnata",
        commission_earned_description = "Hai guadagnato $%s di commissione.",
        terminal_title = "Terminale Fatturazione",
        off_duty_error = "Devi essere in servizio per usare il terminale.",
        access_denied = "Non hai accesso al terminale di fatturazione.",
        payment_received = "Pagamento Ricevuto",
        payment_received_message = "Ricevuto pagamento di $%s da %s",
        payment_failed = "Pagamento Fallito",
        payment_failed_message = "Pagamento della fattura fallito",
        bill_sent = "Fattura Inviata",
        bill_sent_success = "Fattura inviata con successo!",
        bill_sent_error = "Impossibile inviare la fattura.",
        bill_error = "Errore Fattura",
        invalid_bill = "Fattura Non Valida!",
        invalid_bill_description = "La fattura che stai cercando di pagare non esiste.",
        invalid_target_amount = "Destinatario o importo non valido!",
        player_not_found = "Giocatore non trovato!",
        must_be_on_duty = "Devi essere in servizio per inviare una fattura!",
        bill_sent_description = "Inviata fattura di $%s a %s per %s",
        bill_payment_successful = "✅ Pagamento fattura riuscito",
        bill_payment_failed_insufficient = "❌ Pagamento fattura fallito - Fondi insufficienti",
        bill_rejected = "❌ Fattura rifiutata",
        insufficient_funds = "%s non ha abbastanza fondi!",
        order_processed = "🍔 Ordine Processato",
        command_access_denied = "Non puoi usare questo comando!",
        payment_failed_insufficient = "%s non ha abbastanza fondi!",
        bill_rejected_title = "Fattura Rifiutata",

        bill_rejected_sender = "%s ha rifiutato la tua fattura di $%s",
        bill_rejected_receiver = "Hai rifiutato la fattura di %s",
        billing_disabled = "La fatturazione è attualmente disabilitata dalla gestione.",
        billing_off_duty = "Devi essere in servizio per usare la fatturazione.",
    },

    Delivery = {
        items_header = "Oggetti Consegna",
        reward_header = "Ricompensa",
        accept_header = "Accetta Consegna",
        decline_header = "Rifiuta Consegna",
        menu_header = "Menu Consegna",
        no_delivery = "Nessuna consegna attiva!",
        new_delivery_title = "Nuova Consegna",
        new_delivery_desc = "Hai ricevuto una nuova richiesta di consegna.",
        delivery_expired = "La tua richiesta di consegna è scaduta.",
        delivery_timeout = "Non hai fatto in tempo a completare la consegna.",
        delivery_declined = "Hai rifiutato la richiesta di consegna.",
        check_location = "Controlla il GPS per il luogo di consegna.",
        check_location_error = "Nessuna consegna attiva da tracciare.",
        delivery_accepted = "Consegna Accettata",
        invalid_item = "Oggetto non valido per la consegna",
        delivery_failed = "Consegna Fallita",
        invalid_items_data = "Dati oggetti non validi",

        -- UI Text
        delivery_title = "Consegna",
        close_menu = "Chiudi Menu",
        new_order = "Nuovo Ordine",
        in_progress = "In Corso",
        order_items = "Oggetti Ordine:",
        payment = "Pagamento",
        delivery_status = "Stato Consegna",
        deliver_instruction = "Consegna il cibo al luogo segnato sulla mappa.",
        time_remaining = "Tempo Rimanente:",
        order_summary = "Riepilogo Ordine:",
        accept = "Accetta",
        decline = "Rifiuta",
        cancel_delivery = "Annulla Consegna",

        -- Notifications
        delivery_accepted_notification = "Consegna accettata con successo",
        delivery_cancelled_notification = "Consegna annullata con successo",

        -- Status Messages
        complete_delivery = "Completa Consegna",
        delivery_in_progress = "Consegna in corso...",
        head_to_location = "Dirigiti al luogo segnato per completare la consegna",
    },

    Consumption = {
        title = "Consumo",
        description = "Fresco e delizioso!",
        refresh_title = "Rinfrescante",
        refresh_description = "Ti senti rinfrescato",
    },

    Crafting = {
        craft_title = "Crea %s",
        enter_amount_description = "Inserisci quantità da creare",
        crafting_successful = "Creazione Riuscita",
        crafted_description = "Creato %d x %s",
        crafting_cancelled = "Creazione Annullata",
        cancelled_description = "Hai annullato la creazione",
        no_space = "Spazio insufficiente nell'inventario",
    },

    Targets = {
        door = "Bussa alla porta",
        door_icon = "fas fa-door-open",
        delivery_food = "Consegna Cibo",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "Tablet Ordini",
        ordering_tablet_error = "Funzione tablet ordini non disponibile.",
        order_management_tablet = "Tablet Gestione Ordini",
        order_management_error = "Funzione tablet gestione ordini non disponibile.",
        return_utensils = "Restituisci Utensili",
        employee_vending = "Distributore Dipendenti",
    },

    Order = {
        complete = "Ordine Completato",
        description = "Il tuo ordine è stato processato. La fattura è stata aggiunta al tuo inventario.",
        paycheck_suspended_description = "Gli stipendi sono sospesi mentre l'attività è chiusa.",
        paycheck_suspended = "Stipendio Sospeso",
    },

    Door = {
        title = "Porta ",
        description = "La porta è ",
        locked = "La porta è bloccata",
        no_permissions = "Nessun permesso per bloccare/sbloccare questa porta",
        access_denied_title = "Accesso Negato",
        access_granted = "Hai sbloccato la porta",
        access_denied = "Non hai accesso a questa porta",
    },

    Outfits = {
        title = "Abiti",
        invalid = "Sesso non valido",
        failed_equip = "Impossibile equipaggiare l'abito",
        disabled = "Gli abiti sono disabilitati",
        civilian_clothes = "Cambia in Abiti Civili",
        reset_civilian_clothes = "Tornato agli abiti civili",
        no_civilian_saved = "Nessun abito civile salvato. Cambia prima in uniforme.",
        no_permission = "Non hai il permesso di usare questo abito",
        outfit_not_found = "Abito non trovato",
        equip_success = "Abito equipaggiato con successo",
        changed_to_uniform = "Cambiato in %s",
        reset_success = "Abito reimpostato con successo",
        no_civilian_for_reset = "Nessun abito civile salvato. Cambia in uniforme e salva i vestiti prima.",
    },

    System = {
        success = "Successo",
        paycheck_error = "Errore Stipendio",
        inventory_full = "Inventario Pieno",
        inventory_full_description = "Il tuo inventario è pieno.",
        society_not_found = "Attività non trovata",
        business_funds_insufficient = "L'attività non ha fondi sufficienti per pagare gli stipendi.",
        error = "Errore",
        invalid = "Non valido",
        no_license = "Impossibile identificare la tua licenza. Contatta un amministratore.",
        missing_items = "Oggetti Mancanti",
        item_cleaned = "Oggetto pulito con successo",
        missing_required = "Oggetto richiesto mancante",
        slot_error = "Metti la quantità nello stesso slot",
        ice_collected = "Ghiaccio raccolto",
        refreshing = "Rinfrescando",
        refreshed = "Rinfrescato",
        consumption = "Consumo",
        stress_increased = "Stress Aumentato",
        stress_amount = "Il tuo livello di stress è aumentato di %s",
        inventory_full = "Il tuo inventario è pieno",
    },

    Experience = {
        gained_title = "Esperienza Guadagnata",
        experience_earned_description = "Hai guadagnato %d XP.",
        gained_message = "Hai guadagnato %d XP per aver completato la consegna!",
    },

    BossMenu = {
        title = "Menu Capo",
        unable_jobdetermine = "Impossibile determinare il tuo lavoro. Riprova più tardi.",
        bankruptcy_alert = "⚠️ Avviso Bancarotta",
        description = "Impossibile pagare gli stipendi! Saldo attività: $%s, Richiesto: $%s",
        trans_failed_bossmenubalance = "Transazione Fallita - Fondi Attività Insufficienti",
        menu_in_use = "Il menu capo è attualmente in uso da %s.",
        no_permissions = "Non hai i permessi da capo! Devi essere il Capo.",
        wrong_job = "Non hai il lavoro corretto",
        grade_updated = "Grado Lavoro Aggiornato",
        grade_update_success = "Grado %s aggiornato con successo.",
        menu_update = "Aggiornamento Menu",
        menu_update_success = "Voce menu aggiornata con successo!",
        vending_update = "Distributore Automatico",
        vending_update_success = "Oggetto distributore aggiornato con successo!",
        menu_update_error = "Impossibile aggiornare la voce menu!",
        menu_delete = "Elimina Menu",
        menu_delete_success = "Voce menu eliminata con successo!",
        menu_delete_error = "Impossibile eliminare la voce menu!",
        invite_sent = "Invito Inviato",
        invite_sent_success = "Invito di lavoro inviato a %s",
        invite_error = "ID giocatore o ruolo non valido!",
        player_not_found = "Giocatore non trovato!",
        job_error = "Dati invito non validi!",
        job_accepted = "Ora sei un %s presso %s",
        job_updated_title = "Lavoro Aggiornato",
        job_updated = "La tua posizione è stata aggiornata a %s presso %s",
        database_error = "Il tuo lavoro è stato impostato ma l'aggiornamento del database è fallito.",
        invite_rejected = "Hai rifiutato l'invito di lavoro.",
        withdraw_error = "Importo non valido!",
        business_error = "Attività non trovata!",
        insufficient_funds = "Fondi attività insufficienti!",
        money_withdrawn = "Hai prelevato $%s dal conto aziendale.",
        transaction_failed = "Impossibile aggiornare il conto aziendale!",
        money_deposited = "Hai depositato $%s sul conto aziendale.",
        transaction_failed_refund = "Impossibile aggiornare il conto aziendale! I tuoi soldi sono stati restituiti.",
        shop_purchase = "Nuovo Acquisto Negozio",
        shop_purchase_notification = "%s ha acquistato articoli per $%s",
        menu_occupied = "Menu capo occupato",
        menu_occupied_by = "%s sta usando il menu capo. Riprova più tardi.",
        menu_released = "Menu capo ora disponibile",

        -- Main Headers and Titles
        business_overview = "Panoramica Attività",
        business_settings = "Impostazioni Attività",
        menu_management = "Gestione Menu",
        staff_management = "Gestione Personale",
        employee_leaderboard = "Classifica Dipendenti",
        sales_transactions = "Vendite & Transazioni",

        -- Finance Section
        finance = "Finanza",
        business_balance = "Saldo Attività",
        withdraw = "Preleva",
        deposit = "Deposita",
        withdraw_money = "Preleva Denaro",
        deposit_money = "Deposita Denaro",
        enter_amount_withdraw = "Inserisci l'importo che vuoi prelevare dal conto aziendale al tuo %s.",
        enter_amount_deposit = "Inserisci l'importo che vuoi depositare dal tuo %s al conto aziendale.",
        available = "Disponibile",
        enter_amount = "Inserisci importo",
        withdraw_to = "Preleva su %s",
        deposit_from = "Deposita da %s",
        updating = "Aggiornamento...",
        update_avatar = "Aggiorna Avatar",
        cancel = "Annulla",
        cash = "Contanti",
        bank = "Banca",
        invalid_url = "URL Non Valido",
        invalid_url_message = "Inserisci un URL immagine valido",
        avatar_updated = "Avatar Aggiornato",
        avatar_updated_message = "Avatar aggiornato con successo!",
        update_failed = "Aggiornamento Fallito",
        update_failed_message = "Impossibile aggiornare l'avatar",
        business_status = "Stato Attività",
        business_status_desc = "Controlla lo stato operativo della tua attività",
        business_operations = "Operazioni Aziendali",
        business_open = "Attualmente aperto ai clienti - Fatturazione abilitata",
        business_closed = "Attualmente chiuso ai clienti - Fatturazione disabilitata",
        business_status_updated = "Stato Attività",
        business_now_open = "L'attività è ora aperta",
        business_now_closed = "L'attività è ora chiusa",
        business_status_error = "Errore",
        business_status_failed = "Impossibile aggiornare lo stato dell'attività",

        -- Employees Section
        employees = "Dipendenti",
        invite_new_employee = "Invita Nuovo Dipendente",
        player_id = "ID Giocatore...",
        invite = "Invita",
        select_role = "Seleziona Ruolo",
        choose_role_for = "Scegli un ruolo per %s",
        available_roles = "Ruoli Disponibili:",
        roles_available = "%d ruoli disponibili",
        send_invite = "Invia Invito",

        -- Sales Summary
        sales_summary = "Riepilogo Vendite",
        today = "Oggi",
        this_week = "Questa Settimana",
        this_month = "Questo Mese",
        view_sales = "Visualizza Vendite",

        -- Inventory Status
        inventory_status = "Stato Inventario",
        storage_capacity = "Capacità Magazzino",
        ingredients = "Ingredienti",
        supplies = "Forniture",
        manage_inventory = "Gestisci Inventario",

        -- Menu Management
        search_menu_items = "Cerca voci menu...",
        edit_menu_item = "Modifica Voce Menu",
        update_item_details = "Aggiorna i dettagli dell'articolo qui sotto.",
        label_display_name = "Etichetta (Nome Visualizzato)",
        price = "Prezzo ($)",
        category = "Categoria",
        select_category = "Seleziona una categoria",
        update = "Aggiorna",
        all_items = "Tutti gli Articoli",
        no_menu_items = "Nessuna voce menu trovata",
        no_category_items = "Nessun %s trovato",

        -- Vending Machine Management
        vending_machine_management = "Gestione Distributore Automatico",
        search_vending_items = "Cerca articoli distributore...",
        edit_vending_item = "Modifica Articolo Distributore",
        update_vending_details = "Aggiorna i dettagli dell'articolo qui sotto.",
        all_vending_items = "Tutti gli Articoli",
        no_vending_items = "Nessun articolo distributore trovato",
        no_category_vending_items = "Nessun %s trovato",
        vending_update_error = "Impossibile aggiornare l'articolo del distributore",
        item_price = "Prezzo",
        item_type = "Tipo",
        uncategorized = "Non Categorizzato",
        enter_price = "es., 5",

        -- Staff Management
        employee_overview = "Panoramica Dipendenti",
        total_employees = "Totale Dipendenti",
        active_employees = "Dipendenti Attivi",
        pending_applications = "Candidature in Sospeso",
        employee_list = "Lista Dipendenti",
        search_employees = "Cerca dipendenti...",
        all_employees = "Tutti i Dipendenti",
        name = "Nome",
        role = "Ruolo",
        salary = "Stipendio",
        last_seen = "Ultimo Accesso",
        actions = "Azioni",
        promote = "Promuovi",
        demote = "Retrocedi",
        fire = "Licenzia",
        employee_actions = "Azioni Dipendente",
        select_action = "Seleziona un'azione per %s",
        promote_employee = "Promuovi Dipendente",
        demote_employee = "Retrocedi Dipendente",
        fire_employee = "Licenzia Dipendente",
        confirm_action = "Conferma Azione",
        confirm_promote = "Sei sicuro di voler promuovere %s a %s?",
        confirm_demote = "Sei sicuro di voler retrocedere %s a %s?",
        confirm_fire = "Sei sicuro di voler licenziare %s?",
        action_success = "Azione completata con successo",
        action_failed = "Azione fallita",
        employee_promoted = "Dipendente promosso con successo",
        employee_demoted = "Dipendente retrocesso con successo",
        employee_fired = "Dipendente licenziato con successo",
        no_employees = "Nessun dipendente trovato",

            -- Job Grades Management Dialog
        manage_job_grades = "Gestisci Gradi Lavoro",
        configure_salary_commission = "Configura stipendio e tassi di commissione per ogni posizione",
        search_job_grades = "Cerca gradi lavoro...",
        edit_job_grade = "Modifica Grado Lavoro",
        update_job_grade_details = "Aggiorna dettagli grado lavoro",
        job_title = "Titolo Lavoro",
        commission_rate = "Tasso Commissione",
        boss_access = "Accesso Capo",
        boss_access_enabled = "Questo ruolo ha accesso alle funzioni di gestione",
        boss_access_disabled = "Questo ruolo ha accesso livello dipendente",
        save_changes = "Salva Modifiche",
        boss_role = "Ruolo Capo",
        grade_update_error = "Impossibile aggiornare il grado lavoro",

        -- Employee Details View
        employee_overview = "Dettagli Dipendente",
        employee_profile = "Profilo Dipendente",
        performance_stats = "Metriche Prestazioni",
        back = "Indietro",
        
        -- Employee Profile Card Labels
        commission = "Commissione",
        total_earnings = "Guadagni Totali",
        available_balance = "Saldo Disponibile",
        employee_id = "ID Dipendente",
        
        -- Performance Stats Labels
        deliveries_label = "Consegne",
        billings_label = "Fatturazioni",
        earnings_label = "Guadagni",
        experience_label = "Esperienza",
        level_label = "Livello",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "Distribuzione Reddito",
        delivery_income = "Consegne",
        commission_income = "Commissione",
        paycheck_income = "Stipendi",
        completed_label = "completati",
        bills_label = "fatture",
        hourly_label = "Orario",

        -- Employee Card Labels (for list view)
        rank_label = "Rango",
        commission_label = "Commissione",

        -- Role Change Dialog
        no_role_employees = "Nessun %s trovato",
        employee_updated = "Dipendente Aggiornato",
        employee_commission_updated = "Dipendente aggiornato con tasso commissione %s",
        fire_employee_error = "Impossibile licenziare il dipendente",

        -- Employee Leaderboard
        top_performers = "Migliori Prestazioni",
        this_month_leaders = "Leader di Questo Mese",
        rank = "Rango",
        employee = "Dipendente",
        performance = "Prestazione",
        orders_completed = "Ordini Completati",
        revenue_generated = "Fatturato Generato",
        customer_rating = "Valutazione Cliente",
        no_data = "Nessun dato sulle prestazioni disponibile",

        -- Transactions
        transaction_history = "Cronologia Transazioni",
        recent_transactions = "Transazioni Recenti",
        paycheck_history = "Cronologia Stipendi",
        transaction_type = "Tipo Transazione",
        amount = "Importo",
        date = "Data",
        message = "Descrizione",
        customer = "Cliente",
        filter_transactions = "Filtra transazioni...",
        all_transactions = "Tutte le Transazioni",
        sales_only = "Solo Vendite",
        paychecks_only = "Solo Stipendi",
        no_transactions = "Nessuna transazione trovata",
        no_paychecks = "Nessun record stipendi trovato",


        -- Settings
        avatar_settings = "Impostazioni Avatar",
        update_profile_picture = "Aggiorna la tua immagine profilo",
        image_url = "URL Immagine",
        enter_url_preview = "Inserisci un URL qui sotto per vedere l'anteprima del tuo avatar",
        preview = "Anteprima",
        enter_url_message = "Inserisci l'URL della tua immagine avatar",
        ui_theme = "Tema UI",
        customize_appearance = "Personalizza l'aspetto della dashboard",
        light_mode = "Modalità Chiara",
        dark_mode = "Modalità Scura",

        -- Navigation
        home = "Home",
        staff = "Personale",
        menu = "Menu",
        sales = "Vendite",
        top = "Top",
        settings = "Impostazioni",

        -- Status Labels
        open = "Aperto",
        closed = "Chiuso",
        online = "Online",
        offline = "Offline",
        active = "Attivo",
        inactive = "Inattivo",

        -- Common Actions
        save = "Salva",
        edit = "Modifica",
        delete = "Elimina",
        confirm = "Conferma",
        close = "Chiudi",
        refresh = "Aggiorna",
        loading = "Caricamento...",

        -- Error Messages
        error_occurred = "Si è verificato un errore",
        invalid_input = "Input non valido",
        operation_failed = "Operazione fallita",
        permission_denied = "Permesso negato",
        network_error = "Errore di rete",
        data_load_failed = "Caricamento dati fallito",

        -- Success Messages
        operation_successful = "Operazione completata con successo",
        data_saved = "Dati salvati con successo",
        changes_applied = "Modifiche applicate con successo",
    },

    Shop = {
        shop_status = "Stato Negozio",
        shop_open = "Il Negozio è Aperto",
        shop_closed = "Il Negozio è Chiuso",
        access_denied = "Non puoi accedere a questo negozio!",
        purchase_title = "Negozio",
        purchase_success = "Acquisto completato! Articoli aggiunti al tuo inventario.",
        purchase_error = "Checkout fallito!",

        -- Search and Inventory
        search_placeholder = "Cerca prodotti per nome...",
        clear_search = "Cancella ricerca",
        shop_inventory = "Inventario Negozio",
        items_count = "articoli",

        -- Product Actions
        add_to_cart = "Aggiungi",
        per_item = "per/articolo",

        -- Cart
        your_cart = "Il Tuo Carrello",
        cart_empty = "Il Carrello è Vuoto",
        cart_empty_message = "Aggiungi articoli per iniziare a fare acquisti",
        items_label = "articoli",
        total = "Totale",

        -- Search Results
        no_items_found = "Nessun articolo trovato",
        no_items_message = "Prova a modificare la ricerca o sfoglia tutti gli articoli",

        -- Payment
        pay_with_cash = "Contanti",
        pay_with_bank = "Banca",
        processing = "Elaborazione...",
        inventory_notice = "Gli articoli verranno aggiunti direttamente al tuo inventario",

        -- Notifications
        cart_updated = "Carrello Aggiornato",
        item_added = "Articolo Aggiunto",
        item_removed = "Articolo Rimosso",
        quantity_updated = "Quantità Aggiornata",
        purchase_complete = "Acquisto Completato",
        transaction_failed = "Transazione Fallita",
        checkout_error = "Errore Checkout",
        cart_empty_error = "Il tuo carrello è vuoto",
        paid_with_cash = "Pagato in contanti",
        charged_to_bank = "Addebitato sul tuo conto bancario",
        not_enough_cash = "Contanti insufficienti",
        insufficient_bank = "Saldo bancario insufficiente",

        -- Quantity Messages
        added_more = "Aggiunti altri %d %s",
        removed_items = "Rimossi %d %s",
        added_to_cart = "%s aggiunto al carrello",
        removed_from_cart = "Rimosso %s dal tuo carrello",

        -- Loading
        loading_shop = "Caricamento Menu Negozio...",
    },

    EmployeeMenu = {
        access_denied = "Non puoi accedere a questo portale!",
        commission_withdrawn = "Commissione Prelevata",
        commission_withdrawn_description = "Hai prelevato $%s dal tuo saldo commissioni al tuo %s.",
        transaction_failed = "Transazione Fallita",
        fire_employee = "Licenzia Dipendente",
        fire_employee_description = "%s è stato licenziato dalla tua attività!",
        employeeMent_notice = "Avviso Dipendente",
        
        no_employee_active = "Nessun dipendente è attualmente online e attivo per gestire il tuo ordine.",
        -- Main Headers and Navigation
        employee_portal = "Portale Dipendenti",
        employee_profile = "Profilo Dipendente",
        performance_stats = "Statistiche Prestazioni",
        employee_leaderboard = "Classifica Dipendenti",
        job_outfits = "Abiti da Lavoro",
        account_settings = "Impostazioni Account",

        -- Navigation Labels
        profile = "Profilo",
        stats = "Statistiche",
        top = "Top",
        outfits = "Abiti",
        settings = "Impostazioni",

        -- Profile Tab
        personal_information = "Informazioni Personali",
        paycheck_information = "Informazioni Stipendio",
        job_role = "Ruolo Lavorativo",
        salary = "Stipendio",
        experience = "Esperienza",
        duty_status = "Stato Servizio",
        on_duty = "In Servizio",
        off_duty = "Fuori Servizio",
        clock_in = "Timbra Ingresso",
        clock_out = "Timbra Uscita",
        available_balance = "Saldo Disponibile",
        withdraw = "Preleva",
        withdraw_funds = "Preleva Fondi",
        paycheck_interval = "Intervallo Stipendio",
        total_deliveries = "Consegne Totali",
        bills_created = "Fatture Create",
        total_earnings = "Guadagni Totali",
        minutes = "minuti",

        -- Performance Tab
        career_statistics = "Statistiche Carriera",
        experience_points = "Esperienza",
        xp_points = "Punti XP",
        total_earned = "Totale Guadagnato",
        current_balance = "Saldo Attuale",
        deliveries = "Consegne",
        total_completed = "Totale Completato",
        billings = "Fatturazioni",
        invoices_created = "Fatture Create",
        job_grade_progression = "Progressione Grado Lavoro",
        current_grade = "Grado Attuale",
        level = "Livello",
        xp_needed_promotion = "XP necessari per la promozione",
        earn_more_xp = "Guadagna altri %d XP per essere promosso a %s",
        max_grade_reached = "Hai raggiunto il grado automatico più alto! Ulteriori promozioni richiedono l'approvazione della direzione.",
        promotions_by_management = "Le promozioni sono assegnate dalla direzione.",
        loading_experience_data = "Caricamento dati sistema esperienza...",
        loading_progression_data = "Caricamento dati progressione...",

        -- Leaderboard Tab
        top_performers = "Migliori Prestazioni",
        this_month_leaders = "Leader di Questo Mese",
        rank = "Rango",
        employee = "Dipendente",
        performance = "Prestazione",
        no_leaderboard_data = "Nessun dato classifica disponibile",

        -- Outfits Tab
        work_outfits = "Abiti da Lavoro",
        select_outfit = "Seleziona Abito",
        change_outfit = "Cambia Abito",
        outfit_changed = "Abito Cambiato",
        outfit_changed_success = "Il tuo abito è stato cambiato con successo!",
        outfit_change_failed = "Impossibile cambiare abito",
        outfit_preview = "Anteprima Abito",

        -- Settings Tab
        employee_settings = "Impostazioni Dipendente",
        avatar_settings = "Impostazioni Avatar",
        update_profile_picture = "Aggiorna la tua immagine profilo",
        image_url = "URL Immagine",
        enter_url_preview = "Inserisci un URL qui sotto per vedere l'anteprima del tuo avatar",
        preview = "Anteprima",
        enter_url_message = "Inserisci l'URL della tua immagine avatar",
        avatar_updated = "Avatar Aggiornato",
        avatar_created = "Avatar Creato",
        avatar_updated_message = "Avatar aggiornato con successo!",
        update_failed = "Aggiornamento Fallito",
        update_failed_message = "Impossibile aggiornare avatar",
        invalid_url = "URL Non Valido",
        invalid_url_message = "Inserisci un URL immagine valido",
        updating = "Aggiornamento...",
        update_avatar = "Aggiorna Avatar",

        -- UI Theme
        ui_theme = "Tema UI",
        customize_appearance = "Personalizza aspetto dashboard",
        light_mode = "Modalità Chiara",
        dark_mode = "Modalità Scura",

        -- Notifications
        notifications = "Notifiche",
        manage_notification_preferences = "Gestisci preferenze notifiche",
        employee_notifications = "Notifiche Dipendente",
        notifications_enabled_desc = "Riceverai tutti gli aggiornamenti sugli stipendi",
        notifications_disabled_desc = "Non riceverai notifiche",
        notifications_updated = "Notifiche Aggiornate",
        notifications_enabled_message = "Le notifiche stipendio sono ora abilitate",
        notifications_disabled_message = "Le notifiche stipendio sono ora disabilitate",
        enabled = "Abilitato",
        disabled = "Disabilitato",

        -- Withdrawal Dialog
        withdraw_all_funds = "Preleva Tutti i Fondi",
        select_balance_type = "Seleziona Tipo Saldo",
        all_balance = "Tutto il Saldo",
        delivery_balance = "Saldo Consegna",
        commission_balance = "Saldo Commissioni",
        paycheck_balance = "Saldo Stipendio",
        available_balance_type = "Saldo %s Disponibile: $%d",
        enter_amount = "Inserisci importo",
        insufficient_funds = "Fondi Insufficienti",
        insufficient_balance = "Saldo %s insufficiente",
        funds_withdrawn = "Fondi Prelevati",
        funds_withdrawn_success = "Prelevati con successo $%d dal tuo saldo",
        transaction_failed = "Transazione Fallita",
        withdrawal_failed = "Impossibile prelevare fondi",
        invalid_amount = "Importo Non Valido",
        invalid_amount_message = "Inserisci un importo valido",
        no_funds = "Nessun Fondo",
        no_funds_message = "Non hai fondi da prelevare",

        -- Common Actions
        cancel = "Annulla",
        save = "Salva",
        update = "Aggiorna",
        confirm = "Conferma",
        close = "Chiudi",
        loading = "Caricamento...",

        -- Status Labels
        active = "Attivo",
        inactive = "Inattivo",
        online = "Online",
        offline = "Offline",

        -- Error Messages
        error_occurred = "Si è verificato un errore",
        operation_failed = "Operazione fallita",
        data_load_failed = "Caricamento dati fallito",
        network_error = "Errore di rete",
        employee_data_error = "Impossibile recuperare i tuoi dati dipendente.",
        identity_error = "Impossibile verificare la tua identità.",
        withdraw_invalid_amount = "Importo non valido!",
        insufficient_commission = "Saldo commissioni insufficiente!",
        transaction_failed_update = "Impossibile aggiornare il saldo commissioni!",
        fire_employee_not_found = "Dipendente non trovato!",
        fire_employee_wrong_business = "Questo dipendente non lavora per la tua attività!",
        fire_employee_db_error = "Impossibile licenziare il dipendente dal database!",
        employment_notice_fired = "Sei stato licenziato da %s",
        avatar_invalid_url = "URL immagine non valido fornito.",
        avatar_updated_success = "Il tuo avatar profilo è stato aggiornato con successo.",
        avatar_no_changes = "Nessuna modifica apportata al tuo avatar.",
        avatar_created = "Il tuo profilo dipendente e avatar sono stati creati.",
        avatar_create_failed = "Impossibile creare il record dipendente.",
        withdrawal_invalid_amount = "Importo prelievo non valido.",
        employee_record_not_found_withdraw = "Record dipendente non trovato.",
        insufficient_balance_withdraw = "Fondi insufficienti nel tuo saldo.",
        withdraw_balance_failed = "Impossibile prelevare dal saldo. Riprova.",
        identity_error_toggle = "Impossibile verificare la tua identità",
        invalid_grade_data = "Dati grado non validi forniti.",
        grade_id_not_found = "Impossibile trovare ID grado per questo ruolo.",
        no_grade_changes = "Nessuna modifica apportata al grado lavoro.",
        balance_withdrawn = "Hai prelevato $%d dal tuo saldo %s al tuo %s.",
        player_not_found = "Giocatore non trovato!",
        invalid_purchase_data = "Dati acquisto non validi!",
        insufficient_funds = "Non abbastanza fondi nel tuo %s!",
        inventory_full = "Spazio inventario insufficiente o limite peso superato!",
        purchase_complete = "Acquisto completato! Articoli aggiunti al tuo inventario.",
        shop_purchase = "Acquisto Negozio: %s",
        business_balance_error = "Errore aggiornamento saldo attività per %s",
        business_balance_success = "Aggiunti con successo $%s al conto aziendale",
        transaction_record_error = "Errore registrazione transazione per acquisto negozio",
        avatar_found = "Negozio: Trovato avatar per %s: %s",
        avatar_not_found = "Negozio: Nessun avatar trovato per %s, uso default",
    },

    Vending = {
        invalid_item_data = "Dati articolo non validi.",
        insufficient_item = "Non hai abbastanza di questo articolo.",
        item_added_with_money = "Articolo aggiunto allo stock. Ricevuti $%s per %sx %s",
        item_added = "Articolo aggiunto allo stock.",
        business_balance_error = "Errore aggiornamento saldo attività per ordine",
        database_error = "Errore Database",
        add_item_failed = "Impossibile aggiungere articolo.",
        invalid_collection_data = "Dati ritiro non validi.",
        inventory_full = "Impossibile aggiungere articolo al tuo inventario.",
        item_collected = "Ritirati %sx %s",
        stock_update_failed = "Impossibile aggiornare stock distributore.",
        out_of_stock = "Esaurito",
        insufficient_stock = "Non abbastanza articoli disponibili per il ritiro.",
        sale_transaction_error = "Errore registrazione transazione vendita distributore",
        collection_transaction_error = "Errore registrazione transazione ritiro distributore",
    },

    JobSystem = {
        no_permission = "Non hai il permesso di usare questo comando.",
        player_not_found = "Giocatore non trovato.",
        job_assigned = "Lavoro assegnato.",
        job_assign_failed = "Impossibile assegnare il lavoro.",
        job_removed = "Lavoro rimosso.",
        job_remove_failed = "Impossibile rimuovere il lavoro.",
        job_changed_notification = "Lavoro Cambiato",
        job_changed = "Il tuo lavoro è stato cambiato a %s (grado %s).",
        job_removed_notification = "Il tuo lavoro è stato rimosso.",
        give_job_usage = "Uso: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "Uso: /%s [playerId]",
        job_info = "Lavoro: %s (Grado: %s, Servizio: %s)",
        job_info_error = "Impossibile ottenere le info sul tuo lavoro.",
        duty_status = "Ora sei %s servizio.",
        not_on_duty = "Fuori Servizio",
        must_be_on_duty = "Devi essere in servizio per ricevere stipendi.",
        paycheck_title = "Stipendio",
        employer_insufficient_funds = "Il tuo capo non ha fondi sufficienti per pagarti.",
        paycheck_added = "Stipendio di $%s aggiunto al saldo dipendente per %s per lavoro: %s",
        paycheck_received = "Hai ricevuto uno stipendio di $%s da %s",
    },

    BillingInviteNotification = {
        message = "Hai ricevuto una richiesta di pagamento.",

        -- Titles / headers
        title = "Richiesta di Pagamento",
        label = "Notifica Fatturazione",

        -- Button labels
        pay_button = "Paga Fattura",
        decline_button = "Rifiuta",

        -- Small UI labels used inside the notification component
        business_label = "Attività",
        total_amount_label = "Importo Totale",
        reason_label = "Causale",
        amount_label = "Importo:",

        -- Warning / helper texts
        warning_text = "Il pagamento verrà detratto dal tuo conto. Assicurati fondi sufficienti.",
        expires_text = "Scade tra %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "Sei stato invitato a unirti come %s presso Burgershot. Accetti?",

        -- Titles / headers
        title = "Invito di Lavoro",
        label = "Notifica Invito di Lavoro",

        -- Button labels
        accept_button = "Accetta",
        reject_button = "Rifiuta",

        -- Small UI labels used inside the notification component
        company_label = "Azienda",
        grade_label = "Grado",
        invites_left_label = "Inviti Rimanenti",
        salary_label = "Stipendio",

        -- Warning / helper texts
        warning_text = "Accettare questo lavoro ti impegnerà nel ruolo. Assicurati di essere pronto per iniziare.",
        expires_text = "Scade tra %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "Menu Ristorante",
        onduty = "Devi essere in servizio per accedere al menu del ristorante.",
    },

    Duty = {
        status = "Stato Servizio",
        management = "Gestione Servizio",
        description = "Ora sei %s servizio.",
        restaurant_area = "Area Ristorante",
        clock_in = "Sei entrato nell'area ristorante. Usa il menu dipendenti per timbrare.",
        enter_workplace = "Sei entrato nel tuo posto di lavoro e ora sei in servizio.",
        leave_workplace = "Hai lasciato il tuo posto di lavoro e ora sei fuori servizio.",
        inside_workplace = "Sei all'interno del tuo posto di lavoro - impostato automaticamente in servizio.",
        outside_workplace = "Sei fuori dal tuo posto di lavoro - impostato automaticamente fuori servizio.",
        duty_warning = "Avviso Servizio",
        auto_off_duty = "Verrai impostato automaticamente fuori servizio quando sei fuori dal ristorante.",
        no_permission_manage_duty = "Non hai il permesso di gestire lo stato di servizio dei dipendenti",
        not_employee_of_job = "Il giocatore non è un dipendente di questo lavoro",
        duty_set_by_management = "Il tuo stato di servizio è stato impostato a %s dalla gestione",
        duty_management_success = "Impostato con successo lo stato di servizio di %s a %s",
        updated_offline_employee = "Aggiornato stato di servizio dipendente offline",
    },

    Paycheck = {
        title = "Stipendio Ricevuto",
        message = "Hai ricevuto uno stipendio di $%s da %s",
    },

    VendingMachine = {
        sell_item = "Vendi Articolo",
        select_item_from_inventory = "Seleziona Articolo da Inventario",
        add_to_vending = "AGGIUNGI %s AL DISTRIBUTORE",
        cancel = "ANNULLA",
        no_matching_items = "Nessun articolo corrispondente nell'inventario",
        stocked_items = "Articoli in Stock",
        sell = "Vendi",
        no_stock = "Nessuno Stock",
        items = "articoli in stock",
        ready_to_serve = "Pronto a Servire!",
    },

    EmployeeVendingMachine = {
        title = "Ritira da Distributore",
        label = "Ritira articoli dallo stock del distributore",
        collect = "Ritira",
        cancel = "Annulla",
        quantity_available = "Quantità (Disponibile: %s)",
        collect_item = "Ritira %s",
        collect_button = "Ritira",
        in_stock = "In Stock",
        vending_machine_empty = "Questo distributore automatico è vuoto.",
    },

    OrderingTab = {
        where_eating_today = "Dove mangerai oggi?",
        eat_in = "Mangio Qui",
        take_out = "Da Asporto",
        whats_up = "come va?",
        popular = "Popolare",
        done = "Fatto",
        my_order = "Il Mio Ordine",
        empty = "Vuoto",
        total = "Totale",
        checkout = "Cassa",
        back = "Indietro",
        no_menu_items = "Nessuna voce menu disponibile per %s",
        loading = "Caricamento...",
        eat_in_label = "Mangio Qui",
        take_out_label = "Da Asporto",
        pay_cash = "Contanti",
        cancel = "Annulla",
        order = "Ordina",
        pay_bank = "Banca",
        all_items = "Tutti gli Articoli",
        bank_only_disclaimer = "Il pagamento può essere effettuato solo tramite banca.",
    },

    OrderManagementTable = {
        title = "Pannello Gestione Ordini",
        label = "Amministrazione Ordini",
        filter_all = "Tutti",
        filter_cooking = "In Cucina",
        filter_ready = "Pronti",
        filter_completed = "Completati",
        filter_terminal_orders = "Ordini Terminale",
        filter_self_pickup = "Ordini Chiosco",
        sort_by = "Ordina Per",
        sort_day = "Giorno",
        sort_amount = "Importo",
        sort_name = "Nome",
        no_orders = "Nessun ordine corrisponde al filtro attuale.",
        accept = "ACCETTA",
        accepting = "ACCETTANDO...",
        cooking = "IN CUCINA",
        ready = "PRONTO",
        complete = "COMPLETA",
        completed = "COMPLETATO",
        assigned_to = "Assegnato a: ",
        items_label = "Articoli:",
        order_label = "Ordine #",
        status_cooking = "in cucina",
        status_ready = "pronto",
        status_completed = "completato",
        status_cancelled = "annullato",
        self_pickup = "Ritiro Personale",
    },

    MenuSelectionDialog = {
        title = "Scegli Azione",
        subtitle = "Cosa vorresti fare?",
        options = {
            shop = {
                title = "Apri Negozio",
                description = "Sfoglia e acquista articoli dal distributore automatico"
            },
            manageBoss = {
                title = "Gestisci Negozio",
                description = "Gestisci inventario, visualizza analisi e controlla il distributore automatico"
            },
            manageEmployee = {
                title = "Gestisci Negozio",
                description = "Aggiungi e gestisci articoli di inventario nel distributore automatico"
            }
        }
    },
}