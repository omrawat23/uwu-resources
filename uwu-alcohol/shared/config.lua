Config = {}

-- Module System Selection
-- Values:
--  'auto-detect' - Automatically detect the appropriate system
--   Or specify a specific system to use

-- Framework selection
Config.Framework = "qb"  -- Options: auto-detect, qb, esx, qbx

-- Target system selection
Config.Target = "ox"  -- Options: auto-detect, qb (qb-target), qt (qtarget), ox (ox_target)

-- Inventory system selection
Config.Inventory = "ox"  -- Options: auto-detect, qb, ox, qs, esx, chezza, bp, codem, origen, tgiann, qbnew, ps

-- Menu system selection
Config.Menu = "ox"  -- Options: auto-detect, qb, ox, esx, nh

-- Input system selection
Config.Input = "ox"  -- Options: auto-detect, qb, ox, nh

-- Progress bar system selection
Config.Progress = "qb"  -- Options: auto-detect, qb, ox, rprogress, pogress

Config.Fonts = "Bungee"  -- Specify one of the 20 fonts: Acme, Anton, Archivo Black, Bangers, Bebas Neue, Bungee, Caprasimo, Changa One, Lilita One, Luckiest Guy, Oswald, Passion One, Paytone One, Press Start 2P, Righteous, Rowdies, Rubik Mono One, Russo One, Titan One

Config.CraftingMenuPosition = 'right'  --center,left,right

Config.VehicleKeys = "qb" -- Options: auto-detect, qb, qbx, cd, jaksam, mk, mrnewb, okok, qs, renewed, t1ger, tgiann, wasabi

Config.adminPermissions = {
    "admin",
    "superadmin",
    "command.jobadmin", -- Specific permission for job system
    "command.admin",    -- Common admin permission
    "god",              -- Common god-mode/superadmin permission
    "group.admin"       -- Group-based admin permission
}

Config.AutoInstallSql = true -- Enable/disable automatic SQL installation
Config.DebugScript = true -- Enable/disable debug messages in the script console
Config.DepositMoney = 'cash' -- 'cash' or 'bank' - Set the default deposit method for the boss menu
Config.WithdrawMoney = 'cash' -- 'cash' or 'bank' - Set the default withdraw method for the boss menu
Config.EmployeeWithdrawMoney = 'cash' -- 'cash' or 'bank' - Set the default withdraw method for the employee menu

Config.JobInviteTimer = 30 -- Time in seconds for job invite to expire
Config.BillTimer  = 30 -- Time in seconds for bill invite to expire

Config.BillItemName = "bill" -- Item name for the bill item

Config.CloseUiButton = { 'ESCAPE' } -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

-- Door Animation 
Config.DoorAnimation = {
    enable = true,
    dict = 'anim@heists@keycard@',
    name = 'exit',
}

Config.BossMenuInventoryStorage = {
    label = "Burgershot Boss Menu Storage",
    slots = 50, -- Number of slots in the storage box
    weight = 100000, -- Total weight capacity of the storage box
}

Config.Notify = "qb"  -- Options: ox, esx, qb, okok

Config.debugPoly = true   -- For the targeting boxes

Config.InventoryImages = "nui://qb-inventory/html/images/" --"nui://ox_inventory/web/images/" -- "nui://qs-inventory/html/images/"

Config.DoorImages = {
    locked = Config.InventoryImages .. "locked.png",
    unlocked = Config.InventoryImages .. "unlocked.png"
}

Config.Locales = "en" 
Config.LocalesUtils = "en"

Config.JobName = 'burgerpolice'
Config.JobLabel = 'Uwu Cafe'

-- Add command configuration for custom job system
Config.JobSystem = {
    Commands = {
        GiveJob = 'crux_givejob',
        RemoveJob = 'crux_removejob',
        CheckJob = 'crux_checkjob'
    }
}

Config.StorageBox ={
    enabled = true,
    id = "uwucafe_storage",
    label = "Uwu Cafe Storage",
    slots = 5, -- Number of slots in the storage box
    weight = 100000, -- Total weight capacity of the storage box
    item = "bs_burgerbun", -- Default item to use to open the storage box (NOTE: This item will be unique and non-stackable when purchased)
}

Config.NeedDuty = false -- If true, players need to be on duty to access certain features like crafting, shop, billing,delivery etc.

Config.DirtyHands = false -- If true people need to wash hands before crafting

Config.ActivePreset = "gabz"  -- gabz, g&n, molols, moloss, uniqx, kingmaps

Config.UsableMenuItem = {
    enabled = true,
    items = {
        {
            item = "bs_fanta",
            image = Config.InventoryImages .. "bs_coke.png",
        },
        {
            item = "bs_coke",
            image = Config.InventoryImages .. "uwucafemenu.png",
        },
    }
}

Config.Grades = {
    ['1'] = {
        Label = 'Trainee',
        OutfitName = 'Trainee Uniform',
        Salary = 150,
        Commission = 10, -- 10% commission
        Experience = 0, -- Starting position, no XP needed
    },
    ['2'] = {
        Label = 'Cooker',
        OutfitName = 'Cooker Uniform',
        Salary = 175,
        Commission = 20, -- 20% commission
        Experience = 1000, -- Promote to Cooker at 1000+ XP
    },
    ['3'] = {
        Label = 'Cashier',
        OutfitName = 'Cashier Uniform',
        Salary = 200,
        Commission = 30, -- 30% commission
        Experience = 3000, -- Promote to Cashier at 3000+ XP
    },
    ['4'] = {
        Label = 'Shift Supervisor',
        OutfitName = 'Supervisor Uniform',
        Salary = 250,
        Commission = 40, -- 40% commission
        Experience = 7500, -- Promote to Shift Supervisor at 7500+ XP
    },
    ['5'] = {
        Label = 'Manager',
        OutfitName = 'Manager Outfit',
        IsBoss = true,    -- add this in grades can open bossmenu, and this grade can only given by admin (example the boss of burgershot cant give to another employee Manager grade)
        Salary = 300,
        Commission = 50, -- 50% commission
        Experience = 15000, -- Promote to Manager at 15000+ XP (if not boss-only)
    },
}

-- Experience-based progression system
Config.Experience = {
    Enabled = true,               -- Enable/disable the experience-based progression system

    -- Maximum grade players can reach through experience alone
    MaxAutoGrade = 4,

    Notifications = {
        Enabled = true,
        Title = "Promotion",
        Type = "success",
        Duration = 7500,
    },
}

-- Discord Webhook Logging
Config.DiscordLogging = {
    enabled = true,
    webhook = "https://discord.com/api/webhooks/1399766865215094925/8ZTV2xIDF7hseVWgXkt9VujLXJiOQyyChFmCrAdLtFiLQWv4-KPxEUols3fBLMP2aqma",
    botName = "UWU CAFE LOGS",
    botAvatar = "https://i.ibb.co/67YGHW7j/UWU.webp",
    color = {
        crafting = 3066993,     -- Green
        billing = 15105570,     -- Orange
        delivery = 5814783,     -- Blue
        garage = 16776960,      -- Yellow
        transaction = 10181046, -- Purple
        vending = 3447003,     -- Light Blue
    },
    logEvents = {
        craftingAttempt = true,
        craftingSuccess = true,
        craftingFailure = true,
        
        billingAttempt = true,
        billingPayment = true,
        billingFailure = true,
        
        deliveryComplete = true,
        deliveryFailure = true,
        
        vehicleSpawn = true,
        vehicleReturn = true,

        vendingItemAdded = true,
        vendingItemCollected = true,
        
        transactionComplete = true,
        transactionFailure = true
    }
}

Config.Salaries = {
    Enable = true,

    -- [true]: pay employees from bossmenu balance
    -- [false]: just pay, without remove money from bossmenu balance
    SocietyPay = true,

    -- [true]: Salaries are distributed only to on-duty players.
    -- [false]: Salaries are distributed to any online player with the job.
    -- NOTE: If set to true, ensure the duty system is also enabled (see line 78 in this file).
    OnlyOnDuty = true,

    Time = 1, -- Time interval in minutes. Salaries are distributed every 1 minute.
}

Config.Billing = {

    EnableCommand = true,
    Command = "ucbilling",

    Commission = {
        enabled = true,
    },

    Experience = {
        enabled = true,
        experienceperbill = 5, -- Experience per bill
        mincartvaluetoaddexperience = 50, -- Minimum cart value to add experience
    }
}

Config.Shop = {
    enabled = true,

    RequireJob = false, -- Set to true if only job members should access the shop

    Ped = {
        Type = 4,
        Hash = GetHashKey("mp_m_waremech_01"),
        Scenario = "WORLD_HUMAN_CLIPBOARD"
    },

    targeticon = "fas fa-shopping-cart",
    targetlabel = "Shop",

    shopItems = {
            {
                id = "1",
                name = "uc_avocado",
                price = 30,
                image = Config.InventoryImages .. "uc_avocado.png",
                quantity = 1,
                label = "Avocado",
                category = "Ingredients",
            },
            {
                id = "2",
                name = "uc_bakingpowder",
                price = 15,
                image = Config.InventoryImages .. "uc_bakingpowder.png",
                quantity = 1,
                label = "Baking Powder",
                category = "Ingredients",
            },
            {
                id = "3",
                name = "uc_blueberry",
                price = 30,
                image = Config.InventoryImages .. "uc_blueberry.png",
                quantity = 1,
                label = "Blueberry",
                category = "Ingredients",
            },
            {
                id = "4",
                name = "uc_butter",
                price = 15,
                image = Config.InventoryImages .. "uc_butter.png",
                quantity = 1,
                label = "Butter",
                category = "Ingredients",
            },
            {
                id = "5",
                name = "uc_caramel",
                price = 20,
                image = Config.InventoryImages .. "uc_caramel.png",
                quantity = 1,
                label = "Caramel",
                category = "Ingredients",
            },
            {
                id = "6",
                name = "uc_chicken",
                price = 10,
                image = Config.InventoryImages .. "uc_chicken.png",
                quantity = 1,
                label = "Chicken",
                category = "Ingredients",
            },
            {
                id = "7",
                name = "uc_chickenleg",
                price = 15,
                image = Config.InventoryImages .. "uc_chickenleg.png",
                quantity = 1,
                label = "Chicken Leg",
                category = "Ingredients",
            },
            {
                id = "8",
                name = "uc_chocolate",
                price = 10,
                image = Config.InventoryImages .. "uc_chocolate.png",
                quantity = 1,
                label = "Chocolate",
                category = "Ingredients",
            },
            {
                id = "9",
                name = "uc_coffeebeans",
                price = 15,
                image = Config.InventoryImages .. "uc_coffeebeans.png",
                quantity = 1,
                label = "Coffee Beans",
                category = "Ingredients",
            },
            {
                id = "10",
                name = "bs_eggs",
                price = 15,
                image = Config.InventoryImages .. "uc_eggs.png",
                quantity = 1,
                label = "Eggs",
                category = "Ingredients",
            },
            {
                id = "11",
                name = "uc_flour",
                price = 15,
                image = Config.InventoryImages .. "uc_flour.png",
                quantity = 1,
                label = "Flour",
                category = "Ingredients",
            },
            {
                id = "12",
                name = "uc_mango",
                price = 15,
                image = Config.InventoryImages .. "uc_mango.png",
                quantity = 1,
                label = "Mango",
                category = "Ingredients",
            },
            {
                id = "13",
                name = "uc_milk",
                price = 15,
                image = Config.InventoryImages .. "uc_milk.png",
                quantity = 1,
                label = "Milk",
                category = "Ingredients",
            },
            {
                id = "14",
                name = "uc_muffin",
                price = 15,
                image = Config.InventoryImages .. "uc_muffin.png",
                quantity = 1,
                label = "Muffin",
                category = "Ingredients",
            },
            {
                id = "15",
                name = "uc_norisheet",
                price = 15,
                image = Config.InventoryImages .. "uc_norisheet.png",
                quantity = 1,
                label = "Nori Sheet",
                category = "Ingredients",
            },
            {
                id = "16",
                name = "uc_plaindonut",
                price = 15,
                image = Config.InventoryImages .. "uc_plaindonut.png",
                quantity = 1,
                label = "Plain Donut",
                category = "Ingredients",
            },
            {
                id = "17",
                name = "uc_rice",
                price = 15,
                image = Config.InventoryImages .. "uc_rice.png",
                quantity = 1,
                label = "Rice",
                category = "Ingredients",
            },
            {
                id = "18",
                name = "bs_salt",
                price = 15,
                image = Config.InventoryImages .. "bs_salt.png",
                quantity = 1,
                label = "Salt",
                category = "Ingredients",
            },
            {
                id = "19",
                name = "uc_sugar",
                price = 15,
                image = Config.InventoryImages .. "uc_sugar.png",
                quantity = 1,
                label = "Sugar",
                category = "Ingredients",
            },
            {
                id = "20",
                name = "uc_tapiokaballs",
                price = 15,
                image = Config.InventoryImages .. "uc_tapiokaballs.png",
                quantity = 1,
                label = "Tapioka Balls",
                category = "Ingredients",
            },
            {
                id = "21",
                name = "uc_tunafish",
                price = 15,
                image = Config.InventoryImages .. "uc_tunafish.png",
                quantity = 1,
                label = "Tuna Fish",
                category = "Ingredients",
            },
            {
                id = "22",
                name = "uc_vegetable",
                price = 15,
                image = Config.InventoryImages .. "uc_vegetable.png",
                quantity = 1,
                label = "Vegetable",
                category = "Ingredients",
            },
            {
                id = "23",
                name = "uc_vegetableoil",
                price = 15,
                image = Config.InventoryImages .. "uc_vegetableoil.png",
                quantity = 1,
                label = "Vegetable Oil",
                category = "Ingredients",
            },
            {
                id = "24",
                name = "uc_noodles",
                price = 15,
                image = Config.InventoryImages .. "uc_noodles.png",
                quantity = 1,
                label = "Noodles",
                category = "Ingredients",
            },
            {
                id = "25",
                name = "uc_plate",
                price = 15,
                image = Config.InventoryImages .. "uc_plate.png",
                quantity = 1,
                label = "Plate",
                category = "Ingredients",
            },
            {
                id = "26",
                name = "uc_bowl",
                price = 15,
                image = Config.InventoryImages .. "uc_bowl.png",
                quantity = 1,
                label = "Bowl",
                category = "Ingredients",
            },
            {
                id = "27",
                name = "uc_cup",
                price = 15,
                image = Config.InventoryImages .. "uc_cup.png",
                quantity = 1,
                label = "Cup",
                category = "Ingredients",
            },
            {
                id = "28",
                name = "uc_glass",
                price = 15,
                image = Config.InventoryImages .. "uc_glass.png",
                quantity = 1,
                label = "Glass",
                category = "Ingredients",
            },
                        {
                id = "29",
                name = "water_bottle",
                price = 15,
                image = Config.InventoryImages .. "water_bottle.png",
                quantity = 1,
                label = "Water Bottle",
                category = "Ingredients",
            },
    },
}

-- singular category image mapping
Config.categoryimage = {
    Drinks = Config.InventoryImages .. "bs_coke.png",
    Food = Config.InventoryImages .. "bs_fanta.png",
    Deserts = Config.InventoryImages .. "bs_burgerbun.png",
    Ingredients = Config.InventoryImages .. "bs_burgerbun.png",
}

-- Menu items in BossMenu
Config.MenuItems = {
    {
        name = "uc_cappuccinocoffee",
        label = "Cappuccino Coffee",
        price = 30,
        image = Config.InventoryImages .. "uc_cappuccinocoffee.png",
        category = "Drinks",
    },
    {
        name = "uc_lattecoffee",
        label = "Latte Coffee",
        price = 15,
        image = Config.InventoryImages .. "uc_lattecoffee.png",
        category = "Drinks",
    },
    {
        name = "uc_espressocoffee",
        label = "Espresso Coffee",
        price = 30,
        image = Config.InventoryImages .. "uc_espressocoffee.png",
        category = "Drinks",
    },
    {
        name = "uc_chickennoodles",
        label = "Chicken Noodles",
        price = 15,
        image = Config.InventoryImages .. "uc_chickennoodles.png",
        category = "Food",
    },
    {
        name = "uc_chickenrice",
        label = "Chicken Rice",
        price = 20,
        image = Config.InventoryImages .. "uc_chickenrice.png",
        category = "Food",
    },
    {
        name = "uc_fishrice",
        label = "Fice Rice",
        price = 10,
        image = Config.InventoryImages .. "uc_fishrice.png",
        category = "Food",
    },
    {
        name = "uc_fishsushi",
        label = "Fish Sushi",
        price = 15,
        image = Config.InventoryImages .. "uc_fishsushi.png",
        category = "Food",
    },
    {
        name = "uc_sushi",
        label = "Sushi",
        price = 10,
        image = Config.InventoryImages .. "uc_sushi.png",
        category = "Food",
    },
    {
        name = "uc_buttermuffin",
        label = "Butter Muffin",
        price = 15,
        image = Config.InventoryImages .. "uc_buttermuffin.png",
        category = "Deserts",
    },
    {
        name = "uc_chocolatemuffin",
        label = "Chocolate Muffin",
        price = 15,
        image = Config.InventoryImages .. "uc_chocolatemuffin.png",
        category = "Deserts",
    },
    {
        name = "uc_pancake",
        label = "Pan Cake",
        price = 15,
        image = Config.InventoryImages .. "uc_pancake.png",
        category = "Deserts",
    },
    {
        name = "uc_carameldonut",
        label = "Caramel Donut",
        price = 15,
        image = Config.InventoryImages .. "uc_carameldonut.png",
        category = "Deserts",
    },
    {
        name = "uc_chocolatecookies",
        label = "Chocolate Cookies",
        price = 15,
        image = Config.InventoryImages .. "uc_chocolatecookies.png",
        category = "Deserts",
    },
    {
        name = "uc_chocolatedonut",
        label = "Chocolate Donut",
        price = 15,
        image = Config.InventoryImages .. "uc_chocolatedonut.png",
        category = "Deserts",
    },
    {
        name = "uc_avocadobubbletea",
        label = "Avocado Bubble Tea",
        price = 15,
        image = Config.InventoryImages .. "uc_avocadobubbletea.png",
        category = "Drinks",
    },
    {
        name = "uc_blueberrybubbletea",
        label = "Blueberry Bubble Tea",
        price = 15,
        image = Config.InventoryImages .. "uc_blueberrybubbletea.png",
        category = "Drinks",
    },
    {
        name = "uc_caramelbubbletea",
        label = "Caramel Bubble Tea",
        price = 15,
        image = Config.InventoryImages .. "uc_caramelbubbletea.png",
        category = "Drinks",
    },
    {
        name = "uc_mangobubbletea",
        label = "Mango Bubble Tea",
        price = 15,
        image = Config.InventoryImages .. "uc_mangobubbletea.png",
        category = "Drinks",
    },
    {
        name = "uc_chocolateshake",
        label = "Chocolate Shake",
        price = 15,
        image = Config.InventoryImages .. "uc_chocolateshake.png",
        category = "Drinks",
    },
}


Config.Food = {
    ["sandwich"] = {
        Hunger = -35,
        Thirst = -20,
        Stress = 10,
        Log = "You ate a Chicken Noodles",
        Remove = true,
        RemoveItems = {
            {item = "uc_chickennoodles", count = 1}
        },
        Add = true,
        AddItems = {
            {item = "uc_dirtybowl", count = 1},
        },
        ProgressBar = "Eating Chicken Noodles...",
        duration = 5, -- Duration in seconds
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_inteat@burger',
                    clip = 'mp_player_int_eat_burger'
                },
                prop = {
                    model = 'prop_cs_burger_01',
                    bone = 18905,
                    pos = vec3(0.13, 0.05, 0.02),
                    rot = vec3(-50.0, 16.0, 60.0)
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_EATING"
                },
            },
        }
    },
    ["uc_chickenrice"] = {
        Hunger = 35,
        Thirst = 0,
        Stress = 0,
        Log = "You ate a Chicken Rice",
        Remove = true,
        RemoveItems = {
            {item = "uc_chickenrice", count = 1}
        },
        Add = true,
        AddItems = {
            {item = "uc_dirtyplate", count = 1},
        },
        ProgressBar = "Eating Chicken Rice...",
        duration = 5, -- Duration in seconds
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_inteat@burger',
                    clip = 'mp_player_int_eat_burger'
                },
                prop = {
                    model = 'prop_cs_burger_01',
                    bone = 18905,
                    pos = vec3(0.13, 0.05, 0.02),
                    rot = vec3(-50.0, 16.0, 60.0)
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_EATING"
                },
            },
        }
    },
    ["uc_fishrice"] = {
        Hunger = 35,
        Thirst = 0,
        Stress = 0,
        Log = "You ate a Fish Rice",
        Remove = true,
        RemoveItems = {
            {item = "uc_fishrice", count = 1}
        },
        Add = true,
        AddItems = {
            {item = "uc_dirtyplate", count = 1},
        },
        ProgressBar = "Eating Fish Rice...",
        duration = 5, -- Duration in seconds
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_inteat@burger',
                    clip = 'mp_player_int_eat_burger'
                },
                prop = {
                    model = 'prop_cs_burger_01',
                    bone = 18905,
                    pos = vec3(0.13, 0.05, 0.02),
                    rot = vec3(-50.0, 16.0, 60.0)
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_EATING"
                },
            },
        }
    },
    ["uc_fishsushi"] = {
        Hunger = 35,
        Thirst = 0,
        Stress = 0,
        Log = "You ate a Fish Sushi",
        Remove = true,
        RemoveItems = {
            {item = "uc_fishsushi", count = 1}
        },
        Add = false,
        AddItems = {
            {item = "", count = 1},
        },
        ProgressBar = "Eating Fish Sushi...",
        duration = 5, -- Duration in seconds
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_inteat@burger',
                    clip = 'mp_player_int_eat_burger'
                },
                prop = {
                    model = 'prop_donut_01',
                    bone = 18905,
                    pos = vec3(0.13, 0.05, 0.02),
                    rot = vec3(-50.0, 16.0, 60.0)
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_EATING"
                },
            },
        }
    },
    ["uc_sushi"] = {
        Hunger = 35,
        Thirst = 0,
        Stress = 0,
        Log = "You ate a Sushi",
        Remove = true,
        RemoveItems = {
            {item = "uc_sushi", count = 1}
        },
        Add = false,
        AddItems = {
            {item = "", count = 1},
        },
        ProgressBar = "Eating Sushi...",
        duration = 5, -- Duration in seconds
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_inteat@burger',
                    clip = 'mp_player_int_eat_burger'
                },
                prop = {
                    model = 'prop_donut_01',
                    bone = 18905,
                    pos = vec3(0.13, 0.05, 0.02),
                    rot = vec3(-50.0, 16.0, 60.0)
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_EATING"
                },
            },
        }
    },
    ["uc_buttermuffin"] = {
        Hunger = 35,
        Thirst = 0,
        Stress = 0,
        Log = "You ate a Butter Muffin",
        Remove = true,
        RemoveItems = {
            {item = "uc_buttermuffin", count = 1}
        },
        Add = false,
        AddItems = {
            {item = "", count = 1},
        },
        ProgressBar = "Eating Butter Muffin...",
        duration = 5, -- Duration in seconds
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_inteat@burger',
                    clip = 'mp_player_int_eat_burger'
                },
                prop = {
                    model = 'prop_donut_01',
                    bone = 18905,
                    pos = vec3(0.13, 0.05, 0.02),
                    rot = vec3(-50.0, 16.0, 60.0)
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_EATING"
                },
            },
        }
    },
    ["uc_chocolatemuffin"] = {
        Hunger = 35,
        Thirst = 0,
        Stress = 0,
        Log = "You ate a Chocolate Muffin",
        Remove = true,
        RemoveItems = {
            {item = "uc_chocolatemuffin", count = 1}
        },
        Add = false,
        AddItems = {
            {item = "", count = 1},
        },
        ProgressBar = "Eating Chocolate Muffin...",
        duration = 5, -- Duration in seconds
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_inteat@burger',
                    clip = 'mp_player_int_eat_burger'
                },
                prop = {
                    model = 'prop_donut_01',
                    bone = 18905,
                    pos = vec3(0.13, 0.05, 0.02),
                    rot = vec3(-50.0, 16.0, 60.0)
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_EATING"
                },
            },
        }
    },
    ["uc_pancake"] = {
        Hunger = 35,
        Thirst = 0,
        Stress = 0,
        Log = "You ate a Pancake",
        Remove = true,
        RemoveItems = {
            {item = "uc_pancake", count = 1}
        },
        Add = true,
        AddItems = {
            {item = "uc_dirtyplate", count = 1},
        },
        ProgressBar = "Eating Pancake...",
        duration = 5, -- Duration in seconds
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_inteat@burger',
                    clip = 'mp_player_int_eat_burger'
                },
                prop = {
                    model = 'prop_donut_01',
                    bone = 18905,
                    pos = vec3(0.13, 0.05, 0.02),
                    rot = vec3(-50.0, 16.0, 60.0)
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_EATING"
                },
            },
        }
    },
    ["uc_carameldonut"] = {
        Hunger = 35,
        Thirst = 0,
        Stress = 0,
        Log = "You ate a Caramel Donut",
        Remove = true,
        RemoveItems = {
            {item = "uc_carameldonut", count = 1}
        },
        Add = false,
        AddItems = {
            {item = "", count = 1},
        },
        ProgressBar = "Eating Caramel Donut..",
        duration = 5, -- Duration in seconds
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_inteat@burger',
                    clip = 'mp_player_int_eat_burger'
                },
                prop = {
                    model = 'prop_donut_01',
                    bone = 18905,
                    pos = vec3(0.13, 0.05, 0.02),
                    rot = vec3(-50.0, 16.0, 60.0)
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_EATING"
                },
            },
        }
    },
    ["uc_chocolatecookies"] = {
        Hunger = 35,
        Thirst = 0,
        Stress = 0,
        Log = "You ate a Chocolate Cookies",
        Remove = true,
        RemoveItems = {
            {item = "uc_chocolatecookies", count = 1}
        },
        Add = false,
        AddItems = {
            {item = "", count = 1},
        },
        ProgressBar = "Eating Chocolate Cookies...",
        duration = 5, -- Duration in seconds
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_inteat@burger',
                    clip = 'mp_player_int_eat_burger'
                },
                prop = {
                    model = 'prop_donut_01',
                    bone = 18905,
                    pos = vec3(0.13, 0.05, 0.02),
                    rot = vec3(-50.0, 16.0, 60.0)
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_EATING"
                },
            },
        }
    },
    ["uc_chocolatedonut"] = {
        Hunger = 35,
        Thirst = 0,
        Stress = 0,
        Log = "You ate a Chocolate Donut",
        Remove = true,
        RemoveItems = {
            {item = "uc_chocolatedonut", count = 1}
        },
        Add = false,
        AddItems = {
            {item = "", count = 1},
        },
        ProgressBar = "Eating Chocolate Donut...",
        duration = 5, -- Duration in seconds
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_inteat@burger',
                    clip = 'mp_player_int_eat_burger'
                },
                prop = {
                    model = 'prop_donut_01',
                    bone = 18905,
                    pos = vec3(0.13, 0.05, 0.02),
                    rot = vec3(-50.0, 16.0, 60.0)
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_EATING"
                },
            },
        }
    },
}

Config.Drinks = {
    ["bs_eggs"] = {
        Hunger = -40,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Cappuccino Coffee",
        Remove = true,
        RemoveItems = {
            {item = "bs_eggs", count = 1}
        },
        Add = true,
        AddItems = {
            {item = "bs_eggs", count = 1}
        },
        ProgressBar = "Drinking Cappuccino Coffee...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'prop_food_juice02',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["uc_lattecoffee"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Latte Coffee",
        Remove = true,
        RemoveItems = {
            {item = "uc_lattecoffee", count = 1}
        },
        Add = true,
        AddItems = {
            {item = "uc_dirtycup", count = 1}
        },
        ProgressBar = "Drinking Latte Coffee...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'vw_prop_casino_water_bottle_01a',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["uc_espressocoffee"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = -30,
        Log = "You drank a Espresso Coffee",
        Remove = true,
        RemoveItems = {
            {item = "uc_espressocoffee", count = 1}
        },
        Add = true,
        AddItems = {
            {item = "uc_dirtycup", count = 1}
        },
        ProgressBar = "Drinking Espresso Coffee...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'prop_mojito',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["uc_avocadobubbletea"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Avocado Bubble Tea",
        Remove = true,
        RemoveItems = {
            {item = "uc_avocadobubbletea", count = 1}
        },
        Add = true,
        AddItems = {
            {item = "uc_dirtyglass", count = 1}
        },
        ProgressBar = "Drinking Avocado Bubble Tea...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'vw_prop_casino_water_bottle_01a',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["uc_blueberrybubbletea"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Blueberry Bubble Tea",
        Remove = true,
        RemoveItems = {
            {item = "uc_blueberrybubbletea", count = 1}
        },
        Add = true,
        AddItems = {
            {item = "uc_dirtyglass", count = 1}
        },
        ProgressBar = "Drinking Blueberry Bubble Tea...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'vw_prop_casino_water_bottle_01a',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["uc_caramelbubbletea"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Caramel Bubble Tea",
        Remove = true,
        RemoveItems = {
            {item = "uc_caramelbubbletea", count = 1}
        },
        Add = true,
        AddItems = {
            {item = "uc_dirtyglass", count = 1}
        },
        ProgressBar = "Drinking Caramel Bubble Tea...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'vw_prop_casino_water_bottle_01a',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["uc_mangobubbletea"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Mango Bubble Tea",
        Remove = true,
        RemoveItems = {
            {item = "uc_mangobubbletea", count = 1}
        },
        Add = true,
        AddItems = {
            {item = "uc_dirtyglass", count = 1}
        },
        ProgressBar = "Drinking Mango Bubble Tea...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'vw_prop_casino_water_bottle_01a',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["uc_chocolateshake"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Chocolate Shake",
        Remove = true,
        RemoveItems = {
            {item = "uc_chocolateshake", count = 1}
        },
        Add = true,
        AddItems = {
            {item = "uc_dirtyglass", count = 1}
        },
        ProgressBar = "Drinking Chocolate Shake...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'vw_prop_casino_water_bottle_01a',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
}


Config.Crafts = {
    ["craftid"] = { -- Craft Id setted up in the Config.Presets
        ["uc_cappuccinocoffee"] = {
            uc_milk = 1,
            uc_coffeebeans = 1,
            uc_sugar = 1,
            uc_cup = 1,
        },
        ["uc_lattecoffee"] = {
            uc_milk = 1,
            uc_coffeebeans = 1,
            uc_sugar = 1,
            uc_cup = 1,
        },
        ["uc_espressocoffee"] = {
            uc_milk = 1,
            uc_coffeebeans = 1,
            uc_sugar = 1,
            uc_cup = 1,
        },
    }, -- ... can create more
    ["craftid2"] = {
        ["uc_chickennoodles"] = {
            bs_salt = 1,
            uc_chicken = 1,
            uc_vegetable = 1,
            uc_noodles = 1,
            uc_vegetableoil = 1,
            uc_bowl = 1,
        },
        ["uc_chickenrice"] = {
            uc_chickenleg = 1,
            bs_salt = 1,
            uc_rice = 1,
            uc_vegetableoil = 1,
            uc_plate = 1,
        },
        ["uc_fishrice"] = {
            uc_tunafish = 1,
            bs_salt = 1,
            uc_rice = 1,
            uc_vegetableoil = 1,
            uc_plate = 1,
        },
        ["uc_fishsushi"] = {
            uc_rice = 1,
            uc_norisheet = 1,
            uc_tunafish = 1,
        },
        ["bs_burgerbun"] = {
            bs_fanta = 1,
      
        },
    },
    ["craftid3"] = {
        ["uc_buttermuffin"] = {
            uc_muffin = 1,
            uc_butter = 1,
            uc_sugar = 1,
        },
        ["uc_chocolatemuffin"] = {
            uc_chocolate = 1,
            uc_muffin = 1,
            uc_sugar = 1,
        },
        ["uc_pancake"] = {
            uc_flour = 1,
            uc_eggs = 1,
            uc_sugar = 1,
            uc_bakingpowder = 1,
            uc_plate = 1,
        },
        ["uc_carameldonut"] = {
            uc_caramel = 1,
            uc_plaindonut = 1,
            uc_sugar = 1
        },
        ["uc_chocolatecookies"] = {
            uc_chocolate = 1,
            uc_sugar = 1
        },
        ["uc_chocolatedonut"] = {
            uc_plaindonut = 1,
            uc_chocolate = 1,
            uc_sugar = 1
        },
    },
    ["craftid4"] = {
        ["uc_avocadobubbletea"] = {
            uc_avocado = 1,
            uc_milk = 1,
            uc_sugar = 1,
            uc_tapiokaballs = 1,
            uc_icecubes = 1,
            uc_glass = 1,
        },
        ["uc_blueberrybubbletea"] = {
            uc_blueberry = 1,
            uc_milk = 1,
            uc_sugar = 1,
            uc_tapiokaballs = 1,
            uc_icecubes = 1,
            uc_glass = 1,
        },
        ["uc_caramelbubbletea"] = {
            uc_caramel = 1,
            uc_milk = 1,
            uc_sugar = 1,
            uc_tapiokaballs = 1,
            uc_icecubes = 1,
            uc_glass = 1,
        },
        ["uc_mangobubbletea"] = {
            uc_mango = 1,
            uc_milk = 1,
            uc_sugar = 1,
            uc_tapiokaballs = 1,
            uc_icecubes = 1,
            uc_glass = 1,
        },
        ["uc_chocolateshake"] = {
            uc_chocolate = 1,
            uc_sugar = 1,
            uc_milk = 1,
            uc_icecubes = 1,
            uc_glass = 1,
        },
    }
}

Config.Garage = {
    enabled = true,

    OpenGarage_label  = "Garage",
    OpenGarage_icon   = "fas fa-car",

    ReturnVehicle_label  = "Return Vehicle",
    ReturnVehicle_icon   = "fas fa-reply",

    Ped = {
        Type = 4,
        Hash = GetHashKey("mp_m_waremech_01"),
        Scenario = "WORLD_HUMAN_CLIPBOARD"
    },

    ReturnRadius = 50,
    UseCustomImages = true,

    Vehicles = {
        [1] = {
            model = "nspeedo",
            label = "Speedo",
            livery = 0,
            image = Config.InventoryImages .. "uc_speedo.png",
            plateText = "UWU CAFE"
        },
        [2] = {
            model = "sultan",
            label = "Sultan Delivery",
            livery = 0,
            image = Config.InventoryImages .. "burgershot-menu.png",
            plateText = "BS-DEL1"
        },
        [3] = {
            model = "imperial",
            label = "Rumpo Van",
            livery = 0,
            image = "https://picsum.photos/200",
            plateText = "BS-VAN1"
        },
    },

}

Config.Delivery = {
    Enabled = true, -- true or false   - Enable or Disable Deliveries


    DeliveryPedTimer = 1,  -- Time in seconds to spawn a new delivery ped
    DeliveryUsingCash = true, -- true or false - Enables giving Cash on Delivery
    DeliveryUsingBossMenu = false, -- true or false - Enables giving Commission to the player on Delivery and adding rest money in bossmenu

    targeticon = "fas fa-bicycle",
    targetlabel = "Delivery Menu",
    targetDistance = 2.0,

    deliveryProp = 'prop_paper_bag_01',

    deliveries = {
        -- { items = { ["uc_fishrice"] = 3, ["uc_chickenrice"] = 2, ["uc_mangobubbletea"] = 1 }, cash = { min = 200, max = 350 } },
        -- { items = { ["uc_chocolatemuffin"] = 3, ["uc_caramelbubbletea"] = 2 }, cash = { min = 150, max = 350 } },
        { items = { ["uc_lattecoffee"] = 3 }, cash = { min = 100, max = 350 } },
    },

    Experience = {
        enabled = true,
        expPerDelivery = 10, -- Experience per delivery
    },

    -- Global delivery system settings
    delay = 3, -- Time in seconds between global deliveries
    max_time = 60, -- Max time to deliver the order in Seconds
    expire = 300,   -- Time to expire the delivery in seconds (if no one accepts it)

    -- Animation configurations
    animations = {
        -- Door knock animation
        doorKnock = {
            dict = "timetable@jimmy@doorknock@",
            anim = "knockdoor_idle",
            speed = 8.0,
            speedMultiplier = 8.0,
            duration = 2000,
            flag = 48,
            playbackRate = 1
        },
    },

    locations = {
        vector4(-668.25, -971.65, 21.34, 0.38),
        -- vector4(16.62, -1443.81, 29.95, 154.91),
        -- vector4(-32.25, -1446.33, 30.89, 89.67),
        -- vector4(-64.57, -1449.64, 31.52, 277.81),
        -- vector4(980.25, -627.68, 58.24, 31.47),
        -- vector4(943.26, -653.34, 57.43, 218.64),
        -- vector4(919.69, -569.58, 57.37, 208.9),
        -- vector4(976.69, -580.61, 58.85, 29.13),
        -- vector4(987.86, -525.81, 59.69, 211.06),
        -- vector4(1046.2, -498.09, 63.28, 349.9),
        -- vector4(1090.53, -484.37, 64.66, 76.56),
        -- vector4(1056.21, -449.01, 65.26, 347.65),
        -- vector4(1101.15, -411.31, 66.56, 85.7),
        -- vector4(1114.45, -391.23, 67.95, 64.1),
        -- vector4(1303.18, -527.34, 70.46, 159.99),
        -- vector4(1348.34, -546.74, 72.89, 154.53),
        -- vector4(1373.29, -555.77, 73.69, 65.12),
        -- vector4(1389.05, -569.48, 73.5, 116.03),
        -- vector4(1386.26, -593.46, 73.49, 52.85),
        -- vector4(1341.29, -597.3, 73.7, 234.34),
        -- vector4(1301.03, -574.3, 70.73, 342.2),
        -- vector4(1241.35, -566.38, 68.66, 316.44),
        -- vector4(1250.92, -620.92, 68.57, 209.42),
        -- vector4(192.34, -1883.26, 24.06, 151.18),
        -- vector4(128.32, -1896.97, 22.67, 65.46),
        -- vector4(130.6, -1853.28, 24.23, 148.8),
        -- vector4(104.01, -1885.41, 23.32, 322.19),
        -- vector4(54.42, -1873.12, 21.81, 136.86),
        -- vector4(5.3, -1884.26, 22.7, 50.34),
        -- vector4(-34.24, -1847.05, 25.19, 228.92),
        -- vector4(224.77, -160.8, 58.26, 253.82),
        -- vector4(315.07, -128.41, 68.98, 338.89),
        -- vector4(156.32, -116.99, 61.6, 251.38),
        -- vector4(76.22, -86.64, 62.01, 251.62),
        -- vector4(-6.63, -74.49, 60.87, 253.98),
        -- vector4(-66.78, 490.01, 143.88, 340.11),
        -- vector4(-355.85, 469.65, 111.65, 285.31),
        -- vector4(-348.77, 514.97, 119.65, 136.0),
        -- vector4(-580.37, 491.5, 107.9, 10.81),
        -- vector4(-762.06, 430.8, 99.2, 21.55),
        -- vector4(-842.73, 466.85, 86.6, 97.89),
        -- vector4(-884.59, 517.87, 91.44, 283.48),
        -- vector4(-1107.84, 594.54, 103.45, 207.39),
        -- vector4(-1146.5, 545.89, 100.91, 7.02),
        -- vector4(-1165.66, 726.74, 154.61, 322.3),
        -- vector4(-1540.01, 420.46, 109.01, 0.54),
        -- vector4(-655.2, 802.88, 197.99, 0.4),
        -- vector4(-747.32, 808.21, 214.15, 287.67),
        -- vector4(-824.09, 805.75, 201.78, 23.3),
        -- vector4(-912.3, 777.11, 186.01, 10.73),
        -- vector4(-999.54, 816.9, 172.05, 229.03),
        -- vector4(-1056.36, 761.48, 166.32, 274.94),
        -- vector4(-1100.65, 797.97, 166.26, 187.55),
        -- vector4(-1117.72, 761.39, 163.29, 26.72),
        -- vector4(-1174.37, 440.23, 85.85, 86.29),
        -- vector4(-943.21, -1075.33, 1.75, 210.4),
        -- vector4(-978.1, -1108.31, 1.15, 32.8),
        -- vector4(-1063.52, -1160.29, 1.75, 31.23),
        -- vector4(-1074.1, -1152.69, 1.16, 300.66),
        -- vector4(-1104.01, -1059.96, 1.73, 32.34),
        -- vector4(-1122.2, -1046.24, 1.15, 207.78),
        -- vector4(-1055.03, -998.28, 5.41, 122.21),
        -- vector4(-1041.65, -1025.78, 1.75, 30.42),
        -- vector4(222.61, -1702.46, 28.7, 212.23),
        -- vector4(252.89, -1670.78, 28.66, 145.41),
        -- vector4(257.54, -1722.85, 28.65, 139.8),
        -- vector4(250.11, -1730.78, 28.67, 49.96),
        -- vector4(270.43, -1917.04, 25.18, 145.06),
        -- vector4(250.82, -1934.99, 23.7, 45.74),
        -- vector4(148.92, -1960.57, 18.46, 224.13),
        -- vector4(179.27, -1923.88, 20.37, 141.87),
        -- vector4(304.47, -1775.43, 28.1, 226.84),
        -- vector4(320.64, -1759.79, 28.64, 230.56),
        -- vector4(348.68, -1821.01, 27.89, 318.37),
        -- vector4(329.37, -1845.87, 26.75, 45.84),
        -- vector4(256.37, -2023.51, 18.27, 228.03),
        -- vector4(291.54, -1980.13, 20.6, 142.65),
        -- vector4(295.73, -1971.77, 21.9, 226.12),
        -- vector4(324.33, -1937.29, 24.02, 143.75),
        -- vector4(368.69, -1895.74, 24.18, 136.84),
        -- vector4(385.05, -1881.49, 25.03, 223.88),
        -- vector4(412.36, -1856.36, 26.32, 315.33),
        -- vector4(440.56, -1829.62, 27.36, 134.71),
        -- vector4(472.1, -1775.14, 28.07, 270.9),
        -- vector4(489.61, -1714.03, 28.71, 247.46),
        -- vector4(514.33, -1780.87, 27.91, 89.63),
        -- vector4(495.3, -1823.35, 27.87, 319.59),
        -- vector4(1295.04, -1739.82, 53.27, 291.14),
        -- vector4(1289.16, -1710.57, 54.48, 200.22),
        -- vector4(1365.49, -1721.77, 64.63, 21.1),
        -- vector4(1354.84, -1690.55, 59.49, 263.81),
        -- vector4(808.78, -163.63, 74.88, 151.84),
        -- vector4(840.72, -182.16, 73.39, 58.28),
        -- vector4(880.33, -205.13, 70.98, 150.93),
        -- vector4(930.66, -245.14, 68.0, 237.94),
        -- vector4(952.8, -252.43, 66.96, 57.68),
        -- vector4(-896.66, -5.17, 42.8, 306.98),
        -- vector4(-842.25, -25.09, 39.4, 270.53),
        -- vector4(-971.55, 122.16, 56.05, 306.4),
        -- vector4(-949.21, 196.81, 66.39, 168.27),
        -- vector4(-1095.0, 427.25, 74.88, 262.82),
    },

    ped = {
        Type = 4,
        Hash = GetHashKey("u_m_y_burgerdrug_01"),
        Scenario = "WORLD_HUMAN_CLIPBOARD"
    },

    deliveryBlip = { sprite = 853, color = 3, scale = 1.0, name = 'Delivery Location' },

    deliveryPed = {
        {
            Type = 4,
            Hash = GetHashKey("a_m_m_afriamer_01"),
            Scenario = nil                          -- IF YOU WANT TO ADD SCENARIO FOR DELIVERY PEDS
        },
        {
            Type = 4,
            Hash = GetHashKey("u_m_m_aldinapoli"),
            Scenario = nil
        },
        {
            Type = 4,
            Hash = GetHashKey("s_m_y_ammucity_01"),
            Scenario = nil
        },
        {
            Type = 4,
            Hash = GetHashKey("s_m_m_ammucountry"),
            Scenario = nil
        },
        {
            Type = 4,
            Hash = GetHashKey("u_m_y_antonb"),
            Scenario = nil
        },
    }
}

Config.Outfits = {
    Enable = true,

    Animation = {
        Enable = true,
        Anim = {
            Dict = 'clothingshirt',
            Name = 'try_shirt_positive_d'
        }
    },

    -- Grade-specific outfits for male characters
    Male = {
        ['0'] = { -- Trainee uniform
            ["hat"] =       {Id = 218, Texture = 0},
            ["mask"] =      {Id = 0, Texture = 0},
            ["arms"] =      {Id = 19, Texture = 0},
            ["pants"] =     {Id = 24, Texture = 5},
            ["bag"] =       {Id = 0, Texture = 0},
            ["shoes"] =     {Id = 8, Texture = 2},
            ["t-shirt"] =   {Id = 15, Texture = 0},
            ["torso"] =     {Id = 527, Texture = 0},
            ["decals"] =    {Id = 0, Texture = 0},
            ["armor"] =     {Id = 0, Texture = 0},
        },
        ['1'] = { -- Cooker uniform
            ["hat"] =       {Id = 218, Texture = 0},
            ["mask"] =      {Id = 0, Texture = 0},
            ["arms"] =      {Id = 4, Texture = 0},   -- Different arms
            ["pants"] =     {Id = 24, Texture = 0},  -- Different texture
            ["bag"] =       {Id = 0, Texture = 0},
            ["shoes"] =     {Id = 10, Texture = 0},  -- Different shoes
            ["t-shirt"] =   {Id = 15, Texture = 2},  -- Different texture
            ["torso"] =     {Id = 73, Texture = 0},  -- Different torso
            ["decals"] =    {Id = 0, Texture = 0},
            ["armor"] =     {Id = 0, Texture = 0},
        },
        ['2'] = { -- Cashier uniform
            ["hat"] =       {Id = 218, Texture = 0},
            ["mask"] =      {Id = 0, Texture = 0},
            ["arms"] =      {Id = 4, Texture = 0},
            ["pants"] =     {Id = 24, Texture = 3},  -- Different texture
            ["bag"] =       {Id = 0, Texture = 0},
            ["shoes"] =     {Id = 10, Texture = 0},
            ["t-shirt"] =   {Id = 15, Texture = 2},
            ["torso"] =     {Id = 73, Texture = 2},  -- Different texture
            ["decals"] =    {Id = 0, Texture = 0},
            ["armor"] =     {Id = 0, Texture = 0},
        },
        ['3'] = { -- Shift Supervisor uniform
            ["hat"] =       {Id = 0, Texture = 0},   -- No hat
            ["mask"] =      {Id = 0, Texture = 0},
            ["arms"] =      {Id = 4, Texture = 0},
            ["pants"] =     {Id = 28, Texture = 2},  -- More formal pants
            ["bag"] =       {Id = 0, Texture = 0},
            ["shoes"] =     {Id = 10, Texture = 0},
            ["t-shirt"] =   {Id = 31, Texture = 0},  -- Business shirt
            ["torso"] =     {Id = 73, Texture = 3},  -- Different texture
            ["decals"] =    {Id = 0, Texture = 0},
            ["armor"] =     {Id = 0, Texture = 0},
        },
        ['4'] = { -- Manager uniform
            ["hat"] =       {Id = 0, Texture = 0},    -- No hat for manager
            ["mask"] =      {Id = 0, Texture = 0},
            ["arms"] =      {Id = 4, Texture = 0},    -- Shirt arms
            ["pants"] =     {Id = 28, Texture = 0},   -- Formal pants
            ["bag"] =       {Id = 0, Texture = 0},
            ["shoes"] =     {Id = 10, Texture = 0},   -- Formal shoes
            ["t-shirt"] =   {Id = 31, Texture = 0},   -- Business shirt
            ["torso"] =     {Id = 29, Texture = 0},   -- Suit jacket
            ["decals"] =    {Id = 0, Texture = 0},
            ["armor"] =     {Id = 0, Texture = 0},
        },
        ['5'] = { -- Manager uniform (same as 4, but for grade 5)
            ["hat"] =       {Id = 0, Texture = 0},    -- No hat for manager
            ["mask"] =      {Id = 0, Texture = 0},
            ["arms"] =      {Id = 4, Texture = 0},    -- Shirt arms
            ["pants"] =     {Id = 28, Texture = 0},   -- Formal pants
            ["bag"] =       {Id = 0, Texture = 0},
            ["shoes"] =     {Id = 10, Texture = 0},   -- Formal shoes
            ["t-shirt"] =   {Id = 31, Texture = 0},   -- Business shirt
            ["torso"] =     {Id = 29, Texture = 0},   -- Suit jacket
            ["decals"] =    {Id = 0, Texture = 0},
            ["armor"] =     {Id = 0, Texture = 0},
        }
    },

    -- Grade-specific outfits for female characters
    Female = {
        ['0'] = { -- Trainee uniform
            ["hat"] =       {Id = 217, Texture = 0},
            ["mask"] =      {Id = 0, Texture = 0},
            ["arms"] =      {Id = 20, Texture = 0},
            ["pants"] =     {Id = 50, Texture = 2},
            ["bag"] =       {Id = 0, Texture = 0},
            ["shoes"] =     {Id = 27, Texture = 0},
            ["t-shirt"] =   {Id = 15, Texture = 0},
            ["torso"] =     {Id = 568, Texture = 0},
            ["decals"] =    {Id = 0, Texture = 0},
            ["armor"] =     {Id = 0, Texture = 0},
        },
        ['1'] = { -- Cooker uniform
            ["hat"] =       {Id = 217, Texture = 0},
            ["mask"] =      {Id = 0, Texture = 0},
            ["arms"] =      {Id = 14, Texture = 0},  -- Different arms
            ["pants"] =     {Id = 50, Texture = 0},  -- Different texture
            ["bag"] =       {Id = 0, Texture = 0},
            ["shoes"] =     {Id = 29, Texture = 0},  -- Different shoes
            ["t-shirt"] =   {Id = 15, Texture = 2},  -- Different texture
            ["torso"] =     {Id = 57, Texture = 0},  -- Different torso
            ["decals"] =    {Id = 0, Texture = 0},
            ["armor"] =     {Id = 0, Texture = 0},
        },
        ['2'] = { -- Cashier uniform
            ["hat"] =       {Id = 217, Texture = 0},
            ["mask"] =      {Id = 0, Texture = 0},
            ["arms"] =      {Id = 14, Texture = 0},
            ["pants"] =     {Id = 50, Texture = 3},  -- Different texture
            ["bag"] =       {Id = 0, Texture = 0},
            ["shoes"] =     {Id = 29, Texture = 0},
            ["t-shirt"] =   {Id = 15, Texture = 2},
            ["torso"] =     {Id = 57, Texture = 2},  -- Different texture
            ["decals"] =    {Id = 0, Texture = 0},
            ["armor"] =     {Id = 0, Texture = 0},
        },
        ['3'] = { -- Shift Supervisor uniform
            ["hat"] =       {Id = 0, Texture = 0},   -- No hat
            ["mask"] =      {Id = 0, Texture = 0},
            ["arms"] =      {Id = 14, Texture = 0},
            ["pants"] =     {Id = 37, Texture = 2},  -- More formal pants
            ["bag"] =       {Id = 0, Texture = 0},
            ["shoes"] =     {Id = 13, Texture = 0},  -- Different shoes
            ["t-shirt"] =   {Id = 35, Texture = 0},  -- Business shirt style
            ["torso"] =     {Id = 57, Texture = 3},  -- Different texture
            ["decals"] =    {Id = 0, Texture = 0},
            ["armor"] =     {Id = 0, Texture = 0},
        },
        ['4'] = { -- Manager uniform
            ["hat"] =       {Id = 0, Texture = 0},    -- No hat
            ["mask"] =      {Id = 0, Texture = 0},
            ["arms"] =      {Id = 14, Texture = 0},   -- Shirt arms
            ["pants"] =     {Id = 37, Texture = 0},   -- Formal pants
            ["bag"] =       {Id = 0, Texture = 0},
            ["shoes"] =     {Id = 13, Texture = 0},   -- Formal shoes
            ["t-shirt"] =   {Id = 35, Texture = 0},   -- Blouse
            ["torso"] =     {Id = 7, Texture = 0},    -- Blazer
            ["decals"] =    {Id = 0, Texture = 0},
            ["armor"] =     {Id = 0, Texture = 0},
        },
        ['5'] = { -- Manager uniform (same as 4, but for grade 5)
            ["hat"] =       {Id = 0, Texture = 0},    -- No hat for manager
            ["mask"] =      {Id = 0, Texture = 0},
            ["arms"] =      {Id = 4, Texture = 0},    -- Shirt arms
            ["pants"] =     {Id = 28, Texture = 0},   -- Formal pants
            ["bag"] =       {Id = 0, Texture = 0},
            ["shoes"] =     {Id = 10, Texture = 0},   -- Formal shoes
            ["t-shirt"] =   {Id = 31, Texture = 0},   -- Business shirt
            ["torso"] =     {Id = 29, Texture = 0},   -- Suit jacket
            ["decals"] =    {Id = 0, Texture = 0},
            ["armor"] =     {Id = 0, Texture = 0},
        }
    }
}

Config.RestaurantMenu = Config.InventoryImages .. "uwucafemenu.png" -- Image for the restaurant menu

Config.WashingProgressBar = {
    duration = 5, -- Duration in seconds
    label = "Washing Hands",
    animation = {
        emote = {
            enabled = false,
            anim = {
                dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                clip = "machinic_loop_mechandplayer",
            },
            prop = {
                model = "prop_ice_cube_03",
                bone = 57005,
                pos = vec3(0.4, 0.0, -0.1),
                rot = vec3(0.0, 90.0, 0.0)
            },
        },
        scenario = {
            enabled = true,
            anim = {
                scenario = "PROP_HUMAN_BUM_BIN"
            },
        },
    }
}

Config.SinkCleaning = {
    enabled = true,
    UseCustomImages = false,
    MenuHeading = "Sink Menu",
    MenuIcon = "fas fa-sink",

    TargetIcon = 'fas fa-sink',
    TargetLabel = 'Sink wqdq',

    WashHands = {
        Title = "Wash Hands",
        description = "Clean your dirty hands",
        icon = "fas fa-hand-holding-water",
        image = Config.InventoryImages .. "",
    },
    items = {
        CleanDirtyCup = {
            Title = "Clean Dirty Cup",
            description = "Required Item: Dirty Cup",
            icon = "fas fa-mug-saucer",
            image = Config.InventoryImages .. "uc_cup.png",
            metadata = {""},
            RequiredItems = {
                { item = "uc_dirtycup", count = 1, remove = true },
            },
            AddItems = {
                { item = "uc_cup", count = 1 },
            },
            ProgressBar = {
                duration = 5, -- Duration in seconds
                label = "Washing Cup",
                animation = {
                    emote = {
                        enabled = false,
                        anim = {
                            dict = 'mp_player_inteat@burger',
                            clip = 'mp_player_int_eat_burger'
                        },
                        prop = {
                            model = 'prop_food_chips',
                            bone = 18905,
                            pos = vec3(0.13, 0.05, 0.02),
                            rot = vec3(-50.0, 16.0, 60.0)
                        },
                    },
                    scenario = {
                        enabled = true,
                        anim = {
                            scenario = "PROP_HUMAN_BUM_BIN"
                        },
                    },
                }
            }
        },
        CleanDirtyGlass = {
            Title = "Clean Dirty Glass",
            description = "Required Item: Dirty Glass",
            icon = "fas fa-mug-saucer",
            image = Config.InventoryImages .. "uc_glass.png",
            metadata = {""},
            RequiredItems = {
                { item = "uc_dirtyglass", count = 1, remove = true },
            },
            AddItems = {
                { item = "uc_glass", count = 1 },
            },
            ProgressBar = {
                duration = 5, -- Duration in seconds
                label = "Washing Glass",
                animation = {
                    emote = {
                        enabled = false,
                        anim = {
                            dict = 'mp_player_inteat@burger',
                            clip = 'mp_player_int_eat_burger'
                        },
                        prop = {
                            model = 'prop_food_chips',
                            bone = 18905,
                            pos = vec3(0.13, 0.05, 0.02),
                            rot = vec3(-50.0, 16.0, 60.0)
                        },
                    },
                    scenario = {
                        enabled = true,
                        anim = {
                            scenario = "PROP_HUMAN_BUM_BIN"
                        },
                    },
                }
            }
        },
        CleanDirtyBowl = {
            Title = "Clean Dirty Bowl",
            description = "Required Item: Dirty Bowl",
            icon = "fas fa-mug-saucer",
            image = Config.InventoryImages .. "uc_bowl.png",
            metadata = {""},
            RequiredItems = {
                { item = "uc_dirtybowl", count = 1, remove = true },
            },
            AddItems = {
                { item = "uc_bowl", count = 1 },
            },
            ProgressBar = {
                duration = 5, -- Duration in seconds
                label = "Washing Bowl",
                animation = {
                    emote = {
                        enabled = false,
                        anim = {
                            dict = 'mp_player_inteat@burger',
                            clip = 'mp_player_int_eat_burger'
                        },
                        prop = {
                            model = 'prop_food_chips',
                            bone = 18905,
                            pos = vec3(0.13, 0.05, 0.02),
                            rot = vec3(-50.0, 16.0, 60.0)
                        },
                    },
                    scenario = {
                        enabled = true,
                        anim = {
                            scenario = "PROP_HUMAN_BUM_BIN"
                        },
                    },
                }
            }
        },
        CleanPlate = {
            Title = "Clean Dirty Plate",
            description = "Required Item: Dirty Plate",
            icon = "fas fa-utensils",
            image = Config.InventoryImages .. "uc_plate.png",
            metadata = {""},
            RequiredItems = {
                { item = "uc_dirtyplate", count = 1, remove = true },
            },
            AddItems = {
                { item = "uc_plate", count = 1 },
            },
            ProgressBar = {
                duration = 5, -- Duration in seconds
                label = "Washing Plate",
                animation = {
                    emote = {
                        enabled = false,
                        anim = {
                            dict = 'mp_player_inteat@burger',
                            clip = 'mp_player_int_eat_burger'
                        },
                        prop = {
                            model = 'prop_food_chips',
                            bone = 18905,
                            pos = vec3(0.13, 0.05, 0.02),
                            rot = vec3(-50.0, 16.0, 60.0)
                        },
                    },
                    scenario = {
                        enabled = true,
                        anim = {
                            scenario = "PROP_HUMAN_BUM_BIN"
                        },
                    },
                }
            }
        }
    }
}

-- Vending machine items in BossMenu
Config.EnableVendingMachine = true -- Enable or Disable Vending Machine in BossMenu
Config.VendingMachineItems = {
    {
        name = "bs_eggs",
        label = "Eggs",
        price = 30,
        image = Config.InventoryImages .. "bs_eggs.png",
    },
    {
        name = "uc_dirtyglass",
        label = "Dirty Glass",
        price = 15,
        image = Config.InventoryImages .. "uc_dirtyglass.png",
    },
    {
        name = "uc_dirtybowl",
        label = "Dirty Bowl",
        price = 30,
        image = Config.InventoryImages .. "uc_dirtybowl.png",
    },
    {
        name = "uc_dirtyplate",
        label = "Dirty Plate",
        price = 30,
        image = Config.InventoryImages .. "uc_dirtyplate.png",
        category = "Ingredients"
    },
}

-- Config.Colors = {
--     dark = {
--         background = "#1a1e23", -- Keeping dark background as before or adjust if a dark mode version of the image is desired
--         cardBg = "#151b28",     -- Keeping dark card background as before
--         border = "#30363d",     -- Keeping dark border as before
--         highlight = "#2d4b6b",  -- Keeping dark highlight as before
--         accent = "#4d80b3",     -- Keeping dark accent as before
--         sidebar = "#1a1e23",    -- Keeping dark sidebar as before
--         buttonHighlight = "#3b82f6" -- Keeping dark button highlight as before
--     },
--     light = {
--         background = "#bada55", -- This is the main background green color
--         cardBg = "#e0e0e0",     -- A light grey for the card backgrounds
--         border = "#c0c0c0",     -- A slightly darker grey for borders
--         highlight = "#d0d0d0",  -- A subtle highlight color
--         accent = "#4CAF50",     -- A green accent color for elements like "Balance" or primary buttons
--         sidebar = "#bada55",    -- The sidebar seems to share the main background color
--         buttonHighlight = "#8BC34A" -- A slightly darker green for button highlights
--     }
-- }

Config.ResourceName = GetCurrentResourceName() -- Dynamically set the resource name


Config.Alcohol = {
    ["mrc_aviation"] = {
        Hunger = 20,
        Thirst = 20,
        Stress = -20,
        Log = "You drank a Aviation",
        Remove = true,
        RemoveItem = "mrc_aviation",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtywineglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Aviation...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'its_prop_wine_glass_S2',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_bahamamama"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Bahamamama",
        Remove = true,
        RemoveItem = "mrc_bahamamama",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtywhiskeyglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Bahamamama...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_beesknees"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Bees Knees",
        Remove = true,
        RemoveItem = "mrc_beesknees",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtywineglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Bees Knees...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'prop_cocktail',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_cabernetsauvignon"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Cabernet Sauvignon",
        Remove = true,
        RemoveItem = "mrc_cabernetsauvignon",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtywineglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Cabernet Sauvignon...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_chardonnay"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Chardonnay",
        Remove = true,
        RemoveItem = "mrc_chardonnay",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtywineglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Chardonnay...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_cosmopolitan"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = -50,
        Log = "You drank a Cosmopolitan",
        Remove = true,
        RemoveItem = "mrc_cosmopolitan",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtywineglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Cosmopolitan...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_french75"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a French 75",
        Remove = true,
        RemoveItem = "mrc_french75",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtywineglass",
        AddItemCount = 1,
        ProgressBar = "Drinking French 75...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_kirroyale"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Kirroyale",
        Remove = true,
        RemoveItem = "mrc_kirroyale",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtywineglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Kirroyale...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_margarita"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Margarita",
        Remove = true,
        RemoveItem = "mrc_margarita",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtywineglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Margarita...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_martini"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Martini",
        Remove = true,
        RemoveItem = "mrc_martini",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtywineglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Martini...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_oldfashioned"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Old Fashioned",
        Remove = true,
        RemoveItem = "mrc_oldfashioned",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtywhiskeyglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Old Fashioned...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_pinakolada"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Pina Kolada",
        Remove = true,
        RemoveItem = "mrc_pinakolada",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtywineglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Pina Kolada...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_rose"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Rose Wine",
        Remove = true,
        RemoveItem = "mrc_rose",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtywineglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Rose Wine...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_rumpunch"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Rum Punch",
        Remove = true,
        RemoveItem = "mrc_rumpunch",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtyglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Rum Punch...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_scorpion"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Scorpion",
        Remove = true,
        RemoveItem = "mrc_scorpion",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtyglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Scorpion...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_screwdriver"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Screw Driver",
        Remove = true,
        RemoveItem = "mrc_screwdriver",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtyglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Screw Driver...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_seabreeze"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Sea Breeze",
        Remove = true,
        RemoveItem = "mrc_seabreeze",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtyglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Sea Breeze...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
    ["mrc_sexonthebeach"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 20,
        Log = "You drank a Sex On The Beach",
        Remove = true,
        RemoveItem = "mrc_sexonthebeach",
        RemoveItemCount = 1,
        Add = true,
        AddItem = "mrc_dirtywineglass",
        AddItemCount = 1,
        ProgressBar = "Drinking Sex On The Beach...",
        duration = 5, -- Duration in seconds
            animation = {
                emote = {
                enabled = true,
                anim = {
                    dict = 'mp_player_intdrink',
                    clip = 'loop_bottle'
                },
                prop = {
                    model = 'p_wine_glass_s',
                    bone = 60309,
                    pos = vec3(0.0, 0.0, -0.05),
                    rot = vec3(0.0, 0.0, -40.0)
                },
                },
                scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_DRINKING"
                },
            },
        }
    },
}

Config.AlcoholEffect = {
    Default = {
        Active = true,
        Time = 10, -- Time in seconds
        WalkingStyle = "move_m@drunk@slightlydrunk", -- Walking Style
    },

    Custom = {
        Active = false,
        Function = function (item) -- Client Side Function
            -- Custom Alcohol Effect function
        end
    }
}