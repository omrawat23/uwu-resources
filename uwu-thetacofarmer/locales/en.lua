-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["en"] = {
    
    WashHands = {
        title = "Sink",
        no_available = "No sink available",
        success = "Your hands are now clean!",
        error = "Error",
        fail = "Your hands are already clean!",
        targetfail = "You need to wash hands first!",
        item_cleaned = "Item cleaned successfully!",
        missing_required = "You don't have the required items"
    },

    Terminal = {
        SubmitText = "Send Invoice",

        -- Player Selection Tab
        select_player = "Select Player",
        nearby_players = "Nearby Players",
        search_players = "Search players...",
        no_players_found = "No players found nearby",
        loading_players = "Loading players...",
        player_selected = "Player Selected",

        -- Menu Items Tab
        menu_items = "Menu Items",
        items_added = "items added",
        search_menu_items = "Search menu items...",
        available_items = "Available Items",
        selected_items = "Selected Items",
        no_items_found = "No items found",
        no_items_selected = "No items selected",
        total_items = "Total Items",
        total = "Total",
        all = "All",

        -- Finalize Bill Tab
        finalize_bill = "Finalize Bill",
        customer_info = "Customer Information",
        order_summary = "Order Summary",
        amount_label = "Amount ($)",
        enter_amount = "Enter amount",
        reason_label = "Reason (Optional)",
        reason_placeholder = "Enter reason for bill",
        payment_method = "Payment Method",
        cash = "Cash",
        bank = "Bank",
        send_bill = "Send Bill",

        -- Commission
        your_commission = "Your Commission",
        commission_rate = "Commission Rate",

        -- Bills sent counter
        bills_sent = "Bills sent:",
        commission = "Commission:",

        -- Error Messages
        bill_error = "Bill Error",
        select_player_error = "Please select a player",
        invalid_amount_error = "Please enter a valid amount",

        -- Success Messages
        bill_sent_success = "Bill sent successfully!",
        bill_sent_title = "Bill Sent",
    },

    Consumable = {
        Drinking = "Drinking ", -- Drinking ItemName
        Eating = "Eating " -- Eating ItemName
    },

    Garage = {
        title = "Garage",
        no_vehicle = "No vehicle to return",
        not_job_vehicle = "This is not a Burgershot vehicle!",
        parked_title = "Vehicle Parked!",
        parked_message = "Your vehicle has been parked at this location!",
        in_vehicle = "You can not be in a vehicle!",
        too_far = "You are too far from the vehicle!",
        spawn_error = "You can't do this right now!",

        -- UI Text
        garage_title = "Garage",
        garage_active_vehicles = "Active",
        garage_manage = "Manage Active Vehicles",
        close = "Close",
        search_vehicles = "Search vehicles...",
        no_vehicles_found = "No vehicles found",
        dont_have_vehicle = "You don't have any vehicles stored in this garage.",
        select_vehicle = "Select a Vehicle",
        select_vehicle_message = "Choose a vehicle from the list to see its details and spawn it.",
        back = "Back",
        spawn_vehicle = "Spawn Vehicle",
        return_button = "Return",
        return_vehicle = "Return Vehicle",
        license_plate = "License Plate",

        -- Status Messages
        vehicle_spawned = "Vehicle spawned successfully",
        no_vehicle_to_return = "No vehicle to return",
        access_denied = "You don't have access to this garage.",
        all_spawn_points_blocked = "All spawn points are currently blocked. Please wait a moment.",
        vehicle_model_not_exist = "Vehicle model doesn't exist",
        failed_load_model = "Failed to load vehicle model",
        failed_create_vehicle = "Failed to create vehicle",
        invalid_vehicle_data = "Invalid vehicle model data",

        -- Error Messages
        error = "Error",
        garage_error = "Garage Error",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "Vehicle entity failed to create",
        no_spawn_points_available = "No spawn points available",
        vehicle_returned_parked = "Vehicle returned and parked.",
        vehicle_processed_remote = "Vehicle processed (Remote Return).",
    },

    Billing = {
        title = "Billing",
        payment_failed_byreceiver = "Payment failed: %s does not have enough funds in %s.",
        business_closed = "Billing is currently disabled by management.",
        commission_earned = "Commission Earned",
        commission_earned_description = "You have earned $%s in commission.",
        terminal_title = "Billing Terminal",
        off_duty_error = "You need to be on duty to use the billing terminal.",
        access_denied = "You don't have access to the billing terminal.",
        business_closed = "Billing is currently disabled by management.",
        payment_received = "Payment Received",
        payment_received_message = "Payment of $%s received from %s",
        payment_failed = "Payment Failed",
        payment_failed_message = "Bill payment failed",
        bill_sent = "Bill Sent",
        bill_sent_success = "Bill sent successfully!",
        bill_sent_error = "Failed to send bill.",
        bill_error = "Bill Error",
        invalid_bill = "Invalid bill!",
        invalid_bill_description = "The bill you are trying to pay does not exist.",
        invalid_target_amount = "Invalid target or amount!",
        player_not_found = "Player not found!",
        must_be_on_duty = "You must be on duty to send bills!",
        bill_sent_description = "You sent a bill of $%s to %s for %s",
        bill_payment_successful = "✅ Bill Payment Successful",
        bill_payment_failed_insufficient = "❌ Bill Payment Failed - Insufficient Funds",
        bill_rejected = "❌ Bill Rejected",
        insufficient_funds = "You don't have enough %s!",
        order_processed = "🍔 Order Processed",
        command_access_denied = "You cannot use this command!",
        payment_failed_insufficient = "You don't have enough %s!",
        bill_rejected_title = "Bill Rejected",

        kiosk_closed_title = "Kiosk Closed",
        kiosk_closed = "kiosk is currently closed by the management.",
        bill_rejected_sender = "%s rejected your bill of $%s",
        bill_rejected_receiver = "You rejected the bill of %s",
        billing_disabled = "Billing is currently disabled by management.",
        billing_off_duty = "You must be on duty to use billing.",
    },

    Delivery = {
        items_header = "Items to Deliver",
        reward_header = "Reward",
        accept_header = "Accept Delivery",
        decline_header = "Decline Delivery",
        menu_header = "Delivery Menu",
        no_delivery = "No active delivery!",
        new_delivery_title = "New Delivery",
        new_delivery_desc = "You have received a new delivery request.",
        delivery_expired = "Your delivery request has expired.",
        delivery_timeout = "You took too long to complete the delivery.",
        delivery_declined = "You declined the delivery request.",
        check_location = "Check your GPS for the delivery location.",
        check_location_error = "You don't have an active delivery to track.",
        delivery_accepted = "Delivery Accepted",
        delivery_complete_cash = "Delivery Complete - Paid in Cash %s",
        invalid_item = "Invalid item in delivery",
        delivery_failed = "Delivery Failed",
        invalid_items_data = "Invalid item data",

        -- UI Text
        delivery_title = "Delivery",
        close_menu = "Close",
        new_order = "New Order",
        in_progress = "In Progress",
        order_items = "Order Items:",
        payment = "Payment",
        delivery_status = "Delivery Status",
        deliver_instruction = "Deliver the food to the marked location on your map.",
        time_remaining = "Time remaining:",
        order_summary = "Order Summary:",
        accept = "Accept",
        decline = "Decline",
        cancel_delivery = "Cancel Delivery",

        -- Notifications
        delivery_accepted_notification = "Delivery Accepted Successfully",
        delivery_cancelled_notification = "Delivery Cancelled Successfully",

        -- Status Messages
        complete_delivery = "Complete Delivery",
        delivery_in_progress = "Delivery in progress...",
        head_to_location = "Head to the marked location to complete delivery",
    },

    Consumption = {
        title = "Consumption",
        description = "Frsh and tasty!",
        refresh_title = "Refreshing",
        refresh_description = "You feel refreshed",
    },

    Crafting = {
        craft_title = "Craft: %s",
        enter_amount_description = "Enter the amount to craft",
        crafting_successful = "Crafting Successful",
        crafted_description = "You crafted %d x %s",
        crafting_cancelled = "Crafting Cancelled",
        cancelled_description = "You cancelled crafting",
        no_space = "Not enough space in inventory",
    },

    Targets = {
        door = "Knock Door",
        door_icon = "fas fa-door-open",
        delivery_food = "Deliver Food",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "Ordering Tablet",
        ordering_tablet_error = "Ordering tablet function not available.",
        order_management_tablet = "Order Management Tablet",
        order_management_error = "Order management tablet function not available.",
        return_utensils = "Return Utensils",
        employee_vending = "Employee Vending",
    },

    Order = {
        complete = "Order Complete",
        description = "Your order has been processed. Bill added to inventory.",
        paycheck_suspended_description = "Paychecks are suspended while the business is closed.",
        paycheck_suspended = "Paycheck Suspended",
    },

    Door = {
        title = "Door ",
        description = "Door has been ",
        locked = "Door is locked",
        no_permissions = "You don't have permission to lock/unlock this door",
        access_denied_title = "Access Denied",
        access_granted = "You unlocked the door",
        access_denied = "You don't have access to this door",
    },

    Outfits = {
        title = "Outfits",
        invalid = "Invalid gender",
        failed_equip = "Failed to equip outfit",
        disabled = "Outfits are disabled",
        civilian_clothes = "Changed to Civilian Clothes",
        reset_civilian_clothes = "You have changed back to Civilian Clothes",
        no_civilian_saved = "No civilian outfit saved. Please change to uniform first.",
        no_permission = "You don't have permission to use this outfit",
        outfit_not_found = "Outfit not found",
        equip_success = "Outfit equipped successfully",
        changed_to_uniform = "You've changed into your %s",
        reset_success = "Outfit reset successfully",
        no_civilian_for_reset = "No civilian outfit saved. Please change to uniform first to save your current clothes.",
    },

    System = {
        success = "Success",
        paycheck_error = "Paycheck Error",
        inventory_full = "Inventory Full",
        inventory_full_description = "Your inventory is full.",
        society_not_found = "Business not found",
        business_funds_insufficient = "Business has insufficient funds to pay your paycheck.",
        error = "Error",
        invalid = "Invalid",
        no_license = "Could not determine your license. Please contact an administrator.",
        missing_items = "Missing Items",
        item_cleaned = "Item cleaned successfully",
        missing_required = "You don't have the required items",
        slot_error = "Put the amount in the same slot",
        ice_collected = "Ice has been collected",
        refreshing = "Refreshing",
        refreshed = "You feel refreshed",
        consumption = "Consumption",
        stress_increased = "Stress Increased",
        stress_amount = "Your stress level increased by %s",
        inventory_full = "Your inventory is full",
    },

    Experience = {
        gained_title = "Experience Gained",
        experience_earned_description = "You earned %d XP.",
        gained_message = "You earned %d XP for completing the delivery!",
    },

    BossMenu = {
        title = "Boss Menu",
        unable_jobdetermine = "Unable to determine your job. Please try again later.",
        bankruptcy_alert = "⚠️ Bankruptcy Alert",
        description = "Cannot pay salaries! Business balance: $%s, Required: $%s",
        trans_failed_bossmenubalance = "Transaction Failed - Insufficient Business Funds",
        menu_in_use = "The boss menu is currently in use by %s.",
        no_permissions = "You don't have boss permissions! You need to be Boss.",
        wrong_job = "You don't have the correct job",
        grade_updated = "Job Grade Updated",
        grade_update_success = "%s grade updated successfully.",
        menu_update = "Menu Update",
        menu_update_success = "Menu item updated successfully!",
        vending_update = "Vending Machine",
        vending_update_success = "Vending machine item updated successfully!",
        menu_update_error = "Failed to update menu item!",
        menu_delete = "Menu Delete",
        menu_delete_success = "Menu item deleted successfully!",
        menu_delete_error = "Failed to delete menu item!",
        invite_sent = "Invite Sent",
        invite_sent_success = "Job invitation sent to %s",
        invite_error = "Invalid player ID or role!",
        player_not_found = "Player not found!",
        job_error = "Invalid invitation data!",
        job_accepted = "You are now a %s at %s",
        job_updated_title = "Job Updated",
        job_updated = "Your position was updated to %s at %s",
        database_error = "Your job was set but database update failed.",
        invite_rejected = "You rejected the job invitation.",
        withdraw_error = "Invalid amount!",
        business_error = "Business not found!",
        insufficient_funds = "Insufficient business funds!",
        money_withdrawn = "You've withdrawn $%s from the business account.",
        transaction_failed = "Failed to update business account!",
        money_deposited = "You've deposited $%s to the business account.",
        transaction_failed_refund = "Failed to update business account! Your money has been returned.",
        shop_purchase = "New Shop Purchase",
        shop_purchase_notification = "%s purchased items for $%s",
        menu_occupied = "Boss menu is currently in use",
        menu_occupied_by = "%s is currently using the boss menu. Please try again later.",
        menu_released = "Boss menu is now available",

        -- Main Headers and Titles
        business_overview = "Business Overview",
        business_settings = "Business Settings",
        menu_management = "Menu Management",
        staff_management = "Staff Management",
        employee_leaderboard = "Employee Leaderboard",
        sales_transactions = "Sales & Transactions",

        -- Finance Section
        finance = "Finance",
        business_balance = "Business Balance",
        withdraw = "Withdraw",
        deposit = "Deposit",
        withdraw_money = "Withdraw Money",
        deposit_money = "Deposit Money",
        enter_amount_withdraw = "Enter the amount you want to withdraw from the business account to your %s.",
        enter_amount_deposit = "Enter the amount you want to deposit from your %s into the business account.",
        available = "Available",
        enter_amount = "Enter amount",
        withdraw_to = "Withdraw to %s",
        deposit_from = "Deposit from %s",
        updating = "Updating...",
        update_avatar = "Update Avatar",
        cancel = "Cancel",
        cash = "Cash",
        bank = "Bank",
        invalid_url = "Invalid URL",
        invalid_url_message = "Please enter a valid image URL",
        avatar_updated = "Avatar Updated",
        avatar_updated_message = "Avatar updated successfully!",
        update_failed = "Update Failed",
        update_failed_message = "Failed to update avatar",
        business_status = "Business Status",
        business_status_desc = "Control your business operating status",
        business_operations = "Billing Operations",
        business_open = "Billing terminal & kiosk is enabled",
        business_closed = "Billing terminal & kiosk is disabled",
        business_status_updated = "Business Status",
        business_now_open = "Business is now open",
        business_now_closed = "Business is now closed",

        vending_machines = "Vending Machine",
        vending_active = "Vending machine is active",
        vending_inactive = "Vending machine is inactive",
        business_status_error = "Error",
        business_status_failed = "Failed to update business status",

        -- Employees Section
        employees = "Employees",
        invite_new_employee = "Invite New Employee",
        player_id = "Player ID...",
        invite = "Invite",
        select_role = "Select Role",
        choose_role_for = "Choose a role for %s",
        available_roles = "Available Roles:",
        roles_available = "%d roles available",
        send_invite = "Send Invite",

        -- Sales Summary
        sales_summary = "Sales Summary",
        today = "Today",
        this_week = "This Week",
        this_month = "This Month",
        view_sales = "View Sales",

        -- Inventory Status
        inventory_status = "Inventory Status",
        storage_capacity = "Storage Capacity",
        ingredients = "Ingredients",
        supplies = "Supplies",
        manage_inventory = "Manage Inventory",

        -- Menu Management
        search_menu_items = "Search menu items...",
        edit_menu_item = "Edit Menu Item",
        update_item_details = "Update the item details below.",
        label_display_name = "Label (Display Name)",
        price = "Price ($)",
        category = "Category",
        select_category = "Select a category",
        update = "Update",
        all_items = "All Items",
        no_menu_items = "No menu items found",
        no_category_items = "No %s found",

        -- Vending Machine Management
        vending_machine_management = "Vending Machine Management",
        search_vending_items = "Search vending items...",
        edit_vending_item = "Edit Vending Item",
        update_vending_details = "Update the item details below.",
        all_vending_items = "All Items",
        no_vending_items = "No vending machine items found",
        no_category_vending_items = "No %s found",
        vending_update_error = "Failed to update vending machine item",
        item_price = "Price",
        item_type = "Type",
        uncategorized = "Uncategorized",
        enter_price = "e.g., 5",

        -- Staff Management
        employee_overview = "Employee Overview",
        total_employees = "Total Employees",
        active_employees = "Active Employees",
        pending_applications = "Pending Applications",
        employee_list = "Employee List",
        search_employees = "Search employees...",
        all_employees = "All Employees",
        name = "Name",
        role = "Role",
        salary = "Salary",
        last_seen = "Last Seen",
        actions = "Actions",
        promote = "Promote",
        demote = "Demote",
        fire = "Fire",
        employee_actions = "Employee Actions",
        select_action = "Select an action for %s",
        promote_employee = "Promote Employee",
        demote_employee = "Demote Employee",
        fire_employee = "Fire Employee",
        confirm_action = "Confirm Action",
        confirm_promote = "Are you sure you want to promote %s to %s?",
        confirm_demote = "Are you sure you want to demote %s to %s?",
        confirm_fire = "Are you sure you want to fire %s?",
        action_success = "Action completed successfully",
        action_failed = "Action failed",
        employee_promoted = "Employee promoted successfully",
        employee_demoted = "Employee demoted successfully",
        employee_fired = "Employee fired successfully",
        no_employees = "No employees found",

           -- Job Grades Management Dialog
        manage_job_grades = "Manage Job Grades",
        configure_salary_commission = "Configure salary and commission rates for each position",
        search_job_grades = "Search job grades...",
        edit_job_grade = "Edit Job Grade",
        update_job_grade_details = "Update job grade details",
        job_title = "Job Title",
        commission_rate = "Commission Rate",
        boss_access = "Boss Access",
        boss_access_enabled = "This role has access to management features",
        boss_access_disabled = "This role has employee-level access",
        save_changes = "Save Changes",
        boss_role = "Boss Role",
        grade_update_error = "Failed to update job grade",

        -- Employee Details View
        employee_overview = "Employee Details",
        employee_profile = "Employee Profile",
        performance_stats = "Performance Metrics",
        back = "Back",
        
        -- Employee Profile Card Labels
        commission = "Commission",
        total_earnings = "Total Earnings",
        available_balance = "Available Balance",
        employee_id = "Employee ID",
        
        -- Performance Stats Labels
        deliveries_label = "Deliveries",
        billings_label = "Billings",
        earnings_label = "Earnings",
        experience_label = "Experience",
        level_label = "Level",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "Income Distribution",
        delivery_income = "Deliveries",
        commission_income = "Commission",
        paycheck_income = "Paychecks",
        completed_label = "completed",
        bills_label = "bills",
        hourly_label = "Hourly",

        -- Employee Card Labels (for list view)
        rank_label = "Rank",
        commission_label = "Commission",

        -- Role Change Dialog
        no_role_employees = "No %s found",
        employee_updated = "Employee Updated",
        employee_commission_updated = "Employee updated with %s commission rate",
        fire_employee_error = "Failed to fire employee",

        -- Employee Leaderboard
        top_performers = "Top Performers",
        this_month_leaders = "This Month's Leaders",
        rank = "Rank",
        employee = "Employee",
        performance = "Performance",
        orders_completed = "Orders Completed",
        revenue_generated = "Revenue Generated",
        customer_rating = "Customer Rating",
        no_data = "No performance data available",

        -- Transactions
        transaction_history = "Transaction History",
        recent_transactions = "Recent Transactions",
        paycheck_history = "Paycheck History",
        transaction_type = "Transaction Type",
        amount = "Amount",
        date = "Date",
        message = "Description",
        customer = "Customer",
        filter_transactions = "Filter transactions...",
        all_transactions = "All Transactions",
        sales_only = "Sales Only",
        paychecks_only = "Paychecks Only",
        no_transactions = "No transactions found",
        no_paychecks = "No paycheck records found",


        -- Settings
        avatar_settings = "Avatar Settings",
        update_profile_picture = "Update your profile picture",
        image_url = "Image URL",
        enter_url_preview = "Enter a URL below to preview your avatar",
        preview = "Preview",
        enter_url_message = "Enter the URL of your avatar image",
        ui_theme = "UI Theme",
        customize_appearance = "Customize the appearance of the dashboard",
        light_mode = "Light Mode",
        dark_mode = "Dark Mode",

        -- Navigation
        home = "Home",
        staff = "Staff",
        menu = "Menu",
        sales = "Sales",
        top = "Top",
        settings = "Settings",

        -- Status Labels
        open = "Open",
        closed = "Closed",
        online = "Online",
        offline = "Offline",
        active = "Active",
        inactive = "Inactive",

        -- Common Actions
        save = "Save",
        edit = "Edit",
        delete = "Delete",
        confirm = "Confirm",
        close = "Close",
        refresh = "Refresh",
        loading = "Loading...",

        -- Error Messages
        error_occurred = "An error occurred",
        invalid_input = "Invalid input",
        operation_failed = "Operation failed",
        permission_denied = "Permission denied",
        network_error = "Network error",
        data_load_failed = "Failed to load data",

        -- Success Messages
        operation_successful = "Operation completed successfully",
        data_saved = "Data saved successfully",
        changes_applied = "Changes applied successfully",
    },

    Shop = {
        shop_status = "Shop Status",
        shop_open = "Shop is Open",
        shop_closed = "Shop is Closed",
        access_denied = "You cannot access this shop!",
        purchase_title = "Shop",
        purchase_success = "Purchase complete! Items added to your inventory.",
        purchase_error = "Checkout failed!",

        -- Search and Inventory
        search_placeholder = "Search products by name...",
        clear_search = "Clear search",
        shop_inventory = "Shop Inventory",
        items_count = "items",

        -- Product Actions
        add_to_cart = "Add",
        per_item = "per/item",

        -- Cart
        your_cart = "Your Cart",
        cart_empty = "Cart is Empty",
        cart_empty_message = "Add items to start shopping",
        items_label = "items",
        total = "Total",

        -- Search Results
        no_items_found = "No items found",
        no_items_message = "Try adjusting your search or browse all items",

        -- Payment
        pay_with_cash = "Cash",
        pay_with_bank = "Bank",
        processing = "Processing...",
        inventory_notice = "Items will be added directly to your inventory",

        -- Notifications
        cart_updated = "Cart Updated",
        item_added = "Item Added",
        item_removed = "Item Removed",
        quantity_updated = "Quantity Updated",
        purchase_complete = "Purchase Complete",
        transaction_failed = "Transaction Failed",
        checkout_error = "Checkout Error",
        cart_empty_error = "Your cart is empty",
        paid_with_cash = "Paid with cash",
        charged_to_bank = "Charged to your bank account",
        not_enough_cash = "Not enough cash",
        insufficient_bank = "Insufficient bank balance",

        -- Quantity Messages
        added_more = "Added %d more %s",
        removed_items = "Removed %d %s",
        added_to_cart = "%s added to cart",
        removed_from_cart = "Removed %s from your cart",

        -- Loading
        loading_shop = "Loading Shop Menu...",
    },

    EmployeeMenu = {
        access_denied = "You cannot access this portal!",
        commission_withdrawn = "Commission Withdrawn",
        commission_withdrawn_description = "You've withdrawn $%s from your commission balance to your %s.",
        transaction_failed = "Transaction Failed",
        fire_employee = "Fire Employee",
        commission_withdrawn_description = "You've withdrawn $%s from your commission balance to your %s.",
        fire_employee_description = "%s has been fired from your business!",
        employeeMent_notice = "Employee Notice",
        
        no_employee_active = "No employees are currently online and active to handle your order.",
        -- Main Headers and Navigation
        employee_portal = "Employee Portal",
        employee_profile = "Employee Profile",
        performance_stats = "Performance Stats",
        employee_leaderboard = "Employee Leaderboard",
        job_outfits = "Job Outfits",
        account_settings = "Account Settings",

        -- Navigation Labels
        profile = "Profile",
        stats = "Stats",
        top = "Top",
        outfits = "Outfits",
        settings = "Settings",

        -- Profile Tab
        personal_information = "Personal Information",
        paycheck_information = "Paycheck Information",
        job_role = "Job Role",
        salary = "Salary",
        experience = "Experience",
        duty_status = "Duty Status",
        on_duty = "On Duty",
        off_duty = "Off Duty",
        clock_in = "Clock In",
        clock_out = "Clock Out",
        available_balance = "Available Balance",
        withdraw = "Withdraw",
        withdraw_funds = "Withdraw Funds",
        paycheck_interval = "Paycheck Interval",
        total_deliveries = "Total Deliveries",
        bills_created = "Bills Created",
        total_earnings = "Total Earnings",
        minutes = "minutes",

        -- Performance Tab
        career_statistics = "Career Statistics",
        experience_points = "Experience",
        xp_points = "XP Points",
        total_earned = "Total Earned",
        current_balance = "Current Balance",
        deliveries = "Deliveries",
        total_completed = "Total Completed",
        billings = "Billings",
        invoices_created = "Invoices Created",
        job_grade_progression = "Job Grade Progression",
        current_grade = "Current Grade",
        level = "Level",
        xp_needed_promotion = "XP needed for promotion",
        earn_more_xp = "Earn %d more XP to be promoted to %s",
        max_grade_reached = "You've reached the highest automatic grade! Further promotions require management approval.",
        promotions_by_management = "Promotions are assigned by management.",
        loading_experience_data = "Loading experience system data...",
        loading_progression_data = "Loading progression data...",

        -- Leaderboard Tab
        top_performers = "Top Performers",
        this_month_leaders = "This Month's Leaders",
        rank = "Rank",
        employee = "Employee",
        performance = "Performance",
        no_leaderboard_data = "No leaderboard data available",

        -- Outfits Tab
        work_outfits = "Work Outfits",
        select_outfit = "Select Outfit",
        change_outfit = "Change Outfit",
        outfit_changed = "Outfit Changed",
        outfit_changed_success = "Your outfit has been changed successfully!",
        outfit_change_failed = "Failed to change outfit",
        outfit_preview = "Outfit Preview",

        -- Settings Tab
        employee_settings = "Employee Settings",
        avatar_settings = "Avatar Settings",
        update_profile_picture = "Update your profile picture",
        image_url = "Image URL",
        enter_url_preview = "Enter a URL below to preview your avatar",
        preview = "Preview",
        enter_url_message = "Enter the URL of your avatar image",
        avatar_updated = "Avatar Updated",
        avatar_created = "Avatar Created",
        avatar_updated_message = "Avatar updated successfully!",
        update_failed = "Update Failed",
        update_failed_message = "Failed to update avatar",
        invalid_url = "Invalid URL",
        invalid_url_message = "Please enter a valid image URL",
        updating = "Updating...",
        update_avatar = "Update Avatar",

        -- UI Theme
        ui_theme = "UI Theme",
        customize_appearance = "Customize dashboard appearance",
        light_mode = "Light Mode",
        dark_mode = "Dark Mode",

        -- Notifications
        notifications = "Notifications",
        manage_notification_preferences = "Manage notification preferences",
        employee_notifications = "Employee Notifications",
        notifications_enabled_desc = "You will receive all employee paycheck updates",
        notifications_disabled_desc = "You will not receive notifications",
        notifications_updated = "Notifications Updated",
        notifications_enabled_message = "Paycheck notifications are now enabled",
        notifications_disabled_message = "Paycheck notifications are now disabled",
        enabled = "Enabled",
        disabled = "Disabled",

        -- Withdrawal Dialog
        withdraw_all_funds = "Withdraw All Funds",
        select_balance_type = "Select Balance Type",
        all_balance = "All Balance",
        delivery_balance = "Delivery Balance",
        commission_balance = "Commission Balance",
        paycheck_balance = "Paycheck Balance",
        available_balance_type = "Available %s Balance: $%d",
        enter_amount = "Enter amount",
        insufficient_funds = "Insufficient Funds",
        insufficient_balance = "Insufficient %s balance",
        funds_withdrawn = "Funds Withdrawn",
        funds_withdrawn_success = "Successfully withdrew $%d from your balance",
        transaction_failed = "Transaction Failed",
        withdrawal_failed = "Failed to withdraw funds",
        invalid_amount = "Invalid Amount",
        invalid_amount_message = "Please enter a valid amount",
        no_funds = "No Funds",
        no_funds_message = "You don't have any funds to withdraw",

        -- Common Actions
        cancel = "Cancel",
        save = "Save",
        update = "Update",
        confirm = "Confirm",
        close = "Close",
        loading = "Loading...",

        -- Status Labels
        active = "Active",
        inactive = "Inactive",
        online = "Online",
        offline = "Offline",

        -- Error Messages
        error_occurred = "An error occurred",
        operation_failed = "Operation failed",
        data_load_failed = "Failed to load data",
        network_error = "Network error",
        employee_data_error = "Could not retrieve your employee data.",
        identity_error = "Could not verify your identity.",
        withdraw_invalid_amount = "Invalid amount!",
        insufficient_commission = "Insufficient commission balance!",
        transaction_failed_update = "Failed to update commission balance!",
        fire_employee_not_found = "Employee not found!",
        fire_employee_wrong_business = "This employee doesn't work for your business!",
        fire_employee_db_error = "Failed to fire employee from database!",
        employment_notice_fired = "You have been fired from %s",
        avatar_invalid_url = "Invalid image URL provided.",
        avatar_updated_success = "Your profile avatar has been updated successfully.",
        avatar_no_changes = "No changes were made to your avatar.",
        avatar_created = "Your employee profile and avatar have been created.",
        avatar_create_failed = "Failed to create employee record.",
        withdrawal_invalid_amount = "Invalid withdrawal amount.",
        employee_record_not_found_withdraw = "Employee record not found.",
        insufficient_balance_withdraw = "Insufficient funds in your balance.",
        withdraw_balance_failed = "Failed to withdraw from balance. Please try again.",
        identity_error_toggle = "Could not verify your identity",
        invalid_grade_data = "Invalid grade data provided.",
        grade_id_not_found = "Could not find grade ID for this role.",
        no_grade_changes = "No changes were made to the job grade.",
        balance_withdrawn = "You withdrew $%d from your %s balance to your %s.",
        player_not_found = "Player not found!",
        invalid_purchase_data = "Invalid purchase data!",
        insufficient_funds = "Not enough funds in your %s!",
        inventory_full = "Not enough inventory space or weight limit exceeded!",
        purchase_complete = "Purchase complete! Items added to your inventory.",
        shop_purchase = "Shop Purchase: %s",
        business_balance_error = "Error updating business balance for %s",
        business_balance_success = "Successfully added $%s to business account",
        transaction_record_error = "Error recording transaction for shop purchase",
        avatar_found = "Shop: Found avatar for %s: %s",
        avatar_not_found = "Shop: No avatar found for %s, using default",
    },

    Vending = {
        invalid_item_data = "Invalid item data.",
        insufficient_item = "You do not have enough of this item.",
        item_added_with_money = "Item added to stock. Received $%s for %sx %s",
        item_added = "Item added to stock.",
        business_balance_error = "Error updating business balance for ordering",
        database_error = "Database Error",
        add_item_failed = "Failed to add item.",
        invalid_collection_data = "Invalid collection data.",
        inventory_full = "Could not add item to your inventory.",
        item_collected = "Collected %sx %s",
        stock_update_failed = "Failed to update vending stock.",
        out_of_stock = "Out of Stock",
        insufficient_stock = "Not enough items available to collect.",
        sale_transaction_error = "Error recording vending sale transaction",
        collection_transaction_error = "Error recording vending collection transaction",
    },

    JobSystem = {
        no_permission = "You don't have permission to use this command.",
        player_not_found = "Player not found.",
        job_assigned = "Job assigned.",
        job_assign_failed = "Failed to assign job.",
        job_removed = "Job removed.",
        job_remove_failed = "Failed to remove job.",
        job_changed_notification = "Job Changed",
        job_changed = "Your job has been changed to %s (grade %s).",
        job_removed_notification = "Your job has been removed.",
        give_job_usage = "Usage: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "Usage: /%s [playerId]",
        job_info = "Job: %s (Grade: %s, Duty: %s)",
        job_info_error = "Couldn't get your job info.",
        duty_status = "You are now %s duty.",
        not_on_duty = "Not On Duty",
        must_be_on_duty = "You must be on duty to receive paychecks.",
        paycheck_title = "Paycheck",
        employer_insufficient_funds = "Your boss doesn't have enough funds to pay you.",
        paycheck_added = "Paycheck of $%s added to employee balance for %s for job: %s",
        paycheck_received = "You received a paycheck of $%s from %s",
    },

    BillingInviteNotification = {
        message = "You've received a payment request.",

        -- Titles / headers
        title = "Payment Request",
        label = "Billing Notification",

        -- Button labels
        pay_button = "Pay Bill",
        decline_button = "Decline",

        -- Small UI labels used inside the notification component
        business_label = "Business",
        total_amount_label = "Total Amount",
        reason_label = "Reason",
        amount_label = "Amount:",

        -- Warning / helper texts
        warning_text = "Payment will be deducted from your account. Ensure sufficient funds.",
        expires_text = "Expires in %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "You have been invited to join as %s at Burgershot. Do you accept?",

        -- Titles / headers
        title = "Job Invitation",
        label = "Job Invitation Notification",

        -- Button labels
        accept_button = "Accept",
        reject_button = "Reject",

        -- Small UI labels used inside the notification component
        company_label = "Company",
        grade_label = "Grade",
        invites_left_label = "Invites Left",
        salary_label = "Salary",

        -- Warning / helper texts
        warning_text = "Accepting this job will commit you to the role. Make sure you're ready to start.",
        expires_text = "Expires in %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "Restaurant Menu",
        onduty = "You need to be on duty to access the restaurant menu.",
    },

    Duty = {
        status = "Duty Status",
        management = "Duty Management",
        description = "You are now %s duty.",
        restaurant_area = "Restaurant Area",
        clock_in = "You've entered the restaurant area. Use employee menu to clock in.",
        enter_workplace = "You've entered your workplace and are now on duty.",
        leave_workplace = "You've left your workplace and are now off duty.",
        inside_workplace = "You're inside your workplace - automatically set to on duty.",
        outside_workplace = "You're outside your workplace - automatically set to off duty.",
        duty_warning = "Duty Warning",
        auto_off_duty = "You'll be automatically set off duty when outside the restaurant.",
        no_permission_manage_duty = "You don't have permission to manage employee duty status",
        not_employee_of_job = "Player is not an employee of this job",
        duty_set_by_management = "Your duty status was set to %s by management",
        duty_management_success = "Successfully set %s's duty status to %s",
        updated_offline_employee = "Updated offline employee's duty status",
    },

    Paycheck = {
        title = "Paycheck Received",
        message = "You received a paycheck of $%s from %s",
    },

    VendingMachine = {
        sell_item = "Sell Item",
        select_item_from_inventory = "Select Item from Inventory",
        add_to_vending = "ADD %s TO VENDING",
        cancel = "CANCEL",
        no_matching_items = "No matching items in inventory",
        stocked_items = "Stocked Items",
        sell = "Sell",
        no_stock = "No Stock",
        items = "items stocked",
        ready_to_serve = "Ready to Serve!",
    },

    EmployeeVendingMachine = {
        title = "Collect from Vending Machine",
        label = "Collect items from vending machine stock",
        collect = "Collect",
        cancel = "Cancel",
        quantity_available = "Quantity (Available: %s)",
        collect_item = "Collect %s",
        collect_button = "Collect",
        in_stock = "In Stock",
        vending_machine_empty = "This vending machine is empty.",
    },

    OrderingTab = {
        where_eating_today = "What will you be eating today?",
        eat_in = "Eat In",
        take_out = "Take Out",
        whats_up = "what's up?",
        popular = "Popular",
        done = "Done",
        my_order = "My Order",
        empty = "Empty",
        total = "Total",
        checkout = "Checkout",
        back = "Back",
        no_menu_items = "No menu items available for %s",
        loading = "Loading...",
        eat_in_label = "Eat In",
        take_out_label = "Take Out",
        pay_cash = "Cash",
        cancel = "Cancel",
        order = "Order",
        total = "Total",
        pay_bank = "Bank",
        all_items = "All Items",
        bank_only_disclaimer = "Payment can be made through bank only.",
    },

    OrderManagementTable = {
        title = "Order Management Panel",
        label = "Order Administration",
        filter_all = "All",
        filter_cooking = "Cooking",
        filter_ready = "Ready",
        filter_completed = "Completed",
        filter_terminal_orders = "Terminal Orders",
        filter_self_pickup = "Kiosk Orders",
        sort_by = "Sort By",
        sort_day = "Day",
        sort_amount = "Amount",
        sort_name = "Name",
        no_orders = "No orders match the current filter.",
        accept = "ACCEPT",
        accepting = "ACCEPTING...",
        cooking = "COOKING",
        ready = "READY",
        complete = "COMPLETE",
        completed = "COMPLETED",
        assigned_to = "Assigned to: ",
        items_label = "Items:",
        order_label = "Order #",
        status_cooking = "cooking",
        status_ready = "ready",
        status_completed = "completed",
        status_cancelled = "cancelled",
        self_pickup = "Self Pickup",
    },

    MenuSelectionDialog = {
        title = "Choose Action",
        subtitle = "What would you like to do?",
        options = {
            shop = {
                title = "Open Shop",
                description = "Browse and purchase items from the vending machine"
            },
            manageBoss = {
                title = "Manage Shop",
                description = "Manage inventory, view analytics, and control the vending machine"
            },
            manageEmployee = {
                title = "Manage Shop",
                description = "Add and manage inventory items in the vending machine"
            }
        }
    }
}

