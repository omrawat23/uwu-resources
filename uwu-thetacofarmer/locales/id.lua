-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["id"] = {
    
    WashHands = {
        title = "Wastafel",
        no_available = "Tidak ada wastafel tersedia",
        success = "Tangan Anda sekarang bersih!",
        error = "Kesalahan",
        fail = "Tangan Anda sudah bersih!",
        targetfail = "Anda harus mencuci tangan terlebih dahulu!",
        item_cleaned = "Barang berhasil dibersihkan!",
        missing_required = "Kehilangan barang yang diperlukan"
    },

    Terminal = {
        SubmitText = "Kirim Tagihan",

        -- Player Selection Tab
        select_player = "Pilih Pemain",
        nearby_players = "Pemain Terdekat",
        search_players = "Cari pemain...",
        no_players_found = "Tidak ada pemain ditemukan di dekat sini",
        loading_players = "Memuat pemain...",
        player_selected = "Pemain dipilih",

        -- Menu Items Tab
        menu_items = "Item Menu",
        items_added = "Item ditambahkan",
        search_menu_items = "Cari item menu...",
        available_items = "Item Tersedia",
        selected_items = "Item Dipilih",
        no_items_found = "Item tidak ditemukan",
        no_items_selected = "Tidak ada item dipilih",
        total_items = "Total Item",
        total = "Total",
        all = "Semua",

        -- Finalize Bill Tab
        finalize_bill = "Selesaikan Tagihan",
        customer_info = "Info Pelanggan",
        order_summary = "Ringkasan Pesanan",
        amount_label = "Jumlah ($)",
        enter_amount = "Masukkan jumlah",
        reason_label = "Alasan (Opsional)",
        reason_placeholder = "Masukkan alasan tagihan",
        payment_method = "Metode Pembayaran",
        cash = "Tunai",
        bank = "Bank",
        send_bill = "Kirim Tagihan",

        -- Commission
        your_commission = "Komisi Anda",
        commission_rate = "Tingkat Komisi",

        -- Bills sent counter
        bills_sent = "Tagihan terkirim:",
        commission = "Komisi:",

        -- Error Messages
        bill_error = "Kesalahan Tagihan",
        select_player_error = "Silakan pilih pemain",
        invalid_amount_error = "Silakan masukkan jumlah yang valid",

        -- Success Messages
        bill_sent_success = "Tagihan berhasil dikirim!",
        bill_sent_title = "Tagihan Terkirim",
    },

    Consumable = {
        Drinking = "Minum ", -- Drinking ItemName
        Eating = "Makan " -- Eating ItemName
    },

    Garage = {
        title = "Garasi",
        no_vehicle = "Tidak ada kendaraan untuk dikembalikan",
        not_job_vehicle = "Ini bukan kendaraan Burgershot!",
        parked_title = "Kendaraan diparkir!",
        parked_message = "Kendaraan Anda telah diparkir di lokasi ini!",
        in_vehicle = "Anda tidak boleh berada di dalam kendaraan!",
        too_far = "Terlalu jauh dari kendaraan!",
        spawn_error = "Tidak bisa melakukan itu sekarang!",

        -- UI Text
        garage_title = "Garasi",
        garage_active_vehicles = "Aktif",
        garage_manage = "Kelola Aktif",
        close = "Tutup",
        search_vehicles = "Cari kendaraan...",
        no_vehicles_found = "Kendaraan tidak ditemukan",
        dont_have_vehicle = "Anda tidak memiliki kendaraan yang disimpan di garasi ini.",
        select_vehicle = "Pilih Kendaraan",
        select_vehicle_message = "Pilih kendaraan dari daftar untuk melihat detail dan mengeluarkannya.",
        back = "Kembali",
        spawn_vehicle = "Keluarkan Kendaraan",
        return_button = "Kembalikan",
        return_vehicle = "Kembalikan Kendaraan",
        license_plate = "Plat Nomor",

        -- Status Messages
        vehicle_spawned = "Kendaraan berhasil dikeluarkan",
        no_vehicle_to_return = "Tidak ada kendaraan untuk dikembalikan",
        access_denied = "Anda tidak memiliki akses ke garasi ini.",
        all_spawn_points_blocked = "Semua titik spawn sedang diblokir, harap tunggu.",
        vehicle_model_not_exist = "Model kendaraan tidak ada",
        failed_load_model = "Gagal memuat model kendaraan",
        failed_create_vehicle = "Gagal membuat kendaraan",
        invalid_vehicle_data = "Data model kendaraan tidak valid",

        -- Error Messages
        error = "Kesalahan",
        garage_error = "Kesalahan Garasi",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "Gagal membuat entitas kendaraan",
        no_spawn_points_available = "Tidak ada titik spawn yang tersedia",
        vehicle_returned_parked = "Kendaraan dikembalikan dan diparkir.",
        vehicle_processed_remote = "Kendaraan diproses (pengembalian jarak jauh).",
    },

    Billing = {
        title = "Penagihan",
        payment_failed_byreceiver = "Pembayaran gagal: %s tidak memiliki cukup dana untuk membayar %s.",
        business_closed = "Penagihan saat ini dinonaktifkan oleh manajemen.",
        commission_earned = "Komisi Diperoleh",
        commission_earned_description = "Anda memperoleh komisi $%s.",
        terminal_title = "Terminal Penagihan",
        off_duty_error = "Anda harus bertugas untuk menggunakan terminal.",
        access_denied = "Anda tidak memiliki akses ke terminal penagihan.",
        payment_received = "Pembayaran Diterima",
        payment_received_message = "Menerima pembayaran $%s dari %s",
        payment_failed = "Pembayaran Gagal",
        payment_failed_message = "Pembayaran tagihan gagal",
        bill_sent = "Tagihan Terkirim",
        bill_sent_success = "Tagihan berhasil dikirim!",
        bill_sent_error = "Gagal mengirim tagihan.",
        bill_error = "Kesalahan Tagihan",
        invalid_bill = "Tagihan Tidak Valid!",
        invalid_bill_description = "Tagihan yang Anda coba bayar tidak ada.",
        invalid_target_amount = "Target atau jumlah tidak valid!",
        player_not_found = "Pemain tidak ditemukan!",
        must_be_on_duty = "Anda harus bertugas untuk mengirim tagihan!",
        bill_sent_description = "Mengirim tagihan $%s ke %s untuk %s",
        bill_payment_successful = "✅ Pembayaran tagihan berhasil",
        bill_payment_failed_insufficient = "❌ Pembayaran tagihan gagal - Dana tidak mencukupi",
        bill_rejected = "❌ Tagihan ditolak",
        insufficient_funds = "%s tidak memiliki cukup dana!",
        order_processed = "🍔 Pesanan Diproses",
        command_access_denied = "Anda tidak bisa menggunakan perintah ini!",
        payment_failed_insufficient = "%s tidak memiliki cukup dana!",
        bill_rejected_title = "Tagihan Ditolak",

        bill_rejected_sender = "%s menolak tagihan Anda sebesar $%s",
        bill_rejected_receiver = "Anda menolak tagihan dari %s",
        billing_disabled = "Penagihan saat ini dinonaktifkan oleh manajemen.",
        billing_off_duty = "Anda harus bertugas untuk menggunakan penagihan.",
    },

    Delivery = {
        items_header = "Item Pengiriman",
        reward_header = "Hadiah",
        accept_header = "Terima Pengiriman",
        decline_header = "Tolak Pengiriman",
        menu_header = "Menu Pengiriman",
        no_delivery = "Tidak ada pengiriman aktif!",
        new_delivery_title = "Pengiriman Baru",
        new_delivery_desc = "Anda menerima permintaan pengiriman baru.",
        delivery_expired = "Permintaan pengiriman Anda telah kedaluwarsa.",
        delivery_timeout = "Anda tidak punya waktu untuk menyelesaikan pengiriman.",
        delivery_declined = "Anda menolak permintaan pengiriman.",
        check_location = "Periksa GPS Anda untuk lokasi pengiriman.",
        check_location_error = "Tidak ada pengiriman aktif untuk dilacak.",
        delivery_accepted = "Pengiriman Diterima",
        invalid_item = "Item tidak valid untuk pengiriman",
        delivery_failed = "Pengiriman Gagal",
        invalid_items_data = "Data item tidak valid",

        -- UI Text
        delivery_title = "Pengiriman",
        close_menu = "Tutup Menu",
        new_order = "Pesanan Baru",
        in_progress = "Sedang Berlangsung",
        order_items = "Item Pesanan:",
        payment = "Pembayaran",
        delivery_status = "Status Pengiriman",
        deliver_instruction = "Kirim makanan ke lokasi yang ditandai di peta.",
        time_remaining = "Sisa Waktu:",
        order_summary = "Ringkasan Pesanan:",
        accept = "Terima",
        decline = "Tolak",
        cancel_delivery = "Batalkan Pengiriman",

        -- Notifications
        delivery_accepted_notification = "Pengiriman berhasil diterima",
        delivery_cancelled_notification = "Pengiriman berhasil dibatalkan",

        -- Status Messages
        complete_delivery = "Selesaikan Pengiriman",
        delivery_in_progress = "Pengiriman sedang berlangsung...",
        head_to_location = "Pergi ke lokasi yang ditandai untuk menyelesaikan pengiriman",
    },

    Consumption = {
        title = "Konsumsi",
        description = "Segar dan lezat!",
        refresh_title = "Menyegarkan",
        refresh_description = "Anda merasa segar kembali",
    },

    Crafting = {
        craft_title = "Buat %s",
        enter_amount_description = "Masukkan jumlah untuk dibuat",
        crafting_successful = "Pembuatan Berhasil",
        crafted_description = "Membuat %d x %s",
        crafting_cancelled = "Pembuatan Dibatalkan",
        cancelled_description = "Anda membatalkan pembuatan",
        no_space = "Tidak ada ruang di inventaris",
    },

    Targets = {
        door = "Ketuk Pintu",
        door_icon = "fas fa-door-open",
        delivery_food = "Kirim Makanan",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "Tablet Pesanan",
        ordering_tablet_error = "Fitur tablet pesanan tidak tersedia.",
        order_management_tablet = "Tablet Manajemen Pesanan",
        order_management_error = "Fitur tablet manajemen pesanan tidak tersedia.",
        return_utensils = "Kembalikan Peralatan",
        employee_vending = "Vending Karyawan",
    },

    Order = {
        complete = "Pesanan Selesai",
        description = "Pesanan Anda telah diproses. Tagihan telah ditambahkan ke inventaris Anda.",
        paycheck_suspended_description = "Gaji ditangguhkan selama bisnis tutup.",
        paycheck_suspended = "Gaji Ditangguhkan",
    },

    Door = {
        title = "Pintu ",
        description = "Pintu ",
        locked = "Pintu terkunci",
        no_permissions = "Tidak ada izin untuk mengunci/membuka pintu ini",
        access_denied_title = "Akses Ditolak",
        access_granted = "Anda membuka kunci pintu",
        access_denied = "Anda tidak memiliki akses ke pintu ini",
    },

    Outfits = {
        title = "Pakaian",
        invalid = "Jenis kelamin tidak valid",
        failed_equip = "Gagal memakai pakaian",
        disabled = "Pakaian dinonaktifkan",
        civilian_clothes = "Ganti ke Baju Sipil",
        reset_civilian_clothes = "Kembali ke baju sipil",
        no_civilian_saved = "Tidak ada baju sipil yang disimpan. Ganti ke seragam terlebih dahulu.",
        no_permission = "Anda tidak memiliki izin untuk menggunakan pakaian ini",
        outfit_not_found = "Pakaian tidak ditemukan",
        equip_success = "Pakaian berhasil dipakai",
        changed_to_uniform = "Diganti ke %s",
        reset_success = "Pakaian berhasil direset",
        no_civilian_for_reset = "Tidak ada baju sipil yang disimpan. Ganti ke seragam dan simpan pakaian terlebih dahulu.",
    },

    System = {
        success = "Sukses",
        paycheck_error = "Kesalahan Gaji",
        inventory_full = "Inventaris Penuh",
        inventory_full_description = "Inventaris Anda penuh.",
        society_not_found = "Bisnis tidak ditemukan",
        business_funds_insufficient = "Bisnis tidak memiliki cukup dana untuk membayar gaji.",
        error = "Kesalahan",
        invalid = "Tidak Valid",
        no_license = "Tidak dapat mengidentifikasi lisensi Anda. Hubungi administrator.",
        missing_items = "Item Hilang",
        item_cleaned = "Item berhasil dibersihkan",
        missing_required = "Kehilangan item yang diperlukan",
        slot_error = "Tempatkan jumlah di slot yang sama",
        ice_collected = "Es dikumpulkan",
        refreshing = "Menyegarkan",
        refreshed = "Disegarkan",
        consumption = "Konsumsi",
        stress_increased = "Stres Meningkat",
        stress_amount = "Tingkat stres Anda meningkat sebesar %s",
        inventory_full = "Inventaris Anda penuh",
    },

    Experience = {
        gained_title = "Pengalaman Diperoleh",
        experience_earned_description = "Anda memperoleh %d XP.",
        gained_message = "Anda memperoleh %d XP karena menyelesaikan pengiriman!",
    },

    BossMenu = {
        title = "Menu Bos",
        unable_jobdetermine = "Tidak dapat menentukan pekerjaan Anda. Silakan coba lagi nanti.",
        bankruptcy_alert = "⚠️ Peringatan Kebangkrutan",
        description = "Tidak dapat membayar gaji! Saldo bisnis: $%s, Diperlukan: $%s",
        trans_failed_bossmenubalance = "Transaksi Gagal - Dana Bisnis Tidak Mencukupi",
        menu_in_use = "Menu bos sedang digunakan oleh %s.",
        no_permissions = "Anda tidak memiliki izin bos! Anda harus menjadi Bos.",
        wrong_job = "Anda tidak memiliki pekerjaan yang benar",
        grade_updated = "Tingkat Pekerjaan Diperbarui",
        grade_update_success = "Tingkat %s berhasil diperbarui.",
        menu_update = "Pembaruan Menu",
        menu_update_success = "Item menu berhasil diperbarui!",
        vending_update = "Mesin Penjual Otomatis",
        vending_update_success = "Item mesin penjual otomatis berhasil diperbarui!",
        menu_update_error = "Gagal memperbarui item menu!",
        menu_delete = "Hapus Menu",
        menu_delete_success = "Item menu berhasil dihapus!",
        menu_delete_error = "Gagal menghapus item menu!",
        invite_sent = "Undangan Terkirim",
        invite_sent_success = "Undangan kerja dikirim ke %s",
        invite_error = "ID pemain atau peran tidak valid!",
        player_not_found = "Pemain tidak ditemukan!",
        job_error = "Data undangan tidak valid!",
        job_accepted = "Anda sekarang adalah %s di %s",
        job_updated_title = "Pekerjaan Diperbarui",
        job_updated = "Posisi Anda diperbarui menjadi %s di %s",
        database_error = "Pekerjaan Anda telah diatur tetapi pembaruan database gagal.",
        invite_rejected = "Anda menolak undangan kerja.",
        withdraw_error = "Jumlah tidak valid!",
        business_error = "Bisnis tidak ditemukan!",
        insufficient_funds = "Dana bisnis tidak mencukupi!",
        money_withdrawn = "Anda telah menarik $%s dari akun bisnis.",
        transaction_failed = "Gagal memperbarui akun bisnis!",
        money_deposited = "Anda telah menyetor $%s ke akun bisnis.",
        transaction_failed_refund = "Gagal memperbarui akun bisnis! Uang Anda telah dikembalikan.",
        shop_purchase = "Pembelian Toko Baru",
        shop_purchase_notification = "%s membeli item seharga $%s",
        menu_occupied = "Menu bos sedang digunakan",
        menu_occupied_by = "%s sedang menggunakan menu bos. Silakan coba lagi nanti.",
        menu_released = "Menu bos sekarang tersedia",

        -- Main Headers and Titles
        business_overview = "Tinjauan Bisnis",
        business_settings = "Pengaturan Bisnis",
        menu_management = "Manajemen Menu",
        staff_management = "Manajemen Staf",
        employee_leaderboard = "Papan Peringkat Karyawan",
        sales_transactions = "Penjualan & Transaksi",

        -- Finance Section
        finance = "Keuangan",
        business_balance = "Saldo Bisnis",
        withdraw = "Tarik",
        deposit = "Setor",
        withdraw_money = "Tarik Uang",
        deposit_money = "Setor Uang",
        enter_amount_withdraw = "Masukkan jumlah yang ingin Anda tarik dari akun bisnis ke %s Anda.",
        enter_amount_deposit = "Masukkan jumlah yang ingin Anda setor dari %s Anda ke akun bisnis.",
        available = "Tersedia",
        enter_amount = "Masukkan jumlah",
        withdraw_to = "Tarik ke %s",
        deposit_from = "Setor dari %s",
        updating = "Memperbarui...",
        update_avatar = "Perbarui Avatar",
        cancel = "Batal",
        cash = "Tunai",
        bank = "Bank",
        invalid_url = "URL Tidak Valid",
        invalid_url_message = "Silakan masukkan URL gambar yang valid",
        avatar_updated = "Avatar Diperbarui",
        avatar_updated_message = "Avatar berhasil diperbarui!",
        update_failed = "Pembaruan Gagal",
        update_failed_message = "Gagal memperbarui avatar",
        business_status = "Status Bisnis",
        business_status_desc = "Kontrol status operasional bisnis Anda",
        business_operations = "Operasional Bisnis",
        business_open = "Saat ini menerima pelanggan - Penagihan diaktifkan",
        business_closed = "Saat ini tutup untuk pelanggan - Penagihan dinonaktifkan",
        business_status_updated = "Status Bisnis",
        business_now_open = "Bisnis sekarang buka",
        business_now_closed = "Bisnis sekarang tutup",
        business_status_error = "Kesalahan",
        business_status_failed = "Gagal memperbarui status bisnis",

        -- Employees Section
        employees = "Karyawan",
        invite_new_employee = "Undang Karyawan Baru",
        player_id = "ID Pemain...",
        invite = "Undang",
        select_role = "Pilih Peran",
        choose_role_for = "Pilih peran untuk %s",
        available_roles = "Peran Tersedia:",
        roles_available = "%d peran tersedia",
        send_invite = "Kirim Undangan",

        -- Sales Summary
        sales_summary = "Ringkasan Penjualan",
        today = "Hari Ini",
        this_week = "Minggu Ini",
        this_month = "Bulan Ini",
        view_sales = "Lihat Penjualan",

        -- Inventory Status
        inventory_status = "Status Inventaris",
        storage_capacity = "Kapasitas Penyimpanan",
        ingredients = "Bahan",
        supplies = "Perlengkapan",
        manage_inventory = "Kelola Inventaris",

        -- Menu Management
        search_menu_items = "Cari item menu...",
        edit_menu_item = "Edit Item Menu",
        update_item_details = "Perbarui detail item di bawah ini.",
        label_display_name = "Label (Nama Tampilan)",
        price = "Harga ($)",
        category = "Kategori",
        select_category = "Pilih kategori",
        update = "Perbarui",
        all_items = "Semua Item",
        no_menu_items = "Item menu tidak ditemukan",
        no_category_items = "%s tidak ditemukan",

        -- Vending Machine Management
        vending_machine_management = "Manajemen Mesin Penjual Otomatis",
        search_vending_items = "Cari item vending...",
        edit_vending_item = "Edit Item Vending",
        update_vending_details = "Perbarui detail item di bawah ini.",
        all_vending_items = "Semua Item",
        no_vending_items = "Item mesin penjual otomatis tidak ditemukan",
        no_category_vending_items = "%s tidak ditemukan",
        vending_update_error = "Gagal memperbarui item mesin penjual otomatis",
        item_price = "Harga",
        item_type = "Tipe",
        uncategorized = "Tidak Dikategorikan",
        enter_price = "mis., 5",

        -- Staff Management
        employee_overview = "Tinjauan Karyawan",
        total_employees = "Total Karyawan",
        active_employees = "Karyawan Aktif",
        pending_applications = "Aplikasi Tertunda",
        employee_list = "Daftar Karyawan",
        search_employees = "Cari karyawan...",
        all_employees = "Semua Karyawan",
        name = "Nama",
        role = "Peran",
        salary = "Gaji",
        last_seen = "Terakhir Dilihat",
        actions = "Tindakan",
        promote = "Promosikan",
        demote = "Turunkan",
        fire = "Pecat",
        employee_actions = "Tindakan Karyawan",
        select_action = "Pilih tindakan untuk %s",
        promote_employee = "Promosikan Karyawan",
        demote_employee = "Turunkan Karyawan",
        fire_employee = "Pecat Karyawan",
        confirm_action = "Konfirmasi Tindakan",
        confirm_promote = "Apakah Anda yakin ingin mempromosikan %s menjadi %s?",
        confirm_demote = "Apakah Anda yakin ingin menurunkan %s menjadi %s?",
        confirm_fire = "Apakah Anda yakin ingin memecat %s?",
        action_success = "Tindakan berhasil diselesaikan",
        action_failed = "Tindakan gagal",
        employee_promoted = "Karyawan berhasil dipromosikan",
        employee_demoted = "Karyawan berhasil diturunkan",
        employee_fired = "Karyawan berhasil dipecat",
        no_employees = "Karyawan tidak ditemukan",

            -- Job Grades Management Dialog
        manage_job_grades = "Kelola Tingkat Pekerjaan",
        configure_salary_commission = "Konfigurasikan gaji dan tingkat komisi untuk setiap posisi",
        search_job_grades = "Cari tingkat pekerjaan...",
        edit_job_grade = "Edit Tingkat Pekerjaan",
        update_job_grade_details = "Perbarui detail tingkat pekerjaan",
        job_title = "Judul Pekerjaan",
        commission_rate = "Tingkat Komisi",
        boss_access = "Akses Bos",
        boss_access_enabled = "Peran ini memiliki akses ke fitur manajemen",
        boss_access_disabled = "Peran ini memiliki akses tingkat karyawan",
        save_changes = "Simpan Perubahan",
        boss_role = "Peran Bos",
        grade_update_error = "Gagal memperbarui tingkat pekerjaan",

        -- Employee Details View
        employee_overview = "Detail Karyawan",
        employee_profile = "Profil Karyawan",
        performance_stats = "Metrik Kinerja",
        back = "Kembali",
        
        -- Employee Profile Card Labels
        commission = "Komisi",
        total_earnings = "Total Penghasilan",
        available_balance = "Saldo Tersedia",
        employee_id = "ID Karyawan",
        
        -- Performance Stats Labels
        deliveries_label = "Pengiriman",
        billings_label = "Penagihan",
        earnings_label = "Penghasilan",
        experience_label = "Pengalaman",
        level_label = "Level",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "Distribusi Pendapatan",
        delivery_income = "Pengiriman",
        commission_income = "Komisi",
        paycheck_income = "Gaji",
        completed_label = "selesai",
        bills_label = "tagihan",
        hourly_label = "Per Jam",

        -- Employee Card Labels (for list view)
        rank_label = "Pangkat",
        commission_label = "Komisi",

        -- Role Change Dialog
        no_role_employees = "%s tidak ditemukan",
        employee_updated = "Karyawan Diperbarui",
        employee_commission_updated = "Karyawan diperbarui dengan tingkat komisi %s",
        fire_employee_error = "Gagal memecat karyawan",

        -- Employee Leaderboard
        top_performers = "Kinerja Terbaik",
        this_month_leaders = "Pemimpin Bulan Ini",
        rank = "Peringkat",
        employee = "Karyawan",
        performance = "Kinerja",
        orders_completed = "Pesanan Selesai",
        revenue_generated = "Pendapatan Dihasilkan",
        customer_rating = "Peringkat Pelanggan",
        no_data = "Data kinerja tidak tersedia",

        -- Transactions
        transaction_history = "Riwayat Transaksi",
        recent_transactions = "Transaksi Terbaru",
        paycheck_history = "Riwayat Gaji",
        transaction_type = "Tipe Transaksi",
        amount = "Jumlah",
        date = "Tanggal",
        message = "Deskripsi",
        customer = "Pelanggan",
        filter_transactions = "Filter transaksi...",
        all_transactions = "Semua Transaksi",
        sales_only = "Hanya Penjualan",
        paychecks_only = "Hanya Gaji",
        no_transactions = "Transaksi tidak ditemukan",
        no_paychecks = "Catatan gaji tidak ditemukan",


        -- Settings
        avatar_settings = "Pengaturan Avatar",
        update_profile_picture = "Perbarui foto profil Anda",
        image_url = "URL Gambar",
        enter_url_preview = "Masukkan URL di bawah untuk melihat pratinjau avatar Anda",
        preview = "Pratinjau",
        enter_url_message = "Masukkan URL gambar avatar Anda",
        ui_theme = "Tema UI",
        customize_appearance = "Sesuaikan tampilan dasbor",
        light_mode = "Mode Terang",
        dark_mode = "Mode Gelap",

        -- Navigation
        home = "Beranda",
        staff = "Staf",
        menu = "Menu",
        sales = "Penjualan",
        top = "Atas",
        settings = "Pengaturan",

        -- Status Labels
        open = "Buka",
        closed = "Tutup",
        online = "Online",
        offline = "Offline",
        active = "Aktif",
        inactive = "Tidak Aktif",

        -- Common Actions
        save = "Simpan",
        edit = "Edit",
        delete = "Hapus",
        confirm = "Konfirmasi",
        close = "Tutup",
        refresh = "Segarkan",
        loading = "Memuat...",

        -- Error Messages
        error_occurred = "Terjadi kesalahan",
        invalid_input = "Input tidak valid",
        operation_failed = "Operasi gagal",
        permission_denied = "Izin ditolak",
        network_error = "Kesalahan jaringan",
        data_load_failed = "Gagal memuat data",

        -- Success Messages
        operation_successful = "Operasi berhasil diselesaikan",
        data_saved = "Data berhasil disimpan",
        changes_applied = "Perubahan berhasil diterapkan",
    },

    Shop = {
        shop_status = "Status Toko",
        shop_open = "Toko Buka",
        shop_closed = "Toko Tutup",
        access_denied = "Anda tidak dapat mengakses toko ini!",
        purchase_title = "Toko",
        purchase_success = "Pembelian selesai! Item ditambahkan ke inventaris Anda.",
        purchase_error = "Checkout gagal!",

        -- Search and Inventory
        search_placeholder = "Cari produk berdasarkan nama...",
        clear_search = "Hapus pencarian",
        shop_inventory = "Inventaris Toko",
        items_count = "item",

        -- Product Actions
        add_to_cart = "Tambah",
        per_item = "per/item",

        -- Cart
        your_cart = "Keranjang Anda",
        cart_empty = "Keranjang Kosong",
        cart_empty_message = "Tambahkan item untuk mulai berbelanja",
        items_label = "item",
        total = "Total",

        -- Search Results
        no_items_found = "Item tidak ditemukan",
        no_items_message = "Coba sesuaikan pencarian Anda atau jelajahi semua item",

        -- Payment
        pay_with_cash = "Tunai",
        pay_with_bank = "Bank",
        processing = "Memproses...",
        inventory_notice = "Item akan ditambahkan langsung ke inventaris Anda",

        -- Notifications
        cart_updated = "Keranjang Diperbarui",
        item_added = "Item Ditambahkan",
        item_removed = "Item Dihapus",
        quantity_updated = "Jumlah Diperbarui",
        purchase_complete = "Pembelian Selesai",
        transaction_failed = "Transaksi Gagal",
        checkout_error = "Kesalahan Checkout",
        cart_empty_error = "Keranjang Anda kosong",
        paid_with_cash = "Dibayar dengan tunai",
        charged_to_bank = "Ditagihkan ke rekening bank Anda",
        not_enough_cash = "Uang tunai tidak cukup",
        insufficient_bank = "Saldo bank tidak mencukupi",

        -- Quantity Messages
        added_more = "Menambahkan %d lagi %s",
        removed_items = "Menghapus %d %s",
        added_to_cart = "%s ditambahkan ke keranjang",
        removed_from_cart = "Menghapus %s dari keranjang Anda",

        -- Loading
        loading_shop = "Memuat Menu Toko...",
    },

    EmployeeMenu = {
        access_denied = "Anda tidak dapat mengakses portal ini!",
        commission_withdrawn = "Komisi Ditarik",
        commission_withdrawn_description = "Anda telah menarik $%s dari saldo komisi ke %s Anda.",
        transaction_failed = "Transaksi Gagal",
        fire_employee = "Pecat Karyawan",
        fire_employee_description = "%s telah dipecat dari bisnis Anda!",
        employeeMent_notice = "Pemberitahuan Karyawan",
        
        no_employee_active = "Tidak ada karyawan yang sedang online dan aktif untuk menangani pesanan Anda.",
        -- Main Headers and Navigation
        employee_portal = "Portal Karyawan",
        employee_profile = "Profil Karyawan",
        performance_stats = "Statistik Kinerja",
        employee_leaderboard = "Papan Peringkat Karyawan",
        job_outfits = "Seragam Kerja",
        account_settings = "Pengaturan Akun",

        -- Navigation Labels
        profile = "Profil",
        stats = "Statistik",
        top = "Atas",
        outfits = "Seragam",
        settings = "Pengaturan",

        -- Profile Tab
        personal_information = "Informasi Pribadi",
        paycheck_information = "Informasi Gaji",
        job_role = "Peran Pekerjaan",
        salary = "Gaji",
        experience = "Pengalaman",
        duty_status = "Status Tugas",
        on_duty = "Bertugas",
        off_duty = "Tidak Bertugas",
        clock_in = "Masuk Kerja",
        clock_out = "Pulang Kerja",
        available_balance = "Saldo Tersedia",
        withdraw = "Tarik",
        withdraw_funds = "Tarik Dana",
        paycheck_interval = "Interval Gaji",
        total_deliveries = "Total Pengiriman",
        bills_created = "Tagihan Dibuat",
        total_earnings = "Total Penghasilan",
        minutes = "menit",

        -- Performance Tab
        career_statistics = "Statistik Karir",
        experience_points = "Pengalaman",
        xp_points = "Poin XP",
        total_earned = "Total Diperoleh",
        current_balance = "Saldo Saat Ini",
        deliveries = "Pengiriman",
        total_completed = "Total Selesai",
        billings = "Penagihan",
        invoices_created = "Faktur Dibuat",
        job_grade_progression = "Kemajuan Tingkat Pekerjaan",
        current_grade = "Tingkat Saat Ini",
        level = "Level",
        xp_needed_promotion = "XP diperlukan untuk promosi",
        earn_more_xp = "Dapatkan %d XP lagi untuk dipromosikan menjadi %s",
        max_grade_reached = "Anda telah mencapai tingkat otomatis tertinggi! Promosi lebih lanjut memerlukan persetujuan manajemen.",
        promotions_by_management = "Promosi diberikan oleh manajemen.",
        loading_experience_data = "Memuat data sistem pengalaman...",
        loading_progression_data = "Memuat data kemajuan...",

        -- Leaderboard Tab
        top_performers = "Kinerja Terbaik",
        this_month_leaders = "Pemimpin Bulan Ini",
        rank = "Peringkat",
        employee = "Karyawan",
        performance = "Kinerja",
        no_leaderboard_data = "Data papan peringkat tidak tersedia",

        -- Outfits Tab
        work_outfits = "Seragam Kerja",
        select_outfit = "Pilih Pakaian",
        change_outfit = "Ganti Pakaian",
        outfit_changed = "Pakaian Diganti",
        outfit_changed_success = "Pakaian Anda berhasil diganti!",
        outfit_change_failed = "Gagal mengganti pakaian",
        outfit_preview = "Pratinjau Pakaian",

        -- Settings Tab
        employee_settings = "Pengaturan Karyawan",
        avatar_settings = "Pengaturan Avatar",
        update_profile_picture = "Perbarui foto profil Anda",
        image_url = "URL Gambar",
        enter_url_preview = "Masukkan URL di bawah untuk melihat pratinjau avatar Anda",
        preview = "Pratinjau",
        enter_url_message = "Masukkan URL gambar avatar Anda",
        avatar_updated = "Avatar Diperbarui",
        avatar_created = "Avatar Dibuat",
        avatar_updated_message = "Avatar berhasil diperbarui!",
        update_failed = "Pembaruan Gagal",
        update_failed_message = "Gagal memperbarui avatar",
        invalid_url = "URL Tidak Valid",
        invalid_url_message = "Silakan masukkan URL gambar yang valid",
        updating = "Memperbarui...",
        update_avatar = "Perbarui Avatar",

        -- UI Theme
        ui_theme = "Tema UI",
        customize_appearance = "Sesuaikan tampilan dasbor",
        light_mode = "Mode Terang",
        dark_mode = "Mode Gelap",

        -- Notifications
        notifications = "Pemberitahuan",
        manage_notification_preferences = "Kelola preferensi pemberitahuan",
        employee_notifications = "Pemberitahuan Karyawan",
        notifications_enabled_desc = "Anda akan menerima semua pembaruan gaji karyawan",
        notifications_disabled_desc = "Anda tidak akan menerima pemberitahuan",
        notifications_updated = "Pemberitahuan Diperbarui",
        notifications_enabled_message = "Pemberitahuan gaji sekarang diaktifkan",
        notifications_disabled_message = "Pemberitahuan gaji sekarang dinonaktifkan",
        enabled = "Diaktifkan",
        disabled = "Dinonaktifkan",

        -- Withdrawal Dialog
        withdraw_all_funds = "Tarik Semua Dana",
        select_balance_type = "Pilih Tipe Saldo",
        all_balance = "Semua Saldo",
        delivery_balance = "Saldo Pengiriman",
        commission_balance = "Saldo Komisi",
        paycheck_balance = "Saldo Gaji",
        available_balance_type = "Saldo %s Tersedia: $%d",
        enter_amount = "Masukkan jumlah",
        insufficient_funds = "Dana Tidak Mencukupi",
        insufficient_balance = "Saldo %s tidak mencukupi",
        funds_withdrawn = "Dana Ditarik",
        funds_withdrawn_success = "Berhasil menarik $%d dari saldo Anda",
        transaction_failed = "Transaksi Gagal",
        withdrawal_failed = "Gagal menarik dana",
        invalid_amount = "Jumlah Tidak Valid",
        invalid_amount_message = "Silakan masukkan jumlah yang valid",
        no_funds = "Tidak Ada Dana",
        no_funds_message = "Anda tidak memiliki dana untuk ditarik",

        -- Common Actions
        cancel = "Batal",
        save = "Simpan",
        update = "Perbarui",
        confirm = "Konfirmasi",
        close = "Tutup",
        loading = "Memuat...",

        -- Status Labels
        active = "Aktif",
        inactive = "Tidak Aktif",
        online = "Online",
        offline = "Offline",

        -- Error Messages
        error_occurred = "Terjadi kesalahan",
        operation_failed = "Operasi gagal",
        data_load_failed = "Gagal memuat data",
        network_error = "Kesalahan jaringan",
        employee_data_error = "Tidak dapat mengambil data karyawan Anda.",
        identity_error = "Tidak dapat memverifikasi identitas Anda.",
        withdraw_invalid_amount = "Jumlah tidak valid!",
        insufficient_commission = "Saldo komisi tidak mencukupi!",
        transaction_failed_update = "Gagal memperbarui saldo komisi!",
        fire_employee_not_found = "Karyawan tidak ditemukan!",
        fire_employee_wrong_business = "Karyawan ini tidak bekerja untuk bisnis Anda!",
        fire_employee_db_error = "Gagal memecat karyawan dari database!",
        employment_notice_fired = "Anda telah dipecat dari %s",
        avatar_invalid_url = "URL gambar yang diberikan tidak valid.",
        avatar_updated_success = "Avatar profil Anda berhasil diperbarui.",
        avatar_no_changes = "Tidak ada perubahan yang dibuat pada avatar Anda.",
        avatar_created = "Profil karyawan dan avatar Anda telah dibuat.",
        avatar_create_failed = "Gagal membuat catatan karyawan.",
        withdrawal_invalid_amount = "Jumlah penarikan tidak valid.",
        employee_record_not_found_withdraw = "Catatan karyawan tidak ditemukan.",
        insufficient_balance_withdraw = "Dana tidak cukup dalam saldo Anda.",
        withdraw_balance_failed = "Gagal menarik dari saldo. Silakan coba lagi.",
        identity_error_toggle = "Tidak dapat memverifikasi identitas Anda",
        invalid_grade_data = "Data tingkat tidak valid diberikan.",
        grade_id_not_found = "Tidak dapat menemukan ID tingkat untuk peran ini.",
        no_grade_changes = "Tidak ada perubahan yang dibuat pada tingkat pekerjaan.",
        balance_withdrawn = "Anda menarik $%d dari saldo %s Anda ke %s Anda.",
        player_not_found = "Pemain tidak ditemukan!",
        invalid_purchase_data = "Data pembelian tidak valid!",
        insufficient_funds = "Dana tidak cukup di %s Anda!",
        inventory_full = "Ruang inventaris tidak cukup atau batas berat terlampaui!",
        purchase_complete = "Pembelian selesai! Item ditambahkan ke inventaris Anda.",
        shop_purchase = "Pembelian Toko: %s",
        business_balance_error = "Kesalahan memperbarui saldo bisnis untuk %s",
        business_balance_success = "Berhasil menambahkan $%s ke akun bisnis",
        transaction_record_error = "Kesalahan mencatat transaksi untuk pembelian toko",
        avatar_found = "Toko: Menemukan avatar untuk %s: %s",
        avatar_not_found = "Toko: Tidak ada avatar ditemukan untuk %s, menggunakan default",
    },

    Vending = {
        invalid_item_data = "Data item tidak valid.",
        insufficient_item = "Anda tidak memiliki cukup item ini.",
        item_added_with_money = "Item ditambahkan ke stok. Diterima $%s untuk %sx %s",
        item_added = "Item ditambahkan ke stok.",
        business_balance_error = "Kesalahan memperbarui saldo bisnis untuk pemesanan",
        database_error = "Kesalahan Database",
        add_item_failed = "Gagal menambahkan item.",
        invalid_collection_data = "Data pengambilan tidak valid.",
        inventory_full = "Tidak dapat menambahkan item ke inventaris Anda.",
        item_collected = "Mengambil %sx %s",
        stock_update_failed = "Gagal memperbarui stok mesin penjual otomatis.",
        out_of_stock = "Stok Habis",
        insufficient_stock = "Tidak cukup item tersedia untuk diambil.",
        sale_transaction_error = "Kesalahan mencatat transaksi penjualan vending",
        collection_transaction_error = "Kesalahan mencatat transaksi pengambilan vending",
    },

    JobSystem = {
        no_permission = "Anda tidak memiliki izin untuk menggunakan perintah ini.",
        player_not_found = "Pemain tidak ditemukan.",
        job_assigned = "Pekerjaan ditugaskan.",
        job_assign_failed = "Gagal menugaskan pekerjaan.",
        job_removed = "Pekerjaan dihapus.",
        job_remove_failed = "Gagal menghapus pekerjaan.",
        job_changed_notification = "Pekerjaan Diubah",
        job_changed = "Pekerjaan Anda telah diubah menjadi %s (tingkat %s).",
        job_removed_notification = "Pekerjaan Anda telah dihapus.",
        give_job_usage = "Penggunaan: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "Penggunaan: /%s [playerId]",
        job_info = "Pekerjaan: %s (Tingkat: %s, Tugas: %s)",
        job_info_error = "Tidak bisa mendapatkan info pekerjaan Anda.",
        duty_status = "Anda sekarang %s tugas.",
        not_on_duty = "Tidak Bertugas",
        must_be_on_duty = "Anda harus bertugas untuk menerima gaji.",
        paycheck_title = "Gaji",
        employer_insufficient_funds = "Bos Anda tidak memiliki cukup dana untuk membayar Anda.",
        paycheck_added = "Gaji sebesar $%s ditambahkan ke saldo karyawan untuk %s untuk pekerjaan: %s",
        paycheck_received = "Anda menerima gaji sebesar $%s dari %s",
    },

    BillingInviteNotification = {
        message = "Anda telah menerima permintaan pembayaran.",

        -- Titles / headers
        title = "Permintaan Pembayaran",
        label = "Pemberitahuan Penagihan",

        -- Button labels
        pay_button = "Bayar Tagihan",
        decline_button = "Tolak",

        -- Small UI labels used inside the notification component
        business_label = "Bisnis",
        total_amount_label = "Jumlah Total",
        reason_label = "Alasan",
        amount_label = "Jumlah:",

        -- Warning / helper texts
        warning_text = "Pembayaran akan dipotong dari akun Anda. Pastikan dana mencukupi.",
        expires_text = "Berakhir dalam %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "Anda telah diundang untuk bergabung sebagai %s di Burgershot. Apakah Anda menerima?",

        -- Titles / headers
        title = "Undangan Kerja",
        label = "Pemberitahuan Undangan Kerja",

        -- Button labels
        accept_button = "Terima",
        reject_button = "Tolak",

        -- Small UI labels used inside the notification component
        company_label = "Perusahaan",
        grade_label = "Tingkat",
        invites_left_label = "Sisa Undangan",
        salary_label = "Gaji",

        -- Warning / helper texts
        warning_text = "Menerima pekerjaan ini akan mengikat Anda pada peran tersebut. Pastikan Anda siap untuk memulai.",
        expires_text = "Berakhir dalam %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "Menu Restoran",
        onduty = "Anda harus bertugas untuk mengakses menu restoran.",
    },

    Duty = {
        status = "Status Tugas",
        management = "Manajemen Tugas",
        description = "Anda sekarang %s tugas.",
        restaurant_area = "Area Restoran",
        clock_in = "Anda telah memasuki area restoran. Gunakan menu karyawan untuk masuk kerja.",
        enter_workplace = "Anda telah memasuki tempat kerja Anda dan sekarang bertugas.",
        leave_workplace = "Anda telah meninggalkan tempat kerja Anda dan sekarang tidak bertugas.",
        inside_workplace = "Anda berada di dalam tempat kerja Anda - secara otomatis diatur ke bertugas.",
        outside_workplace = "Anda berada di luar tempat kerja Anda - secara otomatis diatur ke tidak bertugas.",
        duty_warning = "Peringatan Tugas",
        auto_off_duty = "Anda akan secara otomatis diatur tidak bertugas saat berada di luar restoran.",
        no_permission_manage_duty = "Anda tidak memiliki izin untuk mengelola status tugas karyawan",
        not_employee_of_job = "Pemain bukan karyawan dari pekerjaan ini",
        duty_set_by_management = "Status tugas Anda diatur ke %s oleh manajemen",
        duty_management_success = "Berhasil mengatur status tugas %s ke %s",
        updated_offline_employee = "Memperbarui status tugas karyawan offline",
    },

    Paycheck = {
        title = "Gaji Diterima",
        message = "Anda menerima gaji sebesar $%s dari %s",
    },

    VendingMachine = {
        sell_item = "Jual Item",
        select_item_from_inventory = "Pilih Item dari Inventaris",
        add_to_vending = "TAMBAHKAN %s KE VENDING",
        cancel = "BATAL",
        no_matching_items = "Tidak ada item yang cocok di inventaris",
        stocked_items = "Item Stok",
        sell = "Jual",
        no_stock = "Tidak Ada Stok",
        items = "item stok",
        ready_to_serve = "Siap Melayani!",
    },

    EmployeeVendingMachine = {
        title = "Ambil dari Mesin Penjual Otomatis",
        label = "Ambil item dari stok mesin penjual otomatis",
        collect = "Ambil",
        cancel = "Batal",
        quantity_available = "Jumlah (Tersedia: %s)",
        collect_item = "Ambil %s",
        collect_button = "Ambil",
        in_stock = "Dalam Stok",
        vending_machine_empty = "Mesin penjual otomatis ini kosong.",
    },

    OrderingTab = {
        where_eating_today = "Makan di mana hari ini?",
        eat_in = "Makan di Sini",
        take_out = "Bawa Pulang",
        whats_up = "ada apa?",
        popular = "Populer",
        done = "Selesai",
        my_order = "Pesanan Saya",
        empty = "Kosong",
        total = "Total",
        checkout = "Checkout",
        back = "Kembali",
        no_menu_items = "Tidak ada item menu tersedia untuk %s",
        loading = "Memuat...",
        eat_in_label = "Makan di Sini",
        take_out_label = "Bawa Pulang",
        pay_cash = "Tunai",
        cancel = "Batal",
        order = "Pesan",
        pay_bank = "Bank",
        all_items = "Semua Item",
        bank_only_disclaimer = "Pembayaran hanya dapat dilakukan melalui bank.",
    },

    OrderManagementTable = {
        title = "Panel Manajemen Pesanan",
        label = "Administrasi Pesanan",
        filter_all = "Semua",
        filter_cooking = "Memasak",
        filter_ready = "Siap",
        filter_completed = "Selesai",
        filter_terminal_orders = "Pesanan Terminal",
        filter_self_pickup = "Pesanan Kiosk",
        sort_by = "Urutkan Berdasarkan",
        sort_day = "Hari",
        sort_amount = "Jumlah",
        sort_name = "Nama",
        no_orders = "Tidak ada pesanan yang cocok dengan filter saat ini.",
        accept = "TERIMA",
        accepting = "MENERIMA...",
        cooking = "MEMASAK",
        ready = "SIAP",
        complete = "SELESAI",
        completed = "SELESAI",
        assigned_to = "Ditugaskan ke: ",
        items_label = "Item:",
        order_label = "Pesanan #",
        status_cooking = "memasak",
        status_ready = "siap",
        status_completed = "selesai",
        status_cancelled = "dibatalkan",
        self_pickup = "Ambil Sendiri",
    },

    MenuSelectionDialog = {
        title = "Pilih Tindakan",
        subtitle = "Apa yang ingin Anda lakukan?",
        options = {
            shop = {
                title = "Buka Toko",
                description = "Jelajahi dan beli item dari mesin penjual otomatis"
            },
            manageBoss = {
                title = "Kelola Toko",
                description = "Kelola inventaris, lihat analitik, dan kendalikan mesin penjual otomatis"
            },
            manageEmployee = {
                title = "Kelola Toko",
                description = "Tambahkan dan kelola item inventaris di mesin penjual otomatis"
            }
        }
    },
}