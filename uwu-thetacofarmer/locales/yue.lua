-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["yue"] = {
    
    WashHands = {
        title = "洗手盤",
        no_available = "冇可用嘅洗手盤",
        success = "你隻手乾淨曬啦!",
        error = "錯誤",
        fail = "你隻手已經好乾淨!",
        targetfail = "你需要洗手先!",
        item_cleaned = "物品已經清洗乾淨!",
        missing_required = "缺少所需物品"
    },

    Terminal = {
        SubmitText = "發送帳單",

        -- Player Selection Tab
        select_player = "選擇玩家",
        nearby_players = "附近玩家",
        search_players = "搜尋玩家...",
        no_players_found = "附近搵唔到玩家",
        loading_players = "載入緊玩家...",
        player_selected = "已選擇玩家",

        -- Menu Items Tab
        menu_items = "餐單項目",
        items_added = "項目已加入",
        search_menu_items = "搜尋餐單項目...",
        available_items = "可用項目",
        selected_items = "已選項目",
        no_items_found = "搵唔到項目",
        no_items_selected = "未選擇項目",
        total_items = "總項目",
        total = "總計",
        all = "全部",

        -- Finalize Bill Tab
        finalize_bill = "結算帳單",
        customer_info = "顧客資料",
        order_summary = "訂單摘要",
        amount_label = "金額 ($)",
        enter_amount = "輸入金額",
        reason_label = "原因 (選填)",
        reason_placeholder = "輸入帳單原因",
        payment_method = "付款方式",
        cash = "現金",
        bank = "銀行",
        send_bill = "發送帳單",

        -- Commission
        your_commission = "你嘅佣金",
        commission_rate = "佣金率",

        -- Bills sent counter
        bills_sent = "已發送帳單:",
        commission = "佣金:",

        -- Error Messages
        bill_error = "帳單錯誤",
        select_player_error = "請選擇玩家",
        invalid_amount_error = "請輸入有效金額",

        -- Success Messages
        bill_sent_success = "帳單發送成功!",
        bill_sent_title = "帳單已發送",
    },

    Consumable = {
        Drinking = "飲緊 ", -- Drinking ItemName
        Eating = "食緊 " -- Eating ItemName
    },

    Garage = {
        title = "車庫",
        no_vehicle = "冇車可以還",
        not_job_vehicle = "呢架唔係 Burgershot 嘅車!",
        parked_title = "車輛已停泊!",
        parked_message = "你架車已經泊咗喺呢個位置!",
        in_vehicle = "你唔可以留喺車入面!",
        too_far = "離架車太遠啦!",
        spawn_error = "而家做唔到!",

        -- UI Text
        garage_title = "車庫",
        garage_active_vehicles = "活躍",
        garage_manage = "管理活躍車輛",
        close = "關閉",
        search_vehicles = "搜尋車輛...",
        no_vehicles_found = "搵唔到車輛",
        dont_have_vehicle = "你喺呢個車庫冇存放車輛。",
        select_vehicle = "選擇車輛",
        select_vehicle_message = "喺清單選擇一架車嚟睇詳情同取出。",
        back = "返回",
        spawn_vehicle = "取出車輛",
        return_button = "歸還",
        return_vehicle = "歸還車輛",
        license_plate = "車牌",

        -- Status Messages
        vehicle_spawned = "車輛已成功取出",
        no_vehicle_to_return = "冇車可以還",
        access_denied = "你冇權限使用呢個車庫。",
        all_spawn_points_blocked = "所有車位暫時被佔用，請稍後。",
        vehicle_model_not_exist = "車輛型號唔存在",
        failed_load_model = "載入車輛型號失敗",
        failed_create_vehicle = "建立車輛失敗",
        invalid_vehicle_data = "無效嘅車輛型號資料",

        -- Error Messages
        error = "錯誤",
        garage_error = "車庫錯誤",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "建立車輛實體失敗",
        no_spawn_points_available = "冇可用嘅車位",
        vehicle_returned_parked = "車輛已歸還並停泊。",
        vehicle_processed_remote = "車輛已處理 (遠程歸還)。",
    },

    Billing = {
        title = "開單",
        payment_failed_byreceiver = "付款失敗: %s 唔夠錢俾 %s。",
        business_closed = "開單功能目前已被管理員關閉。",
        commission_earned = "賺取佣金",
        commission_earned_description = "你賺取咗 $%s 佣金。",
        terminal_title = "開單終端機",
        off_duty_error = "你要上班先可以用終端機。",
        access_denied = "你冇權限使用開單終端機。",
        payment_received = "收到付款",
        payment_received_message = "收到 %s 嘅 $%s 付款",
        payment_failed = "付款失敗",
        payment_failed_message = "帳單付款失敗",
        bill_sent = "帳單已發送",
        bill_sent_success = "帳單發送成功!",
        bill_sent_error = "發送帳單失敗。",
        bill_error = "帳單錯誤",
        invalid_bill = "無效帳單!",
        invalid_bill_description = "你嘗試俾錢嘅帳單唔存在。",
        invalid_target_amount = "無效嘅目標或金額!",
        player_not_found = "搵唔到玩家!",
        must_be_on_duty = "你要上班先可以發送帳單!",
        bill_sent_description = "發送咗張 $%s 嘅單俾 %s，原因: %s",
        bill_payment_successful = "✅ 帳單付款成功",
        bill_payment_failed_insufficient = "❌ 帳單付款失敗 - 餘額不足",
        bill_rejected = "❌ 帳單被拒絕",
        insufficient_funds = "%s 唔夠錢!",
        order_processed = "🍔 訂單已處理",
        command_access_denied = "你唔可以用呢個指令!",
        payment_failed_insufficient = "%s 唔夠錢!",
        bill_rejected_title = "帳單被拒絕",

        bill_rejected_sender = "%s 拒絕咗你張 $%s 嘅單",
        bill_rejected_receiver = "你拒絕咗 %s 嘅單",
        billing_disabled = "開單功能目前已被管理員關閉。",
        billing_off_duty = "你要上班先可以用開單功能。",
    },

    Delivery = {
        items_header = "外賣物品",
        reward_header = "獎勵",
        accept_header = "接受外賣",
        decline_header = "拒絕外賣",
        menu_header = "外賣選單",
        no_delivery = "冇進行中嘅外賣!",
        new_delivery_title = "新外賣",
        new_delivery_desc = "你收到一個新嘅外賣請求。",
        delivery_expired = "你嘅外賣請求已經過期。",
        delivery_timeout = "你唔夠時間完成外賣。",
        delivery_declined = "你拒絕咗外賣請求。",
        check_location = "檢查 GPS 睇送貨地點。",
        check_location_error = "冇進行中嘅外賣可以追蹤。",
        delivery_accepted = "已接受外賣",
        invalid_item = "無效嘅外賣物品",
        delivery_failed = "外賣失敗",
        invalid_items_data = "無效嘅物品資料",

        -- UI Text
        delivery_title = "外賣",
        close_menu = "關閉選單",
        new_order = "新訂單",
        in_progress = "進行中",
        order_items = "訂單物品:",
        payment = "付款",
        delivery_status = "外賣狀態",
        deliver_instruction = "送食物去地圖標記嘅位置。",
        time_remaining = "剩餘時間:",
        order_summary = "訂單摘要:",
        accept = "接受",
        decline = "拒絕",
        cancel_delivery = "取消外賣",

        -- Notifications
        delivery_accepted_notification = "外賣已成功接受",
        delivery_cancelled_notification = "外賣已成功取消",

        -- Status Messages
        complete_delivery = "完成外賣",
        delivery_in_progress = "外賣進行中...",
        head_to_location = "前往標記位置完成送貨",
    },

    Consumption = {
        title = "食用",
        description = "新鮮好味!",
        refresh_title = "提神",
        refresh_description = "你覺得精神咗",
    },

    Crafting = {
        craft_title = "製作 %s",
        enter_amount_description = "輸入製作數量",
        crafting_successful = "製作成功",
        crafted_description = "製作咗 %d x %s",
        crafting_cancelled = "製作取消",
        cancelled_description = "你取消咗製作",
        no_space = "背包冇位",
    },

    Targets = {
        door = "敲門",
        door_icon = "fas fa-door-open",
        delivery_food = "送食物",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "點餐平板",
        ordering_tablet_error = "點餐平板功能暫停使用。",
        order_management_tablet = "訂單管理平板",
        order_management_error = "訂單管理平板功能暫停使用。",
        return_utensils = "歸還餐具",
        employee_vending = "員工販賣機",
    },

    Order = {
        complete = "訂單完成",
        description = "你嘅訂單已處理。帳單已加到你嘅背包。",
        paycheck_suspended_description = "店舖休息期間暫停發薪。",
        paycheck_suspended = "薪金暫停",
    },

    Door = {
        title = "門 ",
        description = "門 ",
        locked = "門鎖咗",
        no_permissions = "冇權限鎖/解鎖呢道門",
        access_denied_title = "拒絕存取",
        access_granted = "你解鎖咗道門",
        access_denied = "你冇權限使用呢道門",
    },

    Outfits = {
        title = "服裝",
        invalid = "無效性別",
        failed_equip = "更換服裝失敗",
        disabled = "服裝功能已停用",
        civilian_clothes = "換便服",
        reset_civilian_clothes = "已換回便服",
        no_civilian_saved = "冇儲存便服。請先換成制服。",
        no_permission = "你冇權限使用呢套服裝",
        outfit_not_found = "搵唔到服裝",
        equip_success = "成功更換服裝",
        changed_to_uniform = "已更換為 %s",
        reset_success = "成功重置服裝",
        no_civilian_for_reset = "冇儲存便服。請先換成制服並儲存服裝。",
    },

    System = {
        success = "成功",
        paycheck_error = "薪金錯誤",
        inventory_full = "背包已滿",
        inventory_full_description = "你嘅背包滿咗。",
        society_not_found = "搵唔到公司",
        business_funds_insufficient = "公司唔夠錢出糧。",
        error = "錯誤",
        invalid = "無效",
        no_license = "無法識別你嘅執照。請聯絡管理員。",
        missing_items = "缺少物品",
        item_cleaned = "物品已成功清潔",
        missing_required = "缺少所需物品",
        slot_error = "請將數量放喺同一個格",
        ice_collected = "已收集冰塊",
        refreshing = "提神中",
        refreshed = "已提神",
        consumption = "食用",
        stress_increased = "壓力增加",
        stress_amount = "你嘅壓力值增加咗 %s",
        inventory_full = "你嘅背包滿咗",
    },

    Experience = {
        gained_title = "獲得經驗",
        experience_earned_description = "你獲得 %d XP。",
        gained_message = "完成外賣獲得 %d XP!",
    },

    BossMenu = {
        title = "老闆選單",
        unable_jobdetermine = "無法確定你嘅職業。請稍後再試。",
        bankruptcy_alert = "⚠️ 破產警告",
        description = "唔夠錢出糧! 公司餘額: $%s, 需要: $%s",
        trans_failed_bossmenubalance = "交易失敗 - 公司資金不足",
        menu_in_use = "老闆選單目前由 %s 使用中。",
        no_permissions = "你冇老闆權限! 你需要係老闆。",
        wrong_job = "你冇正確嘅職業",
        grade_updated = "職位等級已更新",
        grade_update_success = "%s 等級更新成功。",
        menu_update = "餐單更新",
        menu_update_success = "餐單項目更新成功!",
        vending_update = "販賣機",
        vending_update_success = "販賣機物品更新成功!",
        menu_update_error = "更新餐單項目失敗!",
        menu_delete = "刪除餐單",
        menu_delete_success = "餐單項目刪除成功!",
        menu_delete_error = "刪除餐單項目失敗!",
        invite_sent = "邀請已發送",
        invite_sent_success = "工作邀請已發送俾 %s",
        invite_error = "無效嘅玩家 ID 或角色!",
        player_not_found = "搵唔到玩家!",
        job_error = "無效嘅邀請資料!",
        job_accepted = "你而家係 %s 嘅 %s",
        job_updated_title = "職業已更新",
        job_updated = "你嘅職位已更新為 %s (%s)",
        database_error = "你嘅職業已設定但資料庫更新失敗。",
        invite_rejected = "你拒絕咗工作邀請。",
        withdraw_error = "無效金額!",
        business_error = "搵唔到公司!",
        insufficient_funds = "公司資金不足!",
        money_withdrawn = "你從公司戶口提取咗 $%s。",
        transaction_failed = "更新公司戶口失敗!",
        money_deposited = "你存入咗 $%s 到公司戶口。",
        transaction_failed_refund = "更新公司戶口失敗! 你嘅錢已退回。",
        shop_purchase = "新商店購買",
        shop_purchase_notification = "%s 購買咗物品，總值 $%s",
        menu_occupied = "老闆選單使用中",
        menu_occupied_by = "%s 正在使用老闆選單。請稍後再試。",
        menu_released = "老闆選單現在可用",

        -- Main Headers and Titles
        business_overview = "公司概覽",
        business_settings = "公司設定",
        menu_management = "餐單管理",
        staff_management = "員工管理",
        employee_leaderboard = "員工排行榜",
        sales_transactions = "銷售 & 交易",

        -- Finance Section
        finance = "財務",
        business_balance = "公司餘額",
        withdraw = "提款",
        deposit = "存款",
        withdraw_money = "提取現金",
        deposit_money = "存入現金",
        enter_amount_withdraw = "輸入你想從公司戶口提取到你 %s 嘅金額。",
        enter_amount_deposit = "輸入你想從你 %s 存入到公司戶口嘅金額。",
        available = "可用",
        enter_amount = "輸入金額",
        withdraw_to = "提取到 %s",
        deposit_from = "從 %s 存入",
        updating = "更新中...",
        update_avatar = "更新頭像",
        cancel = "取消",
        cash = "現金",
        bank = "銀行",
        invalid_url = "無效 URL",
        invalid_url_message = "請輸入有效嘅圖片 URL",
        avatar_updated = "頭像已更新",
        avatar_updated_message = "頭像更新成功!",
        update_failed = "更新失敗",
        update_failed_message = "更新頭像失敗",
        business_status = "營業狀態",
        business_status_desc = "控制你嘅公司營業狀態",
        business_operations = "商業運作",
        business_open = "目前營業中 - 已啟用開單",
        business_closed = "目前休息中 - 已停用開單",
        business_status_updated = "營業狀態",
        business_now_open = "公司而家營業中",
        business_now_closed = "公司而家休息中",
        business_status_error = "錯誤",
        business_status_failed = "更新營業狀態失敗",

        -- Employees Section
        employees = "員工",
        invite_new_employee = "邀請新員工",
        player_id = "玩家 ID...",
        invite = "邀請",
        select_role = "選擇職位",
        choose_role_for = "為 %s 選擇職位",
        available_roles = "可用職位:",
        roles_available = "%d 個職位可用",
        send_invite = "發送邀請",

        -- Sales Summary
        sales_summary = "銷售摘要",
        today = "今日",
        this_week = "本週",
        this_month = "本月",
        view_sales = "查看銷售",

        -- Inventory Status
        inventory_status = "庫存狀態",
        storage_capacity = "儲存容量",
        ingredients = "食材",
        supplies = "物資",
        manage_inventory = "管理庫存",

        -- Menu Management
        search_menu_items = "搜尋餐單項目...",
        edit_menu_item = "編輯餐單項目",
        update_item_details = "更新以下項目詳情。",
        label_display_name = "標籤 (顯示名稱)",
        price = "價格 ($)",
        category = "類別",
        select_category = "選擇類別",
        update = "更新",
        all_items = "全部項目",
        no_menu_items = "搵唔到餐單項目",
        no_category_items = "搵唔到 %s",

        -- Vending Machine Management
        vending_machine_management = "販賣機管理",
        search_vending_items = "搜尋販賣機物品...",
        edit_vending_item = "編輯販賣機物品",
        update_vending_details = "更新以下物品詳情。",
        all_vending_items = "全部項目",
        no_vending_items = "搵唔到販賣機物品",
        no_category_vending_items = "搵唔到 %s",
        vending_update_error = "更新販賣機物品失敗",
        item_price = "價格",
        item_type = "類型",
        uncategorized = "未分類",
        enter_price = "例子: 5",

        -- Staff Management
        employee_overview = "員工概覽",
        total_employees = "總員工",
        active_employees = "活躍員工",
        pending_applications = "待處理申請",
        employee_list = "員工名單",
        search_employees = "搜尋員工...",
        all_employees = "全部員工",
        name = "名稱",
        role = "職位",
        salary = "薪金",
        last_seen = "最後上線",
        actions = "操作",
        promote = "晉升",
        demote = "降職",
        fire = "解僱",
        employee_actions = "員工操作",
        select_action = "選擇 %s 嘅操作",
        promote_employee = "晉升員工",
        demote_employee = "降職員工",
        fire_employee = "解僱員工",
        confirm_action = "確認操作",
        confirm_promote = "你確定要將 %s 晉升為 %s?",
        confirm_demote = "你確定要將 %s 降職為 %s?",
        confirm_fire = "你確定要解僱 %s?",
        action_success = "操作成功完成",
        action_failed = "操作失敗",
        employee_promoted = "員工晉升成功",
        employee_demoted = "員工降職成功",
        employee_fired = "員工解僱成功",
        no_employees = "搵唔到員工",

            -- Job Grades Management Dialog
        manage_job_grades = "管理職位等級",
        configure_salary_commission = "設定每個職位嘅薪金同佣金率",
        search_job_grades = "搜尋職位等級...",
        edit_job_grade = "編輯職位等級",
        update_job_grade_details = "更新職位等級詳情",
        job_title = "職稱",
        commission_rate = "佣金率",
        boss_access = "老闆權限",
        boss_access_enabled = "此職位可使用管理功能",
        boss_access_disabled = "此職位只有員工級別權限",
        save_changes = "儲存變更",
        boss_role = "老闆職位",
        grade_update_error = "更新職位等級失敗",

        -- Employee Details View
        employee_overview = "員工詳情",
        employee_profile = "員工檔案",
        performance_stats = "表現數據",
        back = "返回",
        
        -- Employee Profile Card Labels
        commission = "佣金",
        total_earnings = "總收入",
        available_balance = "可用餘額",
        employee_id = "員工 ID",
        
        -- Performance Stats Labels
        deliveries_label = "外賣",
        billings_label = "開單",
        earnings_label = "收入",
        experience_label = "經驗",
        level_label = "等級",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "收入分佈",
        delivery_income = "外賣",
        commission_income = "佣金",
        paycheck_income = "薪金",
        completed_label = "已完成",
        bills_label = "單",
        hourly_label = "每小時",

        -- Employee Card Labels (for list view)
        rank_label = "職級",
        commission_label = "佣金",

        -- Role Change Dialog
        no_role_employees = "搵唔到 %s",
        employee_updated = "員工已更新",
        employee_commission_updated = "員工已更新，佣金率為 %s",
        fire_employee_error = "解僱員工失敗",

        -- Employee Leaderboard
        top_performers = "表現最佳",
        this_month_leaders = "本月領袖",
        rank = "排名",
        employee = "員工",
        performance = "表現",
        orders_completed = "完成訂單",
        revenue_generated = "產生收入",
        customer_rating = "顧客評分",
        no_data = "冇表現數據",

        -- Transactions
        transaction_history = "交易記錄",
        recent_transactions = "最近交易",
        paycheck_history = "薪金記錄",
        transaction_type = "交易類型",
        amount = "金額",
        date = "日期",
        message = "描述",
        customer = "顧客",
        filter_transactions = "篩選交易...",
        all_transactions = "全部交易",
        sales_only = "只限銷售",
        paychecks_only = "只限薪金",
        no_transactions = "搵唔到交易",
        no_paychecks = "搵唔到薪金記錄",


        -- Settings
        avatar_settings = "頭像設定",
        update_profile_picture = "更新你嘅個人頭像",
        image_url = "圖片 URL",
        enter_url_preview = "喺下面輸入 URL 預覽你嘅頭像",
        preview = "預覽",
        enter_url_message = "輸入你頭像圖片嘅 URL",
        ui_theme = "介面主題",
        customize_appearance = "自訂控制台外觀",
        light_mode = "淺色模式",
        dark_mode = "深色模式",

        -- Navigation
        home = "主頁",
        staff = "員工",
        menu = "餐單",
        sales = "銷售",
        top = "排行",
        settings = "設定",

        -- Status Labels
        open = "營業中",
        closed = "休息",
        online = "在線",
        offline = "離線",
        active = "活躍",
        inactive = "不活躍",

        -- Common Actions
        save = "儲存",
        edit = "編輯",
        delete = "刪除",
        confirm = "確認",
        close = "關閉",
        refresh = "重新整理",
        loading = "載入中...",

        -- Error Messages
        error_occurred = "發生錯誤",
        invalid_input = "無效輸入",
        operation_failed = "操作失敗",
        permission_denied = "權限不足",
        network_error = "網絡錯誤",
        data_load_failed = "載入數據失敗",

        -- Success Messages
        operation_successful = "操作成功完成",
        data_saved = "數據儲存成功",
        changes_applied = "變更已成功套用",
    },

    Shop = {
        shop_status = "商店狀態",
        shop_open = "商店營業中",
        shop_closed = "商店休息中",
        access_denied = "你唔可以進入呢間商店!",
        purchase_title = "商店",
        purchase_success = "購買完成! 物品已加到你嘅背包。",
        purchase_error = "結帳失敗!",

        -- Search and Inventory
        search_placeholder = "搜尋產品名稱...",
        clear_search = "清除搜尋",
        shop_inventory = "商店庫存",
        items_count = "件物品",

        -- Product Actions
        add_to_cart = "加入",
        per_item = "每件",

        -- Cart
        your_cart = "你嘅購物車",
        cart_empty = "購物車係空嘅",
        cart_empty_message = "加入物品開始購物",
        items_label = "件物品",
        total = "總計",

        -- Search Results
        no_items_found = "搵唔到物品",
        no_items_message = "試下調整搜尋或者瀏覽所有物品",

        -- Payment
        pay_with_cash = "現金",
        pay_with_bank = "銀行",
        processing = "處理中...",
        inventory_notice = "物品會直接加到你嘅背包",

        -- Notifications
        cart_updated = "購物車已更新",
        item_added = "物品已加入",
        item_removed = "物品已移除",
        quantity_updated = "數量已更新",
        purchase_complete = "購買完成",
        transaction_failed = "交易失敗",
        checkout_error = "結帳錯誤",
        cart_empty_error = "你嘅購物車係空嘅",
        paid_with_cash = "已用現金付款",
        charged_to_bank = "已從銀行戶口扣除",
        not_enough_cash = "現金不足",
        insufficient_bank = "銀行餘額不足",

        -- Quantity Messages
        added_more = "加入咗 %d 件 %s",
        removed_items = "移除咗 %d 件 %s",
        added_to_cart = "%s 已加入購物車",
        removed_from_cart = "已從購物車移除 %s",

        -- Loading
        loading_shop = "載入緊商店選單...",
    },

    EmployeeMenu = {
        access_denied = "你唔可以進入呢個入口!",
        commission_withdrawn = "佣金已提取",
        commission_withdrawn_description = "你已從佣金餘額提取 $%s 到你嘅 %s。",
        transaction_failed = "交易失敗",
        fire_employee = "解僱員工",
        fire_employee_description = "%s 已被解僱!",
        employeeMent_notice = "員工通知",
        
        no_employee_active = "目前冇活躍員工在線處理你嘅訂單。",
        -- Main Headers and Navigation
        employee_portal = "員工入口",
        employee_profile = "員工檔案",
        performance_stats = "表現統計",
        employee_leaderboard = "員工排行榜",
        job_outfits = "工作服",
        account_settings = "帳戶設定",

        -- Navigation Labels
        profile = "檔案",
        stats = "統計",
        top = "排行",
        outfits = "服裝",
        settings = "設定",

        -- Profile Tab
        personal_information = "個人資料",
        paycheck_information = "薪金資料",
        job_role = "工作職位",
        salary = "薪金",
        experience = "經驗",
        duty_status = "值班狀態",
        on_duty = "上班",
        off_duty = "下班",
        clock_in = "打卡上班",
        clock_out = "打卡下班",
        available_balance = "可用餘額",
        withdraw = "提款",
        withdraw_funds = "提取資金",
        paycheck_interval = "發薪週期",
        total_deliveries = "總送貨數",
        bills_created = "已開帳單",
        total_earnings = "總收入",
        minutes = "分鐘",

        -- Performance Tab
        career_statistics = "職業統計",
        experience_points = "經驗",
        xp_points = "XP 點數",
        total_earned = "總賺取",
        current_balance = "目前餘額",
        deliveries = "送貨",
        total_completed = "總完成",
        billings = "開單",
        invoices_created = "已建立發票",
        job_grade_progression = "職位晉升進度",
        current_grade = "目前等級",
        level = "等級",
        xp_needed_promotion = "晉升所需 XP",
        earn_more_xp = "再賺取 %d XP 就可以晉升為 %s",
        max_grade_reached = "你已達到最高自動晉升等級! 進一步晉升需要管理層批准。",
        promotions_by_management = "晉升由管理層指派。",
        loading_experience_data = "載入緊經驗系統數據...",
        loading_progression_data = "載入緊進度數據...",

        -- Leaderboard Tab
        top_performers = "最佳表現",
        this_month_leaders = "本月領袖",
        rank = "排名",
        employee = "員工",
        performance = "表現",
        no_leaderboard_data = "冇排行榜數據",

        -- Outfits Tab
        work_outfits = "工作服",
        select_outfit = "選擇服裝",
        change_outfit = "更換服裝",
        outfit_changed = "服裝已更換",
        outfit_changed_success = "你嘅服裝已成功更換!",
        outfit_change_failed = "更換服裝失敗",
        outfit_preview = "服裝預覽",

        -- Settings Tab
        employee_settings = "員工設定",
        avatar_settings = "頭像設定",
        update_profile_picture = "更新你嘅個人頭像",
        image_url = "圖片 URL",
        enter_url_preview = "喺下面輸入 URL 預覽你嘅頭像",
        preview = "預覽",
        enter_url_message = "輸入你頭像圖片嘅 URL",
        avatar_updated = "頭像已更新",
        avatar_created = "頭像已建立",
        avatar_updated_message = "頭像更新成功!",
        update_failed = "更新失敗",
        update_failed_message = "更新頭像失敗",
        invalid_url = "無效 URL",
        invalid_url_message = "請輸入有效嘅圖片 URL",
        updating = "更新中...",
        update_avatar = "更新頭像",

        -- UI Theme
        ui_theme = "介面主題",
        customize_appearance = "自訂控制台外觀",
        light_mode = "淺色模式",
        dark_mode = "深色模式",

        -- Notifications
        notifications = "通知",
        manage_notification_preferences = "管理通知偏好設定",
        employee_notifications = "員工通知",
        notifications_enabled_desc = "你會收到所有員工薪金更新",
        notifications_disabled_desc = "你唔會收到通知",
        notifications_updated = "通知已更新",
        notifications_enabled_message = "薪金通知已啟用",
        notifications_disabled_message = "薪金通知已停用",
        enabled = "已啟用",
        disabled = "已停用",

        -- Withdrawal Dialog
        withdraw_all_funds = "提取所有資金",
        select_balance_type = "選擇餘額類型",
        all_balance = "所有餘額",
        delivery_balance = "外賣餘額",
        commission_balance = "佣金餘額",
        paycheck_balance = "薪金餘額",
        available_balance_type = "可用 %s 餘額: $%d",
        enter_amount = "輸入金額",
        insufficient_funds = "資金不足",
        insufficient_balance = "%s 餘額不足",
        funds_withdrawn = "資金已提取",
        funds_withdrawn_success = "成功從你嘅餘額提取 $%d",
        transaction_failed = "交易失敗",
        withdrawal_failed = "提取資金失敗",
        invalid_amount = "無效金額",
        invalid_amount_message = "請輸入有效金額",
        no_funds = "冇資金",
        no_funds_message = "你冇資金可以提取",

        -- Common Actions
        cancel = "取消",
        save = "儲存",
        update = "更新",
        confirm = "確認",
        close = "關閉",
        loading = "載入中...",

        -- Status Labels
        active = "活躍",
        inactive = "不活躍",
        online = "在線",
        offline = "離線",

        -- Error Messages
        error_occurred = "發生錯誤",
        operation_failed = "操作失敗",
        data_load_failed = "載入數據失敗",
        network_error = "網絡錯誤",
        employee_data_error = "無法讀取你嘅員工數據。",
        identity_error = "無法驗證你嘅身分。",
        withdraw_invalid_amount = "無效金額!",
        insufficient_commission = "佣金餘額不足!",
        transaction_failed_update = "更新佣金餘額失敗!",
        fire_employee_not_found = "搵唔到員工!",
        fire_employee_wrong_business = "呢個員工唔係你公司嘅!",
        fire_employee_db_error = "從資料庫解僱員工失敗!",
        employment_notice_fired = "你已被 %s 解僱",
        avatar_invalid_url = "提供嘅圖片 URL 無效。",
        avatar_updated_success = "你嘅個人頭像已成功更新。",
        avatar_no_changes = "你嘅頭像冇變更。",
        avatar_created = "你嘅員工檔案同頭像已建立。",
        avatar_create_failed = "建立員工記錄失敗。",
        withdrawal_invalid_amount = "無效嘅提款金額。",
        employee_record_not_found_withdraw = "搵唔到員工記錄。",
        insufficient_balance_withdraw = "你嘅餘額不足。",
        withdraw_balance_failed = "從餘額提款失敗。請重試。",
        identity_error_toggle = "無法驗證你嘅身分",
        invalid_grade_data = "提供嘅等級數據無效。",
        grade_id_not_found = "搵唔到此職位嘅等級 ID。",
        no_grade_changes = "職位等級冇變更。",
        balance_withdrawn = "你從 %s 餘額提取咗 $%d 到你嘅 %s。",
        player_not_found = "搵唔到玩家!",
        invalid_purchase_data = "無效嘅購買數據!",
        insufficient_funds = "你嘅 %s 唔夠錢!",
        inventory_full = "背包空間不足或超重!",
        purchase_complete = "購買完成! 物品已加到你嘅背包。",
        shop_purchase = "商店購買: %s",
        business_balance_error = "更新 %s 嘅公司餘額時發生錯誤",
        business_balance_success = "成功將 $%s 加入公司戶口",
        transaction_record_error = "記錄商店購買交易時發生錯誤",
        avatar_found = "商店: 搵到 %s 嘅頭像: %s",
        avatar_not_found = "商店: 搵唔到 %s 嘅頭像，使用預設",
    },

    Vending = {
        invalid_item_data = "無效物品數據。",
        insufficient_item = "你冇足夠嘅物品。",
        item_added_with_money = "物品已加到庫存。%sx %s 收到 $%s",
        item_added = "物品已加到庫存。",
        business_balance_error = "更新訂單嘅公司餘額時發生錯誤",
        database_error = "資料庫錯誤",
        add_item_failed = "加入物品失敗。",
        invalid_collection_data = "無效收集數據。",
        inventory_full = "無法將物品加到你嘅背包。",
        item_collected = "收集咗 %sx %s",
        stock_update_failed = "更新販賣機庫存失敗。",
        out_of_stock = "缺貨",
        insufficient_stock = "冇足夠物品可以收集。",
        sale_transaction_error = "記錄販賣機銷售交易時發生錯誤",
        collection_transaction_error = "記錄販賣機收集交易時發生錯誤",
    },

    JobSystem = {
        no_permission = "你冇權限使用此指令。",
        player_not_found = "搵唔到玩家。",
        job_assigned = "工作已指派。",
        job_assign_failed = "指派工作失敗。",
        job_removed = "工作已移除。",
        job_remove_failed = "移除工作失敗。",
        job_changed_notification = "工作已變更",
        job_changed = "你嘅工作已變更為 %s (等級 %s)。",
        job_removed_notification = "你嘅工作已移除。",
        give_job_usage = "用法: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "用法: /%s [playerId]",
        job_info = "工作: %s (等級: %s, 值班: %s)",
        job_info_error = "無法取得你嘅工作資訊。",
        duty_status = "你而家 %s 值班。",
        not_on_duty = "非值班",
        must_be_on_duty = "你要上班先可以收到薪金。",
        paycheck_title = "薪金",
        employer_insufficient_funds = "你老闆唔夠錢出糧俾你。",
        paycheck_added = "%s 工作: %s 嘅員工餘額已加入薪金 $%s",
        paycheck_received = "你收到 %s 嘅薪金 $%s",
    },

    BillingInviteNotification = {
        message = "你收到一個付款請求。",

        -- Titles / headers
        title = "付款請求",
        label = "帳單通知",

        -- Button labels
        pay_button = "支付帳單",
        decline_button = "拒絕",

        -- Small UI labels used inside the notification component
        business_label = "公司",
        total_amount_label = "總金額",
        reason_label = "原因",
        amount_label = "金額:",

        -- Warning / helper texts
        warning_text = "付款將從你嘅戶口扣除。請確保餘額充足。",
        expires_text = "%s 後過期", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "你被邀請加入 Burgershot 擔任 %s。接受嗎?",

        -- Titles / headers
        title = "工作邀請",
        label = "工作邀請通知",

        -- Button labels
        accept_button = "接受",
        reject_button = "拒絕",

        -- Small UI labels used inside the notification component
        company_label = "公司",
        grade_label = "等級",
        invites_left_label = "剩餘邀請",
        salary_label = "薪金",

        -- Warning / helper texts
        warning_text = "接受此工作代表你承諾擔任此職位。請確保你已準備好開始。",
        expires_text = "%s 後過期", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "餐廳餐單",
        onduty = "你要上班先可以打開餐廳餐單。",
    },

    Duty = {
        status = "值班狀態",
        management = "值班管理",
        description = "你而家 %s 值班。",
        restaurant_area = "餐廳區域",
        clock_in = "你已進入餐廳區域。使用員工選單打卡上班。",
        enter_workplace = "你已進入工作場所，而家係上班狀態。",
        leave_workplace = "你已離開工作場所，而家係下班狀態。",
        inside_workplace = "你喺工作場所內 - 自動設定為上班。",
        outside_workplace = "你喺工作場所外 - 自動設定為下班。",
        duty_warning = "值班警告",
        auto_off_duty = "當你離開餐廳時，會自動設定為下班。",
        no_permission_manage_duty = "你冇權限管理員工值班狀態",
        not_employee_of_job = "玩家唔係此工作嘅員工",
        duty_set_by_management = "你嘅值班狀態已被管理層設定為 %s",
        duty_management_success = "成功將 %s 嘅值班狀態設定為 %s",
        updated_offline_employee = "已更新離線員工嘅值班狀態",
    },

    Paycheck = {
        title = "收到薪金",
        message = "你收到 %s 嘅薪金 $%s",
    },

    VendingMachine = {
        sell_item = "出售物品",
        select_item_from_inventory = "從背包選擇物品",
        add_to_vending = "加入 %s 到販賣機",
        cancel = "取消",
        no_matching_items = "背包冇相符物品",
        stocked_items = "庫存物品",
        sell = "出售",
        no_stock = "冇貨",
        items = "庫存物品",
        ready_to_serve = "準備服務!",
    },

    EmployeeVendingMachine = {
        title = "從販賣機提取",
        label = "從販賣機庫存提取物品",
        collect = "提取",
        cancel = "取消",
        quantity_available = "數量 (可用: %s)",
        collect_item = "提取 %s",
        collect_button = "提取",
        in_stock = "庫存中",
        vending_machine_empty = "呢部販賣機係空嘅。",
    },

    OrderingTab = {
        where_eating_today = "今日想喺邊度食?",
        eat_in = "堂食",
        take_out = "外賣",
        whats_up = "點呀?",
        popular = "熱門",
        done = "完成",
        my_order = "我嘅訂單",
        empty = "空",
        total = "總計",
        checkout = "結帳",
        back = "返回",
        no_menu_items = "%s 冇可用餐單項目",
        loading = "載入中...",
        eat_in_label = "堂食",
        take_out_label = "外賣",
        pay_cash = "現金",
        cancel = "取消",
        order = "落單",
        pay_bank = "銀行",
        all_items = "全部物品",
        bank_only_disclaimer = "只接受銀行付款。",
    },

    OrderManagementTable = {
        title = "訂單管理面板",
        label = "訂單管理",
        filter_all = "全部",
        filter_cooking = "烹飪中",
        filter_ready = "準備好",
        filter_completed = "已完成",
        filter_terminal_orders = "終端機訂單",
        filter_self_pickup = "自助下單機訂單",
        sort_by = "排序方式",
        sort_day = "日期",
        sort_amount = "金額",
        sort_name = "名稱",
        no_orders = "冇訂單符合目前篩選。",
        accept = "接受",
        accepting = "接受中...",
        cooking = "烹飪中",
        ready = "準備好",
        complete = "完成",
        completed = "已完成",
        assigned_to = "指派俾: ",
        items_label = "物品:",
        order_label = "訂單 #",
        status_cooking = "烹飪中",
        status_ready = "準備好",
        status_completed = "已完成",
        status_cancelled = "已取消",
        self_pickup = "自取",
    },

    MenuSelectionDialog = {
        title = "選擇行動",
        subtitle = "你想做咩？",
        options = {
            shop = {
                title = "開店",
                description = "從自動售賣機瀏覽同購買物品"
            },
            manageBoss = {
                title = "管理店舖",
                description = "管理庫存、查看分析同控制自動售賣機"
            },
            manageEmployee = {
                title = "管理店舖",
                description = "喺自動售賣機加入同管理庫存物品"
            }
        }
    },
}