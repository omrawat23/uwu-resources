-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["ja"] = {
    
    WashHands = {
        title = "シンク",
        no_available = "利用可能なシンクがありません",
        success = "あなたの両手は今清潔です！",
        error = "エラー",
        fail = "あなたの両手はすでに清潔です！",
        targetfail = "まず手を洗う必要があります！",
        item_cleaned = "アイテムが正常に清掃されました！",
        missing_required = "必要なアイテムがありません"
    },

    Terminal = {
        SubmitText = "請求書を送信",

        -- Player Selection Tab
        select_player = "プレイヤーを選択",
        nearby_players = "近くのプレイヤー",
        search_players = "プレイヤーを検索...",
        no_players_found = "近くにプレイヤーが見つかりません",
        loading_players = "プレイヤーを読み込み中...",
        player_selected = "プレイヤーが選択されました",

        -- Menu Items Tab
        menu_items = "メニューアイテム",
        items_added = "アイテムが追加されました",
        search_menu_items = "メニューアイテムを検索...",
        available_items = "利用可能なアイテム",
        selected_items = "選択されたアイテム",
        no_items_found = "アイテムが見つかりません",
        no_items_selected = "アイテムが選択されていません",
        total_items = "合計アイテム",
        total = "合計",
        all = "すべて",

        -- Finalize Bill Tab
        finalize_bill = "請求書を確定",
        customer_info = "顧客情報",
        order_summary = "注文概要",
        amount_label = "金額 ($)",
        enter_amount = "金額を入力",
        reason_label = "理由 (オプション)",
        reason_placeholder = "請求書の理由を入力",
        payment_method = "支払い方法",
        cash = "現金",
        bank = "銀行",
        send_bill = "請求書を送信",

        -- Commission
        your_commission = "あなたのコミッション",
        commission_rate = "コミッションレート",

        -- Bills sent counter
        bills_sent = "送信された請求書:",
        commission = "コミッション:",

        -- Error Messages
        bill_error = "請求書エラー",
        select_player_error = "プレイヤーを選択してください",
        invalid_amount_error = "有効な金額を入力してください",

        -- Success Messages
        bill_sent_success = "請求書が正常に送信されました！",
        bill_sent_title = "請求書送信",
    },

    Consumable = {
        Drinking = "飲む ", -- Drinking ItemName
        Eating = "食べる " -- Eating ItemName
    },

    Garage = {
        title = "ガレージ",
        no_vehicle = "返却する車両がありません",
        not_job_vehicle = "これはBurgershotの車両ではありません！",
        parked_title = "車両が駐車されました！",
        parked_message = "あなたの車両がこの場所に駐車されました！",
        in_vehicle = "車両内にいることはできません！",
        too_far = "車両から離れすぎています！",
        spawn_error = "今はそれができません！",

        -- UI Text
        garage_title = "ガレージ",
        garage_active_vehicles = "アクティブ",
        garage_manage = "アクティブ車両を管理",
        close = "閉じる",
        search_vehicles = "車両を検索...",
        no_vehicles_found = "車両が見つかりません",
        dont_have_vehicle = "このガレージに保管されている車両がありません。",
        select_vehicle = "車両を選択",
        select_vehicle_message = "リストから車両を選択して詳細を表示し、スポーンします。",
        back = "戻る",
        spawn_vehicle = "車両をスポーン",
        return_button = "返却",
        return_vehicle = "車両を返却",
        license_plate = "ナンバープレート",

        -- Status Messages
        vehicle_spawned = "車両が正常にスポーンされました",
        no_vehicle_to_return = "返却する車両がありません",
        access_denied = "このガレージにアクセスできません。",
        all_spawn_points_blocked = "すべてのスポーンポイントが現在ブロックされています。少しお待ちください。",
        vehicle_model_not_exist = "車両モデルが存在しません",
        failed_load_model = "車両モデルの読み込みに失敗しました",
        failed_create_vehicle = "車両の作成に失敗しました",
        invalid_vehicle_data = "無効な車両モデルデータ",

        -- Error Messages
        error = "エラー",
        garage_error = "ガレージエラー",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "車両エンティティの作成に失敗しました",
        no_spawn_points_available = "利用可能なスポーンポイントがありません",
        vehicle_returned_parked = "車両が返却され、駐車されました。",
        vehicle_processed_remote = "車両が処理されました (リモート返却)。",
    },

    Billing = {
        title = "請求",
        payment_failed_byreceiver = "支払い失敗: %s が %s に十分な資金を持っていません。",
        business_closed = "請求は現在管理によって無効化されています。",
        commission_earned = "コミッション獲得",
        commission_earned_description = "コミッション $%s を獲得しました。",
        terminal_title = "請求ターミナル",
        off_duty_error = "請求ターミナルを使用するには勤務中である必要があります。",
        access_denied = "請求ターミナルにアクセスできません。",
        payment_received = "支払い受領",
        payment_received_message = "%s から $%s の支払いを受領しました",
        payment_failed = "支払い失敗",
        payment_failed_message = "請求書の支払いが失敗しました",
        bill_sent = "請求書送信",
        bill_sent_success = "請求書が正常に送信されました！",
        bill_sent_error = "請求書の送信に失敗しました。",
        bill_error = "請求書エラー",
        invalid_bill = "無効な請求書！",
        invalid_bill_description = "支払おうとしている請求書が存在しません。",
        invalid_target_amount = "無効なターゲットまたは金額！",
        player_not_found = "プレイヤーが見つかりません！",
        must_be_on_duty = "請求書を送信するには勤務中である必要があります！",
        bill_sent_description = "%s に $%s の請求書を %s に送信しました",
        bill_payment_successful = "✅ 請求書の支払いが成功しました",
        bill_payment_failed_insufficient = "❌ 請求書の支払いが失敗しました - 資金不足",
        bill_rejected = "❌ 請求書が拒否されました",
        insufficient_funds = "%s が十分ではありません！",
        order_processed = "🍔 注文が処理されました",
        command_access_denied = "このコマンドを使用できません！",
        payment_failed_insufficient = "%s が十分ではありません！",
        bill_rejected_title = "請求書拒否",

        bill_rejected_sender = "%s があなたの $%s の請求書を拒否しました",
        bill_rejected_receiver = "%s の請求書を拒否しました",
        billing_disabled = "請求は現在管理によって無効化されています。",
        billing_off_duty = "請求を使用するには勤務中である必要があります。",
    },

    Delivery = {
        items_header = "配送アイテム",
        reward_header = "報酬",
        accept_header = "配送を受け入れる",
        decline_header = "配送を拒否",
        menu_header = "配送メニュー",
        no_delivery = "アクティブな配送がありません！",
        new_delivery_title = "新しい配送",
        new_delivery_desc = "新しい配送リクエストを受信しました。",
        delivery_expired = "あなたの配送リクエストが期限切れになりました。",
        delivery_timeout = "配送を完了する時間がありませんでした。",
        delivery_declined = "配送リクエストを拒否しました。",
        check_location = "GPSで配送場所を確認してください。",
        check_location_error = "追跡するアクティブな配送がありません。",
        delivery_accepted = "配送受け入れ",
        invalid_item = "配送の無効なアイテム",
        delivery_failed = "配送失敗",
        invalid_items_data = "無効なアイテムデータ",

        -- UI Text
        delivery_title = "配送",
        close_menu = "メニューを閉じる",
        new_order = "新しい注文",
        in_progress = "進行中",
        order_items = "注文アイテム:",
        payment = "支払い",
        delivery_status = "配送ステータス",
        deliver_instruction = "マップ上のマークされた場所に食べ物を届けてください。",
        time_remaining = "残り時間:",
        order_summary = "注文概要:",
        accept = "受け入れる",
        decline = "拒否",
        cancel_delivery = "配送をキャンセル",

        -- Notifications
        delivery_accepted_notification = "配送が正常に受け入れられました",
        delivery_cancelled_notification = "配送が正常にキャンセルされました",

        -- Status Messages
        complete_delivery = "配送を完了",
        delivery_in_progress = "配送進行中...",
        head_to_location = "マークされた場所に向かって配送を完了してください",
    },

    Consumption = {
        title = "消費",
        description = "新鮮でおいしい！",
        refresh_title = "リフレッシュ",
        refresh_description = "リフレッシュされました",
    },

    Crafting = {
        craft_title = "%s をクラフト",
        enter_amount_description = "クラフトする量を入力",
        crafting_successful = "クラフト成功",
        crafted_description = "%d x %s をクラフトしました",
        crafting_cancelled = "クラフトキャンセル",
        cancelled_description = "クラフトをキャンセルしました",
        no_space = "インベントリにスペースがありません",
    },

    Targets = {
        door = "ドアをノック",
        door_icon = "fas fa-door-open",
        delivery_food = "食べ物を届ける",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "注文タブレット",
        ordering_tablet_error = "注文タブレット機能が利用できません。",
        order_management_tablet = "注文管理タブレット",
        order_management_error = "注文管理タブレット機能が利用できません。",
        return_utensils = "器具を返す",
        employee_vending = "従業員ベンディング",
    },

    Order = {
        complete = "注文完了",
        description = "あなたの注文が処理されました。請求書がインベントリに追加されました。",
        paycheck_suspended_description = "ビジネスが閉鎖されている間、給与は停止されます。",
        paycheck_suspended = "給与停止",
    },

    Door = {
        title = "ドア ",
        description = "ドアが ",
        locked = "ドアはロックされています",
        no_permissions = "このドアのロック/ロック解除の権限がありません",
        access_denied_title = "アクセス拒否",
        access_granted = "ドアのロックを解除しました",
        access_denied = "このドアにアクセスできません",
    },

    Outfits = {
        title = "衣装",
        invalid = "無効な性別",
        failed_equip = "衣装の装備に失敗しました",
        disabled = "衣装は無効化されています",
        civilian_clothes = "市民服に変更",
        reset_civilian_clothes = "市民服に戻りました",
        no_civilian_saved = "保存された市民衣装がありません。まずユニフォームに変更してください。",
        no_permission = "この衣装を使用する権限がありません",
        outfit_not_found = "衣装が見つかりません",
        equip_success = "衣装が正常に装備されました",
        changed_to_uniform = "%s に変更しました",
        reset_success = "衣装が正常にリセットされました",
        no_civilian_for_reset = "保存された市民衣装がありません。まずユニフォームに変更して服を保存してください。",
    },

    System = {
        success = "成功",
        paycheck_error = "給与エラー",
        inventory_full = "インベントリ満杯",
        inventory_full_description = "あなたのインベントリは満杯です。",
        society_not_found = "ビジネスが見つかりません",
        business_funds_insufficient = "ビジネスに給与を支払うための資金が不足しています。",
        error = "エラー",
        invalid = "無効",
        no_license = "あなたのライセンスを特定できませんでした。管理者にお問い合わせください。",
        missing_items = "不足アイテム",
        item_cleaned = "アイテムが正常に清掃されました",
        missing_required = "必要なアイテムがありません",
        slot_error = "同じスロットに量を置いてください",
        ice_collected = "氷が収集されました",
        refreshing = "リフレッシュ中",
        refreshed = "リフレッシュされました",
        consumption = "消費",
        stress_increased = "ストレス増加",
        stress_amount = "あなたのストレスレベルが %s 増加しました",
    },

    Experience = {
        gained_title = "経験値獲得",
        experience_earned_description = "%d XP を獲得しました。",
        gained_message = "配送を完了して %d XP を獲得しました！",
    },

    BossMenu = {
        title = "ボスメニュー",
        unable_jobdetermine = "職種を特定できません。後でもう一度試してください。",
        bankruptcy_alert = "⚠️ 破産警告",
        description = "給与を支払えません！ 事業残高: $%s, 必要額: $%s",
        trans_failed_bossmenubalance = "取引失敗 - 事業資金不足",
        menu_in_use = "ボスメニューは現在 %s が使用中です。",
        no_permissions = "ボスの権限がありません！ ボスである必要があります。",
        wrong_job = "職種が正しくありません",
        grade_updated = "職務等級更新",
        grade_update_success = "%s 等級が正常に更新されました。",
        menu_update = "メニュー更新",
        menu_update_success = "メニュー項目が正常に更新されました！",
        vending_update = "自動販売機",
        vending_update_success = "自動販売機のアイテムが正常に更新されました！",
        menu_update_error = "メニュー項目の更新に失敗しました！",
        menu_delete = "メニュー削除",
        menu_delete_success = "メニュー項目が正常に削除されました！",
        menu_delete_error = "メニュー項目の削除に失敗しました！",
        invite_sent = "招待送信",
        invite_sent_success = "%s に採用招待を送信しました",
        invite_error = "無効なプレイヤーIDまたは役割です！",
        player_not_found = "プレイヤーが見つかりません！",
        job_error = "無効な招待データです！",
        job_accepted = "あなたは今 %s の %s です",
        job_updated_title = "職務更新",
        job_updated = "あなたの役職は %s の %s に更新されました",
        database_error = "職務は設定されましたが、データベースの更新に失敗しました。",
        invite_rejected = "採用招待を拒否しました。",
        withdraw_error = "無効な金額です！",
        business_error = "ビジネスが見つかりません！",
        insufficient_funds = "事業資金が不足しています！",
        money_withdrawn = "事業口座から $%s を引き出しました。",
        transaction_failed = "事業口座の更新に失敗しました！",
        money_deposited = "事業口座に $%s を預け入れました。",
        transaction_failed_refund = "事業口座の更新に失敗しました！お金は返金されました。",
        shop_purchase = "新しいショップ購入",
        shop_purchase_notification = "%s が $%s 分のアイテムを購入しました",
        menu_occupied = "ボスメニューは現在使用中です",
        menu_occupied_by = "%s が現在ボスメニューを使用しています。後でもう一度試してください。",
        menu_released = "ボスメニューが利用可能になりました",

        -- Main Headers and Titles
        business_overview = "ビジネス概要",
        business_settings = "ビジネス設定",
        menu_management = "メニュー管理",
        staff_management = "スタッフ管理",
        employee_leaderboard = "従業員ランキング",
        sales_transactions = "売上 & 取引",

        -- Finance Section
        finance = "財務",
        business_balance = "事業残高",
        withdraw = "引き出し",
        deposit = "預け入れ",
        withdraw_money = "お金を引き出す",
        deposit_money = "お金を預ける",
        enter_amount_withdraw = "事業口座からあなたの %s へ引き出したい金額を入力してください。",
        enter_amount_deposit = "あなたの %s から事業口座へ預け入れたい金額を入力してください。",
        available = "利用可能",
        enter_amount = "金額を入力",
        withdraw_to = "%s へ引き出し",
        deposit_from = "%s から預け入れ",
        updating = "更新中...",
        update_avatar = "アバターを更新",
        cancel = "キャンセル",
        cash = "現金",
        bank = "銀行",
        invalid_url = "無効なURL",
        invalid_url_message = "有効な画像URLを入力してください",
        avatar_updated = "アバター更新",
        avatar_updated_message = "アバターが正常に更新されました！",
        update_failed = "更新失敗",
        update_failed_message = "アバターの更新に失敗しました",
        business_status = "ビジネスステータス",
        business_status_desc = "ビジネスの営業状況を管理します",
        business_operations = "事業運営",
        business_open = "現在顧客を受け付けています - 請求は有効です",
        business_closed = "現在閉店中です - 請求は無効です",
        business_status_updated = "ビジネスステータス",
        business_now_open = "ビジネスは現在開店しています",
        business_now_closed = "ビジネスは現在閉店しています",
        business_status_error = "エラー",
        business_status_failed = "ビジネスステータスの更新に失敗しました",

        -- Employees Section
        employees = "従業員",
        invite_new_employee = "新しい従業員を招待",
        player_id = "プレイヤーID...",
        invite = "招待",
        select_role = "役割を選択",
        choose_role_for = "%s の役割を選択してください",
        available_roles = "利用可能な役割:",
        roles_available = "%d の役割が利用可能",
        send_invite = "招待を送信",

        -- Sales Summary
        sales_summary = "売上概要",
        today = "今日",
        this_week = "今週",
        this_month = "今月",
        view_sales = "売上を表示",

        -- Inventory Status
        inventory_status = "在庫状況",
        storage_capacity = "保管容量",
        ingredients = "材料",
        supplies = "備品",
        manage_inventory = "在庫管理",

        -- Menu Management
        search_menu_items = "メニューアイテムを検索...",
        edit_menu_item = "メニューアイテムを編集",
        update_item_details = "以下のアイテム詳細を更新してください。",
        label_display_name = "ラベル (表示名)",
        price = "価格 ($)",
        category = "カテゴリー",
        select_category = "カテゴリーを選択",
        update = "更新",
        all_items = "全アイテム",
        no_menu_items = "メニューアイテムが見つかりません",
        no_category_items = "%s が見つかりません",

        -- Vending Machine Management
        vending_machine_management = "自動販売機管理",
        search_vending_items = "自販機アイテムを検索...",
        edit_vending_item = "自販機アイテムを編集",
        update_vending_details = "以下のアイテム詳細を更新してください。",
        all_vending_items = "全アイテム",
        no_vending_items = "自販機アイテムが見つかりません",
        no_category_vending_items = "%s が見つかりません",
        vending_update_error = "自販機アイテムの更新に失敗しました",
        item_price = "価格",
        item_type = "タイプ",
        uncategorized = "未分類",
        enter_price = "例: 5",

        -- Staff Management
        employee_overview = "従業員概要",
        total_employees = "総従業員数",
        active_employees = "アクティブな従業員",
        pending_applications = "保留中の申請",
        employee_list = "従業員リスト",
        search_employees = "従業員を検索...",
        all_employees = "全従業員",
        name = "名前",
        role = "役割",
        salary = "給与",
        last_seen = "最終ログイン",
        actions = "アクション",
        promote = "昇進",
        demote = "降格",
        fire = "解雇",
        employee_actions = "従業員アクション",
        select_action = "%s のアクションを選択",
        promote_employee = "従業員を昇進",
        demote_employee = "従業員を降格",
        fire_employee = "従業員を解雇",
        confirm_action = "アクションを確認",
        confirm_promote = "本当に %s を %s に昇進させますか？",
        confirm_demote = "本当に %s を %s に降格させますか？",
        confirm_fire = "本当に %s を解雇しますか？",
        action_success = "アクションが正常に完了しました",
        action_failed = "アクションに失敗しました",
        employee_promoted = "従業員が正常に昇進しました",
        employee_demoted = "従業員が正常に降格しました",
        employee_fired = "従業員が正常に解雇されました",
        no_employees = "従業員が見つかりません",

            -- Job Grades Management Dialog
        manage_job_grades = "職務等級管理",
        configure_salary_commission = "各役職の給与とコミッション率を設定",
        search_job_grades = "職務等級を検索...",
        edit_job_grade = "職務等級を編集",
        update_job_grade_details = "職務等級詳細を更新",
        job_title = "職種名",
        commission_rate = "コミッション率",
        boss_access = "ボス権限",
        boss_access_enabled = "この役割は管理機能にアクセスできます",
        boss_access_disabled = "この役割は従業員レベルのアクセス権です",
        save_changes = "変更を保存",
        boss_role = "ボス役割",
        grade_update_error = "職務等級の更新に失敗しました",

        -- Employee Details View
        employee_profile = "従業員プロフィール",
        performance_stats = "パフォーマンス指標",
        back = "戻る",
        
        -- Employee Profile Card Labels
        commission = "コミッション",
        total_earnings = "総収入",
        available_balance = "利用可能残高",
        employee_id = "従業員ID",
        
        -- Performance Stats Labels
        deliveries_label = "配送",
        billings_label = "請求",
        earnings_label = "収入",
        experience_label = "経験値",
        level_label = "レベル",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "収入分布",
        delivery_income = "配送",
        commission_income = "コミッション",
        paycheck_income = "給与",
        completed_label = "完了",
        bills_label = "請求書",
        hourly_label = "時給",

        -- Employee Card Labels (for list view)
        rank_label = "ランク",
        commission_label = "コミッション",

        -- Role Change Dialog
        no_role_employees = "%s が見つかりません",
        employee_updated = "従業員更新",
        employee_commission_updated = "従業員のコミッション率が %s に更新されました",
        fire_employee_error = "従業員の解雇に失敗しました",

        -- Employee Leaderboard
        top_performers = "トップパフォーマー",
        this_month_leaders = "今月のリーダー",
        rank = "ランク",
        employee = "従業員",
        performance = "パフォーマンス",
        orders_completed = "完了注文数",
        revenue_generated = "生成収益",
        customer_rating = "顧客評価",
        no_data = "パフォーマンスデータがありません",

        -- Transactions
        transaction_history = "取引履歴",
        recent_transactions = "最近の取引",
        paycheck_history = "給与履歴",
        transaction_type = "取引タイプ",
        amount = "金額",
        date = "日付",
        message = "説明",
        customer = "顧客",
        filter_transactions = "取引をフィルタリング...",
        all_transactions = "全取引",
        sales_only = "売上のみ",
        paychecks_only = "給与のみ",
        no_transactions = "取引が見つかりません",
        no_paychecks = "給与記録が見つかりません",


        -- Settings
        avatar_settings = "アバター設定",
        update_profile_picture = "プロフィール写真を更新",
        image_url = "画像URL",
        enter_url_preview = "以下にURLを入力してアバターをプレビュー",
        preview = "プレビュー",
        enter_url_message = "アバター画像のURLを入力してください",
        ui_theme = "UIテーマ",
        customize_appearance = "ダッシュボードの外観をカスタマイズ",
        light_mode = "ライトモード",
        dark_mode = "ダークモード",

        -- Navigation
        home = "ホーム",
        staff = "スタッフ",
        menu = "メニュー",
        sales = "売上",
        top = "トップ",
        settings = "設定",

        -- Status Labels
        open = "開店",
        closed = "閉店",
        online = "オンライン",
        offline = "オフライン",
        active = "アクティブ",
        inactive = "非アクティブ",

        -- Common Actions
        save = "保存",
        edit = "編集",
        delete = "削除",
        confirm = "確認",
        close = "閉じる",
        refresh = "更新",
        loading = "読み込み中...",

        -- Error Messages
        error_occurred = "エラーが発生しました",
        invalid_input = "無効な入力",
        operation_failed = "操作に失敗しました",
        permission_denied = "権限がありません",
        network_error = "ネットワークエラー",
        data_load_failed = "データの読み込みに失敗しました",

        -- Success Messages
        operation_successful = "操作が正常に完了しました",
        data_saved = "データが正常に保存されました",
        changes_applied = "変更が正常に適用されました",
    },

    Shop = {
        shop_status = "店舗ステータス",
        shop_open = "店舗は開店しています",
        shop_closed = "店舗は閉店しています",
        access_denied = "このショップにはアクセスできません！",
        purchase_title = "ショップ",
        purchase_success = "購入完了！ アイテムがインベントリに追加されました。",
        purchase_error = "チェックアウト失敗！",

        -- Search and Inventory
        search_placeholder = "商品名で検索...",
        clear_search = "検索をクリア",
        shop_inventory = "ショップ在庫",
        items_count = "アイテム",

        -- Product Actions
        add_to_cart = "追加",
        per_item = "個/アイテム",

        -- Cart
        your_cart = "あなたのカート",
        cart_empty = "カートは空です",
        cart_empty_message = "アイテムを追加して買い物を始めましょう",
        items_label = "アイテム",
        total = "合計",

        -- Search Results
        no_items_found = "アイテムが見つかりません",
        no_items_message = "検索条件を調整するか、全商品をご覧ください",

        -- Payment
        pay_with_cash = "現金",
        pay_with_bank = "銀行",
        processing = "処理中...",
        inventory_notice = "アイテムは直接インベントリに追加されます",

        -- Notifications
        cart_updated = "カート更新",
        item_added = "アイテム追加",
        item_removed = "アイテム削除",
        quantity_updated = "数量更新",
        purchase_complete = "購入完了",
        transaction_failed = "取引失敗",
        checkout_error = "チェックアウトエラー",
        cart_empty_error = "カートが空です",
        paid_with_cash = "現金で支払い済み",
        charged_to_bank = "銀行口座に請求されました",
        not_enough_cash = "現金が足りません",
        insufficient_bank = "銀行残高不足",

        -- Quantity Messages
        added_more = "%d 個の %s を追加しました",
        removed_items = "%d 個の %s を削除しました",
        added_to_cart = "%s がカートに追加されました",
        removed_from_cart = "%s をカートから削除しました",

        -- Loading
        loading_shop = "ショップメニューを読み込み中...",
    },

    EmployeeMenu = {
        access_denied = "このポータルにはアクセスできません！",
        commission_withdrawn = "コミッション引き出し",
        commission_withdrawn_description = "コミッション残高から $%s をあなたの %s へ引き出しました。",
        transaction_failed = "取引失敗",
        fire_employee = "従業員を解雇",
        fire_employee_description = "%s があなたのビジネスから解雇されました！",
        employeeMent_notice = "従業員通知",
        
        no_employee_active = "あなたの注文を処理できるアクティブな従業員が現在オンラインではありません。",
        -- Main Headers and Navigation
        employee_portal = "従業員ポータル",
        employee_profile = "従業員プロフィール",
        performance_stats = "パフォーマンス統計",
        employee_leaderboard = "従業員ランキング",
        job_outfits = "仕事用衣装",
        account_settings = "アカウント設定",

        -- Navigation Labels
        profile = "プロフィール",
        stats = "統計",
        top = "トップ",
        outfits = "衣装",
        settings = "設定",

        -- Profile Tab
        personal_information = "個人情報",
        paycheck_information = "給与情報",
        job_role = "職務",
        salary = "給与",
        experience = "経験",
        duty_status = "勤務状況",
        on_duty = "勤務中",
        off_duty = "勤務外",
        clock_in = "出勤",
        clock_out = "退勤",
        available_balance = "利用可能残高",
        withdraw = "引き出し",
        withdraw_funds = "資金を引き出す",
        paycheck_interval = "給与間隔",
        total_deliveries = "総配送数",
        bills_created = "作成された請求書",
        total_earnings = "総収入",
        minutes = "分",

        -- Performance Tab
        career_statistics = "キャリア統計",
        experience_points = "経験値",
        xp_points = "XPポイント",
        total_earned = "総獲得額",
        current_balance = "現在残高",
        deliveries = "配送",
        total_completed = "総完了数",
        billings = "請求",
        invoices_created = "作成されたインボイス",
        job_grade_progression = "職務等級進捗",
        current_grade = "現在の等級",
        level = "レベル",
        xp_needed_promotion = "昇進に必要なXP",
        earn_more_xp = "%s に昇進するにはあと %d XP 必要です",
        max_grade_reached = "自動昇進の最高等級に到達しました！さらなる昇進には管理者の承認が必要です。",
        promotions_by_management = "昇進は管理者が決定します。",
        loading_experience_data = "経験値システムデータを読み込み中...",
        loading_progression_data = "進捗データを読み込み中...",

        -- Leaderboard Tab
        top_performers = "トップパフォーマー",
        this_month_leaders = "今月のリーダー",
        rank = "ランク",
        employee = "従業員",
        performance = "パフォーマンス",
        no_leaderboard_data = "ランキングデータがありません",

        -- Outfits Tab
        work_outfits = "仕事用衣装",
        select_outfit = "衣装を選択",
        change_outfit = "衣装を変更",
        outfit_changed = "衣装変更",
        outfit_changed_success = "衣装が正常に変更されました！",
        outfit_change_failed = "衣装の変更に失敗しました",
        outfit_preview = "衣装プレビュー",

        -- Settings Tab
        employee_settings = "従業員設定",
        avatar_settings = "アバター設定",
        update_profile_picture = "プロフィール写真を更新",
        image_url = "画像URL",
        enter_url_preview = "以下にURLを入力してアバターをプレビュー",
        preview = "プレビュー",
        enter_url_message = "アバター画像のURLを入力してください",
        avatar_updated = "アバター更新",
        avatar_created = "アバター作成",
        avatar_updated_message = "アバターが正常に更新されました！",
        update_failed = "更新失敗",
        update_failed_message = "アバターの更新に失敗しました",
        invalid_url = "無効なURL",
        invalid_url_message = "有効な画像URLを入力してください",
        updating = "更新中...",
        update_avatar = "アバターを更新",

        -- UI Theme
        ui_theme = "UIテーマ",
        customize_appearance = "ダッシュボードの外観をカスタマイズ",
        light_mode = "ライトモード",
        dark_mode = "ダークモード",

        -- Notifications
        notifications = "通知",
        manage_notification_preferences = "通知設定を管理",
        employee_notifications = "従業員通知",
        notifications_enabled_desc = "すべての従業員給与更新を受け取ります",
        notifications_disabled_desc = "通知を受け取りません",
        notifications_updated = "通知更新",
        notifications_enabled_message = "給与通知が有効になりました",
        notifications_disabled_message = "給与通知が無効になりました",
        enabled = "有効",
        disabled = "無効",

        -- Withdrawal Dialog
        withdraw_all_funds = "全資金を引き出す",
        select_balance_type = "残高タイプを選択",
        all_balance = "全残高",
        delivery_balance = "配送残高",
        commission_balance = "コミッション残高",
        paycheck_balance = "給与残高",
        available_balance_type = "利用可能な %s 残高: $%d",
        enter_amount = "金額を入力",
        insufficient_funds = "資金不足",
        insufficient_balance = "%s 残高不足",
        funds_withdrawn = "資金引き出し",
        funds_withdrawn_success = "残高から $%d を正常に引き出しました",
        withdrawal_failed = "資金の引き出しに失敗しました",
        invalid_amount = "無効な金額",
        invalid_amount_message = "有効な金額を入力してください",
        no_funds = "資金なし",
        no_funds_message = "引き出す資金がありません",

        -- Common Actions
        cancel = "キャンセル",
        save = "保存",
        update = "更新",
        confirm = "確認",
        close = "閉じる",
        loading = "読み込み中...",

        -- Status Labels
        active = "アクティブ",
        inactive = "非アクティブ",
        online = "オンライン",
        offline = "オフライン",

        -- Error Messages
        error_occurred = "エラーが発生しました",
        operation_failed = "操作に失敗しました",
        data_load_failed = "データの読み込みに失敗しました",
        network_error = "ネットワークエラー",
        employee_data_error = "従業員データを取得できませんでした。",
        identity_error = "本人確認ができませんでした。",
        withdraw_invalid_amount = "無効な金額です！",
        insufficient_commission = "コミッション残高不足！",
        transaction_failed_update = "コミッション残高の更新に失敗しました！",
        fire_employee_not_found = "従業員が見つかりません！",
        fire_employee_wrong_business = "この従業員はあなたのビジネスで働いていません！",
        fire_employee_db_error = "データベースからの従業員解雇に失敗しました！",
        employment_notice_fired = "あなたは %s から解雇されました",
        avatar_invalid_url = "無効な画像URLが提供されました。",
        avatar_updated_success = "プロフィールアバターが正常に更新されました。",
        avatar_no_changes = "アバターに変更はありませんでした。",
        avatar_created = "従業員プロフィールとアバターが作成されました。",
        avatar_create_failed = "従業員レコードの作成に失敗しました。",
        withdrawal_invalid_amount = "無効な引き出し金額です。",
        employee_record_not_found_withdraw = "従業員レコードが見つかりません。",
        insufficient_balance_withdraw = "残高不足です。",
        withdraw_balance_failed = "残高からの引き出しに失敗しました。もう一度試してください。",
        identity_error_toggle = "本人確認ができませんでした",
        invalid_grade_data = "無効な等級データが提供されました。",
        grade_id_not_found = "この役割の等級IDが見つかりませんでした。",
        no_grade_changes = "職務等級に変更はありませんでした。",
        balance_withdrawn = "%s 残高から $%d をあなたの %s へ引き出しました。",
        player_not_found = "プレイヤーが見つかりません！",
        invalid_purchase_data = "無効な購入データです！",
        insufficient_funds = "%s の資金が足りません！",
        inventory_full = "インベントリのスペースが足りないか、重量制限を超えています！",
        purchase_complete = "購入完了！ アイテムがインベントリに追加されました。",
        shop_purchase = "ショップ購入: %s",
        business_balance_error = "%s の事業残高更新エラー",
        business_balance_success = "事業口座に $%s を正常に追加しました",
        transaction_record_error = "ショップ購入の取引記録エラー",
        avatar_found = "ショップ: %s のアバターが見つかりました: %s",
        avatar_not_found = "ショップ: %s のアバターが見つからないため、デフォルトを使用します",
    },

    Vending = {
        invalid_item_data = "無効なアイテムデータ。",
        insufficient_item = "このアイテムが足りません。",
        item_added_with_money = "アイテムが在庫に追加されました。 %sx %s に対して $%s を受け取りました",
        item_added = "アイテムが在庫に追加されました。",
        business_balance_error = "注文のための事業残高更新エラー",
        database_error = "データベースエラー",
        add_item_failed = "アイテムの追加に失敗しました。",
        invalid_collection_data = "無効な回収データ。",
        inventory_full = "インベントリにアイテムを追加できませんでした。",
        item_collected = "%sx %s を回収しました",
        stock_update_failed = "自販機在庫の更新に失敗しました。",
        out_of_stock = "在庫切れ",
        insufficient_stock = "回収できるアイテムが十分にありません。",
        sale_transaction_error = "自販機販売取引の記録エラー",
        collection_transaction_error = "自販機回収取引の記録エラー",
    },

    JobSystem = {
        no_permission = "このコマンドを使用する権限がありません。",
        player_not_found = "プレイヤーが見つかりません。",
        job_assigned = "職務が割り当てられました。",
        job_assign_failed = "職務の割り当てに失敗しました。",
        job_removed = "職務が削除されました。",
        job_remove_failed = "職務の削除に失敗しました。",
        job_changed_notification = "職務変更",
        job_changed = "あなたの職務は %s (等級 %s) に変更されました。",
        job_removed_notification = "あなたの職務は削除されました。",
        give_job_usage = "使用法: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "使用法: /%s [playerId]",
        job_info = "職務: %s (等級: %s, 勤務: %s)",
        job_info_error = "職務情報を取得できませんでした。",
        duty_status = "あなたは今 %s です。",
        not_on_duty = "勤務外",
        must_be_on_duty = "給与を受け取るには勤務中である必要があります。",
        paycheck_title = "給与",
        employer_insufficient_funds = "ボスにはあなたに支払う十分な資金がありません。",
        paycheck_added = "職務: %s の従業員 %s の残高に $%s の給与が追加されました",
        paycheck_received = "%s から $%s の給与を受け取りました",
    },

    BillingInviteNotification = {
        message = "支払い請求を受け取りました。",

        -- Titles / headers
        title = "支払い請求",
        label = "請求通知",

        -- Button labels
        pay_button = "請求書を支払う",
        decline_button = "拒否",

        -- Small UI labels used inside the notification component
        business_label = "ビジネス",
        total_amount_label = "合計金額",
        reason_label = "理由",
        amount_label = "金額:",

        -- Warning / helper texts
        warning_text = "支払いはあなたのアカウントから引き落とされます。資金が十分であることを確認してください。",
        expires_text = "残り時間 %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "Burgershotでの %s としての参加招待を受けました。承諾しますか？",

        -- Titles / headers
        title = "採用通知",
        label = "採用通知のお知らせ",

        -- Button labels
        accept_button = "承諾",
        reject_button = "拒否",

        -- Small UI labels used inside the notification component
        company_label = "会社",
        grade_label = "等級",
        invites_left_label = "残り招待数",
        salary_label = "給与",

        -- Warning / helper texts
        warning_text = "この仕事を受けると、その役割に従事することになります。準備ができているか確認してください。",
        expires_text = "残り時間 %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "レストランメニュー",
        onduty = "レストランメニューにアクセスするには勤務中である必要があります。",
    },

    Duty = {
        status = "勤務状況",
        management = "勤務管理",
        description = "あなたは今 %s です。",
        restaurant_area = "レストランエリア",
        clock_in = "レストランエリアに入りました。従業員メニューを使用して出勤してください。",
        enter_workplace = "職場に入りました。現在は勤務中です。",
        leave_workplace = "職場を離れました。現在は勤務外です。",
        inside_workplace = "職場内にいます - 自動的に勤務中に設定されます。",
        outside_workplace = "職場外にいます - 自動的に勤務外に設定されます。",
        duty_warning = "勤務警告",
        auto_off_duty = "レストランの外に出ると自動的に勤務外になります。",
        no_permission_manage_duty = "従業員の勤務状況を管理する権限がありません",
        not_employee_of_job = "プレイヤーはこの仕事の従業員ではありません",
        duty_set_by_management = "あなたの勤務状況は管理者によって %s に設定されました",
        duty_management_success = "%s の勤務状況を %s に正常に設定しました",
        updated_offline_employee = "オフラインの従業員の勤務状況を更新しました",
    },

    Paycheck = {
        title = "給与受領",
        message = "%s から $%s の給与を受け取りました",
    },

    VendingMachine = {
        sell_item = "アイテムを売る",
        select_item_from_inventory = "インベントリからアイテムを選択",
        add_to_vending = "%s を自販機に追加",
        cancel = "キャンセル",
        no_matching_items = "インベントリに一致するアイテムがありません",
        stocked_items = "在庫アイテム",
        sell = "売る",
        no_stock = "在庫なし",
        items = "アイテム在庫",
        ready_to_serve = "提供準備完了！",
    },

    EmployeeVendingMachine = {
        title = "自販機から回収",
        label = "自販機の在庫からアイテムを回収",
        collect = "回収",
        cancel = "キャンセル",
        quantity_available = "数量 (利用可能: %s)",
        collect_item = "%s を回収",
        collect_button = "回収",
        in_stock = "在庫あり",
        vending_machine_empty = "この自動販売機は空です。",
    },

    OrderingTab = {
        where_eating_today = "今日のお食事はどちらで？",
        eat_in = "店内飲食",
        take_out = "テイクアウト",
        whats_up = "いらっしゃいませ",
        popular = "人気",
        done = "完了",
        my_order = "注文",
        empty = "空",
        total = "合計",
        checkout = "会計",
        back = "戻る",
        no_menu_items = "%s のメニューアイテムはありません",
        loading = "読み込み中...",
        eat_in_label = "店内飲食",
        take_out_label = "テイクアウト",
        pay_cash = "現金",
        cancel = "キャンセル",
        order = "注文",
        pay_bank = "銀行",
        all_items = "全アイテム",
        bank_only_disclaimer = "支払いは銀行のみ可能です。",
    },

    OrderManagementTable = {
        title = "注文管理パネル",
        label = "注文管理",
        filter_all = "すべて",
        filter_cooking = "調理中",
        filter_ready = "準備完了",
        filter_completed = "完了",
        filter_terminal_orders = "ターミナル注文",
        filter_self_pickup = "キオスク注文",
        sort_by = "並べ替え",
        sort_day = "日",
        sort_amount = "金額",
        sort_name = "名前",
        no_orders = "現在のフィルタに一致する注文はありません。",
        accept = "承認",
        accepting = "承認中...",
        cooking = "調理中",
        ready = "準備完了",
        complete = "完了",
        completed = "完了済み",
        assigned_to = "担当者: ",
        items_label = "アイテム:",
        order_label = "注文番号",
        status_cooking = "調理中",
        status_ready = "準備完了",
        status_completed = "完了済み",
        status_cancelled = "キャンセル済み",
        self_pickup = "セルフ受取",
    },

    MenuSelectionDialog = {
        title = "アクションを選択",
        subtitle = "何をしたいですか？",
        options = {
            shop = {
                title = "ショップを開く",
                description = "自動販売機から商品を閲覧して購入"
            },
            manageBoss = {
                title = "ショップを管理",
                description = "在庫を管理、分析を表示、自動販売機を制御"
            },
            manageEmployee = {
                title = "ショップを管理",
                description = "自動販売機に在庫商品を追加および管理"
            }
        }
    },
}