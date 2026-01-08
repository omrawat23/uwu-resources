-- Initialize Preset table if it doesn't exist
if not Preset then
    Preset = {}
end

-- Add to the existing Preset table rather than redefining it
Preset["gabz"] = {
    blip = { sprite = 838, color = 8, scale = 0.8, location = vector3(-580.95, -1070.14, 22.33)},

    bossMenu = {
        [1] = {
            location = vector3(-578.3, -1067.0, 26.61),
            length = 0.15,
            width = 0.5,
            minZ = 26.51,
            maxZ = 26.61,
            heading = 0.1,
            distance = 1.5,
            targetlabel = "Boss Menu",
            targeticon = "fas fa-user-tie",
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        speedMultiplier = 8.0,
                        duration = 2000,
                        flag = 48,
                        playbackRate = 1
                    },
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 2000,
                    },
                },
            },
            prop = {
                enabled = false,
                model = "prop_laptop_lester2",
                location = vector4(130.76, -427.97, 41.02, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            },
        },
    },

    EnableRestaurantMenu = true, -- Enable or disable the restaurant menu
    restaurantMenu = {
        [1] = {
            location = vector3(-573.46, -1059.76, 22.3),
            menuImage = Config.InventoryImages .. "bs_fanta.png", -- Image for the restaurant menu,
            length = 1.0,
            width = 0.6,
            minZ = 13.8,
            maxZ = 17.8,
            heading = 35,
            distance = 1.5,
            targetlabel = "Bean Machine Menu",
            targeticon = "fas fa-user-tie",
            prop = {
                enabled = true,
                model = "prop_stripmenu",
                location = vector4(-573.46, -1059.76, 22.3, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            },
        },
        [2] = {
            location = vector3(-573.43, -1063.38, 22.3),
            menuImage = Config.InventoryImages .. "bs_fanta.png", -- Different menu image
            length = 1.0,
            width = 0.6,
            minZ = 13.8,
            maxZ = 17.8,
            heading = 35,
            distance = 1.5,
            targetlabel = "Bean Machine Menu",
            targeticon = "fas fa-wine-glass",
            prop = {
                enabled = true,
                model = "prop_stripmenu",
                location = vector4(-573.43, -1063.38, 22.3, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            },
        },
        [3] = {
            location = vector3(-573.49, -1067.08, 22.3),
            menuImage = Config.InventoryImages .. "bs_fanta.png", -- Different menu image
            length = 1.0,
            width = 0.6,
            minZ = 13.8,
            maxZ = 17.8,
            heading = 35,
            distance = 1.5,
            targetlabel = "Bean Machine Menu",
            targeticon = "fas fa-wine-glass",
            prop = {
                enabled = true,
                model = "prop_stripmenu",
                location = vector4(-573.49, -1067.08, 22.3, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            },
        },
        [4] = {
            location = vector3(-584.1, -1062.9, 22.38),
            menuImage = Config.InventoryImages .. "bs_fanta.png", -- Different menu image
            length = 1.0,
            width = 0.6,
            minZ = 13.8,
            maxZ = 17.8,
            heading = 35,
            distance = 1.5,
            targetlabel = "Bean Machine Menu",
            targeticon = "fas fa-wine-glass",
            prop = {
                enabled = true,
                model = "prop_stripmenu",
                location = vector4(-584.1, -1062.9, 22.38, 184.6),
                rotation = vector3(0.0, 0.0, 50.0),
            },
        },
        [5] = {
            location = vector3(-583.78, -1058.71, 22.38),
            menuImage = Config.InventoryImages .. "bs_fanta.png", -- Different menu image
            length = 1.0,
            width = 0.6,
            minZ = 13.8,
            maxZ = 17.8,
            heading = 35,
            distance = 1.5,
            targetlabel = "Bean Machine Menu",
            targeticon = "fas fa-wine-glass",
            prop = {
                enabled = true,
                model = "prop_stripmenu",
                location = vector4(-583.78, -1058.71, 22.38, 184.6),
                rotation = vector3(0.0, 0.0, 70.0),
            },
        },
        [6] = {
            location = vector3(-578.68, -1051.13, 21.75),
            menuImage = Config.InventoryImages .. "bs_fanta.png", -- Different menu image
            length = 1.0,
            width = 0.6,
            minZ = 13.8,
            maxZ = 17.8,
            heading = 35,
            distance = 1.5,
            targetlabel = "Bean Machine Menu",
            targeticon = "fas fa-wine-glass",
            prop = {
                enabled = true,
                model = "prop_stripmenu",
                location = vector4(-578.68, -1051.13, 21.75, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            },
        },
        [7] = {
            location = vector3(-586.97, -1067.25, 22.33),
            menuImage = Config.InventoryImages .. "bs_burgerbun.png", -- Different menu image
            length = 1.0,
            width = 0.6,
            minZ = 13.8,
            maxZ = 17.8,
            heading = 35,
            distance = 1.5,
            targetlabel = "Bean Machine Menu",
            targeticon = "fas fa-wine-glass",
            prop = {
                enabled = true,
                model = "prop_stripmenu",
                location = vector4(-586.97, -1067.25, 22.33, 184.6),
                rotation = vector3(0.0, 0.0, 90.0),
            },
        },
        [8] = {
            location = vector3(-586.98, -1065.69, 22.33),
            menuImage = Config.InventoryImages .. "bs_burgerbun.png", -- Different menu image
            length = 1.0,
            width = 0.6,
            minZ = 13.8,
            maxZ = 17.8,
            heading = 35,
            distance = 1.5,
            targetlabel = "Bean Machine Menu",
            targeticon = "fas fa-wine-glass",
            prop = {
                enabled = true,
                model = "prop_stripmenu",
                location = vector4(-586.98, -1065.69, 22.33, 184.6),
                rotation = vector3(0.0, 0.0, 90.0),
            },
        },
        [9] = {
            location = vector3(-586.39, -1081.49, 22.13),
            menuImage = Config.InventoryImages .. "bs_burgerbun.png", -- Different menu image
            length = 1.0,
            width = 0.6,
            minZ = 13.8,
            maxZ = 17.8,
            heading = 35,
            distance = 1.5,
            targetlabel = "Bean Machine Menu",
            targeticon = "fas fa-wine-glass",
            prop = {
                enabled = true,
                model = "prop_stripmenu",
                location = vector4(-586.39, -1081.49, 22.13, 184.6),
                rotation = vector3(0.0, 0.0, -20.0),
            },
        },
        [10] = {
            location = vector3(-591.1, -1080.19, 22.12),
            menuImage = Config.InventoryImages .. "bs_burgerbun.png", -- Different menu image
            length = 1.0,
            width = 0.6,
            minZ = 13.8,
            maxZ = 17.8,
            heading = 35,
            distance = 1.5,
            targetlabel = "Bean Machine Menu",
            targeticon = "fas fa-wine-glass",
            prop = {
                enabled = true,
                model = "prop_stripmenu",
                location = vector4(-591.1, -1080.19, 22.12, 184.6),
                rotation = vector3(0.0, 0.0, -20.0),
            },
        },
        [11] = {
            location = vector3(-586.26, -1075.95, 22.14),
            menuImage = Config.InventoryImages .. "bs_burgerbun.png", -- Different menu image
            length = 1.0,
            width = 0.6,
            minZ = 13.8,
            maxZ = 17.8,
            heading = 35,
            distance = 1.5,
            targetlabel = "Bean Machine Menu",
            targeticon = "fas fa-wine-glass",
            prop = {
                enabled = true,
                model = "prop_stripmenu",
                location = vector4(-586.26, -1075.95, 22.14, 184.6),
                rotation = vector3(0.0, 0.0, -20.0),
            },
        },
    },

    employeeMenu = {
        [1] = {
            location = vector3(-596.18, -1052.8, 22.34),
            length = 0.2,
            width = 0.5,
            minZ = 22.19,
            maxZ = 22.34,
            heading = 180,
            distance = 1.5,
            targetlabel = "Employee Menu",
            targeticon = "fas fa-user-tie",
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        speedMultiplier = 8.0,
                        duration = 2000,
                        flag = 48,
                        playbackRate = 1
                    },
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 2000,
                    },
                },
            },
            prop = {
                enabled = false,
                model = "prop_laptop_01a",
                location = vector4(117.37, -1045.63, 29.31, 184.6),
                rotation = vector3(0.0, 0.0, 150.0),
            },
        },
    },

    -- ReverseVendingMachine
    ReverseVendingMachine  = {
        [1] = {
            location = vector3(-595.39, -1051.19, 22.34),
            length = 0.35,
            width = 0.35,
            heading = 0,
            minZ = 21.34,
            maxZ = 21.79,
            targetlabel = "Return Utensils",
            slots = 30,
            targeticon = "fas fa-utensils",
            weight = 50000,
            distance = 1.5,
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        speedMultiplier = 8.0,
                        duration = 2000,
                        flag = 48,
                        playbackRate = 1
                    },
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 2000,
                    },
                },
            },
            prop = {
                enabled = true,
                model = "prop_tv_flat_01",
                location = vector4(-579.4863, -1067.6365, 26.6141, 71.8193),
                rotation = vector3(0.0, 0.0, 0.0),
            },
        },
    },

    -- Selforderkiosk
    SelfOrderKiosk = {
        [1] = {
            location = vector3(-575.39, -1063.48, 26.61),
            length = 0.35,
            width = 0.35,
            heading = 359,
            minZ = 25.61,
            maxZ = 26.06,
            targetlabel = "Ordering Tablet",
            slots = 30,
            targeticon = "fas fa-tablet",
            weight = 50000,
            distance = 1.5,
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        speedMultiplier = 8.0,
                        duration = 2000,
                        flag = 48,
                        playbackRate = 1
                    },
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 2000,
                    },
                },
            },
            prop = {
                enabled = true,
                model = "prop_food_bin_02",
                location = vector4(-589.6115, -1056.1030, 22.3442, 81.1724),
                rotation = vector3(2.0, 0.0, 0.0),
            },
        },
    },

    
    OrderManagementTablet = {
        [1] = {
            location = vector3(-591.08, -1055.55, 22.36),
            length = 1.55,
            width = 0.65,
            heading = 0,
            minZ = 22.26,
            maxZ = 22.56,
            targetlabel = "Order Management",
            targeticon = "fas fa-clipboard-list",
            distance = 1.5,
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        speedMultiplier = 8.0,
                        duration = 2000,
                        flag = 48,
                        playbackRate = 1
                    },
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 2000,
                    },
                },
            },
            prop = {
                enabled = true,
                model = "prop_tool_box_05",
                location = vector4(-585.3015, -1059.7612, 22.3442, 290.7538),
                rotation = vector3(0.0, 0.0, 0.0),
            },
        },
    },


    EnableDuty = true, -- Enable or disable duty clock in/out
    duty = {
        [1] = {
            location = vector3(-594.24, -1052.53, 22.97),
            radius = 0.5,
            distance = 2.5,
            targetlabel = "Clock In/Out",
            targeticon = "fas fa-user-clock",
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(-1349.94, -1093.27, 7.0, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            },
            progressBar = {
                duration = 5,
                label = "Log in...",
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
                            scenario = "WORLD_HUMAN_CLIPBOARD"
                        },
                    },
                },
            },
        },
    },

    EnableIce = true,
    ice = {
        [1] = {
            location = vector3(-587.99, -1054.94, 21.34),
            length = 0.8,
            width = 0.75,
            heading = 30,
            minZ = 5.94,
            maxZ = 6.99,
            targetlabel = "Ice Machine",
            targeticon = "fas fa-cubes",
            distance = 1.5,
            addItem = "uc_icecubes",
            addItemCount = 1,
            prop = {
                enabled = true,
                model = "prop_bar_ice_01",
                location = vector4(-587.99, -1054.94, 21.34, 93.29),
                rotation = vector3(0.0, 0.0, 270.0),
            },
            progressBar = {
                duration = 5,
                label = "Getting Ice...",
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
                },
            },
        },
    },

    EnableTrash = true,
    dustbin = {
        [1] = {
            location = vector3(-575.39, -1063.48, 26.61),
            length = 0.35,
            width = 0.35,
            heading = 359,
            minZ = 25.61,
            maxZ = 26.06,
            targetlabel = "Trash",
            slots = 30,
            targeticon = "fas fa-trash",
            weight = 50000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_food_bin_02",
                location = vector4(130.76, -427.97, 41.02, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            },
        },
        [2] = {
            location = vector3(-575.39, -1062.74, 26.61),
            length = 0.35,
            width = 0.35,
            heading = 0,
            minZ = 25.61,
            maxZ = 26.06,
            targetlabel = "Trash",
            slots = 30,
            targeticon = "fas fa-trash",
            weight = 50000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_food_bin_02",
                location = vector4(130.76, -427.97, 41.02, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            },
        },
        [3] = {
            location = vector3(-595.37, -1048.93, 22.34),
            length = 0.35,
            width = 0.35,
            heading = 0,
            minZ = 21.34,
            maxZ = 21.79,
            targetlabel = "Trash",
            slots = 30,
            targeticon = "fas fa-trash",
            weight = 50000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_food_bin_02",
                location = vector4(130.76, -427.97, 41.02, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            },
        },
        [4] = {
            location = vector3(-590.7, -1053.81, 22.34),
            length = 0.35,
            width = 0.35,
            heading = 0,
            minZ = 21.34,
            maxZ = 21.84,
            targetlabel = "Trash",
            slots = 30,
            targeticon = "fas fa-trash",
            weight = 50000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_food_bin_02",
                location = vector4(130.76, -427.97, 41.02, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            },
        },
    },

    EnableClothing = true,
    clothing = {
        [1] = {
            location = vector3(-586.13, -1049.94, 22.34),
            length = 2.45,
            width = 0.5,
            heading = 180,
            minZ = 21.29,
            maxZ = 23.49,
            distance = 1.5,
            targetlabel = "Change Clothes",
            targeticon = "fas fa-tshirt",
            prop = {
                enabled = false,
                model = "v_res_tre_wardrobe",
                location = vector4(114.57, -1042.71, 28.31, 251.59),
                rotation = vector3(0.0, 0.0, 70.0),
            }
        },
    },

    craft = {
        ["craftid"] = {
            MenuTitle = "Coffee Machine",
            location = vector3(-586.88, -1061.9, 22.34),
            length = 0.75,
            width = 0.6,
            heading = 0,
            minZ = 22.24,
            maxZ = 22.74,
            targetlabel = "Coffee Machine",
            targeticon = "fas fa-mug-hot",
            ProgressBarDuration = 5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(130.76, -427.97, 41.02, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            },
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
                        scenario = "PROP_HUMAN_BBQ"
                    },
                },
            },
            distance = 2.5
        },

        ["craftid2"] = {
            MenuTitle = "cooking",
            location = vector3(-591.08, -1056.55, 22.36),
            length = 1.55,
            width = 0.65,
            heading = 0,
            minZ = 22.26,
            maxZ = 22.56,
            targetlabel = "cooking",
            targeticon = "fas fa-fire-burner",
            ProgressBarDuration = 5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(130.76, -427.97, 41.02, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            },
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
                        scenario = "WORLD_HUMAN_AA_COFFEE"
                    },
                },
            },
            distance = 2.5
        },

        ["craftid3"] = {
            MenuTitle = "Desert",
            location = vector3(-590.83, -1059.72, 22.36),
            length = 1.15,
            width = 0.85,
            heading = 0,
            minZ = 22.11,
            maxZ = 23.71,
            targetlabel = "Desert",
            targeticon = "fas fa-cookie-bite",
            ProgressBarDuration = 5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(130.76, -427.97, 41.02, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            },
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
                        scenario = "WORLD_HUMAN_AA_COFFEE"
                    },
                },
            },
            distance = 2.5
        },

        ["craftid4"] = {
            MenuTitle = "Vending Machine",
            location = vector3(-583.98, -1058.18, 22.34),
            length = 0.65,
            width = 0.55,
            heading = 0,
            minZ = 22.34,
            maxZ = 23.19,
            targetlabel = "Vending Machine",
            targeticon = "fas fa-champagne-glasses",
            ProgressBarDuration = 5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(130.76, -427.97, 41.02, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            },
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
                        scenario = "WORLD_HUMAN_AA_COFFEE"
                    },
                },
            },
            distance = 2.5
        },
    },

    EnableTray = true,
    trays = {
        [1] = {
            location = vector3(-584.01, -1059.28, 22.34),
            length = 0.7,
            width = 0.5,
            heading = 0,
            minZ = 22.34,
            maxZ = 22.64,
            targetlabel = "Tray",
            slots = 10,
            targeticon = "fas fa-tablet",
            weight = 15000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_food_tray_01",
                location = vector4(125.41, -1033.05, 29.2488, 184.6),
                rotation = vector3(0.0, 0.0, 70.0)
            }
        },
        [2] = {
            location = vector3(-584.05, -1062.06, 22.34),
            length = 0.7,
            width = 0.5,
            heading = 0,
            minZ = 22.34,
            maxZ = 22.64,
            targetlabel = "Tray",
            slots = 10,
            targeticon = "fas fa-tablet",
            weight = 15000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_food_tray_01",
                location = vector4(125.41, -1033.05, 29.2488, 184.6),
                rotation = vector3(0.0, 0.0, 70.0)
            }
        },
        [3] = {
            location = vector3(-586.56, -1062.93, 22.34),
            length = 0.5,
            width = 0.7,
            heading = 0,
            minZ = 22.34,
            maxZ = 22.49,
            targetlabel = "Tray",
            slots = 10,
            targeticon = "fas fa-tablet",
            weight = 15000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_food_tray_01",
                location = vector4(125.41, -1033.05, 29.2488, 184.6),
                rotation = vector3(0.0, 0.0, 70.0)
            }
        },
        [4] = {
            location = vector3(-587.86, -1059.05, 22.36),
            length = 0.7,
            width = 0.5,
            heading = 0,
            minZ = 22.26,
            maxZ = 22.36,
            targetlabel = "Tray",
            slots = 10,
            targeticon = "fas fa-tablet",
            weight = 15000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_food_tray_01",
                location = vector4(125.41, -1033.05, 29.2488, 184.6),
                rotation = vector3(0.0, 0.0, 70.0)
            }
        },
        [5] = {
            location = vector3(-587.86, -1060.18, 22.34),
            length = 0.7,
            width = 0.5,
            heading = 0,
            minZ = 22.24,
            maxZ = 22.34,
            targetlabel = "Tray",
            slots = 10,
            targeticon = "fas fa-tablet",
            weight = 15000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_food_tray_01",
                location = vector4(125.41, -1033.05, 29.2488, 184.6),
                rotation = vector3(0.0, 0.0, 70.0)
            }
        },
        [6] = {
            location = vector3(-586.91, -1059.67, 22.34),
            length = 0.7,
            width = 0.5,
            heading = 6,
            minZ = 22.24,
            maxZ = 22.34,
            targetlabel = "Tray",
            slots = 10,
            targeticon = "fas fa-tablet",
            weight = 15000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_food_tray_01",
                location = vector4(125.41, -1033.05, 29.2488, 184.6),
                rotation = vector3(0.0, 0.0, 70.0)
            }
        },
    },

    EnableTable = true,
    table = {
        [1] = {
            location = vector3(-573.51, -1059.78, 22.34),
            length = 1.15,
            width = 2.1,
            heading = 0,
            minZ = 22.14,
            maxZ = 22.54,
            targetlabel = "Table",
            slots = 10,
            targeticon = "fas fa-tablet",
            weight = 15000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_chateau_table_01",
                location = vector4(127.89, -435.15, 41.01, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            }
        },
        [2] = {
            location = vector3(-573.5, -1063.42, 22.34),
            length = 1.15,
            width = 2.1,
            heading = 0,
            minZ = 22.14,
            maxZ = 22.54,
            targetlabel = "Table",
            slots = 10,
            targeticon = "fas fa-tablet",
            weight = 15000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_chateau_table_01",
                location = vector4(127.89, -435.15, 41.01, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            }
        },
        [3] = {
            location = vector3(-573.48, -1067.08, 22.34),
            length = 1.15,
            width = 2.15,
            heading = 0,
            minZ = 22.14,
            maxZ = 22.54,
            targetlabel = "Table",
            slots = 10,
            targeticon = "fas fa-tablet",
            weight = 15000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_chateau_table_01",
                location = vector4(127.89, -435.15, 41.01, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            }
        },
        [4] = {
            location = vector3(-578.69, -1051.12, 22.35),
            length = 0.9,
            width = 1.2,
            heading = 0,
            minZ = 21.45,
            maxZ = 21.95,
            targetlabel = "Table",
            slots = 10,
            targeticon = "fas fa-tablet",
            weight = 15000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_chateau_table_01",
                location = vector4(127.89, -435.15, 41.01, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            }
        },
        [5] = {
            location = vector3(-586.42, -1081.63, 22.33),
            length = 2.25,
            width = 2.25,
            heading = 0,
            minZ = 21.93,
            maxZ = 22.33,
            targetlabel = "Table",
            slots = 10,
            targeticon = "fas fa-tablet",
            weight = 15000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_chateau_table_01",
                location = vector4(127.89, -435.15, 41.01, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            }
        },
        [6] = {
            location = vector3(-586.38, -1076.05, 22.33),
            length = 2.25,
            width = 2.25,
            heading = 351,
            minZ = 21.98,
            maxZ = 22.28,
            targetlabel = "Table",
            slots = 10,
            targeticon = "fas fa-tablet",
            weight = 15000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_chateau_table_01",
                location = vector4(127.89, -435.15, 41.01, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            }
        },
        [7] = {
            location = vector3(-591.22, -1080.2, 22.33),
            length = 2.25,
            width = 2.25,
            heading = 300,
            minZ = 21.98,
            maxZ = 22.28,
            targetlabel = "Table",
            slots = 10,
            targeticon = "fas fa-tablet",
            weight = 15000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_chateau_table_01",
                location = vector4(127.89, -435.15, 41.01, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            }
        },
    },

    EnableStash = true,
    stashs = {
        [1] = {
            location = vector3(-587.92, -1066.12, 22.34),
            length = 1.9,
            width = 0.65,
            heading = 0,
            minZ = 21.34,
            maxZ = 23.49,
            targetlabel = "Stash",
            slots = 40,
            targeticon = "fas fa-warehouse",
            weight = 150000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(-1360.47, -1070.97, 6.94, 30.0),
                rotation = vector3(0.0, 0.0, 0.0),
            },
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        duration = 1000,
                        speedMultiplier = 8.0,
                        flag = 48,
                        playbackRate = 1
                    }
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 1000
                    }
                }
            }
        },
        [2] = {
            location = vector3(-587.88, -1068.07, 22.34),
            length = 1.9,
            width = 0.75,
            heading = 0,
            minZ = 21.34,
            maxZ = 23.59,
            targetlabel = "Stash",
            slots = 40,
            targeticon = "fas fa-warehouse",
            weight = 150000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(-1357.22, -1076.5, 6.94, 30.0),
                rotation = vector3(0.0, 0.0, 0.0),
            },
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        duration = 1000,
                        speedMultiplier = 8.0,
                        flag = 48,
                        playbackRate = 1
                    }
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 1000
                    }
                }
            }
        },
        [3] = {
            location = vector3(-590.73, -1068.08, 22.34),
            length = 1.9,
            width = 0.7,
            heading = 0,
            minZ = 21.34,
            maxZ = 23.64,
            targetlabel = "Stash",
            slots = 40,
            targeticon = "fas fa-warehouse",
            weight = 150000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(-1357.22, -1076.5, 6.94, 30.0),
                rotation = vector3(0.0, 0.0, 0.0),
            },
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        duration = 1000,
                        speedMultiplier = 8.0,
                        flag = 48,
                        playbackRate = 1
                    }
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 1000
                    }
                }
            }
        },
        [4] = {
            location = vector3(-598.38, -1068.41, 22.34),
            length = 1.1,
            width = 4.55,
            heading = 0,
            minZ = 21.34,
            maxZ = 24.84,
            targetlabel = "Stash",
            slots = 40,
            targeticon = "fas fa-warehouse",
            weight = 150000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(-1357.22, -1076.5, 6.94, 30.0),
                rotation = vector3(0.0, 0.0, 0.0),
            },
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        duration = 1000,
                        speedMultiplier = 8.0,
                        flag = 48,
                        playbackRate = 1
                    }
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 1000
                    }
                }
            }
        },
        [5] = {
            location = vector3(-598.36, -1065.6, 22.34),
            length = 1.2,
            width = 4.55,
            heading = 0,
            minZ = 21.34,
            maxZ = 24.84,
            targetlabel = "Stash",
            slots = 40,
            targeticon = "fas fa-warehouse",
            weight = 150000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(-1357.22, -1076.5, 6.94, 30.0),
                rotation = vector3(0.0, 0.0, 0.0),
            },
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        duration = 1000,
                        speedMultiplier = 8.0,
                        flag = 48,
                        playbackRate = 1
                    }
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 1000
                    }
                }
            }
        },
        [6] = {
            location = vector3(-598.39, -1062.77, 22.34),
            length = 1.2,
            width = 4.6,
            heading = 0,
            minZ = 21.34,
            maxZ = 24.84,
            targetlabel = "Stash",
            slots = 40,
            targeticon = "fas fa-warehouse",
            weight = 150000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(-1357.22, -1076.5, 6.94, 30.0),
                rotation = vector3(0.0, 0.0, 0.0),
            },
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        duration = 1000,
                        speedMultiplier = 8.0,
                        flag = 48,
                        playbackRate = 1
                    }
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 1000
                    }
                }
            }
        },
        [7] = {
            location = vector3(-587.94, -1063.77, 22.34),
            length = 1.4,
            width = 0.65,
            heading = 0,
            minZ = 21.29,
            maxZ = 23.14,
            targetlabel = "Stash",
            slots = 40,
            targeticon = "fas fa-warehouse",
            weight = 150000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(-1357.22, -1076.5, 6.94, 30.0),
                rotation = vector3(0.0, 0.0, 0.0),
            },
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        duration = 1000,
                        speedMultiplier = 8.0,
                        flag = 48,
                        playbackRate = 1
                    }
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 1000
                    }
                }
            }
        },
        [8] = {
            location = vector3(-585.99, -1055.35, 22.34),
            length = 0.5,
            width = 1.35,
            heading = 0,
            minZ = 21.34,
            maxZ = 23.49,
            targetlabel = "Stash",
            slots = 40,
            targeticon = "fas fa-warehouse",
            weight = 150000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(-1357.22, -1076.5, 6.94, 30.0),
                rotation = vector3(0.0, 0.0, 0.0),
            },
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        duration = 1000,
                        speedMultiplier = 8.0,
                        flag = 48,
                        playbackRate = 1
                    }
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 1000
                    }
                }
            }
        },
        [9] = {
            location = vector3(-584.6, -1055.32, 22.34),
            length = 0.55,
            width = 1.35,
            heading = 0,
            minZ = 21.34,
            maxZ = 23.49,
            targetlabel = "Stash",
            slots = 40,
            targeticon = "fas fa-warehouse",
            weight = 150000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(-1357.22, -1076.5, 6.94, 30.0),
                rotation = vector3(0.0, 0.0, 0.0),
            },
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        duration = 1000,
                        speedMultiplier = 8.0,
                        flag = 48,
                        playbackRate = 1
                    }
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 1000
                    }
                }
            }
        },
        [10] = {
            location = vector3(-591.03, -1063.19, 22.34),
            length = 2.7,
            width = 0.65,
            heading = 0,
            minZ = 21.49,
            maxZ = 22.24,
            targetlabel = "Stash",
            slots = 40,
            targeticon = "fas fa-warehouse",
            weight = 150000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(-1357.22, -1076.5, 6.94, 30.0),
                rotation = vector3(0.0, 0.0, 0.0),
            },
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        duration = 1000,
                        speedMultiplier = 8.0,
                        flag = 48,
                        playbackRate = 1
                    }
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 1000
                    }
                }
            }
        },
    },

    EnableFridge = true,
    fridges = {
        [1] = {
            location = vector3(-590.98, -1058.59, 22.36),
            length = 1.1,
            width = 0.9,
            heading = 0,
            minZ = 21.51,
            maxZ = 23.71,
            targetlabel = "Fridge",
            slots = 40,
            targeticon = "fas fa-warehouse",
            weight = 150000,
            distance = 1.5,
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(-1351.87, -1098.62, 6.94, 300.0),
                rotation = vector3(0.0, 0.0, 0.0),
            },
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        duration = 1000,
                        speedMultiplier = 8.0,
                        flag = 48,
                        playbackRate = 1
                    }
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 1000
                    }
                }
            }
        }
    },

    EnableTerminal = true,
    terminals = {
        [1] = {
            location = vector3(-584.07, -1058.74, 22.34),
            length = 0.25,
            width = 0.4,
            heading = 10,
            minZ = 22.34,
            maxZ = 22.54,
            distance = 1.5,
            targetlabel = "Terminal",
            targeticon = "fas fa-cash-register",
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        speedMultiplier = 8.0,
                        duration = 2000,
                        flag = 48,
                        playbackRate = 1
                    },
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 2000,
                    },
                },
            },
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(113.36, -421.93, 41.13, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            }
        },
        [2] = {
            location = vector3(-584.03, -1061.45, 22.34),
            length = 0.25,
            width = 0.4,
            heading = 348,
            minZ = 22.34,
            maxZ = 22.54,
            distance = 1.5,
            targetlabel = "Terminal",
            targeticon = "fas fa-cash-register",
            animation = {
                emote = {
                    enabled = false,
                    anim = {
                        dict = "timetable@jimmy@doorknock@",
                        anim = "knockdoor_idle",
                        speed = 8.0,
                        speedMultiplier = 8.0,
                        duration = 2000,
                        flag = 48,
                        playbackRate = 1
                    },
                },
                scenario = {
                    enabled = false,
                    anim = {
                        scenario = "PROP_HUMAN_BBQ",
                        duration = 2000,
                    },
                },
            },
            prop = {
                enabled = false,
                model = "prop_tool_box_05",
                location = vector4(113.36, -421.93, 41.13, 184.6),
                rotation = vector3(0.0, 0.0, 0.0),
            }
        },
    },

    chairs = {
        [1] = {
            location = vector3(-573.0, -1068.01, 21.9942),
            heading = 8.42,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-575.47, -1067.99, 21.34, 8.42),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0142 }
        },
        [2] = {
            location = vector3(-573.83, -1068.02, 21.9942),
            heading = 8.42,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-575.47, -1067.99, 21.34, 8.42),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0142 }
        },
        [3] = {
            location = vector3(-572.99, -1066.11, 21.9942),
            heading = 184.61,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-575.57, -1066.05, 21.34, 184.61),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0142 }
        },
        [4] = {
            location = vector3(-573.82, -1066.1, 21.9942),
            heading = 184.61,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-575.57, -1066.05, 21.34, 184.61),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0142 }
        },
        [5] = {
            location = vector3(-573.05, -1064.36, 21.9942),
            heading = 5.7,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-575.61, -1064.19, 21.34, 5.7),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0142 }
        },
        [6] = {
            location = vector3(-573.75, -1064.36, 21.9942),
            heading = 5.7,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-575.61, -1064.19, 21.34, 5.7),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0142 }
        },
        [7] = {
            location = vector3(-572.99, -1062.47, 21.9942),
            heading = 182.42,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-575.71, -1062.48, 21.34, 182.42),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0142 }
        },
        [8] = {
            location = vector3(-573.77, -1062.44, 21.9942),
            heading = 182.42,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-575.71, -1062.48, 21.34, 182.42),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0142 }
        },
        [9] = {
            location = vector3(-573.02, -1060.7, 21.9942),
            heading = 4.06,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-575.5, -1060.47, 21.34, 4.06),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0142 }
        },
        [10] = {
            location = vector3(-573.8, -1060.71, 21.9942),
            heading = 4.06,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-575.5, -1060.47, 21.34, 4.06),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0142 }
        },
        [11] = {
            location = vector3(-572.99, -1058.82, 21.9942),
            heading = 183.64,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-575.56, -1058.9, 21.34, 183.64),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0142 }
        },
        [12] = {
            location = vector3(-573.8, -1058.82, 21.9942),
            heading = 183.64,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-575.56, -1058.9, 21.34, 183.64),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0142 }
        },
        [13] = {
            location = vector3(-576.94, -1051.01, 21.8273),
            heading = 111.44,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-576.13, -1051.89, 21.34, 111.44),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0010 }
        },
        [14] = {
            location = vector3(-577.58, -1052.54, 21.8273),
            heading = 43.58,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-578.17, -1053.48, 21.34, 43.58),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0010 }
        },
        [15] = {
            location = vector3(-579.72, -1052.48, 21.8273),
            heading = 329.5,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-579.06, -1053.62, 21.34, 329.5),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0010 }
        },
        [16] = {
            location = vector3(-580.81, -1051.23, 21.8273),
            heading = 285.59,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-581.44, -1052.34, 21.34, 285.59),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0010 }
        },
        [17] = {
            location = vector3(-586.12, -1074.68, 21.8297),
            heading = 177.56,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-586.88, -1073.94, 21.33, 177.56),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0097 }
        },
        [18] = {
            location = vector3(-587.81, -1075.87, 21.8297),
            heading = 272.12,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-588.53, -1076.72, 21.33, 272.12),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0097 }
        },
        [19] = {
            location = vector3(-586.35, -1077.36, 21.8297),
            heading = 5.67,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-585.46, -1078.0, 21.33, 5.67),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0097 }
        },
        [20] = {
            location = vector3(-584.92, -1076.17, 21.8297),
            heading = 93.14,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-584.1, -1075.34, 21.33, 93.14),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0097 }
        },
        [21] = {
            location = vector3(-591.96, -1079.05, 21.8297),
            heading = 217.83,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-593.11, -1078.93, 21.33, 217.83),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0097 }
        },
        [22] = {
            location = vector3(-592.22, -1081.05, 21.8297),
            heading = 315.45,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-592.29, -1082.23, 21.33, 315.45),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0097 }
        },
        [23] = {
            location = vector3(-590.38, -1081.36, 21.8297),
            heading = 33.34,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-589.08, -1081.59, 21.33, 33.34),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0097 }
        },
        [24] = {
            location = vector3(-590.07, -1079.55, 21.8297),
            heading = 128.72,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-589.83, -1078.37, 21.33, 128.72),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0097 }
        },
        [25] = {
            location = vector3(-587.6, -1082.54, 21.8297),
            heading = 316.74,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-587.66, -1083.7, 21.33, 316.74),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0097 }
        },
        [26] = {
            location = vector3(-585.49, -1082.53, 21.8297),
            heading = 50.15,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-584.29, -1082.42, 21.33, 50.15),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0097 }
        },
        [27] = {
            location = vector3(-585.39, -1080.73, 21.8297),
            heading = 136.13,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-585.28, -1079.52, 21.33, 136.13),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0097 }
        },
        [28] = {
            location = vector3(-587.17, -1080.49, 21.8297),
            heading = 222.59,
            distance = 1.5,
            targetRadius = 0.5,
            targetlabel = "Sit on chair",
            targeticon = "fas fa-couch",
            leaveLocation = vector4(-588.37, -1080.45, 21.33, 222.59),
            animation = {
                animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                anim = "idle_d",
                flags = 1,
                male = {
                    animDict = "amb@prop_human_seat_chair@male@generic@idle_b",
                    anim = "idle_d",
                    flags = 1
                },
                female = {
                    animDict = "amb@prop_human_seat_chair@female@proper@idle_a",
                    anim = "idle_b",
                    flags = 1
                }
            },
            offsets = { x = 0.0, y = 0.0, z = -0.0097 }
        },
    },

    CustomerOrderStatusScreen = {
       enabled = true, -- Set to false if you don't want to use Customer Order Status Screen
       prop = {
                model = "xm_prop_x17_tv_scrn_01",
                location = vector3(-577.1580, -1059.8439, 22.3442),
                rotation = vector3(0.0, 0.0, 0.0),
        },
       
    },

    EmployeeOrderStatusScreen = {
        enabled = true, -- Set to false if you don't want to use Employee Order Status Screen
        prop = {
                 model = "xm_prop_x17_tv_scrn_02",
                 location = vector3(-581.4327, -1059.5264, 22.3440),
                 rotation = vector3(0.0, 0.0, 0.0),
         },
     },

    MenuScreens = {
        [1] = {
            model = "bkr_prop_rt_memorial_active_01",
            location = vector3(-574.4031, -1053.8622, 22.3442),
            rotation = vector3(0.0, 0.0, 0.0),
            menuImage = Config.InventoryImages .. "bs_bleederburger.png", -- Image for the restaurant menu,
        },
        [2] = {
            model = "bkr_prop_rt_memorial_vice_pres",
            location = vector3(-579.1393, -1055.8132, 22.3442),
            rotation = vector3(0.0, 0.0, 0.0),
            menuImage = Config.InventoryImages .. "bs_fanta.png", -- Image for the restaurant menu,
        },
        [3] = {
            model = "prop_tv_flat_michael",
            location = vector3(-582.1111, -1054.6385, 22.4306),
            rotation = vector3(0.0, 0.0, 0.0),
            menuImage = Config.InventoryImages .. "tablet.png", -- Image for the restaurant menu,
        },
    },

    -- Sink locations for washing hands
    EnableSink = true, -- Set to false if you don't want to use sink
    sinks = {
        [1] = {
            location = vector3(-587.88, -1062.57, 22.36), 
            heading = 180, 
            length = 0.9, 
            width = 0.75, 
            minZ = 21.26, 
            maxZ = 23.11, 
            distance = 1.5 
        }
    },

    -- Garage configuration --spawnlocation
    garage = {
        pedLocation = vector4(-615.8011, -1031.6945, 21.7875, 56.8468),
        spawnPoints = {
            vector4(-596.68, -1059.19, 22.13, 90.17),
        }
    },

    --shop
    shop = {
        pedLocation = vector4(161.54, -1307.49, 28.35, 334.79),
        Blip = {
            sprite = 59,
            color = 2,
            scale = 0.6,
            location = vector3(161.54, -1307.49, 28.35)
        }
    },

    -- Delivery configuration
    delivery = {
        pedLocation = vector4(-592.03, -1058.48, 21.34, 91.26)
    },

    -- If AreaPolyzone is enabled, then it checks if the player is in the polyzone area then only he/she can be onduty else they would automatically be offduty
    AreaPolyzone = {
        enabled = true,
        debugPoly = true, -- Set to true if you want to see the polyzone area
        AutoDutyOnIfInZone = false, -- If true, player will be automatically on duty if they are in the polyzone area
        polyzone = {
            vector2(-607.07550048828, -1045.3551025391),
            vector2(-607.98980712891, -1064.8358154297),
            vector2(-607.97943115234, -1071.3753662109),
            vector2(-591.1513671875, -1088.0562744141),
            vector2(-563.22229003906, -1088.0026855469),
            vector2(-562.90222167969, -1045.2550048828)
        },
        minZ = 18.788331985474,
        maxZ = 34.895818710327,
    },

    EnableDoorLock = true, -- Set to false if you don't want to use door lock system
    doors = {
        {
            id = "uc_main_entrance",
            distance = 1.0, -- Increased interaction distance
            locked = true,
            doors = {
                {
                    coords = vector3(-581.67, -1069.63, 22.49),
                    heading = 359.94,
                    model = 526179188
                },
                {
                    coords = vector3(-580.36, -1069.63, 22.49),
                    heading = 359.84,
                    model = -69331849
                }
            }
        },
        {
            id = "uc_door1",
            location = vector3(-587.34, -1051.9, 22.41),
            heading = 90.08,
            distance = 1.0,
            locked = true,
            model = -1283712428
        },
        {
            id = "uc_door2",
            location = vector3(-590.18, -1054.15, 22.41),
            heading = 180.2,
            distance = 1.0,
            locked = true,
            model = -60871655
        },
        {
            id = "uc_door3",
            location = vector3(-592.47, -1056.09, 22.41),
            heading = 0.03,
            distance = 1.0,
            locked = true,
            model = -60871655
        },
        {
            id = "uc_door4",
            location = vector3(-594.41, -1049.77, 22.5),
            heading = 90.0,
            distance = 1.0,
            locked = true,
            model = 2089009131
        },
        {
            id = "uc_door5",
            location = vector3(-591.77, -1066.98, 22.53),
            heading = 270.0,
            distance = 1.0,
            locked = true,
            model = -562476388
        },
        {
            id = "uc_garage_door",
            location = vector3(-600.91, -1059.22, 24.96),
            heading = 270.0,
            distance = 4.0,
            locked = true,
            model = 522844070
        },
        {
            id = "uc_garage_door1",
            location = vector3(-600.89, -1055.13, 22.71),
            heading = 270.04,
            distance = 1.0,
            locked = true,
            model = 1099436502
        },
        {
            id = "uc_door6",
            location = vector3(-571.79, -1057.39, 26.77),
            heading = 0.16,
            distance = 1.0,
            locked = true,
            model = 2089009131
        },
        {
            id = "uc_door7",
            location = vector3(-575.01, -1063.78, 26.77),
            heading = 90.0,
            distance = 1.0,
            locked = true,
            model = 2089009131
        },
        {
            id = "uc_door8",
            location = vector3(-575.01, -1062.38, 26.77),
            heading = 270.0,
            distance = 1.0,
            locked = true,
            model = 2089009131
        },
    }
}