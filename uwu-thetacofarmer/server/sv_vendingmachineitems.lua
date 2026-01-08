Wait(5000)

local function SyncVendingMachineItemsWithConfig()
    Server.Debug("Starting vending machine items synchronization...")

    -- First, get all items from the Config
    local configItems = {}
    for _, item in ipairs(Config.VendingMachineItems) do
        configItems[item.name] = {
            name = item.name,
            label = item.label,
            price = item.price,
            image = item.image,
            category = item.category
        }
    end

    -- Get all items from the database
    MySQL.query('SELECT * FROM ' .. tablePrefix .. 'vendingMachineItems', {}, function(dbItems)
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
                   dbItem.category ~= configItem.category then
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
            Server.Debug("Adding " .. #itemsToAdd .. " new vending machine items to database")
            for _, item in ipairs(itemsToAdd) do
                MySQL.insert('INSERT INTO ' .. tablePrefix .. 'vendingMachineItems (name, label, price, image, category) VALUES (?, ?, ?, ?, ?)',
                    {item.name, item.label, item.price, item.image, item.category},
                    function(id)
                        if id then
                            Server.Debug("Added vending machine item: " .. item.name)
                        else
                            Server.Debug("Failed to add vending machine item: " .. item.name)
                        end
                    end
                )
            end
        end

        -- Update existing items
        if #itemsToUpdate > 0 then
            Server.Debug("Updating " .. #itemsToUpdate .. " existing vending machine items in database")
            for _, item in ipairs(itemsToUpdate) do
                MySQL.update('UPDATE ' .. tablePrefix .. 'vendingMachineItems SET label = ?, price = ?, image = ?, category = ? WHERE id = ?',
                    {item.label, item.price, item.image, item.category, item.id},
                    function(rowsChanged)
                        if rowsChanged > 0 then
                            Server.Debug("Updated vending machine item: " .. item.name)
                        else
                            Server.Debug("Failed to update vending machine item: " .. item.name)
                        end
                    end
                )
            end
        end

        -- Delete items not in config
        if #itemsToDelete > 0 then
            Server.Debug("Deleting " .. #itemsToDelete .. " vending machine items from database")
            for _, item in ipairs(itemsToDelete) do
                MySQL.update('DELETE FROM ' .. tablePrefix .. 'vendingMachineItems WHERE id = ?',
                    {item.id},
                    function(rowsChanged)
                        if rowsChanged > 0 then
                            Server.Debug("Deleted vending machine item: " .. item.name)
                        else
                            Server.Debug("Failed to delete vending machine item: " .. item.name)
                        end
                    end
                )
            end
        end

        Server.Debug("Vending machine items synchronization completed.")
        Server.Debug("Added: " .. #itemsToAdd .. ", Updated: " .. #itemsToUpdate .. ", Deleted: " .. #itemsToDelete)
    end)
end

-- Run the sync function when the resource starts
Citizen.CreateThread(function()
    Citizen.Wait(5000) -- Wait for database and config to be fully loaded
    SyncVendingMachineItemsWithConfig()
end)

-- Export the function so it can be called from other server scripts if needed
exports('SyncVendingMachineItemsWithConfig', SyncVendingMachineItemsWithConfig)
