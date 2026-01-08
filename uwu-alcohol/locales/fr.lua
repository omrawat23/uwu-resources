-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["fr"] = {

    MenuSelectionDialog = {
        title = "Choisir l'Action",
        subtitle = "Que souhaitez-vous faire ?",
        options = {
            shop = {
                title = "Ouvrir le Magasin",
                description = "Parcourir et acheter des articles du distributeur automatique"
            },
            manageBoss = {
                title = "Gérer le Magasin",
                description = "Gérer l'inventaire, voir les analyses et contrôler le distributeur automatique"
            },
            manageEmployee = {
                title = "Gérer le Magasin",
                description = "Ajouter et gérer les articles d'inventaire dans le distributeur automatique"
            }
        }
    },

    WashHands = {
        title = "Évier",
        no_available = "Aucun évier disponible",
        success = "Vos mains sont maintenant propres !",
        error = "Erreur",
        fail = "Vos mains sont déjà propres !",
        targetfail = "Vous devez laver vos mains d'abord !",
        item_cleaned = "Article nettoyé avec succès !",
        missing_required = "Vous n'avez pas les articles requis"
    },

    Terminal = {
        SubmitText = "Envoyer la facture",

        -- Player Selection Tab
        select_player = "Sélectionner le joueur",
        nearby_players = "Joueurs à proximité",
        search_players = "Rechercher des joueurs...",
        no_players_found = "Aucun joueur trouvé à proximité",
        loading_players = "Chargement des joueurs...",
        player_selected = "Joueur sélectionné",

        -- Menu Items Tab
        menu_items = "Articles du menu",
        items_added = "articles ajoutés",
        search_menu_items = "Rechercher des articles du menu...",
        available_items = "Articles disponibles",
        selected_items = "Articles sélectionnés",
        no_items_found = "Aucun article trouvé",
        no_items_selected = "Aucun article sélectionné",
        total_items = "Articles totaux",
        total = "Total",
        all = "Tout",

        -- Finalize Bill Tab
        finalize_bill = "Finaliser la facture",
        customer_info = "Informations client",
        order_summary = "Résumé de la commande",
        amount_label = "Montant ($)",
        enter_amount = "Entrer le montant",
        reason_label = "Raison (Optionnel)",
        reason_placeholder = "Entrer la raison de la facture",
        payment_method = "Méthode de paiement",
        cash = "Espèces",
        bank = "Banque",
        send_bill = "Envoyer la facture",

        -- Commission
        your_commission = "Votre commission",
        commission_rate = "Taux de commission",

        -- Bills sent counter
        bills_sent = "Factures envoyées :",
        commission = "Commission :",

        -- Error Messages
        bill_error = "Erreur de facture",
        select_player_error = "Veuillez sélectionner un joueur",
        invalid_amount_error = "Veuillez entrer un montant valide",

        -- Success Messages
        bill_sent_success = "Facture envoyée avec succès !",
        bill_sent_title = "Facture envoyée",
    },

    Consumable = {
        Drinking = "Boire ", -- Drinking ItemName
        Eating = "Manger " -- Eating ItemName
    },

    Garage = {
        title = "Garage",
        no_vehicle = "Aucun véhicule à retourner",
        not_job_vehicle = "Ce n'est pas un véhicule Burgershot !",
        parked_title = "Véhicule garé !",
        parked_message = "Votre véhicule a été garé à cet emplacement !",
        in_vehicle = "Vous ne pouvez pas être dans un véhicule !",
        too_far = "Vous êtes trop loin du véhicule !",
        spawn_error = "Vous ne pouvez pas faire cela maintenant !",

        -- UI Text
        garage_title = "Garage",
        garage_active_vehicles = "Actif",
        garage_manage = "Gérer les véhicules actifs",
        close = "Fermer",
        search_vehicles = "Rechercher des véhicules...",
        no_vehicles_found = "Aucun véhicule trouvé",
        dont_have_vehicle = "Vous n'avez aucun véhicule stocké dans ce garage.",
        select_vehicle = "Sélectionner un véhicule",
        select_vehicle_message = "Choisissez un véhicule dans la liste pour voir ses détails et le faire apparaître.",
        back = "Retour",
        spawn_vehicle = "Faire apparaître le véhicule",
        return_button = "Retourner",
        return_vehicle = "Retourner le véhicule",
        license_plate = "Plaque d'immatriculation",

        -- Status Messages
        vehicle_spawned = "Véhicule apparu avec succès",
        no_vehicle_to_return = "Aucun véhicule à retourner",
        access_denied = "Vous n'avez pas accès à ce garage.",
        all_spawn_points_blocked = "Tous les points d'apparition sont actuellement bloqués. Veuillez attendre un instant.",
        vehicle_model_not_exist = "Le modèle de véhicule n'existe pas",
        failed_load_model = "Échec du chargement du modèle de véhicule",
        failed_create_vehicle = "Échec de la création du véhicule",
        invalid_vehicle_data = "Données du modèle de véhicule invalides",

        -- Error Messages
        error = "Erreur",
        garage_error = "Erreur de garage",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "L'entité véhicule a échoué à créer",
        no_spawn_points_available = "Aucun point d'apparition disponible",
        vehicle_returned_parked = "Véhicule retourné et garé.",
        vehicle_processed_remote = "Véhicule traité (Retour à distance).",
    },

    Billing = {
        title = "Facturation",
        payment_failed_byreceiver = "Paiement échoué : %s n'a pas assez de fonds dans %s.",
        business_closed = "La facturation est actuellement désactivée par la direction.",
        commission_earned = "Commission gagnée",
        commission_earned_description = "Vous avez gagné $%s en commission.",
        terminal_title = "Terminal de facturation",
        off_duty_error = "Vous devez être en service pour utiliser le terminal de facturation.",
        access_denied = "Vous n'avez pas accès au terminal de facturation.",
        business_closed = "La facturation est actuellement désactivée par la direction.",
        payment_received = "Paiement reçu",
        payment_received_message = "Paiement de $%s reçu de %s",
        payment_failed = "Paiement échoué",
        payment_failed_message = "Échec du paiement de la facture",
        bill_sent = "Facture envoyée",
        bill_sent_success = "Facture envoyée avec succès !",
        bill_sent_error = "Échec de l'envoi de la facture.",
        bill_error = "Erreur de facture",
        invalid_bill = "Facture invalide !",
        invalid_bill_description = "La facture que vous essayez de payer n'existe pas.",
        invalid_target_amount = "Cible ou montant invalide !",
        player_not_found = "Joueur non trouvé !",
        must_be_on_duty = "Vous devez être en service pour envoyer des factures !",
        bill_sent_description = "Vous avez envoyé une facture de $%s à %s pour %s",
        bill_payment_successful = "✅ Paiement de facture réussi",
        bill_payment_failed_insufficient = "❌ Échec du paiement de facture - Fonds insuffisants",
        bill_rejected = "❌ Facture rejetée",
        insufficient_funds = "Vous n'avez pas assez de %s !",
        order_processed = "🍔 Commande traitée",
        command_access_denied = "Vous ne pouvez pas utiliser cette commande !",
        payment_failed_insufficient = "Vous n'avez pas assez de %s !",
        bill_rejected_title = "Facture rejetée",

        bill_rejected_sender = "%s a rejeté votre facture de $%s",
        bill_rejected_receiver = "Vous avez rejeté la facture de %s",
        billing_disabled = "La facturation est actuellement désactivée par la direction.",
        billing_off_duty = "Vous devez être en service pour utiliser la facturation.",
    },

    Delivery = {
        items_header = "Articles à livrer",
        reward_header = "Récompense",
        accept_header = "Accepter la livraison",
        decline_header = "Refuser la livraison",
        menu_header = "Menu de livraison",
        no_delivery = "Aucune livraison active !",
        new_delivery_title = "Nouvelle livraison",
        new_delivery_desc = "Vous avez reçu une nouvelle demande de livraison.",
        delivery_expired = "Votre demande de livraison a expiré.",
        delivery_timeout = "Vous avez pris trop de temps pour compléter la livraison.",
        delivery_declined = "Vous avez refusé la demande de livraison.",
        check_location = "Vérifiez votre GPS pour l'emplacement de livraison.",
        check_location_error = "Vous n'avez aucune livraison active à suivre.",
        delivery_accepted = "Livraison acceptée",
        invalid_item = "Article invalide dans la livraison",
        delivery_failed = "Livraison échouée",
        invalid_items_data = "Données d'article invalides",

        -- UI Text
        delivery_title = "Livraison",
        close_menu = "Fermer",
        new_order = "Nouvelle commande",
        in_progress = "En cours",
        order_items = "Articles de commande :",
        payment = "Paiement",
        delivery_status = "Statut de livraison",
        deliver_instruction = "Livrez la nourriture à l'emplacement marqué sur votre carte.",
        time_remaining = "Temps restant :",
        order_summary = "Résumé de la commande :",
        accept = "Accepter",
        decline = "Refuser",
        cancel_delivery = "Annuler la livraison",

        -- Notifications
        delivery_accepted_notification = "Livraison acceptée avec succès",
        delivery_cancelled_notification = "Livraison annulée avec succès",

        -- Status Messages
        complete_delivery = "Compléter la livraison",
        delivery_in_progress = "Livraison en cours...",
        head_to_location = "Rendez-vous à l'emplacement marqué pour compléter la livraison",
    },

    Consumption = {
        title = "Consommation",
        description = "Frais et savoureux !",
        refresh_title = "Rafraîchissant",
        refresh_description = "Vous vous sentez rafraîchi",
    },

    Crafting = {
        craft_title = "Fabriquer : %s",
        enter_amount_description = "Entrer le montant à fabriquer",
        crafting_successful = "Fabrication réussie",
        crafted_description = "Vous avez fabriqué %d x %s",
        crafting_cancelled = "Fabrication annulée",
        cancelled_description = "Vous avez annulé la fabrication",
        no_space = "Pas assez d'espace dans l'inventaire",
    },

    Targets = {
        door = "Frapper à la porte",
        door_icon = "fas fa-door-open",
        delivery_food = "Livrer la nourriture",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "Tablette de commande",
        ordering_tablet_error = "Fonction tablette de commande non disponible.",
        order_management_tablet = "Tablette de gestion des commandes",
        order_management_error = "Fonction tablette de gestion des commandes non disponible.",
        return_utensils = "Retourner les ustensiles",
        employee_vending = "Distributeur employé",
    },

    Order = {
        complete = "Commande complète",
        description = "Votre commande a été traitée. Facture ajoutée à l'inventaire.",
        paycheck_suspended_description = "Les paies sont suspendues tant que l'entreprise est fermée.",
        paycheck_suspended = "Paie suspendue",
    },

    Door = {
        title = "Porte ",
        description = "La porte a été ",
        locked = "La porte est verrouillée",
        no_permissions = "Vous n'avez pas la permission de verrouiller/déverrouiller cette porte",
        access_denied_title = "Accès refusé",
        access_granted = "Vous avez déverrouillé la porte",
        access_denied = "Vous n'avez pas accès à cette porte",
    },

    Outfits = {
        title = "Tenues",
        invalid = "Genre invalide",
        failed_equip = "Échec de l'équipement de la tenue",
        disabled = "Les tenues sont désactivées",
        civilian_clothes = "Changé en vêtements civils",
        reset_civilian_clothes = "Vous avez changé de nouveau en vêtements civils",
        no_civilian_saved = "Aucune tenue civile sauvegardée. Veuillez changer en uniforme d'abord.",
        no_permission = "Vous n'avez pas la permission d'utiliser cette tenue",
        outfit_not_found = "Tenue non trouvée",
        equip_success = "Tenue équipée avec succès",
        changed_to_uniform = "Vous avez changé en votre %s",
        reset_success = "Tenue réinitialisée avec succès",
        no_civilian_for_reset = "Aucune tenue civile sauvegardée. Veuillez changer en uniforme d'abord pour sauvegarder vos vêtements actuels.",
    },

    System = {
        success = "Succès",
        paycheck_error = "Erreur de paie",
        inventory_full = "Inventaire plein",
        inventory_full_description = "Votre inventaire est plein.",
        society_not_found = "Entreprise non trouvée",
        business_funds_insufficient = "L'entreprise n'a pas assez de fonds pour payer votre paie.",
        error = "Erreur",
        invalid = "Invalide",
        no_license = "Impossible de déterminer votre licence. Veuillez contacter un administrateur.",
        missing_items = "Articles manquants",
        item_cleaned = "Article nettoyé avec succès",
        missing_required = "Vous n'avez pas les articles requis",
        slot_error = "Mettez le montant dans le même slot",
        ice_collected = "La glace a été collectée",
        refreshing = "Rafraîchissement",
        refreshed = "Vous vous sentez rafraîchi",
        consumption = "Consommation",
        stress_increased = "Stress augmenté",
        stress_amount = "Votre niveau de stress a augmenté de %s",
        inventory_full = "Votre inventaire est plein",
    },

    Experience = {
        gained_title = "Expérience gagnée",
        experience_earned_description = "Vous avez gagné %d XP.",
        gained_message = "Vous avez gagné %d XP pour avoir complété la livraison !",
    },

    BossMenu = {
        title = "Menu du patron",
        unable_jobdetermine = "Impossible de déterminer votre travail. Veuillez réessayer plus tard.",
        bankruptcy_alert = "⚠️ Alerte de faillite",
        description = "Impossible de payer les salaires ! Solde de l'entreprise : $%s, Requis : $%s",
        trans_failed_bossmenubalance = "Transaction échouée - Fonds insuffisants de l'entreprise",
        menu_in_use = "Le menu du patron est actuellement utilisé par %s.",
        no_permissions = "Vous n'avez pas les permissions du patron ! Vous devez être Patron.",
        wrong_job = "Vous n'avez pas le bon travail",
        grade_updated = "Grade de travail mis à jour",
        grade_update_success = "Grade %s mis à jour avec succès.",
        menu_update = "Mise à jour du menu",
        menu_update_success = "Article du menu mis à jour avec succès !",
        vending_update = "Distributeur automatique",
        vending_update_success = "Article du distributeur mis à jour avec succès !",
        menu_update_error = "Échec de la mise à jour de l'article du menu !",
        menu_delete = "Suppression du menu",
        menu_delete_success = "Article du menu supprimé avec succès !",
        menu_delete_error = "Échec de la suppression de l'article du menu !",
        invite_sent = "Invitation envoyée",
        invite_sent_success = "Invitation de travail envoyée à %s",
        invite_error = "ID joueur ou rôle invalide !",
        player_not_found = "Joueur non trouvé !",
        job_error = "Données d'invitation invalides !",
        job_accepted = "Vous êtes maintenant un %s chez %s",
        job_updated_title = "Travail mis à jour",
        job_updated = "Votre position a été mise à jour à %s chez %s",
        database_error = "Votre travail a été défini mais la mise à jour de la base de données a échoué.",
        invite_rejected = "Vous avez rejeté l'invitation de travail.",
        withdraw_error = "Montant invalide !",
        business_error = "Entreprise non trouvée !",
        insufficient_funds = "Fonds insuffisants de l'entreprise !",
        money_withdrawn = "Vous avez retiré $%s du compte de l'entreprise.",
        transaction_failed = "Échec de la mise à jour du compte de l'entreprise !",
        money_deposited = "Vous avez déposé $%s sur le compte de l'entreprise.",
        transaction_failed_refund = "Échec de la mise à jour du compte de l'entreprise ! Votre argent a été retourné.",
        shop_purchase = "Nouvel achat en magasin",
        shop_purchase_notification = "%s a acheté des articles pour $%s",
        menu_occupied = "Menu du patron actuellement utilisé",
        menu_occupied_by = "%s utilise actuellement le menu du patron. Veuillez réessayer plus tard.",
        menu_released = "Menu du patron maintenant disponible",

        -- Main Headers and Titles
        business_overview = "Aperçu de l'entreprise",
        business_settings = "Paramètres de l'entreprise",
        menu_management = "Gestion du menu",
        staff_management = "Gestion du personnel",
        employee_leaderboard = "Classement des employés",
        sales_transactions = "Ventes et transactions",

        -- Finance Section
        finance = "Finance",
        business_balance = "Solde de l'entreprise",
        withdraw = "Retirer",
        deposit = "Déposer",
        withdraw_money = "Retirer de l'argent",
        deposit_money = "Déposer de l'argent",
        enter_amount_withdraw = "Entrez le montant que vous voulez retirer du compte de l'entreprise vers votre %s.",
        enter_amount_deposit = "Entrez le montant que vous voulez déposer de votre %s sur le compte de l'entreprise.",
        available = "Disponible",
        enter_amount = "Entrer le montant",
        withdraw_to = "Retirer vers %s",
        deposit_from = "Déposer de %s",
        updating = "Mise à jour...",
        update_avatar = "Mettre à jour l'avatar",
        cancel = "Annuler",
        cash = "Espèces",
        bank = "Banque",
        invalid_url = "URL invalide",
        invalid_url_message = "Veuillez entrer une URL d'image valide",
        avatar_updated = "Avatar mis à jour",
        avatar_updated_message = "Avatar mis à jour avec succès !",
        update_failed = "Mise à jour échouée",
        update_failed_message = "Échec de la mise à jour de l'avatar",
        business_status = "Statut de l'entreprise",
        business_status_desc = "Contrôlez le statut opérationnel de votre entreprise",
        business_operations = "Opérations de l'entreprise",
        business_open = "Accepte actuellement les clients - Facturation activée",
        business_closed = "Actuellement fermé aux clients - Facturation désactivée",
        business_status_updated = "Statut de l'entreprise",
        business_now_open = "L'entreprise est maintenant ouverte",
        business_now_closed = "L'entreprise est maintenant fermée",
        business_status_error = "Erreur",
        business_status_failed = "Échec de la mise à jour du statut de l'entreprise",

        -- Employees Section
        employees = "Employés",
        invite_new_employee = "Inviter un nouvel employé",
        player_id = "ID joueur...",
        invite = "Inviter",
        select_role = "Sélectionner le rôle",
        choose_role_for = "Choisir un rôle pour %s",
        available_roles = "Rôles disponibles :",
        roles_available = "%d rôles disponibles",
        send_invite = "Envoyer l'invitation",

        -- Sales Summary
        sales_summary = "Résumé des ventes",
        today = "Aujourd'hui",
        this_week = "Cette semaine",
        this_month = "Ce mois",
        view_sales = "Voir les ventes",

        -- Inventory Status
        inventory_status = "Statut de l'inventaire",
        storage_capacity = "Capacité de stockage",
        ingredients = "Ingrédients",
        supplies = "Fournitures",
        manage_inventory = "Gérer l'inventaire",

        -- Menu Management
        search_menu_items = "Rechercher des articles du menu...",
        edit_menu_item = "Modifier l'article du menu",
        update_item_details = "Mettez à jour les détails de l'article ci-dessous.",
        label_display_name = "Étiquette (Nom d'affichage)",
        price = "Prix ($)",
        category = "Catégorie",
        select_category = "Sélectionner une catégorie",
        update = "Mettre à jour",
        all_items = "Tous les articles",
        no_menu_items = "Aucun article de menu trouvé",
        no_category_items = "Aucun %s trouvé",

        -- Vending Machine Management
        vending_machine_management = "Gestion du distributeur automatique",
        search_vending_items = "Rechercher des articles du distributeur...",
        edit_vending_item = "Modifier l'article du distributeur",
        update_vending_details = "Mettez à jour les détails de l'article ci-dessous.",
        all_vending_items = "Tous les articles",
        no_vending_items = "Aucun article de distributeur trouvé",
        no_category_vending_items = "Aucun %s trouvé",
        vending_update_error = "Échec de la mise à jour de l'article du distributeur",
        item_price = "Prix",
        item_type = "Type",
        uncategorized = "Non catégorisé",
        enter_price = "par ex., 5",

        -- Staff Management
        employee_overview = "Aperçu de l'employé",
        total_employees = "Employés totaux",
        active_employees = "Employés actifs",
        pending_applications = "Demandes en attente",
        employee_list = "Liste des employés",
        search_employees = "Rechercher des employés...",
        all_employees = "Tous les employés",
        name = "Nom",
        role = "Rôle",
        salary = "Salaire",
        last_seen = "Dernière vue",
        actions = "Actions",
        promote = "Promouvoir",
        demote = "Rétrograder",
        fire = "Licencier",
        employee_actions = "Actions de l'employé",
        select_action = "Sélectionner une action pour %s",
        promote_employee = "Promouvoir l'employé",
        demote_employee = "Rétrograder l'employé",
        fire_employee = "Licencier l'employé",
        confirm_action = "Confirmer l'action",
        confirm_promote = "Êtes-vous sûr de vouloir promouvoir %s à %s ?",
        confirm_demote = "Êtes-vous sûr de vouloir rétrograder %s à %s ?",
        confirm_fire = "Êtes-vous sûr de vouloir licencier %s ?",
        action_success = "Action complétée avec succès",
        action_failed = "Action échouée",
        employee_promoted = "Employé promu avec succès",
        employee_demoted = "Employé rétrogradé avec succès",
        employee_fired = "Employé licencié avec succès",
        no_employees = "Aucun employé trouvé",

           -- Job Grades Management Dialog
        manage_job_grades = "Gérer les grades de travail",
        configure_salary_commission = "Configurer les taux de salaire et de commission pour chaque poste",
        search_job_grades = "Rechercher les grades de travail...",
        edit_job_grade = "Modifier le grade de travail",
        update_job_grade_details = "Mettre à jour les détails du grade de travail",
        job_title = "Titre du travail",
        commission_rate = "Taux de commission",
        boss_access = "Accès patron",
        boss_access_enabled = "Ce rôle a accès aux fonctionnalités de gestion",
        boss_access_disabled = "Ce rôle a un accès niveau employé",
        save_changes = "Sauvegarder les changements",
        boss_role = "Rôle de patron",
        grade_update_error = "Échec de la mise à jour du grade de travail",

        -- Employee Details View
        employee_overview = "Détails de l'employé",
        employee_profile = "Profil de l'employé",
        performance_stats = "Métriques de performance",
        back = "Retour",
        
        -- Employee Profile Card Labels
        commission = "Commission",
        total_earnings = "Gains totaux",
        available_balance = "Solde disponible",
        employee_id = "ID employé",
        
        -- Performance Stats Labels
        deliveries_label = "Livraisons",
        billings_label = "Facturations",
        earnings_label = "Gains",
        experience_label = "Expérience",
        level_label = "Niveau",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "Distribution des revenus",
        delivery_income = "Livraisons",
        commission_income = "Commission",
        paycheck_income = "Paies",
        completed_label = "complété",
        bills_label = "factures",
        hourly_label = "Horaire",

        -- Employee Card Labels (for list view)
        rank_label = "Rang",
        commission_label = "Commission",

        -- Role Change Dialog
        no_role_employees = "Aucun %s trouvé",
        employee_updated = "Employé mis à jour",
        employee_commission_updated = "Employé mis à jour avec taux de commission %s",
        fire_employee_error = "Échec du licenciement de l'employé",

        -- Employee Leaderboard
        top_performers = "Meilleurs performeurs",
        this_month_leaders = "Leaders de ce mois",
        rank = "Rang",
        employee = "Employé",
        performance = "Performance",
        orders_completed = "Commandes complétées",
        revenue_generated = "Revenus générés",
        customer_rating = "Évaluation client",
        no_data = "Aucune donnée de performance disponible",

        -- Transactions
        transaction_history = "Historique des transactions",
        recent_transactions = "Transactions récentes",
        paycheck_history = "Historique des paies",
        transaction_type = "Type de transaction",
        amount = "Montant",
        date = "Date",
        message = "Description",
        customer = "Client",
        filter_transactions = "Filtrer les transactions...",
        all_transactions = "Toutes les transactions",
        sales_only = "Ventes seulement",
        paychecks_only = "Paies seulement",
        no_transactions = "Aucune transaction trouvée",
        no_paychecks = "Aucun enregistrement de paie trouvé",


        -- Settings
        avatar_settings = "Paramètres d'avatar",
        update_profile_picture = "Mettre à jour votre photo de profil",
        image_url = "URL de l'image",
        enter_url_preview = "Entrez une URL ci-dessous pour prévisualiser votre avatar",
        preview = "Prévisualiser",
        enter_url_message = "Entrez l'URL de votre image d'avatar",
        ui_theme = "Thème UI",
        customize_appearance = "Personnaliser l'apparence du tableau de bord",
        light_mode = "Mode clair",
        dark_mode = "Mode sombre",

        -- Navigation
        home = "Accueil",
        staff = "Personnel",
        menu = "Menu",
        sales = "Ventes",
        top = "Top",
        settings = "Paramètres",

        -- Status Labels
        open = "Ouvert",
        closed = "Fermé",
        online = "En ligne",
        offline = "Hors ligne",
        active = "Actif",
        inactive = "Inactif",

        -- Common Actions
        save = "Sauvegarder",
        edit = "Modifier",
        delete = "Supprimer",
        confirm = "Confirmer",
        close = "Fermer",
        refresh = "Actualiser",
        loading = "Chargement...",

        -- Error Messages
        error_occurred = "Une erreur s'est produite",
        invalid_input = "Entrée invalide",
        operation_failed = "Opération échouée",
        permission_denied = "Permission refusée",
        network_error = "Erreur réseau",
        data_load_failed = "Échec du chargement des données",

        -- Success Messages
        operation_successful = "Opération complétée avec succès",
        data_saved = "Données sauvegardées avec succès",
        changes_applied = "Changements appliqués avec succès",
    },

    Shop = {
        shop_status = "Statut du magasin",
        shop_open = "Magasin ouvert",
        shop_closed = "Magasin fermé",
        access_denied = "Vous ne pouvez pas accéder à ce magasin !",
        purchase_title = "Magasin",
        purchase_success = "Achat terminé ! Articles ajoutés à votre inventaire.",
        purchase_error = "Échec de l'achat !",

        -- Search and Inventory
        search_placeholder = "Rechercher des produits par nom...",
        clear_search = "Effacer la recherche",
        shop_inventory = "Inventaire du magasin",
        items_count = "articles",

        -- Product Actions
        add_to_cart = "Ajouter",
        per_item = "par article",

        -- Cart
        your_cart = "Votre panier",
        cart_empty = "Panier vide",
        cart_empty_message = "Ajoutez des articles pour commencer les achats",
        items_label = "articles",
        total = "Total",

        -- Search Results
        no_items_found = "Aucun article trouvé",
        no_items_message = "Essayez d'ajuster votre recherche ou parcourez tous les articles",

        -- Payment
        pay_with_cash = "Espèces",
        pay_with_bank = "Banque",
        processing = "Traitement...",
        inventory_notice = "Les articles seront ajoutés directement à votre inventaire",

        -- Notifications
        cart_updated = "Panier mis à jour",
        item_added = "Article ajouté",
        item_removed = "Article retiré",
        quantity_updated = "Quantité mise à jour",
        purchase_complete = "Achat terminé",
        transaction_failed = "Transaction échouée",
        checkout_error = "Erreur de caisse",
        cart_empty_error = "Votre panier est vide",
        paid_with_cash = "Payé en espèces",
        charged_to_bank = "Facturé sur votre compte bancaire",
        not_enough_cash = "Pas assez d'espèces",
        insufficient_bank = "Solde bancaire insuffisant",

        -- Quantity Messages
        added_more = "Ajouté %d de plus %s",
        removed_items = "Retiré %d %s",
        added_to_cart = "%s ajouté au panier",
        removed_from_cart = "Retiré %s de votre panier",

        -- Loading
        loading_shop = "Chargement du menu du magasin...",
    },

    EmployeeMenu = {
        access_denied = "Vous ne pouvez pas accéder à cette porte !",
        commission_withdrawn = "Commission retirée",
        commission_withdrawn_description = "Vous avez retiré $%s de votre solde de commission vers votre %s.",
        transaction_failed = "Transaction échouée",
        fire_employee = "Licencier l'employé",
        commission_withdrawn_description = "Vous avez retiré $%s de votre solde de commission vers votre %s.",
        fire_employee_description = "%s a été licencié de votre entreprise !",
        employeeMent_notice = "Avis employé",
        
        no_employee_active = "Aucun employé n'est actuellement en ligne et actif pour gérer votre commande.",
        -- Main Headers and Navigation
        employee_portal = "Portail employé",
        employee_profile = "Profil employé",
        performance_stats = "Statistiques de performance",
        employee_leaderboard = "Classement des employés",
        job_outfits = "Tenues de travail",
        account_settings = "Paramètres du compte",

        -- Navigation Labels
        profile = "Profil",
        stats = "Stats",
        top = "Top",
        outfits = "Tenues",
        settings = "Paramètres",

        -- Profile Tab
        personal_information = "Informations personnelles",
        paycheck_information = "Informations de paie",
        job_role = "Rôle de travail",
        salary = "Salaire",
        experience = "Expérience",
        duty_status = "Statut de service",
        on_duty = "En service",
        off_duty = "Hors service",
        clock_in = "Pointer à l'arrivée",
        clock_out = "Pointer au départ",
        available_balance = "Solde disponible",
        withdraw = "Retirer",
        withdraw_funds = "Retirer des fonds",
        paycheck_interval = "Intervalle de paie",
        total_deliveries = "Livraisons totales",
        bills_created = "Factures créées",
        total_earnings = "Gains totaux",
        minutes = "minutes",

        -- Performance Tab
        career_statistics = "Statistiques de carrière",
        experience_points = "Points d'expérience",
        xp_points = "Points XP",
        total_earned = "Total gagné",
        current_balance = "Solde actuel",
        deliveries = "Livraisons",
        total_completed = "Total complété",
        billings = "Facturations",
        invoices_created = "Factures créées",
        job_grade_progression = "Progression du grade de travail",
        current_grade = "Grade actuel",
        level = "Niveau",
        xp_needed_promotion = "XP nécessaire pour la promotion",
        earn_more_xp = "Gagnez %d XP de plus pour être promu à %s",
        max_grade_reached = "Vous avez atteint le grade automatique le plus élevé ! Les promotions supplémentaires nécessitent l'approbation de la direction.",
        promotions_by_management = "Les promotions sont attribuées par la direction.",
        loading_experience_data = "Chargement des données du système d'expérience...",
        loading_progression_data = "Chargement des données de progression...",

        -- Leaderboard Tab
        top_performers = "Meilleurs performeurs",
        this_month_leaders = "Leaders de ce mois",
        rank = "Rang",
        employee = "Employé",
        performance = "Performance",
        no_leaderboard_data = "Aucune donnée de classement disponible",

        -- Outfits Tab
        work_outfits = "Tenues de travail",
        select_outfit = "Sélectionner la tenue",
        change_outfit = "Changer de tenue",
        outfit_changed = "Tenue changée",
        outfit_changed_success = "Votre tenue a été changée avec succès !",
        outfit_change_failed = "Échec du changement de tenue",
        outfit_preview = "Aperçu de la tenue",

        -- Settings Tab
        employee_settings = "Paramètres employé",
        avatar_settings = "Paramètres d'avatar",
        update_profile_picture = "Mettre à jour votre photo de profil",
        image_url = "URL de l'image",
        enter_url_preview = "Entrez une URL ci-dessous pour prévisualiser votre avatar",
        preview = "Prévisualiser",
        enter_url_message = "Entrez l'URL de votre image d'avatar",
        avatar_updated = "Avatar mis à jour",
        avatar_created = "Avatar créé",
        avatar_updated_message = "Avatar mis à jour avec succès !",
        update_failed = "Mise à jour échouée",
        update_failed_message = "Échec de la mise à jour de l'avatar",
        invalid_url = "URL invalide",
        invalid_url_message = "Veuillez entrer une URL d'image valide",
        updating = "Mise à jour...",
        update_avatar = "Mettre à jour l'avatar",

        -- UI Theme
        ui_theme = "Thème UI",
        customize_appearance = "Personnaliser l'apparence du tableau de bord",
        light_mode = "Mode clair",
        dark_mode = "Mode sombre",

        -- Notifications
        notifications = "Notifications",
        manage_notification_preferences = "Gérer les préférences de notification",
        employee_notifications = "Notifications employé",
        notifications_enabled_desc = "Vous recevrez toutes les mises à jour de paie des employés",
        notifications_disabled_desc = "Vous ne recevrez aucune notification",
        notifications_updated = "Notifications mises à jour",
        notifications_enabled_message = "Les notifications de paie sont maintenant activées",
        notifications_disabled_message = "Les notifications de paie sont maintenant désactivées",
        enabled = "Activé",
        disabled = "Désactivé",

        -- Withdrawal Dialog
        withdraw_all_funds = "Retirer tous les fonds",
        select_balance_type = "Sélectionner le type de solde",
        all_balance = "Solde total",
        delivery_balance = "Solde de livraison",
        commission_balance = "Solde de commission",
        paycheck_balance = "Solde de paie",
        available_balance_type = "Solde %s disponible : $%d",
        enter_amount = "Entrer le montant",
        insufficient_funds = "Fonds insuffisants",
        insufficient_balance = "Solde %s insuffisant",
        funds_withdrawn = "Fonds retirés",
        funds_withdrawn_success = "Retiré avec succès $%d de votre solde",
        transaction_failed = "Transaction échouée",
        withdrawal_failed = "Échec du retrait des fonds",
        invalid_amount = "Montant invalide",
        invalid_amount_message = "Veuillez entrer un montant valide",
        no_funds = "Aucun fonds",
        no_funds_message = "Vous n'avez aucun fonds à retirer",

        -- Common Actions
        cancel = "Annuler",
        save = "Sauvegarder",
        update = "Mettre à jour",
        confirm = "Confirmer",
        close = "Fermer",
        loading = "Chargement...",

        -- Status Labels
        active = "Actif",
        inactive = "Inactif",
        online = "En ligne",
        offline = "Hors ligne",

        -- Error Messages
        error_occurred = "Une erreur s'est produite",
        operation_failed = "Opération échouée",
        data_load_failed = "Échec du chargement des données",
        network_error = "Erreur réseau",
        employee_data_error = "Impossible de récupérer vos données d'employé.",
        identity_error = "Impossible de vérifier votre identité.",
        withdraw_invalid_amount = "Montant invalide !",
        insufficient_commission = "Solde de commission insuffisant !",
        transaction_failed_update = "Échec de la mise à jour du solde de commission !",
        fire_employee_not_found = "Employé non trouvé !",
        fire_employee_wrong_business = "Cet employé ne travaille pas pour votre entreprise !",
        fire_employee_db_error = "Échec du licenciement de l'employé de la base de données !",
        employment_notice_fired = "Vous avez été licencié de %s",
        avatar_invalid_url = "URL d'image fournie invalide.",
        avatar_updated_success = "Votre avatar de profil a été mis à jour avec succès.",
        avatar_no_changes = "Aucun changement n'a été apporté à votre avatar.",
        avatar_created = "Votre profil employé et avatar ont été créés.",
        avatar_create_failed = "Échec de la création de l'enregistrement employé.",
        withdrawal_invalid_amount = "Montant de retrait invalide.",
        employee_record_not_found_withdraw = "Enregistrement employé non trouvé.",
        insufficient_balance_withdraw = "Fonds insuffisants dans votre solde.",
        withdraw_balance_failed = "Échec du retrait du solde. Veuillez réessayer.",
        identity_error_toggle = "Impossible de vérifier votre identité",
        invalid_grade_data = "Données de grade fournies invalides.",
        grade_id_not_found = "Impossible de trouver l'ID de grade pour ce rôle.",
        no_grade_changes = "Aucun changement n'a été apporté au grade de travail.",
        balance_withdrawn = "Vous avez retiré $%d de votre solde %s vers votre %s.",
        player_not_found = "Joueur non trouvé !",
        invalid_purchase_data = "Données d'achat invalides !",
        insufficient_funds = "Pas assez de fonds dans votre %s !",
        inventory_full = "Pas assez d'espace d'inventaire ou limite de poids dépassée !",
        purchase_complete = "Achat terminé ! Articles ajoutés à votre inventaire.",
        shop_purchase = "Achat en magasin : %s",
        business_balance_error = "Erreur de mise à jour du solde de l'entreprise pour %s",
        business_balance_success = "Ajouté avec succès $%s au compte de l'entreprise",
        transaction_record_error = "Erreur d'enregistrement de la transaction pour l'achat en magasin",
        avatar_found = "Magasin : Avatar trouvé pour %s : %s",
        avatar_not_found = "Magasin : Aucun avatar trouvé pour %s, utilisation par défaut",
    },

    Vending = {
        invalid_item_data = "Données d'article invalides.",
        insufficient_item = "Vous n'avez pas assez de cet article.",
        item_added_with_money = "Article ajouté au stock. Reçu $%s pour %sx %s",
        item_added = "Article ajouté au stock.",
        business_balance_error = "Erreur de mise à jour du solde de l'entreprise pour la commande",
        database_error = "Erreur de base de données",
        add_item_failed = "Échec de l'ajout de l'article.",
        invalid_collection_data = "Données de collecte invalides.",
        inventory_full = "Impossible d'ajouter l'article à votre inventaire.",
        item_collected = "Collecté %sx %s",
        stock_update_failed = "Échec de la mise à jour du stock du distributeur.",
        out_of_stock = "En rupture de stock",
        insufficient_stock = "Pas assez d'articles disponibles à collecter.",
        sale_transaction_error = "Erreur d'enregistrement de la transaction de vente du distributeur",
        collection_transaction_error = "Erreur d'enregistrement de la transaction de collecte du distributeur",
    },

    JobSystem = {
        no_permission = "Vous n'avez pas la permission d'utiliser cette commande.",
        player_not_found = "Joueur non trouvé.",
        job_assigned = "Travail assigné.",
        job_assign_failed = "Échec de l'assignation du travail.",
        job_removed = "Travail retiré.",
        job_remove_failed = "Échec du retrait du travail.",
        job_changed_notification = "Travail changé",
        job_changed = "Votre travail a été changé en %s (grade %s).",
        job_removed_notification = "Votre travail a été retiré.",
        give_job_usage = "Utilisation : /%s [playerId] [jobName] [grade]",
        remove_job_usage = "Utilisation : /%s [playerId]",
        job_info = "Travail : %s (Grade : %s, Service : %s)",
        job_info_error = "Impossible d'obtenir vos informations de travail.",
        duty_status = "Vous êtes maintenant %s service.",
        not_on_duty = "Pas en service",
        must_be_on_duty = "Vous devez être en service pour recevoir des paies.",
        paycheck_title = "Paie",
        employer_insufficient_funds = "Votre patron n'a pas assez de fonds pour vous payer.",
        paycheck_added = "Paie de $%s ajoutée au solde employé pour %s pour le travail : %s",
        paycheck_received = "Vous avez reçu une paie de $%s de %s",
    },

    BillingInviteNotification = {
        message = "Vous avez reçu une demande de paiement.",

        -- Titles / headers
        title = "Demande de paiement",
        label = "Notification de facturation",

        -- Button labels
        pay_button = "Payer la facture",
        decline_button = "Refuser",

        -- Small UI labels used inside the notification component
        business_label = "Entreprise",
        total_amount_label = "Montant total",
        reason_label = "Raison",
        amount_label = "Montant :",

        -- Warning / helper texts
        warning_text = "Le paiement sera déduit de votre compte. Assurez-vous de fonds suffisants.",
        expires_text = "Expire dans %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "Vous avez été invité à rejoindre en tant que %s chez Burgershot. Acceptez-vous ?",

        -- Titles / headers
        title = "Invitation de travail",
        label = "Notification d'invitation de travail",

        -- Button labels
        accept_button = "Accepter",
        reject_button = "Rejeter",

        -- Small UI labels used inside the notification component
        company_label = "Entreprise",
        grade_label = "Grade",
        invites_left_label = "Invitations restantes",
        salary_label = "Salaire",

        -- Warning / helper texts
        warning_text = "Accepter ce travail vous engagera au rôle. Assurez-vous d'être prêt à commencer.",
        expires_text = "Expire dans %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "Menu du restaurant",
        onduty = "Vous devez être en service pour accéder au menu du restaurant.",
    },

    Duty = {
        status = "Statut de service",
        management = "Gestion du service",
        description = "Vous êtes maintenant %s service.",
        restaurant_area = "Zone du restaurant",
        clock_in = "Vous êtes entré dans la zone du restaurant. Utilisez le menu employé pour pointer à l'arrivée.",
        enter_workplace = "Vous êtes entré dans votre lieu de travail et êtes maintenant en service.",
        leave_workplace = "Vous avez quitté votre lieu de travail et êtes maintenant hors service.",
        inside_workplace = "Vous êtes à l'intérieur de votre lieu de travail - automatiquement défini en service.",
        outside_workplace = "Vous êtes à l'extérieur de votre lieu de travail - automatiquement défini hors service.",
        duty_warning = "Avertissement de service",
        auto_off_duty = "Vous serez automatiquement défini hors service lorsque vous serez à l'extérieur du restaurant.",
        no_permission_manage_duty = "Vous n'avez pas la permission de gérer le statut de service des employés",
        not_employee_of_job = "Le joueur n'est pas un employé de ce travail",
        duty_set_by_management = "Votre statut de service a été défini à %s par la direction",
        duty_management_success = "Défini avec succès le statut de service de %s à %s",
        updated_offline_employee = "Mis à jour le statut de service d'un employé hors ligne",
    },

    Paycheck = {
        title = "Paie reçue",
        message = "Vous avez reçu une paie de $%s de %s",
    },

    VendingMachine = {
        sell_item = "Vendre l'article",
        select_item_from_inventory = "Sélectionner l'article de l'inventaire",
        add_to_vending = "AJOUTER %s AU DISTRIBUTEUR",
        cancel = "ANNULER",
        no_matching_items = "Aucun article correspondant dans l'inventaire",
        stocked_items = "Articles stockés",
        sell = "Vendre",
        no_stock = "Aucun stock",
        items = "articles stockés",
        ready_to_serve = "Prêt à servir !",
    },

    EmployeeVendingMachine = {
        title = "Collecter du distributeur automatique",
        label = "Collecter des articles du stock du distributeur automatique",
        collect = "Collecter",
        cancel = "Annuler",
        quantity_available = "Quantité (Disponible : %s)",
        collect_item = "Collecter %s",
        collect_button = "Collecter",
        in_stock = "En stock",
        vending_machine_empty = "Ce distributeur automatique est vide.",
    },

    OrderingTab = {
        where_eating_today = "Où mangerez-vous aujourd'hui ?",
        eat_in = "Manger sur place",
        take_out = "À emporter",
        whats_up = "quoi de neuf ?",
        popular = "Populaire",
        done = "Terminé",
        my_order = "Ma commande",
        empty = "Vide",
        total = "Total",
        checkout = "Caisse",
        back = "Retour",
        no_menu_items = "Aucun article de menu disponible pour %s",
        loading = "Chargement...",
        eat_in_label = "Manger sur place",
        take_out_label = "À emporter",
        pay_cash = "Espèces",
        cancel = "Annuler",
        order = "Commander",
        total = "Total",
        pay_bank = "Banque",
        all_items = "Tous les articles",
        bank_only_disclaimer = "Le paiement ne peut être effectué que par banque.",
    },

    OrderManagementTable = {
        title = "Panneau de gestion des commandes",
        label = "Administration des commandes",
        filter_all = "Tout",
        filter_cooking = "Cuisson",
        filter_ready = "Prêt",
        filter_completed = "Terminé",
        filter_terminal_orders = "Commandes terminal",
        filter_self_pickup = "Commandes kiosque",
        sort_by = "Trier par",
        sort_day = "Jour",
        sort_amount = "Montant",
        sort_name = "Nom",
        no_orders = "Aucune commande ne correspond au filtre actuel.",
        accept = "ACCEPTER",
        accepting = "ACCEPTATION...",
        cooking = "CUISSON",
        ready = "PRÊT",
        complete = "TERMINÉ",
        completed = "TERMINÉ",
        assigned_to = "Assigné à : ",
        items_label = "Articles :",
        order_label = "Commande #",
        status_cooking = "cuisson",
        status_ready = "prêt",
        status_completed = "terminé",
        status_cancelled = "annulé",
        self_pickup = "Auto-récupération",
    }
}