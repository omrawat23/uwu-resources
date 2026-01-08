-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["ar"] = {
    
    WashHands = {
        title = "حوض",
        no_available = "لا يوجد حوض متاح",
        success = "يديك نظيفتان الآن!",
        error = "خطأ",
        fail = "يديك نظيفتان بالفعل!",
        targetfail = "تحتاج لغسل يديك أولاً!",
        item_cleaned = "تم تنظيف العنصر بنجاح!",
        missing_required = "عنصر مطلوب مفقود"
    },

    Terminal = {
        SubmitText = "إرسال الفاتورة",

        -- Player Selection Tab
        select_player = "اختر لاعب",
        nearby_players = "لاعبون قريبون",
        search_players = "بحث عن لاعبين...",
        no_players_found = "لم يتم العثور على لاعبين قريبين",
        loading_players = "جاري تحميل اللاعبين...",
        player_selected = "تم اختيار اللاعب",

        -- Menu Items Tab
        menu_items = "عناصر القائمة",
        items_added = "تمت إضافة العناصر",
        search_menu_items = "بحث عن عناصر القائمة...",
        available_items = "العناصر المتاحة",
        selected_items = "العناصر المختارة",
        no_items_found = "لم يتم العثور على عناصر",
        no_items_selected = "لم يتم اختيار عناصر",
        total_items = "إجمالي العناصر",
        total = "الإجمالي",
        all = "الكل",

        -- Finalize Bill Tab
        finalize_bill = "إنهاء الفاتورة",
        customer_info = "معلومات العميل",
        order_summary = "ملخص الطلب",
        amount_label = "المبلغ ($)",
        enter_amount = "أدخل المبلغ",
        reason_label = "السبب (اختياري)",
        reason_placeholder = "أدخل سبب الفاتورة",
        payment_method = "طريقة الدفع",
        cash = "نقد",
        bank = "بنك",
        send_bill = "إرسال الفاتورة",

        -- Commission
        your_commission = "عمولتك",
        commission_rate = "نسبة العمولة",

        -- Bills sent counter
        bills_sent = "الفواتير المرسلة:",
        commission = "العمولة:",

        -- Error Messages
        bill_error = "خطأ في الفاتورة",
        select_player_error = "يرجى اختيار لاعب",
        invalid_amount_error = "يرجى إدخال مبلغ صحيح",

        -- Success Messages
        bill_sent_success = "تم إرسال الفاتورة بنجاح!",
        bill_sent_title = "إرسال الفاتورة",
    },

    Consumable = {
        Drinking = "شرب ", -- Drinking ItemName
        Eating = "أكل " -- Eating ItemName
    },

    Garage = {
        title = "كراج",
        no_vehicle = "لا توجد مركبة للإعادة",
        not_job_vehicle = "هذه ليست مركبة Burgershot!",
        parked_title = "تم ركن المركبة!",
        parked_message = "تم ركن مركبتك في هذا الموقع!",
        in_vehicle = "لا يمكنك أن تكون داخل المركبة!",
        too_far = "أنت بعيد جداً عن المركبة!",
        spawn_error = "لا يمكنك فعل ذلك الآن!",

        -- UI Text
        garage_title = "الكراج",
        garage_active_vehicles = "نشط",
        garage_manage = "إدارة المركبات النشطة",
        close = "إغلاق",
        search_vehicles = "بحث عن مركبات...",
        no_vehicles_found = "لم يتم العثور على مركبات",
        dont_have_vehicle = "ليس لديك أي مركبات مخزنة في هذا الكراج.",
        select_vehicle = "اختر مركبة",
        select_vehicle_message = "اختر مركبة من القائمة لعرض التفاصيل واستخراجها.",
        back = "رجوع",
        spawn_vehicle = "استخراج المركبة",
        return_button = "إعادة",
        return_vehicle = "إعادة المركبة",
        license_plate = "لوحة الترخيص",

        -- Status Messages
        vehicle_spawned = "تم استخراج المركبة بنجاح",
        no_vehicle_to_return = "لا توجد مركبة للإعادة",
        access_denied = "لا يمكنك الوصول لهذا الكراج.",
        all_spawn_points_blocked = "جميع نقاط الاستخراج محجوبة حالياً، يرجى الانتظار.",
        vehicle_model_not_exist = "موديل المركبة غير موجود",
        failed_load_model = "فشل تحميل موديل المركبة",
        failed_create_vehicle = "فشل إنشاء المركبة",
        invalid_vehicle_data = "بيانات موديل المركبة غير صالحة",

        -- Error Messages
        error = "خطأ",
        garage_error = "خطأ في الكراج",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "فشل إنشاء كيان المركبة",
        no_spawn_points_available = "لا توجد نقاط استخراج متاحة",
        vehicle_returned_parked = "تمت إعادة مركبتك وركنها.",
        vehicle_processed_remote = "تمت معالجة مركبتك (إعادة عن بعد).",
    },

    Billing = {
        title = "الفواتير",
        payment_failed_byreceiver = "فشل الدفع: %s لا يملك أموالاً كافية للدفع لـ %s.",
        business_closed = "الفواتير معطلة حالياً من قبل الإدارة.",
        commission_earned = "تم كسب عمولة",
        commission_earned_description = "لقد كسبت $%s كعمولة.",
        terminal_title = "محطة الفواتير",
        off_duty_error = "يجب أن تكون في الخدمة لاستخدام محطة الفواتير.",
        access_denied = "لا يمكنك الوصول لمحطة الفواتير.",
        payment_received = "تم استلام الدفعة",
        payment_received_message = "تم استلام دفعة بقيمة $%s من %s",
        payment_failed = "فشل الدفع",
        payment_failed_message = "فشل دفع الفاتورة",
        bill_sent = "تم إرسال الفاتورة",
        bill_sent_success = "تم إرسال الفاتورة بنجاح!",
        bill_sent_error = "فشل إرسال الفاتورة.",
        bill_error = "خطأ في الفاتورة",
        invalid_bill = "فاتورة غير صالحة!",
        invalid_bill_description = "الفاتورة التي تحاول دفعها غير موجودة.",
        invalid_target_amount = "هدف أو مبلغ غير صالح!",
        player_not_found = "اللاعب غير موجود!",
        must_be_on_duty = "يجب أن تكون في الخدمة لإرسال فاتورة!",
        bill_sent_description = "أرسلت فاتورة بقيمة $%s إلى %s لـ %s",
        bill_payment_successful = "✅ تم دفع الفاتورة بنجاح",
        bill_payment_failed_insufficient = "❌ فشل دفع الفاتورة - رصيد غير كاف",
        bill_rejected = "❌ تم رفض الفاتورة",
        insufficient_funds = "%s ليس لديه ما يكفي!",
        order_processed = "🍔 تم معالجة الطلب",
        command_access_denied = "لا يمكنك استخدام هذا الأمر!",
        payment_failed_insufficient = "%s ليس لديه ما يكفي!",
        bill_rejected_title = "رفض الفاتورة",

        bill_rejected_sender = "%s رفض فاتورتك بقيمة $%s",
        bill_rejected_receiver = "رفضت الفاتورة من %s",
        billing_disabled = "الفواتير معطلة حالياً من قبل الإدارة.",
        billing_off_duty = "يجب أن تكون في الخدمة لاستخدام الفواتير.",
    },

    Delivery = {
        items_header = "عناصر التوصيل",
        reward_header = "المكافأة",
        accept_header = "قبول التوصيل",
        decline_header = "رفض التوصيل",
        menu_header = "قائمة التوصيل",
        no_delivery = "لا يوجد توصيل نشط!",
        new_delivery_title = "توصيل جديد",
        new_delivery_desc = "لقد تلقيت طلب توصيل جديد.",
        delivery_expired = "لقد انتهت صلاحية طلب التوصيل الخاص بك.",
        delivery_timeout = "لم تقم بالتوصيل في الوقت المحدد.",
        delivery_declined = "لقد رفضت طلب التوصيل.",
        check_location = "تحقق من موقع التوصيل على GPS.",
        check_location_error = "لا يوجد توصيل نشط لتتبعه.",
        delivery_accepted = "تم قبول التوصيل",
        invalid_item = "عنصر غير صالح للتوصيل",
        delivery_failed = "فشل التوصيل",
        invalid_items_data = "بيانات عناصر غير صالحة",

        -- UI Text
        delivery_title = "التوصيل",
        close_menu = "إغلاق القائمة",
        new_order = "طلب جديد",
        in_progress = "قيد التنفيذ",
        order_items = "عناصر الطلب:",
        payment = "الدفع",
        delivery_status = "حالة التوصيل",
        deliver_instruction = "قم بتوصيل الطعام إلى الموقع المحدد على الخريطة.",
        time_remaining = "الوقت المتبقي:",
        order_summary = "ملخص الطلب:",
        accept = "قبول",
        decline = "رفض",
        cancel_delivery = "إلغاء التوصيل",

        -- Notifications
        delivery_accepted_notification = "تم قبول التوصيل بنجاح",
        delivery_cancelled_notification = "تم إلغاء التوصيل بنجاح",

        -- Status Messages
        complete_delivery = "إكمال التوصيل",
        delivery_in_progress = "التوصيل قيد التنفيذ...",
        head_to_location = "تجه إلى الموقع المحدد لإكمال التوصيل",
    },

    Consumption = {
        title = "استهلاك",
        description = "طازج ولذيذ!",
        refresh_title = "إنعاش",
        refresh_description = "شعور بالانتعاش",
    },

    Crafting = {
        craft_title = "صناعة %s",
        enter_amount_description = "أدخل كمية للصناعة",
        crafting_successful = "تمت الصناعة بنجاح",
        crafted_description = "تمت صناعة %d x %s",
        crafting_cancelled = "تم إلغاء الصناعة",
        cancelled_description = "لقد ألغيت الصناعة",
        no_space = "لا توجد مساحة في المخزون",
    },

    Targets = {
        door = "طرق الباب",
        door_icon = "fas fa-door-open",
        delivery_food = "توصيل الطعام",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "جهاز الطلب اللوحي",
        ordering_tablet_error = "ميزة جهاز الطلب اللوحي غير متوفرة.",
        order_management_tablet = "جهاز إدارة الطلبات",
        order_management_error = "ميزة جهاز إدارة الطلبات غير متوفرة.",
        return_utensils = "إرجاع الأواني",
        employee_vending = "آلة بيع الموظفين",
    },

    Order = {
        complete = "اكتمل الطلب",
        description = "تمت معالجة طلبك. تمت إضافة الفاتورة إلى مخزونك.",
        paycheck_suspended_description = "سيتم تعليق الرواتب أثناء إغلاق العمل.",
        paycheck_suspended = "تم تعليق الراتب",
    },

    Door = {
        title = "باب ",
        description = "الباب هو ",
        locked = "الباب مغلق",
        no_permissions = "ليس لديك صلاحيات لفتح/قفل هذا الباب",
        access_denied_title = "تم رفض الوصول",
        access_granted = "تم فتح الباب",
        access_denied = "لا يمكنك الوصول لهذا الباب",
    },

    Outfits = {
        title = "الأزياء",
        invalid = "جنس غير صالح",
        failed_equip = "فشل ارتداء الزي",
        disabled = "الأزياء معطلة",
        civilian_clothes = "تغيير لملابس مدنية",
        reset_civilian_clothes = "العودة للملابس المدنية",
        no_civilian_saved = "لا توجد ملابس مدنية محفوظة. غير للزي الرسمي أولاً.",
        no_permission = "ليس لديك إذن لاستخدام هذا الزي",
        outfit_not_found = "الزي غير موجود",
        equip_success = "تم ارتداء الزي بنجاح",
        changed_to_uniform = "تم التغيير إلى %s",
        reset_success = "تم إعادة تعيين الزي بنجاح",
        no_civilian_for_reset = "لا توجد ملابس مدنية محفوظة. غير للزي الرسمي واحفظ ملابسك أولاً.",
    },

    System = {
        success = "نجاح",
        paycheck_error = "خطأ في الراتب",
        inventory_full = "المخزون ممتلئ",
        inventory_full_description = "مخزونك ممتلئ.",
        society_not_found = "العمل التجاري غير موجود",
        business_funds_insufficient = "العمل التجاري لا يملك أموالاً كافية لدفع الرواتب.",
        error = "خطأ",
        invalid = "غير صالح",
        no_license = "لم نتمكن من تحديد رخصتك. اتصل بالمسؤول.",
        missing_items = "عناصر مفقودة",
        item_cleaned = "تم تنظيف العنصر بنجاح",
        missing_required = "عنصر مطلوب مفقود",
        slot_error = "ضع الكمية في نفس الخانة",
        ice_collected = "تم جمع الثلج",
        refreshing = "جاري الإنعاش",
        refreshed = "منتعش",
        consumption = "استهلاك",
        stress_increased = "ازداد التوتر",
        stress_amount = "زاد مستوى توترك بمقدار %s",
    },

    Experience = {
        gained_title = "اكتساب خبرة",
        experience_earned_description = "لقد كسبت %d XP.",
        gained_message = "لقد كسبت %d XP لإكمال التوصيل!",
    },

    BossMenu = {
        title = "قائمة المدير",
        unable_jobdetermine = "غير قادر على تحديد وظيفتك. يرجى المحاولة لاحقاً.",
        bankruptcy_alert = "⚠️ تنبيه إفلاس",
        description = "لا يمكن دفع الرواتب! رصيد العمل: $%s, المطلوب: $%s",
        trans_failed_bossmenubalance = "فشلت المعاملة - أموال العمل غير كافية",
        menu_in_use = "قائمة المدير قيد الاستخدام حالياً من قبل %s.",
        no_permissions = "ليس لديك صلاحيات المدير! يجب أن تكون المدير.",
        wrong_job = "ليس لديك الوظيفة الصحيحة",
        grade_updated = "تم تحديث الدرجة الوظيفية",
        grade_update_success = "تم تحديث درجة %s بنجاح.",
        menu_update = "تحديث القائمة",
        menu_update_success = "تم تحديث عنصر القائمة بنجاح!",
        vending_update = "آلة البيع",
        vending_update_success = "تم تحديث عنصر آلة البيع بنجاح!",
        menu_update_error = "فشل تحديث عنصر القائمة!",
        menu_delete = "حذف القائمة",
        menu_delete_success = "تم حذف عنصر القائمة بنجاح!",
        menu_delete_error = "فشل حذف عنصر القائمة!",
        invite_sent = "تم إرسال الدعوة",
        invite_sent_success = "تم إرسال دعوة عمل إلى %s",
        invite_error = "معرف لاعب أو دور غير صالح!",
        player_not_found = "اللاعب غير موجود!",
        job_error = "بيانات دعوة غير صالحة!",
        job_accepted = "أنت الآن %s في %s",
        job_updated_title = "تم تحديث الوظيفة",
        job_updated = "تم تحديث منصبك إلى %s في %s",
        database_error = "تم تعيين وظيفتك ولكن فشل تحديث قاعدة البيانات.",
        invite_rejected = "لقد رفضت دعوة العمل.",
        withdraw_error = "مبلغ غير صالح!",
        business_error = "العمل التجاري غير موجود!",
        insufficient_funds = "أموال العمل غير كافية!",
        money_withdrawn = "لقد سحبت $%s من حساب العمل.",
        transaction_failed = "فشل تحديث حساب العمل!",
        money_deposited = "لقد أودعت $%s في حساب العمل.",
        transaction_failed_refund = "فشل تحديث حساب العمل! تمت إعادة أموالك.",
        shop_purchase = "شراء متجر جديد",
        shop_purchase_notification = "%s اشترى عناصر بقيمة $%s",
        menu_occupied = "قائمة المدير قيد الاستخدام حالياً",
        menu_occupied_by = "%s يستخدم قائمة المدير حالياً. يرجى المحاولة لاحقاً.",
        menu_released = "قائمة المدير متاحة الآن",

        -- Main Headers and Titles
        business_overview = "نظرة عامة على العمل",
        business_settings = "إعدادات العمل",
        menu_management = "إدارة القائمة",
        staff_management = "إدارة الموظفين",
        employee_leaderboard = "لوحة صدارة الموظفين",
        sales_transactions = "المبيعات والمعاملات",

        -- Finance Section
        finance = "المالية",
        business_balance = "رصيد العمل",
        withdraw = "سحب",
        deposit = "إيداع",
        withdraw_money = "سحب الأموال",
        deposit_money = "إيداع الأموال",
        enter_amount_withdraw = "أدخل المبلغ الذي تريد سحبه من حساب العمل إلى %s الخاص بك.",
        enter_amount_deposit = "أدخل المبلغ الذي تريد إيداعه من %s الخاص بك إلى حساب العمل.",
        available = "متاح",
        enter_amount = "أدخل المبلغ",
        withdraw_to = "سحب إلى %s",
        deposit_from = "إيداع من %s",
        updating = "جاري التحديث...",
        update_avatar = "تحديث الصورة الرمزية",
        cancel = "إلغاء",
        cash = "نقد",
        bank = "بنك",
        invalid_url = "رابط غير صالح",
        invalid_url_message = "يرجى إدخال رابط صورة صالح",
        avatar_updated = "تم تحديث الصورة الرمزية",
        avatar_updated_message = "تم تحديث الصورة الرمزية بنجاح!",
        update_failed = "فشل التحديث",
        update_failed_message = "فشل تحديث الصورة الرمزية",
        business_status = "حالة العمل",
        business_status_desc = "التحكم في حالة تشغيل العمل",
        business_operations = "عمليات تجارية",
        business_open = "يقبل العملاء حالياً - الفواتير مفعلة",
        business_closed = "مغلق للعملاء حالياً - الفواتير معطلة",
        business_status_updated = "حالة العمل",
        business_now_open = "العمل مفتوح الآن",
        business_now_closed = "العمل مغلق الآن",
        business_status_error = "خطأ",
        business_status_failed = "فشل تحديث حالة العمل",

        -- Employees Section
        employees = "الموظفين",
        invite_new_employee = "دعوة موظف جديد",
        player_id = "معرف اللاعب...",
        invite = "دعوة",
        select_role = "اختر دوراً",
        choose_role_for = "اختر دوراً لـ %s",
        available_roles = "الأدوار المتاحة:",
        roles_available = "%d أدوار متاحة",
        send_invite = "إرسال دعوة",

        -- Sales Summary
        sales_summary = "ملخص المبيعات",
        today = "اليوم",
        this_week = "هذا الأسبوع",
        this_month = "هذا الشهر",
        view_sales = "عرض المبيعات",

        -- Inventory Status
        inventory_status = "حالة المخزون",
        storage_capacity = "سعة التخزين",
        ingredients = "المكونات",
        supplies = "الإمدادات",
        manage_inventory = "إدارة المخزون",

        -- Menu Management
        search_menu_items = "بحث عن عناصر القائمة...",
        edit_menu_item = "تعديل عنصر القائمة",
        update_item_details = "حدث تفاصيل العنصر أدناه.",
        label_display_name = "التسمية (اسم العرض)",
        price = "السعر ($)",
        category = "فئة",
        select_category = "اختر فئة",
        update = "تحديث",
        all_items = "كل العناصر",
        no_menu_items = "لم يتم العثور على عناصر القائمة",
        no_category_items = "لم يتم العثور على %s",

        -- Vending Machine Management
        vending_machine_management = "إدارة آلة البيع",
        search_vending_items = "بحث عن عناصر آلة البيع...",
        edit_vending_item = "تعديل عنصر آلة البيع",
        update_vending_details = "حدث تفاصيل العنصر أدناه.",
        all_vending_items = "كل العناصر",
        no_vending_items = "لم يتم العثور على عناصر آلة البيع",
        no_category_vending_items = "لم يتم العثور على %s",
        vending_update_error = "فشل تحديث عنصر آلة البيع",
        item_price = "السعر",
        item_type = "النوع",
        uncategorized = "غير مصنف",
        enter_price = "مثلاً، 5",

        -- Staff Management
        employee_overview = "نظرة عامة على الموظف",
        total_employees = "إجمالي الموظفين",
        active_employees = "الموظفين النشطين",
        pending_applications = "طلبات معلقة",
        employee_list = "قائمة الموظفين",
        search_employees = "بحث عن موظفين...",
        all_employees = "كل الموظفين",
        name = "الاسم",
        role = "الدور",
        salary = "الراتب",
        last_seen = "آخر ظهور",
        actions = "إجراءات",
        promote = "ترقية",
        demote = "تخفيض رتبة",
        fire = "طرد",
        employee_actions = "إجراءات الموظف",
        select_action = "اختر إجراء لـ %s",
        promote_employee = "ترقية الموظف",
        demote_employee = "تخفيض رتبة الموظف",
        fire_employee = "طرد الموظف",
        confirm_action = "تأكيد الإجراء",
        confirm_promote = "هل أنت متأكد أنك تريد ترقية %s إلى %s؟",
        confirm_demote = "هل أنت متأكد أنك تريد تخفيض رتبة %s إلى %s؟",
        confirm_fire = "هل أنت متأكد أنك تريد طرد %s؟",
        action_success = "تم الإجراء بنجاح",
        action_failed = "فشل الإجراء",
        employee_promoted = "تم ترقية الموظف بنجاح",
        employee_demoted = "تم تخفيض رتبة الموظف بنجاح",
        employee_fired = "تم طرد الموظف بنجاح",
        no_employees = "لم يتم العثور على موظفين",

            -- Job Grades Management Dialog
        manage_job_grades = "إدارة درجات الوظيفة",
        configure_salary_commission = "تكوين الراتب ونسب العمولة لكل منصب",
        search_job_grades = "بحث عن درجات الوظيفة...",
        edit_job_grade = "تعديل درجة الوظيفة",
        update_job_grade_details = "تحديث تفاصيل درجة الوظيفة",
        job_title = "المسمى الوظيفي",
        commission_rate = "نسبة العمولة",
        boss_access = "صلاحيات المدير",
        boss_access_enabled = "هذا الدور لديه وصول لميزات الإدارة",
        boss_access_disabled = "هذا الدور لديه وصول مستوى موظف",
        save_changes = "حفظ التغييرات",
        boss_role = "دور المدير",
        grade_update_error = "فشل تحديث درجة الوظيفة",

        -- Employee Details View
        employee_profile = "ملف الموظف",
        performance_stats = "مقاييس الأداء",
        back = "رجوع",
        
        -- Employee Profile Card Labels
        commission = "العمولة",
        total_earnings = "إجمالي الأرباح",
        available_balance = "الرصيد المتاح",
        employee_id = "معرف الموظف",
        
        -- Performance Stats Labels
        deliveries_label = "التوصيلات",
        billings_label = "الفواتير",
        earnings_label = "الأرباح",
        experience_label = "الخبرة",
        level_label = "المستوى",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "توزيع الدخل",
        delivery_income = "التوصيلات",
        commission_income = "العمولة",
        paycheck_income = "الرواتب",
        completed_label = "مكتمل",
        bills_label = "فواتير",
        hourly_label = "بالساعة",

        -- Employee Card Labels (for list view)
        rank_label = "الرتبة",
        commission_label = "العمولة",

        -- Role Change Dialog
        no_role_employees = "لم يتم العثور على %s",
        employee_updated = "تم تحديث الموظف",
        employee_commission_updated = "تم تحديث الموظف بنسبة عمولة %s",
        fire_employee_error = "فشل طرد الموظف",

        -- Employee Leaderboard
        top_performers = "أفضل المؤدين",
        this_month_leaders = "قادة هذا الشهر",
        rank = "المرتبة",
        employee = "الموظف",
        performance = "الأداء",
        orders_completed = "الطلبات المكتملة",
        revenue_generated = "الإيرادات المحققة",
        customer_rating = "تقييم العملاء",
        no_data = "لا تتوفر بيانات أداء",

        -- Transactions
        transaction_history = "سجل المعاملات",
        recent_transactions = "المعاملات الأخيرة",
        paycheck_history = "سجل الرواتب",
        transaction_type = "نوع المعاملة",
        amount = "المبلغ",
        date = "التاريخ",
        message = "الوصف",
        customer = "العميل",
        filter_transactions = "تصفية المعاملات...",
        all_transactions = "كل المعاملات",
        sales_only = "المبيعات فقط",
        paychecks_only = "الرواتب فقط",
        no_transactions = "لم يتم العثور على معاملات",
        no_paychecks = "لم يتم العثور على سجلات رواتب",


        -- Settings
        avatar_settings = "إعدادات الصورة الرمزية",
        update_profile_picture = "تحديث صورة ملفك الشخصي",
        image_url = "رابط الصورة",
        enter_url_preview = "أدخل رابطاً أدناه لمعاينة صورتك الرمزية",
        preview = "معاينة",
        enter_url_message = "أدخل رابط صورة الرمزية الخاصة بك",
        ui_theme = "سمة واجهة المستخدم",
        customize_appearance = "تخصيص مظهر لوحة التحكم",
        light_mode = "الوضع الفاتح",
        dark_mode = "الوضع الداكن",

        -- Navigation
        home = "الرئيسية",
        staff = "الموظفين",
        menu = "القائمة",
        sales = "المبيعات",
        top = "الأعلى",
        settings = "الإعدادات",

        -- Status Labels
        open = "مفتوح",
        closed = "مغلق",
        online = "متصل",
        offline = "غير متصل",
        active = "نشط",
        inactive = "غير نشط",

        -- Common Actions
        save = "حفظ",
        edit = "تعديل",
        delete = "حذف",
        confirm = "تأكيد",
        close = "إغلاق",
        refresh = "تحديث",
        loading = "جار التحميل...",

        -- Error Messages
        error_occurred = "حدث خطأ",
        invalid_input = "إدخال غير صالح",
        operation_failed = "فشلت العملية",
        permission_denied = "تم رفض الإذن",
        network_error = "خطأ في الشبكة",
        data_load_failed = "فشل تحميل البيانات",

        -- Success Messages
        operation_successful = "تمت العملية بنجاح",
        data_saved = "تم حفظ البيانات بنجاح",
        changes_applied = "تم تطبيق التغييرات بنجاح",
    },

    Shop = {
        shop_status = "حالة المتجر",
        shop_open = "المتجر مفتوح",
        shop_closed = "المتجر مغلق",
        access_denied = "لا يمكنك الوصول لهذا المتجر!",
        purchase_title = "المتجر",
        purchase_success = "اكتمل الشراء! تمت إضافة العناصر لمخزونك.",
        purchase_error = "فشل الدفع!",

        -- Search and Inventory
        search_placeholder = "بحث عن منتجات بالاسم...",
        clear_search = "مسح البحث",
        shop_inventory = "مخزون المتجر",
        items_count = "عناصر",

        -- Product Actions
        add_to_cart = "إضافة",
        per_item = "لكل/عنصر",

        -- Cart
        your_cart = "عربتك",
        cart_empty = "العربة فارغة",
        cart_empty_message = "أضف عناصر لبدء التسوق",
        items_label = "عناصر",
        total = "الإجمالي",

        -- Search Results
        no_items_found = "لم يتم العثور على عناصر",
        no_items_message = "حاول تعديل بحثك أو تصفح جميع العناصر",

        -- Payment
        pay_with_cash = "نقد",
        pay_with_bank = "بنك",
        processing = "جار المعالجة...",
        inventory_notice = "ستضاف العناصر مباشرة لمخزونك",

        -- Notifications
        cart_updated = "تم تحديث العربة",
        item_added = "تم إضافة عنصر",
        item_removed = "تم إزالة عنصر",
        quantity_updated = "تم تحديث الكمية",
        purchase_complete = "اكتمل الشراء",
        transaction_failed = "فشلت المعاملة",
        checkout_error = "خطأ في الدفع",
        cart_empty_error = "عربتك فارغة",
        paid_with_cash = "تم الدفع نقداً",
        charged_to_bank = "تم الخصم من حسابك البنكي",
        not_enough_cash = "نقد غير كاف",
        insufficient_bank = "رصيد البنك غير كاف",

        -- Quantity Messages
        added_more = "تم إضافة %d %s إضافية",
        removed_items = "تم إزالة %d %s",
        added_to_cart = "تم إضافة %s للعربة",
        removed_from_cart = "تم إزالة %s من عربتك",

        -- Loading
        loading_shop = "جار تحميل قائمة المتجر...",
    },

    EmployeeMenu = {
        access_denied = "لا يمكنك الوصول لهذه البوابة!",
        commission_withdrawn = "تم سحب العمولة",
        commission_withdrawn_description = "لقد سحبت $%s من رصيد عمولتك إلى %s الخاص بك.",
        transaction_failed = "فشلت المعاملة",
        fire_employee = "طرد الموظف",
        fire_employee_description = "تم طرد %s من عملك!",
        employeeMent_notice = "إشعار موظف",
        
        no_employee_active = "لا يوجد موظفون نشطون حالياً للتعامل مع طلبك.",
        -- Main Headers and Navigation
        employee_portal = "بوابة الموظف",
        employee_profile = "ملف الموظف",
        performance_stats = "إحصائيات الأداء",
        employee_leaderboard = "لوحة صدارة الموظفين",
        job_outfits = "أزياء العمل",
        account_settings = "إعدادات الحساب",

        -- Navigation Labels
        profile = "الملف الشخصي",
        stats = "الإحصائيات",
        top = "الأعلى",
        outfits = "الأزياء",
        settings = "الإعدادات",

        -- Profile Tab
        personal_information = "معلومات شخصية",
        paycheck_information = "معلومات الراتب",
        job_role = "الدور الوظيفي",
        salary = "الراتب",
        experience = "الخبرة",
        duty_status = "حالة الخدمة",
        on_duty = "في الخدمة",
        off_duty = "خارج الخدمة",
        clock_in = "تسجيل دخول",
        clock_out = "تسجيل خروج",
        available_balance = "الرصيد المتاح",
        withdraw = "سحب",
        withdraw_funds = "سحب الأموال",
        paycheck_interval = "فترة الراتب",
        total_deliveries = "إجمالي التوصيلات",
        bills_created = "الفواتير المنشأة",
        total_earnings = "إجمالي الأرباح",
        minutes = "دقيقة",

        -- Performance Tab
        career_statistics = "إحصائيات المهنة",
        experience_points = "الخبرة",
        xp_points = "نقاط XP",
        total_earned = "إجمالي المكتسب",
        current_balance = "الرصيد الحالي",
        deliveries = "التوصيلات",
        total_completed = "إجمالي المكتمل",
        billings = "الفواتير",
        invoices_created = "الفواتير المنشأة",
        job_grade_progression = "تقدم الدرجة الوظيفية",
        current_grade = "الدرجة الحالية",
        level = "المستوى",
        xp_needed_promotion = "XP المطلوبة للترقية",
        earn_more_xp = "اكسب %d XP إضافية للترقية إلى %s",
        max_grade_reached = "لقد وصلت لأعلى درجة تلقائية! الترقيات الإضافية تتطلب موافقة الإدارة.",
        promotions_by_management = "يتم تعيين الترقيات من قبل الإدارة.",
        loading_experience_data = "جار تحميل بيانات نظام الخبرة...",
        loading_progression_data = "جار تحميل بيانات التقدم...",

        -- Leaderboard Tab
        top_performers = "أفضل المؤدين",
        this_month_leaders = "قادة هذا الشهر",
        rank = "المرتبة",
        employee = "الموظف",
        performance = "الأداء",
        no_leaderboard_data = "لا تتوفر بيانات لوحة الصدارة",

        -- Outfits Tab
        work_outfits = "أزياء العمل",
        select_outfit = "اختر زياً",
        change_outfit = "تغيير الزي",
        outfit_changed = "تم تغيير الزي",
        outfit_changed_success = "تم تغيير زيك بنجاح!",
        outfit_change_failed = "فشل تغيير الزي",
        outfit_preview = "معاينة الزي",

        -- Settings Tab
        employee_settings = "إعدادات الموظف",
        avatar_settings = "إعدادات الصورة الرمزية",
        update_profile_picture = "تحديث صورة ملفك الشخصي",
        image_url = "رابط الصورة",
        enter_url_preview = "أدخل رابطاً أدناه لمعاينة صورتك الرمزية",
        preview = "معاينة",
        enter_url_message = "أدخل رابط صورة الرمزية الخاصة بك",
        avatar_updated = "تم تحديث الصورة الرمزية",
        avatar_created = "تم إنشاء الصورة الرمزية",
        avatar_updated_message = "تم تحديث الصورة الرمزية بنجاح!",
        update_failed = "فشل التحديث",
        update_failed_message = "فشل تحديث الصورة الرمزية",
        invalid_url = "رابط غير صالح",
        invalid_url_message = "يرجى إدخال رابط صورة صالح",
        updating = "جار التحديث...",
        update_avatar = "تحديث الصورة الرمزية",

        -- UI Theme
        ui_theme = "سمة واجهة المستخدم",
        customize_appearance = "تخصيص مظهر لوحة التحكم",
        light_mode = "الوضع الفاتح",
        dark_mode = "الوضع الداكن",

        -- Notifications
        notifications = "الإشعارات",
        manage_notification_preferences = "إدارة تفضيلات الإشعارات",
        employee_notifications = "إشعارات الموظف",
        notifications_enabled_desc = "سوف تتلقى جميع تحديثات رواتب الموظفين",
        notifications_disabled_desc = "لن تتلقى إشعارات",
        notifications_updated = "تم تحديث الإشعارات",
        notifications_enabled_message = "إشعارات الرواتب مفعلة الآن",
        notifications_disabled_message = "إشعارات الرواتب معطلة الآن",
        enabled = "مفعل",
        disabled = "معطل",

        -- Withdrawal Dialog
        withdraw_all_funds = "سحب جميع الأموال",
        select_balance_type = "اختر نوع الرصيد",
        all_balance = "كل الأرصدة",
        delivery_balance = "رصيد التوصيل",
        commission_balance = "رصيد العمولة",
        paycheck_balance = "رصيد الرواتب",
        available_balance_type = "رصيد %s المتاح: $%d",
        enter_amount = "أدخل المبلغ",
        insufficient_funds = "أموال غير كافية",
        insufficient_balance = "رصيد %s غير كاف",
        funds_withdrawn = "تم سحب الأموال",
        funds_withdrawn_success = "تم سحب $%d من رصيدك بنجاح",
        withdrawal_failed = "فشل سحب الأموال",
        invalid_amount = "مبلغ غير صالح",
        invalid_amount_message = "يرجى إدخال مبلغ صالح",
        no_funds = "لا توجد أموال",
        no_funds_message = "ليس لديك أي أموال لسحبها",

        -- Common Actions
        cancel = "إلغاء",
        save = "حفظ",
        update = "تحديث",
        confirm = "تأكيد",
        close = "إغلاق",
        loading = "جار التحميل...",

        -- Status Labels
        active = "نشط",
        inactive = "غير نشط",
        online = "متصل",
        offline = "غير متصل",

        -- Error Messages
        error_occurred = "حدث خطأ",
        operation_failed = "فشلت العملية",
        data_load_failed = "فشل تحميل البيانات",
        network_error = "خطأ في الشبكة",
        employee_data_error = "تعذر استرداد بيانات الموظف الخاصة بك.",
        identity_error = "تعذر التحقق من هويتك.",
        withdraw_invalid_amount = "مبلغ غير صالح!",
        insufficient_commission = "رصيد عمولة غير كاف!",
        transaction_failed_update = "فشل تحديث رصيد العمولة!",
        fire_employee_not_found = "الموظف غير موجود!",
        fire_employee_wrong_business = "هذا الموظف لا يعمل في عملك التجاري!",
        fire_employee_db_error = "فشل طرد الموظف من قاعدة البيانات!",
        employment_notice_fired = "لقد تم طردك من %s",
        avatar_invalid_url = "رابط صورة غير صالح.",
        avatar_updated_success = "تم تحديث الصورة الرمزية للملف الشخصي بنجاح.",
        avatar_no_changes = "لم يتم إجراء تغييرات على صورتك الرمزية.",
        avatar_created = "تم إنشاء ملف الموظف والصورة الرمزية.",
        avatar_create_failed = "فشل إنشاء سجل الموظف.",
        withdrawal_invalid_amount = "مبلغ سحب غير صالح.",
        employee_record_not_found_withdraw = "سجل الموظف غير موجود.",
        insufficient_balance_withdraw = "أموال غير كافية في رصيدك.",
        withdraw_balance_failed = "فشل السحب من الرصيد. يرجى المحاولة مرة أخرى.",
        identity_error_toggle = "تعذر التحقق من هويتك",
        invalid_grade_data = "بيانات درجة غير صالحة.",
        grade_id_not_found = "تعذر العثور على معرف الدرجة لهذا الدور.",
        no_grade_changes = "لم يتم إجراء تغييرات على الدرجة الوظيفية.",
        balance_withdrawn = "لقد سحبت $%d من رصيد %s الخاص بك إلى %s.",
        player_not_found = "اللاعب غير موجود!",
        invalid_purchase_data = "بيانات شراء غير صالحة!",
        insufficient_funds = "أموال غير كافية في %s الخاص بك!",
        inventory_full = "لا توجد مساحة تخزين كافية أو تم تجاوز حد الوزن!",
        purchase_complete = "اكتمل الشراء! تمت إضافة العناصر لمخزونك.",
        shop_purchase = "شراء المتجر: %s",
        business_balance_error = "خطأ في تحديث رصيد العمل لـ %s",
        business_balance_success = "تمت إضافة $%s بنجاح لحساب العمل",
        transaction_record_error = "خطأ في تسجيل المعاملة لشراء المتجر",
        avatar_found = "المتجر: تم العثور على صورة رمزية لـ %s: %s",
        avatar_not_found = "المتجر: لم يتم العثور على صورة رمزية لـ %s، استخدام الافتراضي",
    },

    Vending = {
        invalid_item_data = "بيانات عنصر غير صالحة.",
        insufficient_item = "ليس لديك ما يكفي من هذا العنصر.",
        item_added_with_money = "تمت إضافة العنصر للمخزون. تم استلام $%s مقابل %sx %s",
        item_added = "تمت إضافة العنصر للمخزون.",
        business_balance_error = "خطأ في تحديث رصيد العمل للطلب",
        database_error = "خطأ في قاعدة البيانات",
        add_item_failed = "فشل إضافة العنصر.",
        invalid_collection_data = "بيانات جمع غير صالحة.",
        inventory_full = "تعذر إضافة العنصر لمخزونك.",
        item_collected = "تم جمع %sx %s",
        stock_update_failed = "فشل تحديث مخزون آلة البيع.",
        out_of_stock = "نفذت الكمية",
        insufficient_stock = "عناصر غير كافية للجمع.",
        sale_transaction_error = "خطأ في تسجيل معاملة بيع آلة البيع",
        collection_transaction_error = "خطأ في تسجيل معاملة جمع آلة البيع",
    },

    JobSystem = {
        no_permission = "ليس لديك إذن لاستخدام هذا الأمر.",
        player_not_found = "اللاعب غير موجود.",
        job_assigned = "تم تعيين الوظيفة.",
        job_assign_failed = "فشل تعيين الوظيفة.",
        job_removed = "تم إزالة الوظيفة.",
        job_remove_failed = "فشل إزالة الوظيفة.",
        job_changed_notification = "تم تغيير الوظيفة",
        job_changed = "تم تغيير وظيفتك إلى %s (الدرجة %s).",
        job_removed_notification = "تم إزالة وظيفتك.",
        give_job_usage = "الاستخدام: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "الاستخدام: /%s [playerId]",
        job_info = "الوظيفة: %s (الدرجة: %s, الخدمة: %s)",
        job_info_error = "تعذر الحصول على معلومات وظيفتك.",
        duty_status = "أنت الآن %s خدمة.",
        not_on_duty = "لست في الخدمة",
        must_be_on_duty = "يجب أن تكون في الخدمة لاستلام الرواتب.",
        paycheck_title = "راتب",
        employer_insufficient_funds = "مديرك لا يملك أموالاً كافية لدفع راتبك.",
        paycheck_added = "تم إضافة راتب بقيمة $%s لرصيد الموظف لـ %s للوظيفة: %s",
        paycheck_received = "تلقيت راتباً بقيمة $%s من %s",
    },

    BillingInviteNotification = {
        message = "لقد تلقيت طلب دفع.",

        -- Titles / headers
        title = "طلب دفع",
        label = "إشعار الفاتورة",

        -- Button labels
        pay_button = "دفع الفاتورة",
        decline_button = "رفض",

        -- Small UI labels used inside the notification component
        business_label = "العمل",
        total_amount_label = "المبلغ الإجمالي",
        reason_label = "السبب",
        amount_label = "المبلغ:",

        -- Warning / helper texts
        warning_text = "سيتم خصم الدفعة من حسابك. تأكد من وجود أموال كافية.",
        expires_text = "ينتهي في %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "لقد تمت دعوتك للانضمام كـ %s في Burgershot. هل تقبل؟",

        -- Titles / headers
        title = "دعوة عمل",
        label = "إشعار دعوة عمل",

        -- Button labels
        accept_button = "قبول",
        reject_button = "رفض",

        -- Small UI labels used inside the notification component
        company_label = "الشركة",
        grade_label = "الدرجة",
        invites_left_label = "الدعوات المتبقية",
        salary_label = "الراتب",

        -- Warning / helper texts
        warning_text = "قبول هذه الوظيفة سيلزمك بالدور. تأكد أنك مستعد للبدء.",
        expires_text = "ينتهي في %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "قائمة المطعم",
        onduty = "تحتاج لأن تكون في الخدمة للوصول لقائمة المطعم.",
    },

    Duty = {
        status = "حالة الخدمة",
        management = "إدارة الخدمة",
        description = "أنت الآن %s خدمة.",
        restaurant_area = "منطقة المطعم",
        clock_in = "لقد دخلت منطقة المطعم. استخدم قائمة الموظف لتسجيل الدخول.",
        enter_workplace = "لقد دخلت مكان عملك وأصبحت الآن في الخدمة.",
        leave_workplace = "لقد غادرت مكان عملك وأصبحت الآن خارج الخدمة.",
        inside_workplace = "أنت داخل مكان عملك - تم تعيينك في الخدمة تلقائياً.",
        outside_workplace = "أنت خارج مكان عملك - تم تعيينك خارج الخدمة تلقائياً.",
        duty_warning = "تحذير الخدمة",
        auto_off_duty = "سيتم تعيينك خارج الخدمة تلقائياً عند التواجد خارج المطعم.",
        no_permission_manage_duty = "ليس لديك إذن لإدارة حالة خدمة الموظف",
        not_employee_of_job = "اللاعب ليس موظفاً في هذه الوظيفة",
        duty_set_by_management = "تم تعيين حالة خدمتك إلى %s من قبل الإدارة",
        duty_management_success = "تم تعيين حالة خدمة %s إلى %s بنجاح",
        updated_offline_employee = "تم تحديث حالة خدمة الموظف غير المتصل",
    },

    Paycheck = {
        title = "تم استلام الراتب",
        message = "تلقيت راتباً بقيمة $%s من %s",
    },

    VendingMachine = {
        sell_item = "بيع عنصر",
        select_item_from_inventory = "اختر عنصراً من المخزون",
        add_to_vending = "إضافة %s لآلة البيع",
        cancel = "إلغاء",
        no_matching_items = "لا توجد عناصر مطابقة في المخزون",
        stocked_items = "العناصر المخزنة",
        sell = "بيع",
        no_stock = "لا يوجد مخزون",
        items = "عناصر مخزنة",
        ready_to_serve = "جاهز للتقديم!",
    },

    EmployeeVendingMachine = {
        title = "جمع من آلة البيع",
        label = "جمع العناصر من مخزون آلة البيع",
        collect = "جمع",
        cancel = "إلغاء",
        quantity_available = "الكمية (متاحة: %s)",
        collect_item = "جمع %s",
        collect_button = "جمع",
        in_stock = "في المخزون",
        vending_machine_empty = "هذه آلة البيع فارغة.",
    },

    OrderingTab = {
        where_eating_today = "أين ستأكل اليوم؟",
        eat_in = "تناول في المطعم",
        take_out = "سفري",
        whats_up = "ما الجديد؟",
        popular = "شائع",
        done = "تم",
        my_order = "طلبي",
        empty = "فارغ",
        total = "الإجمالي",
        checkout = "دفع",
        back = "رجوع",
        no_menu_items = "لا توجد عناصر قائمة متاحة لـ %s",
        loading = "جار التحميل...",
        eat_in_label = "تناول في المطعم",
        take_out_label = "سفري",
        pay_cash = "نقد",
        cancel = "إلغاء",
        order = "طلب",
        pay_bank = "بنك",
        all_items = "كل العناصر",
        bank_only_disclaimer = "يمكن الدفع عن طريق البنك فقط.",
    },

    OrderManagementTable = {
        title = "لوحة إدارة الطلبات",
        label = "إدارة الطلبات",
        filter_all = "الكل",
        filter_cooking = "الطبخ",
        filter_ready = "جاهز",
        filter_completed = "مكتمل",
        filter_terminal_orders = "طلبات المحطة",
        filter_self_pickup = "طلبات الكشك",
        sort_by = "ترتيب حسب",
        sort_day = "اليوم",
        sort_amount = "المبلغ",
        sort_name = "الاسم",
        no_orders = "لا توجد طلبات تطابق التصفية الحالية.",
        accept = "قبول",
        accepting = "جار القبول...",
        cooking = "طبخ",
        ready = "جاهز",
        complete = "إكمال",
        completed = "مكتمل",
        assigned_to = "معين لـ: ",
        items_label = "العناصر:",
        order_label = "طلب #",
        status_cooking = "طبخ",
        status_ready = "جاهز",
        status_completed = "مكتمل",
        status_cancelled = "ملغى",
        self_pickup = "استلام ذاتي",
    },

    MenuSelectionDialog = {
        title = "اختر الإجراء",
        subtitle = "ماذا تريد أن تفعل؟",
        options = {
            shop = {
                title = "فتح المتجر",
                description = "تصفح وشراء العناصر من آلة البيع"
            },
            manageBoss = {
                title = "إدارة المتجر",
                description = "إدارة المخزون، عرض التحليلات، والتحكم في آلة البيع"
            },
            manageEmployee = {
                title = "إدارة المتجر",
                description = "إضافة وإدارة عناصر المخزون في آلة البيع"
            }
        }
    },
}