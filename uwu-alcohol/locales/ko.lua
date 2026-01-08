-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["ko"] = {
    
    WashHands = {
        title = "세면대",
        no_available = "이용 가능한 세면대가 없습니다",
        success = "손이 깨끗해졌습니다!",
        error = "오류",
        fail = "이미 손이 깨끗합니다!",
        targetfail = "먼저 손을 씻어야 합니다!",
        item_cleaned = "아이템이 성공적으로 세척되었습니다!",
        missing_required = "필요한 아이템이 없습니다"
    },

    Terminal = {
        SubmitText = "청구서 전송",

        -- Player Selection Tab
        select_player = "플레이어 선택",
        nearby_players = "주변 플레이어",
        search_players = "플레이어 검색...",
        no_players_found = "주변에 플레이어가 없습니다",
        loading_players = "플레이어 불러오는 중...",
        player_selected = "플레이어가 선택되었습니다",

        -- Menu Items Tab
        menu_items = "메뉴 아이템",
        items_added = "아이템이 추가되었습니다",
        search_menu_items = "메뉴 아이템 검색...",
        available_items = "이용 가능한 아이템",
        selected_items = "선택된 아이템",
        no_items_found = "아이템을 찾을 수 없습니다",
        no_items_selected = "선택된 아이템이 없습니다",
        total_items = "총 아이템",
        total = "합계",
        all = "전체",

        -- Finalize Bill Tab
        finalize_bill = "청구서 확정",
        customer_info = "고객 정보",
        order_summary = "주문 요약",
        amount_label = "금액 ($)",
        enter_amount = "금액 입력",
        reason_label = "사유 (선택)",
        reason_placeholder = "청구 사유 입력",
        payment_method = "결제 방법",
        cash = "현금",
        bank = "계좌",
        send_bill = "청구서 전송",

        -- Commission
        your_commission = "당신의 수수료",
        commission_rate = "수수료율",

        -- Bills sent counter
        bills_sent = "전송된 청구서:",
        commission = "수수료:",

        -- Error Messages
        bill_error = "청구 오류",
        select_player_error = "플레이어를 선택해주세요",
        invalid_amount_error = "유효한 금액을 입력해주세요",

        -- Success Messages
        bill_sent_success = "청구서가 성공적으로 전송되었습니다!",
        bill_sent_title = "청구서 전송됨",
    },

    Consumable = {
        Drinking = "마시는 중 ", -- Drinking ItemName
        Eating = "먹는 중 " -- Eating ItemName
    },

    Garage = {
        title = "차고",
        no_vehicle = "반납할 차량이 없습니다",
        not_job_vehicle = "이것은 Burgershot 차량이 아닙니다!",
        parked_title = "차량 주차됨!",
        parked_message = "차량이 이 위치에 주차되었습니다!",
        in_vehicle = "차량 안에 있을 수 없습니다!",
        too_far = "차량과 너무 멉니다!",
        spawn_error = "지금은 할 수 없습니다!",

        -- UI Text
        garage_title = "차고",
        garage_active_vehicles = "활성",
        garage_manage = "활성 차량 관리",
        close = "닫기",
        search_vehicles = "차량 검색...",
        no_vehicles_found = "차량을 찾을 수 없습니다",
        dont_have_vehicle = "이 차고에 보관된 차량이 없습니다.",
        select_vehicle = "차량 선택",
        select_vehicle_message = "목록에서 차량을 선택하여 세부 정보를 확인하고 소환하세요.",
        back = "뒤로",
        spawn_vehicle = "차량 소환",
        return_button = "반납",
        return_vehicle = "차량 반납",
        license_plate = "번호판",

        -- Status Messages
        vehicle_spawned = "차량이 성공적으로 소환되었습니다",
        no_vehicle_to_return = "반납할 차량이 없습니다",
        access_denied = "이 차고에 접근할 수 없습니다.",
        all_spawn_points_blocked = "모든 소환 지점이 현재 차단되었습니다. 잠시 기다려주세요.",
        vehicle_model_not_exist = "차량 모델이 존재하지 않습니다",
        failed_load_model = "차량 모델 로드 실패",
        failed_create_vehicle = "차량 생성 실패",
        invalid_vehicle_data = "유효하지 않은 차량 모델 데이터",

        -- Error Messages
        error = "오류",
        garage_error = "차고 오류",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "차량 엔티티 생성 실패",
        no_spawn_points_available = "이용 가능한 소환 지점이 없습니다",
        vehicle_returned_parked = "차량이 반납되어 주차되었습니다.",
        vehicle_processed_remote = "차량이 처리되었습니다 (원격 반납).",
    },

    Billing = {
        title = "청구",
        payment_failed_byreceiver = "결제 실패: %s님이 %s을(를) 지불할 자금이 부족합니다.",
        business_closed = "청구 기능은 현재 관리자에 의해 비활성화되었습니다.",
        commission_earned = "수수료 획득",
        commission_earned_description = "수수료 $%s을(를) 획득했습니다.",
        terminal_title = "청구 단말기",
        off_duty_error = "단말기를 사용하려면 근무 중이어야 합니다.",
        access_denied = "청구 단말기에 접근할 수 없습니다.",
        payment_received = "지불 수신",
        payment_received_message = "%s님으로부터 $%s을(를) 받았습니다",
        payment_failed = "지불 실패",
        payment_failed_message = "청구서 지불에 실패했습니다",
        bill_sent = "청구서 전송됨",
        bill_sent_success = "청구서가 성공적으로 전송되었습니다!",
        bill_sent_error = "청구서 전송에 실패했습니다.",
        bill_error = "청구 오류",
        invalid_bill = "유효하지 않은 청구서!",
        invalid_bill_description = "지불하려는 청구서가 존재하지 않습니다.",
        invalid_target_amount = "유효하지 않은 대상 또는 금액!",
        player_not_found = "플레이어를 찾을 수 없습니다!",
        must_be_on_duty = "청구서를 보내려면 근무 중이어야 합니다!",
        bill_sent_description = "%s님에게 $%s 청구서를 %s(으)로 보냈습니다",
        bill_payment_successful = "✅ 청구서 지불 성공",
        bill_payment_failed_insufficient = "❌ 청구서 지불 실패 - 자금 부족",
        bill_rejected = "❌ 청구서 거절됨",
        insufficient_funds = "%s님의 자금이 부족합니다!",
        order_processed = "🍔 주문 처리됨",
        command_access_denied = "이 명령어를 사용할 수 없습니다!",
        payment_failed_insufficient = "%s님의 자금이 부족합니다!",
        bill_rejected_title = "청구서 거절됨",

        bill_rejected_sender = "%s님이 당신의 $%s 청구서를 거절했습니다",
        bill_rejected_receiver = "%s님의 청구서를 거절했습니다",
        billing_disabled = "청구 기능은 현재 관리자에 의해 비활성화되었습니다.",
        billing_off_duty = "청구 기능을 사용하려면 근무 중이어야 합니다.",
    },

    Delivery = {
        items_header = "배달 아이템",
        reward_header = "보상",
        accept_header = "배달 수락",
        decline_header = "배달 거절",
        menu_header = "배달 메뉴",
        no_delivery = "활성 배달 없음!",
        new_delivery_title = "새로운 배달",
        new_delivery_desc = "새로운 배달 요청을 받았습니다.",
        delivery_expired = "배달 요청이 만료되었습니다.",
        delivery_timeout = "배달을 완료할 시간이 부족했습니다.",
        delivery_declined = "배달 요청을 거절했습니다.",
        check_location = "GPS에서 배달 위치를 확인하세요.",
        check_location_error = "추적할 활성 배달이 없습니다.",
        delivery_accepted = "배달 수락됨",
        invalid_item = "배달에 유효하지 않은 아이템",
        delivery_failed = "배달 실패",
        invalid_items_data = "유효하지 않은 아이템 데이터",

        -- UI Text
        delivery_title = "배달",
        close_menu = "메뉴 닫기",
        new_order = "새 주문",
        in_progress = "진행 중",
        order_items = "주문 아이템:",
        payment = "결제",
        delivery_status = "배달 상태",
        deliver_instruction = "지도에 표시된 위치로 음식을 배달하세요.",
        time_remaining = "남은 시간:",
        order_summary = "주문 요약:",
        accept = "수락",
        decline = "거절",
        cancel_delivery = "배달 취소",

        -- Notifications
        delivery_accepted_notification = "배달이 성공적으로 수락되었습니다",
        delivery_cancelled_notification = "배달이 성공적으로 취소되었습니다",

        -- Status Messages
        complete_delivery = "배달 완료",
        delivery_in_progress = "배달 진행 중...",
        head_to_location = "배달을 완료하려면 표시된 위치로 이동하세요",
    },

    Consumption = {
        title = "소비",
        description = "신선하고 맛있습니다!",
        refresh_title = "상쾌함",
        refresh_description = "상쾌해졌습니다",
    },

    Crafting = {
        craft_title = "%s 제작",
        enter_amount_description = "제작할 수량 입력",
        crafting_successful = "제작 성공",
        crafted_description = "%d x %s 제작됨",
        crafting_cancelled = "제작 취소됨",
        cancelled_description = "제작을 취소했습니다",
        no_space = "인벤토리에 공간이 없습니다",
    },

    Targets = {
        door = "문 노크",
        door_icon = "fas fa-door-open",
        delivery_food = "음식 배달",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "주문 태블릿",
        ordering_tablet_error = "주문 태블릿 기능을 사용할 수 없습니다.",
        order_management_tablet = "주문 관리 태블릿",
        order_management_error = "주문 관리 태블릿 기능을 사용할 수 없습니다.",
        return_utensils = "식기 반납",
        employee_vending = "직원 자판기",
    },

    Order = {
        complete = "주문 완료",
        description = "주문이 처리되었습니다. 청구서가 인벤토리에 추가되었습니다.",
        paycheck_suspended_description = "사업장이 닫혀 있는 동안 급여 지급이 중단됩니다.",
        paycheck_suspended = "급여 중단",
    },

    Door = {
        title = "문 ",
        description = "문이 ",
        locked = "문이 잠겼습니다",
        no_permissions = "이 문을 잠그거나 열 권한이 없습니다",
        access_denied_title = "접근 거부됨",
        access_granted = "문의 잠금을 해제했습니다",
        access_denied = "이 문에 접근할 수 없습니다",
    },

    Outfits = {
        title = "복장",
        invalid = "유효하지 않은 성별",
        failed_equip = "복장 착용 실패",
        disabled = "복장이 비활성화되었습니다",
        civilian_clothes = "사복으로 변경",
        reset_civilian_clothes = "사복으로 돌아왔습니다",
        no_civilian_saved = "저장된 사복이 없습니다. 먼저 유니폼으로 변경하세요.",
        no_permission = "이 복장을 사용할 권한이 없습니다",
        outfit_not_found = "복장을 찾을 수 없습니다",
        equip_success = "복장이 성공적으로 착용되었습니다",
        changed_to_uniform = "%s(으)로 변경됨",
        reset_success = "복장이 성공적으로 초기화되었습니다",
        no_civilian_for_reset = "저장된 사복이 없습니다. 먼저 유니폼으로 변경하고 옷을 저장하세요.",
    },

    System = {
        success = "성공",
        paycheck_error = "급여 오류",
        inventory_full = "인벤토리 가득 참",
        inventory_full_description = "인벤토리가 가득 찼습니다.",
        society_not_found = "사업장을 찾을 수 없습니다",
        business_funds_insufficient = "사업장에 급여를 지급할 자금이 부족합니다.",
        error = "오류",
        invalid = "유효하지 않음",
        no_license = "라이선스를 확인할 수 없습니다. 관리자에게 문의하세요.",
        missing_items = "아이템 누락",
        item_cleaned = "아이템이 성공적으로 세척되었습니다",
        missing_required = "필요한 아이템이 없습니다",
        slot_error = "같은 슬롯에 수량을 넣으세요",
        ice_collected = "얼음 수집됨",
        refreshing = "상쾌해지는 중",
        refreshed = "상쾌해짐",
        consumption = "소비",
        stress_increased = "스트레스 증가",
        stress_amount = "스트레스 수준이 %s 증가했습니다",
        inventory_full = "인벤토리가 가득 찼습니다",
    },

    Experience = {
        gained_title = "경험치 획득",
        experience_earned_description = "%d XP를 획득했습니다.",
        gained_message = "배달 완료로 %d XP를 획득했습니다!",
    },

    BossMenu = {
        title = "사장 메뉴",
        unable_jobdetermine = "직업을 확인할 수 없습니다. 나중에 다시 시도해주세요.",
        bankruptcy_alert = "⚠️ 파산 경고",
        description = "급여를 지급할 수 없습니다! 사업 잔액: $%s, 필요 금액: $%s",
        trans_failed_bossmenubalance = "거래 실패 - 사업 자금 부족",
        menu_in_use = "사장 메뉴를 현재 %s님이 사용 중입니다.",
        no_permissions = "사장 권한이 없습니다! 사장이어야 합니다.",
        wrong_job = "올바른 직업이 아닙니다",
        grade_updated = "직급 업데이트됨",
        grade_update_success = "%s 직급이 성공적으로 업데이트되었습니다.",
        menu_update = "메뉴 업데이트",
        menu_update_success = "메뉴 아이템이 성공적으로 업데이트되었습니다!",
        vending_update = "자판기",
        vending_update_success = "자판기 아이템이 성공적으로 업데이트되었습니다!",
        menu_update_error = "메뉴 아이템 업데이트 실패!",
        menu_delete = "메뉴 삭제",
        menu_delete_success = "메뉴 아이템이 성공적으로 삭제되었습니다!",
        menu_delete_error = "메뉴 아이템 삭제 실패!",
        invite_sent = "초대 전송됨",
        invite_sent_success = "직업 초대가 %s님에게 전송되었습니다",
        invite_error = "유효하지 않은 플레이어 ID 또는 역할!",
        player_not_found = "플레이어를 찾을 수 없습니다!",
        job_error = "유효하지 않은 초대 데이터!",
        job_accepted = "이제 %s의 %s입니다",
        job_updated_title = "직업 업데이트됨",
        job_updated = "당신의 직책이 %s의 %s(으)로 업데이트되었습니다",
        database_error = "직업이 설정되었으나 데이터베이스 업데이트에 실패했습니다.",
        invite_rejected = "직업 초대를 거절했습니다.",
        withdraw_error = "유효하지 않은 금액!",
        business_error = "사업장을 찾을 수 없습니다!",
        insufficient_funds = "사업 자금이 부족합니다!",
        money_withdrawn = "사업 계좌에서 $%s을(를) 출금했습니다.",
        transaction_failed = "사업 계좌 업데이트 실패!",
        money_deposited = "사업 계좌에 $%s을(를) 입금했습니다.",
        transaction_failed_refund = "사업 계좌 업데이트 실패! 금액이 반환되었습니다.",
        shop_purchase = "새로운 상점 구매",
        shop_purchase_notification = "%s님이 $%s어치 아이템을 구매했습니다",
        menu_occupied = "사장 메뉴 사용 중",
        menu_occupied_by = "%s님이 현재 사장 메뉴를 사용 중입니다. 나중에 다시 시도해주세요.",
        menu_released = "사장 메뉴를 이제 사용할 수 있습니다",

        -- Main Headers and Titles
        business_overview = "사업 개요",
        business_settings = "사업 설정",
        menu_management = "메뉴 관리",
        staff_management = "직원 관리",
        employee_leaderboard = "직원 순위표",
        sales_transactions = "매출 및 거래",

        -- Finance Section
        finance = "재무",
        business_balance = "사업 잔액",
        withdraw = "출금",
        deposit = "입금",
        withdraw_money = "자금 출금",
        deposit_money = "자금 입금",
        enter_amount_withdraw = "사업 계좌에서 당신의 %s(으)로 출금할 금액을 입력하세요.",
        enter_amount_deposit = "당신의 %s에서 사업 계좌로 입금할 금액을 입력하세요.",
        available = "이용 가능",
        enter_amount = "금액 입력",
        withdraw_to = "%s(으)로 출금",
        deposit_from = "%s에서 입금",
        updating = "업데이트 중...",
        update_avatar = "아바타 업데이트",
        cancel = "취소",
        cash = "현금",
        bank = "계좌",
        invalid_url = "유효하지 않은 URL",
        invalid_url_message = "유효한 이미지 URL을 입력해주세요",
        avatar_updated = "아바타 업데이트됨",
        avatar_updated_message = "아바타가 성공적으로 업데이트되었습니다!",
        update_failed = "업데이트 실패",
        update_failed_message = "아바타 업데이트 실패",
        business_status = "사업 상태",
        business_status_desc = "사업 운영 상태 제어",
        business_operations = "사업 운영",
        business_open = "현재 영업 중 - 청구 활성화됨",
        business_closed = "현재 영업 종료 - 청구 비활성화됨",
        business_status_updated = "사업 상태",
        business_now_open = "사업장이 이제 열렸습니다",
        business_now_closed = "사업장이 이제 닫혔습니다",
        business_status_error = "오류",
        business_status_failed = "사업 상태 업데이트 실패",

        -- Employees Section
        employees = "직원",
        invite_new_employee = "새 직원 초대",
        player_id = "플레이어 ID...",
        invite = "초대",
        select_role = "역할 선택",
        choose_role_for = "%s님의 역할 선택",
        available_roles = "이용 가능한 역할:",
        roles_available = "%d개의 역할 이용 가능",
        send_invite = "초대 전송",

        -- Sales Summary
        sales_summary = "매출 요약",
        today = "오늘",
        this_week = "이번 주",
        this_month = "이번 달",
        view_sales = "매출 보기",

        -- Inventory Status
        inventory_status = "재고 상태",
        storage_capacity = "저장 용량",
        ingredients = "재료",
        supplies = "비품",
        manage_inventory = "재고 관리",

        -- Menu Management
        search_menu_items = "메뉴 아이템 검색...",
        edit_menu_item = "메뉴 아이템 수정",
        update_item_details = "아래에서 아이템 세부 정보를 업데이트하세요.",
        label_display_name = "라벨 (표시 이름)",
        price = "가격 ($)",
        category = "카테고리",
        select_category = "카테고리 선택",
        update = "업데이트",
        all_items = "모든 아이템",
        no_menu_items = "메뉴 아이템을 찾을 수 없습니다",
        no_category_items = "%s을(를) 찾을 수 없습니다",

        -- Vending Machine Management
        vending_machine_management = "자판기 관리",
        search_vending_items = "자판기 아이템 검색...",
        edit_vending_item = "자판기 아이템 수정",
        update_vending_details = "아래에서 아이템 세부 정보를 업데이트하세요.",
        all_vending_items = "모든 아이템",
        no_vending_items = "자판기 아이템을 찾을 수 없습니다",
        no_category_vending_items = "%s을(를) 찾을 수 없습니다",
        vending_update_error = "자판기 아이템 업데이트 실패",
        item_price = "가격",
        item_type = "유형",
        uncategorized = "미분류",
        enter_price = "예: 5",

        -- Staff Management
        employee_overview = "직원 개요",
        total_employees = "총 직원",
        active_employees = "활성 직원",
        pending_applications = "대기 중인 지원",
        employee_list = "직원 목록",
        search_employees = "직원 검색...",
        all_employees = "모든 직원",
        name = "이름",
        role = "역할",
        salary = "급여",
        last_seen = "마지막 접속",
        actions = "작업",
        promote = "승진",
        demote = "강등",
        fire = "해고",
        employee_actions = "직원 작업",
        select_action = "%s님에 대한 작업 선택",
        promote_employee = "직원 승진",
        demote_employee = "직원 강등",
        fire_employee = "직원 해고",
        confirm_action = "작업 확인",
        confirm_promote = "정말로 %s님을 %s(으)로 승진시키겠습니까?",
        confirm_demote = "정말로 %s님을 %s(으)로 강등시키겠습니까?",
        confirm_fire = "정말로 %s님을 해고하시겠습니까?",
        action_success = "작업이 성공적으로 완료되었습니다",
        action_failed = "작업 실패",
        employee_promoted = "직원이 성공적으로 승진되었습니다",
        employee_demoted = "직원이 성공적으로 강등되었습니다",
        employee_fired = "직원이 성공적으로 해고되었습니다",
        no_employees = "직원을 찾을 수 없습니다",

            -- Job Grades Management Dialog
        manage_job_grades = "직급 관리",
        configure_salary_commission = "각 직책에 대한 급여 및 수수료율 구성",
        search_job_grades = "직급 검색...",
        edit_job_grade = "직급 수정",
        update_job_grade_details = "직급 세부 정보 업데이트",
        job_title = "직책명",
        commission_rate = "수수료율",
        boss_access = "사장 권한",
        boss_access_enabled = "이 역할은 관리 기능에 접근할 수 있습니다",
        boss_access_disabled = "이 역할은 직원 수준의 접근 권한을 가집니다",
        save_changes = "변경 사항 저장",
        boss_role = "사장 역할",
        grade_update_error = "직급 업데이트 실패",

        -- Employee Details View
        employee_overview = "직원 세부 정보",
        employee_profile = "직원 프로필",
        performance_stats = "성과 지표",
        back = "뒤로",
        
        -- Employee Profile Card Labels
        commission = "수수료",
        total_earnings = "총 수입",
        available_balance = "이용 가능한 잔액",
        employee_id = "직원 ID",
        
        -- Performance Stats Labels
        deliveries_label = "배달",
        billings_label = "청구",
        earnings_label = "수입",
        experience_label = "경험치",
        level_label = "레벨",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "소득 분배",
        delivery_income = "배달",
        commission_income = "수수료",
        paycheck_income = "급여",
        completed_label = "완료됨",
        bills_label = "청구서",
        hourly_label = "시간당",

        -- Employee Card Labels (for list view)
        rank_label = "직급",
        commission_label = "수수료",

        -- Role Change Dialog
        no_role_employees = "%s을(를) 찾을 수 없습니다",
        employee_updated = "직원 업데이트됨",
        employee_commission_updated = "직원 수수료율이 %s(으)로 업데이트되었습니다",
        fire_employee_error = "직원 해고 실패",

        -- Employee Leaderboard
        top_performers = "최고 성과자",
        this_month_leaders = "이번 달 리더",
        rank = "순위",
        employee = "직원",
        performance = "성과",
        orders_completed = "완료된 주문",
        revenue_generated = "창출된 수익",
        customer_rating = "고객 평점",
        no_data = "성과 데이터가 없습니다",

        -- Transactions
        transaction_history = "거래 내역",
        recent_transactions = "최근 거래",
        paycheck_history = "급여 내역",
        transaction_type = "거래 유형",
        amount = "금액",
        date = "날짜",
        message = "설명",
        customer = "고객",
        filter_transactions = "거래 필터링...",
        all_transactions = "모든 거래",
        sales_only = "매출만",
        paychecks_only = "급여만",
        no_transactions = "거래를 찾을 수 없습니다",
        no_paychecks = "급여 기록을 찾을 수 없습니다",


        -- Settings
        avatar_settings = "아바타 설정",
        update_profile_picture = "프로필 사진 업데이트",
        image_url = "이미지 URL",
        enter_url_preview = "아바타를 미리 보려면 아래에 URL을 입력하세요",
        preview = "미리보기",
        enter_url_message = "아바타 이미지 URL을 입력하세요",
        ui_theme = "UI 테마",
        customize_appearance = "대시보드 외관 사용자 정의",
        light_mode = "라이트 모드",
        dark_mode = "다크 모드",

        -- Navigation
        home = "홈",
        staff = "직원",
        menu = "메뉴",
        sales = "매출",
        top = "상위",
        settings = "설정",

        -- Status Labels
        open = "영업 중",
        closed = "영업 종료",
        online = "온라인",
        offline = "오프라인",
        active = "활성",
        inactive = "비활성",

        -- Common Actions
        save = "저장",
        edit = "수정",
        delete = "삭제",
        confirm = "확인",
        close = "닫기",
        refresh = "새로고침",
        loading = "로딩 중...",

        -- Error Messages
        error_occurred = "오류가 발생했습니다",
        invalid_input = "유효하지 않은 입력",
        operation_failed = "작업 실패",
        permission_denied = "권한 거부됨",
        network_error = "네트워크 오류",
        data_load_failed = "데이터 로드 실패",

        -- Success Messages
        operation_successful = "작업이 성공적으로 완료되었습니다",
        data_saved = "데이터가 성공적으로 저장되었습니다",
        changes_applied = "변경 사항이 성공적으로 적용되었습니다",
    },

    Shop = {
        shop_status = "상점 상태",
        shop_open = "상점 열림",
        shop_closed = "상점 닫힘",
        access_denied = "이 상점에 접근할 수 없습니다!",
        purchase_title = "상점",
        purchase_success = "구매 완료! 아이템이 인벤토리에 추가되었습니다.",
        purchase_error = "결제 실패!",

        -- Search and Inventory
        search_placeholder = "이름으로 상품 검색...",
        clear_search = "검색 초기화",
        shop_inventory = "상점 재고",
        items_count = "아이템",

        -- Product Actions
        add_to_cart = "추가",
        per_item = "개당",

        -- Cart
        your_cart = "장바구니",
        cart_empty = "장바구니가 비어 있습니다",
        cart_empty_message = "쇼핑을 시작하려면 아이템을 추가하세요",
        items_label = "아이템",
        total = "합계",

        -- Search Results
        no_items_found = "아이템을 찾을 수 없습니다",
        no_items_message = "검색어를 조정하거나 모든 아이템을 둘러보세요",

        -- Payment
        pay_with_cash = "현금",
        pay_with_bank = "계좌",
        processing = "처리 중...",
        inventory_notice = "아이템은 인벤토리에 직접 추가됩니다",

        -- Notifications
        cart_updated = "장바구니 업데이트됨",
        item_added = "아이템 추가됨",
        item_removed = "아이템 제거됨",
        quantity_updated = "수량 업데이트됨",
        purchase_complete = "구매 완료",
        transaction_failed = "거래 실패",
        checkout_error = "결제 오류",
        cart_empty_error = "장바구니가 비어 있습니다",
        paid_with_cash = "현금으로 지불됨",
        charged_to_bank = "은행 계좌로 청구됨",
        not_enough_cash = "현금이 부족합니다",
        insufficient_bank = "은행 잔액 부족",

        -- Quantity Messages
        added_more = "%s %d개 추가됨",
        removed_items = "%s %d개 제거됨",
        added_to_cart = "%s이(가) 장바구니에 추가되었습니다",
        removed_from_cart = "%s이(가) 장바구니에서 제거되었습니다",

        -- Loading
        loading_shop = "상점 메뉴 로딩 중...",
    },

    EmployeeMenu = {
        access_denied = "이 포털에 접근할 수 없습니다!",
        commission_withdrawn = "수수료 출금됨",
        commission_withdrawn_description = "수수료 잔액에서 $%s을(를) 당신의 %s(으)로 출금했습니다.",
        transaction_failed = "거래 실패",
        fire_employee = "직원 해고",
        fire_employee_description = "%s님이 사업장에서 해고되었습니다!",
        employeeMent_notice = "직원 알림",
        
        no_employee_active = "현재 주문을 처리할 수 있는 온라인 상태의 활성 직원이 없습니다.",
        -- Main Headers and Navigation
        employee_portal = "직원 포털",
        employee_profile = "직원 프로필",
        performance_stats = "성과 통계",
        employee_leaderboard = "직원 순위표",
        job_outfits = "직업 복장",
        account_settings = "계정 설정",

        -- Navigation Labels
        profile = "프로필",
        stats = "통계",
        top = "상위",
        outfits = "복장",
        settings = "설정",

        -- Profile Tab
        personal_information = "개인 정보",
        paycheck_information = "급여 정보",
        job_role = "직무",
        salary = "급여",
        experience = "경험",
        duty_status = "근무 상태",
        on_duty = "근무 중",
        off_duty = "근무 외",
        clock_in = "출근",
        clock_out = "퇴근",
        available_balance = "이용 가능한 잔액",
        withdraw = "출금",
        withdraw_funds = "자금 출금",
        paycheck_interval = "급여 간격",
        total_deliveries = "총 배달",
        bills_created = "생성된 청구서",
        total_earnings = "총 수입",
        minutes = "분",

        -- Performance Tab
        career_statistics = "경력 통계",
        experience_points = "경험치",
        xp_points = "XP 포인트",
        total_earned = "총 획득",
        current_balance = "현재 잔액",
        deliveries = "배달",
        total_completed = "총 완료",
        billings = "청구",
        invoices_created = "생성된 인보이스",
        job_grade_progression = "직급 진행",
        current_grade = "현재 직급",
        level = "레벨",
        xp_needed_promotion = "승진에 필요한 XP",
        earn_more_xp = "%s(으)로 승진하려면 %d XP를 더 획득하세요",
        max_grade_reached = "가장 높은 자동 승진 직급에 도달했습니다! 추가 승진은 관리자의 승인이 필요합니다.",
        promotions_by_management = "승진은 관리자에 의해 지정됩니다.",
        loading_experience_data = "경험치 시스템 데이터 로딩 중...",
        loading_progression_data = "진행 데이터 로딩 중...",

        -- Leaderboard Tab
        top_performers = "최고 성과자",
        this_month_leaders = "이번 달 리더",
        rank = "순위",
        employee = "직원",
        performance = "성과",
        no_leaderboard_data = "순위표 데이터가 없습니다",

        -- Outfits Tab
        work_outfits = "작업 복장",
        select_outfit = "복장 선택",
        change_outfit = "복장 변경",
        outfit_changed = "복장 변경됨",
        outfit_changed_success = "복장이 성공적으로 변경되었습니다!",
        outfit_change_failed = "복장 변경 실패",
        outfit_preview = "복장 미리보기",

        -- Settings Tab
        employee_settings = "직원 설정",
        avatar_settings = "아바타 설정",
        update_profile_picture = "프로필 사진 업데이트",
        image_url = "이미지 URL",
        enter_url_preview = "아바타를 미리 보려면 아래에 URL을 입력하세요",
        preview = "미리보기",
        enter_url_message = "아바타 이미지 URL을 입력하세요",
        avatar_updated = "아바타 업데이트됨",
        avatar_created = "아바타 생성됨",
        avatar_updated_message = "아바타가 성공적으로 업데이트되었습니다!",
        update_failed = "업데이트 실패",
        update_failed_message = "아바타 업데이트 실패",
        invalid_url = "유효하지 않은 URL",
        invalid_url_message = "유효한 이미지 URL을 입력해주세요",
        updating = "업데이트 중...",
        update_avatar = "아바타 업데이트",

        -- UI Theme
        ui_theme = "UI 테마",
        customize_appearance = "대시보드 외관 사용자 정의",
        light_mode = "라이트 모드",
        dark_mode = "다크 모드",

        -- Notifications
        notifications = "알림",
        manage_notification_preferences = "알림 환경설정 관리",
        employee_notifications = "직원 알림",
        notifications_enabled_desc = "모든 직원 급여 업데이트를 받습니다",
        notifications_disabled_desc = "알림을 받지 않습니다",
        notifications_updated = "알림 업데이트됨",
        notifications_enabled_message = "급여 알림이 활성화되었습니다",
        notifications_disabled_message = "급여 알림이 비활성화되었습니다",
        enabled = "활성화됨",
        disabled = "비활성화됨",

        -- Withdrawal Dialog
        withdraw_all_funds = "모든 자금 출금",
        select_balance_type = "잔액 유형 선택",
        all_balance = "모든 잔액",
        delivery_balance = "배달 잔액",
        commission_balance = "수수료 잔액",
        paycheck_balance = "급여 잔액",
        available_balance_type = "이용 가능한 %s 잔액: $%d",
        enter_amount = "금액 입력",
        insufficient_funds = "자금 부족",
        insufficient_balance = "%s 잔액 부족",
        funds_withdrawn = "자금 출금됨",
        funds_withdrawn_success = "잔액에서 $%d을(를) 성공적으로 출금했습니다",
        transaction_failed = "거래 실패",
        withdrawal_failed = "자금 출금 실패",
        invalid_amount = "유효하지 않은 금액",
        invalid_amount_message = "유효한 금액을 입력해주세요",
        no_funds = "자금 없음",
        no_funds_message = "출금할 자금이 없습니다",

        -- Common Actions
        cancel = "취소",
        save = "저장",
        update = "업데이트",
        confirm = "확인",
        close = "닫기",
        loading = "로딩 중...",

        -- Status Labels
        active = "활성",
        inactive = "비활성",
        online = "온라인",
        offline = "오프라인",

        -- Error Messages
        error_occurred = "오류가 발생했습니다",
        operation_failed = "작업 실패",
        data_load_failed = "데이터 로드 실패",
        network_error = "네트워크 오류",
        employee_data_error = "직원 데이터를 불러올 수 없습니다.",
        identity_error = "신원을 확인할 수 없습니다.",
        withdraw_invalid_amount = "유효하지 않은 금액!",
        insufficient_commission = "수수료 잔액 부족!",
        transaction_failed_update = "수수료 잔액 업데이트 실패!",
        fire_employee_not_found = "직원을 찾을 수 없습니다!",
        fire_employee_wrong_business = "이 직원은 당신의 사업장에서 일하지 않습니다!",
        fire_employee_db_error = "데이터베이스에서 직원 해고 실패!",
        employment_notice_fired = "%s에서 해고되었습니다",
        avatar_invalid_url = "유효하지 않은 이미지 URL이 제공되었습니다.",
        avatar_updated_success = "프로필 아바타가 성공적으로 업데이트되었습니다.",
        avatar_no_changes = "아바타에 변경 사항이 없습니다.",
        avatar_created = "직원 프로필과 아바타가 생성되었습니다.",
        avatar_create_failed = "직원 기록 생성 실패.",
        withdrawal_invalid_amount = "유효하지 않은 출금 금액.",
        employee_record_not_found_withdraw = "직원 기록을 찾을 수 없습니다.",
        insufficient_balance_withdraw = "잔액이 부족합니다.",
        withdraw_balance_failed = "잔액에서 출금 실패. 다시 시도해주세요.",
        identity_error_toggle = "신원을 확인할 수 없습니다",
        invalid_grade_data = "유효하지 않은 직급 데이터가 제공되었습니다.",
        grade_id_not_found = "이 역할의 직급 ID를 찾을 수 없습니다.",
        no_grade_changes = "직급에 변경 사항이 없습니다.",
        balance_withdrawn = "%s 잔액에서 $%d을(를) 당신의 %s(으)로 출금했습니다.",
        player_not_found = "플레이어를 찾을 수 없습니다!",
        invalid_purchase_data = "유효하지 않은 구매 데이터!",
        insufficient_funds = "%s에 자금이 부족합니다!",
        inventory_full = "인벤토리 공간이 부족하거나 무게 제한을 초과했습니다!",
        purchase_complete = "구매 완료! 아이템이 인벤토리에 추가되었습니다.",
        shop_purchase = "상점 구매: %s",
        business_balance_error = "%s에 대한 사업 잔액 업데이트 오류",
        business_balance_success = "사업 계좌에 $%s을(를) 성공적으로 추가했습니다",
        transaction_record_error = "상점 구매 거래 기록 오류",
        avatar_found = "상점: %s님의 아바타 발견: %s",
        avatar_not_found = "상점: %s님의 아바타를 찾을 수 없음, 기본값 사용",
    },

    Vending = {
        invalid_item_data = "유효하지 않은 아이템 데이터.",
        insufficient_item = "이 아이템이 충분하지 않습니다.",
        item_added_with_money = "아이템이 재고에 추가되었습니다. %sx %s에 대해 $%s을(를) 받았습니다",
        item_added = "아이템이 재고에 추가되었습니다.",
        business_balance_error = "주문에 대한 사업 잔액 업데이트 오류",
        database_error = "데이터베이스 오류",
        add_item_failed = "아이템 추가 실패.",
        invalid_collection_data = "유효하지 않은 수집 데이터.",
        inventory_full = "인벤토리에 아이템을 추가할 수 없습니다.",
        item_collected = "%sx %s 수집됨",
        stock_update_failed = "자판기 재고 업데이트 실패.",
        out_of_stock = "재고 없음",
        insufficient_stock = "수집할 아이템이 충분하지 않습니다.",
        sale_transaction_error = "자판기 판매 거래 기록 오류",
        collection_transaction_error = "자판기 수집 거래 기록 오류",
    },

    JobSystem = {
        no_permission = "이 명령어를 사용할 권한이 없습니다.",
        player_not_found = "플레이어를 찾을 수 없습니다.",
        job_assigned = "직업이 할당되었습니다.",
        job_assign_failed = "직업 할당 실패.",
        job_removed = "직업이 제거되었습니다.",
        job_remove_failed = "직업 제거 실패.",
        job_changed_notification = "직업 변경됨",
        job_changed = "당신의 직업이 %s (직급 %s)(으)로 변경되었습니다.",
        job_removed_notification = "당신의 직업이 제거되었습니다.",
        give_job_usage = "사용법: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "사용법: /%s [playerId]",
        job_info = "직업: %s (직급: %s, 근무: %s)",
        job_info_error = "직업 정보를 가져올 수 없습니다.",
        duty_status = "현재 %s 근무입니다.",
        not_on_duty = "근무 외",
        must_be_on_duty = "급여를 받으려면 근무 중이어야 합니다.",
        paycheck_title = "급여",
        employer_insufficient_funds = "고용주가 당신에게 지불할 자금이 부족합니다.",
        paycheck_added = "%s 직업: %s의 직원 잔액에 급여 $%s이(가) 추가되었습니다",
        paycheck_received = "%s님으로부터 급여 $%s을(를) 받았습니다",
    },

    BillingInviteNotification = {
        message = "지불 요청을 받았습니다.",

        -- Titles / headers
        title = "지불 요청",
        label = "청구 알림",

        -- Button labels
        pay_button = "청구서 지불",
        decline_button = "거절",

        -- Small UI labels used inside the notification component
        business_label = "사업장",
        total_amount_label = "총 금액",
        reason_label = "사유",
        amount_label = "금액:",

        -- Warning / helper texts
        warning_text = "결제 금액은 계좌에서 차감됩니다. 잔액을 확인하세요.",
        expires_text = "%s 후 만료", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "Burgershot에 %s(으)로 합류하도록 초대받았습니다. 수락하시겠습니까?",

        -- Titles / headers
        title = "직업 초대",
        label = "직업 초대 알림",

        -- Button labels
        accept_button = "수락",
        reject_button = "거절",

        -- Small UI labels used inside the notification component
        company_label = "회사",
        grade_label = "직급",
        invites_left_label = "남은 초대",
        salary_label = "급여",

        -- Warning / helper texts
        warning_text = "이 직업을 수락하면 해당 역할에 귀속됩니다. 시작할 준비가 되었는지 확인하세요.",
        expires_text = "%s 후 만료", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "레스토랑 메뉴",
        onduty = "레스토랑 메뉴에 접근하려면 근무 중이어야 합니다.",
    },

    Duty = {
        status = "근무 상태",
        management = "근무 관리",
        description = "현재 %s 근무입니다.",
        restaurant_area = "레스토랑 구역",
        clock_in = "레스토랑 구역에 입장했습니다. 직원 메뉴를 사용하여 출근하세요.",
        enter_workplace = "직장에 입장하여 근무 중 상태가 되었습니다.",
        leave_workplace = "직장을 떠나 근무 외 상태가 되었습니다.",
        inside_workplace = "직장 내부에 있습니다 - 자동으로 근무 중으로 설정됩니다.",
        outside_workplace = "직장 외부에 있습니다 - 자동으로 근무 외로 설정됩니다.",
        duty_warning = "근무 경고",
        auto_off_duty = "레스토랑 밖에 있으면 자동으로 근무 외로 설정됩니다.",
        no_permission_manage_duty = "직원 근무 상태를 관리할 권한이 없습니다",
        not_employee_of_job = "플레이어는 이 직업의 직원이 아닙니다",
        duty_set_by_management = "당신의 근무 상태가 관리자에 의해 %s(으)로 설정되었습니다",
        duty_management_success = "%s님의 근무 상태를 %s(으)로 성공적으로 설정했습니다",
        updated_offline_employee = "오프라인 직원의 근무 상태를 업데이트했습니다",
    },

    Paycheck = {
        title = "급여 수신됨",
        message = "%s님으로부터 급여 $%s을(를) 받았습니다",
    },

    VendingMachine = {
        sell_item = "아이템 판매",
        select_item_from_inventory = "인벤토리에서 아이템 선택",
        add_to_vending = "자판기에 %s 추가",
        cancel = "취소",
        no_matching_items = "인벤토리에 일치하는 아이템이 없습니다",
        stocked_items = "재고 아이템",
        sell = "판매",
        no_stock = "재고 없음",
        items = "아이템 재고",
        ready_to_serve = "서빙 준비 완료!",
    },

    EmployeeVendingMachine = {
        title = "자판기에서 수집",
        label = "자판기 재고에서 아이템 수집",
        collect = "수집",
        cancel = "취소",
        quantity_available = "수량 (이용 가능: %s)",
        collect_item = "%s 수집",
        collect_button = "수집",
        in_stock = "재고 있음",
        vending_machine_empty = "이 자판기는 비어 있습니다.",
    },

    OrderingTab = {
        where_eating_today = "오늘 어디서 식사하시겠습니까?",
        eat_in = "매장 식사",
        take_out = "포장",
        whats_up = "무엇을 도와드릴까요?",
        popular = "인기 메뉴",
        done = "완료",
        my_order = "내 주문",
        empty = "비어 있음",
        total = "합계",
        checkout = "결제",
        back = "뒤로",
        no_menu_items = "%s에 이용 가능한 메뉴 아이템이 없습니다",
        loading = "로딩 중...",
        eat_in_label = "매장 식사",
        take_out_label = "포장",
        pay_cash = "현금",
        cancel = "취소",
        order = "주문",
        pay_bank = "계좌",
        all_items = "모든 아이템",
        bank_only_disclaimer = "결제는 계좌 이체로만 가능합니다.",
    },

    OrderManagementTable = {
        title = "주문 관리 패널",
        label = "주문 관리",
        filter_all = "전체",
        filter_cooking = "조리 중",
        filter_ready = "준비됨",
        filter_completed = "완료됨",
        filter_terminal_orders = "터미널 주문",
        filter_self_pickup = "키오스크 주문",
        sort_by = "정렬 기준",
        sort_day = "날짜",
        sort_amount = "금액",
        sort_name = "이름",
        no_orders = "현재 필터와 일치하는 주문이 없습니다.",
        accept = "수락",
        accepting = "수락 중...",
        cooking = "조리 중",
        ready = "준비됨",
        complete = "완료",
        completed = "완료됨",
        assigned_to = "담당자: ",
        items_label = "아이템:",
        order_label = "주문 번호",
        status_cooking = "조리 중",
        status_ready = "준비됨",
        status_completed = "완료됨",
        status_cancelled = "취소됨",
        self_pickup = "직접 수령",
    },

    MenuSelectionDialog = {
        title = "작업 선택",
        subtitle = "무엇을 하시겠습니까?",
        options = {
            shop = {
                title = "상점 열기",
                description = "자판기에서 상품을 둘러보고 구매하세요"
            },
            manageBoss = {
                title = "상점 관리",
                description = "재고 관리, 분석 보기, 자판기 제어"
            },
            manageEmployee = {
                title = "상점 관리",
                description = "자판기에 재고 상품 추가 및 관리"
            }
        }
    },
}