-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["es"] = {

    MenuSelectionDialog = {
        title = "Elegir Acción",
        subtitle = "¿Qué te gustaría hacer?",
        options = {
            shop = {
                title = "Abrir Tienda",
                description = "Navegar y comprar artículos de la máquina expendedora"
            },
            manageBoss = {
                title = "Administrar Tienda",
                description = "Administrar inventario, ver análisis y controlar la máquina expendedora"
            },
            manageEmployee = {
                title = "Administrar Tienda",
                description = "Agregar y administrar artículos de inventario en la máquina expendedora"
            }
        }
    },

    WashHands = {
        title = "Lavabo",
        no_available = "No hay lavabo disponible",
        success = "¡Tus manos están limpias ahora!",
        error = "Error",
        fail = "¡Tus manos ya están limpias!",
        targetfail = "¡Necesitas lavar las manos primero!",
        item_cleaned = "¡Artículo limpiado exitosamente!",
        missing_required = "No tienes los artículos requeridos"
    },

    Terminal = {
        SubmitText = "Enviar Factura",

        -- Player Selection Tab
        select_player = "Seleccionar Jugador",
        nearby_players = "Jugadores Cercanos",
        search_players = "Buscar jugadores...",
        no_players_found = "No se encontraron jugadores cerca",
        loading_players = "Cargando jugadores...",
        player_selected = "Jugador Seleccionado",

        -- Menu Items Tab
        menu_items = "Artículos del Menú",
        items_added = "artículos añadidos",
        search_menu_items = "Buscar artículos del menú...",
        available_items = "Artículos Disponibles",
        selected_items = "Artículos Seleccionados",
        no_items_found = "No se encontraron artículos",
        no_items_selected = "No se seleccionaron artículos",
        total_items = "Total de Artículos",
        total = "Total",
        all = "Todo",

        -- Finalize Bill Tab
        finalize_bill = "Finalizar Factura",
        customer_info = "Información del Cliente",
        order_summary = "Resumen del Pedido",
        amount_label = "Monto ($)",
        enter_amount = "Ingresar monto",
        reason_label = "Razón (Opcional)",
        reason_placeholder = "Ingresar razón para la factura",
        payment_method = "Método de Pago",
        cash = "Efectivo",
        bank = "Banco",
        send_bill = "Enviar Factura",

        -- Commission
        your_commission = "Tu Comisión",
        commission_rate = "Tasa de Comisión",

        -- Bills sent counter
        bills_sent = "Facturas enviadas:",
        commission = "Comisión:",

        -- Error Messages
        bill_error = "Error de Factura",
        select_player_error = "Por favor selecciona un jugador",
        invalid_amount_error = "Por favor ingresa un monto válido",

        -- Success Messages
        bill_sent_success = "¡Factura enviada exitosamente!",
        bill_sent_title = "Factura Enviada",
    },

    Consumable = {
        Drinking = "Bebiendo ", -- Drinking ItemName
        Eating = "Comiendo " -- Eating ItemName
    },

    Garage = {
        title = "Garaje",
        no_vehicle = "No hay vehículo para devolver",
        not_job_vehicle = "Este no es un vehículo de Burgershot!",
        parked_title = "Vehículo Estacionado!",
        parked_message = "Tu vehículo ha sido estacionado en esta ubicación!",
        in_vehicle = "¡No puedes estar en un vehículo!",
        too_far = "¡Estás demasiado lejos del vehículo!",
        spawn_error = "¡No puedes hacer esto ahora!",

        -- UI Text
        garage_title = "Garaje",
        garage_active_vehicles = "Activo",
        garage_manage = "Administrar Vehículos Activos",
        close = "Cerrar",
        search_vehicles = "Buscar vehículos...",
        no_vehicles_found = "No se encontraron vehículos",
        dont_have_vehicle = "No tienes ningún vehículo almacenado en este garaje.",
        select_vehicle = "Seleccionar un Vehículo",
        select_vehicle_message = "Elige un vehículo de la lista para ver sus detalles y generarlo.",
        back = "Atrás",
        spawn_vehicle = "Generar Vehículo",
        return_button = "Devolver",
        return_vehicle = "Devolver Vehículo",
        license_plate = "Placa de Licencia",

        -- Status Messages
        vehicle_spawned = "Vehículo generado exitosamente",
        no_vehicle_to_return = "No hay vehículo para devolver",
        access_denied = "No tienes acceso a este garaje.",
        all_spawn_points_blocked = "Todos los puntos de generación están bloqueados actualmente. Espera un momento.",
        vehicle_model_not_exist = "El modelo de vehículo no existe",
        failed_load_model = "Error al cargar el modelo de vehículo",
        failed_create_vehicle = "Error al crear el vehículo",
        invalid_vehicle_data = "Datos del modelo de vehículo inválidos",

        -- Error Messages
        error = "Error",
        garage_error = "Error de Garaje",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "Error al crear la entidad del vehículo",
        no_spawn_points_available = "No hay puntos de generación disponibles",
        vehicle_returned_parked = "Vehículo devuelto y estacionado.",
        vehicle_processed_remote = "Vehículo procesado (Devolución Remota).",
    },

    Billing = {
        title = "Facturación",
        payment_failed_byreceiver = "Pago fallido: %s no tiene fondos suficientes en %s.",
        business_closed = "La facturación está deshabilitada actualmente por la gerencia.",
        commission_earned = "Comisión Ganada",
        commission_earned_description = "Has ganado $%s en comisión.",
        terminal_title = "Terminal de Facturación",
        off_duty_error = "Necesitas estar de turno para usar la terminal de facturación.",
        access_denied = "No tienes acceso a la terminal de facturación.",
        business_closed = "La facturación está deshabilitada actualmente por la gerencia.",
        payment_received = "Pago Recibido",
        payment_received_message = "Pago de $%s recibido de %s",
        payment_failed = "Pago Fallido",
        payment_failed_message = "El pago de la factura falló",
        bill_sent = "Factura Enviada",
        bill_sent_success = "¡Factura enviada exitosamente!",
        bill_sent_error = "Error al enviar la factura.",
        bill_error = "Error de Factura",
        invalid_bill = "¡Factura inválida!",
        invalid_bill_description = "La factura que intentas pagar no existe.",
        invalid_target_amount = "¡Objetivo o monto inválido!",
        player_not_found = "¡Jugador no encontrado!",
        must_be_on_duty = "¡Debes estar de turno para enviar facturas!",
        bill_sent_description = "Enviaste una factura de $%s a %s por %s",
        bill_payment_successful = "✅ Pago de Factura Exitoso",
        bill_payment_failed_insufficient = "❌ Pago de Factura Fallido - Fondos Insuficientes",
        bill_rejected = "❌ Factura Rechazada",
        insufficient_funds = "¡No tienes suficientes %s!",
        order_processed = "🍔 Pedido Procesado",
        command_access_denied = "¡No puedes usar este comando!",
        payment_failed_insufficient = "¡No tienes suficientes %s!",
        bill_rejected_title = "Factura Rechazada",

        bill_rejected_sender = "%s rechazó tu factura de $%s",
        bill_rejected_receiver = "Rechazaste la factura de %s",
        billing_disabled = "La facturación está deshabilitada actualmente por la gerencia.",
        billing_off_duty = "Debes estar de turno para usar la facturación.",
    },

    Delivery = {
        items_header = "Artículos para Entregar",
        reward_header = "Recompensa",
        accept_header = "Aceptar Entrega",
        decline_header = "Rechazar Entrega",
        menu_header = "Menú de Entrega",
        no_delivery = "¡No hay entrega activa!",
        new_delivery_title = "Nueva Entrega",
        new_delivery_desc = "Has recibido una nueva solicitud de entrega.",
        delivery_expired = "Tu solicitud de entrega ha expirado.",
        delivery_timeout = "Tomaste demasiado tiempo para completar la entrega.",
        delivery_declined = "Rechazaste la solicitud de entrega.",
        check_location = "Revisa tu GPS para la ubicación de entrega.",
        check_location_error = "No tienes una entrega activa para rastrear.",
        delivery_accepted = "Entrega Aceptada",
        invalid_item = "Artículo inválido en la entrega",
        delivery_failed = "Entrega Fallida",
        invalid_items_data = "Datos de artículo inválidos",

        -- UI Text
        delivery_title = "Entrega",
        close_menu = "Cerrar",
        new_order = "Nuevo Pedido",
        in_progress = "En Progreso",
        order_items = "Artículos del Pedido:",
        payment = "Pago",
        delivery_status = "Estado de Entrega",
        deliver_instruction = "Entrega la comida en la ubicación marcada en tu mapa.",
        time_remaining = "Tiempo restante:",
        order_summary = "Resumen del Pedido:",
        accept = "Aceptar",
        decline = "Rechazar",
        cancel_delivery = "Cancelar Entrega",

        -- Notifications
        delivery_accepted_notification = "Entrega Aceptada Exitosamente",
        delivery_cancelled_notification = "Entrega Cancelada Exitosamente",

        -- Status Messages
        complete_delivery = "Completar Entrega",
        delivery_in_progress = "Entrega en progreso...",
        head_to_location = "Dirígete a la ubicación marcada para completar la entrega",
    },

    Consumption = {
        title = "Consumo",
        description = "Fresco y delicioso!",
        refresh_title = "Refrescante",
        refresh_description = "Te sientes refrescado",
    },

    Crafting = {
        craft_title = "Fabricar: %s",
        enter_amount_description = "Ingresa la cantidad a fabricar",
        crafting_successful = "Fabricación Exitosa",
        crafted_description = "Fabricaste %d x %s",
        crafting_cancelled = "Fabricación Cancelada",
        cancelled_description = "Cancelaste la fabricación",
        no_space = "No hay suficiente espacio en el inventario",
    },

    Targets = {
        door = "Llamar a la Puerta",
        door_icon = "fas fa-door-open",
        delivery_food = "Entregar Comida",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "Tableta de Pedidos",
        ordering_tablet_error = "La función de tableta de pedidos no está disponible.",
        order_management_tablet = "Tableta de Gestión de Pedidos",
        order_management_error = "La función de tableta de gestión de pedidos no está disponible.",
        return_utensils = "Devolver Utensilios",
        employee_vending = "Vending de Empleados",
    },

    Order = {
        complete = "Pedido Completo",
        description = "Tu pedido ha sido procesado. Factura añadida al inventario.",
        paycheck_suspended_description = "Los cheques de pago están suspendidos mientras el negocio está cerrado.",
        paycheck_suspended = "Cheque de Pago Suspendido",
    },

    Door = {
        title = "Puerta ",
        description = "La puerta ha sido ",
        locked = "La puerta está cerrada",
        no_permissions = "No tienes permiso para abrir/cerrar esta puerta",
        access_denied_title = "Acceso Denegado",
        access_granted = "Abriste la puerta",
        access_denied = "No tienes acceso a esta puerta",
    },

    Outfits = {
        title = "Trajes",
        invalid = "Género inválido",
        failed_equip = "Error al equipar traje",
        disabled = "Los trajes están deshabilitados",
        civilian_clothes = "Cambiado a Ropa Civil",
        reset_civilian_clothes = "Has vuelto a la Ropa Civil",
        no_civilian_saved = "No hay traje civil guardado. Cambia a uniforme primero.",
        no_permission = "No tienes permiso para usar este traje",
        outfit_not_found = "Traje no encontrado",
        equip_success = "Traje equipado exitosamente",
        changed_to_uniform = "Te has cambiado al %s",
        reset_success = "Traje reiniciado exitosamente",
        no_civilian_for_reset = "No hay traje civil guardado. Cambia a uniforme primero para guardar tu ropa actual.",
    },

    System = {
        success = "Éxito",
        paycheck_error = "Error de Cheque de Pago",
        inventory_full = "Inventario Lleno",
        inventory_full_description = "Tu inventario está lleno.",
        society_not_found = "Negocio no encontrado",
        business_funds_insufficient = "El negocio no tiene fondos suficientes para pagar tu cheque de pago.",
        error = "Error",
        invalid = "Inválido",
        no_license = "No se pudo determinar tu licencia. Contacta a un administrador.",
        missing_items = "Artículos Faltantes",
        item_cleaned = "Artículo limpiado exitosamente",
        missing_required = "No tienes los artículos requeridos",
        slot_error = "Pon la cantidad en el mismo slot",
        ice_collected = "El hielo ha sido recolectado",
        refreshing = "Refrescando",
        refreshed = "Te sientes refrescado",
        consumption = "Consumo",
        stress_increased = "Estrés Aumentado",
        stress_amount = "Tu nivel de estrés aumentó en %s",
        inventory_full = "Tu inventario está lleno",
    },

    Experience = {
        gained_title = "Experiencia Ganada",
        experience_earned_description = "Ganaste %d XP.",
        gained_message = "Ganaste %d XP por completar la entrega!",
    },

    BossMenu = {
        title = "Menú del Jefe",
        unable_jobdetermine = "No se pudo determinar tu trabajo. Inténtalo de nuevo más tarde.",
        bankruptcy_alert = "⚠️ Alerta de Quiebra",
        description = "No se pueden pagar salarios! Balance del negocio: $%s, Requerido: $%s",
        trans_failed_bossmenubalance = "Transacción Fallida - Fondos Insuficientes del Negocio",
        menu_in_use = "El menú del jefe está en uso por %s.",
        no_permissions = "¡No tienes permisos de jefe! Necesitas ser Jefe.",
        wrong_job = "No tienes el trabajo correcto",
        grade_updated = "Grado de Trabajo Actualizado",
        grade_update_success = "Grado %s actualizado exitosamente.",
        menu_update = "Actualización de Menú",
        menu_update_success = "Artículo del menú actualizado exitosamente!",
        vending_update = "Máquina Expendedora",
        vending_update_success = "Artículo de máquina expendedora actualizado exitosamente!",
        menu_update_error = "¡Error al actualizar artículo del menú!",
        menu_delete = "Eliminar Menú",
        menu_delete_success = "Artículo del menú eliminado exitosamente!",
        menu_delete_error = "¡Error al eliminar artículo del menú!",
        invite_sent = "Invitación Enviada",
        invite_sent_success = "Invitación de trabajo enviada a %s",
        invite_error = "¡ID de jugador o rol inválido!",
        player_not_found = "¡Jugador no encontrado!",
        job_error = "¡Datos de invitación inválidos!",
        job_accepted = "Ahora eres un %s en %s",
        job_updated_title = "Trabajo Actualizado",
        job_updated = "Tu posición fue actualizada a %s en %s",
        database_error = "Tu trabajo fue establecido pero la actualización de la base de datos falló.",
        invite_rejected = "Rechazaste la invitación de trabajo.",
        withdraw_error = "¡Monto inválido!",
        business_error = "¡Negocio no encontrado!",
        insufficient_funds = "¡Fondos insuficientes del negocio!",
        money_withdrawn = "Has retirado $%s de la cuenta del negocio.",
        transaction_failed = "Error al actualizar la cuenta del negocio!",
        money_deposited = "Has depositado $%s en la cuenta del negocio.",
        transaction_failed_refund = "Error al actualizar la cuenta del negocio! Tu dinero ha sido devuelto.",
        shop_purchase = "Nueva Compra en Tienda",
        shop_purchase_notification = "%s compró artículos por $%s",
        menu_occupied = "El menú del jefe está en uso",
        menu_occupied_by = "%s está usando el menú del jefe actualmente. Inténtalo de nuevo más tarde.",
        menu_released = "El menú del jefe está disponible ahora",

        -- Main Headers and Titles
        business_overview = "Resumen del Negocio",
        business_settings = "Configuraciones del Negocio",
        menu_management = "Gestión del Menú",
        staff_management = "Gestión del Personal",
        employee_leaderboard = "Tabla de Líderes de Empleados",
        sales_transactions = "Ventas y Transacciones",

        -- Finance Section
        finance = "Finanzas",
        business_balance = "Balance del Negocio",
        withdraw = "Retirar",
        deposit = "Depositar",
        withdraw_money = "Retirar Dinero",
        deposit_money = "Depositar Dinero",
        enter_amount_withdraw = "Ingresa el monto que deseas retirar de la cuenta del negocio a tu %s.",
        enter_amount_deposit = "Ingresa el monto que deseas depositar de tu %s en la cuenta del negocio.",
        available = "Disponible",
        enter_amount = "Ingresar monto",
        withdraw_to = "Retirar a %s",
        deposit_from = "Depositar de %s",
        updating = "Actualizando...",
        update_avatar = "Actualizar Avatar",
        cancel = "Cancelar",
        cash = "Efectivo",
        bank = "Banco",
        invalid_url = "URL Inválida",
        invalid_url_message = "Por favor ingresa una URL de imagen válida",
        avatar_updated = "Avatar Actualizado",
        avatar_updated_message = "¡Avatar actualizado exitosamente!",
        update_failed = "Actualización Fallida",
        update_failed_message = "Error al actualizar avatar",
        business_status = "Estado del Negocio",
        business_status_desc = "Controla el estado operativo de tu negocio",
        business_operations = "Operaciones del Negocio",
        business_open = "Aceptando clientes actualmente - Facturación habilitada",
        business_closed = "Cerrado a clientes actualmente - Facturación deshabilitada",
        business_status_updated = "Estado del Negocio",
        business_now_open = "El negocio está abierto ahora",
        business_now_closed = "El negocio está cerrado ahora",
        business_status_error = "Error",
        business_status_failed = "Error al actualizar estado del negocio",

        -- Employees Section
        employees = "Empleados",
        invite_new_employee = "Invitar Nuevo Empleado",
        player_id = "ID de Jugador...",
        invite = "Invitar",
        select_role = "Seleccionar Rol",
        choose_role_for = "Elegir un rol para %s",
        available_roles = "Roles Disponibles:",
        roles_available = "%d roles disponibles",
        send_invite = "Enviar Invitación",

        -- Sales Summary
        sales_summary = "Resumen de Ventas",
        today = "Hoy",
        this_week = "Esta Semana",
        this_month = "Este Mes",
        view_sales = "Ver Ventas",

        -- Inventory Status
        inventory_status = "Estado del Inventario",
        storage_capacity = "Capacidad de Almacenamiento",
        ingredients = "Ingredientes",
        supplies = "Suministros",
        manage_inventory = "Administrar Inventario",

        -- Menu Management
        search_menu_items = "Buscar artículos del menú...",
        edit_menu_item = "Editar Artículo del Menú",
        update_item_details = "Actualiza los detalles del artículo a continuación.",
        label_display_name = "Etiqueta (Nombre para Mostrar)",
        price = "Precio ($)",
        category = "Categoría",
        select_category = "Seleccionar una categoría",
        update = "Actualizar",
        all_items = "Todos los Artículos",
        no_menu_items = "No se encontraron artículos del menú",
        no_category_items = "No se encontraron %s",

        -- Vending Machine Management
        vending_machine_management = "Gestión de Máquina Expendedora",
        search_vending_items = "Buscar artículos de vending...",
        edit_vending_item = "Editar Artículo de Vending",
        update_vending_details = "Actualiza los detalles del artículo a continuación.",
        all_vending_items = "Todos los Artículos",
        no_vending_items = "No se encontraron artículos de máquina expendedora",
        no_category_vending_items = "No se encontraron %s",
        vending_update_error = "Error al actualizar artículo de vending",
        item_price = "Precio",
        item_type = "Tipo",
        uncategorized = "Sin Categorizar",
        enter_price = "ej., 5",

        -- Staff Management
        employee_overview = "Resumen del Empleado",
        total_employees = "Total de Empleados",
        active_employees = "Empleados Activos",
        pending_applications = "Solicitudes Pendientes",
        employee_list = "Lista de Empleados",
        search_employees = "Buscar empleados...",
        all_employees = "Todos los Empleados",
        name = "Nombre",
        role = "Rol",
        salary = "Salario",
        last_seen = "Visto por Última Vez",
        actions = "Acciones",
        promote = "Promover",
        demote = "Degradar",
        fire = "Despedir",
        employee_actions = "Acciones del Empleado",
        select_action = "Seleccionar una acción para %s",
        promote_employee = "Promover Empleado",
        demote_employee = "Degradar Empleado",
        fire_employee = "Despedir Empleado",
        confirm_action = "Confirmar Acción",
        confirm_promote = "¿Estás seguro de promover a %s a %s?",
        confirm_demote = "¿Estás seguro de degradar a %s a %s?",
        confirm_fire = "¿Estás seguro de despedir a %s?",
        action_success = "Acción completada exitosamente",
        action_failed = "Acción fallida",
        employee_promoted = "Empleado promovido exitosamente",
        employee_demoted = "Empleado degradado exitosamente",
        employee_fired = "Empleado despedido exitosamente",
        no_employees = "No se encontraron empleados",

           -- Job Grades Management Dialog
        manage_job_grades = "Administrar Grados de Trabajo",
        configure_salary_commission = "Configurar tasas de salario y comisión para cada posición",
        search_job_grades = "Buscar grados de trabajo...",
        edit_job_grade = "Editar Grado de Trabajo",
        update_job_grade_details = "Actualizar detalles del grado de trabajo",
        job_title = "Título del Trabajo",
        commission_rate = "Tasa de Comisión",
        boss_access = "Acceso de Jefe",
        boss_access_enabled = "Este rol tiene acceso a funciones de gestión",
        boss_access_disabled = "Este rol tiene acceso de empleado",
        save_changes = "Guardar Cambios",
        boss_role = "Rol de Jefe",
        grade_update_error = "Error al actualizar grado de trabajo",

        -- Employee Details View
        employee_overview = "Detalles del Empleado",
        employee_profile = "Perfil del Empleado",
        performance_stats = "Estadísticas de Rendimiento",
        back = "Atrás",
        
        -- Employee Profile Card Labels
        commission = "Comisión",
        total_earnings = "Ganancias Totales",
        available_balance = "Balance Disponible",
        employee_id = "ID del Empleado",
        
        -- Performance Stats Labels
        deliveries_label = "Entregas",
        billings_label = "Facturaciones",
        earnings_label = "Ganancias",
        experience_label = "Experiencia",
        level_label = "Nivel",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "Distribución de Ingresos",
        delivery_income = "Entregas",
        commission_income = "Comisión",
        paycheck_income = "Cheques de Pago",
        completed_label = "completado",
        bills_label = "facturas",
        hourly_label = "Por Hora",

        -- Employee Card Labels (for list view)
        rank_label = "Rango",
        commission_label = "Comisión",

        -- Role Change Dialog
        no_role_employees = "No se encontraron %s",
        employee_updated = "Empleado Actualizado",
        employee_commission_updated = "Empleado actualizado con tasa de comisión %s",
        fire_employee_error = "Error al despedir empleado",

        -- Employee Leaderboard
        top_performers = "Mejores Intérpretes",
        this_month_leaders = "Líderes de Este Mes",
        rank = "Rango",
        employee = "Empleado",
        performance = "Rendimiento",
        orders_completed = "Pedidos Completados",
        revenue_generated = "Ingresos Generados",
        customer_rating = "Calificación del Cliente",
        no_data = "No hay datos de rendimiento disponibles",

        -- Transactions
        transaction_history = "Historial de Transacciones",
        recent_transactions = "Transacciones Recientes",
        paycheck_history = "Historial de Cheques de Pago",
        transaction_type = "Tipo de Transacción",
        amount = "Monto",
        date = "Fecha",
        message = "Descripción",
        customer = "Cliente",
        filter_transactions = "Filtrar transacciones...",
        all_transactions = "Todas las Transacciones",
        sales_only = "Solo Ventas",
        paychecks_only = "Solo Cheques de Pago",
        no_transactions = "No se encontraron transacciones",
        no_paychecks = "No hay registros de cheques de pago",


        -- Settings
        avatar_settings = "Configuraciones de Avatar",
        update_profile_picture = "Actualizar tu imagen de perfil",
        image_url = "URL de Imagen",
        enter_url_preview = "Ingresa una URL a continuación para previsualizar tu avatar",
        preview = "Previsualizar",
        enter_url_message = "Ingresa la URL de tu imagen de avatar",
        ui_theme = "Tema de UI",
        customize_appearance = "Personalizar la apariencia del dashboard",
        light_mode = "Modo Claro",
        dark_mode = "Modo Oscuro",

        -- Navigation
        home = "Inicio",
        staff = "Personal",
        menu = "Menú",
        sales = "Ventas",
        top = "Top",
        settings = "Configuraciones",

        -- Status Labels
        open = "Abierto",
        closed = "Cerrado",
        online = "En Línea",
        offline = "Fuera de Línea",
        active = "Activo",
        inactive = "Inactivo",

        -- Common Actions
        save = "Guardar",
        edit = "Editar",
        delete = "Eliminar",
        confirm = "Confirmar",
        close = "Cerrar",
        refresh = "Actualizar",
        loading = "Cargando...",

        -- Error Messages
        error_occurred = "Ocurrió un error",
        invalid_input = "Entrada inválida",
        operation_failed = "Operación fallida",
        permission_denied = "Permiso denegado",
        network_error = "Error de red",
        data_load_failed = "Error al cargar datos",

        -- Success Messages
        operation_successful = "Operación completada exitosamente",
        data_saved = "Datos guardados exitosamente",
        changes_applied = "Cambios aplicados exitosamente",
    },

    Shop = {
        shop_status = "Estado de la Tienda",
        shop_open = "La Tienda Está Abierta",
        shop_closed = "La Tienda Está Cerrada",
        access_denied = "¡No puedes acceder a esta tienda!",
        purchase_title = "Tienda",
        purchase_success = "¡Compra completada! Artículos añadidos a tu inventario.",
        purchase_error = "¡Compra fallida!",

        -- Search and Inventory
        search_placeholder = "Buscar productos por nombre...",
        clear_search = "Limpiar búsqueda",
        shop_inventory = "Inventario de la Tienda",
        items_count = "artículos",

        -- Product Actions
        add_to_cart = "Añadir",
        per_item = "por artículo",

        -- Cart
        your_cart = "Tu Carrito",
        cart_empty = "El Carrito Está Vacío",
        cart_empty_message = "Añade artículos para comenzar a comprar",
        items_label = "artículos",
        total = "Total",

        -- Search Results
        no_items_found = "No se encontraron artículos",
        no_items_message = "Intenta ajustar tu búsqueda o navega por todos los artículos",

        -- Payment
        pay_with_cash = "Efectivo",
        pay_with_bank = "Banco",
        processing = "Procesando...",
        inventory_notice = "Los artículos se añadirán directamente a tu inventario",

        -- Notifications
        cart_updated = "Carrito Actualizado",
        item_added = "Artículo Añadido",
        item_removed = "Artículo Removido",
        quantity_updated = "Cantidad Actualizada",
        purchase_complete = "Compra Completada",
        transaction_failed = "Transacción Fallida",
        checkout_error = "Error en el Pago",
        cart_empty_error = "Tu carrito está vacío",
        paid_with_cash = "Pagado con efectivo",
        charged_to_bank = "Cargado a tu cuenta bancaria",
        not_enough_cash = "No hay suficiente efectivo",
        insufficient_bank = "Saldo bancario insuficiente",

        -- Quantity Messages
        added_more = "Añadido %d más %s",
        removed_items = "Removido %d %s",
        added_to_cart = "%s añadido al carrito",
        removed_from_cart = "Removido %s de tu carrito",

        -- Loading
        loading_shop = "Cargando Menú de Tienda...",
    },

    EmployeeMenu = {
        access_denied = "¡No puedes acceder a esta puerta!",
        commission_withdrawn = "Comisión Retirada",
        commission_withdrawn_description = "Has retirado $%s de tu balance de comisión a tu %s.",
        transaction_failed = "Transacción Fallida",
        fire_employee = "Despedir Empleado",
        commission_withdrawn_description = "Has retirado $%s de tu balance de comisión a tu %s.",
        fire_employee_description = "%s ha sido despedido de tu negocio!",
        employeeMent_notice = "Aviso de Empleado",
        
        no_employee_active = "No hay empleados activos en línea actualmente para manejar tu pedido.",
        -- Main Headers and Navigation
        employee_portal = "Portal del Empleado",
        employee_profile = "Perfil del Empleado",
        performance_stats = "Estadísticas de Rendimiento",
        employee_leaderboard = "Tabla de Líderes de Empleados",
        job_outfits = "Trajes de Trabajo",
        account_settings = "Configuraciones de Cuenta",

        -- Navigation Labels
        profile = "Perfil",
        stats = "Estadísticas",
        top = "Top",
        outfits = "Trajes",
        settings = "Configuraciones",

        -- Profile Tab
        personal_information = "Información Personal",
        paycheck_information = "Información de Cheque de Pago",
        job_role = "Rol de Trabajo",
        salary = "Salario",
        experience = "Experiencia",
        duty_status = "Estado de Servicio",
        on_duty = "De Servicio",
        off_duty = "Fuera de Servicio",
        clock_in = "Marcar Entrada",
        clock_out = "Marcar Salida",
        available_balance = "Balance Disponible",
        withdraw = "Retirar",
        withdraw_funds = "Retirar Fondos",
        paycheck_interval = "Intervalo de Cheque de Pago",
        total_deliveries = "Total de Entregas",
        bills_created = "Facturas Creadas",
        total_earnings = "Ganancias Totales",
        minutes = "minutos",

        -- Performance Tab
        career_statistics = "Estadísticas de Carrera",
        experience_points = "Puntos de Experiencia",
        xp_points = "Puntos XP",
        total_earned = "Total Ganado",
        current_balance = "Balance Actual",
        deliveries = "Entregas",
        total_completed = "Total Completado",
        billings = "Facturaciones",
        invoices_created = "Facturas Creadas",
        job_grade_progression = "Progresión de Grado de Trabajo",
        current_grade = "Grado Actual",
        level = "Nivel",
        xp_needed_promotion = "XP necesario para promoción",
        earn_more_xp = "Gana %d XP más para ser promovido a %s",
        max_grade_reached = "Has alcanzado el grado automático más alto! Las promociones adicionales requieren aprobación de gestión.",
        promotions_by_management = "Las promociones son asignadas por la gestión.",
        loading_experience_data = "Cargando datos del sistema de experiencia...",
        loading_progression_data = "Cargando datos de progresión...",

        -- Leaderboard Tab
        top_performers = "Mejores Intérpretes",
        this_month_leaders = "Líderes de Este Mes",
        rank = "Rango",
        employee = "Empleado",
        performance = "Rendimiento",
        no_leaderboard_data = "No hay datos de tabla de líderes disponibles",

        -- Outfits Tab
        work_outfits = "Trajes de Trabajo",
        select_outfit = "Seleccionar Traje",
        change_outfit = "Cambiar Traje",
        outfit_changed = "Traje Cambiado",
        outfit_changed_success = "¡Tu traje ha sido cambiado exitosamente!",
        outfit_change_failed = "Error al cambiar traje",
        outfit_preview = "Vista Previa del Traje",

        -- Settings Tab
        employee_settings = "Configuraciones del Empleado",
        avatar_settings = "Configuraciones de Avatar",
        update_profile_picture = "Actualizar tu imagen de perfil",
        image_url = "URL de Imagen",
        enter_url_preview = "Ingresa una URL a continuación para previsualizar tu avatar",
        preview = "Previsualizar",
        enter_url_message = "Ingresa la URL de tu imagen de avatar",
        avatar_updated = "Avatar Actualizado",
        avatar_created = "Avatar Creado",
        avatar_updated_message = "¡Avatar actualizado exitosamente!",
        update_failed = "Actualización Fallida",
        update_failed_message = "Error al actualizar avatar",
        invalid_url = "URL Inválida",
        invalid_url_message = "Por favor ingresa una URL de imagen válida",
        updating = "Actualizando...",
        update_avatar = "Actualizar Avatar",

        -- UI Theme
        ui_theme = "Tema de UI",
        customize_appearance = "Personalizar apariencia del dashboard",
        light_mode = "Modo Claro",
        dark_mode = "Modo Oscuro",

        -- Notifications
        notifications = "Notificaciones",
        manage_notification_preferences = "Administrar preferencias de notificación",
        employee_notifications = "Notificaciones del Empleado",
        notifications_enabled_desc = "Recibirás todas las actualizaciones de cheques de pago de empleados",
        notifications_disabled_desc = "No recibirás notificaciones",
        notifications_updated = "Notificaciones Actualizadas",
        notifications_enabled_message = "Las notificaciones de cheques de pago están habilitadas ahora",
        notifications_disabled_message = "Las notificaciones de cheques de pago están deshabilitadas ahora",
        enabled = "Habilitado",
        disabled = "Deshabilitado",

        -- Withdrawal Dialog
        withdraw_all_funds = "Retirar Todos los Fondos",
        select_balance_type = "Seleccionar Tipo de Balance",
        all_balance = "Todo el Balance",
        delivery_balance = "Balance de Entrega",
        commission_balance = "Balance de Comisión",
        paycheck_balance = "Balance de Cheque de Pago",
        available_balance_type = "Balance %s Disponible: $%d",
        enter_amount = "Ingresar monto",
        insufficient_funds = "Fondos Insuficientes",
        insufficient_balance = "Balance %s insuficiente",
        funds_withdrawn = "Fondos Retirados",
        funds_withdrawn_success = "Retirado exitosamente $%d de tu balance",
        transaction_failed = "Transacción Fallida",
        withdrawal_failed = "Error al retirar fondos",
        invalid_amount = "Monto Inválido",
        invalid_amount_message = "Por favor ingresa un monto válido",
        no_funds = "Sin Fondos",
        no_funds_message = "No tienes fondos para retirar",

        -- Common Actions
        cancel = "Cancelar",
        save = "Guardar",
        update = "Actualizar",
        confirm = "Confirmar",
        close = "Cerrar",
        loading = "Cargando...",

        -- Status Labels
        active = "Activo",
        inactive = "Inactivo",
        online = "En Línea",
        offline = "Fuera de Línea",

        -- Error Messages
        error_occurred = "Ocurrió un error",
        operation_failed = "Operación fallida",
        data_load_failed = "Error al cargar datos",
        network_error = "Error de red",
        employee_data_error = "No se pudo recuperar tus datos de empleado.",
        identity_error = "No se pudo verificar tu identidad.",
        withdraw_invalid_amount = "¡Monto inválido!",
        insufficient_commission = "¡Balance de comisión insuficiente!",
        transaction_failed_update = "¡Error al actualizar balance de comisión!",
        fire_employee_not_found = "¡Empleado no encontrado!",
        fire_employee_wrong_business = "¡Este empleado no trabaja para tu negocio!",
        fire_employee_db_error = "¡Error al despedir empleado de la base de datos!",
        employment_notice_fired = "Has sido despedido de %s",
        avatar_invalid_url = "URL de imagen inválida proporcionada.",
        avatar_updated_success = "Tu avatar de perfil ha sido actualizado exitosamente.",
        avatar_no_changes = "No se hicieron cambios en tu avatar.",
        avatar_created = "Tu perfil de empleado y avatar han sido creados.",
        avatar_create_failed = "Error al crear registro de empleado.",
        withdrawal_invalid_amount = "Monto de retiro inválido.",
        employee_record_not_found_withdraw = "Registro de empleado no encontrado.",
        insufficient_balance_withdraw = "Fondos insuficientes en tu balance.",
        withdraw_balance_failed = "Error al retirar del balance. Por favor intenta de nuevo.",
        identity_error_toggle = "No se pudo verificar tu identidad",
        invalid_grade_data = "Datos de grado inválidos proporcionados.",
        grade_id_not_found = "No se pudo encontrar ID de grado para este rol.",
        no_grade_changes = "No se hicieron cambios en el grado de trabajo.",
        balance_withdrawn = "Retiraste $%d de tu balance %s a tu %s.",
        player_not_found = "¡Jugador no encontrado!",
        invalid_purchase_data = "¡Datos de compra inválidos!",
        insufficient_funds = "¡No hay fondos suficientes en tu %s!",
        inventory_full = "¡No hay suficiente espacio en el inventario o límite de peso excedido!",
        purchase_complete = "¡Compra completada! Artículos añadidos a tu inventario.",
        shop_purchase = "Compra en Tienda: %s",
        business_balance_error = "Error al actualizar balance del negocio para %s",
        business_balance_success = "Añadido exitosamente $%s a la cuenta del negocio",
        transaction_record_error = "Error al registrar transacción para compra en tienda",
        avatar_found = "Tienda: Encontrado avatar para %s: %s",
        avatar_not_found = "Tienda: No se encontró avatar para %s, usando predeterminado",
    },

    Vending = {
        invalid_item_data = "Datos de artículo inválidos.",
        insufficient_item = "No tienes suficiente de este artículo.",
        item_added_with_money = "Artículo añadido al stock. Recibido $%s por %sx %s",
        item_added = "Artículo añadido al stock.",
        business_balance_error = "Error al actualizar balance del negocio para pedido",
        database_error = "Error de Base de Datos",
        add_item_failed = "Error al añadir artículo.",
        invalid_collection_data = "Datos de colección inválidos.",
        inventory_full = "No se pudo añadir artículo a tu inventario.",
        item_collected = "Recogido %sx %s",
        stock_update_failed = "Error al actualizar stock de vending.",
        out_of_stock = "Agotado",
        insufficient_stock = "No hay suficientes artículos disponibles para recoger.",
        sale_transaction_error = "Error al registrar transacción de venta de vending",
        collection_transaction_error = "Error al registrar transacción de colección de vending",
    },

    JobSystem = {
        no_permission = "No tienes permiso para usar este comando.",
        player_not_found = "Jugador no encontrado.",
        job_assigned = "Trabajo asignado.",
        job_assign_failed = "Error al asignar trabajo.",
        job_removed = "Trabajo removido.",
        job_remove_failed = "Error al remover trabajo.",
        job_changed_notification = "Trabajo Cambiado",
        job_changed = "Tu trabajo ha sido cambiado a %s (grado %s).",
        job_removed_notification = "Tu trabajo ha sido removido.",
        give_job_usage = "Uso: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "Uso: /%s [playerId]",
        job_info = "Trabajo: %s (Grado: %s, Servicio: %s)",
        job_info_error = "No se pudo obtener tu información de trabajo.",
        duty_status = "Ahora estás %s de servicio.",
        not_on_duty = "Fuera de Servicio",
        must_be_on_duty = "Debes estar de servicio para recibir cheques de pago.",
        paycheck_title = "Cheque de Pago",
        employer_insufficient_funds = "Tu jefe no tiene fondos suficientes para pagarte.",
        paycheck_added = "Cheque de pago de $%s añadido al balance del empleado para %s por trabajo: %s",
        paycheck_received = "Recibiste un cheque de pago de $%s de %s",
    },

    BillingInviteNotification = {
        message = "Has recibido una solicitud de pago.",

        -- Titles / headers
        title = "Solicitud de Pago",
        label = "Notificación de Facturación",

        -- Button labels
        pay_button = "Pagar Factura",
        decline_button = "Rechazar",

        -- Small UI labels used inside the notification component
        business_label = "Negocio",
        total_amount_label = "Monto Total",
        reason_label = "Razón",
        amount_label = "Monto:",

        -- Warning / helper texts
        warning_text = "El pago será deducido de tu cuenta. Asegura fondos suficientes.",
        expires_text = "Expira en %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "Has sido invitado a unirte como %s en Burgershot. ¿Aceptas?",

        -- Titles / headers
        title = "Invitación de Trabajo",
        label = "Notificación de Invitación de Trabajo",

        -- Button labels
        accept_button = "Aceptar",
        reject_button = "Rechazar",

        -- Small UI labels used inside the notification component
        company_label = "Compañía",
        grade_label = "Grado",
        invites_left_label = "Invitaciones Restantes",
        salary_label = "Salario",

        -- Warning / helper texts
        warning_text = "Aceptar este trabajo te compromete al rol. Asegúrate de estar listo para comenzar.",
        expires_text = "Expira en %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "Menú del Restaurante",
        onduty = "Necesitas estar de servicio para acceder al menú del restaurante.",
    },

    Duty = {
        status = "Estado de Servicio",
        management = "Gestión de Servicio",
        description = "Ahora estás %s de servicio.",
        restaurant_area = "Área del Restaurante",
        clock_in = "Has entrado al área del restaurante. Usa el menú del empleado para marcar entrada.",
        enter_workplace = "Has entrado a tu lugar de trabajo y ahora estás de servicio.",
        leave_workplace = "Has dejado tu lugar de trabajo y ahora estás fuera de servicio.",
        inside_workplace = "Estás dentro de tu lugar de trabajo - automáticamente establecido de servicio.",
        outside_workplace = "Estás fuera de tu lugar de trabajo - automáticamente establecido fuera de servicio.",
        duty_warning = "Advertencia de Servicio",
        auto_off_duty = "Serás automáticamente establecido fuera de servicio cuando estés fuera del restaurante.",
        no_permission_manage_duty = "No tienes permiso para gestionar el estado de servicio del empleado",
        not_employee_of_job = "El jugador no es un empleado de este trabajo",
        duty_set_by_management = "Tu estado de servicio fue establecido a %s por la gestión",
        duty_management_success = "Establecido exitosamente el estado de servicio de %s a %s",
        updated_offline_employee = "Estado de servicio del empleado offline actualizado",
    },

    Paycheck = {
        title = "Cheque de Pago Recibido",
        message = "Recibiste un cheque de pago de $%s de %s",
    },

    VendingMachine = {
        sell_item = "Vender Artículo",
        select_item_from_inventory = "Seleccionar Artículo del Inventario",
        add_to_vending = "AÑADIR %s AL VENDING",
        cancel = "CANCELAR",
        no_matching_items = "No hay artículos coincidentes en el inventario",
        stocked_items = "Artículos en Stock",
        sell = "Vender",
        no_stock = "Sin Stock",
        items = "artículos en stock",
        ready_to_serve = "¡Listo para Servir!",
    },

    EmployeeVendingMachine = {
        title = "Recoger de Máquina Expendedora",
        label = "Recoger artículos del stock de la máquina expendedora",
        collect = "Recoger",
        cancel = "Cancelar",
        quantity_available = "Cantidad (Disponible: %s)",
        collect_item = "Recoger %s",
        collect_button = "Recoger",
        in_stock = "En Stock",
        vending_machine_empty = "Esta máquina expendedora está vacía.",
    },

    OrderingTab = {
        where_eating_today = "¿Dónde comerás hoy?",
        eat_in = "Comer Aquí",
        take_out = "Para Llevar",
        whats_up = "¿qué pasa?",
        popular = "Popular",
        done = "Hecho",
        my_order = "Mi Pedido",
        empty = "Vacío",
        total = "Total",
        checkout = "Pagar",
        back = "Atrás",
        no_menu_items = "No hay artículos del menú disponibles para %s",
        loading = "Cargando...",
        eat_in_label = "Comer Aquí",
        take_out_label = "Para Llevar",
        pay_cash = "Efectivo",
        cancel = "Cancelar",
        order = "Pedido",
        total = "Total",
        pay_bank = "Banco",
        all_items = "Todos los Artículos",
        bank_only_disclaimer = "El pago se puede hacer solo a través del banco.",
    },

    OrderManagementTable = {
        title = "Panel de Gestión de Pedidos",
        label = "Administración de Pedidos",
        filter_all = "Todo",
        filter_cooking = "Cocinando",
        filter_ready = "Listo",
        filter_completed = "Completado",
        filter_terminal_orders = "Pedidos de Terminal",
        filter_self_pickup = "Pedidos de Kiosco",
        sort_by = "Ordenar Por",
        sort_day = "Día",
        sort_amount = "Monto",
        sort_name = "Nombre",
        no_orders = "No hay pedidos que coincidan con el filtro actual.",
        accept = "ACEPTAR",
        accepting = "ACEPTANDO...",
        cooking = "COCINANDO",
        ready = "LISTO",
        complete = "COMPLETAR",
        completed = "COMPLETADO",
        assigned_to = "Asignado a: ",
        items_label = "Artículos:",
        order_label = "Pedido #",
        status_cooking = "cocinando",
        status_ready = "listo",
        status_completed = "completado",
        status_cancelled = "cancelado",
        self_pickup = "Recogida Propia",
    }
}
