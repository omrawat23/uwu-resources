
Config.EnableUwuCats = true  -- Enable or Disable Uwu Cats Feature
Config.PetCatDuration = 5000 -- Milliseconds
Config.StressReduction = 10  -- Amount to reduce stress after petting

-- Dynamic Cat List
-- To add more cats, just copy a block below, add a comma, and paste it.
Config.Cats = {
    {
        label = "Cat", -- Useful for debug or specific logic
        coords = vec3(-575.17, -1058.14, 23.15),
        heading = 150.0,
        model = 0x573201B8,
        -- Moved animation here so you can choose per-cat
        animDict = "amb@lo_res_idles@",
        animName = "creatures_world_cat_ledge_sleep_lo_res_base", 
        boxzone = { length = 2.0, width = 2.0, minZ = 21.15, maxZ = 25.15, distance = 1.5 }
    },
    {
        label = "Cat",
        coords = vec3(-573.99, -1054.84, 22.40),
        heading = 111.99,
        model = 0x573201B8,
        animDict = "amb@lo_res_idles@",
        animName = "creatures_world_cat_ground_sleep_lo_res_base",
        boxzone = { length = 2.0, width = 2.0, minZ = 20.40, maxZ = 24.40, distance = 1.5 }
    },
    {
        label = "Cat",
        coords = vec3(-576.49, -1056.34, 22.40),
        heading = 292.72,
        model = 0x573201B8,
        animDict = "amb@lo_res_idles@",
        animName = "creatures_world_cat_ground_sleep_lo_res_base",
        boxzone = { length = 2.0, width = 2.0, minZ = 20.40, maxZ = 24.40, distance = 1.5 }
    },
    {
        label = "Cat",
        coords = vec3(-578.63, -1050.92, 22.75),
        heading = 90.0,
        model = 0x573201B8,
        animDict = "amb@lo_res_idles@",
        animName = "creatures_world_cat_ground_sleep_lo_res_base",
        boxzone = { length = 2.0, width = 2.0, minZ = 20.75, maxZ = 24.75, distance = 1.5 }
    },
    {
        label = "Cat",
        coords = vec3(-577.8, -1069.32, 22.80),
        heading = 0,
        model = 0x573201B8,
        animDict = "amb@lo_res_idles@",
        animName = "creatures_world_cat_ledge_sleep_lo_res_base",
        boxzone = { length = 0.8, width = 1.0, minZ = 21.94, maxZ = 22.34, distance = 1.5 }
    },
    {
        label = "Cat",
        coords = vec3(-582.16, -1054.71, 22.42),
        heading = 3.0,
        model = 0x573201B8,
        animDict = "amb@lo_res_idles@",
        animName = "creatures_world_cat_ground_sleep_lo_res_base",
        boxzone = { length = 1.0, width = 1.0, minZ = 21.3, maxZ = 21.8, distance = 1.5 }
    },
    {
        label = "Cat",
        coords = vec3(-582.94, -1049.55, 23.12),
        heading = 0.0,
        model = 0x573201B8,
        animDict = "amb@lo_res_idles@",
        animName = "creatures_world_cat_ground_sleep_lo_res_base",
        boxzone = { length = 0.95, width = 1.0, minZ = 22.04, maxZ = 22.54, distance = 1.5 }
    },
    {
        label = "Cat",
        coords = vec3(-583.88, -1069.33, 23.0),
        heading = 0,
        model = 0x573201B8,
        animDict = "amb@lo_res_idles@",
        animName = "creatures_world_cat_ground_sleep_lo_res_base",
        boxzone = { length = 0.8, width = 1, minZ = 21.94, maxZ = 22.29, distance = 1.5 }
    },
}