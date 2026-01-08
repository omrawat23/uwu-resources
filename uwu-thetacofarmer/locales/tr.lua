-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["tr"] = {
    
    WashHands = {
        title = "Lavabo",
        no_available = "Kullanılabilir lavabo yok",
        success = "Ellerin artık temiz!",
        error = "Hata",
        fail = "Ellerin zaten temiz!",
        targetfail = "Önce ellerini yıkamalısın!",
        item_cleaned = "Eşya başarıyla temizlendi!",
        missing_required = "Gerekli eşya eksik"
    },

    Terminal = {
        SubmitText = "Fatura Gönder",

        -- Player Selection Tab
        select_player = "Oyuncu Seç",
        nearby_players = "Yakındaki Oyuncular",
        search_players = "Oyuncu ara...",
        no_players_found = "Yakında oyuncu bulunamadı",
        loading_players = "Oyuncular yükleniyor...",
        player_selected = "Oyuncu seçildi",

        -- Menu Items Tab
        menu_items = "Menü Öğeleri",
        items_added = "Öğeler eklendi",
        search_menu_items = "Menü öğelerini ara...",
        available_items = "Mevcut Öğeler",
        selected_items = "Seçilen Öğeler",
        no_items_found = "Öğe bulunamadı",
        no_items_selected = "Öğe seçilmedi",
        total_items = "Toplam Öğeler",
        total = "Toplam",
        all = "Tümü",

        -- Finalize Bill Tab
        finalize_bill = "Faturayı Tamamla",
        customer_info = "Müşteri Bilgisi",
        order_summary = "Sipariş Özeti",
        amount_label = "Tutar ($)",
        enter_amount = "Tutar girin",
        reason_label = "Sebep (İsteğe Bağlı)",
        reason_placeholder = "Fatura sebebini girin",
        payment_method = "Ödeme Yöntemi",
        cash = "Nakit",
        bank = "Banka",
        send_bill = "Fatura Gönder",

        -- Commission
        your_commission = "Komisyonunuz",
        commission_rate = "Komisyon Oranı",

        -- Bills sent counter
        bills_sent = "Gönderilen Faturalar:",
        commission = "Komisyon:",

        -- Error Messages
        bill_error = "Fatura Hatası",
        select_player_error = "Lütfen bir oyuncu seçin",
        invalid_amount_error = "Lütfen geçerli bir tutar girin",

        -- Success Messages
        bill_sent_success = "Fatura başarıyla gönderildi!",
        bill_sent_title = "Fatura Gönderildi",
    },

    Consumable = {
        Drinking = "İçiyor ", -- Drinking ItemName
        Eating = "Yiyor " -- Eating ItemName
    },

    Garage = {
        title = "Garaj",
        no_vehicle = "İade edilecek araç yok",
        not_job_vehicle = "Bu bir Burgershot aracı değil!",
        parked_title = "Araç Park Edildi!",
        parked_message = "Aracınız bu konuma park edildi!",
        in_vehicle = "Araç içinde olamazsınız!",
        too_far = "Araca çok uzaksınız!",
        spawn_error = "Bunu şu anda yapamazsınız!",

        -- UI Text
        garage_title = "Garaj",
        garage_active_vehicles = "Aktif",
        garage_manage = "Aktifleri Yönet",
        close = "Kapat",
        search_vehicles = "Araç ara...",
        no_vehicles_found = "Araç bulunamadı",
        dont_have_vehicle = "Bu garajda saklanan aracınız yok.",
        select_vehicle = "Araç Seç",
        select_vehicle_message = "Detayları görmek ve çıkarmak için listeden bir araç seçin.",
        back = "Geri",
        spawn_vehicle = "Aracı Çıkar",
        return_button = "İade Et",
        return_vehicle = "Aracı İade Et",
        license_plate = "Plaka",

        -- Status Messages
        vehicle_spawned = "Araç başarıyla çıkarıldı",
        no_vehicle_to_return = "İade edilecek araç yok",
        access_denied = "Bu garaja erişiminiz yok.",
        all_spawn_points_blocked = "Tüm çıkış noktaları şu anda dolu, lütfen bekleyin.",
        vehicle_model_not_exist = "Araç modeli mevcut değil",
        failed_load_model = "Araç modeli yüklenemedi",
        failed_create_vehicle = "Araç oluşturulamadı",
        invalid_vehicle_data = "Geçersiz araç modeli verisi",

        -- Error Messages
        error = "Hata",
        garage_error = "Garaj Hatası",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "Araç varlığı oluşturulamadı",
        no_spawn_points_available = "Müsait çıkış noktası yok",
        vehicle_returned_parked = "Araç iade edildi ve park edildi.",
        vehicle_processed_remote = "Araç işlendi (Uzaktan İade).",
    },

    Billing = {
        title = "Faturalandırma",
        payment_failed_byreceiver = "Ödeme Başarısız: %s kişisinin %s ödemek için yeterli parası yok.",
        business_closed = "Faturalandırma şu anda yönetim tarafından devre dışı bırakıldı.",
        commission_earned = "Komisyon Kazanıldı",
        commission_earned_description = "$%s komisyon kazandınız.",
        terminal_title = "Fatura Terminali",
        off_duty_error = "Terminali kullanmak için görevde olmalısınız.",
        access_denied = "Fatura terminaline erişiminiz yok.",
        payment_received = "Ödeme Alındı",
        payment_received_message = "%s kişisinden $%s ödeme alındı",
        payment_failed = "Ödeme Başarısız",
        payment_failed_message = "Fatura ödemesi başarısız oldu",
        bill_sent = "Fatura Gönderildi",
        bill_sent_success = "Fatura başarıyla gönderildi!",
        bill_sent_error = "Fatura gönderilemedi.",
        bill_error = "Fatura Hatası",
        invalid_bill = "Geçersiz Fatura!",
        invalid_bill_description = "Ödemeye çalıştığınız fatura mevcut değil.",
        invalid_target_amount = "Geçersiz hedef veya tutar!",
        player_not_found = "Oyuncu bulunamadı!",
        must_be_on_duty = "Fatura göndermek için görevde olmalısınız!",
        bill_sent_description = "%s kişisine %s için $%s tutarında fatura gönderildi",
        bill_payment_successful = "✅ Fatura ödemesi başarılı",
        bill_payment_failed_insufficient = "❌ Fatura ödemesi başarısız - Yetersiz Bakiye",
        bill_rejected = "❌ Fatura reddedildi",
        insufficient_funds = "%s kişisinin parası yetersiz!",
        order_processed = "🍔 Sipariş İşlendi",
        command_access_denied = "Bu komutu kullanamazsınız!",
        payment_failed_insufficient = "%s kişisinin parası yetersiz!",
        bill_rejected_title = "Fatura Reddedildi",

        bill_rejected_sender = "%s, $%s tutarındaki faturanızı reddetti",
        bill_rejected_receiver = "%s kişisinden gelen faturayı reddettiniz",
        billing_disabled = "Faturalandırma şu anda yönetim tarafından devre dışı bırakıldı.",
        billing_off_duty = "Faturalandırmayı kullanmak için görevde olmalısınız.",
    },

    Delivery = {
        items_header = "Teslimat Öğeleri",
        reward_header = "Ödül",
        accept_header = "Teslimatı Kabul Et",
        decline_header = "Teslimatı Reddet",
        menu_header = "Teslimat Menüsü",
        no_delivery = "Aktif teslimat yok!",
        new_delivery_title = "Yeni Teslimat",
        new_delivery_desc = "Yeni bir teslimat isteği aldınız.",
        delivery_expired = "Teslimat isteğinizin süresi doldu.",
        delivery_timeout = "Teslimatı zamanında tamamlayamadınız.",
        delivery_declined = "Teslimat isteğini reddettiniz.",
        check_location = "Teslimat konumu için GPS'inizi kontrol edin.",
        check_location_error = "Takip edilecek aktif teslimat yok.",
        delivery_accepted = "Teslimat Kabul Edildi",
        invalid_item = "Teslimat için geçersiz öğe",
        delivery_failed = "Teslimat Başarısız",
        invalid_items_data = "Geçersiz öğe verisi",

        -- UI Text
        delivery_title = "Teslimat",
        close_menu = "Menüyü Kapat",
        new_order = "Yeni Sipariş",
        in_progress = "Devam Ediyor",
        order_items = "Sipariş Öğeleri:",
        payment = "Ödeme",
        delivery_status = "Teslimat Durumu",
        deliver_instruction = "Yemeği haritada işaretlenen konuma teslim et.",
        time_remaining = "Kalan Süre:",
        order_summary = "Sipariş Özeti:",
        accept = "Kabul Et",
        decline = "Reddet",
        cancel_delivery = "Teslimatı İptal Et",

        -- Notifications
        delivery_accepted_notification = "Teslimat başarıyla kabul edildi",
        delivery_cancelled_notification = "Teslimat başarıyla iptal edildi",

        -- Status Messages
        complete_delivery = "Teslimatı Tamamla",
        delivery_in_progress = "Teslimat devam ediyor...",
        head_to_location = "Teslimatı tamamlamak için işaretlenen konuma gidin",
    },

    Consumption = {
        title = "Tüketim",
        description = "Taze ve lezzetli!",
        refresh_title = "Ferahlatıcı",
        refresh_description = "Ferahlamış hissediyorsun",
    },

    Crafting = {
        craft_title = "%s Üret",
        enter_amount_description = "Üretilecek miktarı girin",
        crafting_successful = "Üretim Başarılı",
        crafted_description = "%d x %s üretildi",
        crafting_cancelled = "Üretim İptal Edildi",
        cancelled_description = "Üretimi iptal ettiniz",
        no_space = "Envanterde yer yok",
    },

    Targets = {
        door = "Kapıyı Çal",
        door_icon = "fas fa-door-open",
        delivery_food = "Yemek Teslim Et",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "Sipariş Tableti",
        ordering_tablet_error = "Sipariş tableti özelliği mevcut değil.",
        order_management_tablet = "Sipariş Yönetim Tableti",
        order_management_error = "Sipariş yönetim tableti özelliği mevcut değil.",
        return_utensils = "Gereçleri İade Et",
        employee_vending = "Çalışan Otomatı",
    },

    Order = {
        complete = "Sipariş Tamamlandı",
        description = "Siparişiniz işlendi. Fatura envanterinize eklendi.",
        paycheck_suspended_description = "İşletme kapalıyken maaş ödemeleri askıya alınır.",
        paycheck_suspended = "Maaş Askıya Alındı",
    },

    Door = {
        title = "Kapı ",
        description = "Kapı ",
        locked = "Kapı kilitli",
        no_permissions = "Bu kapıyı kilitleme/açma izniniz yok",
        access_denied_title = "Erişim Reddedildi",
        access_granted = "Kapının kilidini açtınız",
        access_denied = "Bu kapıya erişiminiz yok",
    },

    Outfits = {
        title = "Kıyafetler",
        invalid = "Geçersiz cinsiyet",
        failed_equip = "Kıyafet giyilemedi",
        disabled = "Kıyafetler devre dışı",
        civilian_clothes = "Sivil Kıyafete Geç",
        reset_civilian_clothes = "Sivil kıyafete dönüldü",
        no_civilian_saved = "Kaydedilmiş sivil kıyafet yok. Önce üniformaya geçin.",
        no_permission = "Bu kıyafeti kullanma izniniz yok",
        outfit_not_found = "Kıyafet bulunamadı",
        equip_success = "Kıyafet başarıyla giyildi",
        changed_to_uniform = "%s olarak değiştirildi",
        reset_success = "Kıyafet başarıyla sıfırlandı",
        no_civilian_for_reset = "Kaydedilmiş sivil kıyafet yok. Önce üniformaya geçin ve kıyafetinizi kaydedin.",
    },

    System = {
        success = "Başarılı",
        paycheck_error = "Maaş Hatası",
        inventory_full = "Envanter Dolu",
        inventory_full_description = "Envanteriniz dolu.",
        society_not_found = "İşletme bulunamadı",
        business_funds_insufficient = "İşletmenin maaş ödemek için yeterli fonu yok.",
        error = "Hata",
        invalid = "Geçersiz",
        no_license = "Lisansınız tanımlanamadı. Bir yöneticiyle iletişime geçin.",
        missing_items = "Eksik Öğeler",
        item_cleaned = "Öğe başarıyla temizlendi",
        missing_required = "Gerekli öğe eksik",
        slot_error = "Miktarı aynı yuvaya yerleştirin",
        ice_collected = "Buz toplandı",
        refreshing = "Ferahlatılıyor",
        refreshed = "Ferahladı",
        consumption = "Tüketim",
        stress_increased = "Stres Arttı",
        stress_amount = "Stres seviyeniz %s arttı",
        inventory_full = "Envanteriniz dolu",
    },

    Experience = {
        gained_title = "Tecrübe Kazanıldı",
        experience_earned_description = "%d XP kazandınız.",
        gained_message = "Teslimatı tamamlayarak %d XP kazandınız!",
    },

    BossMenu = {
        title = "Patron Menüsü",
        unable_jobdetermine = "Mesleğiniz belirlenemedi. Lütfen daha sonra tekrar deneyin.",
        bankruptcy_alert = "⚠️ İflas Uyarısı",
        description = "Maaşlar ödenemiyor! İşletme bakiyesi: $%s, Gerekli: $%s",
        trans_failed_bossmenubalance = "İşlem Başarısız - Yetersiz İşletme Fonu",
        menu_in_use = "Patron menüsü şu anda %s tarafından kullanılıyor.",
        no_permissions = "Patron yetkileriniz yok! Patron olmalısınız.",
        wrong_job = "Doğru mesleğe sahip değilsiniz",
        grade_updated = "Meslek Derecesi Güncellendi",
        grade_update_success = "%s derecesi başarıyla güncellendi.",
        menu_update = "Menü Güncelleme",
        menu_update_success = "Menü öğesi başarıyla güncellendi!",
        vending_update = "Otomat",
        vending_update_success = "Otomat öğesi başarıyla güncellendi!",
        menu_update_error = "Menü öğesi güncellenemedi!",
        menu_delete = "Menü Sil",
        menu_delete_success = "Menü öğesi başarıyla silindi!",
        menu_delete_error = "Menü öğesi silinemedi!",
        invite_sent = "Davet Gönderildi",
        invite_sent_success = "İş daveti %s kişisine gönderildi",
        invite_error = "Geçersiz oyuncu ID'si veya rol!",
        player_not_found = "Oyuncu bulunamadı!",
        job_error = "Geçersiz davet verisi!",
        job_accepted = "Artık %s işletmesinde %s olarak çalışıyorsunuz",
        job_updated_title = "Meslek Güncellendi",
        job_updated = "Pozisyonunuz %s işletmesinde %s olarak güncellendi",
        database_error = "Mesleğiniz ayarlandı ancak veritabanı güncellemesi başarısız oldu.",
        invite_rejected = "İş davetini reddettiniz.",
        withdraw_error = "Geçersiz tutar!",
        business_error = "İşletme bulunamadı!",
        insufficient_funds = "Yetersiz işletme fonu!",
        money_withdrawn = "İşletme hesabından $%s çektiniz.",
        transaction_failed = "İşletme hesabı güncellenemedi!",
        money_deposited = "İşletme hesabına $%s yatırdınız.",
        transaction_failed_refund = "İşletme hesabı güncellenemedi! Paranız iade edildi.",
        shop_purchase = "Yeni Mağaza Satın Alımı",
        shop_purchase_notification = "%s, $%s değerinde eşya satın aldı",
        menu_occupied = "Patron menüsü meşgul",
        menu_occupied_by = "%s şu anda patron menüsünü kullanıyor. Lütfen daha sonra tekrar deneyin.",
        menu_released = "Patron menüsü artık kullanılabilir",

        -- Main Headers and Titles
        business_overview = "İşletme Genel Bakış",
        business_settings = "İşletme Ayarları",
        menu_management = "Menü Yönetimi",
        staff_management = "Personel Yönetimi",
        employee_leaderboard = "Çalışan Liderlik Tablosu",
        sales_transactions = "Satışlar & İşlemler",

        -- Finance Section
        finance = "Finans",
        business_balance = "İşletme Bakiyesi",
        withdraw = "Çek",
        deposit = "Yatır",
        withdraw_money = "Para Çek",
        deposit_money = "Para Yatır",
        enter_amount_withdraw = "İşletme hesabından %s hesabınıza çekmek istediğiniz tutarı girin.",
        enter_amount_deposit = "%s hesabınızdan işletme hesabına yatırmak istediğiniz tutarı girin.",
        available = "Kullanılabilir",
        enter_amount = "Tutar girin",
        withdraw_to = "%s Hesabına Çek",
        deposit_from = "%s Hesabından Yatır",
        updating = "Güncelleniyor...",
        update_avatar = "Avatarı Güncelle",
        cancel = "İptal",
        cash = "Nakit",
        bank = "Banka",
        invalid_url = "Geçersiz URL",
        invalid_url_message = "Lütfen geçerli bir resim URL'si girin",
        avatar_updated = "Avatar Güncellendi",
        avatar_updated_message = "Avatar başarıyla güncellendi!",
        update_failed = "Güncelleme Başarısız",
        update_failed_message = "Avatar güncellenemedi",
        business_status = "İşletme Durumu",
        business_status_desc = "İşletmenizin çalışma durumunu kontrol edin",
        business_operations = "İşletme Operasyonları",
        business_open = "Şu anda müşteri kabul ediliyor - Faturalandırma etkin",
        business_closed = "Şu anda müşterilere kapalı - Faturalandırma devre dışı",
        business_status_updated = "İşletme Durumu",
        business_now_open = "İşletme şimdi açık",
        business_now_closed = "İşletme şimdi kapalı",
        business_status_error = "Hata",
        business_status_failed = "İşletme durumu güncellenemedi",

        -- Employees Section
        employees = "Çalışanlar",
        invite_new_employee = "Yeni Çalışan Davet Et",
        player_id = "Oyuncu ID...",
        invite = "Davet Et",
        select_role = "Rol Seç",
        choose_role_for = "%s için bir rol seçin",
        available_roles = "Mevcut Roller:",
        roles_available = "%d rol mevcut",
        send_invite = "Davet Gönder",

        -- Sales Summary
        sales_summary = "Satış Özeti",
        today = "Bugün",
        this_week = "Bu Hafta",
        this_month = "Bu Ay",
        view_sales = "Satışları Görüntüle",

        -- Inventory Status
        inventory_status = "Stok Durumu",
        storage_capacity = "Depolama Kapasitesi",
        ingredients = "Malzemeler",
        supplies = "Tedarikler",
        manage_inventory = "Stok Yönetimi",

        -- Menu Management
        search_menu_items = "Menü öğelerini ara...",
        edit_menu_item = "Menü Öğesini Düzenle",
        update_item_details = "Aşağıdaki öğe detaylarını güncelleyin.",
        label_display_name = "Etiket (Görünen İsim)",
        price = "Fiyat ($)",
        category = "Kategori",
        select_category = "Bir kategori seçin",
        update = "Güncelle",
        all_items = "Tüm Öğeler",
        no_menu_items = "Menü öğesi bulunamadı",
        no_category_items = "%s bulunamadı",

        -- Vending Machine Management
        vending_machine_management = "Otomat Yönetimi",
        search_vending_items = "Otomat öğelerini ara...",
        edit_vending_item = "Otomat Öğesini Düzenle",
        update_vending_details = "Aşağıdaki öğe detaylarını güncelleyin.",
        all_vending_items = "Tüm Öğeler",
        no_vending_items = "Otomat öğesi bulunamadı",
        no_category_vending_items = "%s bulunamadı",
        vending_update_error = "Otomat öğesi güncellenemedi",
        item_price = "Fiyat",
        item_type = "Tür",
        uncategorized = "Kategorisiz",
        enter_price = "örn., 5",

        -- Staff Management
        employee_overview = "Çalışan Genel Bakış",
        total_employees = "Toplam Çalışan",
        active_employees = "Aktif Çalışanlar",
        pending_applications = "Bekleyen Başvurular",
        employee_list = "Çalışan Listesi",
        search_employees = "Çalışan ara...",
        all_employees = "Tüm Çalışanlar",
        name = "İsim",
        role = "Rol",
        salary = "Maaş",
        last_seen = "Son Görülme",
        actions = "İşlemler",
        promote = "Terfi Ettir",
        demote = "Rütbe Düşür",
        fire = "Kov",
        employee_actions = "Çalışan İşlemleri",
        select_action = "%s için bir işlem seçin",
        promote_employee = "Çalışanı Terfi Ettir",
        demote_employee = "Çalışanın Rütbesini Düşür",
        fire_employee = "Çalışanı Kov",
        confirm_action = "İşlemi Onayla",
        confirm_promote = "%s kişisini %s rütbesine terfi ettirmek istediğinizden emin misiniz?",
        confirm_demote = "%s kişisini %s rütbesine düşürmek istediğinizden emin misiniz?",
        confirm_fire = "%s kişisini kovmak istediğinizden emin misiniz?",
        action_success = "İşlem başarıyla tamamlandı",
        action_failed = "İşlem başarısız",
        employee_promoted = "Çalışan başarıyla terfi ettirildi",
        employee_demoted = "Çalışanın rütbesi başarıyla düşürüldü",
        employee_fired = "Çalışan başarıyla kovuldu",
        no_employees = "Çalışan bulunamadı",

            -- Job Grades Management Dialog
        manage_job_grades = "Meslek Derecelerini Yönet",
        configure_salary_commission = "Her pozisyon için maaş ve komisyon oranlarını yapılandırın",
        search_job_grades = "Meslek derecelerini ara...",
        edit_job_grade = "Meslek Derecesini Düzenle",
        update_job_grade_details = "Meslek derecesi detaylarını güncelle",
        job_title = "Meslek Unvanı",
        commission_rate = "Komisyon Oranı",
        boss_access = "Patron Erişimi",
        boss_access_enabled = "Bu rol yönetim özelliklerine erişebilir",
        boss_access_disabled = "Bu rol çalışan seviyesinde erişime sahiptir",
        save_changes = "Değişiklikleri Kaydet",
        boss_role = "Patron Rolü",
        grade_update_error = "Meslek derecesi güncellenemedi",

        -- Employee Details View
        employee_overview = "Çalışan Detayları",
        employee_profile = "Çalışan Profili",
        performance_stats = "Performans Metrikleri",
        back = "Geri",
        
        -- Employee Profile Card Labels
        commission = "Komisyon",
        total_earnings = "Toplam Kazanç",
        available_balance = "Kullanılabilir Bakiye",
        employee_id = "Çalışan ID",
        
        -- Performance Stats Labels
        deliveries_label = "Teslimatlar",
        billings_label = "Faturalandırmalar",
        earnings_label = "Kazançlar",
        experience_label = "Tecrübe",
        level_label = "Seviye",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "Gelir Dağılımı",
        delivery_income = "Teslimatlar",
        commission_income = "Komisyon",
        paycheck_income = "Maaşlar",
        completed_label = "tamamlandı",
        bills_label = "fatura",
        hourly_label = "Saatlik",

        -- Employee Card Labels (for list view)
        rank_label = "Rütbe",
        commission_label = "Komisyon",

        -- Role Change Dialog
        no_role_employees = "%s bulunamadı",
        employee_updated = "Çalışan Güncellendi",
        employee_commission_updated = "Çalışan %s komisyon oranıyla güncellendi",
        fire_employee_error = "Çalışan kovulamadı",

        -- Employee Leaderboard
        top_performers = "En İyi Performans Gösterenler",
        this_month_leaders = "Bu Ayın Liderleri",
        rank = "Sıra",
        employee = "Çalışan",
        performance = "Performans",
        orders_completed = "Tamamlanan Siparişler",
        revenue_generated = "Üretilen Gelir",
        customer_rating = "Müşteri Puanı",
        no_data = "Performans verisi mevcut değil",

        -- Transactions
        transaction_history = "İşlem Geçmişi",
        recent_transactions = "Son İşlemler",
        paycheck_history = "Maaş Geçmişi",
        transaction_type = "İşlem Türü",
        amount = "Tutar",
        date = "Tarih",
        message = "Açıklama",
        customer = "Müşteri",
        filter_transactions = "İşlemleri filtrele...",
        all_transactions = "Tüm İşlemler",
        sales_only = "Sadece Satışlar",
        paychecks_only = "Sadece Maaşlar",
        no_transactions = "İşlem bulunamadı",
        no_paychecks = "Maaş kaydı bulunamadı",


        -- Settings
        avatar_settings = "Avatar Ayarları",
        update_profile_picture = "Profil resminizi güncelleyin",
        image_url = "Resim URL",
        enter_url_preview = "Avatarınızı önizlemek için aşağıya bir URL girin",
        preview = "Önizleme",
        enter_url_message = "Avatar resminizin URL'sini girin",
        ui_theme = "Arayüz Teması",
        customize_appearance = "Panel görünümünü özelleştirin",
        light_mode = "Açık Mod",
        dark_mode = "Koyu Mod",

        -- Navigation
        home = "Ana Sayfa",
        staff = "Personel",
        menu = "Menü",
        sales = "Satışlar",
        top = "En İyiler",
        settings = "Ayarlar",

        -- Status Labels
        open = "Açık",
        closed = "Kapalı",
        online = "Çevrimiçi",
        offline = "Çevrimdışı",
        active = "Aktif",
        inactive = "Pasif",

        -- Common Actions
        save = "Kaydet",
        edit = "Düzenle",
        delete = "Sil",
        confirm = "Onayla",
        close = "Kapat",
        refresh = "Yenile",
        loading = "Yükleniyor...",

        -- Error Messages
        error_occurred = "Bir hata oluştu",
        invalid_input = "Geçersiz giriş",
        operation_failed = "İşlem başarısız",
        permission_denied = "Erişim reddedildi",
        network_error = "Ağ hatası",
        data_load_failed = "Veri yüklenemedi",

        -- Success Messages
        operation_successful = "İşlem başarıyla tamamlandı",
        data_saved = "Veri başarıyla kaydedildi",
        changes_applied = "Değişiklikler başarıyla uygulandı",
    },

    Shop = {
        shop_status = "Mağaza Durumu",
        shop_open = "Mağaza Açık",
        shop_closed = "Mağaza Kapalı",
        access_denied = "Bu mağazaya erişemezsiniz!",
        purchase_title = "Mağaza",
        purchase_success = "Satın alma tamamlandı! Eşyalar envanterinize eklendi.",
        purchase_error = "Ödeme başarısız!",

        -- Search and Inventory
        search_placeholder = "Ürünleri isme göre ara...",
        clear_search = "Aramayı temizle",
        shop_inventory = "Mağaza Stoğu",
        items_count = "ürün",

        -- Product Actions
        add_to_cart = "Ekle",
        per_item = "adet başı",

        -- Cart
        your_cart = "Sepetiniz",
        cart_empty = "Sepet Boş",
        cart_empty_message = "Alışverişe başlamak için ürün ekleyin",
        items_label = "ürün",
        total = "Toplam",

        -- Search Results
        no_items_found = "Ürün bulunamadı",
        no_items_message = "Aramanızı değiştirmeyi deneyin veya tüm ürünlere göz atın",

        -- Payment
        pay_with_cash = "Nakit",
        pay_with_bank = "Banka",
        processing = "İşleniyor...",
        inventory_notice = "Ürünler doğrudan envanterinize eklenecektir",

        -- Notifications
        cart_updated = "Sepet Güncellendi",
        item_added = "Ürün Eklendi",
        item_removed = "Ürün Kaldırıldı",
        quantity_updated = "Adet Güncellendi",
        purchase_complete = "Satın Alma Tamamlandı",
        transaction_failed = "İşlem Başarısız",
        checkout_error = "Ödeme Hatası",
        cart_empty_error = "Sepetiniz boş",
        paid_with_cash = "Nakit ile ödendi",
        charged_to_bank = "Banka hesabınızdan tahsil edildi",
        not_enough_cash = "Yetersiz nakit",
        insufficient_bank = "Yetersiz banka bakiyesi",

        -- Quantity Messages
        added_more = "%d adet daha %s eklendi",
        removed_items = "%d adet %s kaldırıldı",
        added_to_cart = "%s sepete eklendi",
        removed_from_cart = "%s sepetinizden kaldırıldı",

        -- Loading
        loading_shop = "Mağaza Menüsü Yükleniyor...",
    },

    EmployeeMenu = {
        access_denied = "Bu portala erişemezsiniz!",
        commission_withdrawn = "Komisyon Çekildi",
        commission_withdrawn_description = "Komisyon bakiyenizden $%s tutarını %s hesabınıza çektiniz.",
        transaction_failed = "İşlem Başarısız",
        fire_employee = "Çalışanı Kov",
        fire_employee_description = "%s işletmenizden kovuldu!",
        employeeMent_notice = "Çalışan Bildirimi",
        
        no_employee_active = "Şu anda siparişinizi işleme alacak aktif çevrimiçi çalışan yok.",
        -- Main Headers and Navigation
        employee_portal = "Çalışan Portalı",
        employee_profile = "Çalışan Profili",
        performance_stats = "Performans İstatistikleri",
        employee_leaderboard = "Çalışan Liderlik Tablosu",
        job_outfits = "İş Kıyafetleri",
        account_settings = "Hesap Ayarları",

        -- Navigation Labels
        profile = "Profil",
        stats = "İstatistikler",
        top = "En İyiler",
        outfits = "Kıyafetler",
        settings = "Ayarlar",

        -- Profile Tab
        personal_information = "Kişisel Bilgiler",
        paycheck_information = "Maaş Bilgileri",
        job_role = "İş Rolü",
        salary = "Maaş",
        experience = "Tecrübe",
        duty_status = "Görev Durumu",
        on_duty = "Görevde",
        off_duty = "İzinli",
        clock_in = "Mesaiye Başla",
        clock_out = "Mesaiyi Bitir",
        available_balance = "Kullanılabilir Bakiye",
        withdraw = "Çek",
        withdraw_funds = "Fon Çek",
        paycheck_interval = "Maaş Aralığı",
        total_deliveries = "Toplam Teslimat",
        bills_created = "Oluşturulan Faturalar",
        total_earnings = "Toplam Kazanç",
        minutes = "dakika",

        -- Performance Tab
        career_statistics = "Kariyer İstatistikleri",
        experience_points = "Tecrübe",
        xp_points = "XP Puanı",
        total_earned = "Toplam Kazanılan",
        current_balance = "Mevcut Bakiye",
        deliveries = "Teslimatlar",
        total_completed = "Toplam Tamamlanan",
        billings = "Faturalandırmalar",
        invoices_created = "Oluşturulan Faturalar",
        job_grade_progression = "İş Derecesi İlerlemesi",
        current_grade = "Mevcut Derece",
        level = "Seviye",
        xp_needed_promotion = "Terfi için gereken XP",
        earn_more_xp = "%s rütbesine terfi etmek için %d XP daha kazanın",
        max_grade_reached = "En yüksek otomatik dereceye ulaştınız! Daha fazla terfi yönetim onayı gerektirir.",
        promotions_by_management = "Terfiler yönetim tarafından atanır.",
        loading_experience_data = "Tecrübe sistemi verileri yükleniyor...",
        loading_progression_data = "İlerleme verileri yükleniyor...",

        -- Leaderboard Tab
        top_performers = "En İyi Performans Gösterenler",
        this_month_leaders = "Bu Ayın Liderleri",
        rank = "Sıra",
        employee = "Çalışan",
        performance = "Performans",
        no_leaderboard_data = "Liderlik tablosu verisi yok",

        -- Outfits Tab
        work_outfits = "İş Kıyafetleri",
        select_outfit = "Kıyafet Seç",
        change_outfit = "Kıyafet Değiştir",
        outfit_changed = "Kıyafet Değiştirildi",
        outfit_changed_success = "Kıyafetiniz başarıyla değiştirildi!",
        outfit_change_failed = "Kıyafet değiştirilemedi",
        outfit_preview = "Kıyafet Önizleme",

        -- Settings Tab
        employee_settings = "Çalışan Ayarları",
        avatar_settings = "Avatar Ayarları",
        update_profile_picture = "Profil resminizi güncelleyin",
        image_url = "Resim URL",
        enter_url_preview = "Avatarınızı önizlemek için aşağıya bir URL girin",
        preview = "Önizleme",
        enter_url_message = "Avatar resminizin URL'sini girin",
        avatar_updated = "Avatar Güncellendi",
        avatar_created = "Avatar Oluşturuldu",
        avatar_updated_message = "Avatar başarıyla güncellendi!",
        update_failed = "Güncelleme Başarısız",
        update_failed_message = "Avatar güncellenemedi",
        invalid_url = "Geçersiz URL",
        invalid_url_message = "Lütfen geçerli bir resim URL'si girin",
        updating = "Güncelleniyor...",
        update_avatar = "Avatarı Güncelle",

        -- UI Theme
        ui_theme = "Arayüz Teması",
        customize_appearance = "Panel görünümünü özelleştirin",
        light_mode = "Açık Mod",
        dark_mode = "Koyu Mod",

        -- Notifications
        notifications = "Bildirimler",
        manage_notification_preferences = "Bildirim tercihlerini yönet",
        employee_notifications = "Çalışan Bildirimleri",
        notifications_enabled_desc = "Tüm çalışan maaş güncellemelerini alacaksınız",
        notifications_disabled_desc = "Bildirim almayacaksınız",
        notifications_updated = "Bildirimler Güncellendi",
        notifications_enabled_message = "Maaş bildirimleri artık etkin",
        notifications_disabled_message = "Maaş bildirimleri artık devre dışı",
        enabled = "Etkin",
        disabled = "Devre Dışı",

        -- Withdrawal Dialog
        withdraw_all_funds = "Tüm Fonları Çek",
        select_balance_type = "Bakiye Türü Seç",
        all_balance = "Tüm Bakiye",
        delivery_balance = "Teslimat Bakiyesi",
        commission_balance = "Komisyon Bakiyesi",
        paycheck_balance = "Maaş Bakiyesi",
        available_balance_type = "Kullanılabilir %s Bakiyesi: $%d",
        enter_amount = "Tutar girin",
        insufficient_funds = "Yetersiz Bakiye",
        insufficient_balance = "Yetersiz %s bakiyesi",
        funds_withdrawn = "Fonlar Çekildi",
        funds_withdrawn_success = "Bakiyenizden başarıyla $%d çekildi",
        transaction_failed = "İşlem Başarısız",
        withdrawal_failed = "Fon çekilemedi",
        invalid_amount = "Geçersiz Tutar",
        invalid_amount_message = "Lütfen geçerli bir tutar girin",
        no_funds = "Fon Yok",
        no_funds_message = "Çekilecek fonunuz yok",

        -- Common Actions
        cancel = "İptal",
        save = "Kaydet",
        update = "Güncelle",
        confirm = "Onayla",
        close = "Kapat",
        loading = "Yükleniyor...",

        -- Status Labels
        active = "Aktif",
        inactive = "Pasif",
        online = "Çevrimiçi",
        offline = "Çevrimdışı",

        -- Error Messages
        error_occurred = "Bir hata oluştu",
        operation_failed = "İşlem başarısız",
        data_load_failed = "Veri yüklenemedi",
        network_error = "Ağ hatası",
        employee_data_error = "Çalışan verileriniz alınamadı.",
        identity_error = "Kimliğiniz doğrulanamadı.",
        withdraw_invalid_amount = "Geçersiz tutar!",
        insufficient_commission = "Yetersiz komisyon bakiyesi!",
        transaction_failed_update = "Komisyon bakiyesi güncellenemedi!",
        fire_employee_not_found = "Çalışan bulunamadı!",
        fire_employee_wrong_business = "Bu çalışan işletmenizde çalışmıyor!",
        fire_employee_db_error = "Çalışan veritabanından silinemedi!",
        employment_notice_fired = "%s tarafından kovuldunuz",
        avatar_invalid_url = "Geçersiz resim URL'si sağlandı.",
        avatar_updated_success = "Profil avatarınız başarıyla güncellendi.",
        avatar_no_changes = "Avatarınızda değişiklik yapılmadı.",
        avatar_created = "Çalışan profiliniz ve avatarınız oluşturuldu.",
        avatar_create_failed = "Çalışan kaydı oluşturulamadı.",
        withdrawal_invalid_amount = "Geçersiz çekim tutarı.",
        employee_record_not_found_withdraw = "Çalışan kaydı bulunamadı.",
        insufficient_balance_withdraw = "Bakiyenizde yetersiz fon.",
        withdraw_balance_failed = "Bakiyeden çekim yapılamadı. Lütfen tekrar deneyin.",
        identity_error_toggle = "Kimliğiniz doğrulanamadı",
        invalid_grade_data = "Geçersiz derece verisi sağlandı.",
        grade_id_not_found = "Bu rol için derece ID bulunamadı.",
        no_grade_changes = "İş derecesinde değişiklik yapılmadı.",
        balance_withdrawn = "%s bakiyenizden $%d tutarını %s hesabınıza çektiniz.",
        player_not_found = "Oyuncu bulunamadı!",
        invalid_purchase_data = "Geçersiz satın alma verisi!",
        insufficient_funds = "%s hesabınızda yeterli fon yok!",
        inventory_full = "Yetersiz envanter alanı veya ağırlık sınırı aşıldı!",
        purchase_complete = "Satın alma tamamlandı! Eşyalar envanterinize eklendi.",
        shop_purchase = "Mağaza Satın Alımı: %s",
        business_balance_error = "%s için işletme bakiyesi güncellenirken hata oluştu",
        business_balance_success = "İşletme hesabına başarıyla $%s eklendi",
        transaction_record_error = "Mağaza satın alımı için işlem kaydı hatası",
        avatar_found = "Mağaza: %s için avatar bulundu: %s",
        avatar_not_found = "Mağaza: %s için avatar bulunamadı, varsayılan kullanılıyor",
    },

    Vending = {
        invalid_item_data = "Geçersiz öğe verisi.",
        insufficient_item = "Bu öğeden yeterince yok.",
        item_added_with_money = "Öğe stoğa eklendi. %sx %s için $%s alındı",
        item_added = "Öğe stoğa eklendi.",
        business_balance_error = "Sipariş için işletme bakiyesi güncelleme hatası",
        database_error = "Veritabanı Hatası",
        add_item_failed = "Öğe eklenemedi.",
        invalid_collection_data = "Geçersiz toplama verisi.",
        inventory_full = "Öğe envanterinize eklenemedi.",
        item_collected = "%sx %s toplandı",
        stock_update_failed = "Otomat stoğu güncellenemedi.",
        out_of_stock = "Stok Yok",
        insufficient_stock = "Toplanacak yeterli öğe yok.",
        sale_transaction_error = "Otomat satış işlemi kayıt hatası",
        collection_transaction_error = "Otomat toplama işlemi kayıt hatası",
    },

    JobSystem = {
        no_permission = "Bu komutu kullanma izniniz yok.",
        player_not_found = "Oyuncu bulunamadı.",
        job_assigned = "Meslek atandı.",
        job_assign_failed = "Meslek atanamadı.",
        job_removed = "Meslek kaldırıldı.",
        job_remove_failed = "Meslek kaldırılamadı.",
        job_changed_notification = "Meslek Değiştirildi",
        job_changed = "Mesleğiniz %s (derece %s) olarak değiştirildi.",
        job_removed_notification = "Mesleğiniz kaldırıldı.",
        give_job_usage = "Kullanım: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "Kullanım: /%s [playerId]",
        job_info = "Meslek: %s (Derece: %s, Görev: %s)",
        job_info_error = "Meslek bilgileriniz alınamadı.",
        duty_status = "Şu anda %s görevdesiniz.",
        not_on_duty = "Görevde Değil",
        must_be_on_duty = "Maaş alabilmek için görevde olmalısınız.",
        paycheck_title = "Maaş",
        employer_insufficient_funds = "Patronunuzun size ödeme yapacak yeterli fonu yok.",
        paycheck_added = "%s işi için %s çalışan bakiyesine $%s maaş eklendi: %s",
        paycheck_received = "%s kişisinden $%s maaş aldınız",
    },

    BillingInviteNotification = {
        message = "Bir ödeme isteği aldınız.",

        -- Titles / headers
        title = "Ödeme İsteği",
        label = "Faturalandırma Bildirimi",

        -- Button labels
        pay_button = "Faturayı Öde",
        decline_button = "Reddet",

        -- Small UI labels used inside the notification component
        business_label = "İşletme",
        total_amount_label = "Toplam Tutar",
        reason_label = "Sebep",
        amount_label = "Tutar:",

        -- Warning / helper texts
        warning_text = "Ödeme hesabınızdan düşülecektir. Yeterli bakiyeniz olduğundan emin olun.",
        expires_text = "%s içinde sona eriyor", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "Burgershot'a %s olarak katılmaya davet edildiniz. Kabul ediyor musunuz?",

        -- Titles / headers
        title = "İş Daveti",
        label = "İş Daveti Bildirimi",

        -- Button labels
        accept_button = "Kabul Et",
        reject_button = "Reddet",

        -- Small UI labels used inside the notification component
        company_label = "Şirket",
        grade_label = "Derece",
        invites_left_label = "Kalan Davetler",
        salary_label = "Maaş",

        -- Warning / helper texts
        warning_text = "Bu işi kabul etmek sizi bu role bağlayacaktır. Başlamaya hazır olduğunuzdan emin olun.",
        expires_text = "%s içinde sona eriyor", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "Restoran Menüsü",
        onduty = "Restoran menüsüne erişmek için görevde olmalısınız.",
    },

    Duty = {
        status = "Görev Durumu",
        management = "Görev Yönetimi",
        description = "Şu anda %s görevdesiniz.",
        restaurant_area = "Restoran Alanı",
        clock_in = "Restoran alanına girdiniz. Mesaiye başlamak için çalışan menüsünü kullanın.",
        enter_workplace = "İş yerinize girdiniz ve artık görevdesiniz.",
        leave_workplace = "İş yerinizden ayrıldınız ve artık görevde değilsiniz.",
        inside_workplace = "İş yerindesiniz - otomatik olarak görevde olarak ayarlandı.",
        outside_workplace = "İş yeri dışındasınız - otomatik olarak görev dışı olarak ayarlandı.",
        duty_warning = "Görev Uyarısı",
        auto_off_duty = "Restoran dışındayken otomatik olarak görev dışı bırakılacaksınız.",
        no_permission_manage_duty = "Çalışan görev durumunu yönetme izniniz yok",
        not_employee_of_job = "Oyuncu bu işin çalışanı değil",
        duty_set_by_management = "Görev durumunuz yönetim tarafından %s olarak ayarlandı",
        duty_management_success = "%s kişisinin görev durumu başarıyla %s olarak ayarlandı",
        updated_offline_employee = "Çevrimdışı çalışanın görev durumu güncellendi",
    },

    Paycheck = {
        title = "Maaş Alındı",
        message = "%s kişisinden $%s maaş aldınız",
    },

    VendingMachine = {
        sell_item = "Öğe Sat",
        select_item_from_inventory = "Envanterden Öğe Seç",
        add_to_vending = "%s OTOMATA EKLE",
        cancel = "İPTAL",
        no_matching_items = "Envanterde eşleşen öğe yok",
        stocked_items = "Stoklanan Öğeler",
        sell = "Sat",
        no_stock = "Stok Yok",
        items = "stoktaki öğeler",
        ready_to_serve = "Hizmete Hazır!",
    },

    EmployeeVendingMachine = {
        title = "Otomattan Al",
        label = "Otomat stoğundan öğe al",
        collect = "Al",
        cancel = "İptal",
        quantity_available = "Miktar (Mevcut: %s)",
        collect_item = "%s Al",
        collect_button = "Al",
        in_stock = "Stokta",
        vending_machine_empty = "Bu otomat boş.",
    },

    OrderingTab = {
        where_eating_today = "Bugün nerede yiyeceksiniz?",
        eat_in = "Burada Ye",
        take_out = "Paket Yap",
        whats_up = "ne haber?",
        popular = "Popüler",
        done = "Tamam",
        my_order = "Siparişim",
        empty = "Boş",
        total = "Toplam",
        checkout = "Ödeme",
        back = "Geri",
        no_menu_items = "%s için menü öğesi yok",
        loading = "Yükleniyor...",
        eat_in_label = "Burada Ye",
        take_out_label = "Paket Yap",
        pay_cash = "Nakit",
        cancel = "İptal",
        order = "Sipariş Ver",
        pay_bank = "Banka",
        all_items = "Tüm Öğeler",
        bank_only_disclaimer = "Ödeme sadece banka üzerinden yapılabilir.",
    },

    OrderManagementTable = {
        title = "Sipariş Yönetim Paneli",
        label = "Sipariş Yönetimi",
        filter_all = "Tümü",
        filter_cooking = "Pişiriliyor",
        filter_ready = "Hazır",
        filter_completed = "Tamamlandı",
        filter_terminal_orders = "Terminal Siparişleri",
        filter_self_pickup = "Kiosk Siparişleri",
        sort_by = "Sırala",
        sort_day = "Gün",
        sort_amount = "Tutar",
        sort_name = "İsim",
        no_orders = "Mevcut filtreyle eşleşen sipariş yok.",
        accept = "KABUL ET",
        accepting = "KABUL EDİLİYOR...",
        cooking = "PİŞİRİLİYOR",
        ready = "HAZIR",
        complete = "TAMAMLA",
        completed = "TAMAMLANDI",
        assigned_to = "Atanan: ",
        items_label = "Öğeler:",
        order_label = "Sipariş #",
        status_cooking = "pişiriliyor",
        status_ready = "hazır",
        status_completed = "tamamlandı",
        status_cancelled = "iptal edildi",
        self_pickup = "Kendin Al",
    },

    MenuSelectionDialog = {
        title = "Eylem Seç",
        subtitle = "Ne yapmak istersiniz?",
        options = {
            shop = {
                title = "Mağazayı Aç",
                description = "Otomatdan ürünleri görüntüle ve satın al"
            },
            manageBoss = {
                title = "Mağazayı Yönet",
                description = "Envanteri yönet, analizi görüntüle ve otomatı kontrol et"
            },
            manageEmployee = {
                title = "Mağazayı Yönet",
                description = "Otomatda envanter ürünlerini ekle ve yönet"
            }
        }
    },
}