-- Initialize Locales table if it doesn't exist
if not Locales then
    Locales = {}
end

-- Add to the existing Locales table rather than redefining it
Locales["pt"] = {
    
    WashHands = {
        title = "Lavatório",
        no_available = "Nenhum lavatório disponível",
        success = "Suas mãos estão limpas agora!",
        error = "Erro",
        fail = "Suas mãos já estão limpas!",
        targetfail = "Você precisa lavar as mãos primeiro!",
        item_cleaned = "Item limpo com sucesso!",
        missing_required = "Faltando item necessário"
    },

    Terminal = {
        SubmitText = "Enviar Fatura",

        -- Player Selection Tab
        select_player = "Selecionar Jogador",
        nearby_players = "Jogadores Próximos",
        search_players = "Procurar jogadores...",
        no_players_found = "Nenhum jogador encontrado por perto",
        loading_players = "Carregando jogadores...",
        player_selected = "Jogador selecionado",

        -- Menu Items Tab
        menu_items = "Itens do Menu",
        items_added = "Itens adicionados",
        search_menu_items = "Procurar itens do menu...",
        available_items = "Itens Disponíveis",
        selected_items = "Itens Selecionados",
        no_items_found = "Nenhum item encontrado",
        no_items_selected = "Nenhum item selecionado",
        total_items = "Itens Totais",
        total = "Total",
        all = "Todos",

        -- Finalize Bill Tab
        finalize_bill = "Finalizar Fatura",
        customer_info = "Informações do Cliente",
        order_summary = "Resumo do Pedido",
        amount_label = "Valor ($)",
        enter_amount = "Inserir valor",
        reason_label = "Motivo (Opcional)",
        reason_placeholder = "Inserir motivo da fatura",
        payment_method = "Método de Pagamento",
        cash = "Dinheiro",
        bank = "Banco",
        send_bill = "Enviar Fatura",

        -- Commission
        your_commission = "Sua comissão",
        commission_rate = "Taxa de Comissão",

        -- Bills sent counter
        bills_sent = "Faturas enviadas:",
        commission = "Comissão:",

        -- Error Messages
        bill_error = "Erro na Fatura",
        select_player_error = "Por favor, selecione um jogador",
        invalid_amount_error = "Por favor, insira um valor válido",

        -- Success Messages
        bill_sent_success = "Fatura enviada com sucesso!",
        bill_sent_title = "Fatura Enviada",
    },

    Consumable = {
        Drinking = "Bebendo ", -- Drinking ItemName
        Eating = "Comendo " -- Eating ItemName
    },

    Garage = {
        title = "Garagem",
        no_vehicle = "Nenhum veículo para devolver",
        not_job_vehicle = "Este não é um veículo da Burgershot!",
        parked_title = "Veículo estacionado!",
        parked_message = "Seu veículo foi estacionado neste local!",
        in_vehicle = "Você não pode estar dentro do veículo!",
        too_far = "Muito longe do veículo!",
        spawn_error = "Não pode fazer isso agora!",

        -- UI Text
        garage_title = "Garagem",
        garage_active_vehicles = "Ativos",
        garage_manage = "Gerenciar Ativos",
        close = "Fechar",
        search_vehicles = "Procurar veículos...",
        no_vehicles_found = "Nenhum veículo encontrado",
        dont_have_vehicle = "Você não tem veículos guardados nesta garagem.",
        select_vehicle = "Selecionar Veículo",
        select_vehicle_message = "Selecione um veículo da lista para ver detalhes e retirá-lo.",
        back = "Voltar",
        spawn_vehicle = "Retirar Veículo",
        return_button = "Devolver",
        return_vehicle = "Devolver Veículo",
        license_plate = "Placa",

        -- Status Messages
        vehicle_spawned = "Veículo retirado com sucesso",
        no_vehicle_to_return = "Nenhum veículo para devolver",
        access_denied = "Você não tem acesso a esta garagem.",
        all_spawn_points_blocked = "Todos os pontos de retirada estão bloqueados no momento, por favor aguarde.",
        vehicle_model_not_exist = "Modelo de veículo não existe",
        failed_load_model = "Falha ao carregar modelo de veículo",
        failed_create_vehicle = "Falha ao criar veículo",
        invalid_vehicle_data = "Dados de modelo de veículo inválidos",

        -- Error Messages
        error = "Erro",
        garage_error = "Erro na Garagem",

        -- Added missing notifications from cl_garage.lua
        vehicle_entity_failed = "Falha ao criar entidade do veículo",
        no_spawn_points_available = "Nenhum ponto de retirada disponível",
        vehicle_returned_parked = "Veículo devolvido e estacionado.",
        vehicle_processed_remote = "Veículo processado (Devolução remota).",
    },

    Billing = {
        title = "Faturamento",
        payment_failed_byreceiver = "Pagamento falhou: %s não tem fundos suficientes para pagar %s.",
        business_closed = "O faturamento está desativado pela administração.",
        commission_earned = "Comissão Ganha",
        commission_earned_description = "Você ganhou $%s de comissão.",
        terminal_title = "Terminal de Faturamento",
        off_duty_error = "Você deve estar em serviço para usar o terminal.",
        access_denied = "Você não tem acesso ao terminal de faturamento.",
        payment_received = "Pagamento Recebido",
        payment_received_message = "Pagamento de $%s recebido de %s",
        payment_failed = "Pagamento Falhou",
        payment_failed_message = "Pagamento da fatura falhou",
        bill_sent = "Fatura Enviada",
        bill_sent_success = "Fatura enviada com sucesso!",
        bill_sent_error = "Falha ao enviar fatura.",
        bill_error = "Erro na Fatura",
        invalid_bill = "Fatura Inválida!",
        invalid_bill_description = "A fatura que você está tentando pagar não existe.",
        invalid_target_amount = "Destino ou valor inválido!",
        player_not_found = "Jogador não encontrado!",
        must_be_on_duty = "Você deve estar em serviço para enviar uma fatura!",
        bill_sent_description = "Fatura de $%s enviada para %s por %s",
        bill_payment_successful = "✅ Pagamento da fatura bem-sucedido",
        bill_payment_failed_insufficient = "❌ Pagamento da fatura falhou - Fundos Insuficientes",
        bill_rejected = "❌ Fatura rejeitada",
        insufficient_funds = "%s não tem o suficiente!",
        order_processed = "🍔 Pedido Processado",
        command_access_denied = "Você não pode usar este comando!",
        payment_failed_insufficient = "%s não tem o suficiente!",
        bill_rejected_title = "Fatura Rejeitada",

        bill_rejected_sender = "%s rejeitou sua fatura de $%s",
        bill_rejected_receiver = "Você rejeitou a fatura de %s",
        billing_disabled = "O faturamento está desativado pela administração.",
        billing_off_duty = "Você deve estar em serviço para usar o faturamento.",
    },

    Delivery = {
        items_header = "Itens de Entrega",
        reward_header = "Recompensa",
        accept_header = "Aceitar Entrega",
        decline_header = "Rejeitar Entrega",
        menu_header = "Menu de Entrega",
        no_delivery = "Nenhuma entrega ativa!",
        new_delivery_title = "Nova Entrega",
        new_delivery_desc = "Você recebeu uma nova solicitação de entrega.",
        delivery_expired = "Sua solicitação de entrega expirou.",
        delivery_timeout = "Você não teve tempo para completar a entrega.",
        delivery_declined = "Você rejeitou a solicitação de entrega.",
        check_location = "Verifique seu GPS para o local de entrega.",
        check_location_error = "Nenhuma entrega ativa para rastrear.",
        delivery_accepted = "Entrega Aceita",
        invalid_item = "Item inválido para entrega",
        delivery_failed = "Entrega Falhou",
        invalid_items_data = "Dados de itens inválidos",

        -- UI Text
        delivery_title = "Entrega",
        close_menu = "Fechar Menu",
        new_order = "Novo Pedido",
        in_progress = "Em Andamento",
        order_items = "Itens do Pedido:",
        payment = "Pagamento",
        delivery_status = "Status da Entrega",
        deliver_instruction = "Entregue a comida no local marcado no mapa.",
        time_remaining = "Tempo Restante:",
        order_summary = "Resumo do Pedido:",
        accept = "Aceitar",
        decline = "Rejeitar",
        cancel_delivery = "Cancelar Entrega",

        -- Notifications
        delivery_accepted_notification = "Entrega aceita com sucesso",
        delivery_cancelled_notification = "Entrega cancelada com sucesso",

        -- Status Messages
        complete_delivery = "Concluir Entrega",
        delivery_in_progress = "Entrega em andamento...",
        head_to_location = "Vá para o local marcado para concluir a entrega",
    },

    Consumption = {
        title = "Consumo",
        description = "Fresco e delicioso!",
        refresh_title = "Refrescante",
        refresh_description = "Você se sente refrescado",
    },

    Crafting = {
        craft_title = "Criar %s",
        enter_amount_description = "Inserir quantidade para criar",
        crafting_successful = "Criação Bem-sucedida",
        crafted_description = "Criado %d x %s",
        crafting_cancelled = "Criação Cancelada",
        cancelled_description = "Você cancelou a criação",
        no_space = "Sem espaço no inventário",
    },

    Targets = {
        door = "Bater na porta",
        door_icon = "fas fa-door-open",
        delivery_food = "Entregar Comida",
        delivery_food_icon = "fas fa-utensils",
        ordering_tablet = "Tablet de Pedidos",
        ordering_tablet_error = "Recurso de tablet de pedidos não disponível.",
        order_management_tablet = "Tablet de Gerenciamento de Pedidos",
        order_management_error = "Recurso de tablet de gerenciamento de pedidos não disponível.",
        return_utensils = "Devolver Utensílios",
        employee_vending = "Máquina de Vendas de Funcionários",
    },

    Order = {
        complete = "Pedido Concluído",
        description = "Seu pedido foi processado. A fatura foi adicionada ao seu inventário.",
        paycheck_suspended_description = "Os salários estão suspensos enquanto o negócio está fechado.",
        paycheck_suspended = "Salário Suspenso",
    },

    Door = {
        title = "Porta ",
        description = "A porta está ",
        locked = "A porta está trancada",
        no_permissions = "Sem permissão para trancar/destrancar esta porta",
        access_denied_title = "Acesso Negado",
        access_granted = "Você destrancou a porta",
        access_denied = "Você não tem acesso a esta porta",
    },

    Outfits = {
        title = "Roupas",
        invalid = "Gênero inválido",
        failed_equip = "Falha ao equipar roupa",
        disabled = "Roupas estão desativadas",
        civilian_clothes = "Mudar para Roupas Civis",
        reset_civilian_clothes = "Mudou de volta para roupas civis",
        no_civilian_saved = "Nenhuma roupa civil salva. Mude para uniforme primeiro.",
        no_permission = "Você não tem permissão para usar esta roupa",
        outfit_not_found = "Roupa não encontrada",
        equip_success = "Roupa equipada com sucesso",
        changed_to_uniform = "Mudou para %s",
        reset_success = "Roupa redefinida com sucesso",
        no_civilian_for_reset = "Nenhuma roupa civil salva. Mude para uniforme e salve as roupas primeiro.",
    },

    System = {
        success = "Sucesso",
        paycheck_error = "Erro no Salário",
        inventory_full = "Inventário Cheio",
        inventory_full_description = "Seu inventário está cheio.",
        society_not_found = "Negócio não encontrado",
        business_funds_insufficient = "O negócio não tem fundos suficientes para pagar salários.",
        error = "Erro",
        invalid = "Inválido",
        no_license = "Não foi possível identificar sua licença. Contate um administrador.",
        missing_items = "Itens Faltando",
        item_cleaned = "Item limpo com sucesso",
        missing_required = "Faltando item necessário",
        slot_error = "Coloque a quantidade no mesmo slot",
        ice_collected = "Gelo coletado",
        refreshing = "Refrescando",
        refreshed = "Refrescado",
        consumption = "Consumo",
        stress_increased = "Estresse Aumentado",
        stress_amount = "Seu nível de estresse aumentou em %s",
        inventory_full = "Seu inventário está cheio",
    },

    Experience = {
        gained_title = "Experiência Ganha",
        experience_earned_description = "Você ganhou %d XP.",
        gained_message = "Você ganhou %d XP por completar a entrega!",
    },

    BossMenu = {
        title = "Menu do Chefe",
        unable_jobdetermine = "Não foi possível determinar seu trabalho. Tente novamente mais tarde.",
        bankruptcy_alert = "⚠️ Alerta de Falência",
        description = "Não é possível pagar salários! Saldo do negócio: $%s, Necessário: $%s",
        trans_failed_bossmenubalance = "Transação Falhou - Fundos de Negócio Insuficientes",
        menu_in_use = "O menu do chefe está sendo usado por %s.",
        no_permissions = "Você não tem permissões de chefe! Você precisa ser Chefe.",
        wrong_job = "Você não tem o trabalho correto",
        grade_updated = "Grau de Trabalho Atualizado",
        grade_update_success = "Grau %s atualizado com sucesso.",
        menu_update = "Atualização do Menu",
        menu_update_success = "Item do menu atualizado com sucesso!",
        vending_update = "Máquina de Vendas",
        vending_update_success = "Item da máquina de vendas atualizado com sucesso!",
        menu_update_error = "Falha ao atualizar item do menu!",
        menu_delete = "Excluir Menu",
        menu_delete_success = "Item do menu excluído com sucesso!",
        menu_delete_error = "Falha ao excluir item do menu!",
        invite_sent = "Convite Enviado",
        invite_sent_success = "Convite de trabalho enviado para %s",
        invite_error = "ID de jogador ou cargo inválido!",
        player_not_found = "Jogador não encontrado!",
        job_error = "Dados de convite inválidos!",
        job_accepted = "Você agora é um %s em %s",
        job_updated_title = "Trabalho Atualizado",
        job_updated = "Sua posição foi atualizada para %s em %s",
        database_error = "Seu trabalho foi definido, mas a atualização do banco de dados falhou.",
        invite_rejected = "Você rejeitou o convite de trabalho.",
        withdraw_error = "Valor inválido!",
        business_error = "Negócio não encontrado!",
        insufficient_funds = "Fundos de negócio insuficientes!",
        money_withdrawn = "Você retirou $%s da conta do negócio.",
        transaction_failed = "Falha ao atualizar conta do negócio!",
        money_deposited = "Você depositou $%s na conta do negócio.",
        transaction_failed_refund = "Falha ao atualizar conta do negócio! Seu dinheiro foi devolvido.",
        shop_purchase = "Nova Compra na Loja",
        shop_purchase_notification = "%s comprou itens por $%s",
        menu_occupied = "Menu do chefe está ocupado",
        menu_occupied_by = "%s está usando o menu do chefe atualmente. Tente novamente mais tarde.",
        menu_released = "Menu do chefe agora disponível",

        -- Main Headers and Titles
        business_overview = "Visão Geral do Negócio",
        business_settings = "Configurações do Negócio",
        menu_management = "Gerenciamento do Menu",
        staff_management = "Gerenciamento de Pessoal",
        employee_leaderboard = "Tabela de Líderes de Funcionários",
        sales_transactions = "Vendas e Transações",

        -- Finance Section
        finance = "Finanças",
        business_balance = "Saldo do Negócio",
        withdraw = "Sacar",
        deposit = "Depositar",
        withdraw_money = "Sacar Dinheiro",
        deposit_money = "Depositar Dinheiro",
        enter_amount_withdraw = "Insira o valor que deseja sacar da conta do negócio para o seu %s.",
        enter_amount_deposit = "Insira o valor que deseja depositar do seu %s na conta do negócio.",
        available = "Disponível",
        enter_amount = "Inserir valor",
        withdraw_to = "Sacar para %s",
        deposit_from = "Depositar de %s",
        updating = "Atualizando...",
        update_avatar = "Atualizar Avatar",
        cancel = "Cancelar",
        cash = "Dinheiro",
        bank = "Banco",
        invalid_url = "URL Inválida",
        invalid_url_message = "Por favor, insira uma URL de imagem válida",
        avatar_updated = "Avatar Atualizado",
        avatar_updated_message = "Avatar atualizado com sucesso!",
        update_failed = "Atualização Falhou",
        update_failed_message = "Falha ao atualizar avatar",
        business_status = "Status do Negócio",
        business_status_desc = "Controle o status operacional do seu negócio",
        business_operations = "Operações de Negócios",
        business_open = "Atualmente aceitando clientes - Faturamento ativado",
        business_closed = "Atualmente fechado para clientes - Faturamento desativado",
        business_status_updated = "Status do Negócio",
        business_now_open = "O negócio está agora aberto",
        business_now_closed = "O negócio está agora fechado",
        business_status_error = "Erro",
        business_status_failed = "Falha ao atualizar status do negócio",

        -- Employees Section
        employees = "Funcionários",
        invite_new_employee = "Convidar Novo Funcionário",
        player_id = "ID do Jogador...",
        invite = "Convidar",
        select_role = "Selecionar Cargo",
        choose_role_for = "Escolha um cargo para %s",
        available_roles = "Cargos Disponíveis:",
        roles_available = "%d cargos disponíveis",
        send_invite = "Enviar Convite",

        -- Sales Summary
        sales_summary = "Resumo de Vendas",
        today = "Hoje",
        this_week = "Esta Semana",
        this_month = "Este Mês",
        view_sales = "Ver Vendas",

        -- Inventory Status
        inventory_status = "Status do Inventário",
        storage_capacity = "Capacidade de Armazenamento",
        ingredients = "Ingredientes",
        supplies = "Suprimentos",
        manage_inventory = "Gerenciar Inventário",

        -- Menu Management
        search_menu_items = "Procurar itens do menu...",
        edit_menu_item = "Editar Item do Menu",
        update_item_details = "Atualize os detalhes do item abaixo.",
        label_display_name = "Rótulo (Nome de Exibição)",
        price = "Preço ($)",
        category = "Categoria",
        select_category = "Selecione uma categoria",
        update = "Atualizar",
        all_items = "Todos os Itens",
        no_menu_items = "Nenhum item de menu encontrado",
        no_category_items = "Nenhum %s encontrado",

        -- Vending Machine Management
        vending_machine_management = "Gerenciamento de Máquina de Vendas",
        search_vending_items = "Procurar itens de venda...",
        edit_vending_item = "Editar Item de Venda",
        update_vending_details = "Atualize os detalhes do item abaixo.",
        all_vending_items = "Todos os Itens",
        no_vending_items = "Nenhum item de máquina de vendas encontrado",
        no_category_vending_items = "Nenhum %s encontrado",
        vending_update_error = "Falha ao atualizar item de máquina de vendas",
        item_price = "Preço",
        item_type = "Tipo",
        uncategorized = "Sem Categoria",
        enter_price = "ex: 5",

        -- Staff Management
        employee_overview = "Visão Geral de Funcionários",
        total_employees = "Total de Funcionários",
        active_employees = "Funcionários Ativos",
        pending_applications = "Candidaturas Pendentes",
        employee_list = "Lista de Funcionários",
        search_employees = "Procurar funcionários...",
        all_employees = "Todos os Funcionários",
        name = "Nome",
        role = "Cargo",
        salary = "Salário",
        last_seen = "Visto por Último",
        actions = "Ações",
        promote = "Promover",
        demote = "Rebaixar",
        fire = "Demitir",
        employee_actions = "Ações de Funcionário",
        select_action = "Selecione uma ação para %s",
        promote_employee = "Promover Funcionário",
        demote_employee = "Rebaixar Funcionário",
        fire_employee = "Demitir Funcionário",
        confirm_action = "Confirmar Ação",
        confirm_promote = "Tem certeza de que deseja promover %s para %s?",
        confirm_demote = "Tem certeza de que deseja rebaixar %s para %s?",
        confirm_fire = "Tem certeza de que deseja demitir %s?",
        action_success = "Ação concluída com sucesso",
        action_failed = "Ação falhou",
        employee_promoted = "Funcionário promovido com sucesso",
        employee_demoted = "Funcionário rebaixado com sucesso",
        employee_fired = "Funcionário demitido com sucesso",
        no_employees = "Nenhum funcionário encontrado",

            -- Job Grades Management Dialog
        manage_job_grades = "Gerenciar Graus de Trabalho",
        configure_salary_commission = "Configurar salário e taxas de comissão para cada posição",
        search_job_grades = "Procurar graus de trabalho...",
        edit_job_grade = "Editar Grau de Trabalho",
        update_job_grade_details = "Atualizar detalhes do grau de trabalho",
        job_title = "Título do Trabalho",
        commission_rate = "Taxa de Comissão",
        boss_access = "Acesso de Chefe",
        boss_access_enabled = "Este cargo tem acesso a recursos de gerenciamento",
        boss_access_disabled = "Este cargo tem acesso de nível de funcionário",
        save_changes = "Salvar Alterações",
        boss_role = "Cargo de Chefe",
        grade_update_error = "Falha ao atualizar grau de trabalho",

        -- Employee Details View
        employee_overview = "Detalhes do Funcionário",
        employee_profile = "Perfil do Funcionário",
        performance_stats = "Métricas de Desempenho",
        back = "Voltar",
        
        -- Employee Profile Card Labels
        commission = "Comissão",
        total_earnings = "Ganhos Totais",
        available_balance = "Saldo Disponível",
        employee_id = "ID do Funcionário",
        
        -- Performance Stats Labels
        deliveries_label = "Entregas",
        billings_label = "Faturamentos",
        earnings_label = "Ganhos",
        experience_label = "Experiência",
        level_label = "Nível",
        xp_label = "XP",
        
        -- Income Distribution Section
        income_distribution = "Distribuição de Renda",
        delivery_income = "Entregas",
        commission_income = "Comissão",
        paycheck_income = "Salários",
        completed_label = "concluído",
        bills_label = "faturas",
        hourly_label = "Por Hora",

        -- Employee Card Labels (for list view)
        rank_label = "Classificação",
        commission_label = "Comissão",

        -- Role Change Dialog
        no_role_employees = "Nenhum %s encontrado",
        employee_updated = "Funcionário Atualizado",
        employee_commission_updated = "Funcionário atualizado com taxa de comissão de %s",
        fire_employee_error = "Falha ao demitir funcionário",

        -- Employee Leaderboard
        top_performers = "Melhores Desempenhos",
        this_month_leaders = "Líderes deste Mês",
        rank = "Classificação",
        employee = "Funcionário",
        performance = "Desempenho",
        orders_completed = "Pedidos Concluídos",
        revenue_generated = "Receita Gerada",
        customer_rating = "Avaliação do Cliente",
        no_data = "Nenhum dado de desempenho disponível",

        -- Transactions
        transaction_history = "Histórico de Transações",
        recent_transactions = "Transações Recentes",
        paycheck_history = "Histórico de Salários",
        transaction_type = "Tipo de Transação",
        amount = "Valor",
        date = "Data",
        message = "Descrição",
        customer = "Cliente",
        filter_transactions = "Filtrar transações...",
        all_transactions = "Todas as Transações",
        sales_only = "Apenas Vendas",
        paychecks_only = "Apenas Salários",
        no_transactions = "Nenhuma transação encontrada",
        no_paychecks = "Nenhum registro de salário encontrado",


        -- Settings
        avatar_settings = "Configurações de Avatar",
        update_profile_picture = "Atualizar sua foto de perfil",
        image_url = "URL da Imagem",
        enter_url_preview = "Insira uma URL abaixo para visualizar seu avatar",
        preview = "Visualização",
        enter_url_message = "Insira a URL da sua imagem de avatar",
        ui_theme = "Tema da UI",
        customize_appearance = "Personalizar a aparência do painel",
        light_mode = "Modo Claro",
        dark_mode = "Modo Escuro",

        -- Navigation
        home = "Início",
        staff = "Pessoal",
        menu = "Menu",
        sales = "Vendas",
        top = "Topo",
        settings = "Configurações",

        -- Status Labels
        open = "Aberto",
        closed = "Fechado",
        online = "Online",
        offline = "Offline",
        active = "Ativo",
        inactive = "Inativo",

        -- Common Actions
        save = "Salvar",
        edit = "Editar",
        delete = "Excluir",
        confirm = "Confirmar",
        close = "Fechar",
        refresh = "Atualizar",
        loading = "Carregando...",

        -- Error Messages
        error_occurred = "Ocorreu um erro",
        invalid_input = "Entrada inválida",
        operation_failed = "Operação falhou",
        permission_denied = "Permissão negada",
        network_error = "Erro de rede",
        data_load_failed = "Falha ao carregar dados",

        -- Success Messages
        operation_successful = "Operação concluída com sucesso",
        data_saved = "Dados salvos com sucesso",
        changes_applied = "Alterações aplicadas com sucesso",
    },

    Shop = {
        shop_status = "Status da Loja",
        shop_open = "Loja Aberta",
        shop_closed = "Loja Fechada",
        access_denied = "Você não pode acessar esta loja!",
        purchase_title = "Loja",
        purchase_success = "Compra concluída! Itens adicionados ao seu inventário.",
        purchase_error = "Check-out falhou!",

        -- Search and Inventory
        search_placeholder = "Procurar produtos por nome...",
        clear_search = "Limpar pesquisa",
        shop_inventory = "Inventário da Loja",
        items_count = "itens",

        -- Product Actions
        add_to_cart = "Adicionar",
        per_item = "por/item",

        -- Cart
        your_cart = "Seu Carrinho",
        cart_empty = "Carrinho Vazio",
        cart_empty_message = "Adicione itens para começar a comprar",
        items_label = "itens",
        total = "Total",

        -- Search Results
        no_items_found = "Nenhum item encontrado",
        no_items_message = "Tente ajustar sua pesquisa ou navegue por todos os itens",

        -- Payment
        pay_with_cash = "Dinheiro",
        pay_with_bank = "Banco",
        processing = "Processando...",
        inventory_notice = "Os itens serão adicionados diretamente ao seu inventário",

        -- Notifications
        cart_updated = "Carrinho Atualizado",
        item_added = "Item Adicionado",
        item_removed = "Item Removido",
        quantity_updated = "Quantidade Atualizada",
        purchase_complete = "Compra Concluída",
        transaction_failed = "Transação Falhou",
        checkout_error = "Erro no Check-out",
        cart_empty_error = "Seu carrinho está vazio",
        paid_with_cash = "Pago com dinheiro",
        charged_to_bank = "Cobrado na sua conta bancária",
        not_enough_cash = "Dinheiro insuficiente",
        insufficient_bank = "Saldo bancário insuficiente",

        -- Quantity Messages
        added_more = "Adicionado mais %d %s",
        removed_items = "Removido %d %s",
        added_to_cart = "%s adicionado ao carrinho",
        removed_from_cart = "Removido %s do seu carrinho",

        -- Loading
        loading_shop = "Carregando Menu da Loja...",
    },

    EmployeeMenu = {
        access_denied = "Você não pode acessar este portal!",
        commission_withdrawn = "Comissão Retirada",
        commission_withdrawn_description = "Você retirou $%s do seu saldo de comissão para o seu %s.",
        transaction_failed = "Transação Falhou",
        fire_employee = "Demitir Funcionário",
        fire_employee_description = "%s foi demitido do seu negócio!",
        employeeMent_notice = "Aviso de Funcionário",
        
        no_employee_active = "Nenhum funcionário está online e ativo para lidar com seu pedido.",
        -- Main Headers and Navigation
        employee_portal = "Portal do Funcionário",
        employee_profile = "Perfil do Funcionário",
        performance_stats = "Estatísticas de Desempenho",
        employee_leaderboard = "Tabela de Líderes de Funcionários",
        job_outfits = "Uniformes de Trabalho",
        account_settings = "Configurações da Conta",

        -- Navigation Labels
        profile = "Perfil",
        stats = "Estatísticas",
        top = "Topo",
        outfits = "Uniformes",
        settings = "Configurações",

        -- Profile Tab
        personal_information = "Informações Pessoais",
        paycheck_information = "Informações de Salário",
        job_role = "Cargo",
        salary = "Salário",
        experience = "Experiência",
        duty_status = "Status de Serviço",
        on_duty = "Em Serviço",
        off_duty = "Fora de Serviço",
        clock_in = "Bater Ponto Entrada",
        clock_out = "Bater Ponto Saída",
        available_balance = "Saldo Disponível",
        withdraw = "Sacar",
        withdraw_funds = "Sacar Fundos",
        paycheck_interval = "Intervalo de Pagamento",
        total_deliveries = "Total de Entregas",
        bills_created = "Faturas Criadas",
        total_earnings = "Ganhos Totais",
        minutes = "minutos",

        -- Performance Tab
        career_statistics = "Estatísticas de Carreira",
        experience_points = "Experiência",
        xp_points = "Pontos de XP",
        total_earned = "Total Ganho",
        current_balance = "Saldo Atual",
        deliveries = "Entregas",
        total_completed = "Total Concluído",
        billings = "Faturamentos",
        invoices_created = "Faturas Criadas",
        job_grade_progression = "Progressão de Grau de Trabalho",
        current_grade = "Grau Atual",
        level = "Nível",
        xp_needed_promotion = "XP necessária para promoção",
        earn_more_xp = "Ganhe mais %d XP para ser promovido a %s",
        max_grade_reached = "Você alcançou o grau automático mais alto! Outras promoções requerem aprovação da gerência.",
        promotions_by_management = "Promoções são atribuídas pela gerência.",
        loading_experience_data = "Carregando dados do sistema de experiência...",
        loading_progression_data = "Carregando dados de progressão...",

        -- Leaderboard Tab
        top_performers = "Melhores Desempenhos",
        this_month_leaders = "Líderes deste Mês",
        rank = "Classificação",
        employee = "Funcionário",
        performance = "Desempenho",
        no_leaderboard_data = "Nenhum dado de tabela de líderes disponível",

        -- Outfits Tab
        work_outfits = "Uniformes de Trabalho",
        select_outfit = "Selecionar Uniforme",
        change_outfit = "Mudar Uniforme",
        outfit_changed = "Uniforme Mudado",
        outfit_changed_success = "Seu uniforme foi alterado com sucesso!",
        outfit_change_failed = "Falha ao mudar uniforme",
        outfit_preview = "Pré-visualização do Uniforme",

        -- Settings Tab
        employee_settings = "Configurações do Funcionário",
        avatar_settings = "Configurações de Avatar",
        update_profile_picture = "Atualizar sua foto de perfil",
        image_url = "URL da Imagem",
        enter_url_preview = "Insira uma URL abaixo para pré-visualizar seu avatar",
        preview = "Pré-visualização",
        enter_url_message = "Insira a URL da sua imagem de avatar",
        avatar_updated = "Avatar Atualizado",
        avatar_created = "Avatar Criado",
        avatar_updated_message = "Avatar atualizado com sucesso!",
        update_failed = "Atualização Falhou",
        update_failed_message = "Falha ao atualizar avatar",
        invalid_url = "URL Inválida",
        invalid_url_message = "Por favor, insira uma URL de imagem válida",
        updating = "Atualizando...",
        update_avatar = "Atualizar Avatar",

        -- UI Theme
        ui_theme = "Tema da UI",
        customize_appearance = "Personalizar aparência do painel",
        light_mode = "Modo Claro",
        dark_mode = "Modo Escuro",

        -- Notifications
        notifications = "Notificações",
        manage_notification_preferences = "Gerenciar preferências de notificação",
        employee_notifications = "Notificações de Funcionário",
        notifications_enabled_desc = "Você receberá todas as atualizações de pagamento de funcionários",
        notifications_disabled_desc = "Você não receberá notificações",
        notifications_updated = "Notificações Atualizadas",
        notifications_enabled_message = "Notificações de pagamento estão agora ativadas",
        notifications_disabled_message = "Notificações de pagamento estão agora desativadas",
        enabled = "Ativado",
        disabled = "Desativado",

        -- Withdrawal Dialog
        withdraw_all_funds = "Sacar Todos os Fundos",
        select_balance_type = "Selecionar Tipo de Saldo",
        all_balance = "Todo o Saldo",
        delivery_balance = "Saldo de Entrega",
        commission_balance = "Saldo de Comissão",
        paycheck_balance = "Saldo de Salário",
        available_balance_type = "Saldo de %s Disponível: $%d",
        enter_amount = "Inserir valor",
        insufficient_funds = "Fundos Insuficientes",
        insufficient_balance = "Saldo de %s insuficiente",
        funds_withdrawn = "Fundos Sacados",
        funds_withdrawn_success = "Sacou com sucesso $%d do seu saldo",
        transaction_failed = "Transação Falhou",
        withdrawal_failed = "Falha ao sacar fundos",
        invalid_amount = "Valor Inválido",
        invalid_amount_message = "Por favor, insira um valor válido",
        no_funds = "Sem Fundos",
        no_funds_message = "Você não tem fundos para sacar",

        -- Common Actions
        cancel = "Cancelar",
        save = "Salvar",
        update = "Atualizar",
        confirm = "Confirmar",
        close = "Fechar",
        loading = "Carregando...",

        -- Status Labels
        active = "Ativo",
        inactive = "Inativo",
        online = "Online",
        offline = "Offline",

        -- Error Messages
        error_occurred = "Ocorreu um erro",
        operation_failed = "Operação falhou",
        data_load_failed = "Falha ao carregar dados",
        network_error = "Erro de rede",
        employee_data_error = "Não foi possível recuperar seus dados de funcionário.",
        identity_error = "Não foi possível verificar sua identidade.",
        withdraw_invalid_amount = "Valor inválido!",
        insufficient_commission = "Saldo de comissão insuficiente!",
        transaction_failed_update = "Falha ao atualizar saldo de comissão!",
        fire_employee_not_found = "Funcionário não encontrado!",
        fire_employee_wrong_business = "Este funcionário não trabalha para o seu negócio!",
        fire_employee_db_error = "Falha ao demitir funcionário do banco de dados!",
        employment_notice_fired = "Você foi demitido de %s",
        avatar_invalid_url = "URL de imagem inválida fornecida.",
        avatar_updated_success = "Seu avatar de perfil foi atualizado com sucesso.",
        avatar_no_changes = "Nenhuma alteração foi feita no seu avatar.",
        avatar_created = "Seu perfil de funcionário e avatar foram criados.",
        avatar_create_failed = "Falha ao criar registro de funcionário.",
        withdrawal_invalid_amount = "Valor de saque inválido.",
        employee_record_not_found_withdraw = "Registro de funcionário não encontrado.",
        insufficient_balance_withdraw = "Fundos insuficientes no seu saldo.",
        withdraw_balance_failed = "Falha ao sacar do saldo. Por favor, tente novamente.",
        identity_error_toggle = "Não foi possível verificar sua identidade",
        invalid_grade_data = "Dados de grau inválidos fornecidos.",
        grade_id_not_found = "Não foi possível encontrar o ID do grau para este cargo.",
        no_grade_changes = "Nenhuma alteração foi feita no grau de trabalho.",
        balance_withdrawn = "Você sacou $%d do seu saldo de %s para o seu %s.",
        player_not_found = "Jogador não encontrado!",
        invalid_purchase_data = "Dados de compra inválidos!",
        insufficient_funds = "Fundos insuficientes no seu %s!",
        inventory_full = "Espaço no inventário insuficiente ou limite de peso excedido!",
        purchase_complete = "Compra concluída! Itens adicionados ao seu inventário.",
        shop_purchase = "Compra na Loja: %s",
        business_balance_error = "Erro ao atualizar saldo do negócio para %s",
        business_balance_success = "Adicionado com sucesso $%s à conta do negócio",
        transaction_record_error = "Erro ao registrar transação para compra na loja",
        avatar_found = "Loja: Avatar encontrado para %s: %s",
        avatar_not_found = "Loja: Nenhum avatar encontrado para %s, usando padrão",
    },

    Vending = {
        invalid_item_data = "Dados de item inválidos.",
        insufficient_item = "Você não tem o suficiente deste item.",
        item_added_with_money = "Item adicionado ao estoque. Recebido $%s por %sx %s",
        item_added = "Item adicionado ao estoque.",
        business_balance_error = "Erro ao atualizar saldo do negócio para pedido",
        database_error = "Erro no Banco de Dados",
        add_item_failed = "Falha ao adicionar item.",
        invalid_collection_data = "Dados de coleta inválidos.",
        inventory_full = "Não foi possível adicionar item ao seu inventário.",
        item_collected = "Coletado %sx %s",
        stock_update_failed = "Falha ao atualizar estoque da máquina de vendas.",
        out_of_stock = "Sem Estoque",
        insufficient_stock = "Itens insuficientes disponíveis para coleta.",
        sale_transaction_error = "Erro ao registrar transação de venda da máquina",
        collection_transaction_error = "Erro ao registrar transação de coleta da máquina",
    },

    JobSystem = {
        no_permission = "Você não tem permissão para usar este comando.",
        player_not_found = "Jogador não encontrado.",
        job_assigned = "Trabalho atribuído.",
        job_assign_failed = "Falha ao atribuir trabalho.",
        job_removed = "Trabalho removido.",
        job_remove_failed = "Falha ao remover trabalho.",
        job_changed_notification = "Trabalho Alterado",
        job_changed = "Seu trabalho foi alterado para %s (grau %s).",
        job_removed_notification = "Seu trabalho foi removido.",
        give_job_usage = "Uso: /%s [playerId] [jobName] [grade]",
        remove_job_usage = "Uso: /%s [playerId]",
        job_info = "Trabalho: %s (Grau: %s, Serviço: %s)",
        job_info_error = "Não foi possível obter informações do seu trabalho.",
        duty_status = "Você está agora %s serviço.",
        not_on_duty = "Fora de Serviço",
        must_be_on_duty = "Você deve estar em serviço para receber salários.",
        paycheck_title = "Salário",
        employer_insufficient_funds = "Seu chefe não tem fundos suficientes para pagar você.",
        paycheck_added = "Salário de $%s adicionado ao saldo do funcionário %s para o trabalho: %s",
        paycheck_received = "Você recebeu um salário de $%s de %s",
    },

    BillingInviteNotification = {
        message = "Você recebeu uma solicitação de pagamento.",

        -- Titles / headers
        title = "Solicitação de Pagamento",
        label = "Notificação de Faturamento",

        -- Button labels
        pay_button = "Pagar Fatura",
        decline_button = "Rejeitar",

        -- Small UI labels used inside the notification component
        business_label = "Negócio",
        total_amount_label = "Valor Total",
        reason_label = "Motivo",
        amount_label = "Valor:",

        -- Warning / helper texts
        warning_text = "O pagamento será deduzido da sua conta. Garanta fundos suficientes.",
        expires_text = "Expira em %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    JobInviteNotification = {
        message = "Você foi convidado para se juntar como %s na Burgershot. Você aceita?",

        -- Titles / headers
        title = "Convite de Trabalho",
        label = "Notificação de Convite de Trabalho",

        -- Button labels
        accept_button = "Aceitar",
        reject_button = "Rejeitar",

        -- Small UI labels used inside the notification component
        company_label = "Empresa",
        grade_label = "Grau",
        invites_left_label = "Convites Restantes",
        salary_label = "Salário",

        -- Warning / helper texts
        warning_text = "Aceitar este trabalho comprometerá você com o cargo. Certifique-se de que está pronto para começar.",
        expires_text = "Expira em %s", -- %s will be replaced with the remaining time (MM:SS)
    },

    RestaurantMenu = {
        title = "Menu do Restaurante",
        onduty = "Você precisa estar em serviço para acessar o menu do restaurante.",
    },

    Duty = {
        status = "Status de Serviço",
        management = "Gerenciamento de Serviço",
        description = "Você está agora %s serviço.",
        restaurant_area = "Área do Restaurante",
        clock_in = "Você entrou na área do restaurante. Use o menu de funcionário para bater ponto.",
        enter_workplace = "Você entrou no seu local de trabalho e agora está em serviço.",
        leave_workplace = "Você saiu do seu local de trabalho e agora está fora de serviço.",
        inside_workplace = "Você está dentro do seu local de trabalho - definido automaticamente como em serviço.",
        outside_workplace = "Você está fora do seu local de trabalho - definido automaticamente como fora de serviço.",
        duty_warning = "Aviso de Serviço",
        auto_off_duty = "Você será automaticamente definido como fora de serviço quando sair do restaurante.",
        no_permission_manage_duty = "Você não tem permissão para gerenciar o status de serviço dos funcionários",
        not_employee_of_job = "O jogador não é um funcionário deste trabalho",
        duty_set_by_management = "Seu status de serviço foi definido para %s pela gerência",
        duty_management_success = "Definido com sucesso o status de serviço de %s para %s",
        updated_offline_employee = "Atualizado status de serviço de funcionário offline",
    },

    Paycheck = {
        title = "Salário Recebido",
        message = "Você recebeu um salário de $%s de %s",
    },

    VendingMachine = {
        sell_item = "Vender Item",
        select_item_from_inventory = "Selecionar Item do Inventário",
        add_to_vending = "ADICIONAR %s À MÁQUINA",
        cancel = "CANCELAR",
        no_matching_items = "Nenhum item correspondente no inventário",
        stocked_items = "Itens em Estoque",
        sell = "Vender",
        no_stock = "Sem Estoque",
        items = "itens em estoque",
        ready_to_serve = "Pronto para Servir!",
    },

    EmployeeVendingMachine = {
        title = "Coletar da Máquina",
        label = "Coletar itens do estoque da máquina",
        collect = "Coletar",
        cancel = "Cancelar",
        quantity_available = "Quantidade (Disponível: %s)",
        collect_item = "Coletar %s",
        collect_button = "Coletar",
        in_stock = "Em Estoque",
        vending_machine_empty = "Esta máquina de vendas está vazia.",
    },

    OrderingTab = {
        where_eating_today = "Onde você vai comer hoje?",
        eat_in = "Comer Aqui",
        take_out = "Para Viagem",
        whats_up = "e aí?",
        popular = "Popular",
        done = "Pronto",
        my_order = "Meu Pedido",
        empty = "Vazio",
        total = "Total",
        checkout = "Finalizar",
        back = "Voltar",
        no_menu_items = "Nenhum item de menu disponível para %s",
        loading = "Carregando...",
        eat_in_label = "Comer Aqui",
        take_out_label = "Para Viagem",
        pay_cash = "Dinheiro",
        cancel = "Cancelar",
        order = "Pedir",
        pay_bank = "Banco",
        all_items = "Todos os Itens",
        bank_only_disclaimer = "O pagamento pode ser feito apenas via banco.",
    },

    OrderManagementTable = {
        title = "Painel de Gerenciamento de Pedidos",
        label = "Administração de Pedidos",
        filter_all = "Todos",
        filter_cooking = "Cozinhando",
        filter_ready = "Pronto",
        filter_completed = "Concluído",
        filter_terminal_orders = "Pedidos do Terminal",
        filter_self_pickup = "Pedidos do Quiosque",
        sort_by = "Ordenar Por",
        sort_day = "Dia",
        sort_amount = "Valor",
        sort_name = "Nome",
        no_orders = "Nenhum pedido corresponde ao filtro atual.",
        accept = "ACEITAR",
        accepting = "ACEITANDO...",
        cooking = "COZINHANDO",
        ready = "PRONTO",
        complete = "CONCLUIR",
        completed = "CONCLUÍDO",
        assigned_to = "Atribuído a: ",
        items_label = "Itens:",
        order_label = "Pedido #",
        status_cooking = "cozinhando",
        status_ready = "pronto",
        status_completed = "concluído",
        status_cancelled = "cancelado",
        self_pickup = "Retirada Própria",
    },

    MenuSelectionDialog = {
        title = "Escolher Ação",
        subtitle = "O que você gostaria de fazer?",
        options = {
            shop = {
                title = "Abrir Loja",
                description = "Navegar e comprar itens da máquina de venda automática"
            },
            manageBoss = {
                title = "Gerenciar Loja",
                description = "Gerenciar inventário, ver análises e controlar a máquina de venda automática"
            },
            manageEmployee = {
                title = "Gerenciar Loja",
                description = "Adicionar e gerenciar itens de inventário na máquina de venda automática"
            }
        }
    },
}