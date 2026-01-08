-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["vi"] = {
    
    WashHands = {
        title = "Bồn rửa",
        no_available = "Không có bồn rửa nào",
        success = "Tay bạn đã sạch sẽ!",
        error = "Lỗi",
        fail = "Tay bạn đã sạch rồi!",
        targetfail = "Bạn cần rửa tay trước!",
        item_cleaned = "Vật phẩm đã được làm sạch thành công!",
        missing_required = "Thiếu vật phẩm yêu cầu"
    },

    Terminal = {
        SubmitText = "Gửi Hóa Đơn",

        -- Player Selection Tab
        select_player = "Chọn Người Chơi",
        nearby_players = "Người Chơi Gần Đó",
        search_players = "Tìm kiếm người chơi...",
        no_players_found = "Không tìm thấy người chơi gần đó",
        loading_players = "Đang tải người chơi...",
        player_selected = "Đã chọn người chơi",

        -- Menu Items Tab
        menu_items = "Mục Menu",
        items_added = "Đã thêm mục",
        search_menu_items = "Tìm kiếm mục menu...",
        available_items = "Mục Có Sẵn",
        selected_items = "Mục Đã Chọn",
        no_items_found = "Không tìm thấy mục",
        no_items_selected = "Chưa chọn mục nào",
        total_items = "Tổng Số Mục",
        total = "Tổng",
        all = "Tất Cả",

        -- Finalize Bill Tab
        finalize_bill = "Hoàn Tất Hóa Đơn",
        customer_info = "Thông Tin Khách Hàng",
        order_summary = "Tóm Tắt Đơn Hàng",
        amount_label = "Số Tiền ($)",
        enter_amount = "Nhập số tiền",
        reason_label = "Lý Do (Tùy Chọn)",
        reason_placeholder = "Nhập lý do hóa đơn",
        payment_method = "Phương Thức Thanh Toán",
        cash = "Tiền Mặt",
        bank = "Ngân Hàng",
        send_bill = "Gửi Hóa Đơn",

        -- Commission
        your_commission = "Hoa hồng của bạn",
        commission_rate = "Tỷ lệ hoa hồng",

        -- Bills sent counter
        bills_sent = "Hóa đơn đã gửi:",
        commission = "Hoa hồng:",

        -- Error Messages
        bill_error = "Lỗi Hóa Đơn",
        select_player_error = "Vui lòng chọn người chơi",
        invalid_amount_error = "Vui lòng nhập số tiền hợp lệ",

        -- Success Messages
        bill_sent_success = "Hóa đơn đã gửi thành công!",
        bill_sent_title = "Hóa Đơn Đã Gửi",
    },

    Consumable = {
        Drinking = "Đang uống ", -- Drinking ItemName
        Eating = "Đang ăn " -- Eating ItemName
    },

    Garage = {
        title = "Gara",
        no_vehicle = "Không có xe để trả",
        not_job_vehicle = "Đây không phải xe của Burgershot!",
        parked_title = "Xe đã đỗ!",
        parked_message = "Xe của bạn đã được đỗ tại vị trí này!",
        in_vehicle = "Bạn không thể ở trong xe!",
        too_far = "Quá xa xe!",
        spawn_error = "Không thể làm điều đó ngay bây giờ!",

        -- UI Text
        garage_title = "Gara",
        garage_active_vehicles = "Hoạt Động",
        garage_manage = "Quản Lý Xe Hoạt Động",
        close = "Đóng",
        search_vehicles = "Tìm kiếm xe...",
        no_vehicles_found = "Không tìm thấy xe",
        dont_have_vehicle = "Bạn không có xe nào trong gara này.",
        select_vehicle = "Chọn Xe",
        select_vehicle_message = "Chọn một xe từ danh sách để xem chi tiết và lấy xe.",
        back = "Quay Lại",
        spawn_vehicle = "Lấy Xe",
        return_button = "Trả Xe",
        return_vehicle = "Trả Xe",
        license_plate = "Biển Số",

        -- Status Messages
        vehicle_spawned = "Xe đã được lấy thành công",
        no_vehicle_to_return = "Không có xe để trả",
        access_denied = "Bạn không có quyền truy cập gara này.",
        all_spawn_points_blocked = "Tất cả điểm lấy xe đang bị chặn, vui lòng đợi.",
        vehicle_model_not_exist = "Mẫu xe không tồn tại",
        failed_load_model = "Không thể tải mẫu xe",
        failed_create_vehicle = "Không thể tạo xe",
        invalid_vehicle_data = "Dữ liệu mẫu xe không hợp lệ",

        -- Error Messages
        error = "Lỗi",
        garage_error = "Lỗi Gara",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "Không thể tạo thực thể xe",
        no_spawn_points_available = "Không có điểm lấy xe khả dụng",
        vehicle_returned_parked = "Xe đã được trả và đỗ lại.",
        vehicle_processed_remote = "Xe đã được xử lý (Trả từ xa).",
    },

    Billing = {
        title = "Thanh Toán",
        payment_failed_byreceiver = "Thanh toán thất bại: %s không đủ tiền để trả %s.",
        business_closed = "Thanh toán hiện đang bị tắt bởi quản lý.",
        commission_earned = "Hoa Hồng Đã Nhận",
        commission_earned_description = "Bạn đã nhận được $%s tiền hoa hồng.",
        terminal_title = "Máy Thanh Toán",
        off_duty_error = "Bạn phải đang làm việc để sử dụng máy thanh toán.",
        access_denied = "Bạn không có quyền truy cập máy thanh toán.",
        payment_received = "Đã Nhận Thanh Toán",
        payment_received_message = "Đã nhận thanh toán $%s từ %s",
        payment_failed = "Thanh Toán Thất Bại",
        payment_failed_message = "Thanh toán hóa đơn thất bại",
        bill_sent = "Hóa Đơn Đã Gửi",
        bill_sent_success = "Hóa đơn đã gửi thành công!",
        bill_sent_error = "Gửi hóa đơn thất bại.",
        bill_error = "Lỗi Hóa Đơn",
        invalid_bill = "Hóa Đơn Không Hợp Lệ!",
        invalid_bill_description = "Hóa đơn bạn đang cố thanh toán không tồn tại.",
        invalid_target_amount = "Mục tiêu hoặc số tiền không hợp lệ!",
        player_not_found = "Không tìm thấy người chơi!",
        must_be_on_duty = "Bạn phải đang làm việc để gửi hóa đơn!",
        bill_sent_description = "Đã gửi hóa đơn $%s đến %s với lý do %s",
        bill_payment_successful = "✅ Thanh toán hóa đơn thành công",
        bill_payment_failed_insufficient = "❌ Thanh toán hóa đơn thất bại - Không đủ tiền",
        bill_rejected = "❌ Hóa đơn bị từ chối",
        insufficient_funds = "%s không đủ tiền!",
        order_processed = "🍔 Đơn Hàng Đã Xử Lý",
        command_access_denied = "Bạn không thể sử dụng lệnh này!",
        payment_failed_insufficient = "%s không đủ tiền!",
        bill_rejected_title = "Hóa Đơn Bị Từ Chối",

        bill_rejected_sender = "%s đã từ chối hóa đơn $%s của bạn",
        bill_rejected_receiver = "Bạn đã từ chối hóa đơn từ %s",
        billing_disabled = "Thanh toán hiện đang bị tắt bởi quản lý.",
        billing_off_duty = "Bạn phải đang làm việc để sử dụng thanh toán.",
    },

    Delivery = {
        items_header = "Vật Phẩm Giao Hàng",
        reward_header = "Phần Thưởng",
        accept_header = "Chấp Nhận Giao Hàng",
        decline_header = "Từ Chối Giao Hàng",
        menu_header = "Menu Giao Hàng",
        no_delivery = "Không có đơn giao hàng nào!",
        new_delivery_title = "Giao Hàng Mới",
        new_delivery_desc = "Bạn đã nhận được yêu cầu giao hàng mới.",
        delivery_expired = "Yêu cầu giao hàng của bạn đã hết hạn.",
        delivery_timeout = "Bạn không kịp hoàn thành giao hàng.",
        delivery_declined = "Bạn đã từ chối yêu cầu giao hàng.",
        check_location = "Kiểm tra GPS để biết địa điểm giao hàng.",
        check_location_error = "Không có đơn giao hàng nào để theo dõi.",
        delivery_accepted = "Đã Chấp Nhận Giao Hàng",
        invalid_item = "Vật phẩm giao hàng không hợp lệ",
        delivery_failed = "Giao Hàng Thất Bại",
        invalid_items_data = "Dữ liệu vật phẩm không hợp lệ",

        -- UI Text
        delivery_title = "Giao Hàng",
        close_menu = "Đóng Menu",
        new_order = "Đơn Hàng Mới",
        in_progress = "Đang Thực Hiện",
        order_items = "Vật Phẩm Đơn Hàng:",
        payment = "Thanh Toán",
        delivery_status = "Trạng Thái Giao Hàng",
        deliver_instruction = "Giao thức ăn đến địa điểm được đánh dấu trên bản đồ.",
        time_remaining = "Thời Gian Còn Lại:",
        order_summary = "Tóm Tắt Đơn Hàng:",
        accept = "Chấp Nhận",
        decline = "Từ Chối",
        cancel_delivery = "Hủy Giao Hàng",

        -- Notifications
        delivery_accepted_notification = "Giao hàng đã được chấp nhận thành công",
        delivery_cancelled_notification = "Giao hàng đã bị hủy thành công",

        -- Status Messages
        complete_delivery = "Hoàn Thành Giao Hàng",
        delivery_in_progress = "Đang giao hàng...",
        head_to_location = "Đi đến địa điểm được đánh dấu để hoàn thành giao hàng",
    },

    Consumption = {
        title = "Tiêu Thụ",
        description = "Tươi ngon!",
        refresh_title = "Sảng Khoái",
        refresh_description = "Bạn cảm thấy sảng khoái",
    },

    Crafting = {
        craft_title = "Chế Tạo %s",
        enter_amount_description = "Nhập số lượng cần chế tạo",
        crafting_successful = "Chế Tạo Thành Công",
        crafted_description = "Đã chế tạo %d x %s",
        crafting_cancelled = "Chế Tạo Bị Hủy",
        cancelled_description = "Bạn đã hủy chế tạo",
        no_space = "Không đủ chỗ trong túi đồ",
    },

    Targets = {
        door = "Gõ Cửa",
        door_icon = "fas fa-door-open",
        delivery_food = "Giao Thức Ăn",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "Máy Tính Bảng Đặt Hàng",
        ordering_tablet_error = "Chức năng máy tính bảng đặt hàng không khả dụng.",
        order_management_tablet = "Máy Tính Bảng Quản Lý Đơn Hàng",
        order_management_error = "Chức năng máy tính bảng quản lý đơn hàng không khả dụng.",
        return_utensils = "Trả Dụng Cụ",
        employee_vending = "Máy Bán Hàng Nhân Viên",
    },

    Order = {
        complete = "Đơn Hàng Hoàn Tất",
        description = "Đơn hàng của bạn đã được xử lý. Hóa đơn đã được thêm vào túi đồ của bạn.",
        paycheck_suspended_description = "Lương bị tạm ngưng khi cửa hàng đóng cửa.",
        paycheck_suspended = "Lương Bị Tạm Ngưng",
    },

    Door = {
        title = "Cửa ",
        description = "Cửa ",
        locked = "Cửa đang khóa",
        no_permissions = "Không có quyền khóa/mở khóa cửa này",
        access_denied_title = "Truy Cập Bị Từ Chối",
        access_granted = "Bạn đã mở khóa cửa",
        access_denied = "Bạn không có quyền truy cập cửa này",
    },

    Outfits = {
        title = "Trang Phục",
        invalid = "Giới tính không hợp lệ",
        failed_equip = "Không thể mặc trang phục",
        disabled = "Trang phục bị vô hiệu hóa",
        civilian_clothes = "Đổi Sang Đồ Thường Dân",
        reset_civilian_clothes = "Đã đổi lại đồ thường dân",
        no_civilian_saved = "Không có đồ thường dân được lưu. Hãy đổi sang đồng phục trước.",
        no_permission = "Bạn không có quyền sử dụng trang phục này",
        outfit_not_found = "Không tìm thấy trang phục",
        equip_success = "Đã mặc trang phục thành công",
        changed_to_uniform = "Đã đổi sang %s",
        reset_success = "Đã đặt lại trang phục thành công",
        no_civilian_for_reset = "Không có đồ thường dân được lưu. Hãy đổi sang đồng phục và lưu trang phục trước.",
    },

    System = {
        success = "Thành Công",
        paycheck_error = "Lỗi Lương",
        inventory_full = "Túi Đồ Đầy",
        inventory_full_description = "Túi đồ của bạn đã đầy.",
        society_not_found = "Không tìm thấy doanh nghiệp",
        business_funds_insufficient = "Doanh nghiệp không đủ tiền để trả lương.",
        error = "Lỗi",
        invalid = "Không Hợp Lệ",
        no_license = "Không thể xác định giấy phép của bạn. Vui lòng liên hệ quản trị viên.",
        missing_items = "Thiếu Vật Phẩm",
        item_cleaned = "Vật phẩm đã được làm sạch thành công",
        missing_required = "Thiếu vật phẩm yêu cầu",
        slot_error = "Đặt số lượng vào cùng một ô",
        ice_collected = "Đã lấy đá",
        refreshing = "Đang làm mới",
        refreshed = "Đã làm mới",
        consumption = "Tiêu Thụ",
        stress_increased = "Căng Thẳng Tăng",
        stress_amount = "Mức độ căng thẳng của bạn đã tăng %s",
        inventory_full = "Túi đồ của bạn đã đầy",
    },

    Experience = {
        gained_title = "Kinh Nghiệm Nhận Được",
        experience_earned_description = "Bạn đã nhận được %d XP.",
        gained_message = "Bạn đã nhận được %d XP khi hoàn thành giao hàng!",
    },

    BossMenu = {
        title = "Menu Quản Lý",
        unable_jobdetermine = "Không thể xác định công việc của bạn. Vui lòng thử lại sau.",
        bankruptcy_alert = "⚠️ Cảnh Báo Phá Sản",
        description = "Không thể trả lương! Số dư doanh nghiệp: $%s, Cần: $%s",
        trans_failed_bossmenubalance = "Giao Dịch Thất Bại - Quỹ Doanh Nghiệp Không Đủ",
        menu_in_use = "Menu quản lý đang được sử dụng bởi %s.",
        no_permissions = "Bạn không có quyền quản lý! Bạn cần phải là Quản Lý.",
        wrong_job = "Bạn không có công việc phù hợp",
        grade_updated = "Cập Nhật Cấp Bậc",
        grade_update_success = "Cấp bậc %s đã được cập nhật thành công.",
        menu_update = "Cập Nhật Menu",
        menu_update_success = "Mục menu đã được cập nhật thành công!",
        vending_update = "Máy Bán Hàng",
        vending_update_success = "Vật phẩm máy bán hàng đã được cập nhật thành công!",
        menu_update_error = "Không thể cập nhật mục menu!",
        menu_delete = "Xóa Menu",
        menu_delete_success = "Mục menu đã được xóa thành công!",
        menu_delete_error = "Không thể xóa mục menu!",
        invite_sent = "Đã Gửi Lời Mời",
        invite_sent_success = "Lời mời làm việc đã gửi đến %s",
        invite_error = "ID người chơi hoặc vai trò không hợp lệ!",
        player_not_found = "Không tìm thấy người chơi!",
        job_error = "Dữ liệu lời mời không hợp lệ!",
        job_accepted = "Bạn bây giờ là %s tại %s",
        job_updated_title = "Cập Nhật Công Việc",
        job_updated = "Vị trí của bạn đã được cập nhật thành %s tại %s",
        database_error = "Công việc của bạn đã được thiết lập nhưng cập nhật cơ sở dữ liệu thất bại.",
        invite_rejected = "Bạn đã từ chối lời mời làm việc.",
        withdraw_error = "Số tiền không hợp lệ!",
        business_error = "Không tìm thấy doanh nghiệp!",
        insufficient_funds = "Quỹ doanh nghiệp không đủ!",
        money_withdrawn = "Bạn đã rút $%s từ tài khoản doanh nghiệp.",
        transaction_failed = "Không thể cập nhật tài khoản doanh nghiệp!",
        money_deposited = "Bạn đã gửi $%s vào tài khoản doanh nghiệp.",
        transaction_failed_refund = "Không thể cập nhật tài khoản doanh nghiệp! Tiền của bạn đã được hoàn lại.",
        shop_purchase = "Mua Hàng Mới",
        shop_purchase_notification = "%s đã mua vật phẩm trị giá $%s",
        menu_occupied = "Menu quản lý đang bận",
        menu_occupied_by = "%s hiện đang sử dụng menu quản lý. Vui lòng thử lại sau.",
        menu_released = "Menu quản lý hiện đã có sẵn",

        -- Main Headers and Titles
        business_overview = "Tổng Quan Doanh Nghiệp",
        business_settings = "Cài Đặt Doanh Nghiệp",
        menu_management = "Quản Lý Menu",
        staff_management = "Quản Lý Nhân Viên",
        employee_leaderboard = "Bảng Xếp Hạng Nhân Viên",
        sales_transactions = "Doanh Số & Giao Dịch",

        -- Finance Section
        finance = "Tài Chính",
        business_balance = "Số Dư Doanh Nghiệp",
        withdraw = "Rút Tiền",
        deposit = "Gửi Tiền",
        withdraw_money = "Rút Tiền",
        deposit_money = "Gửi Tiền",
        enter_amount_withdraw = "Nhập số tiền bạn muốn rút từ tài khoản doanh nghiệp vào %s của bạn.",
        enter_amount_deposit = "Nhập số tiền bạn muốn gửi từ %s của bạn vào tài khoản doanh nghiệp.",
        available = "Khả Dụng",
        enter_amount = "Nhập số tiền",
        withdraw_to = "Rút về %s",
        deposit_from = "Gửi từ %s",
        updating = "Đang cập nhật...",
        update_avatar = "Cập Nhật Avatar",
        cancel = "Hủy",
        cash = "Tiền Mặt",
        bank = "Ngân Hàng",
        invalid_url = "URL Không Hợp Lệ",
        invalid_url_message = "Vui lòng nhập URL hình ảnh hợp lệ",
        avatar_updated = "Avatar Đã Cập Nhật",
        avatar_updated_message = "Avatar đã được cập nhật thành công!",
        update_failed = "Cập Nhật Thất Bại",
        update_failed_message = "Không thể cập nhật avatar",
        business_status = "Trạng Thái Doanh Nghiệp",
        business_status_desc = "Kiểm soát trạng thái hoạt động của doanh nghiệp bạn",
        business_operations = "Hoạt Động Kinh Doanh",
        business_open = "Hiện đang mở cửa - Thanh toán được bật",
        business_closed = "Hiện đang đóng cửa - Thanh toán bị tắt",
        business_status_updated = "Trạng Thái Doanh Nghiệp",
        business_now_open = "Doanh nghiệp hiện đang mở cửa",
        business_now_closed = "Doanh nghiệp hiện đang đóng cửa",
        business_status_error = "Lỗi",
        business_status_failed = "Không thể cập nhật trạng thái doanh nghiệp",

        -- Employees Section
        employees = "Nhân Viên",
        invite_new_employee = "Mời Nhân Viên Mới",
        player_id = "ID Người Chơi...",
        invite = "Mời",
        select_role = "Chọn Vai Trò",
        choose_role_for = "Chọn vai trò cho %s",
        available_roles = "Vai Trò Có Sẵn:",
        roles_available = "%d vai trò có sẵn",
        send_invite = "Gửi Lời Mời",

        -- Sales Summary
        sales_summary = "Tóm Tắt Doanh Số",
        today = "Hôm Nay",
        this_week = "Tuần Này",
        this_month = "Tháng Này",
        view_sales = "Xem Doanh Số",

        -- Inventory Status
        inventory_status = "Trạng Thái Kho",
        storage_capacity = "Dung Lượng Kho",
        ingredients = "Nguyên Liệu",
        supplies = "Vật Tư",
        manage_inventory = "Quản Lý Kho",

        -- Menu Management
        search_menu_items = "Tìm kiếm mục menu...",
        edit_menu_item = "Chỉnh Sửa Mục Menu",
        update_item_details = "Cập nhật chi tiết mục bên dưới.",
        label_display_name = "Nhãn (Tên Hiển Thị)",
        price = "Giá ($)",
        category = "Danh Mục",
        select_category = "Chọn danh mục",
        update = "Cập Nhật",
        all_items = "Tất Cả Mục",
        no_menu_items = "Không tìm thấy mục menu",
        no_category_items = "Không tìm thấy %s",

        -- Vending Machine Management
        vending_machine_management = "Quản Lý Máy Bán Hàng",
        search_vending_items = "Tìm kiếm vật phẩm máy bán hàng...",
        edit_vending_item = "Chỉnh Sửa Vật Phẩm Máy Bán Hàng",
        update_vending_details = "Cập nhật chi tiết vật phẩm bên dưới.",
        all_vending_items = "Tất Cả Vật Phẩm",
        no_vending_items = "Không tìm thấy vật phẩm máy bán hàng",
        no_category_vending_items = "Không tìm thấy %s",
        vending_update_error = "Không thể cập nhật vật phẩm máy bán hàng",
        item_price = "Giá",
        item_type = "Loại",
        uncategorized = "Chưa Phân Loại",
        enter_price = "ví dụ: 5",

        -- Staff Management
        employee_overview = "Tổng Quan Nhân Viên",
        total_employees = "Tổng Số Nhân Viên",
        active_employees = "Nhân Viên Hoạt Động",
        pending_applications = "Đơn Ứng Tuyển Đang Chờ",
        employee_list = "Danh Sách Nhân Viên",
        search_employees = "Tìm kiếm nhân viên...",
        all_employees = "Tất Cả Nhân Viên",
        name = "Tên",
        role = "Vai Trò",
        salary = "Lương",
        last_seen = "Lần Cuối Thấy",
        actions = "Hành Động",
        promote = "Thăng Chức",
        demote = "Giáng Chức",
        fire = "Sa Thải",
        employee_actions = "Hành Động Nhân Viên",
        select_action = "Chọn hành động cho %s",
        promote_employee = "Thăng Chức Nhân Viên",
        demote_employee = "Giáng Chức Nhân Viên",
        fire_employee = "Sa Thải Nhân Viên",
        confirm_action = "Xác Nhận Hành Động",
        confirm_promote = "Bạn có chắc muốn thăng chức %s lên %s?",
        confirm_demote = "Bạn có chắc muốn giáng chức %s xuống %s?",
        confirm_fire = "Bạn có chắc muốn sa thải %s?",
        action_success = "Hành động hoàn tất thành công",
        action_failed = "Hành động thất bại",
        employee_promoted = "Nhân viên đã được thăng chức thành công",
        employee_demoted = "Nhân viên đã bị giáng chức thành công",
        employee_fired = "Nhân viên đã bị sa thải thành công",
        no_employees = "Không tìm thấy nhân viên",

            -- Job Grades Management Dialog
        manage_job_grades = "Quản Lý Cấp Bậc Công Việc",
        configure_salary_commission = "Cấu hình lương và tỷ lệ hoa hồng cho từng vị trí",
        search_job_grades = "Tìm kiếm cấp bậc công việc...",
        edit_job_grade = "Chỉnh Sửa Cấp Bậc Công Việc",
        update_job_grade_details = "Cập nhật chi tiết cấp bậc công việc",
        job_title = "Chức Danh",
        commission_rate = "Tỷ Lệ Hoa Hồng",
        boss_access = "Quyền Truy Cập Quản Lý",
        boss_access_enabled = "Vai trò này có quyền truy cập các tính năng quản lý",
        boss_access_disabled = "Vai trò này có quyền truy cập cấp nhân viên",
        save_changes = "Lưu Thay Đổi",
        boss_role = "Vai Trò Quản Lý",
        grade_update_error = "Không thể cập nhật cấp bậc công việc",

        -- Employee Details View
        employee_overview = "Chi Tiết Nhân Viên",
        employee_profile = "Hồ Sơ Nhân Viên",
        performance_stats = "Chỉ Số Hiệu Suất",
        back = "Quay Lại",
        
        -- Employee Profile Card Labels
        commission = "Hoa Hồng",
        total_earnings = "Tổng Thu Nhập",
        available_balance = "Số Dư Khả Dụng",
        employee_id = "ID Nhân Viên",
        
        -- Performance Stats Labels
        deliveries_label = "Giao Hàng",
        billings_label = "Hóa Đơn",
        earnings_label = "Thu Nhập",
        experience_label = "Kinh Nghiệm",
        level_label = "Cấp Độ",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "Phân Phối Thu Nhập",
        delivery_income = "Giao Hàng",
        commission_income = "Hoa Hồng",
        paycheck_income = "Lương",
        completed_label = "hoàn thành",
        bills_label = "hóa đơn",
        hourly_label = "Mỗi Giờ",

        -- Employee Card Labels (for list view)
        rank_label = "Cấp Bậc",
        commission_label = "Hoa Hồng",

        -- Role Change Dialog
        no_role_employees = "Không tìm thấy %s",
        employee_updated = "Nhân Viên Đã Cập Nhật",
        employee_commission_updated = "Nhân viên được cập nhật với tỷ lệ hoa hồng %s",
        fire_employee_error = "Không thể sa thải nhân viên",

        -- Employee Leaderboard
        top_performers = "Nhân Viên Xuất Sắc",
        this_month_leaders = "Dẫn Đầu Tháng Này",
        rank = "Xếp Hạng",
        employee = "Nhân Viên",
        performance = "Hiệu Suất",
        orders_completed = "Đơn Hàng Hoàn Thành",
        revenue_generated = "Doanh Thu Tạo Ra",
        customer_rating = "Đánh Giá Khách Hàng",
        no_data = "Không có dữ liệu hiệu suất",

        -- Transactions
        transaction_history = "Lịch Sử Giao Dịch",
        recent_transactions = "Giao Dịch Gần Đây",
        paycheck_history = "Lịch Sử Lương",
        transaction_type = "Loại Giao Dịch",
        amount = "Số Tiền",
        date = "Ngày",
        message = "Mô Tả",
        customer = "Khách Hàng",
        filter_transactions = "Lọc giao dịch...",
        all_transactions = "Tất Cả Giao Dịch",
        sales_only = "Chỉ Bán Hàng",
        paychecks_only = "Chỉ Lương",
        no_transactions = "Không tìm thấy giao dịch",
        no_paychecks = "Không tìm thấy bản ghi lương",


        -- Settings
        avatar_settings = "Cài Đặt Avatar",
        update_profile_picture = "Cập nhật ảnh đại diện",
        image_url = "URL Hình Ảnh",
        enter_url_preview = "Nhập URL bên dưới để xem trước avatar của bạn",
        preview = "Xem Trước",
        enter_url_message = "Nhập URL hình ảnh avatar của bạn",
        ui_theme = "Giao Diện UI",
        customize_appearance = "Tùy chỉnh giao diện bảng điều khiển",
        light_mode = "Chế Độ Sáng",
        dark_mode = "Chế Độ Tối",

        -- Navigation
        home = "Trang Chủ",
        staff = "Nhân Viên",
        menu = "Menu",
        sales = "Doanh Số",
        top = "Xếp Hạng",
        settings = "Cài Đặt",

        -- Status Labels
        open = "Mở Cửa",
        closed = "Đóng Cửa",
        online = "Trực Tuyến",
        offline = "Ngoại Tuyến",
        active = "Hoạt Động",
        inactive = "Không Hoạt Động",

        -- Common Actions
        save = "Lưu",
        edit = "Sửa",
        delete = "Xóa",
        confirm = "Xác Nhận",
        close = "Đóng",
        refresh = "Làm Mới",
        loading = "Đang tải...",

        -- Error Messages
        error_occurred = "Đã xảy ra lỗi",
        invalid_input = "Dữ liệu không hợp lệ",
        operation_failed = "Thao tác thất bại",
        permission_denied = "Quyền bị từ chối",
        network_error = "Lỗi mạng",
        data_load_failed = "Không thể tải dữ liệu",

        -- Success Messages
        operation_successful = "Thao tác hoàn tất thành công",
        data_saved = "Dữ liệu đã được lưu thành công",
        changes_applied = "Thay đổi đã được áp dụng thành công",
    },

    Shop = {
        shop_status = "Trạng Thái Cửa Hàng",
        shop_open = "Cửa Hàng Đang Mở",
        shop_closed = "Cửa Hàng Đang Đóng",
        access_denied = "Bạn không thể truy cập cửa hàng này!",
        purchase_title = "Cửa Hàng",
        purchase_success = "Mua hàng hoàn tất! Vật phẩm đã được thêm vào túi đồ của bạn.",
        purchase_error = "Thanh toán thất bại!",

        -- Search and Inventory
        search_placeholder = "Tìm kiếm sản phẩm theo tên...",
        clear_search = "Xóa tìm kiếm",
        shop_inventory = "Kho Cửa Hàng",
        items_count = "vật phẩm",

        -- Product Actions
        add_to_cart = "Thêm",
        per_item = "mỗi món",

        -- Cart
        your_cart = "Giỏ Hàng Của Bạn",
        cart_empty = "Giỏ Hàng Trống",
        cart_empty_message = "Thêm vật phẩm để bắt đầu mua sắm",
        items_label = "vật phẩm",
        total = "Tổng",

        -- Search Results
        no_items_found = "Không tìm thấy vật phẩm",
        no_items_message = "Hãy thử điều chỉnh tìm kiếm hoặc duyệt tất cả vật phẩm",

        -- Payment
        pay_with_cash = "Tiền Mặt",
        pay_with_bank = "Ngân Hàng",
        processing = "Đang xử lý...",
        inventory_notice = "Vật phẩm sẽ được thêm trực tiếp vào túi đồ của bạn",

        -- Notifications
        cart_updated = "Giỏ Hàng Đã Cập Nhật",
        item_added = "Đã Thêm Vật Phẩm",
        item_removed = "Đã Xóa Vật Phẩm",
        quantity_updated = "Số Lượng Đã Cập Nhật",
        purchase_complete = "Mua Hàng Hoàn Tất",
        transaction_failed = "Giao Dịch Thất Bại",
        checkout_error = "Lỗi Thanh Toán",
        cart_empty_error = "Giỏ hàng của bạn đang trống",
        paid_with_cash = "Đã thanh toán bằng tiền mặt",
        charged_to_bank = "Đã trừ vào tài khoản ngân hàng",
        not_enough_cash = "Không đủ tiền mặt",
        insufficient_bank = "Số dư ngân hàng không đủ",

        -- Quantity Messages
        added_more = "Đã thêm %d %s",
        removed_items = "Đã xóa %d %s",
        added_to_cart = "%s đã thêm vào giỏ hàng",
        removed_from_cart = "Đã xóa %s khỏi giỏ hàng của bạn",

        -- Loading
        loading_shop = "Đang tải Menu Cửa Hàng...",
    },

    EmployeeMenu = {
        access_denied = "Bạn không thể truy cập cổng thông tin này!",
        commission_withdrawn = "Hoa Hồng Đã Rút",
        commission_withdrawn_description = "Bạn đã rút $%s từ số dư hoa hồng vào %s của bạn.",
        transaction_failed = "Giao Dịch Thất Bại",
        fire_employee = "Sa Thải Nhân Viên",
        fire_employee_description = "%s đã bị sa thải khỏi doanh nghiệp của bạn!",
        employeeMent_notice = "Thông Báo Nhân Viên",
        
        no_employee_active = "Hiện không có nhân viên nào trực tuyến để xử lý đơn hàng của bạn.",
        -- Main Headers and Navigation
        employee_portal = "Cổng Thông Tin Nhân Viên",
        employee_profile = "Hồ Sơ Nhân Viên",
        performance_stats = "Thống Kê Hiệu Suất",
        employee_leaderboard = "Bảng Xếp Hạng Nhân Viên",
        job_outfits = "Đồng Phục Công Việc",
        account_settings = "Cài Đặt Tài Khoản",

        -- Navigation Labels
        profile = "Hồ Sơ",
        stats = "Thống Kê",
        top = "Xếp Hạng",
        outfits = "Trang Phục",
        settings = "Cài Đặt",

        -- Profile Tab
        personal_information = "Thông Tin Cá Nhân",
        paycheck_information = "Thông Tin Lương",
        job_role = "Vai Trò Công Việc",
        salary = "Lương",
        experience = "Kinh Nghiệm",
        duty_status = "Trạng Thái Làm Việc",
        on_duty = "Đang Làm",
        off_duty = "Nghỉ Làm",
        clock_in = "Vào Ca",
        clock_out = "Tan Ca",
        available_balance = "Số Dư Khả Dụng",
        withdraw = "Rút Tiền",
        withdraw_funds = "Rút Quỹ",
        paycheck_interval = "Kỳ Lương",
        total_deliveries = "Tổng Số Giao Hàng",
        bills_created = "Hóa Đơn Đã Tạo",
        total_earnings = "Tổng Thu Nhập",
        minutes = "phút",

        -- Performance Tab
        career_statistics = "Thống Kê Sự Nghiệp",
        experience_points = "Kinh Nghiệm",
        xp_points = "Điểm XP",
        total_earned = "Tổng Đã Kiếm",
        current_balance = "Số Dư Hiện Tại",
        deliveries = "Giao Hàng",
        total_completed = "Tổng Hoàn Thành",
        billings = "Hóa Đơn",
        invoices_created = "Hóa Đơn Đã Tạo",
        job_grade_progression = "Tiến Độ Cấp Bậc Công Việc",
        current_grade = "Cấp Bậc Hiện Tại",
        level = "Cấp Độ",
        xp_needed_promotion = "XP cần để thăng chức",
        earn_more_xp = "Kiếm thêm %d XP để được thăng chức lên %s",
        max_grade_reached = "Bạn đã đạt cấp bậc tự động cao nhất! Thăng chức thêm cần sự chấp thuận của quản lý.",
        promotions_by_management = "Thăng chức được chỉ định bởi quản lý.",
        loading_experience_data = "Đang tải dữ liệu hệ thống kinh nghiệm...",
        loading_progression_data = "Đang tải dữ liệu tiến độ...",

        -- Leaderboard Tab
        top_performers = "Nhân Viên Xuất Sắc",
        this_month_leaders = "Dẫn Đầu Tháng Này",
        rank = "Xếp Hạng",
        employee = "Nhân Viên",
        performance = "Hiệu Suất",
        no_leaderboard_data = "Không có dữ liệu bảng xếp hạng",

        -- Outfits Tab
        work_outfits = "Đồng Phục Công Việc",
        select_outfit = "Chọn Trang Phục",
        change_outfit = "Đổi Trang Phục",
        outfit_changed = "Trang Phục Đã Đổi",
        outfit_changed_success = "Trang phục của bạn đã được đổi thành công!",
        outfit_change_failed = "Đổi trang phục thất bại",
        outfit_preview = "Xem Trước Trang Phục",

        -- Settings Tab
        employee_settings = "Cài Đặt Nhân Viên",
        avatar_settings = "Cài Đặt Avatar",
        update_profile_picture = "Cập nhật ảnh đại diện",
        image_url = "URL Hình Ảnh",
        enter_url_preview = "Nhập URL bên dưới để xem trước avatar của bạn",
        preview = "Xem Trước",
        enter_url_message = "Nhập URL hình ảnh avatar của bạn",
        avatar_updated = "Avatar Đã Cập Nhật",
        avatar_created = "Avatar Đã Tạo",
        avatar_updated_message = "Avatar đã được cập nhật thành công!",
        update_failed = "Cập Nhật Thất Bại",
        update_failed_message = "Không thể cập nhật avatar",
        invalid_url = "URL Không Hợp Lệ",
        invalid_url_message = "Vui lòng nhập URL hình ảnh hợp lệ",
        updating = "Đang cập nhật...",
        update_avatar = "Cập Nhật Avatar",

        -- UI Theme
        ui_theme = "Giao Diện UI",
        customize_appearance = "Tùy chỉnh giao diện bảng điều khiển",
        light_mode = "Chế Độ Sáng",
        dark_mode = "Chế Độ Tối",

        -- Notifications
        notifications = "Thông Báo",
        manage_notification_preferences = "Quản lý tùy chọn thông báo",
        employee_notifications = "Thông Báo Nhân Viên",
        notifications_enabled_desc = "Bạn sẽ nhận được tất cả cập nhật lương nhân viên",
        notifications_disabled_desc = "Bạn sẽ không nhận được thông báo",
        notifications_updated = "Thông Báo Đã Cập Nhật",
        notifications_enabled_message = "Thông báo lương hiện đã được bật",
        notifications_disabled_message = "Thông báo lương hiện đã bị tắt",
        enabled = "Đã Bật",
        disabled = "Đã Tắt",

        -- Withdrawal Dialog
        withdraw_all_funds = "Rút Tất Cả Tiền",
        select_balance_type = "Chọn Loại Số Dư",
        all_balance = "Tất Cả Số Dư",
        delivery_balance = "Số Dư Giao Hàng",
        commission_balance = "Số Dư Hoa Hồng",
        paycheck_balance = "Số Dư Lương",
        available_balance_type = "Số dư %s khả dụng: $%d",
        enter_amount = "Nhập số tiền",
        insufficient_funds = "Không Đủ Tiền",
        insufficient_balance = "Số dư %s không đủ",
        funds_withdrawn = "Đã Rút Tiền",
        funds_withdrawn_success = "Đã rút thành công $%d từ số dư của bạn",
        transaction_failed = "Giao Dịch Thất Bại",
        withdrawal_failed = "Rút tiền thất bại",
        invalid_amount = "Số Tiền Không Hợp Lệ",
        invalid_amount_message = "Vui lòng nhập số tiền hợp lệ",
        no_funds = "Không Có Tiền",
        no_funds_message = "Bạn không có tiền để rút",

        -- Common Actions
        cancel = "Hủy",
        save = "Lưu",
        update = "Cập Nhật",
        confirm = "Xác Nhận",
        close = "Đóng",
        loading = "Đang tải...",

        -- Status Labels
        active = "Hoạt Động",
        inactive = "Không Hoạt Động",
        online = "Trực Tuyến",
        offline = "Ngoại Tuyến",

        -- Error Messages
        error_occurred = "Đã xảy ra lỗi",
        operation_failed = "Thao tác thất bại",
        data_load_failed = "Không thể tải dữ liệu",
        network_error = "Lỗi mạng",
        employee_data_error = "Không thể lấy dữ liệu nhân viên của bạn.",
        identity_error = "Không thể xác minh danh tính của bạn.",
        withdraw_invalid_amount = "Số tiền không hợp lệ!",
        insufficient_commission = "Số dư hoa hồng không đủ!",
        transaction_failed_update = "Không thể cập nhật số dư hoa hồng!",
        fire_employee_not_found = "Không tìm thấy nhân viên!",
        fire_employee_wrong_business = "Nhân viên này không làm việc cho doanh nghiệp của bạn!",
        fire_employee_db_error = "Không thể sa thải nhân viên khỏi cơ sở dữ liệu!",
        employment_notice_fired = "Bạn đã bị sa thải khỏi %s",
        avatar_invalid_url = "URL hình ảnh không hợp lệ.",
        avatar_updated_success = "Avatar hồ sơ của bạn đã được cập nhật thành công.",
        avatar_no_changes = "Không có thay đổi nào được thực hiện đối với avatar của bạn.",
        avatar_created = "Hồ sơ nhân viên và avatar của bạn đã được tạo.",
        avatar_create_failed = "Không thể tạo hồ sơ nhân viên.",
        withdrawal_invalid_amount = "Số tiền rút không hợp lệ.",
        employee_record_not_found_withdraw = "Không tìm thấy hồ sơ nhân viên.",
        insufficient_balance_withdraw = "Không đủ tiền trong số dư của bạn.",
        withdraw_balance_failed = "Rút tiền từ số dư thất bại. Vui lòng thử lại.",
        identity_error_toggle = "Không thể xác minh danh tính của bạn",
        invalid_grade_data = "Dữ liệu cấp bậc không hợp lệ.",
        grade_id_not_found = "Không tìm thấy ID cấp bậc cho vai trò này.",
        no_grade_changes = "Không có thay đổi nào đối với cấp bậc công việc.",
        balance_withdrawn = "Bạn đã rút $%d từ số dư %s vào %s của bạn.",
        player_not_found = "Không tìm thấy người chơi!",
        invalid_purchase_data = "Dữ liệu mua hàng không hợp lệ!",
        insufficient_funds = "Không đủ tiền trong %s của bạn!",
        inventory_full = "Không đủ chỗ trong túi đồ hoặc vượt quá giới hạn trọng lượng!",
        purchase_complete = "Mua hàng hoàn tất! Vật phẩm đã được thêm vào túi đồ của bạn.",
        shop_purchase = "Mua Hàng Cửa Hàng: %s",
        business_balance_error = "Lỗi cập nhật số dư doanh nghiệp cho %s",
        business_balance_success = "Đã thêm thành công $%s vào tài khoản doanh nghiệp",
        transaction_record_error = "Lỗi ghi lại giao dịch mua hàng cửa hàng",
        avatar_found = "Cửa Hàng: Tìm thấy avatar cho %s: %s",
        avatar_not_found = "Cửa Hàng: Không tìm thấy avatar cho %s, sử dụng mặc định",
    },

    Vending = {
        invalid_item_data = "Dữ liệu vật phẩm không hợp lệ.",
        insufficient_item = "Bạn không có đủ vật phẩm này.",
        item_added_with_money = "Vật phẩm đã thêm vào kho. Nhận $%s cho %sx %s",
        item_added = "Vật phẩm đã thêm vào kho.",
        business_balance_error = "Lỗi cập nhật số dư doanh nghiệp cho đơn hàng",
        database_error = "Lỗi Cơ Sở Dữ Liệu",
        add_item_failed = "Không thể thêm vật phẩm.",
        invalid_collection_data = "Dữ liệu thu thập không hợp lệ.",
        inventory_full = "Không thể thêm vật phẩm vào túi đồ của bạn.",
        item_collected = "Đã thu thập %sx %s",
        stock_update_failed = "Không thể cập nhật kho máy bán hàng.",
        out_of_stock = "Hết Hàng",
        insufficient_stock = "Không đủ vật phẩm để thu thập.",
        sale_transaction_error = "Lỗi ghi lại giao dịch bán hàng máy bán hàng",
        collection_transaction_error = "Lỗi ghi lại giao dịch thu thập máy bán hàng",
    },

    JobSystem = {
        no_permission = "Bạn không có quyền sử dụng lệnh này.",
        player_not_found = "Không tìm thấy người chơi.",
        job_assigned = "Đã phân công công việc.",
        job_assign_failed = "Không thể phân công công việc.",
        job_removed = "Đã xóa công việc.",
        job_remove_failed = "Không thể xóa công việc.",
        job_changed_notification = "Công Việc Đã Thay Đổi",
        job_changed = "Công việc của bạn đã được thay đổi thành %s (cấp bậc %s).",
        job_removed_notification = "Công việc của bạn đã bị xóa.",
        give_job_usage = "Sử dụng: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "Sử dụng: /%s [playerId]",
        job_info = "Công Việc: %s (Cấp Bậc: %s, Trực: %s)",
        job_info_error = "Không thể lấy thông tin công việc của bạn.",
        duty_status = "Bạn hiện đang %s làm việc.",
        not_on_duty = "Không Làm Việc",
        must_be_on_duty = "Bạn phải đang làm việc để nhận lương.",
        paycheck_title = "Lương",
        employer_insufficient_funds = "Ông chủ của bạn không đủ tiền để trả cho bạn.",
        paycheck_added = "Lương $%s đã được thêm vào số dư nhân viên cho %s đối với công việc: %s",
        paycheck_received = "Bạn đã nhận được lương $%s từ %s",
    },

    BillingInviteNotification = {
        message = "Bạn đã nhận được một yêu cầu thanh toán.",

        -- Titles / headers
        title = "Yêu Cầu Thanh Toán",
        label = "Thông Báo Thanh Toán",

        -- Button labels
        pay_button = "Thanh Toán Hóa Đơn",
        decline_button = "Từ Chối",

        -- Small UI labels used inside the notification component
        business_label = "Doanh Nghiệp",
        total_amount_label = "Tổng Số Tiền",
        reason_label = "Lý Do",
        amount_label = "Số Tiền:",

        -- Warning / helper texts
        warning_text = "Thanh toán sẽ được trừ vào tài khoản của bạn. Đảm bảo đủ số dư.",
        expires_text = "Hết hạn trong %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "Bạn đã được mời tham gia với vai trò %s tại Burgershot. Bạn có chấp nhận không?",

        -- Titles / headers
        title = "Lời Mời Làm Việc",
        label = "Thông Báo Lời Mời Làm Việc",

        -- Button labels
        accept_button = "Chấp Nhận",
        reject_button = "Từ Chối",

        -- Small UI labels used inside the notification component
        company_label = "Công Ty",
        grade_label = "Cấp Bậc",
        invites_left_label = "Lời Mời Còn Lại",
        salary_label = "Lương",

        -- Warning / helper texts
        warning_text = "Chấp nhận công việc này sẽ cam kết bạn với vai trò đó. Hãy chắc chắn rằng bạn đã sẵn sàng bắt đầu.",
        expires_text = "Hết hạn trong %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "Menu Nhà Hàng",
        onduty = "Bạn cần phải đang làm việc để truy cập menu nhà hàng.",
    },

    Duty = {
        status = "Trạng Thái Làm Việc",
        management = "Quản Lý Làm Việc",
        description = "Bạn hiện đang %s làm việc.",
        restaurant_area = "Khu Vực Nhà Hàng",
        clock_in = "Bạn đã vào khu vực nhà hàng. Sử dụng menu nhân viên để vào ca.",
        enter_workplace = "Bạn đã vào nơi làm việc và hiện đang làm việc.",
        leave_workplace = "Bạn đã rời khỏi nơi làm việc và hiện đang nghỉ làm.",
        inside_workplace = "Bạn đang ở trong nơi làm việc - tự động đặt thành đang làm việc.",
        outside_workplace = "Bạn đang ở ngoài nơi làm việc - tự động đặt thành nghỉ làm.",
        duty_warning = "Cảnh Báo Làm Việc",
        auto_off_duty = "Bạn sẽ tự động được đặt thành nghỉ làm khi ra khỏi nhà hàng.",
        no_permission_manage_duty = "Bạn không có quyền quản lý trạng thái làm việc của nhân viên",
        not_employee_of_job = "Người chơi không phải là nhân viên của công việc này",
        duty_set_by_management = "Trạng thái làm việc của bạn đã được đặt thành %s bởi quản lý",
        duty_management_success = "Đã đặt thành công trạng thái làm việc của %s thành %s",
        updated_offline_employee = "Đã cập nhật trạng thái làm việc của nhân viên ngoại tuyến",
    },

    Paycheck = {
        title = "Đã Nhận Lương",
        message = "Bạn đã nhận được lương $%s từ %s",
    },

    VendingMachine = {
        sell_item = "Bán Vật Phẩm",
        select_item_from_inventory = "Chọn Vật Phẩm từ Túi Đồ",
        add_to_vending = "THÊM %s VÀO MÁY BÁN HÀNG",
        cancel = "HỦY",
        no_matching_items = "Không có vật phẩm phù hợp trong túi đồ",
        stocked_items = "Vật Phẩm Trong Kho",
        sell = "Bán",
        no_stock = "Hết Hàng",
        items = "vật phẩm trong kho",
        ready_to_serve = "Sẵn Sàng Phục Vụ!",
    },

    EmployeeVendingMachine = {
        title = "Lấy từ Máy Bán Hàng",
        label = "Lấy vật phẩm từ kho máy bán hàng",
        collect = "Lấy",
        cancel = "Hủy",
        quantity_available = "Số Lượng (Có Sẵn: %s)",
        collect_item = "Lấy %s",
        collect_button = "Lấy",
        in_stock = "Trong Kho",
        vending_machine_empty = "Máy bán hàng này đang trống.",
    },

    OrderingTab = {
        where_eating_today = "Hôm nay bạn muốn ăn ở đâu?",
        eat_in = "Ăn Tại Chỗ",
        take_out = "Mang Về",
        whats_up = "có chuyện gì vậy?",
        popular = "Phổ Biến",
        done = "Xong",
        my_order = "Đơn Hàng Của Tôi",
        empty = "Trống",
        total = "Tổng",
        checkout = "Thanh Toán",
        back = "Quay Lại",
        no_menu_items = "Không có mục menu nào cho %s",
        loading = "Đang tải...",
        eat_in_label = "Ăn Tại Chỗ",
        take_out_label = "Mang Về",
        pay_cash = "Tiền Mặt",
        cancel = "Hủy",
        order = "Đặt Hàng",
        pay_bank = "Ngân Hàng",
        all_items = "Tất Cả Vật Phẩm",
        bank_only_disclaimer = "Chỉ có thể thanh toán qua ngân hàng.",
    },

    OrderManagementTable = {
        title = "Bảng Quản Lý Đơn Hàng",
        label = "Quản Trị Đơn Hàng",
        filter_all = "Tất Cả",
        filter_cooking = "Đang Nấu",
        filter_ready = "Sẵn Sàng",
        filter_completed = "Hoàn Thành",
        filter_terminal_orders = "Đơn Hàng Tại Chỗ",
        filter_self_pickup = "Đơn Hàng Kiosk",
        sort_by = "Sắp Xếp Theo",
        sort_day = "Ngày",
        sort_amount = "Số Tiền",
        sort_name = "Tên",
        no_orders = "Không có đơn hàng nào khớp với bộ lọc hiện tại.",
        accept = "CHẤP NHẬN",
        accepting = "ĐANG CHẤP NHẬN...",
        cooking = "ĐANG NẤU",
        ready = "SẴN SÀNG",
        complete = "HOÀN THÀNH",
        completed = "ĐÃ HOÀN THÀNH",
        assigned_to = "Đã giao cho: ",
        items_label = "Vật Phẩm:",
        order_label = "Đơn Hàng #",
        status_cooking = "đang nấu",
        status_ready = "sẵn sàng",
        status_completed = "hoàn thành",
        status_cancelled = "đã hủy",
        self_pickup = "Tự Lấy",
    },

    MenuSelectionDialog = {
        title = "Chọn Hành Động",
        subtitle = "Bạn muốn làm gì?",
        options = {
            shop = {
                title = "Mở Cửa Hàng",
                description = "Duyệt và mua hàng từ máy bán hàng tự động"
            },
            manageBoss = {
                title = "Quản Lý Cửa Hàng",
                description = "Quản lý hàng tồn kho, xem phân tích và kiểm soát máy bán hàng tự động"
            },
            manageEmployee = {
                title = "Quản Lý Cửa Hàng",
                description = "Thêm và quản lý các mặt hàng tồn kho trong máy bán hàng tự động"
            }
        }
    },
}