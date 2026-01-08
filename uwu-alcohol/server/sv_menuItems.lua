Wait(5000)

local function SyncMenuItemsWithConfig()
    Server.Debug("Starting menu items synchronization...")

    -- First, get all items from the Config
    local configItems = {}
    for _, item in ipairs(Config.MenuItems) do
        configItems[item.name] = {
            name = item.name,
            label = item.label,
            price = item.price,
            image = item.image,
            category = item.category,
            categoryimage = Config.categoryimage[item.category] -- Add categoryimage field
        }
    end

    -- Get all items from the database
    MySQL.query('SELECT * FROM ' .. tablePrefix .. 'menuItems', {}, function(dbItems)
        local dbItemsMap = {}
        local itemsToAdd = {}
        local itemsToDelete = {}
        local itemsToUpdate = {}

        -- Create a map of existing database items by name
        if dbItems then
            for _, item in ipairs(dbItems) do
                dbItemsMap[item.name] = item
            end
        end

        -- Check which items need to be added or updated
        for name, configItem in pairs(configItems) do
            if not dbItemsMap[name] then
                -- Item in config but not in database, add it
                table.insert(itemsToAdd, configItem)
            else
                -- Item exists, check if it needs updating
                local dbItem = dbItemsMap[name]
                if dbItem.label ~= configItem.label or
                   dbItem.price ~= configItem.price or
                   dbItem.image ~= configItem.image or
                   dbItem.category ~= configItem.category or
                   dbItem.categoryimage ~= configItem.categoryimage then -- Add categoryimage check
                    -- Item needs updating
                    configItem.id = dbItem.id -- Keep the original ID
                    table.insert(itemsToUpdate, configItem)
                end
            end
        end

        -- Check which items need to be deleted (in DB but not in config)
        for name, dbItem in pairs(dbItemsMap) do
            if not configItems[name] then
                table.insert(itemsToDelete, dbItem)
            end
        end

        -- Add new items
        if #itemsToAdd > 0 then
            Server.Debug("Adding " .. #itemsToAdd .. " new menu items to database")
            for _, item in ipairs(itemsToAdd) do
                MySQL.insert('INSERT INTO ' .. tablePrefix .. 'menuItems (name, label, price, image, category, categoryimage) VALUES (?, ?, ?, ?, ?, ?)',
                    {item.name, item.label, item.price, item.image, item.category, item.categoryimage},
                    function(id)
                        if id then
                            Server.Debug("Added menu item: " .. item.name)
                        else
                            Server.Debug("Failed to add menu item: " .. item.name)
                        end
                    end
                )
            end
        end

        -- Update existing items
        if #itemsToUpdate > 0 then
            Server.Debug("Updating " .. #itemsToUpdate .. " existing menu items in database")
            for _, item in ipairs(itemsToUpdate) do
                MySQL.update('UPDATE ' .. tablePrefix .. 'menuItems SET label = ?, price = ?, image = ?, category = ?, categoryimage = ? WHERE id = ?',
                    {item.label, item.price, item.image, item.category, item.categoryimage, item.id},
                    function(rowsChanged)
                        if rowsChanged > 0 then
                            Server.Debug("Updated menu item: " .. item.name)
                        else
                            Server.Debug("Failed to update menu item: " .. item.name)
                        end
                    end
                )
            end
        end

        -- Delete items not in config
        if #itemsToDelete > 0 then
            Server.Debug("Deleting " .. #itemsToDelete .. " menu items from database")
            for _, item in ipairs(itemsToDelete) do
                MySQL.update('DELETE FROM ' .. tablePrefix .. 'menuItems WHERE id = ?',
                    {item.id},
                    function(rowsChanged)
                        if rowsChanged > 0 then
                            Server.Debug("Deleted menu item: " .. item.name)
                        else
                            Server.Debug("Failed to delete menu item: " .. item.name)
                        end
                    end
                )
            end
        end

        Server.Debug("Menu items synchronization completed.")
        Server.Debug("Added: " .. #itemsToAdd .. ", Updated: " .. #itemsToUpdate .. ", Deleted: " .. #itemsToDelete)
    end)
end

-- Run the sync function when the resource starts
Citizen.CreateThread(function()
    Citizen.Wait(5000) -- Wait for database and config to be fully loaded
    SyncMenuItemsWithConfig()
end)

-- Export the function so it can be called from other server scripts if needed
exports('SyncMenuItemsWithConfig', SyncMenuItemsWithConfig)
