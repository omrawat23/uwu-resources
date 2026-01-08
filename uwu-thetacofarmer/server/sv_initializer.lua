local tablePrefix = "crux_uwucafe_cafess_"

local function PrintInfo(message)
    print("^2[DB INIT]^7 " .. message)
end

local function PrintError(message)
    print("^1[DB INIT ERROR]^7 " .. message)
end

-- Detect which framework is running
local function DetectFramework()
    if GetResourceState("qb-core") ~= "missing" then
        return "qb"
    elseif GetResourceState("qbx_core") ~= "missing" then
        return "qbx"
    elseif GetResourceState("es_extended") ~= "missing" then
        return "esx"
    else
        PrintError("No compatible framework detected! Supported: QBCore, QBX, ESX")
        return nil
    end
end

-- Initialize the database
local function InitDatabase()
    local framework = DetectFramework()
    if not framework then return end

    PrintInfo("Initializing database tables...")
    Wait(1000)

    -- 1. DEFINE QUERIES
    local queries = {
        bossmenu = [[
            CREATE TABLE IF NOT EXISTS `%sbossmenu` (
                `id` varchar(50) NOT NULL,
                `business_name` varchar(50) NOT NULL DEFAULT 'Food Business',
                `balance` int(11) DEFAULT 0,
                PRIMARY KEY (`id`)
            )
        ]],
        orders = [[
            CREATE TABLE IF NOT EXISTS `%sorders` (
            `id` INT(11) NOT NULL AUTO_INCREMENT,
            `order_id` VARCHAR(50) NOT NULL,
            `order_label` INT(11) DEFAULT NULL,
            `order_date` DATE DEFAULT NULL,
            `customer_name` VARCHAR(255) DEFAULT NULL,
            `customer_identifier` VARCHAR(255) NULL DEFAULT NULL,
            `employee_identifier` VARCHAR(255),
            `self_pickup` BOOLEAN NOT NULL DEFAULT FALSE,
            `items` JSON NOT NULL,
            `total_amount` DECIMAL(10,2) NOT NULL,
            `status` ENUM('cooking', 'ready', 'completed', 'cancelled') NOT NULL DEFAULT 'cooking',
            `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                PRIMARY KEY (`id`),
                KEY `idx_order_date` (`order_date`)
            )
        ]],
        employees = [[
            CREATE TABLE IF NOT EXISTS `%semployees` (
                `license` varchar(50) NOT NULL,
                `balance` int(11) DEFAULT 0,
                `name` varchar(50) NOT NULL,
                `experience` int(11) NOT NULL DEFAULT 0,
                `deliveries` int(11) DEFAULT 0,
                `image` varchar(255),
                `job` VARCHAR(50) DEFAULT NULL,
                `job_grade` INT DEFAULT 0,
                `billings` INT DEFAULT 0,
                `delivery_balance` INT DEFAULT 0,
                `billing_balance` INT DEFAULT 0,
                `paycheck_balance` INT DEFAULT 0,
                `notifications_enabled` BOOLEAN NOT NULL DEFAULT TRUE,
                `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                PRIMARY KEY (`license`)
            )
        ]],
        vendingMachineItems = [[
            CREATE TABLE IF NOT EXISTS `%svendingMachineItems` (
                `id` INT AUTO_INCREMENT PRIMARY KEY,
                `name` VARCHAR(50) NOT NULL,
                `label` VARCHAR(50) NOT NULL,
                `price` INT NOT NULL DEFAULT 0,
                `image` VARCHAR(255) NOT NULL,
                `category` VARCHAR(50) DEFAULT 'Ingredients',
                `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
            )
        ]],
        vendingmenuItemsSold = [[
            CREATE TABLE IF NOT EXISTS `%svendingmenuItemsSold` (
                `id` INT AUTO_INCREMENT PRIMARY KEY,
                `name` VARCHAR(50) NOT NULL,
                `label` VARCHAR(50) NOT NULL,
                `quantity` INT NOT NULL DEFAULT 0,
                `image` VARCHAR(255) NOT NULL,
                `vending_index` INT NOT NULL DEFAULT 0,
                `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
            )
        ]],
        menuItems = [[
            CREATE TABLE IF NOT EXISTS `%smenuItems` (
                `id` INT AUTO_INCREMENT PRIMARY KEY,
                `name` VARCHAR(50) NOT NULL,
                `label` VARCHAR(50) NOT NULL,
                `price` INT NOT NULL DEFAULT 0,
                `image` VARCHAR(255) NOT NULL,
                `category` VARCHAR(50) NOT NULL DEFAULT 'Ingredients',
                `categoryimage` VARCHAR(255) NOT NULL DEFAULT '',
                `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
            )
        ]],
        transactions = [[
            CREATE TABLE IF NOT EXISTS `%stransactions` (
                `id` INT AUTO_INCREMENT PRIMARY KEY,
                `sender_identifier` VARCHAR(50) NOT NULL,
                `sender_name` VARCHAR(50) NOT NULL,
                `receiver_identifier` VARCHAR(50) NOT NULL,
                `receiver_name` VARCHAR(50) NOT NULL,
                `amount` INT NOT NULL,
                `commission_amount` INT NOT NULL DEFAULT 0,
                `reason` VARCHAR(255) NOT NULL,
                `payment_method` VARCHAR(20) NOT NULL,
                `items` TEXT NOT NULL,
                `job` VARCHAR(50) NOT NULL,
                `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ]],
        jobs = [[
            CREATE TABLE IF NOT EXISTS `%sjobs` (
                `name` varchar(50) NOT NULL,
                `label` varchar(50) NOT NULL,
                `type` varchar(50) DEFAULT 'public',
                `default_duty` BOOLEAN DEFAULT TRUE,
                PRIMARY KEY (`name`)
            )
        ]],
        job_grades = [[
            CREATE TABLE IF NOT EXISTS `%sjob_grades` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `job_name` varchar(50) NOT NULL,
                `grade` int(11) NOT NULL,
                `name` varchar(50) NOT NULL,
                `label` varchar(50) NOT NULL,
                `salary` int(11) NOT NULL DEFAULT 0,
                `commission` int(11) NOT NULL DEFAULT 0,
                `is_boss` BOOLEAN NOT NULL DEFAULT FALSE,
                PRIMARY KEY (`id`),
                KEY `job_name` (`job_name`),
                KEY `grade` (`grade`)
            )
        ]],
        user_jobs = [[
            CREATE TABLE IF NOT EXISTS `%suser_jobs` (
                `identifier` varchar(50) NOT NULL,
                `job` varchar(50) NOT NULL,
                `grade` int(11) NOT NULL DEFAULT 0,
                `onduty` BOOLEAN NOT NULL DEFAULT FALSE,
                PRIMARY KEY (`identifier`),
                KEY `job` (`job`),
                CONSTRAINT `%suser_jobs_ibfk_1` FOREIGN KEY (`job`) REFERENCES `%sjobs` (`name`) ON DELETE CASCADE
            )
        ]],
        paycheck_history = [[
            CREATE TABLE IF NOT EXISTS `%spaycheck_history` (
                `id` INT AUTO_INCREMENT PRIMARY KEY,
                `license` VARCHAR(50) NOT NULL,
                `name` VARCHAR(50) NOT NULL,
                `job` VARCHAR(50) NOT NULL,
                `job_grade` INT NOT NULL,
                `amount` INT NOT NULL,
                `from_society` BOOLEAN DEFAULT FALSE,
                `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                INDEX (`license`)
            )
        ]],
        business_settings = [[
            CREATE TABLE IF NOT EXISTS `%sbusiness_settings` (
                `job` VARCHAR(50) NOT NULL,
                `is_open` BOOLEAN NOT NULL DEFAULT TRUE,
                `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                PRIMARY KEY (`job`)
            )
        ]],
        player_job_vehicles = [[
            CREATE TABLE IF NOT EXISTS `%splayer_job_vehicles` (
              `id` int(11) NOT NULL AUTO_INCREMENT,
              `citizenid` varchar(50) NOT NULL,
              `plate` varchar(15) NOT NULL,
              `model` varchar(50) NOT NULL,
              `label` varchar(100) DEFAULT NULL,
              `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
              PRIMARY KEY (`id`),
              KEY `citizenid` (`citizenid`),
              KEY `plate` (`plate`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
        ]],
        storage_boxes = [[
            CREATE TABLE IF NOT EXISTS `%sstorage_boxes` (
                `id` INT(11) NOT NULL AUTO_INCREMENT,
                `item_id` VARCHAR(50) NOT NULL COMMENT 'Unique identifier for the item instance',
                `stash_id` VARCHAR(100) NOT NULL COMMENT 'Unique stash identifier',
                `owner_identifier` VARCHAR(50) DEFAULT NULL COMMENT 'Player identifier who created it',
                `items` LONGTEXT DEFAULT NULL COMMENT 'JSON encoded items stored in this storage box',
                `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                `last_accessed` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                PRIMARY KEY (`id`),
                UNIQUE KEY `unique_item_id` (`item_id`),
                UNIQUE KEY `unique_stash_id` (`stash_id`),
                INDEX `idx_owner` (`owner_identifier`),
                INDEX `idx_stash` (`stash_id`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
        ]],
        vending_machine_status = [[
            CREATE TABLE IF NOT EXISTS `%svending_machine_status` (
                `id` INT AUTO_INCREMENT PRIMARY KEY,
                `vending_index` INT NOT NULL UNIQUE,
                `is_open` BOOLEAN NOT NULL DEFAULT TRUE,
                `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
            )
        ]],
        door_states = [[
            CREATE TABLE IF NOT EXISTS `%sdoor_states` (
                `door_index` INT NOT NULL,
                `is_locked` BOOLEAN NOT NULL DEFAULT TRUE,
                `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                PRIMARY KEY (`door_index`)
            )
        ]]
    }

    -- 2. EXECUTION ORDER
    local creationSteps = {
        { name = "bossmenu", query = queries.bossmenu, args = 1 },
        { name = "orders", query = queries.orders, args = 1 },
        { name = "employees", query = queries.employees, args = 1 },
        { name = "vendingMachineItems", query = queries.vendingMachineItems, args = 1 },
        { name = "vendingmenuItemsSold", query = queries.vendingmenuItemsSold, args = 1 },
        { name = "menuItems", query = queries.menuItems, args = 1 },
        { name = "transactions", query = queries.transactions, args = 1 },
        { name = "paycheck_history", query = queries.paycheck_history, args = 1 },
        { name = "business_settings", query = queries.business_settings, args = 1 },
        { name = "player_job_vehicles", query = queries.player_job_vehicles, args = 1 },
        { name = "storage_boxes", query = queries.storage_boxes, args = 1 },
        { name = "vending_machine_status", query = queries.vending_machine_status, args = 1 },
        { name = "door_states", query = queries.door_states, args = 1 },
        
        -- Parent then Children
        { name = "jobs", query = queries.jobs, args = 1 },
        { name = "job_grades", query = queries.job_grades, args = 3 },
        { name = "user_jobs", query = queries.user_jobs, args = 3 }
    }

    -- 3. EXECUTE
    for _, step in ipairs(creationSteps) do
        local finalQuery = ""
        if step.args == 1 then
            finalQuery = string.format(step.query, tablePrefix)
        elseif step.args == 3 then
            finalQuery = string.format(step.query, tablePrefix, tablePrefix, tablePrefix)
        end

        local success, result = pcall(function()
            return MySQL.query.await(finalQuery)
        end)

        if success then
            PrintInfo("Table '" .. tablePrefix .. step.name .. "' verified.")
        else
            PrintError("Failed '" .. tablePrefix .. step.name .. "': " .. tostring(result))
        end
        Wait(50)
    end

    PrintInfo("Database initialization complete")
end

if MySQL then
    CreateThread(function()
        if Config.AutoInstallSql then
            InitDatabase()
        else
            PrintInfo("Automatic SQL installation is disabled in config.")
        end
    end)
end